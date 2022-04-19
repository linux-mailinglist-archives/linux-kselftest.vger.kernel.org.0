Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B33506A36
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbiDSL1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiDSL1U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:27:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA005F98
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6175B817FB
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5D8C385A5;
        Tue, 19 Apr 2022 11:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367473;
        bh=ztLRyBFYjrH0ZUAYQsQdxIvWZ0dnQt/vxncGOFyoOdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVotttwKHaTdpZDebYW5fXIQUWsIhZX0OzeFYs/n8kjJRDYiDOeaf+zW3YNO/kxsK
         u4O5bQzY0EY0BWKjkuCqyWIc3WB79kSRd4ZItYCbq9jloHZlOzaiY6S5dX7SdljCV/
         1xYhfwE1u92VmDxL64gORjkgioHdQssbcskJJ2Ev8Fk8yUAG5gNONptgevaLbTcGty
         6HVWPNRz65dvxu2F3N4MgnWTyOMspRgyEgmlaEVOEoKGjgswbTRI9fJfgU/PbRQIp2
         QH7FoKpP/8HM38D8TPr9UbtT6ORGzjbnSqdWR92eWYpjPRDPS7/p+x4+Gc296cJd1J
         ofnVIpqPslFPw==
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
Subject: [PATCH v14 16/39] arm64/sme: Implement traps and syscall handling for SME
Date:   Tue, 19 Apr 2022 12:22:24 +0100
Message-Id: <20220419112247.711548-17-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17869; h=from:subject; bh=ztLRyBFYjrH0ZUAYQsQdxIvWZ0dnQt/vxncGOFyoOdA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpt0x5aBn+Bx8E5kMKTCeeiq/iCOObsWYMuBYQa0 U9WKYWCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bdAAKCRAk1otyXVSH0IrFB/ 9Hen520mRoVVISf/DouA+s9xFBEhxJReBn117K5+FSu4C1hceyffyEq/UkmqWFNTYnGpIU+wBCwsLX gNeCi7vRBKEPlphbSOMvvZYBheaSsXinyZqPudsxElliMCEHQVqmEJu/2j1q5OH9LAajBX9TLrKF7Q xsJSGwLM9Z4GsPPscXJt2y6/slCFTMiNoa5X+Z3/cyHbdxrxGAulX61je/Dtl8jOYPQynvwa5czNLz DDQjzOrd6OPoO4smQailMFnNdenEulJgomtMd6XO8NTGTczgNAfJU31+lerVwkiw3jQARpcaFSGS+8 eH6X1ghWBp/oFuIJwHpYOOyxrSUanu
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

By default all SME operations in userspace will trap.  When this happens
we allocate storage space for the SME register state, set up the SVE
registers and disable traps.  We do not need to initialize ZA since the
architecture guarantees that it will be zeroed when enabled and when we
trap ZA is disabled.

On syscall we exit streaming mode if we were previously in it and ensure
that all but the lower 128 bits of the registers are zeroed while
preserving the state of ZA. This follows the aarch64 PCS for SME, ZA
state is preserved over a function call and streaming mode is exited.
Since the traps for SME do not distinguish between streaming mode SVE
and ZA usage if ZA is in use rather than reenabling traps we instead
zero the parts of the SVE registers not shared with FPSIMD and leave SME
enabled, this simplifies handling SME traps. If ZA is not in use then we
reenable SME traps and fall through to normal handling of SVE.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/esr.h       |   1 +
 arch/arm64/include/asm/exception.h |   1 +
 arch/arm64/include/asm/fpsimd.h    |  39 +++++++
 arch/arm64/kernel/entry-common.c   |  11 ++
 arch/arm64/kernel/fpsimd.c         | 167 +++++++++++++++++++++++++----
 arch/arm64/kernel/process.c        |  30 +++++-
 arch/arm64/kernel/syscall.c        |  29 ++++-
 7 files changed, 255 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 43872e0cfd1e..0467837fd66b 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -76,6 +76,7 @@
 #define ESR_ELx_IL_SHIFT	(25)
 #define ESR_ELx_IL		(UL(1) << ESR_ELx_IL_SHIFT)
 #define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
+#define ESR_ELx_ISS(esr)	((esr) & ESR_ELx_ISS_MASK)
 
 /* ISS field definitions shared by different classes */
 #define ESR_ELx_WNR_SHIFT	(6)
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 339477dca551..2add7f33b7c2 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -64,6 +64,7 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 			struct pt_regs *regs);
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs);
 void do_sve_acc(unsigned int esr, struct pt_regs *regs);
+void do_sme_acc(unsigned int esr, struct pt_regs *regs);
 void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs);
 void do_sysinstr(unsigned int esr, struct pt_regs *regs);
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 1a709c03bb6c..6c33bc832ed4 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -239,6 +239,8 @@ static inline bool sve_vq_available(unsigned int vq)
 	return vq_available(ARM64_VEC_SVE, vq);
 }
 
+size_t sve_state_size(struct task_struct const *task);
+
 #else /* ! CONFIG_ARM64_SVE */
 
 static inline void sve_alloc(struct task_struct *task) { }
@@ -278,10 +280,25 @@ static inline void vec_update_vq_map(enum vec_type t) { }
 static inline int vec_verify_vq_map(enum vec_type t) { return 0; }
 static inline void sve_setup(void) { }
 
+static inline size_t sve_state_size(struct task_struct const *task)
+{
+	return 0;
+}
+
 #endif /* ! CONFIG_ARM64_SVE */
 
 #ifdef CONFIG_ARM64_SME
 
+static inline void sme_user_disable(void)
+{
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_SMEN_EL0EN, 0);
+}
+
+static inline void sme_user_enable(void)
+{
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_SMEN_EL0EN);
+}
+
 static inline void sme_smstart_sm(void)
 {
 	asm volatile(__msr_s(SYS_SVCR_SMSTART_SM_EL0, "xzr"));
@@ -309,16 +326,33 @@ static inline int sme_max_virtualisable_vl(void)
 	return vec_max_virtualisable_vl(ARM64_VEC_SME);
 }
 
+extern void sme_alloc(struct task_struct *task);
 extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
 
+/*
+ * Return how many bytes of memory are required to store the full SME
+ * specific state (currently just ZA) for task, given task's currently
+ * configured vector length.
+ */
+static inline size_t za_state_size(struct task_struct const *task)
+{
+	unsigned int vl = task_get_sme_vl(task);
+
+	return ZA_SIG_REGS_SIZE(sve_vq_from_vl(vl));
+}
+
 #else
 
+static inline void sme_user_disable(void) { BUILD_BUG(); }
+static inline void sme_user_enable(void) { BUILD_BUG(); }
+
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
 static inline void sme_smstop(void) { }
 
+static inline void sme_alloc(struct task_struct *task) { }
 static inline void sme_setup(void) { }
 static inline unsigned int sme_get_vl(void) { return 0; }
 static inline int sme_max_vl(void) { return 0; }
@@ -326,6 +360,11 @@ static inline int sme_max_virtualisable_vl(void) { return 0; }
 static inline int sme_set_current_vl(unsigned long arg) { return -EINVAL; }
 static inline int sme_get_current_vl(void) { return -EINVAL; }
 
+static inline size_t za_state_size(struct task_struct const *task)
+{
+	return 0;
+}
+
 #endif /* ! CONFIG_ARM64_SME */
 
 /* For use by EFI runtime services calls only */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 878c65aa7206..29139e9a1517 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -537,6 +537,14 @@ static void noinstr el0_sve_acc(struct pt_regs *regs, unsigned long esr)
 	exit_to_user_mode(regs);
 }
 
+static void noinstr el0_sme_acc(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_sme_acc(esr, regs);
+	exit_to_user_mode(regs);
+}
+
 static void noinstr el0_fpsimd_exc(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
@@ -645,6 +653,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_SVE:
 		el0_sve_acc(regs, esr);
 		break;
+	case ESR_ELx_EC_SME:
+		el0_sme_acc(regs, esr);
+		break;
 	case ESR_ELx_EC_FP_EXC64:
 		el0_fpsimd_exc(regs, esr);
 		break;
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index dc38f3f2a28a..00a0cbd01ce5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -209,6 +209,12 @@ static void set_sme_default_vl(int val)
 	set_default_vl(ARM64_VEC_SME, val);
 }
 
+static void sme_free(struct task_struct *);
+
+#else
+
+static inline void sme_free(struct task_struct *t) { }
+
 #endif
 
 DEFINE_PER_CPU(bool, fpsimd_context_busy);
@@ -676,7 +682,7 @@ static void sve_to_fpsimd(struct task_struct *task)
  * Return how many bytes of memory are required to store the full SVE
  * state for task, given task's currently configured vector length.
  */
-static size_t sve_state_size(struct task_struct const *task)
+size_t sve_state_size(struct task_struct const *task)
 {
 	unsigned int vl = 0;
 
@@ -818,18 +824,22 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	    thread_sm_enabled(&task->thread))
 		sve_to_fpsimd(task);
 
-	if (system_supports_sme() && type == ARM64_VEC_SME)
+	if (system_supports_sme() && type == ARM64_VEC_SME) {
 		task->thread.svcr &= ~(SYS_SVCR_EL0_SM_MASK |
 				       SYS_SVCR_EL0_ZA_MASK);
+		clear_thread_flag(TIF_SME);
+	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
 
 	/*
-	 * Force reallocation of task SVE state to the correct size
-	 * on next use:
+	 * Force reallocation of task SVE and SME state to the correct
+	 * size on next use:
 	 */
 	sve_free(task);
+	if (system_supports_sme() && type == ARM64_VEC_SME)
+		sme_free(task);
 
 	task_set_vl(task, type, vl);
 
@@ -1164,12 +1174,43 @@ void __init sve_setup(void)
 void fpsimd_release_task(struct task_struct *dead_task)
 {
 	__sve_free(dead_task);
+	sme_free(dead_task);
 }
 
 #endif /* CONFIG_ARM64_SVE */
 
 #ifdef CONFIG_ARM64_SME
 
+/* This will move to uapi/asm/sigcontext.h when signals are implemented */
+#define ZA_SIG_REGS_SIZE(vq) ((vq * __SVE_VQ_BYTES) * (vq * __SVE_VQ_BYTES))
+
+/*
+ * Ensure that task->thread.za_state is allocated and sufficiently large.
+ *
+ * This function should be used only in preparation for replacing
+ * task->thread.za_state with new data.  The memory is always zeroed
+ * here to prevent stale data from showing through: this is done in
+ * the interest of testability and predictability, the architecture
+ * guarantees that when ZA is enabled it will be zeroed.
+ */
+void sme_alloc(struct task_struct *task)
+{
+	if (task->thread.za_state) {
+		memset(task->thread.za_state, 0, za_state_size(task));
+		return;
+	}
+
+	/* This could potentially be up to 64K. */
+	task->thread.za_state =
+		kzalloc(za_state_size(task), GFP_KERNEL);
+}
+
+static void sme_free(struct task_struct *task)
+{
+	kfree(task->thread.za_state);
+	task->thread.za_state = NULL;
+}
+
 void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 {
 	/* Set priority for all PEs to architecturally defined minimum */
@@ -1279,6 +1320,29 @@ void __init sme_setup(void)
 
 #endif /* CONFIG_ARM64_SME */
 
+static void sve_init_regs(void)
+{
+	/*
+	 * Convert the FPSIMD state to SVE, zeroing all the state that
+	 * is not shared with FPSIMD. If (as is likely) the current
+	 * state is live in the registers then do this there and
+	 * update our metadata for the current task including
+	 * disabling the trap, otherwise update our in-memory copy.
+	 * We are guaranteed to not be in streaming mode, we can only
+	 * take a SVE trap when not in streaming mode and we can't be
+	 * in streaming mode when taking a SME trap.
+	 */
+	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		unsigned long vq_minus_one =
+			sve_vq_from_vl(task_get_sve_vl(current)) - 1;
+		sve_set_vq(vq_minus_one);
+		sve_flush_live(true, vq_minus_one);
+		fpsimd_bind_task_to_cpu();
+	} else {
+		fpsimd_to_sve(current);
+	}
+}
+
 /*
  * Trapped SVE access
  *
@@ -1310,22 +1374,77 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
 	/*
-	 * Convert the FPSIMD state to SVE, zeroing all the state that
-	 * is not shared with FPSIMD. If (as is likely) the current
-	 * state is live in the registers then do this there and
-	 * update our metadata for the current task including
-	 * disabling the trap, otherwise update our in-memory copy.
+	 * Even if the task can have used streaming mode we can only
+	 * generate SVE access traps in normal SVE mode and
+	 * transitioning out of streaming mode may discard any
+	 * streaming mode state.  Always clear the high bits to avoid
+	 * any potential errors tracking what is properly initialised.
+	 */
+	sve_init_regs();
+
+	put_cpu_fpsimd_context();
+}
+
+/*
+ * Trapped SME access
+ *
+ * Storage is allocated for the full SVE and SME state, the current
+ * FPSIMD register contents are migrated to SVE if SVE is not already
+ * active, and the access trap is disabled.
+ *
+ * TIF_SME should be clear on entry: otherwise, fpsimd_restore_current_state()
+ * would have disabled the SME access trap for userspace during
+ * ret_to_user, making an SVE access trap impossible in that case.
+ */
+void do_sme_acc(unsigned int esr, struct pt_regs *regs)
+{
+	/* Even if we chose not to use SME, the hardware could still trap: */
+	if (unlikely(!system_supports_sme()) || WARN_ON(is_compat_task())) {
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
+		return;
+	}
+
+	/*
+	 * If this not a trap due to SME being disabled then something
+	 * is being used in the wrong mode, report as SIGILL.
 	 */
+	if (ESR_ELx_ISS(esr) != ESR_ELx_SME_ISS_SME_DISABLED) {
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
+		return;
+	}
+
+	sve_alloc(current);
+	sme_alloc(current);
+	if (!current->thread.sve_state || !current->thread.za_state) {
+		force_sig(SIGKILL);
+		return;
+	}
+
+	get_cpu_fpsimd_context();
+
+	/* With TIF_SME userspace shouldn't generate any traps */
+	if (test_and_set_thread_flag(TIF_SME))
+		WARN_ON(1);
+
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		unsigned long vq_minus_one =
-			sve_vq_from_vl(task_get_sve_vl(current)) - 1;
-		sve_set_vq(vq_minus_one);
-		sve_flush_live(true, vq_minus_one);
+			sve_vq_from_vl(task_get_sme_vl(current)) - 1;
+		sme_set_vq(vq_minus_one);
+
 		fpsimd_bind_task_to_cpu();
-	} else {
-		fpsimd_to_sve(current);
 	}
 
+	/*
+	 * If SVE was not already active initialise the SVE registers,
+	 * any non-shared state between the streaming and regular SVE
+	 * registers is architecturally guaranteed to be zeroed when
+	 * we enter streaming mode.  We do not need to initialize ZA
+	 * since ZA must be disabled at this point and enabling ZA is
+	 * architecturally defined to zero ZA.
+	 */
+	if (system_supports_sve() && !test_thread_flag(TIF_SVE))
+		sve_init_regs();
+
 	put_cpu_fpsimd_context();
 }
 
@@ -1442,8 +1561,12 @@ void fpsimd_flush_thread(void)
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}
 
-	if (system_supports_sme())
+	if (system_supports_sme()) {
+		clear_thread_flag(TIF_SME);
+		sme_free(current);
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
+		current->thread.svcr = 0;
+	}
 
 	put_cpu_fpsimd_context();
 }
@@ -1493,14 +1616,22 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->svcr = &current->thread.svcr;
 	current->thread.fpsimd_cpu = smp_processor_id();
 
+	/*
+	 * Toggle SVE and SME trapping for userspace if needed, these
+	 * are serialsied by ret_to_user().
+	 */
+	if (system_supports_sme()) {
+		if (test_thread_flag(TIF_SME))
+			sme_user_enable();
+		else
+			sme_user_disable();
+	}
+
 	if (system_supports_sve()) {
-		/* Toggle SVE trapping for userspace if needed */
 		if (test_thread_flag(TIF_SVE))
 			sve_user_enable();
 		else
 			sve_user_disable();
-
-		/* Serialised by exception return to user */
 	}
 }
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 07f235b46cf5..99c293513817 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -300,17 +300,41 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 	/*
 	 * Detach src's sve_state (if any) from dst so that it does not
-	 * get erroneously used or freed prematurely.  dst's sve_state
+	 * get erroneously used or freed prematurely.  dst's copies
 	 * will be allocated on demand later on if dst uses SVE.
 	 * For consistency, also clear TIF_SVE here: this could be done
 	 * later in copy_process(), but to avoid tripping up future
-	 * maintainers it is best not to leave TIF_SVE and sve_state in
+	 * maintainers it is best not to leave TIF flags and buffers in
 	 * an inconsistent state, even temporarily.
 	 */
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
-	dst->thread.svcr = 0;
+	/*
+	 * In the unlikely event that we create a new thread with ZA
+	 * enabled we should retain the ZA state so duplicate it here.
+	 * This may be shortly freed if we exec() or if CLONE_SETTLS
+	 * but it's simpler to do it here. To avoid confusing the rest
+	 * of the code ensure that we have a sve_state allocated
+	 * whenever za_state is allocated.
+	 */
+	if (thread_za_enabled(&src->thread)) {
+		dst->thread.sve_state = kzalloc(sve_state_size(src),
+						GFP_KERNEL);
+		if (!dst->thread.za_state)
+			return -ENOMEM;
+		dst->thread.za_state = kmemdup(src->thread.za_state,
+					       za_state_size(src),
+					       GFP_KERNEL);
+		if (!dst->thread.za_state) {
+			kfree(dst->thread.sve_state);
+			dst->thread.sve_state = NULL;
+			return -ENOMEM;
+		}
+	} else {
+		dst->thread.za_state = NULL;
+		clear_tsk_thread_flag(dst, TIF_SME);
+	}
 
 	/* clear any pending asynchronous tag fault raised by the parent */
 	clear_tsk_thread_flag(dst, TIF_MTE_ASYNC_FAULT);
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c938603b3ba0..92c69e5ac269 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -158,11 +158,36 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	syscall_trace_exit(regs);
 }
 
-static inline void sve_user_discard(void)
+/*
+ * As per the ABI exit SME streaming mode and clear the SVE state not
+ * shared with FPSIMD on syscall entry.
+ */
+static inline void fp_user_discard(void)
 {
+	/*
+	 * If SME is active then exit streaming mode.  If ZA is active
+	 * then flush the SVE registers but leave userspace access to
+	 * both SVE and SME enabled, otherwise disable SME for the
+	 * task and fall through to disabling SVE too.  This means
+	 * that after a syscall we never have any streaming mode
+	 * register state to track, if this changes the KVM code will
+	 * need updating.
+	 */
+	if (system_supports_sme() && test_thread_flag(TIF_SME)) {
+		u64 svcr = read_sysreg_s(SYS_SVCR_EL0);
+
+		if (svcr & SYS_SVCR_EL0_SM_MASK)
+			sme_smstop_sm();
+	}
+
 	if (!system_supports_sve())
 		return;
 
+	/*
+	 * If SME is not active then disable SVE, the registers will
+	 * be cleared when userspace next attempts to access them and
+	 * we do not need to track the SVE register state until then.
+	 */
 	clear_thread_flag(TIF_SVE);
 
 	/*
@@ -177,7 +202,7 @@ static inline void sve_user_discard(void)
 
 void do_el0_svc(struct pt_regs *regs)
 {
-	sve_user_discard();
+	fp_user_discard();
 	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
 }
 
-- 
2.30.2

