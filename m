Return-Path: <linux-kselftest+bounces-536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DAF7F6FCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92F01C211F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32917993;
	Fri, 24 Nov 2023 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4/LTHdo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234A10C9;
	Fri, 24 Nov 2023 01:30:19 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cf61eed213so14279035ad.2;
        Fri, 24 Nov 2023 01:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818219; x=1701423019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDn8yu+ZXSMz5mDoGBzoKKYnvA+22L4dgcOQ1oqMhxo=;
        b=b4/LTHdoiElVYt8Aq9QpVuz/aFdHa5ImWLJIXLWdA4DEupXNUIak7ptBwDTfSjv1hn
         aTzBrng74+0dUmWmuEugmMPtGCqaaFfVYYTEUBi4fEZGcINVOX7stf4wIXy3N3rblI+u
         s7NPBn7Y+ChxT6bxklfMNT2iZlzouxXg/CdB6DEAYGdXD8aV7f9lRgvMxs81vuPRZWJ2
         YmYne7MI4Vyk5NbGwevg4OVtp6H/wsOf12+a1dWbPMhUkhpBJsnABfQpYttYbzuAJzQY
         VGW//mP3G1My31DPI77gqDVb/KEN/+iH2KzPgk5DXpvyIILbvmOiHnRhM4UshAzSoPR2
         5WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818219; x=1701423019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDn8yu+ZXSMz5mDoGBzoKKYnvA+22L4dgcOQ1oqMhxo=;
        b=Ypx02i/cbjP7B9DGMx5/2OQ6TzwTyM/01EfUQsSfdqLh/2IUDu4nhAQWEk+kowHjrb
         9467U2JFM+E83ZJUwClJaGsaZ/YzBJGb5OW8oMbRx0zDkuCMGYnWRqSCZdQlgsVH34W6
         ZPNXFwKv5EK7HpXPZk1VOPZaiydm7nKoLXH1RWQ7t8+WNd4BMIqMBuK6eqUVfXHF+qfo
         WlSZGDca7puJF5KPePVRqDGUDZmphbihkp6IldZ7d8gudn90eJbx6SfxX7TfIwltJDGT
         5p73mcMxIUxVvJsRVlK8Tw3palO045BTMcd0dXRvRk02K5DZ+av5Xu9KbvgSlWciezsR
         ROFA==
X-Gm-Message-State: AOJu0Yw9z977vEPNlGqpy07q+3lCF8DW2lwWtPwTVHKiDtiob/upALYW
	3FNLcLDIMVBLI1v1T4wlZJjRYitOuMkl2+Jg
X-Google-Smtp-Source: AGHT+IEo3C9WUilU/fhGW9lY9ye2i/v7qOceBd5jmotOh/wGTq+twDbQ4uhZIx7xJi5h5fZl4N9c4w==
X-Received: by 2002:a17:902:f54c:b0:1cc:5aef:f2d1 with SMTP id h12-20020a170902f54c00b001cc5aeff2d1mr2415575plf.25.1700818218822;
        Fri, 24 Nov 2023 01:30:18 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:18 -0800 (PST)
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
Subject: [PATCH net-next 34/38] selftests/net: convert vrf_strict_mode_test.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:32 +0800
Message-ID: <20231124092736.3673263-35-liuhangbin@gmail.com>
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

 ]# ./vrf_strict_mode_test.sh

 ################################################################################
 TEST SECTION: VRF strict_mode test on init network namespace
 ################################################################################

     TEST: init: net.vrf.strict_mode is available                        [ OK ]

     TEST: init: strict_mode=0 by default, 0 vrfs                        [ OK ]

 ...

     TEST: init: check strict_mode=1                                     [ OK ]

     TEST: testns-HvoZkB: check strict_mode=0                            [ OK ]

 Tests passed:  37
 Tests failed:   0

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/net/vrf_strict_mode_test.sh     | 47 +++++++++----------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/vrf_strict_mode_test.sh b/tools/testing/selftests/net/vrf_strict_mode_test.sh
index 417d214264f3..01552b542544 100755
--- a/tools/testing/selftests/net/vrf_strict_mode_test.sh
+++ b/tools/testing/selftests/net/vrf_strict_mode_test.sh
@@ -3,9 +3,7 @@
 
 # This test is designed for testing the new VRF strict_mode functionality.
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
+source lib.sh
 ret=0
 
 # identifies the "init" network namespace which is often called root network
@@ -247,13 +245,12 @@ setup()
 {
 	modprobe vrf
 
-	ip netns add testns
-	ip netns exec testns ip link set lo up
+	setup_ns testns
 }
 
 cleanup()
 {
-	ip netns del testns 2>/dev/null
+	ip netns del $testns 2>/dev/null
 
 	ip link del vrf100 2>/dev/null
 	ip link del vrf101 2>/dev/null
@@ -298,28 +295,28 @@ vrf_strict_mode_tests_testns()
 {
 	log_section "VRF strict_mode test on testns network namespace"
 
-	vrf_strict_mode_check_support testns
+	vrf_strict_mode_check_support $testns
 
-	strict_mode_check_default testns
+	strict_mode_check_default $testns
 
-	enable_strict_mode_and_check testns
+	enable_strict_mode_and_check $testns
 
-	add_vrf_and_check testns vrf100 100
-	config_vrf_and_check testns 10.0.100.1/24 vrf100
+	add_vrf_and_check $testns vrf100 100
+	config_vrf_and_check $testns 10.0.100.1/24 vrf100
 
-	add_vrf_and_check_fail testns vrf101 100
+	add_vrf_and_check_fail $testns vrf101 100
 
-	add_vrf_and_check_fail testns vrf102 100
+	add_vrf_and_check_fail $testns vrf102 100
 
-	add_vrf_and_check testns vrf200 200
+	add_vrf_and_check $testns vrf200 200
 
-	disable_strict_mode_and_check testns
+	disable_strict_mode_and_check $testns
 
-	add_vrf_and_check testns vrf101 100
+	add_vrf_and_check $testns vrf101 100
 
-	add_vrf_and_check testns vrf102 100
+	add_vrf_and_check $testns vrf102 100
 
-	#the strict_mode is disabled in the testns
+	#the strict_mode is disabled in the $testns
 }
 
 vrf_strict_mode_tests_mix()
@@ -328,25 +325,25 @@ vrf_strict_mode_tests_mix()
 
 	read_strict_mode_compare_and_check init 1
 
-	read_strict_mode_compare_and_check testns 0
+	read_strict_mode_compare_and_check $testns 0
 
-	del_vrf_and_check testns vrf101
+	del_vrf_and_check $testns vrf101
 
-	del_vrf_and_check testns vrf102
+	del_vrf_and_check $testns vrf102
 
 	disable_strict_mode_and_check init
 
-	enable_strict_mode_and_check testns
+	enable_strict_mode_and_check $testns
 
 	enable_strict_mode_and_check init
 	enable_strict_mode_and_check init
 
-	disable_strict_mode_and_check testns
-	disable_strict_mode_and_check testns
+	disable_strict_mode_and_check $testns
+	disable_strict_mode_and_check $testns
 
 	read_strict_mode_compare_and_check init 1
 
-	read_strict_mode_compare_and_check testns 0
+	read_strict_mode_compare_and_check $testns 0
 }
 
 ################################################################################
-- 
2.41.0


