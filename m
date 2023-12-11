Return-Path: <linux-kselftest+bounces-1510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD38E80C605
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A93281AAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA32224D3;
	Mon, 11 Dec 2023 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR2Ky6ma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEEDEA;
	Mon, 11 Dec 2023 02:10:01 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35d699ec3caso13609385ab.3;
        Mon, 11 Dec 2023 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289399; x=1702894199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thjmxlwIU85g7sMW4guj3wIDmURr+67AufSHepXvN5Q=;
        b=KR2Ky6magqZ7/UHxk3wOFbzasOuwbc8VBJNsD0c7bH79PA23mLhmvraL+AXbsgvBVU
         iZnrioCqko35kgQMAiSaoHt6GB2db3sXtOR+38/BDYVzvCsJNlKGymzuL98XGWuFcwJy
         95Gq7+cE+9G+qN5cr9PjW+osGU3TvaDqCIs4pMex9DeufdD5K2rj4B7PlaTbgnXJfoK3
         IoWxgo8NW4zCI/Gp5fJW9WlI3UUt/LgVOBe8ndtdHyblU5tlzusXaDOkp80+wYNflc0W
         0ds1q1n8j5LjSxi4IKlk3kb9szzO42okPteabUSB08WVrz+daQmlmYXLqOsoO/N6O8aI
         y3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289399; x=1702894199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thjmxlwIU85g7sMW4guj3wIDmURr+67AufSHepXvN5Q=;
        b=DmhAzwHv11RWsSBCIM1TyteQQgSZ7MzgK2bH5GZJYE7PHjKLlywfp7Olt3CIz6dMVF
         NMrv9jAEzy9Q9HnJT+hgKcZBikUP+SV7ZPv56ULZQtc4vxoVIMCrzR5MRu+w43V8w6ri
         PG6+TwsklLEZgzVahA78TCggzUGnRQ+vIJlWfTqgyt+MS82xdqgLTCfZGRGEFGZ5twl3
         SWX6pTQj76C2KwmDnWQmFesW0fzIaCwHr74vzWf93FkE4U1DS85pqw5gbZXL8+ResDuS
         /UDakOPSG1lrWBP+awkuD/gj8V1frb4kTpuTB5ef5+THj9CnmPBTyFGTnH+1HEZkAjhA
         sV5g==
X-Gm-Message-State: AOJu0YyY8wQODGepqYHYsg6HEP3+BTbKyEXEYSBq76Dw3MD0ErHZ/fQl
	KQTRunlU0f7z9FBVO4RWbhVLdM8h1PXiAzU1
X-Google-Smtp-Source: AGHT+IFuWa9YOmmiDkyzr8lxi2rtcvEaC1tboVTm9amfGGTo+frbcqwlVNNgUh8yA++qWxC+MIRY8A==
X-Received: by 2002:a05:6e02:b4d:b0:35d:867a:40cd with SMTP id f13-20020a056e020b4d00b0035d867a40cdmr5633296ilu.27.1702289399569;
        Mon, 11 Dec 2023 02:09:59 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:09:59 -0800 (PST)
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
Subject: [PATCH net-next 07/13] selftests/net: convert fib_nexthop_multiprefix to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:19 +0800
Message-ID: <20231211100925.3249265-8-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211100925.3249265-1-liuhangbin@gmail.com>
References: <20231211100925.3249265-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./fib_nexthop_multiprefix.sh
TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                              [ OK ]

TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
TEST: IPv6: host 0 to host 2, mtu 1350                              [ OK ]

TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
TEST: IPv6: host 0 to host 3, mtu 1400                              [ OK ]

TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                              [ OK ]

TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
TEST: IPv6: host 0 to host 2, mtu 1350                              [ OK ]

TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
TEST: IPv6: host 0 to host 3, mtu 1400                              [ OK ]

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/fib_nexthop_multiprefix.sh  | 98 +++++++++----------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index b52d59547fc5..e85248609af4 100755
--- a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
+++ b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
@@ -12,6 +12,7 @@
 #
 # routing in h0 to hN is done with nexthop objects.
 
+source lib.sh
 PAUSE_ON_FAIL=no
 VERBOSE=0
 
@@ -72,12 +73,6 @@ create_ns()
 {
 	local ns=${1}
 
-	ip netns del ${ns} 2>/dev/null
-
-	ip netns add ${ns}
-	ip -netns ${ns} addr add 127.0.0.1/8 dev lo
-	ip -netns ${ns} link set lo up
-
 	ip netns exec ${ns} sysctl -q -w net.ipv6.conf.all.keep_addr_on_down=1
 	case ${ns} in
 	h*)
@@ -97,7 +92,13 @@ setup()
 
 	#set -e
 
-	for ns in h0 r1 h1 h2 h3
+	setup_ns h0 r1 h1 h2 h3
+	h[0]=$h0
+	h[1]=$h1
+	h[2]=$h2
+	h[3]=$h3
+	r[1]=$r1
+	for ns in ${h[0]} ${r[1]} ${h[1]} ${h[2]} ${h[3]}
 	do
 		create_ns ${ns}
 	done
@@ -108,35 +109,35 @@ setup()
 
 	for i in 0 1 2 3
 	do
-		ip -netns h${i} li add eth0 type veth peer name r1h${i}
-		ip -netns h${i} li set eth0 up
-		ip -netns h${i} li set r1h${i} netns r1 name eth${i} up
-
-		ip -netns h${i}    addr add dev eth0 172.16.10${i}.1/24
-		ip -netns h${i} -6 addr add dev eth0 2001:db8:10${i}::1/64
-		ip -netns r1    addr add dev eth${i} 172.16.10${i}.254/24
-		ip -netns r1 -6 addr add dev eth${i} 2001:db8:10${i}::64/64
+		ip -netns ${h[$i]} li add eth0 type veth peer name r1h${i}
+		ip -netns ${h[$i]} li set eth0 up
+		ip -netns ${h[$i]} li set r1h${i} netns ${r[1]} name eth${i} up
+
+		ip -netns ${h[$i]}    addr add dev eth0 172.16.10${i}.1/24
+		ip -netns ${h[$i]} -6 addr add dev eth0 2001:db8:10${i}::1/64
+		ip -netns ${r[1]}    addr add dev eth${i} 172.16.10${i}.254/24
+		ip -netns ${r[1]} -6 addr add dev eth${i} 2001:db8:10${i}::64/64
 	done
 
-	ip -netns h0 nexthop add id 4 via 172.16.100.254 dev eth0
-	ip -netns h0 nexthop add id 6 via 2001:db8:100::64 dev eth0
+	ip -netns ${h[0]} nexthop add id 4 via 172.16.100.254 dev eth0
+	ip -netns ${h[0]} nexthop add id 6 via 2001:db8:100::64 dev eth0
 
-	# routing from h0 to h1-h3 and back
+	# routing from ${h[0]} to h1-h3 and back
 	for i in 1 2 3
 	do
-		ip -netns h0    ro add 172.16.10${i}.0/24 nhid 4
-		ip -netns h${i} ro add 172.16.100.0/24 via 172.16.10${i}.254
+		ip -netns ${h[0]}    ro add 172.16.10${i}.0/24 nhid 4
+		ip -netns ${h[$i]} ro add 172.16.100.0/24 via 172.16.10${i}.254
 
-		ip -netns h0    -6 ro add 2001:db8:10${i}::/64 nhid 6
-		ip -netns h${i} -6 ro add 2001:db8:100::/64 via 2001:db8:10${i}::64
+		ip -netns ${h[0]}    -6 ro add 2001:db8:10${i}::/64 nhid 6
+		ip -netns ${h[$i]} -6 ro add 2001:db8:100::/64 via 2001:db8:10${i}::64
 	done
 
 	if [ "$VERBOSE" = "1" ]; then
 		echo
 		echo "host 1 config"
-		ip -netns h0 li sh
-		ip -netns h0 ro sh
-		ip -netns h0 -6 ro sh
+		ip -netns ${h[0]} li sh
+		ip -netns ${h[0]} ro sh
+		ip -netns ${h[0]} -6 ro sh
 	fi
 
 	#set +e
@@ -144,10 +145,7 @@ setup()
 
 cleanup()
 {
-	for n in h0 r1 h1 h2 h3
-	do
-		ip netns del ${n} 2>/dev/null
-	done
+	cleanup_all_ns
 }
 
 change_mtu()
@@ -156,7 +154,7 @@ change_mtu()
 	local mtu=$2
 
 	run_cmd ip -netns h${hostid} li set eth0 mtu ${mtu}
-	run_cmd ip -netns r1 li set eth${hostid} mtu ${mtu}
+	run_cmd ip -netns ${r1} li set eth${hostid} mtu ${mtu}
 }
 
 ################################################################################
@@ -168,23 +166,23 @@ validate_v4_exception()
 	local mtu=$2
 	local ping_sz=$3
 	local dst="172.16.10${i}.1"
-	local h0=172.16.100.1
-	local r1=172.16.100.254
+	local h0_ip=172.16.100.1
+	local r1_ip=172.16.100.254
 	local rc
 
 	if [ ${ping_sz} != "0" ]; then
-		run_cmd ip netns exec h0 ping -s ${ping_sz} -c5 -w5 ${dst}
+		run_cmd ip netns exec ${h0} ping -s ${ping_sz} -c5 -w5 ${dst}
 	fi
 
 	if [ "$VERBOSE" = "1" ]; then
 		echo "Route get"
-		ip -netns h0 ro get ${dst}
+		ip -netns ${h0} ro get ${dst}
 		echo "Searching for:"
 		echo "    cache .* mtu ${mtu}"
 		echo
 	fi
 
-	ip -netns h0 ro get ${dst} | \
+	ip -netns ${h0} ro get ${dst} | \
 	grep -q "cache .* mtu ${mtu}"
 	rc=$?
 
@@ -197,24 +195,24 @@ validate_v6_exception()
 	local mtu=$2
 	local ping_sz=$3
 	local dst="2001:db8:10${i}::1"
-	local h0=2001:db8:100::1
-	local r1=2001:db8:100::64
+	local h0_ip=2001:db8:100::1
+	local r1_ip=2001:db8:100::64
 	local rc
 
 	if [ ${ping_sz} != "0" ]; then
-		run_cmd ip netns exec h0 ${ping6} -s ${ping_sz} -c5 -w5 ${dst}
+		run_cmd ip netns exec ${h0} ${ping6} -s ${ping_sz} -c5 -w5 ${dst}
 	fi
 
 	if [ "$VERBOSE" = "1" ]; then
 		echo "Route get"
-		ip -netns h0 -6 ro get ${dst}
+		ip -netns ${h0} -6 ro get ${dst}
 		echo "Searching for:"
-		echo "    ${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+		echo "    ${dst}.* via ${r1_ip} dev eth0 src ${h0_ip} .* mtu ${mtu}"
 		echo
 	fi
 
-	ip -netns h0 -6 ro get ${dst} | \
-	grep -q "${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+	ip -netns ${h0} -6 ro get ${dst} | \
+	grep -q "${dst}.* via ${r1_ip} dev eth0 src ${h0_ip} .* mtu ${mtu}"
 	rc=$?
 
 	log_test $rc 0 "IPv6: host 0 to host ${i}, mtu ${mtu}"
@@ -242,11 +240,11 @@ for i in 1 2 3
 do
 	# generate a cached route per-cpu
 	for c in ${cpus}; do
-		run_cmd taskset -c ${c} ip netns exec h0 ping -c1 -w1 172.16.10${i}.1
-		[ $? -ne 0 ] && printf "\nERROR: ping to h${i} failed\n" && ret=1
+		run_cmd taskset -c ${c} ip netns exec ${h0} ping -c1 -w1 172.16.10${i}.1
+		[ $? -ne 0 ] && printf "\nERROR: ping to ${h[$i]} failed\n" && ret=1
 
-		run_cmd taskset -c ${c} ip netns exec h0 ${ping6} -c1 -w1 2001:db8:10${i}::1
-		[ $? -ne 0 ] && printf "\nERROR: ping6 to h${i} failed\n" && ret=1
+		run_cmd taskset -c ${c} ip netns exec ${h0} ${ping6} -c1 -w1 2001:db8:10${i}::1
+		[ $? -ne 0 ] && printf "\nERROR: ping6 to ${h[$i]} failed\n" && ret=1
 
 		[ $ret -ne 0 ] && break
 	done
@@ -282,11 +280,11 @@ if [ $ret -eq 0 ]; then
 	validate_v6_exception 3 1400 0
 
 	# targeted deletes to trigger cleanup paths in kernel
-	ip -netns h0 ro del 172.16.102.0/24 nhid 4
-	ip -netns h0 -6 ro del 2001:db8:102::/64 nhid 6
+	ip -netns ${h0} ro del 172.16.102.0/24 nhid 4
+	ip -netns ${h0} -6 ro del 2001:db8:102::/64 nhid 6
 
-	ip -netns h0 nexthop del id 4
-	ip -netns h0 nexthop del id 6
+	ip -netns ${h0} nexthop del id 4
+	ip -netns ${h0} nexthop del id 6
 fi
 
 cleanup
-- 
2.43.0


