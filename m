Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7241E0E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353377AbhI3STC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3STC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:19:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71CD561994;
        Thu, 30 Sep 2021 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025839;
        bh=Dil6VzIBZYHTDWa8kusgF1OLbs/X1RkDlWbzSD58Rbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ol5i+6Vfzy9lzQ9xHRxK9bKeYNLwSdG1LV4k0nRswUbK4c0g72TWBqUrAHotIQPvF
         W/L5Dc8Vtcx6oOmpmVG55/WUiHa+YRxw7C/7qrpBrFZ2CX3Q/x3yw7h2YV2Y2Jx4gC
         JNyJQb4i6u94RQZzISM1SXBxyT3nBvk5STVtKLeSkdEXCqxDw54ERGahojVinQI76v
         cgaGAAuhi05US4MSaMO1N6NO3P2l+IGlC8MsR4S1/LhYPxW6uT+UAEdmB/KKTs8pRX
         g72xOitzseSny+reqpVos0D4H1EzETltIs1vdC1n57gMDB9jkFEQDJW7L4/eLCZXCm
         xYPRPmOI9yJKA==
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
Subject: [PATCH v1 35/38] kselftest/arm64: Add stress test for SME ZA context switching
Date:   Thu, 30 Sep 2021 19:11:41 +0100
Message-Id: <20210930181144.10029-36-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13977; h=from:subject; bh=Dil6VzIBZYHTDWa8kusgF1OLbs/X1RkDlWbzSD58Rbk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3d3eA8MJHGeH87dBiAk4g5C4KX/wUFfJWafE/6 f7pivHeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX93QAKCRAk1otyXVSH0AblB/ 9PX69/y1ZNXF/rvZyJ0RE42kNZf5KmF5p/AxzD3GNXiFqMu/+qFBSUCowfARpWoLa0RovfU8Epjrw6 4mUXEb8XJBZCQeKeQ6xO+/F0QmqJpvncudf+fMWf5jo4WXmYh4xE98Ws64992WjSkaNGePpRMo0wh5 vgApTb8jVP3uRD10pQsvmwxk+2eLYw6wsjmpTIh39zXFyz1eH7EXNRSDS0AhxC2h+z5mdkUuB16K/B 93mCvSk+rkaojLs1dqkN/Jo77ZJIDNW1TdZvclPhbcyvhkm+Sn35BUssESarF2hfT5a51GM0guCZQ+ alfo+akzwcKYkGyQWrfsypqFt6GP5E
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a stress test for context switching of the ZA register state based on
the similar tests Dave Martin wrote for FPSIMD and SVE registers. The test
loops indefinitely writing a data pattern to ZA then reading it back and
verifying that it's what was expected.

Unlike the other tests we manually assemble the SME instructions since at
present no released toolchain has SME support integrated.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore |   1 +
 tools/testing/selftests/arm64/fp/Makefile   |   3 +
 tools/testing/selftests/arm64/fp/za-stress  |  59 +++
 tools/testing/selftests/arm64/fp/za-test.S  | 545 ++++++++++++++++++++
 4 files changed, 608 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/za-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-test.S

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 73c600e1ab81..1178fecc7aa1 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -7,3 +7,4 @@ sve-test
 ssve-test
 vec-syscfg
 vlset
+za-test
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 11dbe05c5070..4f32cb1041a0 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -6,6 +6,7 @@ TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
 	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
 	ssve-test ssve-stress \
+	za-test za-stress \
 	vlset
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
@@ -22,5 +23,7 @@ ssve-test: sve-test.S
 	$(CC) -DSSVE -nostdlib $^ -o $@
 vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
+za-test: za-test.o
+	$(CC) -nostdlib $^ -o $@
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/fp/za-stress b/tools/testing/selftests/arm64/fp/za-stress
new file mode 100644
index 000000000000..5ac386b55b95
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/za-stress
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2015-2019 ARM Limited.
+# Original author: Dave Martin <Dave.Martin@arm.com>
+
+set -ue
+
+NR_CPUS=`nproc`
+
+pids=
+logs=
+
+cleanup () {
+	trap - INT TERM CHLD
+	set +e
+
+	if [ -n "$pids" ]; then
+		kill $pids
+		wait $pids
+		pids=
+	fi
+
+	if [ -n "$logs" ]; then
+		cat $logs
+		rm $logs
+		logs=
+	fi
+}
+
+interrupt () {
+	cleanup
+	exit 0
+}
+
+child_died () {
+	cleanup
+	exit 1
+}
+
+trap interrupt INT TERM EXIT
+
+for x in `seq 0 $((NR_CPUS * 4))`; do
+	log=`mktemp`
+	logs=$logs\ $log
+	./za-test >$log &
+	pids=$pids\ $!
+done
+
+# Wait for all child processes to be created:
+sleep 10
+
+while :; do
+	kill -USR1 $pids
+done &
+pids=$pids\ $!
+
+wait
+
+exit 1
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
new file mode 100644
index 000000000000..b9e0e2e07dad
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021 ARM Limited.
+// Original author: Mark Brown <broonie@kernel.org>
+//
+// Scalable Matrix Extension ZA context switch test
+// Repeatedly writes unique test patterns into each ZA tile
+// and reads them back to verify integrity.
+//
+// for x in `seq 1 NR_CPUS`; do sve-test & pids=$pids\ $! ; done
+// (leave it running for as long as you want...)
+// kill $pids
+
+#include <asm/unistd.h>
+#include "assembler.h"
+#include "asm-offsets.h"
+
+.arch_extension sve
+
+#define MAXVL     2048
+#define MAXVL_B   (MAXVL / 8)
+
+/*
+ * LDR (vector to ZA array):
+ *	LDR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _ldr_za nw, nxbase, offset=0
+	.inst	0xe1000000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+/*
+ * STR (vector from ZA array):
+ *	STR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _str_za nw, nxbase, offset=0
+	.inst	0xe1200000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+// Print a single character x0 to stdout
+// Clobbers x0-x2,x8
+function putc
+	str	x0, [sp, #-16]!
+
+	mov	x0, #1			// STDOUT_FILENO
+	mov	x1, sp
+	mov	x2, #1
+	mov	x8, #__NR_write
+	svc	#0
+
+	add	sp, sp, #16
+	ret
+endfunction
+
+// Print a NUL-terminated string starting at address x0 to stdout
+// Clobbers x0-x3,x8
+function puts
+	mov	x1, x0
+
+	mov	x2, #0
+0:	ldrb	w3, [x0], #1
+	cbz	w3, 1f
+	add	x2, x2, #1
+	b	0b
+
+1:	mov	w0, #1			// STDOUT_FILENO
+	mov	x8, #__NR_write
+	svc	#0
+
+	ret
+endfunction
+
+// Utility macro to print a literal string
+// Clobbers x0-x4,x8
+.macro puts string
+	.pushsection .rodata.str1.1, "aMS", 1
+.L__puts_literal\@: .string "\string"
+	.popsection
+
+	ldr	x0, =.L__puts_literal\@
+	bl	puts
+.endm
+
+// Print an unsigned decimal number x0 to stdout
+// Clobbers x0-x4,x8
+function putdec
+	mov	x1, sp
+	str	x30, [sp, #-32]!	// Result can't be > 20 digits
+
+	mov	x2, #0
+	strb	w2, [x1, #-1]!		// Write the NUL terminator
+
+	mov	x2, #10
+0:	udiv	x3, x0, x2		// div-mod loop to generate the digits
+	msub	x0, x3, x2, x0
+	add	w0, w0, #'0'
+	strb	w0, [x1, #-1]!
+	mov	x0, x3
+	cbnz	x3, 0b
+
+	ldrb	w0, [x1]
+	cbnz	w0, 1f
+	mov	w0, #'0'		// Print "0" for 0, not ""
+	strb	w0, [x1, #-1]!
+
+1:	mov	x0, x1
+	bl	puts
+
+	ldr	x30, [sp], #32
+	ret
+endfunction
+
+// Print an unsigned decimal number x0 to stdout, followed by a newline
+// Clobbers x0-x5,x8
+function putdecn
+	mov	x5, x30
+
+	bl	putdec
+	mov	x0, #'\n'
+	bl	putc
+
+	ret	x5
+endfunction
+
+// Clobbers x0-x3,x8
+function puthexb
+	str	x30, [sp, #-0x10]!
+
+	mov	w3, w0
+	lsr	w0, w0, #4
+	bl	puthexnibble
+	mov	w0, w3
+
+	ldr	x30, [sp], #0x10
+	// fall through to puthexnibble
+endfunction
+// Clobbers x0-x2,x8
+function puthexnibble
+	and	w0, w0, #0xf
+	cmp	w0, #10
+	blo	1f
+	add	w0, w0, #'a' - ('9' + 1)
+1:	add	w0, w0, #'0'
+	b	putc
+endfunction
+
+// x0=data in, x1=size in, clobbers x0-x5,x8
+function dumphex
+	str	x30, [sp, #-0x10]!
+
+	mov	x4, x0
+	mov	x5, x1
+
+0:	subs	x5, x5, #1
+	b.lo	1f
+	ldrb	w0, [x4], #1
+	bl	puthexb
+	b	0b
+
+1:	ldr	x30, [sp], #0x10
+	ret
+endfunction
+
+// Declare some storage space to shadow ZA register contents and a
+// scratch buffer for a vector.
+.pushsection .text
+.data
+.align 4
+zaref:
+	.space	MAXVL_B * MAXVL_B
+scratch:
+	.space	MAXVL_B
+.popsection
+
+// Trivial memory copy: copy x2 bytes, starting at address x1, to address x0.
+// Clobbers x0-x3
+function memcpy
+	cmp	x2, #0
+	b.eq	1f
+0:	ldrb	w3, [x1], #1
+	strb	w3, [x0], #1
+	subs	x2, x2, #1
+	b.ne	0b
+1:	ret
+endfunction
+
+// Generate a test pattern for storage in ZA
+// x0: pid	(16 bits)
+// x1: row in ZA (8 bits)
+// x2: generation (4 bits)
+
+// These values are used to constuct a 32-bit pattern that is repeated in the
+// scratch buffer as many times as will fit:
+// bits 31:28	generation number (increments once per test_loop)
+// bits 27:22	32-bit lane index
+// bits 21:14	row number
+// bits 13: 0	pid
+
+function pattern
+	and	x0, x0, #0x1fff
+	orr	w1, w0, w1, lsl #13
+	orr	w2, w1, w2, lsl #28
+
+	ldr	x0, =scratch
+	mov	w1, #MAXVL_B / 4
+
+0:	str	w2, [x0], #4
+	add	w2, w2, #(1 << 22)
+	subs	w1, w1, #1
+	bne	0b
+
+	ret
+endfunction
+
+// Get the address of shadow data for ZA horizontal vector xn
+.macro _adrza xd, xn, nrtmp
+	ldr	\xd, =zaref
+	rdvl	x\nrtmp, #1
+	madd	\xd, x\nrtmp, \xn, \xd
+.endm
+
+// Set up test pattern in a ZA horizontal vector
+// x0: pid
+// x1: row number
+// x2: generation
+function setup_za
+	mov	x4, x30
+	mov	x12, x1			// Use x12 for vector select
+
+	bl	pattern			// Get pattern in scratch buffer
+	_adrza	x0, x12, 2		// Shadow buffer pointer to x0 and x5
+	mov	x5, x0
+	ldr	x1, =scratch
+	bl	memcpy			// length set up by pattern
+
+	_ldr_za 12, 5			// load vector w12 from pointer x5
+
+	ret	x4
+endfunction
+
+// Fill x1 bytes starting at x0 with 0xae (for canary purposes)
+// Clobbers x1, x2.
+function memfill_ae
+	mov	w2, #0xae
+	b	memfill
+endfunction
+
+// Fill x1 bytes starting at x0 with 0.
+// Clobbers x1, x2.
+function memclr
+	mov	w2, #0
+	b	memfill
+endfunction
+
+// Trivial memory fill: fill x1 bytes starting at address x0 with byte w2
+// Clobbers x1
+function memfill
+	cmp	x1, #0
+	b.eq	1f
+
+0:	strb	w2, [x0], #1
+	subs	x1, x1, #1
+	b.ne	0b
+
+1:	ret
+endfunction
+
+// Trivial memory compare: compare x2 bytes starting at address x0 with
+// bytes starting at address x1.
+// Returns only if all bytes match; otherwise, the program is aborted.
+// Clobbers x0-x5.
+function memcmp
+	cbz	x2, 2f
+
+	stp	x0, x1, [sp, #-0x20]!
+	str	x2, [sp, #0x10]
+
+	mov	x5, #0
+0:	ldrb	w3, [x0, x5]
+	ldrb	w4, [x1, x5]
+	add	x5, x5, #1
+	cmp	w3, w4
+	b.ne	1f
+	subs	x2, x2, #1
+	b.ne	0b
+
+1:	ldr	x2, [sp, #0x10]
+	ldp	x0, x1, [sp], #0x20
+	b.ne	barf
+
+2:	ret
+endfunction
+
+// Verify that a ZA vector matches its shadow in memory, else abort
+// x0: vector number
+// Clobbers x0-x7 and x12.
+function check_za
+	mov	x3, x30
+
+	mov	x12, x0
+	_adrza	x5, x0, 6		// pointer to expected value in x5
+	mov	x4, x0
+	ldr	x7, =scratch		// x7 is scratch
+
+	mov	x0, x7
+	mov	x1, x6
+	bl	memfill_ae
+
+	_str_za 12, 7			// save vector w12 to pointer x7
+
+	mov	x0, x5
+	mov	x1, x7
+	mov	x2, x6
+	mov	x30, x3
+	b	memcmp
+endfunction
+
+// Any SME register modified here can cause corruption in the main
+// thread -- but *only* the locations modified here.
+function irritator_handler
+	// Increment the irritation signal count (x23):
+	ldr	x0, [x2, #ucontext_regs + 8 * 23]
+	add	x0, x0, #1
+	str	x0, [x2, #ucontext_regs + 8 * 23]
+
+	// Corrupt some random ZA data
+#if 0
+	adr	x0, .text + (irritator_handler - .text) / 16 * 16
+	movi	v0.8b, #1
+	movi	v9.16b, #2
+	movi	v31.8b, #3
+#endif
+
+	ret
+endfunction
+
+function smstart
+	// Set SVCR.SM to 3, equivalent to SMSTART but doesn't need a
+	// SME capable toolchain.
+	mov	x0, #3
+	msr	S3_3_C4_C2_2, x0
+
+	ret
+endfunction
+
+function terminate_handler
+	mov	w21, w0
+	mov	x20, x2
+
+	puts	"Terminated by signal "
+	mov	w0, w21
+	bl	putdec
+	puts	", no error, iterations="
+	ldr	x0, [x20, #ucontext_regs + 8 * 22]
+	bl	putdec
+	puts	", signals="
+	ldr	x0, [x20, #ucontext_regs + 8 * 23]
+	bl	putdecn
+
+	mov	x0, #0
+	mov	x8, #__NR_exit
+	svc	#0
+endfunction
+
+// w0: signal number
+// x1: sa_action
+// w2: sa_flags
+// Clobbers x0-x6,x8
+function setsignal
+	str	x30, [sp, #-((sa_sz + 15) / 16 * 16 + 16)]!
+
+	mov	w4, w0
+	mov	x5, x1
+	mov	w6, w2
+
+	add	x0, sp, #16
+	mov	x1, #sa_sz
+	bl	memclr
+
+	mov	w0, w4
+	add	x1, sp, #16
+	str	w6, [x1, #sa_flags]
+	str	x5, [x1, #sa_handler]
+	mov	x2, #0
+	mov	x3, #sa_mask_sz
+	mov	x8, #__NR_rt_sigaction
+	svc	#0
+
+	cbz	w0, 1f
+
+	puts	"sigaction failure\n"
+	b	.Labort
+
+1:	ldr	x30, [sp], #((sa_sz + 15) / 16 * 16 + 16)
+	ret
+endfunction
+
+// Main program entry point
+.globl _start
+function _start
+_start:
+	puts	"Streaming mode "
+	bl	smstart
+
+	// Sanity-check and report the vector length
+
+	rdvl	x19, #8
+	cmp	x19, #128
+	b.lo	1f
+	cmp	x19, #2048
+	b.hi	1f
+	tst	x19, #(8 - 1)
+	b.eq	2f
+
+1:	puts	"bad vector length: "
+	mov	x0, x19
+	bl	putdecn
+	b	.Labort
+
+2:	puts	"vector length:\t"
+	mov	x0, x19
+	bl	putdec
+	puts	" bits\n"
+
+	// Obtain our PID, to ensure test pattern uniqueness between processes
+	mov	x8, #__NR_getpid
+	svc	#0
+	mov	x20, x0
+
+	puts	"PID:\t"
+	mov	x0, x20
+	bl	putdecn
+
+	mov	x23, #0		// Irritation signal count
+
+	mov	w0, #SIGINT
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGTERM
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGUSR1
+	adr	x1, irritator_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
+	bl	smstart		// printing and signals dropped out of SM
+	mov	x22, #0		// generation number, increments per iteration
+.Ltest_loop:
+	rdvl	x0, #8
+	cmp	x0, x19
+	b.ne	vl_barf
+
+	rdvl	x21, #1		// Set up ZA & shadow with test pattern
+0:	mov	x0, x20
+	sub	x1, x21, #1
+	and	x2, x22, #0xf
+	bl	setup_za
+	subs	x21, x21, #1
+	bne	0b
+
+	mov	x8, #__NR_sched_yield	// Encourage preemption
+	svc	#0
+	bl	smstart		// syscall dropped out of SM
+
+	rdvl	x21, #1		// Set up ZA & shadow with test pattern
+0:	sub	x0, x21, #1
+	bl	check_za
+	subs	x21, x21, #1
+	bne	0b
+
+	add	x22, x22, #1	// Everything still working
+	b	.Ltest_loop
+
+.Labort:
+	mov	x0, #0
+	mov	x1, #SIGABRT
+	mov	x8, #__NR_kill
+	svc	#0
+endfunction
+
+function barf
+// fpsimd.c acitivty log dump hack
+//	ldr	w0, =0xdeadc0de
+//	mov	w8, #__NR_exit
+//	svc	#0
+// end hack
+	mov	x10, x0	// expected data
+	mov	x11, x1	// actual data
+	mov	x12, x2	// data size
+
+	puts	"Mismatch: PID="
+	mov	x0, x20
+	bl	putdec
+	puts	", iteration="
+	mov	x0, x22
+	bl	putdec
+	puts	", row="
+	mov	x0, x21
+	bl	putdecn
+	puts	"\tExpected ["
+	mov	x0, x10
+	mov	x1, x12
+	bl	dumphex
+	puts	"]\n\tGot      ["
+	mov	x0, x11
+	mov	x1, x12
+	bl	dumphex
+	puts	"]\n"
+
+	mov	x8, #__NR_getpid
+	svc	#0
+// fpsimd.c acitivty log dump hack
+//	ldr	w0, =0xdeadc0de
+//	mov	w8, #__NR_exit
+//	svc	#0
+// ^ end of hack
+	mov	x1, #SIGABRT
+	mov	x8, #__NR_kill
+	svc	#0
+//	mov	x8, #__NR_exit
+//	mov	x1, #1
+//	svc	#0
+endfunction
+
+function vl_barf
+	mov	x10, x0
+
+	puts	"Bad active VL: "
+	mov	x0, x10
+	bl	putdecn
+
+	mov	x8, #__NR_exit
+	mov	x1, #1
+	svc	#0
+endfunction
-- 
2.20.1

