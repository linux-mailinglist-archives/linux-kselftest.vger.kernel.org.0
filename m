Return-Path: <linux-kselftest+bounces-46988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247FCA2CA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B20263049D3F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBCC335556;
	Thu,  4 Dec 2025 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DNTaOv6m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD57334C2F;
	Thu,  4 Dec 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836525; cv=none; b=q/FuWFlTq4i96kUYrq3NLgjbw4LRac/lnPCbCIqOzcSv4eB8SA+WYBbj5DnLESV8CE965g9HTn+hM+Db43+jPAJSzmdJN2naIQcoiVyfWublNbOOAEpyMW+s5ZQX/3zlE9BE6mtCpAUetjrWdy6GkIZb3ZcJTh8+s99MjSkv0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836525; c=relaxed/simple;
	bh=ZSNSkCU9KEQ8ALUoHuoEemQ6ajhmopB3CzvJ3m+qUcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YI4X2l8OIJlCGwh7uDdr+P80MN4NWF/lMXx9RBn9stCr9cooFoyUOffdVG9P1HzqKglzueJIbmDdO6GR4X+CFG/HoP5nHB0+Pn2Os/Ij6GnpsvNC/s3PFaAMk9x3UN44QzyZEus8kSG3/ufPst16ai/7eWnMbM87AYvLIcfvLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DNTaOv6m; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XDHekllvIQgL4zfUF3t89noCrQO9MFYGDgryhlGiFZQ=;
	b=DNTaOv6mS2sUaYm7C5IVOY0NUeMPi3kkwqwLVkn2n5J+J+EcIRPOJbdxqvoqOwIsvUQFbdxY9
	4zNZrohuy4sT56m4+QLhW175tLtQg8ADwG5DJKp7quubtNCAYtLCo5vJ2+Kz4GfKw3AhQzpOLtB
	YupSXj5uQtB0xpyRC/dyzs0=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dMS8z3gGCzcb1P;
	Thu,  4 Dec 2025 16:19:31 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 20B96180B60;
	Thu,  4 Dec 2025 16:22:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:59 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>, <deller@gmx.de>,
	<macro@orcam.me.uk>, <charlie@rivosinc.com>, <kevin.brodsky@arm.com>,
	<ldv@strace.io>, <mark.rutland@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v9 15/16] entry: Inline syscall_exit_work()
Date: Thu, 4 Dec 2025 16:21:22 +0800
Message-ID: <20251204082123.2792067-16-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204082123.2792067-1-ruanjinjie@huawei.com>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

After switch arm64 to Generic Entry, a new hotspot syscall_exit_work()
appeared because syscall_exit_work() is no longer inlined. so inline
syscall_exit_work(), and it has 2.6% performance uplift on perf bench
basic syscall on kunpeng920 as below.

    | Metric     | W/O this patch | With this patch | Change    |
    | ---------- | -------------- | --------------- | --------- |
    | Total time | 2.171 [sec]    | 2.114 [sec]     |  ↓2.6%    |
    | usecs/op   | 0.217192       | 0.211453        |  ↓2.6%    |
    | ops/sec    | 4,604,225      | 4,729,178       |  ↑2.7%    |

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/entry-common.h  | 63 ++++++++++++++++++++++++++++++++++-
 kernel/entry/syscall-common.c | 59 ++------------------------------
 2 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index cd6dacb2d8bf..2f84377fb016 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
+#include <linux/audit.h>
 #include <linux/irq-entry-common.h>
 #include <linux/ptrace.h>
 #include <linux/seccomp.h>
@@ -128,6 +129,41 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
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
+/**
+ * arch_ptrace_report_syscall_exit - Architecture specific
+ *				     ptrace_report_syscall_exit.
+ *
+ * Invoked from syscall_exit_work() to wrap ptrace_report_syscall_exit().
+ *
+ * The main purpose is to support arch-specific ptrace_report_syscall_exit
+ * implementation.
+ */
+static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
+							    int step);
+
+#ifndef arch_ptrace_report_syscall_exit
+static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
+							    int step)
+{
+	ptrace_report_syscall_exit(regs, step);
+}
+#endif
+
+void __trace_sys_exit(struct pt_regs *regs, long ret);
+
 /**
  * syscall_exit_work - Handle work before returning to user mode
  * @regs:	Pointer to current pt_regs
@@ -135,7 +171,32 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
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
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 27310e611567..1636f49c58d2 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -90,62 +90,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
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
-/**
- * arch_ptrace_report_syscall_exit - Architecture specific
- *				     ptrace_report_syscall_exit.
- *
- * Invoked from syscall_exit_work() to wrap ptrace_report_syscall_exit().
- *
- * The main purpose is to support arch-specific ptrace_report_syscall_exit
- * implementation.
- */
-static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
-							    int step);
-
-#ifndef arch_ptrace_report_syscall_exit
-static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
-							    int step)
+void __trace_sys_exit(struct pt_regs *regs, long ret)
 {
-	ptrace_report_syscall_exit(regs, step);
-}
-#endif
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
-- 
2.34.1


