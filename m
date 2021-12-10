Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01347090F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhLJSrT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CCBC061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16187B8275C
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6643FC341C7;
        Fri, 10 Dec 2021 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161820;
        bh=Ft/atRfkRMmtdUw6GzWg5UcvdauLRRjBMgFvM3KPpX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xj1xF6Rpz2Aqws2Eq/bjB7KZVxkRVQaBsh3q6+F8HcKo0W0n497ItBXiNIr9bZrue
         TtXlNAE85yf0utlaiw6EnxOlcViEFjyu3A7CA87ikDuUctv3wMMDbZs76dNKf6uKzS
         Ss7+JzpyRZN4O1SfJ262LggnXkieJ+hKtL6mhx4iyf+0zZ868yuGpSn+WNXXvSZraN
         QKaRQq+TP4ZaJibDe+vK+MNqloS1WqZrNYEqgal7DBUuPcnbL0bDjrlzRXayVbNGGV
         QINRwDJ14YJfxM8MUGfQctQJrUykb43UWNlebGvgTH31+pjv3yXHjFFiCNwBQDaUrd
         ohzIFejlecjSQ==
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
Subject: [PATCH v7 02/37] arm64/sve: Generalise vector length configuration prctl() for SME
Date:   Fri, 10 Dec 2021 18:40:58 +0000
Message-Id: <20211210184133.320748-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7475; h=from:subject; bh=Ft/atRfkRMmtdUw6GzWg5UcvdauLRRjBMgFvM3KPpX4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs58/OnautIP3FfL6qIenj1zyswpJyc/bxLuKeQfh 5ZGofK+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfPwAKCRAk1otyXVSH0HsJB/ 9cExdn/Gy/P7ymT2tITNvqQqHel0+aOVwPQwmlMdqPRAd+SR129G/MzcoxhB2L6trTsomch0LBFPnx ETSozwqZXnOfhMbTMzVBxzfqTdeqKPVjOeSRowr2yGboojIJpWOFFfGM+f0VoKdS/r4LfWPmGEYiHZ jo6LPMqguznQ078wJOHtvuVnL3HF+uXNbUgwckiiOPzW6I4zXnxW/RSHg/SpMeW3Yzu/gjvnkrwnJn W2sOwp+wlA/g6Toc1xM8RwkSuc11xElWQUqSPyu6itExvWfUH1xWKuJeyYyZMTKrskgNJWxnidXXE6 B/xwe5iaNZUznTzzzro5ztcYZd3lAa
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
index 426bd7fbc3fd..27386f0d81e4 100644
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
 
 	buf = kzalloc(SVE_SIG_REGS_SIZE(sve_vq_from_vl(vl)), GFP_KERNEL_ACCOUNT);
-- 
2.30.2

