Return-Path: <linux-kselftest+bounces-513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16E7F6F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453C1B212C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669C11737;
	Fri, 24 Nov 2023 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/AF60bZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE167D7E;
	Fri, 24 Nov 2023 01:28:41 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf6373ce31so12514745ad.0;
        Fri, 24 Nov 2023 01:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818121; x=1701422921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgoh/iqvpvyuKZIjURvwzMux+B5e8ZE3qUB3i4j2Exk=;
        b=Q/AF60bZxFNKs7giDHQnLHDwXo00cPvU5qDolyPMBCpy+eYueoEr+ADRsQhHI0rKq8
         g3DvVcpYa5gepyCOs39d63A6bKFT7r2CBaJoZQozyOTmXaFO+lPklPo9vvvgPtBiqvpF
         vjIBYFfOZIkmp8fxso2XYR8d9u86WXoQ3pw2pyrUl3hkD3okDFjJ2t3GqEmEcrQssSRx
         MzN0o+vvuKYFZdYLStR12aMvZN3mwy63M8HxGa01ltwgXyHz2TymG9gZfYqc647/8/3t
         q7f76zF4cqKrqWkbPdETjLTd6xldEwmxnp6pyAnxr2/LFSuY6uU/xlPMcyeHyXr2eR00
         BA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818121; x=1701422921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgoh/iqvpvyuKZIjURvwzMux+B5e8ZE3qUB3i4j2Exk=;
        b=KvV4rpsvHK+UvwW+rBV0Nm3cRkCLH6oVGgcg5Q7PYD1MyGznGVSLZlKrmYum43Jtub
         bYumzmlxzHZIlu1JhoCAD1iIyzrvtHDhEvWo8yXeQQUb9YKaKgtCzAojtmwVY7HaPlOz
         9UvSoCh/Qpl/zesZrl+MqtCIUHkSamMfOJj6M067h0JW5M/qYVVM/4lL766P8Vrh52NQ
         JO5FcVR1Hzjkq5+s9IyX93GLBfIoEvjSC7hyQT0A/COf99kCcn8LHcy8zzMRTl4RKGE4
         qQ6mLYPzz5ti70i4kIS6QB4Ah12zvj+RKjD0J9On+aKxJFPeACQ5HSujFNbresAjrkiD
         d03g==
X-Gm-Message-State: AOJu0YzOXAjL3wCSxqeIBDeC5ZCHncg/kFNUWqBEP3i2upWrnjWU0Mav
	83MCrg6upPWduIvH9RaA839uocUXtiT3sMc+
X-Google-Smtp-Source: AGHT+IG/suUKmvAJubBGui6cULB0LmRapBBMn4VqoVjDbMcFsMZ4IzQtExHrhMtchP52YruvuQIMBQ==
X-Received: by 2002:a17:902:d50e:b0:1bd:e258:a256 with SMTP id b14-20020a170902d50e00b001bde258a256mr2603600plg.32.1700818120972;
        Fri, 24 Nov 2023 01:28:40 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:40 -0800 (PST)
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
Subject: [PATCH net-next 11/38] selftests/net: convert fib_rule_tests.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:09 +0800
Message-ID: <20231124092736.3673263-12-liuhangbin@gmail.com>
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

]# ./fib_rule_tests.sh

    TEST: rule6 check: oif redirect to table                  [ OK ]

    ...

    TEST: rule4 dsfield tcp connect (dsfield 0x07)            [ OK ]

Tests passed:  66
Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 63c3eaec8d30..2ff8534fe353 100755
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
+	ip netns del $testns
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
2.41.0


