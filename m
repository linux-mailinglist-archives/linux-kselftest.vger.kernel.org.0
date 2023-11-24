Return-Path: <linux-kselftest+bounces-521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ED17F6FAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035CD1C20EBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC27E156F3;
	Fri, 24 Nov 2023 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGmRUkBT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF002130;
	Fri, 24 Nov 2023 01:29:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so13646245ad.0;
        Fri, 24 Nov 2023 01:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818155; x=1701422955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LY4WPf/MahyNM1S1ntBoPtimQ0BVkvnOaAkw3gEnbUk=;
        b=KGmRUkBTuRDHnFUSugJSXsj6L2PtPldAYVLFml64gWAqKELXEb7ndCGc/tMefoMH6l
         ffyD5guY5b7hLHPtWahLtp2+czgA/BawNIZVDCvZM2msHUUwyIFCnHEaTjTN7x7Vrjee
         YrOaQKwKA8yZ5X1NRGyly/D9ko6ut57Mn66mH/cSMKNJKFMy4oMIwThJ6UCuqpgYkU5X
         AMrjLC4UdrTAYU68dUoFuyW06vaxEPrnkzLX5HP2wTpgmGPhneal/jOnpJNtoOKDNSly
         5ZtsPOsYx/LPMLVkx9o9E7m3R4Cm65nIeW7F4WI2WB3CS4i/WDkqKj42onKY85Mz2BK+
         0f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818155; x=1701422955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LY4WPf/MahyNM1S1ntBoPtimQ0BVkvnOaAkw3gEnbUk=;
        b=VvARx9WaZxJJblQWY2UFIPyMcIYwpskFOp83jLcwTjOsr61Vfq4V8/lHsOYy8RrXyL
         Buhk4qYNIxevef6Dk/CC5JK09Ps6jHYyM7DEggHMq8uCmrt2Od75CYNcRAEgcAgooz3W
         6ezF3a6qkueNIuQGTX5OdJCcVUOB9lJ/PL40Qd8CCT1nTnPFIJKT4mYs/RiR+98674hn
         bJAUTFfe2JFCYHuLVJ8X3iK+yKWEcQGINBxeVffbg2bk0GK26eOqGl4D3pnsV6uX+zLs
         brCsZ0dK2DwntHaasqVzYv8mpYyIyA8mimuZsZ41/4u01ohd6C79om71YVPcFKY98Fe7
         Wxog==
X-Gm-Message-State: AOJu0YxQXUpr9VKErsPBiV6zW08O6B/g9/jet7WViODaKs5EQzSz37DY
	RrlBhSz+VZW/nB3k0GrJqr8x4LDHMsHaBN5g
X-Google-Smtp-Source: AGHT+IHofJMCwL/Q1VzrVKTUJmiNNUL0pOW/oF5m29+Ib2G8U6UvIdP0o7ChaFrDiL5aO3OP+4/4Vw==
X-Received: by 2002:a17:902:a5c9:b0:1ca:b26a:9729 with SMTP id t9-20020a170902a5c900b001cab26a9729mr2129226plq.38.1700818155029;
        Fri, 24 Nov 2023 01:29:15 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:29:14 -0800 (PST)
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
Subject: [PATCH net-next 19/38] selftests/net: convert netns-name.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:17 +0800
Message-ID: <20231124092736.3673263-20-liuhangbin@gmail.com>
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

This test will move the device to netns 1. Add a new test_ns to do this.
Here is the test result after conversion.

]# ./netns-name.sh
netns-name.sh                           [  OK  ]

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
2.41.0


