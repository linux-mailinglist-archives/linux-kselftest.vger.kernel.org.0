Return-Path: <linux-kselftest+bounces-515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C867F6F9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA759B2127A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FCA156C5;
	Fri, 24 Nov 2023 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9wY8Esb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AFED72;
	Fri, 24 Nov 2023 01:28:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ce656b9780so12302655ad.2;
        Fri, 24 Nov 2023 01:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818129; x=1701422929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GskYLmUfs6Fe2yscHBTlgmw9gEjKPoJWbII+VS/af9U=;
        b=J9wY8Esb1KpydOor/J/FfB8pXZIgIW3s9sjN+DIEz+6s4t9Yvs2FmfKFH4YDS/tP5F
         MU1ET0p+n7//Paai0Ph3JjY2W/K0hedoQm3oeUJAQRVf6mhp1fpxWgLFIFuZleZn8EQG
         Cr0xyg15xecJSxPHW3LRod70vbYYjdYJLcS2dE8KBDV6BIIszlGaSnEqzAPdbn3HytNk
         wrF28jRsBrAtUPdsmyDXufmra7f7pJ5yVW+I3ZeoKcGUCVsK/oMOFau783GsWTDsZfgJ
         AOu73ozmiTOA0vk5ALxTAis3srYIaJpQd7JrSnEgRwMRPnrm9BB9ETwCNGSbRzxuBPuL
         QGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818129; x=1701422929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GskYLmUfs6Fe2yscHBTlgmw9gEjKPoJWbII+VS/af9U=;
        b=mYh1+fBybdx8uZPe2sSXnq0f1bwScc06oBxEvQA6ScWcu0YItLzfeL0724FAYQmERH
         hN1mg8zWXPonZx+DvmC5Cey2svrqb6fxaWii2D6CGSGPGfWzTONcX6Px/hNX33Q9yPB7
         xdYntrzE2Lh+CDEoGMFbR1rkjsxFSMCT541OY4KDyJgJf4FySYvZqw4MjtMRp21PraYK
         8hSqfd+2nnWpVDsIPecxLyYp2UhKrO0jbE5xrj8ySZIbCWw171I17PJBXvxlecENOJXt
         uUreqhXQljm/OCJWDSOPj7fZ9P1cYxHRaZ3PUuVmuey6qINRonLKthGA6JbzfUbH/1ki
         DIJw==
X-Gm-Message-State: AOJu0YxHdLKmwlcC8UedihEjBz+SjwHBh0+mk9ZBIDOI7q7zRsfrL8cW
	9hb1XhegW4mtYNsxp5iE1UPK7bXtnO8nOHMM
X-Google-Smtp-Source: AGHT+IHXvyF/nc4LyjrBMaOxPw1mmBOxwRDIECkt0+r/UFm1Tko9yU/wdqLrhEYXYNfRsc2OuV5RKg==
X-Received: by 2002:a17:902:f7c6:b0:1cf:5c9b:5c27 with SMTP id h6-20020a170902f7c600b001cf5c9b5c27mr1650445plw.63.1700818129688;
        Fri, 24 Nov 2023 01:28:49 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:28:49 -0800 (PST)
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
Subject: [PATCH net-next 13/38] selftests/net: convert gre_gso.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:11 +0800
Message-ID: <20231124092736.3673263-14-liuhangbin@gmail.com>
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

]# ./gre_gso.sh
    TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
    TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
    TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
    TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]

Tests passed:   4
Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/gre_gso.sh | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/gre_gso.sh b/tools/testing/selftests/net/gre_gso.sh
index 3224651db97b..5100d90f92d2 100755
--- a/tools/testing/selftests/net/gre_gso.sh
+++ b/tools/testing/selftests/net/gre_gso.sh
@@ -2,10 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # This test is for checking GRE GSO.
-
+source lib.sh
 ret=0
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
 TESTS="gre_gso"
@@ -13,8 +11,6 @@ TESTS="gre_gso"
 VERBOSE=0
 PAUSE_ON_FAIL=no
 PAUSE=no
-IP="ip -netns ns1"
-NS_EXEC="ip netns exec ns1"
 TMPFILE=`mktemp`
 PID=
 
@@ -50,13 +46,13 @@ log_test()
 setup()
 {
 	set -e
-	ip netns add ns1
-	ip netns set ns1 auto
-	$IP link set dev lo up
+	setup_ns ns1
+	IP="ip -netns $ns1"
+	NS_EXEC="ip netns exec $ns1"
 
 	ip link add veth0 type veth peer name veth1
 	ip link set veth0 up
-	ip link set veth1 netns ns1
+	ip link set veth1 netns $ns1
 	$IP link set veth1 name veth0
 	$IP link set veth0 up
 
@@ -70,7 +66,7 @@ cleanup()
 	[ -n "$PID" ] && kill $PID
 	ip link del dev gre1 &> /dev/null
 	ip link del dev veth0 &> /dev/null
-	ip netns del ns1
+	cleanup_ns $ns1
 }
 
 get_linklocal()
@@ -145,7 +141,7 @@ gre6_gso_test()
 	setup
 
 	a1=$(get_linklocal veth0)
-	a2=$(get_linklocal veth0 ns1)
+	a2=$(get_linklocal veth0 $ns1)
 
 	gre_create_tun $a1 $a2
 
-- 
2.41.0


