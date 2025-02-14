Return-Path: <linux-kselftest+bounces-26626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B55A35455
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCB716AD3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A81FCCE0;
	Fri, 14 Feb 2025 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikYtZ58z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9D1FC7F6;
	Fri, 14 Feb 2025 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498543; cv=none; b=je721RNMLd5U0m1iEylpF4McxhqynV6Mq4aynnQibTBY0O+pwHBUCFV3kquDc2L/AgHnz7r1ztqBk3SKd4yG4ATMx6mxBet4s0FtorA3/ebxFlSO7QRmSgF+UTOUUp/F3MKrGwyo8lqByerd5HCk98a0KJWspltEUzmg+cFwvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498543; c=relaxed/simple;
	bh=a0R7U93Aj1X2mHvG6B9BGzHSZUqOf61mH19+b7QsnZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jk4gTR2/tgRc7ySfNReOJ1kvUoO56pTxlgKXLWQWHhlSW4FHTWa47Xjk5RPtz3Bw0RbZdnf1L9dPrGCVqqDNCWTJu+SjT+t9PN9hnaYLfxz9XihvyyfpS5wOIaK9HXJe4NTr3qJBvrGEfVoUX61Y9APFCqqJZgFurhqnq6BGY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikYtZ58z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E393CC4CEE6;
	Fri, 14 Feb 2025 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498543;
	bh=a0R7U93Aj1X2mHvG6B9BGzHSZUqOf61mH19+b7QsnZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ikYtZ58zSQnnxg0fqKeLz0wl1MNDVKq9zdDr3PwIb9T23pd7uyJ1BJJpD0CBEAUe7
	 P2DLcc6TypbysA/B/wtXSQf264vOBDKGspXPoP1usAjDeJHcLAcShS5inn/FesvN+K
	 rPVpU0yODTaHlJTgEKWIxyFvttODZEKmGP3GBcFWTRC/iLTLwWNguHhQ2FKud7AobT
	 uziw7ez5csVIkOKNoTOpreOy6oWcP89vU7lKLTJbItZvy05U+JhQdO2+IhWrL49jjR
	 VU8nwGC4KeJI78GXdTtcmPZc/ug5Oxhd2qj1aNP9J2X14auq+KtAgq/zfYirYIF0ub
	 K76tlZTm9u4ww==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:58:05 +0000
Subject: [PATCH v4 22/27] KVM: arm64: Context switch SME state for normal
 guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-22-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=13107; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a0R7U93Aj1X2mHvG6B9BGzHSZUqOf61mH19+b7QsnZY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPRcxvCGbFA1pHya4DEakuwseyzduYcymuxEi9p
 l4Xa656JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66j0QAKCRAk1otyXVSH0E+rB/
 9otgfBqzb5ISwAh76xd66kqz24NPO3XXo+TznWNwD8my63zMYjtcq7aBnfqAC50FqGI5uxTpXP6QvM
 TzM87NIS95I462vJ1og8kSDgTbnRXObMhSwrcP0S4pPm/N+sr5Bxg8t82B/psDrIeHYu+GXLL8Fjao
 dtP40nQp2CYS18G/9wwB3aK6WIfB6Ru/DGKo5yukFgWkJkYpxVeDNL6osiOPmgBo/Y4YkOp1Lkylu1
 LMrns0qWBo38lj8VopSFYJF1VceY7gT2wVNk6L2mXutx68hMKZYna640w/j6do4sBVjHp3YPltF726
 x2x25oYtEj4J4cacfh+n3+HW6r4m10
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

If the guest has SME state we need to context switch that state, provide
support for that for normal guests.

SME has three sets of registers, ZA, ZT (only present for SME2) and also
streaming SVE which replaces the standard floating point registers when
active. The first two are fairly straightforward, they are accessible only
when PSTATE.ZA is set and we can reuse the assembly from the host to save
and load them from a single contiguous buffer. When PSTATE.ZA is not set
then these registers are inaccessible, when the guest enables PSTATE.ZA
all bits will be set to 0 by that and nothing is required on restore.

Streaming mode is slightly more complicated, when enabled via PSTATE.SM it
provides a version of the SVE registers using the SME vector length and may
optionally omit the FFR register. SME may also be present without SVE. The
register state is stored in sve_state as for non-streaming SVE mode, we
make an initial selection of registers to update based on the guest SVE
support and then override this when loading SVCR if streaming mode is
enabled.

Since in order to avoid duplication with SME we now restore the register
state outside of the SVE specific restore function we need to move the
restore of the effective VL for nested guests to a separate restore
function run after loading the floating point register state, along with
the similar handling required for SME.

The selection of which vector length to use is handled by vcpu_sve_pffr().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h         |   9 +++
 arch/arm64/include/asm/kvm_emulate.h    |  12 +--
 arch/arm64/include/asm/kvm_host.h       |   3 +
 arch/arm64/kvm/fpsimd.c                 |  16 ++--
 arch/arm64/kvm/hyp/include/hyp/switch.h | 128 +++++++++++++++++++++++++++++---
 5 files changed, 147 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 144cc805bfea112341b89c9c6028cf4b2a201c6c..f517b371e0132271a9bd693349a828e2b824ff07 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -442,6 +442,15 @@ static inline size_t sme_state_size(struct task_struct const *task)
 			write_sysreg_s(__new, (reg));		\
 	} while (0)
 
+#define sme_cond_update_smcr_vq(val, reg)			\
+	do {							\
+		u64 __smcr = read_sysreg_s((reg));		\
+		u64 __new = __smcr & ~SMCR_ELx_LEN_MASK;	\
+		__new |= (val) & SMCR_ELx_LEN_MASK;		\
+		if (__smcr != __new)				\
+			write_sysreg_s(__new, (reg));		\
+	} while (0)
+
 /* For use by EFI runtime services calls only */
 extern void __efi_fpsimd_begin(void);
 extern void __efi_fpsimd_end(void);
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 78ec1ef2cfe82ac31b19cc26ece0d94cea19b46c..19a0faae5ca02a3c8a21ffd2f8da57d56eec0c65 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -590,12 +590,6 @@ static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 	do {								\
 		BUILD_BUG_ON((set) & CPTR_VHE_EL2_RES0);		\
 		BUILD_BUG_ON((clr) & CPACR_EL1_E0POE);			\
-		__build_check_all_or_none((clr), CPACR_EL1_FPEN);	\
-		__build_check_all_or_none((set), CPACR_EL1_FPEN);	\
-		__build_check_all_or_none((clr), CPACR_EL1_ZEN);	\
-		__build_check_all_or_none((set), CPACR_EL1_ZEN);	\
-		__build_check_all_or_none((clr), CPACR_EL1_SMEN);	\
-		__build_check_all_or_none((set), CPACR_EL1_SMEN);	\
 									\
 		if (has_vhe() || has_hvhe())				\
 			sysreg_clear_set(cpacr_el1, clr, set);		\
@@ -649,4 +643,10 @@ static inline bool guest_hyp_sve_traps_enabled(const struct kvm_vcpu *vcpu)
 {
 	return __guest_hyp_cptr_xen_trap_enabled(vcpu, ZEN);
 }
+
+static inline bool guest_hyp_sme_traps_enabled(const struct kvm_vcpu *vcpu)
+{
+	return __guest_hyp_cptr_xen_trap_enabled(vcpu, SMEN);
+}
+
 #endif /* __ARM64_KVM_EMULATE_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0b00b1e42b668367b89d7ffee2839fc53c14e753..bbab22688a465dc0b5a4463cfaf061612b550fbd 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1006,6 +1006,9 @@ struct kvm_vcpu_arch {
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
 
+#define vcpu_sme_smcr_elx(vcpu)						\
+	(unlikely(is_hyp_ctxt(vcpu)) ? SMCR_EL2 : SMCR_EL1)
+
 #define vcpu_sve_state_size(vcpu) ({					\
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 656e02312a5991419bfc3c22193b6b9b4354be64..ed3a17becc489c06c9e2daa3122ec26f1e240e7c 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -100,19 +100,25 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (guest_owns_fp_regs()) {
-		/*
-		 * Currently we do not support SME guests so SVCR is
-		 * always 0 and we just need a variable to point to.
-		 */
 		fp_state.st = &vcpu->arch.ctxt.fp_regs;
 		fp_state.sve_state = vcpu->arch.sve_state;
 		fp_state.sve_vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
-		fp_state.sme_state = NULL;
+		fp_state.sme_vl = vcpu->arch.max_vl[ARM64_VEC_SME];
+		fp_state.sme_state = vcpu->arch.sme_state;
 		fp_state.svcr = &__vcpu_sys_reg(vcpu, SVCR);
 		fp_state.fpmr = &__vcpu_sys_reg(vcpu, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
+
 		fp_state.sme_features = 0;
+		if (kvm_has_fa64(vcpu->kvm))
+			fp_state.sme_features |= SMCR_ELx_FA64;
+		if (kvm_has_sme2(vcpu->kvm))
+			fp_state.sme_features |= SMCR_ELx_EZT0;
 
+		/*
+		 * For SME only hosts fpsimd_save() will override the
+		 * state selection if we are in streaming mode.
+		 */
 		if (vcpu_has_sve(vcpu))
 			fp_state.to_save = FP_STATE_SVE;
 		else
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 2c2e22d86a2353531efa49187fe80acb01d31d20..48f6188040fb6a59441bcb22937875de69d7ae34 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -343,6 +343,29 @@ static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return true;
 }
 
+static inline void __hyp_sme_restore_guest(struct kvm_vcpu *vcpu,
+					   bool *restore_sve,
+					   bool *restore_ffr)
+{
+	bool has_fa64 = vcpu_has_fa64(vcpu);
+	bool has_sme2 = vcpu_has_sme2(vcpu);
+
+	sme_cond_update_smcr(vcpu_sme_max_vq(vcpu) - 1, has_fa64, has_sme2,
+			     SYS_SMCR_EL2);
+
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, SMCR_EL1), SYS_SMCR);
+
+	write_sysreg_s(__vcpu_sys_reg(vcpu, SVCR), SYS_SVCR);
+
+	if (vcpu_in_streaming_mode(vcpu)) {
+		*restore_sve = true;
+		*restore_ffr = has_fa64;
+	}
+
+	if (vcpu_za_enabled(vcpu))
+		__sme_restore_state(vcpu_sme_state(vcpu), has_sme2);
+}
+
 static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -350,19 +373,25 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	 * vCPU. Start off with the max VL so we can load the SVE state.
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	__sve_restore_state(vcpu_sve_pffr(vcpu),
-			    &vcpu->arch.ctxt.fp_regs.fpsr,
-			    true);
 
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)), SYS_ZCR);
+}
+
+static inline void __hyp_nv_restore_guest_vls(struct kvm_vcpu *vcpu)
+{
 	/*
 	 * The effective VL for a VM could differ from the max VL when running a
 	 * nested guest, as the guest hypervisor could select a smaller VL. Slap
 	 * that into hardware before wrapping up.
 	 */
-	if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
+	if (!(vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
+		return;
+
+	if (vcpu_has_sve(vcpu))
 		sve_cond_update_zcr_vq(__vcpu_sys_reg(vcpu, ZCR_EL2), SYS_ZCR_EL2);
 
-	write_sysreg_el1(__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)), SYS_ZCR);
+	if (vcpu_has_sme(vcpu))
+		sme_cond_update_smcr_vq(__vcpu_sys_reg(vcpu, SMCR_EL2), SYS_SMCR_EL2);
 }
 
 static inline void __hyp_sve_save_host(void)
@@ -378,6 +407,7 @@ static inline void __hyp_sve_save_host(void)
 
 static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
 {
+	u64 smcr_el1, smcr_el2;
 	u64 zcr_el1, zcr_el2;
 
 	if (!guest_owns_fp_regs())
@@ -395,10 +425,29 @@ static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
 		zcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu));
 		write_sysreg_el1(zcr_el1, SYS_ZCR);
 	}
+
+	if (vcpu_has_sme(vcpu)) {
+		/* A guest hypervisor may restrict the effective max VL. */
+		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
+			smcr_el2 = __vcpu_sys_reg(vcpu, SMCR_EL2);
+		else
+			smcr_el2 = vcpu_sme_max_vq(vcpu) - 1;
+
+		if (vcpu_has_fa64(vcpu))
+			smcr_el2 |= SMCR_ELx_FA64;
+		if (vcpu_has_sme2(vcpu))
+			smcr_el2 |= SMCR_ELx_EZT0;
+
+		write_sysreg_el2(smcr_el2, SYS_SMCR);
+
+		smcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sme_smcr_elx(vcpu));
+		write_sysreg_el1(smcr_el1, SYS_SMCR);
+	}
 }
 
 static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
 {
+	u64 smcr_el1, smcr_el2;
 	u64 zcr_el1, zcr_el2;
 
 	if (!guest_owns_fp_regs())
@@ -433,6 +482,36 @@ static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
 			write_sysreg_el1(zcr_el1, SYS_ZCR);
 		}
 	}
+
+	if (vcpu_has_sme(vcpu)) {
+		smcr_el1 = read_sysreg_el1(SYS_SMCR);
+		__vcpu_sys_reg(vcpu, vcpu_sme_smcr_elx(vcpu)) = smcr_el1;
+
+		/*
+		 * The guest's state is always saved using the guest's max VL.
+		 * Ensure that the host has the guest's max VL active such that
+		 * the host can save the guest's state lazily, but don't
+		 * artificially restrict the host to the guest's max VL.
+		 */
+		if (has_vhe()) {
+			smcr_el2 = vcpu_sme_max_vq(vcpu) - 1;
+			if (vcpu_has_fa64(vcpu))
+				smcr_el2 |= SMCR_ELx_FA64;
+			if (vcpu_has_sme2(vcpu))
+				smcr_el2 |= SMCR_ELx_EZT0;
+			write_sysreg_el2(smcr_el2, SYS_SMCR);
+		} else {
+			smcr_el2 = sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SME]) - 1;
+			if (system_supports_fa64())
+				smcr_el2 |= SMCR_ELx_FA64;
+			if (system_supports_sme2())
+				smcr_el2 |= SMCR_ELx_EZT0;
+			write_sysreg_el2(smcr_el2, SYS_SMCR);
+
+			smcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el1(smcr_el1, SYS_SMCR);
+		}
+	}
 }
 
 static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
@@ -466,14 +545,18 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
  */
 static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	bool sve_guest;
-	u8 esr_ec;
+	u64 cpacr;
+	bool restore_sve, restore_ffr;
+	bool sve_guest, sme_guest;
+	u8 esr_ec, esr_iss;
 
 	if (!system_supports_fpsimd())
 		return false;
 
 	sve_guest = vcpu_has_sve(vcpu);
+	sme_guest = vcpu_has_sme(vcpu);
 	esr_ec = kvm_vcpu_trap_get_class(vcpu);
+	esr_iss = ESR_ELx_ISS(kvm_vcpu_get_esr(vcpu));
 
 	/* Only handle traps the vCPU can support here: */
 	switch (esr_ec) {
@@ -492,6 +575,15 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 		if (guest_hyp_sve_traps_enabled(vcpu))
 			return false;
 		break;
+	case ESR_ELx_EC_SME:
+		if (!sme_guest)
+			return false;
+		if (guest_hyp_sme_traps_enabled(vcpu))
+			return false;
+		if (!kvm_has_sme2(vcpu->kvm) &&
+		    (esr_iss == ESR_ELx_SME_ISS_ZT_DISABLED))
+			return false;
+		break;
 	default:
 		return false;
 	}
@@ -499,10 +591,12 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	/* Valid trap.  Switch the context: */
 
 	/* First disable enough traps to allow us to update the registers */
+	cpacr = CPACR_EL1_FPEN;
 	if (sve_guest || (is_protected_kvm_enabled() && system_supports_sve()))
-		cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN);
-	else
-		cpacr_clear_set(0, CPACR_EL1_FPEN);
+		cpacr |= CPACR_EL1_ZEN;
+	if (sme_guest)
+		cpacr |= CPACR_EL1_SMEN;
+	cpacr_clear_set(0, cpacr);
 	isb();
 
 	/* Write out the host state if it's in the registers */
@@ -510,8 +604,20 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 		kvm_hyp_save_fpsimd_host(vcpu);
 
 	/* Restore the guest state */
+
+	/* These may be overridden for a SME guest */
+	restore_sve = sve_guest;
+	restore_ffr = sve_guest;
+
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
+	if (sme_guest)
+		__hyp_sme_restore_guest(vcpu, &restore_sve, &restore_ffr);
+
+	if (restore_sve)
+		__sve_restore_state(vcpu_sve_pffr(vcpu),
+				    &vcpu->arch.ctxt.fp_regs.fpsr,
+				    restore_ffr);
 	else
 		__fpsimd_restore_state(&vcpu->arch.ctxt.fp_regs);
 
@@ -522,6 +628,8 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
 		write_sysreg(__vcpu_sys_reg(vcpu, FPEXC32_EL2), fpexc32_el2);
 
+	__hyp_nv_restore_guest_vls(vcpu);
+
 	*host_data_ptr(fp_owner) = FP_STATE_GUEST_OWNED;
 
 	return true;

-- 
2.39.5


