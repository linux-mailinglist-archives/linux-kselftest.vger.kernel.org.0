Return-Path: <linux-kselftest+bounces-1009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F395F8019D1
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303B81C209E0
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0146BB;
	Sat,  2 Dec 2023 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhPrCRTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EB9D;
	Fri,  1 Dec 2023 18:01:48 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35cd70d7735so9738985ab.0;
        Fri, 01 Dec 2023 18:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482507; x=1702087307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlLY4g9cr0HGrzaIYMi76SXlocTMG+p1N+1yvMTwCyA=;
        b=FhPrCRTZ0PesRsw8lWu0MZv0ctTCMcejYunCkX5j+g/w1RYtILBfdaRtjfkQ57zRfR
         05M8aCmJaGzHXhd7NPOFAFih6psiUbry0wpQgLDdjgpNxJoyUItdojODE6kL2uQYVuGH
         pEXNCM+rxW1fYgPCR80RKfdozIfsJYI7eGmKYAiVvdLTGupGHa1BuBY59ooFu+2ITsmg
         3c+XoARCAbNY9+YN6dADwt0vhQTyvn5eC2BICMBNXUAcZPjmPxHUy7SzQ10XqY/xD42I
         LlFRXMNnrax8L60D1fjsBfCjHmYNmDEKLmU+jnQQ1QgGN+HRqEW8lfz+E9An0r2qxgZf
         prAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482507; x=1702087307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlLY4g9cr0HGrzaIYMi76SXlocTMG+p1N+1yvMTwCyA=;
        b=aNI/0ANCz7a1zDvCJqvDjRGsxJQ8XHOYHLeVqpbvrC/aZsRbdIi6Zdei3mkH9mjGU6
         BQegW/jO2ctDGtXqr9ICnGCRpM4awKkppxKyqW4Y3MRZva8fXGI5JAAB9lOT+OVc/b3f
         9iXaRPEDUVn9xvhNJnnNO07PedYB6ZrIgoqVTfIMBnyVrDzvlS0smODLQE5YpamUiu3Z
         GBta4zc92yVSllP0oUfLea/YXW/ai0zhM0PO7FtMjvzIozXq0D0qwKo99ajGbp1YWli/
         GJVgDnxsodP8YIZLFQUpii+kEFePQrWP/XRrovmOqf81x0o14nIXCA3zMbvW5DU6tBJW
         G0yA==
X-Gm-Message-State: AOJu0YyO4SQB4tSPdYQ2y0A9YLMBj+zJLECRQZfTdGWqjPFdvieiehiM
	KMd0JbF2RjunYAE57ct/kZ2c6Y56FczgN89P
X-Google-Smtp-Source: AGHT+IHRw79P6AWBNlO8YZ48r1z3qEjdrcs/YuDrc0xzRntWMORjCsLSUPOLP6aSajhKn0wt/h5yYA==
X-Received: by 2002:a92:dc0b:0:b0:35c:dbda:25f9 with SMTP id t11-20020a92dc0b000000b0035cdbda25f9mr542336iln.31.1701482507664;
        Fri, 01 Dec 2023 18:01:47 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:47 -0800 (PST)
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
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 06/14] selftests/net: convert drop_monitor_tests.sh to run it in unique namespace
Date: Sat,  2 Dec 2023 10:01:02 +0800
Message-ID: <20231202020110.362433-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

]# ./drop_monitor_tests.sh

Software drops test
    TEST: Capturing active software drops                               [ OK ]
    TEST: Capturing inactive software drops                             [ OK ]

Hardware drops test
    TEST: Capturing active hardware drops                               [ OK ]
    TEST: Capturing inactive hardware drops                             [ OK ]

Tests passed:   4
Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/drop_monitor_tests.sh       | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/drop_monitor_tests.sh b/tools/testing/selftests/net/drop_monitor_tests.sh
index b7650e30d18b..7c4818c971fc 100755
--- a/tools/testing/selftests/net/drop_monitor_tests.sh
+++ b/tools/testing/selftests/net/drop_monitor_tests.sh
@@ -2,10 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # This test is for checking drop monitor functionality.
-
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
 TESTS="
@@ -13,10 +11,6 @@ TESTS="
 	hw_drops
 "
 
-IP="ip -netns ns1"
-TC="tc -netns ns1"
-DEVLINK="devlink -N ns1"
-NS_EXEC="ip netns exec ns1"
 NETDEVSIM_PATH=/sys/bus/netdevsim/
 DEV_ADDR=1337
 DEV=netdevsim${DEV_ADDR}
@@ -43,7 +37,7 @@ setup()
 	modprobe netdevsim &> /dev/null
 
 	set -e
-	ip netns add ns1
+	setup_ns NS1
 	$IP link add dummy10 up type dummy
 
 	$NS_EXEC echo "$DEV_ADDR 1" > ${NETDEVSIM_PATH}/new_device
@@ -57,7 +51,7 @@ setup()
 cleanup()
 {
 	$NS_EXEC echo "$DEV_ADDR" > ${NETDEVSIM_PATH}/del_device
-	ip netns del ns1
+	cleanup_ns ${NS1}
 }
 
 sw_drops_test()
@@ -194,8 +188,15 @@ if [ $? -ne 0 ]; then
 	exit $ksft_skip
 fi
 
-# start clean
+# create netns first so we can get the namespace name
+setup_ns NS1
 cleanup &> /dev/null
+trap cleanup EXIT
+
+IP="ip -netns ${NS1}"
+TC="tc -netns ${NS1}"
+DEVLINK="devlink -N ${NS1}"
+NS_EXEC="ip netns exec ${NS1}"
 
 for t in $TESTS
 do
-- 
2.43.0


