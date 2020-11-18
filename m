Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B35B2B74CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 04:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgKRD3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 22:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgKRD3M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 22:29:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA5C0613D4;
        Tue, 17 Nov 2020 19:29:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D181B1F44AB3
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 3/7] kernel: Implement selective syscall userspace redirection
Date:   Tue, 17 Nov 2020 22:28:36 -0500
Message-Id: <20201118032840.3429268-4-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118032840.3429268-1-krisman@collabora.com>
References: <20201118032840.3429268-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <off>, <length>, [selector])

The range [<offset>,<offset>+len] is a part of the process memory map
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

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Paul Gofman <gofmanp@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-api@vger.kernel.org
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v6:
  (Matthew Wilcox)
  - Use unsigned long for mode
  (peterZ)
  - Change interface to {offset,len}
  - Use SYSCALL_WORK interface instead of TIF flags

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
---
 fs/exec.c                             |   3 +
 include/linux/sched.h                 |   2 +
 include/linux/syscall_user_dispatch.h |  40 ++++++++++
 include/linux/thread_info.h           |   2 +
 include/uapi/linux/prctl.h            |   5 ++
 kernel/entry/Makefile                 |   2 +-
 kernel/entry/common.h                 |  16 ++++
 kernel/entry/syscall_user_dispatch.c  | 102 ++++++++++++++++++++++++++
 kernel/fork.c                         |   1 +
 kernel/sys.c                          |   5 ++
 10 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/entry/common.h
 create mode 100644 kernel/entry/syscall_user_dispatch.c

diff --git a/fs/exec.c b/fs/exec.c
index 547a2390baf5..aee36e5733ce 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -64,6 +64,7 @@
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1302,6 +1303,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
+	clear_syscall_work_syscall_user_dispatch(me);
+
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
 	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..6d1c1f5e74fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <linux/syscall_user_dispatch.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -965,6 +966,7 @@ struct task_struct {
 	unsigned int			sessionid;
 #endif
 	struct seccomp			seccomp;
+	struct syscall_user_dispatch	syscall_dispatch;
 
 	/* Thread group tracking: */
 	u64				parent_exec_id;
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
new file mode 100644
index 000000000000..9517ea16f090
--- /dev/null
+++ b/include/linux/syscall_user_dispatch.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#ifndef _SYSCALL_USER_DISPATCH_H
+#define _SYSCALL_USER_DISPATCH_H
+
+#include <linux/thread_info.h>
+
+#ifdef CONFIG_GENERIC_ENTRY
+
+struct syscall_user_dispatch {
+	char __user *selector;
+	unsigned long offset;
+	unsigned long len;
+	bool on_dispatch;
+};
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector);
+
+#define clear_syscall_work_syscall_user_dispatch(tsk) \
+	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
+
+#else
+struct syscall_user_dispatch {};
+
+static inline int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+					    unsigned long len, char __user *selector)
+{
+	return -EINVAL;
+}
+
+static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *tsk)
+{
+}
+
+#endif /* CONFIG_GENERIC_ENTRY */
+
+#endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 317363212ae9..45708a2602b9 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -41,6 +41,7 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_TRACE,
 	SYSCALL_WORK_BIT_SYSCALL_EMU,
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
+	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -48,6 +49,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
 #define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
+#define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
 
 #include <asm/thread_info.h>
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7f0827705c9a..90deb41c8a34 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -247,4 +247,9 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Dispatch syscalls to a userspace handler */
+#define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF		0
+# define PR_SYS_DISPATCH_ON		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index 34c8a3f1c735..095c775e001e 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -9,5 +9,5 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
-obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o syscall_user_dispatch.o
 obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
new file mode 100644
index 000000000000..cd0c4e5f143e
--- /dev/null
+++ b/kernel/entry/common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _COMMON_H
+#define _COMMON_H
+
+bool do_syscall_user_dispatch(struct pt_regs *regs);
+
+static inline bool on_syscall_dispatch(void)
+{
+	if (unlikely(current->syscall_dispatch.on_dispatch)) {
+		current->syscall_dispatch.on_dispatch = false;
+		return true;
+	}
+	return false;
+}
+
+#endif
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
new file mode 100644
index 000000000000..131c38a0b628
--- /dev/null
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#include <linux/sched.h>
+#include <linux/prctl.h>
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
+bool do_syscall_user_dispatch(struct pt_regs *regs)
+{
+	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
+	char state;
+
+	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
+		return false;
+
+	if (unlikely(arch_syscall_is_vdso_sigreturn(regs)))
+		return false;
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
+			return false;
+
+		if (state != PR_SYS_DISPATCH_ON)
+			do_exit(SIGSYS);
+	}
+
+	sd->on_dispatch = true;
+	syscall_rollback(current, regs);
+	trigger_sigsys(regs);
+
+	return true;
+}
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	switch (mode) {
+	case PR_SYS_DISPATCH_OFF:
+		if (offset || len || selector)
+			return -EINVAL;
+		break;
+	case PR_SYS_DISPATCH_ON:
+		/*
+		 * Validate the direct dispatcher region just for basic
+		 * sanity against overflow and a 0-sized dispatcher
+		 * region.  If the user is able to submit a syscall from
+		 * an address, that address is obviously valid.
+		 */
+		if (offset && offset + len <= offset)
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
+	current->syscall_dispatch.offset = offset;
+	current->syscall_dispatch.len = len;
+	current->syscall_dispatch.on_dispatch = false;
+
+	if (mode == PR_SYS_DISPATCH_ON)
+		set_syscall_work(SYSCALL_USER_DISPATCH);
+	else
+		clear_syscall_work(SYSCALL_USER_DISPATCH);
+
+	return 0;
+}
diff --git a/kernel/fork.c b/kernel/fork.c
index 02b689a23457..4a5ecb41f440 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -906,6 +906,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	set_task_stack_end_magic(tsk);
+	clear_syscall_work_syscall_user_dispatch(tsk);
 
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..51f00fe20e4d 100644
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
+		error = set_syscall_user_dispatch(arg2, arg3, arg4,
+						  (char __user *) arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.29.2

