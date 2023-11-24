Return-Path: <linux-kselftest+bounces-507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43227F6F8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F131C20F50
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD18C18;
	Fri, 24 Nov 2023 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv48Xu5q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9DFD46;
	Fri, 24 Nov 2023 01:28:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so13641075ad.0;
        Fri, 24 Nov 2023 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818095; x=1701422895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1L/ZZdYZKIoDq9m4iqvKtYtXvoTpGtCEg5hK4lKFBY=;
        b=Cv48Xu5qhFuquvZnP02O8OLQrQ+kDsczsGYPta2+VJBCfczC9C8eyhSrTLCSw3lU2S
         JyFtB3pOkX6MZh1Y13bj1+IDt2aDWlqYA5FH/A+s3k0WtKM/03VNdCocPLb9HRdWgfRq
         riTEXVkZutqLs9/mURSq6uZvAoInOaqNPDgsDAxrhGEAvb1be5Qz/MiLzfxtiM2FdVc2
         JcE6CnTDHO6AUnS1RH54/BXynus0tvnrTqFT241Rz3305R7N4bXTVmKkk6o0mBQFub0L
         HW6muIHbVi0Dgj6L2l77+bXYUFl0cIVTZ/midRisI/KPZufGxawEHyL7Kd2VfA8L6x15
         BfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818095; x=1701422895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1L/ZZdYZKIoDq9m4iqvKtYtXvoTpGtCEg5hK4lKFBY=;
        b=Fb5Mq9p2/A2XHo2kt2GBdUY8oIosLDbwqNsghM0Vc94lctBbQ6A5Jg93mETzvIyML6
         MHxuJXbrKzIgvMBV9Mqt4fzRw7ytvLvgxY9fImbu5Smn2wrqWKzVcjo2PaBhPuVk4NlR
         PeGNnC/mSa/txxIJE4J/wsnE0LN3X9XKr00aAom1ginTt+Ky3QbRr8ehGhPFFxc9KjVz
         TASFepAmmFmiL32LyzLACN4b9YnX/lgP/NWmZgbiSU3J7Z8XDWDuAhn6KDyc0oLpaBfu
         Ce3pKHg0RDNbbvtV4ZynIdVyPz/c9XbQvE7vtHyAqbEZplq1qq2cd+ZDfhOggG0K+fPX
         oOJQ==
X-Gm-Message-State: AOJu0Yx45Nr5OvoyoHTlBEQvaw3XAqHlI6I+Nn5ax+LD9/H3cVmBBvbv
	ClhIw3y2tEsi7h6kvxoTwuOAlbNUn0d6yWOm
X-Google-Smtp-Source: AGHT+IHppfy9LGBWA9mu7XWJRgl5SLxtkygd69XovfWzlbvyv55RbfKjgeXOrnW+cOBm9AiMiqzv+Q==
X-Received: by 2002:a17:902:f68d:b0:1cf:6704:4340 with SMTP id l13-20020a170902f68d00b001cf67044340mr2170223plg.22.1700818094866;
        Fri, 24 Nov 2023 01:28:14 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:13 -0800 (PST)
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
Subject: [PATCH net-next 05/38] selftests/net: convert drop_monitor_tests.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:03 +0800
Message-ID: <20231124092736.3673263-6-liuhangbin@gmail.com>
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

]# ./drop_monitor_tests.sh

Software drops test
    TEST: Capturing active software drops                               [ OK ]
    TEST: Capturing inactive software drops                             [ OK ]

Hardware drops test
    TEST: Capturing active hardware drops                               [ OK ]
    TEST: Capturing inactive hardware drops                             [ OK ]

Tests passed:   4
Tests failed:   0

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


