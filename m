Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178DB4F94BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiDHL6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiDHL6Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91C87E0AD
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 373BF61FB9
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2253DC385AD;
        Fri,  8 Apr 2022 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418971;
        bh=5zGxbx9eJ7bLf8pL5WCvw4dOrjaS21sxHjUTjXEIp3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y745N6mX/3KgAA3E+B/XEqjrgGbSUUvng2nfoCbywQ+jzhDIAauHF3W/ANke/U2tN
         pGKfp8WKz+8EoVbWyMwrOAWLXk1ojtgICAzrwpKKIibSm2bHnvsKH8Y++F+5IlslGY
         YHThOK8AHUrLuQF0jLWNqBFGMhrVZ5mX+oehfLBXtT91dPVLApeKXInQIWYBb1VTua
         3N2Iy/WAz6gN7vUu/BGMzRlld6jlmRiFcDuxSW6K2No/svUkylp8+TemKQdQI+nbpJ
         zO254sZHnGSJluWntXfut6vx8FD4obe0Iaoa0XiVMhwSHHKQgroVJO5Iu3cCKuCjvM
         sYkpFLFXMrdmw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 14/39] arm64/sme: Implement streaming SVE context switching
Date:   Fri,  8 Apr 2022 12:43:03 +0100
Message-Id: <20220408114328.1401034-15-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12910; h=from:subject; bh=5zGxbx9eJ7bLf8pL5WCvw4dOrjaS21sxHjUTjXEIp3w=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/KY9yNBGi4wv3EWyMU2LVLDeyyF5jmBhkUWPL7 rqn2WJaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfygAKCRAk1otyXVSH0FbxB/ 9a0KgVjlLxALqNuNXxJBMegRCcxB712729qKE7HaPR/xKMwqr3p4AcZmwrvuqSfI9KIi7HUGsgPFd9 /707AKE9QypxgPn02FljGGKvoURM8gBEm+M6NfD35IZJlm1Gj9tTRhJx3T7Ft/cYGtC8iAKS8mtThP Q84UzSTAaWjiah3KsTN2KxaKXjKUCkCmLb7MvCVKQQsj+PPSNhS2u9mcKmEkHbo387Hi7fyMn5gDVq P61uzGuL+OytJfxXqJaw1nd1QHoeo0jWswfK/ZVTyk9Raf7P5CY5xOxZkoPpEPzJxZ7cpyXGDD2qoL ZaJMr3VVzJB2gmj3EIgxGYxsI80U50
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/fpsimd.h       |  22 +++++-
 arch/arm64/include/asm/fpsimdmacros.h |  11 +++
 arch/arm64/include/asm/processor.h    |  10 +++
 arch/arm64/kernel/entry-fpsimd.S      |   5 ++
 arch/arm64/kernel/fpsimd.c            | 109 +++++++++++++++++++++-----
 arch/arm64/kvm/fpsimd.c               |   2 +-
 6 files changed, 136 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 821d270980da..cd94f5c5b516 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -47,11 +47,21 @@ extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 
 extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl,
-				     u64 *svcr);
+				     unsigned int sme_vl, u64 *svcr);
 
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
 
@@ -63,7 +73,14 @@ static inline size_t sve_ffr_offset(int vl)
 
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
@@ -72,6 +89,7 @@ extern void sve_load_state(void const *state, u32 const *pfpsr,
 extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
+extern void sme_set_vq(unsigned long vq_minus_1);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 2e9a33155081..f6ab36e0cd8d 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -262,6 +262,17 @@
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
index 22cd11e86854..7542310b4e6b 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -184,6 +184,11 @@ static inline unsigned int thread_get_sve_vl(struct thread_struct *thread)
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
@@ -197,6 +202,11 @@ static inline unsigned int task_get_sve_vl(const struct task_struct *task)
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
index deee5f01462e..6f88c0f86d50 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -94,4 +94,9 @@ SYM_FUNC_START(sme_get_vl)
 	ret
 SYM_FUNC_END(sme_get_vl)
 
+SYM_FUNC_START(sme_set_vq)
+	sme_load_vq x0, x1, x2
+	ret
+SYM_FUNC_END(sme_set_vq)
+
 #endif /* CONFIG_ARM64_SME */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1c113349f6cc..f8506a875eb2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -123,6 +123,7 @@ struct fpsimd_last_state_struct {
 	void *sve_state;
 	u64 *svcr;
 	unsigned int sve_vl;
+	unsigned int sme_vl;
 };
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
@@ -301,17 +302,28 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
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
@@ -319,7 +331,8 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
  *    corresponding Zn), P0-P15 and FFR are encoded in in
  *    task->thread.sve_state, formatted appropriately for vector
- *    length task->thread.sve_vl.
+ *    length task->thread.sve_vl or, if SVCR.SM is set,
+ *    task->thread.sme_vl.
  *
  *    task->thread.sve_state must point to a valid buffer at least
  *    sve_state_size(task) bytes in size.
@@ -357,19 +370,40 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
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
@@ -387,6 +421,9 @@ static void fpsimd_save(void)
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
+	bool save_sve_regs = false;
+	bool save_ffr;
+	unsigned int vl;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
@@ -394,15 +431,33 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
-	if (IS_ENABLED(CONFIG_ARM64_SME) &&
-	    test_thread_flag(TIF_SME)) {
+	if (test_thread_flag(TIF_SVE)) {
+		save_sve_regs = true;
+		save_ffr = true;
+		vl = last->sve_vl;
+	}
+
+	if (system_supports_sme()) {
 		u64 *svcr = last->svcr;
 		*svcr = read_sysreg_s(SYS_SVCR_EL0);
+
+		if (thread_za_enabled(&current->thread)) {
+			/* ZA state managment is not implemented yet */
+			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
+			return;
+		}
+
+		/* If we are in streaming mode override regular SVE. */
+		if (*svcr & SYS_SVCR_EL0_SM_MASK) {
+			save_sve_regs = true;
+			save_ffr = system_supports_fa64();
+			vl = last->sme_vl;
+		}
 	}
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    test_thread_flag(TIF_SVE)) {
-		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && save_sve_regs) {
+		/* Get the configured VL from RDVL, will account for SM */
+		if (WARN_ON(sve_get_vl() != vl)) {
 			/*
 			 * Can't save the user regs, so current would
 			 * re-enter user with corrupt state.
@@ -413,8 +468,8 @@ static void fpsimd_save(void)
 		}
 
 		sve_save_state((char *)last->sve_state +
-					sve_ffr_offset(last->sve_vl),
-			       &last->st->fpsr, true);
+					sve_ffr_offset(vl),
+			       &last->st->fpsr, save_ffr);
 	} else {
 		fpsimd_save_state(last->st);
 	}
@@ -619,7 +674,14 @@ static void sve_to_fpsimd(struct task_struct *task)
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
@@ -748,7 +810,8 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	}
 
 	fpsimd_flush_task_state(task);
-	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
+	if (test_and_clear_tsk_thread_flag(task, TIF_SVE) ||
+	    thread_sm_enabled(&task->thread))
 		sve_to_fpsimd(task);
 
 	if (system_supports_sme() && type == ARM64_VEC_SME)
@@ -1375,6 +1438,9 @@ void fpsimd_flush_thread(void)
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}
 
+	if (system_supports_sme())
+		fpsimd_flush_thread_vl(ARM64_VEC_SME);
+
 	put_cpu_fpsimd_context();
 }
 
@@ -1418,6 +1484,7 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = task_get_sve_vl(current);
+	last->sme_vl = task_get_sme_vl(current);
 	last->svcr = &current->thread.svcr;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
@@ -1433,7 +1500,8 @@ static void fpsimd_bind_task_to_cpu(void)
 }
 
 void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
-			      unsigned int sve_vl, u64 *svcr)
+			      unsigned int sve_vl, unsigned int sme_vl,
+			      u64 *svcr)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1445,6 +1513,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	last->svcr = svcr;
 	last->sve_state = sve_state;
 	last->sve_vl = sve_vl;
+	last->sme_vl = sme_vl;
 }
 
 /*
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index ac09f1f682ff..394e583bb73e 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -116,7 +116,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fpsimd_bind_state_to_cpu(&vcpu->arch.ctxt.fp_regs,
 					 vcpu->arch.sve_state,
 					 vcpu->arch.sve_max_vl,
-					 NULL);
+					 0, NULL);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		update_thread_flag(TIF_SVE, vcpu_has_sve(vcpu));
-- 
2.30.2

