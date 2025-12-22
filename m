Return-Path: <linux-kselftest+bounces-47828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C8CD5DA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB5E33012CE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6193203A9;
	Mon, 22 Dec 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y2uAVP5/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DD31B810;
	Mon, 22 Dec 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404104; cv=none; b=Rw1oBsrZWdH40r9Eh4Gg2gQG1VmaeZbMvHLgk3Lead9ZuMYazriL5hEWfASHhx6rIQNBqksWpXlHv/Q/CJ3iZA6bYiiF03hC4HgXinA3imwcNv7/HxgESoA2lU5Hn6LAJPU+gAmG2oe/sF1iVvFPWe8rrxrAnn9i9H+2Qd8qj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404104; c=relaxed/simple;
	bh=86vqIlnDGE9SXsgx6ZmdyIIE3hDpkjKJzPCz+NCmIOI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVHnhXbRr2E3R43v+c6OxOHlIEc6FhqWpRk494GEVU/gmnGwo7Lm+7KognqpS5z/xqwBqANQJjsCCZL5h2xNljI5CEdGVvDLIfXHaU3WjGq1d4CN361VyO+ot/68LJAOpW2N8c5xACNcDprkfJ+5FwUUiocWV3TtscdAp/58bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y2uAVP5/; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KhO8fxda2eoaFX00guyo2P+RdkMem4jclOb0Q5+D1Vs=;
	b=y2uAVP5/oePyH6XgV5Su2hxNDS3b7tssANwdFF6VrWKLUJqyslgK3bXBVaI5+55TVqlCQW0ZK
	Y+15Mmi0VwJwHv1HNPJnnVabXjxSjHbc+nnFG52CET6G6CkC6qtDUPFWbxy4ua4B1409ScktHk+
	astDwjPWM0qo1RqDatU+f5Q=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dZbt44PS3zcb1P;
	Mon, 22 Dec 2025 19:45:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 630FC40562;
	Mon, 22 Dec 2025 19:48:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:17 +0800
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
Subject: [PATCH v10 05/16] arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
Date: Mon, 22 Dec 2025 19:47:26 +0800
Message-ID: <20251222114737.1334364-6-ruanjinjie@huawei.com>
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
index 79762ff33945..983d8d1104df 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2442,6 +2442,8 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 
 void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
+	rseq_syscall(regs);
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
@@ -2449,8 +2451,6 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
 		report_syscall_exit(regs);
-
-	rseq_syscall(regs);
 }
 
 /*
-- 
2.34.1


