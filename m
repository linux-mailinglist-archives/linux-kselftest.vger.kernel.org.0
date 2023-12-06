Return-Path: <linux-kselftest+bounces-1234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0128067F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFAC1F21794
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C55B134AB;
	Wed,  6 Dec 2023 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8N/v/df"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40413135;
	Tue,  5 Dec 2023 23:08:19 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b84e328327so3888307b6e.2;
        Tue, 05 Dec 2023 23:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846498; x=1702451298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17gl4U+Jcq9vjydFNVgF3vBTDN4pUVOc2Vp/MAsPT9A=;
        b=Z8N/v/dfevTeUzx1I999fE+U5JTVTggtyCmVe21a45YZNx4BcFYFAEr8ymLSJQXbxz
         G4p9EXdKCLwa+c3/zdeGzbWn77yOgMpH1BLFxOww8Aqf45pi2z7djUqWCFIF+DCgDoXa
         ab465qCQCN861sVy3fCNJgilAKb0w43S7csVCc1+zsl67Q+e8UEjl9AGuKQ6abuKvBuP
         lE6PMv5VgdRgjY4eXaXbuezJ3dBZI8Yo8pEnE31QuF4e0tHstttqg90r5qpom80DdINZ
         XPr32SlKuAU2CoAe+jdze/TTaBIusxQXkaFnOXeSV52tXpkGGLrNir8Od7E9/AD1k+WT
         U46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846498; x=1702451298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17gl4U+Jcq9vjydFNVgF3vBTDN4pUVOc2Vp/MAsPT9A=;
        b=DuIQwd/088geCbb2L57sA+anGY9dmoUQMnfdygqUVg9Rv4k/SBMZAbB3Jg5YD15ioP
         KAVH/k4F0vDUmm1GFojWKLMQnmxNi5cu/fS12lRyDJicjOpeUDWsjCV/n1YMSxgD8sM8
         awvv4vGjxtys1hyhv2/UCepKlTGl3Y7Vp8ZQYABSMExE2tWaHqC/A/8OQ/9m3xcp3xZS
         JtAbZAjNxQWLt+XpdOZM560LTLd6UJPFh0LrGqB2vbr04337WUZv0ePjz38x2WEAVhzw
         OjV/0/FtlBRBC3jpsgfNa4mV0tDL3kMkdM0URv7P3csDeidx1eUaA0e709Jo56uIui7+
         LFRQ==
X-Gm-Message-State: AOJu0YxKmggefMQWYgmR5VChRwtTA6ku4oGpjbWJkYU8ZNXNABJPGXAm
	mhbfdbna219SBdRJiEds2Izf/ZdOiuLMvfiN
X-Google-Smtp-Source: AGHT+IEasJGKglAtC5JqxZ+cIw3T7O23noIjy1FSiJrnytuEY0ZFrs3B1GtNNPTzC60svhzZ8YrMZA==
X-Received: by 2002:a05:6808:219a:b0:3b8:b063:6b9c with SMTP id be26-20020a056808219a00b003b8b0636b9cmr713405oib.75.1701846497375;
        Tue, 05 Dec 2023 23:08:17 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:16 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/9] selftests/net: convert test_bridge_neigh_suppress.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:07:54 +0800
Message-ID: <20231206070801.1691247-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206070801.1691247-1-liuhangbin@gmail.com>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./test_bridge_neigh_suppress.sh

Per-port ARP suppression - VLAN 10
----------------------------------
TEST: arping                                                        [ OK ]
TEST: ARP suppression                                               [ OK ]

...

TEST: NS suppression (VLAN 20)                                      [ OK ]

Tests passed: 148
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/test_bridge_neigh_suppress.sh         | 331 +++++++++---------
 1 file changed, 162 insertions(+), 169 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index d80f2cd87614..8533393a4f18 100755
--- a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
+++ b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
@@ -45,9 +45,8 @@
 # | sw1                                | | sw2                                |
 # +------------------------------------+ +------------------------------------+
 
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # All tests in this script. Can be overridden with -t option.
 TESTS="
@@ -140,9 +139,6 @@ setup_topo_ns()
 {
 	local ns=$1; shift
 
-	ip netns add $ns
-	ip -n $ns link set dev lo up
-
 	ip netns exec $ns sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
 	ip netns exec $ns sysctl -qw net.ipv6.conf.default.ignore_routes_with_linkdown=1
 	ip netns exec $ns sysctl -qw net.ipv6.conf.all.accept_dad=0
@@ -153,21 +149,22 @@ setup_topo()
 {
 	local ns
 
-	for ns in h1 h2 sw1 sw2; do
+	setup_ns h1 h2 sw1 sw2
+	for ns in $h1 $h2 $sw1 $sw2; do
 		setup_topo_ns $ns
 	done
 
 	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 netns h1 name eth0
-	ip link set dev veth1 netns sw1 name swp1
+	ip link set dev veth0 netns $h1 name eth0
+	ip link set dev veth1 netns $sw1 name swp1
 
 	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 netns sw1 name veth0
-	ip link set dev veth1 netns sw2 name veth0
+	ip link set dev veth0 netns $sw1 name veth0
+	ip link set dev veth1 netns $sw2 name veth0
 
 	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 netns h2 name eth0
-	ip link set dev veth1 netns sw2 name swp1
+	ip link set dev veth0 netns $h2 name eth0
+	ip link set dev veth1 netns $sw2 name swp1
 }
 
 setup_host_common()
@@ -190,7 +187,7 @@ setup_host_common()
 
 setup_h1()
 {
-	local ns=h1
+	local ns=$h1
 	local v4addr1=192.0.2.1/28
 	local v4addr2=192.0.2.17/28
 	local v6addr1=2001:db8:1::1/64
@@ -201,7 +198,7 @@ setup_h1()
 
 setup_h2()
 {
-	local ns=h2
+	local ns=$h2
 	local v4addr1=192.0.2.2/28
 	local v4addr2=192.0.2.18/28
 	local v6addr1=2001:db8:1::2/64
@@ -254,7 +251,7 @@ setup_sw_common()
 
 setup_sw1()
 {
-	local ns=sw1
+	local ns=$sw1
 	local local_addr=192.0.2.33
 	local remote_addr=192.0.2.34
 	local veth_addr=192.0.2.49
@@ -265,7 +262,7 @@ setup_sw1()
 
 setup_sw2()
 {
-	local ns=sw2
+	local ns=$sw2
 	local local_addr=192.0.2.34
 	local remote_addr=192.0.2.33
 	local veth_addr=192.0.2.50
@@ -291,11 +288,7 @@ setup()
 
 cleanup()
 {
-	local ns
-
-	for ns in h1 h2 sw1 sw2; do
-		ip netns del $ns &> /dev/null
-	done
+	cleanup_ns $h1 $h2 $sw1 $sw2
 }
 
 ################################################################################
@@ -312,80 +305,80 @@ neigh_suppress_arp_common()
 	echo "Per-port ARP suppression - VLAN $vid"
 	echo "----------------------------------"
 
-	run_cmd "tc -n sw1 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 101 proto 0x0806 flower indev swp1 arp_tip $tip arp_sip $sip arp_op request action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto 0x0806 flower indev swp1 arp_tip $tip arp_sip $sip arp_op request action pass"
 
 	# Initial state - check that ARP requests are not suppressed and that
 	# ARP replies are received.
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "ARP suppression"
 
 	# Enable neighbor suppression and check that nothing changes compared
 	# to the initial state.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "ARP suppression"
 
 	# Install an FDB entry for the remote host and check that nothing
 	# changes compared to the initial state.
-	h2_mac=$(ip -n h2 -j -p link show eth0.$vid | jq -r '.[]["address"]')
-	run_cmd "bridge -n sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
+	h2_mac=$(ip -n $h2 -j -p link show eth0.$vid | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
 	log_test $? 0 "FDB entry installation"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "ARP suppression"
 
 	# Install a neighbor on the matching SVI interface and check that ARP
 	# requests are suppressed.
-	run_cmd "ip -n sw1 neigh replace $tip lladdr $h2_mac nud permanent dev br0.$vid"
+	run_cmd "ip -n $sw1 neigh replace $tip lladdr $h2_mac nud permanent dev br0.$vid"
 	log_test $? 0 "Neighbor entry installation"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "ARP suppression"
 
 	# Take the second host down and check that ARP requests are suppressed
 	# and that ARP replies are received.
-	run_cmd "ip -n h2 link set dev eth0.$vid down"
+	run_cmd "ip -n $h2 link set dev eth0.$vid down"
 	log_test $? 0 "H2 down"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "ARP suppression"
 
-	run_cmd "ip -n h2 link set dev eth0.$vid up"
+	run_cmd "ip -n $h2 link set dev eth0.$vid up"
 	log_test $? 0 "H2 up"
 
 	# Disable neighbor suppression and check that ARP requests are no
 	# longer suppressed.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress off"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
 	log_test $? 0 "arping"
-	tc_check_packets sw1 "dev vx0 egress" 101 4
+	tc_check_packets $sw1 "dev vx0 egress" 101 4
 	log_test $? 0 "ARP suppression"
 
 	# Take the second host down and check that ARP requests are not
 	# suppressed and that ARP replies are not received.
-	run_cmd "ip -n h2 link set dev eth0.$vid down"
+	run_cmd "ip -n $h2 link set dev eth0.$vid down"
 	log_test $? 0 "H2 down"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip -I eth0.$vid $tip"
 	log_test $? 1 "arping"
-	tc_check_packets sw1 "dev vx0 egress" 101 5
+	tc_check_packets $sw1 "dev vx0 egress" 101 5
 	log_test $? 0 "ARP suppression"
 }
 
@@ -415,80 +408,80 @@ neigh_suppress_ns_common()
 	echo "Per-port NS suppression - VLAN $vid"
 	echo "---------------------------------"
 
-	run_cmd "tc -n sw1 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $maddr src_ip $saddr type 135 code 0 action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $maddr src_ip $saddr type 135 code 0 action pass"
 
 	# Initial state - check that NS messages are not suppressed and that ND
 	# messages are received.
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "NS suppression"
 
 	# Enable neighbor suppression and check that nothing changes compared
 	# to the initial state.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "NS suppression"
 
 	# Install an FDB entry for the remote host and check that nothing
 	# changes compared to the initial state.
-	h2_mac=$(ip -n h2 -j -p link show eth0.$vid | jq -r '.[]["address"]')
-	run_cmd "bridge -n sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
+	h2_mac=$(ip -n $h2 -j -p link show eth0.$vid | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac dev vx0 master static vlan $vid"
 	log_test $? 0 "FDB entry installation"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "NS suppression"
 
 	# Install a neighbor on the matching SVI interface and check that NS
 	# messages are suppressed.
-	run_cmd "ip -n sw1 neigh replace $daddr lladdr $h2_mac nud permanent dev br0.$vid"
+	run_cmd "ip -n $sw1 neigh replace $daddr lladdr $h2_mac nud permanent dev br0.$vid"
 	log_test $? 0 "Neighbor entry installation"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "NS suppression"
 
 	# Take the second host down and check that NS messages are suppressed
 	# and that ND messages are received.
-	run_cmd "ip -n h2 link set dev eth0.$vid down"
+	run_cmd "ip -n $h2 link set dev eth0.$vid down"
 	log_test $? 0 "H2 down"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "NS suppression"
 
-	run_cmd "ip -n h2 link set dev eth0.$vid up"
+	run_cmd "ip -n $h2 link set dev eth0.$vid up"
 	log_test $? 0 "H2 up"
 
 	# Disable neighbor suppression and check that NS messages are no longer
 	# suppressed.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress off"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
 	log_test $? 0 "ndisc6"
-	tc_check_packets sw1 "dev vx0 egress" 101 4
+	tc_check_packets $sw1 "dev vx0 egress" 101 4
 	log_test $? 0 "NS suppression"
 
 	# Take the second host down and check that NS messages are not
 	# suppressed and that ND messages are not received.
-	run_cmd "ip -n h2 link set dev eth0.$vid down"
+	run_cmd "ip -n $h2 link set dev eth0.$vid down"
 	log_test $? 0 "H2 down"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr -w 5000 $daddr eth0.$vid"
 	log_test $? 2 "ndisc6"
-	tc_check_packets sw1 "dev vx0 egress" 101 5
+	tc_check_packets $sw1 "dev vx0 egress" 101 5
 	log_test $? 0 "NS suppression"
 }
 
@@ -524,118 +517,118 @@ neigh_vlan_suppress_arp()
 	echo "Per-{Port, VLAN} ARP suppression"
 	echo "--------------------------------"
 
-	run_cmd "tc -n sw1 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 101 proto 0x0806 flower indev swp1 arp_tip $tip1 arp_sip $sip1 arp_op request action pass"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 102 proto 0x0806 flower indev swp1 arp_tip $tip2 arp_sip $sip2 arp_op request action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto 0x0806 flower indev swp1 arp_tip $tip1 arp_sip $sip1 arp_op request action pass"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 102 proto 0x0806 flower indev swp1 arp_tip $tip2 arp_sip $sip2 arp_op request action pass"
 
-	h2_mac1=$(ip -n h2 -j -p link show eth0.$vid1 | jq -r '.[]["address"]')
-	h2_mac2=$(ip -n h2 -j -p link show eth0.$vid2 | jq -r '.[]["address"]')
-	run_cmd "bridge -n sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
-	run_cmd "bridge -n sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
-	run_cmd "ip -n sw1 neigh replace $tip1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
-	run_cmd "ip -n sw1 neigh replace $tip2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
+	h2_mac1=$(ip -n $h2 -j -p link show eth0.$vid1 | jq -r '.[]["address"]')
+	h2_mac2=$(ip -n $h2 -j -p link show eth0.$vid2 | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
+	run_cmd "ip -n $sw1 neigh replace $tip1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
+	run_cmd "ip -n $sw1 neigh replace $tip2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
 
 	# Enable per-{Port, VLAN} neighbor suppression and check that ARP
 	# requests are not suppressed and that ARP replies are received.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_vlan_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_vlan_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
 	log_test $? 0 "\"neigh_vlan_suppress\" is on"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "ARP suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 1
+	tc_check_packets $sw1 "dev vx0 egress" 102 1
 	log_test $? 0 "ARP suppression (VLAN $vid2)"
 
 	# Enable neighbor suppression on VLAN 10 and check that only on this
 	# VLAN ARP requests are suppressed.
-	run_cmd "bridge -n sw1 vlan set vid $vid1 dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on (VLAN $vid1)"
-	run_cmd "bridge -n sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid2)"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "ARP suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 2
+	tc_check_packets $sw1 "dev vx0 egress" 102 2
 	log_test $? 0 "ARP suppression (VLAN $vid2)"
 
 	# Enable neighbor suppression on the port and check that it has no
 	# effect compared to previous state.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "ARP suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 3
+	tc_check_packets $sw1 "dev vx0 egress" 102 3
 	log_test $? 0 "ARP suppression (VLAN $vid2)"
 
 	# Disable neighbor suppression on the port and check that it has no
 	# effect compared to previous state.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress off"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "ARP suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 4
+	tc_check_packets $sw1 "dev vx0 egress" 102 4
 	log_test $? 0 "ARP suppression (VLAN $vid2)"
 
 	# Disable neighbor suppression on VLAN 10 and check that ARP requests
 	# are no longer suppressed on this VLAN.
-	run_cmd "bridge -n sw1 vlan set vid $vid1 dev vx0 neigh_suppress off"
-	run_cmd "bridge -n sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid1)"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "ARP suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 5
+	tc_check_packets $sw1 "dev vx0 egress" 102 5
 	log_test $? 0 "ARP suppression (VLAN $vid2)"
 
 	# Disable per-{Port, VLAN} neighbor suppression, enable neighbor
 	# suppression on the port and check that on both VLANs ARP requests are
 	# suppressed.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_vlan_suppress off"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress off\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_vlan_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress off\""
 	log_test $? 0 "\"neigh_vlan_suppress\" is off"
 
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip1 -I eth0.$vid1 $tip1"
 	log_test $? 0 "arping (VLAN $vid1)"
-	run_cmd "ip netns exec h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
+	run_cmd "ip netns exec $h1 arping -q -b -c 1 -w 5 -s $sip2 -I eth0.$vid2 $tip2"
 	log_test $? 0 "arping (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "ARP suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 5
+	tc_check_packets $sw1 "dev vx0 egress" 102 5
 	log_test $? 0 "ARP suppression (VLAN $vid2)"
 }
 
@@ -655,118 +648,118 @@ neigh_vlan_suppress_ns()
 	echo "Per-{Port, VLAN} NS suppression"
 	echo "-------------------------------"
 
-	run_cmd "tc -n sw1 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $maddr src_ip $saddr1 type 135 code 0 action pass"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 102 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $maddr src_ip $saddr2 type 135 code 0 action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $maddr src_ip $saddr1 type 135 code 0 action pass"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 102 proto ipv6 flower indev swp1 ip_proto icmpv6 dst_ip $maddr src_ip $saddr2 type 135 code 0 action pass"
 
-	h2_mac1=$(ip -n h2 -j -p link show eth0.$vid1 | jq -r '.[]["address"]')
-	h2_mac2=$(ip -n h2 -j -p link show eth0.$vid2 | jq -r '.[]["address"]')
-	run_cmd "bridge -n sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
-	run_cmd "bridge -n sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
-	run_cmd "ip -n sw1 neigh replace $daddr1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
-	run_cmd "ip -n sw1 neigh replace $daddr2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
+	h2_mac1=$(ip -n $h2 -j -p link show eth0.$vid1 | jq -r '.[]["address"]')
+	h2_mac2=$(ip -n $h2 -j -p link show eth0.$vid2 | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac1 dev vx0 master static vlan $vid1"
+	run_cmd "bridge -n $sw1 fdb replace $h2_mac2 dev vx0 master static vlan $vid2"
+	run_cmd "ip -n $sw1 neigh replace $daddr1 lladdr $h2_mac1 nud permanent dev br0.$vid1"
+	run_cmd "ip -n $sw1 neigh replace $daddr2 lladdr $h2_mac2 nud permanent dev br0.$vid2"
 
 	# Enable per-{Port, VLAN} neighbor suppression and check that NS
 	# messages are not suppressed and that ND messages are received.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_vlan_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_vlan_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress on\""
 	log_test $? 0 "\"neigh_vlan_suppress\" is on"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "NS suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 1
+	tc_check_packets $sw1 "dev vx0 egress" 102 1
 	log_test $? 0 "NS suppression (VLAN $vid2)"
 
 	# Enable neighbor suppression on VLAN 10 and check that only on this
 	# VLAN NS messages are suppressed.
-	run_cmd "bridge -n sw1 vlan set vid $vid1 dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on (VLAN $vid1)"
-	run_cmd "bridge -n sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid2 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid2)"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "NS suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 2
+	tc_check_packets $sw1 "dev vx0 egress" 102 2
 	log_test $? 0 "NS suppression (VLAN $vid2)"
 
 	# Enable neighbor suppression on the port and check that it has no
 	# effect compared to previous state.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "NS suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 3
+	tc_check_packets $sw1 "dev vx0 egress" 102 3
 	log_test $? 0 "NS suppression (VLAN $vid2)"
 
 	# Disable neighbor suppression on the port and check that it has no
 	# effect compared to previous state.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress off"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "NS suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 4
+	tc_check_packets $sw1 "dev vx0 egress" 102 4
 	log_test $? 0 "NS suppression (VLAN $vid2)"
 
 	# Disable neighbor suppression on VLAN 10 and check that NS messages
 	# are no longer suppressed on this VLAN.
-	run_cmd "bridge -n sw1 vlan set vid $vid1 dev vx0 neigh_suppress off"
-	run_cmd "bridge -n sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress off\""
+	run_cmd "bridge -n $sw1 vlan set vid $vid1 dev vx0 neigh_suppress off"
+	run_cmd "bridge -n $sw1 -d vlan show dev vx0 vid $vid1 | grep \"neigh_suppress off\""
 	log_test $? 0 "\"neigh_suppress\" is off (VLAN $vid1)"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "NS suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 5
+	tc_check_packets $sw1 "dev vx0 egress" 102 5
 	log_test $? 0 "NS suppression (VLAN $vid2)"
 
 	# Disable per-{Port, VLAN} neighbor suppression, enable neighbor
 	# suppression on the port and check that on both VLANs NS messages are
 	# suppressed.
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_vlan_suppress off"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress off\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_vlan_suppress off"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_vlan_suppress off\""
 	log_test $? 0 "\"neigh_vlan_suppress\" is off"
 
-	run_cmd "bridge -n sw1 link set dev vx0 neigh_suppress on"
-	run_cmd "bridge -n sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
 	log_test $? 0 "\"neigh_suppress\" is on"
 
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr1 -w 5000 $daddr1 eth0.$vid1"
 	log_test $? 0 "ndisc6 (VLAN $vid1)"
-	run_cmd "ip netns exec h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
+	run_cmd "ip netns exec $h1 ndisc6 -q -r 1 -s $saddr2 -w 5000 $daddr2 eth0.$vid2"
 	log_test $? 0 "ndisc6 (VLAN $vid2)"
 
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "NS suppression (VLAN $vid1)"
-	tc_check_packets sw1 "dev vx0 egress" 102 5
+	tc_check_packets $sw1 "dev vx0 egress" 102 5
 	log_test $? 0 "NS suppression (VLAN $vid2)"
 }
 
-- 
2.43.0


