Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5F1545CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFON3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 09:13:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40424 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFON3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 09:13:29 -0500
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f5:7989:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7A69529524B;
        Thu,  6 Feb 2020 14:13:20 +0000 (GMT)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     kernel@collabora.com, krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, peterz@infradead.org, dvhart@infradead.org,
        mingo@redhat.com, z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 1/4] futex: Implement mechanism to wait on any of several futexes
Date:   Thu,  6 Feb 2020 11:10:48 -0300
Message-Id: <20200206141051.6124-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206141051.6124-1-andrealmeid@collabora.com>
References: <20200206141051.6124-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

This is a new futex operation, called FUTEX_WAIT_MULTIPLE, which allows
a thread to wait on several futexes at the same time, and be awoken by
any of them.  In a sense, it implements one of the features that was
supported by pooling on the old FUTEX_FD interface.

The use case lies in the Wine implementation of the Windows NT interface
WaitMultipleObjects. This Windows API function allows a thread to sleep
waiting on the first of a set of event sources (mutexes, timers, signal,
console input, etc) to signal.  Considering this is a primitive
synchronization operation for Windows applications, being able to quickly
signal events on the producer side, and quickly go to sleep on the
consumer side is essential for good performance of those running over Wine.

Wine developers have an implementation that uses eventfd, but it suffers
from FD exhaustion (there is applications that go to the order of
multi-milion FDs), and higher CPU utilization than this new operation.

The futex list is passed as an array of `struct futex_wait_block`
(pointer, value, bitset) to the kernel, which will enqueue all of them
and sleep if none was already triggered. It returns a hint of which
futex caused the wake up event to userspace, but the hint doesn't
guarantee that is the only futex triggered.  Before calling the syscall
again, userspace should traverse the list, trying to re-acquire any of
the other futexes, to prevent an immediate -EWOULDBLOCK return code from
the kernel.

This was tested using three mechanisms:

1) By reimplementing FUTEX_WAIT in terms of FUTEX_WAIT_MULTIPLE and
running the unmodified tools/testing/selftests/futex and a full linux
distro on top of this kernel.

2) By an example code that exercises the FUTEX_WAIT_MULTIPLE path on a
multi-threaded, event-handling setup.

3) By running the Wine fsync implementation and executing multi-threaded
applications, in particular modern games, on top of this implementation.

Changes were tested for the following ABIs: x86_64, i386 and x32.
Support for x32 applications is not implemented since it would
take a major rework adding a new entry point and splitting the current
futex 64 entry point in two and we can't change the current x32 syscall
number without breaking user space compatibility.

CC: Steven Rostedt <rostedt@goodmis.org>
Cc: Richard Yao <ryao@gentoo.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Zebediah Figura <z.figura12@gmail.com>
Signed-off-by: Zebediah Figura <z.figura12@gmail.com>
Co-developed-by: Steven Noonan <steven@valvesoftware.com>
Signed-off-by: Steven Noonan <steven@valvesoftware.com>
Co-developed-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[Added compatibility code]
Co-developed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes since RFC:
  - Limit waitlist to 128 futexes
  - Simplify wait loop
  - Document functions
  - Reduce allocated space
  - Return hint if a futex was awoken during setup
  - Check if any futex was awoken prior to sleep
  - Drop relative timer logic
  - Add compatibility struct and entry points
  - Add selftests
---
 include/uapi/linux/futex.h |  20 +++
 kernel/futex.c             | 356 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 374 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0accd5e..580001e89c6c 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -21,6 +21,7 @@
 #define FUTEX_WAKE_BITSET	10
 #define FUTEX_WAIT_REQUEUE_PI	11
 #define FUTEX_CMP_REQUEUE_PI	12
+#define FUTEX_WAIT_MULTIPLE	13
 
 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
@@ -40,6 +41,8 @@
 					 FUTEX_PRIVATE_FLAG)
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
+#define FUTEX_WAIT_MULTIPLE_PRIVATE	(FUTEX_WAIT_MULTIPLE | \
+					 FUTEX_PRIVATE_FLAG)
 
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
@@ -150,4 +153,21 @@ struct robust_list_head {
   (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
    | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
 
+/*
+ * Maximum number of multiple futexes to wait for
+ */
+#define FUTEX_MULTIPLE_MAX_COUNT	128
+
+/**
+ * struct futex_wait_block - Block of futexes to be waited for
+ * @uaddr:	User address of the futex
+ * @val:	Futex value expected by userspace
+ * @bitset:	Bitset for the optional bitmasked wakeup
+ */
+struct futex_wait_block {
+	__u32 __user *uaddr;
+	__u32 val;
+	__u32 bitset;
+};
+
 #endif /* _UAPI_LINUX_FUTEX_H */
diff --git a/kernel/futex.c b/kernel/futex.c
index 0cf84c8664f2..0580ab383e5c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -215,6 +215,8 @@ struct futex_pi_state {
  * @rt_waiter:		rt_waiter storage for use with requeue_pi
  * @requeue_pi_key:	the requeue_pi target futex key
  * @bitset:		bitset for the optional bitmasked wakeup
+ * @uaddr:             userspace address of futex
+ * @uval:              expected futex's value
  *
  * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
  * we can wake only the relevant ones (hashed queues may be shared).
@@ -237,6 +239,8 @@ struct futex_q {
 	struct rt_mutex_waiter *rt_waiter;
 	union futex_key *requeue_pi_key;
 	u32 bitset;
+	u32 __user *uaddr;
+	u32 uval;
 } __randomize_layout;
 
 static const struct futex_q futex_q_init = {
@@ -2420,6 +2424,29 @@ static int unqueue_me(struct futex_q *q)
 	return ret;
 }
 
+/**
+ * unqueue_multiple() - Remove several futexes from their futex_hash_bucket
+ * @q:	The list of futexes to unqueue
+ * @count: Number of futexes in the list
+ *
+ * Helper to unqueue a list of futexes. This can't fail.
+ *
+ * Return:
+ *  - >=0 - Index of the last futex that was awoken;
+ *  - -1  - If no futex was awoken
+ */
+static int unqueue_multiple(struct futex_q *q, int count)
+{
+	int ret = -1;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (!unqueue_me(&q[i]))
+			ret = i;
+	}
+	return ret;
+}
+
 /*
  * PI futexes can not be requeued and must remove themself from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held on entry
@@ -2783,6 +2810,210 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	return ret;
 }
 
+/**
+ * futex_wait_multiple_setup() - Prepare to wait and enqueue multiple futexes
+ * @qs:		The corresponding futex list
+ * @count:	The size of the lists
+ * @flags:	Futex flags (FLAGS_SHARED, etc.)
+ * @awaken:	Index of the last awoken futex
+ *
+ * Prepare multiple futexes in a single step and enqueue them. This may fail if
+ * the futex list is invalid or if any futex was already awoken. On success the
+ * task is ready to interruptible sleep.
+ *
+ * Return:
+ *  -  1 - One of the futexes was awaken by another thread
+ *  -  0 - Success
+ *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
+ */
+static int futex_wait_multiple_setup(struct futex_q *qs, int count,
+				     unsigned int flags, int *awaken)
+{
+	struct futex_hash_bucket *hb;
+	int ret, i;
+	u32 uval;
+
+	/*
+	 * Enqueuing multiple futexes is tricky, because we need to
+	 * enqueue each futex in the list before dealing with the next
+	 * one to avoid deadlocking on the hash bucket.  But, before
+	 * enqueuing, we need to make sure that current->state is
+	 * TASK_INTERRUPTIBLE, so we don't absorb any awake events, which
+	 * cannot be done before the get_futex_key of the next key,
+	 * because it calls get_user_pages, which can sleep.  Thus, we
+	 * fetch the list of futexes keys in two steps, by first pinning
+	 * all the memory keys in the futex key, and only then we read
+	 * each key and queue the corresponding futex.
+	 */
+retry:
+	for (i = 0; i < count; i++) {
+		qs[i].key = FUTEX_KEY_INIT;
+		ret = get_futex_key(qs[i].uaddr, flags & FLAGS_SHARED,
+				    &qs[i].key, FUTEX_READ);
+		if (unlikely(ret)) {
+			for (--i; i >= 0; i--)
+				put_futex_key(&qs[i].key);
+			return ret;
+		}
+	}
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	for (i = 0; i < count; i++) {
+		struct futex_q *q = &qs[i];
+
+		hb = queue_lock(q);
+
+		ret = get_futex_value_locked(&uval, q->uaddr);
+		if (ret) {
+			/*
+			 * We need to try to handle the fault, which
+			 * cannot be done without sleep, so we need to
+			 * undo all the work already done, to make sure
+			 * we don't miss any wake ups.  Therefore, clean
+			 * up, handle the fault and retry from the
+			 * beginning.
+			 */
+			queue_unlock(hb);
+
+			/*
+			 * Keys 0..(i-1) are implicitly put
+			 * on unqueue_multiple.
+			 */
+			put_futex_key(&q->key);
+
+			*awaken = unqueue_multiple(qs, i);
+
+			__set_current_state(TASK_RUNNING);
+
+			/*
+			 * On a real fault, prioritize the error even if
+			 * some other futex was awoken.  Userspace gave
+			 * us a bad address, -EFAULT them.
+			 */
+			ret = get_user(uval, q->uaddr);
+			if (ret)
+				return ret;
+
+			/*
+			 * Even if the page fault was handled, If
+			 * something was already awaken, we can safely
+			 * give up and succeed to give a hint for userspace to
+			 * acquire the right futex faster.
+			 */
+			if (*awaken >= 0)
+				return 1;
+
+			goto retry;
+		}
+
+		if (uval != q->uval) {
+			queue_unlock(hb);
+
+			put_futex_key(&qs[i].key);
+
+			/*
+			 * If something was already awaken, we can
+			 * safely ignore the error and succeed.
+			 */
+			*awaken = unqueue_multiple(qs, i);
+			__set_current_state(TASK_RUNNING);
+			if (*awaken >= 0)
+				return 1;
+
+			return -EWOULDBLOCK;
+		}
+
+		/*
+		 * The bucket lock can't be held while dealing with the
+		 * next futex. Queue each futex at this moment so hb can
+		 * be unlocked.
+		 */
+		queue_me(&qs[i], hb);
+	}
+	return 0;
+}
+
+/**
+ * futex_wait_multiple() - Prepare to wait on and enqueue several futexes
+ * @qs:		The list of futexes to wait on
+ * @op:		Operation code from futex's syscall
+ * @count:	The number of objects
+ * @abs_time:	Timeout before giving up and returning to userspace
+ *
+ * Entry point for the FUTEX_WAIT_MULTIPLE futex operation, this function
+ * sleeps on a group of futexes and returns on the first futex that
+ * triggered, or after the timeout has elapsed.
+ *
+ * Return:
+ *  - >=0 - Hint to the futex that was awoken
+ *  - <0  - On error
+ */
+static int futex_wait_multiple(struct futex_q *qs, int op,
+			       u32 count, ktime_t *abs_time)
+{
+	struct hrtimer_sleeper timeout, *to;
+	int ret, i, flags = 0, hint = 0;
+
+	if (!(op & FUTEX_PRIVATE_FLAG))
+		flags |= FLAGS_SHARED;
+
+	if (op & FUTEX_CLOCK_REALTIME)
+		flags |= FLAGS_CLOCKRT;
+
+	to = futex_setup_timer(abs_time, &timeout, flags, 0);
+	while (1) {
+		ret = futex_wait_multiple_setup(qs, count, flags, &hint);
+		if (ret) {
+			if (ret > 0) {
+				/* A futex was awaken during setup */
+				ret = hint;
+			}
+			break;
+		}
+
+		if (to)
+			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
+
+		/*
+		 * Avoid sleeping if another thread already tried to
+		 * wake us.
+		 */
+		for (i = 0; i < count; i++) {
+			if (plist_node_empty(&qs[i].list))
+				break;
+		}
+
+		if (i == count && (!to || to->task))
+			freezable_schedule();
+
+		ret = unqueue_multiple(qs, count);
+
+		__set_current_state(TASK_RUNNING);
+
+		if (ret >= 0)
+			break;
+		if (to && !to->task) {
+			ret = -ETIMEDOUT;
+			break;
+		} else if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+		/*
+		 * The final case is a spurious wakeup, for
+		 * which just retry.
+		 */
+	}
+
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
+
+	return ret;
+}
+
 static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset)
 {
@@ -3907,6 +4138,43 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	return -ENOSYS;
 }
 
+/**
+ * futex_read_wait_block - Read an array of futex_wait_block from userspace
+ * @uaddr:	Userspace address of the block
+ * @count:	Number of blocks to be read
+ *
+ * This function creates and allocate an array of futex_q (we zero it to
+ * initialize the fields) and then, for each futex_wait_block element from
+ * userspace, fill a futex_q element with proper values.
+ */
+inline struct futex_q *futex_read_wait_block(u32 __user *uaddr, u32 count)
+{
+	int i;
+	struct futex_q *qs;
+	struct futex_wait_block fwb;
+	struct futex_wait_block __user *entry =
+		(struct futex_wait_block __user *) uaddr;
+
+	if (!count || count > FUTEX_MULTIPLE_MAX_COUNT)
+		return ERR_PTR(-EINVAL);
+
+	qs = kcalloc(count, sizeof(*qs), GFP_KERNEL);
+	if (!qs)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < count; i++) {
+		if (copy_from_user(&fwb, &entry[i], sizeof(fwb))) {
+			kfree(qs);
+			return ERR_PTR(-EFAULT);
+		}
+
+		qs[i].uval = fwb.val;
+		qs[i].uaddr = fwb.uaddr;
+		qs[i].bitset = fwb.bitset;
+	}
+
+	return qs;
+}
 
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
@@ -3919,7 +4187,8 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
 		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+		      cmd == FUTEX_WAIT_REQUEUE_PI ||
+		      cmd == FUTEX_WAIT_MULTIPLE)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
 		if (get_timespec64(&ts, utime))
@@ -3940,6 +4209,24 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
 		val2 = (u32) (unsigned long) utime;
 
+	if (cmd == FUTEX_WAIT_MULTIPLE) {
+		int ret;
+		struct futex_q *qs;
+
+		if (unlikely(in_x32_syscall()))
+			return -ENOSYS;
+
+		qs = futex_read_wait_block(uaddr, val);
+
+		if (IS_ERR(qs))
+			return PTR_ERR(qs);
+
+		ret = futex_wait_multiple(qs, op, val, tp);
+		kfree(qs);
+
+		return ret;
+	}
+
 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
 
@@ -4102,6 +4389,57 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 #endif /* CONFIG_COMPAT */
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
+/**
+ * struct compat_futex_wait_block - Block of futexes to be waited for
+ * @uaddr:	User address of the futex (compatible pointer)
+ * @val:	Futex value expected by userspace
+ * @bitset:	Bitset for the optional bitmasked wakeup
+ */
+struct compat_futex_wait_block {
+	compat_uptr_t	uaddr;
+	__u32 val;
+	__u32 bitset;
+};
+
+/**
+ * compat_futex_read_wait_block - Read an array of futex_wait_block from
+ * userspace
+ * @uaddr:	Userspace address of the block
+ * @count:	Number of blocks to be read
+ *
+ * This function does the same as futex_read_wait_block(), except that it
+ * converts the pointer to the futex from the compat version to the regular one.
+ */
+inline struct futex_q *compat_futex_read_wait_block(u32 __user *uaddr,
+						    u32 count)
+{
+	int i;
+	struct futex_q *qs;
+	struct compat_futex_wait_block fwb;
+	struct compat_futex_wait_block __user *entry =
+		(struct compat_futex_wait_block __user *) uaddr;
+
+	if (!count || count > FUTEX_MULTIPLE_MAX_COUNT)
+		return ERR_PTR(-EINVAL);
+
+	qs = kcalloc(count, sizeof(*qs), GFP_KERNEL);
+	if (!qs)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < count; i++) {
+		if (copy_from_user(&fwb, &entry[i], sizeof(fwb))) {
+			kfree(qs);
+			return ERR_PTR(-EFAULT);
+		}
+
+		qs[i].uaddr = compat_ptr(fwb.uaddr);
+		qs[i].uval = fwb.val;
+		qs[i].bitset = fwb.bitset;
+	}
+
+	return qs;
+}
+
 SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 		struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
@@ -4113,7 +4451,8 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
 		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+		      cmd == FUTEX_WAIT_REQUEUE_PI ||
+		      cmd == FUTEX_WAIT_MULTIPLE)) {
 		if (get_old_timespec32(&ts, utime))
 			return -EFAULT;
 		if (!timespec64_valid(&ts))
@@ -4128,6 +4467,19 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
 		val2 = (int) (unsigned long) utime;
 
+	if (cmd == FUTEX_WAIT_MULTIPLE) {
+		int ret;
+		struct futex_q *qs = compat_futex_read_wait_block(uaddr, val);
+
+		if (IS_ERR(qs))
+			return PTR_ERR(qs);
+
+		ret = futex_wait_multiple(qs, op, val, tp);
+		kfree(qs);
+
+		return ret;
+	}
+
 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
 #endif /* CONFIG_COMPAT_32BIT_TIME */
-- 
2.25.0

