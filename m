Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3023C4AC3E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 16:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbiBGPfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 10:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378274AbiBGPZf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 10:25:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E00CC0401C1
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 07:25:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08DD61035
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 15:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFD8C340F1;
        Mon,  7 Feb 2022 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247533;
        bh=koywA7hAthCVT8sXD5VTyoBPdMoHOs9dyv3/4Qn5c6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EX5krfDJ8jiFdyJev3627WJu/URVNlZgSRpKgeljV3pvrcJom7LcRoSBoEukF7W1T
         wqBd1RlSVX8Rh+hY+u/rn6cABUwulXCsrPl/rWhVbFXwr6EKfO/mHVidCrOxjkPR1T
         lyx7Qib5a9nkikUrA50xClfJofcgHwsFKKpkxmouSDbn/yjzxZwFE4BcTL2W1ZuGzh
         CbbzXlZ/VRGcMCqaoZh3pV89zKZ3OzXpid3RE8LXu35GVJdHVC81olJDgDE1+/MmX+
         C8/ftyw2hl4/2TH96YtFQxaG1QC7DyJmSU+x5NMd8jc2DyDhWsC5W7f3MxLrEcOosO
         lVJjpaH3AMzYA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v11 36/40] kselftest/arm64: Add stress test for SME ZA context switching
Date:   Mon,  7 Feb 2022 15:21:05 +0000
Message-Id: <20220207152109.197566-37-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11030; h=from:subject; bh=koywA7hAthCVT8sXD5VTyoBPdMoHOs9dyv3/4Qn5c6Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjh5an694kAI3DPI2fIjKjT1gn2NTyDGqgThkBQ kA874fqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE44QAKCRAk1otyXVSH0MsxB/ wIqPrRKkjn+90X2EnOUnS4Z7S83x11TmzqpsjxB8LeG4EJegGmly0tu79cBvL2YJy/+C6QwovnTKPY HD2Qlb+7DG/YhvNq6QL5aZBKYStgS991GTdwHrg8AWaavvCLPbKF0h4NmMRnghUcG/B8uBGUmOPfkO S3hS6f7p1vhrVdCXGeEuqRTHehnSz0DorBqp5kAIKj3t/XuLR/BV4LNagr8Y4XmRAFxyzHmtWh164e y8hKzBfm8UiCpqRnzbSyEctTxlRIhqrO1NPG+6hlhbEE6CtavwHXvLlBdr4yq31xpHeVO5hlsBUB5Y MDEAM1e01eCuNbeTbXsh0aqDICRr0m
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 tools/testing/selftests/arm64/fp/za-test.S  | 388 ++++++++++++++++++++
 4 files changed, 451 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/za-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-test.S

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 5729a5b1adfc..ead3197e720b 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -8,3 +8,4 @@ sve-test
 ssve-test
 vec-syscfg
 vlset
+za-test
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index e6643c9b0474..38d2d0d5a0eb 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -6,6 +6,7 @@ TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
 	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
 	ssve-test ssve-stress \
+	za-test za-stress \
 	vlset
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
@@ -24,5 +25,7 @@ ssve-test: sve-test.S asm-utils.o
 	$(CC) -DSSVE -nostdlib $^ -o $@
 vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
+za-test: za-test.o asm-utils.o
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
index 000000000000..9ab6f9cd9623
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -0,0 +1,388 @@
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
+#include "sme-inst.h"
+
+.arch_extension sve
+
+#define MAXVL     2048
+#define MAXVL_B   (MAXVL / 8)
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
+// x0: pid
+// x1: row in ZA
+// x2: generation
+
+// These values are used to constuct a 32-bit pattern that is repeated in the
+// scratch buffer as many times as will fit:
+// bits 31:28	generation number (increments once per test_loop)
+// bits 27:16	pid
+// bits 15: 8	row number
+// bits  7: 0	32-bit lane index
+
+function pattern
+	mov	w3, wzr
+	bfi	w3, w0, #16, #12	// PID
+	bfi	w3, w1, #8, #8		// Row
+	bfi	w3, w2, #28, #4		// Generation
+
+	ldr	x0, =scratch
+	mov	w1, #MAXVL_B / 4
+
+0:	str	w3, [x0], #4
+	add	w3, w3, #1		// Lane
+	subs	w1, w1, #1
+	b.ne	0b
+
+	ret
+endfunction
+
+// Get the address of shadow data for ZA horizontal vector xn
+.macro _adrza xd, xn, nrtmp
+	ldr	\xd, =zaref
+	rdsvl	\nrtmp, 1
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
+	bl	memcpy			// length set up in x2 by _adrza
+
+	_ldr_za 12, 5			// load vector w12 from pointer x5
+
+	ret	x4
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
+// x0: row number
+// Clobbers x0-x7 and x12.
+function check_za
+	mov	x3, x30
+
+	mov	x12, x0
+	_adrza	x5, x0, 6		// pointer to expected value in x5
+	mov	x4, x0
+	ldr	x7, =scratch		// x7 is scratch
+
+	mov	x0, x7			// Poison scratch
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
+	smstart_za
+
+	// Sanity-check and report the vector length
+
+	rdsvl	19, 8
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
+	mov	x22, #0		// generation number, increments per iteration
+.Ltest_loop:
+	rdsvl	0, 8
+	cmp	x0, x19
+	b.ne	vl_barf
+
+	rdsvl	21, 1		// Set up ZA & shadow with test pattern
+0:	mov	x0, x20
+	sub	x1, x21, #1
+	mov	x2, x22
+	bl	setup_za
+	subs	x21, x21, #1
+	b.ne	0b
+
+	and	x8, x22, #127		// Every 128 interations...
+	cbz	x8, 0f
+	mov	x8, #__NR_getpid	// (otherwise minimal syscall)
+	b	1f
+0:
+	mov	x8, #__NR_sched_yield	// ...encourage preemption
+1:
+	svc	#0
+
+	mrs	x0, S3_3_C4_C2_2	// SVCR should have ZA=1,SM=0
+	and	x1, x0, #3
+	cmp	x1, #2
+	b.ne	svcr_barf
+
+	rdsvl	21, 1			// Verify that the data made it through
+	rdsvl	24, 1			// Verify that the data made it through
+0:	sub	x0, x24, x21
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
+	smstop
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
+
+function svcr_barf
+	mov	x10, x0
+
+	puts	"Bad SVCR: "
+	mov	x0, x10
+	bl	putdecn
+
+	mov	x8, #__NR_exit
+	mov	x1, #1
+	svc	#0
+endfunction
-- 
2.30.2

