Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C1241E0D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353364AbhI3SSV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3SSV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:18:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFE436140F;
        Thu, 30 Sep 2021 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025798;
        bh=ak14iOsVLeml06d2awWTo/fKmMA3IdK8ORInyY6Sbxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCQnRWzMcErsmPyT3IA0xdst8qaQnSlKCFhUdEBycrLtzYMH3bPS8zjTSsP3Dh6VF
         bMxcTeeGiTJcyLvx6DJWpGJbaY16Hv/5YmEGPVoGZ/6B+vdMYNZYWRgsqhoB5+k8o9
         ffdPRyqj4GE621DKFfV4kZim0RFU6CJ/qkUADcBeeIW+pZ8Fo0rAphSBqAfOV+qipA
         V+2321ayyuanz+3F0rpZT0mB+Ps/Jznf223PZXCxLJTw7OXI5bQ0/rlSQAHSoIyYSR
         stqfJdtmhObLMNHrGvA4Qkwo3qGr8rg7LDhattomf511bOtZIZd84MeN0TuqV0x/bn
         6LqLDbKFZolWQ==
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
Subject: [PATCH v1 22/38] arm64/sme: Implement streaming SVE context switching
Date:   Thu, 30 Sep 2021 19:11:28 +0100
Message-Id: <20210930181144.10029-23-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13142; h=from:subject; bh=ak14iOsVLeml06d2awWTo/fKmMA3IdK8ORInyY6Sbxk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3TuaTROV89bUaWBKmzZJCJKeZcwEIqr02oEe7f rm4dubmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX90wAKCRAk1otyXVSH0LDoB/ 9vGB4xikLlDZJhVZl6oAF0xcrhCP8jOZGp5yJQ0A5jbF5qZIG/90HeIsa2z7ujTsHdtEkAjrhj5dWe WU7ALLpqofy1pn8n5Ne/vF6ozVnzLIdpHJCOTywtPv6Y/qCP9g0ynslmTHYUSK9mSNVUTHZpzWlUAV bGD92BLClDHa3IUSIwOKOncwkJPPs52KVJbSHGiUhinsJwkFKtvdyBeaXXx439WsumV+hBCAGUG3X4 /pG12nvmy6BsLHsPeZPdEtN5FgyvOhD2r3fQ/zN9ZlFqn4+Ou3DBIUALhMOEW9qf/aCcACaQ9aLVAF B9W3qQqSREJY5S+FZJmEuHCU6N4Sgz
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When in streaming mode we need to save and restore the streaming mode
SVE register state rather than the regular SVE register state. This uses
the streaming mode vector length and omits FFR but is otherwise identical,
if TIF_SVE is enabled when we are in streaming mode then streaming mode
takes precedence.

This does not handle use of streaming SVE state with KVM, ptrace or
signals. This will be updated in further patches.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h       |  23 +++++-
 arch/arm64/include/asm/fpsimdmacros.h |  11 +++
 arch/arm64/include/asm/processor.h    |  10 +++
 arch/arm64/kernel/entry-fpsimd.S      |   9 ++
 arch/arm64/kernel/fpsimd.c            | 114 +++++++++++++++++++++-----
 arch/arm64/kvm/fpsimd.c               |   3 +-
 6 files changed, 147 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index f58c4be03ba2..43737ca91f1a 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -46,11 +46,22 @@ extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
-				     void *sve_state, unsigned int sve_vl);
+				     void *sve_state, unsigned int sve_vl,
+				     unsigned int sme_vl);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_save_and_flush_cpu_state(void);
 
+static inline bool thread_sm_enabled(struct thread_struct *thread)
+{
+	return system_supports_sme() && (thread->svcr & SYS_SVCR_EL0_SM_MASK);
+}
+
+static inline bool thread_za_enabled(struct thread_struct *thread)
+{
+	return system_supports_sme() && (thread->svcr & SYS_SVCR_EL0_ZA_MASK);
+}
+
 /* Maximum VL that SVE/SME VL-agnostic software can transparently support */
 #define VL_ARCH_MAX 0x100
 
@@ -62,7 +73,14 @@ static inline size_t sve_ffr_offset(int vl)
 
 static inline void *sve_pffr(struct thread_struct *thread)
 {
-	return (char *)thread->sve_state + sve_ffr_offset(thread_get_sve_vl(thread));
+	unsigned int vl;
+
+	if (system_supports_sme() && thread_sm_enabled(thread))
+		vl = thread_get_sme_vl(thread);
+	else
+		vl = thread_get_sve_vl(thread);
+
+	return (char *)thread->sve_state + sve_ffr_offset(vl);
 }
 
 extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
@@ -71,6 +89,7 @@ extern void sve_load_state(void const *state, u32 const *pfpsr,
 extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
+extern void sme_set_vq(unsigned long vq_minus_1);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index bc45bb984c49..c86fc2fc72e9 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -252,6 +252,17 @@
 921:
 .endm
 
+/* Update SMCR_EL1.LEN with the new VQ */
+.macro sme_load_vq xvqminus1, xtmp, xtmp2
+		mrs_s		\xtmp, SYS_SMCR_EL1
+		bic		\xtmp2, \xtmp, SMCR_ELx_LEN_MASK
+		orr		\xtmp2, \xtmp2, \xvqminus1
+		cmp		\xtmp2, \xtmp
+		b.eq		921f
+		msr_s		SYS_SMCR_EL1, \xtmp2	//self-synchronising
+921:
+.endm
+
 /* Preserve the first 128-bits of Znz and zero the rest. */
 .macro _sve_flush_z nz
 	_sve_check_zreg \nz
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 3c235e165725..338cb03811bd 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -183,6 +183,11 @@ static inline unsigned int thread_get_sve_vl(struct thread_struct *thread)
 	return thread_get_vl(thread, ARM64_VEC_SVE);
 }
 
+static inline unsigned int thread_get_sme_vl(struct thread_struct *thread)
+{
+	return thread_get_vl(thread, ARM64_VEC_SME);
+}
+
 unsigned int task_get_vl(const struct task_struct *task, enum vec_type type);
 void task_set_vl(struct task_struct *task, enum vec_type type,
 		 unsigned long vl);
@@ -196,6 +201,11 @@ static inline unsigned int task_get_sve_vl(const struct task_struct *task)
 	return task_get_vl(task, ARM64_VEC_SVE);
 }
 
+static inline unsigned int task_get_sme_vl(const struct task_struct *task)
+{
+	return task_get_vl(task, ARM64_VEC_SME);
+}
+
 static inline void task_set_sve_vl(struct task_struct *task, unsigned long vl)
 {
 	task_set_vl(task, ARM64_VEC_SVE, vl);
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 2339d370bfe1..55eb45b3faa9 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -86,3 +86,12 @@ SYM_FUNC_START(sve_flush_live)
 SYM_FUNC_END(sve_flush_live)
 
 #endif /* CONFIG_ARM64_SVE */
+
+#ifdef CONFIG_ARM64_SME
+
+SYM_FUNC_START(sme_set_vq)
+	sme_load_vq x0, x1, x2
+	ret
+SYM_FUNC_END(sme_set_vq)
+
+#endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 25193fd04860..89b94e8c81fd 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -118,6 +118,7 @@ struct fpsimd_last_state_struct {
 	struct user_fpsimd_state *st;
 	void *sve_state;
 	unsigned int sve_vl;
+	unsigned int sme_vl;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -296,17 +297,28 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
 	task->thread.vl_onexec[type] = vl;
 }
 
+/*
+ * TIF_SME controls whether a task can use SME without trapping while
+ * in userspace, when TIF_SME is set then we must have storage
+ * alocated in sve_state and za_state to store the contents of both ZA
+ * and the SVE registers for both streaming and non-streaming modes.
+ *
+ * If both SVCR.ZA and SVCR.SM are disabled then at any point we
+ * may disable TIF_SME and reenable traps.
+ */
+
+
 /*
  * TIF_SVE controls whether a task can use SVE without trapping while
- * in userspace, and also the way a task's FPSIMD/SVE state is stored
- * in thread_struct.
+ * in userspace, and also (together with TIF_SME) the way a task's
+ * FPSIMD/SVE state is stored in thread_struct.
  *
  * The kernel uses this flag to track whether a user task is actively
  * using SVE, and therefore whether full SVE register state needs to
  * be tracked.  If not, the cheaper FPSIMD context handling code can
  * be used instead of the more costly SVE equivalents.
  *
- *  * TIF_SVE set:
+ *  * TIF_SVE or SVCR.SM set:
  *
  *    The task can execute SVE instructions while in userspace without
  *    trapping to the kernel.
@@ -314,7 +326,8 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
  *    corresponding Zn), P0-P15 and FFR are encoded in in
  *    task->thread.sve_state, formatted appropriately for vector
- *    length task->thread.sve_vl.
+ *    length task->thread.sve_vl or, if SVCR.SM is set,
+ *    task->thread.sme_vl.
  *
  *    task->thread.sve_state must point to a valid buffer at least
  *    sve_state_size(task) bytes in size.
@@ -352,19 +365,40 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  */
 static void task_fpsimd_load(void)
 {
+	bool restore_sve_regs = false;
+	bool restore_ffr;
+
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
-	if (IS_ENABLED(CONFIG_ARM64_SME) && test_thread_flag(TIF_SME))
-		write_sysreg_s(current->thread.svcr, SYS_SVCR_EL0);
-
+	/* Check if we should restore SVE first */
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
 		sve_set_vq(sve_vq_from_vl(task_get_sve_vl(current)) - 1);
+		restore_sve_regs = true;
+		restore_ffr = true;
+	}
+
+	/* Restore SME, override SVE register configuration if needed */
+	if (system_supports_sme()) {
+		unsigned long sme_vl = task_get_sme_vl(current);
+
+		if (test_thread_flag(TIF_SME))
+			sme_set_vq(sve_vq_from_vl(sme_vl) - 1);
+
+		write_sysreg_s(current->thread.svcr, SYS_SVCR_EL0);
+
+		if (thread_sm_enabled(&current->thread)) {
+			restore_sve_regs = true;
+			restore_ffr = false;
+		}
+	}
+
+	if (restore_sve_regs)
 		sve_load_state(sve_pffr(&current->thread),
-			       &current->thread.uw.fpsimd_state.fpsr, true);
-	} else {
+			       &current->thread.uw.fpsimd_state.fpsr,
+			       restore_ffr);
+	else
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
-	}
 }
 
 /*
@@ -376,6 +410,9 @@ static void fpsimd_save(void)
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
+	bool save_sve_regs = false;
+	bool save_ffr;
+	unsigned int vl;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
@@ -383,13 +420,37 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
-	if (IS_ENABLED(CONFIG_ARM64_SME) &&
-	    test_thread_flag(TIF_SME))
+	if (test_thread_flag(TIF_SVE)) {
+		save_sve_regs = true;
+		save_ffr = true;
+		vl = last->sve_vl;
+	}
+
+	if (system_supports_sme()) {
 		current->thread.svcr = read_sysreg_s(SYS_SVCR_EL0);
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    test_thread_flag(TIF_SVE)) {
-		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
+		/* Are we still using SME at all? */
+		if (!(current->thread.svcr & (SYS_SVCR_EL0_ZA_MASK |
+					      SYS_SVCR_EL0_SM_MASK)))
+			clear_thread_flag(TIF_SME);
+
+		if (thread_za_enabled(&current->thread)) {
+			/* ZA state managment is not implemented yet */
+			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
+			return;
+		}
+
+		/* If we are in streaming mode override regular SVE. */
+		if (thread_sm_enabled(&current->thread)) {
+			save_sve_regs = true;
+			save_ffr = false;
+			vl = last->sme_vl;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
+		/* Get the configured VL from RDVL, will account for SM */
+		if (WARN_ON(sve_get_vl() != vl)) {
 			/*
 			 * Can't save the user regs, so current would
 			 * re-enter user with corrupt state.
@@ -400,8 +461,8 @@ static void fpsimd_save(void)
 		}
 
 		sve_save_state((char *)last->sve_state +
-					sve_ffr_offset(last->sve_vl),
-			       &last->st->fpsr, true);
+					sve_ffr_offset(vl),
+			       &last->st->fpsr, save_ffr);
 	} else {
 		fpsimd_save_state(last->st);
 	}
@@ -609,7 +670,14 @@ static void sve_to_fpsimd(struct task_struct *task)
  */
 size_t sve_state_size(struct task_struct const *task)
 {
-	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(task_get_sve_vl(task)));
+	unsigned int vl = 0;
+
+	if (system_supports_sve())
+		vl = task_get_sve_vl(task);
+	if (system_supports_sme())
+		vl = max(vl, task_get_sme_vl(task));
+
+	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(vl));
 }
 
 /*
@@ -738,7 +806,8 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	}
 
 	fpsimd_flush_task_state(task);
-	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
+	if (test_and_clear_tsk_thread_flag(task, TIF_SVE) ||
+	    thread_sm_enabled(&task->thread))
 		sve_to_fpsimd(task);
 
 	if (system_supports_sme() && type == ARM64_VEC_SME)
@@ -1362,6 +1431,9 @@ void fpsimd_flush_thread(void)
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}
 
+	if (system_supports_sme())
+		fpsimd_flush_thread_vl(ARM64_VEC_SME);
+
 	put_cpu_fpsimd_context();
 }
 
@@ -1405,6 +1477,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = task_get_sve_vl(current);
+	last->sme_vl = task_get_sme_vl(current);
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
@@ -1419,7 +1492,7 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl)
+			      unsigned int sve_vl, unsigned int sme_vl)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1430,6 +1503,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->st = st;
 	last->sve_state = sve_state;
 	last->sve_vl = sve_vl;
+	last->sme_vl = sme_vl;
 }
 
 /*
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 5621020b28de..d96871002081 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -99,7 +99,8 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
-					 vcpu->arch.sve_max_vl);
+					 vcpu->arch.sve_max_vl,
+					 0);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
-- 
2.20.1

