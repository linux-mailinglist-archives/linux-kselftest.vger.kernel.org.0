Return-Path: <linux-kselftest+bounces-31010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCE1A9107D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D1E190822C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0420DD4D;
	Thu, 17 Apr 2025 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAUZlGYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9A207A03;
	Thu, 17 Apr 2025 00:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849597; cv=none; b=iLWnRRxyKRbd2n1wBVuziTfKlXgCK+pJ9/cmajZXDzrQlosMiQGpZFsIQ19IFwj5N282st7Y2hL0sxGBfSq376hLEv2fMxr9kbgt9abGuEhMoG/HmRbWgDC07w6Gl5QODPhil3ncs+I/3qWS8rCgcd3ocrEIeyNH9PYKkw3azdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849597; c=relaxed/simple;
	bh=SoGNf8VLDcyGvjMMDrVy1nP3wwZE7cm2Qiw2Dqyk5zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3RmMpSQ4fvCEjEG2UgeKW4bHVw3Txv97xCEvdXxEKTT9E6WNh9ON/+MHiGNjwfbfa2vOsgEsdlRPd41fOoe394uX/Yw6l2MHH/GRB3NmmF/rr+dvJBNYQ/EciVoyK1215XaDtWB8iWY5Zgc/HZYPCpuRq0dGKJmZoIjeyxaL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAUZlGYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46445C4CEEA;
	Thu, 17 Apr 2025 00:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849596;
	bh=SoGNf8VLDcyGvjMMDrVy1nP3wwZE7cm2Qiw2Dqyk5zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DAUZlGYFG/jxronLcCvrfl23M7CxVm/yLwrpKUvkB54MWLvuPpCElIcE8jgKimaKg
	 YTv5A2xYewiHd0T6bpH2iRK3OKADoLMEhtzhjKjdYES+qR0DWu6EybnVLxJRuvDdUy
	 gCxKrnKafH33UXL7Q0rcItAwDezK1guC+u8794yE90Yw1UV1bLPOHsbFtdpVHXmfVO
	 L2tzPHQ30BIuREHuSz3AGbtkrOdKirZjgfGwp/jaIzALhQ/e9xRnFaEGVKt4tzldfr
	 GTQCAQ8W4gwSX/KkpkfqTrV16pxPvw77X5agY57wLhIJeWR9RDaSwUUOfajNgU9TMg
	 OFuU7G68JRCaQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:18 +0100
Subject: [PATCH v5 14/28] KVM: arm64: Implement SME vector length
 configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-14-f469a2d5f574@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SoGNf8VLDcyGvjMMDrVy1nP3wwZE7cm2Qiw2Dqyk5zc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEp6wSzOULQFusLlMaNdJ6S5DNLevsvylJeVCmRS
 P+g8x8WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKegAKCRAk1otyXVSH0DP3B/
 4kqa9dUxTw4gVdLIGbofSH0NY0viYSMReQOgg/fr/m8maV4xIm95fEiqrXtV45dNg4IrRzzY3zrU2G
 hABWIfTbm9RNrasgWTzULpjYCgGv86SxZkTrkrQIAUZryR9gm6CdpDHNVC299lsNRCAp1kwn3jJfl6
 e+jDn0woF4lWxMP/cUvnjxEucFeXlWVeHdOJL+2ke1+yzIAVKHTU58e0DpBys9rPxMREdBV09wJH8B
 sYfZYeGkTi4plUS1kxakMp5byunxvm/iDVdjlYQQTzXgoi9ScfpGo4itWNeGFOhzLiT1gd7lqZLgJK
 PNlvp13iUs9aVGesHKKTFBKKlB1ov4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME implements a vector length which architecturally looks very similar
to that for SVE, configured in a very similar manner.  This controls the
vector length used for the ZA matrix register, and for the SVE vector
and predicate registers when in streaming mode.  The only substantial
difference is that unlike SVE the architecture does not guarantee that
any particular vector length will be implemented.

Configuration for SME vector lengths is done using a virtual register as
for SVE, hook up the implementation for the virtual register.  Since we
do not yet have support for any of the new SME registers stub register
access functions are provided that only allow VL configuration.  These
will be extended as the SME specific registers, as for SVE.

Since vq_available() is currently only defined for CONFIG_SVE add a stub
for builds where that is disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h   |  1 +
 arch/arm64/include/asm/kvm_host.h | 24 ++++++++++--
 arch/arm64/include/uapi/asm/kvm.h |  9 +++++
 arch/arm64/kvm/guest.c            | 82 +++++++++++++++++++++++++++++++--------
 4 files changed, 96 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 573bd6a219f2..7af636885c04 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -321,6 +321,7 @@ static inline int sve_max_vl(void)
 	return -EINVAL;
 }
 
+static inline bool vq_available(enum vec_type type, unsigned int vq) { return false; }
 static inline bool sve_vq_available(unsigned int vq) { return false; }
 
 static inline void sve_user_disable(void) { BUILD_BUG(); }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d5ad85478010..8ac63de0a045 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -752,8 +752,15 @@ struct kvm_vcpu_arch {
 	 * low 128 bits of the SVE Z registers.  When the core
 	 * floating point code saves the register state of a task it
 	 * records which view it saved in fp_type.
+	 *
+	 * If SME support is also present then it provides an
+	 * alternative view of the SVE registers accessed as for the Z
+	 * registers when PSTATE.SM is 1, plus an additional set of
+	 * SME specific state in the matrix register ZA and LUT
+	 * register ZT0.
 	 */
 	void *sve_state;
+	void *sme_state;
 	enum fp_type fp_type;
 	unsigned int max_vl[ARM64_VEC_MAX];
 
@@ -1018,14 +1025,23 @@ struct kvm_vcpu_arch {
 
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
 
-/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
-#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.max_vl[ARM64_VEC_SVE]))
-
 #define vcpu_vec_max_vq(vcpu, type) sve_vq_from_vl((vcpu)->arch.max_vl[type])
 
 #define vcpu_sve_max_vq(vcpu)	vcpu_vec_max_vq(vcpu, ARM64_VEC_SVE)
+#define vcpu_sme_max_vq(vcpu)	vcpu_vec_max_vq(vcpu, ARM64_VEC_SME)
+
+#define vcpu_sve_max_vl(vcpu)	((vcpu)->arch.max_vl[ARM64_VEC_SVE])
+#define vcpu_sme_max_vl(vcpu)	((vcpu)->arch.max_vl[ARM64_VEC_SME])
 
+#define vcpu_max_vl(vcpu) max(vcpu_sve_max_vl(vcpu), vcpu_sme_max_vl(vcpu))
+#define vcpu_max_vq(vcpu) sve_vq_from_vl(vcpu_max_vl(vcpu))
+
+#define vcpu_cur_sve_vl(vcpu) (vcpu_in_streaming_mode(vcpu) ? \
+			       vcpu_sme_max_vl(vcpu) : vcpu_sve_max_vl(vcpu))
+
+/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
+#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
+			     sve_ffr_offset(vcpu_cur_sve_vl(vcpu)))
 
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 42cfa86b96ca..c0a8aa8c67ea 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -354,6 +354,15 @@ struct kvm_arm_counter_offset {
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
index e9f17b8a6fba..6460bb21e01d 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -310,22 +310,20 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
+	max_vq = vcpu_vec_max_vq(vcpu, vec_type);
 	for (vq = SVE_VQ_MIN; vq <= max_vq; ++vq)
-		if (sve_vq_available(vq))
+		if (vq_available(vec_type, vq))
 			vqs[vq_word(vq)] |= vq_mask(vq);
 
 	if (copy_to_user((void __user *)reg->addr, vqs, sizeof(vqs)))
@@ -334,40 +332,41 @@ static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
 	if (kvm_arm_vcpu_vec_finalized(vcpu))
 		return -EPERM; /* too late! */
 
-	if (WARN_ON(vcpu->arch.sve_state))
+	if (WARN_ON(!sve_vl_valid(vcpu->arch.max_vl[vec_type])))
 		return -EINVAL;
 
 	if (copy_from_user(vqs, (const void __user *)reg->addr, sizeof(vqs)))
 		return -EFAULT;
 
+	if (WARN_ON(vcpu->arch.sve_state || vcpu->arch.sme_state))
+		return -EINVAL;
+
 	max_vq = 0;
 	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; ++vq)
 		if (vq_present(vqs, vq))
 			max_vq = vq;
 
-	if (max_vq > sve_vq_from_vl(kvm_max_vl[ARM64_VEC_SVE]))
+	if (max_vq > sve_vq_from_vl(kvm_max_vl[vec_type]))
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
@@ -375,11 +374,27 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
+	return set_vec_vls(ARM64_VEC_SVE, vcpu, reg);
+}
+
 #define SVE_REG_SLICE_SHIFT	0
 #define SVE_REG_SLICE_BITS	5
 #define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
@@ -533,6 +548,39 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
@@ -775,6 +823,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_FW_FEAT_BMAP:
 		return kvm_arm_get_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
+	case KVM_REG_ARM64_SME:	return get_sme_reg(vcpu, reg);
 	}
 
 	if (is_timer_reg(reg->id))
@@ -795,6 +844,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_FW_FEAT_BMAP:
 		return kvm_arm_set_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
+	case KVM_REG_ARM64_SME:	return set_sme_reg(vcpu, reg);
 	}
 
 	if (is_timer_reg(reg->id))

-- 
2.39.5


