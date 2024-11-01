Return-Path: <linux-kselftest+bounces-21286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B49B8F17
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 11:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6651F2161A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286DD15CD60;
	Fri,  1 Nov 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="V6YJ0jjN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964814A098
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456562; cv=none; b=nOUxRFk3sJvkFiFQ49u1Zf8XD3e8ae8vkA03HkmsY2RaNA1YyFksdX1hTM4ex+Ra9Af0SxG+QaFxIokkMZxy6RXnTt1amgw+psRAUCMKfkAC0VvY8FJodu8hsFKaCxtaWfI055l08fq4VE6UjBqrF36ErtgTqS8O0ASbGzbbSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456562; c=relaxed/simple;
	bh=nSyBjBXxs4qqZaQPQEIbY6vTVAqIZySvep7SIIhUDZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgy9FR70K7iRAp5AqAsTnPiVTa3O41D4mH+mspRb6lp2eN7Wsj6fEJ07j8PGFvQtTuI+PT9QdP1izxiqhxgoAza9sd+7acprxlrGjIbgKkHbsBcFK5GO4REhoOR/sLeAiGmKyZaPUYQg9DJ1Yzq8KFuLaPTTRM2e9Nl6KThhKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=V6YJ0jjN; arc=none smtp.client-ip=17.57.155.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730456557; bh=o7ASiyFV+Hosqd1uhMOtY9gjtmrT6eZBqgvQxbmi1fU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=V6YJ0jjNnqUsKTBa5dJNxHmTC131QKWeb1da6K4j4r5m5LI6+LMF1DQzG2e4P5Otd
	 TE6AK7249R0ZbcIWNp3YhY8OoKLvQn2pbr+alOzzRlAT15VSvYTBH2lCbOeF3TDTrf
	 7XOki9EezlpABpO2uYM4OWZSPsvhjImqFcebBLneAps5gIldeibfpGwLueccYWeO8B
	 BwJRfUn84eFGJnmMl4Dew7Xmac+laC9QT4cFEphDg9QEFHtx8Z5WfoypuuCsUVOTXy
	 EtVFBq+h6IVP5vin6YC1lHw6HQ/KTKxN5SbQeCfymjN3D72XzjiOZ8gos5SPp/jeo1
	 QdZB6GNiojOFQ==
Received: from almalinux-std3-4-4-10gb.novalocal (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id 231E65EC0325;
	Fri,  1 Nov 2024 10:22:33 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: netdev@vger.kernel.org,
	dsahern@kernel.org,
	davem@davemloft.net
Cc: Vladimir Vdovin <deliran@verdict.gg>,
	idosch@idosch.org,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org
Subject: [PATCH v4] net: ipv4: Cache pmtu for all packet paths if multipath enabled
Date: Fri,  1 Nov 2024 10:21:40 +0000
Message-ID: <20241101102207.68271-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
References: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BWNl501YpNwe5NTxr58mx1Syli_-Rhwf
X-Proofpoint-GUID: BWNl501YpNwe5NTxr58mx1Syli_-Rhwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_06,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411010074

Check number of paths by fib_info_num_path(),
and update_or_create_fnhe() for every path.
Problem is that pmtu is cached only for the oif
that has received icmp message "need to frag",
other oifs will still try to use "default" iface mtu.

V4:
  - fix selftest, do route lookup before checking cached exceptions

V3:
  - added selftest
  - fixed compile error

V2:
  - fix fib_info_num_path parameter pass

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
 net/ipv4/route.c                    | 13 +++++
 tools/testing/selftests/net/pmtu.sh | 79 ++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 723ac9181558..41162b5cc4cb 100644
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
+							  jiffies + net->ipv4.ip_rt_mtu_expires);
+			}
+			rcu_read_unlock();
+			return;
+		}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH */
 		nhc = FIB_RES_NHC(res);
 		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 				      jiffies + net->ipv4.ip_rt_mtu_expires);
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 569bce8b6383..f7ced4c436fb 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -266,7 +266,8 @@ tests="
 	list_flush_ipv4_exception	ipv4: list and flush cached exceptions	1
 	list_flush_ipv6_exception	ipv6: list and flush cached exceptions	1
 	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
-	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
+	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1
+	pmtu_ipv4_mp_exceptions		ipv4: PMTU multipath nh exceptions		0"
 
 # Addressing and routing for tests with routers: four network segments, with
 # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) and an
@@ -2329,6 +2330,82 @@ test_pmtu_ipv6_route_change() {
 	test_pmtu_ipvX_route_change 6
 }
 
+test_pmtu_ipv4_mp_exceptions() {
+	setup namespaces routing || return $ksft_skip
+
+	ip nexthop ls >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		echo "Nexthop objects not supported; skipping tests"
+		exit $ksft_skip
+	fi
+
+	trace "${ns_a}"  veth_A-R1    "${ns_r1}" veth_R1-A \
+	      "${ns_r1}" veth_R1-B    "${ns_b}"  veth_B-R1 \
+	      "${ns_a}"  veth_A-R2    "${ns_r2}" veth_R2-A \
+	      "${ns_r2}" veth_R2-B    "${ns_b}"  veth_B-R2
+
+	dummy0_a="192.168.99.99"
+	dummy0_b="192.168.88.88"
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
+	#Set up host A with multipath routes to host B dummy0_b
+	run_cmd ${ns_a} sysctl -q net.ipv4.fib_multipath_hash_policy=1
+	run_cmd ${ns_a} sysctl -q net.ipv4.ip_forward=1
+	run_cmd ${ns_a} ip link add dummy0 mtu 2000 type dummy
+	run_cmd ${ns_a} ip link set dummy0 up
+	run_cmd ${ns_a} ip addr add ${dummy0_a} dev dummy0
+	run_cmd ${ns_a} ip nexthop add id 201 via ${prefix4}.${a_r1}.2 dev veth_A-R1
+	run_cmd ${ns_a} ip nexthop add id 202 via ${prefix4}.${a_r2}.2 dev veth_A-R2
+	run_cmd ${ns_a} ip nexthop add id 203 group 201/202
+	run_cmd ${ns_a} ip route add ${dummy0_b} nhid 203
+
+	#Set up host B with multipath routes to host A dummy0_a
+	run_cmd ${ns_b} sysctl -q net.ipv4.fib_multipath_hash_policy=1
+	run_cmd ${ns_b} sysctl -q net.ipv4.ip_forward=1
+	run_cmd ${ns_b} ip link add dummy0 mtu 2000 type dummy
+	run_cmd ${ns_b} ip link set dummy0 up
+	run_cmd ${ns_b} ip addr add ${dummy0_b} dev dummy0
+	run_cmd ${ns_b} ip nexthop add id 201 via ${prefix4}.${b_r1}.2 dev veth_A-R1
+	run_cmd ${ns_b} ip nexthop add id 202 via ${prefix4}.${b_r2}.2 dev veth_A-R2
+	run_cmd ${ns_b} ip nexthop add id 203 group 201/202
+	run_cmd ${ns_b} ip route add ${dummy0_a} nhid 203
+
+	#Set up routers with routes to dummies
+	run_cmd ${ns_r1} ip route add ${dummy0_a} via ${prefix4}.${a_r1}.1
+	run_cmd ${ns_r2} ip route add ${dummy0_a} via ${prefix4}.${a_r2}.1
+	run_cmd ${ns_r1} ip route add ${dummy0_b} via ${prefix4}.${b_r1}.1
+	run_cmd ${ns_r2} ip route add ${dummy0_b} via ${prefix4}.${b_r2}.1
+
+
+	#Ping and expect two nexthop exceptions for two routes in nh group
+	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 2 -s 1800 "${dummy0_b}"
+
+	#Do route lookup before checking cached exceptions
+	run_cmd ${ns_a} ip route get ${dummy0_b} oif veth_A-R1
+	run_cmd ${ns_a} ip route get ${dummy0_b} oif veth_A-R2
+
+	#Check cached exceptions
+	echo "$(ip -oneline route list cache)"
+	if [ "$(${ns_a} ip -oneline route list cache| grep mtu | wc -l)" -ne 2 ]; then
+		err "  there are not enough cached exceptions"
+		fail=1
+	fi
+
+	return ${fail}
+}
+
 usage() {
 	echo
 	echo "$0 [OPTIONS] [TEST]..."

base-commit: 66600fac7a984dea4ae095411f644770b2561ede
-- 
2.43.5


