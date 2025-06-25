Return-Path: <linux-kselftest+bounces-35769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AFEAE8152
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B691719E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23C2F0C50;
	Wed, 25 Jun 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcPzFSDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07482F0055;
	Wed, 25 Jun 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850783; cv=none; b=ndoYViYKV6W1LlVWeVnnJ3z6jstUaK4XpqMnwjIafI1ZNwZAWziYQX57fCG/Um5xr1U1/vc7Rlmxj5cGvhr+Pv/Q+F5EVRJK49KR/GlQWYyLAP77r7xyEDYvfB6KGRz77cXnG68gHylSiBTNFkZlClxJYWRvd541nv6ilBhpsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850783; c=relaxed/simple;
	bh=DQ1AqhJ6Vf5cQk7xQdJJILS8/JrKJD4LivoveaURzeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxFdLDWk11ZediT+zlv+qZ65d3yzSlditoNVPT/Jp8DrL6v66nLawdeCzs68Atpk8C+yYl+BBiMaQrs2sTdjT34ocb27A26R61OqGvMdz/FUvS20+mPL0QRiGEiPICJHSG/56twuYqcz1CSB9/kN7VfUFeNLl1vP5TuOpvMlpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcPzFSDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1695CC4CEF0;
	Wed, 25 Jun 2025 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850782;
	bh=DQ1AqhJ6Vf5cQk7xQdJJILS8/JrKJD4LivoveaURzeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IcPzFSDIYQZbn52Qk+bDjHcPQ9kh1FPfXrNMrgm5x+bdHGtE7bStqAjjq3vGDtHxS
	 uQTnQC93eo37aVXWy/JTgmDCMMnqmebYbSR8lOJ6MQmoxLk1Grujqm51JRYY3W6Bxk
	 hJ//ys77AmND/9+6bwY0sjFtBBrfczoT3s4SBiX61cd6KAIH1jMxcx358U9xoOrRcn
	 7G4pTt6LAiYiOy9M3zAPeEdTdHtUw7h5IuJJtn6gnHsoiVe5/iFKkq2PCJLzcZ3U6A
	 nrPEHcamE/YoviTVfSIC7+HYrA85l3v+BJb7bqRcnp3jM8P70jCBescS9UyW0cla/9
	 rDvLULWpdTvlQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:17 +0100
Subject: [PATCH v6 26/28] KVM: arm64: Provide interface for configuring and
 enabling SME for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-26-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15736; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DQ1AqhJ6Vf5cQk7xQdJJILS8/JrKJD4LivoveaURzeA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9x5tY9Y60m0kmXDa/PiL3ET1BSlAC72nzLRD
 HfS3dLOIiSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvceQAKCRAk1otyXVSH
 0Dp8B/wPPSO9iaaks35GcIokHwWJLnGSxEOWfN561VxVYHisPzcSWcKRLvj5dT3iCTKaop/iPpe
 TTxJpS1BV8fM3tI+33gQStAsphE/yCEC+/BtmaYVbsw5Oytpw1vIuAhJ7925OzBVWmFqnLYCkYi
 6x70tVB4R7VqeDRo1w+Z4kjCbRg0jCJavhxxRIv3bWJpL4xZP/CichtNMHoUB7A71KceVbZ5ieK
 lRAkbdYa1jiCuibwMcbZchd6Trl5nWrcIZmy6N3WOe5BrFL9nSF0+yoxmf1GY4uTI7t7Tkp0y+s
 KtX03iZ5G5db4p76wv5sO32SRlT1mdTRq3GW+eIH0L6Urcy9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since SME requires configuration of a vector length in order to know the
size of both the streaming mode SVE state and ZA array we implement a
capability for it and require that it be enabled and finalized before
the SME specific state can be accessed, similarly to SVE.

Due to the overlap with sizing the SVE state we finalise both SVE and
SME with a single finalization, preventing any further changes to the
SVE and SME configuration once KVM_ARM_VCPU_VEC (an alias for _VCPU_SVE)
has been finalised. This is not a thing of great elegance but it ensures
that we never have a state where one of SVE or SME is finalised and the
other not, avoiding complexity.

SME is supported for normal and protected guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h  |  12 +++-
 arch/arm64/include/uapi/asm/kvm.h  |   1 +
 arch/arm64/kvm/arm.c               |  10 ++++
 arch/arm64/kvm/hyp/nvhe/pkvm.c     |  76 +++++++++++++++++++-----
 arch/arm64/kvm/hyp/nvhe/sys_regs.c |   6 ++
 arch/arm64/kvm/reset.c             | 116 +++++++++++++++++++++++++++++++------
 include/uapi/linux/kvm.h           |   1 +
 7 files changed, 189 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 08004908575a..ff054b5fbc35 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -39,7 +39,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 9
+#define KVM_VCPU_MAX_FEATURES 10
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
 #define KVM_REQ_SLEEP \
@@ -81,6 +81,7 @@ extern unsigned int __ro_after_init kvm_host_max_vl[ARM64_VEC_MAX];
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 int __init kvm_arm_init_sve(void);
+int __init kvm_arm_init_sme(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
 void kvm_reset_vcpu(struct kvm_vcpu *vcpu);
@@ -1125,7 +1126,14 @@ struct kvm_vcpu_arch {
 	__size_ret;							\
 })
 
-#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.max_vl[ARM64_VEC_SVE])
+#define vcpu_sve_state_size(vcpu) ({					\
+	unsigned int __max_vl;						\
+									\
+	__max_vl = max((vcpu)->arch.max_vl[ARM64_VEC_SVE],		\
+		       (vcpu)->arch.max_vl[ARM64_VEC_SME]);		\
+									\
+	sve_state_size_from_vl(__max_vl);				\
+})
 
 #define vcpu_sme_state(vcpu) (kern_hyp_va((vcpu)->arch.sme_state))
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index cf75a830f17a..4fb0d7353d54 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -106,6 +106,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
 #define KVM_ARM_VCPU_HAS_EL2_E2H0	8 /* Limit NV support to E2H RES0 */
+#define KVM_ARM_VCPU_SME		9 /* enable SME for this CPU */
 
 /*
  * An alias for _SVE since we finalize VL configuration for both SVE and SME
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 38a91bb5d4c7..ebfbc1a0a92c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -392,6 +392,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SVE:
 		r = system_supports_sve();
 		break;
+	case KVM_CAP_ARM_SME:
+		r = system_supports_sme();
+		break;
 	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
 	case KVM_CAP_ARM_PTRAUTH_GENERIC:
 		r = kvm_has_full_ptr_auth();
@@ -1434,6 +1437,9 @@ static unsigned long system_supported_vcpu_features(void)
 	if (!system_supports_sve())
 		clear_bit(KVM_ARM_VCPU_SVE, &features);
 
+	if (!system_supports_sme())
+		clear_bit(KVM_ARM_VCPU_SME, &features);
+
 	if (!kvm_has_full_ptr_auth()) {
 		clear_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features);
 		clear_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features);
@@ -2837,6 +2843,10 @@ static __init int kvm_arm_init(void)
 	if (err)
 		return err;
 
+	err = kvm_arm_init_sme();
+	if (err)
+		return err;
+
 	err = kvm_arm_vmid_alloc_init();
 	if (err) {
 		kvm_err("Failed to initialize VMID allocator.\n");
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 65c49a5c7091..bee7abf95921 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -148,10 +148,6 @@ static int pkvm_check_pvm_cpu_features(struct kvm_vcpu *vcpu)
 	    !kvm_has_feat(kvm, ID_AA64PFR0_EL1, AdvSIMD, IMP))
 		return -EINVAL;
 
-	/* No SME support in KVM right now. Check to catch if it changes. */
-	if (kvm_has_feat(kvm, ID_AA64PFR1_EL1, SME, IMP))
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -362,6 +358,11 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
 		kvm->arch.flags |= host_arch_flags & BIT(KVM_ARCH_FLAG_GUEST_HAS_SVE);
 	}
 
+	if (kvm_pvm_ext_allowed(KVM_CAP_ARM_SME)) {
+		set_bit(KVM_ARM_VCPU_SME, allowed_features);
+		kvm->arch.flags |= host_arch_flags & BIT(KVM_ARCH_FLAG_GUEST_HAS_SME);
+	}
+
 	bitmap_and(kvm->arch.vcpu_features, host_kvm->arch.vcpu_features,
 		   allowed_features, KVM_VCPU_MAX_FEATURES);
 }
@@ -384,6 +385,18 @@ static void unpin_host_sve_state(struct pkvm_hyp_vcpu *hyp_vcpu)
 			     sve_state + vcpu_sve_state_size(&hyp_vcpu->vcpu));
 }
 
+static void unpin_host_sme_state(struct pkvm_hyp_vcpu *hyp_vcpu)
+{
+	void *sme_state;
+
+	if (!vcpu_has_feature(&hyp_vcpu->vcpu, KVM_ARM_VCPU_SME))
+		return;
+
+	sme_state = kern_hyp_va(hyp_vcpu->vcpu.arch.sme_state);
+	hyp_unpin_shared_mem(sme_state,
+			     sme_state + vcpu_sme_state_size(&hyp_vcpu->vcpu));
+}
+
 static void unpin_host_vcpus(struct pkvm_hyp_vcpu *hyp_vcpus[],
 			     unsigned int nr_vcpus)
 {
@@ -397,6 +410,7 @@ static void unpin_host_vcpus(struct pkvm_hyp_vcpu *hyp_vcpus[],
 
 		unpin_host_vcpu(hyp_vcpu->host_vcpu);
 		unpin_host_sve_state(hyp_vcpu);
+		unpin_host_sme_state(hyp_vcpu);
 	}
 }
 
@@ -411,23 +425,35 @@ static void init_pkvm_hyp_vm(struct kvm *host_kvm, struct pkvm_hyp_vm *hyp_vm,
 	pkvm_init_features_from_host(hyp_vm, host_kvm);
 }
 
-static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *host_vcpu)
+static int pkvm_vcpu_init_vec(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *host_vcpu)
 {
 	struct kvm_vcpu *vcpu = &hyp_vcpu->vcpu;
-	unsigned int sve_max_vl;
-	size_t sve_state_size;
-	void *sve_state;
+	unsigned int sve_max_vl, sme_max_vl;
+	size_t sve_state_size, sme_state_size;
+	void *sve_state, *sme_state;
 	int ret = 0;
 
-	if (!vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE)) {
+	if (!vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE) &&
+	    !vcpu_has_feature(vcpu, KVM_ARM_VCPU_SME)) {
 		vcpu_clear_flag(vcpu, VCPU_VEC_FINALIZED);
 		return 0;
 	}
 
 	/* Limit guest vector length to the maximum supported by the host. */
-	sve_max_vl = min(READ_ONCE(host_vcpu->arch.max_vl[ARM64_VEC_SVE]),
-			 kvm_host_max_vl[ARM64_VEC_SVE]);
-	sve_state_size = sve_state_size_from_vl(sve_max_vl);
+	if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
+		sve_max_vl = min(READ_ONCE(host_vcpu->arch.max_vl[ARM64_VEC_SVE]),
+				 kvm_host_max_vl[ARM64_VEC_SVE]);
+	else
+		sve_max_vl = 0;
+
+	if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SME))
+		sme_max_vl = min(READ_ONCE(host_vcpu->arch.max_vl[ARM64_VEC_SME]),
+				 kvm_host_max_vl[ARM64_VEC_SME]);
+	else
+		sme_max_vl = 0;
+
+	/* We need SVE storage for the larger of normal or streaming mode */
+	sve_state_size = sve_state_size_from_vl(max(sve_max_vl, sme_max_vl));
 	sve_state = kern_hyp_va(READ_ONCE(host_vcpu->arch.sve_state));
 
 	if (!sve_state || !sve_state_size) {
@@ -439,12 +465,36 @@ static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *h
 	if (ret)
 		goto err;
 
+	if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SME)) {
+		sme_state_size = sme_state_size_from_vl(sme_max_vl,
+							vcpu_has_sme2(vcpu));
+		sme_state = kern_hyp_va(READ_ONCE(host_vcpu->arch.sme_state));
+
+		if (!sme_state || !sme_state_size) {
+			ret = -EINVAL;
+			goto err_sve_mapped;
+		}
+
+		ret = hyp_pin_shared_mem(sme_state, sme_state + sme_state_size);
+		if (ret)
+			goto err_sve_mapped;
+	} else {
+		sme_state = 0;
+	}
+
 	vcpu->arch.sve_state = sve_state;
 	vcpu->arch.max_vl[ARM64_VEC_SVE] = sve_max_vl;
 
+	vcpu->arch.sme_state = sme_state;
+	vcpu->arch.max_vl[ARM64_VEC_SME] = sme_max_vl;
+
 	return 0;
+
+err_sve_mapped:
+	hyp_unpin_shared_mem(sve_state, sve_state + sve_state_size);
 err:
 	clear_bit(KVM_ARM_VCPU_SVE, vcpu->kvm->arch.vcpu_features);
+	clear_bit(KVM_ARM_VCPU_SME, vcpu->kvm->arch.vcpu_features);
 	return ret;
 }
 
@@ -474,7 +524,7 @@ static int init_pkvm_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu,
 	if (ret)
 		goto done;
 
-	ret = pkvm_vcpu_init_sve(hyp_vcpu, host_vcpu);
+	ret = pkvm_vcpu_init_vec(hyp_vcpu, host_vcpu);
 done:
 	if (ret)
 		unpin_host_vcpu(host_vcpu);
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 1ddd9ed3cbb3..eed177dfcb96 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -66,6 +66,11 @@ static bool vm_has_ptrauth(const struct kvm *kvm)
 		kvm_vcpu_has_feature(kvm, KVM_ARM_VCPU_PTRAUTH_GENERIC);
 }
 
+static bool vm_has_sme(const struct kvm *kvm)
+{
+	return system_supports_sme() && kvm_vcpu_has_feature(kvm, KVM_ARM_VCPU_SME);
+}
+
 static bool vm_has_sve(const struct kvm *kvm)
 {
 	return system_supports_sve() && kvm_vcpu_has_feature(kvm, KVM_ARM_VCPU_SVE);
@@ -102,6 +107,7 @@ static const struct pvm_ftr_bits pvmid_aa64pfr0[] = {
 };
 
 static const struct pvm_ftr_bits pvmid_aa64pfr1[] = {
+	MAX_FEAT_FUNC(ID_AA64PFR1_EL1, SME, SME2, vm_has_sme),
 	MAX_FEAT(ID_AA64PFR1_EL1, BT, IMP),
 	MAX_FEAT(ID_AA64PFR1_EL1, SSBS, SSBS2),
 	MAX_FEAT_ENUM(ID_AA64PFR1_EL1, MTE_frac, NI),
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index a8684a1346ec..e6dc04267cbb 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -76,6 +76,34 @@ int __init kvm_arm_init_sve(void)
 	return 0;
 }
 
+int __init kvm_arm_init_sme(void)
+{
+	if (system_supports_sme()) {
+		kvm_max_vl[ARM64_VEC_SME] = sme_max_virtualisable_vl();
+		kvm_host_max_vl[ARM64_VEC_SME] = sme_max_vl();
+		kvm_nvhe_sym(kvm_host_max_vl[ARM64_VEC_SME]) = kvm_host_max_vl[ARM64_VEC_SME];
+
+		/*
+		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
+		 * to be extended with multiple register slice support in
+		 * order to support vector lengths greater than
+		 * VL_ARCH_MAX:
+		 */
+		if (WARN_ON(kvm_max_vl[ARM64_VEC_SME] > VL_ARCH_MAX))
+			kvm_max_vl[ARM64_VEC_SME] = VL_ARCH_MAX;
+
+		/*
+		 * Don't even try to make use of vector lengths that
+		 * aren't available on all CPUs, for now:
+		 */
+		if (kvm_max_vl[ARM64_VEC_SME] < sme_max_vl())
+			pr_warn("KVM: SME vector length for guests limited to %u bytes\n",
+				kvm_max_vl[ARM64_VEC_SME]);
+	}
+
+	return 0;
+}
+
 static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.max_vl[ARM64_VEC_SVE] = kvm_max_vl[ARM64_VEC_SVE];
@@ -88,42 +116,86 @@ static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
 	set_bit(KVM_ARCH_FLAG_GUEST_HAS_SVE, &vcpu->kvm->arch.flags);
 }
 
+static void kvm_vcpu_enable_sme(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.max_vl[ARM64_VEC_SME] = kvm_max_vl[ARM64_VEC_SME];
+
+	/*
+	 * Userspace can still customize the vector lengths by writing
+	 * KVM_REG_ARM64_SME_VLS.  Allocation is deferred until
+	 * kvm_arm_vcpu_finalize(), which freezes the configuration.
+	 */
+	set_bit(KVM_ARCH_FLAG_GUEST_HAS_SME, &vcpu->kvm->arch.flags);
+}
+
 /*
- * Finalize vcpu's maximum SVE vector length, allocating
- * vcpu->arch.sve_state as necessary.
+ * Finalize vcpu's maximum vector lengths, allocating
+ * vcpu->arch.sve_state and vcpu->arch.sme_state as necessary.
  */
 static int kvm_vcpu_finalize_vec(struct kvm_vcpu *vcpu)
 {
-	void *buf;
+	void *sve_state, *sme_state;
 	unsigned int vl;
-	size_t reg_sz;
 	int ret;
 
-	vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
-
 	/*
 	 * Responsibility for these properties is shared between
 	 * kvm_arm_init_sve(), kvm_vcpu_enable_sve() and
 	 * set_sve_vls().  Double-check here just to be sure:
 	 */
-	if (WARN_ON(!sve_vl_valid(vl) || vl > sve_max_virtualisable_vl() ||
-		    vl > VL_ARCH_MAX))
-		return -EIO;
+	if (vcpu_has_sve(vcpu)) {
+		vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
+		if (WARN_ON(!sve_vl_valid(vl) ||
+			    vl > sve_max_virtualisable_vl() ||
+			    vl > VL_ARCH_MAX))
+			return -EIO;
+	}
 
-	reg_sz = vcpu_sve_state_size(vcpu);
-	buf = kzalloc(reg_sz, GFP_KERNEL_ACCOUNT);
-	if (!buf)
+	/* Similarly for SME */
+	if (vcpu_has_sme(vcpu)) {
+		vl = vcpu->arch.max_vl[ARM64_VEC_SME];
+		if (WARN_ON(!sve_vl_valid(vl) ||
+			    vl > sme_max_virtualisable_vl() ||
+			    vl > VL_ARCH_MAX))
+			return -EIO;
+	}
+
+	sve_state = kzalloc(vcpu_sve_state_size(vcpu), GFP_KERNEL_ACCOUNT);
+	if (!sve_state)
 		return -ENOMEM;
 
-	ret = kvm_share_hyp(buf, buf + reg_sz);
-	if (ret) {
-		kfree(buf);
-		return ret;
+	ret = kvm_share_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
+	if (ret)
+		goto err_sve_alloc;
+
+	if (vcpu_has_sme(vcpu)) {
+		sme_state = kzalloc(vcpu_sme_state_size(vcpu),
+				    GFP_KERNEL_ACCOUNT);
+		if (!sme_state) {
+			ret = -ENOMEM;
+			goto err_sve_map;
+		}
+
+		ret = kvm_share_hyp(sme_state,
+				    sme_state + vcpu_sme_state_size(vcpu));
+		if (ret)
+			goto err_sme_alloc;
+	} else {
+		sme_state = NULL;
 	}
-	
-	vcpu->arch.sve_state = buf;
+
+	vcpu->arch.sve_state = sve_state;
+	vcpu->arch.sme_state = sme_state;
 	vcpu_set_flag(vcpu, VCPU_VEC_FINALIZED);
 	return 0;
+
+err_sme_alloc:
+	kfree(sme_state);
+err_sve_map:
+	kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
+err_sve_alloc:
+	kfree(sve_state);
+	return ret;
 }
 
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
@@ -153,12 +225,16 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	void *sve_state = vcpu->arch.sve_state;
+	void *sme_state = vcpu->arch.sme_state;
 
 	kvm_unshare_hyp(vcpu, vcpu + 1);
 	if (sve_state)
 		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
 	kfree(sve_state);
 	free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
+	if (sme_state)
+		kvm_unshare_hyp(sme_state, sme_state + vcpu_sme_state_size(vcpu));
+	kfree(sme_state);
 	kfree(vcpu->arch.vncr_tlb);
 	kfree(vcpu->arch.ccsidr);
 }
@@ -167,6 +243,8 @@ static void kvm_vcpu_reset_vec(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_has_sve(vcpu))
 		memset(vcpu->arch.sve_state, 0, vcpu_sve_state_size(vcpu));
+	if (vcpu_has_sme(vcpu))
+		memset(vcpu->arch.sme_state, 0, vcpu_sme_state_size(vcpu));
 }
 
 /**
@@ -206,6 +284,8 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_arm_vcpu_vec_finalized(vcpu)) {
 		if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
 			kvm_vcpu_enable_sve(vcpu);
+		if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SME))
+			kvm_vcpu_enable_sme(vcpu);
 	} else {
 		kvm_vcpu_reset_vec(vcpu);
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 37891580d05d..931dbe1f3c9b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -956,6 +956,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
+#define KVM_CAP_ARM_SME 243
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;

-- 
2.39.5


