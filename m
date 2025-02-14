Return-Path: <linux-kselftest+bounces-26620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75633A35438
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94257A494F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BC1D89F0;
	Fri, 14 Feb 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnBQ65VS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285D1D86E4;
	Fri, 14 Feb 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498520; cv=none; b=eXTeVidt+qPAMDLzGHP9XFhp9xbZxzvhVXyQTVeiHHTBRMQRF+ONLfDYQTZWKCDhxhprrUTG55doCCu3j/CIrqHF6xyQJPxOo/vTdB5zprvnxXMFhTNro4Ly3fcj7UFpBskeauI3REDiuIZGB4V1QyCgse/anq8nPGbXC0M8P7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498520; c=relaxed/simple;
	bh=qo7H32r2wNGTMfrlNHz8kGfdEKw9RWzoZiLjbar4AvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMKBJJOaEl/E35aW/aSq0aHO62nV3YU3UOx6+Av0fDO9Zvk5RmauDw4KLi/qtTx9N+n8vgKXGAMi7zxnM5r2fVXUCLLNa/lEdrSQJP/XLRQj5eTi6en+uQ+KKXOsIrK9jhhG7gtCt0558fsTasWggZDAd4pb0JVPhzACIUphOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnBQ65VS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDEFC4CEE2;
	Fri, 14 Feb 2025 02:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498520;
	bh=qo7H32r2wNGTMfrlNHz8kGfdEKw9RWzoZiLjbar4AvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XnBQ65VS3I9bj1mX7Papiv+X1zToHxd9KnjRGEJ7IXKWZylSISiliUW4nLzRdHCDj
	 nEd5+GPztDi2XRZL8B0/pi/8cbRQDdYUYX/vnZq5/4YzpwbKvzXZA6h6kd4YfMx6PR
	 cABwfP1JO4HMYm+Mf15SWaIBK9Ntf35BP12kM6NSnzzmRr2Zkf8bWTpETQj0LSkfzj
	 +5qX6mHzk+4GQQBgfrtsPYEeOxX1aAZeujtnzV79c+s36/wUrgZxGs4aahkwr4p1Co
	 c9bqFxHy8jD9nY4pJhlIGPYBDtlzJEUdCGYjPdFL1WmhrJWmkFUQMJuOOp97ZUmS2O
	 dV0IkHyWCfGdQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:59 +0000
Subject: [PATCH v4 16/27] KVM: arm64: Support TPIDR2_EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-16-d64a681adcc2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4417; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qo7H32r2wNGTMfrlNHz8kGfdEKw9RWzoZiLjbar4AvM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPMohFUruQXcfEwUEo2WbpxUFeA8eoszM/LB2R2
 Wn3sry6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jzAAKCRAk1otyXVSH0AjRB/
 0TV9UwGhtStHLdnu+w9DOtSEGUUBG38XDsYXOrUG7Wajl8rAeuih8YH2ru0KxeIseo1caarpwjXKId
 /wY1Ua6NBOggNlXFg4nTzkaMIyAO0pCOSQchazJAdt30QQzTwmJ6ZGwdO+snar4yH0Makm4JUv9nd3
 SqQZStsNm+QSz01uAW3ZuoOdU2FlY29SM9UfRWtctXkS/ti1JqK1c7QoL5HowkXiffZrG05MCt9OoG
 k2UB0Gv4zolvhAw/CTchv5O3rpxazHSqP2ZKzQOLwfim/Mc5djh3pVBk++lIcG+rcQCq3rLOrBjUSw
 EXf4uj8VQEQFhgp377gS/TgJmLjUsh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a new thread ID register, TPIDR2_EL0. This is used in userspace
for delayed saving of the ZA state but in terms of the architecture is
not really connected to SME other than being part of FEAT_SME. It has an
independent fine grained trap and the runtime connection with the rest
of SME is purely software defined.

Expose the register as a system register if the guest supports SME,
context switching it along with the other EL0 TPIDRs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 15 +++++++++++++++
 arch/arm64/kvm/sys_regs.c                  |  9 ++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f987698f88acf7b01e08e44b46a0982e36cced95..c770ed6138164fcd3e11b8517ef4120b4f4486b9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -429,6 +429,7 @@ enum vcpu_sysreg {
 	CSSELR_EL1,	/* Cache Size Selection Register */
 	TPIDR_EL0,	/* Thread ID, User R/W */
 	TPIDRRO_EL0,	/* Thread ID, User R/O */
+	TPIDR2_EL0,	/* Thread ID, Register 2 */
 	TPIDR_EL1,	/* Thread ID, Privileged */
 	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
 	PAR_EL1,	/* Physical Address Register */
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 7a4ad8a4c3727e4628b375cbefc5e0d3533687de..8141e4785161d0f610f1aa161d8448ca2f50312c 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -81,6 +81,17 @@ static inline u64 *ctxt_mdscr_el1(struct kvm_cpu_context *ctxt)
 	return &ctxt_sys_reg(ctxt, MDSCR_EL1);
 }
 
+static inline bool ctxt_has_sme(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!system_supports_sme())
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_sme(kern_hyp_va(vcpu->kvm));
+}
+
 static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
 	*ctxt_mdscr_el1(ctxt)	= read_sysreg(mdscr_el1);
@@ -94,6 +105,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		ctxt_sys_reg(ctxt, TPIDR2_EL0)	= read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
@@ -163,6 +176,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, TPIDR2_EL0), SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 597d6a33826d001268d53174581ef8e61e7dd946..eece67141480b8d4bbd2bac0f02f9208c7f86f8b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2901,7 +2901,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .visibility = s1poe_visibility },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
-	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
+	{ SYS_DESC(SYS_TPIDR2_EL0), NULL, reset_unknown, TPIDR2_EL0,
+	  .visibility = sme_visibility},
 
 	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
 
@@ -5033,8 +5034,7 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 				       HFGxTR_EL2_nMAIR2_EL1		|
 				       HFGxTR_EL2_nS2POR_EL1		|
 				       HFGxTR_EL2_nACCDATA_EL1		|
-				       HFGxTR_EL2_nSMPRI_EL1_MASK	|
-				       HFGxTR_EL2_nTPIDR2_EL0_MASK);
+				       HFGxTR_EL2_nSMPRI_EL1_MASK);
 
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		kvm->arch.fgu[HFGITR_GROUP] |= (HFGITR_EL2_TLBIRVAALE1OS|
@@ -5089,6 +5089,9 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 						HFGITR_EL2_nBRBIALL);
 	}
 
+	if (!kvm_has_feat(kvm, ID_AA64PFR1_EL1, SME, IMP))
+		kvm->arch.fgu[HFGxTR_GROUP] |= HFGxTR_EL2_nTPIDR2_EL0;
+
 	set_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags);
 out:
 	mutex_unlock(&kvm->arch.config_lock);

-- 
2.39.5


