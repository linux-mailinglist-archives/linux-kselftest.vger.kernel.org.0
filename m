Return-Path: <linux-kselftest+bounces-23684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5AA9F9721
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CAF16D92D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3F92288D0;
	Fri, 20 Dec 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC/tLDSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C021C198;
	Fri, 20 Dec 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713521; cv=none; b=Bc5mkP0MI07UB9OSX6WpwnyB8ZICmPHQ7FuDEN1fhf0p91gzbaVpUv7pzYP/qItzJyNhjpoUzGkSCsdWVaSHdgR93qp/98/dZq+VG7OpZGk2aqOwBnMab//5l4EuQNIRMCeWacwJMsRr9fEiZ1BYPJ4PQd6Wk/C0zqsKD8nVIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713521; c=relaxed/simple;
	bh=bf57/Mt8lkovk9yTZssGPdXZll/Sjexpxib+fRQYfOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGlMB2tVD9+IsU0wpcsw69voVfrbfRfCrIfUGb7PUb0mORC+NaMM9whQbZI4uWRoNqsmVCcLIAmrHnsR5x8NHee/z3Juarf7Z1ulzd3VHg8/SEw43soNZQYWI/yzmNUiLcQFT4OREpirZar+0wpXtfiMfeKlCeG6fy6Kf09CsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC/tLDSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B4CC4CEDC;
	Fri, 20 Dec 2024 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713521;
	bh=bf57/Mt8lkovk9yTZssGPdXZll/Sjexpxib+fRQYfOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kC/tLDSQl2HZQDgFxku8z644+vm4uF7U5j/HxAXs/eEds3UqDpzlPZo71f8pFBFG2
	 u8YzAGod4rZDiBRBorz4VgkYlG6kV4f7Mw2U9iyC2yAjKXfa/i+fb6zGYeeR5qo8Nn
	 aE0WtAD7f141UoQIV7BdKVwDx87aIpOiRNyeua9fRG4I4HwWJHmXSJ2qYilSHVajMl
	 y7rsa2eo/78mwfKJ0jSQOVVvGKkcNZSXPJSq+H5RLVFaiUhgh/SUNydJcUFL/Pkj8p
	 i4ct6ksCigh51yqeXQ3rpAHv3S4xwXyFqATtEJqTTJb/FQFxewUOzexp6C0UnTeY5M
	 JKnI0Yf4vFssw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:42 +0000
Subject: [PATCH RFC v3 17/27] KVM: arm64: Support TPIDR2_EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-17-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4482; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bf57/Mt8lkovk9yTZssGPdXZll/Sjexpxib+fRQYfOY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBhz28kj9hkbHjMLTSudh2GXiccrVHMInwBUooh
 +mbZBVKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgYQAKCRAk1otyXVSH0IkLB/
 4zrC9EMskzptln4mEPPt0kerJH86JtWGK4Qv5qziXvaYzaKI8ZB0/+Hb2bKehkg9bH6DymfV7VLzPQ
 HT/1mWCt96XTe2R3/pMS6HVbuFVKqAGhtDdoL0qa73iQkRAHgWQzcuBqe5LdEYnGo7qtVs3nJyDwV5
 fSnOBMOGtljuA3aqtzQzJsJD1R1oSHZTKi0LWE2pfTrp5gQuVHAk68xg709FcTrIHjm6rw7wXMfI1M
 ZLtlOFVE6PuH+fio3zBOSyXBTAsjL4vwVDsPw3sd0ON/pN9HyKTU1cK88AWYA8m5U1PJQ5JKneu6gG
 KT1qvLysO4wyuioNxkNH5Te2VFLOMc
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
index 8d6342dde02fd99cfd7d2bedeccf0581ad3504ee..063b75eb4f3bc4fb425d2abc8118a950bccc2317 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -428,6 +428,7 @@ enum vcpu_sysreg {
 	CSSELR_EL1,	/* Cache Size Selection Register */
 	TPIDR_EL0,	/* Thread ID, User R/W */
 	TPIDRRO_EL0,	/* Thread ID, User R/O */
+	TPIDR2_EL0,	/* Thread ID, Register 2 */
 	TPIDR_EL1,	/* Thread ID, Privileged */
 	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
 	PAR_EL1,	/* Physical Address Register */
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 8c234d53acb2753c59aa37d7a66f856f2eb87882..93d2b81e8d0678a16c88bda3549ee790db7f5bc2 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -66,6 +66,17 @@ static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
 	return kvm_has_s1poe(kern_hyp_va(vcpu->kvm));
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
 	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
@@ -79,6 +90,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		ctxt_sys_reg(ctxt, TPIDR2_EL0)	= read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
@@ -148,6 +161,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, TPIDR2_EL0), SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a9429d9d63b54b5b4d4fe365aa6af4d84a256539..b5a38fc7a4a9ed4fce053018eb6ff353ae5c0d09 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2855,7 +2855,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .visibility = s1poe_visibility },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
-	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
+	{ SYS_DESC(SYS_TPIDR2_EL0), NULL, reset_unknown, TPIDR2_EL0,
+	  .visibility = sme_visibility},
 
 	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
 
@@ -4959,8 +4960,7 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 				       HFGxTR_EL2_nMAIR2_EL1		|
 				       HFGxTR_EL2_nS2POR_EL1		|
 				       HFGxTR_EL2_nACCDATA_EL1		|
-				       HFGxTR_EL2_nSMPRI_EL1_MASK	|
-				       HFGxTR_EL2_nTPIDR2_EL0_MASK);
+				       HFGxTR_EL2_nSMPRI_EL1_MASK);
 
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		kvm->arch.fgu[HFGITR_GROUP] |= (HFGITR_EL2_TLBIRVAALE1OS|
@@ -5007,6 +5007,9 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 		kvm->arch.fgu[HAFGRTR_GROUP] |= ~(HAFGRTR_EL2_RES0 |
 						  HAFGRTR_EL2_RES1);
 
+	if (!kvm_has_feat(kvm, ID_AA64PFR1_EL1, SME, IMP))
+		kvm->arch.fgu[HFGxTR_GROUP] |= HFGxTR_EL2_nTPIDR2_EL0;
+
 	set_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags);
 out:
 	mutex_unlock(&kvm->arch.config_lock);

-- 
2.39.5


