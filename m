Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7229D25E2DA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgIDUcP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 16:32:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42092 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIDUcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 16:32:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EB2C029B035
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Paul Gofman <gofmanp@gmail.com>
Subject: [PATCH v6 5/9] kernel: Implement selective syscall userspace redirection
Date:   Fri,  4 Sep 2020 16:31:43 -0400
Message-Id: <20200904203147.2908430-6-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904203147.2908430-1-krisman@collabora.com>
References: <20200904203147.2908430-1-krisman@collabora.com>
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

An example code using this interface can be found at:
  https://gitlab.collabora.com/krisman/syscall-disable-personality

Changes since v4:
  (Andy Lutomirski)
  - Allow sigreturn coming from vDSO
  - Exit with SIGSYS instead of SIGSEGV on bad selector
  (Thomas Gleixner)
  - Use sizeof selector in access_ok
  - Document usage of __get_user
  - Use constant for state value
  - Split out x86 parts
  - Rebase on top of Gleixner's common entry code
  - Don't expose do_syscall_user_dispatch

Changes since v3:
  - NTR.

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
Cc: linux-api@vger.kernel.org
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/Kconfig                          |  21 ++++++
 fs/exec.c                             |   8 ++
 include/linux/sched.h                 |   2 +
 include/linux/syscall_intercept.h     |   1 +
 include/linux/syscall_user_dispatch.h |  29 ++++++++
 include/uapi/linux/prctl.h            |   5 ++
 kernel/entry/Makefile                 |   1 +
 kernel/entry/common.h                 |  15 ++++
 kernel/entry/syscall_user_dispatch.c  | 101 ++++++++++++++++++++++++++
 kernel/sys.c                          |   5 ++
 10 files changed, 188 insertions(+)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/entry/common.h
 create mode 100644 kernel/entry/syscall_user_dispatch.c

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..6e022c5de020 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -468,6 +468,27 @@ config SECCOMP_FILTER
 
 	  See Documentation/userspace-api/seccomp_filter.rst for details.
 
+config HAVE_ARCH_SYSCALL_USER_DISPATCH
+	bool
+	help
+	  An arch should select this symbol if it provides all of these things:
+	  - TIF_SYSCALL_INTERCEPT
+	  - syscall_get_arch
+	  - syscall_rollback
+	  - syscall_get_nr
+	  - SIGSYS siginfo_t support
+	  - arch_syscall_is_vdso_sigreturn
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
diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..9cdf827151c4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,6 +62,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/syscall_intercept.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1418,6 +1419,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
+	/*
+	 * Prevent Syscall User Dispatch from crossing application
+	 * boundaries.  sighand is already unshared, so it is safe to
+	 * use the unlocked version here.
+	 */
+	__clear_tsk_syscall_intercept(me, SYSINT_USER_DISPATCH);
+
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
 	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3511c98a7849..47ce09589072 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <linux/syscall_user_dispatch.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -963,6 +964,7 @@ struct task_struct {
 	struct {
 		unsigned int			syscall_intercept;
 		struct seccomp			seccomp;
+		struct syscall_user_dispatch	syscall_dispatch;
 	};
 
 	/* Thread group tracking: */
diff --git a/include/linux/syscall_intercept.h b/include/linux/syscall_intercept.h
index 725d157699da..21bc2eb668f3 100644
--- a/include/linux/syscall_intercept.h
+++ b/include/linux/syscall_intercept.h
@@ -10,6 +10,7 @@
 #include <linux/thread_info.h>
 
 #define SYSINT_SECCOMP		0x1
+#define SYSINT_USER_DISPATCH	0x2
 
 #ifdef TIF_SYSCALL_INTERCEPT
 
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
new file mode 100644
index 000000000000..f831358bfaab
--- /dev/null
+++ b/include/linux/syscall_user_dispatch.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#ifndef _SYSCALL_USER_DISPATCH_H
+#define _SYSCALL_USER_DISPATCH_H
+
+#ifdef CONFIG_SYSCALL_USER_DISPATCH
+struct syscall_user_dispatch {
+	char __user *selector;
+	unsigned long dispatcher_start;
+	unsigned long dispatcher_end;
+};
+
+int set_syscall_user_dispatch(int mode, unsigned long dispatcher_start,
+			      unsigned long dispatcher_end,
+			      char __user *selector);
+#else
+struct syscall_user_dispatch {};
+
+static inline int set_syscall_user_dispatch(int mode, unsigned long dispatcher_start,
+					    unsigned long dispatcher_end,
+					    char __user *selector)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_SYSCALL_USER_DISPATCH */
+
+#endif /* _SYSCALL_USER_DISPATCH_H */
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
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index 34c8a3f1c735..81182ab5a40c 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -11,3 +11,4 @@ CFLAGS_common.o		+= -fno-stack-protector
 
 obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
 obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
+obj-$(CONFIG_SYSCALL_USER_DISPATCH)	+= syscall_user_dispatch.o
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
new file mode 100644
index 000000000000..557ecaa3fb31
--- /dev/null
+++ b/kernel/entry/common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _COMMON_H
+#define _COMMON_H
+
+#ifdef CONFIG_SYSCALL_USER_DISPATCH
+int do_syscall_user_dispatch(struct pt_regs *regs);
+#else
+static inline int do_syscall_user_dispatch(struct pt_regs *regs)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+#endif /* CONFIG_SYSCALL_USER_DISPATCH */
+
+#endif
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
new file mode 100644
index 000000000000..12ea01711dc7
--- /dev/null
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#include <linux/sched.h>
+#include <linux/prctl.h>
+#include <linux/syscall_intercept.h>
+#include <linux/syscall_user_dispatch.h>
+#include <linux/uaccess.h>
+#include <linux/signal.h>
+#include <linux/elf.h>
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
+	if (unlikely(arch_syscall_is_vdso_sigreturn(regs)))
+		return 0;
+
+	if (likely(sd->selector)) {
+		/*
+		 * access_ok() is performed once, at prctl time, when
+		 * the selector is loaded by userspace.
+		 */
+		if (unlikely(__get_user(state, sd->selector)))
+			do_exit(SIGSEGV);
+
+		if (likely(state == PR_SYS_DISPATCH_OFF))
+			return 0;
+
+		if (state != PR_SYS_DISPATCH_ON)
+			do_exit(SIGSYS);
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
+		if (selector && !access_ok(selector, sizeof(*selector)))
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
+		set_tsk_syscall_intercept(current, SYSINT_USER_DISPATCH);
+	else
+		clear_tsk_syscall_intercept(current, SYSINT_USER_DISPATCH);
+
+	return 0;
+}
diff --git a/kernel/sys.c b/kernel/sys.c
index ab6c409b1159..2786dca862b9 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -42,6 +42,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2530,6 +2531,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SET_SYSCALL_USER_DISPATCH:
+		error = set_syscall_user_dispatch((int) arg2, arg3, arg4,
+						  (char __user *) arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.28.0

