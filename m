Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4476263D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKKVvc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiKKVvW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85C06B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B3C62101
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90511C4347C;
        Fri, 11 Nov 2022 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203480;
        bh=mpO5Qxgy63SzKSm0Pa637DSx9B/LwRyQmrBGvfcgjI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmyoWVWbRv2nrRTMu1D8OJOrAevPfkCUEPJEXOFBvqmMZLbxWtdZoA+NwhQxsel4o
         aRDGee5U4VOYt0IGtS3H169YeGwVD3ZRTOPuBaIyun1zpNyG6KwFBU/0hGdyRALeSG
         qz4PTImaIzMSV3F3JG0r9AOg3DMWLvP6RM9Mv+pprxIp8HHkSEmg/XDs/ebCPMsL3P
         lRSz62rSdOSBLu/jlgdkV+MYolLjUsT6iaIKLcmFnbujUlvgz61eiWGqD46Nx8dyaE
         3LdX/zstfCfDKWZO6G/9FTgsKl7SE6GWrS2ZIpV5moTZNjPPkhfezRvSNX6E/ZSWl/
         JpyqDiHP6B4xQ==
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
Subject: [PATCH v3 10/21] arm64/sme: Implement context switching for ZT0
Date:   Fri, 11 Nov 2022 21:50:15 +0000
Message-Id: <20221111215026.813348-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458; i=broonie@kernel.org; h=from:subject; bh=mpO5Qxgy63SzKSm0Pa637DSx9B/LwRyQmrBGvfcgjI4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOWdc/EIKP8qquj4JHn1sObOtN20Fi7cMiGER7Z YGdTDF+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DlgAKCRAk1otyXVSH0OXeB/ 9D2Kxn/5Sei0T3TbbFhzDxv8a0JSD8rDJKYfcj6gpDfpvwFVFakazcYPGA8GycXJqSBUCS3tHFJ1Po 1Mu04rNQTAIHSj1V4rBD9U+G+dNqtGAMfic9yHnYj+9oEE8QiUAtfMBUJ4TV+opf3wpGLA6nLPSc8Z fz67vhF+v8urzTnxgD1P4vrbEF8TPJAgrhl2Bv3EpERbQZSggTj8M07iSW8wEhXatZG3bFyRJayup0 lZXBcbfXIR5GEKsseFmHxBccPp30ZqJKDDFbCXWdqDsJMkyPllCuSj9SoB3ee3OQPeBfRfoUJINnp5 oVauBiraWzT+RxwjOpV5l/h6u5ehdw
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

