Return-Path: <linux-kselftest+bounces-2392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49C81CCEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E3F1F21481
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD0128DC1;
	Fri, 22 Dec 2023 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMtRe78H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAF3173B;
	Fri, 22 Dec 2023 16:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB8BC433CA;
	Fri, 22 Dec 2023 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262150;
	bh=YQIDwvfjgnZ7hWTCfJLJLcgZ7qQYpeLDqWfDLqs47UU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JMtRe78H9tp00G+FjVMkG1AUu5XzsZ9CXt2ZNFKtX687tHGhnRyWh4pepNGGCdeyH
	 BSGBm7hAbNYyGKsY7GPC8HJw+3oCmGW9WeQdrBDm/V2bssPCcYRtV3HYXDa5BeWmR5
	 UUPw3kbchiMqT5GVTztpHDB4afnESkvDC+WScCqWcibC+PAaNg6suAyTEBHN2Z1BwH
	 9tI+gwi3oGXUwAtgtuZ5rQ3Ty5fd9087BhtDPUljgizLd/t96sWHMUNlZE5hvsWhYi
	 p6Ul6Xe1DfE/zAJ1JvlAEkrvPFMSnqc0qb5D8ynxrQznyT0HIYX/kYuE/koP2GL7dy
	 DJDTNnA+glV/w==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:23 +0000
Subject: [PATCH RFC v2 15/22] KVM: arm64: Implement SME vector length
 configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-15-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7078; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YQIDwvfjgnZ7hWTCfJLJLcgZ7qQYpeLDqWfDLqs47UU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeHhekzBzBrzADLpx68QzDmCL0z9eAMJu0gdehj
 itynXneJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3hwAKCRAk1otyXVSH0N8oB/
 40IOYnM1YoBevEfgjlDGucSQek33P4YDqp6RxW0Ks/IN0w/OdDgQ+hYvLRQf4mBaJXEyHp0hvfLVAh
 U560GvJgw9spRz7TZZJ8DbnHQY4UDQ0AbG0n8UduBiT5I8YqePyhjMQtGN7wZaf5RhTyXm7Goe1XIC
 Le6PKLMLcvoiOxS3rFkbqziIJNkyjf5E0+13MucOQ9FY1JSx07GqLLwVvbfymIdb0KAK7Orl7zaNdV
 Y5JQUfFl4T05sQ24GcMkQU/Duhst2cEMSPv1Qx+1N75sdwD7Ybe90yr26wXeA0wh1YzHa8zK5UD/Xl
 f7Pk82Zbt+glRn0t/k8CWGgUYrTiG8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Configuration for SME vector lengths is done using a virtual register as
for SVE, hook up the implementation for the virtual register.  Since we
do not yet have support for any of the new SME registers stub register
access functions are provided.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/kvm.h |  9 ++++
 arch/arm64/kvm/guest.c            | 94 +++++++++++++++++++++++++++++++--------
 2 files changed, 84 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 3048890fac68..02642bb96496 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -353,6 +353,15 @@ struct kvm_arm_counter_offset {
 #define KVM_ARM64_SVE_VLS_WORDS	\
 	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
 
+/* SME registers */
+#define KVM_REG_ARM64_SME		(0x17 << KVM_REG_ARM_COPROC_SHIFT)
+
+/* Vector lengths pseudo-register: */
+#define KVM_REG_ARM64_SME_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SME | \
+					 KVM_REG_SIZE_U512 | 0xffff)
+#define KVM_ARM64_SME_VLS_WORDS	\
+	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
+
 /* Bitmap feature firmware registers */
 #define KVM_REG_ARM_FW_FEAT_BMAP		(0x0016 << KVM_REG_ARM_COPROC_SHIFT)
 #define KVM_REG_ARM_FW_FEAT_BMAP_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 6e116fd8a917..30446ae357f0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -309,22 +309,20 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
 #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
 
-static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+static int get_vec_vls(enum vec_type vec_type, struct kvm_vcpu *vcpu,
+		      const struct kvm_one_reg *reg)
 {
 	unsigned int max_vq, vq;
 	u64 vqs[KVM_ARM64_SVE_VLS_WORDS];
 
-	if (!vcpu_has_sve(vcpu))
-		return -ENOENT;
-
-	if (WARN_ON(!sve_vl_valid(vcpu->arch.max_vl[ARM64_VEC_SVE])))
+	if (WARN_ON(!sve_vl_valid(vcpu->arch.max_vl[vec_type])))
 		return -EINVAL;
 
 	memset(vqs, 0, sizeof(vqs));
 
-	max_vq = vcpu_sve_max_vq(vcpu);
+	max_vq = vcpu_vec_max_vq(vec_type, vcpu);
 	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
-		if (sve_vq_available(vq))
+		if (vq_available(vec_type, vq))
 			vqs[vq_word(vq)] |= vq_mask(vq);
 
 	if (copy_to_user((void __user *)reg->addr, vqs, sizeof(vqs)))
@@ -333,18 +331,13 @@ static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return 0;
 }
 
-static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+static int set_vec_vls(enum vec_type vec_type, struct kvm_vcpu *vcpu,
+		       const struct kvm_one_reg *reg)
 {
 	unsigned int max_vq, vq;
 	u64 vqs[KVM_ARM64_SVE_VLS_WORDS];
 
-	if (!vcpu_has_sve(vcpu))
-		return -ENOENT;
-
-	if (kvm_arm_vcpu_vec_finalized(vcpu))
-		return -EPERM; /* too late! */
-
-	if (WARN_ON(vcpu->arch.sve_state))
+	if (WARN_ON(!sve_vl_valid(vcpu->arch.max_vl[vec_type])))
 		return -EINVAL;
 
 	if (copy_from_user(vqs, (const void __user *)reg->addr, sizeof(vqs)))
@@ -355,18 +348,18 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		if (vq_present(vqs, vq))
 			max_vq = vq;
 
-	if (max_vq > sve_vq_from_vl(kvm_vec_max_vl[ARM64_VEC_SVE]))
+	if (max_vq > sve_vq_from_vl(kvm_vec_max_vl[vec_type]))
 		return -EINVAL;
 
 	/*
 	 * Vector lengths supported by the host can't currently be
 	 * hidden from the guest individually: instead we can only set a
-	 * maximum via ZCR_EL2.LEN.  So, make sure the available vector
+	 * maximum via xCR_EL2.LEN.  So, make sure the available vector
 	 * lengths match the set requested exactly up to the requested
 	 * maximum:
 	 */
 	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
-		if (vq_present(vqs, vq) != sve_vq_available(vq))
+		if (vq_present(vqs, vq) != vq_available(vec_type, vq))
 			return -EINVAL;
 
 	/* Can't run with no vector lengths at all: */
@@ -374,11 +367,33 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return -EINVAL;
 
 	/* vcpu->arch.sve_state will be alloc'd by kvm_vcpu_finalize_sve() */
-	vcpu->arch.max_vl[ARM64_VEC_SVE] = sve_vl_from_vq(max_vq);
+	vcpu->arch.max_vl[vec_type] = sve_vl_from_vq(max_vq);
 
 	return 0;
 }
 
+static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	return get_vec_vls(ARM64_VEC_SVE, vcpu, reg);
+}
+
+static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	if (kvm_arm_vcpu_vec_finalized(vcpu))
+		return -EPERM; /* too late! */
+
+	if (WARN_ON(vcpu->arch.sve_state))
+		return -EINVAL;
+
+	return set_vec_vls(ARM64_VEC_SVE, vcpu, reg);
+}
+
 #define SVE_REG_SLICE_SHIFT	0
 #define SVE_REG_SLICE_BITS	5
 #define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
@@ -532,6 +547,45 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return 0;
 }
 
+static int get_sme_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	if (!vcpu_has_sme(vcpu))
+		return -ENOENT;
+
+	return get_vec_vls(ARM64_VEC_SME, vcpu, reg);
+}
+
+static int set_sme_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	if (!vcpu_has_sme(vcpu))
+		return -ENOENT;
+
+	if (kvm_arm_vcpu_vec_finalized(vcpu))
+		return -EPERM; /* too late! */
+
+	if (WARN_ON(vcpu->arch.sme_state))
+		return -EINVAL;
+
+	return set_vec_vls(ARM64_VEC_SME, vcpu, reg);
+}
+
+static int get_sme_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/* Handle the KVM_REG_ARM64_SME_VLS pseudo-reg as a special case: */
+	if (reg->id == KVM_REG_ARM64_SME_VLS)
+		return get_sme_vls(vcpu, reg);
+
+	return -EINVAL;
+}
+
+static int set_sme_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/* Handle the KVM_REG_ARM64_SME_VLS pseudo-reg as a special case: */
+	if (reg->id == KVM_REG_ARM64_SME_VLS)
+		return set_sme_vls(vcpu, reg);
+
+	return -EINVAL;
+}
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	return -EINVAL;
@@ -771,6 +825,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_FW_FEAT_BMAP:
 		return kvm_arm_get_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
+	case KVM_REG_ARM64_SME:	return get_sme_reg(vcpu, reg);
 	}
 
 	if (is_timer_reg(reg->id))
@@ -791,6 +846,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_FW_FEAT_BMAP:
 		return kvm_arm_set_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
+	case KVM_REG_ARM64_SME:	return set_sme_reg(vcpu, reg);
 	}
 
 	if (is_timer_reg(reg->id))

-- 
2.30.2


