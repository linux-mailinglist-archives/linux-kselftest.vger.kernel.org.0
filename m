Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5BD25E2C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 22:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIDUcA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 16:32:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42056 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIDUb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 16:31:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0060329B035
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Date:   Fri,  4 Sep 2020 16:31:39 -0400
Message-Id: <20200904203147.2908430-2-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904203147.2908430-1-krisman@collabora.com>
References: <20200904203147.2908430-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Convert TIF_SECCOMP into a generic TI flag for any syscall interception
work being done by the kernel.  The actual type of work is exposed by a
new flag field outside of thread_info.  This ensures that the
syscall_intercept field is only accessed if struct seccomp has to be
accessed already, such that it doesn't incur in a much higher cost to
the seccomp path.

In order to avoid modifying every architecture at once, this patch has a
transition mechanism, such that architectures that define TIF_SECCOMP
continue to work by ignoring the syscall_intercept flag, as long as they
don't support other syscall interception mechanisms like the future
syscall user dispatch.  When migrating TIF_SECCOMP to
TIF_SYSCALL_INTERCEPT, they should adopt the semantics of checking the
syscall_intercept flag, like it is done in the common entry syscall
code, or even better, migrate to the common syscall entry code.

This was tested by running the selftests for seccomp.  No regressions
were observed, and all tests passed (with and without this patch).

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/sched.h             |  6 ++-
 include/linux/seccomp.h           | 20 ++++++++-
 include/linux/syscall_intercept.h | 70 +++++++++++++++++++++++++++++++
 kernel/fork.c                     | 10 ++++-
 kernel/seccomp.c                  |  7 ++--
 5 files changed, 106 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/syscall_intercept.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..3511c98a7849 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -959,7 +959,11 @@ struct task_struct {
 	kuid_t				loginuid;
 	unsigned int			sessionid;
 #endif
-	struct seccomp			seccomp;
+
+	struct {
+		unsigned int			syscall_intercept;
+		struct seccomp			seccomp;
+	};
 
 	/* Thread group tracking: */
 	u64				parent_exec_id;
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef2844c38..027dc462cea9 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -20,6 +20,24 @@
 #include <linux/atomic.h>
 #include <asm/seccomp.h>
 
+/*
+ * Some transitional defines to avoid migrating every architecture code
+ * at once.
+ */
+
+#if defined(TIF_SECCOMP) && defined(TIF_SYSCALL_INTERCEPT)
+# error "TIF_SYSCALL_INTERCEPT and TIF_SECCOMP can't be defined at the same time"
+#endif
+
+/*
+ * If the arch has not transitioned to TIF_SYSCALL_INTERCEPT, this let
+ * seccomp work with these architectures, as long as no other syscall
+ * intercept features are meant to be supported.
+ */
+#ifdef TIF_SECCOMP
+# define TIF_SYSCALL_INTERCEPT TIF_SECCOMP
+#endif
+
 struct seccomp_filter;
 /**
  * struct seccomp - the state of a seccomp'ed process
@@ -42,7 +60,7 @@ struct seccomp {
 extern int __secure_computing(const struct seccomp_data *sd);
 static inline int secure_computing(void)
 {
-	if (unlikely(test_thread_flag(TIF_SECCOMP)))
+	if (unlikely(test_thread_flag(TIF_SYSCALL_INTERCEPT)))
 		return  __secure_computing(NULL);
 	return 0;
 }
diff --git a/include/linux/syscall_intercept.h b/include/linux/syscall_intercept.h
new file mode 100644
index 000000000000..725d157699da
--- /dev/null
+++ b/include/linux/syscall_intercept.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Collabora Ltd.
+ */
+#ifndef _SYSCALL_INTERCEPT_H
+#define _SYSCALL_INTERCEPT_H
+
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/thread_info.h>
+
+#define SYSINT_SECCOMP		0x1
+
+#ifdef TIF_SYSCALL_INTERCEPT
+
+/* seccomp (at least) can modify TIF_SYSCALL_INTERCEPT from a different
+ * thread, which means it can race with itself or with
+ * syscall_user_dispatch. Therefore, TIF_SYSCALL_INTERCEPT and
+ * syscall_intercept are synchronized by tsk->sighand->siglock.
+ */
+
+static inline void __set_tsk_syscall_intercept(struct task_struct *tsk,
+					   unsigned int type)
+{
+	tsk->syscall_intercept |= type;
+
+	if (tsk->syscall_intercept)
+		set_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT);
+}
+
+static inline void __clear_tsk_syscall_intercept(struct task_struct *tsk,
+					     unsigned int type)
+{
+	tsk->syscall_intercept &= ~type;
+
+	if (tsk->syscall_intercept == 0)
+		clear_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT);
+}
+
+static inline void set_tsk_syscall_intercept(struct task_struct *tsk, unsigned int type)
+{
+	spin_lock_irq(&tsk->sighand->siglock);
+	__set_tsk_syscall_intercept(tsk, type);
+	spin_unlock_irq(&tsk->sighand->siglock);
+}
+
+static inline void clear_tsk_syscall_intercept(struct task_struct *tsk, unsigned int type)
+{
+	spin_lock_irq(&tsk->sighand->siglock);
+	__clear_tsk_syscall_intercept(tsk, type);
+	spin_unlock_irq(&tsk->sighand->siglock);
+}
+
+#else
+static inline void __set_tsk_syscall_intercept(struct task_struct *tsk, unsigned int type)
+{
+}
+static inline void set_tsk_syscall_intercept(struct task_struct *tsk, unsigned int type)
+{
+}
+static inline void __clear_tsk_syscall_intercept(struct task_struct *tsk, unsigned int type)
+{
+}
+static inline void clear_tsk_syscall_intercept(struct task_struct *tsk, unsigned int type)
+{
+}
+#endif
+
+#endif
+
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190861bd..a39177bed8ea 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -49,7 +49,7 @@
 #include <linux/cgroup.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
-#include <linux/seccomp.h>
+#include <linux/syscall_intercept.h>
 #include <linux/swap.h>
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
@@ -898,6 +898,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	 * the usage counts on the error path calling free_task.
 	 */
 	tsk->seccomp.filter = NULL;
+	tsk->syscall_intercept = 0;
 #endif
 
 	setup_thread_stack(tsk, orig);
@@ -1620,9 +1621,14 @@ static void copy_seccomp(struct task_struct *p)
 	 * If the parent gained a seccomp mode after copying thread
 	 * flags and between before we held the sighand lock, we have
 	 * to manually enable the seccomp thread flag here.
+	 *
+	 * In addition current sighand lock is asserted, so it is safe
+	 * to use the unlocked version of set_tsk_syscall_intercept.
 	 */
 	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
-		set_tsk_thread_flag(p, TIF_SECCOMP);
+		__set_tsk_syscall_intercept(p, SYSINT_SECCOMP);
+	else
+		__clear_tsk_syscall_intercept(p, SYSINT_SECCOMP);
 #endif
 }
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ee59ce0a323..d0643b500f2e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/sysctl.h>
+#include <linux/syscall_intercept.h>
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 #include <asm/syscall.h>
@@ -352,14 +353,14 @@ static inline void seccomp_assign_mode(struct task_struct *task,
 
 	task->seccomp.mode = seccomp_mode;
 	/*
-	 * Make sure TIF_SECCOMP cannot be set before the mode (and
+	 * Make sure SYSINT_SECCOMP cannot be set before the mode (and
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
 		arch_seccomp_spec_mitigate(task);
-	set_tsk_thread_flag(task, TIF_SECCOMP);
+	__set_tsk_syscall_intercept(task, SYSINT_SECCOMP);
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
@@ -925,7 +926,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 
 	/*
 	 * Make sure that any changes to mode from another thread have
-	 * been seen after TIF_SECCOMP was seen.
+	 * been seen after SYSINT_SECCOMP was seen.
 	 */
 	rmb();
 
-- 
2.28.0

