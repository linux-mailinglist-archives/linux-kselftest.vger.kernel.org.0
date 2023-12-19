Return-Path: <linux-kselftest+bounces-2182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998AD8184C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EBBB236C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3A13FE9;
	Tue, 19 Dec 2023 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU8PEMC9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918014270;
	Tue, 19 Dec 2023 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b0c586c51so1852643a91.2;
        Tue, 19 Dec 2023 01:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979356; x=1703584156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHEI46KopoFTbSHMVTDnz8gmhnmWTUCL99W+mBGa7H8=;
        b=LU8PEMC9kN9s8uvNQ1OXrtHrGSDtHZTurpEMAn/orMatxpjSoIfuf+jD6/IZyYq9Cg
         Klt27sLDH76RCQ1DbeNCJf8oKR2D5tLUeb3wSz5bAqMMfHMs4jpUqYxtE58KKl/7JpWA
         5MVOtTSrRs8xvN96vEo1wqI1hSAjWGn66jnu1208RiDB+UhELHekv8sDgvcjJvxUA5Uv
         1YeJwTz8C5un/Gu3iGZLddxVBIuY/QW6bvzf01YvoiCY20Av6C7aFzTIahZaf3LbiYA/
         l7h4SEMu9OniBDACwu86e5QO9CA/kwYgHafRZyrdfT6BWC7hhMQg9IVMCTivZXmqh4wy
         AtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979356; x=1703584156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHEI46KopoFTbSHMVTDnz8gmhnmWTUCL99W+mBGa7H8=;
        b=lSHzToI7FH+1rD2Y/CgntGxeEVUMwT89vIKgN17mm2RIXkGnLdmEfDZa4/qQPH5tzG
         2qgBsDH3DqU+FHt6/+RSY79PoKXdmTxLa1CZe23wu/pKgTawVLJHdXGloSFy4p9LF+XR
         Ulx3JYtgo5v/kdm/EwZyDRG1ef1JUY4DUUkQ0uYgsAW6F9rNra/GupxVflSlcK7C65DK
         3Nuik/HnxLQKct4GN/YndUm6zxsnXE5OtB+I75ZqUFPhzp8ULWDZWBqu2FWQfj+6eFBk
         7nEd16qB+bYK0TXZMQ3gnK58gsVjvF4xn5Puzqs61X5R5heeRWDL5fnpMUGcgn3pHA7v
         gMLg==
X-Gm-Message-State: AOJu0Yx1zlHmg4SjecE0N57Ha8XFFa+erVTcNMoSBBSUUkP2J+xamjcn
	d8zDS7Z+xp1qpMPBBT1E1ImlkU/LYtEsf8QTzk4=
X-Google-Smtp-Source: AGHT+IHnvxyHX+vfcv9x6cwV9hXoUi+MoGSaVcqW/7q86wDDkywRN4r1sQE3DDI9qzX6lfuNdGtlZg==
X-Received: by 2002:a17:90a:dc0c:b0:28b:bf5c:9b69 with SMTP id i12-20020a17090adc0c00b0028bbf5c9b69mr145305pjv.53.1702979356366;
        Tue, 19 Dec 2023 01:49:16 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:15 -0800 (PST)
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
Subject: [PATCH net-next 2/8] selftests/net: convert netns-name.sh to run it in unique namespace
Date: Tue, 19 Dec 2023 17:48:50 +0800
Message-ID: <20231219094856.1740079-3-liuhangbin@gmail.com>
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

This test will move the device to netns 1. Add a new test_ns to do this.
Here is the test result after conversion.

 # ./netns-name.sh
 netns-name.sh                           [  OK  ]

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/netns-name.sh | 44 +++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
index 7d3d3fc99461..6974474c26f3 100755
--- a/tools/testing/selftests/net/netns-name.sh
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -1,9 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source lib.sh
 set -o pipefail
 
-NS=netns-name-test
 DEV=dummy-dev0
 DEV2=dummy-dev1
 ALT_NAME=some-alt-name
@@ -11,7 +11,7 @@ ALT_NAME=some-alt-name
 RET_CODE=0
 
 cleanup() {
-    ip netns del $NS
+    cleanup_ns $NS $test_ns
 }
 
 trap cleanup EXIT
@@ -21,50 +21,50 @@ fail() {
     RET_CODE=1
 }
 
-ip netns add $NS
+setup_ns NS test_ns
 
 #
 # Test basic move without a rename
 #
 ip -netns $NS link add name $DEV type dummy || fail
-ip -netns $NS link set dev $DEV netns 1 ||
+ip -netns $NS link set dev $DEV netns $test_ns ||
     fail "Can't perform a netns move"
-ip link show dev $DEV >> /dev/null || fail "Device not found after move"
-ip link del $DEV || fail
+ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found after move"
+ip -netns $test_ns link del $DEV || fail
 
 #
 # Test move with a conflict
 #
-ip link add name $DEV type dummy
+ip -netns $test_ns link add name $DEV type dummy
 ip -netns $NS link add name $DEV type dummy || fail
-ip -netns $NS link set dev $DEV netns 1 2> /dev/null &&
+ip -netns $NS link set dev $DEV netns $test_ns 2> /dev/null &&
     fail "Performed a netns move with a name conflict"
-ip link show dev $DEV >> /dev/null || fail "Device not found after move"
+ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found after move"
 ip -netns $NS link del $DEV || fail
-ip link del $DEV || fail
+ip -netns $test_ns link del $DEV || fail
 
 #
 # Test move with a conflict and rename
 #
-ip link add name $DEV type dummy
+ip -netns $test_ns link add name $DEV type dummy
 ip -netns $NS link add name $DEV type dummy || fail
-ip -netns $NS link set dev $DEV netns 1 name $DEV2 ||
+ip -netns $NS link set dev $DEV netns $test_ns name $DEV2 ||
     fail "Can't perform a netns move with rename"
-ip link del $DEV2 || fail
-ip link del $DEV || fail
+ip -netns $test_ns link del $DEV2 || fail
+ip -netns $test_ns link del $DEV || fail
 
 #
 # Test dup alt-name with netns move
 #
-ip link add name $DEV type dummy || fail
-ip link property add dev $DEV altname $ALT_NAME || fail
+ip -netns $test_ns link add name $DEV type dummy || fail
+ip -netns $test_ns link property add dev $DEV altname $ALT_NAME || fail
 ip -netns $NS link add name $DEV2 type dummy || fail
 ip -netns $NS link property add dev $DEV2 altname $ALT_NAME || fail
 
-ip -netns $NS link set dev $DEV2 netns 1 2> /dev/null &&
+ip -netns $NS link set dev $DEV2 netns $test_ns 2> /dev/null &&
     fail "Moved with alt-name dup"
 
-ip link del $DEV || fail
+ip -netns $test_ns link del $DEV || fail
 ip -netns $NS link del $DEV2 || fail
 
 #
@@ -72,11 +72,11 @@ ip -netns $NS link del $DEV2 || fail
 #
 ip -netns $NS link add name $DEV type dummy || fail
 ip -netns $NS link property add dev $DEV altname $ALT_NAME || fail
-ip -netns $NS link set dev $DEV netns 1 || fail
-ip link show dev $ALT_NAME >> /dev/null || fail "Can't find alt-name after move"
-ip  -netns $NS link show dev $ALT_NAME 2> /dev/null &&
+ip -netns $NS link set dev $DEV netns $test_ns || fail
+ip -netns $test_ns link show dev $ALT_NAME >> /dev/null || fail "Can't find alt-name after move"
+ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
     fail "Can still find alt-name after move"
-ip link del $DEV || fail
+ip -netns $test_ns link del $DEV || fail
 
 echo -ne "$(basename $0) \t\t\t\t"
 if [ $RET_CODE -eq 0 ]; then
-- 
2.43.0


