Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C1436A27
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhJUSLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJUSLM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:11:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8717761B00;
        Thu, 21 Oct 2021 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839736;
        bh=qKof+cxRbgFpTz8Lk6F4lyStMC2L/OMiP4AVB/RYIFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfoXLUrDN57lPQdWL3DE6jxt3GBPOCOjdOQEIWXypEArgnXTpz2GRdCnnGmZJaCIK
         w9DHuMkzIBR0mxeiO3PF27hncZiuyb9hVyupwiRvrYzENiWS6I1d8FAWPiB/fh5OVV
         ILjpn8yVigHeu56FYAXI3zVZCZlGfv1tgTBSgcWDfJmGKQJEI8gSjBUSWwQi9for7o
         ti0PFFlw4O+o1+lBYzoPwkWQ9Pkb+eaDFlEkg1h8V/NPz3tbuXbdXcNFXuKyYksydV
         /W56AKWHIfRHljIUk9feSLuSyaMjnsZ/BmFNwPo8vC0/eg9VwORVo1Cz7kcebQUHxZ
         KiWiG6gcFIk7w==
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
Subject: [PATCH v4 18/33] arm64/sme: Implement traps and syscall handling for SME
Date:   Thu, 21 Oct 2021 19:07:07 +0100
Message-Id: <20211021180722.3699248-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16161; h=from:subject; bh=qKof+cxRbgFpTz8Lk6F4lyStMC2L/OMiP4AVB/RYIFI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxMwlNQxvbDtOjoLFsT+JWjSH2fzYUer3VyVtlz 2mJKpFGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsTAAKCRAk1otyXVSH0KvTB/ 0Xm3ZA9D2hH26PKPeL22WCMl87UVcJciOQ2ey3x9Pu+xtHAyX++ubXaAvS34Fh0JwmnQYzAXjaC8U6 HMhzjD/n7iS1a/zQ/fQCvTAXBbv9Yh/wf6tW7Yuubww105yrmLaVHAAWdZ9NcM2H3+sdgxCnZBOcr3 R1L4qoEITdIxdPxbyViuDDyQpBNa/M1paxzxKS0XrpystFHMbuHgWxXQh3RT4ZqjvzKhuMWh/shI35 60oiDqpnIs9IOv2zG5iUb+Wr1V2e9bKGOphjNawX/yXmYPOCc90NzJ5i2T7HNvnligE60njWtvOsRB iVzm/GYFcb4bqi0R4iH25U87+kPYiA
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
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
 arch/arm64/include/asm/fpsimd.h    |  15 +++
 arch/arm64/kernel/entry-common.c   |  10 ++
 arch/arm64/kernel/fpsimd.c         | 174 ++++++++++++++++++++++++++---
 arch/arm64/kernel/process.c        |  12 +-
 arch/arm64/kernel/syscall.c        |  43 ++++++-
 7 files changed, 233 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 31418bc7644a..f664f31c774b 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -75,6 +75,7 @@
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
index c9cefb17d534..180548c13940 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -276,6 +276,17 @@ static inline void sve_setup(void) { }
 #ifdef CONFIG_ARM64_SME
 
 extern void __init sme_setup(void);
+extern void sme_alloc(struct task_struct *task);
+
+static inline void sme_user_disable(void)
+{
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_SMEN_EL0EN, 0);
+}
+
+static inline void sme_user_enable(void)
+{
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_SMEN_EL0EN);
+}
 
 static inline void sme_smstart_sm(void)
 {
@@ -307,6 +318,7 @@ extern int sme_get_current_vl(void);
 static inline void sme_setup(void) { }
 static inline int sme_max_vl(void) { return 0; }
 static inline int sme_max_virtualisable_vl(void) { return 0; }
+static inline void sme_alloc(struct task_struct *task) { }
 
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
@@ -321,6 +333,9 @@ static inline int sme_get_current_vl(void)
 	return -EINVAL;
 }
 
+static inline void sme_user_disable(void) { BUILD_BUG(); }
+static inline void sme_user_enable(void) { BUILD_BUG(); }
+
 #endif /* ! CONFIG_ARM64_SME */
 
 /* For use by EFI runtime services calls only */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..ed34b783244f 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -516,6 +516,13 @@ static void noinstr el0_sve_acc(struct pt_regs *regs, unsigned long esr)
 	exit_to_user_mode(regs);
 }
 
+static void noinstr el0_sme_acc(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_user_mode(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	do_sme_acc(esr, regs);
+}
+
 static void noinstr el0_fpsimd_exc(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
@@ -624,6 +631,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
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
index 348364980878..71b0305cc0a2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -204,6 +204,12 @@ static void set_sme_default_vl(int val)
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
@@ -804,18 +810,22 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
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
 
@@ -1160,12 +1170,55 @@ void __init sve_setup(void)
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
+ * Return how many bytes of memory are required to store the full SME
+ * specific state (currently just ZA) for task, given task's currently
+ * configured vector length.
+ */
+size_t za_state_size(struct task_struct const *task)
+{
+	unsigned int vl = task_get_sme_vl(task);
+
+	return ZA_SIG_REGS_SIZE(sve_vq_from_vl(vl));
+}
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
@@ -1264,6 +1317,29 @@ void __init sme_setup(void)
 
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
@@ -1295,22 +1371,77 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
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
 	 */
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
+	 */
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
 
@@ -1427,8 +1558,11 @@ void fpsimd_flush_thread(void)
 		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}
 
-	if (system_supports_sme())
+	if (system_supports_sme()) {
+		clear_thread_flag(TIF_SME);
+		sme_free(current);
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
+	}
 
 	put_cpu_fpsimd_context();
 }
@@ -1477,14 +1611,22 @@ static void fpsimd_bind_task_to_cpu(void)
 	last->sme_vl = task_get_sme_vl(current);
 	current->thread.fpsimd_cpu = smp_processor_id();
 
+	/*
+	 * Toggle SVE and SME trapping for userspace if needed, these
+	 * are serialsied by ret_to_user()
+	 */
 	if (system_supports_sve()) {
-		/* Toggle SVE trapping for userspace if needed */
 		if (test_thread_flag(TIF_SVE))
 			sve_user_enable();
 		else
 			sve_user_disable();
+	}
 
-		/* Serialised by exception return to user */
+	if (system_supports_sme()) {
+		if (test_thread_flag(TIF_SME))
+			sme_user_enable();
+		else
+			sme_user_disable();
 	}
 }
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4dd35619ece6..cbd6b12c4339 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -298,17 +298,19 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
 
 	/*
-	 * Detach src's sve_state (if any) from dst so that it does not
-	 * get erroneously used or freed prematurely.  dst's sve_state
-	 * will be allocated on demand later on if dst uses SVE.
-	 * For consistency, also clear TIF_SVE here: this could be done
+	 * Detach src's sve/za_state (if any) from dst so that it does not
+	 * get erroneously used or freed prematurely.  dst's copies
+	 * will be allocated on demand later on if dst uses SVE/SME.
+	 * For consistency, also clear TIF_SVE/SME here: this could be done
 	 * later in copy_process(), but to avoid tripping up future
-	 * maintainers it is best not to leave TIF_SVE and sve_state in
+	 * maintainers it is best not to leave TIF flags and buffers in
 	 * an inconsistent state, even temporarily.
 	 */
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
+	dst->thread.za_state = NULL;
+	clear_tsk_thread_flag(dst, TIF_SME);
 	dst->thread.svcr = 0;
 
 	/* clear any pending asynchronous tag fault raised by the parent */
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 50a0f1a38e84..c2237da046f3 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -158,11 +158,50 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
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
+	 * task and fall through to disabling SVE too.
+	 *
+	 * Since with SME traps disabled userspace can freely enter
+	 * and exit streaming mode and SVE register state is shared
+	 * between the two it is simpler to just leave SVE enabled
+	 * while userspace is actively using SME than to track state
+	 * transitions.
+	 */
+	if (system_supports_sme() && test_thread_flag(TIF_SME)) {
+		u64 svcr = read_sysreg_s(SYS_SVCR_EL0);
+
+		if (svcr & SYS_SVCR_EL0_SM_MASK)
+			sme_smstop_sm();
+
+		if (svcr & SYS_SVCR_EL0_ZA_MASK) {
+			unsigned long sve_vq_minus_one =
+				sve_vq_from_vl(task_get_sve_vl(current)) - 1;
+			sve_flush_live(true, sve_vq_minus_one);
+			return;
+		} else {
+			clear_thread_flag(TIF_SME);
+			sme_user_disable();
+		}
+	}
+
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
@@ -177,7 +216,7 @@ static inline void sve_user_discard(void)
 
 void do_el0_svc(struct pt_regs *regs)
 {
-	sve_user_discard();
+	fp_user_discard();
 	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
 }
 
-- 
2.30.2

