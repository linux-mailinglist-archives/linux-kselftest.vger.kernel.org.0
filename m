Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7957D37F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 15:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjJWNZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 09:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjJWNZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 09:25:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D676273A;
        Mon, 23 Oct 2023 06:23:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4492FC433C8;
        Mon, 23 Oct 2023 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698067418;
        bh=wUhiPV1iw/5mTPqUKRQaD3BHKH1V6EDBJD2oIZClkvc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nGcN4xaZJOZpByeL3Ayx5QzDfmypqpMnK8lokOLB7QruiZ3thaLZaWhQ0T99Y0euE
         Qr4AqWp7GOf7AvZLpGO/FbTrVQtKMm0PQoiTjMvcEzohcUB1jqfSlxzRWDrvPBzWSp
         0cdDkziHj4QyL03v9P7ojQ14LvAHmHhwsKWJYkPAABkH6drppV6HF3c+FvG7ZKhxi3
         OVF2bVyE/Z88TXyDO6XSYVaYF0vOg4s4HBt9Dn+nEbcONxeuUnAAROK0XUIs/2ase8
         wBkJocc/4oFhBLDyKOn57gZ7J5E5hC0KxMO3gAMW0/Cel8WXhexOh428rGnFXdEA+Z
         DuXfOzm6Wnylw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 23 Oct 2023 14:20:41 +0100
Subject: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
In-Reply-To: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=10498; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wUhiPV1iw/5mTPqUKRQaD3BHKH1V6EDBJD2oIZClkvc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNnPETIgl8yM0h7STe4LPhtBTXAUmlBEabHthxCru
 eKqExeuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTZzxAAKCRAk1otyXVSH0GmgB/
 9l1Ceu7k2k8Hhe2yBQXNjM5f2ApqPb5FUWmdlWwfmIebt0Q6VuYITF3Y+OsPjaJwh+2FYa0oseE86e
 vm5E1HsH/or6m3tfMZ8+rbrgMWQ7j+eLDh2+v0iF4fpNK9QCCw01y+jrr07juifty90wOr80tHeG7y
 D6Y2+OCdEUBNqzHoQOVlpKlmK8y/zUGwIDQ0BcE5Km+Wp6BJ3kalAxNemTSmJX0GGUaqk/EgQQZq/U
 isWfNNqeUNJtpFNIdt6vu4TVEeNN1yAl1HDLPO9XGw5aP0BVGmgBmJ6eS7SSvGp+LCVjd4Co+dkpGl
 rlOnKw9IclRfIkQbBggSxdttOE41IR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
 arch/x86/kernel/shstk.c      | 36 +++++++++++++++++++++++++++++++-----
 include/linux/sched/task.h   |  2 ++
 include/uapi/linux/sched.h   | 17 ++++++++++++++---
 kernel/fork.c                | 40 ++++++++++++++++++++++++++++++++++++++--
 6 files changed, 93 insertions(+), 15 deletions(-)

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
index 59e15dd8d0f8..3ae5c3d657dc 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -191,18 +191,44 @@ void reset_thread_features(void)
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
+	if (args->shadow_stack) {
+		addr = args->shadow_stack;
+		size = args->shadow_stack_size;
+
+		if (!IS_ALIGNED(addr, 8))
+			return (unsigned long)ERR_PTR(-EINVAL);
+		if (size < 8)
+			return (unsigned long)ERR_PTR(-EINVAL);
+
+		shstk->base = 0;
+		shstk->size = 0;
+
+		return addr + size;
+	}
 
 	/*
 	 * For CLONE_VFORK the child will share the parents shadow stack.
@@ -222,7 +248,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 	if (!(clone_flags & CLONE_VM))
 		return 0;
 
-	size = adjust_shstk_size(stack_size);
+	size = adjust_shstk_size(args->stack_size);
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
index 3bac0a8ceab2..1bd1b956834d 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -84,6 +84,14 @@
  *                kernel's limit of nested PID namespaces.
  * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
  *                a file descriptor for the cgroup.
+ * @shadow_stack: Specify the location of the shadow stack for the
+ *                child process.
+ *                Note, @shadow_stack is expected to point to the
+ *                lowest address. The stack direction will be
+ *                determined by the kernel and set up
+ *                appropriately based on @shadow_stack_size.
+ * @shadow_stack_size:   The size of the shadow stack for the child
+ *                       process.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -101,12 +109,15 @@ struct clone_args {
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
index 3b6d20dfb9a8..bd61aa7353b0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3069,7 +3069,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER1);
 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
 		     CLONE_ARGS_SIZE_VER2);
-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_size) !=
+		     CLONE_ARGS_SIZE_VER3);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
 
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -3112,6 +3114,8 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		.tls		= args.tls,
 		.set_tid_size	= args.set_tid_size,
 		.cgroup		= args.cgroup,
+		.shadow_stack	= args.shadow_stack,
+		.shadow_stack_size	= args.shadow_stack_size,
 	};
 
 	if (args.set_tid &&
@@ -3152,6 +3156,38 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
 	return true;
 }
 
+/**
+ * clone3_shadow_stack_valid - check and prepare shadow stack
+ * @kargs: kernel clone args
+ *
+ * Verify that the shadow stack arguments userspace gave us are sane.
+ */
+static inline bool clone3_shadow_stack_valid(struct kernel_clone_args *kargs)
+{
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
+	if (kargs->shadow_stack) {
+		if (!kargs->shadow_stack_size)
+			return false;
+
+		/*
+		 * This doesn't validate that the addresses are mapped
+		 * VM_SHADOW_STACK, just that they're mapped at all.
+		 */
+		if (!access_ok((void __user *)kargs->shadow_stack,
+			       kargs->shadow_stack_size))
+			return false;
+	} else {
+		if (kargs->shadow_stack_size)
+			return false;
+	}
+
+	return true;
+#else
+	/* The architecture does not support shadow stacks */
+	return !kargs->shadow_stack && !kargs->shadow_stack_size;
+#endif
+}
+
 static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
@@ -3174,7 +3210,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	    kargs->exit_signal)
 		return false;
 
-	if (!clone3_stack_valid(kargs))
+	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
 		return false;
 
 	return true;

-- 
2.30.2

