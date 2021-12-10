Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44148470923
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbhLJSsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:48:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49288 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbhLJSsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:48:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CE8BB82959
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E269C341C7;
        Fri, 10 Dec 2021 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161872;
        bh=njk+oV7pBUj4TNv4gL31XpUNlM0pBlgI7efCXkN9R8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEdm141C2KXA1fYLF4S6nweMpoQk1XmifqFWG8N/Y+QIo0LwkP9Vw/MrzrG677tMj
         3JUjJL2GDmX53knpdyfthZEvc2JdPVIn4rGcn4N20lQqjf5Jb8+qKWDaY9mdMyB51y
         eNB8eecX9UaAc04iwim6DSVC+KYxSuIpXSOstYc4bWmzUG5HvmFNsIJmgX83duOydk
         j3JXK8ekL3ZTiInf5P1NgoDwmQtAYcJ2b6rPyd8F6cToLxAXBlJX8rhc//23f57eVa
         8P0p6F64YjcpoyKBGqPj8uTyz9+XuE4P6RQXjrJBN2QB71EeKTlf/TsZWGEkSKPQHQ
         +tN/RaczxMRMQ==
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
Subject: [PATCH v7 19/37] arm64/sme: Implement streaming SVE context switching
Date:   Fri, 10 Dec 2021 18:41:15 +0000
Message-Id: <20211210184133.320748-20-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13013; h=from:subject; bh=njk+oV7pBUj4TNv4gL31XpUNlM0pBlgI7efCXkN9R8A=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59N5+RaYUen15QWSfzViw4Dpfg5QuLWaVNVGiUW NKJNnKGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfTQAKCRAk1otyXVSH0IcOB/ 9mGEQe7dq0ZODL8NglyyX/o0vGHRIZ8dOnrzTnweMyeQ+ssTPPpPDFiTXjoFTxt8I2W+3cxsuYYd1L kF9z5fcvHFRslSEwGKem2/+Dmdr3Fy+QAmuFfkGnqI5btaGLBErE7ku7LHDxD0si2/pvd5IHDnYIQL 3gU0/iqioc+5/RCNHUv/9ChrYdQPXeSZTGnhRxCDozMZoCHLNllKL67lDQ+HiW7aXsV32GLwEQ5FJa fd7rFNnGIBq1V4UH46L40G74Mvkr86J7SvngYxYmdrgRFCkX1H53c5fq2YfTHZ2BvFUOrZDj73Wei/ kW+lNmSbrgRMehMzlpbR6Pue6AJr/o
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
 arch/arm64/kernel/entry-fpsimd.S      |   9 +++
 arch/arm64/kernel/fpsimd.c            | 109 +++++++++++++++++++++-----
 arch/arm64/kvm/fpsimd.c               |   3 +-
 6 files changed, 142 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index dc01fd634b75..2f7b64797736 100644
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
index f9fb5f111758..57bcd9ec4cb9 100644
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
index 7e08a4d48c24..6e2af9de153c 100644
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
index dc242e269f9a..b06bf42e7856 100644
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
index d6e6bec6b490..39a4dd0a6257 100644
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
+			restore_ffr = system_supports_fa64();
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
@@ -383,13 +420,32 @@ static void fpsimd_save(void)
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
+		if (thread_za_enabled(&current->thread)) {
+			/* ZA state managment is not implemented yet */
+			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
+			return;
+		}
+
+		/* If we are in streaming mode override regular SVE. */
+		if (thread_sm_enabled(&current->thread)) {
+			save_sve_regs = true;
+			save_ffr = system_supports_fa64();
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
@@ -400,8 +456,8 @@ static void fpsimd_save(void)
 		}
 
 		sve_save_state((char *)last->sve_state +
-					sve_ffr_offset(last->sve_vl),
-			       &last->st->fpsr, true);
+					sve_ffr_offset(vl),
+			       &last->st->fpsr, save_ffr);
 	} else {
 		fpsimd_save_state(last->st);
 	}
@@ -606,7 +662,14 @@ static void sve_to_fpsimd(struct task_struct *task)
  */
 static size_t sve_state_size(struct task_struct const *task)
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
@@ -735,7 +798,8 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	}
 
 	fpsimd_flush_task_state(task);
-	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
+	if (test_and_clear_tsk_thread_flag(task, TIF_SVE) ||
+	    thread_sm_enabled(&task->thread))
 		sve_to_fpsimd(task);
 
 	if (system_supports_sme() && type == ARM64_VEC_SME)
@@ -1372,6 +1436,9 @@ void fpsimd_flush_thread(void)
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}
 
+	if (system_supports_sme())
+		fpsimd_flush_thread_vl(ARM64_VEC_SME);
+
 	put_cpu_fpsimd_context();
 }
 
@@ -1415,6 +1482,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = task_get_sve_vl(current);
+	last->sme_vl = task_get_sme_vl(current);
 	current->thread.fpsimd_cpu = smp_processor_id();
 
 	if (system_supports_sve()) {
@@ -1429,7 +1497,7 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl)
+			      unsigned int sve_vl, unsigned int sme_vl)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1440,6 +1508,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
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
2.30.2

