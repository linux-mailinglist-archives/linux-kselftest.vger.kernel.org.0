Return-Path: <linux-kselftest+bounces-6064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53187562E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 19:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CF81F23625
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3BF133980;
	Thu,  7 Mar 2024 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hR3WT9rn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66512F5A5;
	Thu,  7 Mar 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836636; cv=none; b=lZcNGYKAPMApZX4b8yDp7f10FuRwcQirydIQ9ommbKTanPvWoke+EJRONeasoBueQBQkvjKCdXz+eMEVpUzBzWM6IJDMycZ9KUxgkYZDbic45ZxnpwVIopBNYyTQhrrCqcBEKoZHMfv3GHW5rvcgDztEAPl0fayjTzlQSamPCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836636; c=relaxed/simple;
	bh=0hw/BO/EMvzsmF1IVaaww3RoUUfz1Eu0MajBXr+3PIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=saCFzeCohehiMZJtNoBsPNUFvMUdodlkZE0SjkGEmOBJuEgRWJVGqS1Z1SZb+OpDGen5Kz/HrDcLWN27TJcx2wCeLHrqT25oiL1esABkFZPCX2IsF/pjS1mdSziB3R2dPY8qLjKsT/S/OpyVuFLSPofG/gcfyw+HOwN/uq9IPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hR3WT9rn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709836633;
	bh=0hw/BO/EMvzsmF1IVaaww3RoUUfz1Eu0MajBXr+3PIk=;
	h=From:To:Cc:Subject:Date:From;
	b=hR3WT9rnguVUkb7FRTJqU5F8NmFxtRh/IDEWIN2BTOzaxtZeniDYVumU9o0X93+IF
	 OsNZge3SRSkxrPYGVRkOqp47nlseWYYrlHOVy0igcpftzmtQUPRKDPEqW3PVwPwxrf
	 VGEIm7qmlL8dGgu+GYq3qGJvTeQds7UsTlVmzYrIltNmfWjNeSMSYhT6el3mTkcIaH
	 0ai14W/ZSazloDh5owQ5QS7VS+nTyyfyBrxttai3La0h9Y9BAn+kqcmhhouwpVFKt2
	 ayHgqVh3nJETl+j3s4vTKspYaTQ9MBh3R2D1I0hF9ycbnvENnLfXrdcdC3RzHanyge
	 RjVjPayqzBv6Q==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BDB8A378134F;
	Thu,  7 Mar 2024 18:37:09 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Weihong Zhang <weihong.zhang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	angquan yu <angquan21@gmail.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: x86: skip the tests if prerequisites aren't fulfilled
Date: Thu,  7 Mar 2024 23:37:22 +0500
Message-Id: <20240307183730.2858264-1-usama.anjum@collabora.com>
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
  make -C tools/testing/selftest/ TARGETS=x86 run_tests

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

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
I'm not sure if xstate values should be correct on all the x86
processors. If the xstate is invalid on a CPU, the test should be
skipped instead of failing.
---
 tools/testing/selftests/x86/amx.c | 33 ++++++++++++++++++++-----------
 tools/testing/selftests/x86/lam.c |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index d884fd69dd510..5d1ca0bbaaae7 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -103,9 +103,10 @@ static void clearhandler(int sig)
 
 #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
 #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
-static inline void check_cpuid_xsave(void)
+static inline int check_cpuid_xsave(void)
 {
 	uint32_t eax, ebx, ecx, edx;
+	int ret = 0;
 
 	/*
 	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
@@ -113,10 +114,16 @@ static inline void check_cpuid_xsave(void)
 	 * XGETBV.
 	 */
 	__cpuid_count(1, 0, eax, ebx, ecx, edx);
-	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
-		fatal_error("cpuid: no CPU xsave support");
-	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
-		fatal_error("cpuid: no OS xsave support");
+	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK)) {
+		ksft_print_msg("cpuid: no CPU xsave support\n");
+		ret = -1;
+	}
+	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK)) {
+		ksft_print_msg("cpuid: no OS xsave support\n");
+		ret = -1;
+	}
+
+	return ret;
 }
 
 static uint32_t xbuf_size;
@@ -131,7 +138,7 @@ static struct {
 #define TILE_CPUID			0x1d
 #define TILE_PALETTE_ID			0x1
 
-static void check_cpuid_xtiledata(void)
+static int check_cpuid_xtiledata(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 
@@ -153,12 +160,16 @@ static void check_cpuid_xtiledata(void)
 	 * eax: XTILEDATA state component size
 	 * ebx: XTILEDATA state component offset in user buffer
 	 */
-	if (!eax || !ebx)
-		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
-				eax, ebx);
+	if (!eax || !ebx) {
+		ksft_print_msg("xstate cpuid: invalid tile data size/offset: %d/%d\n",
+			       eax, ebx);
+		return -1;
+	}
 
 	xtiledata.size	      = eax;
 	xtiledata.xbuf_offset = ebx;
+
+	return 0;
 }
 
 /* The helpers for managing XSAVE buffer and tile states: */
@@ -929,8 +940,8 @@ static void test_ptrace(void)
 int main(void)
 {
 	/* Check hardware availability at first */
-	check_cpuid_xsave();
-	check_cpuid_xtiledata();
+	if (check_cpuid_xsave() || check_cpuid_xtiledata())
+		return KSFT_SKIP;
 
 	init_stashed_xsave();
 	sethandler(SIGILL, handle_noperm, 0);
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


