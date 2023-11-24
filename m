Return-Path: <linux-kselftest+bounces-514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE27F6F9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1D31C20FCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97F1429F;
	Fri, 24 Nov 2023 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXvMVpXW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE1130;
	Fri, 24 Nov 2023 01:28:46 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c25dfc0aeaso1066437a12.2;
        Fri, 24 Nov 2023 01:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818125; x=1701422925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0LFCllm6KaSmjP5XoK9DwcQnHUpwhi3Br8LbJyE+SM=;
        b=bXvMVpXWeowGvK14JtV0wIbb5xik9o7RPGt3GY8PqIuz6kqeujNg6NFA1oSA/lO47w
         XL8wzz2AZTi3knQLRryPa9xOHo8DqJiqI3j3dEXp1qEvmN/AJDQrCvOwzNRngqtmQbIb
         pNwfckXTQJ0MQMpFaGTvTkNa2IX8xXNLY2qnsEPkL3//D9oi+3Btc0NbbEoRFii+kjqd
         ONGtt/DcdmIC6wpDP9Y3ir8Gp9HoNlWujVHxGYd1C5dDF+N32q5dUa7ogSqaEqzpe9ik
         A2QXE60LpW672i9oGGBmX87ffX3H6kCqMQynIAjXbmNxAy3CvKN3CxHp4AVjEis/48dU
         qV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818125; x=1701422925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0LFCllm6KaSmjP5XoK9DwcQnHUpwhi3Br8LbJyE+SM=;
        b=K6BNFKe8Xm6IiApmsIQEgGNKr4MQ9q2nAx3JlzZxmirWRfhAmJnD1T0+tucd1pCnoh
         7Iwlj1z5PwSEiijmaDa0dMoVSzEtQ+19IDJ4IrF74QwhQ4DEAjTwszWtwsRRShzVRI4G
         FlG0fU3OdVJx12Dadv6s3UkB4XTwKuOykulWFoUh8ijk5e9+VNjxnlaTPypwgLIzBmkB
         HuXX7kWSFjg8gMTQOYNCg/WPdmucu3s8IClilw+zHN0G5Fmb54eFrC9mEC6PZ06OOXOl
         0cR2mBeoicAlBkAaNRqooh1fo9/T3fgaJ2dskHxhEX7CrkcGag8bPlvdszyr8/gLm0tV
         UVag==
X-Gm-Message-State: AOJu0YxtvQ7JCEbqcd6HKNRG7AdqmbohN9YfMAzdThplss+BGK2yj5X1
	XsGffoYF7YcshPtzD6w9ksIAnxBuvPTITyGE
X-Google-Smtp-Source: AGHT+IGYwCLuuDe8yeOMajQcg0LS+p72RMDzGBjZkqATrfE1nr/+X8yKN5QB7s8pCnUelga3RndEog==
X-Received: by 2002:a05:6a20:4425:b0:18b:cb93:ebd9 with SMTP id ce37-20020a056a20442500b0018bcb93ebd9mr2376667pzb.54.1700818125256;
        Fri, 24 Nov 2023 01:28:45 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:44 -0800 (PST)
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
Subject: [PATCH net-next 12/38] selftests/net: convert fib_tests.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:10 +0800
Message-ID: <20231124092736.3673263-13-liuhangbin@gmail.com>
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

]# ./fib_tests.sh

Single path route test
    Start point
    TEST: IPv4 fibmatch                                                 [ OK ]

...

Fib6 garbage collection test
    TEST: ipv6 route garbage collection                                 [ OK ]

IPv4 multipath list receive tests
    TEST: Multipath route hit ratio (1.00)                              [ OK ]

IPv6 multipath list receive tests
    TEST: Multipath route hit ratio (1.00)                              [ OK ]

Tests passed: 225
Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 184 +++++++++++------------
 1 file changed, 87 insertions(+), 97 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 66d0db7a2614..b3ecccbbfcd2 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -3,10 +3,8 @@
 
 # This test is for checking IPv4 and IPv6 FIB behavior in response to
 # different events.
-
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
 TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
@@ -18,8 +16,6 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
 VERBOSE=0
 PAUSE_ON_FAIL=no
 PAUSE=no
-IP="$(which ip) -netns ns1"
-NS_EXEC="$(which ip) netns exec ns1"
 
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
@@ -55,11 +51,11 @@ log_test()
 setup()
 {
 	set -e
-	ip netns add ns1
-	ip netns set ns1 auto
-	$IP link set dev lo up
-	ip netns exec ns1 sysctl -qw net.ipv4.ip_forward=1
-	ip netns exec ns1 sysctl -qw net.ipv6.conf.all.forwarding=1
+	setup_ns ns1
+	IP="$(which ip) -netns $ns1"
+	NS_EXEC="$(which ip) netns exec $ns1"
+	ip netns exec $ns1 sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec $ns1 sysctl -qw net.ipv6.conf.all.forwarding=1
 
 	$IP link add dummy0 type dummy
 	$IP link set dev dummy0 up
@@ -72,8 +68,7 @@ setup()
 cleanup()
 {
 	$IP link del dev dummy0 &> /dev/null
-	ip netns del ns1 &> /dev/null
-	ip netns del ns2 &> /dev/null
+	cleanup_ns $ns1 $ns2
 }
 
 get_linklocal()
@@ -448,28 +443,25 @@ fib_rp_filter_test()
 	setup
 
 	set -e
-	ip netns add ns2
-	ip netns set ns2 auto
-
-	ip -netns ns2 link set dev lo up
+	setup_ns ns2
 
 	$IP link add name veth1 type veth peer name veth2
-	$IP link set dev veth2 netns ns2
+	$IP link set dev veth2 netns $ns2
 	$IP address add 192.0.2.1/24 dev veth1
-	ip -netns ns2 address add 192.0.2.1/24 dev veth2
+	ip -netns $ns2 address add 192.0.2.1/24 dev veth2
 	$IP link set dev veth1 up
-	ip -netns ns2 link set dev veth2 up
+	ip -netns $ns2 link set dev veth2 up
 
 	$IP link set dev lo address 52:54:00:6a:c7:5e
 	$IP link set dev veth1 address 52:54:00:6a:c7:5e
-	ip -netns ns2 link set dev lo address 52:54:00:6a:c7:5e
-	ip -netns ns2 link set dev veth2 address 52:54:00:6a:c7:5e
+	ip -netns $ns2 link set dev lo address 52:54:00:6a:c7:5e
+	ip -netns $ns2 link set dev veth2 address 52:54:00:6a:c7:5e
 
 	# 1. (ns2) redirect lo's egress to veth2's egress
-	ip netns exec ns2 tc qdisc add dev lo parent root handle 1: fq_codel
-	ip netns exec ns2 tc filter add dev lo parent 1: protocol arp basic \
+	ip netns exec $ns2 tc qdisc add dev lo parent root handle 1: fq_codel
+	ip netns exec $ns2 tc filter add dev lo parent 1: protocol arp basic \
 		action mirred egress redirect dev veth2
-	ip netns exec ns2 tc filter add dev lo parent 1: protocol ip basic \
+	ip netns exec $ns2 tc filter add dev lo parent 1: protocol ip basic \
 		action mirred egress redirect dev veth2
 
 	# 2. (ns1) redirect veth1's ingress to lo's ingress
@@ -487,24 +479,24 @@ fib_rp_filter_test()
 		action mirred egress redirect dev veth1
 
 	# 4. (ns2) redirect veth2's ingress to lo's ingress
-	ip netns exec ns2 tc qdisc add dev veth2 ingress
-	ip netns exec ns2 tc filter add dev veth2 ingress protocol arp basic \
+	ip netns exec $ns2 tc qdisc add dev veth2 ingress
+	ip netns exec $ns2 tc filter add dev veth2 ingress protocol arp basic \
 		action mirred ingress redirect dev lo
-	ip netns exec ns2 tc filter add dev veth2 ingress protocol ip basic \
+	ip netns exec $ns2 tc filter add dev veth2 ingress protocol ip basic \
 		action mirred ingress redirect dev lo
 
 	$NS_EXEC sysctl -qw net.ipv4.conf.all.rp_filter=1
 	$NS_EXEC sysctl -qw net.ipv4.conf.all.accept_local=1
 	$NS_EXEC sysctl -qw net.ipv4.conf.all.route_localnet=1
-	ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=1
-	ip netns exec ns2 sysctl -qw net.ipv4.conf.all.accept_local=1
-	ip netns exec ns2 sysctl -qw net.ipv4.conf.all.route_localnet=1
+	ip netns exec $ns2 sysctl -qw net.ipv4.conf.all.rp_filter=1
+	ip netns exec $ns2 sysctl -qw net.ipv4.conf.all.accept_local=1
+	ip netns exec $ns2 sysctl -qw net.ipv4.conf.all.route_localnet=1
 	set +e
 
-	run_cmd "ip netns exec ns2 ping -w1 -c1 192.0.2.1"
+	run_cmd "ip netns exec $ns2 ping -w1 -c1 192.0.2.1"
 	log_test $? 0 "rp_filter passes local packets"
 
-	run_cmd "ip netns exec ns2 ping -w1 -c1 127.0.0.1"
+	run_cmd "ip netns exec $ns2 ping -w1 -c1 127.0.0.1"
 	log_test $? 0 "rp_filter passes loopback packets"
 
 	cleanup
@@ -959,34 +951,32 @@ route_setup()
 	[ "${VERBOSE}" = "1" ] && set -x
 	set -e
 
-	ip netns add ns2
-	ip netns set ns2 auto
-	ip -netns ns2 link set dev lo up
-	ip netns exec ns2 sysctl -qw net.ipv4.ip_forward=1
-	ip netns exec ns2 sysctl -qw net.ipv6.conf.all.forwarding=1
+	setup_ns ns2
+	ip netns exec $ns2 sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec $ns2 sysctl -qw net.ipv6.conf.all.forwarding=1
 
 	$IP li add veth1 type veth peer name veth2
 	$IP li add veth3 type veth peer name veth4
 
 	$IP li set veth1 up
 	$IP li set veth3 up
-	$IP li set veth2 netns ns2 up
-	$IP li set veth4 netns ns2 up
-	ip -netns ns2 li add dummy1 type dummy
-	ip -netns ns2 li set dummy1 up
+	$IP li set veth2 netns $ns2 up
+	$IP li set veth4 netns $ns2 up
+	ip -netns $ns2 li add dummy1 type dummy
+	ip -netns $ns2 li set dummy1 up
 
 	$IP -6 addr add 2001:db8:101::1/64 dev veth1 nodad
 	$IP -6 addr add 2001:db8:103::1/64 dev veth3 nodad
 	$IP addr add 172.16.101.1/24 dev veth1
 	$IP addr add 172.16.103.1/24 dev veth3
 
-	ip -netns ns2 -6 addr add 2001:db8:101::2/64 dev veth2 nodad
-	ip -netns ns2 -6 addr add 2001:db8:103::2/64 dev veth4 nodad
-	ip -netns ns2 -6 addr add 2001:db8:104::1/64 dev dummy1 nodad
+	ip -netns $ns2 -6 addr add 2001:db8:101::2/64 dev veth2 nodad
+	ip -netns $ns2 -6 addr add 2001:db8:103::2/64 dev veth4 nodad
+	ip -netns $ns2 -6 addr add 2001:db8:104::1/64 dev dummy1 nodad
 
-	ip -netns ns2 addr add 172.16.101.2/24 dev veth2
-	ip -netns ns2 addr add 172.16.103.2/24 dev veth4
-	ip -netns ns2 addr add 172.16.104.1/24 dev dummy1
+	ip -netns $ns2 addr add 172.16.101.2/24 dev veth2
+	ip -netns $ns2 addr add 172.16.103.2/24 dev veth4
+	ip -netns $ns2 addr add 172.16.104.1/24 dev dummy1
 
 	set +e
 }
@@ -1238,7 +1228,7 @@ ipv6_addr_metric_test()
 	log_test $rc 0 "Modify metric of address"
 
 	# verify prefix route removed on down
-	run_cmd "ip netns exec ns1 sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1"
+	run_cmd "ip netns exec $ns1 sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1"
 	run_cmd "$IP li set dev dummy2 down"
 	rc=$?
 	if [ $rc -eq 0 ]; then
@@ -1344,7 +1334,7 @@ ipv6_route_metrics_test()
 	log_test $rc 0 "Multipath route with mtu metric"
 
 	$IP -6 ro add 2001:db8:104::/64 via 2001:db8:101::2 mtu 1300
-	run_cmd "ip netns exec ns1 ${ping6} -w1 -c1 -s 1500 2001:db8:104::1"
+	run_cmd "ip netns exec $ns1 ${ping6} -w1 -c1 -s 1500 2001:db8:104::1"
 	log_test $? 0 "Using route with mtu metric"
 
 	run_cmd "$IP -6 ro add 2001:db8:114::/64 via  2001:db8:101::2  congctl lock foo"
@@ -1599,19 +1589,19 @@ ipv4_rt_replace()
 ipv4_local_rt_cache()
 {
 	run_cmd "ip addr add 10.0.0.1/32 dev lo"
-	run_cmd "ip netns add test-ns"
+	run_cmd "setup_ns test-ns"
 	run_cmd "ip link add veth-outside type veth peer name veth-inside"
 	run_cmd "ip link add vrf-100 type vrf table 1100"
 	run_cmd "ip link set veth-outside master vrf-100"
-	run_cmd "ip link set veth-inside netns test-ns"
+	run_cmd "ip link set veth-inside netns $test-ns"
 	run_cmd "ip link set veth-outside up"
 	run_cmd "ip link set vrf-100 up"
 	run_cmd "ip route add 10.1.1.1/32 dev veth-outside table 1100"
-	run_cmd "ip netns exec test-ns ip link set veth-inside up"
-	run_cmd "ip netns exec test-ns ip addr add 10.1.1.1/32 dev veth-inside"
-	run_cmd "ip netns exec test-ns ip route add 10.0.0.1/32 dev veth-inside"
-	run_cmd "ip netns exec test-ns ip route add default via 10.0.0.1"
-	run_cmd "ip netns exec test-ns ping 10.0.0.1 -c 1 -i 1"
+	run_cmd "ip netns exec $test-ns ip link set veth-inside up"
+	run_cmd "ip netns exec $test-ns ip addr add 10.1.1.1/32 dev veth-inside"
+	run_cmd "ip netns exec $test-ns ip route add 10.0.0.1/32 dev veth-inside"
+	run_cmd "ip netns exec $test-ns ip route add default via 10.0.0.1"
+	run_cmd "ip netns exec $test-ns ping 10.0.0.1 -c 1 -i 1"
 	run_cmd "ip link delete vrf-100"
 
 	# if we do not hang test is a success
@@ -1841,7 +1831,7 @@ ipv4_route_metrics_test()
 	log_test $rc 0 "Multipath route with mtu metric"
 
 	$IP ro add 172.16.104.0/24 via 172.16.101.2 mtu 1300
-	run_cmd "ip netns exec ns1 ping -w1 -c1 -s 1500 172.16.104.1"
+	run_cmd "ip netns exec $ns1 ping -w1 -c1 -s 1500 172.16.104.1"
 	log_test $? 0 "Using route with mtu metric"
 
 	run_cmd "$IP ro add 172.16.111.0/24 via 172.16.101.2 congctl lock foo"
@@ -2105,7 +2095,7 @@ ipv4_route_v6_gw_test()
 		check_route "172.16.104.0/24 via inet6 2001:db8:101::2 dev veth1"
 	fi
 
-	run_cmd "ip netns exec ns1 ping -w1 -c1 172.16.104.1"
+	run_cmd "ip netns exec $ns1 ping -w1 -c1 172.16.104.1"
 	log_test $rc 0 "Single path route with IPv6 gateway - ping"
 
 	run_cmd "$IP ro del 172.16.104.0/24 via inet6 2001:db8:101::2"
@@ -2196,7 +2186,7 @@ ipv4_mangle_test()
 	sleep 2
 
 	local tmp_file=$(mktemp)
-	ip netns exec ns2 socat UDP4-LISTEN:54321,fork $tmp_file &
+	ip netns exec $ns2 socat UDP4-LISTEN:54321,fork $tmp_file &
 
 	# Add a FIB rule and a route that will direct our connection to the
 	# listening server.
@@ -2254,7 +2244,7 @@ ipv6_mangle_test()
 	sleep 2
 
 	local tmp_file=$(mktemp)
-	ip netns exec ns2 socat UDP6-LISTEN:54321,fork $tmp_file &
+	ip netns exec $ns2 socat UDP6-LISTEN:54321,fork $tmp_file &
 
 	# Add a FIB rule and a route that will direct our connection to the
 	# listening server.
@@ -2423,37 +2413,37 @@ ipv4_mpath_list_test()
 	route_setup
 
 	set -e
-	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
-
-	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
-	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
-	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
-	run_cmd "ip -n ns2 link add name nh1 up type dummy"
-	run_cmd "ip -n ns2 link add name nh2 up type dummy"
-	run_cmd "ip -n ns2 address add 172.16.201.1/24 dev nh1"
-	run_cmd "ip -n ns2 address add 172.16.202.1/24 dev nh2"
-	run_cmd "ip -n ns2 neigh add 172.16.201.2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
-	run_cmd "ip -n ns2 neigh add 172.16.202.2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
-	run_cmd "ip -n ns2 route add 203.0.113.0/24
+	run_cmd "ip netns exec $ns1 ethtool -K veth1 tcp-segmentation-offload off"
+
+	run_cmd "ip netns exec $ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
+	run_cmd "ip netns exec $ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
+	run_cmd "ip netns exec $ns2 ethtool -K veth2 generic-receive-offload on"
+	run_cmd "ip -n $ns2 link add name nh1 up type dummy"
+	run_cmd "ip -n $ns2 link add name nh2 up type dummy"
+	run_cmd "ip -n $ns2 address add 172.16.201.1/24 dev nh1"
+	run_cmd "ip -n $ns2 address add 172.16.202.1/24 dev nh2"
+	run_cmd "ip -n $ns2 neigh add 172.16.201.2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
+	run_cmd "ip -n $ns2 neigh add 172.16.202.2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
+	run_cmd "ip -n $ns2 route add 203.0.113.0/24
 		nexthop via 172.16.201.2 nexthop via 172.16.202.2"
-	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
-	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.veth2.rp_filter=0"
-	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0"
-	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.conf.default.rp_filter=0"
+	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
+	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.veth2.rp_filter=0"
+	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0"
+	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.default.rp_filter=0"
 	set +e
 
-	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
+	local dmac=$(ip -n $ns2 -j link show dev veth2 | jq -r '.[]["address"]')
 	local tmp_file=$(mktemp)
-	local cmd="ip netns exec ns1 mausezahn veth1 -a own -b $dmac
+	local cmd="ip netns exec $ns1 mausezahn veth1 -a own -b $dmac
 		-A 172.16.101.1 -B 203.0.113.1 -t udp 'sp=12345,dp=0-65535' -q"
 
 	# Packets forwarded in a list using a multipath route must not reuse a
 	# cached result so that a flow always hits the same nexthop. In other
 	# words, the FIB lookup tracepoint needs to be triggered for every
 	# packet.
-	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	local t0_rx_pkts=$(link_stats_get $ns2 veth2 rx packets)
 	run_cmd "perf stat -a -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
-	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	local t1_rx_pkts=$(link_stats_get $ns2 veth2 rx packets)
 	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
 	list_rcv_eval $tmp_file $diff
 
@@ -2471,34 +2461,34 @@ ipv6_mpath_list_test()
 	route_setup
 
 	set -e
-	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
-
-	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
-	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
-	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
-	run_cmd "ip -n ns2 link add name nh1 up type dummy"
-	run_cmd "ip -n ns2 link add name nh2 up type dummy"
-	run_cmd "ip -n ns2 -6 address add 2001:db8:201::1/64 dev nh1"
-	run_cmd "ip -n ns2 -6 address add 2001:db8:202::1/64 dev nh2"
-	run_cmd "ip -n ns2 -6 neigh add 2001:db8:201::2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
-	run_cmd "ip -n ns2 -6 neigh add 2001:db8:202::2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
-	run_cmd "ip -n ns2 -6 route add 2001:db8:301::/64
+	run_cmd "ip netns exec $ns1 ethtool -K veth1 tcp-segmentation-offload off"
+
+	run_cmd "ip netns exec $ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
+	run_cmd "ip netns exec $ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
+	run_cmd "ip netns exec $ns2 ethtool -K veth2 generic-receive-offload on"
+	run_cmd "ip -n $ns2 link add name nh1 up type dummy"
+	run_cmd "ip -n $ns2 link add name nh2 up type dummy"
+	run_cmd "ip -n $ns2 -6 address add 2001:db8:201::1/64 dev nh1"
+	run_cmd "ip -n $ns2 -6 address add 2001:db8:202::1/64 dev nh2"
+	run_cmd "ip -n $ns2 -6 neigh add 2001:db8:201::2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
+	run_cmd "ip -n $ns2 -6 neigh add 2001:db8:202::2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
+	run_cmd "ip -n $ns2 -6 route add 2001:db8:301::/64
 		nexthop via 2001:db8:201::2 nexthop via 2001:db8:202::2"
-	run_cmd "ip netns exec ns2 sysctl -qw net.ipv6.fib_multipath_hash_policy=1"
+	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv6.fib_multipath_hash_policy=1"
 	set +e
 
-	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
+	local dmac=$(ip -n $ns2 -j link show dev veth2 | jq -r '.[]["address"]')
 	local tmp_file=$(mktemp)
-	local cmd="ip netns exec ns1 mausezahn -6 veth1 -a own -b $dmac
+	local cmd="ip netns exec $ns1 mausezahn -6 veth1 -a own -b $dmac
 		-A 2001:db8:101::1 -B 2001:db8:301::1 -t udp 'sp=12345,dp=0-65535' -q"
 
 	# Packets forwarded in a list using a multipath route must not reuse a
 	# cached result so that a flow always hits the same nexthop. In other
 	# words, the FIB lookup tracepoint needs to be triggered for every
 	# packet.
-	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	local t0_rx_pkts=$(link_stats_get $ns2 veth2 rx packets)
 	run_cmd "perf stat -a -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
-	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
+	local t1_rx_pkts=$(link_stats_get $ns2 veth2 rx packets)
 	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
 	list_rcv_eval $tmp_file $diff
 
-- 
2.41.0


