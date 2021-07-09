Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048BB3C1C75
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGIAQ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 20:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGIAQ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 20:16:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D4C061574;
        Thu,  8 Jul 2021 17:14:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C3F5E1F421A2
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
        Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 03/11] futex2: Implement requeue operation
Date:   Thu,  8 Jul 2021 21:13:20 -0300
Message-Id: <20210709001328.329716-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709001328.329716-1-andrealmeid@collabora.com>
References: <20210709001328.329716-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement requeue interface similarly to FUTEX_CMP_REQUEUE operation.

This is the syscall implemented by this patch:

futex_requeue(struct futex_requeue *rq1, struct futex_requeue *rq2,
	      unsigned int nr_wake, unsigned int nr_requeue,
	      u64 cmpval, unsigned int flags)

struct futex_requeue {
	void *uaddr;
	unsigned int flags;
};

If (rq1->uaddr == cmpval), wake at rq1->uaddr a nr_wake number of
waiters and then, remove a number of nr_requeue waiters at rq1->uaddr
and add them to rq2->uaddr list. Each uaddr has its own set of flags,
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
- *rq1 and *rq2 are used as void* (instead of struct
  futex_requeue) just like wait/wake().

In that way, we could avoid the copy_from_user().
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/compat.h                 |  10 +++
 include/linux/futex.h                  |   3 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/futex.h             |  10 +++
 kernel/futex.c                         |  18 ++--
 kernel/futex2.c                        | 111 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   2 +
 9 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 5573437c1914..f02c3da76945 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -454,3 +454,4 @@
 447	i386	futex_wait		sys_futex_wait			compat_sys_futex_wait
 448	i386	futex_wake		sys_futex_wake
 449	i386	futex_waitv		sys_futex_waitv			compat_sys_futex_waitv
+450	i386	futex_requeue		sys_futex_requeue		compat_sys_futex_requeue
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index bad4aca3e9ba..8815c0de5d05 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -371,6 +371,7 @@
 447	common	futex_wait		sys_futex_wait
 448	common	futex_wake		sys_futex_wake
 449	common	futex_waitv		sys_futex_waitv
+450     common  futex_requeue           sys_futex_requeue
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 75b90e41e05b..861616de6d75 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -374,6 +374,11 @@ struct compat_futex_waitv {
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
@@ -705,6 +710,11 @@ asmlinkage long compat_sys_futex_wait(void __user *uaddr, compat_u64 val,
 asmlinkage long compat_sys_futex_waitv(struct compat_futex_waitv *waiters,
 				       compat_uint_t nr_futexes, compat_uint_t flags,
 				       struct __kernel_timespec __user *timo);
+asmlinkage long compat_sys_futex_requeue(struct futex_requeue __user *rq1,
+					 struct futex_requeue __user *rq2,
+					 unsigned int nr_wake,
+					 unsigned int nr_requeue,
+					 u64 cmpval, unsigned int flags);
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 7afef5bb3da2..95afac7b2f76 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -159,6 +159,9 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset);
 int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time,
 	       u32 bitset);
+int futex_requeue(u32 __user *uaddr1, unsigned int flags1, u32 __user *uaddr2,
+		  unsigned int flags2, int nr_wake, int nr_requeue, u32 *cmpval,
+		  int requeue_pi);
 void queue_me(struct futex_q *q, struct futex_hash_bucket *hb);
 int unqueue_me(struct futex_q *q);
 void queue_unlock(struct futex_hash_bucket *hb);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 57acb3a0f69f..89a480490dca 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -878,9 +878,11 @@ __SC_COMP(__NR_futex_wait, sys_futex_wait, compat_sys_futex_wait)
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_waitv 449
 __SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
+#define __NR_futex_requeue 450
+__SC_COMP(__NR_futex_requeue, sys_futex_requeue, compat_sys_futex_requeue)
 
 #undef __NR_syscalls
-#define __NR_syscalls 450
+#define __NR_syscalls 451
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index daa135bdedda..7effdd568699 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -60,6 +60,16 @@ struct futex_waitv {
 	unsigned int flags;
 };
 
+/**
+ * struct futex_requeue - Define an address and its flags for requeue operation
+ * @uaddr: User address of one of the requeue arguments
+ * @flags: Flags for this address
+ */
+struct futex_requeue {
+	void __user *uaddr;
+	unsigned int flags;
+};
+
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
  * thread exit time.
diff --git a/kernel/futex.c b/kernel/futex.c
index 135782fc3461..7e6d70195d8a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1843,9 +1843,9 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
  *  - >=0 - on success, the number of tasks requeued or woken;
  *  -  <0 - on error
  */
-static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
-			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
-			 u32 *cmpval, int requeue_pi)
+int futex_requeue(u32 __user *uaddr1, unsigned int flags1, u32 __user *uaddr2,
+		  unsigned int flags2, int nr_wake, int nr_requeue,
+		  u32 *cmpval, int requeue_pi)
 {
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
 	int task_count = 0, ret;
@@ -1895,10 +1895,10 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 	}
 
 retry:
-	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret = get_futex_key(uaddr1, flags1 & FLAGS_SHARED, &key1, FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
+	ret = get_futex_key(uaddr2, flags2 & FLAGS_SHARED, &key2,
 			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret != 0))
 		return ret;
@@ -1930,7 +1930,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			if (ret)
 				return ret;
 
-			if (!(flags & FLAGS_SHARED))
+			if (!(flags1 & FLAGS_SHARED))
 				goto retry_private;
 
 			goto retry;
@@ -3661,9 +3661,9 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, NULL, 0);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, NULL, 0);
 	case FUTEX_CMP_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 0);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, &val3, 0);
 	case FUTEX_WAKE_OP:
 		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
 	case FUTEX_LOCK_PI:
@@ -3680,7 +3680,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		return futex_wait_requeue_pi(uaddr, flags, val, timeout, val3,
 					     uaddr2);
 	case FUTEX_CMP_REQUEUE_PI:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
+		return futex_requeue(uaddr, flags, uaddr2, flags, val, val2, &val3, 1);
 	}
 	return -ENOSYS;
 }
diff --git a/kernel/futex2.c b/kernel/futex2.c
index cc1f31afb281..4f6d099badec 100644
--- a/kernel/futex2.c
+++ b/kernel/futex2.c
@@ -446,3 +446,114 @@ SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
 
 	return futex_wake(uaddr, futex_flags, nr_wake, FUTEX_BITSET_MATCH_ANY);
 }
+
+#ifdef CONFIG_COMPAT
+static int compat_futex_parse_requeue(struct compat_futex_requeue __user *rq,
+				      void __user **uaddr, unsigned int *flags)
+{
+	struct compat_futex_requeue aux;
+	unsigned int futex_flags = 0;
+
+	if (copy_from_user(&aux, rq, sizeof(*rq)))
+		return -EFAULT;
+
+	if (aux.flags & ~FUTEXV_WAITER_MASK ||
+	    (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
+		return -EINVAL;
+
+	if (aux.flags & FUTEX_SHARED_FLAG)
+		futex_flags |= FLAGS_SHARED;
+
+	*uaddr = compat_ptr(aux.uaddr);
+	*flags = futex_flags;
+
+	return 0;
+}
+
+COMPAT_SYSCALL_DEFINE6(futex_requeue, struct compat_futex_requeue __user *, rq1,
+		       struct compat_futex_requeue __user *, rq2,
+		       unsigned int, nr_wake, unsigned int, nr_requeue,
+		       compat_u64, cmpval, unsigned int, flags)
+{
+	void __user *uaddr1, *uaddr2;
+	unsigned int flags1, flags2;
+	u32 val = cmpval;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	ret = compat_futex_parse_requeue(rq1, &uaddr1, &flags1);
+	if (ret)
+		return ret;
+
+	ret = compat_futex_parse_requeue(rq2, &uaddr2, &flags2);
+	if (ret)
+		return ret;
+
+	return futex_requeue(uaddr1, flags1, uaddr2, flags2, nr_wake, nr_requeue, &val, 0);
+}
+#endif
+
+static int futex_parse_requeue(struct futex_requeue __user *rq,
+			       void __user **uaddr, unsigned int *flags)
+{
+	struct futex_requeue aux;
+	unsigned int futex_flags = 0;
+
+	if (copy_from_user(&aux, rq, sizeof(*rq)))
+		return -EFAULT;
+
+	if (aux.flags & ~FUTEXV_WAITER_MASK ||
+	    (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
+		return -EINVAL;
+
+	if (aux.flags & FUTEX_SHARED_FLAG)
+		futex_flags |= FLAGS_SHARED;
+
+	*uaddr = aux.uaddr;
+	*flags = futex_flags;
+
+	return 0;
+}
+
+/**
+ * sys_futex_requeue - Wake futexes at rq1 and requeue from rq1 to rq2
+ * @rq1:	Address of futexes to be waken/dequeued
+ * @rq2:	Address for the futexes to be enqueued
+ * @nr_wake:    Number of futexes waiting in uaddr1 to be woken up
+ * @nr_requeue: Number of futexes to be requeued from uaddr1 to uaddr2
+ * @cmpval:     Expected value at uaddr1
+ * @flags:      Reserved flags arg for requeue operation expansion. Must be 0.
+ *
+ * If (rq1->uaddr == cmpval), wake at uaddr1->uaddr a nr_wake number of
+ * waiters and then, remove a number of nr_requeue waiters at rq1->uaddr
+ * and add then to rq2->uaddr list. Each uaddr has its own set of flags,
+ * that must be defined at struct futex_requeue (such as size, shared, NUMA).
+ *
+ * Return the number of the woken futexes + the number of requeued ones on
+ * success, error code otherwise.
+ */
+SYSCALL_DEFINE6(futex_requeue, struct futex_requeue __user *, rq1,
+		struct futex_requeue __user *, rq2,
+		unsigned int, nr_wake, unsigned int, nr_requeue,
+		u64, cmpval, unsigned int, flags)
+{
+	void __user *uaddr1, *uaddr2;
+	unsigned int flags1, flags2;
+	u32 val = cmpval;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	ret = futex_parse_requeue(rq1, &uaddr1, &flags1);
+	if (ret)
+		return ret;
+
+	ret = futex_parse_requeue(rq2, &uaddr2, &flags2);
+	if (ret)
+		return ret;
+
+	return futex_requeue(uaddr1, flags1, uaddr2, flags2, nr_wake, nr_requeue, &val, 0);
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 93807bb7be51..20a425b79fca 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -157,6 +157,8 @@ COND_SYSCALL_COMPAT(futex_wait);
 COND_SYSCALL(futex_wake);
 COND_SYSCALL(futex_waitv);
 COND_SYSCALL_COMPAT(futex_waitv);
+COND_SYSCALL(futex_requeue);
+COND_SYSCALL_COMPAT(futex_requeue);
 
 /* kernel/hrtimer.c */
 
-- 
2.32.0

