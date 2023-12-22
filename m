Return-Path: <linux-kselftest+bounces-2398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6923E81CD04
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3AA1F2365E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7318428E1C;
	Fri, 22 Dec 2023 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gskeE6YI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991339FD1;
	Fri, 22 Dec 2023 16:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A37AC433C9;
	Fri, 22 Dec 2023 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262171;
	bh=+GfmxLxglrVq9nbHW9BMkdaa9a2EFJQTra/fS24uE5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gskeE6YI/DJijWV9O/31+bnbts8fxV/0CNdsjQk/fdtrrwoGT2Yw1jrvl3dM9Tm/8
	 eeJq1VmQReycRJQ9PMXk/SBMArWZmFMIy8Nvs6mNjnx88z16hNFDA4qDj39cmeffu8
	 HH5WlZUazUeKHmEaP8GsqZ1Dl4OiMtpz9fk8gxAq1dknjfT0L6FQio8SHOMNkNly1b
	 8KaDvAFwDU+Br0jv94cxQbhhzaZ0MPxfSifbb+hLloxsOtxluEv05Bh/3tl1GlpLcV
	 mLrtOGICVeCcgtJyrCJk7WYYl4wWnXzZtZhKIw3c5chGfx4RI8fARZT5phH6iPhJJs
	 w7jKT3JIjk/ug==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:29 +0000
Subject: [PATCH RFC v2 21/22] KVM: arm64: Provide userspace ABI for
 enabling SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-21-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=10571; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+GfmxLxglrVq9nbHW9BMkdaa9a2EFJQTra/fS24uE5o=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtTW7T26C/6Y+H9LWnwiKS9UZaPoASG3mkVl/BznWaOqP8zc
 vlWkk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYSEsW+x9ue/lpDZpyYkFXRIWYDg
 Vlmx5Ou2soeD1tpUIF89G4VSXCt487O+putL3TtfB66HkW0YLWc2yqtt8eP4l868rG8b493sOJl+/N
 L0+DQyxzz6impd7t1WDc/W/7Oqcuq1cnJ6RufX6kM2SDtEzgJNUZFvq/HH292spqi286/A92uMaS/2
 AW5+RDBxuzY1Q8J8m2v3xzu+9yEJd0+QWW2GlvT3290hawxb1Socztprns35uMRU5xUXKcYlu2KCbW
 Xk6dwSe291bmP+s3nz36vO6pXLynwLKdM5p74oYLS+dopnRk9eseeZ5mI76z88GL/GmrmjI+OrU4su
 8obP1bn2fazexebXaM7TgLc9sWAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Now that everything else is in place allow userspace to enable SME with a
vCPU flag KVM_ARM_VCPU_SME similar to that for SVE, finalized with the
same KVM_ARM_VCPU_VEC/SVE flag used for SVE.

As with SVE when when SME feature is enabled we default the vector
length to the highest vector length that can be exposed to guests
without them being able to observe inconsistencies between the set of
supported vector lengths on processors, discovering this during host SME
enumeration.

When the vectors are finalised we allocate state for both SVE and SME.

Currently SME2 and FA64 are enabled for the guest if supported by the
host, once it is clear how we intend to handle parsing features from ID
registers these features should be handled based on the configured ID
registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |   3 +-
 arch/arm64/include/uapi/asm/kvm.h |   1 +
 arch/arm64/kernel/fpsimd.c        |  28 +++++++++
 arch/arm64/kvm/arm.c              |   7 +++
 arch/arm64/kvm/reset.c            | 120 +++++++++++++++++++++++++++++++++-----
 include/uapi/linux/kvm.h          |   1 +
 6 files changed, 145 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6a5002ab8042..c054aee8160a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -38,7 +38,7 @@
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
-#define KVM_VCPU_MAX_FEATURES 7
+#define KVM_VCPU_MAX_FEATURES 8
 #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
 
 #define KVM_REQ_SLEEP \
@@ -76,6 +76,7 @@ DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 extern unsigned int __ro_after_init kvm_vec_max_vl[ARM64_VEC_MAX];
 int __init kvm_arm_init_sve(void);
+int __init kvm_arm_init_sme(void);
 
 u32 __attribute_const__ kvm_target_cpu(void);
 void kvm_reset_vcpu(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 58640aeb88e4..0f5e678c3ef3 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -110,6 +110,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
+#define KVM_ARM_VCPU_SME		8 /* enable SME for this CPU */
 
 /*
  * An alias for _SVE since we finalize VL configuration for both SVE and SME
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e6a4dd68f62a..05e806a580f0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1307,6 +1307,8 @@ void __init sme_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SME];
 	int min_bit, max_bit;
+	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
+	unsigned long b;
 
 	if (!cpus_have_cap(ARM64_SME))
 		return;
@@ -1342,6 +1344,32 @@ void __init sme_setup(void)
 		info->max_vl);
 	pr_info("SME: default vector length %u bytes per vector\n",
 		get_sme_default_vl());
+
+	/*
+	 * KVM can't cope with any mismatch in supported VLs between
+	 * CPUs, detect any inconsistencies.  Unlike SVE it is
+	 * architecturally possible to end up with no VLs.
+	 */
+	bitmap_andnot(tmp_map, info->vq_partial_map, info->vq_map,
+		      SVE_VQ_MAX);
+
+	b = find_last_bit(tmp_map, SVE_VQ_MAX);
+	if (b >= SVE_VQ_MAX)
+		/* No non-virtualisable VLs found */
+		info->max_virtualisable_vl = SVE_VQ_MAX;
+	else if (WARN_ON(b == SVE_VQ_MAX - 1))
+		/* No virtualisable VLs?  Architecturally possible... */
+		info->max_virtualisable_vl = 0;
+	else /* b + 1 < SVE_VQ_MAX */
+		info->max_virtualisable_vl = sve_vl_from_vq(__bit_to_vq(b + 1));
+
+	if (info->max_virtualisable_vl > info->max_vl)
+		info->max_virtualisable_vl = info->max_vl;
+
+	/* KVM decides whether to support mismatched systems. Just warn here: */
+	if (sve_max_virtualisable_vl() < sve_max_vl())
+		pr_warn("%s: unvirtualisable vector lengths present\n",
+			info->name);
 }
 
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index aa7e2031263c..baa4a8074aaf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -305,6 +305,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SVE:
 		r = system_supports_sve();
 		break;
+	case KVM_CAP_ARM_SME:
+		r = system_supports_sme();
+		break;
 	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
 	case KVM_CAP_ARM_PTRAUTH_GENERIC:
 		r = system_has_full_ptr_auth();
@@ -2559,6 +2562,10 @@ static __init int kvm_arm_init(void)
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
index ab7cd657a73c..56fc91cd8567 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -85,42 +85,125 @@ static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
 	vcpu_set_flag(vcpu, GUEST_HAS_SVE);
 }
 
+int __init kvm_arm_init_sme(void)
+{
+	if (system_supports_sme()) {
+		kvm_vec_max_vl[ARM64_VEC_SME] = sme_max_virtualisable_vl();
+
+		/*
+		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
+		 * to be extended with multiple register slice support in
+		 * order to support vector lengths greater than
+		 * VL_ARCH_MAX:
+		 */
+		if (WARN_ON(kvm_vec_max_vl[ARM64_VEC_SME] > VL_ARCH_MAX))
+			kvm_vec_max_vl[ARM64_VEC_SME] = VL_ARCH_MAX;
+
+		/*
+		 * Don't even try to make use of vector lengths that
+		 * aren't available on all CPUs, for now:
+		 */
+		if (kvm_vec_max_vl[ARM64_VEC_SME] < sme_max_vl())
+			pr_warn("KVM: SME vector length for guests limited to %u bytes\n",
+				kvm_vec_max_vl[ARM64_VEC_SME]);
+	}
+
+	return 0;
+}
+
+static int kvm_vcpu_enable_sme(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.max_vl[ARM64_VEC_SME] = kvm_vec_max_vl[ARM64_VEC_SME];
+
+	/*
+	 * Userspace can still customize the vector lengths by writing
+	 * KVM_REG_ARM64_SME_VLS.  Allocation is deferred until
+	 * kvm_arm_vcpu_finalize(), which freezes the configuration.
+	 */
+	vcpu_set_flag(vcpu, GUEST_HAS_SME);
+
+	return 0;
+}
+
+
 /*
- * Finalize vcpu's maximum SVE vector length, allocating
- * vcpu->arch.sve_state as necessary.
+ * Finalize vcpu's maximum SVE/SME vector lengths, allocating
+ * vcpu->arch.sve_state and vcpu->arch.sme_state as necessary.
  */
 static int kvm_vcpu_finalize_vec(struct kvm_vcpu *vcpu)
 {
-	void *buf;
 	unsigned int vl;
-	size_t reg_sz;
+	void *sve_buf, *sme_buf;
+	size_t sve_sz, sme_sz;
 	int ret;
 
-	vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
+	/* Both SVE and SME need the SVE state */
 
-	/*
+        /*
 	 * Responsibility for these properties is shared between
 	 * kvm_arm_init_sve(), kvm_vcpu_enable_sve() and
 	 * set_sve_vls().  Double-check here just to be sure:
 	 */
+	vl = vcpu->arch.max_vl[ARM64_VEC_SVE];
 	if (WARN_ON(!sve_vl_valid(vl) || vl > sve_max_virtualisable_vl() ||
 		    vl > VL_ARCH_MAX))
 		return -EIO;
 
-	reg_sz = vcpu_sve_state_size(vcpu);
-	buf = kzalloc(reg_sz, GFP_KERNEL_ACCOUNT);
-	if (!buf)
+	sve_sz = vcpu_sve_state_size(vcpu);
+	sve_buf = kzalloc(sve_sz, GFP_KERNEL_ACCOUNT);
+	if (!sve_buf)
 		return -ENOMEM;
 
-	ret = kvm_share_hyp(buf, buf + reg_sz);
+	ret = kvm_share_hyp(sve_buf, sve_buf + sve_sz);
 	if (ret) {
-		kfree(buf);
+		kfree(sve_buf);
 		return ret;
 	}
+
+	if (vcpu_has_sme(vcpu)) {
+		vl = vcpu->arch.max_vl[ARM64_VEC_SME];
+		if (WARN_ON(!sve_vl_valid(vl) ||
+			    vl > sme_max_virtualisable_vl() ||
+			    vl > VL_ARCH_MAX)) {
+			ret = -EIO;
+			goto free_sve;
+		}
+
+		sme_sz = vcpu_sme_state_size(vcpu);
+		sme_buf = kzalloc(sme_sz, GFP_KERNEL_ACCOUNT);
+		if (!sme_buf) {
+			ret = -ENOMEM;
+			goto free_sve;
+		}
+
+		ret = kvm_share_hyp(sme_buf, sme_buf + sme_sz);
+		if (ret) {
+			kfree(sme_buf);
+			goto free_sve;
+		}
+
+		vcpu->arch.sme_state = sme_buf;
+
+		/*
+		 * These are expected to be parsed from ID registers
+		 * once the general approach to doing that is worked
+		 * out.
+		 */
+		if (system_supports_sme2())
+			vcpu_set_flag(vcpu, GUEST_HAS_SME2);
+		if (system_supports_fa64())
+			vcpu_set_flag(vcpu, GUEST_HAS_FA64);
+	}
 	
-	vcpu->arch.sve_state = buf;
+	vcpu->arch.sve_state = sve_buf;
+
 	vcpu_set_flag(vcpu, VCPU_VEC_FINALIZED);
 	return 0;
+
+free_sve:
+	kvm_unshare_hyp(sve_buf, sve_buf + sve_sz);
+	kfree(sve_buf);
+	return ret;
 }
 
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
@@ -150,19 +233,25 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	void *sve_state = vcpu->arch.sve_state;
+	void *sme_state = vcpu->arch.sme_state;
 
 	kvm_vcpu_unshare_task_fp(vcpu);
 	kvm_unshare_hyp(vcpu, vcpu + 1);
 	if (sve_state)
 		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
 	kfree(sve_state);
+	if (sme_state)
+		kvm_unshare_hyp(sme_state, sme_state + vcpu_sme_state_size(vcpu));
+	kfree(sme_state);
 	kfree(vcpu->arch.ccsidr);
 }
 
-static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
+static void kvm_vcpu_reset_vec(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_has_sve(vcpu))
 		memset(vcpu->arch.sve_state, 0, vcpu_sve_state_size(vcpu));
+	if (vcpu_has_sme(vcpu))
+		memset(vcpu->arch.sme_state, 0, vcpu_sme_state_size(vcpu));
 }
 
 static void kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)
@@ -210,8 +299,11 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	if (!kvm_arm_vcpu_vec_finalized(vcpu)) {
 		if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
 			kvm_vcpu_enable_sve(vcpu);
+
+		if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_SME))
+			kvm_vcpu_enable_sme(vcpu);
 	} else {
-		kvm_vcpu_reset_sve(vcpu);
+		kvm_vcpu_reset_vec(vcpu);
 	}
 
 	if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_PTRAUTH_ADDRESS) ||
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 211b86de35ac..42484c0a9051 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1201,6 +1201,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
+#define KVM_CAP_ARM_SME 231
 
 #ifdef KVM_CAP_IRQ_ROUTING
 

-- 
2.30.2


