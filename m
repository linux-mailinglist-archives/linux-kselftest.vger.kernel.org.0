Return-Path: <linux-kselftest+bounces-1233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3378067F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F731F2175E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592F134AB;
	Wed,  6 Dec 2023 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU0xmES7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7830DD42;
	Tue,  5 Dec 2023 23:08:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so1414901b3a.3;
        Tue, 05 Dec 2023 23:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846493; x=1702451293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IF5DGbntq2VRZVdy7aWVL/lGpZaZmpeJADi7s0ptSU=;
        b=OU0xmES7kPaOIJgk6oZt2/wI9/FEnfMezwPF0ByG8CfDAYLKRh9IEIcJCBvWcqQoFT
         8H6vxfZpOfb9KdGQfDHmoojwbY6joNoj8WAZE6wsNwo70bGltMKAUeVOq2cjOyaSGym7
         kdCq0GQ9DFgDecP2q11nIrEh/laDPooj+RLIxtMeTR00tjyRLuYMT2gwzATc6HdEEkts
         9WDgJ9Ims1DtZ95QEZBvBp0bwyep+pj8gEmrldd7y2HLN75j2ItQ1VFIUOcCW7o9d0Fc
         0JS7uFwCXVPdeBVe7ytr0bSlXUwnHtE9K8KKDAh+bV/wm7tgZYSCP/11krIOvuBqrD/a
         0T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846493; x=1702451293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IF5DGbntq2VRZVdy7aWVL/lGpZaZmpeJADi7s0ptSU=;
        b=bkzwojT6aJDHZrMHaH/XXofa32N385v694TR87OxRat6nEBWsQhH2hXnzyNbaoNvLm
         WRP9+zdmGmSCtEcgXkt/JgMghqA6Ye8kwAAUvyYbY9G6MDhpzGF+AlVShjWkppqXKF3V
         cr0yDkBpGbNaV4HNg/bTNoy0pxyZmQxQ9CEc6zcKyXzhmq5EhQ/tpwmw5c7Fyvu0popU
         UkIfPkO6bFEHsO/cxf41cCejnQeoc4SlqGyleCsqvw1uDeAipiLKNQu9/MRKwNwH4MSq
         6phx0MOm1w6HbNk56xAMUJhcjxRmpY99PzzON7VMuJOlBaXqczzHPJcNQPBNEA52srPD
         bqRw==
X-Gm-Message-State: AOJu0YzYUtuXLHpUuMlz5pVXm67LG2g2EDXfiFNo3Jk/nb4qTuq4oT3z
	oKyh9E8zRffQXrB9yeLCJhPfR7MGPg578NGa
X-Google-Smtp-Source: AGHT+IEJuFqKWk2h7dkKNxvm9sB835WS5s8ue0CV8plk9FE7zT0a0oJx26b32z+N6npfdmsGCEHEdQ==
X-Received: by 2002:a05:6a00:5c:b0:6c4:e7a0:af4a with SMTP id i28-20020a056a00005c00b006c4e7a0af4amr520777pfk.32.1701846492902;
        Tue, 05 Dec 2023 23:08:12 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:12 -0800 (PST)
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
Subject: [PATCH net-next 1/9] selftests/net: convert test_bridge_backup_port.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:07:53 +0800
Message-ID: <20231206070801.1691247-2-liuhangbin@gmail.com>
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

There is no h1 h2 actually. Remove it. Here is the test result after
conversion.

]# ./test_bridge_backup_port.sh

Backup port
-----------
TEST: Forwarding out of swp1                                        [ OK ]
TEST: No forwarding out of vx0                                      [ OK ]
TEST: swp1 carrier off                                              [ OK ]
TEST: No forwarding out of swp1                                     [ OK ]
...
Backup nexthop ID - ping
------------------------
TEST: Ping with backup nexthop ID                                   [ OK ]
TEST: Ping after disabling backup nexthop ID                        [ OK ]

Backup nexthop ID - torture test
--------------------------------
TEST: Torture test                                                  [ OK ]

Tests passed:  83
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/test_bridge_backup_port.sh  | 371 +++++++++---------
 1 file changed, 182 insertions(+), 189 deletions(-)

diff --git a/tools/testing/selftests/net/test_bridge_backup_port.sh b/tools/testing/selftests/net/test_bridge_backup_port.sh
index 112cfd8a10ad..70a7d87ba2d2 100755
--- a/tools/testing/selftests/net/test_bridge_backup_port.sh
+++ b/tools/testing/selftests/net/test_bridge_backup_port.sh
@@ -35,9 +35,8 @@
 # | sw1                                | | sw2                                |
 # +------------------------------------+ +------------------------------------+
 
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # All tests in this script. Can be overridden with -t option.
 TESTS="
@@ -132,9 +131,6 @@ setup_topo_ns()
 {
 	local ns=$1; shift
 
-	ip netns add $ns
-	ip -n $ns link set dev lo up
-
 	ip netns exec $ns sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
 	ip netns exec $ns sysctl -qw net.ipv6.conf.default.ignore_routes_with_linkdown=1
 	ip netns exec $ns sysctl -qw net.ipv6.conf.all.accept_dad=0
@@ -145,13 +141,14 @@ setup_topo()
 {
 	local ns
 
-	for ns in sw1 sw2; do
+	setup_ns sw1 sw2
+	for ns in $sw1 $sw2; do
 		setup_topo_ns $ns
 	done
 
 	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 netns sw1 name veth0
-	ip link set dev veth1 netns sw2 name veth0
+	ip link set dev veth0 netns $sw1 name veth0
+	ip link set dev veth1 netns $sw2 name veth0
 }
 
 setup_sw_common()
@@ -190,7 +187,7 @@ setup_sw_common()
 
 setup_sw1()
 {
-	local ns=sw1
+	local ns=$sw1
 	local local_addr=192.0.2.33
 	local remote_addr=192.0.2.34
 	local veth_addr=192.0.2.49
@@ -203,7 +200,7 @@ setup_sw1()
 
 setup_sw2()
 {
-	local ns=sw2
+	local ns=$sw2
 	local local_addr=192.0.2.34
 	local remote_addr=192.0.2.33
 	local veth_addr=192.0.2.50
@@ -229,11 +226,7 @@ setup()
 
 cleanup()
 {
-	local ns
-
-	for ns in h1 h2 sw1 sw2; do
-		ip netns del $ns &> /dev/null
-	done
+	cleanup_ns $sw1 $sw2
 }
 
 ################################################################################
@@ -248,85 +241,85 @@ backup_port()
 	echo "Backup port"
 	echo "-----------"
 
-	run_cmd "tc -n sw1 qdisc replace dev swp1 clsact"
-	run_cmd "tc -n sw1 filter replace dev swp1 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev swp1 clsact"
+	run_cmd "tc -n $sw1 filter replace dev swp1 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
 
-	run_cmd "tc -n sw1 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
 
-	run_cmd "bridge -n sw1 fdb replace $dmac dev swp1 master static vlan 10"
+	run_cmd "bridge -n $sw1 fdb replace $dmac dev swp1 master static vlan 10"
 
 	# Initial state - check that packets are forwarded out of swp1 when it
 	# has a carrier and not forwarded out of any port when it does not have
 	# a carrier.
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 1
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 1
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 0
+	tc_check_packets $sw1 "dev vx0 egress" 101 0
 	log_test $? 0 "No forwarding out of vx0"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 1
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 1
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 0
+	tc_check_packets $sw1 "dev vx0 egress" 101 0
 	log_test $? 0 "No forwarding out of vx0"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier on"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
 	log_test $? 0 "swp1 carrier on"
 
 	# Configure vx0 as the backup port of swp1 and check that packets are
 	# forwarded out of swp1 when it has a carrier and out of vx0 when swp1
 	# does not have a carrier.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_port vx0"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_port vx0\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_port vx0"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_port vx0\""
 	log_test $? 0 "vx0 configured as backup port of swp1"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 2
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 2
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 0
+	tc_check_packets $sw1 "dev vx0 egress" 101 0
 	log_test $? 0 "No forwarding out of vx0"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 2
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 2
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "Forwarding out of vx0"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier on"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
 	log_test $? 0 "swp1 carrier on"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 3
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 3
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "No forwarding out of vx0"
 
 	# Remove vx0 as the backup port of swp1 and check that packets are no
 	# longer forwarded out of vx0 when swp1 does not have a carrier.
-	run_cmd "bridge -n sw1 link set dev swp1 nobackup_port"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_port vx0\""
+	run_cmd "bridge -n $sw1 link set dev swp1 nobackup_port"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_port vx0\""
 	log_test $? 1 "vx0 not configured as backup port of swp1"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 4
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 4
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "No forwarding out of vx0"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 4
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 4
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "No forwarding out of vx0"
 }
 
@@ -339,125 +332,125 @@ backup_nhid()
 	echo "Backup nexthop ID"
 	echo "-----------------"
 
-	run_cmd "tc -n sw1 qdisc replace dev swp1 clsact"
-	run_cmd "tc -n sw1 filter replace dev swp1 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev swp1 clsact"
+	run_cmd "tc -n $sw1 filter replace dev swp1 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
 
-	run_cmd "tc -n sw1 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
 
-	run_cmd "ip -n sw1 nexthop replace id 1 via 192.0.2.34 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 2 via 192.0.2.34 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 10 group 1/2 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 1 via 192.0.2.34 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 2 via 192.0.2.34 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 10 group 1/2 fdb"
 
-	run_cmd "bridge -n sw1 fdb replace $dmac dev swp1 master static vlan 10"
-	run_cmd "bridge -n sw1 fdb replace $dmac dev vx0 self static dst 192.0.2.36 src_vni 10010"
+	run_cmd "bridge -n $sw1 fdb replace $dmac dev swp1 master static vlan 10"
+	run_cmd "bridge -n $sw1 fdb replace $dmac dev vx0 self static dst 192.0.2.36 src_vni 10010"
 
-	run_cmd "ip -n sw2 address replace 192.0.2.36/32 dev lo"
+	run_cmd "ip -n $sw2 address replace 192.0.2.36/32 dev lo"
 
 	# The first filter matches on packets forwarded using the backup
 	# nexthop ID and the second filter matches on packets forwarded using a
 	# regular VXLAN FDB entry.
-	run_cmd "tc -n sw2 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw2 filter replace dev vx0 ingress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac enc_key_id 10010 enc_dst_ip 192.0.2.34 action pass"
-	run_cmd "tc -n sw2 filter replace dev vx0 ingress pref 1 handle 102 proto ip flower src_mac $smac dst_mac $dmac enc_key_id 10010 enc_dst_ip 192.0.2.36 action pass"
+	run_cmd "tc -n $sw2 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw2 filter replace dev vx0 ingress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac enc_key_id 10010 enc_dst_ip 192.0.2.34 action pass"
+	run_cmd "tc -n $sw2 filter replace dev vx0 ingress pref 1 handle 102 proto ip flower src_mac $smac dst_mac $dmac enc_key_id 10010 enc_dst_ip 192.0.2.36 action pass"
 
 	# Configure vx0 as the backup port of swp1 and check that packets are
 	# forwarded out of swp1 when it has a carrier and out of vx0 when swp1
 	# does not have a carrier. When packets are forwarded out of vx0, check
 	# that they are forwarded by the VXLAN FDB entry.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_port vx0"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_port vx0\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_port vx0"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_port vx0\""
 	log_test $? 0 "vx0 configured as backup port of swp1"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 1
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 1
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 0
+	tc_check_packets $sw1 "dev vx0 egress" 101 0
 	log_test $? 0 "No forwarding out of vx0"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 1
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 1
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 0
+	tc_check_packets $sw2 "dev vx0 ingress" 101 0
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	tc_check_packets sw2 "dev vx0 ingress" 102 1
+	tc_check_packets $sw2 "dev vx0 ingress" 102 1
 	log_test $? 0 "Forwarding using VXLAN FDB entry"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier on"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
 	log_test $? 0 "swp1 carrier on"
 
 	# Configure nexthop ID 10 as the backup nexthop ID of swp1 and check
 	# that when packets are forwarded out of vx0, they are forwarded using
 	# the backup nexthop ID.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 10"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_nhid 10\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 10"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_nhid 10\""
 	log_test $? 0 "nexthop ID 10 configured as backup nexthop ID of swp1"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 2
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 2
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "No forwarding out of vx0"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 2
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 2
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "Forwarding using backup nexthop ID"
-	tc_check_packets sw2 "dev vx0 ingress" 102 1
+	tc_check_packets $sw2 "dev vx0 ingress" 102 1
 	log_test $? 0 "No forwarding using VXLAN FDB entry"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier on"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
 	log_test $? 0 "swp1 carrier on"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 3
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 3
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "No forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	tc_check_packets sw2 "dev vx0 ingress" 102 1
+	tc_check_packets $sw2 "dev vx0 ingress" 102 1
 	log_test $? 0 "No forwarding using VXLAN FDB entry"
 
 	# Reset the backup nexthop ID to 0 and check that packets are no longer
 	# forwarded using the backup nexthop ID when swp1 does not have a
 	# carrier and are instead forwarded by the VXLAN FDB.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 0"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_nhid\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 0"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_nhid\""
 	log_test $? 1 "No backup nexthop ID configured for swp1"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 4
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 4
 	log_test $? 0 "Forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "No forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	tc_check_packets sw2 "dev vx0 ingress" 102 1
+	tc_check_packets $sw2 "dev vx0 ingress" 102 1
 	log_test $? 0 "No forwarding using VXLAN FDB entry"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 4
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 4
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	tc_check_packets sw2 "dev vx0 ingress" 102 2
+	tc_check_packets $sw2 "dev vx0 ingress" 102 2
 	log_test $? 0 "Forwarding using VXLAN FDB entry"
 }
 
@@ -475,109 +468,109 @@ backup_nhid_invalid()
 	# is forwarded out of the VXLAN port, but dropped by the VXLAN driver
 	# and does not crash the host.
 
-	run_cmd "tc -n sw1 qdisc replace dev swp1 clsact"
-	run_cmd "tc -n sw1 filter replace dev swp1 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev swp1 clsact"
+	run_cmd "tc -n $sw1 filter replace dev swp1 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
 
-	run_cmd "tc -n sw1 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
+	run_cmd "tc -n $sw1 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac action pass"
 	# Drop all other Tx traffic to avoid changes to Tx drop counter.
-	run_cmd "tc -n sw1 filter replace dev vx0 egress pref 2 handle 102 proto all matchall action drop"
+	run_cmd "tc -n $sw1 filter replace dev vx0 egress pref 2 handle 102 proto all matchall action drop"
 
-	tx_drop=$(ip -n sw1 -s -j link show dev vx0 | jq '.[]["stats64"]["tx"]["dropped"]')
+	tx_drop=$(ip -n $sw1 -s -j link show dev vx0 | jq '.[]["stats64"]["tx"]["dropped"]')
 
-	run_cmd "ip -n sw1 nexthop replace id 1 via 192.0.2.34 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 2 via 192.0.2.34 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 10 group 1/2 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 1 via 192.0.2.34 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 2 via 192.0.2.34 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 10 group 1/2 fdb"
 
-	run_cmd "bridge -n sw1 fdb replace $dmac dev swp1 master static vlan 10"
+	run_cmd "bridge -n $sw1 fdb replace $dmac dev swp1 master static vlan 10"
 
-	run_cmd "tc -n sw2 qdisc replace dev vx0 clsact"
-	run_cmd "tc -n sw2 filter replace dev vx0 ingress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac enc_key_id 10010 enc_dst_ip 192.0.2.34 action pass"
+	run_cmd "tc -n $sw2 qdisc replace dev vx0 clsact"
+	run_cmd "tc -n $sw2 filter replace dev vx0 ingress pref 1 handle 101 proto ip flower src_mac $smac dst_mac $dmac enc_key_id 10010 enc_dst_ip 192.0.2.34 action pass"
 
 	# First, check that redirection works.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_port vx0"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_port vx0\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_port vx0"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_port vx0\""
 	log_test $? 0 "vx0 configured as backup port of swp1"
 
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 10"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_nhid 10\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 10"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_nhid 10\""
 	log_test $? 0 "Valid nexthop as backup nexthop"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 0
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 0
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 1
+	tc_check_packets $sw1 "dev vx0 egress" 101 1
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "Forwarding using backup nexthop ID"
-	run_cmd "ip -n sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $tx_drop'"
+	run_cmd "ip -n $sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $tx_drop'"
 	log_test $? 0 "No Tx drop increase"
 
 	# Use a non-existent nexthop ID.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 20"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_nhid 20\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 20"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_nhid 20\""
 	log_test $? 0 "Non-existent nexthop as backup nexthop"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 0
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 0
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 2
+	tc_check_packets $sw1 "dev vx0 egress" 101 2
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	run_cmd "ip -n sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 1))'"
+	run_cmd "ip -n $sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 1))'"
 	log_test $? 0 "Tx drop increased"
 
 	# Use a blckhole nexthop.
-	run_cmd "ip -n sw1 nexthop replace id 30 blackhole"
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 30"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_nhid 30\""
+	run_cmd "ip -n $sw1 nexthop replace id 30 blackhole"
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 30"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_nhid 30\""
 	log_test $? 0 "Blackhole nexthop as backup nexthop"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 0
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 0
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 3
+	tc_check_packets $sw1 "dev vx0 egress" 101 3
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	run_cmd "ip -n sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 2))'"
+	run_cmd "ip -n $sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 2))'"
 	log_test $? 0 "Tx drop increased"
 
 	# Non-group FDB nexthop.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 1"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_nhid 1\""
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 1"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_nhid 1\""
 	log_test $? 0 "Non-group FDB nexthop as backup nexthop"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 0
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 0
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 4
+	tc_check_packets $sw1 "dev vx0 egress" 101 4
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	run_cmd "ip -n sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 3))'"
+	run_cmd "ip -n $sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 3))'"
 	log_test $? 0 "Tx drop increased"
 
 	# IPv6 address family nexthop.
-	run_cmd "ip -n sw1 nexthop replace id 100 via 2001:db8:100::1 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 200 via 2001:db8:100::1 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 300 group 100/200 fdb"
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 300"
-	run_cmd "bridge -n sw1 -d link show dev swp1 | grep \"backup_nhid 300\""
+	run_cmd "ip -n $sw1 nexthop replace id 100 via 2001:db8:100::1 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 200 via 2001:db8:100::1 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 300 group 100/200 fdb"
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 300"
+	run_cmd "bridge -n $sw1 -d link show dev swp1 | grep \"backup_nhid 300\""
 	log_test $? 0 "IPv6 address family nexthop as backup nexthop"
 
-	run_cmd "ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
-	tc_check_packets sw1 "dev swp1 egress" 101 0
+	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
+	tc_check_packets $sw1 "dev swp1 egress" 101 0
 	log_test $? 0 "No forwarding out of swp1"
-	tc_check_packets sw1 "dev vx0 egress" 101 5
+	tc_check_packets $sw1 "dev vx0 egress" 101 5
 	log_test $? 0 "Forwarding out of vx0"
-	tc_check_packets sw2 "dev vx0 ingress" 101 1
+	tc_check_packets $sw2 "dev vx0 ingress" 101 1
 	log_test $? 0 "No forwarding using backup nexthop ID"
-	run_cmd "ip -n sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 4))'"
+	run_cmd "ip -n $sw1 -s -j link show dev vx0 | jq -e '.[][\"stats64\"][\"tx\"][\"dropped\"] == $((tx_drop + 4))'"
 	log_test $? 0 "Tx drop increased"
 }
 
@@ -591,44 +584,44 @@ backup_nhid_ping()
 	echo "------------------------"
 
 	# Test bidirectional traffic when traffic is redirected in both VTEPs.
-	sw1_mac=$(ip -n sw1 -j -p link show br0.10 | jq -r '.[]["address"]')
-	sw2_mac=$(ip -n sw2 -j -p link show br0.10 | jq -r '.[]["address"]')
+	sw1_mac=$(ip -n $sw1 -j -p link show br0.10 | jq -r '.[]["address"]')
+	sw2_mac=$(ip -n $sw2 -j -p link show br0.10 | jq -r '.[]["address"]')
 
-	run_cmd "bridge -n sw1 fdb replace $sw2_mac dev swp1 master static vlan 10"
-	run_cmd "bridge -n sw2 fdb replace $sw1_mac dev swp1 master static vlan 10"
+	run_cmd "bridge -n $sw1 fdb replace $sw2_mac dev swp1 master static vlan 10"
+	run_cmd "bridge -n $sw2 fdb replace $sw1_mac dev swp1 master static vlan 10"
 
-	run_cmd "ip -n sw1 neigh replace 192.0.2.66 lladdr $sw2_mac nud perm dev br0.10"
-	run_cmd "ip -n sw2 neigh replace 192.0.2.65 lladdr $sw1_mac nud perm dev br0.10"
+	run_cmd "ip -n $sw1 neigh replace 192.0.2.66 lladdr $sw2_mac nud perm dev br0.10"
+	run_cmd "ip -n $sw2 neigh replace 192.0.2.65 lladdr $sw1_mac nud perm dev br0.10"
 
-	run_cmd "ip -n sw1 nexthop replace id 1 via 192.0.2.34 fdb"
-	run_cmd "ip -n sw2 nexthop replace id 1 via 192.0.2.33 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 10 group 1 fdb"
-	run_cmd "ip -n sw2 nexthop replace id 10 group 1 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 1 via 192.0.2.34 fdb"
+	run_cmd "ip -n $sw2 nexthop replace id 1 via 192.0.2.33 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 10 group 1 fdb"
+	run_cmd "ip -n $sw2 nexthop replace id 10 group 1 fdb"
 
-	run_cmd "bridge -n sw1 link set dev swp1 backup_port vx0"
-	run_cmd "bridge -n sw2 link set dev swp1 backup_port vx0"
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 10"
-	run_cmd "bridge -n sw2 link set dev swp1 backup_nhid 10"
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_port vx0"
+	run_cmd "bridge -n $sw2 link set dev swp1 backup_port vx0"
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 10"
+	run_cmd "bridge -n $sw2 link set dev swp1 backup_nhid 10"
 
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
-	run_cmd "ip -n sw2 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	run_cmd "ip -n $sw2 link set dev swp1 carrier off"
 
-	run_cmd "ip netns exec sw1 ping -i 0.1 -c 10 -w $PING_TIMEOUT 192.0.2.66"
+	run_cmd "ip netns exec $sw1 ping -i 0.1 -c 10 -w $PING_TIMEOUT 192.0.2.66"
 	log_test $? 0 "Ping with backup nexthop ID"
 
 	# Reset the backup nexthop ID to 0 and check that ping fails.
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 0"
-	run_cmd "bridge -n sw2 link set dev swp1 backup_nhid 0"
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 0"
+	run_cmd "bridge -n $sw2 link set dev swp1 backup_nhid 0"
 
-	run_cmd "ip netns exec sw1 ping -i 0.1 -c 10 -w $PING_TIMEOUT 192.0.2.66"
+	run_cmd "ip netns exec $sw1 ping -i 0.1 -c 10 -w $PING_TIMEOUT 192.0.2.66"
 	log_test $? 1 "Ping after disabling backup nexthop ID"
 }
 
 backup_nhid_add_del_loop()
 {
 	while true; do
-		ip -n sw1 nexthop del id 10
-		ip -n sw1 nexthop replace id 10 group 1/2 fdb
+		ip -n $sw1 nexthop del id 10
+		ip -n $sw1 nexthop replace id 10 group 1/2 fdb
 	done >/dev/null 2>&1
 }
 
@@ -648,19 +641,19 @@ backup_nhid_torture()
 	# deleting the group. The test is considered successful if nothing
 	# crashed.
 
-	run_cmd "ip -n sw1 nexthop replace id 1 via 192.0.2.34 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 2 via 192.0.2.34 fdb"
-	run_cmd "ip -n sw1 nexthop replace id 10 group 1/2 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 1 via 192.0.2.34 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 2 via 192.0.2.34 fdb"
+	run_cmd "ip -n $sw1 nexthop replace id 10 group 1/2 fdb"
 
-	run_cmd "bridge -n sw1 fdb replace $dmac dev swp1 master static vlan 10"
+	run_cmd "bridge -n $sw1 fdb replace $dmac dev swp1 master static vlan 10"
 
-	run_cmd "bridge -n sw1 link set dev swp1 backup_port vx0"
-	run_cmd "bridge -n sw1 link set dev swp1 backup_nhid 10"
-	run_cmd "ip -n sw1 link set dev swp1 carrier off"
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_port vx0"
+	run_cmd "bridge -n $sw1 link set dev swp1 backup_nhid 10"
+	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 
 	backup_nhid_add_del_loop &
 	pid1=$!
-	ip netns exec sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 0 &
+	ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 0 &
 	pid2=$!
 
 	sleep 30
-- 
2.43.0


