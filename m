Return-Path: <linux-kselftest+bounces-2394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B246D81CCF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE652B24B80
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4728DD8;
	Fri, 22 Dec 2023 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkn5ISut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40133CD5;
	Fri, 22 Dec 2023 16:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EEFC433C7;
	Fri, 22 Dec 2023 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262157;
	bh=zKuU38L57iCaEvwp/q08wSf3P5pjHsM8FfrGJRDNejE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jkn5ISutuXzj3kMqY6qC5XIZV0GEV+pvAD+35K4rx7wFvfhoHmVXqWmrlYJZbaSAo
	 /u72f9Bk/094T0MNoEqaF8gSJrp7UzyM8+rg7v7AOjrdo6kZnICDAOUumo2QFe8X2f
	 brynVvm7Tusm7k+81dz5PVeboAPlk+cvL3gDYkVrEPnFMzb114O02zggZ57Ggsca13
	 Qpec0sMxafnEuDNTXXlYMO7/BBfIwZWQYStkpeA/r0t+zprFAl/IlAOu9JhVrBs148
	 ikhVpVgTZrjNDRMnRh3Ckm6Vfd7SOUaFkv6YmW4onYBa5NoB2Bs6YjjRJUS+6cjm2t
	 mxjoct3ncRuoQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:25 +0000
Subject: [PATCH RFC v2 17/22] KVM: arm64: Support userspace access to
 streaming mode SVE registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-17-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zKuU38L57iCaEvwp/q08wSf3P5pjHsM8FfrGJRDNejE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeJD7dEvRipDevLDE14qCixrsVYMkhBDaC71wTx
 f+S4ZfKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3iQAKCRAk1otyXVSH0AHoB/
 9zOHK+eMx6eNH9hraq87XPyLsLG2mOYIaEN+qy0o2mm3HYsOaCOMJBLpB057u+jOIOWOKQ0K04MAhI
 VbtJKgLacnP6jvz20EjAM7RpBCAq9BH8UBLacA0QTBFOUuCIg2MNYGsVBmLWldeIxOSOrkveEGIF2z
 ECTeGJZCROMUBkxCdi7djX5aeDuL6u13+rFXx/pGTrHTobAp0LH3XIJ0cQvlHi4I8KxoUq5w8qTuuj
 4bcjVtdHwAog2bmZNiO69ugeqoDWwpXWgFB5us7p8Pk/mTzgkuC+wU70/DKJdT2pdTxZLZGN6biQV6
 9zHor2JSZny2y+7aANREUyqRm6qEN6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME defines a new mode called streaming mode with an associated vector
length which may be configured independently to the standard SVE vector
length. SVE and SME also have no interdependency, it is valid to implement
SME without SVE. When in streaming mode the SVE registers are accessible
with the streaming mode vector length rather than  the usual SVE vector
length. In order to handle this we extend the existing SVE register
interface to expose the vector length dependent registers with the larger
of the SVE or SME vector length and requiring access to the V registers via
the SVE register set if the system supports only SME.

The main complication this creates is that the format that is sensible for
saving and restoring the registers in the hypervisor is no longer the same
as that which is exposed to userspace. This is especially true when the
host does not have SVE, in that case we must use FPSIMD register save and
restore code in non-streaming mode. Handle this by extending our set of
register access owners to include userspace access, converting to the
format used by the hypervisor if needed when preparing to run the guest
and to userspace format when the registers are read. This avoids any
conversions in normal hypervisor scheduling.

The userspace format is the existing SVE format with the largest vector
length used. The hypervisor format varies depending on the current value
of SVCR.SM and if SVE is supported:

 - If SVCR.SM=1 then SVE format with the SME vector length is used.
 - If SVCR.SM=0 and SVE is not supported then the FPSIMD format is used.
 - If SVCR.SM=0 and SVE is supported the SVE format and vector length are
   used.

When converting to a larger vector length we pad the high bits with 0.

Since we already track the owner of the floating point register state
introduce a new state FP_STATE_USER_OWNED in which the state is stored in
the format we present to userspace. The guest starts out in this state.
When we prepare to run the guest we check for this state and
the guest we check for this state and if we are in it we do any rewrites
needed to store in the format the hypervisor expects. In order to minimise
overhead we only convert back to userspace format if userspace accesses the
SVE registers.

For simpliciy we always represent FFR for SVE storage, if the system
lacks both SVE and streaming mode FFR then the value will be visible
but ignored.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |   6 +-
 arch/arm64/kvm/arm.c              |   9 +-
 arch/arm64/kvm/fpsimd.c           | 173 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/guest.c            |  16 ++--
 4 files changed, 195 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 022b9585e6f6..a5ed0433edc6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -540,6 +540,7 @@ struct kvm_vcpu_arch {
 		FP_STATE_FREE,
 		FP_STATE_HOST_OWNED,
 		FP_STATE_GUEST_OWNED,
+		FP_STATE_USER_OWNED,
 	} fp_state;
 
 	/* Configuration flags, set once and for all before the vcpu can run */
@@ -828,6 +829,9 @@ struct kvm_vcpu_arch {
 
 #define vcpu_sme_max_vq(vcpu)	vcpu_vec_max_vq(ARM64_VEC_SME, vcpu)
 
+int vcpu_max_vq(struct kvm_vcpu *vcpu);
+void vcpu_fp_guest_to_user(struct kvm_vcpu *vcpu);
+
 #define vcpu_sve_state_size(vcpu) ({					\
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
@@ -835,7 +839,7 @@ struct kvm_vcpu_arch {
 	if (WARN_ON(!sve_vl_valid((vcpu)->arch.max_vl[ARM64_VEC_SVE]))) { \
 		__size_ret = 0;						\
 	} else {							\
-		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
+		__vcpu_vq = vcpu_max_vq(vcpu);				\
 		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
 	}								\
 									\
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e5f75f1f1085..aa7e2031263c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -376,9 +376,14 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Default value for the FP state, will be overloaded at load
-	 * time if we support FP (pretty likely)
+	 * time if we support FP (pretty likely).  If we support both
+	 * SVE and SME we may have to rewrite between the two VLs,
+	 * default to formatting the registers for userspace access.
 	 */
-	vcpu->arch.fp_state = FP_STATE_FREE;
+	if (system_supports_sve() && system_supports_sme())
+		vcpu->arch.fp_state = FP_STATE_USER_OWNED;
+	else
+		vcpu->arch.fp_state = FP_STATE_FREE;
 
 	/* Set up the timer */
 	kvm_timer_vcpu_init(vcpu);
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index d9a56a4027a6..a40072e149cf 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -14,6 +14,24 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
+/* We present Z and P to userspace with the maximum of the SVE or SME VL */
+int vcpu_max_vq(struct kvm_vcpu *vcpu)
+{
+	int sve, sme;
+
+	if (vcpu_has_sve(vcpu))
+		sve = vcpu_sve_max_vq(vcpu);
+	else
+		sve = 0;
+
+	if (vcpu_has_sme(vcpu))
+		sme = vcpu_sme_max_vq(vcpu);
+	else
+		sme = 0;
+
+	return max(sve, sme);
+}
+
 void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
 {
 	struct task_struct *p = vcpu->arch.parent_task;
@@ -65,6 +83,159 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static bool vcpu_fp_user_format_needed(struct kvm_vcpu *vcpu)
+{
+	/* Only systems with SME need rewrites */
+	if (!system_supports_sme())
+		return false;
+
+	/*
+	 * If we have both SVE and SME and the two VLs are the same
+	 * and no rewrite is needed.
+	 */
+	if (vcpu_has_sve(vcpu) &&
+	    (vcpu_sve_max_vq(vcpu) == vcpu_sme_max_vq(vcpu)))
+		return false;
+
+	return true;
+}
+
+static bool vcpu_sm_active(struct kvm_vcpu *vcpu)
+{
+	return __vcpu_sys_reg(vcpu, SVCR) & SVCR_SM;
+}
+
+static int vcpu_active_vq(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_sm_active(vcpu))
+		return vcpu_sme_max_vq(vcpu);
+	else
+		return vcpu_sve_max_vq(vcpu);
+}
+
+static void *buf_zreg(void *buf, int vq, int reg)
+{
+	return buf + __SVE_ZREG_OFFSET(vq, reg) - __SVE_ZREGS_OFFSET;
+}
+
+static void *buf_preg(void *buf, int vq, int reg)
+{
+	return buf + __SVE_PREG_OFFSET(vq, reg) - __SVE_ZREGS_OFFSET;
+}
+
+static void vcpu_rewrite_sve(struct kvm_vcpu *vcpu, int vq_in, int vq_out)
+{
+	void *new_buf;
+	int copy_size, i;
+
+	new_buf = kzalloc(vcpu_sve_state_size(vcpu), GFP_KERNEL);
+	if (!new_buf)
+		return;
+
+	if (WARN_ON_ONCE(vq_in == vq_out))
+		return;
+
+	/* Z registers */
+	if (vq_in < vq_out)
+		copy_size = vq_in * __SVE_VQ_BYTES;
+	else
+		copy_size = vq_out * __SVE_VQ_BYTES;
+
+	for (i = 0; i < SVE_NUM_ZREGS; i++)
+		memcpy(buf_zreg(new_buf, vq_out, i),
+		       buf_zreg(vcpu->arch.sve_state, vq_in, i),
+		       copy_size);
+
+	/* P and FFR, FFR is stored as an additional P */
+	copy_size /= 8;
+	for (i = 0; i <= SVE_NUM_PREGS; i++)
+		memcpy(buf_preg(new_buf, vq_out, i),
+		       buf_preg(vcpu->arch.sve_state, vq_in, i),
+		       copy_size);
+
+	/*
+	 * Ideally we would unmap the existing SVE buffer and remap
+	 * the new one.
+	 */
+	memcpy(vcpu->arch.sve_state, new_buf, vcpu_sve_state_size(vcpu));
+	kfree(new_buf);
+}
+
+/*
+ * If both SVE and SME are supported we present userspace with the SVE
+ * Z, P and FFR registers configured with the larger of the SVE and
+ * SME vector length, and if we have SME then even without SVE we
+ * present the V registers via Z.
+ */
+static void vcpu_fp_user_to_guest(struct kvm_vcpu *vcpu)
+{
+	if (likely(vcpu->arch.fp_state != FP_STATE_USER_OWNED))
+		return;
+
+	if (!vcpu_fp_user_format_needed(vcpu)) {
+		vcpu->arch.fp_state = FP_STATE_FREE;
+		return;
+	}
+
+	if (vcpu_has_sve(vcpu)) {
+		/*
+		 * The register state is stored in SVE format, rewrite
+		 * from the larger VL to the one the guest is
+		 * currently using.
+		 */
+		if (vcpu_active_vq(vcpu) != vcpu_max_vq(vcpu))
+			vcpu_rewrite_sve(vcpu, vcpu_max_vq(vcpu),
+					 vcpu_active_vq(vcpu));
+	} else {
+		/*
+		 * A FPSIMD only system will store non-streaming guest
+		 * state in FPSIMD format when running the guest but
+		 * present to userspace via the SVE regset.
+		 */
+		if (!vcpu_sm_active(vcpu))
+			__sve_to_fpsimd(&vcpu->arch.ctxt.fp_regs,
+					vcpu->arch.sve_state,
+					vcpu_sme_max_vq(vcpu));
+	}
+
+	vcpu->arch.fp_state = FP_STATE_FREE;
+}
+
+void vcpu_fp_guest_to_user(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.fp_state == FP_STATE_USER_OWNED)
+		return;
+
+	if (!vcpu_fp_user_format_needed(vcpu))
+		return;
+
+	if (vcpu_has_sve(vcpu)) {
+		/*
+		 * The register state is stored in SVE format, rewrite
+		 * to the largest VL.
+		 */
+		if (vcpu_active_vq(vcpu) != vcpu_max_vq(vcpu))
+			vcpu_rewrite_sve(vcpu, vcpu_active_vq(vcpu),
+					 vcpu_max_vq(vcpu));
+	} else {
+		/*
+		 * A FPSIMD only system will store non-streaming guest
+		 * state in FPSIMD format when running the guest but
+		 * present to userspace via the SVE regset, rewrite
+		 * with zero padding.
+		 */
+		if (!vcpu_sm_active(vcpu)) {
+			memset(vcpu->arch.sve_state, 0,
+			       vcpu_sve_state_size(vcpu));
+			__fpsimd_to_sve(vcpu->arch.sve_state,
+					&vcpu->arch.ctxt.fp_regs,
+					vcpu_sme_max_vq(vcpu));
+		}
+	}
+
+	vcpu->arch.fp_state = FP_STATE_USER_OWNED;
+}
+
 /*
  * Prepare vcpu for saving the host's FPSIMD state and loading the guest's.
  * The actual loading is done by the FPSIMD access trap taken to hyp.
@@ -81,6 +252,8 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 
 	fpsimd_kvm_prepare();
 
+	vcpu_fp_user_to_guest(vcpu);
+
 	/*
 	 * We will check TIF_FOREIGN_FPSTATE just before entering the
 	 * guest in kvm_arch_vcpu_ctxflush_fp() and override this to
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 1d161fa7c2be..5f2845625c55 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -110,9 +110,9 @@ static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
 	/*
 	 * The KVM_REG_ARM64_SVE regs must be used instead of
 	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
-	 * SVE-enabled vcpus:
+	 * SVE or SME enabled vcpus:
 	 */
-	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
+	if (vcpu_has_vec(vcpu) && core_reg_offset_is_vreg(off))
 		return -EINVAL;
 
 	return size;
@@ -462,20 +462,20 @@ static int sve_reg_to_region(struct vec_state_reg_region *region,
 	reg_num = (reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
 
 	if (reg->id >= zreg_id_min && reg->id <= zreg_id_max) {
-		if (!vcpu_has_sve(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
+		if (!vcpu_has_vec(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
 			return -ENOENT;
 
-		vq = vcpu_sve_max_vq(vcpu);
+		vq = vcpu_max_vq(vcpu);
 
 		reqoffset = SVE_SIG_ZREG_OFFSET(vq, reg_num) -
 				SVE_SIG_REGS_OFFSET;
 		reqlen = KVM_SVE_ZREG_SIZE;
 		maxlen = SVE_SIG_ZREG_SIZE(vq);
 	} else if (reg->id >= preg_id_min && reg->id <= preg_id_max) {
-		if (!vcpu_has_sve(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
+		if (!vcpu_has_vec(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
 			return -ENOENT;
 
-		vq = vcpu_sve_max_vq(vcpu);
+		vq = vcpu_max_vq(vcpu);
 
 		reqoffset = SVE_SIG_PREG_OFFSET(vq, reg_num) -
 				SVE_SIG_REGS_OFFSET;
@@ -514,6 +514,8 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!kvm_arm_vcpu_vec_finalized(vcpu))
 		return -EPERM;
 
+	vcpu_fp_guest_to_user(vcpu);
+
 	if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
 			 region.klen) ||
 	    clear_user(uptr + region.klen, region.upad))
@@ -540,6 +542,8 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!kvm_arm_vcpu_vec_finalized(vcpu))
 		return -EPERM;
 
+	vcpu_fp_guest_to_user(vcpu);
+
 	if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
 			   region.klen))
 		return -EFAULT;

-- 
2.30.2


