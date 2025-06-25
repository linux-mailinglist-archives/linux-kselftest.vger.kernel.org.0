Return-Path: <linux-kselftest+bounces-35758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E24AE8126
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27E01888DB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A22E3384;
	Wed, 25 Jun 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqpGaHg/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDA2E3377;
	Wed, 25 Jun 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850742; cv=none; b=QQxjOzPv14ixoPFBJJaCOsz+rajwqMDTNmA0tx4iYPQVKDKAmL2Xgk1Hwe9GUpNQCCrj8kiaouYG19LBIRbGQFpYDNzR9d44nlu8r+p1tkWNwiPmHvORMTMAJsMXYT34RJjGFfOXet5M1xutlSg5EXEOEFnydboNjMkNVKRi2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850742; c=relaxed/simple;
	bh=9s7py1GXqPfLJ3nSFWfY1aLh2LkvTPlCASfcY/nQdPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSLPPz4kTaIVDprksWDNiVGo4pNAmyVbG0RObuP5/E/bqOBQSMo7I8ANcdBnLRiIHCBU/Bs0CVQfH2KvDCmcTvW3Ab7UyINetgL8ZArxedrn2cBdj3G34pAJmK3fX9hjyWLCLdoselcO9zqTOy5xgrnRlACkPC7fXwaLiVYrTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqpGaHg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F45C4CEEA;
	Wed, 25 Jun 2025 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850742;
	bh=9s7py1GXqPfLJ3nSFWfY1aLh2LkvTPlCASfcY/nQdPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fqpGaHg/nhhLcSO5zBHVDj3XgcFXPiWPPHi/kI7And05kRt+m7B8PJAVKCv2mStTu
	 YI9RkK9qSX1sx7xVDTseNFZ4zhM3w0epU2W7dczI0qfgUCafHIwO3s26Nc9jnCCDxz
	 PIbGr1sVGTOzOZyuDewGf3bBeVktdSN9+q8pXZHnz0vF0QN5O1s/6jgyvIm5kdbbZB
	 9noTBIOITKXqjFox0P87ExQBFv0x9q93t5ZSHupqL2FrNz94SkXrDNjFwIViW/uvov
	 T7q43Ib+FGLNs86xVeL5ODAmoxm0CY4B/j6Q1J1BaoFqV+2qzAJP0SU2jIufJa2ADa
	 7WLgr1Ygg7/wA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:06 +0100
Subject: [PATCH v6 15/28] KVM: arm64: Support SME control registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-15-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4764; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9s7py1GXqPfLJ3nSFWfY1aLh2LkvTPlCASfcY/nQdPY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xwG/rIkNRU6DPNC0sTiINlNc6BXq3kE8G4c
 XRF7hfW7oOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvccAAKCRAk1otyXVSH
 0MpuB/9226iJNL3nJTdf9YzDTvSiKxEWFgKZtzHuMS+BFYU/HVPzHwbYxiZ6/fCyYMNmU4Dv5Mw
 4pJo1L2L5lBEgZslWBO+NCA/NBEJXW4XLsF03DymiLuyfg6/Un1o2hi2DE9LoIr0jmoQWZbMDY0
 3verZmJ4ew7OqEuwFO2oNNwVjlEUil9875MKaXaboolg3vZUT8CK3eOAeIJaU9XqaLTCOU5x4nA
 oDXGC/dLYOe9+nLlUJEC9QtT8zo2dACt9tnvCe5VfCr6SQnIjxdk3FfauM6JvcSaHy5q06QtP0w
 M6eZsJsbK78RvGoRuB6iYIHVlmGn276hNGMzZJtCNeSrdy4H
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME is configured by the system registers SMCR_EL1 and SMCR_EL2, add
definitions and userspace access for them.  These control the SME vector
length in a manner similar to that for SVE and also have feature enable
bits for SME2 and FA64.  A subsequent patch will add management of them
for guests as part of the general floating point context switch, as is
done for the equivalent SVE registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h     |  2 ++
 arch/arm64/include/asm/vncr_mapping.h |  1 +
 arch/arm64/kvm/sys_regs.c             | 37 ++++++++++++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a25a5a668d29..14179e1ddb3e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -506,6 +506,7 @@ enum vcpu_sysreg {
 	CPTR_EL2,	/* Architectural Feature Trap Register (EL2) */
 	HACR_EL2,	/* Hypervisor Auxiliary Control Register */
 	ZCR_EL2,	/* SVE Control Register (EL2) */
+	SMCR_EL2,	/* SME Control Register (EL2) */
 	TTBR0_EL2,	/* Translation Table Base Register 0 (EL2) */
 	TTBR1_EL2,	/* Translation Table Base Register 1 (EL2) */
 	TCR_EL2,	/* Translation Control Register (EL2) */
@@ -543,6 +544,7 @@ enum vcpu_sysreg {
 	VNCR(ACTLR_EL1),/* Auxiliary Control Register */
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
 	VNCR(ZCR_EL1),	/* SVE Control */
+	VNCR(SMCR_EL1),	/* SME Control */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
 	VNCR(TCR_EL1),	/* Translation Control Register */
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index 6f556e993644..aede5d6efad3 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -44,6 +44,7 @@
 #define VNCR_HDFGWTR_EL2	0x1D8
 #define VNCR_ZCR_EL1            0x1E0
 #define VNCR_HAFGRTR_EL2	0x1E8
+#define VNCR_SMCR_EL1		0x1F0
 #define VNCR_TTBR0_EL1          0x200
 #define VNCR_TTBR1_EL1          0x210
 #define VNCR_FAR_EL1            0x220
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7dd4a5ef0e81..90923edb3355 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -143,6 +143,7 @@ static bool get_el2_to_el1_mapping(unsigned int reg,
 		MAPPED_EL2_SYSREG(ELR_EL2,     ELR_EL1,	    NULL	     );
 		MAPPED_EL2_SYSREG(SPSR_EL2,    SPSR_EL1,    NULL	     );
 		MAPPED_EL2_SYSREG(ZCR_EL2,     ZCR_EL1,     NULL	     );
+		MAPPED_EL2_SYSREG(SMCR_EL2,    SMCR_EL1,    NULL	     );
 		MAPPED_EL2_SYSREG(CONTEXTIDR_EL2, CONTEXTIDR_EL1, NULL	     );
 	default:
 		return false;
@@ -2558,6 +2559,37 @@ static bool access_gic_elrsr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static unsigned int sme_el2_visibility(const struct kvm_vcpu *vcpu,
+				       const struct sys_reg_desc *rd)
+{
+	return __el2_visibility(vcpu, rd, sme_visibility);
+}
+
+static bool access_smcr_el2(struct kvm_vcpu *vcpu,
+			    struct sys_reg_params *p,
+			    const struct sys_reg_desc *r)
+{
+	unsigned int vq;
+	u64 smcr;
+
+	if (guest_hyp_sve_traps_enabled(vcpu)) {
+		kvm_inject_nested_sve_trap(vcpu);
+		return true;
+	}
+
+	if (!p->is_write) {
+		p->regval = vcpu_read_sys_reg(vcpu, SMCR_EL2);
+		return true;
+	}
+
+	smcr = p->regval;
+	vq = SYS_FIELD_GET(SMCR_ELx, LEN, smcr) + 1;
+	vq = min(vq, vcpu_sme_max_vq(vcpu));
+	vcpu_write_sys_reg(vcpu, SYS_FIELD_PREP(SMCR_ELx, LEN, vq - 1),
+			   SMCR_EL2);
+	return true;
+}
+
 static unsigned int s1poe_visibility(const struct kvm_vcpu *vcpu,
 				     const struct sys_reg_desc *rd)
 {
@@ -2962,7 +2994,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
 	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
-	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
@@ -3316,6 +3348,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
+			 sme_el2_visibility),
+
 	EL2_REG(TTBR0_EL2, access_rw, reset_val, 0),
 	EL2_REG(TTBR1_EL2, access_rw, reset_val, 0),
 	EL2_REG(TCR_EL2, access_rw, reset_val, TCR_EL2_RES1),

-- 
2.39.5


