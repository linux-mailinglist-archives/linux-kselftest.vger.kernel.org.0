Return-Path: <linux-kselftest+bounces-4061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28517847D7D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9646D1F2B6DD
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945C64E;
	Sat,  3 Feb 2024 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrBKQGhz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19F6FC9;
	Sat,  3 Feb 2024 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918749; cv=none; b=pSd5ZPDCRzLevrQqj5bzwJmlf5aNrGiU211skFrmLllalyTOw43K3DoIFviuApnkoOZh3eZ856yK7exwomLauuhdJojfbib9oE7rJGSM5FcsbxpCTj2ARzuQjMimApk82fb/k3Wh37JgDJUYmyvKlEo/0uAHnbGzc6L3qNWLZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918749; c=relaxed/simple;
	bh=/Uxgj2IAESh9gETndlWWvEFVRUx/ON9J1XPtcKlvNl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tW2eyiC3WhhW4wFA69J3ZB36FRsB5eye31WULMhpoIKxsSOt++wUVYrqgEe6l4r0WmDma8wU5hQX/jxdH/zgkitCDG/WoYIe/rEfBASTOJb7xOY6fJQDv8anPu34YOYd1rUg5+uIevv8lUWfpAtLYTgVCXlUPRwX7wQzZYrVeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrBKQGhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5FFC433A6;
	Sat,  3 Feb 2024 00:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918749;
	bh=/Uxgj2IAESh9gETndlWWvEFVRUx/ON9J1XPtcKlvNl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qrBKQGhzDjbMD1hPRzg+FhkluePUyAG7yQ8lMrbhJ1PmJD7UPq1ZaWDhaZgtP/PrA
	 c9KGSpzKKHAz2scvLevgcJ4Kwf62YpcbnlKrBKJl4KNcvuqB00rBUsK2kJatQSUYnw
	 JasUrpsQ5Xsw4kp9jGwSHTkTCtQxcu7/alHbjUIzXpTJbEBABnAgb+jJHPM+T4cO35
	 I58FKBv5AB5xScMfFh4JxvxpluGMYo1dkdFK5go8wQyp896wkIpEbu6W3IgEhgovLp
	 9X0HMUJCZzNiEdmRyoeWk/as+ocoXUA5A2quzRuLUnDIhxbdKZiFNXYDWiw7zxeozO
	 eX4rG7e7maBNQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 00:05:00 +0000
Subject: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-clone3-shadow-stack-v5-4-322c69598e4b@kernel.org>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
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
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 jannh@google.com, bsegall@google.com, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=12389; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/Uxgj2IAESh9gETndlWWvEFVRUx/ON9J1XPtcKlvNl0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvYM7qtPkzoKYQlZ1WsaXCFO/ZJrlwVY5ooj5EuDA
 bnva/GuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb2DOwAKCRAk1otyXVSH0CjOB/
 4/gAq2McZAJMyKWRAGBo1K7766JCUyDJ53E3DElouyujc0tXFZt/nUbUkpyiopJ4b65tFgqpXPKN4K
 Kk7rhR3FI595uWxVo9RNsMQMaVkg9hGqSAv5wbz6XzyNWnHT4b53MmeFRymWH5wI/Guujv+mQaaUhW
 Dr1rt/53YE6IVWKdreITyDGMfmekm/yOaDbGp+0Xv0J9dl8Ornl/QCL6Ci0WK/hzRwJH0OY3yrRDJk
 b9oCxAUbSybPuJnxlU40AqvojbkH9FjRPIf3HJtiFIo18kcai/UeZk6ysjfL8t3EzzhgqkKtFitNVk
 v0PTEQLOxYbsm4WmjczO3W4DIQJ28V
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Unlike with the normal stack there is no API for configuring the the shadow
stack for a new thread, instead the kernel will dynamically allocate a new
shadow stack with the same size as the normal stack. This appears to be due
to the shadow stack series having been in development since before the more
extensible clone3() was added rather than anything more deliberate.

Add a parameter to clone3() specifying the size of a shadow stack for
the newly created process.  If no shadow stack is specified then the
existing implicit allocation behaviour is maintained.

If the architecture does not support shadow stacks the shadow stack size
parameter must be zero, architectures that do support the feature are
expected to enforce the same requirement on individual systems that lack
shadow stack support.

Update the existing x86 implementation to pay attention to the newly added
arguments, in order to maintain compatibility we use the existing behaviour
if no shadow stack is specified. Minimal validation is done of the supplied
parameters, detailed enforcement is left to when the thread is executed.
Since we are now using more fields from the kernel_clone_args we pass that
into the shadow stack code rather than individual fields.

At present this implemntation does not consume the shadow stack token
atomically as would be desirable.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/include/asm/shstk.h | 11 ++++--
 arch/x86/kernel/process.c    |  2 +-
 arch/x86/kernel/shstk.c      | 91 +++++++++++++++++++++++++++++++++-----------
 include/linux/sched/task.h   |  2 +
 include/uapi/linux/sched.h   | 13 +++++--
 kernel/fork.c                | 61 +++++++++++++++++++++++------
 6 files changed, 137 insertions(+), 43 deletions(-)

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
index ab49ade31b0d..d2bfcd44de05 100644
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
index 59e15dd8d0f8..24d0e9b825da 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -191,44 +191,89 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
-unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-				       unsigned long stack_size)
+static bool shstk_consume_token(struct task_struct *tsk,
+				unsigned long addr)
+{
+	/*
+	 * SSP is aligned, so reserved bits and mode bit are a zero, just mark
+	 * the token 64-bit.
+	 */
+	u64 expected = (addr - SS_FRAME_SIZE) | BIT(0);
+	u64 val;
+
+	/* This should really be an atomic cpmxchg.  It is not. */
+	__get_user(val, (__user u64 *)addr);
+	if (val != expected)
+		return false;
+
+	if (write_user_shstk_64((u64 __user *)addr, 0))
+		return false;
+
+	return true;
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
 
-	size = adjust_shstk_size(stack_size);
-	addr = alloc_shstk(0, size, 0, false);
-	if (IS_ERR_VALUE(addr))
-		return addr;
+		/* There should be a valid token at the top of the stack. */
+		if (!shstk_consume_token(tsk, addr + size - sizeof(u64)))
+			return (unsigned long)ERR_PTR(-EINVAL);
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
 
-	shstk->base = addr;
-	shstk->size = size;
+		/*
+		 * For !CLONE_VM the child will use a copy of the
+		 * parents shadow stack.
+		 */
+		if (!(clone_flags & CLONE_VM))
+			return 0;
+
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
index d362aacf9f89..dd577e8dc881 100644
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
index 0d944e92a43f..fca041cc2b8a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -123,6 +123,11 @@
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
@@ -3062,7 +3067,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER1);
 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
 		     CLONE_ARGS_SIZE_VER2);
-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_size) !=
+		     CLONE_ARGS_SIZE_VER3);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
 
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -3095,16 +3102,18 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
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
@@ -3145,6 +3154,34 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
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
@@ -3167,7 +3204,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	    kargs->exit_signal)
 		return false;
 
-	if (!clone3_stack_valid(kargs))
+	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
 		return false;
 
 	return true;

-- 
2.30.2


