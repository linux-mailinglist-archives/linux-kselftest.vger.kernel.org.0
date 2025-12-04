Return-Path: <linux-kselftest+bounces-46984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA20CA2C88
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D20E30096A0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CF3328EB;
	Thu,  4 Dec 2025 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ev6Mhpca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE43321BB;
	Thu,  4 Dec 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836518; cv=none; b=VFf5jDwjExJuZi8M6pxI7T3vNPhRz+mEQ0rgFbA7pOnryhHA/G5ZcZnYfe/hLPYw6LXmDmxfKxkMcWuSE9g/lom7iYt8VH3deZQMz1tI2BySjs4Rx3CBIVs7GWiXoi81/o4eUGuCdTPcNvFcQaXkKMbM/AqonkQMFsRvD1KZaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836518; c=relaxed/simple;
	bh=ny8aDPURy1VXKbQhwyDp9EKmL3PMvF2nUjM9QvbOqXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/YGDiQ3okQ43sgngvXRjugd2qXs0b2X+YDYowmSjHXy1ho4J1xNhh7Yq5DU/H3qhSRyPhEvgF+1AHc8j7cTubs56dc1l40AVZiJzfu2aWPHf78XmoaF7YbNgXckQnYLXMiRq0P4IRDnwJ2A71Dm9sVC1Zqme7OV6zi+vrSKcI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ev6Mhpca; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dUB5svHzwWtU/ehADg2wSUDPJYFHtQvKQU+SkZzdhs8=;
	b=Ev6MhpcaD5VUlK9FtsDgN/OFnaVaHQXtorpXV35aYRw7knatSXZpcwC5nVDgPU8YanyOwMQcF
	tpcRGaVmLQljWvnCmCEmybWXhlbxjtFbp/WvQTf3opOGlo/lRYVmVA7/hPZAlEgSQwYj6zG4ugn
	RGYY+e22DUA2aYvXIWCWEhA=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dMS914p1PzpTHV;
	Thu,  4 Dec 2025 16:19:33 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id BAADC180485;
	Thu,  4 Dec 2025 16:21:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:53 +0800
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
Subject: [PATCH v9 10/16] arm64/ptrace: Use syscall_get_arguments() helper
Date: Thu, 4 Dec 2025 16:21:17 +0800
Message-ID: <20251204082123.2792067-11-ruanjinjie@huawei.com>
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

The generic entry check audit context first and use
syscall_get_arguments() helper.

In order to switch to the generic entry for arm64,

- Also use syscall_get_arguments() to get audit_syscall_entry()'s
  last four parameters.

- Extract the syscall_enter_audit() helper to make it clear.

- Check audit context first, which saves an unnecessary memcpy when
  current process's audit_context is NULL.

Overall these changes make syscall_enter_audit() exactly equivalent
to the generic one.

No functional changes.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c6dee8a355e5..36e7ba3f38a5 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2381,6 +2381,16 @@ static void report_syscall_exit(struct pt_regs *regs)
 	}
 }
 
+static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
 int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 {
 	int ret;
@@ -2411,8 +2421,7 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 		 syscall = syscall_get_nr(current, regs);
 	}
 
-	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
-			    regs->regs[2], regs->regs[3]);
+	syscall_enter_audit(regs, syscall);
 
 	return ret ? : syscall;
 }
-- 
2.34.1


