Return-Path: <linux-kselftest+bounces-25552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB564A2556D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F223A93B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D30202C3B;
	Mon,  3 Feb 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tu8Hh9hb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1mKAq5B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEA1FFC60;
	Mon,  3 Feb 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573530; cv=none; b=C2BXmQt8cZ41KOYWOZ9KAZTiLzJskh7wRmAorWzSXpexWIFywlWY6g2cdoY821E4zgq8+Hk00y92NSSOPfZ+plPQKDQGK3Q78kIERYpBfr8At0hvxaPvbnwWDk13j+EQkS5LDipkNw1gh4CmbTvI+ELaZu31m3vbLdQtMaD4huE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573530; c=relaxed/simple;
	bh=io6sXt7iIEpqclAN5udDVtDQPsKQqT7YCXVo80AmeIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFUgl10Vr+uf2PG685b5w5pVFshppzguRoYhgcmZrE3vh2fKnBR62c5AI1Ku9YQ51Bw4aLGmynM+WXY+dkCzg6RPqi7/u/WsXWcUFl5ZErZAcrIyHyMHXiKZ+yxJGHuKFFjdkWfTxBb6IogFCKu+rG6yICyEY0Lx4MSATe9p8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tu8Hh9hb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1mKAq5B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWWpuwHkmHsBX34pcGl1jvCG52qLLh0La3Bmm84Eboo=;
	b=tu8Hh9hbsWetkIDgzcpH2nG14ZI8nV2lcq3oKrs+KHbFh8KtE4qTpI38Igq94jhAvFsFQj
	3yY9SX6JdKiD8tVe2lUU9LRtsvnnjdn1JhlJXI2mhmuz8+sLGmg738B9CYWqJu3GcKAmBR
	eAZBHmf/DNUJNQ4HU3P4/HKvBWjUi8TdvgzhWp8BgOqw/UWfqmIFX4Ii8DQWyiZRkNMGxo
	XnDY1pvwSsJZetB95mma2AdKtOTPOicddBbhqUJKIL7EuaTezJuUX5Ac44BaK7XUGYnMqr
	qMdTdJVpXfOXIriZL4wt6wd6AqBXU45ogl118Na0xqoUU0pDPq51ih4XZk2scA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWWpuwHkmHsBX34pcGl1jvCG52qLLh0La3Bmm84Eboo=;
	b=M1mKAq5BEsyd2vw89rzEqIJlchsRF4h8bG5ZOfxZUaEDBVmgPocf4eab2VMqxI3symVNg2
	4ntxneSBMmqJbIAA==
Date: Mon, 03 Feb 2025 10:05:17 +0100
Subject: [PATCH 16/16] selftests: vDSO: vdso_standalone_test_x86: Switch to
 nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-16-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=6263;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=io6sXt7iIEpqclAN5udDVtDQPsKQqT7YCXVo80AmeIk=;
 b=GwjI5bSquW7zdPwOw/ObHOwJd3uaE2TURfhr6wXyXJSxHF8582pBDftmeCnGijOcc4+cOJsgI
 vZbb5XCvvLxC6Hni87Pvz2ilsFxfk0A2G8pgIDBOlJWWLW/J36zx9Uk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vdso_standalone_test_x86 provides its own ASM syscall wrappers and
_start() implementation. The in-tree nolibc library already provides
this functionality for multiple architectures. By making use of nolibc,
the standalone testcase can be built from the exact same codebase as the
non-standalone version.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile              |   8 +-
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 168 +--------------------
 2 files changed, 7 insertions(+), 169 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index bc8ca186fb877dc11740c37f1e07e45e84c2ae92..12a0614b9fd4983deffe5d6a7cfa06ba8d92a516 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -22,13 +22,17 @@ include ../lib.mk
 
 CFLAGS += $(TOOLS_INCLUDES)
 
+CFLAGS_NOLIBC := -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwind-tables \
+		 -fno-stack-protector -include $(top_srcdir)/tools/include/nolibc/nolibc.h \
+		 -I$(top_srcdir)/tools/include/nolibc/ $(KHDR_INCLUDES)
+
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
 $(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
 
-$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
-$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=-nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c | headers
+$(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=$(CFLAGS_NOLIBC) $(CFLAGS)
 
 $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
 $(OUTPUT)/vdso_test_correctness: LDFLAGS += -ldl
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
deleted file mode 100644
index 500608f89c66b5747e3d845ebc54e4c3a35b6ccd..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ /dev/null
@@ -1,167 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * vdso_test.c: Sample code to test parse_vdso.c on x86
- * Copyright (c) 2011-2014 Andy Lutomirski
- *
- * You can amuse yourself by compiling with:
- * gcc -std=gnu99 -nostdlib
- *     -Os -fno-asynchronous-unwind-tables -flto -lgcc_s
- *      vdso_standalone_test_x86.c parse_vdso.c
- * to generate a small binary.  On x86_64, you can omit -lgcc_s
- * if you want the binary to be completely standalone.
- */
-
-#include <sys/syscall.h>
-#include <sys/time.h>
-#include <unistd.h>
-#include <stdint.h>
-#include <linux/auxvec.h>
-
-#include "parse_vdso.h"
-
-/* We need some libc functions... */
-int strcmp(const char *a, const char *b)
-{
-	/* This implementation is buggy: it never returns -1. */
-	while (*a || *b) {
-		if (*a != *b)
-			return 1;
-		if (*a == 0 || *b == 0)
-			return 1;
-		a++;
-		b++;
-	}
-
-	return 0;
-}
-
-/*
- * The clang build needs this, although gcc does not.
- * Stolen from lib/string.c.
- */
-void *memcpy(void *dest, const void *src, size_t count)
-{
-	char *tmp = dest;
-	const char *s = src;
-
-	while (count--)
-		*tmp++ = *s++;
-	return dest;
-}
-
-/* ...and two syscalls.  This is x86-specific. */
-static inline long x86_syscall3(long nr, long a0, long a1, long a2)
-{
-	long ret;
-#ifdef __x86_64__
-	asm volatile ("syscall" : "=a" (ret) : "a" (nr),
-		      "D" (a0), "S" (a1), "d" (a2) :
-		      "cc", "memory", "rcx",
-		      "r8", "r9", "r10", "r11" );
-#else
-	asm volatile ("int $0x80" : "=a" (ret) : "a" (nr),
-		      "b" (a0), "c" (a1), "d" (a2) :
-		      "cc", "memory" );
-#endif
-	return ret;
-}
-
-static inline long linux_write(int fd, const void *data, size_t len)
-{
-	return x86_syscall3(__NR_write, fd, (long)data, (long)len);
-}
-
-static inline void linux_exit(int code)
-{
-	x86_syscall3(__NR_exit, code, 0, 0);
-}
-
-void to_base10(char *lastdig, time_t n)
-{
-	while (n) {
-		*lastdig = (n % 10) + '0';
-		n /= 10;
-		lastdig--;
-	}
-}
-
-unsigned long getauxval(const unsigned long *auxv, unsigned long type)
-{
-	unsigned long ret;
-
-	if (!auxv)
-		return 0;
-
-	while (1) {
-		if (!auxv[0] && !auxv[1]) {
-			ret = 0;
-			break;
-		}
-
-		if (auxv[0] == type) {
-			ret = auxv[1];
-			break;
-		}
-
-		auxv += 2;
-	}
-
-	return ret;
-}
-
-void c_main(void **stack)
-{
-	/* Parse the stack */
-	long argc = (long)*stack;
-	stack += argc + 2;
-
-	/* Now we're pointing at the environment.  Skip it. */
-	while(*stack)
-		stack++;
-	stack++;
-
-	/* Now we're pointing at auxv.  Initialize the vDSO parser. */
-	vdso_init_from_sysinfo_ehdr(getauxval((unsigned long *)stack, AT_SYSINFO_EHDR));
-
-	/* Find gettimeofday. */
-	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod = (gtod_t)vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
-
-	if (!gtod)
-		linux_exit(1);
-
-	struct timeval tv;
-	long ret = gtod(&tv, 0);
-
-	if (ret == 0) {
-		char buf[] = "The time is                     .000000\n";
-		to_base10(buf + 31, tv.tv_sec);
-		to_base10(buf + 38, tv.tv_usec);
-		linux_write(1, buf, sizeof(buf) - 1);
-	} else {
-		linux_exit(ret);
-	}
-
-	linux_exit(0);
-}
-
-/*
- * This is the real entry point.  It passes the initial stack into
- * the C entry point.
- */
-asm (
-	".text\n"
-	".global _start\n"
-	".type _start,@function\n"
-	"_start:\n\t"
-#ifdef __x86_64__
-	"mov %rsp,%rdi\n\t"
-	"and $-16,%rsp\n\t"
-	"sub $8,%rsp\n\t"
-	"jmp c_main"
-#else
-	"push %esp\n\t"
-	"call c_main\n\t"
-	"int $3"
-#endif
-	);
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
new file mode 120000
index 0000000000000000000000000000000000000000..4d3d96f1e440c965474681a6f35375a60b3921be
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -0,0 +1 @@
+vdso_test_gettimeofday.c
\ No newline at end of file

-- 
2.48.1


