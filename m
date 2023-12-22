Return-Path: <linux-kselftest+bounces-2386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0A81CCD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE0F284BCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B862511D;
	Fri, 22 Dec 2023 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG8qH47S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311F2E64E;
	Fri, 22 Dec 2023 16:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABC4C43395;
	Fri, 22 Dec 2023 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262129;
	bh=dZGqZ9ImpY81Bfusy6mo+Pjw/gQq9tbdGvEjILZByB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qG8qH47SvHajYGfvesEINlFcfJjzlOWW91kASs89dKY95GFTPaYCFZUBBxMQ8C9QS
	 OH9dpMzWv1eNfXXdwwaKUMqJa04r73bUlAfPdy/dwtYlQp9ySG4gsJuFuPWlqNndv8
	 Urlj8Ixw0mF5AvrCcghITmc2usrO2SgfAKV/LAe9sKwDGGOzi+CXgN3dFVG3+p2t97
	 w17lZyxrsDrqHJfZD/NY/86hvN5vsFKFZS+cnG3SnkOXWiMULBiiYPEKwwHmZ4Vtds
	 Tq6B32WijWSE2Jt/oXLUeMx/h9Xsq2QaDw5S4V0QqLtqzRWVYiRyCPzmrU2aJR8eii
	 KbrV7GulWzA7Q==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:17 +0000
Subject: [PATCH RFC v2 09/22] KVM: arm64: Basic SME system register
 descriptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-9-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=3669; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dZGqZ9ImpY81Bfusy6mo+Pjw/gQq9tbdGvEjILZByB0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeCIof01vgI7Tpux+LH6LvL3y33URi4Pc4y/kzz
 5oiTfkGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3ggAKCRAk1otyXVSH0H6dB/
 40Dc8V7kbr7i5zAQDok/7OfKZNHAAreYPb/7fvbiGnLJE6JCgRwZpAmUbn4TOdDLsWDNsfn0FLS33k
 SB5AqVQ5y7OwzmsfwNNDcDPLvm4xokdunc+t/cDlMM+vC0r4fvuy/kl6vpUhQTWORBMZUd9eI+NlNP
 NvJc11frMS9H79Fxfmv2jeNRjA5JrCukY/8ub6LmDfdxWIV93zCiWBAfjrzoY/nVMVG0sgE17jwEiA
 Fznszstjwm+AI2H9Smw9CK0lXRMTLLqsfIH5roG/Tadb32/9zT8QhtoWwZojCQPBsgD1dT0dGAZpPt
 BUySP+6c+HTNe3vfd+sX1ds82LSwkH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Set up the basic system register descriptions for the more straightforward
SME registers. All the registers are available from SME 1.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/sys_regs.c         | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 920f8a1ff901..4be5dda9734d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -333,6 +333,7 @@ enum vcpu_sysreg {
 	ACTLR_EL1,	/* Auxiliary Control Register */
 	CPACR_EL1,	/* Coprocessor Access Control */
 	ZCR_EL1,	/* SVE Control */
+	SMCR_EL1,	/* SME Control */
 	TTBR0_EL1,	/* Translation Table Base Register 0 */
 	TTBR1_EL1,	/* Translation Table Base Register 1 */
 	TCR_EL1,	/* Translation Control Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4735e1b37fb3..e6339ca1d8dc 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1404,7 +1404,8 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		if (!kvm_has_mte(vcpu->kvm))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
 
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+		if (!vcpu_has_sme(vcpu))
+			val &= ~ID_AA64PFR1_EL1_SME_MASK;
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
@@ -1470,6 +1471,9 @@ static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
 		if (!vcpu_has_sve(vcpu))
 			return REG_RAZ;
 		break;
+	case SYS_ID_AA64SMFR0_EL1:
+		if (!vcpu_has_sme(vcpu))
+			return REG_RAZ;
 	}
 
 	return 0;
@@ -1521,6 +1525,16 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
+/* Visibility overrides for SME-specific control registers */
+static unsigned int sme_visibility(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *rd)
+{
+	if (vcpu_has_sme(vcpu))
+		return 0;
+
+	return REG_HIDDEN;
+}
+
 static u64 read_sanitised_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 					  const struct sys_reg_desc *rd)
 {
@@ -2142,7 +2156,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
-	ID_HIDDEN(ID_AA64SMFR0_EL1),
+	ID_WRITABLE(ID_AA64SMFR0_EL1, ~ID_AA64SMFR0_EL1_RES0),
 	ID_UNALLOCATED(4,6),
 	ID_UNALLOCATED(4,7),
 
@@ -2211,7 +2225,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
 	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
-	{ SYS_DESC(SYS_SMCR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
@@ -2306,7 +2320,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
 	  .set_user = set_clidr },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
-	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
+	{ SYS_DESC(SYS_SMIDR_EL1), .access = access_id_reg,
+	  .get_user = get_id_reg, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 	{ SYS_DESC(SYS_SVCR), undef_access },

-- 
2.30.2


