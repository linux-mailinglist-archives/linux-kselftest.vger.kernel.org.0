Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128E76263CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKKVu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKVu5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:50:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653C73769
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E047162100
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0490DC433B5;
        Fri, 11 Nov 2022 21:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203455;
        bh=feYAW/OZGfAMtc0rPHOMdt7oiYR1Iy5pxL7FHo9QLg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQemNOnNkrkMb+SP4/aKBjnP+qVhiQytClB2NkMX9m0CcY/Dp3otJ/TXeDsoPsoHe
         rceijGiyaiV0spayGXOy8OrOsbt3vo7CqZdSydxonL0qu9ol07bYMoa00fuQoawbcJ
         ohh2JQO5I1dT9azXH2wQ12ZfrgK7IrhX5wctYeM/KT9RDDARVvKDpRWrwdnaUux0qf
         kBibZd2CEj9YToAc3UFm6Z9Ok9IMmq2dS/7Jya4CF4MmlFP7yfXTRL52hze+KBKkXB
         hY2n9nb278ZIaTRRPta6FjCwjEQ3lsAOEu6/JYIGWD9hyEhJWVw5zw06jEZXAyIEhj
         TVUxr5lnYVEhg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 01/21] arm64/sme: Rename za_state to sme_state
Date:   Fri, 11 Nov 2022 21:50:06 +0000
Message-Id: <20221111215026.813348-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11078; i=broonie@kernel.org; h=from:subject; bh=feYAW/OZGfAMtc0rPHOMdt7oiYR1Iy5pxL7FHo9QLg8=; b=owGbwMvMwMWocq27KDak/QLjabUkhuS8w30mBwoXtU3k3VtUICCk0+jJvDtq39cpJUxb7qil1x+a b6PXyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBM5Odj9r/ifgr52/oEEmTTdX8udv iqIr4yzFLkSTmD3/xLO/58S5nGqbHtpN5Vx10h65Ibll44pJn61b5g7xVuDg6xlcdfW9/V0nQu+XjU TMl3Vedm1dqPl8IqWe+FRIRUHRCLOWqrdTs0eNbE/uKyalOrY7nbxGJXKZWvXi7L1Mfo9KYzKNfEmX eiilbD6+5WO6uJRhwRHtsM/j4tyJqiX9112mTO7K6Ih3fez19frrBsdteRwzZicv94nsV/Ubltp33n J5N1WKlStNq6H4tSXlXpxCif2Lo3yMa1WH+XTFBftajM27kLXRny9yofrsoRPqt/xv9M118he8Fvt9 1DzyxjMT5hG8ds/EAht8zaY/85AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for adding support for storage for ZT0 to the thread_struct
rename za_state to sme_state. Since ZT0 is accessible when PSTATE.ZA is
set just like ZA itself we will extend the allocation done for ZA to
cover it, avoiding the need to further expand task_struct for non-SME
tasks.

No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h    | 13 ++++++----
 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/kernel/fpsimd.c         | 40 +++++++++++++++---------------
 arch/arm64/kernel/process.c        | 11 ++++----
 arch/arm64/kernel/ptrace.c         |  6 ++---
 arch/arm64/kernel/signal.c         |  8 +++---
 6 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 6f86b7ab6c28..a18a86ccfd82 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -346,14 +346,17 @@ extern int sme_get_current_vl(void);
 
 /*
  * Return how many bytes of memory are required to store the full SME
- * specific state (currently just ZA) for task, given task's currently
- * configured vector length.
+ * specific state for task, given task's currently configured vector
+ * length.
  */
-static inline size_t za_state_size(struct task_struct const *task)
+static inline size_t sme_state_size(struct task_struct const *task)
 {
 	unsigned int vl = task_get_sme_vl(task);
+	size_t size;
 
-	return ZA_SIG_REGS_SIZE(sve_vq_from_vl(vl));
+	size = ZA_SIG_REGS_SIZE(sve_vq_from_vl(vl));
+
+	return size;
 }
 
 #else
@@ -373,7 +376,7 @@ static inline int sme_max_virtualisable_vl(void) { return 0; }
 static inline int sme_set_current_vl(unsigned long arg) { return -EINVAL; }
 static inline int sme_get_current_vl(void) { return -EINVAL; }
 
-static inline size_t za_state_size(struct task_struct const *task)
+static inline size_t sme_state_size(struct task_struct const *task)
 {
 	return 0;
 }
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 445aa3af3b76..923a896229c8 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -154,7 +154,7 @@ struct thread_struct {
 
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
-	void			*za_state;	/* ZA register, if any */
+	void			*sme_state;	/* ZA and ZT state, if any */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 23834d96d1e7..b677b5a3e0f6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -121,7 +121,7 @@
 struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
 	void *sve_state;
-	void *za_state;
+	void *sme_state;
 	u64 *svcr;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
@@ -307,7 +307,7 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
 /*
  * TIF_SME controls whether a task can use SME without trapping while
  * in userspace, when TIF_SME is set then we must have storage
- * alocated in sve_state and za_state to store the contents of both ZA
+ * alocated in sve_state and sme_state to store the contents of both ZA
  * and the SVE registers for both streaming and non-streaming modes.
  *
  * If both SVCR.ZA and SVCR.SM are disabled then at any point we
@@ -396,7 +396,7 @@ static void task_fpsimd_load(void)
 		write_sysreg_s(current->thread.svcr, SYS_SVCR);
 
 		if (thread_za_enabled(&current->thread))
-			za_load_state(current->thread.za_state);
+			za_load_state(current->thread.sme_state);
 
 		if (thread_sm_enabled(&current->thread)) {
 			restore_sve_regs = true;
@@ -449,7 +449,7 @@ static void fpsimd_save(void)
 		*svcr = read_sysreg_s(SYS_SVCR);
 
 		if (*svcr & SVCR_ZA_MASK)
-			za_save_state(last->za_state);
+			za_save_state(last->sme_state);
 
 		/* If we are in streaming mode override regular SVE. */
 		if (*svcr & SVCR_SM_MASK) {
@@ -1213,30 +1213,30 @@ void fpsimd_release_task(struct task_struct *dead_task)
 #ifdef CONFIG_ARM64_SME
 
 /*
- * Ensure that task->thread.za_state is allocated and sufficiently large.
+ * Ensure that task->thread.sme_state is allocated and sufficiently large.
  *
  * This function should be used only in preparation for replacing
- * task->thread.za_state with new data.  The memory is always zeroed
+ * task->thread.sme_state with new data.  The memory is always zeroed
  * here to prevent stale data from showing through: this is done in
  * the interest of testability and predictability, the architecture
  * guarantees that when ZA is enabled it will be zeroed.
  */
 void sme_alloc(struct task_struct *task)
 {
-	if (task->thread.za_state) {
-		memset(task->thread.za_state, 0, za_state_size(task));
+	if (task->thread.sme_state) {
+		memset(task->thread.sme_state, 0, sme_state_size(task));
 		return;
 	}
 
 	/* This could potentially be up to 64K. */
-	task->thread.za_state =
-		kzalloc(za_state_size(task), GFP_KERNEL);
+	task->thread.sme_state =
+		kzalloc(sme_state_size(task), GFP_KERNEL);
 }
 
 static void sme_free(struct task_struct *task)
 {
-	kfree(task->thread.za_state);
-	task->thread.za_state = NULL;
+	kfree(task->thread.sme_state);
+	task->thread.sme_state = NULL;
 }
 
 void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
@@ -1443,7 +1443,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 
 	sve_alloc(current, false);
 	sme_alloc(current);
-	if (!current->thread.sve_state || !current->thread.za_state) {
+	if (!current->thread.sve_state || !current->thread.sme_state) {
 		force_sig(SIGKILL);
 		return;
 	}
@@ -1564,7 +1564,7 @@ static void fpsimd_flush_thread_vl(enum vec_type type)
 void fpsimd_flush_thread(void)
 {
 	void *sve_state = NULL;
-	void *za_state = NULL;
+	void *sme_state = NULL;
 
 	if (!system_supports_fpsimd())
 		return;
@@ -1589,8 +1589,8 @@ void fpsimd_flush_thread(void)
 		clear_thread_flag(TIF_SME);
 
 		/* Defer kfree() while in atomic context */
-		za_state = current->thread.za_state;
-		current->thread.za_state = NULL;
+		sme_state = current->thread.sme_state;
+		current->thread.sme_state = NULL;
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
 		current->thread.svcr = 0;
@@ -1598,7 +1598,7 @@ void fpsimd_flush_thread(void)
 
 	put_cpu_fpsimd_context();
 	kfree(sve_state);
-	kfree(za_state);
+	kfree(sme_state);
 }
 
 /*
@@ -1640,7 +1640,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
-	last->za_state = current->thread.za_state;
+	last->sme_state = current->thread.sme_state;
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
@@ -1666,7 +1666,7 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl, void *za_state,
+			      unsigned int sve_vl, void *sme_state,
 			      unsigned int sme_vl, u64 *svcr)
 {
 	struct fpsimd_last_state_struct *last =
@@ -1678,7 +1678,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->st = st;
 	last->svcr = svcr;
 	last->sve_state = sve_state;
-	last->za_state = za_state;
+	last->sme_state = sme_state;
 	last->sve_vl = sve_vl;
 	last->sme_vl = sme_vl;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 044a7d7f1f6a..5cfb876c76ee 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -318,16 +318,17 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 						GFP_KERNEL);
 		if (!dst->thread.sve_state)
 			return -ENOMEM;
-		dst->thread.za_state = kmemdup(src->thread.za_state,
-					       za_state_size(src),
-					       GFP_KERNEL);
-		if (!dst->thread.za_state) {
+
+		dst->thread.sme_state = kmemdup(src->thread.sme_state,
+						sme_state_size(src),
+						GFP_KERNEL);
+		if (!dst->thread.sme_state) {
 			kfree(dst->thread.sve_state);
 			dst->thread.sve_state = NULL;
 			return -ENOMEM;
 		}
 	} else {
-		dst->thread.za_state = NULL;
+		dst->thread.sme_state = NULL;
 		clear_tsk_thread_flag(dst, TIF_SME);
 	}
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c2fb5755bbec..85105375bea5 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1052,7 +1052,7 @@ static int za_get(struct task_struct *target,
 	if (thread_za_enabled(&target->thread)) {
 		start = end;
 		end = ZA_PT_SIZE(vq);
-		membuf_write(&to, target->thread.za_state, end - start);
+		membuf_write(&to, target->thread.sme_state, end - start);
 	}
 
 	/* Zero any trailing padding */
@@ -1106,7 +1106,7 @@ static int za_set(struct task_struct *target,
 
 	/* Allocate/reinit ZA storage */
 	sme_alloc(target);
-	if (!target->thread.za_state) {
+	if (!target->thread.sme_state) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1131,7 +1131,7 @@ static int za_set(struct task_struct *target,
 	start = ZA_PT_ZA_OFFSET;
 	end = ZA_PT_SIZE(vq);
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 target->thread.za_state,
+				 target->thread.sme_state,
 				 start, end);
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 9ad911f1647c..335bc7294b3c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -386,7 +386,7 @@ static int preserve_za_context(struct za_context __user *ctx)
 		 * fpsimd_signal_preserve_current_state().
 		 */
 		err |= __copy_to_user((char __user *)ctx + ZA_SIG_REGS_OFFSET,
-				      current->thread.za_state,
+				      current->thread.sme_state,
 				      ZA_SIG_REGS_SIZE(vq));
 	}
 
@@ -417,7 +417,7 @@ static int restore_za_context(struct user_ctxs *user)
 
 	/*
 	 * Careful: we are about __copy_from_user() directly into
-	 * thread.za_state with preemption enabled, so protection is
+	 * thread.sme_state with preemption enabled, so protection is
 	 * needed to prevent a racing context switch from writing stale
 	 * registers back over the new data.
 	 */
@@ -426,13 +426,13 @@ static int restore_za_context(struct user_ctxs *user)
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
 	sme_alloc(current);
-	if (!current->thread.za_state) {
+	if (!current->thread.sme_state) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		clear_thread_flag(TIF_SME);
 		return -ENOMEM;
 	}
 
-	err = __copy_from_user(current->thread.za_state,
+	err = __copy_from_user(current->thread.sme_state,
 			       (char __user const *)user->za +
 					ZA_SIG_REGS_OFFSET,
 			       ZA_SIG_REGS_SIZE(vq));
-- 
2.30.2

