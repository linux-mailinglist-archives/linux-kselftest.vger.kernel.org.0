Return-Path: <linux-kselftest+bounces-23686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D17F9F972C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3438E16CC21
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692B21C9EC;
	Fri, 20 Dec 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBB6xvvQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55109229124;
	Fri, 20 Dec 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713529; cv=none; b=cu7+glzM7SqnfAGJ/n8bxoYurnHExP9A5suhk7cJxvN+aIQWm5cWRv7jDS/RLvl9jsY7s5JzVPEdQGiJ9J+sbSMppUxoN1/+Kj5/xPuzB8bNIb1qBd9i8HPojpg6UssoeDEVkipjnbuQBtKh/7kjMEatbtni6PjM8fei6rrLmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713529; c=relaxed/simple;
	bh=nbNePGtF8r3EJAN415gAlX/P47OROWPqRW2uyywE6tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHU8uWNcCSQF9cZRonl3KYOnFDhkVLZu9kEErlMR/4z+UXcHTrpiZsNtvFOPUVOYJNrPgnw4lBY7TWTQjORmtwDYOaU0srfXrr4BqH1BM+aOYFs/NchBdry5p6cycDYUqD24ewI1ID5K+fyIhywI7HJAv3r8ojlWKS3hXEPMcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBB6xvvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE008C4CEDC;
	Fri, 20 Dec 2024 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713529;
	bh=nbNePGtF8r3EJAN415gAlX/P47OROWPqRW2uyywE6tA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qBB6xvvQWiFPCg4R74HB3qD7FPcu+ghKOH4IUJUyo7T7hZxyeiUlOM/lk+aIdKRfa
	 3Uc19En22fkH6sR82F/qOc22AjEuFwWYazyr5yPIqAoLdkd+0GJevPiv49d+T0Mc1U
	 E+yF+1tlTnmsM6aI3ilCMzob3O9NbbsnlTHTMPWl31rqd1Rablh5tEZup5w+ghRkgj
	 eSP+EneQWh6oJILbsA2fWaNT+GGbMFa1pLBaFrHE7xhgPSx2pb5CA5btsMEPjvC5dI
	 NxRnPAHagE81Z2dmA4d1Cis2UzApUBGaVHVQPWmYi7MCQSrX4SPb5TKzIFkxMRO+9G
	 bJoeOtEUqIxxw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:44 +0000
Subject: [PATCH RFC v3 19/27] KVM: arm64: Support SME priority registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-19-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5580; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nbNePGtF8r3EJAN415gAlX/P47OROWPqRW2uyywE6tA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBjw1WaaWirHNRbsPCY7dfheJevhiP0Erb7GaMr
 DSXKCK2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgYwAKCRAk1otyXVSH0MNaB/
 0V3OPkEINR3rr9MbskzhpJwVpv/Zi6DFRbb9aiFIE/jx5AD79tpsLbNtgVhEX9NTnUsLrW19EoT4Sy
 zMCLid+1c68k5H1N+CZB/N5n87OUyFckpBjFqzfrJq6oD3o5DviVG2vZQrJzv2mIpUwuYCzkyT8PhV
 c8Yg0Ix0Avxxhnyp/9zXQIx5DcbaeOlFovdcysq88hKfAEm4GbufXPZAKJOoz1XPZ3ks31yPL+mt0N
 g74nltEXTJaGBZGzdgqcYkoDTKiFoq/BakL6fOGYQIVVrz27pUVwNHGVXVCVnSFJ8SGN1Lwu37N1T5
 Bws2MORMIkGTglmAilbds1FVkVzW3D
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME has optional support for configuring the relative priorities of PEs
in systems where they share a single SME hardware block, known as a
SMCU. Currently we do not have any support for this in Linux and will
also hide it from KVM guests, pending experience with practical
implementations. The interface for configuring priority support is via
two new system registers, these registers are always available if SME is
supported.

The register SMPRI_EL1 allows control of SME execution priorities. Since
we disable SME priority support for guests this register is RAZ, define
it as such and enable fine grained traps for SMPRI_EL1 to ensure that
guests can't write to it even if the hardware supports priorites.  We
could with some adjustment to the generic FGT code allow untrapped reads
but since we don't currently advertise priority support to guests there
should be no reason for frequent accesses.

There is also an EL2 register SMPRIMAP_EL2 for virtualisation of
priorities, this is also RAZ when priority configuration is not
supported but has no specific traps available.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h     |  2 ++
 arch/arm64/include/asm/vncr_mapping.h |  1 +
 arch/arm64/kvm/sys_regs.c             | 30 +++++++++++++++++++++++++-----
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a304b02efcadba5371edffe97e911bba0634ed62..f72024ffc89d955b3a0a20b6503ceb451abe824f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -473,6 +473,7 @@ enum vcpu_sysreg {
 	SVCR,
 	FPMR,
 	SMIDR_EL1,	/* Streaming Mode Identification Register */
+	SMPRI_EL1,	/* Streaming Mode Priority Register */
 
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
@@ -525,6 +526,7 @@ enum vcpu_sysreg {
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
 	VNCR(ZCR_EL1),	/* SVE Control */
 	VNCR(SMCR_EL1),	/* SME Control */
+	VNCR(SMPRIMAP_EL2),	/* Streaming Mode Priority Mapping Register */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
 	VNCR(TCR_EL1),	/* Translation Control Register */
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index 74fc7400efbc7de6b8dd81a485f1e9d545baf7a9..1685df741294b68e5ae4a4503258c3ee2667dda9 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -43,6 +43,7 @@
 #define VNCR_ZCR_EL1            0x1E0
 #define VNCR_HAFGRTR_EL2	0x1E8
 #define VNCR_SMCR_EL1		0x1F0
+#define VNCR_SMPRIMAP_EL2	0x1F0
 #define VNCR_TTBR0_EL1          0x200
 #define VNCR_TTBR1_EL1          0x210
 #define VNCR_FAR_EL1            0x220
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 416c855153ca532e4c6557d78599e9af0f913071..c327b5544ad95c965a3d24cea059997eb57135f2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1782,6 +1782,15 @@ static unsigned int fp8_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
+static unsigned int sme_raz_visibility(const struct kvm_vcpu *vcpu,
+				       const struct sys_reg_desc *rd)
+{
+	if (vcpu_has_sme(vcpu))
+		return REG_RAZ;
+
+	return REG_HIDDEN;
+}
+
 static u64 sanitise_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
 {
 	if (!vcpu_has_sve(vcpu))
@@ -2719,7 +2728,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
-	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
+
+	/*
+	 * SMPRI_EL1 is UNDEF when SME is disabled, the UNDEF is
+	 * handled via FGU which is handled without consulting this
+	 * table.
+	 */
+	{ SYS_DESC(SYS_SMPRI_EL1), trap_raz_wi, .visibility = sme_raz_visibility },
+
 	{ SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
@@ -3068,6 +3084,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	EL2_REG_FILTERED(SMPRIMAP_EL2, trap_raz_wi, reset_val, 0,
+			 sme_el2_visibility),
 	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
 			 sme_el2_visibility),
 
@@ -4999,8 +5017,7 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 	kvm->arch.fgu[HFGxTR_GROUP] = (HFGxTR_EL2_nAMAIR2_EL1		|
 				       HFGxTR_EL2_nMAIR2_EL1		|
 				       HFGxTR_EL2_nS2POR_EL1		|
-				       HFGxTR_EL2_nACCDATA_EL1		|
-				       HFGxTR_EL2_nSMPRI_EL1_MASK);
+				       HFGxTR_EL2_nACCDATA_EL1);
 
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		kvm->arch.fgu[HFGITR_GROUP] |= (HFGITR_EL2_TLBIRVAALE1OS|
@@ -5047,8 +5064,11 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 		kvm->arch.fgu[HAFGRTR_GROUP] |= ~(HAFGRTR_EL2_RES0 |
 						  HAFGRTR_EL2_RES1);
 
-	if (!kvm_has_feat(kvm, ID_AA64PFR1_EL1, SME, IMP))
-		kvm->arch.fgu[HFGxTR_GROUP] |= HFGxTR_EL2_nTPIDR2_EL0;
+	if (kvm_has_feat(kvm, ID_AA64PFR1_EL1, SME, IMP))
+		kvm->arch.fgt[HFGxTR_GROUP] |= HFGxTR_EL2_nSMPRI_EL1_MASK;
+	else
+		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nTPIDR2_EL0 |
+						HFGxTR_EL2_nSMPRI_EL1_MASK);
 
 	set_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags);
 out:

-- 
2.39.5


