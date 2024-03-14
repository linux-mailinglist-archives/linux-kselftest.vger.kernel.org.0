Return-Path: <linux-kselftest+bounces-6324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CB87BC1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 12:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B11F24171
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772456EB72;
	Thu, 14 Mar 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BNWYGX01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C356EB5A;
	Thu, 14 Mar 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710416680; cv=none; b=avzYttuzeD46JXwejhSToRpdY6VFZI6SdRvq6nFLgQpbMowgu8iEQ+9PPBBmmfOpxpHz7WuvSXKDOz96s93aN+8zQiHivJjlkfK2UXtYCPGEi4tt41YhKXfDF8AoNaY/IylhJG7AHA6rlyfg/fI1FxtUIPwxLBKPp5Y+Bk6Qjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710416680; c=relaxed/simple;
	bh=TMWaCaNdKcZfFp8MnbDL1SKq1jvkk6APqOXhg7PSgSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JHvOvSybS94cvL2puuww5dhuLWBL3Vs7LTw8rsF+dxeu4xMbECXW/VYBLX73e4pbSRmi8fsJl5q8K0DioS005rGIPyTjwobZx8tpF/ZYFkriTsmN9IqfZqyEnDQMUsA7GeEdF25acr7b09QnqaCK2E2yykDOEzgdIVIC857FkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BNWYGX01; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710416676;
	bh=TMWaCaNdKcZfFp8MnbDL1SKq1jvkk6APqOXhg7PSgSw=;
	h=From:To:Cc:Subject:Date:From;
	b=BNWYGX01jFRH8bWoL0vO651nUjmKFz2hSvXBLujiSKEy2m39n7xfzyP/4wk2n12jg
	 Aj3mMzvBc/8DJXuCfK/F6Wh+5sB1nGi9fxCt53wBRvT4q+NayIOgZR1nr/VzDWGci8
	 Vz/P7axr51RL6W1UNUT2JjyWqosTUvMK6vg82VjgNb1ceo6Omyngg7SsKPAmiz2Val
	 pm71yRUQjuEI8Y4gfaNhaVGT1HvCni8Gp1LufkuY0obNTgOJ6Kc6+yAfiElf5Iz3OC
	 7uMC2xp7ybgRQDhKZGvvAoIPS9cf02E5nBn2PN0v4fxQv1TB64qFG2wtezajZ0AoW4
	 ggIrCn2TUlMCw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB0883781F8E;
	Thu, 14 Mar 2024 11:44:33 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Weihong Zhang <weihong.zhang@intel.com>,
	angquan yu <angquan21@gmail.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: x86: skip the tests if prerequisites aren't fulfilled
Date: Thu, 14 Mar 2024 16:44:53 +0500
Message-Id: <20240314114502.466806-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip instead of failing when prerequisite conditions aren't fulfilled,
such as invalid xstate values etc. This patch would make the tests show
as skip when run by:
  make -C tools/testing/selftests/ TARGETS=x86 run_tests

  ...
  # timeout set to 45
  # selftests: x86: amx_64
  # # xstate cpuid: invalid tile data size/offset: 0/0
  ok 42 selftests: x86: amx_64 # SKIP
  # timeout set to 45
  # selftests: x86: lam_64
  # # Unsupported LAM feature!
  ok 43 selftests: x86: lam_64 # SKIP
  ...

Cc: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Use arch_prctl to check if amx is supported
---
 tools/testing/selftests/x86/amx.c | 27 ++++++++++-----------------
 tools/testing/selftests/x86/lam.c |  2 +-
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index d884fd69dd510..95aad6d8849be 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -103,21 +103,6 @@ static void clearhandler(int sig)
 
 #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
 #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
-static inline void check_cpuid_xsave(void)
-{
-	uint32_t eax, ebx, ecx, edx;
-
-	/*
-	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
-	 * support for the XSAVE feature set, including
-	 * XGETBV.
-	 */
-	__cpuid_count(1, 0, eax, ebx, ecx, edx);
-	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
-		fatal_error("cpuid: no CPU xsave support");
-	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
-		fatal_error("cpuid: no OS xsave support");
-}
 
 static uint32_t xbuf_size;
 
@@ -350,6 +335,7 @@ enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
 
 /* arch_prctl() and sigaltstack() test */
 
+#define ARCH_GET_XCOMP_SUPP	0x1021
 #define ARCH_GET_XCOMP_PERM	0x1022
 #define ARCH_REQ_XCOMP_PERM	0x1023
 
@@ -928,8 +914,15 @@ static void test_ptrace(void)
 
 int main(void)
 {
-	/* Check hardware availability at first */
-	check_cpuid_xsave();
+	unsigned long features;
+	long rc;
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+	if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+		ksft_print_msg("no AMX support\n");
+		return KSFT_SKIP;
+	}
+
 	check_cpuid_xtiledata();
 
 	init_stashed_xsave();
diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 215b8150b7cca..c0f016f45ee17 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1183,7 +1183,7 @@ int main(int argc, char **argv)
 
 	if (!cpu_has_lam()) {
 		ksft_print_msg("Unsupported LAM feature!\n");
-		return -1;
+		return KSFT_SKIP;
 	}
 
 	while ((c = getopt(argc, argv, "ht:")) != -1) {
-- 
2.39.2


