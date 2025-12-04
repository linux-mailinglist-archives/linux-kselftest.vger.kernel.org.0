Return-Path: <linux-kselftest+bounces-46978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A77CA2C85
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 149CA3022806
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8A329E7F;
	Thu,  4 Dec 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qxT8YdTf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B43321BB;
	Thu,  4 Dec 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836513; cv=none; b=L2ReOePAyr1n9oZ80mqpIJIyBNfYJyIfYIg09o5KieGvsJQMe8T65cuuYoMNj5j/Wp0MTH6h41QhpTxSp1PIxgaYfBVsSUGM4USL6zPrbvHcM3waxQ3hw6fvfNFr2qYpiv5lZt9/P3ztHAfVKwflRWlEeV/BW/Tt6i7rkTCsttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836513; c=relaxed/simple;
	bh=txXJEQ+R+Q6hTvcF/C0gW5yR8OomlElSM6yi6o09VRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J02kMLBl3pklgFEwtGLGogpa46td9pgPpfe5RvCGjLsUCqivY90ubqamUM5+s0cdZQJ7Z6ZqLmr1uuSYeGvGl6qZFAcJaVYCQ5xmoNG2YHWn4KKUxLl7x7xeGv2MnvKiG5O1lh2wEd6jUlQeq3SHoKHARSgqTcdyYCzpnkGW2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qxT8YdTf; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l6HnB7u3ih/kMnN+gHTC+H6OSETuFbNr0l0EYsf2KPY=;
	b=qxT8YdTf2qOpyYF6D8oct3lpkJFaSYsoDCbR3AhaSczOVWxGcvagNXVrcQhtsBwjUcoEdMwf/
	5BB4MT6T9dL5zBjmbqQRD0IFBbk9peWHJyhrumJnD/a0g/lB4sCetG8wAohNW3FCnhvBDsLNTn4
	l+6Jm1dyeZerGKJwowzBFvo=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dMS8k4dnlzcb07;
	Thu,  4 Dec 2025 16:19:18 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 440AE14027A;
	Thu,  4 Dec 2025 16:21:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:46 +0800
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
Subject: [PATCH v9 05/16] arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
Date: Thu, 4 Dec 2025 16:21:12 +0800
Message-ID: <20251204082123.2792067-6-ruanjinjie@huawei.com>
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

commit a9f3a74a29af ("entry: Provide generic syscall exit function")
introduce generic syscall exit function and call rseq_syscall()
before audit_syscall_exit() and arch_syscall_exit_tracehook().

And commit b74406f37737 ("arm: Add syscall detection for restartable
sequences") add rseq support for arm32, which also call rseq_syscall()
before audit_syscall_exit() and tracehook_report_syscall().

However, commit 409d5db49867c ("arm64: rseq: Implement backend rseq
calls and select HAVE_RSEQ") implement arm64 rseq and call
rseq_syscall() after audit_syscall_exit() and tracehook_report_syscall().

So compared to the generic entry and arm32 code, arm64 terminates
the process a bit later if the syscall is issued within
a restartable sequence.

But as commit b74406f37737 ("arm: Add syscall detection for restartable
sequences") said, syscalls are not allowed inside restartable sequences,
so should call rseq_syscall() at the very beginning of system call
exiting path for CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect
whether there is a syscall issued inside restartable sequences.

It makes sense to raise SIGSEGV via rseq_syscall() before auditing
and ptrace syscall exit, because this guarantees that the process is
already in an error state with SIGSEGV pending when those later steps
run. Although it makes no practical difference to signal delivery (signals
are processed at the very end in arm64_exit_to_user_mode()), the ordering
is more logical: detect and flag the error first, then proceed with
the remaining work.

To make it more reasonable and in preparation for moving arm64 over to
the generic entry code, move rseq_syscall() ahead before
audit_syscall_exit().

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b962cbcca11d..8b0a46aac51f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2416,6 +2416,8 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 
 void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
+	rseq_syscall(regs);
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
@@ -2423,8 +2425,6 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
 		report_syscall_exit(regs);
-
-	rseq_syscall(regs);
 }
 
 /*
-- 
2.34.1


