Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5C4F94B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiDHL54 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDHL5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:57:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67303710D2
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAD86B82A8B
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2864AC385A1;
        Fri,  8 Apr 2022 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418947;
        bh=aB4RUHNE8BFJH6TJICHL7roJkLxwMZDlImHsGy2yaJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryaCQkovWwc3Vfzw1+T0pauyx4xRUFWMoJn8iK5cJrzsl1aX3BlrsYYoomRf6uIu/
         p++uSiEkPjHqgEENRA4bslYYzHuWj8D1wzodylHlLIsqbaErNWVSKEFx+QuKIsOkUt
         0mPykYuIMfhUDcI5T5nB+JXkASOaqt5WKoJXpaDq8VEgjbjp1F/AmN+bakiSCTr8NN
         AcJ+kDy5H4XGHpP9vo5jOmln72aVy/z/NSkBw9HBYHKHoEjcxBlk9DItWMBz+BfQD2
         m9UzTi/gFrenh4A4o1fDgM/4A/EUjHVPlcW+JN92gfez1qVpcyJfQgjtFTwZ5NmK61
         0CLB3Df4rWgZQ==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 08/39] arm64/sme: Basic enumeration support
Date:   Fri,  8 Apr 2022 12:42:57 +0100
Message-Id: <20220408114328.1401034-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13607; h=from:subject; bh=aB4RUHNE8BFJH6TJICHL7roJkLxwMZDlImHsGy2yaJ8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/FnmESGbj/RgErqeWfBkgjubVj8dfZx1HbULdA Hql+g6qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfxQAKCRAk1otyXVSH0PWeB/ 4/2bP48PT12Fx7N4YnVnpixxsLzfOExWyY3SVeN2we9GNlocsB/BsuLnMbmPeE57RlBbtT6euYRgQO zR61m9Yatbyq/w+I6yR2Tpe17ZjviCkW7yute9E09l4umC+U9xRD2ssmZHh41NiTnB9epdrkdhe4x+ C5weGEot8Ij5GJllkynwwKPgEYJAoN0sBGJ87AwEOcSPfT+jBCrHfXOxDZeesZBAnwjbS/ZWgY5x4C 6+6le3+0WQm3YvqlkCeBLmG1llAVpLS/vn+NN5sRGesBjBSMJEH1tckqgmU/c43MvGf6S94+8/iI2w 0xd90G8outSe9TWuca88qcdV9IMTiS
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

This patch introduces basic cpufeature support for discovering the presence
of the Scalable Matrix Extension.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/elf_hwcaps.rst  | 33 ++++++++++++++++
 arch/arm64/include/asm/cpu.h        |  1 +
 arch/arm64/include/asm/cpufeature.h | 12 ++++++
 arch/arm64/include/asm/fpsimd.h     |  2 +
 arch/arm64/include/asm/hwcap.h      |  8 ++++
 arch/arm64/include/uapi/asm/hwcap.h |  8 ++++
 arch/arm64/kernel/cpufeature.c      | 59 +++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  9 +++++
 arch/arm64/kernel/fpsimd.c          | 30 +++++++++++++++
 arch/arm64/tools/cpucaps            |  2 +
 10 files changed, 164 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index a8f30963e550..f8d818eaaff5 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -264,6 +264,39 @@ HWCAP2_MTE3
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0011, as described
     by Documentation/arm64/memory-tagging-extension.rst.
 
+HWCAP2_SME
+
+    Functionality implied by ID_AA64PFR1_EL1.SME == 0b0001, as described
+    by Documentation/arm64/sme.rst.
+
+HWCAP2_SME_I16I64
+
+    Functionality implied by ID_AA64SMFR0_EL1.I16I64 == 0b1111.
+
+HWCAP2_SME_F64F64
+
+    Functionality implied by ID_AA64SMFR0_EL1.F64F64 == 0b1.
+
+HWCAP2_SME_I8I32
+
+    Functionality implied by ID_AA64SMFR0_EL1.I8I32 == 0b1111.
+
+HWCAP2_SME_F16F32
+
+    Functionality implied by ID_AA64SMFR0_EL1.F16F32 == 0b1.
+
+HWCAP2_SME_B16F32
+
+    Functionality implied by ID_AA64SMFR0_EL1.B16F32 == 0b1.
+
+HWCAP2_SME_F32F32
+
+    Functionality implied by ID_AA64SMFR0_EL1.F32F32 == 0b1.
+
+HWCAP2_SME_FA64
+
+    Functionality implied by ID_AA64SMFR0_EL1.FA64 == 0b1.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index a58e366f0b07..d08062bcb9c1 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -58,6 +58,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
 	u64		reg_id_aa64zfr0;
+	u64		reg_id_aa64smfr0;
 
 	struct cpuinfo_32bit	aarch32;
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c62e7e5e2f0c..8ac12e4094aa 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -759,6 +759,18 @@ static __always_inline bool system_supports_sve(void)
 		cpus_have_const_cap(ARM64_SVE);
 }
 
+static __always_inline bool system_supports_sme(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_SME) &&
+		cpus_have_const_cap(ARM64_SME);
+}
+
+static __always_inline bool system_supports_fa64(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_SME) &&
+		cpus_have_const_cap(ARM64_SME_FA64);
+}
+
 static __always_inline bool system_supports_cnp(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_CNP) &&
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 6e2dc9dcbf49..2e8ef00e7520 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -74,6 +74,8 @@ extern void sve_set_vq(unsigned long vq_minus_1);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void fa64_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 8db5ec0089db..9f0ce004fdbc 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -109,6 +109,14 @@
 #define KERNEL_HWCAP_AFP		__khwcap2_feature(AFP)
 #define KERNEL_HWCAP_RPRES		__khwcap2_feature(RPRES)
 #define KERNEL_HWCAP_MTE3		__khwcap2_feature(MTE3)
+#define KERNEL_HWCAP_SME		__khwcap2_feature(SME)
+#define KERNEL_HWCAP_SME_I16I64		__khwcap2_feature(SME_I16I64)
+#define KERNEL_HWCAP_SME_F64F64		__khwcap2_feature(SME_F64F64)
+#define KERNEL_HWCAP_SME_I8I32		__khwcap2_feature(SME_I8I32)
+#define KERNEL_HWCAP_SME_F16F32		__khwcap2_feature(SME_F16F32)
+#define KERNEL_HWCAP_SME_B16F32		__khwcap2_feature(SME_B16F32)
+#define KERNEL_HWCAP_SME_F32F32		__khwcap2_feature(SME_F32F32)
+#define KERNEL_HWCAP_SME_FA64		__khwcap2_feature(SME_FA64)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 99cb5d383048..b0256cec63b5 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -79,5 +79,13 @@
 #define HWCAP2_AFP		(1 << 20)
 #define HWCAP2_RPRES		(1 << 21)
 #define HWCAP2_MTE3		(1 << 22)
+#define HWCAP2_SME		(1 << 23)
+#define HWCAP2_SME_I16I64	(1 << 24)
+#define HWCAP2_SME_F64F64	(1 << 25)
+#define HWCAP2_SME_I8I32	(1 << 26)
+#define HWCAP2_SME_F16F32	(1 << 27)
+#define HWCAP2_SME_B16F32	(1 << 28)
+#define HWCAP2_SME_F32F32	(1 << 29)
+#define HWCAP2_SME_FA64		(1 << 30)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d72c4b4d389c..0f2d7ddd69ae 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -261,6 +261,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SME_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
@@ -293,6 +295,24 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_FA64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_I16I64_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F64F64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_I8I32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F16F32_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_B16F32_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F32F32_SHIFT, 1, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
@@ -645,6 +665,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1,
 			       &id_aa64pfr1_override),
 	ARM64_FTR_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0),
+	ARM64_FTR_REG(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
@@ -960,6 +981,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64SMFR0_EL1, info->reg_id_aa64smfr0);
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
 		init_32bit_cpu_features(&info->aarch32);
@@ -2442,6 +2464,33 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
 	},
+#ifdef CONFIG_ARM64_SME
+	{
+		.desc = "Scalable Matrix Extension",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_SME,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR1_SME_SHIFT,
+		.field_width = 4,
+		.min_field_value = ID_AA64PFR1_SME,
+		.matches = has_cpuid_feature,
+		.cpu_enable = sme_kernel_enable,
+	},
+	/* FA64 should be sorted after the base SME capability */
+	{
+		.desc = "FA64",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_SME_FA64,
+		.sys_reg = SYS_ID_AA64SMFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64SMFR0_FA64_SHIFT,
+		.field_width = 1,
+		.min_field_value = ID_AA64SMFR0_FA64,
+		.matches = has_cpuid_feature,
+		.cpu_enable = fa64_kernel_enable,
+	},
+#endif /* CONFIG_ARM64_SME */
 	{},
 };
 
@@ -2575,6 +2624,16 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_ECV_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(SYS_ID_AA64MMFR1_EL1, ID_AA64MMFR1_AFP_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AFP),
 	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_RPRES_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RPRES),
+#ifdef CONFIG_ARM64_SME
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SME_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR1_SME, CAP_HWCAP, KERNEL_HWCAP_SME),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_FA64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_FA64, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_I16I64_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_I16I64, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_F64F64, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_I8I32_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_I8I32, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_F16F32, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_B16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_B16F32, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F32F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_F32F32, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+#endif /* CONFIG_ARM64_SME */
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 330b92ea863a..a73fe2888b7e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -98,6 +98,14 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_AFP]		= "afp",
 	[KERNEL_HWCAP_RPRES]		= "rpres",
 	[KERNEL_HWCAP_MTE3]		= "mte3",
+	[KERNEL_HWCAP_SME]		= "sme",
+	[KERNEL_HWCAP_SME_I16I64]	= "smei16i64",
+	[KERNEL_HWCAP_SME_F64F64]	= "smef64f64",
+	[KERNEL_HWCAP_SME_I8I32]	= "smei8i32",
+	[KERNEL_HWCAP_SME_F16F32]	= "smef16f32",
+	[KERNEL_HWCAP_SME_B16F32]	= "smeb16f32",
+	[KERNEL_HWCAP_SME_F32F32]	= "smef32f32",
+	[KERNEL_HWCAP_SME_FA64]		= "smefa64",
 };
 
 #ifdef CONFIG_COMPAT
@@ -401,6 +409,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
 	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
+	info->reg_id_aa64smfr0 = read_cpuid(ID_AA64SMFR0_EL1);
 
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
 		info->reg_gmid = read_cpuid(GMID_EL1);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 47af76e53221..e4fba0bfb55e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -993,6 +993,32 @@ void fpsimd_release_task(struct task_struct *dead_task)
 
 #endif /* CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
+{
+	/* Set priority for all PEs to architecturally defined minimum */
+	write_sysreg_s(read_sysreg_s(SYS_SMPRI_EL1) & ~SMPRI_EL1_PRIORITY_MASK,
+		       SYS_SMPRI_EL1);
+
+	/* Allow SME in kernel */
+	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_SMEN_EL1EN, CPACR_EL1);
+	isb();
+}
+
+/*
+ * This must be called after sme_kernel_enable(), we rely on the
+ * feature table being sorted to ensure this.
+ */
+void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
+{
+	/* Allow use of FA64 */
+	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_FA64_MASK,
+		       SYS_SMCR_EL1);
+}
+
+#endif /* CONFIG_ARM64_SVE */
+
 /*
  * Trapped SVE access
  *
@@ -1538,6 +1564,10 @@ static int __init fpsimd_init(void)
 	if (!cpu_have_named_feature(ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
 
+
+	if (cpu_have_named_feature(SME) && !cpu_have_named_feature(SVE))
+		pr_notice("SME is implemented but not SVE\n");
+
 	return sve_sysctl_init();
 }
 core_initcall(fpsimd_init);
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 3ed418f70e3b..e52b289a27c2 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -43,6 +43,8 @@ KVM_PROTECTED_MODE
 MISMATCHED_CACHE_TYPE
 MTE
 MTE_ASYMM
+SME
+SME_FA64
 SPECTRE_V2
 SPECTRE_V3A
 SPECTRE_V4
-- 
2.30.2

