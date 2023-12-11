Return-Path: <linux-kselftest+bounces-1514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF980C60D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE141C20B7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6FC249E3;
	Mon, 11 Dec 2023 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyRj08cc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C76E3;
	Mon, 11 Dec 2023 02:10:16 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d72bc5cf2so18280545ab.1;
        Mon, 11 Dec 2023 02:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289415; x=1702894215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqtmnDv3fx2NULxN9JI8rHD/poDssAeym2Ee8irj//I=;
        b=hyRj08cczIwLzGW1r3QHaNi3hxIazKUGhJz4X1JEqZY0lgBXPUC+9mNUUnU4ACOL7Z
         x3eqtDttjdAyjfqNvAyeBbbw8e+NB+m44MrXIcNfC3oK4tfsGH7TbAGzBUSf9R7R7ktJ
         w0mT+yYN4kAEHthFb7wVdKIqnWG8qGEUd34pkiJwX4oD0YYJvvs62Louj8yD2rcIBolu
         ewbOI4niWL2mkC5OEP+ffYe4lrwu0Pn/3kkpl9cioHklSGZBgRhrc3O2XdS+StjLLrvT
         gdgyQA48og5VzaEIDYlV/yBtqvn9dIlFwdLNTqeC/3M0cbjdgzAqp8qTwUwGekPX5lVg
         VK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289415; x=1702894215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqtmnDv3fx2NULxN9JI8rHD/poDssAeym2Ee8irj//I=;
        b=t6nEBGQzBaS5tOuRbjIhbzILZIESjDYdYhYdd3Q17/Ki5NNDQZn6mGVkKkitrbqR2t
         jjy7R7DgJn5VGOh1EcH52LYnqaNLb0/hQrC3UUx/tnzZjQcw59sDsQrJUowudMbnGX5Z
         BttVCMujqd/6m8jTYrL6bGWzVStQ2mu0plueNKwgfLeV1mqasiTCOi0mvTqwMcM1gY6G
         2umYfsC8rz0bilaviPpXxOUEshDOcbobMT47alnYErLi7ToiAvQFpLBJ7KjcoKNs8aEJ
         YCD8A5zL6wsOADpYCup9XiDbJTlufpsDPMBDVEMc8N8MxXqDcH4RgHfJWvf+IqX0dQhM
         gN3g==
X-Gm-Message-State: AOJu0YwD4L5CJ7B1/W8qG/E0lE3s7/MW9+JnRjNoe9JD9SCXPNEuHP9Q
	P+yi6xMbOJalEjlKyvAbbodSNyv/XDBg4W+0
X-Google-Smtp-Source: AGHT+IHpvZev8kqs8g+yuVmQcDD3G9cUi1AUgvATDt9/FbKobiWL4uOG45n2bTcy1YaU/ZmCaWsW7Q==
X-Received: by 2002:a05:6e02:16cb:b0:35d:5995:1d6f with SMTP id 11-20020a056e0216cb00b0035d59951d6fmr7485369ilx.52.1702289415492;
        Mon, 11 Dec 2023 02:10:15 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:10:15 -0800 (PST)
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
Subject: [PATCH net-next 11/13] selftests/net: convert fib_rule_tests.sh to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:23 +0800
Message-ID: <20231211100925.3249265-12-liuhangbin@gmail.com>
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


