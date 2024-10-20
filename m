Return-Path: <linux-kselftest+bounces-20224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772EB9A5619
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 21:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F528151D
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8E1990C3;
	Sun, 20 Oct 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gab/gp3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DD194C67;
	Sun, 20 Oct 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452198; cv=none; b=g7FwzXNRUBUHmT3ARZzR9HSMF3osadEvl5NNSguO1EeoFgVSGBGlZ1VEYR3ck8g4M327kGmU345n9GypvEdw3/pLqV5sE7kUy06hEWwpkmZRmJ3OwExPh8b0r7jOT+KOPLpHraEF0eWYJGLpgbundsloEoAlJvmutk0x98THMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452198; c=relaxed/simple;
	bh=F6Roq7f9tTvCuSePQs3sDrJZuIt9ToqhCnAdISXkF1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5mTcDIuA/dctBnoeyyJ8xXwol1vIlM6gR7KYJ+X+P3uNjwISackZtMER+G3NXZMT/RS8AUy9LsT99xJ7iq3lATlv3TYbQBlO5KrRnBb7chV84W+IJVNO5ooAdnt82/rQWwsygR3kwC7+6mes+asLPsIrYXZymQ1f7jTip27mhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gab/gp3t; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B18EB24000C;
	Sun, 20 Oct 2024 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729452193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fx9i21pAqjrbU0cXkWsBZAKAK0ryJsZV4ejVPP7rKRU=;
	b=Gab/gp3tAMN2Y6I2Ch1bPBnsdLVi/z7S/P5tRPbNUb4GmJ8sF1l+rIKFCwVt9y76vZhi3X
	OW/tYTw+o+I6D7H+5LnpcoMbFfIVJR0fGIq/36lBXV0hgnZ6CTXlZAvw9Rkf8YEJq4qTgQ
	wTsJTll3NLsmxZe9cG+N3PiD/Kt2rgD9xaTxaE9hgJ0Jm/6vT4T0fH6w1BmP5auQNbSifc
	ZwXuPA+KXuyHjZ8N943OUIvhx284hqjuNEmvuZhZP9Gy5BtUG0HvRrfYjH91uzclyE3j59
	rZYptGKs65E/1/TExJ0daraI9Ep9fYa9oQJhIYRyaYqhVFasmNXJKf9KsOYDug==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sun, 20 Oct 2024 21:22:58 +0200
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: remove
 test_tcp_check_syncookie
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241020-syncookie-v2-6-2db240225fed@bootlin.com>
References: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
In-Reply-To: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenz Bauer <lorenz.bauer@isovalent.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Now that btf_skc_cls_ingress has the same coverage as
test_tcp_check_syncookie, remove the second one and keep the first one
as it is integrated in test_progs

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   9 +-
 .../bpf/progs/test_tcp_check_syncookie_kern.c      | 167 ----------------
 .../selftests/bpf/test_tcp_check_syncookie.sh      |  85 --------
 .../selftests/bpf/test_tcp_check_syncookie_user.c  | 213 ---------------------
 5 files changed, 3 insertions(+), 472 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e6533b3400de5ef9b0c0e02aa0e1afedcab9b349..7e88551f2d38bdfa87fd56ac83874c88c4335927 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -24,7 +24,6 @@ test_flow_dissector
 flow_dissector_load
 test_tcpnotify_user
 test_libbpf
-test_tcp_check_syncookie_user
 test_sysctl
 xdping
 test_cpp
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 28a76baa854d3ef45bc6d511ad9188e737f0ebe8..7815b815fcef4a8e42f0211253c1e351a9af2abf 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -137,7 +137,6 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_vlan_mode_generic.sh \
 	test_xdp_vlan_mode_native.sh \
 	test_lwt_ip_encap.sh \
-	test_tcp_check_syncookie.sh \
 	test_tc_tunnel.sh \
 	test_tc_edt.sh \
 	test_xdping.sh \
@@ -154,10 +153,9 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
-	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
-	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
-	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	flow_dissector_load test_flow_dissector	test_lirc_mode2_user xdping \
+	test_cpp runqslower bench bpf_testmod.ko xskxceiver xdp_redirect_multi \
+	xdp_synproxy veristat xdp_hw_metadata xdp_features bpf_test_no_cfi.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -347,7 +345,6 @@ $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
-$(OUTPUT)/test_tcp_check_syncookie_user: $(NETWORK_HELPERS)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
deleted file mode 100644
index 6edebce563b57e96b04a20b6d14dbcdca62152d5..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
+++ /dev/null
@@ -1,167 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-// Copyright (c) 2019 Cloudflare
-
-#include <string.h>
-
-#include <linux/bpf.h>
-#include <linux/pkt_cls.h>
-#include <linux/if_ether.h>
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <sys/socket.h>
-#include <linux/tcp.h>
-
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_endian.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, __u32);
-	__type(value, __u32);
-	__uint(max_entries, 3);
-} results SEC(".maps");
-
-static __always_inline __s64 gen_syncookie(void *data_end, struct bpf_sock *sk,
-					   void *iph, __u32 ip_size,
-					   struct tcphdr *tcph)
-{
-	__u32 thlen = tcph->doff * 4;
-
-	if (tcph->syn && !tcph->ack) {
-		// packet should only have an MSS option
-		if (thlen != 24)
-			return 0;
-
-		if ((void *)tcph + thlen > data_end)
-			return 0;
-
-		return bpf_tcp_gen_syncookie(sk, iph, ip_size, tcph, thlen);
-	}
-	return 0;
-}
-
-static __always_inline void check_syncookie(void *ctx, void *data,
-					    void *data_end)
-{
-	struct bpf_sock_tuple tup;
-	struct bpf_sock *sk;
-	struct ethhdr *ethh;
-	struct iphdr *ipv4h;
-	struct ipv6hdr *ipv6h;
-	struct tcphdr *tcph;
-	int ret;
-	__u32 key_mss = 2;
-	__u32 key_gen = 1;
-	__u32 key = 0;
-	__s64 seq_mss;
-
-	ethh = data;
-	if (ethh + 1 > data_end)
-		return;
-
-	switch (bpf_ntohs(ethh->h_proto)) {
-	case ETH_P_IP:
-		ipv4h = data + sizeof(struct ethhdr);
-		if (ipv4h + 1 > data_end)
-			return;
-
-		if (ipv4h->ihl != 5)
-			return;
-
-		tcph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);
-		if (tcph + 1 > data_end)
-			return;
-
-		tup.ipv4.saddr = ipv4h->saddr;
-		tup.ipv4.daddr = ipv4h->daddr;
-		tup.ipv4.sport = tcph->source;
-		tup.ipv4.dport = tcph->dest;
-
-		sk = bpf_skc_lookup_tcp(ctx, &tup, sizeof(tup.ipv4),
-					BPF_F_CURRENT_NETNS, 0);
-		if (!sk)
-			return;
-
-		if (sk->state != BPF_TCP_LISTEN)
-			goto release;
-
-		seq_mss = gen_syncookie(data_end, sk, ipv4h, sizeof(*ipv4h),
-					tcph);
-
-		ret = bpf_tcp_check_syncookie(sk, ipv4h, sizeof(*ipv4h),
-					      tcph, sizeof(*tcph));
-		break;
-
-	case ETH_P_IPV6:
-		ipv6h = data + sizeof(struct ethhdr);
-		if (ipv6h + 1 > data_end)
-			return;
-
-		if (ipv6h->nexthdr != IPPROTO_TCP)
-			return;
-
-		tcph = data + sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
-		if (tcph + 1 > data_end)
-			return;
-
-		memcpy(tup.ipv6.saddr, &ipv6h->saddr, sizeof(tup.ipv6.saddr));
-		memcpy(tup.ipv6.daddr, &ipv6h->daddr, sizeof(tup.ipv6.daddr));
-		tup.ipv6.sport = tcph->source;
-		tup.ipv6.dport = tcph->dest;
-
-		sk = bpf_skc_lookup_tcp(ctx, &tup, sizeof(tup.ipv6),
-					BPF_F_CURRENT_NETNS, 0);
-		if (!sk)
-			return;
-
-		if (sk->state != BPF_TCP_LISTEN)
-			goto release;
-
-		seq_mss = gen_syncookie(data_end, sk, ipv6h, sizeof(*ipv6h),
-					tcph);
-
-		ret = bpf_tcp_check_syncookie(sk, ipv6h, sizeof(*ipv6h),
-					      tcph, sizeof(*tcph));
-		break;
-
-	default:
-		return;
-	}
-
-	if (seq_mss > 0) {
-		__u32 cookie = (__u32)seq_mss;
-		__u32 mss = seq_mss >> 32;
-
-		bpf_map_update_elem(&results, &key_gen, &cookie, 0);
-		bpf_map_update_elem(&results, &key_mss, &mss, 0);
-	}
-
-	if (ret == 0) {
-		__u32 cookie = bpf_ntohl(tcph->ack_seq) - 1;
-
-		bpf_map_update_elem(&results, &key, &cookie, 0);
-	}
-
-release:
-	bpf_sk_release(sk);
-}
-
-SEC("tc")
-int check_syncookie_clsact(struct __sk_buff *skb)
-{
-	check_syncookie(skb, (void *)(long)skb->data,
-			(void *)(long)skb->data_end);
-	return TC_ACT_OK;
-}
-
-SEC("xdp")
-int check_syncookie_xdp(struct xdp_md *ctx)
-{
-	check_syncookie(ctx, (void *)(long)ctx->data,
-			(void *)(long)ctx->data_end);
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
deleted file mode 100755
index b42c24282c2543a61b559e70c4961011ddb8c463..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2018 Facebook
-# Copyright (c) 2019 Cloudflare
-
-set -eu
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-
-wait_for_ip()
-{
-	local _i
-	printf "Wait for IP %s to become available " "$1"
-	for _i in $(seq ${MAX_PING_TRIES}); do
-		printf "."
-		if ns1_exec ping -c 1 -W 1 "$1" >/dev/null 2>&1; then
-			echo " OK"
-			return
-		fi
-		sleep 1
-	done
-	echo 1>&2 "ERROR: Timeout waiting for test IP to become available."
-	exit 1
-}
-
-get_prog_id()
-{
-	awk '/ id / {sub(/.* id /, "", $0); print($1)}'
-}
-
-ns1_exec()
-{
-	ip netns exec ${NS1} "$@"
-}
-
-setup()
-{
-	ip netns add ${NS1}
-	ns1_exec ip link set lo up
-
-	ns1_exec sysctl -w net.ipv4.tcp_syncookies=2
-	ns1_exec sysctl -w net.ipv4.tcp_window_scaling=0
-	ns1_exec sysctl -w net.ipv4.tcp_timestamps=0
-	ns1_exec sysctl -w net.ipv4.tcp_sack=0
-
-	wait_for_ip 127.0.0.1
-	wait_for_ip ::1
-}
-
-cleanup()
-{
-	ip netns del ns1 2>/dev/null || :
-}
-
-main()
-{
-	trap cleanup EXIT 2 3 6 15
-	setup
-
-	printf "Testing clsact..."
-	ns1_exec tc qdisc add dev "${TEST_IF}" clsact
-	ns1_exec tc filter add dev "${TEST_IF}" ingress \
-		bpf obj "${BPF_PROG_OBJ}" sec "${CLSACT_SECTION}" da
-
-	BPF_PROG_ID=$(ns1_exec tc filter show dev "${TEST_IF}" ingress | \
-		      get_prog_id)
-	ns1_exec "${PROG}" "${BPF_PROG_ID}"
-	ns1_exec tc qdisc del dev "${TEST_IF}" clsact
-
-	printf "Testing XDP..."
-	ns1_exec ip link set "${TEST_IF}" xdp \
-		object "${BPF_PROG_OBJ}" section "${XDP_SECTION}"
-	BPF_PROG_ID=$(ns1_exec ip link show "${TEST_IF}" | get_prog_id)
-	ns1_exec "${PROG}" "${BPF_PROG_ID}"
-}
-
-DIR=$(dirname $0)
-TEST_IF=lo
-MAX_PING_TRIES=5
-BPF_PROG_OBJ="${DIR}/test_tcp_check_syncookie_kern.bpf.o"
-CLSACT_SECTION="tc"
-XDP_SECTION="xdp"
-BPF_PROG_ID=0
-PROG="${DIR}/test_tcp_check_syncookie_user"
-
-main
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
deleted file mode 100644
index 3844f9b8232a25278e8190bc9b878ed73060fd4d..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ /dev/null
@@ -1,213 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-// Copyright (c) 2019 Cloudflare
-
-#include <limits.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-#include <arpa/inet.h>
-#include <netinet/in.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "cgroup_helpers.h"
-#include "network_helpers.h"
-
-static int get_map_fd_by_prog_id(int prog_id, bool *xdp)
-{
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	__u32 map_ids[1];
-	int prog_fd = -1;
-	int map_fd = -1;
-
-	prog_fd = bpf_prog_get_fd_by_id(prog_id);
-	if (prog_fd < 0) {
-		log_err("Failed to get fd by prog id %d", prog_id);
-		goto err;
-	}
-
-	info.nr_map_ids = 1;
-	info.map_ids = (__u64)(unsigned long)map_ids;
-
-	if (bpf_prog_get_info_by_fd(prog_fd, &info, &info_len)) {
-		log_err("Failed to get info by prog fd %d", prog_fd);
-		goto err;
-	}
-
-	if (!info.nr_map_ids) {
-		log_err("No maps found for prog fd %d", prog_fd);
-		goto err;
-	}
-
-	*xdp = info.type == BPF_PROG_TYPE_XDP;
-
-	map_fd = bpf_map_get_fd_by_id(map_ids[0]);
-	if (map_fd < 0)
-		log_err("Failed to get fd by map id %d", map_ids[0]);
-err:
-	if (prog_fd >= 0)
-		close(prog_fd);
-	return map_fd;
-}
-
-static int run_test(int server_fd, int results_fd, bool xdp)
-{
-	int client = -1, srv_client = -1;
-	int ret = 0;
-	__u32 key = 0;
-	__u32 key_gen = 1;
-	__u32 key_mss = 2;
-	__u32 value = 0;
-	__u32 value_gen = 0;
-	__u32 value_mss = 0;
-
-	if (bpf_map_update_elem(results_fd, &key, &value, 0) < 0) {
-		log_err("Can't clear results");
-		goto err;
-	}
-
-	if (bpf_map_update_elem(results_fd, &key_gen, &value_gen, 0) < 0) {
-		log_err("Can't clear results");
-		goto err;
-	}
-
-	if (bpf_map_update_elem(results_fd, &key_mss, &value_mss, 0) < 0) {
-		log_err("Can't clear results");
-		goto err;
-	}
-
-	client = connect_to_fd(server_fd, 0);
-	if (client == -1)
-		goto err;
-
-	srv_client = accept(server_fd, NULL, 0);
-	if (srv_client == -1) {
-		log_err("Can't accept connection");
-		goto err;
-	}
-
-	if (bpf_map_lookup_elem(results_fd, &key, &value) < 0) {
-		log_err("Can't lookup result");
-		goto err;
-	}
-
-	if (value == 0) {
-		log_err("Didn't match syncookie: %u", value);
-		goto err;
-	}
-
-	if (bpf_map_lookup_elem(results_fd, &key_gen, &value_gen) < 0) {
-		log_err("Can't lookup result");
-		goto err;
-	}
-
-	if (xdp && value_gen == 0) {
-		// SYN packets do not get passed through generic XDP, skip the
-		// rest of the test.
-		printf("Skipping XDP cookie check\n");
-		goto out;
-	}
-
-	if (bpf_map_lookup_elem(results_fd, &key_mss, &value_mss) < 0) {
-		log_err("Can't lookup result");
-		goto err;
-	}
-
-	if (value != value_gen) {
-		log_err("BPF generated cookie does not match kernel one");
-		goto err;
-	}
-
-	if (value_mss < 536 || value_mss > USHRT_MAX) {
-		log_err("Unexpected MSS retrieved");
-		goto err;
-	}
-
-	goto out;
-
-err:
-	ret = 1;
-out:
-	close(client);
-	close(srv_client);
-	return ret;
-}
-
-static int v6only_true(int fd, void *opts)
-{
-	int mode = true;
-
-	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
-}
-
-static int v6only_false(int fd, void *opts)
-{
-	int mode = false;
-
-	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
-}
-
-int main(int argc, char **argv)
-{
-	struct network_helper_opts opts = { 0 };
-	int server = -1;
-	int server_v6 = -1;
-	int server_dual = -1;
-	int results = -1;
-	int err = 0;
-	bool xdp;
-
-	if (argc < 2) {
-		fprintf(stderr, "Usage: %s prog_id\n", argv[0]);
-		exit(1);
-	}
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	results = get_map_fd_by_prog_id(atoi(argv[1]), &xdp);
-	if (results < 0) {
-		log_err("Can't get map");
-		goto err;
-	}
-
-	server = start_server_str(AF_INET, SOCK_STREAM, "127.0.0.1", 0, NULL);
-	if (server == -1)
-		goto err;
-
-	opts.post_socket_cb = v6only_true;
-	server_v6 = start_server_str(AF_INET6, SOCK_STREAM, "::1", 0, &opts);
-	if (server_v6 == -1)
-		goto err;
-
-	opts.post_socket_cb = v6only_false;
-	server_dual = start_server_str(AF_INET6, SOCK_STREAM, "::0", 0, &opts);
-	if (server_dual == -1)
-		goto err;
-
-	if (run_test(server, results, xdp))
-		goto err;
-
-	if (run_test(server_v6, results, xdp))
-		goto err;
-
-	if (run_test(server_dual, results, xdp))
-		goto err;
-
-	printf("ok\n");
-	goto out;
-err:
-	err = 1;
-out:
-	close(server);
-	close(server_v6);
-	close(server_dual);
-	close(results);
-	return err;
-}

-- 
2.47.0


