Return-Path: <linux-kselftest+bounces-46304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3A5C7C830
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04C1D4E3AC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B82C0F97;
	Sat, 22 Nov 2025 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z23pwq8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507142C0F70;
	Sat, 22 Nov 2025 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790686; cv=none; b=Rs2VB0MBgKJwZUfeR3yye4f7arD4wEonlcbqgWXTlheHMwS2nLcZuFj2P9kLbS3E4sLRAZHSqq6whVaWdDWw5gLjqN1IApFbXlAbiJ2Lxq/UGE/kZdJ/F9YJoPIIcUdkP/81LurgUZqsdUwFs0c39ivHx/17oT8ASY9fKNu+yKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790686; c=relaxed/simple;
	bh=nkYmmv40aQmszbGW+EkkDhVeSBD05ty26Ze+T0qLGD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhqT9T3XW+detiUcVVeImjqQX5bMzpgxUcMFDR5Djzvs3Gnyenfcx14lDuSxXpPUVAW12x5LTVQ7nBLOadBCzoG07wA3ZA2yzWJ3kH6VpnQXXOpHIuGAQjDY6krKvTs/x3E7R4DPcb8ZjZ86UCLsvkGEBlLIcuM0sThxwQJPReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z23pwq8o; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fz2SZAzQPFBi1wyteXTSmIxEEVHmQhv7pKOpper8CGI=; b=Z23pwq8oj0Fwx/0spVYX8rpPbO
	mMjtRNFAtDmCbWzGUOOU6WTsATQgjoY4UT78065ugrfXQPYxsUq3LlA3W3/3IKCVpQ9S666+0UXf0
	kZuRducn9ND0psBSIrXRiLIz2NDWS2NZ0YIBPr4jfUI8dM9q4rqSFC7D52MfynohJ12t/gLnobH1P
	+xUkBsU3fjwdoAeYrWQEfbTlq4X4SQJo+oegA8tY17jshYX1bvh2sOGqv6YuORfJ7DN9ZmTWA0VGQ
	V8u0hDeqzYwJzyg59tl4EOoAynykMBKwbiL5iGbNSaII/YagVAqi4AQX38YRt1w1lxWwG7nugC84M
	2w5XcRYA==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWl-003xEt-Vb; Sat, 22 Nov 2025 06:51:19 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:46 -0300
Subject: [PATCH v6 4/9] futex: Create get_robust_list2() syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-4-05fea005a0fd@igalia.com>
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

As in the original robust list interface, to pair with
set_robust_list2(), create a get_robust_list2() syscall with the
following signature:

  get_robust_list2(int pid, void __user **head_ptr, unsigned int index,
		   unsigned int flags)

  - `pid` sets with task's list should be returned. If is 0, it gets the
    list of the calling task.
  - `index` is the index of the list to get
  - `flags` is unused but can be used for expanding the interface

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
For some reason I wasn't able to use put_user() for 32-bit lists.. it
kept corrupting the value due to wrong write size I believe.
copy_to_user() worked fine nonetheless.
---
 kernel/futex/syscalls.c | 61 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 0b7fa88aa34c..f730d16632fc 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -48,7 +48,7 @@ static inline void __user *futex_task_robust_list(struct task_struct *p, bool co
 	return p->robust_list;
 }
 
-static void __user *futex_get_robust_list_common(int pid, bool compat)
+static void __user *futex_get_robust_list_common(int pid, bool compat, int index)
 {
 	struct task_struct *p = current;
 	void __user *head;
@@ -75,7 +75,15 @@ static void __user *futex_get_robust_list_common(int pid, bool compat)
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = futex_task_robust_list(p, compat);
+	if (index >= 0) {
+		scoped_guard(mutex, &p->futex_exit_mutex) {
+			uintptr_t *rl = p->futex_robust_lists;
+
+			head = rl ? (void __user *) rl[index] : NULL;
+		}
+	} else {
+		head = futex_task_robust_list(p, compat);
+	}
 
 	up_read(&p->signal->exec_update_lock);
 	put_task_struct(p);
@@ -99,7 +107,7 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 		struct robust_list_head __user * __user *, head_ptr,
 		size_t __user *, len_ptr)
 {
-	struct robust_list_head __user *head = futex_get_robust_list_common(pid, false);
+	struct robust_list_head __user *head = futex_get_robust_list_common(pid, false, -1);
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -150,6 +158,51 @@ SYSCALL_DEFINE4(set_robust_list2, struct robust_list_head *, head, unsigned int,
 	return -EINVAL;
 }
 
+SYSCALL_DEFINE4(get_robust_list2, int, pid,
+		void __user * __user *, head_ptr,
+		unsigned int, index, unsigned int, flags)
+{
+	void __user *entry_ptr;
+	uintptr_t entry;
+
+	if (index >= FUTEX_ROBUST_LISTS_PER_USER)
+		return -EINVAL;
+
+	if (flags)
+		return -EINVAL;
+
+	/*
+	 * The first two indexes are reserved for the kernel to be used with the
+	 * legacy syscall, so we hide them from userspace.
+	 *
+	 * We map [0, FUTEX_ROBUST_LISTS_PER_USER) to
+	 *  [FUTEX_ROBUST_LIST2_IDX, FUTEX_ROBUST_LIST2_MAX_IDX)
+	 */
+	index += FUTEX_ROBUST_LIST2_IDX;
+
+	entry_ptr = futex_get_robust_list_common(pid, false, index);
+	if (IS_ERR(entry_ptr))
+		return PTR_ERR(entry_ptr);
+
+	entry = (uintptr_t) entry_ptr;
+
+	if (entry & FUTEX_ROBUST_LIST_ENTRY_32BIT) {
+		entry &= FUTEX_ROBUST_LIST_ENTRY_MASK;
+
+		if (copy_to_user(head_ptr, &entry, sizeof(u32)))
+			return -EFAULT;
+
+		return 0;
+	} else {
+		struct robust_list_head *head;
+
+		entry &= FUTEX_ROBUST_LIST_ENTRY_MASK;
+		head = (__force struct robust_list_head __user *)entry;
+
+		return put_user(head, head_ptr);
+	}
+}
+
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
@@ -524,7 +577,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct robust_list_head32 __user *head = futex_get_robust_list_common(pid, true);
+	struct robust_list_head32 __user *head = futex_get_robust_list_common(pid, true, -1);
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);

-- 
2.52.0


