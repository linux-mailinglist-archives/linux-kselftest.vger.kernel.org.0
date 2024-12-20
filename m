Return-Path: <linux-kselftest+bounces-23679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A669F970E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73931163B6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619A225A3A;
	Fri, 20 Dec 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkAByGPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F82225A32;
	Fri, 20 Dec 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713503; cv=none; b=U3ij5z2KOVIY+Hsxk25VtCdcSICfd7WWdkkgugWwA2QjZf4ZeUKmQ9ZDP88PppNzqJiXjVfWAtErNzKUzj5A6LsoOdirQkFbCteoQNdwh9twiVN2Zzq2Q3l0LqSHKg6pYzRViavKCiEpJxUWxtKELBP+LMI8IoOisCQ6foCOfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713503; c=relaxed/simple;
	bh=h8tZV5l27wMi7QZ5NW8MxQzjInn8bIQ6N+gjfbDmOZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhgjSqPbtN4LQ9DvXNCU7NorhBSNVExb1k9rtWnv2zRi+vUbbt3GZivdJrXeme0N6MLKhUj+lJHDem98h50bcYXPaWcbdGkP9cUTJdBj+fSGOcOrxC5l748wU52k6jkOFrJHh8BZwX2zpnVwiJhbKB3/mdxNYCsH2K8UMcCkg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkAByGPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C0C4CECD;
	Fri, 20 Dec 2024 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713503;
	bh=h8tZV5l27wMi7QZ5NW8MxQzjInn8bIQ6N+gjfbDmOZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dkAByGPQ/h/zgIqhkzJAORHDMIhQJ3TUM9neW6eHt1GtXikZn+iCRia/Y8bCX+MZc
	 5wyGc+VLJtOfcT4OfttexHbBH7ITBNFBZz0KQoRessnzWckchu2FFCjawHwIKgCpVS
	 jKdpNLMhuhnseRWg0iOckGMpYYdYc9Eja8Dfbq7OKAGZe2mrbzsjT8LV0SL2ZRlXRF
	 U4LwyFFX985RvP+Saycum72bN+ZS/eueiV7qjwC3WMyF6E6dKNWTrZYPCPV2qmxcQM
	 OJBavdKvXqCLr4VxkTxDhcaZHx94r+YVGrNOIRkfh0hPt7wMqWuqm/hBSthougxx5f
	 6KYxmggs3xcsQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:37 +0000
Subject: [PATCH RFC v3 12/27] KVM: arm64: Define internal features for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-12-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2935; i=broonie@kernel.org;
 h=from:subject:message-id; bh=h8tZV5l27wMi7QZ5NW8MxQzjInn8bIQ6N+gjfbDmOZc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBd4w3/lE8UZpVmijwql4FlP/nsQSz593ePQ9Xc
 nGIMzxOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgXQAKCRAk1otyXVSH0MdEB/
 9qMnB/e2qi9gqsYL5d2AWSroqgmWPN0FOQjIOFJOU3GIyj2480egTCTNt6+EkHDe1haabUHYho0egr
 PAFlfc0Lr4+phfys3RTH/dtQr/P++q1GlGCH9aCUDiKl9enB74nktMfgPryQnwNteNu0AwZFCr9K6F
 8aliU8+zvqfIMYjkXWJyCDZTy7/TyN6+orQ9D4vPihMYCODSFMJ160xyaoZWsYMkg38v4LjPm7QrwX
 mfBR7ta2dupKszGKrM1s2SZKONb4tOKezSRbT2D8OSLWJ4ELho14oEAIM3LU5ZgXqX3bPVxan8v/v2
 gM5HTvfMXhobBSg4P6LEkPzoOFYEg6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to simplify interdependencies in the rest of the series define
the feature detection for SME and it's subfeatures.  Due to the need for
vector length configuration we define a flag for SME like for SVE.  We
also have two subfeatures which add architectural state, FA64 and SME2,
which are configured via the normal ID register scheme.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 23 +++++++++++++++++++++--
 arch/arm64/kvm/sys_regs.c         |  2 +-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f64ad573573cf000c4644f12f9e072a2fdfc3824..022214e57e74404e8d590a5820a9e77160869b1b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -39,7 +39,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 7
+#define KVM_VCPU_MAX_FEATURES 9
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
 #define KVM_REQ_SLEEP \
@@ -339,6 +339,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_FGU_INITIALIZED			8
 	/* SVE exposed to guest */
 #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
+	/* SME exposed to guest */
+#define KVM_ARCH_FLAG_GUEST_HAS_SME			10
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
@@ -948,7 +950,16 @@ struct kvm_vcpu_arch {
 #define vcpu_has_sve(vcpu)	kvm_has_sve((vcpu)->kvm)
 #endif
 
-#define vcpu_has_vec(vcpu) vcpu_has_sve(vcpu)
+#define kvm_has_sme(kvm)	\
+	test_bit(KVM_ARCH_FLAG_GUEST_HAS_SME, &(kvm)->arch.flags)
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
@@ -1542,4 +1553,12 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define kvm_has_s1poe(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
 
+#define kvm_has_fa64(k)					\
+	(system_supports_sme() &&			\
+	 kvm_has_feat((k), ID_AA64SMFR0_EL1, FA64, IMP))
+
+#define kvm_has_sme2(k)					\
+	(system_supports_sme() &&			\
+	 kvm_has_feat((k), ID_AA64PFR1_EL1, SME, SME2))
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 83c6b4a07ef56cf0ed9c8751ec80686f45dca6b2..1b16716a6d53525fbe694cc8d5d009d72b6ce416 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1727,7 +1727,7 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 static unsigned int sme_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
-	if (kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, SME, IMP))
+	if (vcpu_has_sme(vcpu))
 		return 0;
 
 	return REG_HIDDEN;

-- 
2.39.5


