Return-Path: <linux-kselftest+bounces-30921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98167A8AC2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F223443E23
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020A2D92CD;
	Tue, 15 Apr 2025 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw/ZODP+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77B2957C5;
	Tue, 15 Apr 2025 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759928; cv=none; b=HcogJmzhQ2kSzrP+cmyQKjT+w0PDJasKIoxJgaZli4W+102DyxA30kV7xB+Ct9BE3vhImAl6OITRLd8Ufk/6+9BJ2QyTBNUKCSHhkvVAg8BQaFgTkdeBf6aEj30MzVryjjWRYIsVQBtrXmi6eQNb2jFpKwEXwkgSDu2dyX3igMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759928; c=relaxed/simple;
	bh=W9YJQtN3Bo1hY1TQG+0VI73bjJTxf9tjNhYIGVb9qT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6DMZqkyBVEhRHxTxTEkX/8lCKs9h4lkfDIsduaWmwD2olxqrU4mZV7DEji+r2ohMVxZdtXKxbmc8tJcNWzFk/nprcXKiLZDbQF4qBfXTnoNtLt+w/xJz7f8m7vKfFj4zWanjyTYWECKTnRJf/9xbYGX2upgUqQjWndb/4HHMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw/ZODP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED98DC4CEEB;
	Tue, 15 Apr 2025 23:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759928;
	bh=W9YJQtN3Bo1hY1TQG+0VI73bjJTxf9tjNhYIGVb9qT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rw/ZODP+xzYJUOSSO375wxvhxAc+zrmuwxFFIlz91WrQlvcNMWNvQca+J2lngFyCU
	 +GU4fCi0/+TMZhkhFUbck+VLHLiJ/EclnTRL4ROUbSyvuvLHHQmphOz+v8f+lNdgrR
	 t24mE6WrV5Yt9oSzj62EVHdvaE9yerioOkiSDLeK8hIH4L7YcMOydweOiUt/jY+hAq
	 16YaPhb82Tb/MF/aIodY/JqI/B7qyfwlbcKs0F0095BY31bH6aGI8r7qVmL+zOwprj
	 1TP0uLgQfn3q3tC9dIZrVKizqVTv6J+h/OsQNam8NKjYSqT3EyQG6JgpXg5IxVTKNE
	 6j7mQeYEl56OQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 16 Apr 2025 00:31:11 +0100
Subject: [PATCH RFT v16 4/8] fork: Add shadow stack support to clone3()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-clone3-shadow-stack-v16-4-2ffc9ca3917b@kernel.org>
References: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
In-Reply-To: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=16254; i=broonie@kernel.org;
 h=from:subject:message-id; bh=W9YJQtN3Bo1hY1TQG+0VI73bjJTxf9tjNhYIGVb9qT4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn/uxWZQq4DXGHLTmLtoFbL/sgRUAmHrBcrID/NRGm
 rezPFg2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/7sVgAKCRAk1otyXVSH0Fa0B/
 4uTZCWVW5rStG7kAKevmmKx6PSMK5TXCkg43bRLQ7N20p+9oju2/+Ytyh8dZxGSU3SzyXssdkQmF31
 8c5HtXsGFzmEQD+EwA6lUPPK1vxhz1PvGwGgQC77ISapJE2yeXTjcjq42gEdv3V3enis8AYFgnqeIm
 39J9yNGqOAx22djk9uVxZivV19yQM1fig+pePDTrt5TbYsY8Lxa/h06VrdsrUyQ604ZT2+XyjH8WMt
 edePbw5iT+ylTTrr0FsWVXI8O+8xECWTzOTqZ6Cs4VCBv3pQAQAGgV0E/LpPiMcwEVdJ296FCIvIjS
 RVMFlXzyBSnwYLVshhCTHXjbUojxKU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Unlike with the normal stack there is no API for configuring the shadow
stack for a new thread, instead the kernel will dynamically allocate a
new shadow stack with the same size as the normal stack. This appears to
be due to the shadow stack series having been in development since
before the more extensible clone3() was added rather than anything more
deliberate.

Add a parameter to clone3() specifying the shadow stack pointer to use
for the new thread, this is inconsistent with the way we specify the
normal stack but during review concerns were expressed about having to
identify where the shadow stack pointer should be placed especially in
cases where the shadow stack has been previously active.  If no shadow
stack is specified then the existing implicit allocation behaviour is
maintained.

If a shadow stack pointer is specified then it is required to have an
architecture defined token placed on the stack, this will be consumed by
the new task.  If no valid token is present then this will be reported
with -EINVAL.  This token prevents new threads being created pointing at
the shadow stack of an existing running thread.

If the architecture does not support shadow stacks the shadow stack
pointer must be not be specified, architectures that do support the
feature are expected to enforce the same requirement on individual
systems that lack shadow stack support.

Update the existing arm64 and x86 implementations to pay attention to
the newly added arguments, in order to maintain compatibility we use the
existing behaviour if no shadow stack is specified. Since we are now
using more fields from the kernel_clone_args we pass that into the
shadow stack code rather than individual fields.

Portions of the x86 architecture code were written by Rick Edgecombe.

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/gcs.c              | 53 +++++++++++++++++++++-
 arch/x86/include/asm/shstk.h     | 11 +++--
 arch/x86/kernel/process.c        |  2 +-
 arch/x86/kernel/shstk.c          | 57 +++++++++++++++++++++---
 include/asm-generic/cacheflush.h | 11 +++++
 include/linux/sched/task.h       | 17 +++++++
 include/uapi/linux/sched.h       |  9 ++--
 kernel/fork.c                    | 96 +++++++++++++++++++++++++++++++++++-----
 8 files changed, 230 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 1f633a482558..586494f7669b 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -43,8 +43,23 @@ int gcs_alloc_thread_stack(struct task_struct *tsk,
 {
 	unsigned long addr, size;
 
-	if (!system_supports_gcs())
+	if (!system_supports_gcs()) {
+		if (args->shadow_stack_token)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	/*
+	 * If the user specified a GCS then use it, otherwise fall
+	 * back to a default allocation strategy. Validation is done
+	 * in arch_shstk_validate_clone().
+	 */
+	if (args->shadow_stack_token) {
+		tsk->thread.gcs_base = 0;
+		tsk->thread.gcs_size = 0;
 		return 0;
+	}
 
 	if (!task_gcs_el0_enabled(tsk))
 		return 0;
@@ -68,6 +83,42 @@ int gcs_alloc_thread_stack(struct task_struct *tsk,
 	return 0;
 }
 
+static bool gcs_consume_token(struct vm_area_struct *vma, struct page *page,
+			      unsigned long user_addr)
+{
+	u64 expected = GCS_CAP(user_addr);
+	u64 *token = page_address(page) + offset_in_page(user_addr);
+
+	if (!cmpxchg_to_user_page(vma, page, user_addr, token, expected, 0))
+		return false;
+	set_page_dirty_lock(page);
+
+	return true;
+}
+
+int arch_shstk_validate_clone(struct task_struct *tsk,
+			      struct vm_area_struct *vma,
+			      struct page *page,
+			      struct kernel_clone_args *args)
+{
+	unsigned long gcspr_el0;
+	int ret = 0;
+
+	/* Ensure that a token written as a result of a pivot is visible */
+	gcsb_dsync();
+
+	gcspr_el0 = args->shadow_stack_token;
+	if (!gcs_consume_token(vma, page, gcspr_el0))
+		return -EINVAL;
+
+	tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
+
+	/* Ensure that our token consumption visible */
+	gcsb_dsync();
+
+	return ret;
+}
+
 SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
 {
 	unsigned long alloc_size;
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ba6f2fe43848..827e983430aa 100644
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
index 962c3ce39323..002b05483c62 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -213,7 +213,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
 	 * update it.
 	 */
-	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
+	new_ssp = shstk_alloc_thread_stack(p, args);
 	if (IS_ERR_VALUE(new_ssp))
 		return PTR_ERR((void *)new_ssp);
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 059685612362..8cce74ee0d96 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -191,18 +191,65 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
-unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
-				       unsigned long stack_size)
+int arch_shstk_validate_clone(struct task_struct *t,
+			      struct vm_area_struct *vma,
+			      struct page *page,
+			      struct kernel_clone_args *args)
+{
+	/*
+	 * SSP is aligned, so reserved bits and mode bit are a zero, just mark
+	 * the token 64-bit.
+	 */
+	void *maddr = page_address(page);
+	int offset, token;
+	unsigned long ssp;
+	u64 expected;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	token = args->shadow_stack_token;
+	ssp = token + 8;
+	expected = (ssp + FRAME_SIZE) | BIT(0);
+	offset = offset_in_page(token);
+
+	if (!cmpxchg_to_user_page(vma, page, token, (unsigned long *)(maddr + offset),
+				  expected, 0))
+		return -EINVAL;
+	set_page_dirty_lock(page);
+
+	return 0;
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
+	 * explicitly specify one.
 	 */
-	if (!features_enabled(ARCH_SHSTK_SHSTK))
+	if (!features_enabled(ARCH_SHSTK_SHSTK)) {
+		if (args->shadow_stack_token)
+			return (unsigned long)ERR_PTR(-EINVAL);
+
 		return 0;
+	}
+
+	/*
+	 * If the user specified a shadow stack then use it, otherwise
+	 * fall back to a default allocation strategy. Validation is
+	 * done in arch_shstk_validate_clone().
+	 */
+	if (args->shadow_stack_token) {
+		shstk->base = 0;
+		shstk->size = 0;
+		return args->shadow_stack_token + 8;
+	}
 
 	/*
 	 * For CLONE_VFORK the child will share the parents shadow stack.
@@ -222,7 +269,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 	if (!(clone_flags & CLONE_VM))
 		return 0;
 
-	size = adjust_shstk_size(stack_size);
+	size = adjust_shstk_size(args->stack_size);
 	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return addr;
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 7ee8a179d103..96cc0c7a5c90 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -124,4 +124,15 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 	} while (0)
 #endif
 
+#ifndef cmpxchg_to_user_page
+#define cmpxchg_to_user_page(vma, page, vaddr, ptr, old, new)  \
+({							  \
+	bool ret;						  \
+								  \
+	ret = try_cmpxchg(ptr, &old, new);			  \
+	flush_icache_user_page(vma, page, vaddr, sizeof(*ptr));	  \
+	ret;							  \
+})
+#endif
+
 #endif /* _ASM_GENERIC_CACHEFLUSH_H */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ca1db4b92c32..c34f3cb68822 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -16,6 +16,7 @@ struct task_struct;
 struct rusage;
 union thread_union;
 struct css_set;
+struct vm_area_struct;
 
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
@@ -44,6 +45,7 @@ struct kernel_clone_args {
 	struct cgroup *cgrp;
 	struct css_set *cset;
 	unsigned int kill_seq;
+	unsigned long shadow_stack_token;
 };
 
 /*
@@ -237,4 +239,19 @@ static inline void task_unlock(struct task_struct *p)
 
 DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
 
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
+int arch_shstk_validate_clone(struct task_struct *p,
+			      struct vm_area_struct *vma,
+			      struct page *page,
+			      struct kernel_clone_args *args);
+#else
+static inline int arch_shstk_validate_clone(struct task_struct *p,
+					    struct vm_area_struct *vma,
+					    struct page *page,
+					    struct kernel_clone_args *args)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_SCHED_TASK_H */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14cc76a4..9cf5c419e109 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -84,6 +84,7 @@
  *                kernel's limit of nested PID namespaces.
  * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
  *                a file descriptor for the cgroup.
+ * @shadow_stack_token: Pointer to shadow stack token at top of stack.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -101,12 +102,14 @@ struct clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+	__aligned_u64 shadow_stack_token;
 };
 #endif
 
-#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
-#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
-#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
+#define CLONE_ARGS_SIZE_VER0  64 /* sizeof first published struct */
+#define CLONE_ARGS_SIZE_VER1  80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2  88 /* sizeof third published struct */
+#define CLONE_ARGS_SIZE_VER3  96 /* sizeof fourth published struct */
 
 /*
  * Scheduling policies
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b..98f19bd1f35d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2162,6 +2162,51 @@ static void rv_task_fork(struct task_struct *p)
 #define rv_task_fork(p) do {} while (0)
 #endif
 
+static int shstk_validate_clone(struct task_struct *p,
+				struct kernel_clone_args *args)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct page *page;
+	unsigned long addr;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK))
+		return 0;
+
+	if (!args->shadow_stack_token)
+		return 0;
+
+	mm = get_task_mm(p);
+	if (!mm)
+		return -EFAULT;
+
+	mmap_read_lock(mm);
+
+	addr = untagged_addr_remote(mm, args->shadow_stack_token);
+	page = get_user_page_vma_remote(mm, addr, FOLL_FORCE | FOLL_WRITE,
+					&vma);
+	if (IS_ERR(page)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (!(vma->vm_flags & VM_SHADOW_STACK) ||
+	    !(vma->vm_flags & VM_WRITE)) {
+		ret = -EFAULT;
+		goto out_page;
+	}
+
+	ret = arch_shstk_validate_clone(p, vma, page, args);
+
+out_page:
+	put_page(page);
+out:
+	mmap_read_unlock(mm);
+	mmput(mm);
+	return ret;
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2436,6 +2481,9 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
 	retval = copy_thread(p, args);
+	if (retval)
+		goto bad_fork_cleanup_io;
+	retval = shstk_validate_clone(p, args);
 	if (retval)
 		goto bad_fork_cleanup_io;
 
@@ -3002,7 +3050,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER1);
 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
 		     CLONE_ARGS_SIZE_VER2);
-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(offsetofend(struct clone_args, shadow_stack_token) !=
+		     CLONE_ARGS_SIZE_VER3);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
 
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -3035,16 +3085,17 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
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
+		.shadow_stack_token	= args.shadow_stack_token,
 	};
 
 	if (args.set_tid &&
@@ -3085,6 +3136,27 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
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
+	if (!kargs->shadow_stack_token)
+		return true;
+
+	if (!IS_ALIGNED(kargs->shadow_stack_token, sizeof(void *)))
+		return false;
+
+	/*
+	 * The architecture must check support on the specific
+	 * machine.
+	 */
+	return IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK);
+}
+
 static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
@@ -3107,7 +3179,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	    kargs->exit_signal)
 		return false;
 
-	if (!clone3_stack_valid(kargs))
+	if (!clone3_stack_valid(kargs) || !clone3_shadow_stack_valid(kargs))
 		return false;
 
 	return true;

-- 
2.39.5


