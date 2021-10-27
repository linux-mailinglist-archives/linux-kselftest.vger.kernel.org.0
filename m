Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3718C43D111
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhJ0SxX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243650AbhJ0SxW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 999FC610CA;
        Wed, 27 Oct 2021 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360657;
        bh=OgWFl0NcJl1hoVw9TFF3mgC+KMbr8tQx7r2olhnm1Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYLLc0oNj43wnVhVp/8VOjaoFbMP2Llbn1u57WBraDl8mBvAoxnaVhi6FCDKM1xh2
         5EOs3OoYhhanJYl+q2ZV3m5YFJzueiE2AMHVby+9WrrpyNsgGJaVPO64I1TnSAm3tr
         7+JBRe6Dy2PMKGqqtMvd6X/Uoutqb6n0i/jVWR+ar473lUrgaLsxu0zWS2Wbz4qnWm
         N+g0qIA7RLQ2D19TXb0/cHAhrHyoAnGkFJrheuxEr8djyisBniilO4qi37W02vRS8W
         yAs+AWJ2soxeXj9zGEWdPRmnOP9+91hwRomkx7P59IK6ul1dzD3uAUKm39tRucB7Jb
         rPPu4rYJAnQQA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 02/38] arm64/sve: Generalise vector length configuration prctl() for SME
Date:   Wed, 27 Oct 2021 19:43:48 +0100
Message-Id: <20211027184424.166237-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7467; h=from:subject; bh=OgWFl0NcJl1hoVw9TFF3mgC+KMbr8tQx7r2olhnm1Bk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3ov+c3McP/EjETtxm+6z0SK3JZUrSVm7opTkPn 8XANy0eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd6AAKCRAk1otyXVSH0CTwB/ 458pwpjkOYd4YXKNnJ6jbpIY6PxwT5Uk/bw6KZtQj8IPozAeiLT7FROTGJUcThCoOC+C2HWFLrQ5SE CSdzDKUu/XUoHeFlDFpAa5STCg4c0A3Mi6ai1W+RPOWDCJAldZ/ASiM4cLL9x1Dsa9sPgFbq95acRH WjfFVUVThhkB6boE/vUSug/V/hwei9eWcb0tKETU8QNFEY3ZUQcyqri/lYr+mR5pIJmIhwj22szhVy fpMyG36tDmkjQnK0AoKkKw0gV4FN2S0CAsUdhnq8HLX64X+f88TqCjjmyvLy0vmwrj8HUnkzsKuR0C LlnnnMun+uIpjEKrRi3tcCyEmt/VwT
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for adding SME support update the bulk of the implementation
for the vector length configuration prctl() calls to be independent of
vector type.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h |  6 ++---
 arch/arm64/kernel/fpsimd.c      | 47 ++++++++++++++++++---------------
 arch/arm64/kernel/ptrace.c      |  4 +--
 arch/arm64/kvm/reset.c          |  8 +++---
 4 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index dbb4b30a5648..cb24385e3632 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -51,8 +51,8 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
 
-/* Maximum VL that SVE VL-agnostic software can transparently support */
-#define SVE_VL_ARCH_MAX 0x100
+/* Maximum VL that SVE/SME VL-agnostic software can transparently support */
+#define VL_ARCH_MAX 0x100
 
 /* Offset of FFR in the SVE register dump */
 static inline size_t sve_ffr_offset(int vl)
@@ -122,7 +122,7 @@ extern void fpsimd_sync_to_sve(struct task_struct *task);
 extern void sve_sync_to_fpsimd(struct task_struct *task);
 extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
 
-extern int sve_set_vector_length(struct task_struct *task,
+extern int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 				 unsigned long vl, unsigned long flags);
 
 extern int sve_set_current_vl(unsigned long arg);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 23e575c4e580..4a98cc3b1df1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -632,7 +632,7 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 	__fpsimd_to_sve(sst, fst, vq);
 }
 
-int sve_set_vector_length(struct task_struct *task,
+int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 			  unsigned long vl, unsigned long flags)
 {
 	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
@@ -643,33 +643,35 @@ int sve_set_vector_length(struct task_struct *task,
 		return -EINVAL;
 
 	/*
-	 * Clamp to the maximum vector length that VL-agnostic SVE code can
-	 * work with.  A flag may be assigned in the future to allow setting
-	 * of larger vector lengths without confusing older software.
+	 * Clamp to the maximum vector length that VL-agnostic code
+	 * can work with.  A flag may be assigned in the future to
+	 * allow setting of larger vector lengths without confusing
+	 * older software.
 	 */
-	if (vl > SVE_VL_ARCH_MAX)
-		vl = SVE_VL_ARCH_MAX;
+	if (vl > VL_ARCH_MAX)
+		vl = VL_ARCH_MAX;
 
-	vl = find_supported_vector_length(ARM64_VEC_SVE, vl);
+	vl = find_supported_vector_length(type, vl);
 
 	if (flags & (PR_SVE_VL_INHERIT |
 		     PR_SVE_SET_VL_ONEXEC))
-		task_set_sve_vl_onexec(task, vl);
+		task_set_vl_onexec(task, type, vl);
 	else
 		/* Reset VL to system default on next exec: */
-		task_set_sve_vl_onexec(task, 0);
+		task_set_vl_onexec(task, type, 0);
 
 	/* Only actually set the VL if not deferred: */
 	if (flags & PR_SVE_SET_VL_ONEXEC)
 		goto out;
 
-	if (vl == task_get_sve_vl(task))
+	if (vl == task_get_vl(task, type))
 		goto out;
 
 	/*
 	 * To ensure the FPSIMD bits of the SVE vector registers are preserved,
 	 * write any live register state back to task_struct, and convert to a
-	 * non-SVE thread.
+	 * regular FPSIMD thread.  Since the vector length can only be changed
+	 * with a syscall we can't be in streaming mode while reconfiguring.
 	 */
 	if (task == current) {
 		get_cpu_fpsimd_context();
@@ -690,10 +692,10 @@ int sve_set_vector_length(struct task_struct *task,
 	 */
 	sve_free(task);
 
-	task_set_sve_vl(task, vl);
+	task_set_vl(task, type, vl);
 
 out:
-	update_tsk_thread_flag(task, TIF_SVE_VL_INHERIT,
+	update_tsk_thread_flag(task, vec_vl_inherit_flag(type),
 			       flags & PR_SVE_VL_INHERIT);
 
 	return 0;
@@ -701,20 +703,21 @@ int sve_set_vector_length(struct task_struct *task,
 
 /*
  * Encode the current vector length and flags for return.
- * This is only required for prctl(): ptrace has separate fields
+ * This is only required for prctl(): ptrace has separate fields.
+ * SVE and SME use the same bits for _ONEXEC and _INHERIT.
  *
- * flags are as for sve_set_vector_length().
+ * flags are as for vec_set_vector_length().
  */
-static int sve_prctl_status(unsigned long flags)
+static int vec_prctl_status(enum vec_type type, unsigned long flags)
 {
 	int ret;
 
 	if (flags & PR_SVE_SET_VL_ONEXEC)
-		ret = task_get_sve_vl_onexec(current);
+		ret = task_get_vl_onexec(current, type);
 	else
-		ret = task_get_sve_vl(current);
+		ret = task_get_vl(current, type);
 
-	if (test_thread_flag(TIF_SVE_VL_INHERIT))
+	if (test_thread_flag(vec_vl_inherit_flag(type)))
 		ret |= PR_SVE_VL_INHERIT;
 
 	return ret;
@@ -732,11 +735,11 @@ int sve_set_current_vl(unsigned long arg)
 	if (!system_supports_sve() || is_compat_task())
 		return -EINVAL;
 
-	ret = sve_set_vector_length(current, vl, flags);
+	ret = vec_set_vector_length(current, ARM64_VEC_SVE, vl, flags);
 	if (ret)
 		return ret;
 
-	return sve_prctl_status(flags);
+	return vec_prctl_status(ARM64_VEC_SVE, flags);
 }
 
 /* PR_SVE_GET_VL */
@@ -745,7 +748,7 @@ int sve_get_current_vl(void)
 	if (!system_supports_sve() || is_compat_task())
 		return -EINVAL;
 
-	return sve_prctl_status(0);
+	return vec_prctl_status(ARM64_VEC_SVE, 0);
 }
 
 static void vec_probe_vqs(struct vl_info *info,
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 88a9034fb9b5..716dde289446 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -812,9 +812,9 @@ static int sve_set(struct task_struct *target,
 
 	/*
 	 * Apart from SVE_PT_REGS_MASK, all SVE_PT_* flags are consumed by
-	 * sve_set_vector_length(), which will also validate them for us:
+	 * vec_set_vector_length(), which will also validate them for us:
 	 */
-	ret = sve_set_vector_length(target, header.vl,
+	ret = vec_set_vector_length(target, ARM64_VEC_SVE, header.vl,
 		((unsigned long)header.flags & ~SVE_PT_REGS_MASK) << 16);
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 09cd30a9aafb..0f6741c80226 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -52,10 +52,10 @@ int kvm_arm_init_sve(void)
 		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
 		 * to be extended with multiple register slice support in
 		 * order to support vector lengths greater than
-		 * SVE_VL_ARCH_MAX:
+		 * VL_ARCH_MAX:
 		 */
-		if (WARN_ON(kvm_sve_max_vl > SVE_VL_ARCH_MAX))
-			kvm_sve_max_vl = SVE_VL_ARCH_MAX;
+		if (WARN_ON(kvm_sve_max_vl > VL_ARCH_MAX))
+			kvm_sve_max_vl = VL_ARCH_MAX;
 
 		/*
 		 * Don't even try to make use of vector lengths that
@@ -103,7 +103,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 	 * set_sve_vls().  Double-check here just to be sure:
 	 */
 	if (WARN_ON(!sve_vl_valid(vl) || vl > sve_max_virtualisable_vl() ||
-		    vl > SVE_VL_ARCH_MAX))
+		    vl > VL_ARCH_MAX))
 		return -EIO;
 
 	buf = kzalloc(SVE_SIG_REGS_SIZE(sve_vq_from_vl(vl)), GFP_KERNEL);
-- 
2.30.2

