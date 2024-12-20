Return-Path: <linux-kselftest+bounces-23691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DB99F9745
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55110167AB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1AF22A1F5;
	Fri, 20 Dec 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebhH6sA4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6C22A1EA;
	Fri, 20 Dec 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713548; cv=none; b=LJkVXiGX/qCLaA4t5SGStOMGJ/LolVaGETq3wiDAYEEcNTTt7wiDhm9QJujkIcdzzR5k1kTiaLRsrE+Nn+9WpYZsX38/OIzxBw496IK7GQTbvXXRHIyj2Bdqy8MEAQSAd+ARHvP3PBX6Id/bXQmcigzbjClDv2s2sZmrH3t5o1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713548; c=relaxed/simple;
	bh=xfubkaGiJKFVfZEF1qDdQha6MtUZ0W2BsuPsXw245lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6OEPMtwudS2pcu30+AKgPhpyuEcM2E/5ovMJCTccOOzz0UatokszeaLIe1Z2b9qcNtH0WjXO2Zlhs2RVcEzZOkrZuas6uKW3V154MtjW4kQrhJ/Bg7ShJJHmpJj0uc9CI6En60Ov7OxbyZyxchD1+k7VMYVTElHO2dCn08obDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebhH6sA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A04C4CEE2;
	Fri, 20 Dec 2024 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713548;
	bh=xfubkaGiJKFVfZEF1qDdQha6MtUZ0W2BsuPsXw245lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ebhH6sA4HrUQCgHSXZ1JpeaWxKMuuwEqhTpWV1q63LMujLJHAjp/QD/3Bv2+6cjec
	 PtMBLMOFzwDA3Jhd3llNd20nfxvc76X3a2q2X3SBNt6Z+YNXXQXHViZ0ws04/GZbrn
	 Nc8ehOYEDGMKi6Wpu0jlVJddfo3kxAXBdAdbjH/N553zqEc01I6WBECv25ZpmdbmV9
	 qn7E10EVpWSjjA4ZtRzUjGQUbcVu6BXbJZRlXKt/ovfJX/Vx10kn11Piv9Wb+PDehg
	 U+8tnilWdXUo9aksu7KfBWlcs7WVWL60AL7KOEU/7blUEFa7BQdgs++CYGTGQ4hPbT
	 E6bTXy8Nb9v6A==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:49 +0000
Subject: [PATCH RFC v3 24/27] KVM: arm64: Handle SME exceptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-24-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8144; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xfubkaGiJKFVfZEF1qDdQha6MtUZ0W2BsuPsXw245lc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBnh8VqpDxj8bGZCifT1jzEDQ3NgG6oWQFXihXN
 u/Bk0RqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgZwAKCRAk1otyXVSH0IsEB/
 4xSMDne5g6rapiNEvGOPsW+plT92CVdursADh2x4yQ7vqI5Sm8FZWtedD6XdXhfqOK/6G60pmwzali
 Rs8AjjUhSu6SHh3+JAkyR2d71J+X+UapT7XFZ8mrSSqhXW8AyD8LIGmBBSWlDylQ7m3yhLZoBr1EK9
 07pG9U/74XsUVbY/d5qK71kvRaUNOU9ft+22CtK67KqoM+kw9PyGLctvLqUWJN3TCn/X4n1jVY+CcI
 yXW6OlRqaSTRhFBAFqdlmU+ur9mFURwDa3U5G1QhgYNW7fKX6AHBX+t+hBmaaLooNfUbzWqoMeS374
 3NwdStpFJazie5oRHwFLT+WQGRE7Hg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The access control for SME follows the same structure as for the base FP
and SVE extensions, with control being via CPACR_ELx.SMEN and CPTR_EL2.TSM
mirroring the equivalent FPSIMD and SVE controls in those registers.Add
handling for these controls and exceptions mirroring the existing handling
for FPSIMD and SVE.

When the hardware is in streaming mode guest operations that are invalid in
in streaming mode will generate SME exceptions. Since these exceptions may
be routed to EL1 with no opportunity for the hypervisor to intercept them
we already have code in kvm_arch_vcpu_load_fp() which ensures that we exit
streaming mode before running the guest. This ensures that guests do not
receive unexpected SME exceptions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h |  4 ++--
 arch/arm64/kvm/handle_exit.c         | 14 ++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  6 ++++++
 arch/arm64/kvm/hyp/nvhe/switch.c     | 11 ++++++-----
 arch/arm64/kvm/hyp/vhe/switch.c      | 21 ++++++++++++++++-----
 5 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index c7f3d14c1d69d9b3f7c1c22ad0919c278d2140c1..4c52945779a20604e18d96c78ff920abec9c4dfe 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -624,14 +624,14 @@ static __always_inline void __kvm_reset_cptr_el2(struct kvm *kvm)
 
 		if (!kvm_has_sve(kvm) || !guest_owns_fp_regs())
 			val |= CPACR_ELx_ZEN;
-		if (cpus_have_final_cap(ARM64_SME))
+		if (!kvm_has_sme(kvm) || !guest_owns_fp_regs())
 			val |= CPACR_ELx_SMEN;
 	} else {
 		val = CPTR_NVHE_EL2_RES1;
 
 		if (kvm_has_sve(kvm) && guest_owns_fp_regs())
 			val |= CPTR_EL2_TZ;
-		if (!cpus_have_final_cap(ARM64_SME))
+		if (kvm_has_sme(kvm) && guest_owns_fp_regs())
 			val |= CPTR_EL2_TSM;
 	}
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index d7c2990e7c9ed671833d1011638adeb2c15efd06..48076d0e34038808a36caf2310e11519fd04dd82 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -224,6 +224,19 @@ static int handle_sve(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+/*
+ * Guest access to SME registers should be routed to this handler only
+ * when the system doesn't support SME.
+ */
+static int handle_sme(struct kvm_vcpu *vcpu)
+{
+	if (guest_hyp_sme_traps_enabled(vcpu))
+		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_esr(vcpu));
+
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
 /*
  * Two possibilities to handle a trapping ptrauth instruction:
  *
@@ -307,6 +320,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_SVC64]	= handle_svc,
 	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_SVE]	= handle_sve,
+	[ESR_ELx_EC_SME]	= handle_sme,
 	[ESR_ELx_EC_ERET]	= kvm_handle_eret,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 7468d8516ecaa1370861e51ad4f65adbc01a5d97..481ecd757e0eba021dad6f3b268bb5235f803553 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -487,6 +487,12 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 		sve_cond_update_zcr_vq(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SVE]) - 1,
 				       SYS_ZCR_EL2);
 		break;
+	case ESR_ELx_EC_SME:
+		cpacr_clear_set(0, CPACR_ELx_SMEN);
+		isb();
+		sme_cond_update_smcr_vq(sve_vq_from_vl(kvm_host_max_vl[ARM64_VEC_SME]) - 1,
+					SYS_SMCR_EL2);
+		break;
 	case ESR_ELx_EC_IABT_LOW:
 	case ESR_ELx_EC_DABT_LOW:
 		handle_host_mem_abort(host_ctxt);
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 0ebf84a9f9e2715793bcd08c494539be25b6870e..7d29585f1fa03ad6b0063a82dcfba4c5c0b1e4a5 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -46,15 +46,14 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 			val |= CPACR_ELx_FPEN;
 			if (vcpu_has_sve(vcpu))
 				val |= CPACR_ELx_ZEN;
+			if (vcpu_has_sme(vcpu))
+				val |= CPACR_ELx_SMEN;
 		}
 	} else {
 		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
 
-		/*
-		 * Always trap SME since it's not supported in KVM.
-		 * TSM is RES1 if SME isn't implemented.
-		 */
-		val |= CPTR_EL2_TSM;
+		if (!vcpu_has_sme(vcpu) || !guest_owns_fp_regs())
+			val |= CPTR_EL2_TSM;
 
 		if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs())
 			val |= CPTR_EL2_TZ;
@@ -225,6 +224,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_SME]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
@@ -236,6 +236,7 @@ static const exit_handler_fn pvm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_SYS64]		= kvm_handle_pvm_sys64,
 	[ESR_ELx_EC_SVE]		= kvm_handle_pvm_restricted,
+	[ESR_ELx_EC_SME]		= kvm_handle_pvm_restricted,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 80581b1c399595fd64d0ccada498edac322480a6..b2ce97d47b2715d8d7c7f4f365dc9b39f93b0673 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -83,6 +83,8 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 		val |= CPACR_ELx_FPEN;
 		if (vcpu_has_sve(vcpu))
 			val |= CPACR_ELx_ZEN;
+		if (vcpu_has_sme(vcpu))
+			val |= CPACR_ELx_SMEN;
 	} else {
 		__activate_traps_fpsimd32(vcpu);
 	}
@@ -126,6 +128,8 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 		val &= ~CPACR_ELx_FPEN;
 	if (!(SYS_FIELD_GET(CPACR_ELx, ZEN, cptr) & BIT(0)))
 		val &= ~CPACR_ELx_ZEN;
+	if (!(SYS_FIELD_GET(CPACR_ELx, SMEN, cptr) & BIT(0)))
+		val &= ~CPACR_ELx_SMEN;
 
 	if (kvm_has_feat(vcpu->kvm, ID_AA64MMFR3_EL1, S2POE, IMP))
 		val |= cptr & CPACR_ELx_E0POE;
@@ -380,22 +384,28 @@ static bool kvm_hyp_handle_cpacr_el1(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return true;
 }
 
-static bool kvm_hyp_handle_zcr_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
+static bool kvm_hyp_handle_vec_cr_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
 
 	if (!vcpu_has_nv(vcpu))
 		return false;
 
-	if (sysreg != SYS_ZCR_EL2)
+	switch (sysreg) {
+	case SYS_ZCR_EL2:
+	case SYS_SMCR_EL2:
+		break;
+	default:
 		return false;
+	}
 
 	if (guest_owns_fp_regs())
 		return false;
 
 	/*
-	 * ZCR_EL2 traps are handled in the slow path, with the expectation
-	 * that the guest's FP context has already been loaded onto the CPU.
+	 * ZCR_EL2 and SMCR_EL2 traps are handled in the slow path,
+	 * with the expectation that the guest's FP context has
+	 * already been loaded onto the CPU.
 	 *
 	 * Load the guest's FP context and unconditionally forward to the
 	 * slow path for handling (i.e. return false).
@@ -412,7 +422,7 @@ static bool kvm_hyp_handle_sysreg_vhe(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (kvm_hyp_handle_cpacr_el1(vcpu, exit_code))
 		return true;
 
-	if (kvm_hyp_handle_zcr_el2(vcpu, exit_code))
+	if (kvm_hyp_handle_vec_cr_el2(vcpu, exit_code))
 		return true;
 
 	return kvm_hyp_handle_sysreg(vcpu, exit_code);
@@ -422,6 +432,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg_vhe,
+	[ESR_ELx_EC_SME]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,

-- 
2.39.5


