Return-Path: <linux-kselftest+bounces-23690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF869F9740
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B65916E57A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF603229B1E;
	Fri, 20 Dec 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzRTli+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA62229B33;
	Fri, 20 Dec 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713544; cv=none; b=ECFrgosigGYEY+xmJJwwd+/XD6aYjaHBDL915UuNTJBNhuIXfvp79lEihOuWRaI9pKVxYf55rjPH5BKI3p5sYCCMDmGjQeO80UIXHD57lm+HD+Z4GX6mjviGwvqENUqwJYycQsyoGXuryIh2CF/zyPVpcL+v1WJh7jHoxqloDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713544; c=relaxed/simple;
	bh=as9CT/g9mNlDzCdZ9peiKL5S9mY67eyR2QFZtQSInNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIQfKnvziNKCyJplZpInh6X8pH0TGE98gaWKEQxJbjKcG7QRc04k7Eelrac6ydCAYfm6UJdi5uF7F/LbUCeUDmDLmLNaWJjhwN6AaFYG/Ca+t2AMbtFG3h4nBwEeTTu4iaBOLSphxkya5vnqxrfv6DjrfATGB+7X4GAuyQhSbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzRTli+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03C8C4CED7;
	Fri, 20 Dec 2024 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713544;
	bh=as9CT/g9mNlDzCdZ9peiKL5S9mY67eyR2QFZtQSInNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qzRTli+zDj0vEd6Vr7gHWaH4rdO1HaJf71+tvwwSX4tSmpbTozhLsNwLgESByiZf/
	 l6vFAw0oUN90YoZqL3ntPpRA65wvnwlN7ISEXu7+46nnEzQrlk+WD/84X5qqova993
	 uqmSlnAjstZtRuLhx3a4lqwhhcFodtw41LlWqGaiGYMBx+3tuq0FpbaY0TTFBCVDSU
	 G5sxgGvkhLXjwB170VnP80crh5OEtzPIm2dfCN/Yu09CS9YenE559ybMMMgZL8vQHZ
	 4JeSJm90JUmEtGrzzukNxuN8fSRsFCrrFP4He04oZ0PBr3v9oguN38XsW9OUpyd9M7
	 CDFsGlFoLLbdg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:48 +0000
Subject: [PATCH RFC v3 23/27] KVM: arm64: Context switch SME state for
 normal guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-23-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=13636; i=broonie@kernel.org;
 h=from:subject:message-id; bh=as9CT/g9mNlDzCdZ9peiKL5S9mY67eyR2QFZtQSInNI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBmUnaId7VIz0BTgZ76cluVdFm7HqpNhTRSxK2J
 o9YXQZ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgZgAKCRAk1otyXVSH0LCYB/
 wKhqcGuUS4wwdvXM3rFqtnty0GLrB7nhplHdYuqS3ICN4WKfq8eMOnojr1FVxrDHI+NvV1yGVC6RmT
 2dH+OgZPEHB5IJmkfyiG3uu0PaX430NAHogQNNxe+DhHCphMtwvaVb3iSxhSL7G+zX8TdvXClMmz3t
 yb+V9Pnbu1RUicTK1qe+ojyZ76OdQmWr/624HIDI7U2/vUDNUA1Krh6hxsuVFP9Nt87Qn0nx3DDHNG
 SmQBUWPYABLASurZArNXuzwRakcnSTvHL5ydd5t6/V+kltNbE6a+nHwbrAKnJqHCAkYkxxCx+3Lyu0
 /0RI84hNLL4IVcgcS/kqc82A0GFXM4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

If the guest has SME state we need to context switch that state, provide
support for that for normal guests.

SME has three sets of registers, ZA, ZT (only present for SME2) and also
streaming SVE which replaces the standard floating point registers when
active. The first two are fairly straightforward, they are accessible only
when PSTATE.ZA is set and we can reuse the assembly from the host to save
and load them from a single contiguous buffer. When PSTATE.ZA is not set
then these registers are inaccessible, if the guest enables PSTATE.ZA then
all bits will be set to 0 and nothing is required on restore.

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
 arch/arm64/include/asm/fpsimd.h         |  9 ++++
 arch/arm64/include/asm/kvm_emulate.h    |  6 +++
 arch/arm64/include/asm/kvm_host.h       |  3 ++
 arch/arm64/kvm/fpsimd.c                 | 86 ++++++++++++++++++++----------
 arch/arm64/kvm/hyp/include/hyp/switch.h | 93 ++++++++++++++++++++++++++++-----
 5 files changed, 156 insertions(+), 41 deletions(-)

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
index 5f05da7f538d29d321c424233f21b8448d8b4628..c7f3d14c1d69d9b3f7c1c22ad0919c278d2140c1 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -688,4 +688,10 @@ static inline bool guest_hyp_sve_traps_enabled(const struct kvm_vcpu *vcpu)
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
index 3e064520a86f25fb7b1185b3aca342f593f04994..4fcb2c2603ae2bc51d6993f1f6a3f81f2689717c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1013,6 +1013,9 @@ struct kvm_vcpu_arch {
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
 
+#define vcpu_sme_smcr_elx(vcpu)						\
+	(unlikely(is_hyp_ctxt(vcpu)) ? SMCR_EL2 : SMCR_EL1)
+
 #define vcpu_sve_state_size(vcpu) ({					\
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 51c844e25dfa460ecab5bb0dfc50c7680318aa20..d2a47d7163374ea51157c4817dd13fa43bd2146a 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -127,19 +127,25 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
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
@@ -186,6 +192,32 @@ static void kvm_vcpu_put_sve(struct kvm_vcpu *vcpu)
 				       SYS_ZCR_EL1);
 }
 
+static void kvm_vcpu_put_sme(struct kvm_vcpu *vcpu)
+{
+	u64 smcr;
+
+	if (!vcpu_has_sme(vcpu))
+		return;
+
+	smcr = read_sysreg_el1(SYS_SMCR);
+
+	/*
+	 * If the vCPU is in the hyp context then SMCR_EL1 is loaded
+	 * with its vEL2 counterpart.
+	 */
+	__vcpu_sys_reg(vcpu, vcpu_sme_smcr_elx(vcpu)) = smcr;
+
+	/*
+	 * As for SVE we always save the SME state for the guest using
+	 * the maximum VL supported by the guest so if we are using
+	 * nVHE or were in a nested guest we need to set the VL for
+	 * the host to match.
+	 */
+	if (!has_vhe() || (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
+		sme_cond_update_smcr_vq(vcpu_sme_max_vq(vcpu) - 1,
+					SYS_SMCR_EL1);
+}
+
 /*
  * Write back the vcpu FPSIMD regs if they are dirty, and invalidate the
  * cpu FPSIMD regs so that they can't be spuriously reused if this vcpu
@@ -198,23 +230,9 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
-	/*
-	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
-	 * the default value and we need to reenable SME.
-	 */
-	if (has_vhe() && system_supports_sme()) {
-		/* Also restore EL0 state seen on entry */
-		if (vcpu_get_flag(vcpu, HOST_SME_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_ELx_SMEN);
-		else
-			sysreg_clear_set(CPACR_EL1,
-					 CPACR_EL1_SMEN_EL0EN,
-					 CPACR_EL1_SMEN_EL1EN);
-		isb();
-	}
-
 	if (guest_owns_fp_regs()) {
 		kvm_vcpu_put_sve(vcpu);
+		kvm_vcpu_put_sme(vcpu);
 
 		/*
 		 * Flush (save and invalidate) the FP state so that if
@@ -227,18 +245,30 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 		 * when needed.
 		 */
 		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && system_supports_sve()) {
+	} else if (has_vhe() && (system_supports_sve() ||
+				 system_supports_sme())) {
 		/*
-		 * The FPSIMD/SVE state in the CPU has not been touched, and we
-		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
-		 * reset by kvm_reset_cptr_el2() in the Hyp code, disabling SVE
-		 * for EL0.  To avoid spurious traps, restore the trap state
-		 * seen by kvm_arch_vcpu_load_fp():
+		 * The FP state in the CPU has not been touched, and
+		 * we have a vector extension (and VHE): CPACR_EL1
+		 * (alias CPTR_EL2) has been reset by
+		 * kvm_reset_cptr_el2() in the Hyp code, disabling SVE
+		 * for EL0.  To avoid spurious traps, restore the trap
+		 * state seen by kvm_arch_vcpu_load_fp():
 		 */
+		u64 clear = 0;
+		u64 set = 0;
+
 		if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
+			set |= CPACR_EL1_ZEN_EL0EN;
 		else
-			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
+			clear |= CPACR_EL1_ZEN_EL0EN;
+
+		if (vcpu_get_flag(vcpu, HOST_SME_ENABLED))
+			set |= CPACR_EL1_SMEN_EL0EN;
+		else
+			clear |= CPACR_EL1_SMEN_EL0EN;
+
+		sysreg_clear_set(CPACR_EL1, clear, set);
 	}
 
 	local_irq_restore(flags);
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 09a9a237d6dd22d4bb941714363675abdab1baa7..3aed023ccaf336320b5ca5acab82e30fb52fb63d 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -343,6 +343,37 @@ static bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return true;
 }
 
+static inline void __hyp_sme_restore_guest(struct kvm_vcpu *vcpu,
+					   bool *restore_sve,
+					   bool *restore_ffr)
+{
+	u64 old_smcr, new_smcr;
+	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
+	bool has_fa64 = kvm_has_fa64(kvm);
+	bool has_sme2 = kvm_has_sme2(kvm);
+
+	old_smcr = read_sysreg_s(SYS_SMCR_EL2);
+	new_smcr = vcpu_sme_max_vq(vcpu) - 1;
+	if (has_fa64)
+		new_smcr |= SMCR_ELx_FA64_MASK;
+	if (has_sme2)
+		new_smcr |= SMCR_ELx_EZT0_MASK;
+	if (old_smcr != new_smcr)
+		write_sysreg_s(new_smcr, SYS_SMCR_EL2);
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
@@ -350,19 +381,26 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
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
-	 * The effective VL for a VM could differ from the max VL when running a
-	 * nested guest, as the guest hypervisor could select a smaller VL. Slap
-	 * that into hardware before wrapping up.
+	 * The effective VL for a VM could differ from the max VL when
+	 * running a nested guest, as the guest hypervisor could
+	 * select a smaller VL. Slap that into hardware before
+	 * wrapping up.
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
@@ -386,14 +424,18 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu);
  */
 static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
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
@@ -412,6 +454,15 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
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
@@ -419,10 +470,12 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	/* Valid trap.  Switch the context: */
 
 	/* First disable enough traps to allow us to update the registers */
+	cpacr = CPACR_ELx_FPEN;
 	if (sve_guest || (is_protected_kvm_enabled() && system_supports_sve()))
-		cpacr_clear_set(0, CPACR_ELx_FPEN | CPACR_ELx_ZEN);
-	else
-		cpacr_clear_set(0, CPACR_ELx_FPEN);
+		cpacr |= CPACR_ELx_ZEN;
+	if (sme_guest)
+		cpacr |= CPACR_ELx_SMEN;
+	cpacr_clear_set(0, cpacr);
 	isb();
 
 	/* Write out the host state if it's in the registers */
@@ -430,8 +483,20 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
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
 
@@ -442,6 +507,8 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
 		write_sysreg(__vcpu_sys_reg(vcpu, FPEXC32_EL2), fpexc32_el2);
 
+	__hyp_nv_restore_guest_vls(vcpu);
+
 	*host_data_ptr(fp_owner) = FP_STATE_GUEST_OWNED;
 
 	return true;

-- 
2.39.5


