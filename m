Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC3FD781F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 16:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfJOONn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 10:13:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39662 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbfJOONm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 10:13:42 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKNZy-0004YA-L2; Tue, 15 Oct 2019 14:13:38 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Christian Kellner <christian@kellner.me>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-api@vger.kernel.org
Subject: [PATCH 1/2] pidfd: verify task is alive when printing fdinfo
Date:   Tue, 15 Oct 2019 16:13:31 +0200
Message-Id: <20191015141332.4055-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, when a task is dead we still print the pid it used to use in
the fdinfo files of its pidfds. This doesn't make much sense since the
pid may have already been reused. So verify that the task is still
alive. If the task is not alive anymore, we will print -1. This allows
us to differentiate between a task not being present in a given pid
namespace - in which case we already print 0 - and a task having been
reaped.

Note that this uses PIDTYPE_PID for the check. Technically, we could've
checked PIDTYPE_TGID since pidfds currently only refer to thread-group
leaders but if they won't anymore in the future then this check becomes
problematic without it being immediately obvious to non-experts imho. If
a thread is created via clone(CLONE_THREAD) than struct pid has a single
non-empty list pid->tasks[PIDTYPE_PID] and this pid can't be used as a
PIDTYPE_TGID meaning pid->tasks[PIDTYPE_TGID] will return NULL even
though the thread-group leader might still be very much alive. We could
be more complicated and do something like:

bool alive = false;
rcu_read_lock();
struct task_struct *tsk = pid_task(pid, PIDTYPE_PID);
if (tsk && task_tgid(tsk))
	alive = true;
rcu_read_unlock();

but it's really not worth it. We already have created a pidfd and we
thus know it refers to a thread-group leader. Checking PIDTYPE_PID is
fine and is easier to maintain should we ever allow pidfds to refer to
threads.

Cc: Jann Horn <jannh@google.com>
Cc: Christian Kellner <christian@kellner.me>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-api@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/fork.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 782986962d47..a67944a5e542 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1695,6 +1695,18 @@ static int pidfd_release(struct inode *inode, struct file *file)
 }
 
 #ifdef CONFIG_PROC_FS
+static inline bool task_alive(struct pid *pid)
+{
+	bool alive = true;
+
+	rcu_read_lock();
+	if (!pid_task(pid, PIDTYPE_PID))
+		alive = false;
+	rcu_read_unlock();
+
+	return alive;
+}
+
 /**
  * pidfd_show_fdinfo - print information about a pidfd
  * @m: proc fdinfo file
@@ -1732,15 +1744,20 @@ static int pidfd_release(struct inode *inode, struct file *file)
  */
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
-	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
-	pid_t nr = pid_nr_ns(pid, ns);
+	struct pid_namespace *ns;
+	pid_t nr = -1;
+
+	if (likely(task_alive(pid))) {
+		ns = proc_pid_ns(file_inode(m->file));
+		nr = pid_nr_ns(pid, ns);
+	}
 
-	seq_put_decimal_ull(m, "Pid:\t", nr);
+	seq_put_decimal_ll(m, "Pid:\t", nr);
 
 #ifdef CONFIG_PID_NS
-	seq_put_decimal_ull(m, "\nNSpid:\t", nr);
-	if (nr) {
+	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
+	if (nr > 0) {
 		int i;
 
 		/* If nr is non-zero it means that 'pid' is valid and that
@@ -1749,7 +1766,7 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 		 * Start at one below the already printed level.
 		 */
 		for (i = ns->level + 1; i <= pid->level; i++)
-			seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
+			seq_put_decimal_ll(m, "\t", pid->numbers[i].nr);
 	}
 #endif
 	seq_putc(m, '\n');
-- 
2.23.0

