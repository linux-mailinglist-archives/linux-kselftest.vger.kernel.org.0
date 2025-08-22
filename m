Return-Path: <linux-kselftest+bounces-39639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB1B30B40
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD5FB61F5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1D28B7EA;
	Fri, 22 Aug 2025 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7iXix1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFD28B4E1;
	Fri, 22 Aug 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827740; cv=none; b=HSyYLN14HfEGx7FKVS2wuDOu519tJUV7JNFV/99/3VjC1TZR2ci5PpO0K8c/cFGxEw4sPSUmoGV9c62yErAGipm9+s+jpUnj83ZbnbQEUUvVxNxeWkq2wtbgQH78RVu0v5LmHyHHt2G2wx3JM2r3bdwecod3ZJEusFGgBe6nVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827740; c=relaxed/simple;
	bh=MAZZlV6eUub7krRK8EsIsDbLy5E7LRegIDDazNCSgqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtaaX5t6/x4ovmomS2LrEXk8NAONVeuCDC/mj21nUz7hE51GdknujeAH8QvzQOze3qvCxgyPBFGhX7rUHndmE7gY8GRfdVFK9Ix0zXPIrl87cq72qs7GY2l3Vemj5Sy0dgqXkVkXRVE7Vcd6sro3YQYbCGMCiiNxB7y6hV5vbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7iXix1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D02EC116C6;
	Fri, 22 Aug 2025 01:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827738;
	bh=MAZZlV6eUub7krRK8EsIsDbLy5E7LRegIDDazNCSgqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O7iXix1RKZNh2lmsBj4W6gcd1LHSVXPjast+WjRtkx98q/SrGxEwv/brh8N6lZHEI
	 bSeqJdkvRmUJ2/bKSS9ROu6NenEu7LGoUi9NlIEbdZRd+chk913p7Y9F12wd9InYaG
	 LTnP/X4PaJcnp7JeUp9LmqFLwHvrgck1My0W7M/DVD9gZij+ZzV31cQ8oX8yGrDckd
	 6Un9hXICytN2+/+8G2i1zNNNlqxi3HH60Zj2yxBQsFRmfCTaTkgCv07ZvH7pzMoJRR
	 06bWp04nB3ErekjkRjA4GiOt11Qklj3anwQacBXHVOA5OXZAYj7fsabfUZXMkh3BHk
	 lU9dVIcwroynQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:48 +0100
Subject: [PATCH v7 19/29] KVM: arm64: Support SME priority registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-19-7a65d82b8b10@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5778; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MAZZlV6eUub7krRK8EsIsDbLy5E7LRegIDDazNCSgqc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83H47ZqfLuXd4yOwd5EVdItCuq2sPS1eGpde
 mHGkH2o35qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNxwAKCRAk1otyXVSH
 0P9eB/97Bd330dA9+rISpYO8P3owtayHYl6ppE+RRcQRLCTSW66rnx+myThRCp2keOvzuKs4D9i
 awk653VM268WAi6iBZmCK0uBNhsc+n3ifvdh42034+S+yKU32DwxdHt6yOs2/XPCVhw+grdK7V1
 3Pd2QrVAVTCryf7xwa7qzp7ZR7fCvtg1J5prh1i7S5gOC2NPEEYxulAlEI4jSPr7HTCK1BG5yla
 uilBns4GTAARETTMqhASgdYKkg5pA9otUPM1veAdbq9rnXDbib20oB1FEzvM9TPCuxFaEN3lBAp
 mYc4JQonbLFuk6kJrk3Hc5hYgUBBGPRnYNOQmuicC6LhoCfg
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
but has no specific traps available.  When saving state from a nested
guest we overwite any value the guest stored.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h     |  1 +
 arch/arm64/include/asm/vncr_mapping.h |  1 +
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c    |  7 +++++++
 arch/arm64/kvm/sys_regs.c             | 33 ++++++++++++++++++++++++++++++++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5225dd9b752c..ebc516fe09db 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -548,6 +548,7 @@ enum vcpu_sysreg {
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
 	VNCR(ZCR_EL1),	/* SVE Control */
 	VNCR(SMCR_EL1),	/* SME Control */
+	VNCR(SMPRIMAP_EL2),	/* Streaming Mode Priority Mapping Register */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
 	VNCR(TCR_EL1),	/* Translation Control Register */
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index 5ab6a964bccf..670a2f81847c 100644
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
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index f28c6cf4fe1b..07aa4378c58a 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -80,6 +80,13 @@ static void __sysreg_save_vel2_state(struct kvm_vcpu *vcpu)
 
 	if (ctxt_has_sctlr2(&vcpu->arch.ctxt))
 		__vcpu_assign_sys_reg(vcpu, SCTLR2_EL2, read_sysreg_el1(SYS_SCTLR2));
+
+	/*
+	 * We block SME priorities so SMPRIMAP_EL2 is RES0, however we
+	 * do not have traps to block access so the guest might have
+	 * updated the state, overwrite anything there.
+	 */
+	__vcpu_assign_sys_reg(vcpu, SMPRIMAP_EL2, 0);
 }
 
 static void __sysreg_restore_vel2_state(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 36ba1986e7a1..7284705a5f0a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -552,6 +552,15 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 		return read_zero(vcpu, p);
 }
 
+static int set_res0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		    u64 val)
+{
+	if (val)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * ARMv8.1 mandates at least a trivial LORegion implementation, where all the
  * RW registers are RES0 (which we can implement as RAZ/WI). On an ARMv8.0
@@ -1819,6 +1828,15 @@ static unsigned int fp8_visibility(const struct kvm_vcpu *vcpu,
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
@@ -3091,7 +3109,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
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
@@ -3453,6 +3478,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	{ SYS_DESC(SYS_SMPRIMAP_EL2), .reg = SMPRIMAP_EL2,
+	  .access = trap_raz_wi, .set_user = set_res0, .reset = reset_val,
+	  .val = 0, .visibility = sme_el2_visibility },
 	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
 			 sme_el2_visibility),
 
@@ -5379,6 +5407,9 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
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


