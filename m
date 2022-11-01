Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0F614CD4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKAOjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKAOjn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C61120B8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A3EB81DE7
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445DAC43470;
        Tue,  1 Nov 2022 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313580;
        bh=mpO5Qxgy63SzKSm0Pa637DSx9B/LwRyQmrBGvfcgjI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLPY8ISrAQM1IcwRt+e6glqWUD4UUhWhbIfjpBl7fu1hVoRp0auxf45pkcsIsfPV+
         YuNBH7rLjoU1njZ3N5WF09uX6Uv0U5dvYgaIg+BsrQfWmnLuu3hy4HEOUk275yDy3p
         GIdBFV40FNfzrmrtiqvet2IIampGYnC0pu2iCfqb/+AGTabfHzstiGCCUaqR3i7kD2
         UpqeW7pW3j1des7NTmgxnLH3WzexI+FmS6C5+zVxGpmwgxeaimnakAk7az1/li5eT4
         zC9Oi+mjmeM56noZGYbos3u8oJX7Jkgg1MJSuCoLoQmAGKG4YSqzjHsijM54SxMiIv
         oF1yxJrg8Qqlg==
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
Subject: [PATCH v2 10/21] arm64/sme: Implement context switching for ZT0
Date:   Tue,  1 Nov 2022 14:33:25 +0000
Message-Id: <20221101143336.254445-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458; i=broonie@kernel.org; h=from:subject; bh=mpO5Qxgy63SzKSm0Pa637DSx9B/LwRyQmrBGvfcgjI4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4zdc/EIKP8qquj4JHn1sObOtN20Fi7cMiGER7Z YGdTDF+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuMwAKCRAk1otyXVSH0Hf9B/ sHUWBhFbCQTvgxgLRDQoO7uP6trnWCTyLZO0xGyJZitVcAyW2R7Cl7iOgTzSHb/4M7P1lLr45PFvjE 8ho8gFv1Wb2/pJKMz9JgkiI0xS8/Tsp/ab1cfxsSGVYKtPKjYCz9xnGbT+EhmrOehJJ2AeNt/dVqPY HNosuaKzdoPfua7xFrvsUXi6otS+pztyhURNBEuetf4vzsolyij0h4X/7CDjBatHjRW8M+Jcl5vhDS MJR5XTNdTQKvqSYcSnF7uSZhqj5YG9oq7bkmkmj1b86rCtoWQcxRzWW7qqvS/FCXDu9enol1E/mzIy SBdGSLufIdkXeYbwOpocSvtTHgxHWb
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the system supports SME2 the ZT0 register must be context switched as
part of the floating point state. This register is stored immediately
after ZA in memory and is only accessible when PSTATE.ZA is set so we
handle it in the same functions we use to save and restore ZA.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h  |  4 ++--
 arch/arm64/kernel/entry-fpsimd.S | 30 ++++++++++++++++++++----------
 arch/arm64/kernel/fpsimd.c       |  6 ++++--
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 2d7a69b49349..42c019936dfd 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -110,8 +110,8 @@ extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
 extern void sme_set_vq(unsigned long vq_minus_1);
-extern void za_save_state(void *state);
-extern void za_load_state(void const *state);
+extern void sme_save_state(void *state, int zt);
+extern void sme_load_state(void const *state, int zt);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 229436f33df5..6325db1a2179 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -100,25 +100,35 @@ SYM_FUNC_START(sme_set_vq)
 SYM_FUNC_END(sme_set_vq)
 
 /*
- * Save the SME state
+ * Save the ZA and ZT state
  *
  * x0 - pointer to buffer for state
+ * x1 - number of ZT registers to save
  */
-SYM_FUNC_START(za_save_state)
-	_sme_rdsvl	1, 1		// x1 = VL/8
-	sme_save_za 0, x1, 12
+SYM_FUNC_START(sme_save_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_str_zt 0
+1:
 	ret
-SYM_FUNC_END(za_save_state)
+SYM_FUNC_END(sme_save_state)
 
 /*
- * Load the SME state
+ * Load the ZA and ZT state
  *
  * x0 - pointer to buffer for state
+ * x1 - number of ZT registers to save
  */
-SYM_FUNC_START(za_load_state)
-	_sme_rdsvl	1, 1		// x1 = VL/8
-	sme_load_za 0, x1, 12
+SYM_FUNC_START(sme_load_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_load_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_ldr_zt 0
+1:
 	ret
-SYM_FUNC_END(za_load_state)
+SYM_FUNC_END(sme_load_state)
 
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 73ec8850a402..b7f4eef42f86 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -396,7 +396,8 @@ static void task_fpsimd_load(void)
 		write_sysreg_s(current->thread.svcr, SYS_SVCR);
 
 		if (thread_za_enabled(&current->thread))
-			za_load_state(current->thread.sme_state);
+			sme_load_state(current->thread.sme_state,
+				       system_supports_sme2());
 
 		if (thread_sm_enabled(&current->thread)) {
 			restore_sve_regs = true;
@@ -449,7 +450,8 @@ static void fpsimd_save(void)
 		*svcr = read_sysreg_s(SYS_SVCR);
 
 		if (*svcr & SVCR_ZA_MASK)
-			za_save_state(last->sme_state);
+			sme_save_state(last->sme_state,
+				       system_supports_sme2());
 
 		/* If we are in streaming mode override regular SVE. */
 		if (*svcr & SVCR_SM_MASK) {
-- 
2.30.2

