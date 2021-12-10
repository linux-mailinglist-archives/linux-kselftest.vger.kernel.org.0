Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E057470913
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhLJSrb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48986 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ADF2B8294F
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9110DC341C5;
        Fri, 10 Dec 2021 18:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161833;
        bh=gbEaf/d4xRDW9ydvwFrDyfqJFyr6RLHjpn9Fx7yjnxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBiKUtNb4hys7MklhgxrO1UxrS0lMHpLo6QxJ0w8TcNZwKc9EbyV/pfD5xYrT9TSx
         Zy59Lh4N36u/bgqk3iEgmneVVmVlCAeT5R6LeQKPgb5jAUDWNMivCXQPN4nK33lTyZ
         ay6nCutGcsBPrCBkgJAMrhQdg2mrxeGq8olxaZ1V40GJiUSwkyKBTyCjqG+VSMM01e
         L5AINfc7GgNjIPP39fYiiCYS7kl/XOnkNFBI59Uk9GLi54sHinHoVGIGdRtdI2MQcR
         MLFgKYD3WvINn+bj/CmLXYxlx0M0cMcdeDWB3wssRZtSpc+IAIe89QviLiwWztqCuZ
         JBLn2C9FKBjYw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 06/37] kselftest/arm64: Add a test program to exercise the syscall ABI
Date:   Fri, 10 Dec 2021 18:41:02 +0000
Message-Id: <20211210184133.320748-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17445; h=from:subject; bh=gbEaf/d4xRDW9ydvwFrDyfqJFyr6RLHjpn9Fx7yjnxo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59CXH1lZUq5MVV9t+IR9mHsdlVUleB11AmRULUh XSgDg3qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfQgAKCRAk1otyXVSH0Mu3B/ 9t/Fp5wQRHG1iocRRIpUoW+QuWDq9N0cFMkYHtuKIWXepmeiUtvVgE8VvfW3jl9uVjL6NEsXvRZuuR 4YzMcaIHPWjMNlOXUYAgOsfFtiZvKPAkSojR9oWurs7ahM1jO1XR5k44UlFbAlL/l389sJmxNJWY4U pdF/2r/G6HeGOniVS/okS+zlQt71c5zm97wUt/JpdJb9ItrO3aDSWTRD93AkFkqcN1YkGvmFp4PfvJ PrwHv4v/2Wxkgl+oBRtbLRAjnKAbMGeO6xMmVGiczwqcHdIV4mER3ctlaveElOkONcUDchSFfyIPJ0 QqzGCoU7ETl24NNjqD0kPj6mSTHLWP
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we don't have any coverage of the syscall ABI so let's add a very
dumb test program which sets up register patterns, does a sysscall and then
checks that the register state after the syscall matches what we expect.
The program is written in an extremely simplistic fashion with the goal of
making it easy to verify that it's doing what it thinks it's doing, it is
not a model of how one should write actual code.

Currently we validate the general purpose, FPSIMD and SVE registers. There
are other thing things that could be covered like FPCR and flags registers,
these can be covered incrementally - my main focus at the minute is
covering the ABI for the SVE registers.

The program repeats the tests for all possible SVE vector lengths in case
some vector length specific optimisation causes issues, as well as testing
FPSIMD only. It tries two syscalls, getpid() and sched_yield(), in an
effort to cover both immediate return to userspace and scheduling another
task though there are no guarantees which cases will be hit.

A new test directory "abi" is added to hold the test, it doesn't seem to
fit well into any of the existing directories.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/abi/.gitignore  |   1 +
 tools/testing/selftests/arm64/abi/Makefile    |   8 +
 .../selftests/arm64/abi/syscall-abi-asm.S     | 240 +++++++++++++
 .../testing/selftests/arm64/abi/syscall-abi.c | 318 ++++++++++++++++++
 5 files changed, 568 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/abi/.gitignore
 create mode 100644 tools/testing/selftests/arm64/abi/Makefile
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi-asm.S
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.c

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index ced910fb4019..1e8d9a8f59df 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte bti
+ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/abi/.gitignore b/tools/testing/selftests/arm64/abi/.gitignore
new file mode 100644
index 000000000000..b79cf5814c23
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/.gitignore
@@ -0,0 +1 @@
+syscall-abi
diff --git a/tools/testing/selftests/arm64/abi/Makefile b/tools/testing/selftests/arm64/abi/Makefile
new file mode 100644
index 000000000000..96eba974ac8d
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+
+TEST_GEN_PROGS := syscall-abi
+
+include ../../lib.mk
+
+$(OUTPUT)/syscall-abi: syscall-abi.c syscall-abi-asm.S
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
new file mode 100644
index 000000000000..983467cfcee0
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021 ARM Limited.
+//
+// Assembly portion of the syscall ABI test
+
+//
+// Load values from memory into registers, invoke a syscall and save the
+// register values back to memory for later checking.  The syscall to be
+// invoked is configured in x8 of the input GPR data.
+//
+// x0:	SVE VL, 0 for FP only
+//
+//	GPRs:	gpr_in, gpr_out
+//	FPRs:	fpr_in, fpr_out
+//	Zn:	z_in, z_out
+//	Pn:	p_in, p_out
+//	FFR:	ffr_in, ffr_out
+
+.arch_extension sve
+
+.globl do_syscall
+do_syscall:
+	// Store callee saved registers x19-x29 (80 bytes) plus x0 and x1
+	stp	x29, x30, [sp, #-112]!
+	mov	x29, sp
+	stp	x0, x1, [sp, #16]
+	stp	x19, x20, [sp, #32]
+	stp	x21, x22, [sp, #48]
+	stp	x23, x24, [sp, #64]
+	stp	x25, x26, [sp, #80]
+	stp	x27, x28, [sp, #96]
+
+	// Load GPRs x8-x28, and save our SP/FP for later comparison
+	ldr	x2, =gpr_in
+	add	x2, x2, #64
+	ldp	x8, x9, [x2], #16
+	ldp	x10, x11, [x2], #16
+	ldp	x12, x13, [x2], #16
+	ldp	x14, x15, [x2], #16
+	ldp	x16, x17, [x2], #16
+	ldp	x18, x19, [x2], #16
+	ldp	x20, x21, [x2], #16
+	ldp	x22, x23, [x2], #16
+	ldp	x24, x25, [x2], #16
+	ldp	x26, x27, [x2], #16
+	ldr	x28, [x2], #8
+	str	x29, [x2], #8		// FP
+	str	x30, [x2], #8		// LR
+
+	// Load FPRs if we're not doing SVE
+	cbnz	x0, 1f
+	ldr	x2, =fpr_in
+	ldp	q0, q1, [x2]
+	ldp	q2, q3, [x2, #16 * 2]
+	ldp	q4, q5, [x2, #16 * 4]
+	ldp	q6, q7, [x2, #16 * 6]
+	ldp	q8, q9, [x2, #16 * 8]
+	ldp	q10, q11, [x2, #16 * 10]
+	ldp	q12, q13, [x2, #16 * 12]
+	ldp	q14, q15, [x2, #16 * 14]
+	ldp	q16, q17, [x2, #16 * 16]
+	ldp	q18, q19, [x2, #16 * 18]
+	ldp	q20, q21, [x2, #16 * 20]
+	ldp	q22, q23, [x2, #16 * 22]
+	ldp	q24, q25, [x2, #16 * 24]
+	ldp	q26, q27, [x2, #16 * 26]
+	ldp	q28, q29, [x2, #16 * 28]
+	ldp	q30, q31, [x2, #16 * 30]
+1:
+
+	// Load the SVE registers if we're doing SVE
+	cbz	x0, 1f
+
+	ldr	x2, =z_in
+	ldr	z0, [x2, #0, MUL VL]
+	ldr	z1, [x2, #1, MUL VL]
+	ldr	z2, [x2, #2, MUL VL]
+	ldr	z3, [x2, #3, MUL VL]
+	ldr	z4, [x2, #4, MUL VL]
+	ldr	z5, [x2, #5, MUL VL]
+	ldr	z6, [x2, #6, MUL VL]
+	ldr	z7, [x2, #7, MUL VL]
+	ldr	z8, [x2, #8, MUL VL]
+	ldr	z9, [x2, #9, MUL VL]
+	ldr	z10, [x2, #10, MUL VL]
+	ldr	z11, [x2, #11, MUL VL]
+	ldr	z12, [x2, #12, MUL VL]
+	ldr	z13, [x2, #13, MUL VL]
+	ldr	z14, [x2, #14, MUL VL]
+	ldr	z15, [x2, #15, MUL VL]
+	ldr	z16, [x2, #16, MUL VL]
+	ldr	z17, [x2, #17, MUL VL]
+	ldr	z18, [x2, #18, MUL VL]
+	ldr	z19, [x2, #19, MUL VL]
+	ldr	z20, [x2, #20, MUL VL]
+	ldr	z21, [x2, #21, MUL VL]
+	ldr	z22, [x2, #22, MUL VL]
+	ldr	z23, [x2, #23, MUL VL]
+	ldr	z24, [x2, #24, MUL VL]
+	ldr	z25, [x2, #25, MUL VL]
+	ldr	z26, [x2, #26, MUL VL]
+	ldr	z27, [x2, #27, MUL VL]
+	ldr	z28, [x2, #28, MUL VL]
+	ldr	z29, [x2, #29, MUL VL]
+	ldr	z30, [x2, #30, MUL VL]
+	ldr	z31, [x2, #31, MUL VL]
+
+	ldr	x2, =ffr_in
+	ldr	p0, [x2, #0]
+	wrffr	p0.b
+
+	ldr	x2, =p_in
+	ldr	p0, [x2, #0, MUL VL]
+	ldr	p1, [x2, #1, MUL VL]
+	ldr	p2, [x2, #2, MUL VL]
+	ldr	p3, [x2, #3, MUL VL]
+	ldr	p4, [x2, #4, MUL VL]
+	ldr	p5, [x2, #5, MUL VL]
+	ldr	p6, [x2, #6, MUL VL]
+	ldr	p7, [x2, #7, MUL VL]
+	ldr	p8, [x2, #8, MUL VL]
+	ldr	p9, [x2, #9, MUL VL]
+	ldr	p10, [x2, #10, MUL VL]
+	ldr	p11, [x2, #11, MUL VL]
+	ldr	p12, [x2, #12, MUL VL]
+	ldr	p13, [x2, #13, MUL VL]
+	ldr	p14, [x2, #14, MUL VL]
+	ldr	p15, [x2, #15, MUL VL]
+1:
+
+	// Do the syscall
+	svc	#0
+
+	// Save GPRs x8-x30
+	ldr	x2, =gpr_out
+	add	x2, x2, #64
+	stp	x8, x9, [x2], #16
+	stp	x10, x11, [x2], #16
+	stp	x12, x13, [x2], #16
+	stp	x14, x15, [x2], #16
+	stp	x16, x17, [x2], #16
+	stp	x18, x19, [x2], #16
+	stp	x20, x21, [x2], #16
+	stp	x22, x23, [x2], #16
+	stp	x24, x25, [x2], #16
+	stp	x26, x27, [x2], #16
+	stp	x28, x29, [x2], #16
+	str	x30, [x2]
+
+	// Restore x0 and x1 for feature checks
+	ldp	x0, x1, [sp, #16]
+
+	// Save FPSIMD state
+	ldr	x2, =fpr_out
+	stp	q0, q1, [x2]
+	stp	q2, q3, [x2, #16 * 2]
+	stp	q4, q5, [x2, #16 * 4]
+	stp	q6, q7, [x2, #16 * 6]
+	stp	q8, q9, [x2, #16 * 8]
+	stp	q10, q11, [x2, #16 * 10]
+	stp	q12, q13, [x2, #16 * 12]
+	stp	q14, q15, [x2, #16 * 14]
+	stp	q16, q17, [x2, #16 * 16]
+	stp	q18, q19, [x2, #16 * 18]
+	stp	q20, q21, [x2, #16 * 20]
+	stp	q22, q23, [x2, #16 * 22]
+	stp	q24, q25, [x2, #16 * 24]
+	stp	q26, q27, [x2, #16 * 26]
+	stp	q28, q29, [x2, #16 * 28]
+	stp	q30, q31, [x2, #16 * 30]
+
+	// Save the SVE state if we have some
+	cbz	x0, 1f
+
+	ldr	x2, =z_out
+	str	z0, [x2, #0, MUL VL]
+	str	z1, [x2, #1, MUL VL]
+	str	z2, [x2, #2, MUL VL]
+	str	z3, [x2, #3, MUL VL]
+	str	z4, [x2, #4, MUL VL]
+	str	z5, [x2, #5, MUL VL]
+	str	z6, [x2, #6, MUL VL]
+	str	z7, [x2, #7, MUL VL]
+	str	z8, [x2, #8, MUL VL]
+	str	z9, [x2, #9, MUL VL]
+	str	z10, [x2, #10, MUL VL]
+	str	z11, [x2, #11, MUL VL]
+	str	z12, [x2, #12, MUL VL]
+	str	z13, [x2, #13, MUL VL]
+	str	z14, [x2, #14, MUL VL]
+	str	z15, [x2, #15, MUL VL]
+	str	z16, [x2, #16, MUL VL]
+	str	z17, [x2, #17, MUL VL]
+	str	z18, [x2, #18, MUL VL]
+	str	z19, [x2, #19, MUL VL]
+	str	z20, [x2, #20, MUL VL]
+	str	z21, [x2, #21, MUL VL]
+	str	z22, [x2, #22, MUL VL]
+	str	z23, [x2, #23, MUL VL]
+	str	z24, [x2, #24, MUL VL]
+	str	z25, [x2, #25, MUL VL]
+	str	z26, [x2, #26, MUL VL]
+	str	z27, [x2, #27, MUL VL]
+	str	z28, [x2, #28, MUL VL]
+	str	z29, [x2, #29, MUL VL]
+	str	z30, [x2, #30, MUL VL]
+	str	z31, [x2, #31, MUL VL]
+
+	ldr	x2, =p_out
+	str	p0, [x2, #0, MUL VL]
+	str	p1, [x2, #1, MUL VL]
+	str	p2, [x2, #2, MUL VL]
+	str	p3, [x2, #3, MUL VL]
+	str	p4, [x2, #4, MUL VL]
+	str	p5, [x2, #5, MUL VL]
+	str	p6, [x2, #6, MUL VL]
+	str	p7, [x2, #7, MUL VL]
+	str	p8, [x2, #8, MUL VL]
+	str	p9, [x2, #9, MUL VL]
+	str	p10, [x2, #10, MUL VL]
+	str	p11, [x2, #11, MUL VL]
+	str	p12, [x2, #12, MUL VL]
+	str	p13, [x2, #13, MUL VL]
+	str	p14, [x2, #14, MUL VL]
+	str	p15, [x2, #15, MUL VL]
+
+	ldr	x2, =ffr_out
+	rdffr	p0.b
+	str	p0, [x2, #0]
+1:
+
+	// Restore callee saved registers x19-x30
+	ldp	x19, x20, [sp, #32]
+	ldp	x21, x22, [sp, #48]
+	ldp	x23, x24, [sp, #64]
+	ldp	x25, x26, [sp, #80]
+	ldp	x27, x28, [sp, #96]
+	ldp	x29, x30, [sp], #112
+
+	ret
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
new file mode 100644
index 000000000000..d8eeeafb50dc
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 ARM Limited.
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <asm/hwcap.h>
+#include <asm/sigcontext.h>
+#include <asm/unistd.h>
+
+#include "../../kselftest.h"
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
+#define NUM_VL ((SVE_VQ_MAX - SVE_VQ_MIN) + 1)
+
+extern void do_syscall(int sve_vl);
+
+static void fill_random(void *buf, size_t size)
+{
+	int i;
+	uint32_t *lbuf = buf;
+
+	/* random() returns a 32 bit number regardless of the size of long */
+	for (i = 0; i < size / sizeof(uint32_t); i++)
+		lbuf[i] = random();
+}
+
+/*
+ * We also repeat the test for several syscalls to try to expose different
+ * behaviour.
+ */
+static struct syscall_cfg {
+	int syscall_nr;
+	const char *name;
+} syscalls[] = {
+	{ __NR_getpid,		"getpid()" },
+	{ __NR_sched_yield,	"sched_yield()" },
+};
+
+#define NUM_GPR 31
+uint64_t gpr_in[NUM_GPR];
+uint64_t gpr_out[NUM_GPR];
+
+static void setup_gpr(struct syscall_cfg *cfg, int sve_vl)
+{
+	fill_random(gpr_in, sizeof(gpr_in));
+	gpr_in[8] = cfg->syscall_nr;
+	memset(gpr_out, 0, sizeof(gpr_out));
+}
+
+static int check_gpr(struct syscall_cfg *cfg, int sve_vl)
+{
+	int errors = 0;
+	int i;
+
+	/*
+	 * GPR x0-x7 may be clobbered, and all others should be preserved.
+	 */
+	for (i = 9; i < ARRAY_SIZE(gpr_in); i++) {
+		if (gpr_in[i] != gpr_out[i]) {
+			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %llx != %llx\n",
+				       cfg->name, sve_vl, i,
+				       gpr_in[i], gpr_out[i]);
+			errors++;
+		}
+	}
+
+	return errors;
+}
+
+#define NUM_FPR 32
+uint64_t fpr_in[NUM_FPR * 2];
+uint64_t fpr_out[NUM_FPR * 2];
+
+static void setup_fpr(struct syscall_cfg *cfg, int sve_vl)
+{
+	fill_random(fpr_in, sizeof(fpr_in));
+	memset(fpr_out, 0, sizeof(fpr_out));
+}
+
+static int check_fpr(struct syscall_cfg *cfg, int sve_vl)
+{
+	int errors = 0;
+	int i;
+
+	if (!sve_vl) {
+		for (i = 0; i < ARRAY_SIZE(fpr_in); i++) {
+			if (fpr_in[i] != fpr_out[i]) {
+				ksft_print_msg("%s Q%d/%d mismatch %llx != %llx\n",
+					       cfg->name,
+					       i / 2, i % 2,
+					       fpr_in[i], fpr_out[i]);
+				errors++;
+			}
+		}
+	}
+
+	return errors;
+}
+
+static uint8_t z_zero[__SVE_ZREG_SIZE(SVE_VQ_MAX)];
+uint8_t z_in[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+uint8_t z_out[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+
+static void setup_z(struct syscall_cfg *cfg, int sve_vl)
+{
+	fill_random(z_in, sizeof(z_in));
+	fill_random(z_out, sizeof(z_out));
+}
+
+static int check_z(struct syscall_cfg *cfg, int sve_vl)
+{
+	size_t reg_size = sve_vl;
+	int errors = 0;
+	int i;
+
+	if (!sve_vl)
+		return 0;
+
+	/*
+	 * After a syscall the low 128 bits of the Z registers should
+	 * be preserved and the rest be zeroed or preserved.
+	 */
+	for (i = 0; i < SVE_NUM_ZREGS; i++) {
+		void *in = &z_in[reg_size * i];
+		void *out = &z_out[reg_size * i];
+
+		if (memcmp(in, out, SVE_VQ_BYTES) != 0) {
+			ksft_print_msg("%s SVE VL %d Z%d low 128 bits changed\n",
+				       cfg->name, sve_vl, i);
+			errors++;
+		}
+	}
+
+	return errors;
+}
+
+uint8_t p_in[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
+uint8_t p_out[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
+
+static void setup_p(struct syscall_cfg *cfg, int sve_vl)
+{
+	fill_random(p_in, sizeof(p_in));
+	fill_random(p_out, sizeof(p_out));
+}
+
+static int check_p(struct syscall_cfg *cfg, int sve_vl)
+{
+	size_t reg_size = sve_vq_from_vl(sve_vl) * 2; /* 1 bit per VL byte */
+
+	int errors = 0;
+	int i;
+
+	if (!sve_vl)
+		return 0;
+
+	/* After a syscall the P registers should be preserved or zeroed */
+	for (i = 0; i < SVE_NUM_PREGS * reg_size; i++)
+		if (p_out[i] && (p_in[i] != p_out[i]))
+			errors++;
+	if (errors)
+		ksft_print_msg("%s SVE VL %d predicate registers non-zero\n",
+			       cfg->name, sve_vl);
+
+	return errors;
+}
+
+uint8_t ffr_in[__SVE_PREG_SIZE(SVE_VQ_MAX)];
+uint8_t ffr_out[__SVE_PREG_SIZE(SVE_VQ_MAX)];
+
+static void setup_ffr(struct syscall_cfg *cfg, int sve_vl)
+{
+	/*
+	 * It is only valid to set a contiguous set of bits starting
+	 * at 0.  For now since we're expecting this to be cleared by
+	 * a syscall just set all bits.
+	 */
+	memset(ffr_in, 0xff, sizeof(ffr_in));
+	fill_random(ffr_out, sizeof(ffr_out));
+}
+
+static int check_ffr(struct syscall_cfg *cfg, int sve_vl)
+{
+	size_t reg_size = sve_vq_from_vl(sve_vl) * 2;  /* 1 bit per VL byte */
+	int errors = 0;
+	int i;
+
+	if (!sve_vl)
+		return 0;
+
+	/* After a syscall the P registers should be preserved or zeroed */
+	for (i = 0; i < reg_size; i++)
+		if (ffr_out[i] && (ffr_in[i] != ffr_out[i]))
+			errors++;
+	if (errors)
+		ksft_print_msg("%s SVE VL %d FFR non-zero\n",
+			       cfg->name, sve_vl);
+
+	return errors;
+}
+
+typedef void (*setup_fn)(struct syscall_cfg *cfg, int sve_vl);
+typedef int (*check_fn)(struct syscall_cfg *cfg, int sve_vl);
+
+/*
+ * Each set of registers has a setup function which is called before
+ * the syscall to fill values in a global variable for loading by the
+ * test code and a check function which validates that the results are
+ * as expected.  Vector lengths are passed everywhere, a vector length
+ * of 0 should be treated as do not test.
+ */
+static struct {
+	setup_fn setup;
+	check_fn check;
+} regset[] = {
+	{ setup_gpr, check_gpr },
+	{ setup_fpr, check_fpr },
+	{ setup_z, check_z },
+	{ setup_p, check_p },
+	{ setup_ffr, check_ffr },
+};
+
+static bool do_test(struct syscall_cfg *cfg, int sve_vl)
+{
+	int errors = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(regset); i++)
+		regset[i].setup(cfg, sve_vl);
+
+	do_syscall(sve_vl);
+
+	for (i = 0; i < ARRAY_SIZE(regset); i++)
+		errors += regset[i].check(cfg, sve_vl);
+
+	return errors == 0;
+}
+
+static void test_one_syscall(struct syscall_cfg *cfg)
+{
+	int sve_vq, sve_vl;
+
+	/* FPSIMD only case */
+	ksft_test_result(do_test(cfg, 0),
+			 "%s FPSIMD\n", cfg->name);
+
+	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
+		return;
+
+	for (sve_vq = SVE_VQ_MAX; sve_vq > 0; --sve_vq) {
+		sve_vl = prctl(PR_SVE_SET_VL, sve_vq * 16);
+		if (sve_vl == -1)
+			ksft_exit_fail_msg("PR_SVE_SET_VL failed: %s (%d)\n",
+					   strerror(errno), errno);
+
+		sve_vl &= PR_SVE_VL_LEN_MASK;
+
+		if (sve_vq != sve_vq_from_vl(sve_vl))
+			sve_vq = sve_vq_from_vl(sve_vl);
+
+		ksft_test_result(do_test(cfg, sve_vl),
+				 "%s SVE VL %d\n", cfg->name, sve_vl);
+	}
+}
+
+int sve_count_vls(void)
+{
+	unsigned int vq;
+	int vl_count = 0;
+	int vl;
+
+	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
+		return 0;
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(PR_SVE_SET_VL, vq * 16);
+		if (vl == -1)
+			ksft_exit_fail_msg("PR_SVE_SET_VL failed: %s (%d)\n",
+					   strerror(errno), errno);
+
+		vl &= PR_SVE_VL_LEN_MASK;
+
+		if (vq != sve_vq_from_vl(vl))
+			vq = sve_vq_from_vl(vl);
+
+		vl_count++;
+	}
+
+	return vl_count;
+}
+
+int main(void)
+{
+	int i;
+
+	srandom(getpid());
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(syscalls) * (sve_count_vls() + 1));
+
+	for (i = 0; i < ARRAY_SIZE(syscalls); i++)
+		test_one_syscall(&syscalls[i]);
+
+	ksft_print_cnts();
+
+	return 0;
+}
-- 
2.30.2

