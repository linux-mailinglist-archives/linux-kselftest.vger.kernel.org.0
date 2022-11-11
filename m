Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073DA6263DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiKKVwA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiKKVvf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A96B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 334E3B82805
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8619C4347C;
        Fri, 11 Nov 2022 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203490;
        bh=Jb6w8cU2zmWHyNyhoentTlAJFr6uil/U2XQxkdBpcoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQkTZktysCEDb1Bj7TX4/iklOu4X1sf3DRr3/hHTJxXKlL0qo++jsCr45Bx9STDnA
         tt1YTARNRdYQbgSNmXaFfEWgnwr6OccucuTWaQN6XIftnaLHA1H2+efTW52EeKVbXX
         cW34S2lFhoNvZsfFTxu1Jv21K49PHtLIsY6SLm0j5o7v2WtD3Of119yH1gk3VuEZTg
         5ux4fUvATSq5CpPWpldA+EOIGthm9djbfCgrUvhCYYFldOUGh+mENeVqSiweewnk5o
         a3FKz/k73lphLNMVDeHu5t4XgAJPLSxk4aBavAOYI7zcmlZoQKRQXgDk6qw4bRzksm
         FKxJNvy3ZNT/A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 14/21] kselftest/arm64: Add a stress test program for ZT0
Date:   Fri, 11 Nov 2022 21:50:19 +0000
Message-Id: <20221111215026.813348-15-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8809; i=broonie@kernel.org; h=from:subject; bh=Jb6w8cU2zmWHyNyhoentTlAJFr6uil/U2XQxkdBpcoc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOalKs0d7YvIzSdvCHe1aOqaM1yrLnixzNUtMhB wIPMXtOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DmgAKCRAk1otyXVSH0BdBB/ 4+d9l5xt3TKtG75fcMYOoJrnkjgVQiqsFnJxf+ODpdFQIqv/MalZO4F5zGCH878CmL4KP2hlafSROC n2Te+gzF+2AkxEJTcy5byHXU5l2Xg1nNnjC0KPRbKf8sU+3i0FIDGn1k7Vklt9S+1tzL9Zt8e9UTVm /RUlIr3SPEqq5ZTT5QvCT0SRzOMZtl+U9ZaVv06EnJyd6x868cQbxLkuAaJ3tG9gsgc9096BLbc1Hy h3j0F2xRFIX9wR6ikRc5O8PsBaQJBZMUD4RsQ6mE0K3R8X7NSEJT2yD19LtKb5lZCAbiApWALjrRuD Cjkv3GNzKsDj9fLd4z2YVIJgxrQ2lM
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following the pattern for the other register sets add a stress test program
for ZT0 which continually loads and verifies patterns in the register in
an effort to discover context switching problems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore |   1 +
 tools/testing/selftests/arm64/fp/Makefile   |   3 +
 tools/testing/selftests/arm64/fp/sme-inst.h |  20 ++
 tools/testing/selftests/arm64/fp/zt-test.S  | 324 ++++++++++++++++++++
 4 files changed, 348 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/zt-test.S

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index df79d29664a1..41bde4c97d47 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -12,3 +12,4 @@ vlset
 za-fork
 za-ptrace
 za-test
+zt-test
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 36db61358ed5..aff3026d3dff 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	sve-test \
 	ssve-test \
 	za-test \
+	zt-test \
 	vlset
 TEST_PROGS_EXTENDED := fpsimd-stress sve-stress ssve-stress za-stress
 
@@ -41,5 +42,7 @@ $(OUTPUT)/za-fork: za-fork.c $(OUTPUT)/za-fork-asm.o
 $(OUTPUT)/za-ptrace: za-ptrace.c
 $(OUTPUT)/za-test: za-test.S $(OUTPUT)/asm-utils.o
 	$(CC) -nostdlib $^ -o $@
+$(OUTPUT)/zt-test: zt-test.S $(OUTPUT)/asm-utils.o
+	$(CC) -nostdlib $^ -o $@
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/fp/sme-inst.h b/tools/testing/selftests/arm64/fp/sme-inst.h
index 7191e53ca1c0..9292bba5400b 100644
--- a/tools/testing/selftests/arm64/fp/sme-inst.h
+++ b/tools/testing/selftests/arm64/fp/sme-inst.h
@@ -48,4 +48,24 @@
 		| ((\offset) & 7)
 .endm
 
+/*
+ * LDR (ZT0)
+ *
+ *	LDR ZT0, nx
+ */
+.macro _ldr_zt nx
+	.inst	0xe11f8000			\
+		| (((\nx) & 0x1f) << 5)
+.endm
+
+/*
+ * STR (ZT0)
+ *
+ *	STR ZT0, nx
+ */
+.macro _str_zt nx
+	.inst	0xe13f8000			\
+		| (((\nx) & 0x1f) << 5)
+.endm
+
 #endif
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
new file mode 100644
index 000000000000..6f04a8bf60f6
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021-2 ARM Limited.
+// Original author: Mark Brown <broonie@kernel.org>
+//
+// Scalable Matrix Extension ZT context switch test
+// Repeatedly writes unique test patterns into ZT0
+// and reads them back to verify integrity.
+
+#include <asm/unistd.h>
+#include "assembler.h"
+#include "asm-offsets.h"
+#include "sme-inst.h"
+
+.arch_extension sve
+
+#define ZT_SZ	512
+#define ZT_B	(ZT_SZ / 8)
+
+// Declare some storage space to shadow ZT register contents and a
+// scratch buffer.
+.pushsection .text
+.data
+.align 4
+ztref:
+	.space	ZT_B
+scratch:
+	.space	ZT_B
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
+// Generate a test pattern for storage in ZT
+// x0: pid
+// x1: generation
+
+// These values are used to constuct a 32-bit pattern that is repeated in the
+// scratch buffer as many times as will fit:
+// bits 31:24	generation number (increments once per test_loop)
+// bits 23: 8	pid
+// bits  7: 0	32-bit lane index
+
+function pattern
+	mov	w3, wzr
+	bfi	w3, w0, #8, #16		// PID
+	bfi	w3, w1, #24, #8		// Generation
+
+	ldr	x0, =scratch
+	mov	w1, #ZT_B / 4
+
+0:	str	w3, [x0], #4
+	add	w3, w3, #1		// Lane
+	subs	w1, w1, #1
+	b.ne	0b
+
+	ret
+endfunction
+
+// Set up test pattern in a ZT horizontal vector
+// x0: pid
+// x1: generation
+function setup_zt
+	mov	x4, x30
+
+	bl	pattern			// Get pattern in scratch buffer
+	ldr	x0, =ztref
+	ldr	x1, =scratch
+	mov	x2, #ZT_B
+	bl	memcpy
+
+	_ldr_zt 0			// load zt0 from pointer x0
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
+// Verify that a ZT vector matches its shadow in memory, else abort
+// Clobbers x0-x7 and x12.
+function check_zt
+	mov	x3, x30
+
+	ldr	x0, =scratch		// Poison scratch
+	mov	x1, #ZT_B
+	bl	memfill_ae
+
+	ldr	x0, =scratch
+	_str_zt 0
+
+	ldr	x0, =ztref
+	ldr	x1, =scratch
+	mov	x2, #ZT_B
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
+	// Corrupt some random ZT data
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
+function tickle_handler
+	// Increment the signal count (x23):
+	ldr	x0, [x2, #ucontext_regs + 8 * 23]
+	add	x0, x0, #1
+	str	x0, [x2, #ucontext_regs + 8 * 23]
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
+	mov	x23, #0		// signal count
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
+	mov	w0, #SIGUSR2
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
+	smstart_za
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
+	mov	x22, #0		// generation number, increments per iteration
+.Ltest_loop:
+	mov	x0, x20
+	mov	x1, x22
+	bl	setup_zt
+
+	mov	x8, #__NR_sched_yield	// Encourage preemption
+	svc	#0
+
+	mov	x0, x20
+	mov	x1, x22
+	bl	check_zt
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

