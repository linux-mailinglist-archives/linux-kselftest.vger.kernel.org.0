Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E311249B1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgHSKuX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 06:50:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53971 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgHSKra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 06:47:30 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8Lcq-0006IE-KO; Wed, 19 Aug 2020 10:47:24 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hewllig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 01/11] fork: introduce kernel_clone()
Date:   Wed, 19 Aug 2020 12:46:45 +0200
Message-Id: <20200819104655.436656-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819104655.436656-1-christian.brauner@ubuntu.com>
References: <20200819104655.436656-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The old _do_fork() helper doesn't follow naming conventions of in-kernel
helpers for syscalls. The process creation cleanup in [1] didn't change the
name to something more reasonable mainly because _do_fork() was used in quite a
few places. So sending this as a separate series seemed the better strategy.

This commit does two things:
1. renames _do_fork() to kernel_clone() but keeps _do_fork() as a simple static
   inline wrapper around kernel_clone().
2. Changes the return type from long to pid_t. This aligns kernel_thread() and
   kernel_clone(). Also, the return value from kernel_clone that is surfaced in
   fork(), vfork(), clone(), and clone3() is taken from pid_vrn() which returns
   a pid_t too.

Follow-up patches will switch each caller of _do_fork() and each place where it
is referenced over to kernel_clone(). After all these changes are done, we can
remove _do_fork() completely and will only be left with kernel_clone().

[1]: 9ba27414f2ec ("Merge tag 'fork-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Matthew Wilcox (Oracle) <willy@infradead.org>:
  - make kernel_clone() return pid_t
---
 include/linux/sched/task.h |  6 +++++-
 kernel/fork.c              | 16 ++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index a98965007eef..d4428039c3c1 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -83,7 +83,11 @@ extern void do_group_exit(int);
 extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
-extern long _do_fork(struct kernel_clone_args *kargs);
+extern pid_t kernel_clone(struct kernel_clone_args *kargs);
+static inline long _do_fork(struct kernel_clone_args *kargs)
+{
+	return kernel_clone(kargs);
+}
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190861bd..d822c7a4b9c4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2384,14 +2384,14 @@ struct mm_struct *copy_init_mm(void)
  *
  * args->exit_signal is expected to be checked for sanity by the caller.
  */
-long _do_fork(struct kernel_clone_args *args)
+pid_t kernel_clone(struct kernel_clone_args *args)
 {
 	u64 clone_flags = args->flags;
 	struct completion vfork;
 	struct pid *pid;
 	struct task_struct *p;
 	int trace = 0;
-	long nr;
+	pid_t nr;
 
 	/*
 	 * For legacy clone() calls, CLONE_PIDFD uses the parent_tid argument
@@ -2477,7 +2477,7 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.stack_size	= (unsigned long)arg,
 	};
 
-	return _do_fork(&args);
+	return kernel_clone(&args);
 }
 
 #ifdef __ARCH_WANT_SYS_FORK
@@ -2488,7 +2488,7 @@ SYSCALL_DEFINE0(fork)
 		.exit_signal = SIGCHLD,
 	};
 
-	return _do_fork(&args);
+	return kernel_clone(&args);
 #else
 	/* can not support in nommu mode */
 	return -EINVAL;
@@ -2504,7 +2504,7 @@ SYSCALL_DEFINE0(vfork)
 		.exit_signal	= SIGCHLD,
 	};
 
-	return _do_fork(&args);
+	return kernel_clone(&args);
 }
 #endif
 
@@ -2542,7 +2542,7 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 		.tls		= tls,
 	};
 
-	return _do_fork(&args);
+	return kernel_clone(&args);
 }
 #endif
 
@@ -2700,7 +2700,7 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
 	if (!clone3_args_valid(&kargs))
 		return -EINVAL;
 
-	return _do_fork(&kargs);
+	return kernel_clone(&kargs);
 }
 #endif
 
@@ -2863,7 +2863,7 @@ int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
 /*
  * unshare allows a process to 'unshare' part of the process
  * context which was originally shared using clone.  copy_*
- * functions used by _do_fork() cannot be used here directly
+ * functions used by kernel_clone() cannot be used here directly
  * because they modify an inactive task_struct that is being
  * constructed. Here we are modifying the current, active,
  * task_struct.
-- 
2.28.0

