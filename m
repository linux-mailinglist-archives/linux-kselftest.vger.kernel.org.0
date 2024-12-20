Return-Path: <linux-kselftest+bounces-23683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D709F973E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF66188D573
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD16227BB4;
	Fri, 20 Dec 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJV06mgz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3521C198;
	Fri, 20 Dec 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713518; cv=none; b=gPnVgDaBiSj1xw2TORU/iEhtVZDLC/C9DKuJIsWnZz5+rT16fB2syIv0dimp4it+lDxV0p0VQ5lCUuUido/4UKix/391XQzxx8E9Bk4YDABzeb2kwuM8yk/mDwp9rLK6NBT2fH8eO6Bq1qxH6t7fZiB34F4gUYhz6+VraU0aYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713518; c=relaxed/simple;
	bh=ziNSU1l2k6s22Zl2zTPsgpLBrD3+gSVFEY6O/oZT2Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThdwLFwYcXApBsR2cbVvzr66DOj8MS7691Fkjemd0c9XSo8TAmkiEwEzuK79fDRfQAATv6NnQ7oeT20t835/ZbyBhIpj8WE0cC0VX87M9uFa0UqBTOcPIimRnwO4Zy9yhqya1H9jDainDtXa8k4egJaqDKcv962y+3/xy5xEHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJV06mgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A497AC4CED7;
	Fri, 20 Dec 2024 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713518;
	bh=ziNSU1l2k6s22Zl2zTPsgpLBrD3+gSVFEY6O/oZT2Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lJV06mgzy5StSd1+UxdmtGNogKoICEOQbIwQrX4sftFKHzD/Xz4Fk3+HQFPmhaDSv
	 YBYHGSHLmMRXDZZz3zncLv5JzR20izZubLUVEqHjOoonKGZqeop0jSrRp5OjB5XIxc
	 P47WuASqoGzviaf15wBCQXq0n7BRquj5092/6C9Ii5YKSh1c3ZNXCZToNgkE923MJy
	 RMgLsyuT9M8diUPzAVwypVx7fpr6VI6nocKdV/C7tuV4OoXzn4K3ekMxyeXFeToAv7
	 JRs7/+GVPggrZUJTvAntVz559nMYJjExfWTnAY9p7grNrliu5LMQtPxbt/wLf/0/bP
	 rjln9eSHIcHuA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:41 +0000
Subject: [PATCH RFC v3 16/27] KVM: arm64: Add definitions for SME control
 register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-16-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5625; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ziNSU1l2k6s22Zl2zTPsgpLBrD3+gSVFEY6O/oZT2Fs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBgO7cl0oEi7XeyJsA/z/OYmqthjqYTof8sIJnf
 bwSelFCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgYAAKCRAk1otyXVSH0AtZB/
 0YJLUHxjPX6X2u7w+Y+Q0Dv142hnpW7NfvtMvucCl3io6nDs1dHsgnAB+6A5heum5WaQT5R2ffckUT
 jBbpf6Y4e4/BowX2p8DR4bDZJDJjFLCJDc1LEBfRgENZsr5B7rf5Jfh1GKKxTNp+zt1roTmuf1O3t7
 QxudXhCPz58qeFMKT0WIRSeBQDB3cn37bQ6JI7lf4LW+E0xYAeKMceB8X2lvNlP2RaMJKuPLNvbWVR
 L+LXVHfGmFG5BZI7Yv28w3WBDH9MaFW/On/Xj9el+cRFQqtTwSoG+1OnCSUYVlzMoFe0RbG4nUyrVj
 XQzXQmxaX1dm4v/aKWILW5ifJjw0u4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME is configured by the system registers SMCR_EL1 and SMCR_EL2, add
definitions and userspace access for them.  They will be context
switched together with the rest of SME state.

In systems with SME priority support there are additional registers
SMPRI_EL1 and SMPRIMAP_EL2 managing the priorities however we do not
currently have any support for SME priorities and mask that support out
from guests.  The intention is to revist this once we have physical
implementations and can properly evaluate the practical impacts that
they have.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h     |  6 ++++++
 arch/arm64/include/asm/vncr_mapping.h |  1 +
 arch/arm64/kvm/sys_regs.c             | 37 ++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 02f620d95f7dd2cb2b29cc25e78e7ef404cfad4c..8d6342dde02fd99cfd7d2bedeccf0581ad3504ee 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -484,6 +484,7 @@ enum vcpu_sysreg {
 	CPTR_EL2,	/* Architectural Feature Trap Register (EL2) */
 	HACR_EL2,	/* Hypervisor Auxiliary Control Register */
 	ZCR_EL2,	/* SVE Control Register (EL2) */
+	SMCR_EL2,	/* SME Control Register (EL2) */
 	TTBR0_EL2,	/* Translation Table Base Register 0 (EL2) */
 	TTBR1_EL2,	/* Translation Table Base Register 1 (EL2) */
 	TCR_EL2,	/* Translation Control Register (EL2) */
@@ -521,6 +522,7 @@ enum vcpu_sysreg {
 	VNCR(ACTLR_EL1),/* Auxiliary Control Register */
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
 	VNCR(ZCR_EL1),	/* SVE Control */
+	VNCR(SMCR_EL1),	/* SME Control */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
 	VNCR(TCR_EL1),	/* Translation Control Register */
@@ -998,7 +1000,11 @@ struct kvm_vcpu_arch {
 #define vcpu_vec_max_vq(vcpu, type) sve_vq_from_vl((vcpu)->arch.max_vl[type])
 
 #define vcpu_sve_max_vq(vcpu)	vcpu_vec_max_vq(vcpu, ARM64_VEC_SVE)
+#define vcpu_sme_max_vq(vcpu)	vcpu_vec_max_vq(vcpu, ARM64_VEC_SME)
 
+#define vcpu_max_vl(vcpu) max((vcpu)->arch.max_vl[ARM64_VEC_SVE], \
+			      (vcpu)->arch.max_vl[ARM64_VEC_SME])
+#define vcpu_max_vq(vcpu) sve_vq_from_vl(vcpu_max_vl(vcpu))
 
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index 4f9bbd4d6c2671753124599475e5138bf6b9c749..74fc7400efbc7de6b8dd81a485f1e9d545baf7a9 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -42,6 +42,7 @@
 #define VNCR_HDFGWTR_EL2	0x1D8
 #define VNCR_ZCR_EL1            0x1E0
 #define VNCR_HAFGRTR_EL2	0x1E8
+#define VNCR_SMCR_EL1		0x1F0
 #define VNCR_TTBR0_EL1          0x200
 #define VNCR_TTBR1_EL1          0x210
 #define VNCR_FAR_EL1            0x220
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1b16716a6d53525fbe694cc8d5d009d72b6ce416..a9429d9d63b54b5b4d4fe365aa6af4d84a256539 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -142,6 +142,7 @@ static bool get_el2_to_el1_mapping(unsigned int reg,
 		MAPPED_EL2_SYSREG(ELR_EL2,     ELR_EL1,	    NULL	     );
 		MAPPED_EL2_SYSREG(SPSR_EL2,    SPSR_EL1,    NULL	     );
 		MAPPED_EL2_SYSREG(ZCR_EL2,     ZCR_EL1,     NULL	     );
+		MAPPED_EL2_SYSREG(SMCR_EL2,    SMCR_EL1,    NULL	     );
 		MAPPED_EL2_SYSREG(CONTEXTIDR_EL2, CONTEXTIDR_EL1, NULL	     );
 	default:
 		return false;
@@ -2405,6 +2406,37 @@ static bool access_zcr_el2(struct kvm_vcpu *vcpu,
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
@@ -2649,7 +2681,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
 	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
-	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
@@ -2995,6 +3027,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
+			 sme_el2_visibility),
+
 	EL2_REG(TTBR0_EL2, access_rw, reset_val, 0),
 	EL2_REG(TTBR1_EL2, access_rw, reset_val, 0),
 	EL2_REG(TCR_EL2, access_rw, reset_val, TCR_EL2_RES1),

-- 
2.39.5


