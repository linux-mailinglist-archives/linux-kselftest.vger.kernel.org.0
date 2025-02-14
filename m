Return-Path: <linux-kselftest+bounces-26615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB3A35426
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B68016926D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDF2192D97;
	Fri, 14 Feb 2025 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6MtElX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4EB14A630;
	Fri, 14 Feb 2025 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498502; cv=none; b=nc9Hj8OppOFJRdmCVx3Pb/0SGQy+VHxRmFgy3CVoGXrq5sNt32xcSlbX4/ZUSEzQckxp6X4cn96EttkaUTVhMic4I7bCQPiqqO3X9B0DtjK6n5MCK4bOG4fAyC1rrpL+VAcC0ehjlfBI6jZIvq8JySPCkqJtS/Kf8LjgZpcBI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498502; c=relaxed/simple;
	bh=pIXa80sqzHzFpWf+BtFQDhwZHyO3E94JaRZryQDM4fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VoG3B6/0KcRuauoedcjXywuR/oFwAtN4J01/oJ7/mSS8LpUBklRkdA/frsB9vtOZwpFSmJx2B4U5wDxRt8uWPLdQVo5sA3lg/q3JON2xpHRQ53YPvZk04klNdl2hUSmAVNoBdpHHY8RfVv8E7X/uhDFy+aoitk5vDLb4Y4gC7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6MtElX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B7C4CEE8;
	Fri, 14 Feb 2025 02:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498501;
	bh=pIXa80sqzHzFpWf+BtFQDhwZHyO3E94JaRZryQDM4fI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i6MtElX4fLodMybOfuMqg2AlpZFWQzfsrzHEfVCFp9gAD6y9aJLigtLYg7AwNJRsE
	 Q3CbFPrQHO0X2UVtS/1L5YWuC/dkr3tm5q6gqod8zj8dfWo8wmAegh2+7G+TuRzKEx
	 7KKVECifyPq1YZBfgVjmhm4p3eX6Ds6zeHYdESEIMZqETp7BoNDd1EW5WfPfLcFeBB
	 u2uCDxejaqKo5M9rhNZvI95TEd3G0y7wBl08NRc7n5W0d2AjgIBeC9IzPzHFd5l/v6
	 EwQYrnzuAV51Z+eZbpUNwe5arnWog9NpMtq0oVBBIpjpDGA+OOkb/5kPSDVrn1vSij
	 dqlSsgjArBbTA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:54 +0000
Subject: [PATCH v4 11/27] KVM: arm64: Define internal features for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-11-d64a681adcc2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pIXa80sqzHzFpWf+BtFQDhwZHyO3E94JaRZryQDM4fI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPJQPFdilei7rkQV+MBFJubRfiidnpeFvfS5+lL
 TCDF12+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jyQAKCRAk1otyXVSH0PVeB/
 9eM3Ub+1FRgxCLNlkjT+HrL5Nnh2dYhvBVpDCniMUhDBOplkdpcdpiYXPEbQGd+O+iQrjPeNj2+lez
 hZt2JqIP1IQu9Y43So1lybybs6Qi71jVRdj0amWpIZ3ylXBrucr8fdHkrPjqqNZE9PEWjrz4oPyqqh
 cTcBRpQ7p6GmqFl7npTSpsnZxo6jhkuwUFy6x/7VYPToenzHfqGhWZJfTvd6SpWTRLEcDPRN35MRLr
 78ZNJpDvoCmeM7s7YASmvF4MHp363uHICFrFg9rP5v4jpqh09rxut2wrBGFrOufCFterrReCGr/K0b
 x6EkFNDWd/v0MzF6lw1ApczHd8TOoS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to simplify interdependencies in the rest of the series define
the feature detection for SME and it's subfeatures.  Due to the need for
vector length configuration we define a flag for SME like for SVE.  We
also have two subfeatures which add architectural state, FA64 and SME2,
which are configured via the normal ID register scheme.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 31 +++++++++++++++++++++++++++++--
 arch/arm64/kvm/sys_regs.c         |  2 +-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f12b13c3886a2b90d0f1e95f9d59f374d3c87398..55ada264b7383925269674a47446b8f659a7e4e6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -39,7 +39,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 7
+#define KVM_VCPU_MAX_FEATURES 9
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
 #define KVM_REQ_SLEEP \
@@ -340,6 +340,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_FGU_INITIALIZED			8
 	/* SVE exposed to guest */
 #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
+	/* SME exposed to guest */
+#define KVM_ARCH_FLAG_GUEST_HAS_SME			10
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -941,7 +943,16 @@ struct kvm_vcpu_arch {
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
@@ -1551,4 +1562,20 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
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
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82430c1e1dd02b1ac24fd2ddcd05a91272997fdb..49b7844af8a19467e7842347c4b05ceb44c4caaf 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1748,7 +1748,7 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 static unsigned int sme_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
-	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, SME, IMP))
+	if (vcpu_has_sme(vcpu))
 		return 0;
 
 	return REG_HIDDEN;

-- 
2.39.5


