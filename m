Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4713C1C70
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 02:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGIAQp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 20:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGIAQo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 20:16:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D3FC061574;
        Thu,  8 Jul 2021 17:14:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 3C9451F41516
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
Subject: [PATCH v5 01/11] futex2: Implement wait and wake functions
Date:   Thu,  8 Jul 2021 21:13:18 -0300
Message-Id: <20210709001328.329716-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709001328.329716-1-andrealmeid@collabora.com>
References: <20210709001328.329716-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a new set of futex syscalls known as futex2. This new interface
is aimed to expand it with new functionalities without modifying the
current complex interface.

Implement wait and wake functions with support for 32 sized futexes:

- futex_wait(void *uaddr, unsigned int val, unsigned int flags,
	     struct timespec *timo)

   The user thread is put to sleep, waiting for a futex_wake() at uaddr,
   if the value at *uaddr is the same as val (otherwise, the syscall
   returns immediately with -EAGAIN). timo is an optional timeout value
   for the operation.

   Return 0 on success, error code otherwise.

 - futex_wake(void *uaddr, unsigned long nr_wake, unsigned int flags)

   Wake `nr_wake` threads waiting at uaddr.

   Return the number of woken threads on success, error code otherwise.

** The `flag` argument

 The flag is used to specify the size of the futex word
 (FUTEX_[8, 16, 32, 64]). It's mandatory to define one.

 By default, the timeout uses a monotonic clock, but can be used as a
 realtime one by using the FUTEX_REALTIME_CLOCK flag.

 By default, futexes are of the private type, that means that this user
 address will be accessed by threads that shares the same memory region.
 This allows for some internal optimizations, so they are faster.
 However, if the address needs to be shared with different processes
 (like using `mmap()` or `shm()`), they need to be defined as shared and
 the flag FUTEX_SHARED_FLAG is used to set that.

 By default, the operation has no NUMA-awareness, meaning that the user
 can't choose the memory node where the kernel side futex data will be
 stored. The user can choose the node where it wants to operate by
 setting the FUTEX_NUMA_FLAG and using the following structure (where X
 can be 8, 16, or 32, 64):

  struct futexX_numa {
          __uX value;
          __sX hint;
  };

 This structure should be passed at the `void *uaddr` of futex
 functions. The address of the structure will be used to be waited/waken
 on, and the `value` will be compared to `val` as usual. The `hint`
 member is used to defined which node the futex will use. When waiting,
 the futex will be registered on a kernel-side table stored on that
 node; when waking, the futex will be searched for on that given table.
 That means that there's no redundancy between tables, and the wrong
 `hint` value will led to undesired behavior.  Userspace is responsible
 for dealing with node migrations issues that may occur. `hint` can
 range from [0, MAX_NUMA_NODES], for specifying a node, or -1, to use
 the same node the current process is using.

 When not using FUTEX_NUMA_FLAG on a NUMA system, the futex will be
 stored on a global table on some node, defined at compilation time.

** The `timo` argument

As per the Y2038 work done in the kernel, new interfaces shouldn't add
timeout options known to be buggy. Given that, `timo` should be a 64bit
timeout at all platforms, using an absolute timeout value.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/compat.h                 |   4 +
 include/linux/futex.h                  |  21 +++++
 include/linux/syscalls.h               |   6 ++
 include/uapi/asm-generic/unistd.h      |   7 +-
 include/uapi/linux/futex.h             |   4 +-
 init/Kconfig                           |   7 ++
 kernel/Makefile                        |   1 +
 kernel/futex.c                         |  23 +-----
 kernel/futex2.c                        | 103 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   5 ++
 12 files changed, 163 insertions(+), 22 deletions(-)
 create mode 100644 kernel/futex2.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4bbc267fb36b..e3b827a9c094 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -451,3 +451,5 @@
 444	i386	landlock_create_ruleset	sys_landlock_create_ruleset
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
+447	i386	futex_wait		sys_futex_wait			compat_sys_futex_wait
+448	i386	futex_wake		sys_futex_wake
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ce18119ea0d0..63b447255df2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -368,6 +368,8 @@
 444	common	landlock_create_ruleset	sys_landlock_create_ruleset
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
+447	common	futex_wait		sys_futex_wait
+448	common	futex_wake		sys_futex_wake
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 8855b1b702b2..5a910e0c437a 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -692,6 +692,10 @@ asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
+/* kernel/futex2.c */
+asmlinkage long compat_sys_futex_wait(void __user *uaddr, compat_u64 val,
+				      unsigned int flags,
+				      struct __kernel_timespec __user *timo);
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..f0eaa05ec8bc 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -77,6 +77,27 @@ void futex_exec_release(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
+
+int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset);
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time,
+	       u32 bitset);
+
+/*
+ * Futex flags used to encode options to functions and preserve them across
+ * restarts.
+ */
+#ifdef CONFIG_MMU
+# define FLAGS_SHARED		0x01
+#else
+/*
+ * NOMMU does not have per process address space. Let the compiler optimize
+ * code away.
+ */
+# define FLAGS_SHARED		0x00
+#endif
+#define FLAGS_CLOCKRT		0x02
+#define FLAGS_HAS_TIMEOUT	0x04
+
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 050511e8f1f8..b9c2874410d0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -623,6 +623,12 @@ asmlinkage long sys_get_robust_list(int pid,
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+/* kernel/futex2.c */
+asmlinkage long sys_futex_wait(void __user *uaddr, u64 val, unsigned int flags,
+			       struct __kernel_timespec __user *timo);
+asmlinkage long sys_futex_wake(void __user *uaddr, unsigned int nr_wake,
+			       unsigned int flags);
+
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d2a942086fcb..df9fe2e23ee0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -872,8 +872,13 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 #define __NR_landlock_restrict_self 446
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 
+#define __NR_futex_wait 447
+__SC_COMP(__NR_futex_wait, sys_futex_wait, compat_sys_futex_wait)
+#define __NR_futex_wake 448
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
+
 #undef __NR_syscalls
-#define __NR_syscalls 447
+#define __NR_syscalls 449
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 235e5b2facaa..44750caa261e 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -42,7 +42,9 @@
 					 FUTEX_PRIVATE_FLAG)
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
-
+#define FUTEX_32	2
+#define FUTEX_SHARED_FLAG 8
+#define FUTEX_SIZE_MASK	0x3
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
  * thread exit time.
diff --git a/init/Kconfig b/init/Kconfig
index a61c92066c2e..d87629ec7e48 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1555,6 +1555,13 @@ config FUTEX
 	  support for "fast userspace mutexes".  The resulting kernel may not
 	  run glibc-based applications correctly.
 
+config FUTEX2
+	bool "Enable futex2 support" if EXPERT
+	depends on FUTEX
+	default y
+	help
+	  Support for futex2 interface.
+
 config FUTEX_PI
 	bool
 	depends on FUTEX && RT_MUTEXES
diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609be42d0..1eaf2af50283 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
 obj-$(CONFIG_FUTEX) += futex.o
+obj-$(CONFIG_FUTEX2) += futex2.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += smp.o
 ifneq ($(CONFIG_SMP),y)
diff --git a/kernel/futex.c b/kernel/futex.c
index 2ecb07575055..ef7131bd8bc4 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -150,22 +150,6 @@
 static int  __read_mostly futex_cmpxchg_enabled;
 #endif
 
-/*
- * Futex flags used to encode options to functions and preserve them across
- * restarts.
- */
-#ifdef CONFIG_MMU
-# define FLAGS_SHARED		0x01
-#else
-/*
- * NOMMU does not have per process address space. Let the compiler optimize
- * code away.
- */
-# define FLAGS_SHARED		0x00
-#endif
-#define FLAGS_CLOCKRT		0x02
-#define FLAGS_HAS_TIMEOUT	0x04
-
 /*
  * Priority Inheritance state:
  */
@@ -1588,8 +1572,7 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 /*
  * Wake up waiters matching bitset queued on this futex (uaddr).
  */
-static int
-futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
+int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 {
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
@@ -2676,8 +2659,8 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	return ret;
 }
 
-static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
-		      ktime_t *abs_time, u32 bitset)
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
+	       ktime_t *abs_time, u32 bitset)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
diff --git a/kernel/futex2.c b/kernel/futex2.c
new file mode 100644
index 000000000000..990c665280fd
--- /dev/null
+++ b/kernel/futex2.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * futex2 system call interface by André Almeida <andrealmeid@collabora.com>
+ *
+ * Copyright 2021 Collabora Ltd.
+ */
+
+#include <asm/futex.h>
+
+#include <linux/syscalls.h>
+
+/*
+ * Set of flags that futex2 accepts
+ */
+#define FUTEX2_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG | FUTEX_CLOCK_REALTIME)
+
+static long ksys_futex_wait(void __user *uaddr, u64 val, unsigned int flags,
+			    struct __kernel_timespec __user *timo)
+{
+	unsigned int size = flags & FUTEX_SIZE_MASK, futex_flags = 0;
+	ktime_t *kt = NULL, time;
+	struct timespec64 ts;
+
+	if (flags & ~FUTEX2_MASK)
+		return -EINVAL;
+
+	if (flags & FUTEX_SHARED_FLAG)
+		futex_flags |= FLAGS_SHARED;
+
+	if (flags & FUTEX_CLOCK_REALTIME)
+		futex_flags |= FLAGS_CLOCKRT;
+
+	if (size != FUTEX_32)
+		return -EINVAL;
+
+	if (timo) {
+		if (get_timespec64(&ts, timo))
+			return -EFAULT;
+
+		if (!timespec64_valid(&ts))
+			return -EINVAL;
+
+		time = timespec64_to_ktime(ts);
+		kt = &time;
+	}
+
+	return futex_wait(uaddr, futex_flags, val, kt, FUTEX_BITSET_MATCH_ANY);
+}
+
+/**
+ * sys_futex_wait - Wait on a futex address if (*uaddr) == val
+ * @uaddr: User address of futex
+ * @val:   Expected value of futex
+ * @flags: Specify the size of futex and the clockid
+ * @timo:  Optional absolute timeout.
+ *
+ * The user thread is put to sleep, waiting for a futex_wake() at uaddr, if the
+ * value at *uaddr is the same as val (otherwise, the syscall returns
+ * immediately with -EAGAIN).
+ *
+ * Returns 0 on success, error code otherwise.
+ */
+SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, u64, val, unsigned int, flags,
+		struct __kernel_timespec __user *, timo)
+{
+	return ksys_futex_wait(uaddr, val, flags, timo);
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, compat_u64, val,
+		       unsigned int, flags,
+		       struct __kernel_timespec __user *, timo)
+{
+	return ksys_futex_wait(uaddr, val, flags, timo);
+}
+#endif
+
+/**
+ * sys_futex_wake - Wake a number of futexes waiting on an address
+ * @uaddr:   Address of futex to be woken up
+ * @nr_wake: Number of futexes waiting in uaddr to be woken up
+ * @flags:   Flags for size and shared
+ *
+ * Wake `nr_wake` threads waiting at uaddr.
+ *
+ * Returns the number of woken threads on success, error code otherwise.
+ */
+SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
+		unsigned int, flags)
+{
+	unsigned int size = flags & FUTEX_SIZE_MASK, futex_flags = 0;
+
+	if (flags & ~FUTEX2_MASK)
+		return -EINVAL;
+
+	if (flags & FUTEX_SHARED_FLAG)
+		futex_flags |= FLAGS_SHARED;
+
+	if (size != FUTEX_32)
+		return -EINVAL;
+
+	return futex_wake(uaddr, futex_flags, nr_wake, FUTEX_BITSET_MATCH_ANY);
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0ea8128468c3..dbe397eaea46 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -151,6 +151,11 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 
+/* kernel/futex2.c */
+COND_SYSCALL(futex_wait);
+COND_SYSCALL_COMPAT(futex_wait);
+COND_SYSCALL(futex_wake);
+
 /* kernel/hrtimer.c */
 
 /* kernel/itimer.c */
-- 
2.32.0

