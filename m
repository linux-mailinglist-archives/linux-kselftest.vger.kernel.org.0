Return-Path: <linux-kselftest+bounces-1803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53088109E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC2282125
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6196F9F7;
	Wed, 13 Dec 2023 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG5Nnhyq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB0E3;
	Tue, 12 Dec 2023 22:09:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso5420654a12.0;
        Tue, 12 Dec 2023 22:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447785; x=1703052585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8zHiBqrjdqc07oJD8uG4EanK/Jlyf1+IaXu/Qmbwk8=;
        b=QG5NnhyqZkvFpsLCx6tQfyaoknDdOzbYkc7Fuz+gnB+GBbYGE7SCRI2KKBVRDCeu1c
         q9rZHdnPjxFpmOrVsKgq0YVMlvipsx69F7GwNeU3CBuz3JUA+oj9Xpud4+SCHCxOV7yX
         wfpPwuGF/BhhqXqU9jMWq2YsRZwehuA9OjUrVddqk9spfL35HusPR+bmG/pcqGF/diev
         eC8i7o+FT56K5V7PY3nd4v0YTaXwtJbb//WPsRs19g7imBxz+HUO1PdacOYFCvK7S8U6
         wQM7UaUBltzFNRuQw6mLW0AgfvV7XPN+ib4zDaI7aWqORkQQ6utQUdHX4Uu5ZAowfqPT
         OPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447785; x=1703052585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8zHiBqrjdqc07oJD8uG4EanK/Jlyf1+IaXu/Qmbwk8=;
        b=TnXDIpGl3ES3UqwA+2OjlQxYc4AWzFS+zQkJxthJO9mS+B8azoO2NcOREWgDhGapIn
         F3rYPxbfN3GiqfpvwR2yfDaR5Ojw30lCMfdWneIYPbXZpll7mCX8P+cXDA34tpVLm7FQ
         29b3eiTtmqRQUe3yl0YqHp2ncLu9rX8TzBNEcqDPl+hKol9CuvUJSD2RaNdfbTCF3TEo
         OzSFKhCc2bF8WlwdbTf2cuwHeUv+Q0fTqgsEre1nBiU2+4mY9bNOGvm//EBoVLbU5qL/
         ma0IpWCsBnreMMzNf5MRYxwKv+m4M1H7h8DPGwIE1SlTwLXE4jdlVhx+mAm7Y3h5ZoGK
         oEcg==
X-Gm-Message-State: AOJu0YzCxjBaceAB5QrMi0MNmt5bmzwcWBY2DSs8/GvlEdEzqsjQE/+q
	K0bfXb8huLnIP5hfFzHRV0Z0dB++BnPO8GV0/ag=
X-Google-Smtp-Source: AGHT+IE7um+a6e5uN6KaHw/xtNN0+Fk9zilaUIB/PaY4q2I9e26rw+PgZuD08djQXOSDLltfuRiIWw==
X-Received: by 2002:a05:6a20:3ca6:b0:18b:d207:d857 with SMTP id b38-20020a056a203ca600b0018bd207d857mr10827990pzj.11.1702447784696;
        Tue, 12 Dec 2023 22:09:44 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:44 -0800 (PST)
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
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Amit Cohen <amcohen@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 09/13] selftests/net: convert fib_nexthops.sh to run it in unique namespace
Date: Wed, 13 Dec 2023 14:08:52 +0800
Message-ID: <20231213060856.4030084-10-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213060856.4030084-1-liuhangbin@gmail.com>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

 ]# ./fib_nexthops.sh

 Basic functional tests
 ----------------------
 TEST: List with nothing defined                                     [ OK ]
 TEST: Nexthop get on non-existent id                                [ OK ]

 ...

 TEST: IPv6 resilient nexthop group torture test                     [ OK ]

 Tests passed: 234
 Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 142 ++++++++++----------
 1 file changed, 69 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index a6f2c0b9555d..d5a281aadbac 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -14,6 +14,7 @@
 # objects. Device reference counts and network namespace cleanup tested
 # by use of network namespace for peer.
 
+source lib.sh
 ret=0
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -148,13 +149,7 @@ create_ns()
 {
 	local n=${1}
 
-	ip netns del ${n} 2>/dev/null
-
 	set -e
-	ip netns add ${n}
-	ip netns set ${n} $((nsid++))
-	ip -netns ${n} addr add 127.0.0.1/8 dev lo
-	ip -netns ${n} link set lo up
 
 	ip netns exec ${n} sysctl -qw net.ipv4.ip_forward=1
 	ip netns exec ${n} sysctl -qw net.ipv4.fib_multipath_use_neigh=1
@@ -173,12 +168,13 @@ setup()
 {
 	cleanup
 
-	create_ns me
-	create_ns peer
-	create_ns remote
+	setup_ns me peer remote
+	create_ns $me
+	create_ns $peer
+	create_ns $remote
 
-	IP="ip -netns me"
-	BRIDGE="bridge -netns me"
+	IP="ip -netns $me"
+	BRIDGE="bridge -netns $me"
 	set -e
 	$IP li add veth1 type veth peer name veth2
 	$IP li set veth1 up
@@ -190,24 +186,24 @@ setup()
 	$IP addr add 172.16.2.1/24 dev veth3
 	$IP -6 addr add 2001:db8:92::1/64 dev veth3 nodad
 
-	$IP li set veth2 netns peer up
-	ip -netns peer addr add 172.16.1.2/24 dev veth2
-	ip -netns peer -6 addr add 2001:db8:91::2/64 dev veth2 nodad
+	$IP li set veth2 netns $peer up
+	ip -netns $peer addr add 172.16.1.2/24 dev veth2
+	ip -netns $peer -6 addr add 2001:db8:91::2/64 dev veth2 nodad
 
-	$IP li set veth4 netns peer up
-	ip -netns peer addr add 172.16.2.2/24 dev veth4
-	ip -netns peer -6 addr add 2001:db8:92::2/64 dev veth4 nodad
+	$IP li set veth4 netns $peer up
+	ip -netns $peer addr add 172.16.2.2/24 dev veth4
+	ip -netns $peer -6 addr add 2001:db8:92::2/64 dev veth4 nodad
 
-	ip -netns remote li add veth5 type veth peer name veth6
-	ip -netns remote li set veth5 up
-	ip -netns remote addr add dev veth5 172.16.101.1/24
-	ip -netns remote -6 addr add dev veth5 2001:db8:101::1/64 nodad
-	ip -netns remote ro add 172.16.0.0/22 via 172.16.101.2
-	ip -netns remote -6 ro add 2001:db8:90::/40 via 2001:db8:101::2
+	ip -netns $remote li add veth5 type veth peer name veth6
+	ip -netns $remote li set veth5 up
+	ip -netns $remote addr add dev veth5 172.16.101.1/24
+	ip -netns $remote -6 addr add dev veth5 2001:db8:101::1/64 nodad
+	ip -netns $remote ro add 172.16.0.0/22 via 172.16.101.2
+	ip -netns $remote -6 ro add 2001:db8:90::/40 via 2001:db8:101::2
 
-	ip -netns remote li set veth6 netns peer up
-	ip -netns peer addr add dev veth6 172.16.101.2/24
-	ip -netns peer -6 addr add dev veth6 2001:db8:101::2/64 nodad
+	ip -netns $remote li set veth6 netns $peer up
+	ip -netns $peer addr add dev veth6 172.16.101.2/24
+	ip -netns $peer -6 addr add dev veth6 2001:db8:101::2/64 nodad
 	set +e
 }
 
@@ -215,7 +211,7 @@ cleanup()
 {
 	local ns
 
-	for ns in me peer remote; do
+	for ns in $me $peer $remote; do
 		ip netns del ${ns} 2>/dev/null
 	done
 }
@@ -779,7 +775,7 @@ ipv6_grp_refs()
 	run_cmd "$IP route add 2001:db8:101::1/128 nhid 102"
 
 	# create per-cpu dsts through nh 100
-	run_cmd "ip netns exec me mausezahn -6 veth1.10 -B 2001:db8:101::1 -A 2001:db8:91::1 -c 5 -t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1"
+	run_cmd "ip netns exec $me mausezahn -6 veth1.10 -B 2001:db8:101::1 -A 2001:db8:91::1 -c 5 -t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1"
 
 	# remove nh 100 from the group to delete the route potentially leaving
 	# a stale per-cpu dst which holds a reference to the nexthop's net
@@ -805,7 +801,7 @@ ipv6_grp_refs()
 
 	# if a reference was lost this command will hang because the net device
 	# cannot be removed
-	timeout -s KILL 5 ip netns exec me ip link del veth1.10 >/dev/null 2>&1
+	timeout -s KILL 5 ip netns exec $me ip link del veth1.10 >/dev/null 2>&1
 
 	# we can't cleanup if the command is hung trying to delete the netdev
 	if [ $? -eq 137 ]; then
@@ -1012,13 +1008,13 @@ ipv6_fcnal_runtime()
 	log_test $? 0 "Route delete"
 
 	run_cmd "$IP ro add 2001:db8:101::1/128 nhid 81"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	log_test $? 0 "Ping with nexthop"
 
 	run_cmd "$IP nexthop add id 82 via 2001:db8:92::2 dev veth3"
 	run_cmd "$IP nexthop add id 122 group 81/82"
 	run_cmd "$IP ro replace 2001:db8:101::1/128 nhid 122"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	log_test $? 0 "Ping - multipath"
 
 	#
@@ -1026,26 +1022,26 @@ ipv6_fcnal_runtime()
 	#
 	run_cmd "$IP -6 nexthop add id 83 blackhole"
 	run_cmd "$IP ro replace 2001:db8:101::1/128 nhid 83"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	log_test $? 2 "Ping - blackhole"
 
 	run_cmd "$IP nexthop replace id 83 via 2001:db8:91::2 dev veth1"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	log_test $? 0 "Ping - blackhole replaced with gateway"
 
 	run_cmd "$IP -6 nexthop replace id 83 blackhole"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	log_test $? 2 "Ping - gateway replaced by blackhole"
 
 	run_cmd "$IP ro replace 2001:db8:101::1/128 nhid 122"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	if [ $? -eq 0 ]; then
 		run_cmd "$IP nexthop replace id 122 group 83"
-		run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+		run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 		log_test $? 2 "Ping - group with blackhole"
 
 		run_cmd "$IP nexthop replace id 122 group 81/82"
-		run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+		run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 		log_test $? 0 "Ping - group blackhole replaced with gateways"
 	else
 		log_test 2 0 "Ping - multipath failed"
@@ -1128,15 +1124,15 @@ ipv6_fcnal_runtime()
 
 	# rpfilter and default route
 	$IP nexthop flush >/dev/null 2>&1
-	run_cmd "ip netns exec me ip6tables -t mangle -I PREROUTING 1 -m rpfilter --invert -j DROP"
+	run_cmd "ip netns exec $me ip6tables -t mangle -I PREROUTING 1 -m rpfilter --invert -j DROP"
 	run_cmd "$IP nexthop add id 91 via 2001:db8:91::2 dev veth1"
 	run_cmd "$IP nexthop add id 92 via 2001:db8:92::2 dev veth3"
 	run_cmd "$IP nexthop add id 93 group 91/92"
 	run_cmd "$IP -6 ro add default nhid 91"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	log_test $? 0 "Nexthop with default route and rpfilter"
 	run_cmd "$IP -6 ro replace default nhid 93"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 2001:db8:101::1"
 	log_test $? 0 "Nexthop with multipath default route and rpfilter"
 
 	# TO-DO:
@@ -1216,11 +1212,11 @@ ipv6_torture()
 	pid1=$!
 	ipv6_grp_replace_loop &
 	pid2=$!
-	ip netns exec me ping -f 2001:db8:101::1 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 2001:db8:101::1 >/dev/null 2>&1 &
 	pid3=$!
-	ip netns exec me ping -f 2001:db8:101::2 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 2001:db8:101::2 >/dev/null 2>&1 &
 	pid4=$!
-	ip netns exec me mausezahn -6 veth1 -B 2001:db8:101::2 -A 2001:db8:91::1 -c 0 -t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1 &
+	ip netns exec $me mausezahn -6 veth1 -B 2001:db8:101::2 -A 2001:db8:91::1 -c 0 -t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1 &
 	pid5=$!
 
 	sleep 300
@@ -1270,11 +1266,11 @@ ipv6_res_torture()
 	pid1=$!
 	ipv6_res_grp_replace_loop &
 	pid2=$!
-	ip netns exec me ping -f 2001:db8:101::1 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 2001:db8:101::1 >/dev/null 2>&1 &
 	pid3=$!
-	ip netns exec me ping -f 2001:db8:101::2 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 2001:db8:101::2 >/dev/null 2>&1 &
 	pid4=$!
-	ip netns exec me mausezahn -6 veth1 \
+	ip netns exec $me mausezahn -6 veth1 \
 			    -B 2001:db8:101::2 -A 2001:db8:91::1 -c 0 \
 			    -t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1 &
 	pid5=$!
@@ -1544,7 +1540,7 @@ ipv4_withv6_fcnal()
 	local lladdr
 
 	set -e
-	lladdr=$(get_linklocal veth2 peer)
+	lladdr=$(get_linklocal veth2 $peer)
 	run_cmd "$IP nexthop add id 11 via ${lladdr} dev veth1"
 	set +e
 	run_cmd "$IP ro add 172.16.101.1/32 nhid 11"
@@ -1606,13 +1602,13 @@ ipv4_fcnal_runtime()
 	#
 	run_cmd "$IP nexthop replace id 21 via 172.16.1.2 dev veth1"
 	run_cmd "$IP ro replace 172.16.101.1/32 nhid 21"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "Basic ping"
 
 	run_cmd "$IP nexthop replace id 22 via 172.16.2.2 dev veth3"
 	run_cmd "$IP nexthop add id 122 group 21/22"
 	run_cmd "$IP ro replace 172.16.101.1/32 nhid 122"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "Ping - multipath"
 
 	run_cmd "$IP ro delete 172.16.101.1/32 nhid 122"
@@ -1623,7 +1619,7 @@ ipv4_fcnal_runtime()
 	run_cmd "$IP nexthop add id 501 via 172.16.1.2 dev veth1"
 	run_cmd "$IP ro add default nhid 501"
 	run_cmd "$IP ro add default via 172.16.1.3 dev veth1 metric 20"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "Ping - multiple default routes, nh first"
 
 	# flip the order
@@ -1632,7 +1628,7 @@ ipv4_fcnal_runtime()
 	run_cmd "$IP ro add default via 172.16.1.2 dev veth1 metric 20"
 	run_cmd "$IP nexthop replace id 501 via 172.16.1.3 dev veth1"
 	run_cmd "$IP ro add default nhid 501 metric 20"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "Ping - multiple default routes, nh second"
 
 	run_cmd "$IP nexthop delete nhid 501"
@@ -1643,26 +1639,26 @@ ipv4_fcnal_runtime()
 	#
 	run_cmd "$IP nexthop add id 23 blackhole"
 	run_cmd "$IP ro replace 172.16.101.1/32 nhid 23"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 2 "Ping - blackhole"
 
 	run_cmd "$IP nexthop replace id 23 via 172.16.1.2 dev veth1"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "Ping - blackhole replaced with gateway"
 
 	run_cmd "$IP nexthop replace id 23 blackhole"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 2 "Ping - gateway replaced by blackhole"
 
 	run_cmd "$IP ro replace 172.16.101.1/32 nhid 122"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	if [ $? -eq 0 ]; then
 		run_cmd "$IP nexthop replace id 122 group 23"
-		run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+		run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 		log_test $? 2 "Ping - group with blackhole"
 
 		run_cmd "$IP nexthop replace id 122 group 21/22"
-		run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+		run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 		log_test $? 0 "Ping - group blackhole replaced with gateways"
 	else
 		log_test 2 0 "Ping - multipath failed"
@@ -1685,11 +1681,11 @@ ipv4_fcnal_runtime()
 	# IPv4 with IPv6
 	#
 	set -e
-	lladdr=$(get_linklocal veth2 peer)
+	lladdr=$(get_linklocal veth2 $peer)
 	run_cmd "$IP nexthop add id 24 via ${lladdr} dev veth1"
 	set +e
 	run_cmd "$IP ro replace 172.16.101.1/32 nhid 24"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "IPv6 nexthop with IPv4 route"
 
 	$IP neigh sh | grep -q "${lladdr} dev veth1"
@@ -1713,11 +1709,11 @@ ipv4_fcnal_runtime()
 
 	check_route "172.16.101.1" "172.16.101.1 nhid 101 nexthop via inet6 ${lladdr} dev veth1 weight 1 nexthop via 172.16.1.2 dev veth1 weight 1"
 
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "IPv6 nexthop with IPv4 route"
 
 	run_cmd "$IP ro replace 172.16.101.1/32 via inet6 ${lladdr} dev veth1"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "IPv4 route with IPv6 gateway"
 
 	$IP neigh sh | grep -q "${lladdr} dev veth1"
@@ -1734,7 +1730,7 @@ ipv4_fcnal_runtime()
 
 	run_cmd "$IP ro del 172.16.101.1/32 via inet6 ${lladdr} dev veth1"
 	run_cmd "$IP -4 ro add default via inet6 ${lladdr} dev veth1"
-	run_cmd "ip netns exec me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
+	run_cmd "ip netns exec $me ping -c1 -w$PING_TIMEOUT 172.16.101.1"
 	log_test $? 0 "IPv4 default route with IPv6 gateway"
 
 	#
@@ -1785,7 +1781,7 @@ sysctl_nexthop_compat_mode_check()
 	local sysctlname="net.ipv4.nexthop_compat_mode"
 	local lprefix=$1
 
-	IPE="ip netns exec me"
+	IPE="ip netns exec $me"
 
 	$IPE sysctl -q $sysctlname 2>&1 >/dev/null
 	if [ $? -ne 0 ]; then
@@ -1804,7 +1800,7 @@ sysctl_nexthop_compat_mode_set()
 	local mode=$1
 	local lprefix=$2
 
-	IPE="ip netns exec me"
+	IPE="ip netns exec $me"
 
 	out=$($IPE sysctl -w $sysctlname=$mode)
 	log_test $? 0 "$lprefix set compat mode - $mode"
@@ -1988,11 +1984,11 @@ ipv4_torture()
 	pid1=$!
 	ipv4_grp_replace_loop &
 	pid2=$!
-	ip netns exec me ping -f 172.16.101.1 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 172.16.101.1 >/dev/null 2>&1 &
 	pid3=$!
-	ip netns exec me ping -f 172.16.101.2 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 172.16.101.2 >/dev/null 2>&1 &
 	pid4=$!
-	ip netns exec me mausezahn veth1 -B 172.16.101.2 -A 172.16.1.1 -c 0 -t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1 &
+	ip netns exec $me mausezahn veth1 -B 172.16.101.2 -A 172.16.1.1 -c 0 -t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1 &
 	pid5=$!
 
 	sleep 300
@@ -2042,11 +2038,11 @@ ipv4_res_torture()
 	pid1=$!
 	ipv4_res_grp_replace_loop &
 	pid2=$!
-	ip netns exec me ping -f 172.16.101.1 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 172.16.101.1 >/dev/null 2>&1 &
 	pid3=$!
-	ip netns exec me ping -f 172.16.101.2 >/dev/null 2>&1 &
+	ip netns exec $me ping -f 172.16.101.2 >/dev/null 2>&1 &
 	pid4=$!
-	ip netns exec me mausezahn veth1 \
+	ip netns exec $me mausezahn veth1 \
 				-B 172.16.101.2 -A 172.16.1.1 -c 0 \
 				-t tcp "dp=1-1023, flags=syn" >/dev/null 2>&1 &
 	pid5=$!
@@ -2081,10 +2077,10 @@ basic()
 
 	# create nh with linkdown device - fails
 	$IP li set veth1 up
-	ip -netns peer li set veth2 down
+	ip -netns $peer li set veth2 down
 	run_cmd "$IP nexthop add id 1 dev veth1"
 	log_test $? 2 "Nexthop with device that is linkdown"
-	ip -netns peer li set veth2 up
+	ip -netns $peer li set veth2 up
 
 	# device only
 	run_cmd "$IP nexthop add id 1 dev veth1"
@@ -2465,7 +2461,7 @@ fi
 for t in $TESTS
 do
 	case $t in
-	none) IP="ip -netns peer"; setup; exit 0;;
+	none) IP="ip -netns $peer"; setup; exit 0;;
 	*) setup; $t; cleanup;;
 	esac
 done
-- 
2.43.0


