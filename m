Return-Path: <linux-kselftest+bounces-2390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3E81CCE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9946A286412
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091528DA5;
	Fri, 22 Dec 2023 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exZJgnj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDD2FC40;
	Fri, 22 Dec 2023 16:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E936FC433C9;
	Fri, 22 Dec 2023 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262143;
	bh=cKXoapvlrxmyQ/afPMSTptUZjSWlyFOMcPcl2DBAGyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=exZJgnj0QQeOESgI1mc0BPoSS9NClrI41gMERf04Tix3RhvQaMIRhNhptlfN0weNm
	 ziOEN902n99Rv919OXxnbqR1fr+reLpRm7vIvI22qWH5Fc3V39pD2U2JRkDvKZe3B1
	 Jau9oi9EAPnDjxplPyZano7zeGPBoyHS0ndJbqRngG8raZ7O7Htmhi/bh5yAQewizK
	 tOj8bgl7tB3VtKL05NGGgzWV/qEaLlDDB16NyUAtBbjS0+OYxeCvuY5r/KuSHFGH/5
	 oTCRmyLEE6HVyvRyRXBqt6dHnhCGFpXOTuJn8MUKemo5wNeNDAzTakw8SOEHelerzA
	 etNhRR3V+oZew==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:21 +0000
Subject: [PATCH RFC v2 13/22] KVM: arm64: Context switch SME state for
 guest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-13-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=13101; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cKXoapvlrxmyQ/afPMSTptUZjSWlyFOMcPcl2DBAGyc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeGGQkTiQGzv38Qqu+jXdEytP06b2gwKFcIQ0Ia
 OmofS+KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3hgAKCRAk1otyXVSH0GujB/
 4uBb2007IrkwH+RnqE210FiwBz1IXnM+MObarSwmw5TrZ5SdbHgDncsG90CNgpwCDgTTDpaTjtno2d
 BSAIdrDi11IXjgem4GPEfLbzkbM7oQ+RnfN418vLT7ktHlKNgPyfZBj9wBDp2knjsCSTDS+xuVQZ4R
 Xtmj+kKlhvWH9OCbKGqy9icuzqOFKwAo+6Z6eJucFPMBLKBIjKqfogX8rghQlEEykVCxFBQX8rT1wI
 qOPY9gAx20Ffg27sV2NhxiaADQwAJfcVrDUnpP1+mW7qOdXw3/QzIU1GJn+7ick+FXocd1vTlo+mgs
 Iewm12UFqgBda9eoWtSfFAktO5GZ9I
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

If the guest has access to SME then we need to restore state for it and
configure SMCR_EL2 to grant the guest access to the vector lengths that
it has access to, along with FA64 and ZT0 if they were enabled.

SME has three sets of registers, ZA, ZT (only present if SME2 is
supported for the guest) and streaming SVE. ZA and streaming SVE use a
separately configured streaming mode vector length. The first two are
fairly straightforward, they are enabled by PSTATE.ZA which is saved and
restored via SVCR.ZA. We reuse the assembly the host already uses to
load them from a single contiguous buffer. If PSTATE.ZA is not set they
can only be accessed by setting PSTATE.ZA which will initialise them to
all bits 0.

Streaming mode SVE presents some complications, this is a version of
the SVE registers which may optionally omit the FFR register and which
uses the streaming mode vector length. Similarly to ZA and ZT it is
controlled by PSTATE.SM which we save and restore with SVCR.SM. Any
change in the value of PSTATE.SM initialises all bits of the floating
point registers to 0 so we do not need to be concerned about information
leakage due to changes in vector length between streaming and non-streaming
modes.

The overall floating point restore is modified to start by assuming that
we will restore either FPSIMD or full SVE register state depending on if
the guest has access to vanilla SVE. If the guest has SME we then check
the SME configuration we are restoring and override as appropriate.
Since SVE instructions are VL agnostic the hardware will load using the
appropriate vector length without us needing to pass further flags.

We also modify the floating point save to save SMCR and restore the host
configuration in a similar way to ZCR, the code is slightly more complex
since for SME as well as the vector length we also have enables for FA64
and ZT0 in the register.

Since the layout of the SVE register state depends on the vector length
we need to pass the active vector length when getting the pointer to
FFR.

Since for reasons discussed at length in aaa2f14e6f3f ("KVM: arm64:
Clarify host SME state management") we always disable both PSTATE.SM and
PSTATE.ZA prior to running the guest meaning that we do not need to
worry about saving host SME state.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       |  7 ++-
 arch/arm64/include/asm/kvm_hyp.h        |  1 +
 arch/arm64/kvm/fpsimd.c                 | 83 ++++++++++++++++++++++-----------
 arch/arm64/kvm/hyp/fpsimd.S             | 10 ++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 76 ++++++++++++++++++++++++++++--
 5 files changed, 143 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 690c439b5e2a..022b9585e6f6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -517,6 +517,7 @@ struct kvm_vcpu_arch {
 	 * records which view it saved in fp_type.
 	 */
 	void *sve_state;
+	void *sme_state;
 	enum fp_type fp_type;
 	unsigned int max_vl[ARM64_VEC_MAX];
 
@@ -818,13 +819,15 @@ struct kvm_vcpu_arch {
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
-#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.max_vl[ARM64_VEC_SVE]))
+#define vcpu_sve_pffr(vcpu, vec) (kern_hyp_va((vcpu)->arch.sve_state) +	\
+			     sve_ffr_offset((vcpu)->arch.max_vl[vec]))
 
 #define vcpu_vec_max_vq(type, vcpu) sve_vq_from_vl((vcpu)->arch.max_vl[type])
 
 #define vcpu_sve_max_vq(vcpu)	vcpu_vec_max_vq(ARM64_VEC_SVE, vcpu)
 
+#define vcpu_sme_max_vq(vcpu)	vcpu_vec_max_vq(ARM64_VEC_SME, vcpu)
+
 #define vcpu_sve_state_size(vcpu) ({					\
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 7ac38ed90062..e555af02ece3 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -112,6 +112,7 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_restore_state(void *sve_pffr, u32 *fpsr, bool restore_ffr);
+void __sme_restore_state(void const *state, bool zt);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 1be18d719fce..d9a56a4027a6 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -153,10 +153,15 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.st = &vcpu->arch.ctxt.fp_regs;
 		fp_state.sve_state = vcpu->arch.sve_state;
 		fp_state.sve_vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
-		fp_state.sme_state = NULL;
+		fp_state.sme_vl = vcpu->arch.max_vl[ARM64_VEC_SME];
+		fp_state.sme_state = vcpu->arch.sme_state;
 		fp_state.svcr = &(vcpu->arch.ctxt.sys_regs[SVCR]);
 		fp_state.fp_type = &vcpu->arch.fp_type;
 
+		/*
+		 * If we are in streaming mode PSTATE.SM will override
+		 * FP_STATE_FPSIMD during save for SME only guests.
+		 */
 		if (vcpu_has_sve(vcpu))
 			fp_state.to_save = FP_STATE_SVE;
 		else
@@ -177,26 +182,11 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
+	u64 cpacr_set, cpacr_clear;
+	u64 smcr_cur, smcr_new;
 
 	local_irq_save(flags);
 
-	/*
-	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
-	 * the default value and we need to reenable SME.
-	 */
-	if (has_vhe() && system_supports_sme()) {
-		/* Also restore EL0 state seen on entry */
-		if (vcpu_get_flag(vcpu, HOST_SME_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0,
-					 CPACR_EL1_SMEN_EL0EN |
-					 CPACR_EL1_SMEN_EL1EN);
-		else
-			sysreg_clear_set(CPACR_EL1,
-					 CPACR_EL1_SMEN_EL0EN,
-					 CPACR_EL1_SMEN_EL1EN);
-		isb();
-	}
-
 	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
 		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
@@ -207,19 +197,56 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 						       SYS_ZCR_EL1);
 		}
 
+		if (vcpu_has_sme(vcpu)) {
+			smcr_cur = read_sysreg_el1(SYS_SMCR);
+			__vcpu_sys_reg(vcpu, SMCR_EL1) = smcr_cur;
+
+			/* Restore the full VL and feature set */
+			if (!has_vhe()) {
+				smcr_new = vcpu_sme_max_vq(vcpu) - 1;
+
+				if (system_supports_fa64())
+					smcr_new |= SMCR_ELx_FA64;
+				if (system_supports_sme2())
+					smcr_new |= SMCR_ELx_EZT0_MASK;
+
+				if (smcr_cur != smcr_new)
+					write_sysreg_s(smcr_new, SYS_SMCR_EL1);
+			}
+		}
+
 		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && system_supports_sve()) {
+	} else if (has_vhe()) {
 		/*
-		 * The FPSIMD/SVE state in the CPU has not been touched, and we
-		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
-		 * reset by kvm_reset_cptr_el2() in the Hyp code, disabling SVE
-		 * for EL0.  To avoid spurious traps, restore the trap state
-		 * seen by kvm_arch_vcpu_load_fp():
+		 * The FP state in the CPU has not been touched, and
+		 * we have SVE or SME (and VHE): CPACR_EL1 (alias
+		 * CPTR_EL2) has been reset by kvm_reset_cptr_el2() in
+		 * the Hyp code, disabling SVE/SME for EL0.  To avoid
+		 * spurious traps, restore the trap state seen by
+		 * kvm_arch_vcpu_load_fp():
 		 */
-		if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
-		else
-			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
+
+		cpacr_clear = 0;
+		cpacr_set = 0;
+
+		if (system_supports_sve()) {
+			if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED)) {
+				cpacr_set |= CPACR_EL1_ZEN_EL0EN;
+			} else {
+				cpacr_clear |= CPACR_EL1_ZEN_EL0EN;
+			}
+		}
+
+		if (system_supports_sme()) {
+			if (vcpu_get_flag(vcpu, HOST_SME_ENABLED)) {
+				cpacr_set |= CPACR_EL1_SMEN_EL0EN;
+			} else {
+				cpacr_clear |= CPACR_EL1_SMEN_EL0EN;
+			}
+		}
+
+		if (cpacr_clear || cpacr_set)
+			sysreg_clear_set(CPACR_EL1, cpacr_clear, cpacr_set);
 	}
 
 	local_irq_restore(flags);
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 8940954b5420..b266f97b77ae 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -24,3 +24,13 @@ SYM_FUNC_START(__sve_restore_state)
 	sve_load 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
+
+SYM_FUNC_START(__sme_restore_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_load_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_ldr_zt 0
+1:
+	ret
+SYM_FUNC_END(__sme_restore_state)
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 0cf4770b9d70..10a055e8ed73 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -293,11 +293,45 @@ static bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	__sve_restore_state(vcpu_sve_pffr(vcpu),
-			    &vcpu->arch.ctxt.fp_regs.fpsr, true);
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
 }
 
+static inline void __hyp_sme_restore_guest(struct kvm_vcpu *vcpu,
+					   bool *restore_sve_regs,
+					   bool *restore_ffr,
+					   enum vec_type *vec_type)
+{
+	u64 svcr, old_smcr, new_smcr;
+
+	/* Configure VL and features for the guest */
+	old_smcr = read_sysreg_s(SYS_SMCR_EL2);
+	new_smcr = old_smcr & ~(SMCR_ELx_LEN_MASK | SMCR_ELx_FA64_MASK |
+				SMCR_ELx_EZT0_MASK);
+	new_smcr |= (vcpu_sme_max_vq(vcpu) - 1) & SMCR_ELx_LEN_MASK;
+	if (vcpu_has_fa64(vcpu))
+		new_smcr |= SMCR_ELx_FA64_MASK;
+	if (vcpu_has_sme2(vcpu))
+		new_smcr |= SMCR_ELx_EZT0_MASK;
+	if (old_smcr != new_smcr)
+		write_sysreg_s(new_smcr, SYS_SMCR_EL2);
+
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, SMCR_EL1), SYS_SMCR);
+
+	/* Restore SVCR before data to ensure PSTATE.{SM,ZA} are configured */
+	svcr = __vcpu_sys_reg(vcpu, SVCR);
+	write_sysreg_s(svcr, SYS_SVCR);
+
+	if (svcr & SVCR_SM_MASK) {
+		*restore_sve_regs = true;
+		*restore_ffr = vcpu_has_fa64(vcpu);
+		*vec_type = ARM64_VEC_SME;
+	}
+
+	if (svcr & SVCR_ZA_MASK)
+		__sme_restore_state(kern_hyp_va((vcpu)->arch.sme_state),
+				    vcpu_has_sme2(vcpu));
+}
+
 /*
  * We trap the first access to the FP/SIMD to save the host context and
  * restore the guest context lazily.
@@ -306,15 +340,20 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
  */
 static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	bool sve_guest;
-	u8 esr_ec;
+	bool sve_guest, sme_guest;
+	u8 esr_ec, esr_iss;
 	u64 reg;
+	bool restore_ffr;
+	bool restore_sve_regs;
+	enum vec_type vec_type = ARM64_VEC_SVE;
 
 	if (!system_supports_fpsimd())
 		return false;
 
 	sve_guest = vcpu_has_sve(vcpu);
+	sme_guest = vcpu_has_sme(vcpu);
 	esr_ec = kvm_vcpu_trap_get_class(vcpu);
+	esr_iss = ESR_ELx_ISS(kvm_vcpu_get_esr(vcpu));
 
 	/* Only handle traps the vCPU can support here: */
 	switch (esr_ec) {
@@ -324,6 +363,14 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 		if (!sve_guest)
 			return false;
 		break;
+	case ESR_ELx_EC_SME:
+		if (!sme_guest)
+			return false;
+
+		if (!vcpu_has_sme2(vcpu) &&
+		    (esr_iss == ESR_ELx_SME_ISS_ZT_DISABLED))
+			return false;
+		break;
 	default:
 		return false;
 	}
@@ -335,12 +382,16 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 		reg = CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN;
 		if (sve_guest)
 			reg |= CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN;
+		if (sme_guest)
+			reg |= CPACR_EL1_SMEN_EL0EN | CPACR_EL1_SMEN_EL1EN;
 
 		sysreg_clear_set(cpacr_el1, 0, reg);
 	} else {
 		reg = CPTR_EL2_TFP;
 		if (sve_guest)
 			reg |= CPTR_EL2_TZ;
+		if (sme_guest)
+			reg |= CPTR_EL2_TSM;
 
 		sysreg_clear_set(cptr_el2, reg, 0);
 	}
@@ -351,8 +402,25 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
 
 	/* Restore the guest state */
+
+	/*
+	 * These may be overridden if the guest has SME, the host can
+	 * have SME without SVE and in streaming mode SME may lack FFR.
+	 */
+	restore_sve_regs = sve_guest;
+	restore_ffr = sve_guest;
+
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
+	/* SVCR is cleared by kvm_arch_vcpu_load_fp() for !SME cases */
+	if (sme_guest)
+		__hyp_sme_restore_guest(vcpu, &restore_sve_regs, &restore_ffr,
+					&vec_type);
+
+	if (restore_sve_regs)
+		__sve_restore_state(vcpu_sve_pffr(vcpu, vec_type),
+				    &vcpu->arch.ctxt.fp_regs.fpsr,
+				    restore_ffr);
 	else
 		__fpsimd_restore_state(&vcpu->arch.ctxt.fp_regs);
 

-- 
2.30.2


