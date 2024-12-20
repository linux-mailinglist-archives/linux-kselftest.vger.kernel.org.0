Return-Path: <linux-kselftest+bounces-23692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 964D49F9769
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FEF189A1FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4471622A812;
	Fri, 20 Dec 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsoLx8Sm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BF22A80D;
	Fri, 20 Dec 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713552; cv=none; b=Qj6lPl8xhPrMXS4FMRvLjKqwDWo3INWrLQt5EeV3rXhkRg7I+FLURvq7sxys2rVtg6xl6AYjIXbnI3JRqEuVFy/2fr1vDRelttkNx1wESzHKtSe958XZJwWxi8PPyW8SAeyMYyfO2M/JrsowS8WAuDhBsbnKpi+3bY3H8N7ckYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713552; c=relaxed/simple;
	bh=/CEgAI+Ra5jr/FzEmZ6S+G/3G+R1dOJRvC2cjEojBkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iq4e7fYOBqp3IX0n5+aW0cHayvQEwOXt/mJ0dS04QUbuACBKwY6Coizusp01P91PXR1XY0lkFSx2gyUiAtrmRj1c7hgub0YZ6mmWDdutzkjFPHH5P3OVoIETkdkHk8xWseGIq3YYVZHErf3BmDcY8DbkU8h/kw/HAvJGuF8w2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsoLx8Sm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69515C4CED7;
	Fri, 20 Dec 2024 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713551;
	bh=/CEgAI+Ra5jr/FzEmZ6S+G/3G+R1dOJRvC2cjEojBkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TsoLx8SmQO4xtYjm/mfDGy7tyEp/3160l4cVOp6huvslgMBB0aC4lI40reWDI53xy
	 frhM6dwXsdKw1BBiZb+EMQorYkhFoSKqO7XriL2qHl9f3nrrFhuvFYWGORcz7P9iM9
	 NQaTvG0atYMDkVMtOwY3j6fJHXSDNZOS7bWDyl1M0h5aAK7zGlQILmqbkK130U5NSh
	 MwnmJWUYoCWsaHOZ+b8/dHZk+yZQEAiIrJHX9u8uMWsdEDiUyjgRPwLwxMyweKCb89
	 hLORJ4q8nsnvAJkfwIyEnTdAh8WkP10qC09m93YKjxQ1AZf6+MoOsYuQU15JQnpv77
	 nPScbn4GLT6wA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:50 +0000
Subject: [PATCH RFC v3 25/27] KVM: arm64: Provide interface for configuring
 and enabling SME for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-25-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9252; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/CEgAI+Ra5jr/FzEmZ6S+G/3G+R1dOJRvC2cjEojBkk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBnI3UPpUtSalk6C7gc4wxNtDJW/JWiZD5SE/+W
 uOfU9RuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgZwAKCRAk1otyXVSH0EvvB/
 0WwiHINr9p1O74GhSy8y7OBflr2zca+6b12KdDCtVljhdhMBoONMxeqFvWZ82tODmp0zXjU9TPXjp9
 XGQDwJ+4TQ5DbOcW9r5psC/T9uHHCu5hm2Qp5XicbNUlbPncBTRMvsYaoSl7FGC0tJ7sKPFcILIcMm
 JsI7QzLuG9P4xFdZpyL1AvVlVCyv2HrevZX2pOutzFHfYTIy7++FXexd/RQw4Xs/tSTt9n2+jSz6iB
 0IW5WBbdbKXwOYFMZEIp+fGoLZiOLQgr6y8eDDB+of0BykST1U9vmZHG2IPrew9OIGf2pq4+spqSTo
 2rsB2HJJeBZdxzHKYGL8aTIi6MJHDt
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/include/uapi/asm/kvm.h |   1 +
 arch/arm64/kvm/arm.c              |  10 ++++
 arch/arm64/kvm/reset.c            | 114 ++++++++++++++++++++++++++++++++------
 include/uapi/linux/kvm.h          |   1 +
 5 files changed, 109 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4fcb2c2603ae2bc51d6993f1f6a3f81f2689717c..838f7ad8ec14b7549ebdfe11e991f664894cc4e7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -79,6 +79,7 @@ extern unsigned int __ro_after_init kvm_host_max_vl[ARM64_VEC_MAX];
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 int __init kvm_arm_init_sve(void);
+int __init kvm_arm_init_sme(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
 void kvm_reset_vcpu(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 5092f39138cbf17d9e89191de23ab2ee9f3fa77d..4110ff85623b6fe354038b2dffd59a27d0d6d75b 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -108,6 +108,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
+#define KVM_ARM_VCPU_SME		8 /* enable SME for this CPU */
 
 /*
  * An alias for _SVE since we finalize VL configuration for both SVE and SME
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8a3d02cf0a7a28e6d2a2fe2b6d63a9dbbe2d4916..c8f44e2c54b613b53087c581176315bc3f4bb2c8 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -377,6 +377,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SVE:
 		r = system_supports_sve();
 		break;
+	case KVM_CAP_ARM_SME:
+		r = system_supports_sme();
+		break;
 	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
 	case KVM_CAP_ARM_PTRAUTH_GENERIC:
 		r = kvm_has_full_ptr_auth();
@@ -1378,6 +1381,9 @@ static unsigned long system_supported_vcpu_features(void)
 	if (!system_supports_sve())
 		clear_bit(KVM_ARM_VCPU_SVE, &features);
 
+	if (!system_supports_sme())
+		clear_bit(KVM_ARM_VCPU_SME, &features);
+
 	if (!kvm_has_full_ptr_auth()) {
 		clear_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features);
 		clear_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features);
@@ -2756,6 +2762,10 @@ static __init int kvm_arm_init(void)
 	if (err)
 		return err;
 
+	err = kvm_arm_init_sme();
+	if (err)
+		return err;
+
 	err = kvm_arm_vmid_alloc_init();
 	if (err) {
 		kvm_err("Failed to initialize VMID allocator.\n");
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 3cb91dc6dc3dc5cc484900dbd9f4cdfedb3e2b4a..78b5aa7976dbbfec35d83f5e373ef87636c2e3e4 100644
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
@@ -88,42 +116,84 @@ static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
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
+			goto err_sve_map;
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
+err_sve_map:
+	kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
+err_sve_alloc:
+	kfree(sve_state);
+	return ret;
 }
 
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
@@ -153,11 +223,15 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	void *sve_state = vcpu->arch.sve_state;
+	void *sme_state = vcpu->arch.sme_state;
 
 	kvm_unshare_hyp(vcpu, vcpu + 1);
 	if (sve_state)
 		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
 	kfree(sve_state);
+	if (sme_state)
+		kvm_unshare_hyp(sme_state, sme_state + vcpu_sme_state_size(vcpu));
+	kfree(sme_state);
 	kfree(vcpu->arch.ccsidr);
 }
 
@@ -165,6 +239,8 @@ static void kvm_vcpu_reset_vec(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_has_sve(vcpu))
 		memset(vcpu->arch.sve_state, 0, vcpu_sve_state_size(vcpu));
+	if (vcpu_has_sme(vcpu))
+		memset(vcpu->arch.sme_state, 0, vcpu_sme_state_size(vcpu));
 }
 
 /**
@@ -207,6 +283,8 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_arm_vcpu_vec_finalized(vcpu)) {
 		if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
 			kvm_vcpu_enable_sve(vcpu);
+		if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SME))
+			kvm_vcpu_enable_sme(vcpu);
 	} else {
 		kvm_vcpu_reset_vec(vcpu);
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 502ea63b5d2e7371f3f0d8cb5b9757ff693ee363..e478d9e5e8bff3beeddd39043a62337e0b9d688d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -933,6 +933,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PRE_FAULT_MEMORY 236
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
+#define KVM_CAP_ARM_SME 239
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;

-- 
2.39.5


