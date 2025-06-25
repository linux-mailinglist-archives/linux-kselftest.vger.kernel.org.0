Return-Path: <linux-kselftest+bounces-35760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A910AE8134
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5795A7B2B39
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CB2E6D11;
	Wed, 25 Jun 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4gsm5YC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF412E62D5;
	Wed, 25 Jun 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850749; cv=none; b=Gb0kOktsZobUqgSNsff0VyeSjw7xyoW7ECUbO1BJIzSk9OfKn2wXTvCmAH/w/7DOQ1vm14LOUSOAvUmygKOkInZZMvOwQm6B32fWs3pP0rJtOaQMmhcIhbKtj2+6yEf6hd3l9RBp5qqEU10e5OQJn1T98BI9PKVZB/+q3NnVR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850749; c=relaxed/simple;
	bh=QJQHUAMW8r5F6GKVZSnOYzg0vb/nAN5jmjGWnBd733g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0/4gbsLKoy6xEgPcgY9wLYWDubeQAeKy+/luBO8OWp0SoY8ZYZJTl96Go2myurecQFImVqW1xfyEcNAXfHtZGVC/JHFxI0zVVo+CRnPBy/Pali6Z5QOcWvuBRJIcmM633albTMTruR9NIgItTC+SDExnntcdSGjbKqLNhSISKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4gsm5YC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30471C4CEF0;
	Wed, 25 Jun 2025 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850749;
	bh=QJQHUAMW8r5F6GKVZSnOYzg0vb/nAN5jmjGWnBd733g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n4gsm5YC8/Bq9q5kJQvXi8Es93buxrbp930eF1n1AHmk3nLaT3m/fA9EWLeLvj4MG
	 k9d0STQ7srHWAIxbQ4MSi3zOIx1UiNGVR0zJtwq6Vh2eJNSEHtvGSlnlkaI/XRz0Gk
	 6Bf7oInuoswuJe+WNhnWoPpzlJq4GgL3iVjxD8wy1ErJ1R9iNDapOZUmbNiyh8Dqq9
	 nKRYJk576ZSSpQRSDUx9IzuH7eXTGnpbk5MJjZOWMXC7fMxnA+obC4yvaP0mQRIYrU
	 sACTflwDZNLmQrpWKOXG1/ggS7leEV+9ZDM9mvdfF9Y9UdKwnSa3Y66hmAw3OBP2MV
	 bp/lMnl28geOQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:08 +0100
Subject: [PATCH v6 17/28] KVM: arm64: Support SME identification registers
 for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-17-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=5391; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QJQHUAMW8r5F6GKVZSnOYzg0vb/nAN5jmjGWnBd733g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xyedImk1DyVTTDOWwqVQ2omp2HQOxkrUZad
 ofMWuIZIyaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvccgAKCRAk1otyXVSH
 0N0tB/9sfmdk+z3bP5LajBZOqhA7CEYD8+ADKyXhfg2Th7MN9RDtgJ+y9fIeV3Sf3wTm0Dl9q34
 FSnKC+H0gdZyZzbiGAs50I9/c/AaXaT02uROVCDxdE9fS2qtZ0V7I6nvYG3XwE09h9Wjxmmpm2f
 GNmveYb4sFm1/lDYsr0WXka53TWuz3XibFsA7QbiX0To8WMRLHWEh/mp73brumfXhp7xc1lUpBU
 RZntIxp5Jhm5e7KC1PVHnOl4NhwpM8TXYZKrjETjpBCWJcfM3B5hg6+XAKqY8DDuwoyxoiUNRsf
 afcYvxo51SG/97KTJdgCiwzCWiisHJE8Nzu70aV+Qxlzys9g
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
space.  We do not support priority management and affinity is not
meaningful for guests so we mask out everything except for the
microarchitecture description.

As for MIDR_EL1 and REVIDR_EL1 we expose the implementer and revision
information to guests with the raw value from the CPU we are running on,
this may present issues for asymmetric systems or for migration as it
does for the existing registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/sys_regs.c         | 46 +++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c26099f74648..29b8697c8144 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -494,6 +494,7 @@ enum vcpu_sysreg {
 	/* FP/SIMD/SVE */
 	SVCR,
 	FPMR,
+	SMIDR_EL1,	/* Streaming Mode Identification Register */
 
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index caa90dae8184..b11bb95e9e35 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -774,6 +774,38 @@ static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	return mpidr;
 }
 
+static u64 reset_smidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 smidr = 0;
+
+	if (!system_supports_sme())
+		return smidr;
+
+	smidr = read_sysreg_s(SYS_SMIDR_EL1);
+
+	/*
+	 * Mask out everything except for the implementer and revison,
+	 * in particular priority management is not implemented.
+	 */
+	smidr &= SMIDR_EL1_IMPLEMENTER_MASK | SMIDR_EL1_REVISION_MASK;
+
+	vcpu_write_sys_reg(vcpu, smidr, SMIDR_EL1);
+
+	return smidr;
+}
+
+static bool access_smidr(struct kvm_vcpu *vcpu,
+			 struct sys_reg_params *p,
+			 const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = vcpu_read_sys_reg(vcpu, r->reg);
+
+	return true;
+}
+
 static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *r)
 {
@@ -1607,7 +1639,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac);
 		}
 
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+		if (!vcpu_has_sme(vcpu))
+			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_RNDR_trap);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_NMI);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_GCS);
@@ -1723,6 +1757,10 @@ static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
 		if (!vcpu_has_sve(vcpu))
 			return REG_RAZ;
 		break;
+	case SYS_ID_AA64SMFR0_EL1:
+		if (!vcpu_has_sme(vcpu))
+			return REG_RAZ;
+		break;
 	}
 
 	return 0;
@@ -2905,7 +2943,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 				       ID_AA64PFR1_EL1_MTE_frac |
 				       ID_AA64PFR1_EL1_NMI |
 				       ID_AA64PFR1_EL1_RNDR_trap |
-				       ID_AA64PFR1_EL1_SME |
 				       ID_AA64PFR1_EL1_RES0 |
 				       ID_AA64PFR1_EL1_MPAM_frac |
 				       ID_AA64PFR1_EL1_RAS_frac |
@@ -2913,7 +2950,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_FPMR),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
-	ID_HIDDEN(ID_AA64SMFR0_EL1),
+	ID_WRITABLE(ID_AA64SMFR0_EL1, ~ID_AA64SMFR0_EL1_RES0),
 	ID_UNALLOCATED(4,6),
 	ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
 
@@ -3112,7 +3149,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
 	  .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
-	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMIDR_EL1), .access = access_smidr, .reset = reset_smidr,
+	  .reg = SMIDR_EL1, .visibility = sme_visibility },
 	IMPLEMENTATION_ID(AIDR_EL1, GENMASK_ULL(63, 0)),
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	ID_FILTERED(CTR_EL0, ctr_el0,

-- 
2.39.5


