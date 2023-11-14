Return-Path: <linux-kselftest+bounces-110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF77EB740
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 21:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E247B20AF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387C35EEB;
	Tue, 14 Nov 2023 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6ueccfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842A35EE7;
	Tue, 14 Nov 2023 20:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE786C433C8;
	Tue, 14 Nov 2023 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699992389;
	bh=rEnFppQxs2VRtsQrM4GtrIYWCx4gRYkNGbc4gkefOew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X6ueccfi7VjhhSaPqe6F8CadZN+x042CjlAISPE8RWfJM9uyQ/lf/GC/si68Yr5ea
	 gAUxJfHaBM/tUbGU7YpAbK//Q+VGeI6tMCUsGuto9+3crIcqohIUnRmrOzFt0ECjNE
	 1hz9CANB1tnXQ7/fq5QemjL7X8YOUv0/Et1L8bFtEyKq26BBgmotO5eKsqBVn26bzn
	 Xlf7+5DCr0lK2e7OtoAfzRotC6zqeOpbgh7lCcXS3TFpR3nQjG3p7b+x2ojf9FWx+I
	 pN4sT9pE3Jdz/8cUHY5k7X9kXeawmH0cL/5as0VBjYCu16DYOvD2cCIJbPrm75KNb9
	 luwtSmUKv8jyg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 20:05:55 +0000
Subject: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=9325; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rEnFppQxs2VRtsQrM4GtrIYWCx4gRYkNGbc4gkefOew=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU9Mu+37t29M3Co3bC5Tcq+Z5IGymkBXb3k0s52CF
 uC5qirWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVPTLgAKCRAk1otyXVSH0BvsB/
 93NTo9+zfkzEA/mPe6KuM6rZ80LGcs2bxhCjT+Lzx37QDoGLO4N6goSliomWPcWUcwmu2sXx/1pE8W
 OBKKwLWhp7EAtzvaOmQVrGRrkYA08QD8TLvNMcTtc3AIHjMOKnLMURZeZ2Va4UKEYsIMxeWfVkMzjw
 2JEm97fp0Be6OnKz6kQRGjcjsko6c58bamnQ10gfgpLjcUTFfyNY3Kxg/jJEQ4dYxjwZjZ5nJWbuJF
 rELXt33h+v2faarI3747fHXzjTjVcGEpbqwB30M8Lo6FHddVMrf5cGeZqCZKgoualkugjMbUs6sG4J
 VXFC1Q4BNkDUY2IyLE7ItuvI3japnA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Unlike with the normal stack there is no API for configuring the the shadow
stack for a new thread, instead the kernel will dynamically allocate a new
shadow stack with the same size as the normal stack. This appears to be due
to the shadow stack series having been in development since before the more
extensible clone3() was added rather than anything more deliberate.

Add parameters to clone3() specifying the address and size of a shadow
stack for the newly created process, we validate that the range specified
is accessible to userspace but do not validate that it has been mapped
appropriately for use as a shadow stack (normally via map_shadow_stack()).
If the shadow stack is specified in this way then the caller is responsible
for freeing the memory as with the main stack. If no shadow stack is
specified then the existing implicit allocation and freeing behaviour is
maintained.

If the architecture does not support shadow stacks the shadow stack
parameters must be zero, architectures that do support the feature are
expected to have the same requirement on individual systems that lack
shadow stack support.

Update the existing x86 implementation to pay attention to the newly added
arguments, in order to maintain compatibility we use the existing behaviour
if no shadow stack is specified. Minimal validation is done of the supplied
parameters, detailed enforcement is left to when the thread is executed.
Since we are now using four fields from the kernel_clone_args we pass that
into the shadow stack code rather than individual fields.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/include/asm/shstk.h | 11 +++++++----
 arch/x86/kernel/process.c    |  2 +-
 arch/x86/kernel/shstk.c      | 30 +++++++++++++++++++++++++-----
 include/linux/sched/task.h   |  2 ++
 include/uapi/linux/sched.h   |  4 ++++
 kernel/fork.c                | 24 ++++++++++++++++++++++--
 6 files changed, 61 insertions(+), 12 deletions(-)

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
index b6f4e8399fca..a9ca80ea5056 100644
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
index 59e15dd8d0f8..7ffe90010587 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -191,18 +191,38 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
-unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-				       unsigned long stack_size)
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
+	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
+		if (args->shadow_stack)
+			return (unsigned long)ERR_PTR(-EINVAL);
+
 		return 0;
+	}
+
+	/*
+	 * If the user specified a shadow stack then do some basic
+	 * validation and use it.  The caller is responsible for
+	 * freeing the shadow stack.
+	 */
+	if (args->shadow_stack_size) {
+		size = args->shadow_stack_size;
+
+		if (size < 8)
+			return (unsigned long)ERR_PTR(-EINVAL);
+	} else {
+		size = args->stack_size;
+	}
 
 	/*
 	 * For CLONE_VFORK the child will share the parents shadow stack.
@@ -222,7 +242,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 	if (!(clone_flags & CLONE_VM))
 		return 0;
 
-	size = adjust_shstk_size(stack_size);
+	size = adjust_shstk_size(size);
 	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return addr;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index a23af225c898..94e7cf62be51 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -41,6 +41,8 @@ struct kernel_clone_args {
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	unsigned long shadow_stack;
+	unsigned long shadow_stack_size;
 };
 
 /*
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..a998b6d0c897 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -84,6 +84,8 @@
  *                kernel's limit of nested PID namespaces.
  * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
  *                a file descriptor for the cgroup.
+ * @shadow_stack_size: Specify the size of the shadow stack to allocate
+ *                     for the child process.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -101,12 +103,14 @@ struct clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+	__aligned_u64 shadow_stack_size;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
 #define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
+#define CLONE_ARGS_SIZE_VER3 96 /* sizeof fourth published struct */
 
 /*
  * Scheduling policies
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..b0df69c8185e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3067,7 +3067,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER1);
 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
 		     CLONE_ARGS_SIZE_VER2);
-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_size) !=
+		     CLONE_ARGS_SIZE_VER3);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
 
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -3110,6 +3112,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		.tls		= args.tls,
 		.set_tid_size	= args.set_tid_size,
 		.cgroup		= args.cgroup,
+		.shadow_stack_size	= args.shadow_stack_size,
 	};
 
 	if (args.set_tid &&
@@ -3150,6 +3153,23 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
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
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
+	/* The architecture must check support on the specific machine */
+	return true;
+#else
+	/* The architecture does not support shadow stacks */
+	return !kargs->shadow_stack_size;
+#endif
+}
+
 static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
@@ -3172,7 +3192,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	    kargs->exit_signal)
 		return false;
 
-	if (!clone3_stack_valid(kargs))
+	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
 		return false;
 
 	return true;

-- 
2.30.2


