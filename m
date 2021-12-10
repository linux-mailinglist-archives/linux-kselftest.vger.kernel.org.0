Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4602470939
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbhLJStF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:49:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49748 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhLJStE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:49:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B9E3B82957
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EB9C341C7;
        Fri, 10 Dec 2021 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161927;
        bh=UolwcvH1N1k437yFBrJuUERuvzNNH4cDCoX9zvns2JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxDsKM7dwqHl02CTXQlurUmF+JRQX9GfYZqtgmDHWr2VE/H05ZNXWFylXk7YFUFcx
         xqrNF9NbYry8W7cFW6+5326xMuzmkUNmleqg5xxAjsJfK9hwY20E2+Ky8+AowcvC7P
         ekxRnS+PfMn7UHcm0StU3WWxH4d7tL3N+CYkIcEmd31Fyr2BWaCV/isVwTt0+ANB7h
         Dln1fDWRotm0sNuB+S3jHJudqZTFR2WmESLMtXrFwYWbpHjXih3QDtzVv2eymt7qgT
         JYuN5ljqes9puRso8N/Ut1r7jhSwVqM4xRSlL4dZ00duwZ3tJGuWuxsPP8QNhsHLn/
         6dSOquzjtdNxA==
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
Subject: [PATCH v7 37/37] kselftest/arm64: Add SME support to syscall ABI test
Date:   Fri, 10 Dec 2021 18:41:33 +0000
Message-Id: <20211210184133.320748-38-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15036; h=from:subject; bh=UolwcvH1N1k437yFBrJuUERuvzNNH4cDCoX9zvns2JE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59cgQbEOp6knWICMIgDRkmzMEeks8h0uB5PzdN1 zOU+iiKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfXAAKCRAk1otyXVSH0C1yB/ 0XY7y3LBoGeOC4VKudngTIEfNWYjjK6r+LyyEJSEiyzx/3UpndwsfDHU46W6KaAT+NKS9JG4B5V7lA v5Jo+5Qo0QdgIz1xel4WZl8eClrL0kXUTKit16fT3Smt9d4KD5csDAHv0VokRj3h7vL5MmBXH/NyY0 YavhSyJygVIuf36BYmf0F6rtZ4Vg32hHbzBW1DtXF6H6F1ABLWnuIP9dKdgS1eK7wp9hhgvgxomUA8 E3iXlkolhFMGRvw+NNzG28u1PQfF75n320204crU6sbsps8UzzCnXDR2io9xASKV86K3bRVoKaNJJe mdrFWllZLoR87RKBCN7VgJTHbKLv21
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For every possible combination of SVE and SME vector length verify that for
each possible value of SVCR after a syscall we leave streaming mode and ZA
is preserved. We don't need to take account of any streaming/non streaming
SVE vector length changes in the assembler code since the store instructions
will handle the vector length for us. We log if the system supports FA64 and
only try to set FFR in streaming mode if it does.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/abi/syscall-abi-asm.S     |  69 +++++-
 .../testing/selftests/arm64/abi/syscall-abi.c | 204 ++++++++++++++++--
 .../testing/selftests/arm64/abi/syscall-abi.h |  15 ++
 3 files changed, 265 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.h

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
index 983467cfcee0..bc70e04224bf 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
+++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
@@ -9,15 +9,42 @@
 // invoked is configured in x8 of the input GPR data.
 //
 // x0:	SVE VL, 0 for FP only
+// x1:	SME VL
 //
 //	GPRs:	gpr_in, gpr_out
 //	FPRs:	fpr_in, fpr_out
 //	Zn:	z_in, z_out
 //	Pn:	p_in, p_out
 //	FFR:	ffr_in, ffr_out
+//	ZA:	za_in, za_out
+//	SVCR:	svcr_in, svcr_out
+
+#include "syscall-abi.h"
 
 .arch_extension sve
 
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
 .globl do_syscall
 do_syscall:
 	// Store callee saved registers x19-x29 (80 bytes) plus x0 and x1
@@ -30,6 +57,24 @@ do_syscall:
 	stp	x25, x26, [sp, #80]
 	stp	x27, x28, [sp, #96]
 
+	// Set SVCR if we're doing SME
+	cbz	x1, 1f
+	adrp	x2, svcr_in
+	ldr	x2, [x2, :lo12:svcr_in]
+	msr	S3_3_C4_C2_2, x2
+1:
+
+	// Load ZA if it's enabled - uses x12 as scratch due to SME LDR
+	tbz	x2, #SVCR_ZA_SHIFT, 1f
+	mov	w12, #0
+	ldr	x2, =za_in
+2:	_ldr_za 12, 2
+	add	x2, x2, x1
+	add	x12, x12, #1
+	cmp	x1, x12
+	bne	2b
+1:
+
 	// Load GPRs x8-x28, and save our SP/FP for later comparison
 	ldr	x2, =gpr_in
 	add	x2, x2, #64
@@ -68,7 +113,7 @@ do_syscall:
 	ldp	q30, q31, [x2, #16 * 30]
 1:
 
-	// Load the SVE registers if we're doing SVE
+	// Load the SVE registers if we're doing SVE/SME
 	cbz	x0, 1f
 
 	ldr	x2, =z_in
@@ -105,9 +150,13 @@ do_syscall:
 	ldr	z30, [x2, #30, MUL VL]
 	ldr	z31, [x2, #31, MUL VL]
 
+	// Only set a non-zero FFR, test patterns must be zero since the
+	// syscall should clear it - this lets us handle FA64.
 	ldr	x2, =ffr_in
+	cbz	x2, 2f
 	ldr	p0, [x2, #0]
 	wrffr	p0.b
+2:
 
 	ldr	x2, =p_in
 	ldr	p0, [x2, #0, MUL VL]
@@ -169,6 +218,24 @@ do_syscall:
 	stp	q28, q29, [x2, #16 * 28]
 	stp	q30, q31, [x2, #16 * 30]
 
+	// Save SVCR if we're doing SME
+	cbz	x1, 1f
+	mrs	x2, S3_3_C4_C2_2
+	adrp	x3, svcr_out
+	str	x2, [x3, :lo12:svcr_out]
+1:
+
+	// Save ZA if it's enabled - uses x12 as scratch due to SME STR
+	tbz	x2, #SVCR_ZA_SHIFT, 1f
+	mov	w12, #0
+	ldr	x2, =za_out
+2:	_str_za 12, 2
+	add	x2, x2, x1
+	add	x12, x12, #1
+	cmp	x1, x12
+	bne	2b
+1:
+
 	// Save the SVE state if we have some
 	cbz	x0, 1f
 
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index d8eeeafb50dc..a373f4c38d31 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -18,10 +18,14 @@
 
 #include "../../kselftest.h"
 
+#include "syscall-abi.h"
+
 #define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
 #define NUM_VL ((SVE_VQ_MAX - SVE_VQ_MIN) + 1)
 
-extern void do_syscall(int sve_vl);
+static int default_sme_vl;
+
+extern void do_syscall(int sve_vl, int sme_vl);
 
 static void fill_random(void *buf, size_t size)
 {
@@ -49,14 +53,15 @@ static struct syscall_cfg {
 uint64_t gpr_in[NUM_GPR];
 uint64_t gpr_out[NUM_GPR];
 
-static void setup_gpr(struct syscall_cfg *cfg, int sve_vl)
+static void setup_gpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		      uint64_t svcr)
 {
 	fill_random(gpr_in, sizeof(gpr_in));
 	gpr_in[8] = cfg->syscall_nr;
 	memset(gpr_out, 0, sizeof(gpr_out));
 }
 
-static int check_gpr(struct syscall_cfg *cfg, int sve_vl)
+static int check_gpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl, uint64_t svcr)
 {
 	int errors = 0;
 	int i;
@@ -80,13 +85,15 @@ static int check_gpr(struct syscall_cfg *cfg, int sve_vl)
 uint64_t fpr_in[NUM_FPR * 2];
 uint64_t fpr_out[NUM_FPR * 2];
 
-static void setup_fpr(struct syscall_cfg *cfg, int sve_vl)
+static void setup_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		      uint64_t svcr)
 {
 	fill_random(fpr_in, sizeof(fpr_in));
 	memset(fpr_out, 0, sizeof(fpr_out));
 }
 
-static int check_fpr(struct syscall_cfg *cfg, int sve_vl)
+static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		     uint64_t svcr)
 {
 	int errors = 0;
 	int i;
@@ -110,13 +117,15 @@ static uint8_t z_zero[__SVE_ZREG_SIZE(SVE_VQ_MAX)];
 uint8_t z_in[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
 uint8_t z_out[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
 
-static void setup_z(struct syscall_cfg *cfg, int sve_vl)
+static void setup_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		    uint64_t svcr)
 {
 	fill_random(z_in, sizeof(z_in));
 	fill_random(z_out, sizeof(z_out));
 }
 
-static int check_z(struct syscall_cfg *cfg, int sve_vl)
+static int check_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		   uint64_t svcr)
 {
 	size_t reg_size = sve_vl;
 	int errors = 0;
@@ -127,13 +136,17 @@ static int check_z(struct syscall_cfg *cfg, int sve_vl)
 
 	/*
 	 * After a syscall the low 128 bits of the Z registers should
-	 * be preserved and the rest be zeroed or preserved.
+	 * be preserved and the rest be zeroed or preserved, except if
+	 * we were in streaming mode in which case the low 128 bits may
+	 * also be cleared by the transition out of streaming mode.
 	 */
 	for (i = 0; i < SVE_NUM_ZREGS; i++) {
 		void *in = &z_in[reg_size * i];
 		void *out = &z_out[reg_size * i];
 
-		if (memcmp(in, out, SVE_VQ_BYTES) != 0) {
+		if ((memcmp(in, out, SVE_VQ_BYTES) != 0) &&
+		    !((svcr & SVCR_SM_MASK) &&
+		      memcmp(z_zero, out, SVE_VQ_BYTES) == 0)) {
 			ksft_print_msg("%s SVE VL %d Z%d low 128 bits changed\n",
 				       cfg->name, sve_vl, i);
 			errors++;
@@ -146,13 +159,15 @@ static int check_z(struct syscall_cfg *cfg, int sve_vl)
 uint8_t p_in[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
 uint8_t p_out[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
 
-static void setup_p(struct syscall_cfg *cfg, int sve_vl)
+static void setup_p(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		    uint64_t svcr)
 {
 	fill_random(p_in, sizeof(p_in));
 	fill_random(p_out, sizeof(p_out));
 }
 
-static int check_p(struct syscall_cfg *cfg, int sve_vl)
+static int check_p(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		   uint64_t svcr)
 {
 	size_t reg_size = sve_vq_from_vl(sve_vl) * 2; /* 1 bit per VL byte */
 
@@ -176,8 +191,19 @@ static int check_p(struct syscall_cfg *cfg, int sve_vl)
 uint8_t ffr_in[__SVE_PREG_SIZE(SVE_VQ_MAX)];
 uint8_t ffr_out[__SVE_PREG_SIZE(SVE_VQ_MAX)];
 
-static void setup_ffr(struct syscall_cfg *cfg, int sve_vl)
+static void setup_ffr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		      uint64_t svcr)
 {
+	/*
+	 * If we are in streaming mode and do not have FA64 then FFR
+	 * is unavailable.
+	 */
+	if ((svcr & SVCR_SM_MASK) &&
+	    !(getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)) {
+		memset(&ffr_in, 0, sizeof(ffr_in));
+		return;
+	}
+
 	/*
 	 * It is only valid to set a contiguous set of bits starting
 	 * at 0.  For now since we're expecting this to be cleared by
@@ -187,7 +213,8 @@ static void setup_ffr(struct syscall_cfg *cfg, int sve_vl)
 	fill_random(ffr_out, sizeof(ffr_out));
 }
 
-static int check_ffr(struct syscall_cfg *cfg, int sve_vl)
+static int check_ffr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		     uint64_t svcr)
 {
 	size_t reg_size = sve_vq_from_vl(sve_vl) * 2;  /* 1 bit per VL byte */
 	int errors = 0;
@@ -196,6 +223,10 @@ static int check_ffr(struct syscall_cfg *cfg, int sve_vl)
 	if (!sve_vl)
 		return 0;
 
+	if ((svcr & SVCR_SM_MASK) &&
+	    !(getauxval(AT_HWCAP2) & HWCAP2_SME_FA64))
+		return 0;
+
 	/* After a syscall the P registers should be preserved or zeroed */
 	for (i = 0; i < reg_size; i++)
 		if (ffr_out[i] && (ffr_in[i] != ffr_out[i]))
@@ -207,8 +238,65 @@ static int check_ffr(struct syscall_cfg *cfg, int sve_vl)
 	return errors;
 }
 
-typedef void (*setup_fn)(struct syscall_cfg *cfg, int sve_vl);
-typedef int (*check_fn)(struct syscall_cfg *cfg, int sve_vl);
+uint64_t svcr_in, svcr_out;
+
+static void setup_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		    uint64_t svcr)
+{
+	svcr_in = svcr;
+}
+
+static int check_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		      uint64_t svcr)
+{
+	int errors = 0;
+
+	if (svcr_out & SVCR_SM_MASK) {
+		ksft_print_msg("%s Still in SM, SVCR %llx\n",
+			       cfg->name, svcr_out);
+		errors++;
+	}
+
+	if ((svcr_in & SVCR_ZA_MASK) != (svcr_out & SVCR_ZA_MASK)) {
+		ksft_print_msg("%s PSTATE.ZA changed, SVCR %llx != %llx\n",
+			       cfg->name, svcr_in, svcr_out);
+		errors++;
+	}
+
+	return errors;
+}
+
+uint8_t za_in[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+uint8_t za_out[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+
+static void setup_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		     uint64_t svcr)
+{
+	fill_random(za_in, sizeof(za_in));
+	memset(za_out, 0, sizeof(za_out));
+}
+
+static int check_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		    uint64_t svcr)
+{
+	size_t reg_size = sme_vl * sme_vl;
+	int errors = 0;
+
+	if (!(svcr & SVCR_ZA_MASK))
+		return 0;
+
+	if (memcmp(za_in, za_out, reg_size) != 0) {
+		ksft_print_msg("SME VL %d ZA does not match\n", sme_vl);
+		errors++;
+	}
+
+	return errors;
+}
+
+typedef void (*setup_fn)(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+			 uint64_t svcr);
+typedef int (*check_fn)(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+			uint64_t svcr);
 
 /*
  * Each set of registers has a setup function which is called before
@@ -226,20 +314,23 @@ static struct {
 	{ setup_z, check_z },
 	{ setup_p, check_p },
 	{ setup_ffr, check_ffr },
+	{ setup_svcr, check_svcr },
+	{ setup_za, check_za },
 };
 
-static bool do_test(struct syscall_cfg *cfg, int sve_vl)
+static bool do_test(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
+		    uint64_t svcr)
 {
 	int errors = 0;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(regset); i++)
-		regset[i].setup(cfg, sve_vl);
+		regset[i].setup(cfg, sve_vl, sme_vl, svcr);
 
-	do_syscall(sve_vl);
+	do_syscall(sve_vl, sme_vl);
 
 	for (i = 0; i < ARRAY_SIZE(regset); i++)
-		errors += regset[i].check(cfg, sve_vl);
+		errors += regset[i].check(cfg, sve_vl, sme_vl, svcr);
 
 	return errors == 0;
 }
@@ -247,9 +338,10 @@ static bool do_test(struct syscall_cfg *cfg, int sve_vl)
 static void test_one_syscall(struct syscall_cfg *cfg)
 {
 	int sve_vq, sve_vl;
+	int sme_vq, sme_vl;
 
 	/* FPSIMD only case */
-	ksft_test_result(do_test(cfg, 0),
+	ksft_test_result(do_test(cfg, 0, default_sme_vl, 0),
 			 "%s FPSIMD\n", cfg->name);
 
 	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
@@ -266,8 +358,36 @@ static void test_one_syscall(struct syscall_cfg *cfg)
 		if (sve_vq != sve_vq_from_vl(sve_vl))
 			sve_vq = sve_vq_from_vl(sve_vl);
 
-		ksft_test_result(do_test(cfg, sve_vl),
+		ksft_test_result(do_test(cfg, sve_vl, default_sme_vl, 0),
 				 "%s SVE VL %d\n", cfg->name, sve_vl);
+
+		if (!(getauxval(AT_HWCAP2) & HWCAP2_SME))
+			continue;
+
+		for (sme_vq = SVE_VQ_MAX; sme_vq > 0; --sme_vq) {
+			sme_vl = prctl(PR_SME_SET_VL, sme_vq * 16);
+			if (sme_vl == -1)
+				ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",
+						   strerror(errno), errno);
+
+			sme_vl &= PR_SME_VL_LEN_MASK;
+
+			if (sme_vq != sve_vq_from_vl(sme_vl))
+				sme_vq = sve_vq_from_vl(sme_vl);
+
+			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
+						 SVCR_ZA_MASK | SVCR_SM_MASK),
+					 "%s SVE VL %d/SME VL %d SM+ZA\n",
+					 cfg->name, sve_vl, sme_vl);
+			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
+						 SVCR_SM_MASK),
+					 "%s SVE VL %d/SME VL %d SM\n",
+					 cfg->name, sve_vl, sme_vl);
+			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
+						 SVCR_ZA_MASK),
+					 "%s SVE VL %d/SME VL %d ZA\n",
+					 cfg->name, sve_vl, sme_vl);
+		}
 	}
 }
 
@@ -300,14 +420,54 @@ int sve_count_vls(void)
 	return vl_count;
 }
 
+int sme_count_vls(void)
+{
+	unsigned int vq;
+	int vl_count = 0;
+	int vl;
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_SME))
+		return 0;
+
+	/* Ensure we configure a SME VL, used to flag if SVCR is set */
+	default_sme_vl = 16;
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(PR_SME_SET_VL, vq * 16);
+		if (vl == -1)
+			ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",
+					   strerror(errno), errno);
+
+		vl &= PR_SME_VL_LEN_MASK;
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
 int main(void)
 {
 	int i;
+	int tests = 1;  /* FPSIMD */
 
 	srandom(getpid());
 
 	ksft_print_header();
-	ksft_set_plan(ARRAY_SIZE(syscalls) * (sve_count_vls() + 1));
+	tests += sve_count_vls();
+	tests += (sve_count_vls() * sme_count_vls()) * 3;
+	ksft_set_plan(ARRAY_SIZE(syscalls) * tests);
+
+	if (getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)
+		ksft_print_msg("SME with FA64\n");
+	else if (getauxval(AT_HWCAP2) & HWCAP2_SME)
+		ksft_print_msg("SME without FA64\n");
 
 	for (i = 0; i < ARRAY_SIZE(syscalls); i++)
 		test_one_syscall(&syscalls[i]);
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.h b/tools/testing/selftests/arm64/abi/syscall-abi.h
new file mode 100644
index 000000000000..bda5a87ad381
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 ARM Limited.
+ */
+
+#ifndef SYSCALL_ABI_H
+#define SYSCALL_ABI_H
+
+#define SVCR_ZA_MASK		2
+#define SVCR_SM_MASK		1
+
+#define SVCR_ZA_SHIFT		1
+#define SVCR_SM_SHIFT		0
+
+#endif
-- 
2.30.2

