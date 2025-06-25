Return-Path: <linux-kselftest+bounces-35754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B11BAE810F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CF01679AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0B22DF3F8;
	Wed, 25 Jun 2025 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eusZCGxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5C2DF3E3;
	Wed, 25 Jun 2025 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850727; cv=none; b=l8AnqSZxKCgXIsLyFI4Z0lL4MBD0Pi2yMmUhC+z/wkvZY90hSQutC+B7p5U9XLS8/4H+Qywrmdp1w3/fticFHD2TmHbFpYuyeS+lxWoIKJckEp0B8JkAHm41ztGxZDBdTixYIPQXS+tvDvc2ovIHG6Rp2VDFchshyGAvaUzZny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850727; c=relaxed/simple;
	bh=+UH9XrQHNkHntsBWQgweH71zC1QqE5QsvfFHM7M4pUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OfTYNc7cFxUjOjGdTEe6opHipvpA4lqy4hGGs8tUAv1v4ePftOWqmhzm8K+Kf/e20eDlCcJXmWdo6KWMr6rNKP6o+dp7MpU7cloKrm5qZhKnmm11/gXC13SmGaKgW6egRo6d9FfJqSU+qDRr29+WhvQdi0h0mVBIYQwTtjvDsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eusZCGxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39141C4CEF3;
	Wed, 25 Jun 2025 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850727;
	bh=+UH9XrQHNkHntsBWQgweH71zC1QqE5QsvfFHM7M4pUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eusZCGxwEUQoeeoklVRN7JJsVb6qxYAyRLfDizHifwZksFmN7lSUim57nl1jKNNiN
	 jdo5BtWMVAY/nPGavr1Qv/zmvoMebg2hcp5feyLqjdbjxEojQuFFYlq5Jw9r+8Rpb+
	 2/nqBgxtoKD6XsZJEZFAW4cF9KVmQI5SND2r+chx0QYAJIHm31YGBDvdjAWcW4Esh4
	 d4iUgEVHU2sP7Yb9nEP4L1UyepqHdGnTREUvu5EWdgeqLsx2dJvLtdl2ClgEDoFbZ+
	 37WIpQut8O+da4Scdx+gb3YO89IWzCihQJwMPSEQICJjabW5j+dOwaLMrEFHofkSNX
	 kBFCBSI7cyacQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:02 +0100
Subject: [PATCH v6 11/28] KVM: arm64: Define internal features for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-11-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+UH9XrQHNkHntsBWQgweH71zC1QqE5QsvfFHM7M4pUc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xttI+GOVh+0IpSpNb1N6ud4UCEEQFdYcPgq
 AVXYMTEi3WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcbQAKCRAk1otyXVSH
 0DlVB/0XFJp/sRnrGFrxlThlJ07gvs5hW0OGCOOvpfcsvUB47K2Z9EYmp1+6zbZ5IRvIehfh6SJ
 6VP7jCbJ7EYOkfEfmvl4LVFTkESLvYOAAodFC+7aaja1buByshW7b6tx5G1frDEJfBooVQPTX6c
 UGwA7NWMCeYGtFmzm54QD4uwESOAPhjHWjGeav8kb2XFCzb/Mt3d5K8yJFSLa7rayc54gmtQubo
 vA+SVajjBlNPdO3laP6U/bnBXriPFYiI01TrcLgQw/uvdIG2MbpB4l9I6/JLVxfRL+7uv7OIVP8
 fA44Zn3b1qx43DremJw6m7U2TFJFpl/Q7UDRA91v9XLV9GQb
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
index bd3bf8043c43..bf7aa52af405 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -355,6 +355,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
 	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
 #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
+	/* SME exposed to guest */
+#define KVM_ARCH_FLAG_GUEST_HAS_SME			11
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -1037,7 +1039,16 @@ struct kvm_vcpu_arch {
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
@@ -1674,6 +1685,28 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
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
 static inline bool kvm_arch_has_irq_bypass(void)
 {
 	return true;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 76c2f0da821f..7dd4a5ef0e81 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1774,7 +1774,7 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 static unsigned int sme_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
-	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, SME, IMP))
+	if (vcpu_has_sme(vcpu))
 		return 0;
 
 	return REG_HIDDEN;

-- 
2.39.5


