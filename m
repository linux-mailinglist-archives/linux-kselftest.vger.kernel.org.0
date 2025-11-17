Return-Path: <linux-kselftest+bounces-45743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D42C64618
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBDF54EB639
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDE334361;
	Mon, 17 Nov 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q6Peldem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1664330B03;
	Mon, 17 Nov 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386281; cv=none; b=Dw8jart/+Utp5rGDxnfMWprMHJgtiF0rc13riZg+9mohbs8y68DG6fSuRG35ii+uayfztWylHwujhmXNrnnmgQ5MBApM1NJA/MkWnrhrfbbMuSgplva2aVvOvIVGFrvz6+zDhx85BDYkTaGMiz/ER8onDfRfXsUZWB4r2+MSuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386281; c=relaxed/simple;
	bh=qO5ZtWRyU93oWfWwgMQEyXOEIf2nN2ddEqJMkkjnPGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cosBU6EHIDgcvahCeoIIbH2rjERkB+1Exhh1FF4M8toNf4/6Z9oYEs4PvPJbo7DtsP1Bf1zTd5oacPa9DyqAJbk9lV6sGxqV0G4apNWvROF4AAN3u3g+6ungi6/7nciHu0xntrrM5/DN4STthhRot2A0Olhhb783vt/UDszdzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q6Peldem; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j4B/gAP/ehXLgCgUT9gdurkhU0EpobJjRCtEvQb5TWI=;
	b=q6Peldem+vwkoD+lMi5B9Gj4HhqVKk1YxlBmQDtEu0vgWc+O3fc1W8rK1dO/IV+Pjr5iKT3CD
	uinNAdXLP6p3Gypam6dCXjtA+TiZmb5RcKowm6WEKGuMZuyhyPwk2L7LKDq3uZ6cqdzjOV7vvhm
	hXv60Skoy6tiIyydIpJDDc4=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d97r704KMzcbNS;
	Mon, 17 Nov 2025 21:29:11 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E3E3D140132;
	Mon, 17 Nov 2025 21:31:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:08 +0800
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
Subject: [PATCH v7 03/11] arm64/ptrace: Refator el0_svc_common()
Date: Mon, 17 Nov 2025 21:30:40 +0800
Message-ID: <20251117133048.53182-4-ruanjinjie@huawei.com>
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

Compared to the generic entry code, arm64 terminate the process
after report_syscall_exit() if the syscall is issued within
a restartable sequence.

In preparation for moving arm64 over to the generic entry code,
refactor el0_svc_common() as below:

- Extract syscall_exit_to_user_mode_prepare() to replace the
  the combination of read_thread_flags() and syscall_trace_exit(),
  also move the syscall exit check logic into it.

- Move rseq_syscall() ahead, so the CONFIG_DEBUG_RSEQ check is
  not needed.

- Move has_syscall_work() helper into asm/syscall.h, which will be
  reused by ptrace.c.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h |  7 ++++++-
 arch/arm64/kernel/ptrace.c       | 10 +++++++++-
 arch/arm64/kernel/syscall.c      | 26 +++++---------------------
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index d69f590a989b..6225981fbbdb 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -114,7 +114,12 @@ static inline int syscall_get_arch(struct task_struct *task)
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
index bbb868f6b292..95984bbf53db 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2403,7 +2403,7 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 	return regs->syscallno;
 }
 
-void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
+static void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
 	audit_syscall_exit(regs);
 
@@ -2412,8 +2412,16 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
 		report_syscall_exit(regs);
+}
+
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long flags = read_thread_flags();
 
 	rseq_syscall(regs);
+
+	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
+		syscall_trace_exit(regs, flags);
 }
 
 /*
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 6e3fe760e0bb..9713b038d750 100644
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
@@ -125,26 +120,15 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
 		scno = syscall_trace_enter(regs, regs->syscallno, flags);
-		if (scno == NO_SYSCALL)
-			goto trace_exit;
+		if (scno == NO_SYSCALL) {
+			syscall_exit_to_user_mode_prepare(regs);
+			return;
+		}
 	}
 
 	invoke_syscall(regs, scno, sc_nr, syscall_table);
 
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
-trace_exit:
-	flags = read_thread_flags();
-	syscall_trace_exit(regs, flags);
+	syscall_exit_to_user_mode_prepare(regs);
 }
 
 void do_el0_svc(struct pt_regs *regs)
-- 
2.34.1


