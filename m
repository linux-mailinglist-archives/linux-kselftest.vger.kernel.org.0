Return-Path: <linux-kselftest+bounces-31012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6DA91086
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA553AADFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4502185AA;
	Thu, 17 Apr 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htMZzg3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0692144B9;
	Thu, 17 Apr 2025 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849604; cv=none; b=kjnnDkGuKWtVFVRRrFvpQKV+1e08i7HleSeWeLLhzFTqywyWSomnka3gJKsp8Ks4WU3OCkHEIZ9Zqee8vGoupmPBp58cpJxtdllUWNuQrPmub6OPyyp8KILY4N6zODPu5CewjnxZItHmBtWBbPlCS3bwaSdEhW812R8O5H6QcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849604; c=relaxed/simple;
	bh=suQVxCyhMLYX8/wX26fCQf5eYg++OX5MZcwBCHNmvkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAP0M6tcGQiyK+yeZeqzjLqQpnj3eslqs0LqnimuC574QslRudYmwigoeokQOqN6pMFg2rLdOY9l2lspLmLE2GIOhCfuOSfEBv37Nn/zDb7cWe1FGrL36oHKhxw37KTbnASpReRh/AIr6B/CxcFH4l+1kIOceE/fkC745RMqq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htMZzg3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90139C4CEE2;
	Thu, 17 Apr 2025 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849603;
	bh=suQVxCyhMLYX8/wX26fCQf5eYg++OX5MZcwBCHNmvkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=htMZzg3mt17fnEvR0KBcSxGzmwsXuThdo9yFAiS9gdKhSq5kvm67mF0OiOlEOKb+N
	 cXaXcTD0dyLXJqXnsGLtOIM4xbqj00sWV5/i2szCIjn/e44yo6PrR+1Fm7a3JJ5RP/
	 KfdXsMf9OozJgvTEZibC3vIKlFZVADxxQzlvFdPqshSeYiANoW1hz8uwL+N+3pnaMa
	 PYoWXPDB8I+afpo3bOAPAQItw276Uv8GRsFBh/2pMRJuBfE2ZHluwYOI6zlkMmduGG
	 fm6FzLtbQoEQHv2oWzMQKj5KD8dfqffWH5EM+R7JAMF6Q/x2vFZqoZtQjqkRVEtbhI
	 ENhT+3rtAicFg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:20 +0100
Subject: [PATCH v5 16/28] KVM: arm64: Support TPIDR2_EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-16-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4237; i=broonie@kernel.org;
 h=from:subject:message-id; bh=suQVxCyhMLYX8/wX26fCQf5eYg++OX5MZcwBCHNmvkc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEp7W0peKP++HkrB3Vo/bYbj162IyYwKJ6Sfgccq
 vAZI0Z6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKewAKCRAk1otyXVSH0JBzB/
 oD9iycjI6MM3meBb3H18BNPB5QOwa4eVbotXXRZBc2zrhAkhVwxb6w8byeZXy9ykL/NsdwJBXawVSJ
 e/25VtQLumRwK7CDO5pQJXpNJuVBcnfbTMyqGkkx0cAm5NKTjXgXx8v1yH429bM0h3QewnF1qdZMg2
 dVZHcDieq4GNM5+yEMiZDqfmZ5dJkS6xbc2EJAayFs9UT2W6heDxS9CAiga1oZS22c7EIj9blOfaAF
 ucB7em0D9WHwr+xzZwH8ja54VlxYUssx8wT8Eh3uNZP0GYBumfEDgZqZ5OOFTNMQhYBIkJvBfTEqXW
 FW4xhKtm+4MIZe7umsD3rfBIIFjdY6
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
index b15de8319a65..645c7c694cf2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -440,6 +440,7 @@ enum vcpu_sysreg {
 	CSSELR_EL1,	/* Cache Size Selection Register */
 	TPIDR_EL0,	/* Thread ID, User R/W */
 	TPIDRRO_EL0,	/* Thread ID, User R/O */
+	TPIDR2_EL0,	/* Thread ID, Register 2 */
 	TPIDR_EL1,	/* Thread ID, Privileged */
 	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
 	PAR_EL1,	/* Physical Address Register */
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index b795a7a87a93..7b5ba37b4d19 100644
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
 static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
 {
 	return host_data_ptr(host_ctxt) != ctxt;
@@ -105,6 +116,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		ctxt_sys_reg(ctxt, TPIDR2_EL0)	= read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
@@ -174,6 +187,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (ctxt_has_sme(ctxt))
+		write_sysreg_s(ctxt_sys_reg(ctxt, TPIDR2_EL0), SYS_TPIDR2_EL0);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 58ec44aac5c9..84a745e392d4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3110,7 +3110,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .visibility = s1poe_visibility },
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
-	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
+	{ SYS_DESC(SYS_TPIDR2_EL0), NULL, reset_unknown, TPIDR2_EL0,
+	  .visibility = sme_visibility},
 
 	{ SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
 
@@ -5186,8 +5187,7 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
 				       HFGxTR_EL2_nMAIR2_EL1		|
 				       HFGxTR_EL2_nS2POR_EL1		|
 				       HFGxTR_EL2_nACCDATA_EL1		|
-				       HFGxTR_EL2_nSMPRI_EL1_MASK	|
-				       HFGxTR_EL2_nTPIDR2_EL0_MASK);
+				       HFGxTR_EL2_nSMPRI_EL1_MASK);
 
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		kvm->arch.fgu[HFGITR_GROUP] |= (HFGITR_EL2_TLBIRVAALE1OS|
@@ -5242,6 +5242,9 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
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


