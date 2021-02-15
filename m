Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7431BC4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhBOP0V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 10:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBOPZZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 10:25:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0BC061786;
        Mon, 15 Feb 2021 07:24:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DE6981F44EFD
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
Subject: [RFC PATCH 03/13] futex2: Implement vectorized wait
Date:   Mon, 15 Feb 2021 12:23:54 -0300
Message-Id: <20210215152404.250281-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210215152404.250281-1-andrealmeid@collabora.com>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support to wait on multiple futexes. This is the interface
implemented by this syscall:

futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
	    unsigned int flags, struct timespec *timo)

struct futex_waitv {
	void *uaddr;
	unsigned int val;
	unsigned int flags;
};

Given an array of struct futex_waitv, wait on each uaddr. The thread
wakes if a futex_wake() is performed at any uaddr. The syscall returns
immediately if any waiter has *uaddr != val. *timo is an optional
timeout value for the operation. The flags argument of the syscall
should be used solely for specifying the timeout as realtime, if needed.
Flags for shared futexes, sizes, etc. should be used on the individual
flags of each waiter.

Returns the array index of one of the awakened futexes. There’s no given
information of how many were awakened, or any particular attribute of it
(if it’s the first awakened, if it is of the smaller index...).

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/compat.h                        |  11 ++
 include/linux/syscalls.h                      |   4 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 kernel/futex2.c                               | 171 ++++++++++++++++++
 kernel/sys_ni.c                               |   1 +
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 11 files changed, 200 insertions(+), 3 deletions(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 4eef220cd2a2..6d0f6626a166 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -457,3 +457,4 @@
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	futex_wait			sys_futex_wait
 443	common	futex_wake			sys_futex_wake
+444	common  futex_waitv                     sys_futex_waitv
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index d1f7d35f986e..64ebdc1ec581 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		444
+#define __NR_compat_syscalls		445
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ece90c8d9739..fe242fa0baea 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -448,3 +448,4 @@
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	i386	futex_wait		sys_futex_wait
 443	i386	futex_wake		sys_futex_wake
+444	i386	futex_waitv		sys_futex_waitv			compat_sys_futex_waitv
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 72fb65ef996a..9d0f07e054d1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -365,6 +365,7 @@
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common	futex_wait		sys_futex_wait
 443	common	futex_wake		sys_futex_wake
+444	common	futex_waitv		sys_futex_waitv
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be753603..b63dc0899c2a 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -365,6 +365,12 @@ struct compat_robust_list_head {
 	compat_uptr_t			list_op_pending;
 };
 
+struct compat_futex_waitv {
+	compat_uptr_t uaddr;
+	compat_uint_t val;
+	compat_uint_t flags;
+};
+
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
 	compat_uptr_t			sa_handler;
@@ -654,6 +660,11 @@ asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
+/* kernel/futex2.c */
+asmlinkage long compat_sys_futex_waitv(struct compat_futex_waitv *waiters,
+				       compat_uint_t nr_futexes, compat_uint_t flags
+				       struct __kernel_timespec __user *timo);
+
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index bf146c2b0c77..7da1ceb3685d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -68,6 +68,7 @@ union bpf_attr;
 struct io_uring_params;
 struct clone_args;
 struct open_how;
+struct futex_waitv;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -624,6 +625,9 @@ asmlinkage long sys_futex_wait(void __user *uaddr, unsigned int val,
 			       struct __kernel_timespec __user __user *timo);
 asmlinkage long sys_futex_wake(void __user *uaddr, unsigned int nr_wake,
 			       unsigned int flags);
+asmlinkage long sys_futex_waitv(struct futex_waitv __user *waiters,
+				unsigned int nr_futexes, unsigned int flags,
+				struct __kernel_timespec __user *timo);
 
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 57e19200f7e4..090da8e12bd0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -868,8 +868,11 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_wake 443
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 
+#define __NR_futex_waitv 444
+__SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
+
 #undef __NR_syscalls
-#define __NR_syscalls 444
+#define __NR_syscalls 445
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/futex2.c b/kernel/futex2.c
index 27767b2d060a..f3c2379abd35 100644
--- a/kernel/futex2.c
+++ b/kernel/futex2.c
@@ -713,6 +713,177 @@ SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, unsigned int, val,
 	return futex_set_timer_and_wait(futexv, 1, timo, flags);
 }
 
+#ifdef CONFIG_COMPAT
+/**
+ * compat_futex_parse_waitv - Parse a waitv array from userspace
+ * @futexv:	Kernel side list of waiters to be filled
+ * @uwaitv:     Userspace list to be parsed
+ * @nr_futexes: Length of futexv
+ *
+ * Return: Error code on failure, pointer to a prepared futexv otherwise
+ */
+static int compat_futex_parse_waitv(struct futexv_head *futexv,
+				    struct compat_futex_waitv __user *uwaitv,
+				    unsigned int nr_futexes)
+{
+	struct futex_bucket *bucket;
+	struct compat_futex_waitv waitv;
+	unsigned int i;
+
+	for (i = 0; i < nr_futexes; i++) {
+		if (copy_from_user(&waitv, &uwaitv[i], sizeof(waitv)))
+			return -EFAULT;
+
+		if ((waitv.flags & ~FUTEXV_WAITER_MASK) ||
+		    (waitv.flags & FUTEX_SIZE_MASK) != FUTEX_32)
+			return -EINVAL;
+
+		futexv->objects[i].key.pointer = 0;
+		futexv->objects[i].flags  = waitv.flags;
+		futexv->objects[i].uaddr  = (uintptr_t)compat_ptr(waitv.uaddr);
+		futexv->objects[i].val    = waitv.val;
+		futexv->objects[i].index  = i;
+
+		bucket = futex_get_bucket(compat_ptr(waitv.uaddr),
+					  &futexv->objects[i].key,
+					  is_object_shared);
+
+		if (IS_ERR(bucket))
+			return PTR_ERR(bucket);
+
+		futexv->objects[i].bucket = bucket;
+
+		INIT_LIST_HEAD(&futexv->objects[i].list);
+	}
+
+	return 0;
+}
+
+COMPAT_SYSCALL_DEFINE4(futex_waitv, struct compat_futex_waitv __user *, waiters,
+		       unsigned int, nr_futexes, unsigned int, flags,
+		       struct __kernel_timespec __user *, timo)
+{
+	struct futexv_head *futexv;
+	int ret;
+
+	if (flags & ~FUTEXV_MASK)
+		return -EINVAL;
+
+	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
+		return -EINVAL;
+
+	futexv = kmalloc((sizeof(struct futex_waiter) * nr_futexes) +
+			 sizeof(*futexv), GFP_KERNEL);
+	if (!futexv)
+		return -ENOMEM;
+
+	futexv->hint = false;
+	futexv->task = current;
+
+	ret = compat_futex_parse_waitv(futexv, waiters, nr_futexes);
+
+	if (!ret)
+		ret = futex_set_timer_and_wait(futexv, nr_futexes, timo, flags);
+
+	kfree(futexv);
+
+	return ret;
+}
+#endif
+
+/**
+ * futex_parse_waitv - Parse a waitv array from userspace
+ * @futexv:	Kernel side list of waiters to be filled
+ * @uwaitv:     Userspace list to be parsed
+ * @nr_futexes: Length of futexv
+ *
+ * Return: Error code on failure, pointer to a prepared futexv otherwise
+ */
+static int futex_parse_waitv(struct futexv_head *futexv,
+			     struct futex_waitv __user *uwaitv,
+			     unsigned int nr_futexes)
+{
+	struct futex_bucket *bucket;
+	struct futex_waitv waitv;
+	unsigned int i;
+
+	for (i = 0; i < nr_futexes; i++) {
+		if (copy_from_user(&waitv, &uwaitv[i], sizeof(waitv)))
+			return -EFAULT;
+
+		if ((waitv.flags & ~FUTEXV_WAITER_MASK) ||
+		    (waitv.flags & FUTEX_SIZE_MASK) != FUTEX_32)
+			return -EINVAL;
+
+		futexv->objects[i].key.pointer = 0;
+		futexv->objects[i].flags  = waitv.flags;
+		futexv->objects[i].uaddr  = (uintptr_t)waitv.uaddr;
+		futexv->objects[i].val    = waitv.val;
+		futexv->objects[i].index  = i;
+
+		bucket = futex_get_bucket(waitv.uaddr, &futexv->objects[i].key,
+					  is_object_shared);
+
+		if (IS_ERR(bucket))
+			return PTR_ERR(bucket);
+
+		futexv->objects[i].bucket = bucket;
+
+		INIT_LIST_HEAD(&futexv->objects[i].list);
+	}
+
+	return 0;
+}
+
+/**
+ * sys_futex_waitv - Wait on a list of futexes
+ * @waiters:    List of futexes to wait on
+ * @nr_futexes: Length of futexv
+ * @flags:      Flag for timeout (monotonic/realtime)
+ * @timo:	Optional absolute timeout.
+ *
+ * Given an array of `struct futex_waitv`, wait on each uaddr. The thread wakes
+ * if a futex_wake() is performed at any uaddr. The syscall returns immediately
+ * if any waiter has *uaddr != val. *timo is an optional timeout value for the
+ * operation. Each waiter has individual flags. The `flags` argument for the
+ * syscall should be used solely for specifying the timeout as realtime, if
+ * needed. Flags for shared futexes, sizes, etc. should be used on the
+ * individual flags of each waiter.
+ *
+ * Returns the array index of one of the awaken futexes. There's no given
+ * information of how many were awakened, or any particular attribute of it (if
+ * it's the first awakened, if it is of the smaller index...).
+ */
+SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
+		unsigned int, nr_futexes, unsigned int, flags,
+		struct __kernel_timespec __user *, timo)
+{
+	struct futexv_head *futexv;
+	int ret;
+
+	if (flags & ~FUTEXV_MASK)
+		return -EINVAL;
+
+	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
+		return -EINVAL;
+
+	futexv = kmalloc((sizeof(struct futex_waiter) * nr_futexes) +
+			 sizeof(*futexv), GFP_KERNEL);
+	if (!futexv)
+		return -ENOMEM;
+
+	futexv->hint = false;
+	futexv->task = current;
+
+	ret = futex_parse_waitv(futexv, waiters, nr_futexes);
+	if (!ret)
+		ret = futex_set_timer_and_wait(futexv, nr_futexes, timo, flags);
+
+	kfree(futexv);
+
+	return ret;
+}
+
 /**
  * futex_get_parent - For a given futex in a futexv list, get a pointer to the futexv
  * @waiter: Address of futex in the list
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 27ef83ca8a9d..977890c58ab5 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -153,6 +153,7 @@ COND_SYSCALL_COMPAT(get_robust_list);
 /* kernel/futex2.c */
 COND_SYSCALL(futex_wait);
 COND_SYSCALL(futex_wake);
+COND_SYSCALL(futex_waitv);
 
 /* kernel/hrtimer.c */
 
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 57e19200f7e4..23febe59effc 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -868,8 +868,11 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_wake 443
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 
+#define __NR_futex_waitv 444
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
+
 #undef __NR_syscalls
-#define __NR_syscalls 444
+#define __NR_syscalls 445
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 15d2b89b6ad7..820c1e4b1aa9 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -365,6 +365,7 @@
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common  futex_wait              sys_futex_wait
 443	common  futex_wake              sys_futex_wake
+444	common  futex_waitv             sys_futex_waitv
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.30.1

