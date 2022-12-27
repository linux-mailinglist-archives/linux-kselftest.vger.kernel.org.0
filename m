Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6EE656B3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiL0NHX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiL0NHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:07:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995CE65B5;
        Tue, 27 Dec 2022 05:06:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50BDBB8101B;
        Tue, 27 Dec 2022 13:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CECC433D2;
        Tue, 27 Dec 2022 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146417;
        bh=FkCT7CeF2shSYZvmS/axMpxelhP3SAvkHxuUZYWnJIE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=k5a1Fp6k4JM/SAz6EHZrDATlGxVJpwAplKssCMN8O8AvebKyvYcCtAdUwC07qDSFm
         vucAjfW5pj1FYVcWlZR6RPOdIzAX6GFyOI0HCLFBSde9yUMKZgS4DKXUcFmXsdJH3b
         Qh9FLmMXSIgc6IJUXT1K8mVfYDl5KMhcB5Xn5EKgJaZUd2HFJZeeFZPd3ClO/xkwtm
         zoylAD1FIhx2N8dI6+L/ojdFN5THEbKGvNttpEZmUDncIAsIjVYimf05mq2LjBOFRA
         pFaBKBkwuOgZoQ4z2OnBaZ1GPqKcf1Ivf7LpqR6JMLQfxXpO7ZcaaqZrF+1e6FeQ7C
         jErfN+/fycKoA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 13:06:37 +0000
Subject: [PATCH 3/4] kselftest/arm64: Verify SME only ABI in syscall-abi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221223-arm64-syscall-abi-sme-only-v1-3-4fabfbd62087@kernel.org>
References: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
In-Reply-To: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4483; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FkCT7CeF2shSYZvmS/axMpxelhP3SAvkHxuUZYWnJIE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqu3nf73Pjz+vQrz9xDatgVaakTyMlwkVuTleA8yn
 QhrAwGeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6rt5wAKCRAk1otyXVSH0KlsB/
 9L9rONe+nrYiKbLKgNfpatd8y4qUJPoHXKFp76EtFk1W2vOUxWJmGR8gQw7pv7ZA1BEgKHAZhq8ztl
 Oai4XIY5IbrihK2NWBelkV4ht9yR3KQmtmSDSys4igU/R1r1wFrHzZok9bfpHEqR913n5Iz3oELQrr
 RX64R5rO9svwK+m+N/IGk+oFKIDTli08lldm/CQdTpsNSlwgSJaMg/Gz1BXlSJh5v1gJyasiKdJymr
 ei2i1AvZXOAa8l2rliqSjs839jxsOuprm3cAmnlr8RWNeDtMvnAIDXP0OoxqYEaH7E1i2NeGdVrSET
 c6B9z4vGznErF5BMUsoeMTEiaQxa5C
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently syscall-abi only covers SME in the case where the system supports
SVE however it is architecturally valid to support SME without SVE. Update
the program to cover this case, this requires adjustments in the code to
check for SVCR.SM being set when deciding if we're handling the FPSIMD or
SVE registers and the addition of new test cases for the SME only case.

Note that in the SME only case we should not save the SVE registers after a
syscall since even if we were in streaming mode and therefore set them the
syscall should have exited streaming mode, we check that we have done so by
looking at SVCR.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  | 14 +++++----
 tools/testing/selftests/arm64/abi/syscall-abi.c    | 34 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
index acd5e9f3bc0b..cdfafc939a9e 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
+++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
@@ -92,8 +92,11 @@ do_syscall:
 	str	x29, [x2], #8		// FP
 	str	x30, [x2], #8		// LR
 
-	// Load FPRs if we're not doing SVE
+	// Load FPRs if we're not doing neither SVE nor streaming SVE
 	cbnz	x0, 1f
+	ldr	x2, =svcr_in
+	tbnz	x2, #SVCR_SM_SHIFT, 1f
+
 	ldr	x2, =fpr_in
 	ldp	q0, q1, [x2]
 	ldp	q2, q3, [x2, #16 * 2]
@@ -111,10 +114,11 @@ do_syscall:
 	ldp	q26, q27, [x2, #16 * 26]
 	ldp	q28, q29, [x2, #16 * 28]
 	ldp	q30, q31, [x2, #16 * 30]
+
+	b	2f
 1:
 
 	// Load the SVE registers if we're doing SVE/SME
-	cbz	x0, 1f
 
 	ldr	x2, =z_in
 	ldr	z0, [x2, #0, MUL VL]
@@ -155,9 +159,9 @@ do_syscall:
 	ldr	x2, =ffr_in
 	ldr	p0, [x2]
 	ldr	x2, [x2, #0]
-	cbz	x2, 2f
+	cbz	x2, 1f
 	wrffr	p0.b
-2:
+1:
 
 	ldr	x2, =p_in
 	ldr	p0, [x2, #0, MUL VL]
@@ -176,7 +180,7 @@ do_syscall:
 	ldr	p13, [x2, #13, MUL VL]
 	ldr	p14, [x2, #14, MUL VL]
 	ldr	p15, [x2, #15, MUL VL]
-1:
+2:
 
 	// Do the syscall
 	svc	#0
diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index 45fdcbe3e909..7c9b6e947040 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -88,6 +88,7 @@ static int check_gpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl, uint64_t s
 #define NUM_FPR 32
 uint64_t fpr_in[NUM_FPR * 2];
 uint64_t fpr_out[NUM_FPR * 2];
+uint64_t fpr_zero[NUM_FPR * 2];
 
 static void setup_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		      uint64_t svcr)
@@ -102,7 +103,7 @@ static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	int errors = 0;
 	int i;
 
-	if (!sve_vl) {
+	if (!sve_vl && !(svcr & SVCR_SM_MASK)) {
 		for (i = 0; i < ARRAY_SIZE(fpr_in); i++) {
 			if (fpr_in[i] != fpr_out[i]) {
 				ksft_print_msg("%s Q%d/%d mismatch %llx != %llx\n",
@@ -114,6 +115,18 @@ static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		}
 	}
 
+	/*
+	 * In streaming mode the whole register set should be cleared
+	 * by the transition out of streaming mode.
+	 */
+	if (svcr & SVCR_SM_MASK) {
+		if (memcmp(fpr_zero, fpr_out, sizeof(fpr_out)) != 0) {
+			ksft_print_msg("%s FPSIMD registers non-zero exiting SM\n",
+				       cfg->name);
+			errors++;
+		}
+	}
+
 	return errors;
 }
 
@@ -400,6 +413,24 @@ static void test_one_syscall(struct syscall_cfg *cfg)
 					 sme_vls[sme]);
 		}
 	}
+
+	for (sme = 0; sme < sme_vl_count; sme++) {
+		ret = prctl(PR_SME_SET_VL, sme_vls[sme]);
+		if (ret == -1)
+			ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",
+						   strerror(errno), errno);
+
+		ksft_test_result(do_test(cfg, 0, sme_vls[sme],
+					 SVCR_ZA_MASK | SVCR_SM_MASK),
+				 "%s SME VL %d SM+ZA\n",
+				 cfg->name, sme_vls[sme]);
+		ksft_test_result(do_test(cfg, 0, sme_vls[sme], SVCR_SM_MASK),
+				 "%s SME VL %d SM\n",
+				 cfg->name, sme_vls[sme]);
+		ksft_test_result(do_test(cfg, 0, sme_vls[sme], SVCR_ZA_MASK),
+				 "%s SME VL %d ZA\n",
+				 cfg->name, sme_vls[sme]);
+	}
 }
 
 void sve_count_vls(void)
@@ -474,6 +505,7 @@ int main(void)
 	sme_count_vls();
 
 	tests += sve_vl_count;
+	tests += sme_vl_count * 3;
 	tests += (sve_vl_count * sme_vl_count) * 3;
 	ksft_set_plan(ARRAY_SIZE(syscalls) * tests);
 

-- 
2.30.2
