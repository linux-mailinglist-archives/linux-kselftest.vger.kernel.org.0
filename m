Return-Path: <linux-kselftest+bounces-46981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392ECA2CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70AE309247D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFADE3328F9;
	Thu,  4 Dec 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fw/9LN7P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993632E131;
	Thu,  4 Dec 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836515; cv=none; b=GXwN9PwI4RD5QLymU9vNPLzbxfWzNd8UIh+bykI62FKG2TFR5G7yd+bsNFIsSrt4krgctY4MsRdaNsKGOFRyS9iREfetnUjUPmb+bF2pzOx7bwT3alA7FXGHGic+0LfRlkYQPE7grYloLf9XIw+Sx65fd926hJeCJPf6TIyemrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836515; c=relaxed/simple;
	bh=e54zcuYkhSDsOGAFmhb593nBpTTy4968JmkJ2dMg3Cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gv/RyEA7rO1QyRn0g7zcmM2CN/3rq26lYFIAswBoVOzuX4TQvO35ICb1QORpL+BUcx66rWLQlOCGBUsl2nXwrczNBW2ypN4f6bXhIi7i5GaP9v/N+rRA0NAcG+7uJH6Jxdk0vwHlO0cw1XwcJi/aZva0Ob/TgOnPOKzuh7E25gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fw/9LN7P; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AZEfbfMjNWamoJ+0odNZq6Zli/tw4Fem2WDzT5dht6M=;
	b=fw/9LN7P1axsigk6D0mQM2zJdPUNV0Gxyis/LlxalZ+QmQS/r+XCSTav4/E8RTuas6Y9Dp3iR
	wZH4yVUlqlExP3C1wU6/Y+58HJwOuIL9odXJV8qMPmrOQnJLNp+AS13lQOO6XZSoVaaXMjYZ3Rr
	nqzmOe5I8+CqqCRsKL4tYlY=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dMS9M4pVnz1prKH;
	Thu,  4 Dec 2025 16:19:51 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B50741401F2;
	Thu,  4 Dec 2025 16:21:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:44 +0800
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
Subject: [PATCH v9 03/16] arm64/ptrace: Return early for ptrace_report_syscall_entry() error
Date: Thu, 4 Dec 2025 16:21:10 +0800
Message-ID: <20251204082123.2792067-4-ruanjinjie@huawei.com>
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

The generic entry abort the syscall_trace_enter() sequence if
ptrace_report_syscall_entry() errors out, but arm64 not.

As the ptrace_report_syscall_entry() comment said, the calling arch code
should abort the system call and must prevent normal entry so no system
call is made if ptrace_report_syscall_entry() return nonzero.

In preparation for moving arm64 over to the generic entry code,
return early if ptrace_report_syscall_entry() encounters an error.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4532e9831856..3926ce6aa268 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2346,15 +2346,18 @@ static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
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
@@ -2381,10 +2384,11 @@ static void report_syscall_exit(struct pt_regs *regs)
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


