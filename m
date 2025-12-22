Return-Path: <linux-kselftest+bounces-47829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E31CD5DAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D28F2301F3D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2231B833;
	Mon, 22 Dec 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HZ4lPPx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906231BC8D;
	Mon, 22 Dec 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404105; cv=none; b=HZS93rn6QvjyvOBX3Z70bI1nIyElpIF+6Yr5z7oy9EuTpx1XtnkXev+mKz/2GBjsVLKLUIzxVBtamdo8Ku23GbQG7t5Cl6TLUSl1a7o04882CATe8Kk0RFwgs7+bpkJITSUWFumh/rNvnWNbeyrvSBjfH2MsvIC21tdzoViJa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404105; c=relaxed/simple;
	bh=5Gst5SGXok/LST2YUfZIoAf1TaixhCb8CPojSfHFHE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UucCNX6f2WcqHGcFL6xXyCJw8iEnGNIrx/6q3HlVHC+w6hoyPZFCWhH1p+EaugWnmb9/pD+dYzynpX6klQE+vdnNh4QPen3fkteYCgwEa7dPH2m7HdE1WjFOEdu1QguJ1bckZL2EL5CB3G+RxR/A9Ug30qt+DUtn3hQP5WMHg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HZ4lPPx/; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pxgQLkj0Z7hHoCYhNOLJqMr8LObp/tqs2Sovd+PzMtM=;
	b=HZ4lPPx/CfznsSIiZbI4KOTlDMzG0Ifg+iz13CW2kG+nAG431Zbip88e1rRIb+2HC8IjU50G3
	X1jg48Xhr/ISGsb362U31wZE90tnAehSfEXzVRUxoRBTazwy7jL065zbHffkTLPZ5+l8g570ZYO
	6RARnmpAdtWv/7sJLSZrpXE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dZbsx3jRnzLlTC;
	Mon, 22 Dec 2025 19:45:09 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DF7A40565;
	Mon, 22 Dec 2025 19:48:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:13 +0800
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
Subject: [PATCH v10 02/16] arm64/ptrace: Split report_syscall()
Date: Mon, 22 Dec 2025 19:47:23 +0800
Message-ID: <20251222114737.1334364-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114737.1334364-1-ruanjinjie@huawei.com>
References: <20251222114737.1334364-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The generic syscall entry code has the form:

| syscall_trace_enter()
| {
|	ptrace_report_syscall_entry()
| }
|
| syscall_exit_work()
| {
|	ptrace_report_syscall_exit()
| }

In preparation for moving arm64 over to the generic entry code, split
report_syscall() to two separate enter and exit functions to align
the structure of the arm64 code with syscall_trace_enter() and
syscall_exit_work() from the generic entry code.

No functional changes.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v8:
- report_syscall_enter() -> report_syscall_entry().
- Add ptrace_save_reg() helper.
---
 arch/arm64/kernel/ptrace.c | 41 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b9bdd83fbbca..03fe2f8a4d54 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2343,9 +2343,10 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
+static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
+						     enum ptrace_syscall_dir dir,
+						     int *regno)
 {
-	int regno;
 	unsigned long saved_reg;
 
 	/*
@@ -2364,15 +2365,31 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 	 * - Syscall stops behave differently to seccomp and pseudo-step traps
 	 *   (the latter do not nobble any registers).
 	 */
-	regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[regno];
-	regs->regs[regno] = dir;
+	*regno = (is_compat_task() ? 12 : 7);
+	saved_reg = regs->regs[*regno];
+	regs->regs[*regno] = dir;
 
-	if (dir == PTRACE_SYSCALL_ENTER) {
-		if (ptrace_report_syscall_entry(regs))
-			forget_syscall(regs);
-		regs->regs[regno] = saved_reg;
-	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
+	return saved_reg;
+}
+
+static void report_syscall_entry(struct pt_regs *regs)
+{
+	unsigned long saved_reg;
+	int regno;
+
+	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
+	if (ptrace_report_syscall_entry(regs))
+		forget_syscall(regs);
+	regs->regs[regno] = saved_reg;
+}
+
+static void report_syscall_exit(struct pt_regs *regs)
+{
+	unsigned long saved_reg;
+	int regno;
+
+	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
+	if (!test_thread_flag(TIF_SINGLESTEP)) {
 		ptrace_report_syscall_exit(regs, 0);
 		regs->regs[regno] = saved_reg;
 	} else {
@@ -2392,7 +2409,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	unsigned long flags = read_thread_flags();
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		report_syscall(regs, PTRACE_SYSCALL_ENTER);
+		report_syscall_entry(regs);
 		if (flags & _TIF_SYSCALL_EMU)
 			return NO_SYSCALL;
 	}
@@ -2420,7 +2437,7 @@ void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
-		report_syscall(regs, PTRACE_SYSCALL_EXIT);
+		report_syscall_exit(regs);
 
 	rseq_syscall(regs);
 }
-- 
2.34.1


