Return-Path: <linux-kselftest+bounces-28179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E56FA4D49A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EF189A26A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291E20012C;
	Tue,  4 Mar 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m05+rRBn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nk7Ma3VI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D081FECDC;
	Tue,  4 Mar 2025 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072292; cv=none; b=fIwF/JMf4DAKu9dtAi9f/E5LUquQKwjhXysYGwSuF9aHxaun4kMHGaBDB0yMHykhzUXSLfyhLT0Pae8RiQ/3DIcwP6WT64OhmwdfcM0TqIziyTiKnTFnsb9KZc+lhIdwYSMmkL0/mTIq93hj4t55V4NwcHEdVkveRi06maMTEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072292; c=relaxed/simple;
	bh=ds4x0bRTJvm27hXV7OZVurepjLM17Pfn1+1EbPNYHkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTepFV7pEqfL7gP1szovdS+Rl5aDZFkb0lFHha+pOLOpwjtpDZWnvUQ/aFBCP24GMnig3bi1xWuARcUgnl5pTcFXHjZNnx/AAgc9iZM1PdFdWogGEI2hq0Bot3T4govVe1fmbXacAEhS9flesDtpzozhYu1OtF/dJf/JXOMrxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m05+rRBn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nk7Ma3VI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37RsePHmpOan7iuyTAP4ljNPUti20SRSWmzdMYK71Ds=;
	b=m05+rRBnIUJlmQsnKEuaycSpEUdMbsdGUoAHDJRvTD9s8Hii3GFgLtNzKTDhI1AN5Y/KPp
	m4sT6nTBeVm3yAI7LD1CRjLtejOKBHQxJ4dkeaiU14klC3JkNQNn0qlogzXcHilYqb1Q7v
	KNC0eFcRSylEbSeH96MVmLxfRNcmRzyqHcVi7qdZBwk6+s7ZPVikhNhZbjMLunt42+HxvN
	Winas6Znt38JAkwqPqNkUNpPJoG4dOUIVtFd5U0uz7WlxaKh9AxKOOWKzEVuNDGdnuraSA
	URrK0UOHczEJxH6RsxR/HP4mBxMGdXveLv4GxVADZkMINpkfam/wYUviPj4+DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37RsePHmpOan7iuyTAP4ljNPUti20SRSWmzdMYK71Ds=;
	b=Nk7Ma3VIlihngRSHdKw0yYz7bLrFRyizqZPiXeEkFsre9p5MpG50s3VlS/7dBL1VeUNNxx
	AIgfPQCHFu/3Y0DQ==
Date: Tue, 04 Mar 2025 08:11:02 +0100
Subject: [PATCH 32/32] HACK: selftests/nolibc: demonstrate usage of the
 kselftest harness
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-32-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=62737;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ds4x0bRTJvm27hXV7OZVurepjLM17Pfn1+1EbPNYHkQ=;
 b=dF2OyNd+uakpWTkbLPBaOg8rx8B5FZ8Njxps7cgsZu3dR7mVE7vByrj4UYnOTVubjulCLhwhs
 IOendnV5BX9C+yCwwVUMTQQJAir+8UdLSzjc+vcG/N7+ODp5dngjrio
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Show how to use the kselftest harness together with nolibc.
This just runs the existing harness selftest by crudely replacing the
regular nolibc-test.c with the harness-selftest.c to get that wired up easily.

In the future nolibc-test can use the harness for itself.

Not-Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 .../testing/selftests/kselftest/harness-selftest.c |    2 +-
 tools/testing/selftests/nolibc/Makefile            |   17 +-
 tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
 tools/testing/selftests/nolibc/nolibc-test.c       | 1698 +-------------------
 tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
 5 files changed, 10 insertions(+), 1710 deletions(-)

diff --git a/tools/testing/selftests/kselftest/harness-selftest.c b/tools/testing/selftests/kselftest/harness-selftest.c
index 8d39e7a0b99c41a5d33edfe2dbf875cac04c098d..bbb2fda7042ca8bac608625e6f4302466b23f7b3 100644
--- a/tools/testing/selftests/kselftest/harness-selftest.c
+++ b/tools/testing/selftests/kselftest/harness-selftest.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #include <stdio.h>
 
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 58bcbbd029bc3ad9ccac968191b703ccf5df0717..d97ffc138da0f63673dcc20b6636b842e3226587 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -47,7 +47,6 @@ XARCH_riscv      = riscv64
 XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
-ARCH_armthumb    = arm
 ARCH_ppc         = powerpc
 ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
@@ -64,7 +63,6 @@ IMAGE_x86_64     = arch/x86/boot/bzImage
 IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
-IMAGE_armthumb   = arch/arm/boot/zImage
 IMAGE_mips32le   = vmlinuz
 IMAGE_mips32be   = vmlinuz
 IMAGE_ppc        = vmlinux
@@ -85,7 +83,6 @@ DEFCONFIG_x86_64     = defconfig
 DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
-DEFCONFIG_armthumb   = multi_v7_defconfig
 DEFCONFIG_mips32le   = malta_defconfig
 DEFCONFIG_mips32be   = malta_defconfig generic/eb.config
 DEFCONFIG_ppc        = pmac32_defconfig
@@ -110,7 +107,6 @@ QEMU_ARCH_x86_64     = x86_64
 QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
-QEMU_ARCH_armthumb   = arm
 QEMU_ARCH_mips32le   = mipsel  # works with malta_defconfig
 QEMU_ARCH_mips32be  = mips
 QEMU_ARCH_ppc        = ppc
@@ -140,7 +136,6 @@ QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_armthumb   = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32le   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32be   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -165,8 +160,7 @@ Q=@
 endif
 
 CFLAGS_i386 = $(call cc-option,-m32)
-CFLAGS_arm = -marm
-CFLAGS_armthumb = -mthumb -march=armv6t2
+CFLAGS_arm = -march=armv7
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
@@ -175,8 +169,10 @@ CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra -ggdb -ffreestanding \
+	        -ffile-prefix-map=./= \
 		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
+		$(call cc-option,-mno-outline-atomics) \
 		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
@@ -193,10 +189,7 @@ include $(srctree)/tools/scripts/Makefile.include
 # GCC uses "s390", clang "systemz"
 CLANG_CROSS_FLAGS := $(subst --target=s390-linux,--target=systemz-linux,$(CLANG_CROSS_FLAGS))
 
-REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
-		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
-		if (f || !p) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
-		printf("\nSee all results in %s\n", ARGV[1]); }'
+REPORT  = sed -i -e '/^\[/d' -e 's/\x0d//' run.out; cmp ../kselftest/harness-selftest.expected run.out && echo ok; true
 
 help:
 	@echo "Supported targets under selftests/nolibc:"
diff --git a/tools/testing/selftests/nolibc/harness-selftest.c b/tools/testing/selftests/nolibc/harness-selftest.c
new file mode 120000
index 0000000000000000000000000000000000000000..847b121e60482513cd0911422cfdb19bdf681bd6
--- /dev/null
+++ b/tools/testing/selftests/nolibc/harness-selftest.c
@@ -0,0 +1 @@
+../kselftest/harness-selftest.c
\ No newline at end of file
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b801b611e003a6f3ebd5bdbcd4f70961c1279a4d..9a074d2b24c99d86bf27f8399f2e7dc719dbcd24 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,1699 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define _GNU_SOURCE
-#define _LARGEFILE64_SOURCE
+#define inline __inline__
 
-/* libc-specific include files
- * The program may be built in 3 ways:
- *   $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
- *   $(CC) -nostdlib -I/path/to/nolibc/sysroot  => _NOLIBC_* guards are present
- *   $(CC) with default libc                    => NOLIBC* never defined
- */
-#ifndef NOLIBC
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#ifndef _NOLIBC_STDIO_H
-/* standard libcs need more includes */
-#include <sys/auxv.h>
-#include <sys/io.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <sys/prctl.h>
-#include <sys/reboot.h>
-#include <sys/resource.h>
-#include <sys/stat.h>
-#include <sys/syscall.h>
-#include <sys/sysmacros.h>
-#include <sys/time.h>
-#include <sys/utsname.h>
-#include <sys/wait.h>
-#include <dirent.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <poll.h>
-#include <sched.h>
-#include <signal.h>
-#include <stdarg.h>
-#include <stddef.h>
-#include <stdint.h>
-#include <unistd.h>
-#include <limits.h>
-#include <ctype.h>
-#endif
-#endif
-
-#pragma GCC diagnostic ignored "-Wmissing-prototypes"
-
-#include "nolibc-test-linkage.h"
-
-/* for the type of int_fast16_t and int_fast32_t, musl differs from glibc and nolibc */
-#define SINT_MAX_OF_TYPE(type) (((type)1 << (sizeof(type) * 8 - 2)) - (type)1 + ((type)1 << (sizeof(type) * 8 - 2)))
-#define SINT_MIN_OF_TYPE(type) (-SINT_MAX_OF_TYPE(type) - 1)
-
-/* will be used to test initialization of environ */
-static char **test_envp;
-
-/* will be used to test initialization of argv */
-static char **test_argv;
-
-/* will be used to test initialization of argc */
-static int test_argc;
-
-/* will be used by some test cases as readable file, please don't write it */
-static const char *argv0;
-
-/* will be used by constructor tests */
-static int constructor_test_value;
-
-static const int is_nolibc =
-#ifdef NOLIBC
-	1
-#else
-	0
-#endif
-;
-
-/* definition of a series of tests */
-struct test {
-	const char *name;              /* test name */
-	int (*func)(int min, int max); /* handler */
-};
-
-#ifndef _NOLIBC_STDLIB_H
-char *itoa(int i)
-{
-	static char buf[12];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf), "%d", i);
-	return (ret >= 0 && ret < sizeof(buf)) ? buf : "#err";
-}
-#endif
-
-#define CASE_ERR(err) \
-	case err: return #err
-
-/* returns the error name (e.g. "ENOENT") for common errors, "SUCCESS" for 0,
- * or the decimal value for less common ones.
- */
-static const char *errorname(int err)
-{
-	switch (err) {
-	case 0: return "SUCCESS";
-	CASE_ERR(EPERM);
-	CASE_ERR(ENOENT);
-	CASE_ERR(ESRCH);
-	CASE_ERR(EINTR);
-	CASE_ERR(EIO);
-	CASE_ERR(ENXIO);
-	CASE_ERR(E2BIG);
-	CASE_ERR(ENOEXEC);
-	CASE_ERR(EBADF);
-	CASE_ERR(ECHILD);
-	CASE_ERR(EAGAIN);
-	CASE_ERR(ENOMEM);
-	CASE_ERR(EACCES);
-	CASE_ERR(EFAULT);
-	CASE_ERR(ENOTBLK);
-	CASE_ERR(EBUSY);
-	CASE_ERR(EEXIST);
-	CASE_ERR(EXDEV);
-	CASE_ERR(ENODEV);
-	CASE_ERR(ENOTDIR);
-	CASE_ERR(EISDIR);
-	CASE_ERR(EINVAL);
-	CASE_ERR(ENFILE);
-	CASE_ERR(EMFILE);
-	CASE_ERR(ENOTTY);
-	CASE_ERR(ETXTBSY);
-	CASE_ERR(EFBIG);
-	CASE_ERR(ENOSPC);
-	CASE_ERR(ESPIPE);
-	CASE_ERR(EROFS);
-	CASE_ERR(EMLINK);
-	CASE_ERR(EPIPE);
-	CASE_ERR(EDOM);
-	CASE_ERR(ERANGE);
-	CASE_ERR(ENOSYS);
-	CASE_ERR(EOVERFLOW);
-	default:
-		return itoa(err);
-	}
-}
-
-static void align_result(size_t llen)
-{
-	const size_t align = 64;
-	char buf[align];
-	size_t n;
-
-	if (llen >= align)
-		return;
-
-	n = align - llen;
-	memset(buf, ' ', n);
-	buf[n] = '\0';
-	fputs(buf, stdout);
-}
-
-enum RESULT {
-	OK,
-	FAIL,
-	SKIPPED,
-};
-
-static void result(int llen, enum RESULT r)
-{
-	const char *msg;
-
-	if (r == OK)
-		msg = "  [OK]";
-	else if (r == SKIPPED)
-		msg = "[SKIPPED]";
-	else
-		msg = " [FAIL]";
-
-	align_result(llen);
-	puts(msg);
-}
-
-/* The tests below are intended to be used by the macroes, which evaluate
- * expression <expr>, print the status to stdout, and update the "ret"
- * variable to count failures. The functions themselves return the number
- * of failures, thus either 0 or 1.
- */
-
-#define EXPECT_ZR(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
-
-static __attribute__((unused))
-int expect_zr(int expr, int llen)
-{
-	int ret = !(expr == 0);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_NZ(cond, expr, val)			\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
-
-static __attribute__((unused))
-int expect_nz(int expr, int llen)
-{
-	int ret = !(expr != 0);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_EQ(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_eq(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_eq(uint64_t expr, int llen, uint64_t val)
-{
-	int ret = !(expr == val);
-
-	llen += printf(" = %lld ", (long long)expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_NE(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ne(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_ne(int expr, int llen, int val)
-{
-	int ret = !(expr != val);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_GE(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ge(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_ge(int expr, int llen, int val)
-{
-	int ret = !(expr >= val);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_GT(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_gt(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_gt(int expr, int llen, int val)
-{
-	int ret = !(expr > val);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_LE(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_le(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_le(int expr, int llen, int val)
-{
-	int ret = !(expr <= val);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_LT(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_lt(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_lt(int expr, int llen, int val)
-{
-	int ret = !(expr < val);
-
-	llen += printf(" = %d ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_SYSZR(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syszr(expr, llen); } while (0)
-
-static __attribute__((unused))
-int expect_syszr(int expr, int llen)
-{
-	int ret = 0;
-
-	if (errno == ENOSYS) {
-		llen += printf(" = ENOSYS");
-		result(llen, SKIPPED);
-	} else if (expr) {
-		ret = 1;
-		llen += printf(" = %d %s ", expr, errorname(errno));
-		result(llen, FAIL);
-	} else {
-		llen += printf(" = %d ", expr);
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_SYSEQ(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syseq(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_syseq(int expr, int llen, int val)
-{
-	int ret = 0;
-
-	if (expr != val) {
-		ret = 1;
-		llen += printf(" = %d %s ", expr, errorname(errno));
-		result(llen, FAIL);
-	} else {
-		llen += printf(" = %d ", expr);
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_SYSNE(cond, expr, val)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_sysne(expr, llen, val); } while (0)
-
-static __attribute__((unused))
-int expect_sysne(int expr, int llen, int val)
-{
-	int ret = 0;
-
-	if (errno == ENOSYS) {
-		llen += printf(" = ENOSYS");
-		result(llen, SKIPPED);
-	} else if (expr == val) {
-		ret = 1;
-		llen += printf(" = %d %s ", expr, errorname(errno));
-		result(llen, FAIL);
-	} else {
-		llen += printf(" = %d ", expr);
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_SYSER2(cond, expr, expret, experr1, experr2)		\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
-
-#define EXPECT_SYSER(cond, expr, expret, experr)			\
-	EXPECT_SYSER2(cond, expr, expret, experr, 0)
-
-static __attribute__((unused))
-int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
-{
-	int ret = 0;
-	int _errno = errno;
-
-	llen += printf(" = %d %s ", expr, errorname(_errno));
-	if (errno == ENOSYS) {
-		result(llen, SKIPPED);
-	} else if (expr != expret || (_errno != experr1 && _errno != experr2)) {
-		ret = 1;
-		if (experr2 == 0)
-			llen += printf(" != (%d %s) ", expret, errorname(experr1));
-		else
-			llen += printf(" != (%d %s %s) ", expret, errorname(experr1), errorname(experr2));
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_PTRZR(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrzr(expr, llen); } while (0)
-
-static __attribute__((unused))
-int expect_ptrzr(const void *expr, int llen)
-{
-	int ret = 0;
-
-	llen += printf(" = <%p> ", expr);
-	if (expr) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_PTRNZ(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrnz(expr, llen); } while (0)
-
-static __attribute__((unused))
-int expect_ptrnz(const void *expr, int llen)
-{
-	int ret = 0;
-
-	llen += printf(" = <%p> ", expr);
-	if (!expr) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-#define EXPECT_PTREQ(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptreq(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_ptreq(const void *expr, int llen, const void *cmp)
-{
-	int ret = 0;
-
-	llen += printf(" = <%p> ", expr);
-	if (expr != cmp) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-#define EXPECT_PTRNE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrne(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_ptrne(const void *expr, int llen, const void *cmp)
-{
-	int ret = 0;
-
-	llen += printf(" = <%p> ", expr);
-	if (expr == cmp) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-#define EXPECT_PTRGE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrge(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_ptrge(const void *expr, int llen, const void *cmp)
-{
-	int ret = !(expr >= cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-#define EXPECT_PTRGT(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrgt(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_ptrgt(const void *expr, int llen, const void *cmp)
-{
-	int ret = !(expr > cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_PTRLE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrle(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_ptrle(const void *expr, int llen, const void *cmp)
-{
-	int ret = !(expr <= cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-
-#define EXPECT_PTRLT(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrlt(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_ptrlt(const void *expr, int llen, const void *cmp)
-{
-	int ret = !(expr < cmp);
-
-	llen += printf(" = <%p> ", expr);
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-#define EXPECT_PTRER2(cond, expr, expret, experr1, experr2)		\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrerr2(expr, expret, experr1, experr2, llen); } while (0)
-
-#define EXPECT_PTRER(cond, expr, expret, experr)			\
-	EXPECT_PTRER2(cond, expr, expret, experr, 0)
-
-static __attribute__((unused))
-int expect_ptrerr2(const void *expr, const void *expret, int experr1, int experr2, int llen)
-{
-	int ret = 0;
-	int _errno = errno;
-
-	llen += printf(" = <%p> %s ", expr, errorname(_errno));
-	if (expr != expret || (_errno != experr1 && _errno != experr2)) {
-		ret = 1;
-		if (experr2 == 0)
-			llen += printf(" != (<%p> %s) ", expret, errorname(experr1));
-		else
-			llen += printf(" != (<%p> %s %s) ", expret, errorname(experr1), errorname(experr2));
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-#define EXPECT_STRZR(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strzr(expr, llen); } while (0)
-
-static __attribute__((unused))
-int expect_strzr(const char *expr, int llen)
-{
-	int ret = 0;
-
-	llen += printf(" = <%s> ", expr ? expr : "(null)");
-	if (expr) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_STRNZ(cond, expr)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strnz(expr, llen); } while (0)
-
-static __attribute__((unused))
-int expect_strnz(const char *expr, int llen)
-{
-	int ret = 0;
-
-	llen += printf(" = <%s> ", expr ? expr : "(null)");
-	if (!expr) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_STREQ(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_streq(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_streq(const char *expr, int llen, const char *cmp)
-{
-	int ret = 0;
-
-	llen += printf(" = <%s> ", expr);
-	if (strcmp(expr, cmp) != 0) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-
-#define EXPECT_STRNE(cond, expr, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strne(expr, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_strne(const char *expr, int llen, const char *cmp)
-{
-	int ret = 0;
-
-	llen += printf(" = <%s> ", expr);
-	if (strcmp(expr, cmp) == 0) {
-		ret = 1;
-		result(llen, FAIL);
-	} else {
-		result(llen, OK);
-	}
-	return ret;
-}
-
-#define EXPECT_STRBUFEQ(cond, expr, buf, val, cmp)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
-
-static __attribute__((unused))
-int expect_str_buf_eq(size_t expr, const char *buf, size_t val, int llen, const char *cmp)
-{
-	llen += printf(" = %lu <%s> ", (unsigned long)expr, buf);
-	if (strcmp(buf, cmp) != 0) {
-		result(llen, FAIL);
-		return 1;
-	}
-	if (expr != val) {
-		result(llen, FAIL);
-		return 1;
-	}
-
-	result(llen, OK);
-	return 0;
-}
-
-#define EXPECT_STRTOX(cond, func, input, base, expected, chars, expected_errno)				\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strtox(llen, func, input, base, expected, chars, expected_errno); } while (0)
-
-static __attribute__((unused))
-int expect_strtox(int llen, void *func, const char *input, int base, intmax_t expected, int expected_chars, int expected_errno)
-{
-	char *endptr;
-	int actual_errno, actual_chars;
-	intmax_t r;
-
-	errno = 0;
-	if (func == strtol) {
-		r = strtol(input, &endptr, base);
-	} else if (func == strtoul) {
-		r = strtoul(input, &endptr, base);
-	} else {
-		result(llen, FAIL);
-		return 1;
-	}
-	actual_errno = errno;
-	actual_chars = endptr - input;
-
-	llen += printf(" %lld = %lld", (long long)expected, (long long)r);
-	if (r != expected) {
-		result(llen, FAIL);
-		return 1;
-	}
-	if (expected_chars == -1) {
-		if (*endptr != '\0') {
-			result(llen, FAIL);
-			return 1;
-		}
-	} else if (expected_chars != actual_chars) {
-		result(llen, FAIL);
-		return 1;
-	}
-	if (actual_errno != expected_errno) {
-		result(llen, FAIL);
-		return 1;
-	}
-
-	result(llen, OK);
-	return 0;
-}
-
-/* declare tests based on line numbers. There must be exactly one test per line. */
-#define CASE_TEST(name) \
-	case __LINE__: llen += printf("%d %s", test, #name);
-
-/* constructors validate that they are executed in definition order */
-__attribute__((constructor))
-static void constructor1(void)
-{
-	constructor_test_value = 1;
-}
-
-__attribute__((constructor))
-static void constructor2(int argc, char **argv, char **envp)
-{
-	if (argc && argv && envp)
-		constructor_test_value *= 2;
-}
-
-int run_startup(int min, int max)
-{
-	int test;
-	int ret = 0;
-	/* kernel at least passes HOME and TERM, shell passes more */
-	int env_total = 2;
-	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
-	extern char end;
-	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
-	/* differ from nolibc, both glibc and musl have no global _auxv */
-	const unsigned long *test_auxv = (void *)-1;
-#ifdef NOLIBC
-	test_auxv = _auxv;
-#endif
-
-	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; /* line length */
-
-		/* avoid leaving empty lines below, this will insert holes into
-		 * test numbers.
-		 */
-		switch (test + __LINE__ + 1) {
-		CASE_TEST(argc);             EXPECT_GE(1, test_argc, 1); break;
-		CASE_TEST(argv_addr);        EXPECT_PTRGT(1, test_argv, brk); break;
-		CASE_TEST(argv_environ);     EXPECT_PTRLT(1, test_argv, environ); break;
-		CASE_TEST(argv_total);       EXPECT_EQ(1, environ - test_argv - 1, test_argc ?: 1); break;
-		CASE_TEST(argv0_addr);       EXPECT_PTRGT(1, argv0, brk); break;
-		CASE_TEST(argv0_str);        EXPECT_STRNZ(1, argv0 > brk ? argv0 : NULL); break;
-		CASE_TEST(argv0_len);        EXPECT_GE(1,  argv0 > brk ? strlen(argv0) : 0, 1); break;
-		CASE_TEST(environ_addr);     EXPECT_PTRGT(1, environ, brk); break;
-		CASE_TEST(environ_envp);     EXPECT_PTREQ(1, environ, test_envp); break;
-		CASE_TEST(environ_auxv);     EXPECT_PTRLT(test_auxv != (void *)-1, environ, test_auxv); break;
-		CASE_TEST(environ_total);    EXPECT_GE(test_auxv != (void *)-1, (void *)test_auxv - (void *)environ - 1, env_total); break;
-		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
-		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
-		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(constructor);      EXPECT_EQ(is_nolibc, constructor_test_value, 2); break;
-		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
-		CASE_TEST(linkage_constr);   EXPECT_EQ(is_nolibc, linkage_test_constructor_test_value, 6); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
-	}
-	return ret;
-}
-
-
-/* used by some syscall tests below */
-int test_getdents64(const char *dir)
-{
-	char buffer[4096];
-	int fd, ret;
-	int err;
-
-	ret = fd = open(dir, O_RDONLY | O_DIRECTORY, 0);
-	if (ret < 0)
-		return ret;
-
-	ret = getdents64(fd, (void *)buffer, sizeof(buffer));
-	err = errno;
-	close(fd);
-
-	errno = err;
-	return ret;
-}
-
-static int test_dirent(void)
-{
-	int comm = 0, cmdline = 0;
-	struct dirent dirent, *result;
-	DIR *dir;
-	int ret;
-
-	dir = opendir("/proc/self");
-	if (!dir)
-		return 1;
-
-	while (1) {
-		errno = 0;
-		ret = readdir_r(dir, &dirent, &result);
-		if (ret != 0)
-			return 1;
-		if (!result)
-			break;
-
-		if (strcmp(dirent.d_name, "comm") == 0)
-			comm++;
-		else if (strcmp(dirent.d_name, "cmdline") == 0)
-			cmdline++;
-	}
-
-	if (errno)
-		return 1;
-
-	ret = closedir(dir);
-	if (ret)
-		return 1;
-
-	if (comm != 1 || cmdline != 1)
-		return 1;
-
-	return 0;
-}
-
-int test_getpagesize(void)
-{
-	int x = getpagesize();
-	int c;
-
-	if (x < 0)
-		return x;
-
-#if defined(__x86_64__) || defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__)
-	/*
-	 * x86 family is always 4K page.
-	 */
-	c = (x == 4096);
-#elif defined(__aarch64__)
-	/*
-	 * Linux aarch64 supports three values of page size: 4K, 16K, and 64K
-	 * which are selected at kernel compilation time.
-	 */
-	c = (x == 4096 || x == (16 * 1024) || x == (64 * 1024));
-#else
-	/*
-	 * Assuming other architectures must have at least 4K page.
-	 */
-	c = (x >= 4096);
-#endif
-
-	return !c;
-}
-
-int test_fork(void)
-{
-	int status;
-	pid_t pid;
-
-	/* flush the printf buffer to avoid child flush it */
-	fflush(stdout);
-	fflush(stderr);
-
-	pid = fork();
-
-	switch (pid) {
-	case -1:
-		return 1;
-
-	case 0:
-		exit(123);
-
-	default:
-		pid = waitpid(pid, &status, 0);
-
-		return pid == -1 || !WIFEXITED(status) || WEXITSTATUS(status) != 123;
-	}
-}
-
-int test_stat_timestamps(void)
-{
-	struct stat st;
-
-	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
-		return 1;
-
-	if (stat("/proc/self/", &st) && stat(argv0, &st) && stat("/", &st))
-		return 1;
-
-	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
-		return 1;
-
-	if (st.st_mtim.tv_sec != st.st_mtime || st.st_mtim.tv_nsec > 1000000000)
-		return 1;
-
-	if (st.st_ctim.tv_sec != st.st_ctime || st.st_ctim.tv_nsec > 1000000000)
-		return 1;
-
-	return 0;
-}
-
-int test_uname(void)
-{
-	struct utsname buf;
-	char osrelease[sizeof(buf.release)];
-	ssize_t r;
-	int fd;
-
-	memset(&buf.domainname, 'P', sizeof(buf.domainname));
-
-	if (uname(&buf))
-		return 1;
-
-	if (strncmp("Linux", buf.sysname, sizeof(buf.sysname)))
-		return 1;
-
-	fd = open("/proc/sys/kernel/osrelease", O_RDONLY);
-	if (fd == -1)
-		return 1;
-
-	r = read(fd, osrelease, sizeof(osrelease));
-	if (r == -1)
-		return 1;
-
-	close(fd);
-
-	if (osrelease[r - 1] == '\n')
-		r--;
-
-	/* Validate one of the later fields to ensure field sizes are correct */
-	if (strncmp(osrelease, buf.release, r))
-		return 1;
-
-	/* Ensure the field domainname is set, it is missing from struct old_utsname */
-	if (strnlen(buf.domainname, sizeof(buf.domainname)) == sizeof(buf.domainname))
-		return 1;
-
-	return 0;
-}
-
-int test_mmap_munmap(void)
-{
-	int ret, fd, i, page_size;
-	void *mem;
-	size_t file_size, length;
-	off_t offset, pa_offset;
-	struct stat stat_buf;
-	const char * const files[] = {
-		"/dev/zero",
-		"/proc/1/exe", "/proc/self/exe",
-		argv0,
-		NULL
-	};
-
-	page_size = getpagesize();
-	if (page_size < 0)
-		return 1;
-
-	/* find a right file to mmap, existed and accessible */
-	for (i = 0; files[i] != NULL; i++) {
-		ret = fd = open(files[i], O_RDONLY);
-		if (ret == -1)
-			continue;
-		else
-			break;
-	}
-	if (ret == -1)
-		return 1;
-
-	ret = stat(files[i], &stat_buf);
-	if (ret == -1)
-		goto end;
-
-	/* file size of the special /dev/zero is 0, let's assign one manually */
-	if (i == 0)
-		file_size = 3*page_size;
-	else
-		file_size = stat_buf.st_size;
-
-	offset = file_size - 1;
-	if (offset < 0)
-		offset = 0;
-	length = file_size - offset;
-	pa_offset = offset & ~(page_size - 1);
-
-	mem = mmap(NULL, length + offset - pa_offset, PROT_READ, MAP_SHARED, fd, pa_offset);
-	if (mem == MAP_FAILED) {
-		ret = 1;
-		goto end;
-	}
-
-	ret = munmap(mem, length + offset - pa_offset);
-
-end:
-	close(fd);
-	return !!ret;
-}
-
-int test_pipe(void)
-{
-	const char *const msg = "hello, nolibc";
-	int pipefd[2];
-	char buf[32];
-	size_t len;
-
-	if (pipe(pipefd) == -1)
-		return 1;
-
-	write(pipefd[1], msg, strlen(msg));
-	close(pipefd[1]);
-	len = read(pipefd[0], buf, sizeof(buf));
-	close(pipefd[0]);
-
-	if (len != strlen(msg))
-		return 1;
-
-	return !!memcmp(buf, msg, len);
-}
-
-int test_rlimit(void)
-{
-	struct rlimit rlim = {
-		.rlim_cur = 1 << 20,
-		.rlim_max = 1 << 21,
-	};
-	int ret;
-
-	ret = setrlimit(RLIMIT_CORE, &rlim);
-	if (ret)
-		return -1;
-
-	rlim.rlim_cur = 0;
-	rlim.rlim_max = 0;
-
-	ret = getrlimit(RLIMIT_CORE, &rlim);
-	if (ret)
-		return -1;
-
-	if (rlim.rlim_cur != 1 << 20)
-		return -1;
-	if (rlim.rlim_max != 1 << 21)
-		return -1;
-
-	return 0;
-}
-
-
-/* Run syscall tests between IDs <min> and <max>.
- * Return 0 on success, non-zero on failure.
- */
-int run_syscall(int min, int max)
-{
-	struct timeval tv;
-	struct timezone tz;
-	struct stat stat_buf;
-	int euid0;
-	int proc;
-	int test;
-	int tmp;
-	int ret = 0;
-	void *p1, *p2;
-	int has_gettid = 1;
-	int has_brk;
-
-	/* <proc> indicates whether or not /proc is mounted */
-	proc = stat("/proc", &stat_buf) == 0;
-
-	/* this will be used to skip certain tests that can't be run unprivileged */
-	euid0 = geteuid() == 0;
-
-	/* from 2.30, glibc provides gettid() */
-#if defined(__GLIBC_MINOR__) && defined(__GLIBC__)
-	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
-#endif
-
-	/* on musl setting brk()/sbrk() always fails */
-	has_brk = brk(0) == 0;
-
-	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; /* line length */
-
-		/* avoid leaving empty lines below, this will insert holes into
-		 * test numbers.
-		 */
-		switch (test + __LINE__ + 1) {
-		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
-		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
-		CASE_TEST(gettid);            EXPECT_SYSNE(has_gettid, gettid(), -1); break;
-		CASE_TEST(getpgid_self);      EXPECT_SYSNE(1, getpgid(0), -1); break;
-		CASE_TEST(getpgid_bad);       EXPECT_SYSER(1, getpgid(-1), -1, ESRCH); break;
-		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
-		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
-		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESRCH); break;
-		CASE_TEST(sbrk_0);            EXPECT_PTRNE(has_brk, sbrk(0), (void *)-1); break;
-		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(has_brk, (p2 == (void *)-1) || p2 == p1); break;
-		CASE_TEST(brk);               EXPECT_SYSZR(has_brk, brk(sbrk(0))); break;
-		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
-		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
-		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
-		CASE_TEST(chmod_argv0);       EXPECT_SYSZR(1, chmod(argv0, 0555)); break;
-		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
-		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
-		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
-		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-		CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot(argv0), -1, ENOTDIR); break;
-		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
-		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
-		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
-		CASE_TEST(dup_m1);            tmp = dup(-1); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
-		CASE_TEST(dup2_0);            tmp = dup2(0, 100);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
-		CASE_TEST(dup2_m1);           tmp = dup2(-1, 100); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
-		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
-		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
-		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
-		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
-		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
-		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
-		CASE_TEST(directories);       EXPECT_SYSZR(proc, test_dirent()); break;
-		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
-		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
-		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
-		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
-		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
-		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
-		CASE_TEST(link_dir);          EXPECT_SYSER(euid0, link("/", "/blah"), -1, EPERM); break;
-		CASE_TEST(link_cross);        EXPECT_SYSER(proc, link("/proc/self/cmdline", "/blah"), -1, EXDEV); break;
-		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
-		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
-		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
-		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
-		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap(NULL, 0), -1, EINVAL); break;
-		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
-		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
-		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
-		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
-		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
-		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll(NULL, 1, 0), -1, EFAULT); break;
-		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
-		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
-		CASE_TEST(rlimit);            EXPECT_SYSZR(1, test_rlimit()); break;
-		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
-		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
-		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
-		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
-		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
-		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
-		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
-		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
-		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
-		CASE_TEST(uname);             EXPECT_SYSZR(proc, test_uname()); break;
-		CASE_TEST(uname_fault);       EXPECT_SYSER(1, uname(NULL), -1, EFAULT); break;
-		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
-		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
-		CASE_TEST(wait_child);        EXPECT_SYSER(1, wait(&tmp), -1, ECHILD); break;
-		CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, ESRCH); break;
-		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
-		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
-		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
-		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
-		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_statx, 0, NULL, 0, 0, NULL), -1, EFAULT); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
-	}
-	return ret;
-}
-
-int run_stdlib(int min, int max)
-{
-	int test;
-	int ret = 0;
-
-	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; /* line length */
-
-		/* For functions that take a long buffer, like strlcat()
-		 * Add some more chars after the \0, to test functions that overwrite the buffer set
-		 * the \0 at the exact right position.
-		 */
-		char buf[10] = "test123456";
-		buf[4] = '\0';
-
-
-		/* avoid leaving empty lines below, this will insert holes into
-		 * test numbers.
-		 */
-		switch (test + __LINE__ + 1) {
-		CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
-		CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
-		CASE_TEST(setcmp_blah_blah);   EXPECT_EQ(1, strcmp("blah", "blah"), 0); break;
-		CASE_TEST(setcmp_blah_blah2);  EXPECT_NE(1, strcmp("blah", "blah2"), 0); break;
-		CASE_TEST(setncmp_blah_blah);  EXPECT_EQ(1, strncmp("blah", "blah", 10), 0); break;
-		CASE_TEST(setncmp_blah_blah4); EXPECT_EQ(1, strncmp("blah", "blah4", 4), 0); break;
-		CASE_TEST(setncmp_blah_blah5); EXPECT_NE(1, strncmp("blah", "blah5", 5), 0); break;
-		CASE_TEST(setncmp_blah_blah6); EXPECT_NE(1, strncmp("blah", "blah6", 6), 0); break;
-		CASE_TEST(strchr_foobar_o);    EXPECT_STREQ(1, strchr("foobar", 'o'), "oobar"); break;
-		CASE_TEST(strchr_foobar_z);    EXPECT_STRZR(1, strchr("foobar", 'z')); break;
-		CASE_TEST(strrchr_foobar_o);   EXPECT_STREQ(1, strrchr("foobar", 'o'), "obar"); break;
-		CASE_TEST(strrchr_foobar_z);   EXPECT_STRZR(1, strrchr("foobar", 'z')); break;
-		CASE_TEST(strlcat_0);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 0), buf, 3, "test"); break;
-		CASE_TEST(strlcat_1);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 1), buf, 4, "test"); break;
-		CASE_TEST(strlcat_5);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 5), buf, 7, "test"); break;
-		CASE_TEST(strlcat_6);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 6), buf, 7, "testb"); break;
-		CASE_TEST(strlcat_7);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 7), buf, 7, "testba"); break;
-		CASE_TEST(strlcat_8);          EXPECT_STRBUFEQ(is_nolibc, strlcat(buf, "bar", 8), buf, 7, "testbar"); break;
-		CASE_TEST(strlcpy_0);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 0), buf, 3, "test"); break;
-		CASE_TEST(strlcpy_1);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 1), buf, 3, ""); break;
-		CASE_TEST(strlcpy_2);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 2), buf, 3, "b"); break;
-		CASE_TEST(strlcpy_3);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 3), buf, 3, "ba"); break;
-		CASE_TEST(strlcpy_4);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 4), buf, 3, "bar"); break;
-		CASE_TEST(memcmp_20_20);       EXPECT_EQ(1, memcmp("aaa\x20", "aaa\x20", 4), 0); break;
-		CASE_TEST(memcmp_20_60);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\x60", 4), 0); break;
-		CASE_TEST(memcmp_60_20);       EXPECT_GT(1, memcmp("aaa\x60", "aaa\x20", 4), 0); break;
-		CASE_TEST(memcmp_20_e0);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\xe0", 4), 0); break;
-		CASE_TEST(memcmp_e0_20);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x20", 4), 0); break;
-		CASE_TEST(memcmp_80_e0);       EXPECT_LT(1, memcmp("aaa\x80", "aaa\xe0", 4), 0); break;
-		CASE_TEST(memcmp_e0_80);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x80", 4), 0); break;
-		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,         (int8_t)          0x7f); break;
-		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,         (int8_t)          0x80); break;
-		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,        (uint8_t)         0xff); break;
-		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,        (int16_t)         0x7fff); break;
-		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,        (int16_t)         0x8000); break;
-		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX,       (uint16_t)        0xffff); break;
-		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,        (int32_t)         0x7fffffff); break;
-		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,        (int32_t)         0x80000000); break;
-		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX,       (uint32_t)        0xffffffff); break;
-		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,        (int64_t)         0x7fffffffffffffff); break;
-		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,        (int64_t)         0x8000000000000000); break;
-		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX,       (uint64_t)        0xffffffffffffffff); break;
-		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
-		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
-		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
-		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
-		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
-		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
-		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
-		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
-		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffffU); break;
-		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
-		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
-		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
-		CASE_TEST(limit_int_fast8_max);     EXPECT_EQ(1, INT_FAST8_MAX,    (int_fast8_t)     0x7f); break;
-		CASE_TEST(limit_int_fast8_min);     EXPECT_EQ(1, INT_FAST8_MIN,    (int_fast8_t)     0x80); break;
-		CASE_TEST(limit_uint_fast8_max);    EXPECT_EQ(1, UINT_FAST8_MAX,   (uint_fast8_t)    0xff); break;
-		CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,   (int_fast16_t)    SINT_MIN_OF_TYPE(int_fast16_t)); break;
-		CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,   (int_fast16_t)    SINT_MAX_OF_TYPE(int_fast16_t)); break;
-		CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX,  (uint_fast16_t)   UINTPTR_MAX); break;
-		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    SINT_MIN_OF_TYPE(int_fast32_t)); break;
-		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    SINT_MAX_OF_TYPE(int_fast32_t)); break;
-		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINTPTR_MAX); break;
-		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INT64_MIN); break;
-		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INT64_MAX); break;
-		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINT64_MAX); break;
-		CASE_TEST(sizeof_long_sane);        EXPECT_EQ(1, sizeof(long) == 8 || sizeof(long) == 4, 1); break;
-		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  sizeof(long) == 8 ? (intptr_t)  0x8000000000000000LL  : (intptr_t)  0x80000000); break;
-		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  sizeof(long) == 8 ? (intptr_t)  0x7fffffffffffffffLL  : (intptr_t)  0x7fffffff); break;
-		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, sizeof(long) == 8 ? (uintptr_t) 0xffffffffffffffffULL : (uintptr_t) 0xffffffffU); break;
-		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, sizeof(long) == 8 ? (ptrdiff_t) 0x8000000000000000LL  : (ptrdiff_t) 0x80000000); break;
-		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, sizeof(long) == 8 ? (ptrdiff_t) 0x7fffffffffffffffLL  : (ptrdiff_t) 0x7fffffff); break;
-		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    sizeof(long) == 8 ? (size_t)    0xffffffffffffffffULL : (size_t)    0xffffffffU); break;
-		CASE_TEST(strtol_simple);           EXPECT_STRTOX(1, strtol, "35", 10, 35, -1, 0); break;
-		CASE_TEST(strtol_positive);         EXPECT_STRTOX(1, strtol, "+35", 10, 35, -1, 0); break;
-		CASE_TEST(strtol_negative);         EXPECT_STRTOX(1, strtol, "-35", 10, -35, -1, 0); break;
-		CASE_TEST(strtol_hex_auto);         EXPECT_STRTOX(1, strtol, "0xFF", 0, 255, -1, 0); break;
-		CASE_TEST(strtol_base36);           EXPECT_STRTOX(1, strtol, "12yZ", 36, 50507, -1, 0); break;
-		CASE_TEST(strtol_cutoff);           EXPECT_STRTOX(1, strtol, "1234567890", 8, 342391, 7, 0); break;
-		CASE_TEST(strtol_octal_auto);       EXPECT_STRTOX(1, strtol, "011", 0, 9, -1, 0); break;
-		CASE_TEST(strtol_hex_00);           EXPECT_STRTOX(1, strtol, "0x00", 16, 0, -1, 0); break;
-		CASE_TEST(strtol_hex_FF);           EXPECT_STRTOX(1, strtol, "FF", 16, 255, -1, 0); break;
-		CASE_TEST(strtol_hex_ff);           EXPECT_STRTOX(1, strtol, "ff", 16, 255, -1, 0); break;
-		CASE_TEST(strtol_hex_prefix);       EXPECT_STRTOX(1, strtol, "0xFF", 16, 255, -1, 0); break;
-		CASE_TEST(strtol_trailer);          EXPECT_STRTOX(1, strtol, "35foo", 10, 35, 2, 0); break;
-		CASE_TEST(strtol_overflow);         EXPECT_STRTOX(1, strtol, "0x8000000000000000", 16, LONG_MAX, -1, ERANGE); break;
-		CASE_TEST(strtol_underflow);        EXPECT_STRTOX(1, strtol, "-0x8000000000000001", 16, LONG_MIN, -1, ERANGE); break;
-		CASE_TEST(strtoul_negative);        EXPECT_STRTOX(1, strtoul, "-0x1", 16, ULONG_MAX, 4, 0); break;
-		CASE_TEST(strtoul_overflow);        EXPECT_STRTOX(1, strtoul, "0x10000000000000000", 16, ULONG_MAX, -1, ERANGE); break;
-		CASE_TEST(strerror_success);        EXPECT_STREQ(is_nolibc, strerror(0), "errno=0"); break;
-		CASE_TEST(strerror_EINVAL);         EXPECT_STREQ(is_nolibc, strerror(EINVAL), "errno=22"); break;
-		CASE_TEST(strerror_int_max);        EXPECT_STREQ(is_nolibc, strerror(INT_MAX), "errno=2147483647"); break;
-		CASE_TEST(strerror_int_min);        EXPECT_STREQ(is_nolibc, strerror(INT_MIN), "errno=-2147483648"); break;
-		CASE_TEST(tolower);                 EXPECT_EQ(1, tolower('A'), 'a'); break;
-		CASE_TEST(tolower_noop);            EXPECT_EQ(1, tolower('a'), 'a'); break;
-		CASE_TEST(toupper);                 EXPECT_EQ(1, toupper('a'), 'A'); break;
-		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
-
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
-	}
-	return ret;
-}
-
-#define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
-	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
-
-static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
-{
-	char buf[100];
-	va_list args;
-	ssize_t w;
-	int ret;
-
-
-	va_start(args, fmt);
-	/* Only allow writing 21 bytes, to test truncation */
-	w = vsnprintf(buf, 21, fmt, args);
-	va_end(args);
-
-	if (w != c) {
-		llen += printf(" written(%d) != %d", (int)w, c);
-		result(llen, FAIL);
-		return 1;
-	}
-
-	llen += printf(" \"%s\" = \"%s\"", expected, buf);
-	ret = strncmp(expected, buf, c);
-
-	result(llen, ret ? FAIL : OK);
-	return ret;
-}
-
-static int test_scanf(void)
-{
-	unsigned long long ull;
-	unsigned long ul;
-	unsigned int u;
-	long long ll;
-	long l;
-	void *p;
-	int i;
-
-	/* return __LINE__ to point to the specific failure */
-
-	/* test EOF */
-	if (sscanf("", "foo") != EOF)
-		return __LINE__;
-
-	/* test simple literal without placeholder */
-	if (sscanf("foo", "foo") != 0)
-		return __LINE__;
-
-	/* test single placeholder */
-	if (sscanf("123", "%d", &i) != 1)
-		return __LINE__;
-
-	if (i != 123)
-		return __LINE__;
-
-	/* test multiple place holders and separators */
-	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
-		return __LINE__;
-
-	if (i != 123)
-		return __LINE__;
-
-	if (u != 456)
-		return __LINE__;
-
-	if (p != (void *)0x90)
-		return __LINE__;
-
-	/* test space handling */
-	if (sscanf("a    b1", "a b%d", &i) != 1)
-		return __LINE__;
-
-	if (i != 1)
-		return __LINE__;
-
-	/* test literal percent */
-	if (sscanf("a%1", "a%%%d", &i) != 1)
-		return __LINE__;
-
-	if (i != 1)
-		return __LINE__;
-
-	/* test stdint.h types */
-	if (sscanf("1|2|3|4|5|6",
-		   "%d|%ld|%lld|%u|%lu|%llu",
-		   &i, &l, &ll, &u, &ul, &ull) != 6)
-		return __LINE__;
-
-	if (i != 1 || l != 2 || ll != 3 ||
-	    u != 4 || ul != 5 || ull != 6)
-		return __LINE__;
-
-	return 0;
-}
-
-static int run_printf(int min, int max)
-{
-	int test;
-	int ret = 0;
-
-	for (test = min; test >= 0 && test <= max; test++) {
-		int llen = 0; /* line length */
-
-		/* avoid leaving empty lines below, this will insert holes into
-		 * test numbers.
-		 */
-		switch (test + __LINE__ + 1) {
-		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
-		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
-		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
-		CASE_TEST(number);       EXPECT_VFPRINTF(4, "1234", "%d", 1234); break;
-		CASE_TEST(negnumber);    EXPECT_VFPRINTF(5, "-1234", "%d", -1234); break;
-		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
-		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
-		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
-		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
-		CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
-		CASE_TEST(intmax_t);     EXPECT_VFPRINTF(20, "-9223372036854775807", "%jd", 0x8000000000000001LL); break;
-		CASE_TEST(truncation);   EXPECT_VFPRINTF(25, "01234567890123456789", "%s", "0123456789012345678901234"); break;
-		CASE_TEST(string_width); EXPECT_VFPRINTF(10, "         1", "%10s", "1"); break;
-		CASE_TEST(number_width); EXPECT_VFPRINTF(10, "         1", "%10d", 1); break;
-		CASE_TEST(width_trunc);  EXPECT_VFPRINTF(25, "                    ", "%25d", 1); break;
-		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
-		case __LINE__:
-			return ret; /* must be last */
-		/* note: do not set any defaults so as to permit holes above */
-		}
-	}
-	return ret;
-}
-
-static int smash_stack(void)
-{
-	char buf[100];
-	volatile char *ptr = buf;
-	size_t i;
-
-	for (i = 0; i < 200; i++)
-		ptr[i] = 'P';
-
-	return 1;
-}
-
-static int run_protection(int min __attribute__((unused)),
-			  int max __attribute__((unused)))
-{
-	pid_t pid;
-	int llen = 0, status;
-	struct rlimit rlimit = { 0, 0 };
-
-	llen += printf("0 -fstackprotector ");
-
-#if !defined(_NOLIBC_STACKPROTECTOR)
-	llen += printf("not supported");
-	result(llen, SKIPPED);
-	return 0;
-#endif
-
-#if defined(_NOLIBC_STACKPROTECTOR)
-	if (!__stack_chk_guard) {
-		llen += printf("__stack_chk_guard not initialized");
-		result(llen, FAIL);
-		return 1;
-	}
-#endif
-
-	pid = -1;
-	pid = fork();
-
-	switch (pid) {
-	case -1:
-		llen += printf("fork()");
-		result(llen, FAIL);
-		return 1;
-
-	case 0:
-		close(STDOUT_FILENO);
-		close(STDERR_FILENO);
-
-		prctl(PR_SET_DUMPABLE, 0, 0, 0, 0);
-		setrlimit(RLIMIT_CORE, &rlimit);
-		smash_stack();
-		return 1;
-
-	default:
-		pid = waitpid(pid, &status, 0);
-
-		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
-			llen += printf("waitpid()");
-			result(llen, FAIL);
-			return 1;
-		}
-		result(llen, OK);
-		return 0;
-	}
-}
-
-/* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
-int prepare(void)
-{
-	struct stat stat_buf;
-
-	/* It's possible that /dev doesn't even exist or was not mounted, so
-	 * we'll try to create it, mount it, or create minimal entries into it.
-	 * We want at least /dev/null and /dev/console.
-	 */
-	if (stat("/dev/.", &stat_buf) == 0 || mkdir("/dev", 0755) == 0) {
-		if (stat("/dev/console", &stat_buf) != 0 ||
-		    stat("/dev/null", &stat_buf) != 0 ||
-		    stat("/dev/zero", &stat_buf) != 0) {
-			/* try devtmpfs first, otherwise fall back to manual creation */
-			if (mount("/dev", "/dev", "devtmpfs", 0, 0) != 0) {
-				mknod("/dev/console", 0600 | S_IFCHR, makedev(5, 1));
-				mknod("/dev/null",    0666 | S_IFCHR, makedev(1, 3));
-				mknod("/dev/zero",    0666 | S_IFCHR, makedev(1, 5));
-			}
-		}
-	}
-
-	/* If no /dev/console was found before calling init, stdio is closed so
-	 * we need to reopen it from /dev/console. If it failed above, it will
-	 * still fail here and we cannot emit a message anyway.
-	 */
-	if (close(dup(1)) == -1) {
-		int fd = open("/dev/console", O_RDWR);
-
-		if (fd >= 0) {
-			if (fd != 0)
-				dup2(fd, 0);
-			if (fd != 1)
-				dup2(fd, 1);
-			if (fd != 2)
-				dup2(fd, 2);
-			if (fd > 2)
-				close(fd);
-			puts("\nSuccessfully reopened /dev/console.");
-		}
-	}
-
-	/* try to mount /proc if not mounted. Silently fail otherwise */
-	if (stat("/proc/.", &stat_buf) == 0 || mkdir("/proc", 0755) == 0) {
-		if (stat("/proc/self", &stat_buf) != 0) {
-			/* If not mountable, remove /proc completely to avoid misuse */
-			if (mount("none", "/proc", "proc", 0, 0) != 0)
-				rmdir("/proc");
-		}
-	}
-
-	/* some tests rely on a writable /tmp */
-	mkdir("/tmp", 0755);
-
-	return 0;
-}
-
-/* This is the definition of known test names, with their functions */
-static const struct test test_names[] = {
-	/* add new tests here */
-	{ .name = "startup",    .func = run_startup    },
-	{ .name = "syscall",    .func = run_syscall    },
-	{ .name = "stdlib",     .func = run_stdlib     },
-	{ .name = "printf",     .func = run_printf     },
-	{ .name = "protection", .func = run_protection },
-	{ 0 }
-};
-
-static int is_setting_valid(char *test)
-{
-	int idx, len, test_len, valid = 0;
-	char delimiter;
-
-	if (!test)
-		return valid;
-
-	test_len = strlen(test);
-
-	for (idx = 0; test_names[idx].name; idx++) {
-		len = strlen(test_names[idx].name);
-		if (test_len < len)
-			continue;
-
-		if (strncmp(test, test_names[idx].name, len) != 0)
-			continue;
-
-		delimiter = test[len];
-		if (delimiter != ':' && delimiter != ',' && delimiter != '\0')
-			continue;
-
-		valid = 1;
-		break;
-	}
-
-	return valid;
-}
-
-int main(int argc, char **argv, char **envp)
-{
-	int min = 0;
-	int max = INT_MAX;
-	int ret = 0;
-	int err;
-	int idx;
-	char *test;
-
-	argv0 = argv[0];
-	test_argc = argc;
-	test_argv = argv;
-	test_envp = envp;
-
-	/* when called as init, it's possible that no console was opened, for
-	 * example if no /dev file system was provided. We'll check that fd#1
-	 * was opened, and if not we'll attempt to create and open /dev/console
-	 * and /dev/null that we'll use for later tests.
-	 */
-	if (getpid() == 1)
-		prepare();
-
-	/* the definition of a series of tests comes from either argv[1] or the
-	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
-	 * series of test names and optional ranges:
-	 *    syscall:5-15[:.*],stdlib:8-10
-	 */
-	test = argv[1];
-	if (!is_setting_valid(test))
-		test = getenv("NOLIBC_TEST");
-
-	if (is_setting_valid(test)) {
-		char *comma, *colon, *dash, *value;
-
-		do {
-			comma = strchr(test, ',');
-			if (comma)
-				*(comma++) = '\0';
-
-			colon = strchr(test, ':');
-			if (colon)
-				*(colon++) = '\0';
-
-			for (idx = 0; test_names[idx].name; idx++) {
-				if (strcmp(test, test_names[idx].name) == 0)
-					break;
-			}
-
-			if (test_names[idx].name) {
-				/* The test was named, it will be called at least
-				 * once. We may have an optional range at <colon>
-				 * here, which defaults to the full range.
-				 */
-				do {
-					min = 0; max = INT_MAX;
-					value = colon;
-					if (value && *value) {
-						colon = strchr(value, ':');
-						if (colon)
-							*(colon++) = '\0';
-
-						dash = strchr(value, '-');
-						if (dash)
-							*(dash++) = '\0';
-
-						/* support :val: :min-max: :min-: :-max: */
-						if (*value)
-							min = atoi(value);
-						if (!dash)
-							max = min;
-						else if (*dash)
-							max = atoi(dash);
-
-						value = colon;
-					}
-
-					/* now's time to call the test */
-					printf("Running test '%s'\n", test_names[idx].name);
-					err = test_names[idx].func(min, max);
-					ret += err;
-					printf("Errors during this test: %d\n\n", err);
-				} while (colon && *colon);
-			} else
-				printf("Ignoring unknown test name '%s'\n", test);
-
-			test = comma;
-		} while (test && *test);
-	} else {
-		/* no test mentioned, run everything */
-		for (idx = 0; test_names[idx].name; idx++) {
-			printf("Running test '%s'\n", test_names[idx].name);
-			err = test_names[idx].func(min, max);
-			ret += err;
-			printf("Errors during this test: %d\n\n", err);
-		}
-	}
-
-	printf("Total number of errors: %d\n", ret);
-
-	if (getpid() == 1) {
-		/* we're running as init, there's no other process on the
-		 * system, thus likely started from a VM for a quick check.
-		 * Exiting will provoke a kernel panic that may be reported
-		 * as an error by Qemu or the hypervisor, while stopping
-		 * cleanly will often be reported as a success. This allows
-		 * to use the output of this program for bisecting kernels.
-		 */
-		printf("Leaving init with final status: %d\n", !!ret);
-		if (ret == 0)
-			reboot(RB_POWER_OFF);
-#if defined(__x86_64__)
-		/* QEMU started with "-device isa-debug-exit -no-reboot" will
-		 * exit with status code 2N+1 when N is written to 0x501. We
-		 * hard-code the syscall here as it's arch-dependent.
-		 */
-		else if (syscall(__NR_ioperm, 0x501, 1, 1) == 0)
-			__asm__ volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
-		/* if it does nothing, fall back to the regular panic */
-#endif
-	}
-
-	printf("Exiting with status %d\n", !!ret);
-	return !!ret;
-}
+#include "harness-selftest.c"
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 0299a0912d4049dd12217f9835b81d231e1d2bfd..9344e3e8e10466dbb04a80028439599bb0cb28a2 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -189,7 +189,7 @@ test_arch() {
 	swallow_output "${MAKE[@]}" defconfig
 	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" "$test_target" V=1
 	cp run.out run.out."${arch}"
-	"${MAKE[@]}" report | grep passed
+	"${MAKE[@]}" report
 }
 
 if [ "$perform_download" -ne 0 ]; then

-- 
2.48.1


