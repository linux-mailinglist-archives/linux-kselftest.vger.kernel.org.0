Return-Path: <linux-kselftest+bounces-46474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A6C885D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7AD3351029
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4A296BB6;
	Wed, 26 Nov 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FbNzI9bu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C028A701;
	Wed, 26 Nov 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141305; cv=none; b=Cj6CmEKL24S7XKjlBiaW05GUW14F3lXV3se4Sw94+Ff11VdnFL/EOu38u74+cmAnuG2ozcc44oAvioEorWlkkh7Jh0nyhCakhv8UQ3MKXnjolJV1YyY9qW4vGCDiyHKn3KZzWY6m+IJcQYHJVClRBtJEvzuZbu/gDRxDNEJeeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141305; c=relaxed/simple;
	bh=5xMVBUub1MeUZzPm6Olt/iG99dQDj/5ngIJYS/XDj4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is3UL5gcSBIcNeIcvEYXVEh/HU3cgiYyByk9q/Zn0nfn4AmMxxE4lrEdAQFiH9bxvS1ufe6J57i/BtINYR5EMGwJGfOmUVEMgrjX21KEUMNobWzFKpfXwarUaxqFxf9/T1/iWKC6FY5NNRMzrJvl3gAhwUsAS9ZFLtAbrqMyj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FbNzI9bu; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m++Ja64toY4JijKddK95sxr6F/f7jZN65PAWtoxPrwY=;
	b=FbNzI9buM0hOoUbnLtRtni5vHYvIF/zsLUz9S7ckh5JUo9M1cesPBjinHXC1ZdfcQ6VRKW4c5
	SEMOsqeNDZS/TXOFcgEt7JFu6JvGowkSdLbswpIVk0S+EkPymXprGLCE+KFP4ztYQxzFwmXLsjG
	znCXFcPeMJAqyKBfpqYW7R4=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dGW442brsz1K971;
	Wed, 26 Nov 2025 15:13:08 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C8BF140294;
	Wed, 26 Nov 2025 15:14:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Nov
 2025 15:14:53 +0800
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
Subject: [PATCH v8 01/12] arm64: Remove unused _TIF_WORK_MASK
Date: Wed, 26 Nov 2025 15:14:35 +0800
Message-ID: <20251126071446.3234218-2-ruanjinjie@huawei.com>
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

Since commit b3cf07851b6c ("arm64: entry: Switch to generic IRQ
entry"), _TIF_WORK_MASK is never used, so remove it.

Fixes: b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry")
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


