Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA349CE4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242833AbiAZPbD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiAZPbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:31:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB191C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:31:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DCED6189F
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59802C340E9;
        Wed, 26 Jan 2022 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211061;
        bh=iVdj3mxas6xH+1iRC6maiXHTY83c1rk4ADYLHk9Ya1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzH6Kpw2eh/l7h99fImNwNbI+Rfqov+NlgnLl5mIPY+/XUUp1sqW6OrX2LOu3Mk3s
         vGHxgweNaRi3E9UPSN/rr0B4c9+vzhrlurz+mukeg+Ete9AqSHEQm7qMdL4ketD827
         vJp2SKdqKSIoWYuODRRV4Nqkjx+P/QNqJNIwwy0uOdmWuOPnRfMFGFWu77HhrF+xNM
         ZqOkLEdOLdezb7g2JXla9sUH6dTziLtPkoXm0YrNyc3N0rJT52H5V3S7iQwQgH6QsC
         FXNLdLdGB4Fpdkrgyqobs/U5B1P9yqaM0iqxqn+SDLDyFN+VHuD733HUpavEmNY81F
         d+JEQFHjBWAgg==
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
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 10/39] arm64/sme: Identify supported SME vector lengths at boot
Date:   Wed, 26 Jan 2022 15:27:20 +0000
Message-Id: <20220126152749.233712-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13528; h=from:subject; bh=iVdj3mxas6xH+1iRC6maiXHTY83c1rk4ADYLHk9Ya1g=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhavDf9SkR+8G7PVz4qDYk9qdqPXmwn/LtoUmL+ e06ZyH2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoWgAKCRAk1otyXVSH0EPZB/ 9/F3zI56OwS7XFiOo/xGGcoCy125FvqaZdCFHkClq4R/dk8V32vBwIAhqi3v9uhwB8MuEYlLIg/CiS Y4Ve94QJ3tjcggy1qudPtbPg1i+EAnLLkshpgJVdfe8eK4z61t/7w3smrPepTvIdeWBHGGAiwtQYyE rFayg9Blq0p0tidV406PNn9CjDnOquy/IzLhsrDQav0JrB+dCA1U9GD/qzyfMzHpFQpgzTp1Dzp77k tZTlbogg8xgZJi7JS/VTAOCGXaxJcfJvcR7//WhWJlh4hgwrI6OsNSzVhgIC6eCi+yX7UIIzyMe38j TTYoNG8ySPz6Hh9qCvQOyQHaoyDUhH
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
length using a different instruction (or enter streaming mode which
would have the same issue and be higher cost).  Rather than add an ops
structure we add special cases directly in the otherwise generic
vec_probe_vqs() function, this is a bit inelegant but it's the only
place where this is an issue.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpu.h        |   3 +
 arch/arm64/include/asm/cpufeature.h |   7 ++
 arch/arm64/include/asm/fpsimd.h     |  26 ++++++
 arch/arm64/include/asm/processor.h  |   1 +
 arch/arm64/kernel/cpufeature.c      |  49 +++++++++++
 arch/arm64/kernel/cpuinfo.c         |   4 +
 arch/arm64/kernel/entry-fpsimd.S    |   9 ++
 arch/arm64/kernel/fpsimd.c          | 123 +++++++++++++++++++++++++++-
 8 files changed, 220 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index d08062bcb9c1..550e1fc4ae6c 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -64,6 +64,9 @@ struct cpuinfo_arm64 {
 
 	/* pseudo-ZCR for recording maximum ZCR_EL1 LEN value: */
 	u64		reg_zcr;
+
+	/* pseudo-SMCR for recording maximum ZCR_EL1 LEN value: */
+	u64		reg_smcr;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f93b1442143f..9d36035acce3 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -620,6 +620,13 @@ static inline bool id_aa64pfr0_sve(u64 pfr0)
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
index 6b7eb6f2cecd..8cb99b6fe565 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -78,6 +78,7 @@ extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void fa64_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
+extern u64 read_smcr_features(void);
 
 /*
  * Helpers to translate bit indices in sve_vq_map to VQ values (and
@@ -172,6 +173,12 @@ static inline void write_vl(enum vec_type type, u64 val)
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
@@ -268,12 +275,31 @@ static inline void sme_smstop(void)
 	asm volatile(".inst 0xd503467f");
 }
 
+extern void __init sme_setup(void);
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
+extern unsigned int sme_get_vl(void);
+
 #else
 
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
 static inline void sme_smstop(void) { }
 
+static inline void sme_setup(void) { }
+static inline unsigned int sme_get_vl(void) { return 0; }
+static inline int sme_max_vl(void) { return 0; }
+static inline int sme_max_virtualisable_vl(void) { return 0; }
+
 #endif /* ! CONFIG_ARM64_SME */
 
 /* For use by EFI runtime services calls only */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6f41b65f9962..df68f0fb0ded 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -117,6 +117,7 @@ struct debug_info {
 
 enum vec_type {
 	ARM64_VEC_SVE = 0,
+	ARM64_VEC_SME,
 	ARM64_VEC_MAX,
 };
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3cd7fe53cffa..1995ff72a8c6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -570,6 +570,12 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
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
@@ -673,6 +679,7 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 1, CRm = 2 */
 	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
+	ARM64_FTR_REG(SYS_SMCR_EL1, ftr_smcr),
 
 	/* Op1 = 1, CRn = 0, CRm = 0 */
 	ARM64_FTR_REG(SYS_GMID_EL1, ftr_gmid),
@@ -977,6 +984,14 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
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
 
@@ -1203,6 +1218,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64SMFR0_EL1, cpu,
+				      info->reg_id_aa64smfr0, boot->reg_id_aa64smfr0);
+
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
 					info->reg_zcr, boot->reg_zcr);
@@ -1213,6 +1231,16 @@ void update_cpu_features(int cpu,
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
@@ -2878,6 +2906,23 @@ static void verify_sve_features(void)
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
@@ -2930,6 +2975,9 @@ static void verify_local_cpu_capabilities(void)
 	if (system_supports_sve())
 		verify_sve_features();
 
+	if (system_supports_sme())
+		verify_sme_features();
+
 	if (is_hyp_mode_available())
 		verify_hyp_capabilities();
 }
@@ -3047,6 +3095,7 @@ void __init setup_cpu_features(void)
 		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
 
 	sve_setup();
+	sme_setup();
 	minsigstksz_setup();
 
 	/* Advertise that we have computed the system capabilities */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 33ec182e872e..72dc155719b0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -420,6 +420,10 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	    id_aa64pfr0_sve(info->reg_id_aa64pfr0))
 		info->reg_zcr = read_zcr_features();
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) &&
+	    id_aa64pfr1_sme(info->reg_id_aa64pfr1))
+		info->reg_smcr = read_smcr_features();
+
 	cpuinfo_detect_icache_policy(info);
 }
 
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index dc242e269f9a..deee5f01462e 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -86,3 +86,12 @@ SYM_FUNC_START(sve_flush_live)
 SYM_FUNC_END(sve_flush_live)
 
 #endif /* CONFIG_ARM64_SVE */
+
+#ifdef CONFIG_ARM64_SME
+
+SYM_FUNC_START(sme_get_vl)
+	_sme_rdsvl	0, 1
+	ret
+SYM_FUNC_END(sme_get_vl)
+
+#endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 576490be3c2b..3fb2167f8af7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -136,6 +136,12 @@ __ro_after_init struct vl_info vl_info[ARM64_VEC_MAX] = {
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
@@ -186,6 +192,20 @@ extern void __percpu *efi_sve_state;
 
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
 
@@ -403,6 +423,8 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 
 	if (vl > max_vl)
 		vl = max_vl;
+	if (vl < info->min_vl)
+		vl = info->min_vl;
 
 	bit = find_next_bit(info->vq_map, SVE_VQ_MAX,
 			    __vq_to_bit(sve_vq_from_vl(vl)));
@@ -764,7 +786,23 @@ static void vec_probe_vqs(struct vl_info *info,
 
 	for (vq = SVE_VQ_MAX; vq >= SVE_VQ_MIN; --vq) {
 		write_vl(info->type, vq - 1); /* self-syncing */
-		vl = sve_get_vl();
+
+		switch (info->type) {
+		case ARM64_VEC_SVE:
+			vl = sve_get_vl();
+			break;
+		case ARM64_VEC_SME:
+			vl = sme_get_vl();
+			break;
+		default:
+			vl = 0;
+			break;
+		}
+
+		/* Minimum VL identified? */
+		if (sve_vq_from_vl(vl) > vq)
+			break;
+
 		vq = sve_vq_from_vl(vl); /* skip intervening lengths */
 		set_bit(__vq_to_bit(vq), map);
 	}
@@ -1011,7 +1049,88 @@ void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 		       SYS_SMCR_EL1);
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
+	 * Set the maximum possible VL.
+	 */
+	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_LEN_MASK,
+		       SYS_SMCR_EL1);
+
+	smcr = read_sysreg_s(SYS_SMCR_EL1);
+	smcr &= ~(u64)SMCR_ELx_LEN_MASK; /* Only the LEN field */
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

