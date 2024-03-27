Return-Path: <linux-kselftest+bounces-6703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA78E88DC4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180771C28277
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664A56B65;
	Wed, 27 Mar 2024 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rCEHJyf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF05677A;
	Wed, 27 Mar 2024 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538261; cv=none; b=uGaod3rVVAQEtiMV3lPzeh/c9Dt93IraR13hPbSQxEJ9FtnZPQt+PQVVMPtUsY0xINjurekIS29jT8jzh/mR1Nhcnd0Vuk9HsMR7yCwjvB69Ex5PWTy7907kUg5nZl2LdL+iXWzbZan5WIRZT1z7e+4Eypdf+/STyVJ07ngVyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538261; c=relaxed/simple;
	bh=FI+N6IhlJ4EOVxkXt4Oham7RNF9BhN+wSykaCLczAJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHSd/kymY1dAnw+tr8HBCjXo2sQ/BU3+FglPBcKFOe49aVgLX9+St6rtTCo4jgW5wizhUkNh1BFH204cRs7I40tSUbsTHvEN2sfRp/Lp6e66K+9xfBIdd8b/Rt/dKl1YFBwjCYbEs1O2dtgl/owCIabSB3+/RCoMRljbZ4/Uqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rCEHJyf4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711538258;
	bh=FI+N6IhlJ4EOVxkXt4Oham7RNF9BhN+wSykaCLczAJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=rCEHJyf4gEwo6xPDRGZw0GACoDqAZy63uksUbRQCfiZ2kAaP0GoMgOGWeTKAqNkBZ
	 SxFNSFc63uqvmvXI+7wjdfwKj0OxN3tBRpsgqWhlnQmkTFv9R2vkSHwkQVcHj4VtwB
	 O+HzoCa0PhYdigzzwEOroTacNgk6aE10R9FNdxDRmwwMx91L+hODVagrMbIRcNH0j0
	 k1A5/NVvtmGnjKYYrRaVQRuMyCC/B1ia/IOJf6EPaOhk3XCkusNorSp7Hlpi1QqXSu
	 DSvVQE3RMiha0la2VEP2rXf7EyzSne05cdbpyuA5ZGWgps9QHOxjaSrJM0+pMltv0F
	 ubb3k9fZzu12A==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5DD473780480;
	Wed, 27 Mar 2024 11:17:32 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	angquan yu <angquan21@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests: x86: skip the tests if prerequisites aren't fulfilled
Date: Wed, 27 Mar 2024 16:17:17 +0500
Message-Id: <20240327111720.3509180-1-usama.anjum@collabora.com>
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

In amx test, Move away from check_cpuid_xsave() and start using
arch_prctl() to find out if amx support is present or not. In the
kernels where amx isn't present, arch_prctl returns -EINVAL. Hence it is
backward compatible.

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v2:
- Update the changelog

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


