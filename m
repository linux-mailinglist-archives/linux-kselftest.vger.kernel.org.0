Return-Path: <linux-kselftest+bounces-46309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4EAC7C869
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A33D3A9D3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29F2D4816;
	Sat, 22 Nov 2025 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="W7D3ePx8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390F2D3A70;
	Sat, 22 Nov 2025 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790701; cv=none; b=rmEJvyH8nv+HGLKKydsoli8CvX01y9uxlGk8bOPVTeF0aNSWreyutKWOi29cF51WZhSaZLvjnwLpu4nQr/sAlAtH9lQD9FcJBZrLkWUg803aJoyNL8jSkgzPr57CdgMIugflYEpQIe6alrwd8ZHFLFaMg7GuAhy22Orj3uwjTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790701; c=relaxed/simple;
	bh=LwIHhYXeFJeDdF1kDSEARDffQgz5dUmhKnAXQwo8Pn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjUFhwvHJkAdzFZJlDYGMIZwZtafAZBHWS3HSyezNwSDmFv/c/lbTV/RWwLWspJjYtPSgZdO52d9yNnHUrxvNnjTYMjGBecv84TuM1jU2p1xNm7OqRIO1UOkqzeOTTTIhAGy0yCf8DkjaIiNJwRpjzOidz1Hv5V4474qkRMpOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=W7D3ePx8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zOjPGE9lsonyPtm0p0zdTTkMf2zbS0u2zhJUFebOEG0=; b=W7D3ePx87PMqrJQuCOV3NeJPG3
	kBh6S/y74nERtLvLkl3MoJZ2WWgWlKUQm6Mt1c061jzVhiCqLHmCE0mq9QtzPpK05VLiZGFYnVC12
	CXdaXCgjPfVC+gMogBHGG5ip9vMRSqKreNNvORDYHFPzzPsQIJIY5JMqNY4G7ucre7wWwN4P1m/VL
	EdtH+V2/goa9iM6Z38OZLJpTJKlEA1toqO5RVP/iMXCzKir8JE/zRcEtDlALO0h4ts+NdPkHw8TKw
	XzR3S7un+kAnASjAhmFQTc8hb8aCNviGuvDP0WmvuScNNzyH5SXAa8YsrInJsYGW8KlohoX5ALpKI
	vzkQX3gg==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgX1-003xEt-SV; Sat, 22 Nov 2025 06:51:35 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:51 -0300
Subject: [PATCH v6 9/9] futex: Use new robust list API internally
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-9-05fea005a0fd@igalia.com>
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

The new robust list API internals can handle any kind of robust list, so
to simplify the code, reuse the same mechanisms for the original API and
when calling the original set syscall, set the head in the array of
lists. The first two indexes of the array of robust lists are reserved
for the original API lists, the native robust list and the compat robust
list.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/futex.h   |  4 ----
 include/linux/sched.h   |  5 -----
 kernel/futex/core.c     | 12 ------------
 kernel/futex/syscalls.c | 52 ++++++++++++++++++++++++-------------------------
 4 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 3dba249bcd32..ce27f6307c60 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -87,10 +87,6 @@ static inline bool futex_in_32bit_syscall(void)
 
 static inline void futex_init_task(struct task_struct *tsk)
 {
-	tsk->robust_list = NULL;
-#ifdef CONFIG_COMPAT
-	tsk->robust_list32 = NULL;
-#endif
 	tsk->futex_robust_lists = NULL;
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index de2f3cbe4953..e0f28e7f0a2d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -75,7 +75,6 @@ struct pid_namespace;
 struct pipe_inode_info;
 struct rcu_node;
 struct reclaim_state;
-struct robust_list_head;
 struct root_domain;
 struct rq;
 struct sched_attr;
@@ -1330,11 +1329,7 @@ struct task_struct {
 	u32				rmid;
 #endif
 #ifdef CONFIG_FUTEX
-	struct robust_list_head __user	*robust_list;
 	uintptr_t			*futex_robust_lists;
-#ifdef CONFIG_COMPAT
-	struct robust_list_head32 __user *robust_list32;
-#endif
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
 	struct mutex			futex_exit_mutex;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 14d8a7176367..f91df175033d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1500,18 +1500,6 @@ static void exit_robust_lists(struct task_struct *tsk)
 
 static void futex_cleanup(struct task_struct *tsk)
 {
-	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk, tsk->robust_list);
-		tsk->robust_list = NULL;
-	}
-
-#ifdef CONFIG_64BIT
-	if (unlikely(tsk->robust_list32)) {
-		exit_robust_list32(tsk, tsk->robust_list32);
-		tsk->robust_list32 = NULL;
-	}
-#endif
-
 	if (unlikely(tsk->futex_robust_lists))
 		exit_robust_lists(tsk);
 
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index f730d16632fc..2a44791db37a 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -28,32 +28,29 @@
 SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 		size_t, len)
 {
+	enum robust_list2_cmd cmd;
 	/*
 	 * The kernel knows only one size for now:
 	 */
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
-	current->robust_list = head;
+	cmd = IS_ENABLED(CONFIG_64BIT) ? FUTEX_ROBUST_LIST_CMD_SET_64 :
+	      FUTEX_ROBUST_LIST_CMD_SET_32;
 
-	return 0;
+	return futex_robust_list_set((uintptr_t) head, cmd,
+				     FUTEX_ROBUST_LIST_NATIVE_IDX);
 }
 
-static inline void __user *futex_task_robust_list(struct task_struct *p, bool compat)
-{
-#ifdef CONFIG_COMPAT
-	if (compat)
-		return p->robust_list32;
-#endif
-	return p->robust_list;
-}
-
-static void __user *futex_get_robust_list_common(int pid, bool compat, int index)
+static void __user *futex_get_robust_list_common(int pid, unsigned int index)
 {
 	struct task_struct *p = current;
 	void __user *head;
 	int ret;
 
+	if (index >= FUTEX_ROBUST_LIST2_MAX_IDX)
+		return (void __user *)ERR_PTR(-EINVAL);
+
 	scoped_guard(rcu) {
 		if (pid) {
 			p = find_task_by_vpid(pid);
@@ -75,14 +72,10 @@ static void __user *futex_get_robust_list_common(int pid, bool compat, int index
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	if (index >= 0) {
-		scoped_guard(mutex, &p->futex_exit_mutex) {
-			uintptr_t *rl = p->futex_robust_lists;
+	scoped_guard(mutex, &p->futex_exit_mutex) {
+		uintptr_t *rl = p->futex_robust_lists;
 
-			head = rl ? (void __user *) rl[index] : NULL;
-		}
-	} else {
-		head = futex_task_robust_list(p, compat);
+		head = rl ? (void __user *) rl[index] : NULL;
 	}
 
 	up_read(&p->signal->exec_update_lock);
@@ -107,7 +100,11 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 		struct robust_list_head __user * __user *, head_ptr,
 		size_t __user *, len_ptr)
 {
-	struct robust_list_head __user *head = futex_get_robust_list_common(pid, false, -1);
+	struct robust_list_head __user *head =
+		futex_get_robust_list_common(pid, FUTEX_ROBUST_LIST_NATIVE_IDX);
+
+	head = (struct robust_list_head __user *)
+		((uintptr_t) head & FUTEX_ROBUST_LIST_ENTRY_MASK);
 
 	if (IS_ERR(head))
 		return PTR_ERR(head);
@@ -180,7 +177,7 @@ SYSCALL_DEFINE4(get_robust_list2, int, pid,
 	 */
 	index += FUTEX_ROBUST_LIST2_IDX;
 
-	entry_ptr = futex_get_robust_list_common(pid, false, index);
+	entry_ptr = futex_get_robust_list_common(pid, index);
 	if (IS_ERR(entry_ptr))
 		return PTR_ERR(entry_ptr);
 
@@ -568,22 +565,23 @@ COMPAT_SYSCALL_DEFINE2(set_robust_list,
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
-	current->robust_list32 = head;
-
-	return 0;
+	return futex_robust_list_set((uintptr_t) head, FUTEX_ROBUST_LIST_CMD_SET_32,
+				     FUTEX_ROBUST_LIST_COMPAT_IDX);
 }
 
 COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct robust_list_head32 __user *head = futex_get_robust_list_common(pid, true, -1);
+	struct robust_list_head32 __user *head =
+		futex_get_robust_list_common(pid, FUTEX_ROBUST_LIST_COMPAT_IDX);
 
-	if (IS_ERR(head))
-		return PTR_ERR(head);
+	head = (struct robust_list_head32 __user *)
+		((uintptr_t) head & FUTEX_ROBUST_LIST_ENTRY_MASK);
 
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
+
 	return put_user(ptr_to_compat(head), head_ptr);
 }
 #endif /* CONFIG_COMPAT */

-- 
2.52.0


