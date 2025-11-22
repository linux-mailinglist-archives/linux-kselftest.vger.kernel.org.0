Return-Path: <linux-kselftest+bounces-46300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB77C7C80F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994EF3A66C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2952B274FC2;
	Sat, 22 Nov 2025 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NnEnLTar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC827472;
	Sat, 22 Nov 2025 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790678; cv=none; b=lWoKiK+7WvD2Wa/Ze3fEiGoFquz1wHvBa4lC9PxFScsxTO91QXl/Qx3LGA4giinYS2vnIVixsVCS2bCPEnOUINxt+c9YLLLPX+LWaW8T3xf+tWRgH87HSX/Y6RfEl7gW8DCAHX7b9KtcDX8w2UlzXkd1C3U0OQWtQud2DklM1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790678; c=relaxed/simple;
	bh=a5e0WtmE31hjyJgzIO30tYa+3yYEus9iohkBFUET4TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWvDfKJdgIOScnSWzgJw8mbDg61y6YK0C0LBIy9VYpYLvNLwZADuDzyrO394rTvnprcI18O/sE7w8FKJyv7RC4bF+wBgv9dQ/YN6UO6bNp2MauBsaxzbcdoAFvk2HTbLZpAOG6m6IrErN576oPoAXQWpHuXXq8bdP5Q5eKlM+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NnEnLTar; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AnwA/qmj6OsksCBaVbOLbdcJ5EzsvrOTwevQOw/XH3U=; b=NnEnLTarqdBzDJi0nODi4YraZr
	G7bp0R8ESu5YQ7mpoMx10jddeS1L9ZaiFZnsHwSH/5+yh7VAtrT/AtmkBrfO3nGcwDpN90CdTsfAt
	XsZYVMvkEVdDbwzhJN0cx8KhTOJMOj0drme3mHRbbQ89KdP0FM5xe49AWOChJCYgXCODNRtbc+vT4
	eSjTDqEHhcyAnYPKb2z/z8rQ24HB6N5XXwabY/lP4NsiqQPaJBg0aPlrhj0UXLmoy6Sym7Skw1h98
	+ewieIgynNLafzHT9Zcy6ZIYnCmuFTVJ7WDKU4qjYfOac3ka61O0ii/kNzsCAZE9GNGTC3Utsv8vf
	LlY8jURw==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWc-003xEt-Dq; Sat, 22 Nov 2025 06:51:10 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:43 -0300
Subject: [PATCH v6 1/9] futex: Use explicit sizes for compat_robust_list
 structs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-1-05fea005a0fd@igalia.com>
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

There are two functions for handling robust lists during a task exit:
exit_robust_list() and compat_exit_robust_list(). The first one handles
either 64-bit or 32-bit lists, depending on the kernel bitness.
compat_exit_robust_list() exists only in 64-bit kernels that supports
32-bit syscalls entry points (also known as compat entry points).

The new syscall set_robust_list2() needs to handle both 64-bit and
32-bit robust lists, regardless of compat entry being enabled, so it
needs to have both functions always available.

In preparation for this, use explicit size for struct members of
compat_robust_list and compat_robust_list_head. Rename the structs and
compat_exit_robust_list() to make clear which bitness it handles.

Keep exit_robust_list() as it is: used to handle the native bit size of
the kernel.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/compat.h     | 13 +++----------
 include/linux/futex.h      |  2 +-
 include/linux/sched.h      |  2 +-
 include/uapi/linux/futex.h | 10 ++++++++++
 kernel/futex/core.c        | 20 ++++++++++----------
 kernel/futex/syscalls.c    |  8 ++++----
 6 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 56cebaff0c91..2c5a7f980182 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -385,15 +385,8 @@ struct compat_ifconf {
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
+struct robust_list32;
+struct robust_list_head32;
 
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
@@ -672,7 +665,7 @@ asmlinkage long compat_sys_waitid(int, compat_pid_t,
 		struct compat_siginfo __user *, int,
 		struct compat_rusage __user *);
 asmlinkage long
-compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
+compat_sys_set_robust_list(struct robust_list_head32 __user *head,
 			   compat_size_t len);
 asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f04980..322851e4a703 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -66,7 +66,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 {
 	tsk->robust_list = NULL;
 #ifdef CONFIG_COMPAT
-	tsk->compat_robust_list = NULL;
+	tsk->robust_list32 = NULL;
 #endif
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340c5866..76cabfab5b73 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1332,7 +1332,7 @@ struct task_struct {
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
 #ifdef CONFIG_COMPAT
-	struct compat_robust_list_head __user *compat_robust_list;
+	struct robust_list_head32 __user *robust_list32;
 #endif
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 7e2744ec8933..86efb089893d 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -153,6 +153,16 @@ struct robust_list_head {
 	struct robust_list __user *list_op_pending;
 };
 
+struct robust_list32 {
+	__u32 next;
+};
+
+struct robust_list_head32 {
+	struct robust_list32	list;
+	__s32			futex_offset;
+	__u32			list_op_pending;
+};
+
 /*
  * Are there any waiters for this robust futex:
  */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 125804fbb5cb..c99d7baab24e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1227,7 +1227,7 @@ static void __user *futex_uaddr(struct robust_list __user *entry,
  * Fetch a robust-list pointer. Bit 0 signals PI futexes:
  */
 static inline int
-compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
+fetch_robust_entry32(compat_uptr_t *uentry, struct robust_list __user **entry,
 		   compat_uptr_t __user *head, unsigned int *pi)
 {
 	if (get_user(*uentry, head))
@@ -1245,9 +1245,9 @@ compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **ent
  *
  * We silently return on any sign of list-walking problem.
  */
-static void compat_exit_robust_list(struct task_struct *curr)
+static void exit_robust_list32(struct task_struct *curr)
 {
-	struct compat_robust_list_head __user *head = curr->compat_robust_list;
+	struct robust_list_head32 __user *head = curr->robust_list32;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -1259,7 +1259,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
 	 */
-	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
+	if (fetch_robust_entry32(&uentry, &entry, &head->list.next, &pi))
 		return;
 	/*
 	 * Fetch the relative futex offset:
@@ -1270,7 +1270,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	 * Fetch any possibly pending lock-add first, and handle it
 	 * if it exists:
 	 */
-	if (compat_fetch_robust_entry(&upending, &pending,
+	if (fetch_robust_entry32(&upending, &pending,
 			       &head->list_op_pending, &pip))
 		return;
 
@@ -1280,8 +1280,8 @@ static void compat_exit_robust_list(struct task_struct *curr)
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
@@ -1413,9 +1413,9 @@ static void futex_cleanup(struct task_struct *tsk)
 	}
 
 #ifdef CONFIG_COMPAT
-	if (unlikely(tsk->compat_robust_list)) {
-		compat_exit_robust_list(tsk);
-		tsk->compat_robust_list = NULL;
+	if (unlikely(tsk->robust_list32)) {
+		exit_robust_list32(tsk);
+		tsk->robust_list32 = NULL;
 	}
 #endif
 
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 880c9bf2f315..1de8ff230d54 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -43,7 +43,7 @@ static inline void __user *futex_task_robust_list(struct task_struct *p, bool co
 {
 #ifdef CONFIG_COMPAT
 	if (compat)
-		return p->compat_robust_list;
+		return p->robust_list32;
 #endif
 	return p->robust_list;
 }
@@ -468,13 +468,13 @@ SYSCALL_DEFINE4(futex_requeue,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
-		struct compat_robust_list_head __user *, head,
+		struct robust_list_head32 __user *, head,
 		compat_size_t, len)
 {
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
-	current->compat_robust_list = head;
+	current->robust_list32 = head;
 
 	return 0;
 }
@@ -483,7 +483,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head = futex_get_robust_list_common(pid, true);
+	struct robust_list_head32 __user *head = futex_get_robust_list_common(pid, true);
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);

-- 
2.52.0


