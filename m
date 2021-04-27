Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53E36CF58
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhD0XQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 19:16:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36854 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbhD0XQC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 19:16:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5A1C31F426B2
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 03/13] futex2: Implement vectorized wait
Date:   Tue, 27 Apr 2021 20:12:38 -0300
Message-Id: <20210427231248.220501-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427231248.220501-1-andrealmeid@collabora.com>
References: <20210427231248.220501-1-andrealmeid@collabora.com>
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
	__u64 val;
	void *uaddr;
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
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/compat.h                        |   9 +
 include/linux/syscalls.h                      |   4 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/futex.h                    |  14 ++
 kernel/futex2.c                               | 177 ++++++++++++++++++
 kernel/sys_ni.c                               |   2 +
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 13 files changed, 221 insertions(+), 3 deletions(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 2bf93c69e00a..f9b55f2ea444 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -458,3 +458,4 @@
 442	common	mount_setattr			sys_mount_setattr
 443	common	futex_wait			sys_futex_wait
 444	common	futex_wake			sys_futex_wake
+445	common  futex_waitv                     sys_futex_waitv
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
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 15c2cd5f1c95..1e19604b8885 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -897,6 +897,8 @@ __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_wake 444
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_waitv 445
+__SYSCALL(__NR_futex_waitv, compat_sys_futex_waitv)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 17d22509d780..4bc546c841b0 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -449,3 +449,4 @@
 442	i386	mount_setattr		sys_mount_setattr
 443	i386	futex_wait		sys_futex_wait
 444	i386	futex_wake		sys_futex_wake
+445	i386	futex_waitv		sys_futex_waitv			compat_sys_futex_waitv
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 3336b5cd5bdb..a715e88e3d6d 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -366,6 +366,7 @@
 442	common	mount_setattr		sys_mount_setattr
 443	common	futex_wait		sys_futex_wait
 444	common	futex_wake		sys_futex_wake
+445	common	futex_waitv		sys_futex_waitv
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 4b05200eb8dd..d55b271bad60 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -365,6 +365,12 @@ struct compat_robust_list_head {
 	compat_uptr_t			list_op_pending;
 };
 
+struct compat_futex_waitv {
+	compat_u64 val;
+	compat_uptr_t uaddr;
+	compat_uint_t flags;
+};
+
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
 	compat_uptr_t			sa_handler;
@@ -658,6 +664,9 @@ compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 asmlinkage long
 compat_sys_futex_wait(void __user *uaddr, compat_u64 val, unsigned int flags,
 		      struct __kernel_timespec __user *timo);
+asmlinkage long compat_sys_futex_waitv(struct compat_futex_waitv *waiters,
+				       compat_uint_t nr_futexes, compat_uint_t flags,
+				       struct __kernel_timespec __user *timo);
 
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c0b47c76d542..054ee70edfbe 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -69,6 +69,7 @@ struct io_uring_params;
 struct clone_args;
 struct open_how;
 struct mount_attr;
+struct futex_waitv;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -624,6 +625,9 @@ asmlinkage long sys_futex_wait(void __user *uaddr, u64 val, unsigned int flags,
 			       struct __kernel_timespec __user *timo);
 asmlinkage long sys_futex_wake(void __user *uaddr, unsigned int nr_wake,
 			       unsigned int flags);
+asmlinkage long sys_futex_waitv(struct futex_waitv __user *waiters,
+				unsigned int nr_futexes, unsigned int flags,
+				struct __kernel_timespec __user *timo);
 
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 738315f148fa..2a6adca37fe9 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -870,8 +870,11 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_wake 444
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 
+#define __NR_futex_waitv 445
+__SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
+
 #undef __NR_syscalls
-#define __NR_syscalls 445
+#define __NR_syscalls 446
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 70ea66fffb1c..ca019b682b2e 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -48,6 +48,20 @@
 
 #define FUTEX_SHARED_FLAG 8
 
+#define FUTEX_WAITV_MAX 128
+
+/**
+ * struct futex_waitv - A waiter for vectorized wait
+ * @val:   Expected value at uaddr
+ * @uaddr: User address to wait on
+ * @flags: Flags for this waiter
+ */
+struct futex_waitv {
+	__u64 val;
+	void __user *uaddr;
+	unsigned int flags;
+};
+
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
  * thread exit time.
diff --git a/kernel/futex2.c b/kernel/futex2.c
index f112c8c48f91..9c957c6bf699 100644
--- a/kernel/futex2.c
+++ b/kernel/futex2.c
@@ -82,6 +82,12 @@ struct futex_bucket {
 /* Mask for futex2 flag operations */
 #define FUTEX2_MASK (FUTEX_SIZE_MASK | FUTEX_CLOCK_REALTIME | FUTEX_SHARED_FLAG)
 
+/* Mask for sys_futex_waitv flag */
+#define FUTEXV_MASK (FUTEX_CLOCK_REALTIME)
+
+/* Mask for each futex in futex_waitv list */
+#define FUTEXV_WAITER_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG)
+
 #define is_object_shared ((futexv->objects[i].flags & FUTEX_SHARED_FLAG) ? true : false)
 
 #define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
@@ -701,6 +707,177 @@ SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, u64, val, unsigned int, flags,
 	return ksys_futex_wait(uaddr, val, flags, timo);
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
+static int compat_futex_parse_waitv(struct futex_waiter_head *futexv,
+				    struct compat_futex_waitv __user *uwaitv,
+				    unsigned int nr_futexes)
+{
+	struct compat_futex_waitv waitv;
+	struct futex_bucket *bucket;
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
+		futexv->objects[i].uaddr  = compat_ptr(waitv.uaddr);
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
+	struct futex_waiter_head *futexv;
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
+		ret = __futex_waitv(futexv, nr_futexes, timo, flags);
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
+static int futex_parse_waitv(struct futex_waiter_head *futexv,
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
+		futexv->objects[i].uaddr  = waitv.uaddr;
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
+	struct futex_waiter_head *futexv;
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
+		ret = __futex_waitv(futexv, nr_futexes, timo, flags);
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
index 81bc661d8fbe..e3ce31d62c73 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -154,6 +154,8 @@ COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_wait);
 COND_SYSCALL_COMPAT(futex_wait);
 COND_SYSCALL(futex_wake);
+COND_SYSCALL(futex_waitv);
+COND_SYSCALL_COMPAT(futex_waitv);
 
 /* kernel/hrtimer.c */
 
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 738315f148fa..2a6adca37fe9 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -870,8 +870,11 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_wake 444
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 
+#define __NR_futex_waitv 445
+__SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
+
 #undef __NR_syscalls
-#define __NR_syscalls 445
+#define __NR_syscalls 446
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 0e1bfa9867b0..f74b1c00ab26 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -366,6 +366,7 @@
 442	common	mount_setattr		sys_mount_setattr
 443	common  futex_wait              sys_futex_wait
 444	common  futex_wake              sys_futex_wake
+445	common  futex_waitv             sys_futex_waitv
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.31.1

