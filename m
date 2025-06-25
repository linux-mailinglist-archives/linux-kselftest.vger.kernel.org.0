Return-Path: <linux-kselftest+bounces-35765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6763DAE8149
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CDE5A58FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C22ED85D;
	Wed, 25 Jun 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq9c7l8G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1692ECE88;
	Wed, 25 Jun 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850767; cv=none; b=Is/Tnz5jmEFgimOYhykbiwtXSM+NC0N8U/IIKYmvJj3Et1X3DosdHEN/Gb35m5FnrdYFxXvHD0Uvyq1ngmUQ1G+jliiYCjZnB/tDQAA5Tn06VClZKI7XZQGTFySlHExwIta3vg4jYRkKHEXKf38iiVpoKto07NC0tiqM4J14NZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850767; c=relaxed/simple;
	bh=67sau1kTrpcFB1EpOThvgdJihVjoSwKZtQPl/JxMPto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5lYvlomLcs/d6LLnfmQ2qnswvRqDOH6dGH2amfVd9v7m6/3GfzzMWvEMq94L3ftZ919DwN8sqsBgS7fi6V3q13CLhgcCPHr2plg0OP2TwMSUpF8X2d286tkv9+6GaBEHsrgwG85NO4pdvCLRWpqI5+Cfl1GcNkLgikn0yFA1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq9c7l8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5F1C4CEEA;
	Wed, 25 Jun 2025 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850767;
	bh=67sau1kTrpcFB1EpOThvgdJihVjoSwKZtQPl/JxMPto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jq9c7l8Gebas/pXE3W24s3DV7iT6HvJSG+Yy3m4I0whcnGPvo1UQcR8a9n79xdQ6s
	 IPBLFCdxgu0qGzpuMemhc8vaOjyk7D/WlXq1XDlZJJcsR09UUn2WcMvmK2ubuDsEBh
	 GdAo9P4pA3+sEGYzTsgv8Q1ZRsE41lCZ4xv3LRBZ7uMjUQYU2s+uEoEqLbZoMifSmZ
	 BKOMUgzmPY/Y/k7G/RGYTHh6/JAJiYf5zYLlPgncw6tsZ976zvObwnzD44gA1C2kUs
	 BS0YmX1IKOe9xuzfcJLK+x2T/7d4A5IKHEfk8gmhlhQSlez2/cQpYmPMUnJd6mNSOr
	 FMlNcPrWmMrcw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:13 +0100
Subject: [PATCH v6 22/28] KVM: arm64: Expose SME specific state to
 userspace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-22-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6845; i=broonie@kernel.org;
 h=from:subject:message-id; bh=67sau1kTrpcFB1EpOThvgdJihVjoSwKZtQPl/JxMPto=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9x26pr0IMkXom7lAhfhA6/yqeQul7ZrHhqcO
 CmpfCd9e1+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcdgAKCRAk1otyXVSH
 0HS6B/sGrZspk+0sHFVYTQwGV4kImEOPUvxlTxpG/D9MsYMKNYySU+/HRp/8uLhp0kZ9Xq45K4D
 19pMe9YIX19BWzJ9/mQZ4TDmuOyTkJWEnTfzmtywRF7lNzPyjQqiH4Wdi4lFyM8yfBQq9th3Pev
 4THWvH+G981Fx3uI0Sn08eeIY2XeGyNWeWgWgzjhNHnTljozDNeYm9hg3yQVQr/jMR8y6PiOE7i
 Pgaax/dKYnEDFW2UHNQb3FgeyFELCJgJ9DidEN5nuIYmhctoPr61gQSTcELwF6MS9vX9VnwhEot
 AeazyJtLv1rk9jYx1DnMRIzmgcODnawcbJ31pmEWZp6SAVlM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME introduces two new registers, the ZA matrix register and the ZT0 LUT
register.  Both of these registers are only accessible when PSTATE.ZA is
set and ZT0 is only present if SME2 is enabled for the guest. Provide
support for configuring these from VMMs.

The ZA matrix is a single SVL*SVL register which is available when
PSTATE.ZA is set. We follow the pattern established by the architecture
itself and expose this to userspace as a series of horizontal SVE vectors
with the streaming mode vector length, using the format already established
for the SVE vectors themselves.

ZT0 is a single register with a refreshingly fixed size 512 bit register
which is like ZA accessible only when PSTATE.ZA is set. Add support for it
to the userspace API, as with ZA we allow the register to be read or written
regardless of the state of PSTATE.ZA in order to simplify userspace usage.
The value will be reset to 0 whenever PSTATE.ZA changes from 0 to 1,
userspace can read stale values but these are not observable by the guest
without manipulation of PSTATE.ZA by userspace.

While there is currently only one ZT register the naming as ZT0 and the
instruction encoding clearly leave room for future extensions adding more
ZT registers. This encoding can readily support such an extension if one is
introduced.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/kvm.h |  17 ++++++
 arch/arm64/kvm/guest.c            | 114 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 5220797361e0..cf75a830f17a 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -357,6 +357,23 @@ struct kvm_arm_counter_offset {
 /* SME registers */
 #define KVM_REG_ARM64_SME		(0x17 << KVM_REG_ARM_COPROC_SHIFT)
 
+#define KVM_ARM64_SME_VQ_MIN __SVE_VQ_MIN
+#define KVM_ARM64_SME_VQ_MAX __SVE_VQ_MAX
+
+/* ZA and ZTn occupy blocks at the following offsets within this range: */
+#define KVM_REG_ARM64_SME_ZA_BASE	0
+#define KVM_REG_ARM64_SME_ZT_BASE	0x600
+
+#define KVM_ARM64_SME_MAX_ZAHREG	(__SVE_VQ_BYTES * KVM_ARM64_SME_VQ_MAX)
+
+#define KVM_REG_ARM64_SME_ZAHREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SME | KVM_REG_ARM64_SME_ZA_BASE | \
+	 KVM_REG_SIZE_U2048 |						\
+	 (((n) & (KVM_ARM64_SME_MAX_ZAHREG - 1)) << 5) |		\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SME_ZTREG_SIZE	(512 / 8)
+
 /* Vector lengths pseudo-register: */
 #define KVM_REG_ARM64_SME_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SME | \
 					 KVM_REG_SIZE_U512 | 0xffff)
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 4ba0afa369d5..6ed5f4fe6126 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -594,23 +594,133 @@ static int set_sme_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return set_vec_vls(ARM64_VEC_SME, vcpu, reg);
 }
 
+/*
+ * Validate SVE register ID and get sanitised bounds for user/kernel SVE
+ * register copy
+ */
+static int sme_reg_to_region(struct vec_state_reg_region *region,
+			     struct kvm_vcpu *vcpu,
+			     const struct kvm_one_reg *reg)
+{
+	/* reg ID ranges for ZA.H[n] registers */
+	unsigned int vq = vcpu_sme_max_vq(vcpu) - 1;
+	const u64 za_h_max = vq * __SVE_VQ_BYTES;
+	const u64 zah_id_min = KVM_REG_ARM64_SME_ZAHREG(0, 0);
+	const u64 zah_id_max = KVM_REG_ARM64_SME_ZAHREG(za_h_max - 1,
+						       SVE_NUM_SLICES - 1);
+	unsigned int reg_num;
+
+	unsigned int reqoffset, reqlen; /* User-requested offset and length */
+	unsigned int maxlen; /* Maximum permitted length */
+
+	size_t sme_state_size;
+
+	reg_num = (reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	if (reg->id >= zah_id_min && reg->id <= zah_id_max) {
+		if (!vcpu_has_sme(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
+			return -ENOENT;
+
+		/* ZA is exposed as SVE vectors ZA.H[n] */
+		reqoffset = ZA_SIG_ZAV_OFFSET(vq, reg_num) -
+			ZA_SIG_REGS_OFFSET;
+		reqlen = KVM_SVE_ZREG_SIZE;
+		maxlen = SVE_SIG_ZREG_SIZE(vq);
+	} else if (reg->id == KVM_REG_ARM64_SME_ZT_BASE) {
+		/* ZA is exposed as SVE vectors ZA.H[n] */
+		if (!kvm_has_feat(vcpu->kvm, ID_AA64PFR1_EL1, SME, SME2) ||
+		    (reg->id & SVE_REG_SLICE_MASK) > 0 ||
+		    reg_num > 0)
+			return -ENOENT;
+
+		/* ZT0 is stored after ZA */
+		reqlen = KVM_REG_ARM64_SME_ZTREG_SIZE;
+		maxlen = KVM_REG_ARM64_SME_ZTREG_SIZE;
+	} else {
+		return -EINVAL;
+	}
+
+	sme_state_size = vcpu_sme_state_size(vcpu);
+	if (WARN_ON(!sme_state_size))
+		return -EINVAL;
+
+	region->koffset = array_index_nospec(reqoffset, sme_state_size);
+	region->klen = min(maxlen, reqlen);
+	region->upad = reqlen - region->klen;
+
+	return 0;
+}
+
+/*
+ * ZA is exposed as an array of horizontal vectors with the same
+ * format as SVE, mirroring the architecture's LDR ZA[Wv, offs], [Xn]
+ * instruction.
+ */
+
 static int get_sme_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
+	int ret;
+	struct vec_state_reg_region region;
+	char __user *uptr = (char __user *)reg->addr;
+
 	/* Handle the KVM_REG_ARM64_SME_VLS pseudo-reg as a special case: */
 	if (reg->id == KVM_REG_ARM64_SME_VLS)
 		return get_sme_vls(vcpu, reg);
 
-	return -EINVAL;
+	/* Try to interpret reg ID as an architectural SME register... */
+	ret = sme_reg_to_region(&region, vcpu, reg);
+	if (ret)
+		return ret;
+
+	if (!kvm_arm_vcpu_vec_finalized(vcpu))
+		return -EPERM;
+
+	/*
+	 * None of the SME specific registers are accessible unless
+	 * PSTATE.ZA is set.
+	 */
+	if (!vcpu_za_enabled(vcpu))
+		return -EINVAL;
+
+	if (copy_from_user(vcpu->arch.sme_state + region.koffset, uptr,
+			   region.klen))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int set_sme_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
+	int ret;
+	struct vec_state_reg_region region;
+	char __user *uptr = (char __user *)reg->addr;
+
 	/* Handle the KVM_REG_ARM64_SME_VLS pseudo-reg as a special case: */
 	if (reg->id == KVM_REG_ARM64_SME_VLS)
 		return set_sme_vls(vcpu, reg);
 
-	return -EINVAL;
+	/* Try to interpret reg ID as an architectural SME register... */
+	ret = sme_reg_to_region(&region, vcpu, reg);
+	if (ret)
+		return ret;
+
+	if (!kvm_arm_vcpu_vec_finalized(vcpu))
+		return -EPERM;
+
+	/*
+	 * None of the SME specific registers are accessible unless
+	 * PSTATE.ZA is set.
+	 */
+	if (!vcpu_za_enabled(vcpu))
+		return -EINVAL;
+
+	if (copy_from_user(vcpu->arch.sme_state + region.koffset, uptr,
+			   region.klen))
+		return -EFAULT;
+
+	return 0;
 }
+
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	return -EINVAL;

-- 
2.39.5


