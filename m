Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6631BC4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBOP0Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 10:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhBOPZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 10:25:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DACFC061788;
        Mon, 15 Feb 2021 07:24:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 3A5601F44F06
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 04/13] futex2: Implement requeue operation
Date:   Mon, 15 Feb 2021 12:23:55 -0300
Message-Id: <20210215152404.250281-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210215152404.250281-1-andrealmeid@collabora.com>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement requeue interface similarly to FUTEX_CMP_REQUEUE operation.
This is the syscall implemented by this patch:

futex_requeue(struct futex_requeue *uaddr1, struct futex_requeue *uaddr2,
	      unsigned int nr_wake, unsigned int nr_requeue,
	      unsigned int cmpval, unsigned int flags)

struct futex_requeue {
	void *uaddr;
	unsigned int flags;
};

If (uaddr1->uaddr == cmpval), wake at uaddr1->uaddr a nr_wake number of
waiters and then, remove a number of nr_requeue waiters at uaddr1->uaddr
and add them to uaddr2->uaddr list. Each uaddr has its own set of flags,
that must be defined at struct futex_requeue (such as size, shared, NUMA).
The flags argument of the syscall is there just for the sake of
extensibility, and right now it needs to be zero.

Return the number of the woken futexes + the number of requeued ones on
success, error code otherwise.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---

The original FUTEX_CMP_REQUEUE interfaces is such as follows:

futex(*uaddr1, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, *uaddr2, cmpval);

Given that when this interface was created they was only one type of
futex (as opposed to futex2, where there is shared, sizes, and NUMA),
there was no way to specify individual flags for uaddr1 and 2. When
FUTEX_PRIVATE was implemented, a new opcode was created as well
(FUTEX_CMP_REQUEUE_PRIVATE), but they apply both futexes, so they
should be of the same type regarding private/shared. This imposes a
limitation on the use cases of the operation, and to overcome that at futex2,
`struct futex_requeue` was created, so one can set individual flags for
each futex. This flexibility is a trade-off with performance, given that
now we need to perform two extra copy_from_user(). One alternative would
be to use the upper half of flags bits to the first one, and the bottom
half for the second futex, but this would also impose limitations, given
that we would limit by half the flags possibilities. If equal futexes
are common enough, the following extension could be added to overcome
the current performance:

- A flag FUTEX_REQUEUE_EQUAL is added to futex2() flags;
- If futex_requeue() see this flag, that means that both futexes uses
  the same set of attributes.
- Then, the function parses the flags as of futex_wait/wake().
- *uaddr1 and *uaddr2 are used as void* (instead of struct
  futex_requeue) just like wait/wake().

In that way, we could avoid the copy_from_user().
---
 arch/arm/tools/syscall.tbl             |   1 +
 arch/arm64/include/asm/unistd.h        |   2 +-
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/compat.h                 |  12 ++
 include/linux/syscalls.h               |   5 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 kernel/futex2.c                        | 215 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   1 +
 9 files changed, 241 insertions(+), 2 deletions(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 6d0f6626a166..9aa1088024b0 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -458,3 +458,4 @@
 442	common	futex_wait			sys_futex_wait
 443	common	futex_wake			sys_futex_wake
 444	common  futex_waitv                     sys_futex_waitv
+445	common	futex_requeue			sys_futex_requeue
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 64ebdc1ec581..d1cc2849dc00 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		445
+#define __NR_compat_syscalls		446
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index fe242fa0baea..0cd1df235e70 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -449,3 +449,4 @@
 442	i386	futex_wait		sys_futex_wait
 443	i386	futex_wake		sys_futex_wake
 444	i386	futex_waitv		sys_futex_waitv			compat_sys_futex_waitv
+445	i386	futex_requeue		sys_futex_requeue		compat_sys_futex_requeue
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 9d0f07e054d1..abbfddcdb15d 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -366,6 +366,7 @@
 442	common	futex_wait		sys_futex_wait
 443	common	futex_wake		sys_futex_wake
 444	common	futex_waitv		sys_futex_waitv
+445	common	futex_requeue		sys_futex_requeue
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/compat.h b/include/linux/compat.h
index b63dc0899c2a..7d17ae0dc462 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -371,6 +371,11 @@ struct compat_futex_waitv {
 	compat_uint_t flags;
 };
 
+struct compat_futex_requeue {
+	compat_uptr_t uaddr;
+	compat_uint_t flags;
+};
+
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
 	compat_uptr_t			sa_handler;
@@ -665,6 +670,13 @@ asmlinkage long compat_sys_futex_waitv(struct compat_futex_waitv *waiters,
 				       compat_uint_t nr_futexes, compat_uint_t flags
 				       struct __kernel_timespec __user *timo);
 
+asmlinkage long compat_sys_futex_requeue(struct compat_futex_requeue *uaddr1,
+					 struct compat_futex_requeue *uaddr2,
+					 compat_uint_t nr_wake,
+					 compat_uint_t nr_requeue,
+					 compat_uint_t cmpval,
+					 compat_uint_t flags);
+
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7da1ceb3685d..06823bc7ef9d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -69,6 +69,7 @@ struct io_uring_params;
 struct clone_args;
 struct open_how;
 struct futex_waitv;
+struct futex_requeue;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -628,6 +629,10 @@ asmlinkage long sys_futex_wake(void __user *uaddr, unsigned int nr_wake,
 asmlinkage long sys_futex_waitv(struct futex_waitv __user *waiters,
 				unsigned int nr_futexes, unsigned int flags,
 				struct __kernel_timespec __user *timo);
+asmlinkage long sys_futex_requeue(struct futex_requeue __user *uaddr1,
+				  struct futex_requeue __user *uaddr2,
+				  unsigned int nr_wake, unsigned int nr_requeue,
+				  unsigned int cmpval, unsigned int flags);
 
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 090da8e12bd0..9afde54cd380 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -871,8 +871,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_waitv 444
 __SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
 
+#define __NR_futex_requeue 445
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue, compat_sys_futex_requeue)
+
 #undef __NR_syscalls
-#define __NR_syscalls 445
+#define __NR_syscalls 446
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/futex2.c b/kernel/futex2.c
index f3c2379abd35..bad8c183cf9f 100644
--- a/kernel/futex2.c
+++ b/kernel/futex2.c
@@ -977,6 +977,221 @@ SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
 	return ret;
 }
 
+static void futex_double_unlock(struct futex_bucket *b1, struct futex_bucket *b2)
+{
+	spin_unlock(&b1->lock);
+	if (b1 != b2)
+		spin_unlock(&b2->lock);
+}
+
+static inline int __futex_requeue(struct futex_requeue rq1,
+				  struct futex_requeue rq2, unsigned int nr_wake,
+				  unsigned int nr_requeue, unsigned int cmpval,
+				  bool shared1, bool shared2)
+{
+	struct futex_waiter w1, w2, *aux, *tmp;
+	bool retry = false;
+	struct futex_bucket *b1, *b2;
+	DEFINE_WAKE_Q(wake_q);
+	u32 uval;
+	int ret;
+
+	b1 = futex_get_bucket(rq1.uaddr, &w1.key, shared1);
+	if (IS_ERR(b1))
+		return PTR_ERR(b1);
+
+	b2 = futex_get_bucket(rq2.uaddr, &w2.key, shared2);
+	if (IS_ERR(b2))
+		return PTR_ERR(b2);
+
+retry:
+	if (shared1 && retry) {
+		b1 = futex_get_bucket(rq1.uaddr, &w1.key, shared1);
+		if (IS_ERR(b1))
+			return PTR_ERR(b1);
+	}
+
+	if (shared2 && retry) {
+		b2 = futex_get_bucket(rq2.uaddr, &w2.key, shared2);
+		if (IS_ERR(b2))
+			return PTR_ERR(b2);
+	}
+
+	bucket_inc_waiters(b2);
+	/*
+	 * To ensure the locks are taken in the same order for all threads (and
+	 * thus avoiding deadlocks), take the "smaller" one first
+	 */
+	if (b1 <= b2) {
+		spin_lock(&b1->lock);
+		if (b1 < b2)
+			spin_lock_nested(&b2->lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock(&b2->lock);
+		spin_lock_nested(&b1->lock, SINGLE_DEPTH_NESTING);
+	}
+
+	ret = futex_get_user(&uval, rq1.uaddr);
+
+	if (unlikely(ret)) {
+		futex_double_unlock(b1, b2);
+		if (__get_user(uval, (u32 * __user)rq1.uaddr))
+			return -EFAULT;
+
+		bucket_dec_waiters(b2);
+		retry = true;
+		goto retry;
+	}
+
+	if (uval != cmpval) {
+		futex_double_unlock(b1, b2);
+
+		bucket_dec_waiters(b2);
+		return -EAGAIN;
+	}
+
+	list_for_each_entry_safe(aux, tmp, &b1->list, list) {
+		if (futex_match(w1.key, aux->key)) {
+			if (ret < nr_wake) {
+				futex_mark_wake(aux, b1, &wake_q);
+				ret++;
+				continue;
+			}
+
+			if (ret >= nr_wake + nr_requeue)
+				break;
+
+			aux->key.pointer = w2.key.pointer;
+			aux->key.index = w2.key.index;
+			aux->key.offset = w2.key.offset;
+
+			if (b1 != b2) {
+				list_del_init_careful(&aux->list);
+				bucket_dec_waiters(b1);
+
+				list_add_tail(&aux->list, &b2->list);
+				bucket_inc_waiters(b2);
+			}
+			ret++;
+		}
+	}
+
+	futex_double_unlock(b1, b2);
+	wake_up_q(&wake_q);
+	bucket_dec_waiters(b2);
+
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_futex_parse_requeue(struct futex_requeue *rq,
+				      struct compat_futex_requeue __user *uaddr,
+				      bool *shared)
+{
+	struct compat_futex_requeue tmp;
+
+	if (copy_from_user(&tmp, uaddr, sizeof(tmp)))
+		return -EFAULT;
+
+	if (tmp.flags & ~FUTEXV_WAITER_MASK ||
+	    (tmp.flags & FUTEX_SIZE_MASK) != FUTEX_32)
+		return -EINVAL;
+
+	*shared = (tmp.flags & FUTEX_SHARED_FLAG) ? true : false;
+
+	rq->uaddr = compat_ptr(tmp.uaddr);
+	rq->flags = tmp.flags;
+
+	return 0;
+}
+
+COMPAT_SYSCALL_DEFINE6(futex_requeue, struct compat_futex_requeue __user *, uaddr1,
+		       struct compat_futex_requeue __user *, uaddr2,
+		       unsigned int, nr_wake, unsigned int, nr_requeue,
+		       unsigned int, cmpval, unsigned int, flags)
+{
+	struct futex_requeue rq1, rq2;
+	bool shared1, shared2;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	ret = compat_futex_parse_requeue(&rq1, uaddr1, &shared1);
+	if (ret)
+		return ret;
+
+	ret = compat_futex_parse_requeue(&rq2, uaddr2, &shared2);
+	if (ret)
+		return ret;
+
+	return __futex_requeue(rq1, rq2, nr_wake, nr_requeue, cmpval, shared1, shared2);
+}
+#endif
+
+/**
+ * futex_parse_requeue - Copy a user struct futex_requeue and check it's flags
+ * @rq:    Kernel struct
+ * @uaddr: Address of user struct
+ * @shared: Out parameter, defines if this is a shared futex
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int futex_parse_requeue(struct futex_requeue *rq,
+			       struct futex_requeue __user *uaddr, bool *shared)
+{
+	if (copy_from_user(rq, uaddr, sizeof(*rq)))
+		return -EFAULT;
+
+	if (rq->flags & ~FUTEXV_WAITER_MASK ||
+	    (rq->flags & FUTEX_SIZE_MASK) != FUTEX_32)
+		return -EINVAL;
+
+	*shared = (rq->flags & FUTEX_SHARED_FLAG) ? true : false;
+
+	return 0;
+}
+
+/**
+ * sys_futex_requeue - Wake futexes at uaddr1 and requeue from uaddr1 to uaddr2
+ * @uaddr1:	Address of futexes to be waken/dequeued
+ * @uaddr2:	Address for the futexes to be enqueued
+ * @nr_wake:	Number of futexes waiting in uaddr1 to be woken up
+ * @nr_requeue: Number of futexes to be requeued from uaddr1 to uaddr2
+ * @cmpval:	Expected value at uaddr1
+ * @flags:	Reserved flags arg for requeue operation expansion. Must be 0.
+ *
+ * If (uaddr1->uaddr == cmpval), wake at uaddr1->uaddr a nr_wake number of
+ * waiters and then, remove a number of nr_requeue waiters at uaddr1->uaddr
+ * and add then to uaddr2->uaddr list. Each uaddr has its own set of flags,
+ * that must be defined at struct futex_requeue (such as size, shared, NUMA).
+ *
+ * Return the number of the woken futexes + the number of requeued ones on
+ * success, error code otherwise.
+ */
+SYSCALL_DEFINE6(futex_requeue, struct futex_requeue __user *, uaddr1,
+		struct futex_requeue __user *, uaddr2,
+		unsigned int, nr_wake, unsigned int, nr_requeue,
+		unsigned int, cmpval, unsigned int, flags)
+{
+	struct futex_requeue rq1, rq2;
+	bool shared1, shared2;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	ret = futex_parse_requeue(&rq1, uaddr1, &shared1);
+	if (ret)
+		return ret;
+
+	ret = futex_parse_requeue(&rq2, uaddr2, &shared2);
+	if (ret)
+		return ret;
+
+	return __futex_requeue(rq1, rq2, nr_wake, nr_requeue, cmpval, shared1, shared2);
+}
+
 static int __init futex2_init(void)
 {
 	int i;
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 977890c58ab5..1750dfc416d8 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -154,6 +154,7 @@ COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_wait);
 COND_SYSCALL(futex_wake);
 COND_SYSCALL(futex_waitv);
+COND_SYSCALL(futex_requeue);
 
 /* kernel/hrtimer.c */
 
-- 
2.30.1

