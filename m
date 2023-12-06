Return-Path: <linux-kselftest+bounces-1240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69D8067FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3062822FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F213AF6;
	Wed,  6 Dec 2023 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWr5TRZT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604B1BD;
	Tue,  5 Dec 2023 23:08:45 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1f055438492so3879965fac.3;
        Tue, 05 Dec 2023 23:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846524; x=1702451324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn/Kekgv+2Dpp2fAM0Z6c0QdMJhE99qnph2y52xtVLo=;
        b=JWr5TRZTYhDSP0bCg8Aqd5RDkPDMD6LSlWSd/s4ox2xyDe56GByJ4eGOKHX17ZytQq
         MWoBatwnSnPcyk1zZrbpkQU6iwUJX4uzLQ+x4MBGk8t9cjBAldKVFh0yVciOtsGC+r7C
         uDSbpk8RAlHN+C/gKoPlsUgKvIfz0d6y0X16XXT8xtYzVDyqpLQEYJ6HY1N13FRV3IJ5
         YCZse6+fPbB254/iG99jtfV3/Ic8YtL0wcjeIr99WkS8PBm8FDXHBD3QSNJXh62uSQLw
         iwVY/6Mv2rWunT14eE13QHknPUAN7BtoKjNC54YFe2tcfHeJ9Olda89rDTzk46Mans6Q
         HS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846524; x=1702451324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn/Kekgv+2Dpp2fAM0Z6c0QdMJhE99qnph2y52xtVLo=;
        b=KhiWWda+Uvt7Ph8Jj0IxjeHQSamWFMZ2F70tdxudqlLYwff6ieQQSlNeP1vbPTjIxe
         49Py3XWBR9+2QQxmquFuuRBjnioZl/WdW2KbSWkBxi4y+ptqGb1wKwbkOc3Pg6UcCjeK
         lyG/RwHOxa65gGEnqCKASMwL56xmPfLrWQ8gVhENyGt5XjQxunfu5rWuAwR/Hd/Hiz2O
         fioOrbYCc+t9GZClArongr5+dqWe4llz3xs2mHwcq0QgkJrH5yShQ0xI3NSmXuPreOBC
         y7aETXxiToIu9zNWYKTjVlfcD4nWkDZiIVdQpK00D3K2F7he5f1a3uh8URE5SX+0x/in
         FktQ==
X-Gm-Message-State: AOJu0YzSkLUjNsXNjHYGbl8Ox0SFaI2gH5F8OI/UFN+F6B1IN3u/rrSU
	90u2fY7MZ7tNpVBCs+GnOHm4UI7o+r6ZcfW+
X-Google-Smtp-Source: AGHT+IEIPXyaOBU+0lLIALRfFeMw+cEIthCMWkA/FioWsb4QcOVTFUzqGNjz5vxiKLQt5sph7KhxBA==
X-Received: by 2002:a05:6870:e8c7:b0:1f9:697a:69e1 with SMTP id r7-20020a056870e8c700b001f9697a69e1mr448756oan.16.1701846524264;
        Tue, 05 Dec 2023 23:08:44 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:43 -0800 (PST)
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
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 8/9] selftests/net: convert vrf_strict_mode_test.sh to run it in unique namespace
Date: Wed,  6 Dec 2023 15:08:00 +0800
Message-ID: <20231206070801.1691247-9-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206070801.1691247-1-liuhangbin@gmail.com>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
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

Acked-by: David Ahern <dsahern@kernel.org>
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
2.43.0


