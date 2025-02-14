Return-Path: <linux-kselftest+bounces-26622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E78AA35443
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746CF7A22CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56711DD88B;
	Fri, 14 Feb 2025 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kai8r0TV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685E1DD874;
	Fri, 14 Feb 2025 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498528; cv=none; b=mtzM9tbsz5J9d3HSZQfJln6abgozmrFydf3kG2z+W+lFkMczCIL9z/pFm+tjvdKzrhovWretrUHjUAqiqlRBywr/3W59p3XXFsuXDMNMgbInAZygRb3/l81ongvmOzVGzr6RXEI5oZ98RHjQCQ1A7EwNADU6NJVf9TALDnDGl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498528; c=relaxed/simple;
	bh=6+yuCWSCCIs16Jon1OJvbgrnHNHLnpx8MtUwecXrDgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgidbzUBv4riV2rnQuy4fGF+6hMMgS12iPlCnASOsp4IbvqCkWNH4cjrlKT5vfgvxPpsWK7KYO6NpnY2eQENoJEHDJeB9eiLgSb0DotA4aHBCMARi3saOk/ErxI3H4MsoY6AS4UmRDoVZNfmHfMyAalQOxC0y6+lXFDN/omPe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kai8r0TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8C8C4CED1;
	Fri, 14 Feb 2025 02:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498528;
	bh=6+yuCWSCCIs16Jon1OJvbgrnHNHLnpx8MtUwecXrDgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kai8r0TVvxxDM8S5+CI9+sQ15FI1q7sRt+DdfKyRKXvje9oicImkMmdg2Nt6uRpcf
	 kaadsts2QaA+rFVJYp7qX4o0MmK2eDeHdpTArm50CTjM8pmt0auFgfcZBTuLGjJNkO
	 jwypiFUuHT33CIi2aJZG7rXzPlGVboOKJuzJVfVvHfg7LyUJCR0WXzC5d+iVg+BIAc
	 eeLEIOnjqPfApQeuPYp8nhdssan8UsgHF/R/w+UnMYNcu54lXqLxlr/6IjAZ0tcARG
	 fD3Q+XoERZWaxk069JjV83EDmGeto3BiJ+s7IV2/Vi72fkEBrgq9WY+DzXzUGTYkPU
	 zCP1GhIA6oQrw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:58:01 +0000
Subject: [PATCH v4 18/27] KVM: arm64: Support SME priority registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-18-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=5526; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6+yuCWSCCIs16Jon1OJvbgrnHNHLnpx8MtUwecXrDgc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPOQKx6cm5prWToN4nshoLQ67Ao7wJcFjKd+ka5
 MOMgIv+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jzgAKCRAk1otyXVSH0A6JB/
 9kFxLRjk9+inhmrCqNBkq43kb5EOUI3r2uzYrPDIHGeG/is7IrvWQZz43uSi3w15tF4SAhV0xViyAy
 UBitEKkJs4UIlFYT0CvvlksjbowRr4GSEZMPYD9yoBwgS+j8eWU0kG/kdrW/pOpvKG7GNSWXQ5c72S
 5Gk/cphcGM7jKRejF8JENf4zYcUR2UH7iMPLFbRQTon1BvrnbZSON6CIj0zYymr1mpwwnbJIm1wr4V
 BNtDeD27CY3+cELMzw6tEJyBTRZImVzr8hOUfWOrvGAxOjq+BKfMPrkXWOmlxYZknzFO31h31yWewI
 kz4OvblJzh/vhUPvkV+H4ZHbvK76a8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME has optional support for configuring the relative priorities of PEs
in systems where they share a single SME hardware block, known as a
SMCU. Currently we do not have any support for this in Linux and will
also hide it from KVM guests, pending experience with practical
implementations. The interface for configuring priority support is via
two new system registers, these registers are always defined when SME is
available.

The register SMPRI_EL1 allows control of SME execution priorities. Since
we disable SME priority support for guests this register is RES0, define
it as such and enable fine grained traps for SMPRI_EL1 to ensure that
guests can't write to it even if the hardware supports priorites.  We
could with some adjustment to the generic FGT code allow untrapped reads
but since we don't currently advertise priority support to guests there
should be no reason for frequent accesses.

There is also an EL2 register SMPRIMAP_EL2 for virtualisation of
priorities, this is RES0 when priority configuration is not supported
but has no specific traps available.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h     |  2 ++
 arch/arm64/include/asm/vncr_mapping.h |  1 +
 arch/arm64/kvm/sys_regs.c             | 30 +++++++++++++++++++++++++-----
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 14615216845668bf1a614e9fbdb6112190fec054..acd243a31ccb77cce3d95829e22456a71e87725c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -474,6 +474,7 @@ enum vcpu_sysreg {
 	SVCR,
 	FPMR,
 	SMIDR_EL1,	/* Streaming Mode Identification Register */
+	SMPRI_EL1,	/* Streaming Mode Priority Register */
 
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
@@ -526,6 +527,7 @@ enum vcpu_sysreg {
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
index b515dfa1f27d0c744de996f6dcdff272aa184385..d22bd4df9e93213d6974fdfba0175c67716a1e95 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1802,6 +1802,15 @@ static unsigned int fp8_visibility(const struct kvm_vcpu *vcpu,
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
@@ -2763,7 +2772,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
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
@@ -3118,6 +3134,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	EL2_REG_FILTERED(SMPRIMAP_EL2, trap_raz_wi, reset_val, 0,
+			 sme_el2_visibility),
 	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
 			 sme_el2_visibility),
 
@@ -5071,8 +5089,7 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 	kvm->arch.fgu[HFGxTR_GROUP] = (HFGxTR_EL2_nAMAIR2_EL1		|
 				       HFGxTR_EL2_nMAIR2_EL1		|
 				       HFGxTR_EL2_nS2POR_EL1		|
-				       HFGxTR_EL2_nACCDATA_EL1		|
-				       HFGxTR_EL2_nSMPRI_EL1_MASK);
+				       HFGxTR_EL2_nACCDATA_EL1);
 
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		kvm->arch.fgu[HFGITR_GROUP] |= (HFGITR_EL2_TLBIRVAALE1OS|
@@ -5127,8 +5144,11 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 						HFGITR_EL2_nBRBIALL);
 	}
 
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


