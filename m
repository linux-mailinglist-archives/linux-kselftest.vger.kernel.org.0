Return-Path: <linux-kselftest+bounces-2395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC781CCF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455D0B24C89
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CAA28E00;
	Fri, 22 Dec 2023 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvbHc52q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384235EE5;
	Fri, 22 Dec 2023 16:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90550C433CA;
	Fri, 22 Dec 2023 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262160;
	bh=3r8fD00XjCnaZrU0SmIrO9CoscfRaXzsXWfhUg2fTlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tvbHc52q/hNN1hJVM2UN9AidwHinbBzYudlSVv4rh5zUKOIIBhTD+36BIlXBuIpAn
	 RfxqkOfna8fBtJIZp1ri3jUlba63igwiTIm18Mtc9Zygrh/kta+qZ/QSXZjFLywSYj
	 XfLeCzfgRloR1LTfFGyy+SrtiEDpUf3kru9eHlrhPK0yXWCQ69WNVxTrEyPrVr2P0W
	 679e1PyNhCykUxbdOpP46R+vEyHrPV98IvOdcmA3rEvPmMr2iwOnGpHM2aHa8oiofm
	 bd75vVz3SRJ5eZSbH9h/GuaGqKw+zFYPChKloAw/bG16oNoS0J5BpkqYB07ZYSYOl4
	 nSjNHaoojpo+w==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:26 +0000
Subject: [PATCH RFC v2 18/22] KVM: arm64: Expose ZA to userspace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-18-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6540; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3r8fD00XjCnaZrU0SmIrO9CoscfRaXzsXWfhUg2fTlM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeKXkjebfu8N1x5OKu63GCDoeRyY5y0mQaj98oy
 5yGvNvWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3igAKCRAk1otyXVSH0OG3B/
 9ClXyYjhsIiv/4+Dv5P9kN2mRyiY4P0OHlER8qwxbNwuZBPmoCwyBh6zKOGihCyzAMugm4GXTPckTS
 vYg1lGfX8Jc1Vq+F8uC/T13x/cwe0TthGV3OEVjM5Y4OEP7/djOuyNYG0FU9QF3rq+3hA7f4zb6bfQ
 HsVMFA62YD1ONAklyUThIggo/PXwKzKy+odNVa3gmbfRU4GqfbQ8kyVyjv700q1YW1AAB4LVStw+jW
 58BrRr+s4xzqMbXo5vAj1hzLR5FbFCWmRFtSSv9yqhCo+Woti8eKSOWbHvW21lr7XFyp70dnVr9Y/o
 Ipd7dtRGEHlNAKomf6kbpkTA2D8MRP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The SME ZA matrix is a single SVL*SVL register which is available when
PSTATE.ZA is set. We follow the pattern established by the architecture
itself and expose this to userspace as a series of horizontal SVE vectors
with the streaming mode vector length, using the format already established
for the SVE vectors themselves.

For the purposes of exporting to userspace we ignore the value of
PSTATE.ZA, if PSTATE.ZA is clear when the guest is run then the guest will
need to set it to access ZA which would cause the value to be cleared. If
userspace reads ZA when PSTATE.ZA is clear then it will read whatever stale
data was last saved. This removes ordering requirements from userspace,
minimising the need to special case.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 14 ++++++
 arch/arm64/include/uapi/asm/kvm.h | 15 +++++++
 arch/arm64/kvm/guest.c            | 95 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a5ed0433edc6..a1aa9471084d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -846,6 +846,20 @@ void vcpu_fp_guest_to_user(struct kvm_vcpu *vcpu);
 	__size_ret;							\
 })
 
+#define vcpu_sme_state_size(vcpu) ({					\
+	size_t __size_ret;						\
+	unsigned int __vcpu_vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.max_vl[ARM64_VEC_SME]))) { \
+		__size_ret = 0;						\
+	} else {							\
+		__vcpu_vq = vcpu_sme_max_vq(vcpu);			\
+		__size_ret = ZA_SIG_REGS_SIZE(__vcpu_vq);		\
+	}								\
+									\
+	__size_ret;							\
+})
+
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
  * memory backed version of a register, and not the one most recently
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 02642bb96496..00fb2ea4c057 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -356,6 +356,21 @@ struct kvm_arm_counter_offset {
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
 /* Vector lengths pseudo-register: */
 #define KVM_REG_ARM64_SME_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SME | \
 					 KVM_REG_SIZE_U512 | 0xffff)
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5f2845625c55..cb38af891387 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -573,22 +573,113 @@ static int set_sme_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
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
+
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
+		/* ZA is exposed as SVE vectors ZA.H[n] */
+		if (!vcpu_has_sme(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
+			return -ENOENT;
+
+		reqoffset = ZA_SIG_ZAV_OFFSET(vq, reg_num) -
+			ZA_SIG_REGS_OFFSET;
+		reqlen = KVM_SVE_ZREG_SIZE;
+		maxlen = SVE_SIG_ZREG_SIZE(vq);
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
+	/* Try to interpret reg ID as an architectural SVE register... */
+	ret = sme_reg_to_region(&region, vcpu, reg);
+	if (ret)
+		return ret;
+
+	/* Try to interpret reg ID as an architectural SVE register... */
+	ret = sme_reg_to_region(&region, vcpu, reg);
+	if (ret)
+		return ret;
+
+	if (!kvm_arm_vcpu_vec_finalized(vcpu))
+		return -EPERM;
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
+	/* Try to interpret reg ID as an architectural SVE register... */
+	ret = sme_reg_to_region(&region, vcpu, reg);
+	if (ret)
+		return ret;
+
+	if (!kvm_arm_vcpu_vec_finalized(vcpu))
+		return -EPERM;
+
+	if (copy_from_user(vcpu->arch.sme_state + region.koffset, uptr,
+			   region.klen))
+		return -EFAULT;
+
+	return 0;
 }
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {

-- 
2.30.2


