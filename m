Return-Path: <linux-kselftest+bounces-45747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FEC646BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8808734BFB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C8334C3D;
	Mon, 17 Nov 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XCdll9/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D933373D;
	Mon, 17 Nov 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386283; cv=none; b=pqyLXS6kMges9CZsAfTBhIhniN34IvsH7nL+9IZOxB/lFGhUr0xXoXftQ6oH43SfqtWT4CbTO513D59WYqSUwjG2qt/DL1CRKHAwOQxLOCGAzot+JS0eNdfgpoJU9rnuCgBQyki2jnDsSMvwk8TrDjJ4TK25XslCQfqokn8CaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386283; c=relaxed/simple;
	bh=vR4ujFeL/c/rSyeE+Ew/QgmViHAeCETlnfNIV7PYf2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdZjyoAE2gBJ3HpbvCiEQigGXm2vfBwWAbKF60VZltXzJdwutB8GDpZM/epnomI/YLivNTstQncZPJz67vnzrF7cCmIjAF8ylwqHUC+hPLpxbQn2ggGM270lrEPUaXvXlICx1ywbIRAb0P/ILuXG06EvmO2cUbdOu9rZmepHHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XCdll9/W; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kQJChy4CSig7WwWYt7pGFEdPu8K8NX2y5MQxbd1imwo=;
	b=XCdll9/WfiN+9U5PmTpPKoAREVR7KqYPR4vpBiFW1qdQOrehyTN+qOdp6g4vWfpvcmKX4Ek1o
	ZaxJoqJiZOKKoW/7JzAhVQ/sWCNiZDkXuW++bpMiXhOo2Nrn6NWbHi9iKn+3lhHdK12FtfG96OU
	FbilBiHRQZ6cuST6Q8DJ/bk=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d97rT4yJXz1cyqF;
	Mon, 17 Nov 2025 21:29:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id AB31B1A0188;
	Mon, 17 Nov 2025 21:31:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:11 +0800
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
Subject: [PATCH v7 05/11] arm64/ptrace: Handle ptrace_report_syscall_entry() error
Date: Mon, 17 Nov 2025 21:30:42 +0800
Message-ID: <20251117133048.53182-6-ruanjinjie@huawei.com>
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

The generic entry handle error of ptrace_report_syscall_entry(), but
arm64 not.

As the comment said, the calling arch code should abort the system
call and must prevent normal entry so no system call is
made if ptrace_report_syscall_entry() return nonzero.

In preparation for moving arm64 over to the generic entry code,
return early if ptrace_report_syscall_entry() encounters an error.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 95984bbf53db..707951ad5d24 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2317,10 +2317,10 @@ enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_EXIT,
 };
 
-static void report_syscall_enter(struct pt_regs *regs)
+static int report_syscall_enter(struct pt_regs *regs)
 {
-	int regno;
 	unsigned long saved_reg;
+	int regno, ret;
 
 	/*
 	 * We have some ABI weirdness here in the way that we handle syscall
@@ -2342,9 +2342,13 @@ static void report_syscall_enter(struct pt_regs *regs)
 	saved_reg = regs->regs[regno];
 	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
 
-	if (ptrace_report_syscall_entry(regs))
+	ret = ptrace_report_syscall_entry(regs);
+	if (ret)
 		forget_syscall(regs);
+
 	regs->regs[regno] = saved_reg;
+
+	return ret;
 }
 
 static void report_syscall_exit(struct pt_regs *regs)
@@ -2374,9 +2378,11 @@ static void report_syscall_exit(struct pt_regs *regs)
 
 int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 {
+	int ret;
+
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
-		report_syscall_enter(regs);
-		if (flags & _TIF_SYSCALL_EMU)
+		ret = report_syscall_enter(regs);
+		if (ret || (flags & _TIF_SYSCALL_EMU))
 			return NO_SYSCALL;
 	}
 
-- 
2.34.1


