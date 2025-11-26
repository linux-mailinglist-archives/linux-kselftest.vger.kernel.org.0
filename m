Return-Path: <linux-kselftest+bounces-46483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DBC8860F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47BD33567CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 07:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541331A81F;
	Wed, 26 Nov 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NhK9ppcL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C27314D39;
	Wed, 26 Nov 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141318; cv=none; b=C54QY7y77BL8mxrNM0du9ZsYRqkRZ9/qI5lS5a5FPr5PPI4YDpdEr6WKoAC7dhEtb1oXNI/CGIU89CKNxd28ubeHnclu5++/fwlYecNLpZm60sdotXPU8hIiZzZ4bNKYE8rSFzDCC7AAPzMFPOEe08Y1TptR7zYgdJaWBbuii2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141318; c=relaxed/simple;
	bh=aG3AtmF12usEsGwSmhyCvpHZGV9MRNSl927bSKCYh7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxwnU3ZP5k+g+smAl05aldjbluw/ENxygVFDP2Mb/Yrjcz9h+Yxa/kC01zFUN3xGP4XW8ODq4DAzJQZxNG10IGR4suaEcuVWdAJA/9VXbV/UbDNs4SYvoMHRh3FK4XOuBVWy87M//gmHcuJ8xF698AOtPeyuBtOWLqTR3PT1gaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NhK9ppcL; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zPp8W18dzKYIBqBnjquNPhOqVoaG0FMhWX+NDOwrn4c=;
	b=NhK9ppcLQDrNCw6cFujodotPhX3lZNsAYQNqCP8YKfcc/cLjXC0ysfx2bhBsk3gljIdo4ME5L
	t4mGHzez+44xFycMyLfskDGBQffytq++yacV/eJ079CyOIhY9ouaEB5YCfDg2WblY9xKeN1diCb
	Ta7gWv+Fyi7FZoqRY6VdHpg=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dGW4l3Wtfz12LFc;
	Wed, 26 Nov 2025 15:13:43 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 382D9180483;
	Wed, 26 Nov 2025 15:15:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Nov
 2025 15:15:05 +0800
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
Subject: [PATCH v8 09/12] entry: Split syscall_exit_to_user_mode_work() for arch reuse
Date: Wed, 26 Nov 2025 15:14:43 +0800
Message-ID: <20251126071446.3234218-10-ruanjinjie@huawei.com>
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

In the generic entry code, the beginning of
syscall_exit_to_user_mode_work() can be reused on arm64 so it makes
sense to split it.

In preparation for moving arm64 over to the generic entry
code, split out syscall_exit_to_user_mode_prepare() helper from
syscall_exit_to_user_mode_work().

No functional changes.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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


