Return-Path: <linux-kselftest+bounces-49375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D139D3AD0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFDE93097191
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C3937F8C9;
	Mon, 19 Jan 2026 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="brm6ueQL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8F1E531;
	Mon, 19 Jan 2026 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834081; cv=none; b=iiEAojx0BtQdD6sGxHLtVsOmxUjZVWixaNTCKLBlT/MyDk1kEoKCMEy1u7Y39VNcOoeEqbcivYgWLV879oXh1dcrcNeSoIlIXbbRF0GIX/RW7p6fXkQTw2Ehl+fIgZrVA+8AxHz2sl/pFA9ldrQfbYlceCXGjSD0wjkqeA8h1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834081; c=relaxed/simple;
	bh=Pe3RNVaiFeDp5+sCxGJDBB2QzlxcDNyTyJJ1oXBcLHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgAZFQ+XgMGXW9E6IU4dmDY/9c4V2z+tHb6FuKEOPj48ZQJrIGS5BDXrBt0EAtuJY9hugyEwVBTcp1LUL0dbVbycHHItvMx7SvagmbGK94AN0MaNqqbNN/9hAmeBTaQDBuxZKgUa3UOK1AoYZN9+7fRVtz8ugGEHhOXbzFkN/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=brm6ueQL reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dvtbv2DpKz1Fg8d;
	Mon, 19 Jan 2026 15:47:55 +0100 (CET)
Received: from ludwig.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dvtbt5qFyz1DDgY;
	Mon, 19 Jan 2026 15:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768834075;
	bh=j4yDMOEg6XIfZw3APHo4V+HY8OEIMSKNw1iXWOzBq3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=brm6ueQLAocf6FouHpxZlQgnQDWYvaeouWO9eEQ70JRG77w7l1n4+W62OXQqy84Sf
	 ssOfxuzrMVGPRaH2YWMZ1b159XVDh1VkLMjA5qqLqOEN2kloPxwWo1/O9g5wK4a42t
	 f52YT3qnjdPw/5vZUH4dkHHWYN3s8MXHrlbjRQK6Q1H+aDcV2gRQj5epFVCciVwFEb
	 RB5HbvpHZL8rcW4fLrnHjaXy37Hseqdcc5gqF6Jfn/YH2RowtLUaijvonGyYHJEria
	 XAfEZlodMVwiFSWjR//bQAk0MMM3vS/8uk8J4jUmZAww1lOmbWJg0IYYz3TQTlO1hA
	 4s8L8Z3NIgm4A==
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	brauner@kernel.org,
	shuah@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	glaubitz@physik.fu-berlin.de,
	geert@linux-m68k.org,
	schuster.simon@siemens-energy.com,
	jrtc27@jrtc27.com
Subject: [PATCH v2 2/2] sparc: Add architecture support for clone3
Date: Mon, 19 Jan 2026 15:47:53 +0100
Message-Id: <20260119144753.27945-3-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
References: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the clone3 system call to the SPARC architectures.

The implementation follows the pattern of the original clone syscall.
However, instead of explicitly calling kernel_clone, the clone3
handler calls the generic sys_clone3 handler in kernel/fork.
In case no stack is provided, the parents stack is reused.

The return value convention for clone3 follows the regular kernel return
value convention (in contrast to the original clone/fork on SPARC).

Closes: https://github.com/sparclinux/issues/issues/10
Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 arch/sparc/include/asm/syscalls.h      |  1 +
 arch/sparc/include/asm/unistd.h        |  2 --
 arch/sparc/kernel/entry.S              | 15 ++++++++++++++
 arch/sparc/kernel/kernel.h             |  1 +
 arch/sparc/kernel/process.c            | 14 +++++++++++++
 arch/sparc/kernel/process_32.c         | 23 ++++++++++++++++------
 arch/sparc/kernel/process_64.c         | 27 ++++++++++++++++++++------
 arch/sparc/kernel/syscalls.S           |  8 ++++++++
 arch/sparc/kernel/syscalls/syscall.tbl |  2 +-
 9 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/include/asm/syscalls.h b/arch/sparc/include/asm/syscalls.h
index 35575fbfb9dc..282e62b66518 100644
--- a/arch/sparc/include/asm/syscalls.h
+++ b/arch/sparc/include/asm/syscalls.h
@@ -7,5 +7,6 @@ struct pt_regs;
 asmlinkage long sparc_fork(struct pt_regs *regs);
 asmlinkage long sparc_vfork(struct pt_regs *regs);
 asmlinkage long sparc_clone(struct pt_regs *regs);
+asmlinkage long sparc_clone3(struct pt_regs *regs);
 
 #endif /* _SPARC64_SYSCALLS_H */
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 3380411a4537..d6bc76706a7a 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -49,8 +49,6 @@
 #define __ARCH_WANT_COMPAT_STAT
 #endif
 
-#define __ARCH_BROKEN_SYS_CLONE3
-
 #ifdef __32bit_syscall_numbers__
 /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
  * it never had the plain ones and there is no value to adding those
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index a3fdee4cd6fa..ea51ef52c952 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -907,6 +907,21 @@ flush_patch_four:
 	jmpl	%l1 + %lo(sparc_vfork), %g0
 	 add	%sp, STACKFRAME_SZ, %o0
 
+	.globl	__sys_clone3, flush_patch_five
+__sys_clone3:
+	mov	%o7, %l5
+flush_patch_five:
+	FLUSH_ALL_KERNEL_WINDOWS;
+	ld	[%curptr + TI_TASK], %o4
+	rd	%psr, %g4
+	WRITE_PAUSE
+	rd	%wim, %g5
+	WRITE_PAUSE
+	std	%g4, [%o4 + AOFF_task_thread + AOFF_thread_fork_kpsr]
+	add	%sp, STACKFRAME_SZ, %o0
+	call	sparc_clone3
+	 mov	%l5, %o7
+
         .align  4
 linux_sparc_ni_syscall:
 	sethi   %hi(sys_ni_syscall), %l7
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 8328a3b78a44..4ee85051521a 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -18,6 +18,7 @@ extern int ncpus_probed;
 asmlinkage long sparc_clone(struct pt_regs *regs);
 asmlinkage long sparc_fork(struct pt_regs *regs);
 asmlinkage long sparc_vfork(struct pt_regs *regs);
+asmlinkage long sparc_clone3(struct pt_regs *regs);
 
 #ifdef CONFIG_SPARC64
 /* setup_64.c */
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index 7d69877511fa..d72fa0665943 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -12,6 +12,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/signal.h>
+#include <linux/syscalls.h>
 
 #include "kernel.h"
 
@@ -118,3 +119,16 @@ asmlinkage long sparc_clone(struct pt_regs *regs)
 
 	return ret;
 }
+
+asmlinkage long sparc_clone3(struct pt_regs *regs)
+{
+	unsigned long sz;
+	struct clone_args __user *cl_args;
+
+	synchronize_user_stack();
+
+	cl_args = (struct clone_args __user *)regs->u_regs[UREG_I0];
+	sz = regs->u_regs[UREG_I1];
+
+	return sys_clone3(cl_args, sz);
+}
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 5a28c0e91bf1..dd8c6c02b0f1 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -247,6 +247,8 @@ clone_stackframe(struct sparc_stackf __user *dst,
  * Parent -->  %o0 == childs  pid, %o1 == 0
  * Child  -->  %o0 == parents pid, %o1 == 1
  *
+ * clone3() - Uses regular kernel return value conventions
+ *
  * NOTE: We have a separate fork kpsr/kwim because
  *       the parent could change these values between
  *       sys_fork invocation and when we reach here
@@ -261,11 +263,11 @@ extern void ret_from_kernel_thread(void);
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	u64 clone_flags = args->flags;
-	unsigned long sp = args->stack;
 	unsigned long tls = args->tls;
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	char *new_stack;
+	unsigned long sp = args->stack ? args->stack : regs->u_regs[UREG_FP];
 
 #ifndef CONFIG_SMP
 	if(last_task_used_math == current) {
@@ -350,13 +352,22 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	childregs->psr &= ~PSR_EF;
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
 #endif
+	/* Handle return value conventions */
+	if (regs->u_regs[UREG_G1] == __NR_clone3) {
+		/* clone3() - use regular kernel return value convention */
+
+		/* Set the return value for the child. */
+		childregs->u_regs[UREG_I0] = 0;
+	} else {
+		/* clone()/fork() - use SunOS return value convention */
 
-	/* Set the return value for the child. */
-	childregs->u_regs[UREG_I0] = current->pid;
-	childregs->u_regs[UREG_I1] = 1;
+		/* Set the return value for the child. */
+		childregs->u_regs[UREG_I0] = current->pid;
+		childregs->u_regs[UREG_I1] = 1;
 
-	/* Set the return value for the parent. */
-	regs->u_regs[UREG_I1] = 0;
+		/* Set the return value for the parent. */
+		regs->u_regs[UREG_I1] = 0;
+	}
 
 	if (clone_flags & CLONE_SETTLS)
 		childregs->u_regs[UREG_G7] = tls;
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 25781923788a..e889da8e4835 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -564,17 +564,19 @@ void fault_in_user_windows(struct pt_regs *regs)
  * under SunOS are nothing short of bletcherous:
  * Parent -->  %o0 == childs  pid, %o1 == 0
  * Child  -->  %o0 == parents pid, %o1 == 1
+ *
+ * clone3() - Uses regular kernel return value conventions
  */
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	u64 clone_flags = args->flags;
-	unsigned long sp = args->stack;
 	unsigned long tls = args->tls;
 	struct thread_info *t = task_thread_info(p);
 	struct pt_regs *regs = current_pt_regs();
 	struct sparc_stackf *parent_sf;
 	unsigned long child_stack_sz;
 	char *child_trap_frame;
+	unsigned long sp = args->stack ? args->stack : regs->u_regs[UREG_FP];
 
 	/* Calculate offset to stack_frame & pt_regs */
 	child_stack_sz = (STACKFRAME_SZ + TRACEREG_SZ);
@@ -616,12 +618,25 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (t->utraps)
 		t->utraps[0]++;
 
-	/* Set the return value for the child. */
-	t->kregs->u_regs[UREG_I0] = current->pid;
-	t->kregs->u_regs[UREG_I1] = 1;
+	/* Handle return value conventions */
+	if (regs->u_regs[UREG_G1] == __NR_clone3) {
+		/* clone3() - use regular kernel return value convention */
+
+		/* Set the return value for the child. */
+		t->kregs->u_regs[UREG_I0] = 0;
+
+		/* Clear g1 to indicate user thread */
+		t->kregs->u_regs[UREG_G1] = 0;
+	} else {
+		/* clone()/fork() - use SunOS return value convention */
+
+		/* Set the return value for the child. */
+		t->kregs->u_regs[UREG_I0] = current->pid;
+		t->kregs->u_regs[UREG_I1] = 1;
 
-	/* Set the second return value for the parent. */
-	regs->u_regs[UREG_I1] = 0;
+		/* Set the second return value for the parent. */
+		regs->u_regs[UREG_I1] = 0;
+	}
 
 	if (clone_flags & CLONE_SETTLS)
 		t->kregs->u_regs[UREG_G7] = tls;
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 0e8ab0602c36..96fe8763d70c 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -103,6 +103,12 @@ sys_clone:
 	ba,pt	%xcc, sparc_clone
 	 add	%sp, PTREGS_OFF, %o0
 
+	.align	32
+__sys_clone3:
+	flushw
+	ba,pt	%xcc, sparc_clone3
+	 add	%sp, PTREGS_OFF, %o0
+
 	.globl	ret_from_fork
 ret_from_fork:
 	/* Clear current_thread_info()->new_child. */
@@ -113,6 +119,8 @@ ret_from_fork:
 	brnz,pt	%o0, ret_sys_call
 	 ldx	[%g6 + TI_FLAGS], %l0
 	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %l1
+	brz,pt	%l1, ret_sys_call
+	 nop
 	call	%l1
 	 ldx	[%sp + PTREGS_OFF + PT_V9_G2], %o0
 	ba,pt	%xcc, ret_sys_call
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 39aa26b6a50b..c0307bb09892 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -480,7 +480,7 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
-# 435 reserved for clone3
+435	common	clone3				__sys_clone3
 436	common	close_range			sys_close_range
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
-- 
2.35.3


