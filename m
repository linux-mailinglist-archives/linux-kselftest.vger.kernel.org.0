Return-Path: <linux-kselftest+bounces-45741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FFC6469F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12AF136894F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF5333432;
	Mon, 17 Nov 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IQFXTe/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6A31B81D;
	Mon, 17 Nov 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386279; cv=none; b=cx3V3TvxF9neCbe2AaoD6k/RkZ4vXG43Bfz9+/6XhMnu9y1XamI5KAfFQYK3RNd2XV9FokEWOBD0CkkrQhflWQumBGeTiQa3n7HacmnVlq+tJrS/MDF9KW832c68shw5XeHX6iJK9OVwTodFZlElZfY0MvtCxSLBjJOdUMeLls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386279; c=relaxed/simple;
	bh=rzcXOSEPfyqUemKA1OR69/JDsy29iHr/9zm+iqt5GGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnW5tI5l5l1VvyS5NheNFsY3lxtlfPsLxHArcxHwUfAtV8qlheetHSIM9KjQVpwL0n1Ua62qdQqRV6PcOWqX46IArqhCa7SJkuV4qCQSAJixhZtWFHQ53L1l1pl9p9ZLtPlfmInwN4ZYR8Kkeo5vC+IA3yUuy6vw1t8iq9xcilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IQFXTe/2; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Po+J9ChiWqTu8ODR4zmOg9Leefa4MaCMclJAtu9oQJk=;
	b=IQFXTe/2IhYr6mwfB/HHz/SgGIcZ96Yh6HjGbc+AlSHb4a5exnH9p+vPR4QxGecINrFfDwA2h
	q7fBbN85IVMLd4lqYwXSxVb6ruoXeP3ytNdynNghbe9aeVgFZ0nx7viLqaTfhlra1qzFWzR/sBa
	J3jW8HZ2mI0FqSUvs9CN2Ew=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d97rR3W2Pz1K98x;
	Mon, 17 Nov 2025 21:29:27 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BEB91A0188;
	Mon, 17 Nov 2025 21:31:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:07 +0800
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
Subject: [PATCH v7 02/11] arm64/ptrace: Refactor syscall_trace_enter/exit()
Date: Mon, 17 Nov 2025 21:30:39 +0800
Message-ID: <20251117133048.53182-3-ruanjinjie@huawei.com>
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

The generic syscall entry code has the following form, which use
the input syscall work flag and syscall number:

| syscall_trace_enter(struct pt_regs *regs, long syscall,
|		      unsigned long work)
|
| syscall_exit_work(struct pt_regs *regs, unsigned long work)

In preparation for moving arm64 over to the generic entry code,
refactor syscall_trace_enter/exit() to also pass thread flags, and
get syscall number by syscall_get_nr() helper.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h |  4 ++--
 arch/arm64/kernel/ptrace.c       | 24 +++++++++++++++---------
 arch/arm64/kernel/syscall.c      |  5 +++--
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 712daa90e643..d69f590a989b 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -114,7 +114,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
-void syscall_trace_exit(struct pt_regs *regs);
+int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
+void syscall_trace_exit(struct pt_regs *regs, unsigned long flags);
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5534c175ceb7..bbb868f6b292 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2372,10 +2372,8 @@ static void report_syscall_exit(struct pt_regs *regs)
 	}
 }
 
-int syscall_trace_enter(struct pt_regs *regs)
+int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 {
-	unsigned long flags = read_thread_flags();
-
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		report_syscall_enter(regs);
 		if (flags & _TIF_SYSCALL_EMU)
@@ -2386,19 +2384,27 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (secure_computing() == -1)
 		return NO_SYSCALL;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, regs->syscallno);
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
+		trace_sys_enter(regs, syscall);
 
-	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		 syscall = syscall_get_nr(current, regs);
+	}
+
+	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
 			    regs->regs[2], regs->regs[3]);
 
 	return regs->syscallno;
 }
 
-void syscall_trace_exit(struct pt_regs *regs)
+void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
-	unsigned long flags = read_thread_flags();
-
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index aba7ca6bca2d..6e3fe760e0bb 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -124,7 +124,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 */
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
-		scno = syscall_trace_enter(regs);
+		scno = syscall_trace_enter(regs, regs->syscallno, flags);
 		if (scno == NO_SYSCALL)
 			goto trace_exit;
 	}
@@ -143,7 +143,8 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	}
 
 trace_exit:
-	syscall_trace_exit(regs);
+	flags = read_thread_flags();
+	syscall_trace_exit(regs, flags);
 }
 
 void do_el0_svc(struct pt_regs *regs)
-- 
2.34.1


