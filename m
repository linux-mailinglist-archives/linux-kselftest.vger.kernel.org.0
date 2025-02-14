Return-Path: <linux-kselftest+bounces-26618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA531A3543A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125663AD5EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DD1C84C0;
	Fri, 14 Feb 2025 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTrjxuBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CA15198F;
	Fri, 14 Feb 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498515; cv=none; b=bMVyBzyru9pQKFQCX2Ake7e2CCpzw1Fn1jiEoY/u5Uj1/+X4LlSP/JYQDD6EqwYRhgXuIb6pBjkfzFMui0+kn6JrbjVDbuLQEOEsHYX32a6j8vns2vVta4ICdVrvU4FpBaP8G4sw+FRno5dyGTVuwQgGYOXZTOdfMgL9aWOsJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498515; c=relaxed/simple;
	bh=g2PttUoHfnqw6SnqMLDp+K12QyiZh4H10a6CHRcsYTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjOBaqIoLkgqXIZ2oDC+fGYsH1MRkF5bYn/spfso38JGE9G4Z7P0SO6abxoOLK8xypdk2e7sObRaYiEYrlxeh3qSs/4ZOcJsaRAHqJUWsqzsPoSeVYRhy6r53nMTOXQAG4hzrdjZtpYoDBXgVdwLfHDB/ws1ND1gECs7CUEu890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTrjxuBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B245AC4CEE5;
	Fri, 14 Feb 2025 02:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498513;
	bh=g2PttUoHfnqw6SnqMLDp+K12QyiZh4H10a6CHRcsYTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bTrjxuBpLILwvM/oSF38Xc4WP6m8TQVkNlwYU6GZkxirnAjjw2QVbRddjzzl3i6Nm
	 iP3D0Hi4poKjtIAtBtpMsU6RkswFclcPa7MYwNHhhmKly2wlGRCUUTzRaT78OrFJIT
	 1EaUMlzZ4RiQBH12RFen30Q1FcH4cG9WcJzHrHhkGk5iKfXiC61lsMDsYf2v4QbW9U
	 +oPCT1upxZLJEWXcYccOmcG256wKsQYdRKyry9VKeSJHHZOobNM0v9jhZGi6d5WiTm
	 UD0TDtCpfLLk1Pd1kh0y99zM4FANN9JAOFnBDebxnb1EqhdUXpam8DDlFiTKFq0P8/
	 r+GYyq9Bio86A==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:57 +0000
Subject: [PATCH v4 14/27] KVM: arm64: Implement SME vector length
 configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-14-d64a681adcc2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=g2PttUoHfnqw6SnqMLDp+K12QyiZh4H10a6CHRcsYTg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPLx4OmjNsnE5cvIuDx1F+d9FNxtMS8i4IpGRPn
 Ry4M1PuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jywAKCRAk1otyXVSH0J+tCA
 CCaZ+HHp/euJCO+F6Xpu5NLPoFlg7MWvEJGOJGcWVNmgl+cewD/IaYbb33bIVRSyBC+6rG7lNh1Prh
 KzGvM7XWq19wVZzdzB9UzgNHyNt+1+FKYK9Y5KE3GvbtJqFwE1QlkvahA7ArTC/W3gh5OuQJMQCpbY
 x8BiGtR/tH/k3FKxN5oJFKHGC0SFeyNbUy/Ze3s6wFeB3OzsYJeoQtYbb+l0MRubD7Ii2taGk2doXE
 SBZtEVF6wGCtTqfihOu/F5hjmmQq+JyT+ILwFWa7/1IncL/+ZAmrcScC6A5RMBae+Yz+2TvKbtONcI
 RhOPptHlNdPhLBgQnl/Jusk0MWMlVa
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 11 +++++
 arch/arm64/include/uapi/asm/kvm.h |  9 ++++
 arch/arm64/kvm/guest.c            | 94 +++++++++++++++++++++++++++++++--------
 3 files changed, 95 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 84aa728718e13b99b4f17f5fdffa81e380834e69..5cc1014120ca6de249093b3e34437a99bc8bf935 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -715,8 +715,15 @@ struct kvm_vcpu_arch {
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
 
@@ -984,7 +991,11 @@ struct kvm_vcpu_arch {
 #define vcpu_vec_max_vq(vcpu, type) sve_vq_from_vl((vcpu)->arch.max_vl[type])
 
 #define vcpu_sve_max_vq(vcpu)	vcpu_vec_max_vq(vcpu, ARM64_VEC_SVE)
+#define vcpu_sme_max_vq(vcpu)	vcpu_vec_max_vq(vcpu, ARM64_VEC_SME)
 
+#define vcpu_max_vl(vcpu) max((vcpu)->arch.max_vl[ARM64_VEC_SVE], \
+			      (vcpu)->arch.max_vl[ARM64_VEC_SME])
+#define vcpu_max_vq(vcpu) sve_vq_from_vl(vcpu_max_vl(vcpu))
 
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index ea5aaa4b1cfe82862883678bbe47373d53c005f6..ff7c4bcee542befae6961fae9eec2eb9bc8e2eb3 100644
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
index e9f17b8a6fba476a472d3f09691611228ee9d203..62df7830d11e6e7d01d175566e4b6a771ac2ec6d 100644
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
@@ -334,18 +332,13 @@ static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
@@ -356,18 +349,18 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
@@ -375,11 +368,33 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
@@ -533,6 +548,45 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
@@ -775,6 +829,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_FW_FEAT_BMAP:
 		return kvm_arm_get_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
+	case KVM_REG_ARM64_SME:	return get_sme_reg(vcpu, reg);
 	}
 
 	if (is_timer_reg(reg->id))
@@ -795,6 +850,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_FW_FEAT_BMAP:
 		return kvm_arm_set_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
+	case KVM_REG_ARM64_SME:	return set_sme_reg(vcpu, reg);
 	}
 
 	if (is_timer_reg(reg->id))

-- 
2.39.5


