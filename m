Return-Path: <linux-kselftest+bounces-47893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F71CD7AF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B63B30DD580
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3232ED3B;
	Tue, 23 Dec 2025 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVDienFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D22326946;
	Tue, 23 Dec 2025 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452995; cv=none; b=FjMSCU4ihGuSkA+P+yCed62Tn8qGj7Wbn3PYVGLgKlIUtBx+w+YdRZCb3vqqdbRR3PkeFpjgvdbH5304T9hMjyG7VPLbd1c8eccaabDCapA32XMOlROdfITEC9A6Zvd/b98E4v/KUdYs7UZvEuV0yO+5dsb31cXVphfaSPFDKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452995; c=relaxed/simple;
	bh=7meBQOOk+cHZORi2pAyi6ETNFpYUQ8ejWOvoNqyjX4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMaf8QBBNjxSg9eTTJ2+hORhe32uBRrfclZemwJNo/ky49zj4xvBNG8XPBPxIErghqRvR/Afvx0QE7QIUdEJIat79MHSoGEqI+eGiRCDaM6hOT+0sMf8Pgw+/gzKA0poSP+o3hGiI30qXTU/wqXu8g0A4NbnylFPXRub+uKr48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVDienFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F032C19422;
	Tue, 23 Dec 2025 01:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452994;
	bh=7meBQOOk+cHZORi2pAyi6ETNFpYUQ8ejWOvoNqyjX4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eVDienFpjOatYQBZy1ZrglivhpcSztYlmPQGCQAnJfAswUVHvFJ2qI10trdhI97OQ
	 QAV6QqBw40uAYN6ruKEWmAUwNgjlBnOXtJUnaihQLAt4M1hc+9+F7XquVFE9T4Upy8
	 DK/sWYPV09rJgV2VHWQv0xc9yab5jGrnMTWtUDxBjU0Yr/POdXxit5RqhD24s6QUd1
	 xUFFvfFG4IoKJHDLKP+mWbJFaxzCGy91dRGrDzjOIl2TpPB0wFW4ArWSHlpCVw/Q1a
	 nXnEt74gVYkJeYTCnOBRiQL7Kt6EGqFDqK2HKX6sOFQVGXN+8OpGHVksS0HscFeBRD
	 ltlC3Vy2yeD6A==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:17 +0000
Subject: [PATCH v9 23/30] KVM: arm64: Context switch SME state for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-23-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=18756; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7meBQOOk+cHZORi2pAyi6ETNFpYUQ8ejWOvoNqyjX4Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6U+etODYBtBO2T1qsMK4tci8QC6LC1mCqU6
 sMI9BPSOLSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnulAAKCRAk1otyXVSH
 0OzAB/0Ta7SZjziD+P3zN0Kj2gCO9n83PpkMadOWSS5hxbH9MX+U/bPe8cigT7CGOO2SyeyRCAi
 fDqeQsE683r5KzbKj4VSB5pTkNbNpq6WKjoQUjnN8o1kVS3CCNR4yVArmLwj5jxUohybAmWz3fj
 Y+IHceUK/KBZAY5fIF0y+rPJ1yXacSb30MoGIEJyCOZL4vfgUeczRudVE7KWAdUGvW7PsUflmkw
 kbL9BLE/Jr/9wypTqLBAHiLH2VE1JpPxNwL08ddP27tPOcC1r4sUTm2GQuWQwJAPgl6bRCqbrTi
 cHetS6oX6wR6Txdv/fytb03dOO8s1sULOceKYNqo2HKKZn4r
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

A further complication is that when the hardware is in streaming mode
guest operations that are invalid in in streaming mode will generate SME
exceptions. There are also subfeature exceptions for SME2 controlled via
SMCR which generate distinct exception codes. In many situations these
exceptions are routed directly to the lower ELs with no opportunity for
the hypervisor to intercept. So that guests do not see unexpected
exception types due to the actual hardware configuration not being what
the guest configured we update the SMCRs and SVCR even if the guest does
not own the registers.

Since in order to avoid duplication with SME we now restore the register
state outside of the SVE specific restore function we need to move the
restore of the effective VL for nested guests to a separate restore
function run after loading the floating point register state, along with
the similar handling required for SME.

The selection of which vector length to use is handled by vcpu_sve_pffr().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h         |  10 +++
 arch/arm64/include/asm/kvm_emulate.h    |   6 ++
 arch/arm64/include/asm/kvm_host.h       |   4 +
 arch/arm64/kvm/fpsimd.c                 |  25 ++++--
 arch/arm64/kvm/hyp/include/hyp/switch.h | 151 ++++++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  80 +++++++++++++++--
 6 files changed, 255 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8b0840bd7e14..8642efbdcb2b 100644
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
 #else
 
 static inline void sme_user_disable(void) { BUILD_BUG(); }
@@ -471,6 +480,7 @@ static inline size_t sme_state_size(struct task_struct const *task)
 }
 
 #define sme_cond_update_smcr(val, fa64, zt0, reg) do { } while (0)
+#define sme_cond_update_smcr_vq(val, reg) do { } while (0)
 
 #endif /* ! CONFIG_ARM64_SME */
 
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index c9eab316398e..1b0ebe480e19 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -696,4 +696,10 @@ static inline void vcpu_set_hcrx(struct kvm_vcpu *vcpu)
 			vcpu->arch.hcrx_el2 |= HCRX_EL2_SCTLR2En;
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
index bd7a9a4efbc3..bceaf0608d75 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -736,6 +736,7 @@ struct kvm_host_data {
 
 	/* Used by pKVM only. */
 	u64	fpmr;
+	u64	smcr_el1;
 
 	/* Ownership of the FP regs */
 	enum {
@@ -1131,6 +1132,9 @@ struct kvm_vcpu_arch {
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
 
+#define vcpu_sme_smcr_elx(vcpu)						\
+	(unlikely(is_hyp_ctxt(vcpu)) ? SMCR_EL2 : SMCR_EL1)
+
 #define sve_state_size_from_vl(sve_max_vl) ({				\
 	size_t __size_ret;						\
 	unsigned int __vq;						\
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 1f4fcc8b5554..8fb8c55e50b3 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -69,19 +69,25 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
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
+		fp_state.sme_state = vcpu->arch.sme_state;
+		fp_state.sme_vl = vcpu->arch.max_vl[ARM64_VEC_SME];
 		fp_state.svcr = __ctxt_sys_reg(&vcpu->arch.ctxt, SVCR);
 		fp_state.fpmr = __ctxt_sys_reg(&vcpu->arch.ctxt, FPMR);
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
@@ -90,6 +96,15 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fpsimd_bind_state_to_cpu(&fp_state);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
+	} else {
+		/*
+		 * We might have enabled SME to configure traps but
+		 * insist the host doesn't run the hypervisor with SME
+		 * enabled, ensure it's disabled again.
+		 */
+		if (system_supports_sme()) {
+			sme_smstop();
+		}
 	}
 }
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 9ce53524d664..5bcc72ae48ff 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -431,6 +431,22 @@ static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return true;
 }
 
+static inline void __hyp_sme_restore_guest(struct kvm_vcpu *vcpu,
+					   bool *restore_sve,
+					   bool *restore_ffr)
+{
+	bool has_fa64 = vcpu_has_fa64(vcpu);
+	bool has_sme2 = vcpu_has_sme2(vcpu);
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
@@ -438,19 +454,25 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
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
-	if (is_nested_ctxt(vcpu))
+	if (!is_nested_ctxt(vcpu))
+		return;
+
+	if (vcpu_has_sve(vcpu))
 		sve_cond_update_zcr_vq(__vcpu_sys_reg(vcpu, ZCR_EL2), SYS_ZCR_EL2);
 
-	write_sysreg_el1(__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)), SYS_ZCR);
+	if (vcpu_has_sme(vcpu))
+		sme_cond_update_smcr_vq(__vcpu_sys_reg(vcpu, SMCR_EL2), SYS_SMCR_EL2);
 }
 
 static inline void __hyp_sve_save_host(void)
@@ -464,10 +486,46 @@ static inline void __hyp_sve_save_host(void)
 			 true);
 }
 
+static inline void kvm_sme_configure_traps(struct kvm_vcpu *vcpu)
+{
+	u64 smcr_el1, smcr_el2;
+	u64 svcr;
+
+	if (!vcpu_has_sme(vcpu))
+		return;
+
+	/* A guest hypervisor may restrict the effective max VL. */
+	if (is_nested_ctxt(vcpu))
+		smcr_el2 = __vcpu_sys_reg(vcpu, SMCR_EL2);
+	else
+		smcr_el2 = vcpu_sme_max_vq(vcpu) - 1;
+
+	if (vcpu_has_fa64(vcpu))
+		smcr_el2 |= SMCR_ELx_FA64;
+	if (vcpu_has_sme2(vcpu))
+		smcr_el2 |= SMCR_ELx_EZT0;
+
+	write_sysreg_el2(smcr_el2, SYS_SMCR);
+
+	smcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sme_smcr_elx(vcpu));
+	write_sysreg_el1(smcr_el1, SYS_SMCR);
+
+	svcr = __vcpu_sys_reg(vcpu, SVCR);
+	write_sysreg_s(svcr, SYS_SVCR);
+}
+
 static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
 {
 	u64 zcr_el1, zcr_el2;
 
+	/*
+	 * We always load the SME control registers that affect traps
+	 * since if they are not configured as expected by the guest
+	 * then it may have exceptions that it does not expect
+	 * directly delivered.
+	 */
+	kvm_sme_configure_traps(vcpu);
+
 	if (!guest_owns_fp_regs())
 		return;
 
@@ -487,8 +545,51 @@ static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
 
 static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
 {
+	u64 smcr_el1, smcr_el2;
 	u64 zcr_el1, zcr_el2;
 
+	/*
+	 * We always load the control registers for the guest so we
+	 * always restore state for the host.
+	 */
+	if (vcpu_has_sme(vcpu)) {
+		/*
+		 * __deactivate_cptr_traps() disabled traps, but there
+		 * hasn't necessarily been a context synchronization
+		 * event yet.
+		 */
+		isb();
+
+		smcr_el1 = read_sysreg_el1(SYS_SMCR);
+		__vcpu_assign_sys_reg(vcpu, vcpu_sme_smcr_elx(vcpu), smcr_el1);
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
+
+		__vcpu_assign_sys_reg(vcpu, SVCR, read_sysreg_s(SYS_SVCR));
+	}
+
 	if (!guest_owns_fp_regs())
 		return;
 
@@ -525,6 +626,16 @@ static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
 
 static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * The hypervisor refuses to run if streaming mode or ZA is
+	 * enabled, we only need to save SMCR_EL1 for SME.  For pKVM
+	 * we will restore this, reset SMCR_EL2 to a fixed value and
+	 * disable streaming mode and ZA to avoid any state being
+	 * leaked.
+	 */
+	if (system_supports_sme())
+		*host_data_ptr(smcr_el1) = read_sysreg_el1(SYS_SMCR);
+
 	/*
 	 * Non-protected kvm relies on the host restoring its sve state.
 	 * Protected kvm restores the host's sve state as not to reveal that
@@ -549,14 +660,17 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
  */
 static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	bool sve_guest;
-	u8 esr_ec;
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
@@ -575,6 +689,15 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
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
@@ -590,8 +713,20 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
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
 
@@ -602,6 +737,8 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
 		write_sysreg(__vcpu_sys_reg(vcpu, FPEXC32_EL2), fpexc32_el2);
 
+	__hyp_nv_restore_guest_vls(vcpu);
+
 	*host_data_ptr(fp_owner) = FP_STATE_GUEST_OWNED;
 
 	/*
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 208e9042aca4..bd48e149764c 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -26,14 +26,17 @@ void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
 static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 {
+	bool save_ffr = !vcpu_in_streaming_mode(vcpu) || vcpu_has_fa64(vcpu);
+
 	__vcpu_assign_sys_reg(vcpu, ZCR_EL1, read_sysreg_el1(SYS_ZCR));
+
 	/*
 	 * On saving/restoring guest sve state, always use the maximum VL for
 	 * the guest. The layout of the data when saving the sve state depends
 	 * on the VL, so use a consistent (i.e., the maximum) guest VL.
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	__sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, true);
+	__sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, save_ffr);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1, SYS_ZCR_EL2);
 }
 
@@ -57,9 +60,63 @@ static void __hyp_sve_restore_host(void)
 	write_sysreg_el1(sve_state->zcr_el1, SYS_ZCR);
 }
 
-static void fpsimd_sve_flush(void)
+static void __hyp_sme_save_guest(struct kvm_vcpu *vcpu)
 {
-	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
+	__vcpu_assign_sys_reg(vcpu, SMCR_EL1, read_sysreg_el1(SYS_SMCR));
+	__vcpu_assign_sys_reg(vcpu, SVCR, read_sysreg_s(SYS_SVCR));
+
+	/*
+	 * On saving/restoring guest sve state, always use the maximum VL for
+	 * the guest. The layout of the data when saving the sve state depends
+	 * on the VL, so use a consistent (i.e., the maximum) guest VL.
+	 *
+	 * We restore the FA64 and SME2 enables for the host since we
+	 * will always restore the host configuration so if host and
+	 * guest VLs are the same we might suppress an update.
+	 */
+	sme_cond_update_smcr(vcpu_sme_max_vq(vcpu) - 1, system_supports_fa64(),
+			     system_supports_sme2(), SYS_SMCR_EL2);
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
+static void fpsimd_sve_flush(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * If the guest has SME then we need to restore the trap
+	 * controls in SMCR and mode in SVCR in order to ensure that
+	 * traps generated directly to EL1 have the correct types,
+	 * otherwise we can defer until we load the guest state.
+	 */
+	if (vcpu_has_sme(vcpu)) {
+		kvm_hyp_save_fpsimd_host(vcpu);
+		kvm_sme_configure_traps(vcpu);
+
+		*host_data_ptr(fp_owner) = FP_STATE_FREE;
+	} else {
+		*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
+	}
 }
 
 static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
@@ -75,7 +132,10 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	 */
 	isb();
 
-	if (vcpu_has_sve(vcpu))
+	if (vcpu_has_sme(vcpu))
+		__hyp_sme_save_guest(vcpu);
+
+	if (vcpu_has_sve(vcpu) || vcpu_in_streaming_mode(vcpu))
 		__hyp_sve_save_guest(vcpu);
 	else
 		__fpsimd_save_state(&vcpu->arch.ctxt.fp_regs);
@@ -84,6 +144,9 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (has_fpmr)
 		__vcpu_assign_sys_reg(vcpu, FPMR, read_sysreg_s(SYS_FPMR));
 
+	if (system_supports_sme())
+		__hyp_sme_restore_host();
+
 	if (system_supports_sve())
 		__hyp_sve_restore_host();
 	else
@@ -121,7 +184,7 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 {
 	struct kvm_vcpu *host_vcpu = hyp_vcpu->host_vcpu;
 
-	fpsimd_sve_flush();
+	fpsimd_sve_flush(host_vcpu);
 	flush_debug_state(hyp_vcpu);
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
@@ -204,10 +267,9 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 		struct pkvm_hyp_vcpu *hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
 
 		/*
-		 * KVM (and pKVM) doesn't support SME guests for now, and
-		 * ensures that SME features aren't enabled in pstate when
-		 * loading a vcpu. Therefore, if SME features enabled the host
-		 * is misbehaving.
+		 * KVM (and pKVM) refuses to run if PSTATE.{SM,ZA} are
+		 * enabled. Therefore, if SME features enabled the
+		 * host is misbehaving.
 		 */
 		if (unlikely(system_supports_sme() && read_sysreg_s(SYS_SVCR))) {
 			ret = -EINVAL;

-- 
2.47.3


