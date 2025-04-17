Return-Path: <linux-kselftest+bounces-31019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E9FA910A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341844602F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F922ACE3;
	Thu, 17 Apr 2025 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJmfrk8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4E1B6CE9;
	Thu, 17 Apr 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849634; cv=none; b=MAuax8OukqC+PG+oFEAIqpga18WWxYTV8xj70jqu45vZlYUQRUJ5sHOBegcd+gYRV18iaV1g6l6Nj/ihzorfl7f9dsf1kv+gWtV0kGKadFWGEak2D0Tj8ILRXLtzOgGhR2mcCK4BQiVEN+n3Lo0nt482Xqfa5VER3AOid6Qq7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849634; c=relaxed/simple;
	bh=b7kGdAfUth0T1NTyXq4Cq6Cp/WpJOurZv0+8UuWRaKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qoh2fBFa9c85pJJuXFMTx2LlbBLnYtveCH6lU9n3a72jzaMxrdXJEmcwO0pkCgnBLkilDfa5kzTRNfOR/9ir7LUfcWVzUf5+AWF905X16ieB5dSiP2wgaN4PreK4Z3jIV1DvSCmRKjM6nB12NrNH7smXIryRSf4IkQripLcmEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJmfrk8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A72EC4CEE2;
	Thu, 17 Apr 2025 00:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849633;
	bh=b7kGdAfUth0T1NTyXq4Cq6Cp/WpJOurZv0+8UuWRaKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GJmfrk8OJhGoS85xmYZEOhwbG2yy3hX6v+VAt45EFmDIzZbl30BswZhX9w0NhHH21
	 nApAM0uyBkK/uZDVFNwz4nOF0eADCxnXkDWJy26+V5qLYZ0qVlof89YQVmcUFfPTKl
	 CoVpn6lBHMLIpxLfeJEdh5NhlRN1aG7DOJq/ZQyXkBkdhu6W+6RGYvsmGn1V2+W5cT
	 rhqKpu6gAqPooI3+3mTFTtA7ENCBPNU+swgq7VSEbtXCTrKwWEMD12TuXyJqB04trD
	 jiNCS95vg+D047mCB1gb6a2T3YAQVVArkNI3kFRoKbcrD/BEvsi1fB9rm1BIi8BrCw
	 U8La1s4ubfXZg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:27 +0100
Subject: [PATCH v5 23/28] KVM: arm64: Context switch SME state for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-23-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=17467; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b7kGdAfUth0T1NTyXq4Cq6Cp/WpJOurZv0+8UuWRaKc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEqBWZTcjpDadBZj5NYWLEZ0XJ2scPfqiDxG5I/e
 RmyhqJSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKgQAKCRAk1otyXVSH0P0DB/
 9k8/YJgAZxL7imFmL04e4lsYcCJ0TcubJWUNAAGd4+q/xZEO/9GeaSQwKyIKMiWprBUW/DqO87+Tbt
 1ZGYpYyj4q7NIJ3Bt0K/vzKLo258zWoKAIqrUzThJE85MJLa/4gAM0kYjwh5eCToX23c4sDyVgOuoM
 p7QvU5tb1PnzO5KnTcQKJWnv9bd4n1SBxyRaJKTHUB/1Z0488V2dIu73qdU/xNDx0zm6rvFOumKp9X
 ahoEDYEPa6DREMzS6d7LRp6K0QjSZA7Lr8/6H1N0ieSH80GIcWEIknp6hKzoRjr/oq++exUBbhnJOt
 p65cZPXgghvTmNpS/kq7+eYYqLlnzY
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
 arch/arm64/include/asm/fpsimd.h         |  10 +++
 arch/arm64/include/asm/kvm_emulate.h    |  12 +--
 arch/arm64/include/asm/kvm_host.h       |   4 +
 arch/arm64/kvm/fpsimd.c                 |  16 ++--
 arch/arm64/kvm/hyp/include/hyp/switch.h | 142 +++++++++++++++++++++++++++++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  48 ++++++++++-
 6 files changed, 208 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 7af636885c04..ca6b02c71c14 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -416,6 +416,15 @@ static inline size_t sme_state_size(struct task_struct const *task)
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
 #else
 
 static inline void sme_user_disable(void) { BUILD_BUG(); }
@@ -440,6 +449,7 @@ static inline size_t sme_state_size(struct task_struct const *task)
 }
 
 #define sme_cond_update_smcr(val, fa64, zt0, reg) do { } while (0)
+#define sme_cond_update_smcr_vq(val, reg) do { } while (0)
 
 #endif /* ! CONFIG_ARM64_SME */
 
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index bd020fc28aa9..c50c692373e8 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -608,12 +608,6 @@ static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
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
@@ -691,4 +685,10 @@ static inline void vcpu_set_hcrx(struct kvm_vcpu *vcpu)
 			vcpu->arch.hcrx_el2 |= HCRX_EL2_EnFPM;
 	}
 }
+
+static inline bool guest_hyp_sme_traps_enabled(const struct kvm_vcpu *vcpu)
+{
+	return __guest_hyp_cptr_xen_trap_enabled(vcpu, SMEN);
+}
+
 #endif /* __ARM64_KVM_EMULATE_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ef8b60222ac9..e3d9e241a46f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -682,6 +682,7 @@ struct kvm_host_data {
 
 	/* Used by pKVM only. */
 	u64	fpmr;
+	u64	smcr_el1;
 
 	/* Ownership of the FP regs */
 	enum {
@@ -1052,6 +1053,9 @@ struct kvm_vcpu_arch {
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
 
+#define vcpu_sme_smcr_elx(vcpu)						\
+	(unlikely(is_hyp_ctxt(vcpu)) ? SMCR_EL2 : SMCR_EL1)
+
 #define vcpu_sve_state_size(vcpu) ({					\
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 72c67b067ca1..1cc3bf437e64 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -95,19 +95,25 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
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
index 1c0ef9d6609d..c21e1448ae7d 100644
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
@@ -433,10 +482,54 @@ static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
 			write_sysreg_el1(zcr_el1, SYS_ZCR);
 		}
 	}
+
+	if (vcpu_has_sme(vcpu)) {
+		smcr_el1 = read_sysreg_el1(SYS_SMCR);
+		__vcpu_sys_reg(vcpu, vcpu_sme_smcr_elx(vcpu)) = smcr_el1;
+
+		smcr_el2 = 0;
+		if (system_supports_fa64())
+			smcr_el2 |= SMCR_ELx_FA64;
+		if (system_supports_sme2())
+			smcr_el2 |= SMCR_ELx_EZT0;
+
+		/*
+		 * The guest's state is always saved using the guest's max VL.
+		 * Ensure that the host has the guest's max VL active such that
+		 * the host can save the guest's state lazily, but don't
+		 * artificially restrict the host to the guest's max VL.
+		 */
+		if (has_vhe()) {
+			smcr_el2 |= vcpu_sme_max_vq(vcpu) - 1;
+			write_sysreg_el2(smcr_el2, SYS_SMCR);
+		} else {
+			smcr_el1 = smcr_el2;
+			smcr_el2 |= sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SME]) - 1;
+			write_sysreg_el2(smcr_el2, SYS_SMCR);
+
+			smcr_el1 |= vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el1(smcr_el1, SYS_SMCR);
+		}
+	}
 }
 
 static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * The hypervisor refuses to run if streaming mode or ZA is
+	 * enabled, we only need to save SMCR_EL1 for SME.  For pKVM
+	 * we will restore this, reset SMCR_EL2 to a fixed value and
+	 * disable streaming mode and ZA to avoid any state being
+	 * leaked.
+	 */
+	if (system_supports_sme()) {
+		*host_data_ptr(smcr_el1) = read_sysreg_el1(SYS_SMCR);
+
+		/* Re-enable SME traps if not supported for the guest vcpu. */
+		if (!vcpu_has_sme(vcpu))
+			cpacr_clear_set(CPACR_EL1_SMEN, 0);
+	}
+
 	/*
 	 * Non-protected kvm relies on the host restoring its sve state.
 	 * Protected kvm restores the host's sve state as not to reveal that
@@ -466,14 +559,18 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
  */
 static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	bool sve_guest;
-	u8 esr_ec;
+	u64 cpacr;
+	bool restore_sve, restore_ffr;
+	bool sve_guest, sme_guest;
+	u8 esr_ec, esr_iss_smtc;
 
 	if (!system_supports_fpsimd())
 		return false;
 
 	sve_guest = vcpu_has_sve(vcpu);
+	sme_guest = vcpu_has_sme(vcpu);
 	esr_ec = kvm_vcpu_trap_get_class(vcpu);
+	esr_iss_smtc = ESR_ELx_SME_ISS_SMTC((kvm_vcpu_get_esr(vcpu)));
 
 	/* Only handle traps the vCPU can support here: */
 	switch (esr_ec) {
@@ -492,6 +589,15 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 		if (guest_hyp_sve_traps_enabled(vcpu))
 			return false;
 		break;
+	case ESR_ELx_EC_SME:
+		if (!sme_guest)
+			return false;
+		if (guest_hyp_sme_traps_enabled(vcpu))
+			return false;
+		if (!kvm_has_sme2(vcpu->kvm) &&
+		    (esr_iss_smtc == ESR_ELx_SME_ISS_SMTC_ZT_DISABLED))
+			return false;
+		break;
 	default:
 		return false;
 	}
@@ -499,10 +605,12 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	/* Valid trap.  Switch the context: */
 
 	/* First disable enough traps to allow us to update the registers */
+	cpacr = CPACR_EL1_FPEN;
 	if (sve_guest || (is_protected_kvm_enabled() && system_supports_sve()))
-		cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN);
-	else
-		cpacr_clear_set(0, CPACR_EL1_FPEN);
+		cpacr |= CPACR_EL1_ZEN;
+	if (sme_guest || (is_protected_kvm_enabled() && system_supports_sme()))
+		cpacr |= CPACR_EL1_SMEN;
+	cpacr_clear_set(0, cpacr);
 	isb();
 
 	/* Write out the host state if it's in the registers */
@@ -510,8 +618,20 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
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
 
@@ -522,6 +642,8 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
 		write_sysreg(__vcpu_sys_reg(vcpu, FPEXC32_EL2), fpexc32_el2);
 
+	__hyp_nv_restore_guest_vls(vcpu);
+
 	*host_data_ptr(fp_owner) = FP_STATE_GUEST_OWNED;
 
 	return true;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 1fb38dc64357..d7dfc76198a5 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -26,6 +26,8 @@ void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 {
+	bool save_ffr = !vcpu_in_streaming_mode(vcpu) || vcpu_has_fa64(vcpu);
+
 	__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
 	/*
 	 * On saving/restoring guest sve state, always use the maximum VL for
@@ -33,7 +35,7 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 	 * on the VL, so use a consistent (i.e., the maximum) guest VL.
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	__sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, true);
+	__sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, save_ffr);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
 }
 
@@ -57,6 +59,38 @@ static void __hyp_sve_restore_host(void)
 	write_sysreg_el1(sve_state->zcr_el1, SYS_ZCR);
 }
 
+static void __hyp_sme_save_guest(struct kvm_vcpu *vcpu)
+{
+	__vcpu_sys_reg(vcpu, SMCR_EL1) = read_sysreg_el1(SYS_SMCR);
+	__vcpu_sys_reg(vcpu, SVCR) = read_sysreg_s(SYS_SVCR);
+
+	sme_cond_update_smcr(vcpu_sme_max_vq(vcpu) - 1, vcpu_has_fa64(vcpu),
+			     vcpu_has_sme2(vcpu), SYS_SMCR_EL2);
+
+	if (vcpu_za_enabled(vcpu))
+		__sme_save_state(vcpu_sme_state(vcpu), vcpu_has_sme2(vcpu));
+}
+
+static void __hyp_sme_restore_host(void)
+{
+	/*
+	 * The hypervisor refuses to run if we are in streaming mode
+	 * or have ZA enabled so there is no SME specific state to
+	 * restore other than the system registers.
+	 *
+	 * Note that this constrains the PE to the maximum shared VL
+	 * that was discovered, if we wish to use larger VLs this will
+	 * need to be revisited.
+	 */
+	sme_cond_update_smcr(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SME]) - 1,
+			     cpus_have_final_cap(ARM64_SME_FA64),
+			     cpus_have_final_cap(ARM64_SME2), SYS_SMCR_EL2);
+
+	write_sysreg_el1(*host_data_ptr(smcr_el1), SYS_SMCR);
+
+	sme_smstop();
+}
+
 static void fpsimd_sve_flush(void)
 {
 	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
@@ -69,10 +103,13 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (!guest_owns_fp_regs())
 		return;
 
-	cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN);
+	cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN);
 	isb();
 
-	if (vcpu_has_sve(vcpu))
+	if (vcpu_has_sme(vcpu))
+		__hyp_sme_save_guest(vcpu);
+
+	if (vcpu_has_sve(vcpu) || vcpu_in_streaming_mode(vcpu))
 		__hyp_sve_save_guest(vcpu);
 	else
 		__fpsimd_save_state(&vcpu->arch.ctxt.fp_regs);
@@ -81,6 +118,9 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (has_fpmr)
 		__vcpu_sys_reg(vcpu, FPMR) = read_sysreg_s(SYS_FPMR);
 
+	if (system_supports_sme())
+		__hyp_sme_restore_host();
+
 	if (system_supports_sve())
 		__hyp_sve_restore_host();
 	else
@@ -125,6 +165,8 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
 	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
+	hyp_vcpu->vcpu.arch.sme_state	= kern_hyp_va(host_vcpu->arch.sme_state);
+
 	/* Limit guest vector length to the maximum supported by the host.  */
 	for (i = 0; i < ARM64_VEC_MAX; i++)
 		hyp_vcpu->vcpu.arch.max_vl[i] = min(host_vcpu->arch.max_vl[i],

-- 
2.39.5


