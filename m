Return-Path: <linux-kselftest+bounces-25479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602BA23A18
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349E43A95A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A61D5CEE;
	Fri, 31 Jan 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fGz6C2sL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988401C54B2;
	Fri, 31 Jan 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308127; cv=none; b=Qx/LParKCLKpZRmp9zJYaBILgAIzaKaZ6lf6pB6F7a+KvJPQRXdRMFVUyLU0ucUiIX7vI4cHWa3R7VY8oH2VOnHeh2cS4XTemhfGSWgdOHktBWwoCBnt7r7HtuEG2IhTvsmYG+P1svyKF45mg8SuMMSMtPx+CcxD+PDoLR/f8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308127; c=relaxed/simple;
	bh=TLbephqRzZUbnNMeh5HLjP1DbT3MJAIK71uZlNm64eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxQXLCbnKICbC3nFWVCmqKCW5bO190VmGPc7o4TGPWLcPGhBkU2WwIrC37kxlVl4UmohcWKZcVeRB1exLY66QNsub25Zrd8HJ9KiyyvgNoTyafc9hgRPa7AzkqmoGhNFgNjV47AqYBmzKi//DyXfwHEg1H0TsGk3wCsKvlbs8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fGz6C2sL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5A39442D9;
	Fri, 31 Jan 2025 07:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhKj4MjB8Bp5lRZabuDZ3mwzfxVA+RngPzFvHgVpZzA=;
	b=fGz6C2sLFXnDNmXXt/BSY2DhoyjCLvotNIyGTMwRnMbbwZqniTM0GLLZ3fqoPhTnPZRHOa
	knt/WpJOdFcuumZdxQvE1Djp4BoiYHi/bouNXyzOQ95n6crIMzWwCLcAGFC3xObKS+2fvG
	Kx1RTi7NBL7073a1W2kd1/P9s0dIBP1k8rFg/v+zVrxt9VjnpWHIRj51EJfTRpdLhZ41dK
	U4283wkCmqloycbCmrMphute0SEyDvXItD7XdhB3NXRot24liWLQgQp59ke/6DSAl/AOf0
	aZgownw9una4UUissmIkORl24SZBmT1kARCD9DMhabcWyZq0r1hNliIMTQiU8w==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:53 +0100
Subject: [PATCH bpf-next v4 14/14] selftests/bpf: Remove
 test_xdp_redirect_multi.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-14-970b33678512@bootlin.com>
References: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
In-Reply-To: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevhfetkeegtdfgteevveekveellefggeeiteetieejkefhhefhuefggfdvleenucffohhmrghinhepihhfrhgphhifrgguughrrdhsrgenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnr
 dgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

The tests done by test_xdp_redirect_multi.sh are now fully covered by
the CI through test_xdp_veth.c.

Remove test_xdp_redirect_multi.sh
Remove xdp_redirect_multi.c that was used by the script to load and
attach the BPF programs.
Remove their entries in the Makefile

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |   2 -
 .../selftests/bpf/test_xdp_redirect_multi.sh       | 214 -------------------
 tools/testing/selftests/bpf/xdp_redirect_multi.c   | 226 ---------------------
 3 files changed, 442 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6722080b2107a56c1500bab4d7b638f5bcde2a82..38738946ef16dc1e29418bdaca660d5a69cce6a8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -100,7 +100,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
-	test_xdp_redirect_multi.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
@@ -135,7 +134,6 @@ TEST_GEN_PROGS_EXTENDED = \
 	veristat \
 	xdp_features \
 	xdp_hw_metadata \
-	xdp_redirect_multi \
 	xdp_synproxy \
 	xdping \
 	xskxceiver
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
deleted file mode 100755
index 4c3c3fdd2d7304cbe71abbea69f1c20601108b2d..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
+++ /dev/null
@@ -1,214 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Test topology:
-#    - - - - - - - - - - - - - - - - - - -
-#    | veth1         veth2         veth3 |  ns0
-#     - -| - - - - - - | - - - - - - | - -
-#    ---------     ---------     ---------
-#    | veth0 |     | veth0 |     | veth0 |
-#    ---------     ---------     ---------
-#       ns1           ns2           ns3
-#
-# Test modules:
-# XDP modes: generic, native, native + egress_prog
-#
-# Test cases:
-#   ARP: Testing BPF_F_BROADCAST, the ingress interface also should receive
-#   the redirects.
-#      ns1 -> gw: ns1, ns2, ns3, should receive the arp request
-#   IPv4: Testing BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS, the ingress
-#   interface should not receive the redirects.
-#      ns1 -> gw: ns1 should not receive, ns2, ns3 should receive redirects.
-#   IPv6: Testing none flag, all the pkts should be redirected back
-#      ping test: ns1 -> ns2 (block), echo requests will be redirect back
-#   egress_prog:
-#      all src mac should be egress interface's mac
-
-# netns numbers
-NUM=3
-IFACES=""
-DRV_MODE="xdpgeneric xdpdrv xdpegress"
-PASS=0
-FAIL=0
-LOG_DIR=$(mktemp -d)
-declare -a NS
-NS[0]="ns0-$(mktemp -u XXXXXX)"
-NS[1]="ns1-$(mktemp -u XXXXXX)"
-NS[2]="ns2-$(mktemp -u XXXXXX)"
-NS[3]="ns3-$(mktemp -u XXXXXX)"
-
-test_pass()
-{
-	echo "Pass: $@"
-	PASS=$((PASS + 1))
-}
-
-test_fail()
-{
-	echo "fail: $@"
-	FAIL=$((FAIL + 1))
-}
-
-clean_up()
-{
-	for i in $(seq 0 $NUM); do
-		ip netns del ${NS[$i]} 2> /dev/null
-	done
-}
-
-# Kselftest framework requirement - SKIP code is 4.
-check_env()
-{
-	ip link set dev lo xdpgeneric off &>/dev/null
-	if [ $? -ne 0 ];then
-		echo "selftests: [SKIP] Could not run test without the ip xdpgeneric support"
-		exit 4
-	fi
-
-	which tcpdump &>/dev/null
-	if [ $? -ne 0 ];then
-		echo "selftests: [SKIP] Could not run test without tcpdump"
-		exit 4
-	fi
-}
-
-setup_ns()
-{
-	local mode=$1
-	IFACES=""
-
-	if [ "$mode" = "xdpegress" ]; then
-		mode="xdpdrv"
-	fi
-
-	ip netns add ${NS[0]}
-	for i in $(seq $NUM); do
-	        ip netns add ${NS[$i]}
-		ip -n ${NS[$i]} link add veth0 type veth peer name veth$i netns ${NS[0]}
-		ip -n ${NS[$i]} link set veth0 up
-		ip -n ${NS[0]} link set veth$i up
-
-		ip -n ${NS[$i]} addr add 192.0.2.$i/24 dev veth0
-		ip -n ${NS[$i]} addr add 2001:db8::$i/64 dev veth0
-		# Add a neigh entry for IPv4 ping test
-		ip -n ${NS[$i]} neigh add 192.0.2.253 lladdr 00:00:00:00:00:01 dev veth0
-		ip -n ${NS[$i]} link set veth0 $mode obj \
-			xdp_dummy.bpf.o sec xdp &> /dev/null || \
-			{ test_fail "Unable to load dummy xdp" && exit 1; }
-		IFACES="$IFACES veth$i"
-		veth_mac[$i]=$(ip -n ${NS[0]} link show veth$i | awk '/link\/ether/ {print $2}')
-	done
-}
-
-do_egress_tests()
-{
-	local mode=$1
-
-	# mac test
-	ip netns exec ${NS[2]} tcpdump -e -i veth0 -nn -l -e &> ${LOG_DIR}/mac_ns1-2_${mode}.log &
-	ip netns exec ${NS[3]} tcpdump -e -i veth0 -nn -l -e &> ${LOG_DIR}/mac_ns1-3_${mode}.log &
-	sleep 0.5
-	ip netns exec ${NS[1]} ping 192.0.2.254 -i 0.1 -c 4 &> /dev/null
-	sleep 0.5
-	pkill tcpdump
-
-	# mac check
-	grep -q "${veth_mac[2]} > ff:ff:ff:ff:ff:ff" ${LOG_DIR}/mac_ns1-2_${mode}.log && \
-	       test_pass "$mode mac ns1-2" || test_fail "$mode mac ns1-2"
-	grep -q "${veth_mac[3]} > ff:ff:ff:ff:ff:ff" ${LOG_DIR}/mac_ns1-3_${mode}.log && \
-		test_pass "$mode mac ns1-3" || test_fail "$mode mac ns1-3"
-}
-
-do_ping_tests()
-{
-	local mode=$1
-
-	# ping6 test: echo request should be redirect back to itself, not others
-	ip netns exec ${NS[1]} ip neigh add 2001:db8::2 dev veth0 lladdr 00:00:00:00:00:02
-
-	ip netns exec ${NS[1]} tcpdump -i veth0 -nn -l -e &> ${LOG_DIR}/ns1-1_${mode}.log &
-	ip netns exec ${NS[2]} tcpdump -i veth0 -nn -l -e &> ${LOG_DIR}/ns1-2_${mode}.log &
-	ip netns exec ${NS[3]} tcpdump -i veth0 -nn -l -e &> ${LOG_DIR}/ns1-3_${mode}.log &
-	sleep 0.5
-	# ARP test
-	ip netns exec ${NS[1]} arping -q -c 2 -I veth0 192.0.2.254
-	# IPv4 test
-	ip netns exec ${NS[1]} ping 192.0.2.253 -i 0.1 -c 4 &> /dev/null
-	# IPv6 test
-	ip netns exec ${NS[1]} ping6 2001:db8::2 -i 0.1 -c 2 &> /dev/null
-	sleep 0.5
-	pkill tcpdump
-
-	# All netns should receive the redirect arp requests
-	[ $(grep -cF "who-has 192.0.2.254" ${LOG_DIR}/ns1-1_${mode}.log) -eq 4 ] && \
-		test_pass "$mode arp(F_BROADCAST) ns1-1" || \
-		test_fail "$mode arp(F_BROADCAST) ns1-1"
-	[ $(grep -cF "who-has 192.0.2.254" ${LOG_DIR}/ns1-2_${mode}.log) -eq 2 ] && \
-		test_pass "$mode arp(F_BROADCAST) ns1-2" || \
-		test_fail "$mode arp(F_BROADCAST) ns1-2"
-	[ $(grep -cF "who-has 192.0.2.254" ${LOG_DIR}/ns1-3_${mode}.log) -eq 2 ] && \
-		test_pass "$mode arp(F_BROADCAST) ns1-3" || \
-		test_fail "$mode arp(F_BROADCAST) ns1-3"
-
-	# ns1 should not receive the redirect echo request, others should
-	[ $(grep -c "ICMP echo request" ${LOG_DIR}/ns1-1_${mode}.log) -eq 4 ] && \
-		test_pass "$mode IPv4 (F_BROADCAST|F_EXCLUDE_INGRESS) ns1-1" || \
-		test_fail "$mode IPv4 (F_BROADCAST|F_EXCLUDE_INGRESS) ns1-1"
-	[ $(grep -c "ICMP echo request" ${LOG_DIR}/ns1-2_${mode}.log) -eq 4 ] && \
-		test_pass "$mode IPv4 (F_BROADCAST|F_EXCLUDE_INGRESS) ns1-2" || \
-		test_fail "$mode IPv4 (F_BROADCAST|F_EXCLUDE_INGRESS) ns1-2"
-	[ $(grep -c "ICMP echo request" ${LOG_DIR}/ns1-3_${mode}.log) -eq 4 ] && \
-		test_pass "$mode IPv4 (F_BROADCAST|F_EXCLUDE_INGRESS) ns1-3" || \
-		test_fail "$mode IPv4 (F_BROADCAST|F_EXCLUDE_INGRESS) ns1-3"
-
-	# ns1 should receive the echo request, ns2 should not
-	[ $(grep -c "ICMP6, echo request" ${LOG_DIR}/ns1-1_${mode}.log) -eq 4 ] && \
-		test_pass "$mode IPv6 (no flags) ns1-1" || \
-		test_fail "$mode IPv6 (no flags) ns1-1"
-	[ $(grep -c "ICMP6, echo request" ${LOG_DIR}/ns1-2_${mode}.log) -eq 0 ] && \
-		test_pass "$mode IPv6 (no flags) ns1-2" || \
-		test_fail "$mode IPv6 (no flags) ns1-2"
-}
-
-do_tests()
-{
-	local mode=$1
-	local drv_p
-
-	case ${mode} in
-		xdpdrv)  drv_p="-N";;
-		xdpegress) drv_p="-X";;
-		xdpgeneric) drv_p="-S";;
-	esac
-
-	ip netns exec ${NS[0]} ./xdp_redirect_multi $drv_p $IFACES &> ${LOG_DIR}/xdp_redirect_${mode}.log &
-	xdp_pid=$!
-	sleep 1
-	if ! ps -p $xdp_pid > /dev/null; then
-		test_fail "$mode xdp_redirect_multi start failed"
-		return 1
-	fi
-
-	if [ "$mode" = "xdpegress" ]; then
-		do_egress_tests $mode
-	else
-		do_ping_tests $mode
-	fi
-
-	kill $xdp_pid
-}
-
-check_env
-
-trap clean_up EXIT
-
-for mode in ${DRV_MODE}; do
-	setup_ns $mode
-	do_tests $mode
-	clean_up
-done
-rm -rf ${LOG_DIR}
-
-echo "Summary: PASS $PASS, FAIL $FAIL"
-[ $FAIL -eq 0 ] && exit 0 || exit 1
diff --git a/tools/testing/selftests/bpf/xdp_redirect_multi.c b/tools/testing/selftests/bpf/xdp_redirect_multi.c
deleted file mode 100644
index c1fc44c87c300c72df65a2fb00f9293c3b4f2ffc..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/xdp_redirect_multi.c
+++ /dev/null
@@ -1,226 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
-#include <linux/if_link.h>
-#include <assert.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <net/if.h>
-#include <unistd.h>
-#include <libgen.h>
-#include <sys/ioctl.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-
-#include "bpf_util.h"
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#define MAX_IFACE_NUM 32
-#define MAX_INDEX_NUM 1024
-
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-static int ifaces[MAX_IFACE_NUM] = {};
-
-static void int_exit(int sig)
-{
-	__u32 prog_id = 0;
-	int i;
-
-	for (i = 0; ifaces[i] > 0; i++) {
-		if (bpf_xdp_query_id(ifaces[i], xdp_flags, &prog_id)) {
-			printf("bpf_xdp_query_id failed\n");
-			exit(1);
-		}
-		if (prog_id)
-			bpf_xdp_detach(ifaces[i], xdp_flags, NULL);
-	}
-
-	exit(0);
-}
-
-static int get_mac_addr(unsigned int ifindex, void *mac_addr)
-{
-	char ifname[IF_NAMESIZE];
-	struct ifreq ifr;
-	int fd, ret = -1;
-
-	fd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (fd < 0)
-		return ret;
-
-	if (!if_indextoname(ifindex, ifname))
-		goto err_out;
-
-	strcpy(ifr.ifr_name, ifname);
-
-	if (ioctl(fd, SIOCGIFHWADDR, &ifr) != 0)
-		goto err_out;
-
-	memcpy(mac_addr, ifr.ifr_hwaddr.sa_data, 6 * sizeof(char));
-	ret = 0;
-
-err_out:
-	close(fd);
-	return ret;
-}
-
-static void usage(const char *prog)
-{
-	fprintf(stderr,
-		"usage: %s [OPTS] <IFNAME|IFINDEX> <IFNAME|IFINDEX> ...\n"
-		"OPTS:\n"
-		"    -S    use skb-mode\n"
-		"    -N    enforce native mode\n"
-		"    -F    force loading prog\n"
-		"    -X    load xdp program on egress\n",
-		prog);
-}
-
-int main(int argc, char **argv)
-{
-	int prog_fd, group_all, mac_map;
-	struct bpf_program *ingress_prog, *egress_prog;
-	int i, err, ret, opt, egress_prog_fd = 0;
-	struct bpf_devmap_val devmap_val;
-	bool attach_egress_prog = false;
-	unsigned char mac_addr[6];
-	char ifname[IF_NAMESIZE];
-	struct bpf_object *obj;
-	unsigned int ifindex;
-	char filename[256];
-
-	while ((opt = getopt(argc, argv, "SNFX")) != -1) {
-		switch (opt) {
-		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
-			break;
-		case 'N':
-			/* default, set below */
-			break;
-		case 'F':
-			xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
-			break;
-		case 'X':
-			attach_egress_prog = true;
-			break;
-		default:
-			usage(basename(argv[0]));
-			return 1;
-		}
-	}
-
-	if (!(xdp_flags & XDP_FLAGS_SKB_MODE)) {
-		xdp_flags |= XDP_FLAGS_DRV_MODE;
-	} else if (attach_egress_prog) {
-		printf("Load xdp program on egress with SKB mode not supported yet\n");
-		goto err_out;
-	}
-
-	if (optind == argc) {
-		printf("usage: %s <IFNAME|IFINDEX> <IFNAME|IFINDEX> ...\n", argv[0]);
-		goto err_out;
-	}
-
-	printf("Get interfaces:");
-	for (i = 0; i < MAX_IFACE_NUM && argv[optind + i]; i++) {
-		ifaces[i] = if_nametoindex(argv[optind + i]);
-		if (!ifaces[i])
-			ifaces[i] = strtoul(argv[optind + i], NULL, 0);
-		if (!if_indextoname(ifaces[i], ifname)) {
-			perror("Invalid interface name or i");
-			goto err_out;
-		}
-		if (ifaces[i] > MAX_INDEX_NUM) {
-			printf(" interface index too large\n");
-			goto err_out;
-		}
-		printf(" %d", ifaces[i]);
-	}
-	printf("\n");
-
-	snprintf(filename, sizeof(filename), "%s_kern.bpf.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	err = libbpf_get_error(obj);
-	if (err)
-		goto err_out;
-	err = bpf_object__load(obj);
-	if (err)
-		goto err_out;
-	prog_fd = bpf_program__fd(bpf_object__next_program(obj, NULL));
-
-	if (attach_egress_prog)
-		group_all = bpf_object__find_map_fd_by_name(obj, "map_egress");
-	else
-		group_all = bpf_object__find_map_fd_by_name(obj, "map_all");
-	mac_map = bpf_object__find_map_fd_by_name(obj, "mac_map");
-
-	if (group_all < 0 || mac_map < 0) {
-		printf("bpf_object__find_map_fd_by_name failed\n");
-		goto err_out;
-	}
-
-	if (attach_egress_prog) {
-		/* Find ingress/egress prog for 2nd xdp prog */
-		ingress_prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_all_prog");
-		egress_prog = bpf_object__find_program_by_name(obj, "xdp_devmap_prog");
-		if (!ingress_prog || !egress_prog) {
-			printf("finding ingress/egress_prog in obj file failed\n");
-			goto err_out;
-		}
-		prog_fd = bpf_program__fd(ingress_prog);
-		egress_prog_fd = bpf_program__fd(egress_prog);
-		if (prog_fd < 0 || egress_prog_fd < 0) {
-			printf("find egress_prog fd failed\n");
-			goto err_out;
-		}
-	}
-
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
-
-	/* Init forward multicast groups and exclude group */
-	for (i = 0; ifaces[i] > 0; i++) {
-		ifindex = ifaces[i];
-
-		if (attach_egress_prog) {
-			ret = get_mac_addr(ifindex, mac_addr);
-			if (ret < 0) {
-				printf("get interface %d mac failed\n", ifindex);
-				goto err_out;
-			}
-			ret = bpf_map_update_elem(mac_map, &ifindex, mac_addr, 0);
-			if (ret) {
-				perror("bpf_update_elem mac_map failed\n");
-				goto err_out;
-			}
-		}
-
-		/* Add all the interfaces to group all */
-		devmap_val.ifindex = ifindex;
-		devmap_val.bpf_prog.fd = egress_prog_fd;
-		ret = bpf_map_update_elem(group_all, &ifindex, &devmap_val, 0);
-		if (ret) {
-			perror("bpf_map_update_elem");
-			goto err_out;
-		}
-
-		/* bind prog_fd to each interface */
-		ret = bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL);
-		if (ret) {
-			printf("Set xdp fd failed on %d\n", ifindex);
-			goto err_out;
-		}
-	}
-
-	/* sleep some time for testing */
-	sleep(999);
-
-	return 0;
-
-err_out:
-	return 1;
-}

-- 
2.48.1


