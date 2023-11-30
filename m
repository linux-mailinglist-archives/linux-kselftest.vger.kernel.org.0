Return-Path: <linux-kselftest+bounces-868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED05B7FE7FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C672B2143C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570114A8F;
	Thu, 30 Nov 2023 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXYeLDT9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08B10C3;
	Wed, 29 Nov 2023 20:01:44 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cdd9c53270so459478b3a.1;
        Wed, 29 Nov 2023 20:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316903; x=1701921703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa9mNXvwNhkrNlDep8B7GfmxL7b3B/m9/X+O5mp5KPA=;
        b=GXYeLDT9D+lls5A69MSEhY85ugL3UVaOi7AP97v9dYvoqWqNzPl74qBXJsUDpsr9Bq
         SzMQzLl1ugp9vW153M2Yv8dlDfyEPoGRhbDeKUxkDN7vWHdcVDi7W+93lac9Q7kCtx/R
         6PDIf1dwFksx9JUBTh9nS5ZZxZkLUHsKamFtiY7xWRsfc5ETljQL02dvtEuyW5Btezx+
         hqv8vGWWLT1FyDQGcDXPRHd0GTaEjdvHPbhv+ojj2SQjWvLpegXh3CXQ7A2Yib4//6KM
         AyXDzjJFJZtEAR+t/8EOt36BX2Cmwc1k7hd3+d6YXV+CV+zqNNv2mPhwqjusojr/tuoa
         A/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316903; x=1701921703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa9mNXvwNhkrNlDep8B7GfmxL7b3B/m9/X+O5mp5KPA=;
        b=X89FYEKuZIP+znfdFU59syB/jN7d9zAZzZrYtOVsZ0IaFzhlPrt/Z3sy20uwZQoTK+
         Wj6/tssRWGOIScZNL2e+YcFA4jyDQsk3lXN2f8Xx6cqBYukC2CHUiqlNSi7mm9gSlGYo
         ZgiiyefU1ehF+M0fwY8c0OnrcT5XtlV1YwA2am/o2X6IjKo3RVoWXQIJ7OlGMOS4b35I
         1NPYI5FbS2tu0SUqWLy5zEjNbr+ZO7rrZk3aTNv6JcpknYWRr3MnwIT0aa8DkueYL1ez
         8J/lUovkIofk8mphXyr1O/Vet5NSKeSwhC9rmXw53HeNmTbWbcHEov6YNglPGI/8Uwje
         4kEg==
X-Gm-Message-State: AOJu0Ywo7p4wIcbRzBMtqJM+5Rkej46ETfqvkI15yWpbRdmPjRlvB6Vx
	z/jc9YhCZqDXgHlcpj4s95jO6FrdgAiXZQ==
X-Google-Smtp-Source: AGHT+IEYD+Jd+hb+6UhAxjVQtjKC9nRUhIT28YcbQbq3KhwCYv3go7d9v2Q1y71mAq87FaDoZ5oTww==
X-Received: by 2002:a05:6a00:2d8a:b0:6c2:cf23:3e14 with SMTP id fb10-20020a056a002d8a00b006c2cf233e14mr21689154pfb.15.1701316902928;
        Wed, 29 Nov 2023 20:01:42 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:42 -0800 (PST)
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
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 06/14] selftests/net: convert drop_monitor_tests.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:00:57 +0800
Message-ID: <20231130040105.1265779-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130040105.1265779-1-liuhangbin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
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
2.41.0


