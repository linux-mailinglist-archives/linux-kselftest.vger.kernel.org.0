Return-Path: <linux-kselftest+bounces-46986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA7CA2CCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A5E30D2E0F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39638334C35;
	Thu,  4 Dec 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZLVEQ/U0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1D2FFDFE;
	Thu,  4 Dec 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836521; cv=none; b=r6bcUviV7SItx4LqxWoWv+7/GdxlV+ymg679C2jdsLcpdkqp3vs9ZfnhPT4SQMZnve451LSZcxy2i9aR6SBg+fST2Shw1AfDtKBc4L7VYfluYrXYPEjOmi82K4AEOEIaMTRllirh3bH7NyBXW+1y5xvZYvb519k5NOAMPjIHmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836521; c=relaxed/simple;
	bh=/2hl0V6rEgQwdB6xIDPjwU0wZ5t4Uf0ro/HXaMhEidA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9YQIu79PKApNhMcLU2l60gaIMYimE5T2DCHLYRazYgi5KtYT5NBd+suqbrvCmlKcnbXtBUQLrdo/JRustXAN8rvoJ1RPzSjkwwGqr9+gECSAv5p65tCcJXWKpdY2HUCAuKyYHf7wM1CN0m9eLFOm74FkSvOzr0fUYrCT5s3n1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZLVEQ/U0; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=miPtJcuxDC3FhmFutVVF/gzjsjFye9cVSFzGgf7hjYQ=;
	b=ZLVEQ/U0PAmunTH6wHiOYMGF+coCMw3HA2mXJC0ZxzS2qncplUjQ+0pN4XqXCCoeSFsOvbcEo
	UAxxUOFbZTPBwadOZ11m6AefO4AWhHdBfrE6kuL4sJS2CBqRFLPVqHswly3ZlONAtAJ9DGBkK2k
	+EV6A4Z6JZpfhABHDW/Flxc=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dMS9R53yGz1T4GD;
	Thu,  4 Dec 2025 16:19:55 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 89E33180485;
	Thu,  4 Dec 2025 16:21:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:48 +0800
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
Subject: [PATCH v9 06/16] arm64: syscall: Rework el0_svc_common()
Date: Thu, 4 Dec 2025 16:21:13 +0800
Message-ID: <20251204082123.2792067-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204082123.2792067-1-ruanjinjie@huawei.com>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The generic syscall syscall_exit_work() has the following content:

| audit_syscall_exit(regs)
| trace_sys_exit(regs, ...)
| ptrace_report_syscall_exit(regs, step)

The generic syscall syscall_exit_to_user_mode_work() has
the following form:

| unsigned long work = READ_ONCE(current_thread_info()->syscall_work)
| rseq_syscall()
| if (unlikely(work & SYSCALL_WORK_EXIT))
|	syscall_exit_work(regs, work)

In preparation for moving arm64 over to the generic entry code,
rework el0_svc_common() as below:

- Rename syscall_trace_exit() to syscall_exit_work().

- Add syscall_exit_to_user_mode_prepare() function to replace
  the combination of read_thread_flags() and syscall_exit_work(),
  also move the syscall exit check logic into it. Move has_syscall_work()
  helper into asm/syscall.h for reuse.

- As currently rseq_syscall() is always called and itself is controlled
  by the CONFIG_DEBUG_RSEQ macro, so the CONFIG_DEBUG_RSEQ check
  is removed.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h |  7 ++++++-
 arch/arm64/kernel/ptrace.c       | 14 +++++++++++---
 arch/arm64/kernel/syscall.c      | 20 +-------------------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index cef1d9ce6e1b..ccdaa805aa52 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -120,7 +120,12 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
+static inline bool has_syscall_work(unsigned long flags)
+{
+	return unlikely(flags & _TIF_SYSCALL_WORK);
+}
+
 int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
-void syscall_trace_exit(struct pt_regs *regs, unsigned long flags);
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8b0a46aac51f..25fdf320d73a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2414,10 +2414,8 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 	return syscall;
 }
 
-void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
+static void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
 {
-	rseq_syscall(regs);
-
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
@@ -2427,6 +2425,16 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 		report_syscall_exit(regs);
 }
 
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long flags = read_thread_flags();
+
+	rseq_syscall(regs);
+
+	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
+		syscall_exit_work(regs, flags);
+}
+
 /*
  * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487D.a.
  * We permit userspace to set SSBS (AArch64 bit 12, AArch32 bit 23) which is
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index ec31f82d2e9f..65021d0f49e1 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -65,11 +65,6 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	choose_random_kstack_offset(get_random_u16());
 }
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
@@ -130,21 +125,8 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	}
 
 	invoke_syscall(regs, scno, sc_nr, syscall_table);
-
-	/*
-	 * The tracing status may have changed under our feet, so we have to
-	 * check again. However, if we were tracing entry, then we always trace
-	 * exit regardless, as the old entry assembly did.
-	 */
-	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		flags = read_thread_flags();
-		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
-			return;
-	}
-
 trace_exit:
-	flags = read_thread_flags();
-	syscall_trace_exit(regs, flags);
+	syscall_exit_to_user_mode_prepare(regs);
 }
 
 void do_el0_svc(struct pt_regs *regs)
-- 
2.34.1


