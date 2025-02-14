Return-Path: <linux-kselftest+bounces-26625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 653A1A35450
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0A97A2E02
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E91FC117;
	Fri, 14 Feb 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBV9xS6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCE1FC10D;
	Fri, 14 Feb 2025 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498539; cv=none; b=KvaBtRqTxqdKGqDDpBrZmtll0SZGmbK6iLM5+Qc5dRAIS8eIL3a9Nrsv7fUtXeQRVgpULJkxL9FPrsZWGrMzH1YapVamtFlHU7Vdo5UVfXr14GUUg2z2sJYrFs3xTBRdu5l6XqM8c4QbpJMzsgS+5xlzD904Hux2sDIgNbaIj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498539; c=relaxed/simple;
	bh=fnCQMptN1ycDRPB+hsWu9oBxkCMnhPzAMfclA65DM6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZK7qjsZGLge4U8hsRPXCbvufAJx4CA4Y2tB0kkmo6ACWD3InFh+JQ1XWaVPLx88frUJ7m3c+RO9whOGnlLVBjn8tb+uoiRM7RTAAXB0el1PegiNqxulNOQFDWk2Hk2U0XUO3O7ski/6xD1tT397HjLXSjAcWk0bO6ObthAdbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBV9xS6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206ABC4CEE5;
	Fri, 14 Feb 2025 02:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498539;
	bh=fnCQMptN1ycDRPB+hsWu9oBxkCMnhPzAMfclA65DM6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FBV9xS6advEsW5GLOU0FDPSCV33IEBjgVcG4VpPNDOnh3/IPo85wpJgWVmtvPssnA
	 Swaix4faswwQxyCVSufhzsK0XMzB3AbXFWOhttEXr9FMxFptDZ1cTn+v7oCiB8joPS
	 smv0lL0USmqMqWQuT/G5+IIBMxyS2dnu3M89fMdbvbfK8RboQlurcBCdUzH6lbwVqr
	 QqkjonlTlES4Nl/5zj9n4U9iQg9U0DpDu62zijj9H4VxFK7R+PSU8dBFK4PrrYjDvD
	 XfSvAzZbhz0JwcB7EHAZ760YCfQu2HkoKR2jVJ7MP6w7SfBGWEE23A+u5ELdrLOZ1M
	 C+y0jHPnD41KQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:58:04 +0000
Subject: [PATCH v4 21/27] KVM: arm64: Expose SME specific state to
 userspace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-21-d64a681adcc2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8323; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fnCQMptN1ycDRPB+hsWu9oBxkCMnhPzAMfclA65DM6Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPQ2aiAXrCUt457WEMctVDTOFzvg9+orir6Rf1F
 K99jIKSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66j0AAKCRAk1otyXVSH0B0mB/
 45/HObhST/tz6QF+/Wy8m1myRbqdAJbH1tEt2o+OkO//j+eVrqojveCXn8bV4Jk6+OXfKGfD+tMk4U
 hNKolDasx0BVMhd12H9MHM4GlCXKpkZoHa2qojvwXpz72qa6pbHC3hEB6j3Tot2qL78fZ4zQYDAO3l
 7N0T96/00F5w00FtbDOf+/2E4oBY85o+aDNh+0HCOPJ/nd5NAMwl8UElVsR/gAhnGxKf/JuJBP7t2Z
 O5G/wrto/TRRVOrehW629wxdxccYUsMZQQmC6zDilkulZ+8ddTddTctmWU0MV84aj1zDf3vehAbgre
 Jg5YzZ54+9TxkHsxwZZibo1lXM62Pm
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
 arch/arm64/include/asm/kvm_host.h |  21 +++++++
 arch/arm64/include/uapi/asm/kvm.h |  17 ++++++
 arch/arm64/kvm/guest.c            | 114 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 67ac3e37fde31901513c2e692693d3ba1967b0bd..0b00b1e42b668367b89d7ffee2839fc53c14e753 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1020,6 +1020,24 @@ struct kvm_vcpu_arch {
 	__size_ret;							\
 })
 
+#define vcpu_sme_state(vcpu) (kern_hyp_va((vcpu)->arch.sme_state))
+
+#define vcpu_sme_state_size(vcpu) ({					\
+	size_t __size_ret;						\
+	unsigned int __vcpu_vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.max_vl[ARM64_VEC_SME]))) { \
+		__size_ret = 0;						\
+	} else {							\
+		__vcpu_vq = vcpu_sme_max_vq(vcpu);			\
+		__size_ret = ZA_SIG_REGS_SIZE(__vcpu_vq);		\
+		if (system_supports_sme2())				\
+			__size_ret += ZT_SIG_REG_SIZE;			\
+	}								\
+									\
+	__size_ret;							\
+})
+
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
  * memory backed version of a register, and not the one most recently
@@ -1603,4 +1621,7 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define vcpu_in_streaming_mode(vcpu) \
 	(__vcpu_sys_reg(vcpu, SVCR) & SVCR_SM_MASK)
 
+#define vcpu_za_enabled(vcpu) \
+	(__vcpu_sys_reg(vcpu, SVCR) & SVCR_ZA_MASK)
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index ff7c4bcee542befae6961fae9eec2eb9bc8e2eb3..1f75c9938f313e70a82d9792cb3c89caec2076a1 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -356,6 +356,23 @@ struct kvm_arm_counter_offset {
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
index 87a0a027e1e7e2487eff703dee2958137c9640ef..55459d1e7586291f8384e8073b5de2d6a8f5f2d9 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -600,23 +600,133 @@ static int set_sme_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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


