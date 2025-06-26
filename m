Return-Path: <linux-kselftest+bounces-35877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A54AEA43D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B19E1888B0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518E42DAFB8;
	Thu, 26 Jun 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="egAE1jsR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207F2ED87B;
	Thu, 26 Jun 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957992; cv=none; b=U5rNrrPgdr9GYbiFWBz5PpZPn63h6ElFKT8dw+F0u14SofJuS8Ak0XIMy7d8MHGUYjRdhwXha4OFK4E7bOb0KIf0cD/Q4Ws94HB9chpFBhFNAyQZS4YWS8ZrsTDeo2O/5aVA1GoACNsusIj/E2dbDlL/DbHWYKeWqS1m+24GHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957992; c=relaxed/simple;
	bh=LyULV/00HGMkM555z0VBFVwNY0LLLcAuf2yHlIJA+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3s46/aEl6u0c/cRUyNxfFfYt7T9GDvRTcScuM0DwKxe6ymTJ28T9d4VdNTD9szLnFmON9TgNOAXAzTiVNhO/RwC7ctrbZGiyhfKFjnlnBVj1XsHw5du0K3QNm0FzLPlXn9W4FcmRSKehGcVCSqhFoRzgq6JNpJoFKcLTJ6BZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=egAE1jsR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U9WBAVHk3IR52iGdt3cbpIAxJqoXrb45BIFKAXiHKAw=; b=egAE1jsRBukcZvTx9wAVsEcJHy
	7daxk6xEO8Hd/9/FpSPyXwsfFK6OUjXCqvHgmfluHak6YakYkQcdWyWd+6U48FmSImkqVzxldwuHq
	lGZL22+PZ133goFuvC0gnLIO03MYizf+FOBvYB6ztQ/7saQjINVS9GwULN2TPiw5iE5okEAv0upxI
	pU1rH7+2pPmjKjJNtQGNY44OO2w++TeHSKrybMsMmXZPtGJpN30e5BCe7SXY6RW97RG9PJ/NeWdff
	w5jwhI8ifyuScFGypnUKe9EhQPEQQODQSeK7Vw8oXi5v3WduRFn6hs8CC4gtmc9NSqkztrcuMnW+K
	zpk5jxFg==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uUq9r-009491-Ib; Thu, 26 Jun 2025 19:13:07 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 26 Jun 2025 14:11:28 -0300
Subject: [PATCH v5 4/7] futex: Create set_robust_list2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-tonyk-robust_futex-v5-4-179194dbde8f@igalia.com>
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

Create a new robust_list() syscall. The current syscall can't be
expanded to cover the following use case, so a new one is needed. This
new syscall allows users to set multiple robust lists per process and to
have either 32bit or 64bit pointers in the list.

* Interface

This is the proposed interface:

	long set_robust_list2(void *head, int index, unsigned int flags)

`head` is the head of the userspace struct robust_list_head, just as old
set_robust_list(). It needs to be a void pointer since it can point to a
normal robust_list_head or a compat_robust_list_head.

`flags` can be used for defining the list type:

	enum robust_list_type {
	 	ROBUST_LIST_32BIT,
		ROBUST_LIST_64BIT,
	 };

`index` is the index in the internal robust_list's linked list (the
naming starts to get confusing, I reckon). If `index == -1`, that means
that user wants to set a new robust_list, and the kernel will append it
in the end of the list, assign a new index and return this index to the
user. If `index >= 0`, that means that user wants to re-set `*head` of
an already existing list (similarly to what happens when you call
set_robust_list() twice with different `*head`).

If `index` is out of range, or it points to a non-existing robust_list,
or if the internal list is full, an error is returned.

Unaligned `head` addresses are refused by the kernel with -EINVAL.

User cannot remove lists.

* Implementation

The old syscall's set/get_robust_list() are converted to use the linked
list as well. When using only the old syscalls user shouldn't any
difference as the internal code will handle the linked list insertion as
usual. When mixing old and new interfaces users should be aware that one
of the elements of the list was created by another syscall and they
should have special care handling this element index.

On exit, the linked list is parsed and all robust lists regardless of
which interface it was used to create them are handled.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/futex.h             |  20 +++++++-
 include/linux/sched.h             |   5 +-
 include/uapi/asm-generic/unistd.h |   2 +
 include/uapi/linux/futex.h        |  10 ++++
 kernel/futex/core.c               | 103 +++++++++++++++++++++++++++++++-------
 kernel/futex/futex.h              |   5 ++
 kernel/futex/syscalls.c           |  81 ++++++++++++++++++++++++++++--
 7 files changed, 199 insertions(+), 27 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index c5b6976909c7d51360e1831e017f4d1544c258fa..a8db1ed27373083330ae37d429ddf343f8a0d130 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -66,6 +66,21 @@ struct robust_list_head32 {
 };
 
 #ifdef CONFIG_FUTEX
+/*
+ * This is an entry of a linked list of robust lists.
+ *
+ * @head: can point to a 64bit list or a 32bit list
+ * @list_type: determine the size of the futex pointers in the list
+ * @index: the index of this entry in the list
+ * @list: linked list element
+ */
+struct robust_list2_entry {
+	void __user *head;
+	enum robust_list2_type list_type;
+	unsigned int index;
+	struct list_head list;
+};
+
 enum {
 	FUTEX_STATE_OK,
 	FUTEX_STATE_EXITING,
@@ -74,10 +89,11 @@ enum {
 
 static inline void futex_init_task(struct task_struct *tsk)
 {
-	tsk->robust_list = NULL;
+	tsk->robust_list_index = -1;
 #ifdef CONFIG_COMPAT
-	tsk->compat_robust_list = NULL;
+	tsk->compat_robust_list_index = -1;
 #endif
+	INIT_LIST_HEAD(&tsk->robust_list2);
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
 	tsk->futex_state = FUTEX_STATE_OK;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b0f64029d53e8b2ab56f24f77054aa7645a185c5..e97d1ade05211e7e02b8e36326f41c6a8a7f99b8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1331,10 +1331,11 @@ struct task_struct {
 	u32				rmid;
 #endif
 #ifdef CONFIG_FUTEX
-	struct robust_list_head __user	*robust_list;
+	int				robust_list_index;
 #ifdef CONFIG_COMPAT
-	struct robust_list_head32 __user *compat_robust_list;
+	int				compat_robust_list_index;
 #endif
+	struct list_head		robust_list2;
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
 	struct mutex			futex_exit_mutex;
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2892a45023af6d3eb941623d4fed04841ab07e02..ebe68c2c88eb5390dda184ce9268a8d3a606c9e5 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -852,6 +852,8 @@ __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
+#define __NR_set_robust_list2 467
+
 #undef __NR_syscalls
 #define __NR_syscalls 468
 
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 7e2744ec89336a260e89883e95222eda199eeb7f..a8d8d4b1306ba56041046647bfb12146cf1ae4cb 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -153,6 +153,16 @@ struct robust_list_head {
 	struct robust_list __user *list_op_pending;
 };
 
+#define ROBUST_LISTS_PER_TASK 10
+
+enum robust_list2_type {
+	ROBUST_LIST_32BIT,
+	ROBUST_LIST_64BIT,
+};
+
+#define ROBUST_LIST_TYPE_MASK (ROBUST_LIST_32BIT | ROBUST_LIST_64BIT)
+
+
 /*
  * Are there any waiters for this robust futex:
  */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index f0ac4b897ddbb667fa85daf5853cb47c749d512d..1049f8ef3ce3c611b3be0ca12df34a98f710121d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1220,7 +1220,6 @@ static void exit_robust_list64(struct task_struct *curr,
 }
 #endif
 
-#if defined(CONFIG_COMPAT) || !defined(CONFIG_64BIT)
 static void __user *futex_uaddr(struct robust_list __user *entry,
 				compat_long_t futex_offset)
 {
@@ -1319,7 +1318,70 @@ static void exit_robust_list32(struct task_struct *curr,
 		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
-#endif
+
+long do_set_robust_list2(struct robust_list_head __user *head,
+			 int index, unsigned int type)
+{
+	struct list_head *list2 = &current->robust_list2;
+	struct robust_list2_entry *prev, *new = NULL;
+
+	if (index == -1) {
+		if (list_empty(list2)) {
+			index = 0;
+		} else {
+			prev = list_last_entry(list2, struct robust_list2_entry, list);
+			index = prev->index + 1;
+		}
+
+		if (index >= ROBUST_LISTS_PER_TASK)
+			return -EINVAL;
+
+		new = kmalloc(sizeof(struct robust_list2_entry), GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		list_add_tail(&new->list, list2);
+		new->index = index;
+
+	} else if (index >= 0) {
+		struct robust_list2_entry *curr;
+
+		if (list_empty(list2))
+			return -ENOENT;
+
+		list_for_each_entry(curr, list2, list) {
+			if (index == curr->index) {
+				new = curr;
+				break;
+			}
+		}
+
+		if (!new)
+			return -ENOENT;
+	}
+
+	BUG_ON(!new);
+	new->head = head;
+	new->list_type = type;
+
+	return index;
+}
+
+struct robust_list_head __user *get_robust_list2(int index, struct task_struct *task)
+{
+	struct list_head *list2 = &task->robust_list2;
+	struct robust_list2_entry *curr;
+
+	if (list_empty(list2) || index == -1)
+		return NULL;
+
+	list_for_each_entry(curr, list2, list) {
+		if (index == curr->index)
+			return curr->head;
+	}
+
+	return NULL;
+}
 
 #ifdef CONFIG_FUTEX_PI
 
@@ -1414,25 +1476,28 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
 
 static void futex_cleanup(struct task_struct *tsk)
 {
-#ifdef CONFIG_64BIT
-	if (unlikely(tsk->robust_list)) {
-		exit_robust_list64(tsk, tsk->robust_list);
-		tsk->robust_list = NULL;
-	}
-#else
-	if (unlikely(tsk->robust_list)) {
-		exit_robust_list32(tsk,
-				  (struct robust_list_head32 __user *) tsk->robust_list);
-		tsk->robust_list = NULL;
-	}
-#endif
+	struct robust_list2_entry *curr, *n;
+	struct list_head *list2 = &tsk->robust_list2;
 
-#ifdef CONFIG_COMPAT
-	if (unlikely(tsk->compat_robust_list)) {
-		exit_robust_list32(tsk, tsk->compat_robust_list);
-		tsk->compat_robust_list = NULL;
+	/*
+	 * Walk through the linked list, parsing robust lists and freeing the
+	 * allocated lists
+	 */
+	if (unlikely(!list_empty(list2))) {
+		list_for_each_entry_safe(curr, n, list2, list) {
+			if (curr->head != NULL) {
+				if (curr->list_type == ROBUST_LIST_64BIT)
+					exit_robust_list64(tsk, curr->head);
+				else if (curr->list_type == ROBUST_LIST_32BIT)
+					exit_robust_list32(tsk, curr->head);
+				curr->head = NULL;
+			}
+			list_del_init(&curr->list);
+			kfree(curr);
+		}
 	}
-#endif
+
+	tsk->robust_list_index = -1;
 
 	if (unlikely(!list_empty(&tsk->pi_state_list)))
 		exit_pi_state_list(tsk);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index fcd1617212eed0e3c2367d2b463a0e019eda6d13..67201e51fa1798a21ff68f60b1e35977b9bd267b 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -467,6 +467,11 @@ extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
 
+extern long do_set_robust_list2(struct robust_list_head __user *head,
+			 int index, unsigned int type);
+
+extern struct robust_list_head __user *get_robust_list2(int index, struct task_struct *task);
+
 /**
  * struct futex_vector - Auxiliary struct for futex_waitv()
  * @w: Userspace provided data
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index dba193dfd216cc929c8f4d979aa2bcd99237e2d8..56ee1123cbd8ea26c8d22aa74e5faed2974ec577 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -20,6 +20,18 @@
  * the list. There can only be one such pending lock.
  */
 
+#ifdef CONFIG_64BIT
+static inline int robust_list_native_type(void)
+{
+	return ROBUST_LIST_64BIT;
+}
+#else
+static inline int robust_list_native_type(void)
+{
+	return ROBUST_LIST_32BIT;
+}
+#endif
+
 /**
  * sys_set_robust_list() - Set the robust-futex list head of a task
  * @head:	pointer to the list-head
@@ -28,17 +40,63 @@
 SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 		size_t, len)
 {
+	unsigned int type = robust_list_native_type();
+	int ret;
+
 	/*
 	 * The kernel knows only one size for now:
 	 */
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
-	current->robust_list = head;
+	ret = do_set_robust_list2(head, current->robust_list_index, type);
+	if (ret < 0)
+		return ret;
+
+	current->robust_list_index = ret;
 
 	return 0;
 }
 
+#define ROBUST_LIST_FLAGS ROBUST_LIST_TYPE_MASK
+
+/*
+ * sys_set_robust_list2()
+ *
+ * When index == -1, create a new list for user. When index >= 0, try to find
+ * the corresponding list and re-set the head there.
+ *
+ * Return values:
+ *  >= 0: success, index of the robust list
+ *  -EINVAL: invalid flags, invalid index
+ *  -ENOENT: requested index no where to be found
+ *  -ENOMEM: error allocating new list
+ *  -ESRCH: too many allocated lists
+ */
+SYSCALL_DEFINE3(set_robust_list2, struct robust_list_head __user *, head,
+		int, index, unsigned int, flags)
+{
+	unsigned int type;
+
+	type = flags & ROBUST_LIST_TYPE_MASK;
+
+	if (index < -1 || index >= ROBUST_LISTS_PER_TASK)
+		return -EINVAL;
+
+	if ((flags & ~ROBUST_LIST_FLAGS) != 0)
+		return -EINVAL;
+
+	if (((uintptr_t) head % sizeof(u32)) != 0)
+		return -EINVAL;
+
+#ifndef CONFIG_64BIT
+	if (type == ROBUST_LIST_64BIT)
+		return -EINVAL;
+#endif
+
+	return do_set_robust_list2(head, index, type);
+}
+
 /**
  * sys_get_robust_list() - Get the robust-futex list head of a task
  * @pid:	pid of the process [zero for current task]
@@ -52,6 +110,7 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	struct robust_list_head __user *head;
 	unsigned long ret;
 	struct task_struct *p;
+	int index;
 
 	rcu_read_lock();
 
@@ -68,9 +127,11 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = p->robust_list;
+	index = p->robust_list_index;
 	rcu_read_unlock();
 
+	head = get_robust_list2(index, p);
+
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(head, head_ptr);
@@ -443,10 +504,19 @@ COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct robust_list_head32 __user *, head,
 		compat_size_t, len)
 {
+	unsigned int type = ROBUST_LIST_32BIT;
+	int ret;
+
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
-	current->compat_robust_list = head;
+	ret = do_set_robust_list2((struct robust_list_head __user *) head,
+				  current->robust_list_index, type);
+	if (ret < 0)
+		return ret;
+
+	current->robust_list_index = ret;
+
 
 	return 0;
 }
@@ -458,6 +528,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 	struct robust_list_head32 __user *head;
 	unsigned long ret;
 	struct task_struct *p;
+	int index;
 
 	rcu_read_lock();
 
@@ -474,9 +545,11 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = p->compat_robust_list;
+	index = p->compat_robust_list_index;
 	rcu_read_unlock();
 
+	head = (struct robust_list_head32 __user *) get_robust_list2(index, p);
+
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(ptr_to_compat(head), head_ptr);

-- 
2.49.0


