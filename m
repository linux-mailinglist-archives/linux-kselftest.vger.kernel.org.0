Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C72436A1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhJUSKs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJUSKs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:10:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9F7861AFF;
        Thu, 21 Oct 2021 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839712;
        bh=CIZzO6QeNWLVwo9OKedi5Ni2LSHDBtTg6CQf4uJ7RgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbxfqpQPwO4ogJUDE30mKishKWX/ZCVpOMDyd2ilwPAe2BvZ5boWb45fMTuyKbrTW
         M2VSPz3KX/DeDwu7Bt4hCwEKgKZPiA7+pSaM48GB83qqRkBLm8ZMxdCa+e9MNDT7on
         R9z/xQepmMHIU7DOZ+yhvRR81fw2SS3Z0xxtp3GpiXquDlsU0gE68H+LnkWojCQ+nV
         +whKo91jEEn09dJecreakaev4rsm76GAWGO9PmKRUuxHe5c5NJTfST6UOQSLfcQRNL
         e1c6YrpL/bQBKwGlIrBEfSCqZgCFU3QNuJw73E/SDPeg9uJZTJ4P12ikXV/4DkEs69
         BBKPPEEkxw3JA==
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
Subject: [PATCH v4 11/33] arm64/sme: Identify supported SME vector lengths at boot
Date:   Thu, 21 Oct 2021 19:07:00 +0100
Message-Id: <20211021180722.3699248-12-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13419; h=from:subject; bh=CIZzO6QeNWLVwo9OKedi5Ni2LSHDBtTg6CQf4uJ7RgQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxH3YVu3JSM/L+jpOs8IF9PgOsSEkNMVUgl6zbN eKRg+52JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsRwAKCRAk1otyXVSH0JePB/ 4pi46vAEzJQVUOjpyoVqzgVdy3LrYfL0+X7XWfEB2uUv+EEZDQFbpQ6Depr2XEBtWqQNn8dlyfutKV vcbtKUwuCKk+PsnliRaoG1qHgcWKWJR5yM2PX+YYyagHH0CleVr91o24zBCrVqjqCBH4CLsteOvwrO i2fKTt0+fb6IA4CGFUvQEcD5aOTdqb8S8q0623tEyWiInJ8Z7ene0aMq458jSY0IMK99R4wE37UkXp 3rUdgAq8+IrxmqaQ9B7vtpqcxPm9PzZ54k8ehHM9kLCVTV/hCqtxTJi4I49J6cviuFCspxUyIWq7LK 1UHSntTnfrZc81oxLcNHGLd0Q25luN
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The vector lengths used for SME are controlled through a similar set of
registers to those for SVE and enumerated using a similar algorithm with
some slight differences due to the fact that unlike SVE there are no
restrictions on which combinations of vector lengths can be supported
nor any mandatory vector lengths which must be implemented.  Add a new
vector type and implement support for enumerating it.

One slightly awkward feature is that we need to read the current vector
length using the SVE RVDL instruction while in streaming mode.  Rather
than add an ops structure we add special cases directly in the otherwise
generic vec_probe_vqs() function, this is a bit inelegant but it's the
only place where this is an issue.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpu.h        |   3 +
 arch/arm64/include/asm/cpufeature.h |   7 ++
 arch/arm64/include/asm/fpsimd.h     |  44 ++++++++++
 arch/arm64/include/asm/processor.h  |   1 +
 arch/arm64/kernel/cpufeature.c      |  49 +++++++++++
 arch/arm64/kernel/cpuinfo.c         |   4 +
 arch/arm64/kernel/fpsimd.c          | 131 +++++++++++++++++++++++++++-
 7 files changed, 238 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 667b66fe1a53..707f30dccbf1 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -63,6 +63,9 @@ struct cpuinfo_arm64 {
 
 	/* pseudo-ZCR for recording maximum ZCR_EL1 LEN value: */
 	u64		reg_zcr;
+
+	/* pseudo-SMCR for recording maximum ZCR_EL1 LEN value: */
+	u64		reg_smcr;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e1b745bf5fbe..9a183267b341 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -619,6 +619,13 @@ static inline bool id_aa64pfr0_sve(u64 pfr0)
 	return val > 0;
 }
 
+static inline bool id_aa64pfr1_sme(u64 pfr1)
+{
+	u32 val = cpuid_feature_extract_unsigned_field(pfr1, ID_AA64PFR1_SME_SHIFT);
+
+	return val > 0;
+}
+
 static inline bool id_aa64pfr1_mte(u64 pfr1)
 {
 	u32 val = cpuid_feature_extract_unsigned_field(pfr1, ID_AA64PFR1_MTE_SHIFT);
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index e28e09f30ad4..a65779fe6d56 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -77,6 +77,7 @@ extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
+extern u64 read_smcr_features(void);
 
 /*
  * Helpers to translate bit indices in sve_vq_map to VQ values (and
@@ -171,6 +172,12 @@ static inline void write_vl(enum vec_type type, u64 val)
 		tmp = read_sysreg_s(SYS_ZCR_EL1) & ~ZCR_ELx_LEN_MASK;
 		write_sysreg_s(tmp | val, SYS_ZCR_EL1);
 		break;
+#endif
+#ifdef CONFIG_ARM64_SME
+	case ARM64_VEC_SME:
+		tmp = read_sysreg_s(SYS_SMCR_EL1) & ~SMCR_ELx_LEN_MASK;
+		write_sysreg_s(tmp | val, SYS_SMCR_EL1);
+		break;
 #endif
 	default:
 		WARN_ON_ONCE(1);
@@ -245,6 +252,43 @@ static inline void sve_setup(void) { }
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+extern void __init sme_setup(void);
+
+static inline void sme_smstart_sm(void)
+{
+	/* SMSTART SM is an alias for MSR SVCRSM, #1 */
+	asm volatile(".inst 0xd503437f");
+}
+
+static inline void sme_smstop_sm(void)
+{
+	/* SMSTOP SM is an alias for MSR SVCRSM, #0 */
+	asm volatile(".inst 0xd503427f");
+}
+
+static inline int sme_max_vl(void)
+{
+	return vec_max_vl(ARM64_VEC_SME);
+}
+
+static inline int sme_max_virtualisable_vl(void)
+{
+	return vec_max_virtualisable_vl(ARM64_VEC_SME);
+}
+
+#else
+
+static inline void sme_setup(void) { }
+static inline int sme_max_vl(void) { return 0; }
+static inline int sme_max_virtualisable_vl(void) { return 0; }
+
+static inline void sme_smstart_sm(void) { }
+static inline void sme_smstop_sm(void) { }
+
+#endif /* ! CONFIG_ARM64_SME */
+
 /* For use by EFI runtime services calls only */
 extern void __efi_fpsimd_begin(void);
 extern void __efi_fpsimd_end(void);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 9b854e8196df..575a1fe719b7 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -117,6 +117,7 @@ struct debug_info {
 
 enum vec_type {
 	ARM64_VEC_SVE = 0,
+	ARM64_VEC_SME,
 	ARM64_VEC_MAX,
 };
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9d3e87ba5d5a..84aec4704885 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -562,6 +562,12 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_smcr[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,
+		SMCR_ELx_LEN_SHIFT, SMCR_ELx_LEN_SIZE, 0),	/* LEN */
+	ARM64_FTR_END,
+};
+
 /*
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
@@ -660,6 +666,7 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 1, CRm = 2 */
 	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
+	ARM64_FTR_REG(SYS_SMCR_EL1, ftr_smcr),
 
 	/* Op1 = 1, CRn = 0, CRm = 0 */
 	ARM64_FTR_REG(SYS_GMID_EL1, ftr_gmid),
@@ -963,6 +970,14 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		vec_init_vq_map(ARM64_VEC_SVE);
 	}
 
+	if (id_aa64pfr1_sme(info->reg_id_aa64pfr1)) {
+		init_cpu_ftr_reg(SYS_SMCR_EL1, info->reg_smcr);
+		if (IS_ENABLED(CONFIG_ARM64_SME)) {
+			sme_kernel_enable(NULL);
+			vec_init_vq_map(ARM64_VEC_SME);
+		}
+	}
+
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
 		init_cpu_ftr_reg(SYS_GMID_EL1, info->reg_gmid);
 
@@ -1187,6 +1202,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64SMFR0_EL1, cpu,
+				      info->reg_id_aa64smfr0, boot->reg_id_aa64smfr0);
+
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
 					info->reg_zcr, boot->reg_zcr);
@@ -1197,6 +1215,16 @@ void update_cpu_features(int cpu,
 			vec_update_vq_map(ARM64_VEC_SVE);
 	}
 
+	if (id_aa64pfr1_sme(info->reg_id_aa64pfr1)) {
+		taint |= check_update_ftr_reg(SYS_SMCR_EL1, cpu,
+					info->reg_smcr, boot->reg_smcr);
+
+		/* Probe vector lengths, unless we already gave up on SME */
+		if (id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1)) &&
+		    !system_capabilities_finalized())
+			vec_update_vq_map(ARM64_VEC_SME);
+	}
+
 	/*
 	 * The kernel uses the LDGM/STGM instructions and the number of tags
 	 * they read/write depends on the GMID_EL1.BS field. Check that the
@@ -2789,6 +2817,23 @@ static void verify_sve_features(void)
 	/* Add checks on other ZCR bits here if necessary */
 }
 
+static void verify_sme_features(void)
+{
+	u64 safe_smcr = read_sanitised_ftr_reg(SYS_SMCR_EL1);
+	u64 smcr = read_smcr_features();
+
+	unsigned int safe_len = safe_smcr & SMCR_ELx_LEN_MASK;
+	unsigned int len = smcr & SMCR_ELx_LEN_MASK;
+
+	if (len < safe_len || vec_verify_vq_map(ARM64_VEC_SME)) {
+		pr_crit("CPU%d: SME: vector length support mismatch\n",
+			smp_processor_id());
+		cpu_die_early();
+	}
+
+	/* Add checks on other SMCR bits here if necessary */
+}
+
 static void verify_hyp_capabilities(void)
 {
 	u64 safe_mmfr1, mmfr0, mmfr1;
@@ -2841,6 +2886,9 @@ static void verify_local_cpu_capabilities(void)
 	if (system_supports_sve())
 		verify_sve_features();
 
+	if (system_supports_sme())
+		verify_sme_features();
+
 	if (is_hyp_mode_available())
 		verify_hyp_capabilities();
 }
@@ -2957,6 +3005,7 @@ void __init setup_cpu_features(void)
 		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
 
 	sve_setup();
+	sme_setup();
 	minsigstksz_setup();
 
 	/* Advertise that we have computed the system capabilities */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 9830fa0c7647..572da7d1f194 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -415,6 +415,10 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	    id_aa64pfr0_sve(info->reg_id_aa64pfr0))
 		info->reg_zcr = read_zcr_features();
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) &&
+	    id_aa64pfr1_sme(info->reg_id_aa64pfr1))
+		info->reg_smcr = read_smcr_features();
+
 	cpuinfo_detect_icache_policy(info);
 }
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8416e4889596..0b2c4dfdf9fb 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -132,6 +132,12 @@ __ro_after_init struct vl_info vl_info[ARM64_VEC_MAX] = {
 		.max_virtualisable_vl	= SVE_VL_MIN,
 	},
 #endif
+#ifdef CONFIG_ARM64_SME
+	[ARM64_VEC_SME] = {
+		.type			= ARM64_VEC_SME,
+		.name			= "SME",
+	},
+#endif
 };
 
 static unsigned int vec_vl_inherit_flag(enum vec_type type)
@@ -182,6 +188,20 @@ extern void __percpu *efi_sve_state;
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+static int get_sme_default_vl(void)
+{
+	return get_default_vl(ARM64_VEC_SME);
+}
+
+static void set_sme_default_vl(int val)
+{
+	set_default_vl(ARM64_VEC_SME, val);
+}
+
+#endif
+
 DEFINE_PER_CPU(bool, fpsimd_context_busy);
 EXPORT_PER_CPU_SYMBOL(fpsimd_context_busy);
 
@@ -399,6 +419,8 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 
 	if (vl > max_vl)
 		vl = max_vl;
+	if (vl < info->min_vl)
+		vl = info->min_vl;
 
 	bit = find_next_bit(info->vq_map, SVE_VQ_MAX,
 			    __vq_to_bit(sve_vq_from_vl(vl)));
@@ -758,12 +780,38 @@ static void vec_probe_vqs(struct vl_info *info,
 
 	bitmap_zero(map, SVE_VQ_MAX);
 
+	/*
+	 * Enter streaming mode for SME; we don't use an op as the
+	 * vector length info is used from KVM.
+	 */
+	switch (info->type) {
+	case ARM64_VEC_SME:
+		sme_smstart_sm();
+		break;
+	default:
+		break;
+	}
+
 	for (vq = SVE_VQ_MAX; vq >= SVE_VQ_MIN; --vq) {
 		write_vl(info->type, vq - 1); /* self-syncing */
+
 		vl = sve_get_vl();
+
+		/* Minimum VL identified? */
+		if (sve_vq_from_vl(vl) > vq)
+			break;
+
 		vq = sve_vq_from_vl(vl); /* skip intervening lengths */
 		set_bit(__vq_to_bit(vq), map);
 	}
+
+	switch (info->type) {
+	case ARM64_VEC_SME:
+		sme_smstop_sm();
+		break;
+	default:
+		break;
+	}
 }
 
 /*
@@ -996,7 +1044,88 @@ void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 	isb();
 }
 
-#endif /* CONFIG_ARM64_SVE */
+/*
+ * Read the pseudo-SMCR used by cpufeatures to identify the supported
+ * vector length.
+ *
+ * Use only if SME is present.
+ * This function clobbers the SME vector length.
+ */
+u64 read_smcr_features(void)
+{
+	u64 smcr;
+	unsigned int vq_max;
+
+	sme_kernel_enable(NULL);
+	sme_smstart_sm();
+
+	/*
+	 * Set the maximum possible VL, and write zeroes to all other
+	 * bits to see if they stick.
+	 */
+	write_sysreg_s(SMCR_ELx_LEN_MASK, SYS_SMCR_EL1);
+
+	smcr = read_sysreg_s(SYS_SMCR_EL1);
+	smcr &= ~(u64)SMCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
+	vq_max = sve_vq_from_vl(sve_get_vl());
+	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
+
+	sme_smstop_sm();
+
+	return smcr;
+}
+
+void __init sme_setup(void)
+{
+	struct vl_info *info = &vl_info[ARM64_VEC_SME];
+	u64 smcr;
+	int min_bit;
+
+	if (!system_supports_sme())
+		return;
+
+	/*
+	 * SME doesn't require any particular vector length be
+	 * supported but it does require at least one.  We should have
+	 * disabled the feature entirely while bringing up CPUs but
+	 * let's double check here.
+	 */
+	WARN_ON(bitmap_empty(info->vq_map, SVE_VQ_MAX));
+
+	min_bit = find_last_bit(info->vq_map, SVE_VQ_MAX);
+	info->min_vl = sve_vl_from_vq(__bit_to_vq(min_bit));
+
+	smcr = read_sanitised_ftr_reg(SYS_SMCR_EL1);
+	info->max_vl = sve_vl_from_vq((smcr & SMCR_ELx_LEN_MASK) + 1);
+
+	/*
+	 * Sanity-check that the max VL we determined through CPU features
+	 * corresponds properly to sme_vq_map.  If not, do our best:
+	 */
+	if (WARN_ON(info->max_vl != find_supported_vector_length(ARM64_VEC_SME,
+								 info->max_vl)))
+		info->max_vl = find_supported_vector_length(ARM64_VEC_SME,
+							    info->max_vl);
+
+	WARN_ON(info->min_vl > info->max_vl);
+
+	/*
+	 * For the default VL, pick the maximum supported value <= 32
+	 * (256 bits) if there is one since this is guaranteed not to
+	 * grow the signal frame when in streaming mode, otherwise the
+	 * minimum available VL will be used.
+	 */
+	set_sme_default_vl(find_supported_vector_length(ARM64_VEC_SME, 32));
+
+	pr_info("SME: minimum available vector length %u bytes per vector\n",
+		info->min_vl);
+	pr_info("SME: maximum available vector length %u bytes per vector\n",
+		info->max_vl);
+	pr_info("SME: default vector length %u bytes per vector\n",
+		get_sme_default_vl());
+}
+
+#endif /* CONFIG_ARM64_SME */
 
 /*
  * Trapped SVE access
-- 
2.30.2

