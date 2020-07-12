Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804B721C75F
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jul 2020 06:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGLEpg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jul 2020 00:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgGLEpg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jul 2020 00:45:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D57C08C5DD;
        Sat, 11 Jul 2020 21:45:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id CBCE52A5023
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        willy@infradead.org, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 1/2] kernel: Implement selective syscall userspace redirection
Date:   Sun, 12 Jul 2020 00:45:15 -0400
Message-Id: <20200712044516.2347844-2-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200712044516.2347844-1-krisman@collabora.com>
References: <20200712044516.2347844-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a mechanism to quickly disable/enable syscall handling for a
specific process and redirect to userspace via SIGSYS.  This is useful
for processes with parts that require syscall redirection and parts that
don't, but who need to perform this boundary crossing really fast,
without paying the cost of a system call to reconfigure syscall handling
on each boundary transition.  This is particularly important for Windows
games running over Wine.

The proposed interface looks like this:

  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <start_addr>, <end_addr>, [selector])

The range [<start_addr>,<end_addr>] is a part of the process memory map
that is allowed to by-pass the redirection code and dispatch syscalls
directly, such that in fast paths a process doesn't need to disable the
trap nor the kernel has to check the selector.  This is essential to
return from SIGSYS to a blocked area without triggering another SIGSYS
from rt_sigreturn.

selector is an optional pointer to a char-sized userspace memory region
that has a key switch for the mechanism. This key switch is set to
either PR_SYS_DISPATCH_ON, PR_SYS_DISPATCH_OFF to enable and disable the
redirection without calling the kernel.

The feature is meant to be set per-thread and it is disabled on
fork/clone/execv.

Internally, this doesn't add overhead to the syscall hot path, and it
requires very little per-architecture support.  I avoided using seccomp,
even though it duplicates some functionality, due to previous feedback
that maybe it shouldn't mix with seccomp since it is not a security
mechanism.  And obviously, this should never be considered a security
mechanism, since any part of the program can by-pass it by using the
syscall dispatcher.

For the sysinfo benchmark, which measures the overhead added to
executing a native syscall that doesn't require interception, the
overhead using only the direct dispatcher region to issue syscalls is
pretty much irrelevant.  The overhead of using the selector goes around
40ns for a native (unredirected) syscall in my system, and it is (as
expected) dominated by the supervisor-mode user-address access.  In
fact, with SMAP off, the overhead is consistently less than 5ns on my
test box.

Right now, it is only supported by x86_64 and x86, but it should be
easily enabled for other architectures.

An example code using this interface can be found at:
  https://gitlab.collabora.com/krisman/syscall-disable-personality

Changes since v2:
  (Matthew Wilcox suggestions)
  - Drop __user on non-ptr type.
  - Move #define closer to similar defs
  - Allow a memory region that can dispatch directly
  (Kees Cook suggestions)
  - Improve kconfig summary line
  - Move flag cleanup on execve to begin_new_exec
  - Hint branch predictor in the syscall path
  (Me)
  - Convert selector to char

Changes since RFC:
  (Kees Cook suggestions)
  - Don't mention personality while explaining the feature
  - Use syscall_get_nr
  - Remove header guard on several places
  - Convert WARN_ON to WARN_ON_ONCE
  - Explicit check for state values
  - Rename to syscall user dispatcher

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Paul Gofman <gofmanp@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/Kconfig                          | 20 ++++++
 arch/x86/Kconfig                      |  1 +
 arch/x86/entry/common.c               |  5 ++
 arch/x86/include/asm/thread_info.h    |  4 +-
 arch/x86/kernel/signal_compat.c       |  2 +-
 fs/exec.c                             |  2 +
 include/linux/sched.h                 |  3 +
 include/linux/syscall_user_dispatch.h | 50 +++++++++++++++
 include/uapi/asm-generic/siginfo.h    |  3 +-
 include/uapi/linux/prctl.h            |  5 ++
 kernel/Makefile                       |  1 +
 kernel/fork.c                         |  1 +
 kernel/sys.c                          |  5 ++
 kernel/syscall_user_dispatch.c        | 92 +++++++++++++++++++++++++++
 14 files changed, 191 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/syscall_user_dispatch.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..0ebd971d0d8f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -465,6 +465,26 @@ config SECCOMP_FILTER
 
 	  See Documentation/userspace-api/seccomp_filter.rst for details.
 
+config HAVE_ARCH_SYSCALL_USER_DISPATCH
+	bool
+	help
+	  An arch should select this symbol if it provides all of these things:
+	  - TIF_SYSCALL_USER_DISPATCH
+	  - syscall_get_arch
+	  - syscall_rollback
+	  - syscall_get_nr
+	  - SIGSYS siginfo_t support
+
+config SYSCALL_USER_DISPATCH
+	bool "Support syscall redirection to userspace dispatcher"
+	depends on HAVE_ARCH_SYSCALL_USER_DISPATCH
+	help
+	  Enable tasks to ask the kernel to redirect syscalls not
+	  issued from a predefined dispatcher back to userspace,
+	  depending on a userspace memory selector.
+
+	  This option is useful to optimize games running over Wine.
+
 config HAVE_ARCH_STACKLEAK
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 883da0abf779..466a3a9c0708 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,6 +149,7 @@ config X86
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SYSCALL_USER_DISPATCH
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f14175193..6c1360a7f260 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -138,6 +138,11 @@ static long syscall_trace_enter(struct pt_regs *regs)
 			return -1L;
 	}
 
+	if (work & _TIF_SYSCALL_USER_DISPATCH) {
+		if (do_syscall_user_dispatch(regs))
+			return -1L;
+	}
+
 #ifdef CONFIG_SECCOMP
 	/*
 	 * Do seccomp after ptrace, to catch any tracer changes.
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..b26a9f2f0491 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -93,6 +93,7 @@ struct thread_info {
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
+#define TIF_SYSCALL_USER_DISPATCH 19	/* Redirect syscall for userspace handling */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
@@ -123,6 +124,7 @@ struct thread_info {
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_SLD		(1 << TIF_SLD)
+#define _TIF_SYSCALL_USER_DISPATCH (1 << TIF_SYSCALL_USER_DISPATCH)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
@@ -136,7 +138,7 @@ struct thread_info {
 /* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
+	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_USER_DISPATCH)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 9ccbf0576cd0..210aecc6eab9 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -31,7 +31,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
-	BUILD_BUG_ON(NSIGSYS  != 1);
+	BUILD_BUG_ON(NSIGSYS  != 2);
 
 	/* This is part of the ABI and can never change in size: */
 	BUILD_BUG_ON(sizeof(compat_siginfo_t) != 128);
diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..849f618ed790 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1386,6 +1386,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
+	clear_tsk_syscall_user_dispatch(me);
+
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
 	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..407b868146e1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -32,6 +32,7 @@
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
 #include <linux/kcsan.h>
+#include <linux/syscall_user_dispatch.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -953,6 +954,8 @@ struct task_struct {
 #endif
 	struct seccomp			seccomp;
 
+	struct syscall_user_dispatch	syscall_dispatch;
+
 	/* Thread group tracking: */
 	u64				parent_exec_id;
 	u64				self_exec_id;
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
new file mode 100644
index 000000000000..a49e2de93705
--- /dev/null
+++ b/include/linux/syscall_user_dispatch.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#ifndef _SYSCALL_USER_DISPATCH_H
+#define _SYSCALL_USER_DISPATCH_H
+
+struct task_struct;
+static void clear_tsk_thread_flag(struct task_struct *tsk, int flag);
+
+#ifdef CONFIG_SYSCALL_USER_DISPATCH
+struct syscall_user_dispatch {
+	char __user *selector;
+	unsigned long dispatcher_start;
+	unsigned long dispatcher_end;
+};
+
+int do_syscall_user_dispatch(struct pt_regs *regs);
+int set_syscall_user_dispatch(int mode, unsigned long dispatcher_start,
+			      unsigned long dispatcher_end,
+			      char __user *selector);
+
+static inline void clear_tsk_syscall_user_dispatch(struct task_struct *tsk)
+{
+	clear_tsk_thread_flag(tsk, TIF_SYSCALL_USER_DISPATCH);
+}
+
+#else
+struct syscall_user_dispatch {};
+
+static inline int set_syscall_user_dispatch(int mode, unsigned long dispatcher_start,
+					    unsigned long dispatcher_end,
+					    char __user *selector)
+{
+	return -EINVAL;
+}
+
+static inline int do_syscall_user_dispatch(struct pt_regs *regs)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static inline void clear_tsk_syscall_user_dispatch(struct task_struct *tsk)
+{
+}
+
+#endif /* CONFIG_SYSCALL_USER_DISPATCH */
+
+#endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..37741908b846 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -284,7 +284,8 @@ typedef struct siginfo {
  * SIGSYS si_codes
  */
 #define SYS_SECCOMP	1	/* seccomp triggered */
-#define NSIGSYS		1
+#define SYS_USER_DISPATCH 2	/* syscall user dispatch triggered */
+#define NSIGSYS		2
 
 /*
  * SIGEMT si_codes
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..96265246383d 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -238,4 +238,9 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Dispatch syscalls to a userspace handler */
+#define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF		0
+# define PR_SYS_DISPATCH_ON		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..158b8c61592f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_SYSCALL_USER_DISPATCH) += syscall_user_dispatch.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..c6b64a849fec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -921,6 +921,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	set_task_stack_end_magic(tsk);
+	clear_tsk_syscall_user_dispatch(tsk);
 
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
diff --git a/kernel/sys.c b/kernel/sys.c
index 00a96746e28a..d85880873c92 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -42,6 +42,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2527,6 +2528,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SET_SYSCALL_USER_DISPATCH:
+		error = set_syscall_user_dispatch((int) arg2, arg3, arg4,
+						  (char __user *) arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/kernel/syscall_user_dispatch.c b/kernel/syscall_user_dispatch.c
new file mode 100644
index 000000000000..39ee29c2b91f
--- /dev/null
+++ b/kernel/syscall_user_dispatch.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#include <linux/sched.h>
+#include <linux/prctl.h>
+#include <linux/syscall_user_dispatch.h>
+#include <linux/uaccess.h>
+#include <linux/signal.h>
+
+#include <asm/syscall.h>
+
+#include <linux/sched/signal.h>
+#include <linux/sched/task_stack.h>
+
+static void trigger_sigsys(struct pt_regs *regs)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGSYS;
+	info.si_code = SYS_USER_DISPATCH;
+	info.si_call_addr = (void __user *)KSTK_EIP(current);
+	info.si_errno = 0;
+	info.si_arch = syscall_get_arch(current);
+	info.si_syscall = syscall_get_nr(current, regs);
+
+	force_sig_info(&info);
+}
+
+int do_syscall_user_dispatch(struct pt_regs *regs)
+{
+	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
+	unsigned long ip = instruction_pointer(regs);
+	char state;
+
+	if (likely(ip >= sd->dispatcher_start && ip <= sd->dispatcher_end))
+		return 0;
+
+	if (likely(sd->selector)) {
+		if (unlikely(__get_user(state, sd->selector)))
+			do_exit(SIGSEGV);
+
+		if (likely(state == 0))
+			return 0;
+
+		if (state != 1)
+			do_exit(SIGSEGV);
+	}
+
+	syscall_rollback(current, regs);
+	trigger_sigsys(regs);
+
+	return 1;
+}
+
+int set_syscall_user_dispatch(int mode, unsigned long dispatcher_start,
+			      unsigned long dispatcher_end, char __user *selector)
+{
+	switch (mode) {
+	case PR_SYS_DISPATCH_OFF:
+		if (dispatcher_start || dispatcher_end || selector)
+			return -EINVAL;
+		break;
+	case PR_SYS_DISPATCH_ON:
+		/*
+		 * Validate the direct dispatcher region just for basic
+		 * sanity.  If the user is able to submit a syscall from
+		 * an address, that address is obviously valid.
+		 */
+		if (dispatcher_end < dispatcher_start)
+			return -EINVAL;
+
+		if (selector && !access_ok(selector, 1))
+			return -EFAULT;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	current->syscall_dispatch.selector = selector;
+	current->syscall_dispatch.dispatcher_start = dispatcher_start;
+	current->syscall_dispatch.dispatcher_end = dispatcher_end;
+
+	if (mode == PR_SYS_DISPATCH_ON)
+		set_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
+	else
+		clear_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
+
+	return 0;
+}
-- 
2.27.0

