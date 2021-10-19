Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44524433E4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhJSSVN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 14:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJSSVM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 14:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0940661360;
        Tue, 19 Oct 2021 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634667539;
        bh=WXHVaQCOjaq5aGMB0aoF5fbsDEmRbqKlu+GUFX/yEc0=;
        h=From:To:Cc:Subject:Date:From;
        b=SYWoVDE72/Pzb1Spj39FTlUl/BZEtUjaa7Go7HMe9I9WYvjCv5FnsdDFmUNeZsfQS
         8BuujP/XRC8q8JjqBuIJzkswoWYhq2Hq2UmnYnHKx4A+FE+U6MJZGnCE1mSd6D2+tG
         IQsQI5Iou4bKPJCkd3wrJYXxegW7PXQVf7P7e2EZ4JILC+v5zu4t46XcComSrMhL6q
         gBhM8Aq0PwAVenbDyo/mlmEvvUEcHJdgXd091TsdcIBewTws4UR6Tj8Hu8hqtRu5oT
         Tc4He38E8II6UPn/uQ2QLuxwc6Jl7nxPrFrWhvClN78todH7QvRi9SCvEGSvr3ivtB
         BgPhU64Sielmw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests: arm64: Factor out utility functions for assembly FP tests
Date:   Tue, 19 Oct 2021 19:18:51 +0100
Message-Id: <20211019181851.3341232-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13348; h=from:subject; bh=WXHVaQCOjaq5aGMB0aoF5fbsDEmRbqKlu+GUFX/yEc0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbwrf1FdRduja36Nww1SS+BMG2oEtAER3U9/2wwBq mkyJgPWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW8K3wAKCRAk1otyXVSH0EEVB/ 4nP/hbT3cykJqfd+ANmhErPLGBILjYyFeQOG+Y4Y1/yUe87Nd/xftIu+jRegOgTiDMY5kLa/ItroQ4 tdpvIcQWTPHjgC0wHLr7iZG0cVYtqWkik3zdKV+2SuXhK6tqwgK6UUgRs44Vero1aOdyduhcRJoYGH 3nCX3DdjQoa3QQr6vlBIRR8RYJs7Gk+f0NZOs10UR2XUmUnKysXqgnmhr1Mb0FN2JdnsmxABcFyhPD vkCJHS9UzFed+/V6R0SoA/JKsij2vqNl4+egPNODQyf3lgitPboeMdLNXLY31gNbhKtktIAVns7sfd HQUFQ0R6PJd2Rwx/0d8WC0BnavEa4a
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The various floating point test programs written in assembly have a bunch
of helper functions and macros which are cut'n'pasted between them. Factor
them out into a separate source file which is linked into all of them.

We don't include memcmp() since it isn't as generic as it should be and
directly branches to report an error in the programs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile     |   4 +-
 tools/testing/selftests/arm64/fp/asm-utils.S  | 172 ++++++++++++++++++
 tools/testing/selftests/arm64/fp/assembler.h  |  11 ++
 .../testing/selftests/arm64/fp/fpsimd-test.S  | 164 -----------------
 tools/testing/selftests/arm64/fp/sve-test.S   | 163 -----------------
 5 files changed, 185 insertions(+), 329 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/fp/asm-utils.S

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 4367125b7c27..ba1488c7c315 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -9,12 +9,12 @@ TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
 
-fpsimd-test: fpsimd-test.o
+fpsimd-test: fpsimd-test.o asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 rdvl-sve: rdvl-sve.o rdvl.o
 sve-ptrace: sve-ptrace.o
 sve-probe-vls: sve-probe-vls.o rdvl.o
-sve-test: sve-test.o
+sve-test: sve-test.o asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
diff --git a/tools/testing/selftests/arm64/fp/asm-utils.S b/tools/testing/selftests/arm64/fp/asm-utils.S
new file mode 100644
index 000000000000..4b9728efc18d
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/asm-utils.S
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2015-2021 ARM Limited.
+// Original author: Dave Martin <Dave.Martin@arm.com>
+//
+// Utility functions for assembly code.
+
+#include <asm/unistd.h>
+#include "assembler.h"
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
+.globl	putc
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
+.globl	puts
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
+.globl	putdec
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
+.globl	putdecn
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
+.globl	puthexb
+
+// Clobbers x0-x2,x8
+function puthexnibble
+	and	w0, w0, #0xf
+	cmp	w0, #10
+	blo	1f
+	add	w0, w0, #'a' - ('9' + 1)
+1:	add	w0, w0, #'0'
+	b	putc
+endfunction
+.globl	puthexnibble
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
+.globl	dumphex
+
+	// Trivial memory copy: copy x2 bytes, starting at address x1, to address x0.
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
+.globl	memcpy
+
+// Fill x1 bytes starting at x0 with 0xae (for canary purposes)
+// Clobbers x1, x2.
+function memfill_ae
+	mov	w2, #0xae
+	b	memfill
+endfunction
+.globl	memfill_ae
+	
+// Fill x1 bytes starting at x0 with 0.
+// Clobbers x1, x2.
+function memclr
+	mov	w2, #0
+endfunction
+.globl	memclr
+	// fall through to memfill
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
+.globl	memfill
diff --git a/tools/testing/selftests/arm64/fp/assembler.h b/tools/testing/selftests/arm64/fp/assembler.h
index 8944f2189206..90bd433d2665 100644
--- a/tools/testing/selftests/arm64/fp/assembler.h
+++ b/tools/testing/selftests/arm64/fp/assembler.h
@@ -54,4 +54,15 @@ endfunction
 	.purgem \name\()_entry
 .endm
 
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
 #endif /* ! ASSEMBLER_H */
diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index 0dbd594c2747..e21e8ea52c7e 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -33,131 +33,6 @@
 define_accessor setv, NVR, _vldr
 define_accessor getv, NVR, _vstr
 
-// Print a single character x0 to stdout
-// Clobbers x0-x2,x8
-function putc
-	str	x0, [sp, #-16]!
-
-	mov	x0, #1			// STDOUT_FILENO
-	mov	x1, sp
-	mov	x2, #1
-	mov	x8, #__NR_write
-	svc	#0
-
-	add	sp, sp, #16
-	ret
-endfunction
-
-// Print a NUL-terminated string starting at address x0 to stdout
-// Clobbers x0-x3,x8
-function puts
-	mov	x1, x0
-
-	mov	x2, #0
-0:	ldrb	w3, [x0], #1
-	cbz	w3, 1f
-	add	x2, x2, #1
-	b	0b
-
-1:	mov	w0, #1			// STDOUT_FILENO
-	mov	x8, #__NR_write
-	svc	#0
-
-	ret
-endfunction
-
-// Utility macro to print a literal string
-// Clobbers x0-x4,x8
-.macro puts string
-	.pushsection .rodata.str1.1, "aMS", 1
-.L__puts_literal\@: .string "\string"
-	.popsection
-
-	ldr	x0, =.L__puts_literal\@
-	bl	puts
-.endm
-
-// Print an unsigned decimal number x0 to stdout
-// Clobbers x0-x4,x8
-function putdec
-	mov	x1, sp
-	str	x30, [sp, #-32]!	// Result can't be > 20 digits
-
-	mov	x2, #0
-	strb	w2, [x1, #-1]!		// Write the NUL terminator
-
-	mov	x2, #10
-0:	udiv	x3, x0, x2		// div-mod loop to generate the digits
-	msub	x0, x3, x2, x0
-	add	w0, w0, #'0'
-	strb	w0, [x1, #-1]!
-	mov	x0, x3
-	cbnz	x3, 0b
-
-	ldrb	w0, [x1]
-	cbnz	w0, 1f
-	mov	w0, #'0'		// Print "0" for 0, not ""
-	strb	w0, [x1, #-1]!
-
-1:	mov	x0, x1
-	bl	puts
-
-	ldr	x30, [sp], #32
-	ret
-endfunction
-
-// Print an unsigned decimal number x0 to stdout, followed by a newline
-// Clobbers x0-x5,x8
-function putdecn
-	mov	x5, x30
-
-	bl	putdec
-	mov	x0, #'\n'
-	bl	putc
-
-	ret	x5
-endfunction
-
-
-// Clobbers x0-x3,x8
-function puthexb
-	str	x30, [sp, #-0x10]!
-
-	mov	w3, w0
-	lsr	w0, w0, #4
-	bl	puthexnibble
-	mov	w0, w3
-
-	ldr	x30, [sp], #0x10
-	// fall through to puthexnibble
-endfunction
-// Clobbers x0-x2,x8
-function puthexnibble
-	and	w0, w0, #0xf
-	cmp	w0, #10
-	blo	1f
-	add	w0, w0, #'a' - ('9' + 1)
-1:	add	w0, w0, #'0'
-	b	putc
-endfunction
-
-// x0=data in, x1=size in, clobbers x0-x5,x8
-function dumphex
-	str	x30, [sp, #-0x10]!
-
-	mov	x4, x0
-	mov	x5, x1
-
-0:	subs	x5, x5, #1
-	b.lo	1f
-	ldrb	w0, [x4], #1
-	bl	puthexb
-	b	0b
-
-1:	ldr	x30, [sp], #0x10
-	ret
-endfunction
-
 // Declare some storate space to shadow the SVE register contents:
 .pushsection .text
 .data
@@ -168,18 +43,6 @@ scratch:
 	.space	MAXVL_B
 .popsection
 
-// Trivial memory copy: copy x2 bytes, starting at address x1, to address x0.
-// Clobbers x0-x3
-function memcpy
-	cmp	x2, #0
-	b.eq	1f
-0:	ldrb	w3, [x1], #1
-	strb	w3, [x0], #1
-	subs	x2, x2, #1
-	b.ne	0b
-1:	ret
-endfunction
-
 // Generate a test pattern for storage in SVE registers
 // x0: pid	(16 bits)
 // x1: register number (6 bits)
@@ -227,33 +90,6 @@ function setup_vreg
 	ret	x4
 endfunction
 
-// Fill x1 bytes starting at x0 with 0xae (for canary purposes)
-// Clobbers x1, x2.
-function memfill_ae
-	mov	w2, #0xae
-	b	memfill
-endfunction
-
-// Fill x1 bytes starting at x0 with 0.
-// Clobbers x1, x2.
-function memclr
-	mov	w2, #0
-endfunction
-	// fall through to memfill
-
-// Trivial memory fill: fill x1 bytes starting at address x0 with byte w2
-// Clobbers x1
-function memfill
-	cmp	x1, #0
-	b.eq	1f
-
-0:	strb	w2, [x0], #1
-	subs	x1, x1, #1
-	b.ne	0b
-
-1:	ret
-endfunction
-
 // Trivial memory compare: compare x2 bytes starting at address x0 with
 // bytes starting at address x1.
 // Returns only if all bytes match; otherwise, the program is aborted.
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index e3e08d9c7020..f5b1b48ffff2 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -46,130 +46,6 @@ define_accessor getz, NZR, _sve_str_v
 define_accessor setp, NPR, _sve_ldr_p
 define_accessor getp, NPR, _sve_str_p
 
-// Print a single character x0 to stdout
-// Clobbers x0-x2,x8
-function putc
-	str	x0, [sp, #-16]!
-
-	mov	x0, #1			// STDOUT_FILENO
-	mov	x1, sp
-	mov	x2, #1
-	mov	x8, #__NR_write
-	svc	#0
-
-	add	sp, sp, #16
-	ret
-endfunction
-
-// Print a NUL-terminated string starting at address x0 to stdout
-// Clobbers x0-x3,x8
-function puts
-	mov	x1, x0
-
-	mov	x2, #0
-0:	ldrb	w3, [x0], #1
-	cbz	w3, 1f
-	add	x2, x2, #1
-	b	0b
-
-1:	mov	w0, #1			// STDOUT_FILENO
-	mov	x8, #__NR_write
-	svc	#0
-
-	ret
-endfunction
-
-// Utility macro to print a literal string
-// Clobbers x0-x4,x8
-.macro puts string
-	.pushsection .rodata.str1.1, "aMS", 1
-.L__puts_literal\@: .string "\string"
-	.popsection
-
-	ldr	x0, =.L__puts_literal\@
-	bl	puts
-.endm
-
-// Print an unsigned decimal number x0 to stdout
-// Clobbers x0-x4,x8
-function putdec
-	mov	x1, sp
-	str	x30, [sp, #-32]!	// Result can't be > 20 digits
-
-	mov	x2, #0
-	strb	w2, [x1, #-1]!		// Write the NUL terminator
-
-	mov	x2, #10
-0:	udiv	x3, x0, x2		// div-mod loop to generate the digits
-	msub	x0, x3, x2, x0
-	add	w0, w0, #'0'
-	strb	w0, [x1, #-1]!
-	mov	x0, x3
-	cbnz	x3, 0b
-
-	ldrb	w0, [x1]
-	cbnz	w0, 1f
-	mov	w0, #'0'		// Print "0" for 0, not ""
-	strb	w0, [x1, #-1]!
-
-1:	mov	x0, x1
-	bl	puts
-
-	ldr	x30, [sp], #32
-	ret
-endfunction
-
-// Print an unsigned decimal number x0 to stdout, followed by a newline
-// Clobbers x0-x5,x8
-function putdecn
-	mov	x5, x30
-
-	bl	putdec
-	mov	x0, #'\n'
-	bl	putc
-
-	ret	x5
-endfunction
-
-// Clobbers x0-x3,x8
-function puthexb
-	str	x30, [sp, #-0x10]!
-
-	mov	w3, w0
-	lsr	w0, w0, #4
-	bl	puthexnibble
-	mov	w0, w3
-
-	ldr	x30, [sp], #0x10
-	// fall through to puthexnibble
-endfunction
-// Clobbers x0-x2,x8
-function puthexnibble
-	and	w0, w0, #0xf
-	cmp	w0, #10
-	blo	1f
-	add	w0, w0, #'a' - ('9' + 1)
-1:	add	w0, w0, #'0'
-	b	putc
-endfunction
-
-// x0=data in, x1=size in, clobbers x0-x5,x8
-function dumphex
-	str	x30, [sp, #-0x10]!
-
-	mov	x4, x0
-	mov	x5, x1
-
-0:	subs	x5, x5, #1
-	b.lo	1f
-	ldrb	w0, [x4], #1
-	bl	puthexb
-	b	0b
-
-1:	ldr	x30, [sp], #0x10
-	ret
-endfunction
-
 // Declare some storate space to shadow the SVE register contents:
 .pushsection .text
 .data
@@ -184,18 +60,6 @@ scratch:
 	.space	MAXVL_B
 .popsection
 
-// Trivial memory copy: copy x2 bytes, starting at address x1, to address x0.
-// Clobbers x0-x3
-function memcpy
-	cmp	x2, #0
-	b.eq	1f
-0:	ldrb	w3, [x1], #1
-	strb	w3, [x0], #1
-	subs	x2, x2, #1
-	b.ne	0b
-1:	ret
-endfunction
-
 // Generate a test pattern for storage in SVE registers
 // x0: pid	(16 bits)
 // x1: register number (6 bits)
@@ -316,33 +180,6 @@ function setup_ffr
 	ret	x4
 endfunction
 
-// Fill x1 bytes starting at x0 with 0xae (for canary purposes)
-// Clobbers x1, x2.
-function memfill_ae
-	mov	w2, #0xae
-	b	memfill
-endfunction
-
-// Fill x1 bytes starting at x0 with 0.
-// Clobbers x1, x2.
-function memclr
-	mov	w2, #0
-endfunction
-	// fall through to memfill
-
-// Trivial memory fill: fill x1 bytes starting at address x0 with byte w2
-// Clobbers x1
-function memfill
-	cmp	x1, #0
-	b.eq	1f
-
-0:	strb	w2, [x0], #1
-	subs	x1, x1, #1
-	b.ne	0b
-
-1:	ret
-endfunction
-
 // Trivial memory compare: compare x2 bytes starting at address x0 with
 // bytes starting at address x1.
 // Returns only if all bytes match; otherwise, the program is aborted.
-- 
2.30.2

