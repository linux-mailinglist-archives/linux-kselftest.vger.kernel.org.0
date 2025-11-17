Return-Path: <linux-kselftest+bounces-45742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8AC64615
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F08F4EB775
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA732E6AB;
	Mon, 17 Nov 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KmCsfjIb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01437333424;
	Mon, 17 Nov 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386281; cv=none; b=RYJW7Mbf0ahxIg4ni09DYpOMoqmMAtVLaWEPGancUqU03ifMWidNivO2wurbeLQ7T1+4eBzcywmd1nptGmGf6+XdtB4R4Uzz55bT/bJQ0QeAymk0xfTaq2dlFXdUY1qQlGX0ylxZXO4ckog1fv7uk+mEuJDqtQDgt8vyEnOmNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386281; c=relaxed/simple;
	bh=EF2iXe3ciK3258zQTRLplMfgEvw0qWOVl2x4DdApvlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG5/aniSsRFAcGakir3kjk2y9eCS4P0lZpIhtZaLvLqxmdlV2sV8HgYtjyzDXWSo8VmQ/PJQXvvFvyM9ciJzf+JPjfeaAwRcrWPsYNVTY9ttxWdau1GietjEs+Yc9DumQfP8wB6CXRUd+SAz0C3drUcVC/U/lyzFEgtUDicalfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KmCsfjIb; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1MqVMJTTo6T38F+TamEic2utqXgvdR5R1B5+ka+htpM=;
	b=KmCsfjIbe5OZG8mPkBkAf7aSmDbVJXEEuudK77nDVckGswYjWj2Kq03qz9Lmhv7uWsTCPZfSs
	pBncWxfGQ9qpVsUABLLe2BQSMApCF8lJe9OAvWm0zeJwLVIkQqm1r8nwu4kTilkBPHEB5mm62bS
	VipywHoR2ah4t+hf3LglecA=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d97rb6B0Dz1K9Bq;
	Mon, 17 Nov 2025 21:29:35 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id D815E1A016C;
	Mon, 17 Nov 2025 21:31:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:15 +0800
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
Subject: [PATCH v7 08/11] entry: Add arch_ptrace_report_syscall_entry/exit()
Date: Mon, 17 Nov 2025 21:30:45 +0800
Message-ID: <20251117133048.53182-9-ruanjinjie@huawei.com>
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

Differ from generic entry, due to historical reasons, ARM64 need to
save/restore during syscall entry/exit because ARM64 use a scratch
register (ip(r12) on AArch32, x7 on AArch64) to denote syscall entry/exit.

In preparation for moving arm64 over to the generic entry code,
add arch_ptrace_report_syscall_entry/exit() as the default
ptrace_report_syscall_entry/exit() implementation. This allows
arm64 to implement the architecture specific version.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/entry/syscall-common.c | 43 +++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 66e6ba7fa80c..27310e611567 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -17,6 +17,25 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
+/**
+ * arch_ptrace_report_syscall_entry - Architecture specific
+ *				      ptrace_report_syscall_entry().
+ *
+ * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
+ * Defaults to ptrace_report_syscall_entry.
+ *
+ * The main purpose is to support arch-specific ptrace_report_syscall_entry()
+ * implementation.
+ */
+static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
+
+#ifndef arch_ptrace_report_syscall_entry
+static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
+{
+	return ptrace_report_syscall_entry(regs);
+}
+#endif
+
 long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long work)
 {
@@ -34,7 +53,7 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret = ptrace_report_syscall_entry(regs);
+		ret = arch_ptrace_report_syscall_entry(regs);
 		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
 			return -1L;
 	}
@@ -84,6 +103,26 @@ static inline bool report_single_step(unsigned long work)
 	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
 
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
 void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
@@ -108,5 +147,5 @@ void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 
 	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		ptrace_report_syscall_exit(regs, step);
+		arch_ptrace_report_syscall_exit(regs, step);
 }
-- 
2.34.1


