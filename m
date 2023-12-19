Return-Path: <linux-kselftest+bounces-2181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8BC8184C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4048E1C23A7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034F14006;
	Tue, 19 Dec 2023 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJSnUBdV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF613FE5;
	Tue, 19 Dec 2023 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28ba18740d6so1174304a91.1;
        Tue, 19 Dec 2023 01:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979352; x=1703584152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkMZMH3Iw0DBwphNefyafQMICe6Pnez2GwihrP7r9/E=;
        b=XJSnUBdVFyPI3FgOZ2OTGR4CssfxE2vbZ+3JKoDdRo15BxSIfwLkinBK3Y0o0ZD58y
         8YdxSarcfukRTSm0HkEQKMoyuEdiv/nczW2mYGyYvugoxqT/VQQHEfSNMpHW2eys3Iif
         MnbIF2M2aqbTMEI/mSvKHjzmperL2gKuYjhKECxKA6qeA9JmOTFkGRAEL9BnfRn4MwGO
         DTQ9/GEN1oNc2CxbbhzlBtfL+5c+wEnpAxDo89WznqQ6R0XJ0swI3LYcrfgcWWtEzADh
         /xtYqspTI5RGlmE3kdiDf24RVA/ZKvv8Rt5LENslGjS+AfIOqKdAPbpoXJsAhmJiZPiz
         Q+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979352; x=1703584152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkMZMH3Iw0DBwphNefyafQMICe6Pnez2GwihrP7r9/E=;
        b=Pyc+1xnF1eByjpZVlDPdG+ff3YywAUkOrGcCXO5RPA/0XFrFJ9EYK6Xdcgw8pwK4/Z
         8TIKsiDq9U85oRxnKEIdJXrGVueeGloE8htyMwyEDOhwQW39J4aob7SbYFG97cBKutU2
         3E6aGGsca70KXEJlKDlG6eL79h53sf51SBcQqlaBitf8I27huiBL0WEH+Q8nAXZsKccP
         M2vzPTJ5nMG8N+zs1YuKpZsuPUZvo4NaqXVs2lX4Y6eWdP7TS8N2fvBKk+QJpkNhAnCR
         iq6MaEoFmpQqL4xxYvyunkZ4aqqcN79D7PT4xa0GGum47E/xoTERuI3tn3ca7HZNkGV5
         PZ0Q==
X-Gm-Message-State: AOJu0Yz0Bjbz0PGq9CWK7Upen+NN+PxYFxEn73lYqAawRRYnqTlzHs2Y
	ttAeRWDCJ9l78mFvCT43gSLBx/jn26El3vCUP9U=
X-Google-Smtp-Source: AGHT+IG7iVc0O0Vjmly1Zhvl+WDIJBRtzae59V5k5lbL/WAKGzDB6dvMkUhHnz9dmT9V5S4uCyEQww==
X-Received: by 2002:a17:90b:4ac5:b0:28b:98e5:3ae8 with SMTP id mh5-20020a17090b4ac500b0028b98e53ae8mr1678749pjb.95.1702979352546;
        Tue, 19 Dec 2023 01:49:12 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:11 -0800 (PST)
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
Subject: [PATCH net-next 1/8] selftests/net: convert gre_gso.sh to run it in unique namespace
Date: Tue, 19 Dec 2023 17:48:49 +0800
Message-ID: <20231219094856.1740079-2-liuhangbin@gmail.com>
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

Here is the test result after conversion.

 # ./gre_gso.sh
     TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
     TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
     TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
     TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]

 Tests passed:   4
 Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
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
2.43.0


