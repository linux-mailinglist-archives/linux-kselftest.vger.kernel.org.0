Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56365D95C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405183AbfJPPhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 11:37:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47472 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405139AbfJPPhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 11:37:19 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKlMS-00050w-2l; Wed, 16 Oct 2019 15:37:16 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@kellner.me, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, jannh@google.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        shuah@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/5] pidfd: verify task is alive when printing fdinfo
Date:   Wed, 16 Oct 2019 17:36:02 +0200
Message-Id: <20191016153606.2326-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015141332.4055-1-christian.brauner@ubuntu.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, when a task is dead we still print the pid it used to use in
the fdinfo files of its pidfds. This doesn't make much sense since the
pid may have already been reused. So verify that the task is still
alive by introducing the task_alive() helper which will be used by other
callers in follow-up patches.
If the task is not alive anymore, we will print -1. This allows us to
differentiate between a task not being present in a given pid namespace
- in which case we already print 0 - and a task having been reaped.

Note that this uses PIDTYPE_PID for the check. Technically, we could've
checked PIDTYPE_TGID since pidfds currently only refer to thread-group
leaders but if they won't anymore in the future then this check becomes
problematic without it being immediately obvious to non-experts imho. If
a thread is created via clone(CLONE_THREAD) than struct pid has a single
non-empty list pid->tasks[PIDTYPE_PID] and this pid can't be used as a
PIDTYPE_TGID meaning pid->tasks[PIDTYPE_TGID] will return NULL even
though the thread-group leader might still be very much alive. So
checking PIDTYPE_PID is fine and is easier to maintain should we ever
allow pidfds to refer to threads.

Cc: Jann Horn <jannh@google.com>
Cc: Christian Kellner <christian@kellner.me>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-api@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191015141332.4055-1-christian.brauner@ubuntu.com

/* v2 */
- Oleg Nesterov <oleg@redhat.com>:
  - simplify check whether task is still alive to hlist_empty()
  - optionally introduce generic helper to replace open coded
    hlist_emtpy() checks whether or not a task is alive
- Christian Brauner <christian.brauner@ubuntu.com>:
  - introduce task_alive() helper and use in pidfd_show_fdinfo()
---
 include/linux/pid.h |  4 ++++
 kernel/fork.c       | 17 +++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 9645b1194c98..5f1c8ce10b71 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -85,6 +85,10 @@ static inline struct pid *get_pid(struct pid *pid)
 
 extern void put_pid(struct pid *pid);
 extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
+static inline bool task_alive(struct pid *pid, enum pid_type type)
+{
+	return !hlist_empty(&pid->tasks[type]);
+}
 extern struct task_struct *get_pid_task(struct pid *pid, enum pid_type);
 
 extern struct pid *get_task_pid(struct task_struct *task, enum pid_type type);
diff --git a/kernel/fork.c b/kernel/fork.c
index 782986962d47..ef9a9d661079 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1732,15 +1732,20 @@ static int pidfd_release(struct inode *inode, struct file *file)
  */
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
-	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
-	pid_t nr = pid_nr_ns(pid, ns);
+	struct pid_namespace *ns;
+	pid_t nr = -1;
 
-	seq_put_decimal_ull(m, "Pid:\t", nr);
+	if (likely(task_alive(pid, PIDTYPE_PID))) {
+		ns = proc_pid_ns(file_inode(m->file));
+		nr = pid_nr_ns(pid, ns);
+	}
+
+	seq_put_decimal_ll(m, "Pid:\t", nr);
 
 #ifdef CONFIG_PID_NS
-	seq_put_decimal_ull(m, "\nNSpid:\t", nr);
-	if (nr) {
+	seq_put_decimal_ll(m, "\nNSpid:\t", nr);
+	if (nr > 0) {
 		int i;
 
 		/* If nr is non-zero it means that 'pid' is valid and that
@@ -1749,7 +1754,7 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
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

