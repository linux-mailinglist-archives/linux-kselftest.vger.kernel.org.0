Return-Path: <linux-kselftest+bounces-47832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75647CD5E46
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4C0A307779B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4023254BC;
	Mon, 22 Dec 2025 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ohiUYkxj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640231B825;
	Mon, 22 Dec 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404109; cv=none; b=sZuA3ol2naJsjoh50va01m/3Bu+2sUBHRzE6upEMkcfj1Aoz+wUAqe84yFsqJ0kTmSVZXaw1IqsAMkC+wwSHOJhG26BNCjKpDaO+915gAEd8n9r2q/DDFM09zGor27M9uhsF+h3eXSFp9J49Q79SBOk28S58a2ZH0sSAjbYGug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404109; c=relaxed/simple;
	bh=QQADJFmFOX9MtKDPKvXM3/ttyGNVAvUDDH/vWBbWWRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QERFCzmanHuLLBrebqT6eJXLnojfKnDcEFMPQmg5MIAvmJtLjvitG0s8KGFRG+UJjiEtH9wG6SUXV9fHbuMjymw2ovZCV/YRIIYkw7hcr66yP0iR315gGInJvmRoUN2IFeH073agJmZ3MZ+92LXH4FAiIRB0qQWr9oQxn406oWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ohiUYkxj; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fjWdd/vlyHsbupVpqCXHo9EJOCq1gDlA2o9eaOcad8M=;
	b=ohiUYkxj+fovHWNdtPWOEROwwhddUQ9Q3g/4mvPLFXxUKLRfUXWlJMmKCUK6gZgJp64AhCpsP
	D2EeaKA3QqEvHHecOq8Nrob5M5ME1yWlmzp2fAwOANjIpbYZ1GfbZ9QykzuvOeRptEkR+YJqU/J
	BYjihdrQYKphUheWy3/qVY8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dZbtM0N04zpSvn;
	Mon, 22 Dec 2025 19:45:31 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 35AC540562;
	Mon, 22 Dec 2025 19:48:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:22 +0800
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
Subject: [PATCH v10 08/16] arm64/ptrace: Do not report_syscall_exit() for PTRACE_SYSEMU_SINGLESTEP
Date: Mon, 22 Dec 2025 19:47:29 +0800
Message-ID: <20251222114737.1334364-9-ruanjinjie@huawei.com>
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

The generic report_single_step() always returns false if SYSCALL_EMU
is set, but arm64 only checks _TIF_SINGLESTEP and does not check
_TIF_SYSCALL_EMU, which means that if both _TIF_SINGLESTEP and
_TIF_SYSCALL_EMU are set, the generic entry will not report
a single-step, whereas arm64 will do it.

As the man manual of PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP said,
"For PTRACE_SYSEMU, continue and stop on entry to the next system
call, which will not be executed. For PTRACE_SYSEMU_SINGLESTEP, do the
same but also singlestep if not a system call.". And as the generic entry
report_single_step() comment said, If SYSCALL_EMU is set, then the only
reason to report is when SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).
Because this syscall instruction has been already reported
in syscall_trace_enter(), there is no need to report the syscall
again in syscall_exit_work().

In preparation for moving arm64 over to the generic entry code,

- Add report_single_step() helper for arm64 to make it clear.

- Do not report_syscall_exit() if both _TIF_SYSCALL_EMU and
  _TIF_SINGLESTEP set.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index ec818940114e..558d5553fd6b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2440,14 +2440,25 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 	return syscall;
 }
 
+static inline bool report_single_step(unsigned long flags)
+{
+	if (flags & _TIF_SYSCALL_EMU)
+		return false;
+
+	return flags & _TIF_SINGLESTEP;
+}
+
 static void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
 {
+	bool step;
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
+	step = report_single_step(flags);
+	if (step || flags & _TIF_SYSCALL_TRACE)
 		report_syscall_exit(regs);
 }
 
-- 
2.34.1


