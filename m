Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7969CD6079
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfJNKp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 06:45:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfJNKpz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 06:45:55 -0400
Received: from [212.86.36.32] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iJxrM-0002lB-2a; Mon, 14 Oct 2019 10:45:52 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org
Cc:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v3 1/2] clone3: add CLONE_CLEAR_SIGHAND
Date:   Mon, 14 Oct 2019 12:45:37 +0200
Message-Id: <20191014104538.3096-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reset all signal handlers of the child not set to SIG_IGN to SIG_DFL.
Mutually exclusive with CLONE_SIGHAND to not disturb other thread's
signal handler.

In the spirit of closer cooperation between glibc developers and kernel
developers (cf. [2]) this patchset came out of a discussion on the glibc
mailing list for improving posix_spawn() (cf. [1], [3], [4]). Kernel
support for this feature has been explicitly requested by glibc and I
see no reason not to help them with this.

The child helper process on Linux posix_spawn must ensure that no signal
handlers are enabled, so the signal disposition must be either SIG_DFL
or SIG_IGN. However, it requires a sigprocmask to obtain the current
signal mask and at least _NSIG sigaction calls to reset the signal
handlers for each posix_spawn call or complex state tracking that might
lead to data corruption in glibc. Adding this flags lets glibc avoid
these problems.

[1]: https://www.sourceware.org/ml/libc-alpha/2019-10/msg00149.html
[3]: https://www.sourceware.org/ml/libc-alpha/2019-10/msg00158.html
[4]: https://www.sourceware.org/ml/libc-alpha/2019-10/msg00160.html
[2]: https://lwn.net/Articles/799331/
     '[...] by asking for better cooperation with the C-library projects
     in general. They should be copied on patches containing ABI
     changes, for example. I noted that there are often times where
     C-library developers wish the kernel community had done things
     differently; how could those be avoided in the future? Members of
     the audience suggested that more glibc developers should perhaps
     join the linux-api list. The other suggestion was to "copy Florian
     on everything".'
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org
Cc: linux-api@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191010133518.5420-1-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191011102537.27502-1-christian.brauner@ubuntu.com
- Florian Weimer <fweimer@redhat.com>:
  - update comment in clone3_args_valid()

/* v3 */
- "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>:
  - s/CLONE3_CLEAR_SIGHAND/CLONE_CLEAR_SIGHAND/g
---
 include/uapi/linux/sched.h |  3 +++
 kernel/fork.c              | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 99335e1f4a27..1d500ed03c63 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -33,6 +33,9 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/* Flags for the clone3() syscall. */
+#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
diff --git a/kernel/fork.c b/kernel/fork.c
index 1f6c45f6a734..aa5b5137f071 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1517,6 +1517,11 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 	spin_lock_irq(&current->sighand->siglock);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
 	spin_unlock_irq(&current->sighand->siglock);
+
+	/* Reset all signal handler not set to SIG_IGN to SIG_DFL. */
+	if (clone_flags & CLONE_CLEAR_SIGHAND)
+		flush_signal_handlers(tsk, 0);
+
 	return 0;
 }
 
@@ -2563,11 +2568,8 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 
 static bool clone3_args_valid(const struct kernel_clone_args *kargs)
 {
-	/*
-	 * All lower bits of the flag word are taken.
-	 * Verify that no other unknown flags are passed along.
-	 */
-	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
+	/* Verify that no unknown flags are passed along. */
+	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND))
 		return false;
 
 	/*
@@ -2577,6 +2579,10 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
 	if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
 		return false;
 
+	if ((kargs->flags & (CLONE_SIGHAND | CLONE_CLEAR_SIGHAND)) ==
+	    (CLONE_SIGHAND | CLONE_CLEAR_SIGHAND))
+		return false;
+
 	if ((kargs->flags & (CLONE_THREAD | CLONE_PARENT)) &&
 	    kargs->exit_signal)
 		return false;
-- 
2.23.0

