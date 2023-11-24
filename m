Return-Path: <linux-kselftest+bounces-528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B67F6FB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E0DB20FE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34F156E1;
	Fri, 24 Nov 2023 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrytpJjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A045DD;
	Fri, 24 Nov 2023 01:29:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ce656b9780so12310055ad.2;
        Fri, 24 Nov 2023 01:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818185; x=1701422985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB4lw/evgz0Y5zIZuooPJArSKXL4orJ6Wn3RCNPZos8=;
        b=ZrytpJjlw8oefIbeR34U0agF41fGRobR+zYwcz3/G66AjY8S7SVcyi1P2R1o1aM8vl
         0j3aAAaBtTToAfrp0cX1PQCfkgn2V96VXAn51DeEYS9QJ5tr97w88hZ4ZNtQEsnEqAFW
         Cyn6l/xLMBp0CED9EZu3Qevadpu1TgBLJcZK811WE0yeJeCJ9d8ttlQSQZMHzpVIbNBt
         AP/0ehNiTJJg2WtsXbBmEPp2t8XQpYMCIAkFvrjnsusUzk7taalsdJoc8aF1QGjWwXQg
         GGeDi8tWeouwp7q/2VKGt/LkfXyO9I/KL1RmcOygtHOefQRfZuuuSv/KreyxCPJYzpvg
         HjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818185; x=1701422985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB4lw/evgz0Y5zIZuooPJArSKXL4orJ6Wn3RCNPZos8=;
        b=HrFXJxa4s5UGR73UZ/d7TeiMRkA8RFYERzEb14ljFckvOfumxv/ryUnrFcFN8V72KS
         2Aj31StXdKahFiu5I9AsiiGnCB9PvC7z2JNqoJ7R5pRDqNfUao3F9ywae11u3frrRxCE
         DkTLtKNQ8/ZnZKU/z8frfoy/R/Rfy8oFUBtpN0DBi8Uc8uEH3AlJORJ4CGcQcw2dsjWz
         IHLJnwRkYuaoDW6VK4ITsQGJOuZ2Dmx3L809RRmgqvPJO7p44OOkEm3EhqLd7laOygnA
         pA9+Q3dMfc0d5RTaBywUgh69Yt0jVY1QD+q2DmayA50kJiVyHNbv5gCes5EQ+uZIrB/c
         5hew==
X-Gm-Message-State: AOJu0YyUvFHRql2AvM8Nwky4EmAPIzS//5Bc4y9ToorkjUwta4kAJozc
	BumtDmUHQO9QdBskyeMSEsRL0b04AzVvJ3TM
X-Google-Smtp-Source: AGHT+IH+vmE6cF9EQwdVRRZtnvT//a5xM0QZrppWoCny0I8hJlBQDkNqRfJR4PeqGUfyXnbvJ7O9ug==
X-Received: by 2002:a17:902:d50c:b0:1cf:78a6:d61 with SMTP id b12-20020a170902d50c00b001cf78a60d61mr2123922plg.9.1700818184635;
        Fri, 24 Nov 2023 01:29:44 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:44 -0800 (PST)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 26/38] selftests/net: convert test_bridge_neigh_suppress.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:24 +0800
Message-ID: <20231124092736.3673263-27-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./test_bridge_neigh_suppress.sh
declare -- sip="192.0.2.1"
declare -- tip="192.0.2.2"
declare -- vid="10"

Per-port ARP suppression - VLAN 10
----------------------------------
TEST: arping                                                        [ OK ]
TEST: ARP suppression                                               [ OK ]

...

TEST: NS suppression (VLAN 20)                                      [ OK ]

Tests passed: 148
Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/test_bridge_neigh_suppress.sh         | 333 +++++++++---------
 1 file changed, 163 insertions(+), 170 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index d80f2cd87614..cd8629b476e2 100755
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
 
@@ -409,86 +402,86 @@ neigh_suppress_ns_common()
 	local saddr=$1; shift
 	local daddr=$1; shift
 	local maddr=$1; shift
-	local h2_mac
+	local $h2_mac
 
 	echo
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
 
@@ -517,125 +510,125 @@ neigh_vlan_suppress_arp()
 	local sip2=192.0.2.17
 	local tip1=192.0.2.2
 	local tip2=192.0.2.18
-	local h2_mac1
-	local h2_mac2
+	local $h2_mac1
+	local $h2_mac2
 
 	echo
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
 
@@ -648,125 +641,125 @@ neigh_vlan_suppress_ns()
 	local daddr1=2001:db8:1::2
 	local daddr2=2001:db8:2::2
 	local maddr=ff02::1:ff00:2
-	local h2_mac1
-	local h2_mac2
+	local $h2_mac1
+	local $h2_mac2
 
 	echo
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
2.41.0


