Return-Path: <linux-kselftest+bounces-35876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C83AEA42F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F984E32A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A378F2ED867;
	Thu, 26 Jun 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OY5Yq3Yv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC42ED152;
	Thu, 26 Jun 2025 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957988; cv=none; b=YG2467vBnotLREBJLdzprkEc4K3AgL9pKQKCKSuXeEJ7Y6FmlNZ0O6ekJI/2hgpWeGvbzfPCxgCOtwgTVoAJdWuueyIYtnDdMoNtOKW7yvMOCfPUQAnOEtw2AyNffzNzAR7LhNDTr8Y6Agehq/oGKy01gIYTThkxrAokeTKYbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957988; c=relaxed/simple;
	bh=CUtwUKXDz4DkNMp5YBD/tJDHmFUCeORwEy4IRtoJ3G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcySRtwdqCRpEj64CRiFOftXcePF4yIa3A/WjtzZPe9TnMm8DId2ELwY0Kl0WGRzgSmnQTeuj4PFF90hMyfr5GeKAFTb1M725pvW+XNrkA5rOBq+weM2jCnResVFCTDCrs9cDFYc+e6k3GlPvJtCTmJpP0OroigU/za/2jCWJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OY5Yq3Yv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yf/WUr3lC/ecExHg82fOS+TmR2AOfqu+uEiB301mkDI=; b=OY5Yq3YvcnkztpfBbZL/6wXXpC
	WkuVdVPov3ok8JORX+pGJp255DoYSRC81zMCWBHcQ7FJoj+RZJZfZdj9Thp4GlOmbbNf8w2w4A9dd
	cC0Jj0Lp019kupc/HDSzZocIoP3VYJBP2t5Uo1oi6zGu8uhGcOfcjSA+ePwDW/cmz+FcsIWrf9FKl
	DxXD7RpMFkM0uu9aQi5aX8pLR6DjgMX6+lbR8oI9Mzt7g7PwItkjGXi8JzXn+rCK66ctbL4T2Ycoy
	IK/PT96RVWDRRDMPNJh2aw3md3mpFO8PbURaugvr3jo2KDlInN6+L1AkVyS3tWX3alNkqCWyWAsy9
	P32EUVCA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uUq9o-009491-B1; Thu, 26 Jun 2025 19:13:04 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 26 Jun 2025 14:11:27 -0300
Subject: [PATCH v5 3/7] futex: Use explicit sizes for
 compat_exit_robust_list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-tonyk-robust_futex-v5-3-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
In-Reply-To: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

There are two functions for handling robust lists during the task
exit: exit_robust_list() and compat_exit_robust_list(). The first one
handles either 64bit or 32bit lists, depending if it's a 64bit or 32bit
kernel. The compat_exit_robust_list() only exists in 64bit kernels that
supports 32bit syscalls, and handles 32bit lists.

For the new syscall set_robust_list2(), 64bit kernels need to be able to
handle 32bit lists despite having or not support for 32bit syscalls, so
make compat_exit_robust_list() exist regardless of compat_ config.

Also, use explicitly sizing, otherwise in a 32bit kernel both
exit_robust_list() and compat_exit_robust_list() would be the exactly
same function, with none of them dealing with 64bit robust lists.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/compat.h  | 12 +-----------
 include/linux/futex.h   | 10 ++++++++++
 include/linux/sched.h   |  2 +-
 kernel/futex/core.c     | 48 ++++++++++++++++++++++++++++++++----------------
 kernel/futex/syscalls.c |  4 ++--
 5 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 56cebaff0c910fda853a0e2b3d6d0517e55f8b38..968a9135ff486cf9c8be2a18b80cd4c46e890236 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -385,16 +385,6 @@ struct compat_ifconf {
 	compat_caddr_t  ifcbuf;
 };
 
-struct compat_robust_list {
-	compat_uptr_t			next;
-};
-
-struct compat_robust_list_head {
-	struct compat_robust_list	list;
-	compat_long_t			futex_offset;
-	compat_uptr_t			list_op_pending;
-};
-
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
 	compat_uptr_t			sa_handler;
@@ -672,7 +662,7 @@ asmlinkage long compat_sys_waitid(int, compat_pid_t,
 		struct compat_siginfo __user *, int,
 		struct compat_rusage __user *);
 asmlinkage long
-compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
+compat_sys_set_robust_list(struct robust_list_head32 __user *head,
 			   compat_size_t len);
 asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
diff --git a/include/linux/futex.h b/include/linux/futex.h
index b37193653e6b5d7d562ac08f93d4ee41eb8e72a2..c5b6976909c7d51360e1831e017f4d1544c258fa 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -55,6 +55,16 @@ union futex_key {
 
 #define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = 0ULL } }
 
+struct robust_list32 {
+	u32 next;
+};
+
+struct robust_list_head32 {
+	struct robust_list32	list;
+	s32			futex_offset;
+	u32			list_op_pending;
+};
+
 #ifdef CONFIG_FUTEX
 enum {
 	FUTEX_STATE_OK,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52c425e46c66427b2f608ba30b3d99..b0f64029d53e8b2ab56f24f77054aa7645a185c5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1333,7 +1333,7 @@ struct task_struct {
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
 #ifdef CONFIG_COMPAT
-	struct compat_robust_list_head __user *compat_robust_list;
+	struct robust_list_head32 __user *compat_robust_list;
 #endif
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 90d53fb0ee9e1563c355ef0499df441367e1a46c..f0ac4b897ddbb667fa85daf5853cb47c749d512d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1144,15 +1144,16 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
 	return 0;
 }
 
+#ifdef CONFIG_64BIT
 /*
  * Walk curr->robust_list (very carefully, it's a userspace list!)
  * and mark any locks found there dead, and notify any waiters.
  *
  * We silently return on any sign of list-walking problem.
  */
-static void exit_robust_list(struct task_struct *curr)
+static void exit_robust_list64(struct task_struct *curr,
+			       struct robust_list_head __user *head)
 {
-	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -1211,8 +1212,15 @@ static void exit_robust_list(struct task_struct *curr)
 				   curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
+#else
+static void exit_robust_list64(struct task_struct *curr,
+			       struct robust_list_head __user *head)
+{
+	pr_warn("32bit kernel should not allow ROBUST_LIST_64BIT");
+}
+#endif
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT) || !defined(CONFIG_64BIT)
 static void __user *futex_uaddr(struct robust_list __user *entry,
 				compat_long_t futex_offset)
 {
@@ -1226,13 +1234,13 @@ static void __user *futex_uaddr(struct robust_list __user *entry,
  * Fetch a robust-list pointer. Bit 0 signals PI futexes:
  */
 static inline int
-compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
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
@@ -1244,21 +1252,21 @@ compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **ent
  *
  * We silently return on any sign of list-walking problem.
  */
-static void compat_exit_robust_list(struct task_struct *curr)
+static void exit_robust_list32(struct task_struct *curr,
+			       struct robust_list_head32 __user *head)
 {
-	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
-	compat_uptr_t uentry, next_uentry, upending;
-	compat_long_t futex_offset;
+	u32 uentry, next_uentry, upending;
+	s32 futex_offset;
 	int rc;
 
 	/*
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
 	 */
-	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
+	if (fetch_robust_entry32((u32 *)&uentry, &entry, (u32 *)&head->list.next, &pi))
 		return;
 	/*
 	 * Fetch the relative futex offset:
@@ -1269,7 +1277,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	 * Fetch any possibly pending lock-add first, and handle it
 	 * if it exists:
 	 */
-	if (compat_fetch_robust_entry(&upending, &pending,
+	if (fetch_robust_entry32(&upending, &pending,
 			       &head->list_op_pending, &pip))
 		return;
 
@@ -1279,8 +1287,8 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		 * Fetch the next entry in the list before calling
 		 * handle_futex_death:
 		 */
-		rc = compat_fetch_robust_entry(&next_uentry, &next_entry,
-			(compat_uptr_t __user *)&entry->next, &next_pi);
+		rc = fetch_robust_entry32(&next_uentry, &next_entry,
+			(u32 __user *)&entry->next, &next_pi);
 		/*
 		 * A pending lock might already be on the list, so
 		 * dont process it twice:
@@ -1406,14 +1414,22 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
 
 static void futex_cleanup(struct task_struct *tsk)
 {
+#ifdef CONFIG_64BIT
 	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk);
+		exit_robust_list64(tsk, tsk->robust_list);
 		tsk->robust_list = NULL;
 	}
+#else
+	if (unlikely(tsk->robust_list)) {
+		exit_robust_list32(tsk,
+				  (struct robust_list_head32 __user *) tsk->robust_list);
+		tsk->robust_list = NULL;
+	}
+#endif
 
 #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list)) {
-		compat_exit_robust_list(tsk);
+		exit_robust_list32(tsk, tsk->compat_robust_list);
 		tsk->compat_robust_list = NULL;
 	}
 #endif
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6c33db9796e3055ce0c90b02d7b91..dba193dfd216cc929c8f4d979aa2bcd99237e2d8 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -440,7 +440,7 @@ SYSCALL_DEFINE4(futex_requeue,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
-		struct compat_robust_list_head __user *, head,
+		struct robust_list_head32 __user *, head,
 		compat_size_t, len)
 {
 	if (unlikely(len != sizeof(*head)))
@@ -455,7 +455,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head;
+	struct robust_list_head32 __user *head;
 	unsigned long ret;
 	struct task_struct *p;
 

-- 
2.49.0


