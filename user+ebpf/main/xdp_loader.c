// SPDX-License-Identifier: GPL-2.0
static const char *__doc__ = "XDP sample packet\n";

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <linux/bpf.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <sys/resource.h>
#include <linux/if_link.h>
#include "perf-sys.h"
#include "common/common_params.h"
#include "common/common_user_bpf_xdp.h"
#include "libbpf/src/bpf_endian.h"
#include "bpf_util.h"
#include <linux/ip.h>
#include <linux/if_ether.h>
#include <linux/ipv6.h>
#include <arpa/inet.h>
#include <time.h>
#include <math.h>

#ifndef __packed
#define __packed __attribute__((packed))
#endif


struct flow
{
	u_int32_t ip_src;
	u_int32_t ip_dest;
	__u32 packet_count;
	double entropy;
} __packed;

struct interval
{
	struct flow flow[100000];
} __packed;

struct lpm_v4_key
{
	__u32 prefixlen;
	__u32 address;
};

struct logger_value
{
        int32_t prev;
        int32_t cur;
		int32_t entropy;
};

struct entpy 
{
	double ent[100000];
	int ip[100000]; 
};

struct data_value
{
        int32_t prev_interval_pkt;
        int32_t cur_interval_pkt;
};

static const struct option_wrapper long_options[] = {
	{{"help", no_argument, NULL, 'h'},
	 "Show help",
	 false},

	{{"force", no_argument, NULL, 'F'},
	 "Force install, replacing existing program on interface"},

	{{"dev", required_argument, NULL, 'd'},
	 "Operate on device <ifname>",
	 "<ifname>",
	 true},

	{{"filename", required_argument, NULL, 1},
	 "Store packet sample into <file>",
	 "<file>"},

	{{"quiet", no_argument, NULL, 'q'},
	 "Quiet mode (no output)"},

	{{"unload", no_argument, NULL, 'U'},
	 "Unload XDP program instead of loading"},
	{{"udef", no_argument, NULL, 'i'},
	 "Add user defined filter"},
	{{0, 0, NULL, 0}, NULL, false}};

struct bpf_object *__load_bpf_object_file(const char *filename, int ifindex)
{
	int first_prog_fd = -1;
	struct bpf_object *obj;
	int err;

	struct bpf_prog_load_attr prog_load_attr = {
		.prog_type = BPF_PROG_TYPE_XDP,
		.ifindex = ifindex,
	};
	prog_load_attr.file = "xdp_prog_kern.o";

	err = bpf_prog_load_xattr(&prog_load_attr, &obj, &first_prog_fd);
	if (err)
	{
		fprintf(stderr, "ERR: loading BPF-OBJ file(%s) (%d): %s\n",
				filename, err, strerror(-err));
		return NULL;
	}

	return obj;
}

struct bpf_object *__load_bpf_and_xdp_attach(struct config *cfg)
{
	struct bpf_program *bpf_prog;
	struct bpf_object *bpf_obj;
	int offload_ifindex = 0;
	int prog_fd = -1;
	int err;

	if (cfg->xdp_flags & XDP_FLAGS_HW_MODE)
		offload_ifindex = cfg->ifindex;

	bpf_obj = __load_bpf_object_file(cfg->filename, offload_ifindex);
	if (!bpf_obj)
	{
		fprintf(stderr, "ERR: loading file: %s\n", cfg->filename);
		exit(EXIT_FAIL_BPF);
	}

	/* Find a matching BPF prog section name */
	bpf_prog = bpf_object__find_program_by_title(bpf_obj, cfg->progsec);
	if (!bpf_prog)
	{
		fprintf(stderr, "ERR: finding progsec: %s\n", cfg->progsec);
		exit(EXIT_FAIL_BPF);
	}

	prog_fd = bpf_program__fd(bpf_prog);
	if (prog_fd <= 0)
	{
		fprintf(stderr, "ERR: bpf_program__fd failed\n");
		exit(EXIT_FAIL_BPF);
	}

	err = xdp_link_attach(cfg->ifindex, cfg->xdp_flags, prog_fd);
	if (err)
		exit(err);

	return bpf_obj;
}

const char *pin_basedir = "/sys/fs/bpf";
const char *map_name = "map";

int pin_maps_in_bpf_object(struct bpf_object *bpf_obj, const char *subdir)
{
	char map_filename[4096];
	char pin_dir[4096];
	int err, len;

	len = snprintf(pin_dir, 4096, "%s/%s", pin_basedir, subdir);
	if (len < 0)
	{
		fprintf(stderr, "ERR: creating pin dirname\n");
		return EXIT_FAIL_OPTION;
	}

	len = snprintf(map_filename, 4096, "%s/%s/%s",
				   pin_basedir, subdir, map_name);
	if (len < 0)
	{
		fprintf(stderr, "ERR: creating map_name\n");
	}

	if (access(map_filename, F_OK) == 0)
	{
		printf(" - Unpinning (remove) prev maps in %s/\n", pin_dir);

		err = bpf_object__unpin_maps(bpf_obj, pin_dir);
		if (err)
		{
			fprintf(stderr, "ERR: Unpinning maps in %s\n", pin_dir);
			return EXIT_FAIL_BPF;
		}
	}

	if (verbose)
		printf(" - Pinning maps in %s/\n", pin_dir);

	err = bpf_object__pin_maps(bpf_obj, pin_dir);
	if (err)
		return EXIT_FAIL_BPF;

	return 0;
}

static int packet_count_alltime = 0;
static int prev_packet_count = 0;
static int cur_packet_count = 0;
static int beta = 1;
struct interval *invl_prev = {0};

static int holder = 0;

void calculate_ent (int logger_fd, int data_fd, int blacklist_fd) {
	int k = 0;
	int key = NULL;
	int next_key = NULL;
	struct data_value *data_value = malloc(sizeof(struct data_value));
	int l = bpf_map_lookup_elem(data_fd, &k, data_value);

	struct entpy *entpy = malloc(sizeof(struct entpy));
	struct logger_value *logger_value = malloc(sizeof(struct logger_value));
	
	double entropy_all = 0;
	int i = 1;

	if (bpf_map_get_next_key(logger_fd, &key, &next_key) == 0) {
		for (i = 0; i < 100000; i++) {
			bpf_map_lookup_elem(logger_fd, &next_key, logger_value);
			double entropy = 0.0;
			// Calculate entropy
			if (logger_value->prev >= logger_value->cur)
			{
				entropy = -1 * log2((double)logger_value->prev / (data_value->prev_interval_pkt)) + fabs(log2((double)logger_value->cur/logger_value->prev));
			}
			else
			{
				entropy = -1 * log2((double)logger_value->prev / (data_value->prev_interval_pkt)) + fabs(log2((double)logger_value->prev/logger_value->cur));
			}

			struct in_addr in;
			in.s_addr = next_key;
			char *ip = inet_ntoa(in);
			printf("IP:%s, prev: %d, cur:%d\n", ip, logger_value->prev, logger_value->cur);

			entpy->ent[i]= entropy;
			entpy->ip[i] = next_key;
			entropy_all += entropy;
			key = next_key;
			int r = bpf_map_get_next_key(logger_fd, &key, &next_key);
			if (r < 0) {
				break;
			}
			
		}
	}

	// while (bpf_map_get_next_key(logger_fd, &key, &next_key) == 0 && i < 10000) {
	// 	i++;
	// 	bpf_map_lookup_elem(logger_fd, &next_key, logger_value);

	// 	double entropy = 0.0;
	// 	// Calculate entropy
	// 	if (logger_value->prev >= logger_value->cur)
	// 	{
	// 		entropy = -1 * log2((double)logger_value->prev / (data_value->prev_interval_pkt)) + fabs(log2((double)logger_value->cur/logger_value->prev));
	// 	}
	// 	else
	// 	{
	// 		entropy = -1 * log2((double)logger_value->prev / (data_value->prev_interval_pkt)) + fabs(log2((double)logger_value->prev/logger_value->cur));
	// 	}

	// 	struct in_addr in;
	// 	in.s_addr = next_key;
	// 	char *ip = inet_ntoa(in);
	// 	//printf("%d\n", i);
	// 	printf("IP:%s, prev: %d, cur:%d\n", ip, logger_value->prev, logger_value->cur);
	// 	//memcpy(&logger_value->prev, &logger_value->cur, sizeof(int32_t));
	// 	// if (logger_value->cur == 0)
	// 	// {
	// 	// 	//bpf_map_delete_elem(logger_fd, &next_key);
			
	// 	// } else {
	// 	// 	logger_value->prev = logger_value->cur;
	// 	// 	logger_value->cur = 0;
	// 	// 	//bpf_map_update_elem(logger_fd, &next_key, logger_value, BPF_EXIST);
	// 	// }

	// 	entpy->ent[i]= entropy;
	// 	entpy->ip[i] = next_key;
	// 	entropy_all += entropy;
	// 	key = next_key;
	// }

	printf("Number of packets from %d flows: %d\n", i, data_value->cur_interval_pkt);
	holder = holder + data_value->cur_interval_pkt;

	//data_value->prev_interval_pkt = data_value->cur_interval_pkt;
	memcpy(&data_value->prev_interval_pkt, &data_value->cur_interval_pkt, sizeof(int32_t));
	data_value->cur_interval_pkt = 0;
	key = 0;
	int n = bpf_map_update_elem(data_fd, &key, data_value, BPF_EXIST);

	double avg = entropy_all/i;
	
	double deviation = 0.0;
	for (int k = 0; k < i; k++) {
		deviation += entpy->ent[k] - avg;
	}
	double variance = deviation * deviation;
	double std = sqrt(variance);

	for (int k = 0; k < i; k++) {
		double d = fabs(entpy->ent[k] - avg);

		if (entpy->ent[k] > 1.5 * avg)
        {
                beta += 1;
        }
        else if (entpy->ent[k] < 0.5 * avg)
        {
                beta -= 1;
        }

		if (d > beta * std)
        {
			// add the IP address to the blacklist
			struct lpm_v4_key filter_key;
			filter_key.prefixlen = 32;
			filter_key.address = entpy->ip[k];
			__u32 rule = 1;
			//printf("We would add this IP address to the blacklist.\n");
			//bpf_map_update_elem(blacklist_fd, &filter_key, &rule, BPF_ANY);
        }
	}

	for (int k = 0; k <= i; k ++) {
		key = entpy->ip[k];
		bpf_map_lookup_elem(logger_fd, &key, logger_value);
		if (logger_value->cur == 0)
		{
			bpf_map_delete_elem(logger_fd, &key);
		} else {
			memcpy(&logger_value->prev, &logger_value->cur, sizeof(int32_t));
			logger_value->cur = 0;
			bpf_map_update_elem(logger_fd, &key, logger_value, BPF_ANY);
		}
	}

	// key = NULL;
	// if (bpf_map_get_next_key(logger_fd, &key, &next_key) == 0) {
	// 	for (int index = 0; index < 10000; index++) {
	// 		bpf_map_lookup_elem(logger_fd, &next_key, logger_value);
	// 		if (logger_value->prev == 0)
	// 		{
	// 			key = next_key; 
	// 			int r = bpf_map_get_next_key(logger_fd, &key, &next_key);
	// 			bpf_map_delete_elem(logger_fd, &next_key);
	// 			if (r < 0) {
	// 				break;
	// 			}
	// 		}
	// 	}
	// }
}

void calculate_entropy(int logger_fd, int blacklist_fd)
{
	struct interval *invl_cur = malloc(sizeof(struct interval));
	struct lpm_v4_key *i = malloc(sizeof(struct lpm_v4_key));
	struct lpm_v4_key *next = malloc(sizeof(struct lpm_v4_key));
	int ret = 1;
	int packet_count = 0;
	ret = bpf_map_get_next_key(logger_fd, NULL, next);
	int num = 0;
	for (num = 0; num < 10000; num++)
	{
		invl_cur->flow[num].ip_src = next->address;
		bpf_map_lookup_elem(logger_fd, next, &packet_count);
		invl_cur->flow[num].packet_count = packet_count;
		bpf_map_delete_elem(logger_fd, next);
		i = next;
		ret = bpf_map_get_next_key(logger_fd, i, next);
		if (ret < 0) {
			break;
		}
	}
	
	// implement code to calculate based on fast entropy approach
	double value = 0.0;
	double tau = 0.0;
	printf("==Interval==\n");
	for (int num_of_flow = 0; num_of_flow < 10000; num_of_flow++)
	{
		if (invl_prev->flow[num_of_flow].packet_count != 0)
		{
			cur_packet_count += invl_prev->flow[num_of_flow].packet_count;
		}
		else
		{
			break;
		}
	}

	// int average_packet_per_flow = cur_packet_count / num_of_flow;

	for (int i = 0; i < 10000; i++)
	{
		if (invl_prev->flow[i].packet_count != 0)
		{
			packet_count_alltime += invl_prev->flow[i].packet_count;
			double p = (double)invl_prev->flow[i].packet_count / cur_packet_count;
			value = -1 * log(p);
			tau = 0.0;
			int j = 0;
			for (j = 0; j < 10000; j++)
			{
				if (invl_prev->flow[i].ip_src == invl_cur->flow[j].ip_src)
				{
					if (invl_prev->flow[i].packet_count >= invl_cur->flow[j].packet_count)
					{
						tau = log((double)invl_cur->flow[j].packet_count / invl_prev->flow[i].packet_count);
						break;
					}
					else
					{
						tau = log((double)invl_prev->flow[i].packet_count / invl_cur->flow[j].packet_count);
						break;
					}
				} else if (invl_cur->flow[j].ip_src == 0) {
					break;
				}
			}
			// Printing the entropy values
			struct in_addr in;
			in.s_addr = invl_prev->flow[i].ip_src;
			char *ip = inet_ntoa(in);
			if (tau < 0)
			{
				tau = -1 * tau;
			}
			invl_prev->flow[i].entropy = value + tau;
			printf("IP:%s prv: %d cur: %d etp:%f\n", ip, invl_prev->flow[i].packet_count, invl_cur->flow[j].packet_count, invl_prev->flow[i].entropy);
			holder += invl_prev->flow[i].packet_count;
		}
		else
		{
			break;
		}
	}

	double avg_entropy = 0.0;
	double sum_of_entropy = 0.0;
	int num_of_flow = 0;
	for (num_of_flow = 0; num_of_flow < 10000; num_of_flow++)
	{
		if (invl_prev->flow[num_of_flow].packet_count != 0)
		{
			sum_of_entropy += invl_prev->flow[num_of_flow].entropy;
		}
		else
		{
			break;
		}
	}
	avg_entropy = sum_of_entropy / num_of_flow;
	double deviation = 0.0;

	for (int i = 0; i <= num_of_flow; i++)
	{
		deviation += abs(invl_prev->flow[i].entropy - avg_entropy) * abs(invl_prev->flow[i].entropy - avg_entropy);
	}

	double std_deviation = sqrt(deviation / (double)num_of_flow);
	// printf("calculated standard deviation %f\n", std_deviation);

	for (int i = 0; i <= num_of_flow; i++)
	{
		if (invl_prev->flow[i].entropy > 2 * avg_entropy)
		{
			beta++;
		}
		else if (invl_prev->flow[i].entropy < 0.5 * avg_entropy)
		{
			beta--;
		}

		if (abs(avg_entropy - invl_prev->flow[i].entropy) > beta * std_deviation)
		{
			struct lpm_v4_key *key = malloc(sizeof(struct lpm_v4_key));
			key->prefixlen = 32;
			key->address = invl_prev->flow[i].ip_src;
			int num = 0;

			struct in_addr in;
			in.s_addr = invl_prev->flow[i].ip_src;
			char *ip = inet_ntoa(in);
				
			int e = bpf_map_update_elem(blacklist_fd, key, &num, BPF_NOEXIST);
			if (e < 0)
			{
				printf("Adding new filter settings failed IP: %s\n", ip);
			}
			else
			{
				printf("Blocked IP: %s\n", ip);
			}
		}
	}
	printf("Number of packets from all flows: %d\n", cur_packet_count);
	cur_packet_count = 0;
	invl_prev = invl_cur;
}

void calculate_entropy_csv(int logger_fd, int blacklist_fd)
{
	struct interval *invl_prev = malloc(sizeof(struct interval));
	int key_invl = 0;
	int e = bpf_map_lookup_elem(logger_fd, &key_invl, invl_prev);
	if (e == -1)
	{
		printf("Error in fetching log data\n");
		return;
	}

	struct interval *invl_cur = malloc(sizeof(struct interval));
	key_invl = 1;
	e = bpf_map_lookup_elem(logger_fd, &key_invl, invl_cur);
	if (e == -1)
	{
		printf("Error in fetching log data\n");
		return;
	}

	// Refresh the log to accept new data
	struct interval *invl_new = malloc(sizeof(struct interval));
	key_invl = 1;
	bpf_map_update_elem(logger_fd, &key_invl, invl_new, BPF_ANY);

	// implement code to calculate based on fast entropy approach
	double value = 0.0;
	double tau = 0.0;
	for (int num_of_flow = 0; num_of_flow < 1000; num_of_flow++)
	{
		if (invl_prev->flow[num_of_flow].packet_count != 0)
		{
			cur_packet_count += invl_prev->flow[num_of_flow].packet_count;
		}
		else
		{
			break;
		}
	}

	// int average_packet_per_flow = cur_packet_count / num_of_flow;

	for (int i = 0; i < 1000; i++)
	{
		if (invl_prev->flow[i].packet_count != 0)
		{
			packet_count_alltime += invl_prev->flow[i].packet_count;
			double p = (double)invl_prev->flow[i].packet_count / cur_packet_count;
			value = -1 * log(p);
			tau = 0.0;
			int j = 0;
			for (j = 0; j < 10000; j++)
			{
				if (invl_prev->flow[i].ip_src == invl_cur->flow[j].ip_src)
				{
					if (invl_prev->flow[i].packet_count >= invl_cur->flow[j].packet_count)
					{
						tau = log((double)invl_cur->flow[j].packet_count / invl_prev->flow[i].packet_count);
						break;
					}
					else
					{
						tau = log((double)invl_prev->flow[i].packet_count / invl_cur->flow[j].packet_count);
						break;
					}
				} else if (invl_cur->flow[j].ip_src == 0) {
					break;
				}
			}
			// Printing the entropy values
			struct in_addr in;
			in.s_addr = invl_prev->flow[i].ip_src;
			char *ip = inet_ntoa(in);
			if (tau < 0)
			{
				tau = -1 * tau;
			}
			invl_prev->flow[i].entropy = value + tau;
			// printf("IP:%s prv: %d cur: %d etp:%f\n", ip, invl_prev->flow[i].packet_count, next_int_packet_count, invl_prev->flow[i].entropy);
			// printf("%d,%f,", invl_prev->flow[i].packet_count, invl_prev->flow[i].entropy);
			holder += invl_prev->flow[i].packet_count;
		}
		else
		{
			break;
		}
	}

	double avg_entropy = 0.0;
	double sum_of_entropy = 0.0;
	int num_of_flow = 0;
	for (num_of_flow = 0; num_of_flow < 1000; num_of_flow++)
	{
		if (invl_prev->flow[num_of_flow].packet_count != 0)
		{
			sum_of_entropy += invl_prev->flow[num_of_flow].entropy;
		}
		else
		{
			break;
		}
	}
	avg_entropy = sum_of_entropy / num_of_flow;
	double deviation = 0.0;

	for (int i = 0; i <= num_of_flow; i++)
	{
		deviation += abs(invl_prev->flow[i].entropy - avg_entropy) * abs(invl_prev->flow[i].entropy - avg_entropy);
	}

	double std_deviation = sqrt(deviation / (double)num_of_flow);
	// printf("calculated standard deviation %f\n", std_deviation);

	for (int i = 0; i <= num_of_flow; i++)
	{
		if (invl_prev->flow[i].entropy > 1.5 * avg_entropy)
		{
			beta = beta + 1;
		}
		else if (invl_prev->flow[i].entropy < 0.5 * avg_entropy)
		{
			beta = beta - 1;
		}

		if (abs(avg_entropy - invl_prev->flow[i].entropy) > beta * std_deviation)
		{
			struct lpm_v4_key *key = malloc(sizeof(struct lpm_v4_key));
			key->prefixlen = 32;
			key->address = invl_prev->flow[i].ip_src;
			int i = 0;

			struct in_addr in;
			in.s_addr = invl_prev->flow[i].ip_src;
			char *ip = inet_ntoa(in);

			int e = bpf_map_update_elem(blacklist_fd, key, &i, BPF_NOEXIST);
			if (e < 0)
			{
				printf("Adding new filter settings failed IP: %s\n", ip);
			}
			else
			{
				printf("Blocked IP: %s\n", ip);
			}
		}
	}

	cur_packet_count = 0;
	//  copy invl->intervals[1] to invl->intervals[0], and update bpf map
	memcpy(invl_prev, invl_cur, sizeof(struct interval));
	key_invl = 0;
	bpf_map_update_elem(logger_fd, &key_invl, invl_prev, BPF_ANY);
}

void check_trie(int map)
{
	int packet_count[10000] = {0};
	int ip[10000] = {0};

	struct lpm_v4_key *i = malloc(sizeof(struct lpm_v4_key));
	struct lpm_v4_key *next = malloc(sizeof(struct lpm_v4_key));
	int ret = 1;
	int value = 0;
	ret = bpf_map_get_next_key(map, NULL, next);
	int num = 0;
	for (num = 0; num < 10000; num++)
	{
		ip[num]	= next->address;
		bpf_map_lookup_elem(map, next, &value);
		packet_count[num] = value;
		bpf_map_delete_elem(map, next);
		i = next;
		ret = bpf_map_get_next_key(map, i, next);
		if (ret < 0) {
			break;
		}
	}
	printf("===Interval===\n");
	for (int j = 0; j <= num; j++)
	{
		struct in_addr in;
		in.s_addr = ip[j];
		char *ip = inet_ntoa(in);
		printf("IP: %s, packet count: %d\n", ip, packet_count[j]);
	}
}

int main(int argc, char **argv)
{
	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
	struct bpf_object *obj;
	struct bpf_map *logger;
	struct bpf_map *blacklist;
	struct bpf_map *data;
	struct bpf_map *tx_port;
	char filename[256];
	struct config cfg = {
		.xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE,
		.ifindex = -1,
		.do_unload = false,
	};
	char *default_progsec = "xdp_filter";

	strncpy(cfg.progsec, default_progsec, sizeof(cfg.progsec));

	parse_cmdline_args(argc, argv, long_options, &cfg, __doc__);

	/* Required option */
	if (cfg.ifindex == -1)
	{
		fprintf(stderr, "ERR: required option --dev missing\n");
		usage(argv[0], __doc__, long_options, (argc == 1));
		return EXIT_FAIL_OPTION;
	}

	if (setrlimit(RLIMIT_MEMLOCK, &r))
	{
		perror("setrlimit(RLIMIT_MEMLOCK)");
		return 1;
	}

	snprintf(cfg.filename, sizeof(cfg.filename), "xdp_prog_kern.o");

	if (cfg.do_unload)
		return xdp_link_detach(cfg.ifindex, cfg.xdp_flags, 0);

	obj = __load_bpf_and_xdp_attach(&cfg);
	if (!obj)
		return EXIT_FAIL_BPF;
	printf("eBPF program has been successfully attached to XDP.\n");

	pin_maps_in_bpf_object(obj, cfg.ifname);

	logger = bpf_map__next(NULL, obj);
	if (!logger)
	{
		printf("finding a map in obj file failed\n");
		return 1;
	}
	int logger_fd = bpf_map__fd(logger);

	blacklist = bpf_map__next(logger, obj);
	if (!blacklist)
	{
		printf("finding a map in obj file failed\n");
		return 1;
	}
	int blacklist_fd = bpf_map__fd(blacklist);

	data = bpf_map__next(blacklist, obj);
	if (!data)
	{
		printf("finding a map in obj file failed\n");
		return 1;
	}
	int data_fd = bpf_map__fd(data);

	tx_port = bpf_map__next(data, obj);
	if (!tx_port)
	{
		printf("finding a map in obj file failed\n");
		return 1;
	}
	int tx_port_fd = bpf_map__fd(tx_port);

	int index = 0;
	int ifindex = 4;
	int ret;
    ret = bpf_map_update_elem(bpf_map__fd(tx_port), &index, &ifindex, 0);
    if (ret < 0) {
        fprintf(stderr, "Failed to update devmap_ value: %s\n",
            strerror(errno));
    }

	int count = 0;
	invl_prev = malloc(sizeof(struct interval));

	while (1)
	{
		sleep(1);
		//check_trie(logger_fd);
		calculate_ent(logger_fd, data_fd, blacklist_fd);
		// calculate_entropy_csv(logger_fd, blacklist_fd);
		if (holder > 0)
		{
			count++;
		}
		if (count == 11)
		{
			printf("Roudup of past 10 seconds %d\n", holder);
			printf("\n");
			// printf("%d,\n", holder);
			count = 0;
			cur_packet_count = 0;
			holder = 0;
		}
	}
}
