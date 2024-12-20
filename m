Return-Path: <linux-kselftest+bounces-23685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFE9F971A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446D97A1B5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3AA2288FD;
	Fri, 20 Dec 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqkvOVSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D121C198;
	Fri, 20 Dec 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713526; cv=none; b=GeSRnn4Rkl4pNtoNmx9xeVcOzIXZUQMY+coYgUPE1hNqww9r2ygdueX5ndQsXQBVmjmPpgdWbaHxidPzEQgXu7ugombvK6bR765NTnj5nA1P2f4udtwt5xx+b47bxXGnv1KZiLsSZjIcs7yd5sEi+hec7QmKiwmGNpw4ecT7wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713526; c=relaxed/simple;
	bh=ugWnPjaP6zeZk+xhqbQnNKY7IW5UR6NCSNSJraf8UWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgCoKGbnKnE9ZGSS2SrrKIo+3sV5J4MEa5x0R9ku8MXBUCFOIoOWPALd8uesHDZrtHNA1x5F7TybSTT4dIHZXF6OZ9vJuzW82djbdXefyMUzGxtxlIyVxV0U88yp6uU1yTUEEtmB3BtTYZldLw0mN73Nb98+ftJmHoFvY9vsjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqkvOVSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB5EC4CECD;
	Fri, 20 Dec 2024 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713525;
	bh=ugWnPjaP6zeZk+xhqbQnNKY7IW5UR6NCSNSJraf8UWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QqkvOVSBClkTAoxPDQIOr6BOiamrjEBCoqgeF7rmEv8oue8TNeeOMeAGx7vHGSkui
	 /oiM9Gl527gyYX24SsWvk/Ts4rytLCjqk8OepzPydPtl0COdSrzbav8OGHCPDeYmfU
	 TN2a1aRPBrRIMPbvzhveKnzefTpk15rqA6qq61DiYlEE8DX1eSgImlCvUQjqFOTZU/
	 oo6fIhQ3HXrDPJoKzd2JJLy1EqFaNw5VR6bNN2R9ayQg6r2AJOrhuq3HVZC5ccmrUr
	 thxHTbiF0i5kNXsWVm0eHgFAVU8f3LlXVBEXis20aDtvCIW+Q0xTplsdMZqdt2sBTZ
	 Wqa1B84n4TZgw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:43 +0000
Subject: [PATCH RFC v3 18/27] KVM: arm64: Support SMIDR_EL1 for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-18-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4343; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ugWnPjaP6zeZk+xhqbQnNKY7IW5UR6NCSNSJraf8UWI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBi306AU+25ymsIInB6kYrxfAyUEl8/NHvT1eLF
 XMFeG7CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgYgAKCRAk1otyXVSH0BVOB/
 4qxP9v6MmfqF6r8myKyAk8gF2kl3QE96D+Za51PzoU1WnpI0pYByC6QnpHzdKbLeo/LBGvfvKcPYUJ
 ZzPhLV6RlKvCV0b7zuzT3ISPcdyOvaArKcyMNOMaPEVV1xalmWFM0u+efWWlp+Nb76XoCdonD+cFqh
 ZcnlV1Jpc5QnZBhf7Mn3t2qOZ7ckLA8xe5Sxh5TN/2hq0CV8qiufZ2AF32D8CEDU8ciXe5bdWipWXv
 EBedDKL4CaTlQGhum+UFkRLC0ZUj7Y6uYFOvRMacK+FTvkk5VH8MqUBO9evSNyeRQsSEmRHWy5uetL
 +IbVJho34Pi7AW3GFwVbg1DgjIXL6E
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds an identification register SMIDR_EL1 which provides a basic
description of the SME implementation, describing the implementation
in a manner similar to MIDR_EL1 for the PE as well as indicating support
for priority management.

Since we do not currently support SME priority control we mask out SMPS,
indicating that priority management is not supported.  We do the same
for Affinity, indicating that there is no physical sharing, and unknown
fields.

As for MIDR_EL1 and REVIDR_EL1 we expose the implementer and revision
information to guests with the raw value from the CPU we are running on,
this may present issues for asymmetric systems or for migration as it
does for the existing registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/sys_regs.c         | 46 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 063b75eb4f3bc4fb425d2abc8118a950bccc2317..a304b02efcadba5371edffe97e911bba0634ed62 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -472,6 +472,7 @@ enum vcpu_sysreg {
 	/* FP/SIMD/SVE */
 	SVCR,
 	FPMR,
+	SMIDR_EL1,	/* Streaming Mode Identification Register */
 
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b5a38fc7a4a9ed4fce053018eb6ff353ae5c0d09..416c855153ca532e4c6557d78599e9af0f913071 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -882,6 +882,39 @@ static u64 reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
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
+	 * Mask out any priority or affinity information, or fields we
+	 * don't know about.
+	 */
+	smidr &= ~(SMIDR_EL1_SMPS_MASK | SMIDR_EL1_AFFINITY_MASK |
+		   SMIDR_EL1_RES0);
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
@@ -1576,7 +1609,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		if (!kvm_has_mte(vcpu->kvm))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
 
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+		if (!vcpu_has_sme(vcpu))
+			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_RNDR_trap);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_NMI);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE_frac);
@@ -1676,6 +1711,10 @@ static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
 		if (!vcpu_has_sve(vcpu))
 			return REG_RAZ;
 		break;
+	case SYS_ID_AA64SMFR0_EL1:
+		if (!vcpu_has_sme(vcpu))
+			return REG_RAZ;
+		break;
 	}
 
 	return 0;
@@ -2601,7 +2640,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_FPMR),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
-	ID_HIDDEN(ID_AA64SMFR0_EL1),
+	ID_WRITABLE(ID_AA64SMFR0_EL1, ~ID_AA64SMFR0_EL1_RES0),
 	ID_UNALLOCATED(4,6),
 	ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
 
@@ -2799,7 +2838,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
 	  .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
-	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMIDR_EL1), .access = access_smidr, .reset = reset_smidr,
+	  .reg = SMIDR_EL1, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	ID_FILTERED(CTR_EL0, ctr_el0,
 		    CTR_EL0_DIC_MASK |

-- 
2.39.5


