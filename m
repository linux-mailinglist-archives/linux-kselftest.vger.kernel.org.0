Return-Path: <linux-kselftest+bounces-49163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C52D33380
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B3BE3025A55
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF033A00C;
	Fri, 16 Jan 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Qdj1nn/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0833A03F;
	Fri, 16 Jan 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577461; cv=none; b=QA2ObTyIoTUh2tVHLTVSQfEesJfd1E3bUIb5Ed7TOg7udcZl1OfgUIXCN4+xtgftVwbBDNjJ2rhoRc8BumEySR0e4yHYXO3BrQuRg3VClQ+rUe09Bw5TVIVcpNa1zOMHp7e+ADuIven52umSNSnvtOPTCYlFByIlmDvkwm1k4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577461; c=relaxed/simple;
	bh=IpZZ8A/8vRhXhWckaz1NwuJhiZ+fEaPg96F8nlsuS2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJ2d/hvx8/YLm/bT9AlFgCSZxZakFkTPJKDAL2MBj7/PyJ6GbQyHvRQiHOMLueCMc/Un1wSM/CRvGB25Kevzoel1pDsjB7TwagmA6IKeu2yqnqc2mIwGPmQ71Vcc4N3I3BRCJVNyAitTAO/jNheol7VW52MB3PfP/SVgB3SOMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Qdj1nn/b reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dt3hr0nRHz1FQVr;
	Fri, 16 Jan 2026 16:30:52 +0100 (CET)
Received: from ludwig.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dt3hq5dslz1DDFM;
	Fri, 16 Jan 2026 16:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768577452;
	bh=4g2nxBOyYfkdzGSQ0inwR35X22JbYjY4qn7TdUVrjIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qdj1nn/b/Qi4pkVeDE3zMn/TjSMs/38o958jz6eojkiSlCGfLFeuCn9ql6XnzJ2SQ
	 9/89I6jOWkzv0igZaMK7bH8aruIToM4IOEMyRdcKYgmtO9UzVPEe2wf8HbIYpVAjkM
	 5fQRbuF0sGAYH6rzmzEFeZ3LGOC5WKLTM/HR20bnp0cpiyKx0P4+vN1UaVYKA6Cy/d
	 sVHeEhv/RpgPPP+JnGKsuyWose8BguuRxBd4dVXJ6u4g3fr3icn1l82nIzT0Bx7Iom
	 KHSXs0yDzYdIwHDegvFo2NcTQRNqOg6cw8L+jyP8y0LpxzYVFVPMzqCAssRYrk7lBL
	 SCer2MFSJa7oQ==
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
	schuster.simon@siemens-energy.com
Subject: [PATCH 2/3] sparc: Add architecture support for clone3
Date: Fri, 16 Jan 2026 16:30:50 +0100
Message-Id: <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
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

The return call conventions for clone on SPARC are kept for clone3:
  Parent -->  %o0 == child's  pid, %o1 == 0
  Child  -->  %o0 == parent's pid, %o1 == 1

Closes: https://github.com/sparclinux/issues/issues/10
Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 arch/sparc/include/asm/syscalls.h      |  1 +
 arch/sparc/include/asm/unistd.h        |  2 --
 arch/sparc/kernel/entry.S              | 15 +++++++++++++++
 arch/sparc/kernel/kernel.h             |  1 +
 arch/sparc/kernel/process.c            | 25 +++++++++++++++++++++++++
 arch/sparc/kernel/process_32.c         |  2 +-
 arch/sparc/kernel/process_64.c         |  2 +-
 arch/sparc/kernel/syscalls.S           |  6 ++++++
 arch/sparc/kernel/syscalls/syscall.tbl |  2 +-
 9 files changed, 51 insertions(+), 5 deletions(-)

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
index 7d69877511fa..b8e23295db69 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -12,6 +12,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/signal.h>
+#include <linux/syscalls.h>
 
 #include "kernel.h"
 
@@ -118,3 +119,27 @@ asmlinkage long sparc_clone(struct pt_regs *regs)
 
 	return ret;
 }
+
+asmlinkage long sparc_clone3(struct pt_regs *regs)
+{
+	unsigned long sz;
+	long ret;
+	struct clone_args __user *cl_args;
+
+	synchronize_user_stack();
+
+	cl_args = (struct clone_args __user *)regs->u_regs[UREG_I0];
+	sz = regs->u_regs[UREG_I1];
+
+	ret = sys_clone3(cl_args, sz);
+
+	/* If we get an error and potentially restart the system
+	 * call, we're screwed because copy_thread() clobbered
+	 * the parent's %o1.  So detect that case and restore it
+	 * here.
+	 */
+	if ((unsigned long)ret >= -ERESTART_RESTARTBLOCK)
+		regs->u_regs[UREG_I1] = sz;
+
+	return ret;
+}
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 5a28c0e91bf1..216c07971c81 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -261,11 +261,11 @@ extern void ret_from_kernel_thread(void);
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
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 25781923788a..885d617ba29d 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -568,13 +568,13 @@ void fault_in_user_windows(struct pt_regs *regs)
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
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 0e8ab0602c36..c8d374a37f98 100644
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


