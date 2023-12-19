Return-Path: <linux-kselftest+bounces-2183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891178184C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206422852DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB4213FF7;
	Tue, 19 Dec 2023 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxbsvpZn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F114273;
	Tue, 19 Dec 2023 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b4a73d3c7so2676599a91.2;
        Tue, 19 Dec 2023 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979360; x=1703584160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHAcJu9znSRPsLBojULlLh46+h3VyWNF5AMsqybfbR4=;
        b=RxbsvpZnB88649QbcpIJRQ+OZ7EriB7P+XfU2cQ6X3XrHzJwe6y8WlZ9bTSc7p9hC/
         mO2HSh9xMIScrBF9Z4CLJh2O29z6P7gdVY8r4zYFp7Ndu6li9YMhWhLWxs+w7FLLYVzX
         Mv7z+3pEZi+gFtg4f0GcUsUwTplA4aaas4QKdXqDidlMShHzklKUu/3azubD19Ova7at
         pivi6cXlaitFQmXebx/y/Q+lhYrKRamDKXm4ebZPUB2sXAvT0PdUVWUfzY3xxcZVUSdB
         9IhWSOdXTnuOCjjkdPGqqSXJ8aqUgJJwQnGdCd8iFJ8RoF0f8gLWJerWw2CljYJ7vZzX
         TK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979360; x=1703584160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHAcJu9znSRPsLBojULlLh46+h3VyWNF5AMsqybfbR4=;
        b=tRAQFgGgPZIyi0o2af1eTFp9msGWNzAw/dRdGG4VWN04s1c+yom3z29kinKdGmLEYJ
         7yeCDbOX5l0EoeyG9bYO8/YyYgiR2z+h5gYor1+W77gL9V/G7kvmyOCnserveWEh+PzR
         rKgqh0DDp7NwH81wNm1nRx6o5corj0nbqozBm+cGRad7W1hzfzIow5H1hxNOStS6WvRS
         mtXTHp6Zfupq61A6OdOIIc6V/9g5TAjOVmCtSJxGfwfGu9ZGlNyTxU4kUgIq1jmnSqEA
         75ti2VvRJmQLi1cmRwCho46tPFo2nUGhXUrpmiVAv96WtFPuWcJHE1Z8IKWO7ecEnMxg
         T3HA==
X-Gm-Message-State: AOJu0YwSbSHIX0sfwe97KQgYbKsDN9Kvy6PMv5WaEj9mTntjCIjYvLmc
	9uhzk6M+bAG9Wnv/daNU5dSfXv8bsGjpMy82YeI=
X-Google-Smtp-Source: AGHT+IFaigRw3rmD7TNGw13v5VzxHoOUG+TgYXmTBwzT2uJx+rPjFuo9LAvq0HCtRtm7KA+/ZOvmGw==
X-Received: by 2002:a17:90a:d518:b0:28b:924d:a7d8 with SMTP id t24-20020a17090ad51800b0028b924da7d8mr1729655pju.51.1702979360213;
        Tue, 19 Dec 2023 01:49:20 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:19 -0800 (PST)
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
	Florian Westphal <fw@strlen.de>,
	Martin KaFai Lau <kafai@fb.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/8] selftests/net: convert rtnetlink.sh to run it in unique namespace
Date: Tue, 19 Dec 2023 17:48:51 +0800
Message-ID: <20231219094856.1740079-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219094856.1740079-1-liuhangbin@gmail.com>
References: <20231219094856.1740079-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running the test in namespace, the debugfs may not load automatically.
So add a checking to make sure debugfs loaded. Here is the test result
after conversion.

 # ./rtnetlink.sh
 PASS: policy routing
 PASS: route get
 ...
 PASS: address proto IPv4
 PASS: address proto IPv6

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 34 +++++++++++++-----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 38be9706c45f..97278b6427f1 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -35,8 +35,7 @@ VERBOSE=0
 PAUSE=no
 PAUSE_ON_FAIL=no
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
 
 # set global exit status, but never reset nonzero one.
 check_err()
@@ -517,9 +516,8 @@ kci_test_encap_fou()
 # test various encap methods, use netns to avoid unwanted interference
 kci_test_encap()
 {
-	testns="testns"
 	local ret=0
-	run_cmd ip netns add "$testns"
+	setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP encap tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -574,6 +572,10 @@ kci_test_macsec_offload()
 		return $ksft_skip
 	fi
 
+	if ! mount | grep -q debugfs; then
+		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
+	fi
+
 	# setup netdevsim since dummydev doesn't have offload support
 	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
 		run_cmd modprobe -q netdevsim
@@ -738,6 +740,10 @@ kci_test_ipsec_offload()
 	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
 	probed=false
 
+	if ! mount | grep -q debugfs; then
+		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
+	fi
+
 	# setup netdevsim since dummydev doesn't have offload support
 	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
 		run_cmd modprobe -q netdevsim
@@ -836,11 +842,10 @@ EOF
 
 kci_test_gretap()
 {
-	testns="testns"
 	DEV_NS=gretap00
 	local ret=0
 
-	run_cmd ip netns add "$testns"
+	setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP gretap tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -878,11 +883,10 @@ kci_test_gretap()
 
 kci_test_ip6gretap()
 {
-	testns="testns"
 	DEV_NS=ip6gretap00
 	local ret=0
 
-	run_cmd ip netns add "$testns"
+	setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP ip6gretap tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -920,7 +924,6 @@ kci_test_ip6gretap()
 
 kci_test_erspan()
 {
-	testns="testns"
 	DEV_NS=erspan00
 	local ret=0
 	run_cmd_grep "^Usage:" ip link help erspan
@@ -928,7 +931,7 @@ kci_test_erspan()
 		end_test "SKIP: erspan: iproute2 too old"
 		return $ksft_skip
 	fi
-	run_cmd ip netns add "$testns"
+	setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP erspan tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -970,7 +973,6 @@ kci_test_erspan()
 
 kci_test_ip6erspan()
 {
-	testns="testns"
 	DEV_NS=ip6erspan00
 	local ret=0
 	run_cmd_grep "^Usage:" ip link help ip6erspan
@@ -978,7 +980,7 @@ kci_test_ip6erspan()
 		end_test "SKIP: ip6erspan: iproute2 too old"
 		return $ksft_skip
 	fi
-	run_cmd ip netns add "$testns"
+	setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP ip6erspan tests: cannot add net namespace $testns"
 		return $ksft_skip
@@ -1022,8 +1024,6 @@ kci_test_ip6erspan()
 
 kci_test_fdb_get()
 {
-	IP="ip -netns testns"
-	BRIDGE="bridge -netns testns"
 	brdev="test-br0"
 	vxlandev="vxlan10"
 	test_mac=de:ad:be:ef:13:37
@@ -1037,11 +1037,13 @@ kci_test_fdb_get()
 		return $ksft_skip
 	fi
 
-	run_cmd ip netns add testns
+	setup_ns testns
 	if [ $? -ne 0 ]; then
 		end_test "SKIP fdb get tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
+	IP="ip -netns $testns"
+	BRIDGE="bridge -netns $testns"
 	run_cmd $IP link add "$vxlandev" type vxlan id 10 local $localip \
                 dstport 4789
 	run_cmd $IP link add name "$brdev" type bridge
@@ -1052,7 +1054,7 @@ kci_test_fdb_get()
 	run_cmd_grep "dev $vxlandev master $brdev" $BRIDGE fdb get $test_mac br "$brdev"
 	run_cmd_grep "dev $vxlandev dst $dstip" $BRIDGE fdb get $test_mac dev "$vxlandev" self
 
-	ip netns del testns &>/dev/null
+	ip netns del $testns &>/dev/null
 
 	if [ $ret -ne 0 ]; then
 		end_test "FAIL: bridge fdb get"
-- 
2.43.0


