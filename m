Return-Path: <linux-kselftest+bounces-31020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B2A910A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B80D4600CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1FE22B8CF;
	Thu, 17 Apr 2025 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn2UP3ce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC21C3F30;
	Thu, 17 Apr 2025 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849638; cv=none; b=qZy/15Lh6Tja3xnnz0wlHBlvTTMaCq5TvUoyoPeQ+hWSZwdCzwjnFJrbPaIvf3VWahqJtj/I4rmOZTBcodRLq0bYpvEJb0PYmODhpzxxuQMvCEEiC6HFy/FFaG+BBrzAx1XbKWlWzGSyITDseOrjqMQPXC8jdpusTTfyA7CGuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849638; c=relaxed/simple;
	bh=pe5aI37YwedWzR6XP4KVR8L0CbNpDRvIXsy/vJcYfoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxE8zXSDS/Nh6A+zYlGf0JWNnniPPx7fWszxsAuiRkULVu8x87zphG23Mhc6bsj/dLXflrWKbAci/aWke4RhfWnIoF8e3VawdXaaizuFtdeaBvx6qMBsTWUqoNp9XGSkNzoZZEVpGvCVa3J+ao1iGsHRL6RtocCMJRlMgL75XEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn2UP3ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6551C4CEEE;
	Thu, 17 Apr 2025 00:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849637;
	bh=pe5aI37YwedWzR6XP4KVR8L0CbNpDRvIXsy/vJcYfoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qn2UP3ce+NDDRx975aSO2yZEf3+Ie0B9BupB1NCJwcrAijYfZiwMKQNtzzAoZDLaF
	 dftxI337gmIxFJBCtDPh784f4RPMb3nHK53jrN35gckOFkDe+R8/EzVAsoMbNBCyWI
	 YEZumZADCBsd0L/ct2rvWS1INVLj70M4PRDhgDBOCrMDkgxYCYyYAUPJ1QCh5DyaVE
	 vwIdxhNZOWO1e+xDAtGR8KaMb3mI6rR8YlG5Wzfzr3T20yaVptQziwtP2pZklvjYSD
	 yOT4ZZVbf5UntOuXrzVTLko+UGWHjpiFK7N3OK5eWEv5pBxZtSX4kbGOoKyZQFTgSc
	 gNjIhYLqM8eFg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:28 +0100
Subject: [PATCH v5 24/28] KVM: arm64: Handle SME exceptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-24-f469a2d5f574@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9675; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pe5aI37YwedWzR6XP4KVR8L0CbNpDRvIXsy/vJcYfoI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEqBhCmUmWSDkXi1qqNwc9qof49aABQf9d2SonRF
 6xkW1D+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKgQAKCRAk1otyXVSH0DF4B/
 9qSK6BOlvAbecTiGsouhvmBoO1IpmjYs0U1JxdLx+mFKe1PXSfVgSgl0wacRKZ8MNfuuGzbv/E8TNU
 nuBMVPgz7rPx3NrrNMG6u9Ml+I6N9Cah0jfc+ibrHOZxfS0YaMgxSz7SqAPG+J/sPJwymLxjJ+m8CU
 UhPCqT/ecN/CF2cylnKsqTmp2En2Oco9HfxP5kJqw0/7ZhBLqewoNWkbr55CnoS3urfx/EokydVTYZ
 jEIR5fQcPGoEt5wIIa5C94jEjVmDPamGTNCRlJsGlOMxmZ1wDNmFqUzABrEdoYibRbTMiVHTskayqP
 CbL2gSgnS3cp9Ko5px6c6GKblI2Q72
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The access control for SME follows the same structure as for the base FP
and SVE extensions, with control being via CPACR_ELx.SMEN and CPTR_EL2.TSM
mirroring the equivalent FPSIMD and SVE controls in those registers. Add
handling for these controls and exceptions mirroring the existing handling
for FPSIMD and SVE.

When the hardware is in streaming mode guest operations that are invalid in
in streaming mode will generate SME exceptions. In many situations
these exceptions are routed directly to the lower ELs with no
opportunity for the hypervisor to intercept. So that guests do not see
unexpected exception types due to the hardware streaming mode
configuration not being what the guest configured we update SVCR when
enabling floating point traps for the guest. For pKVM this means that
when changing SVCR we need to save the host floating point state before
returning to the guest.

Signed-off-by: Mark Brown <broonie@kernel.org>

squash ctxtsync
---
 arch/arm64/kvm/handle_exit.c       | 14 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 22 ++++++++++++++++-----
 arch/arm64/kvm/hyp/nvhe/switch.c   | 40 +++++++++++++++++++++++++++++++-------
 arch/arm64/kvm/hyp/vhe/switch.c    | 29 ++++++++++++++++++++++-----
 4 files changed, 88 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index b73dc26bc44b..6b7f83cc5a20 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -231,6 +231,19 @@ static int handle_sve(struct kvm_vcpu *vcpu)
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
@@ -314,6 +327,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_SVC64]	= handle_svc,
 	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_SVE]	= handle_sve,
+	[ESR_ELx_EC_SME]	= handle_sme,
 	[ESR_ELx_EC_ERET]	= kvm_handle_eret,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index d7dfc76198a5..a2132682913a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -100,8 +100,21 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 {
 	bool has_fpmr;
 
-	if (!guest_owns_fp_regs())
+	if (!guest_owns_fp_regs()) {
+		/*
+		 * We always restore SVCR for SME guests to ensure
+		 * exceptions within the guest are delivered with the
+		 * right type, always reset it to the fixed host
+		 * value.
+		 */
+		if (vcpu_has_sme(vcpu)) {
+			cpacr_clear_set(0, CPACR_EL1_SMEN);
+			isb();
+
+			sme_smstop();
+		}
 		return;
+	}
 
 	cpacr_clear_set(0, CPACR_EL1_FPEN | CPACR_EL1_ZEN | CPACR_EL1_SMEN);
 	isb();
@@ -249,10 +262,9 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
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
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 7d2ba6ef0261..d945e6c79504 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -35,12 +35,37 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
 extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
 
+static void __activate_traps_sme(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu_has_sme(vcpu))
+		return;
+
+	if (__vcpu_sys_reg(vcpu, SVCR) == read_sysreg_s(SYS_SVCR))
+		return;
+
+	/*
+	 * Write out the host state if it's in the registers,
+	 * updating SVCR will invalidate it.
+	 */
+	if (host_owns_fp_regs())
+		kvm_hyp_save_fpsimd_host(vcpu);
+
+	/*
+	 * Always restore SVCR to ensure that exceptions delivered
+	 * directly within the guest have the correct type.
+	 */
+	write_sysreg_s(__vcpu_sys_reg(vcpu, SVCR), SYS_SVCR);
+	*host_data_ptr(fp_owner) = FP_STATE_FREE;
+}
+
 static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
 
-	if (!guest_owns_fp_regs())
+	if (!guest_owns_fp_regs()) {
 		__activate_traps_fpsimd32(vcpu);
+		__activate_traps_sme(vcpu);
+	}
 
 	if (has_hvhe()) {
 		val |= CPACR_EL1_TTA;
@@ -49,17 +74,16 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 			val |= CPACR_EL1_FPEN;
 			if (vcpu_has_sve(vcpu))
 				val |= CPACR_EL1_ZEN;
+			if (vcpu_has_sme(vcpu))
+				val |= CPACR_EL1_SMEN;
 		}
 
 		write_sysreg(val, cpacr_el1);
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
@@ -222,6 +246,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_SME]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
@@ -233,7 +258,8 @@ static const exit_handler_fn pvm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_SYS64]		= kvm_handle_pvm_sys64,
 	[ESR_ELx_EC_SVE]		= kvm_handle_pvm_restricted,
-	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_SME]		= kvm_handle_pvm_restricted,
+	[ESR_ELx_EC_FP_ASIMD]		= kvm_handle_pvm_restricted,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
 	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 731a0378ed13..eb50e13d7013 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -67,6 +67,7 @@ static u64 __compute_hcr(struct kvm_vcpu *vcpu)
 
 static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
+	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 	u64 cptr;
 
 	/*
@@ -83,8 +84,17 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 		val |= CPACR_EL1_FPEN;
 		if (vcpu_has_sve(vcpu))
 			val |= CPACR_EL1_ZEN;
+		if (vcpu_has_sme(vcpu))
+			val |= CPACR_EL1_SMEN;
 	} else {
 		__activate_traps_fpsimd32(vcpu);
+
+		/*
+		 * Streaming mode affects exception types delivered
+		 * directly to lower ELs for FP operations, configure it.
+		 */
+		if (vcpu_has_sme(vcpu))
+			write_sysreg_s(ctxt_sys_reg(ctxt, SVCR), SYS_SVCR);
 	}
 
 	if (!vcpu_has_nv(vcpu))
@@ -126,6 +136,8 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 		val &= ~CPACR_EL1_FPEN;
 	if (!(SYS_FIELD_GET(CPACR_EL1, ZEN, cptr) & BIT(0)))
 		val &= ~CPACR_EL1_ZEN;
+	if (!(SYS_FIELD_GET(CPACR_EL1, SMEN, cptr) & BIT(0)))
+		val &= ~CPACR_EL1_SMEN;
 
 	if (kvm_has_feat(vcpu->kvm, ID_AA64MMFR3_EL1, S2POE, IMP))
 		val |= cptr & CPACR_EL1_E0POE;
@@ -486,22 +498,28 @@ static bool kvm_hyp_handle_cpacr_el1(struct kvm_vcpu *vcpu, u64 *exit_code)
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
@@ -521,7 +539,7 @@ static bool kvm_hyp_handle_sysreg_vhe(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (kvm_hyp_handle_cpacr_el1(vcpu, exit_code))
 		return true;
 
-	if (kvm_hyp_handle_zcr_el2(vcpu, exit_code))
+	if (kvm_hyp_handle_vec_cr_el2(vcpu, exit_code))
 		return true;
 
 	return kvm_hyp_handle_sysreg(vcpu, exit_code);
@@ -550,6 +568,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg_vhe,
+	[ESR_ELx_EC_SME]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,

-- 
2.39.5


