Return-Path: <linux-kselftest+bounces-47837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D6CD5E37
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1EF3053B2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCDD329E69;
	Mon, 22 Dec 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yuCEvVky"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE731E0F2;
	Mon, 22 Dec 2025 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404116; cv=none; b=SBh+vQhMiSfADEPtZNWMXZgXCn2mk/gs1943eRPoqjr+6jDluGNq9IjSeZLXwPR4I6hm0E6GFl469EE1LzriDqfPM2d3bx3SSnzJuS0UtH9qLfvJd1cc3Vxd+401XUMfRZYGC3Aqfv8wLHoHTQV1zrwYKbFeI8AEss4YVslJX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404116; c=relaxed/simple;
	bh=XIa4OdxYwiMnsFqS6guEHGiJWxCxujFLYiqMPPn3iX0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7YQE19r8sG9y+HTsRMwEJdqLBs7AHfkhMgvTC+9JjPy7l2UAtR+oDkyO+BUD0YkzIryJd/hqsaoDGv27E+NRujzWThaIGswC1Fudv4k7IJ66LwBZSHYrhp4SzZYGK00V0AJEFLWlQ5QUl4RKswLAx2EVoIrMQiMKWsAWtTneYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yuCEvVky; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8fKGogfif+HoCc3kIHvnvF0L83fYROr/QiADL9niEfU=;
	b=yuCEvVkyfc05tkT4jKX7cVdfIsnF2cOHQsg2SnhRSGWdEk+Ht4711wBNARx7ofXrYY5PajHwc
	mdilYBz98ektLNmkeD2/cPrkKDS6Q3/ANBbxt5e5f1KHYkuZRSSQkPIvHNq/jUdHaYrCeW+SzID
	if3uDh86yDbFcaEmaZGeXJs=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dZbt86Y6jzmV6t;
	Mon, 22 Dec 2025 19:45:20 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 5280D4056B;
	Mon, 22 Dec 2025 19:48:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Dec
 2025 19:48:25 +0800
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
Subject: [PATCH v10 10/16] arm64/ptrace: Use syscall_get_arguments() helper
Date: Mon, 22 Dec 2025 19:47:31 +0800
Message-ID: <20251222114737.1334364-11-ruanjinjie@huawei.com>
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
index a1922e4a6437..2645ddf77369 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2407,6 +2407,16 @@ static void report_syscall_exit(struct pt_regs *regs)
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
@@ -2437,8 +2447,7 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 		 syscall = syscall_get_nr(current, regs);
 	}
 
-	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
-			    regs->regs[2], regs->regs[3]);
+	syscall_enter_audit(regs, syscall);
 
 	return ret ? : syscall;
 }
-- 
2.34.1


