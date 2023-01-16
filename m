Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCC66C593
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjAPQHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjAPQHD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:07:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5808424123;
        Mon, 16 Jan 2023 08:05:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19D75B80DC7;
        Mon, 16 Jan 2023 16:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739AAC433F1;
        Mon, 16 Jan 2023 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885118;
        bh=oOgTsPmP77gfZ9aN3fKhVcLZdopUgO5oDN6uiNQXtwo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TnaFV6+rjXQDdha5PjLz7zIA20ifHCn90xAwVauuKMvEDcZ8JONwVpTZiRnE5YO+H
         5mUOcOnT/J1SC/R2sg7886ofu/2zLAtWRpktwUA6TLnWA87L1vos7xDxrXoo3brDdK
         9WAN0SLC0tcKXutftFarVUPXK7SGBhJE3eJbcPmKa7BEqaHizmlgYXCkr6I75OaDsQ
         4SQu39gR8n9MBcRTzm0ZnlwINCMqBncGwMUYU5ndyDDMN5feEWqg00jy2zE/Ze38Oj
         HF/55RPZeWA/Hrm2WSrEz2CDhHHfjqMHiQMqAq6KdOhduScyx/cOBoVm3gEWUitDfP
         IIoEbBvGQsgvg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:36 +0000
Subject: [PATCH v4 01/21] arm64/sme: Rename za_state to sme_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-1-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=11499; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oOgTsPmP77gfZ9aN3fKhVcLZdopUgO5oDN6uiNQXtwo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWiU4cWEb06aVAijUfAjOySAyuZKEnXTGvCO9bl
 AmCI82WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1ogAKCRAk1otyXVSH0MMWB/
 wPMiJtKxbMmXU+37pnDzflwMvU9MNXmuitEX894EJsN9/vPadj7tpwVnHCFVm88R0LIKriyBgkGwAk
 ADDRW7cM2X5rE7z46fXaf5qK7zRVrH5zOLH6agmETun/tf8LnhbP48p/JsuuKKj6mIinuBqcjG6Gb/
 Zra6s9p2gZDRc1vagW+yDk90PZq21vRG7Vyc4JtUgLibf6Cf7c8l5P/NDSEzwqXfYE7icGgpwgvBdP
 /J2FB772eQvU2JxBVprLEUebu0T9YITvimGDwxov1MSDmsBHKSZ8Ob/MbKM3zznhDv7pALQgTh0giP
 4qKPjvtREMknZxIfT3VbjGp5qNwdvC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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
 arch/arm64/include/asm/fpsimd.h    | 15 +++++++++------
 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/kernel/fpsimd.c         | 34 +++++++++++++++++-----------------
 arch/arm64/kernel/process.c        | 13 +++++++------
 arch/arm64/kernel/ptrace.c         |  6 +++---
 arch/arm64/kernel/signal.c         |  8 ++++----
 arch/arm64/kvm/fpsimd.c            |  2 +-
 7 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index e6fa1e2982c8..2d3fa80cd95d 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -61,7 +61,7 @@ extern void fpsimd_kvm_prepare(void);
 struct cpu_fp_state {
 	struct user_fpsimd_state *st;
 	void *sve_state;
-	void *za_state;
+	void *sme_state;
 	u64 *svcr;
 	unsigned int sve_vl;
 	unsigned int sme_vl;
@@ -355,14 +355,17 @@ extern int sme_get_current_vl(void);
 
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
@@ -382,7 +385,7 @@ static inline int sme_max_virtualisable_vl(void) { return 0; }
 static inline int sme_set_current_vl(unsigned long arg) { return -EINVAL; }
 static inline int sme_get_current_vl(void) { return -EINVAL; }
 
-static inline size_t za_state_size(struct task_struct const *task)
+static inline size_t sme_state_size(struct task_struct const *task)
 {
 	return 0;
 }
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index d51b32a69309..3918f2a67970 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -161,7 +161,7 @@ struct thread_struct {
 	enum fp_type		fp_type;	/* registers FPSIMD or SVE? */
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
-	void			*za_state;	/* ZA register, if any */
+	void			*sme_state;	/* ZA and ZT state, if any */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index dcc81e7200d4..9e168a9eb615 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -299,7 +299,7 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
 /*
  * TIF_SME controls whether a task can use SME without trapping while
  * in userspace, when TIF_SME is set then we must have storage
- * alocated in sve_state and za_state to store the contents of both ZA
+ * alocated in sve_state and sme_state to store the contents of both ZA
  * and the SVE registers for both streaming and non-streaming modes.
  *
  * If both SVCR.ZA and SVCR.SM are disabled then at any point we
@@ -429,7 +429,7 @@ static void task_fpsimd_load(void)
 		write_sysreg_s(current->thread.svcr, SYS_SVCR);
 
 		if (thread_za_enabled(&current->thread))
-			za_load_state(current->thread.za_state);
+			za_load_state(current->thread.sme_state);
 
 		if (thread_sm_enabled(&current->thread))
 			restore_ffr = system_supports_fa64();
@@ -490,7 +490,7 @@ static void fpsimd_save(void)
 		*svcr = read_sysreg_s(SYS_SVCR);
 
 		if (*svcr & SVCR_ZA_MASK)
-			za_save_state(last->za_state);
+			za_save_state(last->sme_state);
 
 		/* If we are in streaming mode override regular SVE. */
 		if (*svcr & SVCR_SM_MASK) {
@@ -1257,30 +1257,30 @@ void fpsimd_release_task(struct task_struct *dead_task)
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
@@ -1488,7 +1488,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 
 	sve_alloc(current, false);
 	sme_alloc(current);
-	if (!current->thread.sve_state || !current->thread.za_state) {
+	if (!current->thread.sve_state || !current->thread.sme_state) {
 		force_sig(SIGKILL);
 		return;
 	}
@@ -1609,7 +1609,7 @@ static void fpsimd_flush_thread_vl(enum vec_type type)
 void fpsimd_flush_thread(void)
 {
 	void *sve_state = NULL;
-	void *za_state = NULL;
+	void *sme_state = NULL;
 
 	if (!system_supports_fpsimd())
 		return;
@@ -1634,8 +1634,8 @@ void fpsimd_flush_thread(void)
 		clear_thread_flag(TIF_SME);
 
 		/* Defer kfree() while in atomic context */
-		za_state = current->thread.za_state;
-		current->thread.za_state = NULL;
+		sme_state = current->thread.sme_state;
+		current->thread.sme_state = NULL;
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
 		current->thread.svcr = 0;
@@ -1645,7 +1645,7 @@ void fpsimd_flush_thread(void)
 
 	put_cpu_fpsimd_context();
 	kfree(sve_state);
-	kfree(za_state);
+	kfree(sme_state);
 }
 
 /*
@@ -1711,7 +1711,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
-	last->za_state = current->thread.za_state;
+	last->sme_state = current->thread.sme_state;
 	last->sve_vl = task_get_sve_vl(current);
 	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 269ac1c25ae2..4ce0c4313ec6 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -311,23 +311,24 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	 * This may be shortly freed if we exec() or if CLONE_SETTLS
 	 * but it's simpler to do it here. To avoid confusing the rest
 	 * of the code ensure that we have a sve_state allocated
-	 * whenever za_state is allocated.
+	 * whenever sme_state is allocated.
 	 */
 	if (thread_za_enabled(&src->thread)) {
 		dst->thread.sve_state = kzalloc(sve_state_size(src),
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
index 2686ab157601..67256e7772e4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1045,7 +1045,7 @@ static int za_get(struct task_struct *target,
 	if (thread_za_enabled(&target->thread)) {
 		start = end;
 		end = ZA_PT_SIZE(vq);
-		membuf_write(&to, target->thread.za_state, end - start);
+		membuf_write(&to, target->thread.sme_state, end - start);
 	}
 
 	/* Zero any trailing padding */
@@ -1099,7 +1099,7 @@ static int za_set(struct task_struct *target,
 
 	/* Allocate/reinit ZA storage */
 	sme_alloc(target);
-	if (!target->thread.za_state) {
+	if (!target->thread.sme_state) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1124,7 +1124,7 @@ static int za_set(struct task_struct *target,
 	start = ZA_PT_ZA_OFFSET;
 	end = ZA_PT_SIZE(vq);
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 target->thread.za_state,
+				 target->thread.sme_state,
 				 start, end);
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e0d09bf5b01b..27768809dd3e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -389,7 +389,7 @@ static int preserve_za_context(struct za_context __user *ctx)
 		 * fpsimd_signal_preserve_current_state().
 		 */
 		err |= __copy_to_user((char __user *)ctx + ZA_SIG_REGS_OFFSET,
-				      current->thread.za_state,
+				      current->thread.sme_state,
 				      ZA_SIG_REGS_SIZE(vq));
 	}
 
@@ -420,7 +420,7 @@ static int restore_za_context(struct user_ctxs *user)
 
 	/*
 	 * Careful: we are about __copy_from_user() directly into
-	 * thread.za_state with preemption enabled, so protection is
+	 * thread.sme_state with preemption enabled, so protection is
 	 * needed to prevent a racing context switch from writing stale
 	 * registers back over the new data.
 	 */
@@ -429,13 +429,13 @@ static int restore_za_context(struct user_ctxs *user)
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
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 02dd7e9ebd39..235775d0c825 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -143,7 +143,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.st = &vcpu->arch.ctxt.fp_regs;
 		fp_state.sve_state = vcpu->arch.sve_state;
 		fp_state.sve_vl = vcpu->arch.sve_max_vl;
-		fp_state.za_state = NULL;
+		fp_state.sme_state = NULL;
 		fp_state.svcr = &vcpu->arch.svcr;
 		fp_state.fp_type = &vcpu->arch.fp_type;
 

-- 
2.34.1

