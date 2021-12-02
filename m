Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABF04668A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 17:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbhLBQzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 11:55:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57288 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbhLBQzI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 11:55:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A0DBB82429
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 16:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B02C00446;
        Thu,  2 Dec 2021 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638463903;
        bh=oG+PegkSkunMX4uoxAPSZN8kXoQS/wjKGXQGpltcYT4=;
        h=From:To:Cc:Subject:Date:From;
        b=Dq94d0inwnPb7npPVYT3v3+4CRbfPYxeWQJioWiJn/JEWnQ54HUckluqdq6xiDa6Y
         8XHVKrvwHYVh7Zq1bLmpTja6PS15wHeB0qdgngd1Z9PChGo48i8dQaC5ei45YtwR5k
         vpIlBMT7vS1IMhjNlstsedb6qrC3+8njAu75M3B3ssIz+TwDSjHZMaf9Xr5NwVXeLn
         pAVfR3bM8Z3X2uv7VKcYiDujt9Zt/7XEnDEH4IYDi7SyxM48wyZIq4GEBSRChCzOVZ
         cO4GD/3HXhUSqrIwhGt4N3vjQswsplHTA/DejyM0c8/TkdWn1n34F8jzSot4wF7i+L
         RlMgKnfgr4Npw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Add pidbench for floating point syscall cases
Date:   Thu,  2 Dec 2021 16:51:07 +0000
Message-Id: <20211202165107.1075259-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4114; h=from:subject; bh=oG+PegkSkunMX4uoxAPSZN8kXoQS/wjKGXQGpltcYT4=; b=owGbwMvMwMWocq27KDak/QLjabUkhsQVP1YdFtOr7e5NUszfJbTfSmUra76hynTOzbdr7rz4meT7 I2N3J6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkamB7P/rzbRWztm11sdydWvB7v 0vW8SOsr93f8ggIdZxuiMoti7vDjP/pnzZ9SVb92osNUor+u9+5tQR2X1R0xdaflmoc+OTTPb//Dqj mQ07q3I3lE35WFXbbGwRy7tHok/Nc8aeJzvWZ194l6FitrraUS3wQJCdVmb5qSmiM6aGLOvQj3tQa7 9pIpfY14dbdK661oqK28Rlv+dht0pV2dNUNV0imfvGpaLz3nu/Zb2K2/z/gvPU9XM3Bmy7W1BbXXB2 XrlPsfdLq4KcV2Gf2c1TCjk2aBfxFU/8llmX4jp/v1l2jlF13617XnVl/jy5BmKdhj3e4oUtXhyb7y hsrbd0EZgWfrOdI/yS1dk/9hmMAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since it's likely to be useful for performance work with SVE let's have a
pidbench that gives us some numbers for consideration. In order to ensure
that we test exactly the scenario we want this is written in assembly - if
system libraries use SVE this would stop us exercising the case where the
process has never used SVE.

We exercise three cases:

 - Never having used SVE.
 - Having used SVE once.
 - Using SVE after each syscall.

by spinning running getpid() for a fixed number of iterations with the
time measured using CNTVCT_EL0 reported on the console. This is obviously
a totally unrealistic benchmark which will show the extremes of any
performance variation but equally given the potential gotchas with use of
FP instructions by system libraries it's good to have some concrete code
shared to make it easier to compare notes on results.

Testing over multiple SVE vector lengths will need to be done with vlset
currently, the test could be extended to iterate over all of them if
desired.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore   |  1 +
 tools/testing/selftests/arm64/fp/Makefile     |  4 +-
 .../testing/selftests/arm64/fp/fp-pidbench.S  | 71 +++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/fp-pidbench.S

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index b67395903b9b..c50d86331ed2 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -1,3 +1,4 @@
+fp-pidbench
 fpsimd-test
 rdvl-sve
 sve-probe-vls
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index ba1488c7c315..95f0b877a060 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -2,13 +2,15 @@
 
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
-TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
+TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
 	rdvl-sve \
 	sve-test sve-stress \
 	vlset
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
 
+fp-pidbench: fp-pidbench.S asm-utils.o
+	$(CC) -nostdlib $^ -o $@
 fpsimd-test: fpsimd-test.o asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 rdvl-sve: rdvl-sve.o rdvl.o
diff --git a/tools/testing/selftests/arm64/fp/fp-pidbench.S b/tools/testing/selftests/arm64/fp/fp-pidbench.S
new file mode 100644
index 000000000000..16a436389bfc
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/fp-pidbench.S
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021 ARM Limited.
+// Original author: Mark Brown <broonie@kernel.org>
+//
+// Trivial syscall overhead benchmark.
+//
+// This is implemented in asm to ensure that we don't have any issues with
+// system libraries using instructions that disrupt the test.
+
+#include <asm/unistd.h>
+#include "assembler.h"
+
+.arch_extension sve
+
+.macro test_loop per_loop
+	mov	x10, x20
+	mov	x8, #__NR_getpid
+	mrs	x11, CNTVCT_EL0
+1:
+	\per_loop
+	svc	#0
+	sub	x10, x10, #1
+	cbnz	x10, 1b
+
+	mrs	x12, CNTVCT_EL0
+	sub	x0, x12, x11
+	bl	putdec
+	puts	"\n"
+.endm
+
+// Main program entry point
+.globl _start
+function _start
+_start:
+	puts	"Iterations per test: "
+	mov	x20, #10000
+	lsl	x20, x20, #8
+	mov	x0, x20
+	bl	putdec
+	puts	"\n"
+
+	// Test having never used SVE
+	puts	"No SVE: "
+	test_loop
+
+	// Check for SVE support - should use hwcap but that's hard in asm
+	mrs	x0, ID_AA64PFR0_EL1
+	ubfx	x0, x0, #32, #4
+	cbnz	x0, 1f
+	puts	"System does not support SVE\n"
+	b	out
+1:
+
+	// Execute a SVE instruction
+	puts	"SVE VL: "
+	rdvl	x0, #8
+	bl	putdec
+	puts	"\n"
+
+	puts	"SVE used once: "
+	test_loop
+
+	// Use SVE per syscall
+	puts	"SVE used per syscall: "
+	test_loop "rdvl x0, #8"
+
+	//  And we're done
+out:
+	mov	x0, #0
+	mov	x8, #__NR_exit
+	svc	#0
-- 
2.30.2

