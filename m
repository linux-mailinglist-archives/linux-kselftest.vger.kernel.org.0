Return-Path: <linux-kselftest+bounces-47881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E87CD7C8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6CB531452E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A042D3EC1;
	Tue, 23 Dec 2025 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyZ69Kcb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330982D3A75;
	Tue, 23 Dec 2025 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452943; cv=none; b=bZ2GP4gLSwYZ8U9vCXaTKXmNweGkKdwKZT5wYSQS4zzilYN16n/k7xBmQ94o702jmmfGuT5D3K8F36yFQkmArursi8aIS3hOqIj5y0ujK3ItcvnhbdEEqZARvqhJf+4IXrs9K8ueYeUk/pUb8Owj7YOBFed/3XXRnbZ2l1WVz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452943; c=relaxed/simple;
	bh=A4NZGrg+TEz6932+zi/k6JqFarqVN/v9J+9+Wy94BBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0Ip4xCl5lrFYgEo7NwdXU4EyvdzyZVtyLJL3XGTNQOKPXB+IhV3LzN+IjlBkErZ6bgEzSrts9zQHvxAIIrhM6dv4cC8pMgsyF5RzBGOV8x5FGXFt4z+q4dzUuOwme7IyUIp7nsRC32EQebBtv/5ldEzK5dYSFrG/CKyt4rXdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyZ69Kcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E3CC4CEF1;
	Tue, 23 Dec 2025 01:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452941;
	bh=A4NZGrg+TEz6932+zi/k6JqFarqVN/v9J+9+Wy94BBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qyZ69Kcb0JMVMtJ9LiFOsKQ4MTUhDH6m8LY2vS1rmL+JXQcp2UKibKlIMV5kH6Jeq
	 pd5oTKhoCeVlE/+OBJgaYQFdml3cpRaqH1tupEiu1ix3Otz/UwIO3xvAOPm8FnsdB1
	 ++SlGSHV/8OvucH8cMLUz2xok6ikXjV7/sI8AYVezlAmpyNdkWhaXHOiYHbAfj6ksU
	 Eh/lynQWiBt61kJOuFvVt5bDUTUyuyojXHMlCyawMRJ9CibwA7j7a2nYQ17B2PhGiF
	 ruF9fcBPBIEOcjmnt4oYwnl9XJ7yDp7lrgOu4pBuk0mbGlxHh4UfhXVNzqSPJry/3C
	 Zw+8iOPms44kg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:05 +0000
Subject: [PATCH v9 11/30] KVM: arm64: Define internal features for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-11-8be3867cb883@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A4NZGrg+TEz6932+zi/k6JqFarqVN/v9J+9+Wy94BBA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6LFCe39WIuuDEtOO/K4RmDUXHyHJaBm6U/x
 0hrqF0DjneJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuiwAKCRAk1otyXVSH
 0G/5B/9YxeU6cxwTbk61Pby5uUM1Mk4lRYZ+QxXUVDvTuKJSTgNEp1Y9UfPhG1kE+ynnpYcX1pm
 3jXPtAU01yEgKY6dIwtN88EGpYQmkUhvw8WhmGxzYGhJcgSjznOarreIeeRdz6FF3Lj9BLu2iZo
 prBeSHs5RDFzNjovnKJtV+UK8dokaCRfWVy7KfbV9WGY0UCHped1ZH4RoFy2gtgH8D8fWX0U1QX
 8Sk2f1DUUmvsu+fX7/VPyIzCfILM83mnRNMn4tGp0LQsIvbKQmNQ47xmBHOjnHqRDSVK/qvBMaC
 wZP9w+ezCgGRlpqCCXkWsbeJHEuAaZxsLRK1d8InmdtIjwwA
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
 arch/arm64/include/asm/kvm_host.h | 35 ++++++++++++++++++++++++++++++++++-
 arch/arm64/kvm/sys_regs.c         |  2 +-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0f3d26467bf0..0816180dc551 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -353,6 +353,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
 	/* Unhandled SEAs are taken to userspace */
 #define KVM_ARCH_FLAG_EXIT_SEA				11
+	/* SME exposed to guest */
+#define KVM_ARCH_FLAG_GUEST_HAS_SME			12
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -1062,7 +1064,16 @@ struct kvm_vcpu_arch {
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
@@ -1602,6 +1613,28 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define kvm_has_sctlr2(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, SCTLRX, IMP))
 
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
 static inline bool kvm_arch_has_irq_bypass(void)
 {
 	return true;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c8fd7c6a12a1..3576e69468db 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1945,7 +1945,7 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 static unsigned int sme_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
-	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, SME, IMP))
+	if (vcpu_has_sme(vcpu))
 		return 0;
 
 	return REG_HIDDEN;

-- 
2.47.3


