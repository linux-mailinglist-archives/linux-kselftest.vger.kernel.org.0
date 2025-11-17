Return-Path: <linux-kselftest+bounces-45746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6241C6467E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBA25380AAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DA334C2A;
	Mon, 17 Nov 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l4fE+B9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDE333755;
	Mon, 17 Nov 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386282; cv=none; b=fsVqNcaZjnqktrXF8ErOTk8KFPibKSroEJkHzKz9yBzunSTbhWfw37ny5Tcqm96OaCV//KtQB0+yr3i/q5g1mDqclCTJ1+KxQ5dlZoXRPdrEu83jfF8oTEZV0bSIGBiTlGdHo4KGl2kErXMRqHmZRWnGHVo83gQ3B+e9U7DMr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386282; c=relaxed/simple;
	bh=Ju/mymHs/AiYsKpoIWu/nrpZTM9/XFNzstz5vCKBKhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCTl85bugrjqjaAnWWH2T0viPkTuEGJBU0LI74MXjRk3FlGPp/7CAVopoKsBspbRsvkhPoy16fA7jzMfhfaxMGFiEpCOQBdxsNp9BzP9vWKudK8Cx3XF4jlUPDRJm/D/fHmcK+TajYtsJyRZ/PKpWjTGiRmoIlLHbMlVhYLqhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l4fE+B9Z; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dLrfgy8TOLZhKOg9TpR8Wk1N6DHgABzMsigfkHUhMuM=;
	b=l4fE+B9ZcmKRodkU19wgUeoEYbjgTYiJpAhW1gBJsI9B/Gynd68hmIhfHa7TxofVBEQomoGl0
	0PcO+Wqg2f+Vr6G6/uZ2ZiO4UEwEofN8BNdj0lw66KGA6FMeebwcgT0+5ihTjN0L/txrb2caviJ
	N38zBiqZXgCt9kfZz4dPkvE=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d97rQ2ZghzpTKW;
	Mon, 17 Nov 2025 21:29:26 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 42291140277;
	Mon, 17 Nov 2025 21:31:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:16 +0800
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
Subject: [PATCH v7 09/11] entry: Add has_syscall_work() helper
Date: Mon, 17 Nov 2025 21:30:46 +0800
Message-ID: <20251117133048.53182-10-ruanjinjie@huawei.com>
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

Add has_syscall_work() helper to facilitate reuse of this
function in other places.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/entry-common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index cd6dacb2d8bf..e0f94e937e84 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -44,6 +44,11 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
+static inline bool has_syscall_work(unsigned long work)
+{
+	return unlikely(work & SYSCALL_WORK_ENTER);
+}
+
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
  * @regs:	Pointer to currents pt_regs
@@ -91,7 +96,7 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
-	if (work & SYSCALL_WORK_ENTER)
+	if (has_syscall_work(work))
 		syscall = syscall_trace_enter(regs, syscall, work);
 
 	return syscall;
-- 
2.34.1


