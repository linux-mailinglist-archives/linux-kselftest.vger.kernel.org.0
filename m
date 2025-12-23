Return-Path: <linux-kselftest+bounces-47885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F63CD7C9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542E431894B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9AC306D3D;
	Tue, 23 Dec 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWIvFazZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7132F99AD;
	Tue, 23 Dec 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452960; cv=none; b=nZjWfQcPs+gZU+ePgWGVR0ZJl79xrdGL4oSQCgI60Tj+H0lUjjXa4JUhp7fhlRQM5FvmonT7V5wF59YX73TGyf4PYWl4zxaKBXSxbIfW4QT1IeirHLiILSmJuoJcYjq9KEKdfyjCp6w1tN39F4PfqJ9SJ14zmLcLS98Ebi7BLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452960; c=relaxed/simple;
	bh=hpiP0eA4qmeF4dLRzqbVb4BsWjeVplh22fbkO2rFo8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3XxDbbazZm2DnO8EQiVWbeQQEdttu7MKKF6ngdOlcgXjjjlr2Ltn5AC+ex1MwBv/nd54PCv7nbmtk2mWmj8lucxpa5HMrpgd1kAKSbM1gBlYv7gQQH1QzqQkPOoOldpPLSE5O0tyZDq6a4dmJFD/Axhf2yWrvHa/5eREKJ1Qco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWIvFazZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749BEC4CEF1;
	Tue, 23 Dec 2025 01:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452960;
	bh=hpiP0eA4qmeF4dLRzqbVb4BsWjeVplh22fbkO2rFo8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nWIvFazZ5RgrX1CjjIpYxoRtuNA5PCABKZQ6CfGRyh2YGw9MTBZTecbebv8nJIkAt
	 lWJRFkYIOFS9aRreL2MaK9diLIlPfJK8/WjIPpmBgDL+STqgPFaWhsk4dOCgFaRo7T
	 2rpiREiYkf9dQ7M4pAkWSP3VFZP+qOR51mzXSH+OYT0+7AZmD5QDvt369cg7FNlCDp
	 bq4zw+Obqdk2yslAlg0NM7NjL6FIqb/nDx8M6F3gnml4nxSi6fkzx5NZ0Z4dMZ1hsa
	 2KwcGR6DVXCBhyNWrRpvb5r93CqzSHorVHw5GtJi0Pi6UQLWwUS/GVVEmeqkRpvnyJ
	 EPvA6j48XKTkA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:09 +0000
Subject: [PATCH v9 15/30] KVM: arm64: Support SME control registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-15-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4356; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hpiP0eA4qmeF4dLRzqbVb4BsWjeVplh22fbkO2rFo8A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6OnJ5qm9IRTxWCDKhWuw2aB2hSIwMUwtyOH
 TgMhhQ1atCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnujgAKCRAk1otyXVSH
 0McDB/9x+JQHYW4gMSj2mVEj4a9Woqsapd9hWJyx5t9Oy9c2TSR+913aYJpLW0pw2z5/peJUpDd
 wIMWclk27zLPVNowolZgW62+9GLvszO3ntr9He8IJbDA/UekMq1TyrBzFkuGh/3sHl07Mtb9qgt
 6pNrIqViZp5xV6gBlLvsRmNlo5uHSKvwM9T0y/8HMVE7cCI/XwnSwsN6oQN/mejz9NaigbaKbJD
 P6QZ4DnqSfWRACybE/xujy+PIjuamypojsEoss84fCCxD4dW8oYkQh1iZOT6O0t2pdjP5agWY6c
 NWFgp8G3Cjn4H5hoiqwlKl4B8ASFufPqqEdjKTr429vvfKAN
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
 arch/arm64/kvm/sys_regs.c             | 36 ++++++++++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b41700df3ce9..f24441244a68 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -504,6 +504,7 @@ enum vcpu_sysreg {
 	CPTR_EL2,	/* Architectural Feature Trap Register (EL2) */
 	HACR_EL2,	/* Hypervisor Auxiliary Control Register */
 	ZCR_EL2,	/* SVE Control Register (EL2) */
+	SMCR_EL2,	/* SME Control Register (EL2) */
 	TTBR0_EL2,	/* Translation Table Base Register 0 (EL2) */
 	TTBR1_EL2,	/* Translation Table Base Register 1 (EL2) */
 	TCR_EL2,	/* Translation Control Register (EL2) */
@@ -542,6 +543,7 @@ enum vcpu_sysreg {
 	VNCR(ACTLR_EL1),/* Auxiliary Control Register */
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
 	VNCR(ZCR_EL1),	/* SVE Control */
+	VNCR(SMCR_EL1),	/* SME Control */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
 	VNCR(TCR_EL1),	/* Translation Control Register */
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index c2485a862e69..44b12565321b 100644
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
index 3576e69468db..5c912139d264 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2827,6 +2827,37 @@ static bool access_gic_elrsr(struct kvm_vcpu *vcpu,
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
+		return false;
+	}
+
+	if (!p->is_write) {
+		p->regval = __vcpu_sys_reg(vcpu, SMCR_EL2);
+		return true;
+	}
+
+	smcr = p->regval;
+	vq = SYS_FIELD_GET(SMCR_ELx, LEN, smcr) + 1;
+	vq = min(vq, vcpu_sme_max_vq(vcpu));
+	__vcpu_assign_sys_reg(vcpu, SMCR_EL2, SYS_FIELD_PREP(SMCR_ELx, LEN,
+							     vq - 1));
+	return true;
+}
+
 static unsigned int s1poe_visibility(const struct kvm_vcpu *vcpu,
 				     const struct sys_reg_desc *rd)
 {
@@ -3291,7 +3322,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
 	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
-	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
@@ -3655,6 +3686,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
+			 sme_el2_visibility),
+
 	EL2_REG(TTBR0_EL2, access_rw, reset_val, 0),
 	EL2_REG(TTBR1_EL2, access_rw, reset_val, 0),
 	EL2_REG(TCR_EL2, access_rw, reset_val, TCR_EL2_RES1),

-- 
2.47.3


