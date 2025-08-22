Return-Path: <linux-kselftest+bounces-39636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395FFB30B4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAEBA01E7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D7287502;
	Fri, 22 Aug 2025 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctQGiHWa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C292874F0;
	Fri, 22 Aug 2025 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827727; cv=none; b=G8VTVQukCj4dFsCbgXr91mp7lqhMMlIj6z8I7yItrAnaiPrzKT/iEQ/jpnzxaC7OVryaIQramMKjG1NjWjCnd/a7s73YPcDLV/xDvdhhXLeitcfQrEDs4HpxKI45h+aOh8g1rUWdtRbgmJqw0epKUgCdPi/HKvyjCj0qq38PoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827727; c=relaxed/simple;
	bh=0fLGhfB6VaFN9V2OPaprNenzTUhxjwQ4WMNFeuSowXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1KKCegy/PkcmGKwftNkNc+aisTs2rXP9JNgciGdC9IVFIpttImjOtp9XanyjuLplMmh9BiufYlW0kU17JjP2fspT7tPsK5PLQh/0xmbCl6zTzd5GrIB/VudUyh6lkBsI5pPCd29GEK7LK11dxa3UswG1bzE6ojeEkVkjnv3nDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctQGiHWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46436C116B1;
	Fri, 22 Aug 2025 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827727;
	bh=0fLGhfB6VaFN9V2OPaprNenzTUhxjwQ4WMNFeuSowXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ctQGiHWaV26ejoLFO4zfHMMBN+KUc6cNP0jdCLGWRg3j96fF72rkN15gBCxn5/Kig
	 IBDvnTVM1yM9bP5VzjJ5xQR0GRbH3uYA/2Mh2qDWX2Bu+iIOW5UUk7I7+KMT94MOUQ
	 ipOw14avng2D9P09EX7uO62QuTCsSiz6Bne/TW9x1WTKLitn3zzQxmVhor58FFrNuZ
	 XDhjkLQH3mBsgtG/LmrS0xoeBVUYlOPp+xZk4Lqj0dddU20Wd9Xdp5FUxy+ZVBMlph
	 k+skK76Dj43h4Yd3jR5b8OtYF2GqWZWOtSD9IoKQROjy8Amg458Y8dJ1CsudXrgyP8
	 w875mxdQrc8Ag==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:45 +0100
Subject: [PATCH v7 16/29] KVM: arm64: Support SME control registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-16-7a65d82b8b10@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4807; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0fLGhfB6VaFN9V2OPaprNenzTUhxjwQ4WMNFeuSowXY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83EVDbH8kbLyWgiAxxl33xkta6QdpR/6PkP0
 j82HY5UiZCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNxAAKCRAk1otyXVSH
 0OkpB/9IdtL6rqg4nxPNX61/jxuwXDiCWZIT8+8Qp+Iks4x8mMoZgjnHDnXU/i6pcbHvMHEcUY4
 X20+MCiX5y4rL/JXAyHXhk2aHrvbU4qfLxYc/nUpCTGB0ccvgQcy+lWqZD8OpbSDJD64jpdenWu
 W5JdwHMc2zaQpGfjdOlav33LrU3bfGOkf4DIkcNINoqaQuWVjJ7K/Jg1DbSUldjlyfLXwDEvpop
 mJYeRyfsOIq57WawUPEgr/5Eymvd2HtuvAunQkWnhU/EJ8wXb2z07oRhhxohYZLJBZExDMJQMjb
 sVuv0qnTpn5xymaGkQmiUuFO3e6f+JyaaiIzmKXrrtlXtE0G
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
index 4348f297b5ae..edb2acdb4bd1 100644
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
@@ -544,6 +545,7 @@ enum vcpu_sysreg {
 	VNCR(ACTLR_EL1),/* Auxiliary Control Register */
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
 	VNCR(ZCR_EL1),	/* SVE Control */
+	VNCR(SMCR_EL1),	/* SME Control */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
 	VNCR(TCR_EL1),	/* Translation Control Register */
diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index f6ec500ad3fa..5ab6a964bccf 100644
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
index 111b07a78787..81742e9237c0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -142,6 +142,7 @@ static bool get_el2_to_el1_mapping(unsigned int reg,
 		MAPPED_EL2_SYSREG(ELR_EL2,     ELR_EL1,	    NULL	     );
 		MAPPED_EL2_SYSREG(SPSR_EL2,    SPSR_EL1,    NULL	     );
 		MAPPED_EL2_SYSREG(ZCR_EL2,     ZCR_EL1,     NULL	     );
+		MAPPED_EL2_SYSREG(SMCR_EL2,    SMCR_EL1,    NULL	     );
 		MAPPED_EL2_SYSREG(CONTEXTIDR_EL2, CONTEXTIDR_EL1, NULL	     );
 		MAPPED_EL2_SYSREG(SCTLR2_EL2,  SCTLR2_EL1,  NULL	     );
 	default:
@@ -2589,6 +2590,37 @@ static bool access_gic_elrsr(struct kvm_vcpu *vcpu,
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
@@ -3035,7 +3067,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
 	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
-	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
@@ -3391,6 +3423,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
 
+	EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
+			 sme_el2_visibility),
+
 	EL2_REG(TTBR0_EL2, access_rw, reset_val, 0),
 	EL2_REG(TTBR1_EL2, access_rw, reset_val, 0),
 	EL2_REG(TCR_EL2, access_rw, reset_val, TCR_EL2_RES1),

-- 
2.39.5


