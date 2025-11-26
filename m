Return-Path: <linux-kselftest+bounces-46473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8CC885D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8A23B50A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1828D82A;
	Wed, 26 Nov 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Lz4Ee3ld"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BB21FF46;
	Wed, 26 Nov 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141303; cv=none; b=thQld0QQAOOmyFdD7MmcTwSaiIVQvkUrgOa53l77pdqIuNEIZaZ9+Fuj4Wm8O8yrI4xSgOJRAouH52V7rNVjGzJ5WuZoe21Bl2Uh6w8fi2X9P8+k9dV0bq3DG7awBnaByDtr1dQ/FmSHNbFAiN8xnzCfM/jsod9FjQCpEPIjXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141303; c=relaxed/simple;
	bh=I+995feiIQlvI5w2DpfXefRJlZ4xjz5o7lg57KdVKxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSB2DHUD+aXGEXiaaysL2DRQKz588bnMcnzqvtNPL5Vfru21HP28OCv+YasICLMFbeczmIYtbU0iyNCkYbIt2Rg6RKYNswnozEjT4JgeAhT3BxaE6m18aoccCKFY2DRmjGoGy4NiaXionqLiXPZq8CEDjYbagxOw8VyGn6AN0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Lz4Ee3ld; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FtKvnxZXZgzObQ4W0owI/iA3ruc5UMsJHnOfm0fb+ao=;
	b=Lz4Ee3ldUBERYkkic7N0aU+DN9IO0pS11twtCQgkoqp8dF8vCz5+7fjuxQlKHyokH7WuMWD9r
	BRmAylsJUVyBOZ73xn+7Gsb25Bu5l2/7UM3f0WGZiEULC0QAJNv13vpc2nvMk97LWJ5UIeitHCS
	SbOnPovP80uiYKpEvd+8h+0=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dGW453jtKz1cyQD;
	Wed, 26 Nov 2025 15:13:09 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id BCE3414011F;
	Wed, 26 Nov 2025 15:14:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Nov
 2025 15:14:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<charlie@rivosinc.com>, <akpm@linux-foundation.org>, <ldv@strace.io>,
	<macro@orcam.me.uk>, <deller@gmx.de>, <mark.rutland@arm.com>,
	<efault@gmx.de>, <song@kernel.org>, <mbenes@suse.cz>, <ryan.roberts@arm.com>,
	<ada.coupriediaz@arm.com>, <anshuman.khandual@arm.com>, <broonie@kernel.org>,
	<kevin.brodsky@arm.com>, <pengcan@kylinos.cn>, <dvyukov@google.com>,
	<kmal@cock.li>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 03/12] arm64/ptrace: Refactor syscall_trace_enter/exit()
Date: Wed, 26 Nov 2025 15:14:37 +0800
Message-ID: <20251126071446.3234218-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126071446.3234218-1-ruanjinjie@huawei.com>
References: <20251126071446.3234218-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
 arch/arm64/kernel/ptrace.c       | 26 ++++++++++++++++----------
 arch/arm64/kernel/syscall.c      |  5 +++--
 3 files changed, 21 insertions(+), 14 deletions(-)

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
index abc5baa29cc9..63ba6c961ecc 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2378,10 +2378,8 @@ static void report_syscall_exit(struct pt_regs *regs)
 	}
 }
 
-int syscall_trace_enter(struct pt_regs *regs)
+int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 {
-	unsigned long flags = read_thread_flags();
-
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		report_syscall_entry(regs);
 		if (flags & _TIF_SYSCALL_EMU)
@@ -2392,19 +2390,27 @@ int syscall_trace_enter(struct pt_regs *regs)
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
 
-	return regs->syscallno;
+	return syscall;
 }
 
-void syscall_trace_exit(struct pt_regs *regs)
+void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
-	unsigned long flags = read_thread_flags();
-
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index aba7ca6bca2d..ec31f82d2e9f 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -124,7 +124,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 */
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
-		scno = syscall_trace_enter(regs);
+		scno = syscall_trace_enter(regs, scno, flags);
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


