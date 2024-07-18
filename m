Return-Path: <linux-kselftest+bounces-13876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B2934C9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 13:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F1B1C21EC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 11:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4DB13774A;
	Thu, 18 Jul 2024 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YNCm/H9y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71878C92;
	Thu, 18 Jul 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302362; cv=none; b=I3dIaif/cY0Ljxn87KhcrcNB2vAYt+HYW4kpNEciiP0fMZcRB3mtxe1B9lTwrqPEa8rQRUIOKFxbzgNsD9SzeNRz/+puhUJhTf9ZvOrm+3SEUyvqQ1PVwchoAnrJ3IkP3uR76jlYTSlqwPJO9ZnS8ViEGXKfK2kk8iveFoaFWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302362; c=relaxed/simple;
	bh=e/ELe0uCIXAZ9JK3bV6Hqi3tnbjAlG1JCWOxpmjk/C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFcRq9iPUjaChBiO4tI8uHZBFvW+nonJB6QYh2OPha26vItFpTQceNIM8F7h7LDwQHZqE7sYTmX/8Qak6mBflQtYj9ncQq+EyXfPcpxAzHgdy6lKH7XHj69hxV8hCN6pKGXTVWpCRVtijRBF0bDgfKHGKJv9S6LG0PlVYH2oVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YNCm/H9y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721302359;
	bh=e/ELe0uCIXAZ9JK3bV6Hqi3tnbjAlG1JCWOxpmjk/C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNCm/H9yblSQUGEusF5WMq3I/HX78DsR6vGsEg+eptIcr0NRzu8J6lCUXlrrkd0ar
	 I3ZZcGqgXFCAL9Zgyz0CqLlhB4kwDT97fXfIzK14uex96NlPIyda35l9sSzdshSdDn
	 UkQhjsjNwWH627PXv4SCLamxeKk2Ebq7DfFpuZMWCnr64poveG5p4NPZ5eWiHYuh3X
	 M58SyfBAuZLOeuSbUU4LEcry9FicKDnUEgS/Ao3k7d15d3hCgS3avFT92DetR8SYUr
	 K+InBKjXqneDDjI+nirWdXGeV99JoBNadBz3CjmWQfkUUHE6BaS7H1s02QhwOHk534
	 Oe9jDqahMmUuw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BF6393782167;
	Thu, 18 Jul 2024 11:32:34 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 1/4] selftests: x86: check_initial_reg_state: remove manual counting and increase maintainability
Date: Thu, 18 Jul 2024 16:32:19 +0500
Message-Id: <20240718113222.867116-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718113222.867116-1-usama.anjum@collabora.com>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes manual counting of pass and fail tests. This increases readability
of tests, but also improves maintainability of the tests. Print logs in
standard format (without [RUN], [OK] tags)

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- correct description of the patch

Changes since v2:
- Update description of the patch and add before/after output

Before:
  # selftests: x86: check_initial_reg_state_32
  # [OK]	All GPRs except SP are 0
  # [OK]	FLAGS is 0x202
  ok 5 selftests: x86: check_initial_reg_state_32

After:
  # selftests: x86: check_initial_reg_state_32
  # TAP version 13
  # 1..2
  # ok 1 All GPRs except SP are 0
  # ok 2 FLAGS is 0x202
  # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
  ok 5 selftests: x86: check_initial_reg_state_32
---
 .../selftests/x86/check_initial_reg_state.c   | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/x86/check_initial_reg_state.c b/tools/testing/selftests/x86/check_initial_reg_state.c
index 3bc95f3ed5859..b91c2b06b9881 100644
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
+#define SHOW(x) ksft_print_msg("\t" #x " = 0x%lx\n", x)
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


