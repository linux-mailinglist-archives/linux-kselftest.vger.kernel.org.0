Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9080CFDB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfD3QWS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 12:22:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35340 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfD3QWS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 12:22:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so7079905pgs.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9QRo0ZDNWIQ23X4zjBAyAxfO3UKWQaE061qKNLC8bw=;
        b=QxfWpj9CU9qsi+RwsiOBxPeUP8Jm5VHxgDYrdPX4cGxjf8+oPwEBcoFAb/+FPJZq+3
         HMLeFmYOIeVIWKvtXO+AFKWOuyejHNY1M2aQbbXeR7vzhX1dqioUC+uXElAPRkDPQean
         Xx3gI+FzghB3R2vUZETYpmqdXPHTj4RjefDII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9QRo0ZDNWIQ23X4zjBAyAxfO3UKWQaE061qKNLC8bw=;
        b=fMMEsmthkJOvrGVlfnjowD1gbhljJ3jtqzsLOs73Hnc9ZdCcl1TdOmDn2j6q1fYdEI
         d9TJwF0+4eCIGVKLwGebp04EyM4KZATuEev6d+9ig9CNYmSbFRRhG9R0lYUbIbCLwTQH
         erdSs+pY0YZlJC/WpgK6X6GRNtLGNTghPXvubXQ4JYuTf9EjqsLn0gfVTJclwpGx60lN
         GgK4S7vX7QCSm0Gybk/wMtYIDlvID6cuz5U5KwOl+ncZwu9t9BmP9VbqmqZRjAExnsAx
         fnHcjhmSF3NCv6kRqJ1pK2gNbrKFidhgrOZ4VAQthr5rDnE1vRiRC2jhiPcrTWeoLOWy
         F9Hg==
X-Gm-Message-State: APjAAAXTzSe/1jVBetmj2YvYghAx/uTTt0GUQtUDCAv+Uwm3ouJiqqyP
        kjz/N8Tt5zUtbhZwDuxZj8Ka0A==
X-Google-Smtp-Source: APXvYqyy1CE0n3ouBRRpPWA+0JIlmpd5jBMhdtCTOFDNIo5kngTY2vap0J+Br7yUCERTtOOdIxcsNw==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr10260322pfd.221.1556641337154;
        Tue, 30 Apr 2019 09:22:17 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y68sm2201059pfy.28.2019.04.30.09.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:22:15 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v2 1/2] Add polling support to pidfd
Date:   Tue, 30 Apr 2019 12:21:53 -0400
Message-Id: <20190430162154.61314-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Android low memory killer (LMK) needs to know when a process dies once
it is sent the kill signal. It does so by checking for the existence of
/proc/pid which is both racy and slow. For example, if a PID is reused
between when LMK sends a kill signal and checks for existence of the
PID, since the wrong PID is now possibly checked for existence.

This patch adds polling support to pidfd. Using the polling support, LMK
will be able to get notified when a process exists in race-free and fast
way, and allows the LMK to do other things (such as by polling on other
fds) while awaiting the process being killed to die.

For notification to polling processes, we follow the same existing
mechanism in the kernel used when the parent of the task group is to be
notified of a child's death (do_notify_parent).  This is precisely when
the tasks waiting on a poll of pidfd are also awakened in this patch.

We have decided to include the waitqueue in struct pid for the following
reasons:
1. The wait queue has to survive for the lifetime of the poll. Including
it in task_struct would not be option in this case because the task can
be reaped and destroyed before the poll returns.

2. By including the struct pid for the waitqueue means that during
de_thread(), the new thread group leader automatically gets the new
waitqueue/pid even though its task_struct is different.

Appropriate test cases are added in the second patch to provide coverage
of all the cases the patch is handling.

Andy had a similar patch [1] in the past which was a good reference
however this patch tries to handle different situations properly related
to thread group existence, and how/where it notifies. And also solves
other bugs (waitqueue lifetime).  Daniel had a similar patch [2]
recently which this patch supercedes.

[1] https://lore.kernel.org/patchwork/patch/345098/
[2] https://lore.kernel.org/lkml/20181029175322.189042-1-dancol@google.com/

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Colascione <dancol@google.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Jann Horn <jannh@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: kernel-team@android.com
(Oleg improved the code by showing how to avoid tasklist_lock)
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Co-developed-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---

v1 -> v2:
* Restructure poll code to avoid tasklist_lock (Oleg)
* use task_pid instead of get_pid_task in notify_pidfd (Oleg)
* Added comments to code, commit message nits (Christian)
* Test case nits/improvements (Christian)

RFC -> v1:
* Based on CLONE_PIDFD patches: https://lwn.net/Articles/786244/
* Updated selftests.
* Renamed poll wake function to do_notify_pidfd.
* Removed depending on EXIT flags
* Removed POLLERR flag since semantics are controversial and
  we don't have usecases for it right now (later we can add if there's
  a need for it).

 include/linux/pid.h |  3 +++
 kernel/fork.c       | 29 +++++++++++++++++++++++++++++
 kernel/pid.c        |  2 ++
 kernel/signal.c     | 11 +++++++++++
 4 files changed, 45 insertions(+)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 3c8ef5a199ca..1484db6ca8d1 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -3,6 +3,7 @@
 #define _LINUX_PID_H
 
 #include <linux/rculist.h>
+#include <linux/wait.h>
 
 enum pid_type
 {
@@ -60,6 +61,8 @@ struct pid
 	unsigned int level;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
+	/* wait queue for pidfd notifications */
+	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
 	struct upid numbers[1];
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index 5525837ed80e..721f8c9d2921 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1685,8 +1685,37 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+/*
+ * Poll support for process exit notification.
+ */
+static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
+{
+	struct task_struct *task;
+	struct pid *pid = file->private_data;
+	int poll_flags = 0;
+
+	poll_wait(file, &pid->wait_pidfd, pts);
+
+	rcu_read_lock();
+	task = pid_task(pid, PIDTYPE_PID);
+	WARN_ON_ONCE(task && !thread_group_leader(task));
+
+	/*
+	 * Inform pollers only when the whole thread group exits, if thread
+	 * group leader exits before all other threads in the group, then
+	 * poll(2) should block, similar to the wait(2) family.
+	 */
+	if (!task || (task->exit_state && thread_group_empty(task)))
+		poll_flags = POLLIN | POLLRDNORM;
+	rcu_read_unlock();
+
+	return poll_flags;
+}
+
+
 const struct file_operations pidfd_fops = {
 	.release = pidfd_release,
+	.poll = pidfd_poll,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = pidfd_show_fdinfo,
 #endif
diff --git a/kernel/pid.c b/kernel/pid.c
index 20881598bdfa..5c90c239242f 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -214,6 +214,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
+	init_waitqueue_head(&pid->wait_pidfd);
+
 	upid = pid->numbers + ns->level;
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
diff --git a/kernel/signal.c b/kernel/signal.c
index 1581140f2d99..a17fff073c3d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1800,6 +1800,14 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+static void do_notify_pidfd(struct task_struct *task)
+{
+	struct pid *pid;
+
+	pid = task_pid(task);
+	wake_up_all(&pid->wait_pidfd);
+}
+
 /*
  * Let a parent know about the death of a child.
  * For a stopped/continued status change, use do_notify_parent_cldstop instead.
@@ -1823,6 +1831,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
+	/* Wake up all pidfd waiters */
+	do_notify_pidfd(tsk);
+
 	if (sig != SIGCHLD) {
 		/*
 		 * This is only possible if parent == real_parent.
-- 
2.21.0.593.g511ec345e18-goog
