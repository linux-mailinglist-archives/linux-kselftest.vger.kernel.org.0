Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A68C41E0CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353339AbhI3SSE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353313AbhI3SSE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D95AB61A03;
        Thu, 30 Sep 2021 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025781;
        bh=F9XC6tXaw/0319Tvj4xHTPNyjMH4yJwrBww8b2tbLBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFBCzCvivxK/deJ5VYkurpFzlTsHNi4PfpVH9MgBbNF3ALHtiKrWfT4HEDdtMZyaY
         DKHs28Uy/54TJie6ZpMJ8zmTqGUz6wigcavnjmkuP4MrLb2aygy2kdIVZgzfbqHbPO
         Hu4ON3/9jtV6BNYXOkyXPYm+hr1ZcImdkSqgJS8I+aoy98I8SEZegIlAlDrxfk6mKr
         iAuCKQr2HMvJfqdvE3H+XJkHBqTtW+SFHzmgM9AiZhPvnaFNcI4RWbfE6RWm3xGmeF
         vTTCGgD3ZyFr8BIfkdsZJha3qfgvRBuZOQkqistm7yaT8LW7w+y5MC77lAE+PRyYU5
         kgjNRMmKq7O2g==
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
Subject: [PATCH v1 16/38] arm64/sme: Basic enumeration support
Date:   Thu, 30 Sep 2021 19:11:22 +0100
Message-Id: <20210930181144.10029-17-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11866; h=from:subject; bh=F9XC6tXaw/0319Tvj4xHTPNyjMH4yJwrBww8b2tbLBU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3OJxoEUtmo2FlM4KuhWLKK2kzRU5fg1Oiugzsl qDIsFgeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9zgAKCRAk1otyXVSH0GrUB/ 0R972ysbF5yPdtBYt4Exew7IKbg7HFvSgxq9RWXoEXnB59vOFBruJJccCNwDUTN2Kp/m0Wmbqz5pLo dIrsYESbombZKx9OAsSg7zt+wyDoA2EAzeyLG4OW/CkYJ5EQqKoKSj1Wzk5knMcHRJ12kbq9ZJ9/4T tbFDZmFrb4ncIhPQA7cYRtfQ7i3/+HHNlZwfI0/7TLrUcHmU6OJJE+bi8C7Vbl7B2WQ+B1ca0uquB/ pL2F1Tkv7bsTeycL/4LCgVv0NwIcF8Jiu84rdgm2jquWtsrJxoBakNorVX4ExLCIL058Q2oQjsRdy1 GRNaOzTWCdyIFp5ka8cloJ18ODcR1W
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch introduces basic cpufeature support for discovering the presence
of the Scalable Matrix Extension and reporting hwcaps for the detected
features.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/elf_hwcaps.rst  | 29 ++++++++++++++++++++
 arch/arm64/include/asm/cpu.h        |  1 +
 arch/arm64/include/asm/cpufeature.h |  6 +++++
 arch/arm64/include/asm/fpsimd.h     |  1 +
 arch/arm64/include/asm/hwcap.h      |  7 +++++
 arch/arm64/include/uapi/asm/hwcap.h |  7 +++++
 arch/arm64/kernel/cpufeature.c      | 41 +++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  8 ++++++
 arch/arm64/kernel/fpsimd.c          | 19 +++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 10 files changed, 120 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index ec1a5a63c1d0..39680ff764bb 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -247,6 +247,35 @@ HWCAP2_MTE
     Functionality implied by ID_AA64PFR1_EL1.MTE == 0b0010, as described
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
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 0f6d16faa540..667b66fe1a53 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -57,6 +57,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
 	u64		reg_id_aa64zfr0;
+	u64		reg_id_aa64smfr0;
 
 	struct cpuinfo_32bit	aarch32;
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ef6be92b1921..e1b745bf5fbe 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -727,6 +727,12 @@ static __always_inline bool system_supports_sve(void)
 		cpus_have_const_cap(ARM64_SVE);
 }
 
+static __always_inline bool system_supports_sme(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_SME) &&
+		cpus_have_const_cap(ARM64_SME);
+}
+
 static __always_inline bool system_supports_cnp(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_CNP) &&
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 802597140121..160f4f246db8 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -74,6 +74,7 @@ extern void sve_set_vq(unsigned long vq_minus_1);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 8c129db8232a..37605f4be103 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -105,6 +105,13 @@
 #define KERNEL_HWCAP_RNG		__khwcap2_feature(RNG)
 #define KERNEL_HWCAP_BTI		__khwcap2_feature(BTI)
 #define KERNEL_HWCAP_MTE		__khwcap2_feature(MTE)
+#define KERNEL_HWCAP_SME		__khwcap2_feature(SME)
+#define KERNEL_HWCAP_SME_I16I64		__khwcap2_feature(SME_I16I64)
+#define KERNEL_HWCAP_SME_F64F64		__khwcap2_feature(SME_F64F64)
+#define KERNEL_HWCAP_SME_I8I32		__khwcap2_feature(SME_I8I32)
+#define KERNEL_HWCAP_SME_F16F32		__khwcap2_feature(SME_F16F32)
+#define KERNEL_HWCAP_SME_B16F32		__khwcap2_feature(SME_B16F32)
+#define KERNEL_HWCAP_SME_F32F32		__khwcap2_feature(SME_F32F32)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index b8f41aa234ee..2d6bbee3c68a 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -75,5 +75,12 @@
 #define HWCAP2_RNG		(1 << 16)
 #define HWCAP2_BTI		(1 << 17)
 #define HWCAP2_MTE		(1 << 18)
+#define HWCAP2_SME		(1 << 19)
+#define HWCAP2_SME_I16I64	(1 << 20)
+#define HWCAP2_SME_F64F64	(1 << 21)
+#define HWCAP2_SME_I8I32	(1 << 22)
+#define HWCAP2_SME_F16F32	(1 << 23)
+#define HWCAP2_SME_B16F32	(1 << 24)
+#define HWCAP2_SME_F32F32	(1 << 25)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 405a65d7e618..9d3e87ba5d5a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -246,6 +246,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SME_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
@@ -278,6 +279,22 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
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
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
@@ -624,6 +641,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1,
 			       &id_aa64pfr1_override),
 	ARM64_FTR_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0),
+	ARM64_FTR_REG(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
@@ -935,6 +953,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64SMFR0_EL1, info->reg_id_aa64smfr0);
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
 		init_32bit_cpu_features(&info->aarch32);
@@ -2332,6 +2351,19 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
+		.min_field_value = ID_AA64PFR1_SME,
+		.matches = has_cpuid_feature,
+		.cpu_enable = sme_kernel_enable,
+	},
+#endif /* CONFIG_ARM64_SME */
 	{},
 };
 
@@ -2451,6 +2483,15 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 #ifdef CONFIG_ARM64_MTE
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_MTE_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_MTE, CAP_HWCAP, KERNEL_HWCAP_MTE),
 #endif /* CONFIG_ARM64_MTE */
+#ifdef CONFIG_ARM64_SME
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SME_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SME, CAP_HWCAP, KERNEL_HWCAP_SME),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_I16I64_SHIFT, FTR_UNSIGNED, ID_AA64SMFR0_I16I64, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F64F64_SHIFT, FTR_UNSIGNED, ID_AA64SMFR0_F64F64, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_I8I32_SHIFT, FTR_UNSIGNED, ID_AA64SMFR0_I8I32, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F16F32_SHIFT, FTR_UNSIGNED, ID_AA64SMFR0_F16F32, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_B16F32_SHIFT, FTR_UNSIGNED, ID_AA64SMFR0_B16F32, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F32F32_SHIFT, FTR_UNSIGNED, ID_AA64SMFR0_F32F32, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+#endif /* CONFIG_ARM64_SME */
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 87731fea5e41..9830fa0c7647 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -94,6 +94,13 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_RNG]		= "rng",
 	[KERNEL_HWCAP_BTI]		= "bti",
 	[KERNEL_HWCAP_MTE]		= "mte",
+	[KERNEL_HWCAP_SME]		= "sme",
+	[KERNEL_HWCAP_SME_I16I64]	= "smei16i64",
+	[KERNEL_HWCAP_SME_F64F64]	= "smef64f64",
+	[KERNEL_HWCAP_SME_I8I32]	= "smei8i32",
+	[KERNEL_HWCAP_SME_F16F32]	= "smef16f32",
+	[KERNEL_HWCAP_SME_B16F32]	= "smeb16f32",
+	[KERNEL_HWCAP_SME_F32F32]	= "smef32f32",
 };
 
 #ifdef CONFIG_COMPAT
@@ -396,6 +403,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
 	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
+	info->reg_id_aa64smfr0 = read_cpuid(ID_AA64SMFR0_EL1);
 
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
 		info->reg_gmid = read_cpuid(GMID_EL1);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b3d4786e2601..bf698c3eaed3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -986,6 +986,21 @@ void fpsimd_release_task(struct task_struct *dead_task)
 
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
+#endif /* CONFIG_ARM64_SVE */
+
 /*
  * Trapped SVE access
  *
@@ -1528,6 +1543,10 @@ static int __init fpsimd_init(void)
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
index 49305c2e6dfd..a21a82d3cd64 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -39,6 +39,7 @@ HW_DBM
 KVM_PROTECTED_MODE
 MISMATCHED_CACHE_TYPE
 MTE
+SME
 SPECTRE_V2
 SPECTRE_V3A
 SPECTRE_V4
-- 
2.20.1

