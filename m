Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DE41E0C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353329AbhI3SRs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353324AbhI3SRs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8208619E5;
        Thu, 30 Sep 2021 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025765;
        bh=Ds6Ok6cyT0TVU/rm+TKPRTRqmCBG9LLrn3T5OWU46UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ct9SCBRZaLt3w/XHz9QAdz9436ut+b5sBPFt+cCyJZpxNSP6oQhYmVIRhPle2FSuw
         VTj1Gp4DVdnUhfAAQO93vrwoiF5LKAa6a/l8y9FaxiL35UUsgLNpyhJtFmZ+SSg7hy
         ATPjhN/PvLib4qXyh6hf1omLXhCbjTdXj/GkN4oiJGTTLGo5Vsxx1d4yBjuVxXWxsj
         P0T3SujMHyknm7OSl6GP0nnr4Pgn+gf987TScaNQJuMB+oNDlCTahPetfDM55+JEDV
         qjmAWXzH5Zgly3b1hU6nCN0M4OMxUNOJUlymAtxtLmThl2hkZU6x5TWIk11CyP4dw7
         8aLV/MD4Fj5jQ==
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
Subject: [PATCH v1 10/38] arm64/sve: Generalise vector length configuration prctl() for SME
Date:   Thu, 30 Sep 2021 19:11:16 +0100
Message-Id: <20210930181144.10029-11-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7651; h=from:subject; bh=Ds6Ok6cyT0TVU/rm+TKPRTRqmCBG9LLrn3T5OWU46UQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3JJYjih7kQFjiwbCQZoj9YLc5VSXQBnLN/RrD2 SOrlbt6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9yQAKCRAk1otyXVSH0InmB/ 9TAU/BTXykkJT1SPeB3c/FZ+Y4y/N9ojVmMZmZxJ1B08WA1J8P2yrUznNdM1RSXPdgbgL2rNjC4v9B oVReXu6Rn12Y147PL9m4Wy81CkNM7ENgFbnNdA2RWhDCllrvnJXQCPouUD+/rNvqNhC1YhHn6CXVuJ hQCa2uyAzsfLPRgNIzb0/45SpGhkQtVfBkOKHBOeOsgGlVP1lgjuz0iYNnb5uegcldwqMH/ZjaTkrI W6myz9d8Ui0J7JbNzCNgiOYWbXTfz2YFauIF802jWTWxHwHJyPxdKFGUc1YavfrQcQ9LAvAfZfkfeq OEBPkrpnh6VgWHpUAKqOavVYKHtnzi
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
 arch/arm64/include/asm/fpsimd.h |  8 +++---
 arch/arm64/kernel/fpsimd.c      | 47 ++++++++++++++++++---------------
 arch/arm64/kernel/ptrace.c      |  4 +--
 arch/arm64/kvm/reset.c          |  8 +++---
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index a18f409dec33..802597140121 100644
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
@@ -103,11 +103,13 @@ extern void fpsimd_sync_to_sve(struct task_struct *task);
 extern void sve_sync_to_fpsimd(struct task_struct *task);
 extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
 
-extern int sve_set_vector_length(struct task_struct *task,
+extern int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 				 unsigned long vl, unsigned long flags);
 
 extern int sve_set_current_vl(unsigned long arg);
 extern int sve_get_current_vl(void);
+extern int sme_set_current_vl(unsigned long arg);
+extern int sme_get_current_vl(void);
 
 static inline void sve_user_disable(void)
 {
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e3a88fba390d..b3d4786e2601 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -635,7 +635,7 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 	__fpsimd_to_sve(sst, fst, vq);
 }
 
-int sve_set_vector_length(struct task_struct *task,
+int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 			  unsigned long vl, unsigned long flags)
 {
 	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
@@ -646,33 +646,35 @@ int sve_set_vector_length(struct task_struct *task,
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
@@ -693,10 +695,10 @@ int sve_set_vector_length(struct task_struct *task,
 	 */
 	sve_free(task);
 
-	task_set_sve_vl(task, vl);
+	task_set_vl(task, type, vl);
 
 out:
-	update_tsk_thread_flag(task, TIF_SVE_VL_INHERIT,
+	update_tsk_thread_flag(task, vec_vl_inherit_flag(type),
 			       flags & PR_SVE_VL_INHERIT);
 
 	return 0;
@@ -704,20 +706,21 @@ int sve_set_vector_length(struct task_struct *task,
 
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
@@ -735,11 +738,11 @@ int sve_set_current_vl(unsigned long arg)
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
@@ -748,7 +751,7 @@ int sve_get_current_vl(void)
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
2.20.1

