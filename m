Return-Path: <linux-kselftest+bounces-47826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C1FCD5D8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9433F3042183
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CB31AF2C;
	Mon, 22 Dec 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H07+Cca2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835C30F552;
	Mon, 22 Dec 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404100; cv=none; b=O1chpMkz3M5xbzwuFS3PRHcp1ph2E9uaogBSRvZK8qAt+jVSNgXnHh6RglL8QJAbyZr0TMurKDfvj+SWKD453FDqXmVNJFusDguCfvyVr3KtZPONoXQEeVl2SmPn+kCoj7lrc3xVAsjs9gFrAgvtaEaadOl236j49OSmPk+Z6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404100; c=relaxed/simple;
	bh=e2WbpbCMzHLqBkoEtGaFBePKKKYbMo6SyDuqYb8qkLc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKGmZUPR6KUq5UIKJ/6UJS6bzGkzZpQGCb9H3kcTFiSB779F6P/bEeWiYaDuZ9SFiaYzJKLV3olvzTjmrCFlD4pfASRNqlJ3wOF8tViRyolhSqgyx7TDjEi87nI28pUrJz1eBnc4fPwF9oYj7vNvs0Vf1ZViyBvRhrH6925zPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H07+Cca2; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eA9FmNXHGiOZZGgTL6Sla6Y2umwnwt6FXz/Hs6qRHm4=;
	b=H07+Cca2xuxeNQpzvbRVmh8CyvEBwrt6UIo902ma750PFu24SIMd5UR52h0063FIyECjxm0Qt
	6O0Y7f3whHfpdAAHfOC/G8ZJ9d2sd3Tnz199rOns6TCik7R/Ojo+FTGTmx8iDnF/17f8pkZgbRe
	mlSK4OHEbDVRcQm2aRzBTgw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dZbtr6fL6z1T4GL;
	Mon, 22 Dec 2025 19:45:56 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E50240562;
	Mon, 22 Dec 2025 19:48:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:14 +0800
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
Subject: [PATCH v10 03/16] arm64/ptrace: Return early for ptrace_report_syscall_entry() error
Date: Mon, 22 Dec 2025 19:47:24 +0800
Message-ID: <20251222114737.1334364-4-ruanjinjie@huawei.com>
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

The generic entry abort the syscall_trace_enter() sequence if
ptrace_report_syscall_entry() errors out, but arm64 not.

When ptrace requests interception, it should prevent all subsequent
system-call processing, including audit and seccomp. In preparation for
moving arm64 over to the generic entry code, return early if
ptrace_report_syscall_entry() encounters an error.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 03fe2f8a4d54..f333791ffba6 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2372,15 +2372,18 @@ static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
 	return saved_reg;
 }
 
-static void report_syscall_entry(struct pt_regs *regs)
+static int report_syscall_entry(struct pt_regs *regs)
 {
 	unsigned long saved_reg;
-	int regno;
+	int regno, ret;
 
 	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
-	if (ptrace_report_syscall_entry(regs))
+	ret = ptrace_report_syscall_entry(regs);
+	if (ret)
 		forget_syscall(regs);
 	regs->regs[regno] = saved_reg;
+
+	return ret;
 }
 
 static void report_syscall_exit(struct pt_regs *regs)
@@ -2407,10 +2410,11 @@ static void report_syscall_exit(struct pt_regs *regs)
 int syscall_trace_enter(struct pt_regs *regs)
 {
 	unsigned long flags = read_thread_flags();
+	int ret;
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		report_syscall_entry(regs);
-		if (flags & _TIF_SYSCALL_EMU)
+		ret = report_syscall_entry(regs);
+		if (ret || (flags & _TIF_SYSCALL_EMU))
 			return NO_SYSCALL;
 	}
 
-- 
2.34.1


