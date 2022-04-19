Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB4506A2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiDSL1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbiDSL1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:27:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7DD2E69B
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3F561223
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA19CC385B0;
        Tue, 19 Apr 2022 11:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367443;
        bh=UZDN0E4NaNeHE28TVDbqka6fq9AtY2iZjWctTmQRkZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FExQ4nv/4dWguDFFWi/Gjexq2iNDvAJIW4t3dxzwU41lrYQNTxPbSXraSBtlcjKtB
         Sea3SiuSJBtQgAsk8DD9CTKQtLrHnm45dxY08+thXM3G3FqyejFkIdIewSDyHh7E90
         go9SnucBlHmsLsLDATOFLbqDcEMOvvHMwl1bikvzoxMfFlMhn6uoCD7OtNHUTBiahB
         3uM2vyu3uf5/VBeJ4YRvUtSTZYMVrVc7mK83HjAIih6BHMHnKSdAF3fVkv2905Uk8I
         3UfNKPpynfZwu9yqOpJN65O86vKRMeJByiPX4ngtHtoULbczx2hpXsDod3SnXmje2d
         UtF8/MPWMO26g==
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
Subject: [PATCH v14 09/39] arm64/sme: Identify supported SME vector lengths at boot
Date:   Tue, 19 Apr 2022 12:22:17 +0100
Message-Id: <20220419112247.711548-10-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13569; h=from:subject; bh=UZDN0E4NaNeHE28TVDbqka6fq9AtY2iZjWctTmQRkZo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXptv6+Up0mYA6YDparWoLuKQKWi0EdfbcZTKmAoF t++n1NeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bbwAKCRAk1otyXVSH0CPNB/ 9sspSnkUzjpjAo+MoQvUkzFJCrfO1adhC1AFd+pU2NKGqv+NC85jITzg6UaEoCTYuTz89uwBPH1YYf AWl7igMr5fJmTG2PnJzRQyhrZajV9IZtXOFtloii+B0cEyd7bi75PuWwMVn8JQNMr+AV+eQTb4Be+/ oh1OUTyqMboSNH0zeRf1S3GaWi62eqwx0ukgroiRoQwk2Cn+KnayGGHJahoST7v2MlPSfBw81eOZz+ l2lW0fXt4FcjGcMSELd9tNw7txM1XfGaLTjoRBGb7g5D7FofT3eHuoMR0qrDKn026gNs6GmnXl/I3C SyHwTlN0neXuE3I9Oh8iPDkh9JZ8bd
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpu.h        |   3 +
 arch/arm64/include/asm/cpufeature.h |   7 ++
 arch/arm64/include/asm/fpsimd.h     |  26 ++++++
 arch/arm64/include/asm/processor.h  |   1 +
 arch/arm64/kernel/cpufeature.c      |  47 +++++++++++
 arch/arm64/kernel/cpuinfo.c         |   4 +
 arch/arm64/kernel/entry-fpsimd.S    |   9 ++
 arch/arm64/kernel/fpsimd.c          | 123 +++++++++++++++++++++++++++-
 8 files changed, 218 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index d08062bcb9c1..115cdec1ae87 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -64,6 +64,9 @@ struct cpuinfo_arm64 {
 
 	/* pseudo-ZCR for recording maximum ZCR_EL1 LEN value: */
 	u64		reg_zcr;
+
+	/* pseudo-SMCR for recording maximum SMCR_EL1 LEN value: */
+	u64		reg_smcr;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8ac12e4094aa..5ddfae233ea5 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -622,6 +622,13 @@ static inline bool id_aa64pfr0_sve(u64 pfr0)
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
index 2e8ef00e7520..32cd682258d9 100644
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
 	asm volatile(__msr_s(SYS_SVCR_SMSTOP_SMZA_EL0, "xzr"));
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
index 73e38d9a540c..abf34a9c2eab 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -118,6 +118,7 @@ struct debug_info {
 
 enum vec_type {
 	ARM64_VEC_SVE = 0,
+	ARM64_VEC_SME,
 	ARM64_VEC_MAX,
 };
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0f2d7ddd69ae..082b3f48cbfd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -581,6 +581,12 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
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
@@ -687,6 +693,7 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 1, CRm = 2 */
 	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
+	ARM64_FTR_REG(SYS_SMCR_EL1, ftr_smcr),
 
 	/* Op1 = 1, CRn = 0, CRm = 0 */
 	ARM64_FTR_REG(SYS_GMID_EL1, ftr_gmid),
@@ -991,6 +998,12 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		vec_init_vq_map(ARM64_VEC_SVE);
 	}
 
+	if (id_aa64pfr1_sme(info->reg_id_aa64pfr1)) {
+		init_cpu_ftr_reg(SYS_SMCR_EL1, info->reg_smcr);
+		if (IS_ENABLED(CONFIG_ARM64_SME))
+			vec_init_vq_map(ARM64_VEC_SME);
+	}
+
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
 		init_cpu_ftr_reg(SYS_GMID_EL1, info->reg_gmid);
 
@@ -1217,6 +1230,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64SMFR0_EL1, cpu,
+				      info->reg_id_aa64smfr0, boot->reg_id_aa64smfr0);
+
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
 					info->reg_zcr, boot->reg_zcr);
@@ -1227,6 +1243,16 @@ void update_cpu_features(int cpu,
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
@@ -2931,6 +2957,23 @@ static void verify_sve_features(void)
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
@@ -2983,6 +3026,9 @@ static void verify_local_cpu_capabilities(void)
 	if (system_supports_sve())
 		verify_sve_features();
 
+	if (system_supports_sme())
+		verify_sme_features();
+
 	if (is_hyp_mode_available())
 		verify_hyp_capabilities();
 }
@@ -3100,6 +3146,7 @@ void __init setup_cpu_features(void)
 		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
 
 	sve_setup();
+	sme_setup();
 	minsigstksz_setup();
 
 	/* Advertise that we have computed the system capabilities */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index a73fe2888b7e..8a8136a096ac 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -421,6 +421,10 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
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
index e4fba0bfb55e..5e5fbd9cba75 100644
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
 
@@ -409,6 +429,8 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 
 	if (vl > max_vl)
 		vl = max_vl;
+	if (vl < info->min_vl)
+		vl = info->min_vl;
 
 	bit = find_next_bit(info->vq_map, SVE_VQ_MAX,
 			    __vq_to_bit(sve_vq_from_vl(vl)));
@@ -770,7 +792,23 @@ static void vec_probe_vqs(struct vl_info *info,
 
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
@@ -1017,7 +1055,88 @@ void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
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

