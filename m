Return-Path: <linux-kselftest+bounces-40578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BBFB3FE78
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A043A9C78
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CDF3054C1;
	Tue,  2 Sep 2025 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpaCi98s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A92F5484;
	Tue,  2 Sep 2025 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813542; cv=none; b=WtAPkHC9zFv70TJm7flxqyNItcdton6Py1A7JRv2UQ1dMxTZO/BO/nuiURsSbb98CudRVxTyFgpE5zrbnh2A8qweSNlPCO50N9hKuGWnZ8bcaBPwtWLnv6lXOn+eJk243emIUiAILqzC7jC17nfa1TUzDI6G4PqxwP37QwFUs9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813542; c=relaxed/simple;
	bh=IOvRUXTwez4vce4kM+TbWeJxICUO2t5XVZ3KjPI4DQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSAdY/XBbKCm1d+5r9S0r6wnSQuUZIpaRZ40iKuIPgz+hZTbEh/L8lZwf1p1ZiKcdpKKcMZVzPRIY5pLZDvHY0hUD8rg3K9G6paNMsJiuKf86fCSfCErslfjVl/APrVFv3U3udi1Awr56qXSEHhgnb8AicR1FYXbLMvKTHrekEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpaCi98s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F272FC4CEF5;
	Tue,  2 Sep 2025 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813542;
	bh=IOvRUXTwez4vce4kM+TbWeJxICUO2t5XVZ3KjPI4DQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UpaCi98s6fPka0+erYNtNcDAX8/3Et25DXn+qMm58Tm4pqx4H4KBboTCtoMUbJWVc
	 SjIdJpk6LJyxyVG6WN1bkYKfry4veUTdfJ6TdPe+epw9BhzonbJqF5J/eRMZcTGLH+
	 fLzhjmdoJ+6/8bHyA8JfTpWhkAXqWC8jEpeATbSZxkwYlIsxUMBDjcqZ+paqyMSQhV
	 cEj0Avozb6kKrZjU5g/uhsuVuUhgDJp7HSVTJZPWttYuefNbYWKOIxwCREYhgv1tkK
	 aLE5tyEKakGavOhBuqzXNcCsJIx5T2KQ5/+9ColYWaAyx3Oie4wqi9QYPbN6NeDWxC
	 oISHNJfwnH4OA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:21 +0100
Subject: [PATCH v8 18/29] KVM: arm64: Support SME identification registers
 for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-18-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=8730; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IOvRUXTwez4vce4kM+TbWeJxICUO2t5XVZ3KjPI4DQM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiH0RF71Uziy+zSJEfHp66qaaMSnQCV0xwMQ
 T6hpEmJOWyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYhwAKCRAk1otyXVSH
 0CVcB/99MT8EGZWMnh4l5mgyn/GrjswQZsMK0qjufEghAgQz2ODg2Z6w/4pAvsDcP8CYjNrhgEV
 ENIDGxaTve3aT5jDaoc7pr7CS5DiqAGO7acmb/BSjCqj9JXUaSFb9Ilq903SO3XxApTsedvYvTo
 08Fj28i0M3BF8mebJlU1jYQEu/6LpNbrblPu2DGQha/vsKVI58KThCRsEkyRLC52M7AMyB79rGx
 GDoDePXrdcI+ZYEmxTtRyJ1Ktqys4uKAbF9Mjl61H0DPBSBGNDpngfkRYywhKOYLZQMdDl8ypjI
 0MXtCFOGcAvrtn3uHMoQ5cZID2i+P2PXXk3AIbX/7U/tkAo8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The primary register for identifying SME is ID_AA64PFR1_EL1.SME.  This
is hidden from guests unless SME is enabled by the VMM.
When it is visible it is writable and can be used to control the
availability of SME2.

There is also a new register ID_AA64SMFR0_EL1 which we make writable,
forcing it to all bits 0 if SME is disabled.  This includes the field
SMEver giving the SME version, userspace is responsible for ensuring
the value is consistent with ID_AA64PFR1_EL1.SME.  It also includes
FA64, a separately enableable extension which provides the full FPSIMD
and SVE instruction set including FFR in streaming mode.  Userspace can
control the availability of FA64 by writing to this field.  The other
features enumerated there only add new instructions, there are no
architectural controls for these.

There is a further identification register SMIDR_EL1 which provides a
basic description of the SME microarchitecture, in a manner similar to
MIDR_EL1 for the PE.  It also describes support for priority management
and a basic affinity description for shared SME units, plus some RES0
space.  We do not support priority management for guests so this is
hidden from guests, along with any new fields.

As for MIDR_EL1 and REVIDR_EL1 we expose the implementer and revision
information to guests with the raw value from the CPU we are running on,
this may present issues for asymmetric systems or for migration as it
does for the existing registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          |  3 +++
 arch/arm64/kvm/config.c                    |  8 +------
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 11 +++++++++
 arch/arm64/kvm/hyp/nvhe/pkvm.c             |  4 +++-
 arch/arm64/kvm/sys_regs.c                  | 37 ++++++++++++++++++++++++++----
 5 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 632c74397fa9..5225dd9b752c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -402,6 +402,7 @@ struct kvm_arch {
 	u64 revidr_el1;
 	u64 aidr_el1;
 	u64 ctr_el0;
+	u64 smidr_el1;
 
 	/* Masks for VNCR-backed and general EL2 sysregs */
 	struct kvm_sysreg_masks	*sysreg_masks;
@@ -1646,6 +1647,8 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
 		return &ka->revidr_el1;
 	case SYS_AIDR_EL1:
 		return &ka->aidr_el1;
+	case SYS_SMIDR_EL1:
+		return &ka->smidr_el1;
 	default:
 		WARN_ON_ONCE(1);
 		return NULL;
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index da66c4a14775..a08e89e210d8 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -208,14 +208,8 @@ static bool feat_anerr(struct kvm *kvm)
 
 static bool feat_sme_smps(struct kvm *kvm)
 {
-	/*
-	 * Revists this if KVM ever supports SME -- this really should
-	 * look at the guest's view of SMIDR_EL1. Funnily enough, this
-	 * is not captured in the JSON file, but only as a note in the
-	 * ARM ARM.
-	 */
 	return (kvm_has_feat(kvm, FEAT_SME) &&
-		(read_sysreg_s(SYS_SMIDR_EL1) & SMIDR_EL1_SMPS));
+		(kvm_read_vm_id_reg(kvm, SYS_SMIDR_EL1) & SMIDR_EL1_SMPS));
 }
 
 static bool feat_spe_fds(struct kvm *kvm)
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 8c3b3d6df99f..d921db152119 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -125,6 +125,17 @@ static inline u64 ctxt_midr_el1(struct kvm_cpu_context *ctxt)
 	return kvm_read_vm_id_reg(kvm, SYS_MIDR_EL1);
 }
 
+static inline u64 ctxt_smidr_el1(struct kvm_cpu_context *ctxt)
+{
+	struct kvm *kvm = kern_hyp_va(ctxt_to_vcpu(ctxt)->kvm);
+
+	if (!(ctxt_is_guest(ctxt) &&
+	      test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags)))
+		return read_sysreg_s(SYS_SMIDR_EL1);
+
+	return kvm_read_vm_id_reg(kvm, SYS_SMIDR_EL1);
+}
+
 static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
 	*ctxt_mdscr_el1(ctxt)	= read_sysreg(mdscr_el1);
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 65c49a5c7091..fc9fb2e693f6 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -338,8 +338,10 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
 			    host_kvm->arch.vcpu_features,
 			    KVM_VCPU_MAX_FEATURES);
 
-		if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &host_arch_flags))
+		if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &host_arch_flags)) {
 			hyp_vm->kvm.arch.midr_el1 = host_kvm->arch.midr_el1;
+			hyp_vm->kvm.arch.smidr_el1 = host_kvm->arch.smidr_el1;
+		}
 
 		return;
 	}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4166d396450d..36ba1986e7a1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1612,7 +1612,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac);
 		}
 
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+		if (!vcpu_has_sme(vcpu))
+			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_RNDR_trap);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_NMI);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_GCS);
@@ -1731,6 +1733,10 @@ static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
 		if (!vcpu_has_sve(vcpu))
 			return REG_RAZ;
 		break;
+	case SYS_ID_AA64SMFR0_EL1:
+		if (!vcpu_has_sme(vcpu))
+			return REG_RAZ;
+		break;
 	}
 
 	return 0;
@@ -1758,10 +1764,25 @@ static unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
 
 /* cpufeature ID register access trap handlers */
 
+static bool hidden_id_reg(struct kvm_vcpu *vcpu,
+			  struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
+{
+	switch (reg_to_encoding(r)) {
+	case SYS_SMIDR_EL1:
+		return !vcpu_has_sme(vcpu);
+	default:
+		return false;
+	}
+}
+
 static bool access_id_reg(struct kvm_vcpu *vcpu,
 			  struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
 {
+	if (hidden_id_reg(vcpu, p, r))
+		return bad_trap(vcpu, p, r, "write to hidden ID register");
+
 	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
 
@@ -2789,12 +2810,15 @@ static bool access_imp_id_reg(struct kvm_vcpu *vcpu,
 static u64 __ro_after_init boot_cpu_midr_val;
 static u64 __ro_after_init boot_cpu_revidr_val;
 static u64 __ro_after_init boot_cpu_aidr_val;
+static u64 __ro_after_init boot_cpu_smidr_val;
 
 static void init_imp_id_regs(void)
 {
 	boot_cpu_midr_val = read_sysreg(midr_el1);
 	boot_cpu_revidr_val = read_sysreg(revidr_el1);
 	boot_cpu_aidr_val = read_sysreg(aidr_el1);
+	if (system_supports_sme())
+		boot_cpu_smidr_val = read_sysreg_s(SYS_SMIDR_EL1);
 }
 
 static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
@@ -2806,6 +2830,8 @@ static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 		return boot_cpu_revidr_val;
 	case SYS_AIDR_EL1:
 		return boot_cpu_aidr_val;
+	case SYS_SMIDR_EL1:
+		return boot_cpu_smidr_val;
 	default:
 		KVM_BUG_ON(1, vcpu->kvm);
 		return 0;
@@ -2972,7 +2998,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 				       ID_AA64PFR1_EL1_MTE_frac |
 				       ID_AA64PFR1_EL1_NMI |
 				       ID_AA64PFR1_EL1_RNDR_trap |
-				       ID_AA64PFR1_EL1_SME |
 				       ID_AA64PFR1_EL1_RES0 |
 				       ID_AA64PFR1_EL1_MPAM_frac |
 				       ID_AA64PFR1_EL1_RAS_frac |
@@ -2983,7 +3008,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		    ID_AA64PFR2_EL1_MTESTOREONLY),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
-	ID_HIDDEN(ID_AA64SMFR0_EL1),
+	ID_WRITABLE(ID_AA64SMFR0_EL1, ~ID_AA64SMFR0_EL1_RES0),
 	ID_UNALLOCATED(4,6),
 	ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
 
@@ -3185,7 +3210,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
 	  .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
-	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
+	IMPLEMENTATION_ID(SMIDR_EL1, (SMIDR_EL1_NSMC | SMIDR_EL1_HIP |
+				      SMIDR_EL1_AFFINITY2 |
+				      SMIDR_EL1_IMPLEMENTER |
+				      SMIDR_EL1_REVISION | SMIDR_EL1_SH |
+				      SMIDR_EL1_AFFINITY)),
 	IMPLEMENTATION_ID(AIDR_EL1, GENMASK_ULL(63, 0)),
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	ID_FILTERED(CTR_EL0, ctr_el0,

-- 
2.39.5


