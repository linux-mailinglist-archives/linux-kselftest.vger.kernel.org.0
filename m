Return-Path: <linux-kselftest+bounces-14543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBD942E0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3280B1F21132
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8671B29A7;
	Wed, 31 Jul 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1V7E7tS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CF1B151C;
	Wed, 31 Jul 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428369; cv=none; b=GF2BjoUhp0eWJJMKp31l+Mzf/50lug9Ud93cDA1dCibRvxnVN0g1+QHD3HdfJH2FTyYuYoJ5wIFXLOBpx0p5zl1EIFUvpDAW66pAMXyDsL0teAtqrLad9XUGgJIvk6BbJ1nguS2KTOQbEv93b/YednY6gkQCf+Vzasdn58wTT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428369; c=relaxed/simple;
	bh=x56zzA6iyEl4hYlVsxr4pVDsnY2Epg1Ay/M+axG7wxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWOBc1aJEakEyoe2R27mVw4vSnP+jS7kNHoiOionxw4BcKRwa71oOP6WUJViSi9zgQvpCcEteWZ/WUVP3+EPitUMgX4AkUHCVLTsRZbHPCsJlQZH6rIey4TUqyKkZeFqZFIJXDY/l9h0TztRgrY5iVhJmYzEXS6xDk/mAmqq9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1V7E7tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0818DC116B1;
	Wed, 31 Jul 2024 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428368;
	bh=x56zzA6iyEl4hYlVsxr4pVDsnY2Epg1Ay/M+axG7wxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y1V7E7tSE58NuZBzQ65h8W/2ESLa8rcUSzqP3NnCrrYajot5hjHaVY3jC1XCn8IA3
	 7fsfm1mjQPpcWFzk3LI1v7amGPawhAulf9KCH5YRuhGREneQ5tH7h7dxHK62pAGla6
	 vB+pcdI34zU6i29KSgh4i/ONTqh7rS1fI88u2qF8zk5FUulzkyvTziVoqJ2sc9AVt+
	 bRRvAjjDZXiPXzxwQGDSK8Fwv38RYQC2EvzD8gb9qNeTZ9m5LhXVWM8RVDrgw28dkq
	 OUm1wNSYy3L4s/UdsReuNsgymqYtWurvF6+nUMDTiXuR5B/pRYUPAYy0bsaaEOZlSN
	 A7YqRmbCRNdBg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 13:14:10 +0100
Subject: [PATCH RFT v7 4/9] fork: Add shadow stack support to clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-clone3-shadow-stack-v7-4-a9532eebfb1d@kernel.org>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
In-Reply-To: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=14271; i=broonie@kernel.org;
 h=from:subject:message-id; bh=x56zzA6iyEl4hYlVsxr4pVDsnY2Epg1Ay/M+axG7wxA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqiuuY9ajMjER9WiNW+tbe1HvU4h+9UYrwco04tK6
 H4kLPlGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqorrgAKCRAk1otyXVSH0EzeCA
 CDg9vUtgRuW1eZ3HcZUHCiQpJ9rGPEmP8zIrzl+qxwf79RKXUfnZv8vCa1Z9O10uhDbE9F1wWt3ZK7
 Wnhi6blrLP5gyixmWXbCZra/NgcTnZr5+e22r+2JUsAfELYs7zMZEQGwK849navDctQdmr0YNoayKV
 n0ishdWvtajiR/1ZFSNmrgnOKFU3UelJuGpz0gzI9KYQDqtU1QELpIpoC7jlcWkoUcgNxFiiWbRZzV
 wOpDcayRvMM3ZXjSuIY51rRdBUO6LW2iUTc25T67ulkswTGux50uOTzw0r1b7oNlqdnO6g/LUEhnHs
 aeyW0y0oKOG0MDGpv7SRqM45F48EV0
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
index 4cb77e004615..252feeda6999 100644
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
@@ -28,8 +29,10 @@ static inline long shstk_prctl(struct task_struct *task, int option,
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
index f63f8fd00a91..59456ab8d93f 100644
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
index 059685612362..1755fa21e6fb 100644
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
+	/* This should really be an atomic cmpxchg.  It is not. */
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
index cc760491f201..18278c72681c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -128,6 +128,11 @@
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
@@ -2729,6 +2734,19 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
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
@@ -2790,6 +2808,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 	 */
 	trace_sched_process_fork(current, p);
 
+	shstk_post_fork(p, args);
+
 	pid = get_task_pid(p, PIDTYPE_PID);
 	nr = pid_vnr(pid);
 
@@ -2939,7 +2959,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER1);
 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
 		     CLONE_ARGS_SIZE_VER2);
-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_size) !=
+		     CLONE_ARGS_SIZE_VER3);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
 
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -2972,16 +2994,18 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
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
@@ -3022,6 +3046,34 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
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
@@ -3044,7 +3096,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	    kargs->exit_signal)
 		return false;
 
-	if (!clone3_stack_valid(kargs))
+	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
 		return false;
 
 	return true;

-- 
2.39.2


