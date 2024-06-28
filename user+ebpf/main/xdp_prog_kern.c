/* SPDX-License-Identifier: GPL-2.0 */
#include <stdio.h>
#include <stdlib.h>
#include <linux/bpf.h>
// #include <bpf/libbpf.h>
#include "libbpf/src/bpf_helpers.h"
#include "libbpf/src/bpf_endian.h"
#include <linux/if_ether.h>
#include <netinet/ip.h>

#ifndef __packed
#define __packed __attribute__((packed))
#endif

#ifndef lock_xadd
#define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
#endif

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

struct data_value
{
        int32_t prev_interval_pkt;
        int32_t cur_interval_pkt;
};

#define FIXED_POINT_BITS 24

struct bpf_map_def SEC("maps") logger = {
    //.type = BPF_MAP_TYPE_ARRAY,
    //.key_size = sizeof(__u32),
    //.value_size = sizeof(__u32),
    //.max_entries = 1000,
    .type = BPF_MAP_TYPE_HASH,
    .key_size = sizeof(__u32),
    .value_size = sizeof(struct logger_value),
    .max_entries = 100000,
};

struct bpf_map_def SEC("maps") blacklist = {
    .type = BPF_MAP_TYPE_LPM_TRIE,
    .key_size = sizeof(struct lpm_v4_key),
    .value_size = sizeof(__u32),
    .map_flags = BPF_F_NO_PREALLOC,
    .max_entries = 8000,
};

struct bpf_map_def SEC("maps") data = {
    .type = BPF_MAP_TYPE_ARRAY,
    .key_size = sizeof(__u32),
    .value_size = sizeof(struct data_value),
    .max_entries = 1,
};

struct bpf_map_def SEC("maps") tx_port = {
    .type = BPF_MAP_TYPE_DEVMAP,
    .key_size = sizeof(__u32),
    .value_size = sizeof(__u32),
    .max_entries = 1,
};


SEC("xdp_filter") // This is the typical "main" function replacement.
int xdp_filter_func(struct xdp_md *ctx)
{
        //__u64 ts_initial = bpf_ktime_get_ns();
        //char str[] = "Received\n";
        //                bpf_trace_printk(str, sizeof(str));
	struct ethhdr *eth;
        struct iphdr *ip;
        struct lpm_v4_key key;
        key.prefixlen = 32;
        int32_t drop_flag = 0;

        // checks whether packet data format follows the definition of ethernet frame header
        eth = (void *)(long)ctx->data;
        // drop the packet if it doesn't
        if (ctx->data + sizeof(*eth) > ctx->data_end)
        {
                char str[] = "not ethernet frame, dropped\n";
                bpf_trace_printk(str, sizeof(str));
		return XDP_ABORTED;
        }

        // Packet filtering process for IPv4
        if (eth->h_proto == bpf_htons(ETH_P_IP))
        {
                // checks whether packet data format follows the definition of ip packet header
                ip = (void *)(long)ctx->data + sizeof(*eth);
                // drop the packet if it doesn't
                if (ctx->data + sizeof(*eth) + sizeof(*ip) > ctx->data_end)
                {
			char str[] = "dropped\n";
			bpf_trace_printk(str, sizeof(str));
                        return XDP_ABORTED;
                }

                key.address = ip->saddr;
                //__u64 ts_initial = bpf_ktime_get_ns();
                __u32 *rule = bpf_map_lookup_elem(&blacklist, &key);
                if (rule)
		{
	                //bpf_printk("dropped by filter");
                        //return XDP_DROP;
                        drop_flag = 1;
                }


                //bpf_printk(",%lld", bpf_ktime_get_ns() - ts_initial);

	
                // Record the number of packets (for this interval)
                int key = 0;
                struct data_value *tmp = bpf_map_lookup_elem(&data, &key);
                if (tmp)
                {
                        //tmp->cur_interval_pkt++;
                        lock_xadd(&tmp->cur_interval_pkt, 1);
                        // bpf_map_update_elem(&data, &key, tmp, BPF_ANY);
                }
                else
                {
                        char error_log[] = "Error at reading data, the first one\n";
                        bpf_trace_printk(error_log, sizeof(error_log));
                        return XDP_ABORTED;
                }

                // Record the number of packets (for this IP address)
                struct logger_value *value = bpf_map_lookup_elem(&logger, &ip->saddr);
                if (value)
                {
                        //value->cur++;
                        lock_xadd(&value->cur, 1);
                        // bpf_map_update_elem(&logger, &ip->saddr, value, BPF_ANY);
                }
                else
                {
                        struct logger_value new_value;
                        new_value.prev = 0;
                        new_value.cur = 1;
                        new_value.entropy = 0;
                        bpf_map_update_elem(&logger, &ip->saddr, &new_value, BPF_ANY);
                }
}
        if (drop_flag == 1) {
                return XDP_DROP;
        }
       	//return XDP_PASS;
	return bpf_redirect_map(&tx_port, 0, 0);
}

char _license[] SEC("license") = "GPL";
