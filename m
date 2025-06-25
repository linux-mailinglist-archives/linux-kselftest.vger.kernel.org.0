Return-Path: <linux-kselftest+bounces-35761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E024FAE8131
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3513A79C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29862E7F36;
	Wed, 25 Jun 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSgXvqb1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D32D4B44;
	Wed, 25 Jun 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850753; cv=none; b=JYJqmyzHjyE3mzFU+ksZuyUcwbzfQSsXvEGDAndiwR8HKX4jU6OBAzaXnV6zjm4iS+nR+KkW6UaLUyEj47BDdm6j8HMH31wIkCb5ZOTD08FVY5Lhvp9McY/tQ+OPFt12OHRd0kkxnfsQBx4mvDCaDwUYd2Un8QUOse+2Wn3DZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850753; c=relaxed/simple;
	bh=qA0mwadkpEtIxftmxgait0EjWz9W34wp0tXWQC5BqJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/8y0UJF/drWqoSvsL65kPmNCjmPDSBhlLkY6nc6QQ/ajYrt21MGkek0fwE/XB+eDh4b+zaZYAZbwVIadbD7Ho9Rr3CVZUjBANw0lQWWVwFTd7hfQysysOXX652f/VDHrwVOCCuBdr2/aa2rTyuRK3IR3rETVbk3/f9FZ97cLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSgXvqb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0482C4CEEA;
	Wed, 25 Jun 2025 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850753;
	bh=qA0mwadkpEtIxftmxgait0EjWz9W34wp0tXWQC5BqJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qSgXvqb1LUZ3iz/OiDx943WWSNmWFlTgqS55pzBVo26XHivakAbo4XGpipuNLWP6B
	 RC8CySfX7pSXj7Ii9T0Rl5ja8RGIcjMCzjVE7Sr36eK27lWho/yr77ah8yNr8tUFPc
	 ne0DGfrJyK4H3DSWo4weootJt9qKONiOZbEhPk7A/FRVGhzZxoBYSlFB21urFITfwM
	 tz0sBDP6PHH4flu2/meGzUXXqRvny4N/cATcMckNjkzQTUAHASkHDc3h/A2s1g0OuB
	 J+G+1BH/caE3FvxXbNKso1KL1DR+4Vmd1lyz5+3/NJEatetu3otoYd7wwfCQWq0Pq/
	 5x480srg1zWfg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:09 +0100
Subject: [PATCH v6 18/28] KVM: arm64: Support SME priority registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-18-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4660; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qA0mwadkpEtIxftmxgait0EjWz9W34wp0tXWQC5BqJ8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xzuOTNN+4zWpVdPd9zirK7XMkJcqAoDRjJK
 ms/u4jKefeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvccwAKCRAk1otyXVSH
 0FSKB/4uGybS3PUQxVj1I4QAOYhPwx/3KABTuMpof5G3awwBeEHyXxa0kaP/Oxb+cMUDPQjuLRh
 BVlLlusu22iJ653mgWoBa+3u14rfwCQRcqlFJN5WTUqDaf1yKLic10YkIUB17I6pUQph33mIGur
 mOlshBMR/LkebFxW560iBrEyvI09//7S/ytLJnok262qBJDoGsyn80YYWest23G3+ezhTRyGm2a
 MfWslGVmhIKkcd+vgrju35elN1CjeJ0sP1IbLXlettgjyF0CyYc5i11/3lBzpzmf+zxgxvL3KKE
 Ma/4Eiq0lc7hff23RTtrD4FtAYkiLSY4FY0HSpPJctT3iowi
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
guests can't write to it even if the hardware supports priorites.  Since
the register should be readable with fixed contents we only trap writes,
not reads.

There is also an EL2 register SMPRIMAP_EL2 for virtualisation of
priorities, this is RES0 when priority configuration is not supported
but has no specific traps available.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h     |  2 ++
 arch/arm64/include/asm/vncr_mapping.h |  1 +
 arch/arm64/kvm/sys_regs.c             | 23 ++++++++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 29b8697c8144..5ce9e06324b5 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -495,6 +495,7 @@ enum vcpu_sysreg {
 	SVCR,
 	FPMR,
 	SMIDR_EL1,	/* Streaming Mode Identification Register */
+	SMPRI_EL1,	/* Streaming Mode Priority Register */
 
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
@@ -547,6 +548,7 @@ enum vcpu_sysreg {
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
 	VNCR(ZCR_EL1),	/* SVE Control */
 	VNCR(SMCR_EL1),	/* SME Control */
+	VNCR(SMPRIMAP_EL2),	/* Streaming Mode Priority Mapping Register */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
 	VNCR(TCR_EL1),	/* Translation Control Register */
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index aede5d6efad3..454e076b77cb 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -45,6 +45,7 @@
 #define VNCR_ZCR_EL1            0x1E0
 #define VNCR_HAFGRTR_EL2	0x1E8
 #define VNCR_SMCR_EL1		0x1F0
+#define VNCR_SMPRIMAP_EL2	0x1F0
 #define VNCR_TTBR0_EL1          0x200
 #define VNCR_TTBR1_EL1          0x210
 #define VNCR_FAR_EL1            0x220
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b11bb95e9e35..1fee8e534615 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1828,6 +1828,15 @@ static unsigned int fp8_visibility(const struct kvm_vcpu *vcpu,
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
@@ -3030,7 +3039,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
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
@@ -3387,6 +3403,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	EL2_REG_FILTERED(SMPRIMAP_EL2, trap_raz_wi, reset_val, 0,
+			 sme_el2_visibility),
 	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
 			 sme_el2_visibility),
 
@@ -5306,6 +5324,9 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 	compute_fgu(kvm, HFGITR2_GROUP);
 	compute_fgu(kvm, HDFGRTR2_GROUP);
 
+	if (kvm_has_feat(kvm, ID_AA64PFR1_EL1, SME, IMP))
+		kvm->arch.fgt[HFGWTR_GROUP] |= HFGWTR_EL2_nSMPRI_EL1_MASK;
+
 	set_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags);
 out:
 	mutex_unlock(&kvm->arch.config_lock);

-- 
2.39.5


