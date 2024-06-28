# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

XDP_TARGETS  := xdp_prog_kern
USER_TARGETS := xdp_loader
USER_TARGETS += xdp_insert
USER_TARGETS += xdp_inspector
USER_TARGETS += filter_gen
CFLAG = -lm

LIBBPF_DIR = libbpf/src/
COMMON_DIR = common/

# Extend with another COMMON_OBJS
COMMON_OBJS += $(COMMON_DIR)/common_libbpf.o

include $(COMMON_DIR)/common.mk
