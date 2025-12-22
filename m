Return-Path: <linux-kselftest+bounces-47841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 715FFCD5DDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F93D301F3DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F87324B23;
	Mon, 22 Dec 2025 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oEp9Ug2a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10D32B9AC;
	Mon, 22 Dec 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404126; cv=none; b=PN/oYfMn+d/swxW7W3MfEhgfHJzjGAaInoqF9K2fxE2Bu5ZwqvMbt8UL8rrxN+xV8TkDQj+Xe8NR2q0fL2yDxQ632/YXXDMx4N3V7wWX0P9oN5v8h90/QRSRTKjrYisb5pRlB1Uq9fwngFymdZ6A/ro2pJn/PavoiWyzccTb1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404126; c=relaxed/simple;
	bh=Uwx4KJhyIRX+0FKJqrEw/iuBXDmfw0YMxs+D9x/Ewbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPyTJ3sIqB4N1qe7yFCJyQtBL0j9Dc0Ugpm17ZwEufrW10l6CS0vKiL4pgc2nmTcUm/heupi5spVbsRqOzK7AuYrUVpDZoX4TXD7h+IYn1ynwqdOi7OrpSR8i3wPI+jLxPcU9V2UIemFxu5AEyqeP74JylMVxxQO7vjiXmgppTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oEp9Ug2a; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aJTiI4bA0T86T+t5tkcGj308AfemJUXr12sJGCUKjxE=;
	b=oEp9Ug2akzL8mvTBxZckK/2AGC0mDTS0+1Yg50bxXbJZZwf0Kofh8opHytIvDbFFE0fTZ+mKg
	91HGNx00zKxlBUuyoTwgobQs1gtHw90gQ6xi/9B+Xo0yzM6Q7KVc1VBm39OwekhahuHXm0g22Vv
	pnooENZI9QBWUtKykiVbRXQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dZbtK16znzRhWS;
	Mon, 22 Dec 2025 19:45:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BC574036C;
	Mon, 22 Dec 2025 19:48:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <kevin.brodsky@arm.com>, <macro@orcam.me.uk>,
	<charlie@rivosinc.com>, <akpm@linux-foundation.org>, <ldv@strace.io>,
	<anshuman.khandual@arm.com>, <mark.rutland@arm.com>, <thuth@redhat.com>,
	<song@kernel.org>, <ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <liqiang01@kylinos.cn>, <pengcan@kylinos.cn>,
	<kmal@cock.li>, <dvyukov@google.com>, <richard.weiyang@gmail.com>,
	<reddybalavignesh9979@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v10 15/16] entry: Inline syscall_exit_work() and syscall_trace_enter()
Date: Mon, 22 Dec 2025 19:47:36 +0800
Message-ID: <20251222114737.1334364-16-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114737.1334364-1-ruanjinjie@huawei.com>
References: <20251222114737.1334364-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

After switch arm64 to Generic Entry, a new hotspot syscall_exit_work()
appeared because syscall_exit_work() is not inlined, so inline
syscall_exit_work(). Also inline syscall_trace_enter() to align with
syscall_exit_work().

On v6.19-rc1 with audit on, inline both syscall_trace_enter() and
syscall_exit_work() has 4% performance uplift on perf bench basic
syscall on kunpeng920 as below:

    | Metric     | W/O this patch | With this patch | Change  |
    | ---------- | -------------- | --------------- | ------  |
    | Total time | 2.353 [sec]    | 2.264 [sec]     |  ↓3.8%  |
    | usecs/op   | 0.235374       | 0.226472        |  ↓3.8%  |
    | ops/sec    | 4,248,588      | 4,415,554       |  ↑3.9%  |

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/entry-common.h         | 102 ++++++++++++++++++++++++++-
 kernel/entry/common.h                |   7 --
 kernel/entry/syscall-common.c        |  96 ++-----------------------
 kernel/entry/syscall_user_dispatch.c |   4 +-
 4 files changed, 106 insertions(+), 103 deletions(-)
 delete mode 100644 kernel/entry/common.h

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 17171e8873fc..ad61a13bf24f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
+#include <linux/audit.h>
 #include <linux/irq-entry-common.h>
 #include <linux/livepatch.h>
 #include <linux/ptrace.h>
@@ -64,7 +65,64 @@ static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs
 }
 #endif
 
-long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long work);
+static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
+void __trace_sys_enter(struct pt_regs *regs, long syscall);
+bool syscall_user_dispatch(struct pt_regs *regs);
+
+static __always_inline long syscall_trace_enter(struct pt_regs *regs, long syscall,
+						unsigned long work)
+{
+	long ret = 0;
+
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return -1L;
+	}
+
+	/* Handle ptrace */
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		ret = arch_ptrace_report_syscall_entry(regs);
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+			return -1L;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (work & SYSCALL_WORK_SECCOMP) {
+		ret = __secure_computing();
+		if (ret == -1L)
+			return ret;
+	}
+
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
+		__trace_sys_enter(regs, syscall);
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		syscall = syscall_get_nr(current, regs);
+	}
+
+	syscall_enter_audit(regs, syscall);
+
+	return ret ? : syscall;
+}
 
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
@@ -131,6 +189,19 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
 	return ret;
 }
 
+/*
+ * If SYSCALL_EMU is set, then the only reason to report is when
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_user_mode().
+ */
+static __always_inline bool report_single_step(unsigned long work)
+{
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
+		return false;
+
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
+}
+
 /**
  * arch_ptrace_report_syscall_exit - Architecture specific
  *				     ptrace_report_syscall_exit.
@@ -151,6 +222,8 @@ static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs
 }
 #endif
 
+void __trace_sys_exit(struct pt_regs *regs, long ret);
+
 /**
  * syscall_exit_work - Handle work before returning to user mode
  * @regs:	Pointer to current pt_regs
@@ -158,7 +231,32 @@ static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs
  *
  * Do one-time syscall specific work.
  */
-void syscall_exit_work(struct pt_regs *regs, unsigned long work);
+static __always_inline void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+{
+	bool step;
+
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch = false;
+			return;
+		}
+	}
+
+	audit_syscall_exit(regs);
+
+	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
+		__trace_sys_exit(regs, syscall_get_return_value(current, regs));
+
+	step = report_single_step(work);
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
+		arch_ptrace_report_syscall_exit(regs, step);
+}
 
 /*
  * Syscall specific exit to user mode preparation. Runs with interrupts
diff --git a/kernel/entry/common.h b/kernel/entry/common.h
deleted file mode 100644
index f6e6d02f07fe..000000000000
--- a/kernel/entry/common.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _COMMON_H
-#define _COMMON_H
-
-bool syscall_user_dispatch(struct pt_regs *regs);
-
-#endif
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index fe38f84dfff3..10231d30405e 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -1,104 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/audit.h>
 #include <linux/entry-common.h>
-#include "common.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+void __trace_sys_enter(struct pt_regs *regs, long syscall)
 {
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
+	trace_sys_enter(regs, syscall);
 }
 
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
+void __trace_sys_exit(struct pt_regs *regs, long ret)
 {
-	long ret = 0;
-
-	/*
-	 * Handle Syscall User Dispatch.  This must comes first, since
-	 * the ABI here can be something that doesn't make sense for
-	 * other syscall_work features.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (syscall_user_dispatch(regs))
-			return -1L;
-	}
-
-	/* Handle ptrace */
-	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret = arch_ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
-			return -1L;
-	}
-
-	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (work & SYSCALL_WORK_SECCOMP) {
-		ret = __secure_computing();
-		if (ret == -1L)
-			return ret;
-	}
-
-	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
-
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
-		trace_sys_enter(regs, syscall);
-		/*
-		 * Probes or BPF hooks in the tracepoint may have changed the
-		 * system call number as well.
-		 */
-		syscall = syscall_get_nr(current, regs);
-	}
-
-	syscall_enter_audit(regs, syscall);
-
-	return ret ? : syscall;
-}
-
-/*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
- */
-static inline bool report_single_step(unsigned long work)
-{
-	if (work & SYSCALL_WORK_SYSCALL_EMU)
-		return false;
-
-	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
-}
-
-void syscall_exit_work(struct pt_regs *regs, unsigned long work)
-{
-	bool step;
-
-	/*
-	 * If the syscall was rolled back due to syscall user dispatching,
-	 * then the tracers below are not invoked for the same reason as
-	 * the entry side was not invoked in syscall_trace_enter(): The ABI
-	 * of these syscalls is unknown.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (unlikely(current->syscall_dispatch.on_dispatch)) {
-			current->syscall_dispatch.on_dispatch = false;
-			return;
-		}
-	}
-
-	audit_syscall_exit(regs);
-
-	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	step = report_single_step(work);
-	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		arch_ptrace_report_syscall_exit(regs, step);
+	trace_sys_exit(regs, ret);
 }
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index a9055eccb27e..d89dffcc2d64 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (C) 2020 Collabora Ltd.
  */
+
+#include <linux/entry-common.h>
 #include <linux/sched.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
@@ -15,8 +17,6 @@
 
 #include <asm/syscall.h>
 
-#include "common.h"
-
 static void trigger_sigsys(struct pt_regs *regs)
 {
 	struct kernel_siginfo info;
-- 
2.34.1


