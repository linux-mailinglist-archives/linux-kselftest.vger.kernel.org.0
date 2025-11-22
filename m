Return-Path: <linux-kselftest+bounces-46302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80EBC7C824
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D4F3A764B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700D2BE7AC;
	Sat, 22 Nov 2025 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lcdsX+19"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074123A9A8;
	Sat, 22 Nov 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790680; cv=none; b=sRfC9wxmQZCBciDki/RYcRFZRe18bPu64cpn0J338RrF0adKl5nZ4/NJHsQQsAu1Tp1xU1xq7LwOC4004YCh0ZtayXwqjDcFMOEUSBTuFZUJ/Gy03n7PIG+37Ik+JBj30b3HFtJUpaqHNC49KDHVjZJA6HoiHhE3tPtzB56fo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790680; c=relaxed/simple;
	bh=/ZDJnQBlGNOSO0UEqHe5ew7N8SJnqbveSgGLUNHalYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnc5v0UJM4RNS+Jr6LGd8OshzqwP+21E2aNHIkUxbqXWCSYQ2dwqNCNbVO8DVxH4da3dHb0ZVvYAA0XxmVQJOH5qXG0mzDzPhxF/llAUhFdCr8p1vASjylc5PpLF/CbL278+zyaW/Q5WwteyE1KwCxpooidrz3ZAdEmVwkxKwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lcdsX+19; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GCIZbuTzPUqv8cOo26+OQpOYWfjT0BoJo6GaN8MM1i4=; b=lcdsX+19wsoj62dMx3773Pa7Pi
	mSFGS+JTRZ/10FW/T5WouKKsDcM4fON/X620huoSSoe2LpJoftx8/PuE6sEeFsDZvLhEKDllfj32I
	JZdBYzVlFAAN7L+85J4MIqXjigUQHiobXhq6pG0K0RQMmKWhhFAnR/qyGC7t8+b5nO2FYKAEvaYBg
	iPnlQjKPrYkrquw+z0gKuI1Wl/wb4oEiDccVPGR9sdoaHuGbbHI9lvBGUDDRM1z6zkvLbkdwjSkWy
	1ovsSs8uw4McA5bxRLrlwrBmBXbpEGXv5BPxow45Th3zdYi7SMo/NT/SZCLM8Doju+fAKXvNcIOXv
	RH7WZmlw==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWf-003xEt-Jf; Sat, 22 Nov 2025 06:51:13 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:44 -0300
Subject: [PATCH v6 2/9] futex: Make exit_robust_list32() unconditionally
 available for 64-bit kernels
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-2-05fea005a0fd@igalia.com>
References: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
In-Reply-To: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>, Ryan Houdek <Sonicadvance1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

The new syscall set_robust_list2() needs to handle both 64-bit and
32-bit robust lists, but not every 64-bit platform have compat entry
points. Make exit_robust_list32() unconditionally available for 64-bit
kernels regardless of having a compat configuration.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 kernel/futex/core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index c99d7baab24e..136639897ff9 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -31,7 +31,6 @@
  *  "The futexes are also cursed."
  *  "But they come in a choice of three flavours!"
  */
-#include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
@@ -1213,12 +1212,12 @@ static void exit_robust_list(struct task_struct *curr)
 	}
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_64BIT
 static void __user *futex_uaddr(struct robust_list __user *entry,
 				compat_long_t futex_offset)
 {
-	compat_uptr_t base = ptr_to_compat(entry);
-	void __user *uaddr = compat_ptr(base + futex_offset);
+	u32 base = (u32)(unsigned long)(entry);
+	void __user *uaddr = (void __user *)(unsigned long)(base + futex_offset);
 
 	return uaddr;
 }
@@ -1227,13 +1226,13 @@ static void __user *futex_uaddr(struct robust_list __user *entry,
  * Fetch a robust-list pointer. Bit 0 signals PI futexes:
  */
 static inline int
-fetch_robust_entry32(compat_uptr_t *uentry, struct robust_list __user **entry,
-		   compat_uptr_t __user *head, unsigned int *pi)
+fetch_robust_entry32(u32 *uentry, struct robust_list __user **entry,
+		     u32 __user *head, unsigned int *pi)
 {
 	if (get_user(*uentry, head))
 		return -EFAULT;
 
-	*entry = compat_ptr((*uentry) & ~1);
+	*entry = (void __user *)(unsigned long)((*uentry) & ~1);
 	*pi = (unsigned int)(*uentry) & 1;
 
 	return 0;
@@ -1251,8 +1250,8 @@ static void exit_robust_list32(struct task_struct *curr)
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
-	compat_uptr_t uentry, next_uentry, upending;
-	compat_long_t futex_offset;
+	u32 uentry, next_uentry, upending;
+	s32 futex_offset;
 	int rc;
 
 	/*
@@ -1412,7 +1411,7 @@ static void futex_cleanup(struct task_struct *tsk)
 		tsk->robust_list = NULL;
 	}
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_64BIT
 	if (unlikely(tsk->robust_list32)) {
 		exit_robust_list32(tsk);
 		tsk->robust_list32 = NULL;

-- 
2.52.0


