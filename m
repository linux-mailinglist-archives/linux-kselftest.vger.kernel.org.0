Return-Path: <linux-kselftest+bounces-7919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C538A4286
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542121C20C88
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02E44C92;
	Sun, 14 Apr 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YDj1VvWI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADBA41A84;
	Sun, 14 Apr 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100670; cv=none; b=Y00gmP6f/BONqSzwRLo6wGhoG58V5LmP8Xu4mIGzraWCr7kwZcu5fVUUgGjUQuBHMhgAORHr78mJlANgZXPWbLSd/MW8TeF1gjwoFW67+GtuuBZ5BJa3PnBFxiFzc8hDD868um01BReOll99H21e5NYJzJYhfDKPdlM0/Bkfsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100670; c=relaxed/simple;
	bh=487rgzFDsEyfYYJUJzmpGlea8SYGkTaVFpU/m4GnPhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LeQXu1KNCuYHTERreJ7WkcBRMZ+qJzL9epYv7oAFxhAYV2OSgJ+8MmCaYKBOxoinIXZ2SaRdzunW/7EIPY98Kjlr5cRk+Zo++3n8didSYnu2d4L2B0zKSl3bC15vZirIdGeIyD9mz2bmV1qe8neoULYTZuVgUeyi8F3PI32+RMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YDj1VvWI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713100667;
	bh=487rgzFDsEyfYYJUJzmpGlea8SYGkTaVFpU/m4GnPhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDj1VvWI+Zd1nN1q5mxkwKT3RVs5cKsdV5UO6pDAYM9GXOSYkT3gXhtSqZCCoR+vi
	 N16Bjb32lz7RXm3a4lIIRoL7XtCTx0Dn9ZO/FBRcMakJjXrdsWue0XPOFzbqKT8Aqf
	 U3i25EZclyvuvs26Pb+/1mFAxoLB4nYA4MqMzSdoyX5/0/T6/ByvKGb0gh/A+kCFVL
	 px0LG+d5L7k7YGj927GcMiRhQov2dsvTexrJIwvRPMoA3Vfc3BZ+UswxhMUa63XpXJ
	 9h8E/CrueT38oYe5H2gScecZ15C0/BoOR6mKYVDGuHYsTarqw85euNpEknJpjcE+lR
	 JJhigHZ/W/mkw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8F0C637811CE;
	Sun, 14 Apr 2024 13:17:44 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 1/4] selftests: x86: check_initial_reg_state: conform test to TAP format output
Date: Sun, 14 Apr 2024 18:18:04 +0500
Message-Id: <20240414131807.2253344-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240414131807.2253344-1-usama.anjum@collabora.com>
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/x86/check_initial_reg_state.c   | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/x86/check_initial_reg_state.c b/tools/testing/selftests/x86/check_initial_reg_state.c
index 3bc95f3ed5859..c3d42b193222a 100644
--- a/tools/testing/selftests/x86/check_initial_reg_state.c
+++ b/tools/testing/selftests/x86/check_initial_reg_state.c
@@ -7,6 +7,7 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
+#include "../kselftest.h"
 
 unsigned long ax, bx, cx, dx, si, di, bp, sp, flags;
 unsigned long r8, r9, r10, r11, r12, r13, r14, r15;
@@ -53,20 +54,19 @@ asm (
 
 int main()
 {
-	int nerrs = 0;
+	ksft_print_header();
+	ksft_set_plan(2);
 
-	if (sp == 0) {
-		printf("[FAIL]\tTest was built incorrectly\n");
-		return 1;
-	}
+	if (sp == 0)
+		ksft_exit_fail_msg("Test was built incorrectly\n");
 
 	if (ax || bx || cx || dx || si || di || bp
 #ifdef __x86_64__
 	    || r8 || r9 || r10 || r11 || r12 || r13 || r14 || r15
 #endif
 		) {
-		printf("[FAIL]\tAll GPRs except SP should be 0\n");
-#define SHOW(x) printf("\t" #x " = 0x%lx\n", x);
+		ksft_test_result_fail("All GPRs except SP should be 0\n");
+#define SHOW(x) ksft_print_msg("\t" #x " = 0x%lx\n", x);
 		SHOW(ax);
 		SHOW(bx);
 		SHOW(cx);
@@ -85,17 +85,15 @@ int main()
 		SHOW(r14);
 		SHOW(r15);
 #endif
-		nerrs++;
 	} else {
-		printf("[OK]\tAll GPRs except SP are 0\n");
+		ksft_test_result_pass("All GPRs except SP are 0\n");
 	}
 
 	if (flags != 0x202) {
-		printf("[FAIL]\tFLAGS is 0x%lx, but it should be 0x202\n", flags);
-		nerrs++;
+		ksft_test_result_fail("FLAGS is 0x%lx, but it should be 0x202\n", flags);
 	} else {
-		printf("[OK]\tFLAGS is 0x202\n");
+		ksft_test_result_pass("FLAGS is 0x202\n");
 	}
 
-	return nerrs ? 1 : 0;
+	ksft_finished();
 }
-- 
2.39.2


