Return-Path: <linux-kselftest+bounces-509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFA7F6F93
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDEB21263
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97DFBFC;
	Fri, 24 Nov 2023 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp6MFQq2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E7DD;
	Fri, 24 Nov 2023 01:28:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cf6bdf8274so19654545ad.1;
        Fri, 24 Nov 2023 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818104; x=1701422904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LBqBKI+QCowfu2/Y4WPJp9GOfksiWJbzVokuk/ddrc=;
        b=Vp6MFQq2PaFqzqpAVIGE25x3TjUiUQLzF8nYlMu+72ErT8+B6RZpXIlW3nzorUjrxO
         kF3AvkufrarfX0Kx2gTt2nCbtd4QglCV5H1iIcsJdCQ/6adW4oj2EH9MldWWgwBLE94N
         UZPGlZ+XY6txPF2C1W3qwFS7Ro9wpehu5UsiFpQaiA9ttRhTjsi0ke9g6O/4v+381mHg
         VQi5b+ZvExkUE3UlUUHIKNzajauZ6tGDGhuX2gela32rzMX64H6vclywspY8QFb7gH9z
         DgEptik0Ok11YR2B3ApxJqGfZ07fS51YT7WqJzBL/39OCbPwcTHsayOwGQzQyS/9rwDU
         1Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818104; x=1701422904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LBqBKI+QCowfu2/Y4WPJp9GOfksiWJbzVokuk/ddrc=;
        b=VlSprmLdwv07fTVMCb6LkSdC7x6MJnzRwYI2+FV6tvc+nct5mAELpSUDVZZxDZsFQz
         trlsrwRvDVw2G2JfHJudw2Q13U1dquUQ/EKhlLq/2UWsHDw3adUZex6dtGCIyCosm5Mp
         DPCQ8LBEUbOU7zwbvWWG5bjz2540MflAvKD8DeBkj4t4O8kEddppBtWaEfTWrousWT9c
         KcrkEIf42rVXum7Mq2ozkccHQ7a28SMjKEGEDXlRlAkEt7yK3FImSbROLYbFeTMElDUm
         8VJU+CroAw6V02Y4GlNHWMX8Utt/l39FblLIPinTi7xEhKEbnPulEA/AKFkATp/543BC
         YuCw==
X-Gm-Message-State: AOJu0Yx7TYU3cwu9QXv5c/4BBlWZqlYO/XnSgvLS7hCwNMyQayp/LSP0
	ynSGa9yuea2tGCnVD4PuFaDlDBs0b+uy9+4m
X-Google-Smtp-Source: AGHT+IFUDAIbT+Jss6yCQfh/xNyLs2UUnu5a9lrri/O1Zi+Ne+qwesV274AQ5QwauAzZ6L9j0+fUKQ==
X-Received: by 2002:a17:902:ec92:b0:1cf:8a7f:23c2 with SMTP id x18-20020a170902ec9200b001cf8a7f23c2mr2671799plg.30.1700818103670;
        Fri, 24 Nov 2023 01:28:23 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:22 -0800 (PST)
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
Subject: [PATCH net-next 07/38] selftests/net: convert fib_nexthop_multiprefix to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:05 +0800
Message-ID: <20231124092736.3673263-8-liuhangbin@gmail.com>
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

There is no need cleanup since the lib trap will clean all created ns.

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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/fib_nexthop_multiprefix.sh  | 104 ++++++++----------
 1 file changed, 47 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index 51df5e305855..58efeccc96f7 100755
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
@@ -108,55 +109,47 @@ setup()
 
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
 }
 
-cleanup()
-{
-	for n in h0 r1 h1 h2 h3
-	do
-		ip netns del ${n} 2>/dev/null
-	done
-}
-
 change_mtu()
 {
 	local hostid=$1
 	local mtu=$2
 
 	run_cmd ip -netns h${hostid} li set eth0 mtu ${mtu}
-	run_cmd ip -netns r1 li set eth${hostid} mtu ${mtu}
+	run_cmd ip -netns ${r1} li set eth${hostid} mtu ${mtu}
 }
 
 ################################################################################
@@ -168,23 +161,23 @@ validate_v4_exception()
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
 
@@ -197,24 +190,24 @@ validate_v6_exception()
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
-		echo "    ${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+		echo "    ${dst} from :: via ${r1_ip} dev eth0 src ${h0_ip} .* mtu ${mtu}"
 		echo
 	fi
 
-	ip -netns h0 -6 ro get ${dst} | \
-	grep -q "${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+	ip -netns ${h0} -6 ro get ${dst} | \
+	grep -q "${dst} from :: via ${r1_ip} dev eth0 src ${h0_ip} .* mtu ${mtu}"
 	rc=$?
 
 	log_test $rc 0 "IPv6: host 0 to host ${i}, mtu ${mtu}"
@@ -231,7 +224,6 @@ do
 	esac
 done
 
-cleanup
 setup
 sleep 2
 
@@ -242,11 +234,11 @@ for i in 1 2 3
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
@@ -282,11 +274,9 @@ if [ $ret -eq 0 ]; then
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
-
-cleanup
-- 
2.41.0


