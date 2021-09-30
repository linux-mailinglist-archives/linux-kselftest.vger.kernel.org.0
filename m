Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED31841E0BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353145AbhI3SRd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353326AbhI3SRd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C995F619E5;
        Thu, 30 Sep 2021 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025750;
        bh=c9z/i9YjkkeAD/Zgr3nLzAkR9jRTsIna+Ok2zemCOrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wq9pKSoI4f6I/hjTaAxqw7JdX9i0ajshVx2GnRY2qMT3HAHV3ez/PX3yUEzj6ExiM
         rjwQm7ipAc2ThbB7uR0o8+Xd8O/cs0lvk7Sdyq0p3cUKvbTd7caTkxy6FFrUuKr9Tl
         UU+24W/n2wk3HN2Y23ktIBYUOVcbANqoxTTUAiaAwepclkbKkWC5fjWF503uIPRoeO
         O5i8npZpTrFirkqBEV4XhabFTRZG/lSfOQVfzaY5CPFz8Xk2WlamcWgQh89qQA1Tss
         YXJ7ZWhyscIyiY+jKn6knTuv3NyL6onqXIp19rckn9FvUW1vkE4oJcyhByYrtnli8/
         HG7WegBnHFMxA==
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
Subject: [PATCH v1 05/38] arm64/sve: Use accessor functions for vector lengths in thread_struct
Date:   Thu, 30 Sep 2021 19:11:11 +0100
Message-Id: <20210930181144.10029-6-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10222; h=from:subject; bh=c9z/i9YjkkeAD/Zgr3nLzAkR9jRTsIna+Ok2zemCOrs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3F3vFBwU/MkCjdiSrNT/UBpokAd6I5ebix4fXF pEIj4pGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9xQAKCRAk1otyXVSH0LzdB/ 4+2wAaGxDWtndzSP13raIhjfiL0HBBbGPiaG7c8UWRNHV8Eqdt7s6t1clLiLUK4jSrm1cCVF7CNqKx SktaThqIXxYKBtH3/ehV9xSSWBBTwLI5iAGxpdoKke73PrVJS/ADeXRBpU4/2LRMw0osggjEQtqHxm UiDy8Q5aArAdRIoxSmOtuaQvT4T/Bw998ezrXQ1aYMtkF4m/t+XWDfe/ff8N91pVzmTKrCvlper9sG WmTeQ8hG5e8qoJ5zgG6II4VQDShuLvrD89WS4eyYXYwnecfsT+3ODQ95DeLc0zdBX4XfqElmqmdaUQ IJWGLCnwBDby+Ui8m8ccLhRm805LFG
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In a system with SME there are parallel vector length controls for SVE and
SME vectors which function in much the same way so it is desirable to
share the code for handling them as much as possible. In order to prepare
for doing this add a layer of accessor functions for the various VL related
operations on tasks.

Since almost all current interactions are actually via task->thread rather
than directly with the thread_info the accessors use that. Accessors are
provided for both generic and SVE specific usage, the generic accessors
should be used for cases where register state is being manipulated since
the registers are shared between streaming and regular SVE so we know that
when SME support is implemented we will always have to be in the appropriate
mode already and hence can generalise now.

Since we are using task_struct and we don't want to cause widespread
inclusion of sched.h the acessors are all out of line, it is hoped that
none of the uses are in a sufficiently critical path for this to be an
issue. Those that are most likely to present an issue are in the same
translation unit so hopefully the compiler may be able to inline anyway.

This is purely adding the layer of abstraction, additional work will be
needed to support tasks using SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h    |  2 +-
 arch/arm64/include/asm/processor.h | 10 ++++++
 arch/arm64/kernel/fpsimd.c         | 55 +++++++++++++++++++++---------
 arch/arm64/kernel/ptrace.c         |  4 +--
 arch/arm64/kernel/signal.c         |  6 ++--
 5 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index bf5bb881ef67..7d0204f77f90 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -62,7 +62,7 @@ static inline size_t sve_ffr_offset(int vl)
 
 static inline void *sve_pffr(struct thread_struct *thread)
 {
-	return (char *)thread->sve_state + sve_ffr_offset(thread->sve_vl);
+	return (char *)thread->sve_state + sve_ffr_offset(thread_get_sve_vl(thread));
 }
 
 extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ee2bdc1b9f5b..adb6a46a1fae 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -164,6 +164,16 @@ struct thread_struct {
 	u64			sctlr_user;
 };
 
+static inline unsigned int thread_get_sve_vl(struct thread_struct *thread)
+{
+	return thread->sve_vl;
+}
+
+unsigned int task_get_sve_vl(const struct task_struct *task);
+void task_set_sve_vl(struct task_struct *task, unsigned long vl);
+unsigned int task_get_sve_vl_onexec(const struct task_struct *task);
+void task_set_sve_vl_onexec(struct task_struct *task, unsigned long vl);
+
 #define SCTLR_USER_MASK                                                        \
 	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
 	 SCTLR_EL1_TCF0_MASK)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index dff71c041e85..b0acaa20457c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -228,6 +228,26 @@ static void sve_free(struct task_struct *task)
 	__sve_free(task);
 }
 
+unsigned int task_get_sve_vl(const struct task_struct *task)
+{
+	return task->thread.sve_vl;
+}
+
+void task_set_sve_vl(struct task_struct *task, unsigned long vl)
+{
+	task->thread.sve_vl = vl;
+}
+
+unsigned int task_get_sve_vl_onexec(const struct task_struct *task)
+{
+	return task->thread.sve_vl_onexec;
+}
+
+void task_set_sve_vl_onexec(struct task_struct *task, unsigned long vl)
+{
+	task->thread.sve_vl_onexec = vl;
+}
+
 /*
  * TIF_SVE controls whether a task can use SVE without trapping while
  * in userspace, and also the way a task's FPSIMD/SVE state is stored
@@ -290,7 +310,7 @@ static void task_fpsimd_load(void)
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE))
 		sve_load_state(sve_pffr(&current->thread),
 			       &current->thread.uw.fpsimd_state.fpsr, true,
-			       sve_vq_from_vl(current->thread.sve_vl) - 1);
+			       sve_vq_from_vl(task_get_sve_vl(current)) - 1);
 	else
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
 }
@@ -458,7 +478,7 @@ static void fpsimd_to_sve(struct task_struct *task)
 	if (!system_supports_sve())
 		return;
 
-	vq = sve_vq_from_vl(task->thread.sve_vl);
+	vq = sve_vq_from_vl(task_get_sve_vl(task));
 	__fpsimd_to_sve(sst, fst, vq);
 }
 
@@ -484,7 +504,7 @@ static void sve_to_fpsimd(struct task_struct *task)
 	if (!system_supports_sve())
 		return;
 
-	vq = sve_vq_from_vl(task->thread.sve_vl);
+	vq = sve_vq_from_vl(task_get_sve_vl(task));
 	for (i = 0; i < SVE_NUM_ZREGS; ++i) {
 		p = (__uint128_t const *)ZREG(sst, vq, i);
 		fst->vregs[i] = arm64_le128_to_cpu(*p);
@@ -499,7 +519,7 @@ static void sve_to_fpsimd(struct task_struct *task)
  */
 size_t sve_state_size(struct task_struct const *task)
 {
-	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(task->thread.sve_vl));
+	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(task_get_sve_vl(task)));
 }
 
 /*
@@ -574,7 +594,7 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 	if (!test_tsk_thread_flag(task, TIF_SVE))
 		return;
 
-	vq = sve_vq_from_vl(task->thread.sve_vl);
+	vq = sve_vq_from_vl(task_get_sve_vl(task));
 
 	memset(sst, 0, SVE_SIG_REGS_SIZE(vq));
 	__fpsimd_to_sve(sst, fst, vq);
@@ -602,16 +622,16 @@ int sve_set_vector_length(struct task_struct *task,
 
 	if (flags & (PR_SVE_VL_INHERIT |
 		     PR_SVE_SET_VL_ONEXEC))
-		task->thread.sve_vl_onexec = vl;
+		task_set_sve_vl_onexec(task, vl);
 	else
 		/* Reset VL to system default on next exec: */
-		task->thread.sve_vl_onexec = 0;
+		task_set_sve_vl_onexec(task, 0);
 
 	/* Only actually set the VL if not deferred: */
 	if (flags & PR_SVE_SET_VL_ONEXEC)
 		goto out;
 
-	if (vl == task->thread.sve_vl)
+	if (vl == task_get_sve_vl(task))
 		goto out;
 
 	/*
@@ -638,7 +658,7 @@ int sve_set_vector_length(struct task_struct *task,
 	 */
 	sve_free(task);
 
-	task->thread.sve_vl = vl;
+	task_set_sve_vl(task, vl);
 
 out:
 	update_tsk_thread_flag(task, TIF_SVE_VL_INHERIT,
@@ -658,9 +678,9 @@ static int sve_prctl_status(unsigned long flags)
 	int ret;
 
 	if (flags & PR_SVE_SET_VL_ONEXEC)
-		ret = current->thread.sve_vl_onexec;
+		ret = task_get_sve_vl_onexec(current);
 	else
-		ret = current->thread.sve_vl;
+		ret = task_get_sve_vl(current);
 
 	if (test_thread_flag(TIF_SVE_VL_INHERIT))
 		ret |= PR_SVE_VL_INHERIT;
@@ -960,7 +980,7 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	 */
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		unsigned long vq_minus_one =
-			sve_vq_from_vl(current->thread.sve_vl) - 1;
+			sve_vq_from_vl(task_get_sve_vl(current)) - 1;
 		sve_set_vq(vq_minus_one);
 		sve_flush_live(true, vq_minus_one);
 		fpsimd_bind_task_to_cpu();
@@ -1060,8 +1080,9 @@ void fpsimd_flush_thread(void)
 		 * If a bug causes this to go wrong, we make some noise and
 		 * try to fudge thread.sve_vl to a safe value here.
 		 */
-		vl = current->thread.sve_vl_onexec ?
-			current->thread.sve_vl_onexec : get_sve_default_vl();
+		vl = task_get_sve_vl_onexec(current);
+		if (!vl)
+			vl = get_sve_default_vl();
 
 		if (WARN_ON(!sve_vl_valid(vl)))
 			vl = SVE_VL_MIN;
@@ -1070,14 +1091,14 @@ void fpsimd_flush_thread(void)
 		if (WARN_ON(supported_vl != vl))
 			vl = supported_vl;
 
-		current->thread.sve_vl = vl;
+		task_set_sve_vl(current, vl);
 
 		/*
 		 * If the task is not set to inherit, ensure that the vector
 		 * length will be reset by a subsequent exec:
 		 */
 		if (!test_thread_flag(TIF_SVE_VL_INHERIT))
-			current->thread.sve_vl_onexec = 0;
+			task_set_sve_vl_onexec(current, 0);
 	}
 
 	put_cpu_fpsimd_context();
@@ -1122,7 +1143,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
-	last->sve_vl = current->thread.sve_vl;
+	last->sve_vl = task_get_sve_vl(current);
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index e26196a33cf4..95ff03a1b077 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -725,7 +725,7 @@ static void sve_init_header_from_task(struct user_sve_header *header,
 	if (test_tsk_thread_flag(target, TIF_SVE_VL_INHERIT))
 		header->flags |= SVE_PT_VL_INHERIT;
 
-	header->vl = target->thread.sve_vl;
+	header->vl = task_get_sve_vl(target);
 	vq = sve_vq_from_vl(header->vl);
 
 	header->max_vl = sve_max_vl;
@@ -820,7 +820,7 @@ static int sve_set(struct task_struct *target,
 		goto out;
 
 	/* Actual VL set may be less than the user asked for: */
-	vq = sve_vq_from_vl(target->thread.sve_vl);
+	vq = sve_vq_from_vl(task_get_sve_vl(target));
 
 	/* Registers: FPSIMD-only case */
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index c287b9407f28..aa1d9d7918da 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -227,7 +227,7 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 {
 	int err = 0;
 	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
-	unsigned int vl = current->thread.sve_vl;
+	unsigned int vl = task_get_sve_vl(current);
 	unsigned int vq = 0;
 
 	if (test_thread_flag(TIF_SVE))
@@ -266,7 +266,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
 		return -EFAULT;
 
-	if (sve.vl != current->thread.sve_vl)
+	if (sve.vl != task_get_sve_vl(current))
 		return -EINVAL;
 
 	if (sve.head.size <= sizeof(*user->sve)) {
@@ -597,7 +597,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			int vl = sve_max_vl;
 
 			if (!add_all)
-				vl = current->thread.sve_vl;
+				vl = task_get_sve_vl(current);
 
 			vq = sve_vq_from_vl(vl);
 		}
-- 
2.20.1

