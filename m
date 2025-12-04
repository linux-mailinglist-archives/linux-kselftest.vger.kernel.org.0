Return-Path: <linux-kselftest+bounces-46977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A85CA2C8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D4930443F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDA32E131;
	Thu,  4 Dec 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JY8IUHs7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972E1DE4E1;
	Thu,  4 Dec 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836509; cv=none; b=h0Ds/vHaic46+bclMZarzboIbNK18ZokYfrb8rCGlNJq9R2xFiiAaZs7iyoC6/iEVi3UmxcdFo2Rs2Mg3JPWxXlLJDR7JAZXcyGt4PQ3pg7LNC8XY+gAco7axIXyjGEs+eUrjQUAqKo8m8AJdhdexl3JMbWKvCBQQMWNA4VDpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836509; c=relaxed/simple;
	bh=idyf09D6tOB0/uzZlkWttdz/d4L/WHUrRd3VToT22Ps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H01lomW6ZBBulzSEBPMN61PENcT7rONlwq4C4VRviJzf8cQUk+UJlwORj7pu8Yh1MB0l7W+kvxyw28bkN9ujsFUAW8tDVlHQL1VtSzloQHwazCo7VijUo9KfMEbHULuqcAoeZ9GIazESEksWeBKBpsrRItLnNcETZpji+YGj0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JY8IUHs7; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AGNGLldXdwgNCoRM5ubKMGAygKrSJsujNI1vY4gMRis=;
	b=JY8IUHs7y0MFUzY7IBLbrLKYoAHxHR8Cq7PdrH2f2hNrHwdqng3bbBVLlZ4tS+hZ+Co+ZTSQW
	hY23FB9q9oYoOQyKFhv64H58Vi4AKyrA212VKKdNX8r8IlwC8Y90fxvhpFzBVEqO6kEVhbb0ABm
	nfmCn+UhuOkUtl/CXw32edU=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dMS8d43kgzcb1N;
	Thu,  4 Dec 2025 16:19:13 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F0C214027A;
	Thu,  4 Dec 2025 16:21:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:41 +0800
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
Subject: [PATCH v9 01/16] arm64: Remove unused _TIF_WORK_MASK
Date: Thu, 4 Dec 2025 16:21:08 +0800
Message-ID: <20251204082123.2792067-2-ruanjinjie@huawei.com>
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

Since commit b3cf07851b6c ("arm64: entry: Switch to generic IRQ
entry"), _TIF_WORK_MASK is never used, so remove it.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/thread_info.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f241b8601ebd..ff4998fa1844 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -106,12 +106,6 @@ void arch_setup_new_exec(void);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
 
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
-				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
-				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING | \
-				 _TIF_PATCH_PENDING)
-
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_SYSCALL_EMU)
-- 
2.34.1


