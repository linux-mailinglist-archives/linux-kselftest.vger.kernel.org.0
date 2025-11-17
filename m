Return-Path: <linux-kselftest+bounces-45740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE52C6466C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 985D0368564
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F953321D6;
	Mon, 17 Nov 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QJi33dP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB2320CCF;
	Mon, 17 Nov 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386277; cv=none; b=WEEy/orqn0q4F/b0tzrMWxtX8JDPjWzMc2QzPwtONS75Xw+SGh7t14yAojHcipQOoyL3gXAieeQtG5rYwAtjwJb7KtNWxSD1m+qRA29+IRHyIonjLcYeDJoX9Ceq+FBW9rOVJyrbgFzhjvqLECBDazL7w6qlmsfamXjbM5jon6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386277; c=relaxed/simple;
	bh=VdHvdR9xYKjIdNBbC8/KNtwOCuoWMLN2B+4bji7I5b4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS5Iwx6hHSyLZxIJbJk+f3mw7aC2Zxl6QwLltNG1Jal0PZPvrbt3eNeiw8NZHw/e6rUYce+J3xa3B1UrLvVZY1kDi8yixK9hLmASvVoYTpYU70dTkr73Oq1ISaC1ur7s1kzsc+5ifccc2rFCeP9502byALFUcaI0L9ANVBDIPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QJi33dP6; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TWXjlJ8Nf+o3OCawdZWYtmIL00hhY0BSagg28LmBWeY=;
	b=QJi33dP6IdSUigK10KKiBgdpbvdf1SKYXQuIPBmCCYEmiTxXcB5fSHcODD1YZgf+6UyICoqri
	nW0BJTJqctFPuR5QZpN02I7WG9GVzrAp1obQxhky2HCtnImh/jYM1ZfJHLB16YlwNr7kOAZhLjC
	KuPnJTZka72Fe5DjllMqeJc=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d97rf3TXXz12Lgl;
	Mon, 17 Nov 2025 21:29:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BAC6180471;
	Mon, 17 Nov 2025 21:31:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <ldv@strace.io>, <macro@orcam.me.uk>,
	<deller@gmx.de>, <mark.rutland@arm.com>, <song@kernel.org>, <mbenes@suse.cz>,
	<ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <kevin.brodsky@arm.com>,
	<pengcan@kylinos.cn>, <dvyukov@google.com>, <kmal@cock.li>,
	<lihongbo22@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v7 01/11] arm64/ptrace: Split report_syscall()
Date: Mon, 17 Nov 2025 21:30:38 +0800
Message-ID: <20251117133048.53182-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117133048.53182-1-ruanjinjie@huawei.com>
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4b001121c72d..5534c175ceb7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2317,7 +2317,7 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
+static void report_syscall_enter(struct pt_regs *regs)
 {
 	int regno;
 	unsigned long saved_reg;
@@ -2340,13 +2340,24 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 	 */
 	regno = (is_compat_task() ? 12 : 7);
 	saved_reg = regs->regs[regno];
-	regs->regs[regno] = dir;
+	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
 
-	if (dir == PTRACE_SYSCALL_ENTER) {
-		if (ptrace_report_syscall_entry(regs))
-			forget_syscall(regs);
-		regs->regs[regno] = saved_reg;
-	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
+	if (ptrace_report_syscall_entry(regs))
+		forget_syscall(regs);
+	regs->regs[regno] = saved_reg;
+}
+
+static void report_syscall_exit(struct pt_regs *regs)
+{
+	int regno;
+	unsigned long saved_reg;
+
+	/* See comment for report_syscall_enter() above */
+	regno = (is_compat_task() ? 12 : 7);
+	saved_reg = regs->regs[regno];
+	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
+
+	if (!test_thread_flag(TIF_SINGLESTEP)) {
 		ptrace_report_syscall_exit(regs, 0);
 		regs->regs[regno] = saved_reg;
 	} else {
@@ -2366,7 +2377,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	unsigned long flags = read_thread_flags();
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		report_syscall(regs, PTRACE_SYSCALL_ENTER);
+		report_syscall_enter(regs);
 		if (flags & _TIF_SYSCALL_EMU)
 			return NO_SYSCALL;
 	}
@@ -2394,7 +2405,7 @@ void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
-		report_syscall(regs, PTRACE_SYSCALL_EXIT);
+		report_syscall_exit(regs);
 
 	rseq_syscall(regs);
 }
-- 
2.34.1


