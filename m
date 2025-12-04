Return-Path: <linux-kselftest+bounces-46987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ECDCA2CD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42EE230DB816
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11294335086;
	Thu,  4 Dec 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CjxxLsLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5723090EB;
	Thu,  4 Dec 2025 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836522; cv=none; b=o3msQclozWYUEk8JZ1sHSHMjhjfBdKpPFH1FNW1vG36hv89Lw13kNt1dgCFVhDc/i/4ueNHymr/EZqWwj8OBWLnU77Pxp6yhI5N9TeV+hFcKDfkACU/bdKtRQ+U6gFgbFYgTrXBWaZtL/n8YJs0B3qZK3rQh4ssFvE4Wdetxtc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836522; c=relaxed/simple;
	bh=tckLzvkScaYJARXDfiXWI4ktqPlQYgkwixWP8+3tf5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzQvwO+wmfYTGSshYG9peru5pisNZBCNzLnIiunEcISeihuFxlOoZ2VNte/POXKxoIOc54qnDJ1ATTriUYVKs7ML/k1M1EC36TMBCWexTONu0ZoWnW9HCn9iqK7ln6ZEOezLUOmm2JdhXvPwr0VEEOhqDIROajfrZkHBW15UCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CjxxLsLi; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VhD2P0g3phUdeAXLvkKoMMuP8ewq/ndWK3wLodERPTw=;
	b=CjxxLsLii9QZY4aIsOSSWBUmMoM51s9wehaIme5Y1k7Vw7VFNpbajLFz6EhLXg+X6vgyxL+6E
	UJ9qDawu+gAGJJziBYYvw7LfYnzGBtdIuY/Ahe4R0k64zG0PrwpGsdPsv/DxptYsFrGhDQPJ9dv
	pLJQIFpiVpB3kKvjo5qdH/M=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dMS8z0WWyzpTHf;
	Thu,  4 Dec 2025 16:19:31 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 24529180485;
	Thu,  4 Dec 2025 16:21:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:50 +0800
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
Subject: [PATCH v9 08/16] arm64/ptrace: Do not report_syscall_exit() for PTRACE_SYSEMU_SINGLESTEP
Date: Thu, 4 Dec 2025 16:21:15 +0800
Message-ID: <20251204082123.2792067-9-ruanjinjie@huawei.com>
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
index 3e233968efa2..25111c121b5e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2414,14 +2414,25 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
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


