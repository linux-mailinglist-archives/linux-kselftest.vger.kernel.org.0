Return-Path: <linux-kselftest+bounces-12515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B9913A05
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184EC1F21EFC
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FF130486;
	Sun, 23 Jun 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjty4ucT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5B12FB2F;
	Sun, 23 Jun 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141988; cv=none; b=bcmqNsjNIUMoNUai5kKUjIGxNZ8WBRubezHbjRP76W8CHrSMQ20dxE85Qtmnw5VWx1Rzfvv3wH0w9eQmfdTB+XVEWRGM5hmoXlJ9BDFyNAZ19d8klwGwKqwYkHvmZctrY0RaZp1PZXJVsW8w/TLROE1C42DZjHalSTUyCuCKStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141988; c=relaxed/simple;
	bh=vgYZJQTtzTV+0K6VAfXB2QvqhBocp9Mhfxvvr3RAmRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fad890hiUa6RHIEY8Yg6eNhhNbgqagKlazBLrOsTSFF2RT0NiMq8U5ZOqzEq7YfnC9hNTKFCdnpmR6VS70Umuieprvl+g8IJ12MSWIujCGNbqvhHbRN2qel8WurkrpeQIwKA/xzdxWsmY/ikBA07RNjbyw70uue8wq1CTNUBOaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjty4ucT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288FAC2BD10;
	Sun, 23 Jun 2024 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719141987;
	bh=vgYZJQTtzTV+0K6VAfXB2QvqhBocp9Mhfxvvr3RAmRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tjty4ucTxRC1OVKOmat2S9/tD8jfs5v1DX1YxCasckKPe8aG2NJeEPpBu/vIMdE+A
	 gJmWAh+oJWbZ2nSGMFRkQqGxnv73ntiFaSED2dAxOeEFOVIpvMhucx354dNRBu0wcX
	 P0GTmlCdrsPvGOJoOiZASCms+k9e/npSZNus7GE9Ii5u9uNZCqC5RzAaBn6EwxSwQb
	 OgXigpwd9aIimEJHkI4pVMF+1kpWuuDbaFMViV7rwAa80+Yfew4j3WWIlX4N4APG5U
	 e1eCsRMyYQNzvZ18wMIQOxK5B2uv/HILZaAtKYVaGrt18UNjJeOaVdLIs3gpYw8HwI
	 hqcj78l/6lkOg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 23 Jun 2024 12:23:46 +0100
Subject: [PATCH RFT v6 4/9] fork: Add shadow stack support to clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-clone3-shadow-stack-v6-4-9ee7783b1fb9@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=14271; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vgYZJQTtzTV+0K6VAfXB2QvqhBocp9Mhfxvvr3RAmRE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAZB6kG8u5JhU7xUMDkJBd03vKjTYvP5UsAJ6l96
 2zf9JlSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGQQAKCRAk1otyXVSH0ApBB/
 4idJbZOorp/g41oJsCveltBI1aI2lFLuLRRxIFZ+UdvX+luw0gATNHauJp1RwvgNQwcd7sogivrBcy
 J3wcDZY4n1cZTMhbt3lrrfFhy1cdi7xnajoLPHgjrmXU23bT8t2JtxT5J8pMtZsLEpSQtlrxo06J4d
 GMJWR1z0jD2h0cp5t4CtE9R3Qc5vf+OKbFiHVvCo9bW0Z+5DSiBO2ZiA7nszl3dj2XyGqVD/cj5nE6
 xbj/1mh2GjDx0yK/Fmbe/STqCssJi3xQ1rS7VpQKUay6WOcBUyTfD3tMDMoOJRHgybFtVtJH6Uc7zT
 8BiflZbEtWSMnS9KNvYG1i7T5Q+TAN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Unlike with the normal stack there is no API for configuring the the shadow
stack for a new thread, instead the kernel will dynamically allocate a new
shadow stack with the same size as the normal stack. This appears to be due
to the shadow stack series having been in development since before the more
extensible clone3() was added rather than anything more deliberate.

Add parameters to clone3() specifying the location and size of a shadow
stack for the newly created process.  If no shadow stack is specified
then the existing implicit allocation behaviour is maintained.

If a stack is specified then it is required to have an architecture
defined token placed on the stack, this will be consumed by the new
task.  If the token is not provided then this will be reported as a
segmentation fault with si_code SEGV_CPERR, as a runtime shadow stack
protection error would be.  This allows architectures to implement the
validation of the token in the child process context.

If the architecture does not support shadow stacks the shadow stack
parameters must be zero, architectures that do support the feature are
expected to enforce the same requirement on individual systems that lack
shadow stack support.

Update the existing x86 implementation to pay attention to the newly added
arguments, in order to maintain compatibility we use the existing behaviour
if no shadow stack is specified. Minimal validation is done of the supplied
parameters, detailed enforcement is left to when the thread is executed.
Since we are now using more fields from the kernel_clone_args we pass that
into the shadow stack code rather than individual fields.

At present this implementation does not consume the shadow stack token
atomically as would be desirable, it uses a separate read and write.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/include/asm/shstk.h |  11 +++--
 arch/x86/kernel/process.c    |   2 +-
 arch/x86/kernel/shstk.c      | 104 +++++++++++++++++++++++++++++++++----------
 include/linux/sched/task.h   |  13 ++++++
 include/uapi/linux/sched.h   |  13 ++++--
 kernel/fork.c                |  76 ++++++++++++++++++++++++++-----
 6 files changed, 176 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 42fee8959df7..8be7b0a909c3 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct kernel_clone_args;
 struct ksignal;
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
@@ -16,8 +17,8 @@ struct thread_shstk {
 
 long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
 void reset_thread_features(void);
-unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
-				       unsigned long stack_size);
+unsigned long shstk_alloc_thread_stack(struct task_struct *p,
+				       const struct kernel_clone_args *args);
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
@@ -26,8 +27,10 @@ static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
 static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
-						     unsigned long clone_flags,
-						     unsigned long stack_size) { return 0; }
+						     const struct kernel_clone_args *args)
+{
+	return 0;
+}
 static inline void shstk_free(struct task_struct *p) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..f206e997f91d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -207,7 +207,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
 	 * update it.
 	 */
-	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
+	new_ssp = shstk_alloc_thread_stack(p, args);
 	if (IS_ERR_VALUE(new_ssp))
 		return PTR_ERR((void *)new_ssp);
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 6f1e9883f074..953cc0893097 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -191,44 +191,102 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
-unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-				       unsigned long stack_size)
+int arch_shstk_post_fork(struct task_struct *t, struct kernel_clone_args *args)
+{
+	/*
+	 * SSP is aligned, so reserved bits and mode bit are a zero, just mark
+	 * the token 64-bit.
+	 */
+	struct mm_struct *mm;
+	unsigned long addr;
+	u64 expected;
+	u64 val;
+	int ret = -EINVAL;;
+
+	addr = args->shadow_stack + args->shadow_stack_size - sizeof(u64);
+	expected = (addr - SS_FRAME_SIZE) | BIT(0);
+
+	mm = get_task_mm(t);
+	if (!mm)
+		return -EFAULT;
+
+	/* This should really be an atomic cpmxchg.  It is not. */
+	if (access_remote_vm(mm, addr, &val, sizeof(val),
+			     FOLL_FORCE) != sizeof(val))
+		goto out;
+
+	if (val != expected)
+		goto out;
+	val = 0;
+	if (access_remote_vm(mm, addr, &val, sizeof(val),
+			     FOLL_FORCE | FOLL_WRITE) != sizeof(val))
+		goto out;
+
+	ret = 0;
+
+out:
+	mmput(mm);
+	return ret;
+}
+
+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
+				       const struct kernel_clone_args *args)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
+	unsigned long clone_flags = args->flags;
 	unsigned long addr, size;
 
 	/*
 	 * If shadow stack is not enabled on the new thread, skip any
-	 * switch to a new shadow stack.
+	 * implicit switch to a new shadow stack and reject attempts to
+	 * explciitly specify one.
 	 */
-	if (!features_enabled(ARCH_SHSTK_SHSTK))
-		return 0;
+	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
+		if (args->shadow_stack || args->shadow_stack_size)
+			return (unsigned long)ERR_PTR(-EINVAL);
 
-	/*
-	 * For CLONE_VFORK the child will share the parents shadow stack.
-	 * Make sure to clear the internal tracking of the thread shadow
-	 * stack so the freeing logic run for child knows to leave it alone.
-	 */
-	if (clone_flags & CLONE_VFORK) {
-		shstk->base = 0;
-		shstk->size = 0;
 		return 0;
 	}
 
 	/*
-	 * For !CLONE_VM the child will use a copy of the parents shadow
-	 * stack.
+	 * If the user specified a shadow stack then do some basic
+	 * validation and use it, otherwise fall back to a default
+	 * shadow stack size if the clone_flags don't indicate an
+	 * allocation is unneeded.
 	 */
-	if (!(clone_flags & CLONE_VM))
-		return 0;
+	if (args->shadow_stack) {
+		addr = args->shadow_stack;
+		size = args->shadow_stack_size;
+	} else {
+		/*
+		 * For CLONE_VFORK the child will share the parents
+		 * shadow stack.  Make sure to clear the internal
+		 * tracking of the thread shadow stack so the freeing
+		 * logic run for child knows to leave it alone.
+		 */
+		if (clone_flags & CLONE_VFORK) {
+			shstk->base = 0;
+			shstk->size = 0;
+			return 0;
+		}
 
-	size = adjust_shstk_size(stack_size);
-	addr = alloc_shstk(0, size, 0, false);
-	if (IS_ERR_VALUE(addr))
-		return addr;
+		/*
+		 * For !CLONE_VM the child will use a copy of the
+		 * parents shadow stack.
+		 */
+		if (!(clone_flags & CLONE_VM))
+			return 0;
 
-	shstk->base = addr;
-	shstk->size = size;
+		size = args->stack_size;
+		size = adjust_shstk_size(size);
+		addr = alloc_shstk(0, size, 0, false);
+		if (IS_ERR_VALUE(addr))
+			return addr;
+
+		/* We allocated the shadow stack, we should deallocate it. */
+		shstk->base = addr;
+		shstk->size = size;
+	}
 
 	return addr + size;
 }
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d362aacf9f89..56b2013d7fe5 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -43,6 +43,8 @@ struct kernel_clone_args {
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	unsigned long shadow_stack;
+	unsigned long shadow_stack_size;
 };
 
 /*
@@ -230,4 +232,15 @@ static inline void task_unlock(struct task_struct *p)
 
 DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
 
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
+int arch_shstk_post_fork(struct task_struct *p,
+			 struct kernel_clone_args *args);
+#else
+static inline int arch_shstk_post_fork(struct task_struct *p,
+				       struct kernel_clone_args *args)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_SCHED_TASK_H */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..8b7af52548fd 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -84,6 +84,10 @@
  *                kernel's limit of nested PID namespaces.
  * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
  *                a file descriptor for the cgroup.
+ * @shadow_stack: Pointer to the memory allocated for the child
+ *                shadow stack.
+ * @shadow_stack_size: Specify the size of the shadow stack for
+ *                     the child process.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -101,12 +105,15 @@ struct clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+	__aligned_u64 shadow_stack;
+	__aligned_u64 shadow_stack_size;
 };
 #endif
 
-#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
-#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
-#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
+#define CLONE_ARGS_SIZE_VER0  64 /* sizeof first published struct */
+#define CLONE_ARGS_SIZE_VER1  80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2  88 /* sizeof third published struct */
+#define CLONE_ARGS_SIZE_VER3 104 /* sizeof fourth published struct */
 
 /*
  * Scheduling policies
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..d7c5769942f8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -125,6 +125,11 @@
  */
 #define MAX_THREADS FUTEX_TID_MASK
 
+/*
+ * Require that shadow stacks can store at least one element
+ */
+#define SHADOW_STACK_SIZE_MIN sizeof(void *)
+
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
@@ -2745,6 +2750,19 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 	return copy_process(NULL, 0, node, &args);
 }
 
+static void shstk_post_fork(struct task_struct *p,
+			    struct kernel_clone_args *args)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK))
+		return;
+
+	if (!args->shadow_stack)
+		return;
+
+	if (arch_shstk_post_fork(p, args) != 0)
+		force_sig_fault_to_task(SIGSEGV, SEGV_CPERR, NULL, p);
+}
+
 /*
  *  Ok, this is the main fork-routine.
  *
@@ -2806,6 +2824,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 	 */
 	trace_sched_process_fork(current, p);
 
+	shstk_post_fork(p, args);
+
 	pid = get_task_pid(p, PIDTYPE_PID);
 	nr = pid_vnr(pid);
 
@@ -2957,7 +2977,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER1);
 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
 		     CLONE_ARGS_SIZE_VER2);
-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_size) !=
+		     CLONE_ARGS_SIZE_VER3);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
 
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -2990,16 +3012,18 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		return -EINVAL;
 
 	*kargs = (struct kernel_clone_args){
-		.flags		= args.flags,
-		.pidfd		= u64_to_user_ptr(args.pidfd),
-		.child_tid	= u64_to_user_ptr(args.child_tid),
-		.parent_tid	= u64_to_user_ptr(args.parent_tid),
-		.exit_signal	= args.exit_signal,
-		.stack		= args.stack,
-		.stack_size	= args.stack_size,
-		.tls		= args.tls,
-		.set_tid_size	= args.set_tid_size,
-		.cgroup		= args.cgroup,
+		.flags			= args.flags,
+		.pidfd			= u64_to_user_ptr(args.pidfd),
+		.child_tid		= u64_to_user_ptr(args.child_tid),
+		.parent_tid		= u64_to_user_ptr(args.parent_tid),
+		.exit_signal		= args.exit_signal,
+		.stack			= args.stack,
+		.stack_size		= args.stack_size,
+		.tls			= args.tls,
+		.set_tid_size		= args.set_tid_size,
+		.cgroup			= args.cgroup,
+		.shadow_stack		= args.shadow_stack,
+		.shadow_stack_size	= args.shadow_stack_size,
 	};
 
 	if (args.set_tid &&
@@ -3040,6 +3064,34 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
 	return true;
 }
 
+/**
+ * clone3_shadow_stack_valid - check and prepare shadow stack
+ * @kargs: kernel clone args
+ *
+ * Verify that shadow stacks are only enabled if supported.
+ */
+static inline bool clone3_shadow_stack_valid(struct kernel_clone_args *kargs)
+{
+	if (kargs->shadow_stack) {
+		if (!kargs->shadow_stack_size)
+			return false;
+
+		if (kargs->shadow_stack_size < SHADOW_STACK_SIZE_MIN)
+			return false;
+
+		if (kargs->shadow_stack_size > rlimit(RLIMIT_STACK))
+			return false;
+
+		/*
+		 * The architecture must check support on the specific
+		 * machine.
+		 */
+		return IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK);
+	} else {
+		return !kargs->shadow_stack_size;
+	}
+}
+
 static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
@@ -3062,7 +3114,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	    kargs->exit_signal)
 		return false;
 
-	if (!clone3_stack_valid(kargs))
+	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
 		return false;
 
 	return true;

-- 
2.39.2


