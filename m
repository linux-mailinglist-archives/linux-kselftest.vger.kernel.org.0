Return-Path: <linux-kselftest+bounces-13808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618893307F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88671F2325F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3941ABCCE;
	Tue, 16 Jul 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMxRaJJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7E1A0AF2;
	Tue, 16 Jul 2024 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154920; cv=none; b=jviCURXfLLVHhuhPNKtU//MuFOIkq1dAAvKuJrXl7fu1P8b5FEkf8fh3pe4MhVWs4iAQCm1Di8Naa8duA2X4Od1BcPLasOS8cNAR6oKrmqbcugr5fIgRU+0r9ZO53pLmeKSW1kZitx/iOjL0SugQah97VSJXwJInGBbwv/BMZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154920; c=relaxed/simple;
	bh=4cr3frS2fJLcGXPWeACtPtdj2rQhQgAAGq2J8rr+Mbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqHxUfA41PM0MQ2hb/OZiBEA/n7AMSGW7kMECtIZHdEHx98FwQ/rT0AbSvHez7ouJujZl8EqifZ2aRec2KIgijgsKwnOH5SM9r/hOt6BwEqG4S5uo0WO3b7nwUQOX/CoamRWfv8LD5OguLol76Cg+HL+05ugMQBZUKF2GiY2yq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMxRaJJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F22BC116B1;
	Tue, 16 Jul 2024 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154919;
	bh=4cr3frS2fJLcGXPWeACtPtdj2rQhQgAAGq2J8rr+Mbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMxRaJJe3HoBWe2fQV48iZpDORuO1eZT2LAbPUGYs+9Mv0pBT+JuGwq+znaGOm/sZ
	 4Lr0vRQ7wlb/7JYWY8qSwS9d/1sIC9wPoPGXRIEt3R80VInk3DPB9UPbqQ3ntcaNGP
	 rsd/vrizvUd+u8lOpZh5HUiwDiguuGoXgL5EOeBFnCIAFft8TfyK0qKJDbt/FUSs+G
	 T6AZQ071qMSOn61ypl9MyxEIVx+0HwIFpvUEKp52750wYS8fz4tE3qGUOAyg8Yx69U
	 kAFpbxnFVI/MyPhVpMKjVgcdBapVPg3kwzTakSsl23AuGhsP1PZTOr6aM49C/4Ae3j
	 k0PgXyU1idY2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Hubbard <jhubbard@nvidia.com>,
	Carlos Llamas <cmllamas@google.com>,
	Edward Liaw <edliaw@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	nathan@kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 2/3] selftests/vDSO: fix clang build errors and warnings
Date: Tue, 16 Jul 2024 14:35:08 -0400
Message-ID: <20240716183513.2814965-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183513.2814965-1-sashal@kernel.org>
References: <20240716183513.2814965-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.317
Content-Transfer-Encoding: 8bit

From: John Hubbard <jhubbard@nvidia.com>

[ Upstream commit 73810cd45b99c6c418e1c6a487b52c1e74edb20d ]

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...there are several warnings, and an error. This fixes all of those and
allows these tests to run and pass.

1. Fix linker error (undefined reference to memcpy) by providing a local
   version of memcpy.

2. clang complains about using this form:

    if (g = h & 0xf0000000)

...so factor out the assignment into a separate step.

3. The code is passing a signed const char* to elf_hash(), which expects
   a const unsigned char *. There are several callers, so fix this at
   the source by allowing the function to accept a signed argument, and
   then converting to unsigned operations, once inside the function.

4. clang doesn't have __attribute__((externally_visible)) and generates
   a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
   to require that attribute in order to build, run and pass tests here,
   so remove it.

Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
 .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 1dbb4b87268fa..9ef3ad3789c17 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -77,14 +77,20 @@ static struct vdso_info
 	ELF(Verdef) *verdef;
 } vdso_info;
 
-/* Straight from the ELF specification. */
-static unsigned long elf_hash(const unsigned char *name)
+/*
+ * Straight from the ELF specification...and then tweaked slightly, in order to
+ * avoid a few clang warnings.
+ */
+static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *uch_name = (const unsigned char *)name;
+
+	while (*uch_name)
 	{
-		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		h = (h << 4) + *uch_name++;
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 93b0ebf8cc38d..805e8c1892764 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -20,7 +20,7 @@ extern void *vdso_sym(const char *version, const char *name);
 extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
 extern void vdso_init_from_auxv(void *auxv);
 
-/* We need a libc functions... */
+/* We need some libc functions... */
 int strcmp(const char *a, const char *b)
 {
 	/* This implementation is buggy: it never returns -1. */
@@ -36,6 +36,20 @@ int strcmp(const char *a, const char *b)
 	return 0;
 }
 
+/*
+ * The clang build needs this, although gcc does not.
+ * Stolen from lib/string.c.
+ */
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest;
+	const char *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+
 /* ...and two syscalls.  This is x86-specific. */
 static inline long x86_syscall3(long nr, long a0, long a1, long a2)
 {
@@ -72,7 +86,7 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
 
-__attribute__((externally_visible)) void c_main(void **stack)
+void c_main(void **stack)
 {
 	/* Parse the stack */
 	long argc = (long)*stack;
-- 
2.43.0


