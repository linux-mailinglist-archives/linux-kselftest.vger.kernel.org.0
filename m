Return-Path: <linux-kselftest+bounces-46478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E4BC885EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D4A3B5318
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE582315760;
	Wed, 26 Nov 2025 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Zcf6Nhoy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1EA2BEC57;
	Wed, 26 Nov 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141309; cv=none; b=LVKi9//1VBPngI+gCejDKngzi46xmbM5lNZjEt1J68IheUGVOhwgoUoWDgC4G2krjGoI6q5DMFmfAYQO7Fc5hnA6JECyvCuTxbyXTaLSnWdQ/QejlF55JtG7F33bL4J61juasJygebWhOF/T+djh5JOnq/hxZBuZ3PR3HJBX28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141309; c=relaxed/simple;
	bh=ZLO85BqU8G0oEC8+KOS1qazRlfkkoZw35VaKUcgQZ5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rA9uKxB1z9IbX3e/MBWgc8aBjnTESpQw/r7SLwPX5iHDSquNmmn1cN/UG8vhuBFk1rr+s0PxtI0aHo/+FOFe3VIoo8BXGYo7iUwCBoS/kP+BF4lEQRrnsX/8hgRe5JAU0UkI42lo1gHjCkm+Fq3GRF/kUxYMPCtJWZ1caGKtg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Zcf6Nhoy; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=owgLQB6io9/MDXD8u3V/lL7scp0sEqB5t2TvhpWgiDk=;
	b=Zcf6NhoyJOcOk8FyIPiyJjaYZEpqbfUzXH2FXigyMjsrv6g5Vc2dTf26nk4cofYxq3wEEd95U
	YdsbSHofpo6DWlGSRrvTVJUwdKPQNvq4qv2jCOkSskSTW4u67YlitxdtiU7fsqujQREBnG3Q64n
	O8oCjb+3uZ7j0/WWoYkHnA8=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dGW472xrQzRhRh;
	Wed, 26 Nov 2025 15:13:11 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B8D11401E0;
	Wed, 26 Nov 2025 15:14:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Nov
 2025 15:14:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<charlie@rivosinc.com>, <akpm@linux-foundation.org>, <ldv@strace.io>,
	<macro@orcam.me.uk>, <deller@gmx.de>, <mark.rutland@arm.com>,
	<efault@gmx.de>, <song@kernel.org>, <mbenes@suse.cz>, <ryan.roberts@arm.com>,
	<ada.coupriediaz@arm.com>, <anshuman.khandual@arm.com>, <broonie@kernel.org>,
	<kevin.brodsky@arm.com>, <pengcan@kylinos.cn>, <dvyukov@google.com>,
	<kmal@cock.li>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v8 04/12] arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
Date: Wed, 26 Nov 2025 15:14:38 +0800
Message-ID: <20251126071446.3234218-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126071446.3234218-1-ruanjinjie@huawei.com>
References: <20251126071446.3234218-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 63ba6c961ecc..dfdd886dc0a9 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2411,6 +2411,8 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 
 void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
+	rseq_syscall(regs);
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
@@ -2418,8 +2420,6 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
 		report_syscall_exit(regs);
-
-	rseq_syscall(regs);
 }
 
 /*
-- 
2.34.1


