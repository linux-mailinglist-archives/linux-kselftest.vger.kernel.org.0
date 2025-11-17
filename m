Return-Path: <linux-kselftest+bounces-45744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86697C6469C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 14:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF64138052E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136133437C;
	Mon, 17 Nov 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pnc6gW7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41613333427;
	Mon, 17 Nov 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386281; cv=none; b=OxIykw3gZCGWl5aYLuB51EUtHmx9SL6MBr8qupX/1tQQTR2OZnn36f8opKWUwrkcqLLd2kXlXANpKVCNAdrJprswokbl7ZKhr+bjR5J0lMQ8toOVH/sg6suMHexOzGkoWhkXZ6XYGk2oVOAFAay7RocY8GqZh8YZiSDExXvM8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386281; c=relaxed/simple;
	bh=JIaz9zgfcVFK3ca6qDzFvUQP6GbZmkf7k9Apn3brebY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkpdx/ccZw1CqJ4/YiOAWsCQA+kTbnq9G73dlvkS9LZmevVFeO+Nm0I1zSScKSULqRGvS4MazFzwDc4sib7UR5Ul1NaW+RJL3lMrbdct0w4hAEM4SB3hcwzV7yft/ZOOPHJrxSUO3pUrDlfjASclU/k+LI/KUzMMU1D9eCgBx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pnc6gW7e; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=L7VSQzrso9GSPLc8m0QenwYICMxW9oDwCZBjF11X5ag=;
	b=pnc6gW7eV6qXsHPrMzzc+1zBhX5PMceiCd1YbXc0Ij2ZQKwwNIXX6586xpe/44NNKqp92FxRe
	KLkIjSlAFHiXQAuzR4SzdX+F2b9s0CUzEP6/zCxmA5DEnM932nDKCe0RkHYm/wDubEkBmrqMWzs
	zYM4yx+QIx44xM7UxHf54S8=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d97rH2l06zpSyw;
	Mon, 17 Nov 2025 21:29:19 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 480FC140202;
	Mon, 17 Nov 2025 21:31:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:31:09 +0800
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
Subject: [PATCH v7 04/11] entry: Add syscall_exit_to_user_mode_prepare() helper
Date: Mon, 17 Nov 2025 21:30:41 +0800
Message-ID: <20251117133048.53182-5-ruanjinjie@huawei.com>
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

In the generic entry code, the part before
syscall_exit_to_user_mode_work() calls syscall_exit_work(), which
serves the same purpose as syscall_exit_to_user_mode_prepare()
in arm64.

In preparation for moving arm64 over to the generic entry
code, extract syscall_exit_to_user_mode_prepare() helper from
syscall_exit_to_user_mode_work().

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/entry-common.h | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 7177436f0f9e..cd6dacb2d8bf 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -137,20 +137,11 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
  */
 void syscall_exit_work(struct pt_regs *regs, unsigned long work);
 
-/**
- * syscall_exit_to_user_mode_work - Handle work before returning to user mode
- * @regs:	Pointer to currents pt_regs
- *
- * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
- * exit_to_user_mode() to perform the final transition to user mode.
- *
- * Calling convention is the same as for syscall_exit_to_user_mode() and it
- * returns with all work handled and interrupts disabled. The caller must
- * invoke exit_to_user_mode() before actually switching to user mode to
- * make the final state transitions. Interrupts must stay disabled between
- * return from this function and the invocation of exit_to_user_mode().
+/*
+ * Syscall specific exit to user mode preparation. Runs with interrupts
+ * enabled.
  */
-static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long nr = syscall_get_nr(current, regs);
@@ -171,6 +162,24 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 	 */
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
+}
+
+/**
+ * syscall_exit_to_user_mode_work - Handle work before returning to user mode
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
+ * exit_to_user_mode() to perform the final transition to user mode.
+ *
+ * Calling convention is the same as for syscall_exit_to_user_mode() and it
+ * returns with all work handled and interrupts disabled. The caller must
+ * invoke exit_to_user_mode() before actually switching to user mode to
+ * make the final state transitions. Interrupts must stay disabled between
+ * return from this function and the invocation of exit_to_user_mode().
+ */
+static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	syscall_exit_to_user_mode_prepare(regs);
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
 }
-- 
2.34.1


