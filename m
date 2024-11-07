Return-Path: <linux-kselftest+bounces-21596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5989C0147
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 10:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5A5283AA3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074201E2301;
	Thu,  7 Nov 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="PHNBdwDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from qs51p00im-qukt01071501.me.com (qs51p00im-qukt01071501.me.com [17.57.155.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799681E1337
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972245; cv=none; b=tKor64toa2SH+FlxLyn81a55MHzaTDzTeVHq3ikJgQYiY/8as/7/kEeu+I998andK3YLrMpixv+Rzk84knVnnitqasT4eDkVR7jXjb/KKGgnPRgkL4ijuAom7lwHL48SysH5GZXALES5qDbc8elo4rQpwYiUT4rZzQDCeYOQQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972245; c=relaxed/simple;
	bh=qchMyWJJ/n2J0XEnAiTkkFhzNY5B3jJjIsItb63FfPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/qGlYoWYMYt/GE85QUHHMmT0RsDGgqwQ3DOUdFzAmBKaxbUpN/3RXTw7LLnJFOYBBMErfTlhfFnKQOaVKJvAIn3o3vZn3CNQKGQNrApqtb9APfgkiNhVjVvjgMxHCM+RQYcMhKSIv+rZwJ/2JpXBuW2w6Uio0Im6MmKpTkFdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=PHNBdwDQ; arc=none smtp.client-ip=17.57.155.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730972241; bh=DfttAdFNUDiAEe4taQl+Y8CHRRhdLgIuz3ER5p7pWOc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=PHNBdwDQfY5rESjsKrLZyAkaOTdW+6NgZrGHEpW1WM8nlaksk/HByIfEBwia3Ck0R
	 4NA+N5+UAIIp4UDlzUd8xXdLG5tBR+33hFI2DFNVgW3D0qQny1+37jm7zWeOPKNbwq
	 jotCcZchJiuq4xVG22H79popGe/eSBbKiOGISrRw95i57qrUFKtFFvi+C/aor1g1MH
	 pyvheV5Xatpn/0IEx3b7uiSN7RWBm6SLVvsAuOvlXK2B9VivEaNrpl5U/VgT1e0xXb
	 mo5VWTSdOLstoqECENmbtazBuDIAPOr1AKlXBdi18T4IZzWcEAZbblbh+K7QxKDIz5
	 IoA09sPXxKXgw==
Received: from almalinux-std3-4-4-10gb.novalocal (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071501.me.com (Postfix) with ESMTPSA id 4AF051C402AB;
	Thu,  7 Nov 2024 09:36:41 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: netdev@vger.kernel.org,
	dsahern@kernel.org,
	davem@davemloft.net,
	idosch@idosch.org
Cc: Vladimir Vdovin <deliran@verdict.gg>,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	gnault@redhat.com
Subject: [PATCH net-next v9] net: ipv4: Cache pmtu for all packet paths if multipath enabled
Date: Thu,  7 Nov 2024 09:36:24 +0000
Message-ID: <20241107093629.311800-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4iaRtNC6FdUsl-Dno7Iln4Y_LLgvG8Uv
X-Proofpoint-ORIG-GUID: 4iaRtNC6FdUsl-Dno7Iln4Y_LLgvG8Uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_20,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 clxscore=1030 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411070074

Check number of paths by fib_info_num_path(),
and update_or_create_fnhe() for every path.
Problem is that pmtu is cached only for the oif
that has received icmp message "need to frag",
other oifs will still try to use "default" iface mtu.

An example topology showing the problem:

                    |  host1
                +---------+
                |  dummy0 | 10.179.20.18/32  mtu9000
                +---------+
        +-----------+----------------+
    +---------+                     +---------+
    | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
    +---------+                     +---------+
        |    (all here have mtu 9000)    |
    +------+                         +------+
    | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
    +------+                         +------+
        |                                |
---------+------------+-------------------+------
                        |
                    +-----+
                    | ro3 | 10.10.10.10  mtu1500
                    +-----+
                        |
    ========================================
                some networks
    ========================================
                        |
                    +-----+
                    | eth0| 10.10.30.30  mtu9000
                    +-----+
                        |  host2

host1 have enabled multipath and
sysctl net.ipv4.fib_multipath_hash_policy = 1:

default proto static src 10.179.20.18
        nexthop via 10.179.2.12 dev ens17f1 weight 1
        nexthop via 10.179.2.140 dev ens17f0 weight 1

When host1 tries to do pmtud from 10.179.20.18/32 to host2,
host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=1500.
And host1 caches it in nexthop exceptions cache.

Problem is that it is cached only for the iface that has received icmp,
and there is no way that ro3 will send icmp msg to host1 via another path.

Host1 now have this routes to host2:

ip r g 10.10.30.30 sport 30000 dport 443
10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
    cache expires 521sec mtu 1500

ip r g 10.10.30.30 sport 30033 dport 443
10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
    cache

So when host1 tries again to reach host2 with mtu>1500,
if packet flow is lucky enough to be hashed with oif=ens17f1 its ok,
if oif=ens17f0 it blackholes and still gets icmp msgs from ro3 to ens17f1,
until lucky day when ro3 will send it through another flow to ens17f0.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
V9:
  selftests in pmtu.sh:
    - remove useless return
    - fix mtu var override
V8:
  selftests in pmtu.sh:
    - Change var names from "dummy" to "host"
    - Fix errors caused by incorrect iface arguments pass
    - Add src addr to setup_multipath_new
    - Change multipath* func order
    - Change route_get_dst_exception() && route_get_dst_pmtu_from_exception()
      and arguments pass where they are used
      as Ido suggested in https://lore.kernel.org/all/ZykH_fdcMBdFgXix@shredder/

V7:
  selftest in pmtu.sh:
    - add setup_multipath() with old and new nh tests
    - add global "dummy_v4" addr variables
    - add documentation
    - remove dummy netdev usage in mp nh test
    - remove useless sysctl opts in mp nh test

V6:
  - make commit message cleaner

V5:
  - make self test cleaner

V4:
  - fix selftest, do route lookup before checking cached exceptions

V3:
  - add selftest
  - fix compile error

V2:
  - fix fib_info_num_path parameter pass
---
 net/ipv4/route.c                    |  13 ++++
 tools/testing/selftests/net/pmtu.sh | 117 ++++++++++++++++++++++++----
 2 files changed, 113 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 723ac9181558..652f603d29fe 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1027,6 +1027,19 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		struct fib_nh_common *nhc;
 
 		fib_select_path(net, &res, fl4, NULL);
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+		if (fib_info_num_path(res.fi) > 1) {
+			int nhsel;
+
+			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
+				nhc = fib_info_nhc(res.fi, nhsel);
+				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
+						      jiffies + net->ipv4.ip_rt_mtu_expires);
+			}
+			rcu_read_unlock();
+			return;
+		}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH */
 		nhc = FIB_RES_NHC(res);
 		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 				      jiffies + net->ipv4.ip_rt_mtu_expires);
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 569bce8b6383..611ae7862f46 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -197,6 +197,12 @@
 #
 # - pmtu_ipv6_route_change
 #	Same as above but with IPv6
+#
+# - pmtu_ipv4_mp_exceptions
+#	Use the same topology as in pmtu_ipv4, but add routeable addresses
+#	on host A and B on lo reachable via both routers. Host A and B
+#	addresses have multipath routes to each other, b_r1 mtu = 1500.
+#	Check that PMTU exceptions are created for both paths.
 
 source lib.sh
 source net_helper.sh
@@ -266,7 +272,8 @@ tests="
 	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
 	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
 	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
-	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
+	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
+	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions	1"
 
 # Addressing and routing for tests with routers: four network segments, with
 # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) and an
@@ -343,6 +350,9 @@ tunnel6_a_addr="fd00:2::a"
 tunnel6_b_addr="fd00:2::b"
 tunnel6_mask="64"
 
+host4_a_addr="192.168.99.99"
+host4_b_addr="192.168.88.88"
+
 dummy6_0_prefix="fc00:1000::"
 dummy6_1_prefix="fc00:1001::"
 dummy6_mask="64"
@@ -984,6 +994,52 @@ setup_ovs_bridge() {
 	run_cmd ip route add ${prefix6}:${b_r1}::1 via ${prefix6}:${a_r1}::2
 }
 
+setup_multipath_new() {
+	# Set up host A with multipath routes to host B host4_b_addr
+	run_cmd ${ns_a} ip addr add ${host4_a_addr} dev lo
+	run_cmd ${ns_a} ip nexthop add id 401 via ${prefix4}.${a_r1}.2 dev veth_A-R1
+	run_cmd ${ns_a} ip nexthop add id 402 via ${prefix4}.${a_r2}.2 dev veth_A-R2
+	run_cmd ${ns_a} ip nexthop add id 403 group 401/402
+	run_cmd ${ns_a} ip route add ${host4_b_addr} src ${host4_a_addr} nhid 403
+
+	# Set up host B with multipath routes to host A host4_a_addr
+	run_cmd ${ns_b} ip addr add ${host4_b_addr} dev lo
+	run_cmd ${ns_b} ip nexthop add id 401 via ${prefix4}.${b_r1}.2 dev veth_B-R1
+	run_cmd ${ns_b} ip nexthop add id 402 via ${prefix4}.${b_r2}.2 dev veth_B-R2
+	run_cmd ${ns_b} ip nexthop add id 403 group 401/402
+	run_cmd ${ns_b} ip route add ${host4_a_addr} src ${host4_b_addr} nhid 403
+}
+
+setup_multipath_old() {
+	# Set up host A with multipath routes to host B host4_b_addr
+	run_cmd ${ns_a} ip addr add ${host4_a_addr} dev lo
+	run_cmd ${ns_a} ip route add ${host4_b_addr} \
+			src ${host4_a_addr} \
+			nexthop via ${prefix4}.${a_r1}.2 weight 1 \
+			nexthop via ${prefix4}.${a_r2}.2 weight 1
+
+	# Set up host B with multipath routes to host A host4_a_addr
+	run_cmd ${ns_b} ip addr add ${host4_b_addr} dev lo
+	run_cmd ${ns_b} ip route add ${host4_a_addr} \
+			src ${host4_b_addr} \
+			nexthop via ${prefix4}.${b_r1}.2 weight 1 \
+			nexthop via ${prefix4}.${b_r2}.2 weight 1
+}
+
+setup_multipath() {
+	if [ "$USE_NH" = "yes" ]; then
+		setup_multipath_new
+	else
+		setup_multipath_old
+	fi
+
+	# Set up routers with routes to dummies
+	run_cmd ${ns_r1} ip route add ${host4_a_addr} via ${prefix4}.${a_r1}.1
+	run_cmd ${ns_r2} ip route add ${host4_a_addr} via ${prefix4}.${a_r2}.1
+	run_cmd ${ns_r1} ip route add ${host4_b_addr} via ${prefix4}.${b_r1}.1
+	run_cmd ${ns_r2} ip route add ${host4_b_addr} via ${prefix4}.${b_r2}.1
+}
+
 setup() {
 	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
 
@@ -1076,23 +1132,15 @@ link_get_mtu() {
 }
 
 route_get_dst_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
-
-	if [ -z "${dsfield}" ]; then
-		dsfield=0
-	fi
+	ns_cmd="${1}"; shift
 
-	${ns_cmd} ip route get "${dst}" dsfield "${dsfield}"
+	${ns_cmd} ip route get "$@"
 }
 
 route_get_dst_pmtu_from_exception() {
-	ns_cmd="${1}"
-	dst="${2}"
-	dsfield="${3}"
+	ns_cmd="${1}"; shift
 
-	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "${dst}" "${dsfield}")"
+	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "$@")"
 }
 
 check_pmtu_value() {
@@ -1235,10 +1283,10 @@ test_pmtu_ipv4_dscp_icmp_exception() {
 	run_cmd "${ns_a}" ping -q -M want -Q "${dsfield}" -c 1 -w 1 -s "${len}" "${dst2}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" dsfield "${policy_mark}")"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
 
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" dsfield "${policy_mark}")"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }
 
@@ -1285,9 +1333,9 @@ test_pmtu_ipv4_dscp_udp_exception() {
 		UDP:"${dst2}":50000,tos="${dsfield}"
 
 	# Check that exceptions have been created with the correct PMTU
-	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
+	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" dsfield "${policy_mark}")"
 	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
-	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
+	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" dsfield "${policy_mark}")"
 	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
 }
 
@@ -2329,6 +2377,41 @@ test_pmtu_ipv6_route_change() {
 	test_pmtu_ipvX_route_change 6
 }
 
+test_pmtu_ipv4_mp_exceptions() {
+	setup namespaces routing multipath || return $ksft_skip
+
+	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
+	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
+	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
+	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
+
+	# Set up initial MTU values
+	mtu "${ns_a}"  veth_A-R1 2000
+	mtu "${ns_r1}" veth_R1-A 2000
+	mtu "${ns_r1}" veth_R1-B 1500
+	mtu "${ns_b}"  veth_B-R1 1500
+
+	mtu "${ns_a}"  veth_A-R2 2000
+	mtu "${ns_r2}" veth_R2-A 2000
+	mtu "${ns_r2}" veth_R2-B 1500
+	mtu "${ns_b}"  veth_B-R2 1500
+
+	fail=0
+
+	# Ping and expect two nexthop exceptions for two routes in nh group
+	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${host4_b_addr}"
+
+	# Do route lookup before checking cached exceptions.
+	# The following commands are needed for dst entries to be cached
+	# in both paths exceptions and therefore dumped to user space
+	# Check that exceptions have been created with the correct PMTU
+	pmtu_a_R1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R1)"
+	pmtu_a_R2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${host4_b_addr}" oif veth_A-R2)"
+
+	check_pmtu_value "1500" "${pmtu_a_R1}" "exceeding MTU (veth_A-R2)" || return 1
+	check_pmtu_value "1500" "${pmtu_a_R2}" "exceeding MTU (veth_A-R1)" || return 1
+}
+
 usage() {
 	echo
 	echo "$0 [OPTIONS] [TEST]..."

base-commit: 66600fac7a984dea4ae095411f644770b2561ede
-- 
2.43.5


