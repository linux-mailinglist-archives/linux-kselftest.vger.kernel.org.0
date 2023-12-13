Return-Path: <linux-kselftest+bounces-1805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AA8109EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2461C208FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5DDF5B;
	Wed, 13 Dec 2023 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZV/DyJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C82683;
	Tue, 12 Dec 2023 22:09:55 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5530210a12.1;
        Tue, 12 Dec 2023 22:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447794; x=1703052594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjS9g56UCivM8Kubm1Y/1I6O6NRDWMwcHBF7pF2NKHU=;
        b=iZV/DyJw+E4pmmpj6dz8iTCgpHdbH+sve7vLwX5FhfED1iTau8gey9yfSjVE7GKz8V
         xY8DDa+62KHrRaFb1O6+BOxsjASZ7m6Gpr6S1rSEwG5lsntOQnDHekuUv4DvGyah+9iU
         LeChhcWhQtHKNnUTn8P3Tbgq9R0YEdBvuQ0JZ8BhOwPq73L6rjvPm3airyvR8qAlfLLH
         jpvGZf5gkL5P9QQtWQF37mvKZjc6WkCAH5ytP6fEPbZhJiIUjWdEGU+vwGrVYMX0Qzed
         TV4zJKsKA2RgeUE304GzOpC1Ah3lo8MyZJeReww0E73vbsCpNDV6IobGaiunOsM7GC1d
         gD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447794; x=1703052594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjS9g56UCivM8Kubm1Y/1I6O6NRDWMwcHBF7pF2NKHU=;
        b=KeweSwLpqTzAorXQ2zwSi7kzhrGQL5yJ40VjO4TXChlenf/nlxRrxYLBLCyWT+Q9dV
         t8+k0USF+fw5EFTLejcxAEvOVL/ZIBS3QOfKHT+BynO336TeEa0xhqxFkXmelAclX5ot
         FMFl+sZ1QJnNWfDJJ5/NOMeAzFIYjxTNfcCReCHoOsasRcVTk1uGaPLvJZ4z/g9FP/hH
         SSjhwwVL1m98ELrNw5qHjFRwc8aNPUjI3ciT1EpwNZ/UNZtxYEbeiYxJRQqb88DV64OU
         kQuqeMg9UBIb+2m0W1TDsDlhEwz4gD4IMZHfabWbQVmkqQcK4x58wG6hND2SR0rsVEjE
         TG7w==
X-Gm-Message-State: AOJu0YzbwMvxDCvSgmYt+5zFb9flyz76m1n+kL3Se/5m2V2fWiLGhV3a
	1uOI0e5etyM5M/ZUfFYhaLsjnGNJJ0UFYdzkUJ0=
X-Google-Smtp-Source: AGHT+IFaLbxVb22OI2ULPxFa+L80fkis03H+n6xE5rpY9TiBVYVrUqBDxKeMtXtBrZNkZgfiF97URw==
X-Received: by 2002:a05:6a20:158b:b0:190:61a1:3be2 with SMTP id h11-20020a056a20158b00b0019061a13be2mr10203283pzj.97.1702447794148;
        Tue, 12 Dec 2023 22:09:54 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:53 -0800 (PST)
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
Subject: [PATCHv2 net-next 11/13] selftests/net: convert fib_rule_tests.sh to run it in unique namespace
Date: Wed, 13 Dec 2023 14:08:54 +0800
Message-ID: <20231213060856.4030084-12-liuhangbin@gmail.com>
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

 ]# ./fib_rule_tests.sh

     TEST: rule6 check: oif redirect to table                  [ OK ]

     ...

     TEST: rule4 dsfield tcp connect (dsfield 0x07)            [ OK ]

 Tests passed:  66
 Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 63c3eaec8d30..51157a5559b7 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -3,14 +3,9 @@
 
 # This test is for checking IPv4 and IPv6 FIB rules API
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
+source lib.sh
 ret=0
-
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
-IP="ip -netns testns"
-IP_PEER="ip -netns peerns"
 
 RTABLE=100
 RTABLE_PEER=101
@@ -84,8 +79,8 @@ check_nettest()
 setup()
 {
 	set -e
-	ip netns add testns
-	$IP link set dev lo up
+	setup_ns testns
+	IP="ip -netns $testns"
 
 	$IP link add dummy0 type dummy
 	$IP link set dev dummy0 up
@@ -98,18 +93,19 @@ setup()
 cleanup()
 {
 	$IP link del dev dummy0 &> /dev/null
-	ip netns del testns
+	cleanup_ns $testns
 }
 
 setup_peer()
 {
 	set -e
 
-	ip netns add peerns
+	setup_ns peerns
+	IP_PEER="ip -netns $peerns"
 	$IP_PEER link set dev lo up
 
-	ip link add name veth0 netns testns type veth \
-		peer name veth1 netns peerns
+	ip link add name veth0 netns $testns type veth \
+		peer name veth1 netns $peerns
 	$IP link set dev veth0 up
 	$IP_PEER link set dev veth1 up
 
@@ -131,7 +127,7 @@ setup_peer()
 cleanup_peer()
 {
 	$IP link del dev veth0
-	ip netns del peerns
+	ip netns del $peerns
 }
 
 fib_check_iproute_support()
@@ -270,11 +266,11 @@ fib_rule6_connect_test()
 	# (Not-ECT: 0, ECT(1): 1, ECT(0): 2, CE: 3).
 	# The ECN bits shouldn't influence the result of the test.
 	for dsfield in 0x04 0x05 0x06 0x07; do
-		nettest -q -6 -B -t 5 -N testns -O peerns -U -D \
+		nettest -q -6 -B -t 5 -N $testns -O $peerns -U -D \
 			-Q "${dsfield}" -l 2001:db8::1:11 -r 2001:db8::1:11
 		log_test $? 0 "rule6 dsfield udp connect (dsfield ${dsfield})"
 
-		nettest -q -6 -B -t 5 -N testns -O peerns -Q "${dsfield}" \
+		nettest -q -6 -B -t 5 -N $testns -O $peerns -Q "${dsfield}" \
 			-l 2001:db8::1:11 -r 2001:db8::1:11
 		log_test $? 0 "rule6 dsfield tcp connect (dsfield ${dsfield})"
 	done
@@ -337,11 +333,11 @@ fib_rule4_test()
 
 	# need enable forwarding and disable rp_filter temporarily as all the
 	# addresses are in the same subnet and egress device == ingress device.
-	ip netns exec testns sysctl -qw net.ipv4.ip_forward=1
-	ip netns exec testns sysctl -qw net.ipv4.conf.$DEV.rp_filter=0
+	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec $testns sysctl -qw net.ipv4.conf.$DEV.rp_filter=0
 	match="from $SRC_IP iif $DEV"
 	fib_rule4_test_match_n_redirect "$match" "$match" "iif redirect to table"
-	ip netns exec testns sysctl -qw net.ipv4.ip_forward=0
+	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=0
 
 	# Reject dsfield (tos) options which have ECN bits set
 	for cnt in $(seq 1 3); do
@@ -407,11 +403,11 @@ fib_rule4_connect_test()
 	# (Not-ECT: 0, ECT(1): 1, ECT(0): 2, CE: 3).
 	# The ECN bits shouldn't influence the result of the test.
 	for dsfield in 0x04 0x05 0x06 0x07; do
-		nettest -q -B -t 5 -N testns -O peerns -D -U -Q "${dsfield}" \
+		nettest -q -B -t 5 -N $testns -O $peerns -D -U -Q "${dsfield}" \
 			-l 198.51.100.11 -r 198.51.100.11
 		log_test $? 0 "rule4 dsfield udp connect (dsfield ${dsfield})"
 
-		nettest -q -B -t 5 -N testns -O peerns -Q "${dsfield}" \
+		nettest -q -B -t 5 -N $testns -O $peerns -Q "${dsfield}" \
 			-l 198.51.100.11 -r 198.51.100.11
 		log_test $? 0 "rule4 dsfield tcp connect (dsfield ${dsfield})"
 	done
-- 
2.43.0


