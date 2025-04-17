Return-Path: <linux-kselftest+bounces-31007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F78A91072
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1583B9F9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF90B1F585C;
	Thu, 17 Apr 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMd9iCFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C51F417F;
	Thu, 17 Apr 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849585; cv=none; b=gsiEynohZ/hLstDzwcym3i+zvimRGIjP+HEdsDFnI/rw/ROloHs74DyxpKViq7WglHKN/4KkRngKUKnOz98qYiRxsfsiLUf4pjkds3KRE3Fhaut9Q37oCBYQCtP5FAZR7v5/dnigCp0OKgAxrZqdwO1o6UlNI4YrWfUOBsDGsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849585; c=relaxed/simple;
	bh=BYdob+W33p0p38mPrG7hoqJmur4cAV8L1cxc/90jdsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHzGb4r76SpyFPdpcfMCQJ/87G1CBirRqGLtPKmjezqYZZh9b52vOx/EoY3gasXu/QlwS4OpNLLR5b476WMWcGTwmsyPIs9BNxl9vLaGSLbOyW7vLzm/bOtAlGLz/i1fYidD4cs+DzNx2vWvQknBhOY8XDpzx9pYD0lkwgLTAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMd9iCFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565F6C4CEEC;
	Thu, 17 Apr 2025 00:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849585;
	bh=BYdob+W33p0p38mPrG7hoqJmur4cAV8L1cxc/90jdsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WMd9iCFb4qyJ1YAYVLv4rwJJ9diJAMkdqwfehdJVANNo+mEGx0Wxsw8yM7YAvDndK
	 fw2YHZRKB/irHhiuJWaGXlO0WytqVPZYFwzOCAgLKi06Gq8zfpQBJDNE/Za/h7qWyN
	 hvl+b+AqitRVS8ojJIbHZEfDvV5i9k4dWidHsjozXg9IcdM+gloK3A1p48Si0z/vAz
	 /sHCKrMXNZEJMCplNxarYV7RG/HKc/yMGgHkAR0orSDmTtvVQIeG+TD7sanrYHw9hX
	 EDIvohL776bK6fmikjwJkEXrLL2NRO9eOzmQHVjzckbImO5DFUioikebwnvMM+yonU
	 mLHn+VD3z75Cw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:15 +0100
Subject: [PATCH v5 11/28] KVM: arm64: Define internal features for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-11-f469a2d5f574@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3485; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BYdob+W33p0p38mPrG7hoqJmur4cAV8L1cxc/90jdsM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEp3I8DJjtzyfDKd7nlH0QFerMoK4BdwF667LOMV
 OrBptoOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKdwAKCRAk1otyXVSH0DRjB/
 4sZN1FtqP3EImLO6pygoyQeYddHPrz4QsBEzA7n4E4WbDcRuEO5ELi2f1ovP+mLMdhTKkKaIqbqSYZ
 6H2lAS2mUWfY6Gjuk32JB50ibWxfiIyMOPwyiLIq4zKqgufsvuhEFBiBghM5GN5fFkAdUHiEoxxe1n
 kyhe1s0e622pdJIUbpK3rYjirr1U5qM4D5dtfyGproj/Ja2010vrF0aoCAtA4X95wsKipyJGKnu9zp
 SBfvkKqZ5W/aBZ5vgDvLNrRLPigLQRgg89IL6bGvn6D1QukDuk5VoZOO5RSeFXBTKnmd4e8t5sqTWP
 REKs8L8/aj16Jl/Xq4ktpLs0o+8ikv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to simplify interdependencies in the rest of the series define
the feature detection for SME and it's subfeatures.  Due to the need for
vector length configuration we define a flag for SME like for SVE.  We
also have two subfeatures which add architectural state, FA64 and SME2,
which are configured via the normal ID register scheme.

Also provide helpers which check if the vCPU is in streaming mode or has
ZA enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 37 +++++++++++++++++++++++++++++++++++--
 arch/arm64/kvm/sys_regs.c         |  2 +-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e828607653c7..a6690893ec5e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -39,7 +39,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 7
+#define KVM_VCPU_MAX_FEATURES 9
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
 #define KVM_REQ_SLEEP \
@@ -348,6 +348,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
 	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
 #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
+	/* SME exposed to guest */
+#define KVM_ARCH_FLAG_GUEST_HAS_SME			11
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -982,7 +984,16 @@ struct kvm_vcpu_arch {
 #define vcpu_has_sve(vcpu)	kvm_has_sve((vcpu)->kvm)
 #endif
 
-#define vcpu_has_vec(vcpu) vcpu_has_sve(vcpu)
+#define kvm_has_sme(kvm)	(system_supports_sme() &&		\
+				 test_bit(KVM_ARCH_FLAG_GUEST_HAS_SME, &(kvm)->arch.flags))
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+#define vcpu_has_sme(vcpu)	kvm_has_sme(kern_hyp_va((vcpu)->kvm))
+#else
+#define vcpu_has_sme(vcpu)	kvm_has_sme((vcpu)->kvm)
+#endif
+
+#define vcpu_has_vec(vcpu) (vcpu_has_sve(vcpu) || vcpu_has_sme(vcpu))
 
 #ifdef CONFIG_ARM64_PTR_AUTH
 #define vcpu_has_ptrauth(vcpu)						\
@@ -1596,4 +1607,26 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define kvm_has_s1poe(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
 
+#define kvm_has_fa64(k)					\
+	(system_supports_fa64() &&			\
+	 kvm_has_feat((k), ID_AA64SMFR0_EL1, FA64, IMP))
+
+#define kvm_has_sme2(k)					\
+	(system_supports_sme2() &&			\
+	 kvm_has_feat((k), ID_AA64PFR1_EL1, SME, SME2))
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+#define vcpu_has_sme2(vcpu)	kvm_has_sme2(kern_hyp_va((vcpu)->kvm))
+#define vcpu_has_fa64(vcpu)	kvm_has_fa64(kern_hyp_va((vcpu)->kvm))
+#else
+#define vcpu_has_sme2(vcpu)	kvm_has_sme2((vcpu)->kvm)
+#define vcpu_has_fa64(vcpu)	kvm_has_fa64((vcpu)->kvm)
+#endif
+
+#define vcpu_in_streaming_mode(vcpu) \
+	(__vcpu_sys_reg(vcpu, SVCR) & SVCR_SM_MASK)
+
+#define vcpu_za_enabled(vcpu) \
+	(__vcpu_sys_reg(vcpu, SVCR) & SVCR_ZA_MASK)
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 005ad28f7306..0fc33134ac41 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1772,7 +1772,7 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 static unsigned int sme_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
-	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, SME, IMP))
+	if (vcpu_has_sme(vcpu))
 		return 0;
 
 	return REG_HIDDEN;

-- 
2.39.5


