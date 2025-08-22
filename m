Return-Path: <linux-kselftest+bounces-39645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC621B30B59
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6E5B63F48
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B502BD5B9;
	Fri, 22 Aug 2025 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFzSqMBe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CC2BD031;
	Fri, 22 Aug 2025 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827761; cv=none; b=UW3Q9Aaiw8scfuKc2jIo6CR7AVJJNIDvUql0PwrCE66BoreptwtNszPjQmWX05P738yBxMF5q6aEZfMDeF12a+FkEbsxMvBMji8C1Cw4fYql++LY/XA44bZB1+w+Idnz688lkRDtW0juNuLfAZg56l2AStDX+ItWRmu1bNfQxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827761; c=relaxed/simple;
	bh=NTFrR4Ul2FjKNCZg2te+RhXOLPTLiTRbz6mCjfo2Vis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUWyRHxHk6zXSL3tImWUo/iiKI/CtpK0Ne+ihUciapJM2sk5hHRmInYk9yb3gDPBpjlmMa05m+T7ldahbJvpJMm23tJxtoet7G7QR82euIVx3VACqGyRETl0C2fJ7NnGcawE9XYLJGWh3e5s98euWNdcfkKo8nleWw0SwmnuE+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFzSqMBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30A0C4CEEB;
	Fri, 22 Aug 2025 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827761;
	bh=NTFrR4Ul2FjKNCZg2te+RhXOLPTLiTRbz6mCjfo2Vis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vFzSqMBeOaH40A7B0Jnjdq108ldYJIEuEC7FdvPT8pJ0WCVyD9b57OsiSgpPbwJRr
	 lCEAPq8UgATdZuL0OHBflicn4mKlwuUs3PQHr5uW8LH7nHHsW1soEi2cCpyt+wBXlK
	 Yp+s4eo/6h8FuRaobiZtvcBaaFgHrEC1MJUs5sFkCrpn8bx7nn4ABJ+v6e0nJwBaOY
	 0vbqROYlNXYOa0t5WUfNiqqeF5Add9g8njpy7vL+YD15N1DN66z0SSFHRajiVx0/jH
	 UaFezOrgxEmnvPShzVNFxCwUjXln+B3JG5R+ueCG60N7/JZ2AMkIIx5tVE7HNfvyeC
	 R1DqDiwcPwJwA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:54 +0100
Subject: [PATCH v7 25/29] KVM: arm64: Handle SME exceptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-25-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
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
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=6175; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NTFrR4Ul2FjKNCZg2te+RhXOLPTLiTRbz6mCjfo2Vis=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83L1eAEauMA75PPXYSGXSKCEjgzIsyz7GWSV
 xvH+3YGyrmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNywAKCRAk1otyXVSH
 0A2DB/94nXwg0bS6zk1vGd+TbpOSIKQdrdokTcbQQaE8E4c6TX30yeyg/wpb+YaW08H9TX+/XEI
 XXVA6x1UAFa9zET6o+N8ZTDmvgwq2q4c6s1hXnoX8B62BmFvvkp2Ele0kOvSOBSDtgyDUutlOys
 XKHWnXc5rs7bWzzYc0AML9mS1MQJ5oK14it60utq8t0fyEiKs2w2DOCbk1g3gcpG6tcAleG8DiS
 w/MVbro+wLb5xPfX4AR5mpAH1FFR8gPRO6wcF2fv43PRbSWt4MuPCEk4BvhhRaqFVw9CttQfKyg
 k6h6AxxmByUaC3Ji3aWNSp2zaO2Qs4+Lmj2W1blXkU237oqc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The access control for SME follows the same structure as for the base FP
and SVE extensions, with control being via CPACR_ELx.SMEN and CPTR_EL2.TSM
mirroring the equivalent FPSIMD and SVE controls in those registers. Add
handling for these controls and exceptions mirroring the existing handling
for FPSIMD and SVE.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/handle_exit.c            | 14 ++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 11 ++++++-----
 arch/arm64/kvm/hyp/nvhe/switch.c        |  4 +++-
 arch/arm64/kvm/hyp/vhe/switch.c         | 17 ++++++++++++-----
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index a598072f36d2..d96f3a585d70 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -232,6 +232,19 @@ static int handle_sve(struct kvm_vcpu *vcpu)
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
@@ -385,6 +398,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_SVC64]	= handle_svc,
 	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_SVE]	= handle_sve,
+	[ESR_ELx_EC_SME]	= handle_sme,
 	[ESR_ELx_EC_ERET]	= kvm_handle_eret,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index c128b4d25a2d..9375afa96b71 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -69,11 +69,8 @@ static inline void __activate_cptr_traps_nvhe(struct kvm_vcpu *vcpu)
 {
 	u64 val = CPTR_NVHE_EL2_RES1 | CPTR_EL2_TAM | CPTR_EL2_TTA;
 
-	/*
-	 * Always trap SME since it's not supported in KVM.
-	 * TSM is RES1 if SME isn't implemented.
-	 */
-	val |= CPTR_EL2_TSM;
+	if (!vcpu_has_sme(vcpu) || !guest_owns_fp_regs())
+		val |= CPTR_EL2_TSM;
 
 	if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs())
 		val |= CPTR_EL2_TZ;
@@ -101,6 +98,8 @@ static inline void __activate_cptr_traps_vhe(struct kvm_vcpu *vcpu)
 		val |= CPACR_EL1_FPEN;
 		if (vcpu_has_sve(vcpu))
 			val |= CPACR_EL1_ZEN;
+		if (vcpu_has_sme(vcpu))
+			val |= CPACR_EL1_SMEN;
 	}
 
 	if (!vcpu_has_nv(vcpu))
@@ -142,6 +141,8 @@ static inline void __activate_cptr_traps_vhe(struct kvm_vcpu *vcpu)
 		val &= ~CPACR_EL1_FPEN;
 	if (!(SYS_FIELD_GET(CPACR_EL1, ZEN, cptr) & BIT(0)))
 		val &= ~CPACR_EL1_ZEN;
+	if (!(SYS_FIELD_GET(CPACR_EL1, SMEN, cptr) & BIT(0)))
+		val &= ~CPACR_EL1_SMEN;
 
 	if (kvm_has_feat(vcpu->kvm, ID_AA64MMFR3_EL1, S2POE, IMP))
 		val |= cptr & CPACR_EL1_E0POE;
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index ccd575d5f6de..79a3e5c290f9 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -175,6 +175,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_SME]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
@@ -186,7 +187,8 @@ static const exit_handler_fn pvm_exit_handlers[] = {
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
index e482181c6632..86a892966a18 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -448,22 +448,28 @@ static bool kvm_hyp_handle_cpacr_el1(struct kvm_vcpu *vcpu, u64 *exit_code)
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
@@ -483,7 +489,7 @@ static bool kvm_hyp_handle_sysreg_vhe(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (kvm_hyp_handle_cpacr_el1(vcpu, exit_code))
 		return true;
 
-	if (kvm_hyp_handle_zcr_el2(vcpu, exit_code))
+	if (kvm_hyp_handle_vec_cr_el2(vcpu, exit_code))
 		return true;
 
 	return kvm_hyp_handle_sysreg(vcpu, exit_code);
@@ -512,6 +518,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg_vhe,
+	[ESR_ELx_EC_SME]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,

-- 
2.39.5


