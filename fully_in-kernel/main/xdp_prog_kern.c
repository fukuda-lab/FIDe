/* SPDX-License-Identifier: GPL-2.0 */
#include <stdio.h>
#include <stdlib.h>
#include <linux/bpf.h>
// #include <bpf/libbpf.h>
#include "../lib/libbpf/src/bpf_helpers.h"
#include "../lib/libbpf/src/bpf_endian.h"
#include <linux/if_ether.h>
#include <netinet/ip.h>
#include "fixed-point.h"

#ifndef __packed
#define __packed __attribute__((packed))
#endif

#ifndef lock_xadd
#define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
#endif

#define invl_ns 1000000000

#define LOGGER_MAP_SIZE 100000

struct lpm_v4_key
{
        __u32 prefixlen;
        __u32 address;
};

struct logger_value
{
        int32_t prev;
        int32_t cur;
        struct fixed_point entropy;  
};

struct data_value
{
        int32_t prev_interval_pkt;
        int32_t cur_interval_pkt;
        int32_t threshold;
        int32_t int_bits;
};
struct loc_ts
{
        struct bpf_spin_lock lock;
        int64_t timestamp;
};

struct
{
        __uint(type, BPF_MAP_TYPE_HASH);
        __type(key, __u32);
        __type(value, struct logger_value);
        __uint(max_entries, LOGGER_MAP_SIZE);
} logger SEC(".maps");

struct
{
        __uint(type, BPF_MAP_TYPE_LPM_TRIE);
        __type(key, struct lpm_v4_key);
        __type(value, __u32);
        __uint(map_flags, BPF_F_NO_PREALLOC);
        __uint(max_entries, 10000);
} blacklist SEC(".maps");

struct
{
        __uint(type, BPF_MAP_TYPE_ARRAY);
        __type(key, __u32);
        __type(value, struct data_value);
        __uint(max_entries, 1);
} data SEC(".maps");

struct
{
        __uint(type, BPF_MAP_TYPE_ARRAY);
        __type(key, __u32);
        __type(value, struct loc_ts);
        __uint(max_entries, 1);
} loc_ts SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_DEVMAP);
    __type(key, __u32);
    __type(value, __u32);
    __uint(max_entries, 1);
} tx_port SEC(".maps");

static int count = 0;
static struct fixed_point entropy_all;
static struct fixed_point avg;

static int calc_entropy(struct bpf_map *map, const void *key, void *value, void *ctx)
{
        struct data_value *tmp = ctx;

        struct logger_value *logger_value = value;
        struct fixed_point cur = to_fixed_point(logger_value->cur, tmp->int_bits);
        struct fixed_point prev = to_fixed_point(logger_value->prev, tmp->int_bits);
        struct fixed_point entropy;
        entropy.q = 16;
        entropy.number = 16;
        struct fixed_point prev_invl = to_fixed_point(tmp->prev_interval_pkt, tmp->int_bits);
        
        struct fixed_point tmp_one = to_fixed_point(1, tmp->int_bits);
        struct fixed_point tmp_ten = to_fixed_point(10, tmp->int_bits);

        if (logger_value->prev == 0 || logger_value->cur == 0)
        {
            if (logger_value->prev == 0)
            {
                prev = divide(&tmp_one, &tmp_ten);
            }

            if (logger_value->cur == 0)
            {
                cur = divide(&tmp_one, &tmp_ten);
            }
        }
        
        // Calculate entropy
        struct fixed_point first = divide(&prev, &prev_invl);
        first = calc_log(&first);
        first.number = first.number * -1;
        if (prev.number >= cur.number)
        {
                struct fixed_point second = divide(&cur, &prev);
                second = calc_log(&second);
                second = abs_val(&second);
                entropy = add(&first, &second);
        }
        else
        {
                struct fixed_point second = divide(&prev, &cur);
                second = calc_log(&second);
                second = abs_val(&second);
                entropy = add(&first, &second);
        }

        logger_value->entropy = entropy;
        entropy_all = add(&entropy_all, &entropy);
        count++;
        return 0;
}


static int detection(struct bpf_map *map, const void *key, void *value, void *ctx)
{
        struct data_value *tmp = ctx;
        struct logger_value *logger_value = value;

        if (logger_value->entropy.number == 0) {
                logger_value->prev = logger_value->cur;
                logger_value->cur = 0;
                return 0;
        }

        struct fixed_point diff = subtract(&logger_value->entropy, &avg);
        struct fixed_point d = abs_val(&diff);

        //if (d > multiply(tmp->threshold, std_dev))
        if (d.number > tmp->threshold)
        {
                // add the IP address to the blacklist
                struct lpm_v4_key filter_key;
                filter_key.prefixlen = 32;
                filter_key.address = *(int *)key;
                //char error_log[] = "Added %d to the blacklist\n";
                //bpf_trace_printk(error_log, sizeof(error_log), filter_key.address);
                //__u32 rule = 1;
                //bpf_map_update_elem(&blacklist, &filter_key, &rule, BPF_ANY);
        }

        // check whether the current packet count is 0
        if (logger_value->cur == 0)
        {
                bpf_map_delete_elem(map, key);
                return 0;
        }
        // reset current packet count
        logger_value->prev = logger_value->cur;
        logger_value->cur = 0;

        return 0;
}

SEC("xdp") // This is the typical "main" function replacement.
int xdp_filter_func(struct xdp_md *ctx)
{
        int64_t ts = bpf_ktime_get_ns();
        struct ethhdr *eth;
        struct iphdr *ip;
        struct lpm_v4_key filter_key;
        filter_key.prefixlen = 32;

        // checks whether packet data format follows the definition of ethernet frame header
        eth = (void *)(long)ctx->data;
        // drop the packet if it doesn't
        if (ctx->data + sizeof(*eth) > ctx->data_end)
        {
                char error_log[] = "Issue with packet size, ETH\n";
                bpf_trace_printk(error_log, sizeof(error_log));
                return XDP_PASS;
        }

        // Packet filtering process for IPv4
        if (eth->h_proto == bpf_htons(ETH_P_IP))
        {
                // checks whether packet data format follows the definition of ip packet header
                ip = (void *)(long)ctx->data + sizeof(*eth);
                // drop the packet if it doesn't
                if (ctx->data + sizeof(*eth) + sizeof(*ip) > ctx->data_end)
                {
			char error_log[] = "Issue with packet size, IPv4\n";
                        bpf_trace_printk(error_log, sizeof(error_log));
                        return XDP_PASS;
                }
        /*{
        ip = (void *)(long)ctx->data;
        if (ctx->data + sizeof(*ip) > ctx->data_end)
        {
		return XDP_DROP;
        }*/

                // check if the IP address is in the blacklist
                
                filter_key.address = ip->saddr;
                __u32 *rule = bpf_map_lookup_elem(&blacklist, &filter_key);
                if (rule)
                {
                        char error_log[] = "IP listed on blocklist.\n";
                        bpf_trace_printk(error_log, sizeof(error_log));
                        return XDP_DROP;
                }

                // Record the number of packets (for this interval)
                int key = 0;
                struct data_value *tmp = bpf_map_lookup_elem(&data, &key);
                if (tmp)
                {
                        // tmp->cur_interval_pkt++;
                        lock_xadd(&tmp->cur_interval_pkt, 1);
                        if (tmp->cur_interval_pkt > (1 << (tmp->int_bits - 1)) - 1) 
                        {
                                // tmp->int_bits++;
                                lock_xadd(&tmp->int_bits, 1);
                        }
                }
                else
                {
                        char error_log[] = "Error at reading data, the first one\n";
                        bpf_trace_printk(error_log, sizeof(error_log));
                        return XDP_PASS;
                }

                // Record the number of packets (for this IP address)
                struct logger_value *value = bpf_map_lookup_elem(&logger, &ip->saddr);
                if (value)
                {
                        // value->cur++;
                        lock_xadd(&value->cur, 1);
                        // bpf_map_update_elem(&logger, &ip->saddr, value, BPF_ANY);
                }
                else
                {
                        
                        struct logger_value new_value;
                        new_value.prev = 0;
                        new_value.cur = 1;
                        new_value.entropy.q = 16;
                        new_value.entropy.number = 0;
                        bpf_map_update_elem(&logger, &ip->saddr, &new_value, BPF_ANY);
                }

                struct loc_ts *lts = bpf_map_lookup_elem(&loc_ts, &key);
                if (!lts)
                {
                        char error_log[] = "Error at reading time stamp\n";
                        bpf_trace_printk(error_log, sizeof(error_log));
                        return XDP_PASS;
                }

                if (ts > lts->timestamp + invl_ns)
                {
                         // update timestamp
                        bpf_spin_lock(&lts->lock);
			if (lts->timestamp == 0)
                	{
				lts->timestamp = ts;
                                bpf_spin_unlock(&lts->lock);
				goto END;
			} else
                        if (ts > lts->timestamp + invl_ns)
                	{
				lts->timestamp = ts;
			} else 
			{
				bpf_spin_unlock(&lts->lock);
				goto END;
			}
			bpf_spin_unlock(&lts->lock);
                        //  calulate entropy
                        struct data_value t;
                        struct data_value *d = __builtin_memcpy(&t, tmp, sizeof(struct data_value));
                        bpf_for_each_map_elem(&logger, calc_entropy, d, 0);
                        struct fixed_point cnt = to_fixed_point(count, tmp->int_bits);
                        avg = divide(&entropy_all, &cnt);

                        // int deviation  = 0;
                        // bpf_for_each_map_elem(&logger, calc_dev, &deviation, 0);
                        
                        // int variance = multiply(deviation, deviation);
                        // std_dev = 1 << get_integer(calc_log(variance));
                        bpf_for_each_map_elem(&logger, detection, d, 0);

                        // update previous interval packet count
                        tmp->prev_interval_pkt = tmp->cur_interval_pkt;
                        tmp->cur_interval_pkt = 0;
                        tmp->int_bits = 4;
	                count = 0;
                        entropy_all.number = 0;
                        entropy_all.q = 16;
                }
        }
	goto END;
	
	END:
	//return XDP_PASS;
       	return bpf_redirect_map(&tx_port, 0, 0);
}
char _license[] SEC("license") = "GPL";
