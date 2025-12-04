Return-Path: <linux-kselftest+bounces-46985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B80CA2CCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA8D301F277
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3542334C27;
	Thu,  4 Dec 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a2vBtBiu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8D334695;
	Thu,  4 Dec 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836520; cv=none; b=joPaOM/TidIFplQkR/lOH8QWuB8Xy8vvwSALfJDPh7CHxacwXPRiWSeJHVbeNNgU2ujoR7+O1v+UiKu5uBM0fSN7xRXjjYpTY6tkd/l3U1rwc/lSFdJn0iilMsItGv93/GHP1OzRSTsVIT8SDYLnr+QzRR4qI087FvLxYlsm2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836520; c=relaxed/simple;
	bh=Uua52Y0ZgqdTohlA6Sxlf5sjcTK1WbqcWJVfSfX0g7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJ0SfdWTxSj922GYI6CL/3DsQeWwY2MYuF3Vfc/+agZA2C3D3WYjhoIyF2rFGRbzi22aoujp4EmgQOhiXb48YcZHye9eVQdU4FJ/sCyI5GqeTplDq9oQZDbEDf1+ek9Lp9JXMGJCafI/6ls4HH8lRZhMfkK9Pf/BEjgcLfz4zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a2vBtBiu; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AD3lkY3lo9BOCUTsw01s+6qfHOQPi+Kn7WcvrIho52Q=;
	b=a2vBtBiue9RxqGMSRB2McAGhZvRq5ayz/HFD+S7VTbX3OOS4u59s4x65tplSSoeVzm3sKQ7mv
	4D3OhW81uaimvnmqq5S2Yqg+xW/9qMGPhtBx1Rh51vzAgv5Aosqb8/GvAGE0g5cmq4y7rkWesMp
	9X3GAuK+rjZ8EzkTD8RdCkY=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dMS8x5jsYzpSy3;
	Thu,  4 Dec 2025 16:19:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id D76F1180485;
	Thu,  4 Dec 2025 16:21:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:49 +0800
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
Subject: [PATCH v9 07/16] arm64/ptrace: Not check _TIF_SECCOMP/SYSCALL_EMU for syscall_exit_work()
Date: Thu, 4 Dec 2025 16:21:14 +0800
Message-ID: <20251204082123.2792067-8-ruanjinjie@huawei.com>
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

As syscall_exit_work() do not handle seccomp, so not check _TIF_SECCOMP
for syscall_exit_work().

And as the man manual of PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
said, "For PTRACE_SYSEMU, continue and stop on entry to the next system
call, which will not be executed. For PTRACE_SYSEMU_SINGLESTEP, do the same
but also singlestep if not a system call.". So only the syscall entry need
to be reported for SYSCALL_EMU, so not check _TIF_SYSCALL_EMU for
syscall_exit_work().

After this, audit_syscall_exit() and report_syscall_exit() will
no longer be called if only SECCOMP and/or SYSCALL_EMU is set.

And remove has_syscall_work() by the way as currently it is only used in
el0_svc_common().

This is another preparation for moving arm64 over to the generic
entry code.

Link：https://man7.org/linux/man-pages/man2/ptrace.2.html
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h     | 5 -----
 arch/arm64/include/asm/thread_info.h | 3 +++
 arch/arm64/kernel/ptrace.c           | 2 +-
 arch/arm64/kernel/syscall.c          | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index ccdaa805aa52..9f2aa9c57560 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -120,11 +120,6 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
 int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
 void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index ff4998fa1844..8d308ef64612 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -110,6 +110,9 @@ void arch_setup_new_exec(void);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_SYSCALL_EMU)
 
+#define _TIF_SYSCALL_EXIT_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
+				 _TIF_SYSCALL_TRACEPOINT)
+
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 25fdf320d73a..3e233968efa2 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2431,7 +2431,7 @@ void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	rseq_syscall(regs);
 
-	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
+	if (unlikely(flags & _TIF_SYSCALL_EXIT_WORK) || flags & _TIF_SINGLESTEP)
 		syscall_exit_work(regs, flags);
 }
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 65021d0f49e1..881fd261e8cb 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -101,7 +101,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		return;
 	}
 
-	if (has_syscall_work(flags)) {
+	if (unlikely(flags & _TIF_SYSCALL_WORK)) {
 		/*
 		 * The de-facto standard way to skip a system call using ptrace
 		 * is to set the system call to -1 (NO_SYSCALL) and set x0 to a
-- 
2.34.1


