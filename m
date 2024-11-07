Return-Path: <linux-kselftest+bounces-21576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C49BFBBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4992C1C21075
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20217BCA;
	Thu,  7 Nov 2024 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcbnYj6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3B28689;
	Thu,  7 Nov 2024 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943541; cv=none; b=udCvGGNsgFUWP2bJ9yvTXClNLWAbTMmUjbrGqKGTB7qxUn4P/Q/9YnBj2VJbAY+46s94ef/ryd13sJuk9+u/VA/bjBnpe8h4wEwtoKipZz+34sbB6RLk9ouCSVQGU1B1pSiAKQWLhFN3ilikohXprGZeIzXKevTmDRAxCXxfFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943541; c=relaxed/simple;
	bh=xEt/GuYUc1T9GgP1WKMvPTj91jfRIyjXPBA0FfOjlmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8aM3QpioGVMZVBmn2CHgdSraZQT+cnvFlq6U6KpDpwproGj3CuxKIZJJAnewM6mhdXL7VDBHCmhZDZQLZK8X68n7j4NTZHvezRyrFI8E+opv/FHs1W5BvFiLNarr9V8pcmu/Kmiu1pINK9WVgUB/Lcj9eRaM44w50oNKVkL3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcbnYj6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E0C4CECC;
	Thu,  7 Nov 2024 01:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943541;
	bh=xEt/GuYUc1T9GgP1WKMvPTj91jfRIyjXPBA0FfOjlmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FcbnYj6pNPCownppWPz9g3BOYuf0qtvn8EI/+FXdiefIiTwh6JPdy3yvnIxtbniyY
	 Qo3swFx2VtluDzWQvgH/6YmdZfIkqsVGJaZv8rLZ1gDeRfSg/QeFgoDDCBZs2/qXLu
	 IsoaIndGp2bJcrMDVVcpzwxkPull6XiF3k3YmV0HK7NNPsdR0haoSdggGvo9GtTE9B
	 Syqt9HRiDzc/ZdcPszYNxy2cD/oZ0c22LNPgWsrZQ2WXLxzLczo3aBAfxnr9gwg/g7
	 8Xcvfeg4d+qPCzGXCLweTlU08bQG1PKELHUf8AkRqzs80HXCF0y+fttOFv+gWRvVjL
	 gdR947cLmVnug==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:38:05 +0000
Subject: [PATCH 2/4] kselftest/arm64: Use a define for SVCR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-ptrace-fpmr-v1-2-3e5e0b6e3be9@kernel.org>
References: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
In-Reply-To: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=9048; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xEt/GuYUc1T9GgP1WKMvPTj91jfRIyjXPBA0FfOjlmo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBot0iYhrXXS1NhlawJ/mRd21YVB/8pIGXMBsIab
 kM7AwVuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywaLQAKCRAk1otyXVSH0CnPB/
 4lgz8hA8FciW1nHlseNZvf/8dnW5DCVdcdPYyR8611uKFzozwpy5zD2fYJNhgL9cBx9jTvSnnmjBad
 46VGA9vqxoTeri342M0Gf2e4MaHMbu2X0fWVr7CytWvpiJgT8RdNzpAIezh1QDKdlzgOfrpiQM0wFp
 xXMu88I5h+8wZW5Mufa2INlLMZZ7OdD5xfl4ECC4BXpfqVfHWVii84Aw6/okJ0KnYpBXgU3nZtMfI+
 rnLvpMz9mNbG4WZPlO34AJlkAwhtwOW0/GDxvjA6o/wda/qrOb4CIbBp0Q34Yes56DML8qQQ2KNEzd
 cXNeeZlnOAecoKyFlWqMhEVh+u2ivm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

For some reason when we're accessing SVCR in the FP tests we use the raw
numerical version of the register name rather than hiding that behind a
preprocessor macro for readability. Since we already use the generated
defines for sysreg bitfields in other the KVM selftests let's do the same
thing here, also replacing the defines for the SVCR bitfields which we
have.

The build setup for fp-ptrace is a little fun so we have to manually define
__ASSEMBLY__ in the source code for that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile        | 20 +++++++++++++-------
 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S | 11 ++++++++---
 tools/testing/selftests/arm64/fp/fp-ptrace.c     |  2 ++
 tools/testing/selftests/arm64/fp/fp-ptrace.h     |  6 +-----
 tools/testing/selftests/arm64/fp/sve-test.S      |  5 +++--
 tools/testing/selftests/arm64/fp/za-fork-asm.S   |  3 ++-
 tools/testing/selftests/arm64/fp/za-test.S       |  6 ++++--
 tools/testing/selftests/arm64/fp/zt-test.S       |  5 +++--
 8 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index d171021e4cdd1a880f842c7d58b1b149e79e4794..da808074e6ca9388c0ab7a716632742d1a8acbf4 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -3,7 +3,13 @@
 # A proper top_srcdir is needed by KSFT(lib.mk)
 top_srcdir = $(realpath ../../../../../)
 
-CFLAGS += $(KHDR_INCLUDES)
+ARCH_TOOLS_INCLUDES=\
+	-I${top_srcdir}/tools/include \
+	-I${top_srcdir}/tools/arch/arm64/include \
+	-I${top_srcdir}/tools/arch/arm64/include/generated
+
+CFLAGS += $(KHDR_INCLUDES) $(ARCH_TOOLS_INCLUDES)
+ASFLAGS += -D__ASSEMBLY__ $(ARCH_TOOLS_INCLUDES)
 
 TEST_GEN_PROGS := \
 	fp-ptrace \
@@ -26,18 +32,18 @@ EXTRA_CLEAN += $(OUTPUT)/asm-utils.o $(OUTPUT)/rdvl.o $(OUTPUT)/za-fork-asm.o
 
 # Build with nolibc to avoid effects due to libc's clone() support
 $(OUTPUT)/fp-pidbench: fp-pidbench.S $(OUTPUT)/asm-utils.o
-	$(CC) -nostdlib $^ -o $@
+	$(CC) $(ASFLAGS) -nostdlib $^ -o $@
 $(OUTPUT)/fp-ptrace: fp-ptrace.c fp-ptrace-asm.S
 $(OUTPUT)/fpsimd-test: fpsimd-test.S $(OUTPUT)/asm-utils.o
-	$(CC) -nostdlib $^ -o $@
+	$(CC) $(ASFLAGS) -nostdlib $^ -o $@
 $(OUTPUT)/rdvl-sve: rdvl-sve.c $(OUTPUT)/rdvl.o
 $(OUTPUT)/rdvl-sme: rdvl-sme.c $(OUTPUT)/rdvl.o
 $(OUTPUT)/sve-ptrace: sve-ptrace.c
 $(OUTPUT)/sve-probe-vls: sve-probe-vls.c $(OUTPUT)/rdvl.o
 $(OUTPUT)/sve-test: sve-test.S $(OUTPUT)/asm-utils.o
-	$(CC) -nostdlib $^ -o $@
+	$(CC) $(ASFLAGS) -nostdlib $^ -o $@
 $(OUTPUT)/ssve-test: sve-test.S $(OUTPUT)/asm-utils.o
-	$(CC) -DSSVE -nostdlib $^ -o $@
+	$(CC) -DSSVE $(ASFLAGS) -nostdlib $^ -o $@
 $(OUTPUT)/vec-syscfg: vec-syscfg.c $(OUTPUT)/rdvl.o
 $(OUTPUT)/vlset: vlset.c
 $(OUTPUT)/za-fork: za-fork.c $(OUTPUT)/za-fork-asm.o
@@ -46,9 +52,9 @@ $(OUTPUT)/za-fork: za-fork.c $(OUTPUT)/za-fork-asm.o
 		-static -ffreestanding -Wall $^ -o $@
 $(OUTPUT)/za-ptrace: za-ptrace.c
 $(OUTPUT)/za-test: za-test.S $(OUTPUT)/asm-utils.o
-	$(CC) -nostdlib $^ -o $@
+	$(CC) $(ASFLAGS) -nostdlib $^ -o $@
 $(OUTPUT)/zt-ptrace: zt-ptrace.c
 $(OUTPUT)/zt-test: zt-test.S $(OUTPUT)/asm-utils.o
-	$(CC) -nostdlib $^ -o $@
+	$(CC) $(ASFLAGS) -nostdlib $^ -o $@
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
index 5e7e9c878f2ce797e3ba5f4033a42526830393e6..4a9242296ef75cf1a83ec561cda11a31e9f69bd4 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
@@ -8,6 +8,11 @@
 // break on a further breakpoint
 //
 
+/* The build system is dumb and doesn't do this for us */
+#define __ASSEMBLY__
+
+#include <asm/sysreg.h>
+
 #include "fp-ptrace.h"
 #include "sme-inst.h"
 
@@ -47,7 +52,7 @@ load_and_save:
 	ldr	x7, [x7, :lo12:svcr_in]
 	// SVCR is 0 by default, avoid triggering SME if not in use
 	cbz	x7, check_sve_in
-	msr	S3_3_C4_C2_2, x7
+	msr	REG_SVCR, x7
 
 	// ZA?
 	tbz	x7, #SVCR_ZA_SHIFT, check_sm_in
@@ -172,7 +177,7 @@ wait_for_writes:
 	adrp	x6, sme_vl_out
 	str	x11, [x6, :lo12:sme_vl_out]
 
-	mrs	x7, S3_3_C4_C2_2
+	mrs	x7, REG_SVCR
 	adrp	x6, svcr_out
 	str	x7, [x6, :lo12:svcr_out]
 
@@ -276,7 +281,7 @@ wait_for_reads:
 
 	// Ensure we don't leave ourselves in streaming mode
 	tbz	x0, #HAVE_SME_SHIFT, out
-	msr	S3_3_C4_C2_2, xzr
+	msr	REG_SVCR, xzr
 
 out:
 	ldp	x11, x12, [sp, #-0x10]
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index d96af27487fa642e94ecc971f53cb78c233e7b44..22d52a75ac9687673c4354f66abcf7204ce17875 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -27,6 +27,8 @@
 #include <asm/sve_context.h>
 #include <asm/ptrace.h>
 
+#include <asm/sysreg.h>
+
 #include "../../kselftest.h"
 
 #include "fp-ptrace.h"
diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.h b/tools/testing/selftests/arm64/fp/fp-ptrace.h
index 36ca627e1980f6a384d9ed0f2e9d4bd32d90f893..a3849817cf4ee23879da835cb7f66821b5e09bd0 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.h
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.h
@@ -4,11 +4,7 @@
 #ifndef FP_PTRACE_H
 #define FP_PTRACE_H
 
-#define SVCR_SM_SHIFT 0
-#define SVCR_ZA_SHIFT 1
-
-#define SVCR_SM (1 << SVCR_SM_SHIFT)
-#define SVCR_ZA (1 << SVCR_ZA_SHIFT)
+#include <asm/sysreg.h>
 
 #define HAVE_SVE_SHIFT		0
 #define HAVE_SME_SHIFT		1
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index fff60e2a25addfd4850ef71aa3cf6535ac880ffd..20da6398f98afaa410d81b2d776643b4d7716f35 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -10,6 +10,7 @@
 // (leave it running for as long as you want...)
 // kill $pids
 
+#include <asm/sysreg.h>
 #include <asm/unistd.h>
 #include "assembler.h"
 #include "asm-offsets.h"
@@ -474,7 +475,7 @@ function _start
 //	svc	#0
 
 #ifdef SSVE
-	mrs	x0, S3_3_C4_C2_2	// SVCR should have ZA=0,SM=1
+	mrs	x0, REG_SVCR	// SVCR should have ZA=0,SM=1
 	and	x1, x0, #3
 	cmp	x1, #1
 	b.ne	svcr_barf
@@ -516,7 +517,7 @@ function barf
 	mov	x12, x2	// data size
 
 #ifdef SSVE
-	mrs	x13, S3_3_C4_C2_2
+	mrs	x13, REG_SVCR
 #endif
 
 	puts	"Mismatch: PID="
diff --git a/tools/testing/selftests/arm64/fp/za-fork-asm.S b/tools/testing/selftests/arm64/fp/za-fork-asm.S
index 2fafadd491c326a31d6193551d6b26835ac7ade0..13d882ec40f2f5ab9fb6ab776e9a3e498594680d 100644
--- a/tools/testing/selftests/arm64/fp/za-fork-asm.S
+++ b/tools/testing/selftests/arm64/fp/za-fork-asm.S
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (C) 2021 ARM Limited.
 
+#include <asm/sysreg.h>
 #include "sme-inst.h"
 
 .arch_extension sve
@@ -35,7 +36,7 @@ fork_test:
 .globl verify_fork
 verify_fork:
 	// SVCR should have ZA=1, SM=0
-	mrs	x0, S3_3_C4_C2_2
+	mrs	x0, REG_SVCR
 	and	x1, x0, #3
 	cmp	x1, #2
 	beq	1f
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 095b45531640966e685408057c08ada67e68998b..fc8e1f47d6463efd8e59221b14b2502e960e64c4 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -10,6 +10,8 @@
 // (leave it running for as long as you want...)
 // kill $pids
 
+
+#include <asm/sysreg.h>
 #include <asm/unistd.h>
 #include "assembler.h"
 #include "asm-offsets.h"
@@ -305,7 +307,7 @@ function _start
 1:
 	svc	#0
 
-	mrs	x0, S3_3_C4_C2_2	// SVCR should have ZA=1,SM=0
+	mrs	x0, REG_SVCR	// SVCR should have ZA=1,SM=0
 	and	x1, x0, #3
 	cmp	x1, #2
 	b.ne	svcr_barf
@@ -334,7 +336,7 @@ function barf
 //	svc	#0
 // end hack
 
-	mrs	x13, S3_3_C4_C2_2
+	mrs	x13, REG_SVCR
 
 	smstop
 	mov	x10, x0	// expected data
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index b5c81e81a37946c1bffe810568855939e9ceb08e..0066ba3d5818beda9901bead8725d3909714ddeb 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -6,6 +6,7 @@
 // Repeatedly writes unique test patterns into ZT0
 // and reads them back to verify integrity.
 
+#include <asm/sysreg.h>
 #include <asm/unistd.h>
 #include "assembler.h"
 #include "asm-offsets.h"
@@ -244,7 +245,7 @@ function _start
 	mov	x8, #__NR_sched_yield	// Encourage preemption
 	svc	#0
 
-	mrs	x0, S3_3_C4_C2_2	// SVCR should have ZA=1,SM=0
+	mrs	x0, REG_SVCR	// SVCR should have ZA=1,SM=0
 	and	x1, x0, #3
 	cmp	x1, #2
 	b.ne	svcr_barf
@@ -268,7 +269,7 @@ function barf
 //	svc	#0
 // end hack
 
-	mrs	x13, S3_3_C4_C2_2
+	mrs	x13, REG_SVCR
 	smstop
 	mov	x10, x0	// expected data
 	mov	x11, x1	// actual data

-- 
2.39.2


