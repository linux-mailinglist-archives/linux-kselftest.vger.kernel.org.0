Return-Path: <linux-kselftest+bounces-9483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A78BC2F0
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 19:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B615B20EBF
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECB5A788;
	Sun,  5 May 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Xk3rrHUk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196075A0F9;
	Sun,  5 May 2024 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714931938; cv=none; b=RgN+TeqTMFnZ+ixAPwFxvf3MSJ2TwN2LwlA8aVMADQiyQ2DZWp/6oeil7DyVBHYdhiNJa8V98S59cKKn8r0I4gBP8vxwTqX+F9hae0/+Q5h4MLefq9FxcQs15OxXQG9hrZRc/9URW38cI6pN4KB63iwHkT+543tvfD4KXJSgOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714931938; c=relaxed/simple;
	bh=nTkSX1WXhY8O4RpvStwXh2qm8eE+jpQjZBXT3XXkrxg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffJ7zglO5NTfmlx4SJcKseaFIdCiAebSkAzXWzTo2Ww8h9xrakpDH7dSRRnTWeJashrg1N48gvUdSOkBrPMVTKOFn7Dg17HQRIxUHq1bJMyJ4V8wIL+SyP5R72t/14Y2UNE5GdCRLk/erPxzbLzjQjdoDy21BsFXM2cb0ICoV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Xk3rrHUk; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5E6982074B;
	Sun,  5 May 2024 19:58:54 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWdZYycGoT3a; Sun,  5 May 2024 19:58:53 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1F10920561;
	Sun,  5 May 2024 19:58:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1F10920561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714931933;
	bh=K0CiEQe3orTTxTaD9+cvvRrkFLEZI5N6fmSdwg6r3fA=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=Xk3rrHUkCo6jiZek0bAn8tqM1yvSIumbMJkw7a3ZS8eFroqvnpZdfSP7QnIE2qaet
	 YuVOatRUHWcGJ2pZPe3hlxSGRYE0J7hLHM9bsXiUdASS29NMum24HaziRrU7bgwkQ8
	 oWPTUv3EN2oT81TmPd1qGsoXoW8Kk6CWo4oC9puZdqQUH/J21l9DZTWAuK6duwRfja
	 5O93yK4ElOu2w++GmVhX2Ju9xecAIbJKPuqstGvBYJ5u0u03CeYFfxLFZEOymFpOkn
	 m75p5yh3NewttBWVuHKG4alZSa/ZwUSmuJDVlutG1+ydegKZZSERdloh7GTWMXf5TK
	 BuleuQiisBoIw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 0ACD980004A;
	Sun,  5 May 2024 19:58:53 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 5 May 2024 19:58:52 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 May
 2024 19:58:52 +0200
Date: Sun, 5 May 2024 19:58:46 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, Antony Antony <antony.antony@secunet.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH net-next v2 2/2] selftests/net: add ICMP unreachable over
 IPsec tunnel
Message-ID: <88b1865b1dc5559d49426f595e6d79c0d1386f80.1714931276.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1714931276.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1714931276.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Add IPsec tunnel, aka xfrm state, tests with ICMP flags enabled.
IPv4 and IPv6, unreachable tests over xfrm/IPsec tunnels,
xfrm SA with "flag icmp" set.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/xfrm_state.sh | 624 ++++++++++++++++++++++
 2 files changed, 625 insertions(+)
 create mode 100755 tools/testing/selftests/net/xfrm_state.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5befca249452..7d96b3e411b7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -53,6 +53,7 @@ TEST_PROGS += bind_bhash.sh
 TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
+TEST_PROGS += xfrm_state.sh
 TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
diff --git a/tools/testing/selftests/net/xfrm_state.sh b/tools/testing/selftests/net/xfrm_state.sh
new file mode 100755
index 000000000000..26eac013abcf
--- /dev/null
+++ b/tools/testing/selftests/net/xfrm_state.sh
@@ -0,0 +1,624 @@
+#!/bin/bash -u
+# SPDX-License-Identifier: GPL-2.0
+#
+# Checks for xfrm/ESP/IPsec tunnel.
+# - The unreachable tests are for icmp error handling.
+#   As specified in IETF RFC 4301 section 6.
+#
+# See "test=" below for the implemented tests.
+#
+# Network topology default
+# 10.1.c.d or IPv6 fc00:c::d/64
+#   1.1   1.2   2.1   2.2   3.1   3.2   4.1   4.2   5.1   5.2  6.1  6.2
+#  eth0  eth1  eth0  eth1  eth0  eth1  eth0  eth1  eth0  eth1 eth0  eth1
+# a -------- r1 -------- s1 -------- r2 -------- s2 -------- r3 -------- b
+# a, b = Alice and Bob hosts without IPsec.
+# r1, r2, r3 routers without IPsec
+# s1, s2, IPsec gateways/routers that setup tunnel(s).
+#
+# Network topology: x for IPsec gateway that generate ICMP response.
+# 10.1.c.d or IPv6 fc00:c::d/64
+#   1.1   1.2   2.1   2.2   3.1   3.2   4.1   4.2   5.1   5.2
+#  eth0  eth1  eth0  eth1  eth0  eth1  eth0  eth1  eth0  eth1
+# a -------- r1 -------- s1 -------- r2 -------- s2 -------- b
+#
+
+source lib.sh
+
+PAUSE_ON_FAIL=no
+VERBOSE=${VERBOSE:-0}
+TRACING=0
+
+#               Name                          Description
+tests="
+	unreachable_ipv4		IPv4 unreachable from router r3
+	unreachable_ipv4		IPv6 unreachable from router r3
+	unreachable_gw_ipv4		IPv4 unreachable from IPsec gateway s2
+	unreachable_gw_ipv6		IPv6 unreachable from IPsec gateway s2
+	mtu_ipv4_r2			IPv4 MTU exceeded from ESP router r2
+	mtu_ipv6_r2			IPv6 MTU exceeded from ESP router r2
+	mtu_ipv4_r3			IPv4 MTU exceeded router r3
+	mtu_ipv6_r3			IPv6 MTU exceeded router r3"
+
+ns_set="a r1 s1 r2 s2 r3 b" # Network topology default
+imax=7 # number of namespaces in the test
+
+prefix4="10.1"
+prefix6="fc00"
+
+run_cmd() {
+	cmd="$*"
+
+	if [ "$VERBOSE" -gt 0 ]; then
+		printf "    COMMAND: $cmd\n"
+	fi
+
+	out="$($cmd 2>&1)"
+	rc=$?
+	if [ "$VERBOSE" -gt 1 -a -n "$out" ]; then
+		echo "    $out"
+		echo
+	fi
+	return $rc
+}
+
+run_test() {
+	(
+	tname="$1"
+	tdesc="$2"
+
+
+	unset IFS
+
+	fail="yes"
+
+	# Since cleanup() relies on variables modified by this sub shell, it
+	# has to run in this context.
+	trap cleanup EXIT
+
+	if [ "$VERBOSE" -gt 0 ]; then
+		printf "\n#####################################################################\n\n"
+	fi
+
+	# if errexit was not set, set it and unset after test eval
+	errexit=0
+	if [[ $- =~ "e" ]]; then
+		errexit=1
+	else
+		set -e
+	fi
+
+	eval test_${tname}
+	ret=$?
+	fail="no"
+	[ $errexit -eq 0 ] && set +e # hack until exception is fixed
+
+	if [ $ret -eq 0 ]; then
+		printf "TEST: %-60s [ PASS ]\n" "${tdesc}"
+	elif [ $ret -eq 1 ]; then
+		printf "TEST: %-60s [FAIL]\n" "${tdesc}"
+		if [ "$VERBOSE" -eq 0 -o -n "${out}" -o -n "${out}" ]; then
+			echo "#####################################################################"
+			[ -n "${cmd}" ] && echo -e "${cmd}"
+			[ -n "${out}" ] && echo -e "${out}"
+			echo "#####################################################################"
+		fi
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+			echo
+			echo "Pausing. Hit enter to continue"
+			read a
+		fi
+		err_flush
+		exit 1
+	elif [ $ret -eq $ksft_skip ]; then
+		printf "TEST: %-60s [SKIP]\n" "${tdesc}"
+		err_flush
+	fi
+
+	return $ret
+	)
+	ret=$?
+	case $ret in
+		0)
+			all_skipped=false
+			[ $exitcode -eq $ksft_skip ] && exitcode=0
+		;;
+		$ksft_skip)
+			[ $all_skipped = true ] && exitcode=$ksft_skip
+		;;
+		*)
+			all_skipped=false
+			exitcode=1
+		;;
+	esac
+
+	return $ret
+}
+
+# Find the auto-generated name for this namespace
+nsname() {
+	eval echo ns_$1
+}
+
+nscmd() {
+	eval echo "ip netns exec $1"
+}
+
+setup_namespace() {
+	setup_ns NS_A
+	ns_a="ip netns exec ${NS_A}"
+}
+
+setup_namespaces() {
+	local namespaces="";
+
+	NS_R1=""
+	NS_R2=""
+	NS_R3=""
+	for ns in ${ns_set}; do
+		n=$(nsname ${ns})
+		n=$(echo $n | tr '[:lower:]' '[:upper:]')
+		namespaces="$namespaces ${n}"
+	done
+
+	setup_ns $namespaces
+
+	ns_active= #ordered list of namespaces for this test.
+
+	[ -n NS_A ] && ns_a="ip netns exec ${NS_A}" && ns_active="${ns_active} $NS_A"
+	[ -n NS_R1 ] && ns_r1="ip netns exec ${NS_R1}" && ns_active="${ns_active} $NS_R1"
+	[ -n NS_S1 ] && ns_s1="ip netns exec ${NS_S1}" && ns_active="${ns_active} $NS_S1"
+	[ -n NS_R2 ] && ns_r2="ip netns exec ${NS_R2}" && ns_active="${ns_active} $NS_R2"
+	[ -n NS_S2 ] && ns_s2="ip netns exec ${NS_S2}" && ns_active="${ns_active} $NS_S2"
+	[ -n NS_R3 ] && ns_r3="ip netns exec ${NS_R3}" && ns_active="${ns_active} $NS_R3"
+	[ -n NS_B ] && ns_b="ip netns exec ${NS_B}" && ns_active="${ns_active} $NS_B"
+}
+
+setup_addr_add() {
+	local ns_cmd=$(nscmd $1)
+	local ip0="$2"
+	local ip1="$3"
+
+	if [ -n "${ip0}" ]; then
+		run_cmd ${ns_cmd} ip addr add ${ip0} dev eth0
+		run_cmd ${ns_cmd} ip link set up eth0
+	fi
+	if [ -n "${ip1}" ]; then
+		run_cmd ${ns_cmd} ip addr add ${ip1} dev eth1
+		run_cmd ${ns_cmd} ip link set up eth1
+	fi
+	run_cmd ${ns_cmd} sysctl -q net/ipv4/ip_forward=1
+	run_cmd ${ns_cmd} sysctl -q net/ipv6/conf/all/forwarding=1
+
+	# Disable DAD, so that we don't have to wait to use the
+	# configured IPv6 addresses
+	run_cmd ${ns_cmd} sysctl -q net/ipv6/conf/default/accept_dad=0
+}
+
+route_add() {
+	local ns_cmd=$(nscmd $1)
+	local nhf=$2
+	local nhr=$3
+	local i=$4
+
+	if [ -n "${nhf}" ]; then
+		# add forward routes
+		for j in $(seq $((i + 1)) $imax); do
+			local route="${prefix}${s}${j}${S}0/${prefix_len}"
+			run_cmd ${ns_cmd} ip route replace "${route} via ${nhf}"
+		done
+	fi
+
+	if [ -n "${nhr}" ]; then
+		# add reverse routes
+		for j in $(seq 1 $((i - 2))); do
+			local route="${prefix}${s}${j}${S}0/${prefix_len}"
+			run_cmd ${ns_cmd} ip route replace "${route} via ${nhr}"
+		done
+	fi
+}
+
+veth_add() {
+	local ns_cmd=$(nscmd $1)
+	local tn="veth${2}1"
+	local ln=${3:-eth0}
+	run_cmd ${ns_cmd} ip link add ${ln} type veth peer name ${tn}
+}
+
+setup_nft_add_icmp_filter() {
+	local ns_cmd=${ns_r2}
+
+	run_cmd ${ns_cmd} nft add table inet filter
+	run_cmd ${ns_cmd} nft add chain inet filter FORWARD \
+		{ type filter hook forward priority filter\; policy drop \; }
+	run_cmd ${ns_cmd} nft add rule inet filter FORWARD counter ip protocol \
+		icmp counter log drop
+	run_cmd ${ns_cmd} nft add rule inet filter FORWARD counter ip protocol esp \
+		counter log accept
+}
+
+setup_nft_add_icmpv6_filter() {
+	local ns_cmd=${ns_r2}
+
+	run_cmd ${ns_cmd} nft add table inet filter
+	run_cmd ${ns_cmd} nft add chain inet filter FORWARD { type filter \
+		hook forward priority filter\; policy drop \; }
+	run_cmd ${ns_cmd} nft add rule inet filter FORWARD ip6 nexthdr \
+		ipv6-icmp icmpv6 type echo-request counter log drop
+	run_cmd ${ns_cmd} nft add rule inet filter FORWARD ip6 nexthdr esp \
+		counter log accept
+	run_cmd ${ns_cmd} nft add rule inet filter FORWARD ip6 nexthdr \
+		ipv6-icmp icmpv6 type {nd-neighbor-solicit,nd-neighbor-advert,\
+		nd-router-solicit,nd-router-advert} counter log accept
+}
+
+veth_mv() {
+	local ns=$1
+	local nsp=$2
+	local rn=${4:-eth1}
+	local tn="veth${3}1"
+
+	run_cmd "$(nscmd ${nsp})" ip link set ${tn} netns ${ns}
+	run_cmd "$(nscmd ${ns})" ip link set ${tn} name ${rn}
+}
+
+vm_set() {
+	s1_src=${src}
+	s1_dst=${dst}
+	s1_src_net=${src_net}
+	s1_dst_net=${dst_net}
+}
+
+setup_vm_set_v4() {
+	src="10.1.3.1"
+	dst="10.1.4.2"
+	src_net="10.1.1.0/24"
+	dst_net="10.1.6.0/24"
+
+	prefix=${prefix4}
+	prefix_len=24
+	s="."
+	S="."
+
+	vm_set
+}
+
+setup_vm_set_v4x() {
+	ns_set="a r1 s1 r2 s2 b" # Network topology: x
+	imax=6
+	prefix=${prefix4}
+	s="."
+	S="."
+	src="10.1.3.1"
+	dst="10.1.4.2"
+	src_net="10.1.1.0/24"
+	dst_net="10.1.5.0/24"
+	prefix_len=24
+
+	vm_set
+}
+
+setup_vm_set_v6() {
+	imax=7
+	prefix=${prefix6}
+	s=":"
+	S="::"
+	src="fc00:3::1"
+	dst="fc00:4::2"
+	src_net="fc00:1::0/64"
+	dst_net="fc00:6::0/64"
+	prefix_len=64
+
+	vm_set
+}
+
+setup_vm_set_v6x() {
+	ns_set="a r1 s1 r2 s2 b" # Network topology: x
+	imax=6
+	prefix=${prefix6}
+	s=":"
+	S="::"
+	src="fc00:3::1"
+	dst="fc00:4::2"
+	src_net="fc00:1::0/64"
+	dst_net="fc00:5::0/64"
+	prefix_len=64
+
+	vm_set
+}
+
+setup_veths() {
+	i=1
+	for ns in ${ns_active}; do
+		[ ${i} = ${imax} ] && continue
+		veth_add ${ns} ${i}
+		i=$((i + 1))
+	done
+
+	j=1
+	for ns in ${ns_active}; do
+		if [ ${j} -eq 1 ]; then
+			p=${ns};
+			pj=${j}
+			j=$((j + 1))
+			continue
+		fi
+		veth_mv ${ns} "${p}" ${pj}
+		p=${ns}
+		pj=${j}
+		j=$((j + 1))
+	done
+}
+
+setup_routes() {
+	ip1=""
+	i=1
+	for ns in ${ns_active}; do
+		# 10.1.C.1/24
+		ip0="${prefix}${s}${i}${S}1/${prefix_len}"
+		[ "${ns}" = b ] && ip0=""
+		setup_addr_add ${ns} "${ip0}" "${ip1}"
+		# 10.1.C.2/24
+		ip1="${prefix}${s}${i}${S}2/${prefix_len}"
+		i=$((i + 1))
+	done
+
+	i=1
+	nhr=""
+	for ns in ${ns_active}; do
+		nhf="${prefix}${s}${i}${S}2"
+		[ "${ns}" = b ] && nhf=""
+		route_add ${ns} "${nhf}" "${nhr}" ${i}
+		nhr="${prefix}${s}${i}${S}1"
+		i=$((i + 1))
+	done
+}
+
+setup_xfrm() {
+
+	run_cmd ${ns_s1} ip xfrm policy add src ${s1_src_net} dst ${s1_dst_net} dir out \
+		tmpl src ${s1_src} dst ${s1_dst} proto esp reqid 1 mode tunnel
+
+	# no "input" policies. we are only doing forwarding.
+	# run_cmd ${ns_s1} ip xfrm policy add src ${s1_dst_net} dst ${s1_src_net} dir in \
+	#	flag icmp tmpl src ${s1_dst} dst ${s1_src} proto esp reqid 2 mode tunnel
+
+	run_cmd ${ns_s1} ip xfrm policy add src ${s1_dst_net} dst ${s1_src_net} dir fwd \
+		flag icmp tmpl src ${s1_dst} dst ${s1_src} proto esp reqid 2 mode tunnel
+
+	run_cmd ${ns_s1} ip xfrm state add src ${s1_src} dst ${s1_dst} proto esp spi 1 \
+		reqid 1 mode tunnel aead 'rfc4106(gcm(aes))' \
+		0x1111111111111111111111111111111111111111 96 \
+		sel src ${s1_src_net} dst ${s1_dst_net}
+
+	run_cmd ${ns_s1} ip xfrm state add src ${s1_dst} dst ${s1_src} proto esp spi 2 \
+		reqid 2 flag icmp replay-window 8 mode tunnel aead 'rfc4106(gcm(aes))' \
+		0x2222222222222222222222222222222222222222 96 \
+		sel src ${s1_dst_net} dst ${s1_src_net}
+
+	run_cmd ${ns_s2} ip xfrm policy add src ${s1_dst_net} dst ${s1_src_net} dir out \
+		flag icmp tmpl src ${s1_dst} dst ${s1_src} proto esp reqid 2 mode tunnel
+
+	run_cmd ${ns_s2} ip xfrm policy add src ${s1_src_net} dst ${s1_dst_net} dir fwd \
+		tmpl src ${s1_src} dst ${s1_dst} proto esp reqid 1 mode tunnel
+
+	run_cmd ${ns_s2} ip xfrm state add src ${s1_dst} dst ${s1_src} proto esp spi 2 \
+		reqid 2 mode tunnel aead 'rfc4106(gcm(aes))' \
+		0x2222222222222222222222222222222222222222 96 \
+		sel src ${s1_dst_net} dst ${s1_src_net}
+
+	run_cmd ${ns_s2} ip xfrm state add src ${s1_src} dst ${s1_dst} proto esp spi 1 \
+		reqid 1 flag icmp replay-window 8 mode tunnel aead 'rfc4106(gcm(aes))' \
+		0x1111111111111111111111111111111111111111 96 \
+		sel src ${s1_src_net} dst ${s1_dst_net}
+}
+
+setup() {
+	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
+
+	for arg do
+		eval setup_${arg} || { echo "  ${arg} not supported"; return 1; }
+	done
+}
+
+trace() {
+	[ $TRACING -eq 0 ] && return
+
+	for arg do
+		[ "${ns_cmd}" = "" ] && ns_cmd="${arg}" && continue
+		ns_cmd=
+	done
+	sleep 1
+}
+
+cleanup() {
+	if [ "${fail}" = "yes" -a -n "${desc}" ]; then
+		printf "TEST: %-60s [ FAIL ]\n" "${desc}"
+		[ -n "${cmd}" ] && echo -e "${cmd}\n"
+		[ -n "${out}" ] && echo -e "${out}\n"
+	fi
+
+	cleanup_all_ns
+}
+
+mtu() {
+	ns_cmd="${1}"
+	dev="${2}"
+	mtu="${3}"
+
+	${ns_cmd} ip link set dev ${dev} mtu ${mtu}
+}
+
+mtu_parse() {
+	input="${1}"
+
+	next=0
+	for i in ${input}; do
+		[ ${next} -eq 1 -a "${i}" = "lock" ] && next=2 && continue
+		[ ${next} -eq 1 ] && echo "${i}" && return
+		[ ${next} -eq 2 ] && echo "lock ${i}" && return
+		[ "${i}" = "mtu" ] && next=1
+	done
+}
+
+link_get() {
+	ns_cmd="${1}"
+	name="${2}"
+
+	${ns_cmd} ip link show dev "${name}"
+}
+
+link_get_mtu() {
+	ns_cmd="${1}"
+	name="${2}"
+
+	mtu_parse "$(link_get "${ns_cmd}" ${name})"
+}
+
+test_unreachable_ipv6() {
+	setup vm_set_v6 namespaces veths routes xfrm nft_add_icmpv6_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 fc00:6::2
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 fc00:6::3 || true
+	rc=0
+	echo -e "$out" | grep -q -E 'From fc00:5::2 icmp_seq.* Destination' || rc=1
+	return ${rc}
+}
+
+test_unreachable_gw_ipv6() {
+	setup vm_set_v6x namespaces veths routes xfrm nft_add_icmpv6_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 fc00:5::2
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 fc00:5::3 || true
+	rc=0
+	echo -e "$out" | grep -q -E 'From fc00:4::2 icmp_seq.* Destination' || rc=1
+	return ${rc}
+}
+
+test_unreachable_gw_ipv4() {
+	setup vm_set_v4x namespaces veths routes xfrm nft_add_icmp_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 10.1.5.2
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 10.1.5.3 || true
+	rc=0
+	echo -e "$out" | grep -q -E 'From 10.1.4.2 icmp_seq.* Destination' || rc=1
+	return ${rc}
+}
+
+test_unreachable_ipv4() {
+	setup vm_set_v4 namespaces veths routes xfrm nft_add_icmp_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 10.1.6.2
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 10.1.6.3 || true
+	rc=0
+	echo -e "$out" | grep -q -E 'From 10.1.5.2 icmp_seq.* Destination' || rc=1
+	return ${rc}
+}
+
+test_mtu_ipv4_r2() {
+	setup vm_set_v4 namespaces veths routes xfrm nft_add_icmp_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 10.1.6.2
+	run_cmd ${ns_r2} ip route replace 10.1.3.0/24 dev eth1 src 10.1.3.2 mtu 1300
+	run_cmd ${ns_r2} ip route replace 10.1.4.0/24 dev eth0 src 10.1.4.1 mtu 1300
+	run_cmd ${ns_a} ping -M do -s 1300 -W 5 -w 4 -c 1 10.1.6.2 || true
+	rc=0
+	# note the error should be s1 not from r2
+	echo -e "$out" | grep -q -E "From 10.1.2.2 icmp_seq=.* Frag needed and DF set" || rc=1
+	return ${rc}
+}
+
+test_mtu_ipv6_r2() {
+	setup vm_set_v6 namespaces veths routes xfrm nft_add_icmpv6_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 fc00:6::2
+	run_cmd ${ns_r2} ip -6 route replace fc00:3::/64 dev eth1 metric 256 src fc00:3::2 mtu 1300
+	run_cmd ${ns_r2} ip -6 route replace fc00:4::/64 dev eth0 metric 256 src fc00:4::1 mtu 1300
+	run_cmd ${ns_a} ping -M do -s 1300 -W 5 -w 4 -c 1 fc00:6::2 || true
+	rc=0
+	# note the error should be s1 not from r2
+	echo -e "$out" | grep -q -E "From fc00:2::2 icmp_seq=.* Packet too big: mtu=1230" || rc=1
+	return ${rc}
+}
+
+test_mtu_ipv4_r3() {
+	setup vm_set_v4 namespaces veths routes xfrm nft_add_icmp_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 10.1.6.2
+	run_cmd ${ns_r3} ip route replace 10.1.6.0/24 dev eth0 src 10.1.6.1 mtu 1300
+	run_cmd ${ns_a} ping -M do -s 1350 -W 5 -w 4 -c 1 10.1.6.2 || true
+	rc=0
+	echo -e "$out" | grep -q -E "From 10.1.5.2 icmp_seq=.* Frag needed and DF set \(mtu = 1300\)" || rc=1
+	return ${rc}
+}
+
+test_mtu_ipv6_r3() {
+	setup vm_set_v6 namespaces veths routes xfrm nft_add_icmpv6_filter || return $ksft_skip
+	run_cmd ${ns_a} ping -W 5 -w 4 -c 1 fc00:6::2
+	run_cmd ${ns_r3} ip -6 route replace fc00:6::/64 dev eth1 metric 256 src fc00:6::1 mtu 1300
+	run_cmd ${ns_a} ping -M do -s 1300 -W 5 -w 4 -c 1 fc00:6::2 || true
+	rc=0
+	# note the error should be s1 not from r2
+	echo -e "$out" | grep -q -E "From fc00:5::2 icmp_seq=.* Packet too big: mtu=1300" || rc=1
+	return ${rc}
+}
+
+################################################################################
+#
+usage() {
+	echo
+	echo "$0 [OPTIONS] [TEST]..."
+	echo "If no TEST argument is given, all tests will be run."
+	echo
+	echo -e "\t-p Pause on fail"
+	echo -e "\t-v Verbose output. Show commands; -vv Show output also"
+	echo "Available tests${tests}"
+	exit 1
+}
+
+################################################################################
+#
+exitcode=0
+desc=0
+all_skipped=true
+out=
+cmd=
+
+while getopts :pv o
+do
+	case $o in
+	p) PAUSE_ON_FAIL=yes;;
+	v) VERBOSE=$(( VERBOSE + 1 ));;
+	*) usage;;
+	esac
+done
+shift $(($OPTIND-1))
+
+IFS="
+"
+
+for arg do
+	# Check first that all requested tests are available before running any
+	command -v > /dev/null "test_${arg}" || { echo "=== Test ${arg} not found"; usage; }
+done
+
+trap cleanup EXIT
+
+name=""
+desc=""
+fail="no"
+
+# end cleanup
+cleanup
+
+for t in ${tests}; do
+	[ "${name}" = "" ] && name="${t}" && continue
+	[ "${desc}" = "" ] && desc="${t}"
+
+	run_this=1
+	for arg do
+		[ "${arg}" != "${arg#--*}" ] && continue
+		[ "${arg}" = "${name}" ] && run_this=1 && break
+		run_this=0
+	done
+	if [ $run_this -eq 1 ]; then
+		run_test "${name}" "${desc}"
+	fi
+	name=""
+	desc=""
+done
+
+exit ${exitcode}
--
2.30.2


