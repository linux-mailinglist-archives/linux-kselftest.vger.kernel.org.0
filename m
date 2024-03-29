Return-Path: <linux-kselftest+bounces-6790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5A1890F03
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516C728B365
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF6A3D;
	Fri, 29 Mar 2024 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2E+sQXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0112B83;
	Fri, 29 Mar 2024 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671244; cv=none; b=qE1iomKypBQXCNcQeaWuFOl21dI4epl6D9HHTBqY9+hIT3OpsKtIqKdFYtZF9sDAK05vxifZ5+XSwWfZcNRiZ/v2RAC20B520sFSoiO531M34NaK6b6z9YbDS9/jF4g5tgCo3y/bNpfcutQeYYw5ygng7UylE/etI+fDD4GnKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671244; c=relaxed/simple;
	bh=TzURQCcdXE/Rwii91k7zKRZL0yNTrQttIJF3XlI51Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tt/tNZ+urdc9N21TvPw60+l9x1cMMPyLSD6KnydqD+mZ7VpfzBQw2E4uYMU7eBi9d/TQHqQRLTA8SmkReH3Pbj3S0M43btO/Aq4lDwIQArjaD5eMqp9LeerJR7xJFg2KSKx2LheMGE9bsBvV0Bh+rbsXmCD2WcTNHkTtiF9PTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2E+sQXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9385CC433B1;
	Fri, 29 Mar 2024 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671244;
	bh=TzURQCcdXE/Rwii91k7zKRZL0yNTrQttIJF3XlI51Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L2E+sQXraEdOfhX2s9ek822i8DJmYqNw+JQlKi1GNGpkTpBRENxt0Qgrk025LTuIu
	 E67cO7v4YY3at0tg+relxPspBCZwvbydm2D2Kt6D41unXQnylkI+PJrRAUmFMqM4I1
	 jSl6+eCpG0d7T0OaULlIutM1YcarCHKJrwyglVk1VlVWWqqu+GyVCY8aiZBXwwun2+
	 7ei3bw7G0MG4TmdSNif1vVRyLEh7mQc8r8O1w1Uyfxvtc/cVHW5uyuHQs6P+9p31fb
	 RLT4e+tHgBavMXUa83Uk9QxdMbpwAODLcDgp2NaRAYAnA1WV6ILSMoKCCp5qzKijoC
	 tc9TTIQ60GbIg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 29 Mar 2024 00:13:44 +0000
Subject: [PATCH v6 3/5] KVM: arm64: Support FEAT_FPMR for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-arm64-2023-dpisa-v6-3-ba42db6c27f3@kernel.org>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
In-Reply-To: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5950; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TzURQCcdXE/Rwii91k7zKRZL0yNTrQttIJF3XlI51Bk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmBge9a6ytdnHHv6IsOV9/3KmwoObVGrmRg1/O2zb5
 0oH/4GqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgYHvQAKCRAk1otyXVSH0LfHB/
 4pIC7S7G54cf6K30Ood+5znP0BciXZDOFr+Nw847igGv/2NPsRtQr4XS5nBoDVEOQkZZC76+fGmzHY
 OPh8Vt0MCtMZ6usdBXtq3gwb/0DA8st7Z06O27jdJKBXe8Xi7U4jdYte1lud4b60h6FeBQj1o9Mzn7
 97BQpAc6plYhSpazTc6sfM9cedHXOJzgJYtGz6cWyWmJJxmqByXEwEQidfgm1mBC/6KYCcxKf9aBqd
 lnn97AYjBq4BAC3O4tCfKbgokR7WzkrOL+UZDO6G8Mlm82G/UDd2Gv0+E2jBOZT2eppYKOloL2zw3c
 m1Cwe3qrjGa1Is0abXVmlOIOYqS8Iu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR introduces a new system register FPMR which allows configuration
of floating point behaviour, currently for FP8 specific features. Allow use
of this in guests, disabling the trap while guests are running and saving
and restoring the value along with the rest of the floating point state
if the ID registers indicate that the feature is present.  Since FPMR is
stored immediately after the main floating point state we share it with
the hypervisor by adjusting the size of the shared region.

Access to FPMR is covered by both a register specific trap HCRX_EL2.EnFPM
and the overall floating point access trap so we just unconditionally
enable the FPMR specific trap if the guest has FPMR exposed in the ID
registers and rely on the floating point access trap to detect guest
floating point usage when FPMR is enabled for the guest.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       |  3 ++-
 arch/arm64/kvm/emulate-nested.c         |  9 +++++++++
 arch/arm64/kvm/fpsimd.c                 |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |  7 ++++++-
 arch/arm64/kvm/sys_regs.c               | 13 +++++++++++++
 5 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8a251f0da900..3f0f31b17d96 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -415,6 +415,8 @@ enum vcpu_sysreg {
 	APGAKEYLO_EL1,
 	APGAKEYHI_EL1,
 
+	FPMR,
+
 	/* Memory Tagging Extension registers */
 	RGSR_EL1,	/* Random Allocation Tag Seed Register */
 	GCR_EL1,	/* Tag Control Register */
@@ -582,7 +584,6 @@ struct kvm_vcpu_arch {
 	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 	u64 svcr;
-	u64 fpmr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 4697ba41b3a9..0289882713f9 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -67,6 +67,8 @@ enum cgt_group_id {
 	CGT_HCR_TTLBIS,
 	CGT_HCR_TTLBOS,
 
+	CGT_HCRX_EnFPM,
+
 	CGT_MDCR_TPMCR,
 	CGT_MDCR_TPM,
 	CGT_MDCR_TDE,
@@ -279,6 +281,12 @@ static const struct trap_bits coarse_trap_bits[] = {
 		.mask		= HCR_TTLBOS,
 		.behaviour	= BEHAVE_FORWARD_ANY,
 	},
+	[CGT_HCRX_EnFPM] = {
+		.index		= HCRX_EL2,
+		.value		= 0,
+		.mask		= HCRX_EL2_EnFPM,
+		.behaviour	= BEHAVE_HANDLE_LOCALLY,
+	},
 	[CGT_MDCR_TPMCR] = {
 		.index		= MDCR_EL2,
 		.value		= MDCR_EL2_TPMCR,
@@ -481,6 +489,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_AIDR_EL1,		CGT_HCR_TID1),
 	SR_TRAP(SYS_SMIDR_EL1,		CGT_HCR_TID1),
 	SR_TRAP(SYS_CTR_EL0,		CGT_HCR_TID2),
+	SR_TRAP(SYS_FPMR,		CGT_HCRX_EnFPM),
 	SR_TRAP(SYS_CCSIDR_EL1,		CGT_HCR_TID2_TID4),
 	SR_TRAP(SYS_CCSIDR2_EL1,	CGT_HCR_TID2_TID4),
 	SR_TRAP(SYS_CLIDR_EL1,		CGT_HCR_TID2_TID4),
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8a0fedbb6f39..2f625410c1b7 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -152,7 +152,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.sve_vl = vcpu->arch.sve_max_vl;
 		fp_state.sme_state = NULL;
 		fp_state.svcr = &vcpu->arch.svcr;
-		fp_state.fpmr = &vcpu->arch.fpmr;
+		fp_state.fpmr = &__vcpu_sys_reg(vcpu, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
 
 		if (vcpu_has_sve(vcpu))
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index a9a11893c191..3d78ab164bab 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -376,10 +376,15 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	isb();
 
 	/* Write out the host state if it's in the registers */
-	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED)
+	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED) {
 		__fpsimd_save_state(&(vcpu->arch.host_uw->fpsimd_state));
+		if (cpus_have_final_cap(ARM64_HAS_FPMR))
+			vcpu->arch.host_uw->fpmr = read_sysreg_s(SYS_FPMR);
+	}
 
 	/* Restore the guest state */
+	if (kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64PFR2_EL1, FPMR, IMP))
+		write_sysreg_s(__vcpu_sys_reg(vcpu, FPMR), SYS_FPMR);
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
 	else
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a3c20d1a36aa..941ad700d0ab 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2068,6 +2068,15 @@ static unsigned int hidden_user_visibility(const struct kvm_vcpu *vcpu,
 	.visibility = hidden_user_visibility,	\
 }
 
+static unsigned int fpmr_visibility(const struct kvm_vcpu *vcpu,
+				    const struct sys_reg_desc *rd)
+{
+	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR2_EL1, FPMR, IMP))
+		return 0;
+
+	return REG_HIDDEN;
+}
+
 /*
  * Since reset() callback and field val are not used for idregs, they will be
  * used for specific purposes for idregs.
@@ -2469,6 +2478,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 	{ SYS_DESC(SYS_SVCR), undef_access },
+	{ SYS_DESC(SYS_FPMR), access_rw, reset_unknown, FPMR,
+	  .visibility = fpmr_visibility },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
 	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },
@@ -4054,6 +4065,8 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
 
 		if (kvm_has_feat(kvm, ID_AA64ISAR2_EL1, MOPS, IMP))
 			vcpu->arch.hcrx_el2 |= (HCRX_EL2_MSCEn | HCRX_EL2_MCE2);
+		if (kvm_has_feat(kvm, ID_AA64PFR2_EL1, FPMR, IMP))
+			vcpu->arch.hcrx_el2 |= (HCRX_EL2_EnFPM);
 	}
 
 	if (test_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags))

-- 
2.30.2


