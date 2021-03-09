Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311B4332F2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Mar 2021 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCITk0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Mar 2021 14:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhCITkW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Mar 2021 14:40:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A97A965226;
        Tue,  9 Mar 2021 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615318822;
        bh=VjF+TsVYh8ZIU4dNFpjvFPS4hnezK9SWqlt+zfQfwRo=;
        h=From:To:Cc:Subject:Date:From;
        b=fpeT62oLL8m1vBa9dL49bBjZZbf9JgbbiYTUU289J6t22e9r000cZoxLIih+aoN6p
         8GktijRBLSyWS2Ee7pxL/2SVmiSrM8EDQX7atTJNIoeY1CogfiszZQRAlpG8HCNtA5
         44dyUcTpqLuc4nSwnTjFfug2MkUoQG97n3+RQiRigRa5Zhqy4rrOTjdPYkyvuuLI6L
         FpVhjtgSR+oRM5gy8PJgsDBVdbKtIeeODW/WwYTL/aObOPi+fL9Z/UtWqPjOAUVaW0
         xGJykZuC9ezcjQwmFwGICZ7hJaWAWoxRpJLB/C1w63S6bsCfqnjr2WTD26/MHFsbqW
         MKQmbANqM6rSQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH] kselftest: arm64: Add BTI tests
Date:   Tue,  9 Mar 2021 19:37:31 +0000
Message-Id: <20210309193731.57247-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=giYty4+XlBzXoyv/hB2cj7v/ncZCl1+uMLmoK/AzQD0=; m=ZngAOH4pMo++v00Gu7QVqphZTgotV4kBEqwM90Npc2o=; p=rdJmpufcffzeO1LBsZuma5X8S81gTkMIuQ6mY369EUg=; g=cf593ae3a8935715dce384a6acc8054fd033f60c
X-Patch-Sig: m=pgp; i=broonie@kernel.org; s=0xC3F436CA30F5D8EB; b=iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBHziIACgkQJNaLcl1Uh9BhgQf8CxL p13VcJKfLHsdKyHKLjPNUZUnq8uhFZ0g57lK44lda8Kw4BddC7IptkTocv8uUuulcTczU/DEsD6vQ GBUVw0Du4sYjKGRUWg4MMeh10OfrTfB/Qorij9Dkh7Nj4HyMdzy+F61fAPUO7i+8NXNbsChBGp+oy EU5MbZwIzevmuPzpeD129EtjApRURBvYn80XRqDIjz3vCoJVYDANtFI8icTXoNmWTjOJIo2fUB6Px dD4twOePjG3iXPdRbtCNB0RAuBIKZsdWkBx2bvIW+0Acoivq97eIaoSJI3ouwWGyg0uvgGkhCw6S1 UQUBq2/a1AsFejDspSDsQ/3QCCcVKkQ==
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some tests that verify that BTI functions correctly for static binaries
built with and without BTI support, verifying that SIGILL is generated when
expected and is not generated in other situations.

Since BTI support is still being rolled out in distributions these tests
are built entirely free standing, no libc support is used at all so none
of the standard helper functions for kselftest can be used and we open
code everything. This also means we aren't testing the kernel support for
the dynamic linker, though the test program can be readily adapted for
that once it becomes something that we can reliably build and run.

These tests were originally written by Dave Martin, I've adapted them for
kselftest, mainly around the build system and the output format.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/bti/.gitignore  |   2 +
 tools/testing/selftests/arm64/bti/Makefile    |  61 +++++
 tools/testing/selftests/arm64/bti/assembler.h |  80 ++++++
 tools/testing/selftests/arm64/bti/btitest.h   |  23 ++
 tools/testing/selftests/arm64/bti/compiler.h  |  21 ++
 .../selftests/arm64/bti/gen/.gitignore        |   2 +
 tools/testing/selftests/arm64/bti/signal.c    |  37 +++
 tools/testing/selftests/arm64/bti/signal.h    |  21 ++
 tools/testing/selftests/arm64/bti/start.S     |  14 ++
 tools/testing/selftests/arm64/bti/syscall.S   |  23 ++
 tools/testing/selftests/arm64/bti/system.c    |  22 ++
 tools/testing/selftests/arm64/bti/system.h    |  28 +++
 tools/testing/selftests/arm64/bti/test.c      | 234 ++++++++++++++++++
 tools/testing/selftests/arm64/bti/teststubs.S |  39 +++
 .../testing/selftests/arm64/bti/trampoline.S  |  29 +++
 16 files changed, 637 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/bti/.gitignore
 create mode 100644 tools/testing/selftests/arm64/bti/Makefile
 create mode 100644 tools/testing/selftests/arm64/bti/assembler.h
 create mode 100644 tools/testing/selftests/arm64/bti/btitest.h
 create mode 100644 tools/testing/selftests/arm64/bti/compiler.h
 create mode 100644 tools/testing/selftests/arm64/bti/gen/.gitignore
 create mode 100644 tools/testing/selftests/arm64/bti/signal.c
 create mode 100644 tools/testing/selftests/arm64/bti/signal.h
 create mode 100644 tools/testing/selftests/arm64/bti/start.S
 create mode 100644 tools/testing/selftests/arm64/bti/syscall.S
 create mode 100644 tools/testing/selftests/arm64/bti/system.c
 create mode 100644 tools/testing/selftests/arm64/bti/system.h
 create mode 100644 tools/testing/selftests/arm64/bti/test.c
 create mode 100644 tools/testing/selftests/arm64/bti/teststubs.S
 create mode 100644 tools/testing/selftests/arm64/bti/trampoline.S

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 2c9d012797a7..ced910fb4019 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte
+ARM64_SUBTARGETS ?= tags signal pauth fp mte bti
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/bti/.gitignore b/tools/testing/selftests/arm64/bti/.gitignore
new file mode 100644
index 000000000000..73869fabada4
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/.gitignore
@@ -0,0 +1,2 @@
+btitest
+nobtitest
diff --git a/tools/testing/selftests/arm64/bti/Makefile b/tools/testing/selftests/arm64/bti/Makefile
new file mode 100644
index 000000000000..73e013c082a6
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/Makefile
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := btitest nobtitest
+
+PROGS := $(patsubst %,gen/%,$(TEST_GEN_PROGS))
+
+# These tests are built as freestanding binaries since otherwise BTI
+# support in ld.so is required which is not currently widespread; when
+# it is available it will still be useful to test this separately as the
+# cases for statically linked and dynamically lined binaries are
+# slightly different.
+
+CFLAGS_NOBTI = -DBTI=0
+CFLAGS_BTI = -mbranch-protection=standard -DBTI=1
+
+CFLAGS_COMMON = -ffreestanding -Wall -Wextra $(CFLAGS)
+
+BTI_CC_COMMAND = $(CC) $(CFLAGS_BTI) $(CFLAGS_COMMON) -c -o $@ $<
+NOBTI_CC_COMMAND = $(CC) $(CFLAGS_NOBTI) $(CFLAGS_COMMON) -c -o $@ $<
+
+%-bti.o: %.c
+	$(BTI_CC_COMMAND)
+
+%-bti.o: %.S
+	$(BTI_CC_COMMAND)
+
+%-nobti.o: %.c
+	$(NOBTI_CC_COMMAND)
+
+%-nobti.o: %.S
+	$(NOBTI_CC_COMMAND)
+
+BTI_OBJS =                                      \
+	test-bti.o                           \
+	signal-bti.o                            \
+	start-bti.o                             \
+	syscall-bti.o                           \
+	system-bti.o                            \
+	teststubs-bti.o                         \
+	trampoline-bti.o
+gen/btitest: $(BTI_OBJS)
+	$(CC) $(CFLAGS_BTI) $(CFLAGS_COMMON) -nostdlib -o $@ $^
+
+NOBTI_OBJS =                                    \
+	test-nobti.o                         \
+	signal-nobti.o                          \
+	start-nobti.o                           \
+	syscall-nobti.o                         \
+	system-nobti.o                          \
+	teststubs-nobti.o                       \
+	trampoline-nobti.o
+gen/nobtitest: $(NOBTI_OBJS)
+	$(CC) $(CFLAGS_BTI) $(CFLAGS_COMMON) -nostdlib -o $@ $^
+
+# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
+# to account for any OUTPUT target-dirs optionally provided by
+# the toplevel makefile
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): $(PROGS)
+	cp $(PROGS) $(OUTPUT)/
diff --git a/tools/testing/selftests/arm64/bti/assembler.h b/tools/testing/selftests/arm64/bti/assembler.h
new file mode 100644
index 000000000000..04e7b72880ef
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/assembler.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#ifndef ASSEMBLER_H
+#define ASSEMBLER_H
+
+#define NT_GNU_PROPERTY_TYPE_0	5
+#define GNU_PROPERTY_AARCH64_FEATURE_1_AND	0xc0000000
+
+/* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
+#define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
+#define GNU_PROPERTY_AARCH64_FEATURE_1_PAC	(1U << 1)
+
+
+.macro startfn name:req
+	.globl \name
+\name:
+	.macro endfn
+		.size \name, . - \name
+		.type \name, @function
+		.purgem endfn
+	.endm
+.endm
+
+.macro emit_aarch64_feature_1_and
+	.pushsection .note.gnu.property, "a"
+	.align	3
+	.long	2f - 1f
+	.long	6f - 3f
+	.long	NT_GNU_PROPERTY_TYPE_0
+1:	.string	"GNU"
+2:
+	.align	3
+3:	.long	GNU_PROPERTY_AARCH64_FEATURE_1_AND
+	.long	5f - 4f
+4:
+#if BTI
+	.long	GNU_PROPERTY_AARCH64_FEATURE_1_PAC | \
+		GNU_PROPERTY_AARCH64_FEATURE_1_BTI
+#else
+	.long	0
+#endif
+5:
+	.align	3
+6:
+	.popsection
+.endm
+
+.macro paciasp
+	hint	0x19
+.endm
+
+.macro autiasp
+	hint	0x1d
+.endm
+
+.macro __bti_
+	hint	0x20
+.endm
+
+.macro __bti_c
+	hint	0x22
+.endm
+
+.macro __bti_j
+	hint	0x24
+.endm
+
+.macro __bti_jc
+	hint	0x26
+.endm
+
+.macro bti what=
+	__bti_\what
+.endm
+
+#endif /* ! ASSEMBLER_H */
diff --git a/tools/testing/selftests/arm64/bti/btitest.h b/tools/testing/selftests/arm64/bti/btitest.h
new file mode 100644
index 000000000000..2aff9b10336e
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/btitest.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#ifndef BTITEST_H
+#define BTITEST_H
+
+/* Trampolines for calling the test stubs: */
+void call_using_br_x0(void (*)(void));
+void call_using_br_x16(void (*)(void));
+void call_using_blr(void (*)(void));
+
+/* Test stubs: */
+void nohint_func(void);
+void bti_none_func(void);
+void bti_c_func(void);
+void bti_j_func(void);
+void bti_jc_func(void);
+void paciasp_func(void);
+
+#endif /* !BTITEST_H */
diff --git a/tools/testing/selftests/arm64/bti/compiler.h b/tools/testing/selftests/arm64/bti/compiler.h
new file mode 100644
index 000000000000..ebb6204f447a
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/compiler.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#ifndef COMPILER_H
+#define COMPILER_H
+
+#define __always_unused __attribute__((__unused__))
+#define __noreturn __attribute__((__noreturn__))
+#define __unreachable() __builtin_unreachable()
+
+/* curse(e) has value e, but the compiler cannot assume so */
+#define curse(e) ({				\
+	__typeof__(e) __curse_e = (e);		\
+	asm ("" : "+r" (__curse_e));		\
+	__curse_e;				\
+})
+
+#endif /* ! COMPILER_H */
diff --git a/tools/testing/selftests/arm64/bti/gen/.gitignore b/tools/testing/selftests/arm64/bti/gen/.gitignore
new file mode 100644
index 000000000000..73869fabada4
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/gen/.gitignore
@@ -0,0 +1,2 @@
+btitest
+nobtitest
diff --git a/tools/testing/selftests/arm64/bti/signal.c b/tools/testing/selftests/arm64/bti/signal.c
new file mode 100644
index 000000000000..f3fd29b91141
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/signal.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#include "system.h"
+#include "signal.h"
+
+int sigemptyset(sigset_t *s)
+{
+	unsigned int i;
+
+	for (i = 0; i < _NSIG_WORDS; ++i)
+		s->sig[i] = 0;
+
+	return 0;
+}
+
+int sigaddset(sigset_t *s, int n)
+{
+	if (n < 1 || n > _NSIG)
+		return -EINVAL;
+
+	s->sig[(n - 1) / _NSIG_BPW] |= 1UL << (n - 1) % _NSIG_BPW;
+	return 0;
+}
+
+int sigaction(int n, struct sigaction *sa, const struct sigaction *old)
+{
+	return syscall(__NR_rt_sigaction, n, sa, old, sizeof(sa->sa_mask));
+}
+
+int sigprocmask(int how, const sigset_t *mask, sigset_t *old)
+{
+	return syscall(__NR_rt_sigprocmask, how, mask, old, sizeof(*mask));
+}
diff --git a/tools/testing/selftests/arm64/bti/signal.h b/tools/testing/selftests/arm64/bti/signal.h
new file mode 100644
index 000000000000..103457dc880e
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/signal.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#ifndef SIGNAL_H
+#define SIGNAL_H
+
+#include <linux/signal.h>
+
+#include "system.h"
+
+typedef __sighandler_t sighandler_t;
+
+int sigemptyset(sigset_t *s);
+int sigaddset(sigset_t *s, int n);
+int sigaction(int n, struct sigaction *sa, const struct sigaction *old);
+int sigprocmask(int how, const sigset_t *mask, sigset_t *old);
+
+#endif /* ! SIGNAL_H */
diff --git a/tools/testing/selftests/arm64/bti/start.S b/tools/testing/selftests/arm64/bti/start.S
new file mode 100644
index 000000000000..831f952e0572
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/start.S
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#include "assembler.h"
+
+startfn _start
+	mov	x0, sp
+	b	start
+endfn
+
+emit_aarch64_feature_1_and
diff --git a/tools/testing/selftests/arm64/bti/syscall.S b/tools/testing/selftests/arm64/bti/syscall.S
new file mode 100644
index 000000000000..8dde8b6f3db1
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/syscall.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#include "assembler.h"
+
+startfn syscall
+	bti	c
+	mov	w8, w0
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	mov	x3, x4
+	mov	x4, x5
+	mov	x5, x6
+	mov	x6, x7
+	svc	#0
+	ret
+endfn
+
+emit_aarch64_feature_1_and
diff --git a/tools/testing/selftests/arm64/bti/system.c b/tools/testing/selftests/arm64/bti/system.c
new file mode 100644
index 000000000000..6385d8d4973b
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/system.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#include "system.h"
+
+#include <asm/unistd.h>
+
+#include "compiler.h"
+
+void __noreturn exit(int n)
+{
+	syscall(__NR_exit, n);
+	__unreachable();
+}
+
+ssize_t write(int fd, const void *buf, size_t size)
+{
+	return syscall(__NR_write, fd, buf, size);
+}
diff --git a/tools/testing/selftests/arm64/bti/system.h b/tools/testing/selftests/arm64/bti/system.h
new file mode 100644
index 000000000000..aca118589705
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/system.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#ifndef SYSTEM_H
+#define SYSTEM_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+
+typedef __kernel_size_t size_t;
+typedef __kernel_ssize_t ssize_t;
+
+#include <linux/errno.h>
+#include <asm/hwcap.h>
+#include <asm/ptrace.h>
+#include <asm/unistd.h>
+
+#include "compiler.h"
+
+long syscall(int nr, ...);
+
+void __noreturn exit(int n);
+ssize_t write(int fd, const void *buf, size_t size);
+
+#endif /* ! SYSTEM_H */
diff --git a/tools/testing/selftests/arm64/bti/test.c b/tools/testing/selftests/arm64/bti/test.c
new file mode 100644
index 000000000000..656b04976ccc
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/test.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019,2021  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#include "system.h"
+
+#include <linux/errno.h>
+#include <linux/auxvec.h>
+#include <linux/signal.h>
+#include <asm/sigcontext.h>
+#include <asm/ucontext.h>
+
+typedef struct ucontext ucontext_t;
+
+#include "btitest.h"
+#include "compiler.h"
+#include "signal.h"
+
+#define EXPECTED_TESTS 18
+
+static volatile unsigned int test_num = 1;
+static unsigned int test_passed;
+static unsigned int test_failed;
+static unsigned int test_skipped;
+
+static void fdputs(int fd, const char *str)
+{
+	size_t len = 0;
+	const char *p = str;
+
+	while (*p++)
+		++len;
+
+	write(fd, str, len);
+}
+
+static void putstr(const char *str)
+{
+	fdputs(1, str);
+}
+
+static void putnum(unsigned int num)
+{
+	char c;
+
+	if (num / 10)
+		putnum(num / 10);
+
+	c = '0' + (num % 10);
+	write(1, &c, 1);
+}
+
+#define puttestname(test_name, trampoline_name) do {	\
+	putstr(test_name);				\
+	putstr("/");					\
+	putstr(trampoline_name);			\
+} while (0)
+
+void print_summary(void)
+{
+	putstr("# Totals: pass:");
+	putnum(test_passed);
+	putstr(" fail:");
+	putnum(test_failed);
+	putstr(" xfail:0 xpass:0 skip:");
+	putnum(test_skipped);
+	putstr(" error:0\n");
+}
+
+static const char *volatile current_test_name;
+static const char *volatile current_trampoline_name;
+static volatile int sigill_expected, sigill_received;
+
+static void handler(int n, siginfo_t *si __always_unused,
+		    void *uc_ __always_unused)
+{
+	ucontext_t *uc = uc_;
+
+	putstr("# \t[SIGILL in ");
+	puttestname(current_test_name, current_trampoline_name);
+	putstr(", BTYPE=");
+	write(1, &"00011011"[((uc->uc_mcontext.pstate & PSR_BTYPE_MASK)
+			      >> PSR_BTYPE_SHIFT) * 2], 2);
+	if (!sigill_expected) {
+		putstr("]\n");
+		putstr("not ok ");
+		putnum(test_num);
+		putstr(" ");
+		puttestname(current_test_name, current_trampoline_name);
+		putstr("(unexpected SIGILL)\n");
+		print_summary();
+		exit(128 + n);
+	}
+
+	putstr(" (expected)]\n");
+	sigill_received = 1;
+	/* zap BTYPE so that resuming the faulting code will work */
+	uc->uc_mcontext.pstate &= ~PSR_BTYPE_MASK;
+}
+
+static int skip_all;
+
+static void __do_test(void (*trampoline)(void (*)(void)),
+		      void (*fn)(void),
+		      const char *trampoline_name,
+		      const char *name,
+		      int expect_sigill)
+{
+	if (skip_all) {
+		test_skipped++;
+		putstr("ok ");
+		putnum(test_num);
+		putstr(" ");
+		puttestname(name, trampoline_name);
+		putstr(" # SKIP\n");
+
+		return;
+	}
+
+	/* Branch Target exceptions should only happen in BTI binaries: */
+	if (!BTI)
+		expect_sigill = 0;
+
+	sigill_expected = expect_sigill;
+	sigill_received = 0;
+	current_test_name = name;
+	current_trampoline_name = trampoline_name;
+
+	trampoline(fn);
+
+	if (expect_sigill && !sigill_received) {
+		putstr("not ok ");
+		test_failed++;
+	} else {
+		putstr("ok ");
+		test_passed++;
+	}
+	putnum(test_num++);
+	putstr(" ");
+	puttestname(name, trampoline_name);
+	putstr("\n");
+}
+
+#define do_test(expect_sigill_br_x0,					\
+		expect_sigill_br_x16,					\
+		expect_sigill_blr,					\
+		name)							\
+do {									\
+	__do_test(call_using_br_x0, name, "call_using_br_x0", #name,	\
+		  expect_sigill_br_x0);					\
+	__do_test(call_using_br_x16, name, "call_using_br_x16", #name,	\
+		  expect_sigill_br_x16);				\
+	__do_test(call_using_blr, name, "call_using_blr", #name,	\
+		  expect_sigill_blr);					\
+} while (0)
+
+void start(int *argcp)
+{
+	struct sigaction sa;
+	void *const *p;
+	const struct auxv_entry {
+		unsigned long type;
+		unsigned long val;
+	} *auxv;
+	unsigned long hwcap = 0, hwcap2 = 0;
+
+	putstr("TAP version 13\n");
+	putstr("1..");
+	putnum(EXPECTED_TESTS);
+	putstr("\n");
+
+	/* Gross hack for finding AT_HWCAP2 from the initial process stack: */
+	p = (void *const *)argcp + 1 + *argcp + 1; /* start of environment */
+	/* step over environment */
+	while (*p++)
+		;
+	for (auxv = (const struct auxv_entry *)p; auxv->type != AT_NULL; ++auxv) {
+		switch (auxv->type) {
+		case AT_HWCAP:
+			hwcap = auxv->val;
+			break;
+		case AT_HWCAP2:
+			hwcap2 = auxv->val;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (hwcap & HWCAP_PACA)
+		putstr("# HWCAP_PACA present\n");
+	else
+		putstr("# HWCAP_PACA not present\n");
+
+	if (hwcap2 & HWCAP2_BTI) {
+		putstr("# HWCAP2_BTI present\n");
+		if (!(hwcap & HWCAP_PACA))
+			putstr("# Bad hardware?  Expect problems.\n");
+	} else {
+		putstr("# HWCAP2_BTI not present\n");
+		skip_all = 1;
+	}
+
+	putstr("# Test binary");
+	if (!BTI)
+		putstr(" not");
+	putstr(" built for BTI\n");
+
+	sa.sa_handler = (sighandler_t)(void *)handler;
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	sigaction(SIGILL, &sa, NULL);
+	sigaddset(&sa.sa_mask, SIGILL);
+	sigprocmask(SIG_UNBLOCK, &sa.sa_mask, NULL);
+
+	do_test(1, 1, 1, nohint_func);
+	do_test(1, 1, 1, bti_none_func);
+	do_test(1, 0, 0, bti_c_func);
+	do_test(0, 0, 1, bti_j_func);
+	do_test(0, 0, 0, bti_jc_func);
+	do_test(1, 0, 0, paciasp_func);
+
+	print_summary();
+
+	if (test_num - 1 != EXPECTED_TESTS)
+		putstr("# WARNING - EXPECTED TEST COUNT WRONG\n");
+
+	if (test_failed)
+		exit(1);
+	else
+		exit(0);
+}
diff --git a/tools/testing/selftests/arm64/bti/teststubs.S b/tools/testing/selftests/arm64/bti/teststubs.S
new file mode 100644
index 000000000000..b62c8c35f67e
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/teststubs.S
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#include "assembler.h"
+
+startfn bti_none_func
+	bti
+	ret
+endfn
+
+startfn bti_c_func
+	bti	c
+	ret
+endfn
+
+startfn bti_j_func
+	bti	j
+	ret
+endfn
+
+startfn bti_jc_func
+	bti	jc
+	ret
+endfn
+
+startfn paciasp_func
+	paciasp
+	autiasp
+	ret
+endfn
+
+startfn nohint_func
+	ret
+endfn
+
+emit_aarch64_feature_1_and
diff --git a/tools/testing/selftests/arm64/bti/trampoline.S b/tools/testing/selftests/arm64/bti/trampoline.S
new file mode 100644
index 000000000000..09beb3f361f1
--- /dev/null
+++ b/tools/testing/selftests/arm64/bti/trampoline.S
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019  Arm Limited
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+
+#include "assembler.h"
+
+startfn call_using_br_x0
+	bti	c
+	br	x0
+endfn
+
+startfn call_using_br_x16
+	bti	c
+	mov	x16, x0
+	br	x16
+endfn
+
+startfn call_using_blr
+	paciasp
+	stp	x29, x30, [sp, #-16]!
+	blr	x0
+	ldp	x29, x30, [sp], #16
+	autiasp
+	ret
+endfn
+
+emit_aarch64_feature_1_and
-- 
2.20.1

