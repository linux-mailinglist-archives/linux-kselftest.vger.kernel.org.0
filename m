Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1A1441CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2020 17:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAUQNT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jan 2020 11:13:19 -0500
Received: from mail.efficios.com ([167.114.26.124]:45050 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUQNT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jan 2020 11:13:19 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 11:13:17 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A7952251478;
        Tue, 21 Jan 2020 11:03:32 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qi7IjiNd28gQ; Tue, 21 Jan 2020 11:03:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 63EF0251477;
        Tue, 21 Jan 2020 11:03:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 63EF0251477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1579622608;
        bh=OH3jkMAVz+xyUCbKZ3IPz2LZslUGG8p8cy2hZQd6gcY=;
        h=From:To:Date:Message-Id;
        b=dqXtTqRrKbx32swyYQ+p+k3bMPMBpF1iUYVemNRQ8PFTK1dfg+dE4Uk9/KGE9DXiy
         rlRdzvnajROlSN95wA11rmc+51pYdz2xWJv6xI273TfA2bTDHLYXiufl5oZFudryax
         KUuNBd61qWybVFm8cwIlBhZ4ZFJ1cH8P5SnW2r2ENxWAcx05+u1J/MoboNoyynVQkZ
         fmlXnOdE4vejGAE6Ss+i+WDHA61b8L0gSdBM+6f55MzgW0rlK3L8oa0dtbdK9Xk9zZ
         1hlUnr6BRwwumv23+/Vch5+rUxuHxmIioblCTprriH6WlW4gPzTbI6yp7HcnTdcrT9
         aRO/QXqYSTvOg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qfKi8rzknrjM; Tue, 21 Jan 2020 11:03:28 -0500 (EST)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 3149325173C;
        Tue, 21 Jan 2020 11:03:26 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system call
Date:   Tue, 21 Jan 2020 11:03:12 -0500
Message-Id: <20200121160312.26545-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is an important use-case which is not possible with the
"rseq" (Restartable Sequences) system call, which was left as
future work.

That use-case is to modify user-space per-cpu data structures
belonging to specific CPUs which may be brought offline and
online again by CPU hotplug. This can be used by memory
allocators to migrate free memory pools when CPUs are brought
offline, or by ring buffer consumers to target specific per-CPU
buffers, even when CPUs are brought offline.

A few rather complex prior attempts were made to solve this.
Those were based on in-kernel interpreters (cpu_opv, do_on_cpu).
That complexity was generally frowned upon, even by their author.

This patch fulfills this use-case in a refreshingly simple way:
it introduces a "pin_on_cpu" system call, which allows user-space
threads to pin themselves on a specific CPU (which needs to be
present in the thread's allowed cpu mask), and then clear this
pinned state.

"But this can already be done with sched_setaffinity", some
would rightfully reply. However, there is a significant twist
in the way pin_on_cpu deals with CPU hotplug compared to the
allowed cpu mask.

When all CPUs part of the thread's allowed cpu mask are offlined,
this mask is effectively reset to include all CPUs. This behavior
is completely incompatible with modifying per-cpu data structures:
the updates then become racy between concurrent CPUs trying to
update the given per-cpu data.

Conversely, all threads pinned on a given CPU with pin_on_cpu are
guaranteed to be scheduled on the same runqueue when that CPU is
offline. If that CPU is brought back online, the CPU hotplug
scheduler hooks are responsible for migrating back the tasks to
their pinned CPU.

For instance, this allows implementing this userspace library API
for incrementing a per-cpu counter for a specific cpu number
received as parameter:

static inline __attribute__((always_inline))
int percpu_addv(intptr_t *v, intptr_t count, int cpu)
{
        int ret;

        ret = rseq_addv(v, count, cpu);
check:
        if (rseq_unlikely(ret)) {
                pin_on_cpu_set(cpu);
                ret = rseq_addv(v, count, percpu_current_cpu());
                pin_on_cpu_clear();
                goto check;
        }
        return 0;
}

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: linux-kselftest@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: linux-api@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/exec.c                              |   1 +
 include/linux/sched.h                  |   1 +
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/sched.h             |   6 +
 init/init_task.c                       |   1 +
 kernel/sched/core.c                    | 321 +++++++++++++++++++++++--
 kernel/sched/deadline.c                |  54 +++--
 kernel/sched/fair.c                    |  19 ++
 kernel/sched/rt.c                      |  15 +-
 kernel/sched/sched.h                   |  28 +++
 kernel/sys_ni.c                        |   1 +
 14 files changed, 413 insertions(+), 42 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 15908eb9b17e..0b1081a9b872 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -440,3 +440,4 @@
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
 434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
+436	i386	pin_on_cpu		sys_pin_on_cpu			__ia32_sys_pin_on_cpu
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c29976eca4a8..90f9b3cab88d 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,7 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+436	common	pin_on_cpu		__x64_sys_pin_on_cpu
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/exec.c b/fs/exec.c
index c27231234764..6d882dbdd1e3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1827,6 +1827,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	current->pinned_cpu = -1;
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	free_bprm(bprm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7f0bb6fff27c..ac0cac7b8d1d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -651,6 +651,7 @@ struct task_struct {
 	/* Current CPU: */
 	unsigned int			cpu;
 #endif
+	int				pinned_cpu;
 	unsigned int			wakee_flips;
 	unsigned long			wakee_flip_decay_ts;
 	struct task_struct		*last_wakee;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index be0d0cf788ba..46fee5af99e3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1000,6 +1000,7 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
+asmlinkage long sys_pin_on_cpu(int cmd, int flags, int cpu);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1fc8faa6e973..43b0c956cc3c 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -851,8 +851,11 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
 
+#define __NR_pin_on_cpu 436
+__SYSCALL(__NR_pin_on_cpu, sys_pin_on_cpu)
+
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 437
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 25b4fa00bad1..590cdc613698 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -114,4 +114,10 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
 
+enum pin_on_cpu_cmd {
+	PIN_ON_CPU_CMD_QUERY				= 0,
+	PIN_ON_CPU_CMD_SET				= (1 << 0),
+	PIN_ON_CPU_CMD_CLEAR				= (1 << 1),
+};
+
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/init/init_task.c b/init/init_task.c
index 9e5cbe5eab7b..9aabce589cc7 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -88,6 +88,7 @@ struct task_struct init_task
 	.tasks		= LIST_HEAD_INIT(init_task.tasks),
 #ifdef CONFIG_SMP
 	.pushable_tasks	= PLIST_NODE_INIT(init_task.pushable_tasks, MAX_PRIO),
+	.pinned_cpu	= -1,
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	.sched_task_group = &root_task_group,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8dacda4b0362..6ca904d6e0ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -52,6 +52,8 @@ const_debug unsigned int sysctl_sched_features =
 #undef SCHED_FEAT
 #endif
 
+#define PIN_ON_CPU_CMD_BITMASK	(PIN_ON_CPU_CMD_SET | PIN_ON_CPU_CMD_CLEAR)
+
 /*
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
@@ -1457,8 +1459,13 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
-	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
-		return false;
+	if (is_pinned_task(p)) {
+		if (!allowed_pinned_cpu(p, cpu))
+			return false;
+	} else {
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+			return false;
+	}
 
 	if (is_per_cpu_kthread(p))
 		return cpu_online(cpu);
@@ -1662,6 +1669,12 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
+	/* Prevent removing the currently pinned CPU from the allowed cpu mask. */
+	if (is_pinned_task(p) && !cpumask_test_cpu(p->pinned_cpu, new_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	do_set_cpus_allowed(p, new_mask);
 
 	if (p->flags & PF_KTHREAD) {
@@ -1674,6 +1687,10 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 			p->nr_cpus_allowed != 1);
 	}
 
+	/* Task pinned to a CPU overrides allowed cpu mask. */
+	if (is_pinned_task(p))
+		goto out;
+
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), new_mask))
 		goto out;
@@ -1813,11 +1830,20 @@ static int migrate_swap_stop(void *data)
 	if (task_cpu(arg->src_task) != arg->src_cpu)
 		goto unlock;
 
-	if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
-		goto unlock;
-
-	if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
-		goto unlock;
+	if (is_pinned_task(arg->src_task)) {
+		if (!allowed_pinned_cpu(arg->src_task, arg->dst_cpu))
+			goto unlock;
+	} else {
+		if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
+			goto unlock;
+	}
+	if (is_pinned_task(arg->dst_task)) {
+		if (!allowed_pinned_cpu(arg->dst_task, arg->src_cpu))
+			goto unlock;
+	} else {
+		if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
+			goto unlock;
+	}
 
 	__migrate_swap_task(arg->src_task, arg->dst_cpu);
 	__migrate_swap_task(arg->dst_task, arg->src_cpu);
@@ -1858,11 +1884,21 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
 	if (!cpu_active(arg.src_cpu) || !cpu_active(arg.dst_cpu))
 		goto out;
 
-	if (!cpumask_test_cpu(arg.dst_cpu, arg.src_task->cpus_ptr))
-		goto out;
+	if (is_pinned_task(arg.src_task)) {
+		if (!allowed_pinned_cpu(arg.src_task, arg.dst_cpu))
+			goto out;
+	} else {
+		if (!cpumask_test_cpu(arg.dst_cpu, arg.src_task->cpus_ptr))
+			goto out;
+	}
 
-	if (!cpumask_test_cpu(arg.src_cpu, arg.dst_task->cpus_ptr))
-		goto out;
+	if (is_pinned_task(arg.dst_task)) {
+		if (!allowed_pinned_cpu(arg.dst_task, arg.src_cpu))
+			goto out;
+	} else {
+		if (!cpumask_test_cpu(arg.src_cpu, arg.dst_task->cpus_ptr))
+			goto out;
+	}
 
 	trace_sched_swap_numa(cur, arg.src_cpu, p, arg.dst_cpu);
 	ret = stop_two_cpus(arg.dst_cpu, arg.src_cpu, migrate_swap_stop, &arg);
@@ -2034,6 +2070,18 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 	enum { cpuset, possible, fail } state = cpuset;
 	int dest_cpu;
 
+	/*
+	 * If the task is pinned to a CPU which is online, pick that pinned CPU
+	 * number.
+	 * If the task is pinned to a CPU which is offline, pick a CPU which is
+	 * guaranteed to be the same for all tasks pinned to that offlined CPU.
+	 */
+	if (is_pinned_task(p)) {
+		if (cpu_online(p->pinned_cpu))
+			return p->pinned_cpu;
+		else
+			return pinned_cpu_offline_offload(p);
+	}
 	/*
 	 * If the node that the CPU is on has been offlined, cpu_to_node()
 	 * will return -1. There is no CPU on the node, and we should
@@ -2104,10 +2152,15 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
-	if (p->nr_cpus_allowed > 1)
-		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
-	else
-		cpu = cpumask_any(p->cpus_ptr);
+	if (is_pinned_task(p))
+		cpu = p->pinned_cpu;
+	else {
+		if (p->nr_cpus_allowed > 1)
+			cpu = p->sched_class->select_task_rq(p, cpu, sd_flags,
+							     wake_flags);
+		else
+			cpu = cpumask_any(p->cpus_ptr);
+	}
 
 	/*
 	 * In order not to call set_task_cpu() on a blocking task we need
@@ -6130,8 +6183,13 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (curr_cpu == target_cpu)
 		return 0;
 
-	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
-		return -EINVAL;
+	if (is_pinned_task(p)) {
+		if (!allowed_pinned_cpu(p, target_cpu))
+			return -EINVAL;
+	} else {
+		if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
+			return -EINVAL;
+	}
 
 	/* TODO: This is not properly updating schedstats */
 
@@ -6300,6 +6358,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 
 	rq->stop = stop;
 }
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -6380,11 +6439,100 @@ static int cpuset_cpu_inactive(unsigned int cpu)
 	return 0;
 }
 
+static bool skip_pinned_task(int pinned_cpu, int cpu,
+			     bool first_online)
+{
+	if (pinned_cpu < 0)
+		return true;
+	if (first_online) {
+		if (cpu_online(pinned_cpu) && pinned_cpu != cpu)
+			return true;
+	} else {
+		if (pinned_cpu != cpu)
+			return true;
+	}
+	return false;
+}
+
+static void sched_cpu_migrate_pinned_tasks(unsigned int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *p, *t;
+	bool first_online = false;
+
+	if (cpu == cpumask_first(cpu_online_mask))
+		first_online = true;
+
+	/*
+	 * This state transition (online && !active) when going online
+	 * only allow bound kthreads to be scheduled.
+	 * At this point, the CPU is completely online and running,
+	 * but no userspace tasks are scheduled yet.
+	 */
+	read_lock(&tasklist_lock);
+	for_each_process_thread(p, t) {
+		struct rq *target_rq;
+		struct rq_flags rf;
+		int pinned_cpu;
+
+		/*
+		 * Migrate t to cpu if pinned to this cpu.
+		 *
+		 * Migrate t to cpu if its pinned cpu is offline
+		 * and cpu becomes the new first online cpu.
+		 *
+		 * Transition of t->pinned_cpu to cpu can only
+		 * happen if the thread is scheduled on cpu, which
+		 * is impossible at this point because the cpu is
+		 * not active.
+		 *
+		 * Transition of t->pinned_cpu from cpu to -1 or some
+		 * other cpu number may happen concurrently. Therefore,
+		 * skip early (without rq lock), and check again with
+		 * the rq lock held to eliminate concurrent transitions
+		 * from cpu to -1 or some other cpu number.
+		 */
+		pinned_cpu = READ_ONCE(t->pinned_cpu);
+		if (skip_pinned_task(pinned_cpu, cpu, first_online))
+			continue;
+		if (pinned_cpu == cpu)
+			printk("pin_on_cpu migrate to owner: online cpu %d\n",
+			       cpu);
+		if (first_online && !cpu_online(pinned_cpu))
+			printk("pin_on_cpu migrate to new offload cpu %d\n",
+			       cpu);
+		target_rq = task_rq_lock(t, &rf);
+		pinned_cpu = t->pinned_cpu;
+		if (skip_pinned_task(pinned_cpu, cpu, first_online))
+			goto unlock;
+		WARN_ON_ONCE(target_rq == rq);
+		update_rq_clock(target_rq);
+		if (task_running(target_rq, t) || t->state == TASK_WAKING) {
+			struct migration_arg arg = { t, cpu };
+			/* Need help from migration thread: drop lock and wait. */
+			task_rq_unlock(target_rq, t, &rf);
+			stop_one_cpu(cpu_of(target_rq), migration_cpu_stop, &arg);
+			continue;
+		} else if (task_on_rq_queued(t)) {
+			/*
+			 * OK, since we're going to drop the lock immediately
+			 * afterwards anyway.
+			 */
+			rq = move_queued_task(target_rq, &rf, t, cpu);
+		}
+	unlock:
+		task_rq_unlock(target_rq, t, &rf);
+	}
+	read_unlock(&tasklist_lock);
+}
+
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	sched_cpu_migrate_pinned_tasks(cpu);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -7899,6 +8047,145 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+static void do_set_pinned_cpu(struct task_struct *p, int cpu)
+{
+	struct rq *rq = task_rq(p);
+	bool queued, running;
+
+	lockdep_assert_held(&p->pi_lock);
+
+	queued = task_on_rq_queued(p);
+	running = task_current(rq, p);
+
+	if (queued) {
+		/*
+		 * Because __kthread_bind() calls this on blocked tasks without
+		 * holding rq->lock.
+		 */
+		lockdep_assert_held(&rq->lock);
+		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+	}
+	if (running)
+		put_prev_task(rq, p);
+
+	WRITE_ONCE(p->pinned_cpu, cpu);
+
+	if (queued)
+		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
+	if (running)
+		set_next_task(rq, p);
+}
+
+static int __do_pin_on_cpu(int cpu)
+{
+	struct task_struct *p = current;
+	struct rq_flags rf;
+	struct rq *rq;
+	int ret = 0, dest_cpu;
+	struct migration_arg arg = { p };
+
+	cpus_read_lock();
+	rq = task_rq_lock(p, &rf);
+	update_rq_clock(rq);
+	if (cpu >= 0 && !cpumask_test_cpu(cpu, current->cpus_ptr)) {
+		ret = -EINVAL;
+		goto out;
+	}
+#ifdef CONFIG_SMP
+	do_set_pinned_cpu(p, cpu);
+	if (cpu >= 0) {
+		if (cpu_online(cpu))
+			dest_cpu = cpu;
+		else
+			dest_cpu = pinned_cpu_offline_offload(p);
+		if (task_cpu(p) == dest_cpu) {
+			/*
+			 * If the task already runs on the pinned cpu, we're
+			 * done.
+			 */
+			goto out;
+		}
+	} else {
+		/*
+		 * When clearing the pinned cpu, we may need to migrate the
+		 * current task if it is currently sitting on a runqueue which
+		 * does not belong to the allowed mask.
+		 */
+		dest_cpu = cpumask_any(p->cpus_ptr);
+	}
+	arg.dest_cpu = dest_cpu;
+	/* Need help from migration thread: drop lock and wait. */
+	task_rq_unlock(rq, p, &rf);
+	stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+	/* Preempt disable prevents hotplug on current cpu. */
+	preempt_disable();
+	WARN_ON_ONCE(cpu >= 0 && cpu_online(cpu) &&
+		     smp_processor_id() != cpu);
+	preempt_enable();
+	cpus_read_unlock();
+	return 0;
+#endif
+out:
+	task_rq_unlock(rq, p, &rf);
+	cpus_read_unlock();
+	return ret;
+}
+
+static int pin_on_cpu_set(int cpu)
+{
+	if (cpu < 0 || !cpu_possible(cpu)) {
+		return -EINVAL;
+	}
+	return __do_pin_on_cpu(cpu);
+}
+
+static int pin_on_cpu_clear(void)
+{
+	return __do_pin_on_cpu(-1);
+}
+
+/*
+ * sys_pin_on_cpu - pin current task to a specific cpu.
+ * @cmd: command to issue (enum pin_on_cpu_cmd)
+ * @flags: system call flags
+ * @cpu: cpu where the task should run.
+ *
+ * Returns -EINVAL if cmd is unknown.
+ * Returns -EINVAL if flags are unknown.
+ * Returns -EINVAL if the CPU is not part of the possible CPUs.
+ * Returns -EINVAL if the CPU is not part of the allowed cpu mask
+ * for the current task.
+ *
+ * PIN_ON_CPU_CMD_QUERY: Return the mask of supported commands.
+ * PIN_ON_CPU_CMD_SET: Pin the current task to a specific CPU.
+ * PIN_ON_CPU_CMD_CLEAR: Clear cpu pinning for current task.
+ *
+ * If the pinned CPU is online, the current task will run on that CPU.
+ *
+ * If the pinned CPU is offline, the scheduler guarantees that
+ * all tasks pinned to that CPU number are moved to the same
+ * runqueue.
+ *
+ * Removing the pinned CPU from the task's allowed cpu mask is
+ * forbidden.
+ */
+SYSCALL_DEFINE3(pin_on_cpu, int, cmd, int, flags, int, cpu)
+{
+	if (unlikely(flags))
+		return -EINVAL;
+	switch (cmd) {
+	case PIN_ON_CPU_CMD_QUERY:
+		return PIN_ON_CPU_CMD_BITMASK;
+	case PIN_ON_CPU_CMD_SET:
+		return pin_on_cpu_set(cpu);
+	case PIN_ON_CPU_CMD_CLEAR:
+		return pin_on_cpu_clear();
+	default:
+		return -EINVAL;
+	}
+}
+
 void dump_cpu_task(int cpu)
 {
 	pr_info("Task dump for CPU %d:\n", cpu);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a8a08030a8f7..8a1581e8509e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -535,24 +535,31 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 	if (!later_rq) {
 		int cpu;
 
-		/*
-		 * If we cannot preempt any rq, fall back to pick any
-		 * online CPU:
-		 */
-		cpu = cpumask_any_and(cpu_active_mask, p->cpus_ptr);
-		if (cpu >= nr_cpu_ids) {
-			/*
-			 * Failed to find any suitable CPU.
-			 * The task will never come back!
-			 */
-			BUG_ON(dl_bandwidth_enabled());
-
+		if (is_pinned_task(p)) {
+			if (cpu_online(p->pinned_cpu))
+				cpu = p->pinned_cpu;
+			else
+				cpu = pinned_cpu_offline_offload(p);
+		} else {
 			/*
-			 * If admission control is disabled we
-			 * try a little harder to let the task
-			 * run.
+			 * If we cannot preempt any rq, fall back to pick any
+			 * online CPU:
 			 */
-			cpu = cpumask_any(cpu_active_mask);
+			cpu = cpumask_any_and(cpu_active_mask, p->cpus_ptr);
+			if (cpu >= nr_cpu_ids) {
+				/*
+				 * Failed to find any suitable CPU.
+				 * The task will never come back!
+				 */
+				BUG_ON(dl_bandwidth_enabled());
+
+				/*
+				 * If admission control is disabled we
+				 * try a little harder to let the task
+				 * run.
+				 */
+				cpu = cpumask_any(cpu_active_mask);
+			}
 		}
 		later_rq = cpu_rq(cpu);
 		double_lock_balance(rq, later_rq);
@@ -1836,9 +1843,15 @@ static void task_fork_dl(struct task_struct *p)
 
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
-		return 1;
+	if (!task_running(rq, p)) {
+		if (is_pinned_task(p)) {
+			if (allowed_pinned_cpu(p, cpu))
+				return 1;
+		} else {
+			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+				return 1;
+		}
+	}
 	return 0;
 }
 
@@ -1987,7 +2000,8 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
+				     (is_pinned_task(task) && !allowed_pinned_cpu(task, later_rq->cpu)) ||
+				     (!is_pinned_task(task) && !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr)) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5709ff..e96ae1ce9829 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7223,6 +7223,25 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	lockdep_assert_held(&env->src_rq->lock);
 
+	if (is_pinned_task(p)) {
+		if (task_running(env->src_rq, p)) {
+			schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+			return 0;
+		}
+		if (cpu_online(p->pinned_cpu)) {
+			if (env->dst_cpu == p->pinned_cpu)
+				return 1;
+			else
+				return 0;
+		} else {
+			if (env->dst_cpu ==
+			    pinned_cpu_offline_offload(p))
+				return 1;
+			else
+				return 0;
+		}
+	}
+
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9b8adc01be3d..2774311e5750 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1600,9 +1600,15 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
-		return 1;
+	if (!task_running(rq, p)) {
+		if (is_pinned_task(p)) {
+			if (allowed_pinned_cpu(p, cpu))
+				return 1;
+		} else {
+			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+				return 1;
+		}
+	}
 
 	return 0;
 }
@@ -1738,7 +1744,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * Also make sure that it wasn't scheduled on its rq.
 			 */
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr) ||
+				     (is_pinned_task(task) && !allowed_pinned_cpu(task, lowest_rq->cpu)) ||
+				     (!is_pinned_task(task) && !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr)) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 49ed949f850c..922bc618cc87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -187,6 +187,34 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
+/*
+ * All tasks which require to be pinned on offlined CPUs are sent
+ * to runqueue of the first online CPU.
+ */
+static inline bool is_pinned_task(struct task_struct *p)
+{
+	return p->pinned_cpu >= 0;
+}
+
+static inline int pinned_cpu_offline_offload(struct task_struct *p)
+{
+	return cpumask_first(cpu_online_mask);
+}
+
+static inline bool allowed_pinned_cpu(struct task_struct *p, int cpu)
+{
+	if (!cpu_possible(cpu))
+		return false;
+	if (cpu_online(p->pinned_cpu)) {
+		if (p->pinned_cpu == cpu)
+			return true;
+	} else {
+		if (cpu == pinned_cpu_offline_offload(p))
+			return true;
+	}
+	return false;
+}
+
 #define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
 
 /*
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 34b76895b81e..7e5192cd8d9d 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -449,3 +449,4 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+COND_SYSCALL(pin_on_cpu);
-- 
2.17.1

