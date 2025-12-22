Return-Path: <linux-kselftest+bounces-47838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B186CD5E2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CE9A300F708
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F732A3CA;
	Mon, 22 Dec 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Nmtk4AEv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223A329C73;
	Mon, 22 Dec 2025 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404117; cv=none; b=JxhvwBjF+TZpF+QJ0gNnV9X+ackl5Rjznu5peceErc1wyYVDgt6TwxDubYoA4nqxguA6Mpt8M8c/gZU4iZq5rJXuuBkx/fG5q3RahaVJp7cevZsIijMgZvdlwwufK21Fxrh/q9QWHtxgbss73S2HdzvrP2y5zZY5DjESGOgvH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404117; c=relaxed/simple;
	bh=w+cUrSnTFPj7qB1ZhE5wRIgVWI719XIZTH8tY8rpieI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWr4lWtpwWzInlP5Ecb200lUdsXIN1DPVtfLN/Worlo5zLOC6g9Knz/xWSIFauCDyZ+TqWpxaiPAOkdH+ioOplFzmPg6iN3/cGEP8z652y7QP+kGK+yPkcKzML/hS5Oipopir3chokkksuTbyUFFSyBdYVAW9O/k8cp+W7foQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Nmtk4AEv; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S3hbrlvj9nTle8zD5nundzj0J9i0Kdczvuf9BWM9sBA=;
	b=Nmtk4AEvwXQmD/Kyr7Q6sF5YiVxvdJ4yKktNjmWsoTNDFUOX90ZXuaQHq68uB3JIwjBRvKiNj
	hM5LXkZn3vf7Rv21+HsbhvpjBNL+U2tIS/S8HufXp0m9Urd/gr7wvUAlUk6Z5KE/k61cQpXTNgf
	npauqpC+TR/O3miBueiw71I=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dZbtK2QM1zcZxm;
	Mon, 22 Dec 2025 19:45:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B24140538;
	Mon, 22 Dec 2025 19:48:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <kevin.brodsky@arm.com>, <macro@orcam.me.uk>,
	<charlie@rivosinc.com>, <akpm@linux-foundation.org>, <ldv@strace.io>,
	<anshuman.khandual@arm.com>, <mark.rutland@arm.com>, <thuth@redhat.com>,
	<song@kernel.org>, <ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <liqiang01@kylinos.cn>, <pengcan@kylinos.cn>,
	<kmal@cock.li>, <dvyukov@google.com>, <richard.weiyang@gmail.com>,
	<reddybalavignesh9979@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v10 13/16] arm64: entry: Convert to generic entry
Date: Mon, 22 Dec 2025 19:47:34 +0800
Message-ID: <20251222114737.1334364-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114737.1334364-1-ruanjinjie@huawei.com>
References: <20251222114737.1334364-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Currently, x86, Riscv, Loongarch use the generic entry which makes
maintainers' work easier and codes more elegant. arm64 has already
switched to the generic IRQ entry, so completely convert arm64 to use
the generic entry infrastructure from kernel/entry/*.

The changes are below:
 - Remove TIF_SYSCALL_* flag.

 - Remove _TIF_SYSCALL_WORK/EXIT_WORK as they are equal with
   SYSCALL_WORK_ENTER/EXIT.

 - Implement arch_ptrace_report_syscall_entry/exit() with
   report_syscall_entry/exit() to do arm64-specific save/restore
   during syscall entry/exit.

 - Remove arm64 syscall_trace_enter() and related sub-functions
   including syscall_enter_audit(), by calling generic entry's
   functions with similar functionality.

 - Set/clear SYSCALL_EXIT_TRAP flag when enable/disable single_step,
   So _TIF_SINGLESTEP can be replaced with generic SYSCALL_EXIT_TRAP,
   _TIF_SYSCALL_EXIT_WORK and _TIF_SINGLESTEP can be replaced
   with generic SYSCALL_WORK_EXIT, arm64's report_single_step() can be
   replaced with generic version.

 - Remove arm64's syscall_exit_to_user_mode_work_prepare() and
   syscall_exit_work() etc. by using generic entry's similar same name
   functions.

 - Implement arch_syscall_is_vdso_sigreturn() to support "Syscall User
   Dispatch".

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                    |   2 +-
 arch/arm64/include/asm/entry-common.h |  76 +++++++++++++
 arch/arm64/include/asm/syscall.h      |  19 +++-
 arch/arm64/include/asm/thread_info.h  |  19 +---
 arch/arm64/kernel/debug-monitors.c    |   7 ++
 arch/arm64/kernel/ptrace.c            | 153 --------------------------
 arch/arm64/kernel/signal.c            |   2 +-
 arch/arm64/kernel/syscall.c           |   6 +-
 8 files changed, 107 insertions(+), 177 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0a09c7..f50b49ce8b65 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -153,9 +153,9 @@ config ARM64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ENTRY
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP
-	select GENERIC_IRQ_ENTRY
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm64/include/asm/entry-common.h b/arch/arm64/include/asm/entry-common.h
index cab8cd78f693..d8bf4bf342e8 100644
--- a/arch/arm64/include/asm/entry-common.h
+++ b/arch/arm64/include/asm/entry-common.h
@@ -3,14 +3,21 @@
 #ifndef _ASM_ARM64_ENTRY_COMMON_H
 #define _ASM_ARM64_ENTRY_COMMON_H
 
+#include <linux/ptrace.h>
 #include <linux/thread_info.h>
 
+#include <asm/compat.h>
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/fpsimd.h>
 #include <asm/mte.h>
 #include <asm/stacktrace.h>
 
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
 #define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_MTE_ASYNC_FAULT | _TIF_FOREIGN_FPSTATE)
 
 static __always_inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
@@ -54,4 +61,73 @@ static inline bool arch_irqentry_exit_need_resched(void)
 
 #define arch_irqentry_exit_need_resched arch_irqentry_exit_need_resched
 
+static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
+						     enum ptrace_syscall_dir dir,
+						     int *regno)
+{
+	unsigned long saved_reg;
+
+	/*
+	 * We have some ABI weirdness here in the way that we handle syscall
+	 * exit stops because we indicate whether or not the stop has been
+	 * signalled from syscall entry or syscall exit by clobbering a general
+	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
+	 * and restoring its old value after the stop. This means that:
+	 *
+	 * - Any writes by the tracer to this register during the stop are
+	 *   ignored/discarded.
+	 *
+	 * - The actual value of the register is not available during the stop,
+	 *   so the tracer cannot save it and restore it later.
+	 *
+	 * - Syscall stops behave differently to seccomp and pseudo-step traps
+	 *   (the latter do not nobble any registers).
+	 */
+	*regno = (is_compat_task() ? 12 : 7);
+	saved_reg = regs->regs[*regno];
+	regs->regs[*regno] = dir;
+
+	return saved_reg;
+}
+
+static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
+{
+	unsigned long saved_reg;
+	int regno, ret;
+
+	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
+	ret = ptrace_report_syscall_entry(regs);
+	if (ret)
+		forget_syscall(regs);
+	regs->regs[regno] = saved_reg;
+
+	return ret;
+}
+
+#define arch_ptrace_report_syscall_entry arch_ptrace_report_syscall_entry
+
+static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
+							    int step)
+{
+	unsigned long saved_reg;
+	int regno;
+
+	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
+	if (!step) {
+		ptrace_report_syscall_exit(regs, 0);
+		regs->regs[regno] = saved_reg;
+	} else {
+		regs->regs[regno] = saved_reg;
+
+		/*
+		 * Signal a pseudo-step exception since we are stepping but
+		 * tracer modifications to the registers may have rewound the
+		 * state machine.
+		 */
+		ptrace_report_syscall_exit(regs, 1);
+	}
+}
+
+#define arch_ptrace_report_syscall_exit arch_ptrace_report_syscall_exit
+
 #endif /* _ASM_ARM64_ENTRY_COMMON_H */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 7746c8f0e045..240d45735cc5 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -9,6 +9,9 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 
+#include <asm/compat.h>
+#include <asm/vdso.h>
+
 typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
 extern const syscall_fn_t sys_call_table[];
@@ -120,7 +123,19 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
-void syscall_exit_to_user_mode_work_prepare(struct pt_regs *regs);
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	unsigned long sigtramp;
+
+#ifdef CONFIG_COMPAT
+	if (is_compat_task()) {
+		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
+
+		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
+	}
+#endif
+	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
+	return regs->pc == (sigtramp + 8);
+}
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index ef1462b9b00b..90be0c590b86 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -43,6 +43,7 @@ struct thread_info {
 	void			*scs_sp;
 #endif
 	u32			cpu;
+	unsigned long		syscall_work;   /* SYSCALL_WORK_ flags */
 };
 
 #define thread_saved_pc(tsk)	\
@@ -65,11 +66,6 @@ void arch_setup_new_exec(void);
 #define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
 #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
-#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
-#define TIF_SECCOMP		11	/* syscall secure computing */
-#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
@@ -92,27 +88,14 @@ void arch_setup_new_exec(void);
 #define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
 
-#define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_SYSCALL_EMU)
-
-#define _TIF_SYSCALL_EXIT_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SYSCALL_TRACEPOINT)
-
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 29307642f4c9..e67643a70405 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -385,11 +385,18 @@ void user_enable_single_step(struct task_struct *task)
 
 	if (!test_and_set_ti_thread_flag(ti, TIF_SINGLESTEP))
 		set_regs_spsr_ss(task_pt_regs(task));
+
+	/*
+	 * Ensure that a trap is triggered once stepping out of a system
+	 * call prior to executing any user instruction.
+	 */
+	set_task_syscall_work(task, SYSCALL_EXIT_TRAP);
 }
 NOKPROBE_SYMBOL(user_enable_single_step);
 
 void user_disable_single_step(struct task_struct *task)
 {
 	clear_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
+	clear_task_syscall_work(task, SYSCALL_EXIT_TRAP);
 }
 NOKPROBE_SYMBOL(user_disable_single_step);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 2645ddf77369..f575b30b2dc4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
-#include <linux/audit.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -18,7 +17,6 @@
 #include <linux/smp.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
-#include <linux/seccomp.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/signal.h>
@@ -28,7 +26,6 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
-#include <linux/rseq.h>
 
 #include <asm/compat.h>
 #include <asm/cpufeature.h>
@@ -38,13 +35,9 @@
 #include <asm/mte.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
-#include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -2338,152 +2331,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ptrace_request(child, request, addr, data);
 }
 
-enum ptrace_syscall_dir {
-	PTRACE_SYSCALL_ENTER = 0,
-	PTRACE_SYSCALL_EXIT,
-};
-
-static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
-						     enum ptrace_syscall_dir dir,
-						     int *regno)
-{
-	unsigned long saved_reg;
-
-	/*
-	 * We have some ABI weirdness here in the way that we handle syscall
-	 * exit stops because we indicate whether or not the stop has been
-	 * signalled from syscall entry or syscall exit by clobbering a general
-	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
-	 * and restoring its old value after the stop. This means that:
-	 *
-	 * - Any writes by the tracer to this register during the stop are
-	 *   ignored/discarded.
-	 *
-	 * - The actual value of the register is not available during the stop,
-	 *   so the tracer cannot save it and restore it later.
-	 *
-	 * - Syscall stops behave differently to seccomp and pseudo-step traps
-	 *   (the latter do not nobble any registers).
-	 */
-	*regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[*regno];
-	regs->regs[*regno] = dir;
-
-	return saved_reg;
-}
-
-static int report_syscall_entry(struct pt_regs *regs)
-{
-	unsigned long saved_reg;
-	int regno, ret;
-
-	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
-	ret = ptrace_report_syscall_entry(regs);
-	if (ret)
-		forget_syscall(regs);
-	regs->regs[regno] = saved_reg;
-
-	return ret;
-}
-
-static void report_syscall_exit(struct pt_regs *regs)
-{
-	unsigned long saved_reg;
-	int regno;
-
-	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
-	if (!test_thread_flag(TIF_SINGLESTEP)) {
-		ptrace_report_syscall_exit(regs, 0);
-		regs->regs[regno] = saved_reg;
-	} else {
-		regs->regs[regno] = saved_reg;
-
-		/*
-		 * Signal a pseudo-step exception since we are stepping but
-		 * tracer modifications to the registers may have rewound the
-		 * state machine.
-		 */
-		ptrace_report_syscall_exit(regs, 1);
-	}
-}
-
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
-
-int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
-{
-	int ret;
-
-	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		ret = report_syscall_entry(regs);
-		if (ret || (flags & _TIF_SYSCALL_EMU))
-			return NO_SYSCALL;
-	}
-
-	/* Do the secure computing after ptrace; failures should be fast. */
-	if (flags & _TIF_SECCOMP) {
-		ret = __secure_computing();
-		if (ret == -1)
-			return NO_SYSCALL;
-	}
-
-	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
-
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
-		trace_sys_enter(regs, syscall);
-
-		/*
-		 * Probes or BPF hooks in the tracepoint may have changed the
-		 * system call number as well.
-		 */
-		 syscall = syscall_get_nr(current, regs);
-	}
-
-	syscall_enter_audit(regs, syscall);
-
-	return ret ? : syscall;
-}
-
-static inline bool report_single_step(unsigned long flags)
-{
-	if (flags & _TIF_SYSCALL_EMU)
-		return false;
-
-	return flags & _TIF_SINGLESTEP;
-}
-
-static void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
-{
-	bool step;
-
-	audit_syscall_exit(regs);
-
-	if (flags & _TIF_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	step = report_single_step(flags);
-	if (step || flags & _TIF_SYSCALL_TRACE)
-		report_syscall_exit(regs);
-}
-
-void syscall_exit_to_user_mode_work_prepare(struct pt_regs *regs)
-{
-	unsigned long flags = read_thread_flags();
-
-	rseq_syscall(regs);
-
-	if (unlikely(flags & _TIF_SYSCALL_EXIT_WORK) || flags & _TIF_SINGLESTEP)
-		syscall_exit_work(regs, flags);
-}
-
 /*
  * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487D.a.
  * We permit userspace to set SSBS (AArch64 bit 12, AArch32 bit 23) which is
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 1110eeb21f57..d3ec1892b3c7 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -8,8 +8,8 @@
 
 #include <linux/cache.h>
 #include <linux/compat.h>
+#include <linux/entry-common.h>
 #include <linux/errno.h>
-#include <linux/irq-entry-common.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/freezer.h>
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 80b7fd67492e..c440ccb2af62 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -2,6 +2,7 @@
 
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
@@ -68,6 +69,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long flags = read_thread_flags();
 
 	regs->orig_x0 = regs->regs[0];
@@ -101,7 +103,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		return;
 	}
 
-	if (unlikely(flags & _TIF_SYSCALL_WORK)) {
+	if (unlikely(work & SYSCALL_WORK_ENTER)) {
 		/*
 		 * The de-facto standard way to skip a system call using ptrace
 		 * is to set the system call to -1 (NO_SYSCALL) and set x0 to a
@@ -119,7 +121,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 */
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
-		scno = syscall_trace_enter(regs, scno, flags);
+		scno = syscall_trace_enter(regs, scno, work);
 		if (scno == NO_SYSCALL)
 			goto trace_exit;
 	}
-- 
2.34.1


