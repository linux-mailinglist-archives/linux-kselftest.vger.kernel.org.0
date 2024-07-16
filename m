Return-Path: <linux-kselftest+bounces-13804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E293304C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FD728170A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44961A9081;
	Tue, 16 Jul 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4zOxb3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812F1A2C14;
	Tue, 16 Jul 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154859; cv=none; b=nf897SXjDOsdCINikKDh3VzSTSCciHsNM+xMqcR+urDAP8KQYyA3JTga8evpt3dLpgqbaifaVfIvZnY5C0AXtm1eLn3PLfVCd+bde8E3BeYSQuEbzyo/U59u3mDqVB+OAiZRxCt2QVHyHInpo/iZOW8ULes8NTysVHAlT9Ez5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154859; c=relaxed/simple;
	bh=2K0g1t7SFFmyFpHBYCQZgT7kd2mByMFkUCTErHVQcs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXfsbNGMyrxddW+JqvqP7gMjmzNEKgOWTr88KAdv3ljUJwRiKuE6wPuDVYMV7kDpbHltAff1/RlcdjM+qVQ++yA7IPAi5Pl1VX19QrA0WJjLohAPU781WgZIZ/MOugP9CvoxgXDcerh8goIf2lNH1qdMEN4s2Gf/7k6DlpJa0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4zOxb3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93948C4AF0B;
	Tue, 16 Jul 2024 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154859;
	bh=2K0g1t7SFFmyFpHBYCQZgT7kd2mByMFkUCTErHVQcs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4zOxb3Qnz/Z32Dyweyl2vkwBKSXhq7ntBfQQ90aDMRfx11w6xnW26OGYwzvpGZmc
	 b7GQQEg7lIqTKmddPPEfpoTNnBOeDVXpj7Ww/e9PTWADX9pFb8loGsGGozkT65GVNi
	 B7lFYCLGyN7L6BZz9tqMuZbRj7Jec01RD1HWUUXfJFdnyiVB73FyPXygd02RlHBcTD
	 GszcFKWQfZ+UZUJYAIFvFtWJf6285Cv+IeAZvI1fUowJPULgtz6+hLQ+o2ER1TxOnc
	 f14mb7uuJRSgvCZFrWfDAw0wQWh9LNAIAC+dZDN7PjMvtGriGebiUYA0SUh7bYCZ5w
	 jGYvrY8ZO4G2A==
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
Subject: [PATCH AUTOSEL 6.1 3/5] selftests/vDSO: fix clang build errors and warnings
Date: Tue, 16 Jul 2024 14:34:00 -0400
Message-ID: <20240716183409.2814531-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183409.2814531-1-sashal@kernel.org>
References: <20240716183409.2814531-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index 413f75620a35b..4ae417372e9eb 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -55,14 +55,20 @@ static struct vdso_info
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
index 8a44ff973ee17..27f6fdf119691 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -18,7 +18,7 @@
 
 #include "parse_vdso.h"
 
-/* We need a libc functions... */
+/* We need some libc functions... */
 int strcmp(const char *a, const char *b)
 {
 	/* This implementation is buggy: it never returns -1. */
@@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
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
@@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
 
-__attribute__((externally_visible)) void c_main(void **stack)
+void c_main(void **stack)
 {
 	/* Parse the stack */
 	long argc = (long)*stack;
-- 
2.43.0


