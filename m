Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A3432729
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTMd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CED460ED3;
        Mon, 18 Oct 2021 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584221;
        bh=tfNX4HZvR9myIHsB1H1Yxc+FO0aOoJuRDQD4iVzJ4xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N05otQ7kXwv5abGBpIBisVmFpe1yPqncAPV7zGGWS4PelO0k80Tqxj6AsMdJaQqPs
         Se+E4AGaninhcrQw5H5X4y0pASvvL6MM9h/70BSC0W2ulD5DRqtfEDIJDr2dBwJQ9d
         EZ5gxCwtxMs+mMvuc4g4gYD9sczwRloXG+4nZ+FHrlxsYouIZ0v9RlkCiHQodys3K5
         AZLA2mB+eWhioKDULnXg0pBhRxVmS3XkrLxt/2OYVSrwzLr5c2Fn7m/pUAd9QomNQj
         7Ft1YLlZLjBBR3FuFbSHAle10KgabLUt90Jq6EwxyEDV6ZMvpR4dNurMGW/lAcj1D2
         Mb6fpfS+Fff3Q==
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
Subject: [PATCH v2 06/42] arm64/sve: Use accessor functions for vector lengths in thread_struct
Date:   Mon, 18 Oct 2021 20:08:22 +0100
Message-Id: <20211018190858.2119209-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10229; h=from:subject; bh=tfNX4HZvR9myIHsB1H1Yxc+FO0aOoJuRDQD4iVzJ4xo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYsEsBF40vws8LpNdtBkeJcQpDpBboNne/j2fPA JgPqtuOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GLAAKCRAk1otyXVSH0Po3B/ 4jSr+HOYVM5sodi1A2qOV5AiyVlRcZxR0eJjqzhCXPLLLuBSVMGWq7CpTlcQ3Q8Njqky1orIoZcjQL iZBd0gWjKiW/pxmPpZ/HjTQIPRYHvxPJmmcYuPbrlvzPHeUJ6WOBYtXBh4Tbvo41ksUlF6qCLUP3mL mx25PNLd1P0mGId/r9YsmvQ2y8JfT3v5zYBPkFOtCMF4flIxJfe5Y6aFhuCEai6LQ9GM2WIEhQ82UF 6b/72VCUKMlBUZ/xb1Z6ibBSR0a1LPVpJ2+W5f5jWe/QN80F6hSiUtBF7ezm8MOe7GEl8HL9Y2vNpq GEC5ec3YaWi02n/nfmR2NuKMoN7iXp
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
index 7f8a44a9a5e6..d164e2f35837 100644
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
index 25aa6f2386a1..f7eb54e9a8b8 100644
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
 static size_t sve_state_size(struct task_struct const *task)
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
2.30.2

