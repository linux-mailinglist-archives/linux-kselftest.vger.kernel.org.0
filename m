Return-Path: <linux-kselftest+bounces-2389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCFE81CCDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F45283C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93572EAEE;
	Fri, 22 Dec 2023 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EklYw6aa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AB2F845;
	Fri, 22 Dec 2023 16:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B1C433C7;
	Fri, 22 Dec 2023 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262139;
	bh=BfDVxp2FNobiQyEIBN4bFECrULZkFLrPOul5KJoubig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EklYw6aa5aCO6O7pChhfTuFRLJdr0q8Ibe4g1/d37eo5aPmltlsX10TNWjLAgEQO3
	 2yomAKRLIqJKVZlEAcjc5EkWs0NYFXJ2fx8JVilwU2kvAjeg6NRzxTNkmnF05BVVSG
	 5X5bN8QigrVpIv7mBHWW0rFYLv73+CJ10IiWAQ0x/SteN/5OwN8XjlrAtZRX34J8Sm
	 KoGD0OuLqSGmwPj/1eXmMpPAek+eLQ+OlKbV3pwKnIUON9ZALy2MNL7hBbT8DOKVW7
	 eV9om+BLWMGExp9uJqkMbQtf1SKMG8kHnZqdAKs7XGeWm22ZEDM1nM9GMuhn+GZdiG
	 Maj6uZ9C2xMmw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:20 +0000
Subject: [PATCH RFC v2 12/22] KVM: arm64: Make SVCR a normal system
 register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-12-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3077; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BfDVxp2FNobiQyEIBN4bFECrULZkFLrPOul5KJoubig=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeF2QnJkH4mj19gDAextG3dHkfl9HdSULBfMbo8
 yjHYKpiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3hQAKCRAk1otyXVSH0FnXB/
 4kMjbe3ZKXnEEl49Tne3AKOIDanMIAoY95Y4lL3hJoHFcqTWWt+uUiV7mFC9+JFO030A2hEgtD+aJ+
 7BV2lPmHBYbfAH4szLCB0sUkw1SyJi6X4BHPD1Ud2oYztkAKxmHIAE2I6TpddD8EZx9ULomytOxeua
 1NuGbwOaMpMuFvJRes3Y782K0mwg4L3croPcarjSncvJ8V2v13o/CfbYHWlomLoURkVSDOluKBFkpw
 Ezw3RmJER0ebqoWgJdBF1mdnNGAXp9fWb7GhnnwxYsfjAfGHzhW0lvLp1z3ifk653fPQfoy216NvDX
 Rsx0nL8xYGVA+ap9PP2hNH6kbZzsrb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As a placeholder while SME guests were not supported we provide a u64 in
struct kvm_vcpu_arch for the host kernel's floating point save code to use
when managing KVM guests. In order to support KVM guests we will need to
replace this with a proper KVM system register, do so and update the system
register definition to make it accessible to the guest if it has SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/fpsimd.c           | 8 +++++---
 arch/arm64/kvm/sys_regs.c         | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 36bf9d7e92e1..690c439b5e2a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -356,6 +356,7 @@ enum vcpu_sysreg {
 	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
 	OSLSR_EL1,	/* OS Lock Status Register */
 	DISR_EL1,	/* Deferred Interrupt Status Register */
+	SVCR,		/* Scalable Vector Control Register */
 
 	/* Performance Monitors Registers */
 	PMCR_EL0,	/* Control Register */
@@ -518,7 +519,6 @@ struct kvm_vcpu_arch {
 	void *sve_state;
 	enum fp_type fp_type;
 	unsigned int max_vl[ARM64_VEC_MAX];
-	u64 svcr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index a402a072786a..1be18d719fce 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -145,14 +145,16 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
 
 		/*
-		 * Currently we do not support SME guests so SVCR is
-		 * always 0 and we just need a variable to point to.
+		 * We peer into the registers since SVCR is saved as
+		 * part of the floating point state, determining which
+		 * registers exist and their size, so is saved by
+		 * fpsimd_save().
 		 */
 		fp_state.st = &vcpu->arch.ctxt.fp_regs;
 		fp_state.sve_state = vcpu->arch.sve_state;
 		fp_state.sve_vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
 		fp_state.sme_state = NULL;
-		fp_state.svcr = &vcpu->arch.svcr;
+		fp_state.svcr = &(vcpu->arch.ctxt.sys_regs[SVCR]);
 		fp_state.fp_type = &vcpu->arch.fp_type;
 
 		if (vcpu_has_sve(vcpu))
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b618bcab526e..f908aa3fb606 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2336,7 +2336,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .get_user = get_id_reg, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
-	{ SYS_DESC(SYS_SVCR), undef_access },
+	{ SYS_DESC(SYS_SVCR), NULL, reset_val, SVCR, 0, .visibility = sme_visibility },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
 	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },

-- 
2.30.2


