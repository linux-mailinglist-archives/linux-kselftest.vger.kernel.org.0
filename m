Return-Path: <linux-kselftest+bounces-43384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B1BE9353
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3818567AC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06033506B;
	Fri, 17 Oct 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W1c6y7AT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F5330334
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711380; cv=none; b=hUKMVodyQwjqeay6X1OnWyh1Z3CzDuQlfInxo+QtEkXZ84m+0YEKzQSm1XG4MwOonm6pR3YayuZ1EyAuk3oyfTGgjkitoa+7Pdv6myyCKe5yoHlXlvHAuoIbboPqy1ZKW2wXGdObc9aTnC0Aqxc1O6bmIujDwntg3lmghfsbgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711380; c=relaxed/simple;
	bh=yZNrXnuhvIGexvS5EGtRmXZuWyasmi5dAGGIa6BXW/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+0YUVUhxchtQEIPqY3Ad8FZS9rjzpcG62pZ9Yi3hp7ON6WnWG6zAjaDyYhA62MHhXyi6qXpDrMHfoE78UthkyQDmMFE24P0ep6Za4iD76BJSXd+uZZsmf7KQtvBb7ljClTXWBaWVqZ0kcvyjs9nQMmI+JmA85uZCxiHk7G80GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W1c6y7AT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6038E1A1486;
	Fri, 17 Oct 2025 14:29:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36216606DB;
	Fri, 17 Oct 2025 14:29:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA00F102F235B;
	Fri, 17 Oct 2025 16:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760711374; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ftwr4rofYyoL8+AUwR6byHdRTkmIIk8XU5ISZhyl4tY=;
	b=W1c6y7ATJNfplWdJkqEl95dU5sW2k/j7c+64+Iv9fTWyflLN49SVep/zUXWFRQgmgbku0g
	joHUjJwY3b7lOB2ZO5tWs3RCvqeBnl0u4pcLLBswRgLDeXodADOu3JN4cmhIDrgIjop/KI
	Zko2VhkItX977cyo5mrrOa3aLdb7nUB/gDrPctHbXMhvZPeeVQtBCdX/yCzhkDkYSz45tG
	BU3EMY3DujpHjPk/GP/I3umhIvuOvb//ODFwRMvHFPIow/cgJbxl9x5VayqbRw+MYxtj0f
	q1kWiG2FAa5BP7Msw/cFxz1rN7XDRtu6pzOUUIIidT6Y+Se20cwFjRsImsrleQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 17 Oct 2025 16:29:05 +0200
Subject: [PATCH bpf-next 5/5] selftests/bpf: remove test_tc_tunnel.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-tc_tunnel-v1-5-2d86808d86b2@bootlin.com>
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
In-Reply-To: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Now that test_tc_tunnel.sh scope has been ported to the test_progs
framework, remove it.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 -
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 320 --------------------------
 2 files changed, 321 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2f248dab922f57e2c14053cb0bdfbb547efe1292..58c768d9da575d8bb9274d3287123eb214a8d14d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -104,7 +104,6 @@ TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_lirc_mode2.sh \
-	test_tc_tunnel.sh \
 	test_tc_edt.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
deleted file mode 100755
index cb55a908bb0d70c251bc55c9c8994fc023d44f64..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ /dev/null
@@ -1,320 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# In-place tunneling
-
-BPF_FILE="test_tc_tunnel.bpf.o"
-# must match the port that the bpf program filters on
-readonly port=8000
-
-readonly ns_prefix="ns-$$-"
-readonly ns1="${ns_prefix}1"
-readonly ns2="${ns_prefix}2"
-
-readonly ns1_v4=192.168.1.1
-readonly ns2_v4=192.168.1.2
-readonly ns1_v6=fd::1
-readonly ns2_v6=fd::2
-
-# Must match port used by bpf program
-readonly udpport=5555
-# MPLSoverUDP
-readonly mplsudpport=6635
-readonly mplsproto=137
-
-readonly infile="$(mktemp)"
-readonly outfile="$(mktemp)"
-
-setup() {
-	ip netns add "${ns1}"
-	ip netns add "${ns2}"
-
-	ip link add dev veth1 mtu 1500 netns "${ns1}" type veth \
-	      peer name veth2 mtu 1500 netns "${ns2}"
-
-	ip netns exec "${ns1}" ethtool -K veth1 tso off
-
-	ip -netns "${ns1}" link set veth1 up
-	ip -netns "${ns2}" link set veth2 up
-
-	ip -netns "${ns1}" -4 addr add "${ns1_v4}/24" dev veth1
-	ip -netns "${ns2}" -4 addr add "${ns2_v4}/24" dev veth2
-	ip -netns "${ns1}" -6 addr add "${ns1_v6}/64" dev veth1 nodad
-	ip -netns "${ns2}" -6 addr add "${ns2_v6}/64" dev veth2 nodad
-
-	# clamp route to reserve room for tunnel headers
-	ip -netns "${ns1}" -4 route flush table main
-	ip -netns "${ns1}" -6 route flush table main
-	ip -netns "${ns1}" -4 route add "${ns2_v4}" mtu 1450 dev veth1
-	ip -netns "${ns1}" -6 route add "${ns2_v6}" mtu 1430 dev veth1
-
-	sleep 1
-
-	dd if=/dev/urandom of="${infile}" bs="${datalen}" count=1 status=none
-}
-
-cleanup() {
-	ip netns del "${ns2}"
-	ip netns del "${ns1}"
-
-	if [[ -f "${outfile}" ]]; then
-		rm "${outfile}"
-	fi
-	if [[ -f "${infile}" ]]; then
-		rm "${infile}"
-	fi
-
-	if [[ -n $server_pid ]]; then
-		kill $server_pid 2> /dev/null
-	fi
-}
-
-server_listen() {
-	ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
-	server_pid=$!
-}
-
-client_connect() {
-	ip netns exec "${ns1}" timeout 2 nc "${netcat_opt}" -w 1 "${addr2}" "${port}" < "${infile}"
-	echo $?
-}
-
-verify_data() {
-	wait "${server_pid}"
-	server_pid=
-	# sha1sum returns two fields [sha1] [filepath]
-	# convert to bash array and access first elem
-	insum=($(sha1sum ${infile}))
-	outsum=($(sha1sum ${outfile}))
-	if [[ "${insum[0]}" != "${outsum[0]}" ]]; then
-		echo "data mismatch"
-		exit 1
-	fi
-}
-
-wait_for_port() {
-	for i in $(seq 20); do
-		if ip netns exec "${ns2}" ss ${2:--4}OHntl | grep -q "$1"; then
-			return 0
-		fi
-		sleep 0.1
-	done
-	return 1
-}
-
-set -e
-
-# no arguments: automated test, run all
-if [[ "$#" -eq "0" ]]; then
-	echo "ipip"
-	$0 ipv4 ipip none 100
-
-	echo "ipip6"
-	$0 ipv4 ipip6 none 100
-
-	echo "ip6ip6"
-	$0 ipv6 ip6tnl none 100
-
-	echo "sit"
-	$0 ipv6 sit none 100
-
-	echo "ip4 vxlan"
-	$0 ipv4 vxlan eth 2000
-
-	echo "ip6 vxlan"
-	$0 ipv6 ip6vxlan eth 2000
-
-	for mac in none mpls eth ; do
-		echo "ip gre $mac"
-		$0 ipv4 gre $mac 100
-
-		echo "ip6 gre $mac"
-		$0 ipv6 ip6gre $mac 100
-
-		echo "ip gre $mac gso"
-		$0 ipv4 gre $mac 2000
-
-		echo "ip6 gre $mac gso"
-		$0 ipv6 ip6gre $mac 2000
-
-		echo "ip udp $mac"
-		$0 ipv4 udp $mac 100
-
-		echo "ip6 udp $mac"
-		$0 ipv6 ip6udp $mac 100
-
-		echo "ip udp $mac gso"
-		$0 ipv4 udp $mac 2000
-
-		echo "ip6 udp $mac gso"
-		$0 ipv6 ip6udp $mac 2000
-	done
-
-	echo "OK. All tests passed"
-	exit 0
-fi
-
-if [[ "$#" -ne "4" ]]; then
-	echo "Usage: $0"
-	echo "   or: $0 <ipv4|ipv6> <tuntype> <none|mpls|eth> <data_len>"
-	exit 1
-fi
-
-case "$1" in
-"ipv4")
-	readonly addr1="${ns1_v4}"
-	readonly addr2="${ns2_v4}"
-	readonly ipproto=4
-	readonly netcat_opt=-${ipproto}
-	readonly foumod=fou
-	readonly foutype=ipip
-	readonly fouproto=4
-	readonly fouproto_mpls=${mplsproto}
-	readonly gretaptype=gretap
-	;;
-"ipv6")
-	readonly addr1="${ns1_v6}"
-	readonly addr2="${ns2_v6}"
-	readonly ipproto=6
-	readonly netcat_opt=-${ipproto}
-	readonly foumod=fou6
-	readonly foutype=ip6tnl
-	readonly fouproto="41 -6"
-	readonly fouproto_mpls="${mplsproto} -6"
-	readonly gretaptype=ip6gretap
-	;;
-*)
-	echo "unknown arg: $1"
-	exit 1
-	;;
-esac
-
-readonly tuntype=$2
-readonly mac=$3
-readonly datalen=$4
-
-echo "encap ${addr1} to ${addr2}, type ${tuntype}, mac ${mac} len ${datalen}"
-
-trap cleanup EXIT
-
-setup
-
-# basic communication works
-echo "test basic connectivity"
-server_listen
-wait_for_port ${port} ${netcat_opt}
-client_connect
-verify_data
-
-# clientside, insert bpf program to encap all TCP to port ${port}
-# client can no longer connect
-ip netns exec "${ns1}" tc qdisc add dev veth1 clsact
-ip netns exec "${ns1}" tc filter add dev veth1 egress \
-	bpf direct-action object-file ${BPF_FILE} \
-	section "encap_${tuntype}_${mac}"
-echo "test bpf encap without decap (expect failure)"
-server_listen
-wait_for_port ${port} ${netcat_opt}
-! client_connect
-
-if [[ "$tuntype" =~ "udp" ]]; then
-	# Set up fou tunnel.
-	ttype="${foutype}"
-	targs="encap fou encap-sport auto encap-dport $udpport"
-	# fou may be a module; allow this to fail.
-	modprobe "${foumod}" ||true
-	if [[ "$mac" == "mpls" ]]; then
-		dport=${mplsudpport}
-		dproto=${fouproto_mpls}
-		tmode="mode any ttl 255"
-	else
-		dport=${udpport}
-		dproto=${fouproto}
-	fi
-	ip netns exec "${ns2}" ip fou add port $dport ipproto ${dproto}
-	targs="encap fou encap-sport auto encap-dport $dport"
-elif [[ "$tuntype" =~ "gre" && "$mac" == "eth" ]]; then
-	ttype=$gretaptype
-elif [[ "$tuntype" =~ "vxlan" && "$mac" == "eth" ]]; then
-	ttype="vxlan"
-	targs="id 1 dstport 8472 udp6zerocsumrx"
-elif [[ "$tuntype" == "ipip6" ]]; then
-	ttype="ip6tnl"
-	targs=""
-else
-	ttype=$tuntype
-	targs=""
-fi
-
-# tunnel address family differs from inner for SIT
-if [[ "${tuntype}" == "sit" ]]; then
-	link_addr1="${ns1_v4}"
-	link_addr2="${ns2_v4}"
-elif [[ "${tuntype}" == "ipip6" ]]; then
-	link_addr1="${ns1_v6}"
-	link_addr2="${ns2_v6}"
-else
-	link_addr1="${addr1}"
-	link_addr2="${addr2}"
-fi
-
-# serverside, insert decap module
-# server is still running
-# client can connect again
-ip netns exec "${ns2}" ip link add name testtun0 type "${ttype}" \
-	${tmode} remote "${link_addr1}" local "${link_addr2}" $targs
-
-expect_tun_fail=0
-
-if [[ "$tuntype" == "ip6udp" && "$mac" == "mpls" ]]; then
-	# No support for MPLS IPv6 fou tunnel; expect failure.
-	expect_tun_fail=1
-elif [[ "$tuntype" =~ "udp" && "$mac" == "eth" ]]; then
-	# No support for TEB fou tunnel; expect failure.
-	expect_tun_fail=1
-elif [[ "$tuntype" =~ (gre|vxlan) && "$mac" == "eth" ]]; then
-	# Share ethernet address between tunnel/veth2 so L2 decap works.
-	ethaddr=$(ip netns exec "${ns2}" ip link show veth2 | \
-		  awk '/ether/ { print $2 }')
-	ip netns exec "${ns2}" ip link set testtun0 address $ethaddr
-elif [[ "$mac" == "mpls" ]]; then
-	modprobe mpls_iptunnel ||true
-	modprobe mpls_gso ||true
-	ip netns exec "${ns2}" sysctl -qw net.mpls.platform_labels=65536
-	ip netns exec "${ns2}" ip -f mpls route add 1000 dev lo
-	ip netns exec "${ns2}" ip link set lo up
-	ip netns exec "${ns2}" sysctl -qw net.mpls.conf.testtun0.input=1
-	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.lo.rp_filter=0
-fi
-
-# Because packets are decapped by the tunnel they arrive on testtun0 from
-# the IP stack perspective.  Ensure reverse path filtering is disabled
-# otherwise we drop the TCP SYN as arriving on testtun0 instead of the
-# expected veth2 (veth2 is where 192.168.1.2 is configured).
-ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
-# rp needs to be disabled for both all and testtun0 as the rp value is
-# selected as the max of the "all" and device-specific values.
-ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.testtun0.rp_filter=0
-ip netns exec "${ns2}" ip link set dev testtun0 up
-if [[ "$expect_tun_fail" == 1 ]]; then
-	# This tunnel mode is not supported, so we expect failure.
-	echo "test bpf encap with tunnel device decap (expect failure)"
-	! client_connect
-else
-	echo "test bpf encap with tunnel device decap"
-	client_connect
-	verify_data
-	server_listen
-	wait_for_port ${port} ${netcat_opt}
-fi
-
-# serverside, use BPF for decap
-ip netns exec "${ns2}" ip link del dev testtun0
-ip netns exec "${ns2}" tc qdisc add dev veth2 clsact
-ip netns exec "${ns2}" tc filter add dev veth2 ingress \
-	bpf direct-action object-file ${BPF_FILE} section decap
-echo "test bpf encap with bpf decap"
-client_connect
-verify_data
-
-echo OK

-- 
2.51.0


