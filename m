Return-Path: <linux-kselftest+bounces-46303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB729C7C82A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0CE94E35F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B4F2C0F6F;
	Sat, 22 Nov 2025 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VeTFDVhm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1922BF001;
	Sat, 22 Nov 2025 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790684; cv=none; b=NDetO6UjI7OB+HtZFbC71V6SotOSFHarDitqYUkTYZ93yWtmTfd75mLEbT7n+Wq3++boAnwg30HK0ouImGMUerHZ6BShqztypCdhtUQ1Sigz5I2NCtU40aNiR+/aqGJXKtRsBqV1C5JhGJ8jrqmeycUbD6JApDqKfsPuskeKeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790684; c=relaxed/simple;
	bh=gzn9/EkgVxiA3KJ0mSY4H8pHvFxv0hklj1GOC8fNUHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dI5Orvs8aOW31QdD+9jtK57656E6NU89pINobDA4gbyT4w0kVjit4WH/ONwjSra8xTnFmZHBTIGm+jeCqntUDeJSN1Mr3hkivIAyj8SL8/3GpOQMWo7RYvNlUhAXtALS727YqRV9dIJhT5Mw5j73G5nvkW9jiT1++CQjg16/TVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VeTFDVhm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Riw0dCVlXYIc0c55x20LABMFyn6l9sW+SJ5HW68HaAU=; b=VeTFDVhmgcc+gTsb6OmVjIQhp+
	xuqHqlmjFiy/13SiWa/B+zf/MdjN3ViH4Gl3JLbdv12l07dhE3o/KTwX1vOoSrQvNKb2SKIGX5PpR
	WybMJRcT9QzTTmX9dIA5eazrJpPgo/k56Vb89N9gd9yBEGdzEWw8Yf/jiB/3h/5a/xhUPIX3Hngfl
	5A0aQl4r6hPTK6C+A1jH5X7H90ooXVn6vThtVDuGPwh2U8g1e1Y7DDu5mAkkh1tjnM1Yyv7p9wzT2
	xoWYqLQ5TQHhq0LLptlzIzk+celaerk0HHsD7OjpW21kzEpZQCYyCUa4aSS94QswwJfp5n1WvBOSw
	ShdKeCVw==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWi-003xEt-Pe; Sat, 22 Nov 2025 06:51:16 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:45 -0300
Subject: [PATCH v6 3/9] futex: Create set_robust_list2() syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-3-05fea005a0fd@igalia.com>
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

Emulators (like FEX-Emu, to run x86 apps on top of Aarch64) have two
special needs about robust lists: to be able to register more than one
robust list, one of the app being emulated and one list for the emulator
itself; and to be able to walk on 32-bit robusts lists on a 64-bit
platform without compat entry points.

The current syscall allows for one robust list per task (on x86-64, it
can have two if compat is enabled) and on Aarch64 there's no way to
parse a 32-bit robust list. The current syscall cannot be expanded to
solve both needs, so create a new syscall, set_robust_list2() with the
following signature:

  sys_set_robust_list2(struct robust_list_head *head, unsigned int index,
		       unsigned int cmd, unsigned int flags)

The new syscall allows to set multiple lists per task, of 64-bit or
32-bit types.

 - `*head` is the same structure used in the current syscall.
 - `index` is the index of the list to be set with `head`.
 - `cmd` defines the operation to perform:
   - `FUTEX_ROBUST_LIST_CMD_SET_64` set a 64-bit robust list at `index`
   - `FUTEX_ROBUST_LIST_CMD_SET_32` set a 32-bit robust list at `index`
   - `FUTEX_ROBUST_LIST_CMD_LIST_LIMIT` get the limit of lists per task
 - `flag` is unused now but can be used to expand the interface

Setting an index twice overwrites the last instance.

The array of lists is dynamically allocated in the first use, but has a
fixed size determined by the kernel. 8 slots are more than enough to
cover the target use case and allows for more use cases. The command for
getting the list limit allows to userspace check if the kernel ever
expands this list. The first two slots are reserved for the kernel, to
store the original syscall robust_list_head's.

The array of lists is destroyed only during task exit.

The `FUTEX_ROBUST_LIST_CMD_SET_64` operation is only available for
64-bit kernels. In such kernels, lists created with
`FUTEX_ROBUST_LIST_CMD_SET_32` are marked with
`FUTEX_ROBUST_LIST_ENTRY_32BIT` and the kernel handles it with a special
function exit_robust_list32() to be able to walk in a list of 32-bit
pointers.

For 32-bit kernels, there's no special function available as every user
list and list handling functions will all have the same bitness.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/futex.h      |  26 +++++++++++
 include/linux/sched.h      |   1 +
 include/uapi/linux/futex.h |  16 +++++++
 kernel/futex/core.c        | 111 ++++++++++++++++++++++++++++++++++++++++++---
 kernel/futex/syscalls.c    |  41 +++++++++++++++++
 5 files changed, 188 insertions(+), 7 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 322851e4a703..3dba249bcd32 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm_types.h>
+#include <linux/compat.h>
 
 #include <uapi/linux/futex.h>
 
@@ -62,12 +63,35 @@ enum {
 	FUTEX_STATE_DEAD,
 };
 
+#define FUTEX_ROBUST_LIST_NATIVE_IDX	0
+#define FUTEX_ROBUST_LIST_COMPAT_IDX	1
+#define FUTEX_ROBUST_LIST2_IDX		2
+#define FUTEX_ROBUST_LISTS_PER_USER	8
+#define FUTEX_ROBUST_LIST2_MAX_IDX	(FUTEX_ROBUST_LIST2_IDX + FUTEX_ROBUST_LISTS_PER_USER)
+
+/*
+ * List entries without _32BIT flag are using the native machine size
+ */
+#define FUTEX_ROBUST_LIST_ENTRY_INUSE	0x1UL
+#define FUTEX_ROBUST_LIST_ENTRY_32BIT	0x2UL
+#define FUTEX_ROBUST_LIST_ENTRY_MASK	(~0x3UL)
+
+static inline bool futex_in_32bit_syscall(void)
+{
+#ifdef CONFIG_X86
+	return !IS_ENABLED(CONFIG_64BIT) || in_32bit_syscall();
+#else
+	return !IS_ENABLED(CONFIG_64BIT);
+#endif
+}
+
 static inline void futex_init_task(struct task_struct *tsk)
 {
 	tsk->robust_list = NULL;
 #ifdef CONFIG_COMPAT
 	tsk->robust_list32 = NULL;
 #endif
+	tsk->futex_robust_lists = NULL;
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
 	tsk->futex_state = FUTEX_STATE_OK;
@@ -82,6 +106,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
 
+int futex_robust_list_set(uintptr_t head, enum robust_list2_cmd cmd, unsigned int index);
+
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 76cabfab5b73..de2f3cbe4953 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1331,6 +1331,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
+	uintptr_t			*futex_robust_lists;
 #ifdef CONFIG_COMPAT
 	struct robust_list_head32 __user *robust_list32;
 #endif
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 86efb089893d..2ba5c0c3bb59 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -163,6 +163,22 @@ struct robust_list_head32 {
 	__u32			list_op_pending;
 };
 
+/*
+ * Commands for set_robust_list2 syscall
+ */
+enum robust_list2_cmd {
+	FUTEX_ROBUST_LIST_CMD_SET_64,
+	FUTEX_ROBUST_LIST_CMD_SET_32,
+	FUTEX_ROBUST_LIST_CMD_LIST_LIMIT,
+	FUTEX_ROBUST_LIST_CMD_USER_MAX,
+
+	/*
+	 * Kernel internal, rejected for user space
+	 */
+	FUTEX_ROBUST_LIST_SET_NATIVE = 128,
+	FUTEX_ROBUST_LIST_SET_COMPAT,
+};
+
 /*
  * Are there any waiters for this robust futex:
  */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136639897ff9..14d8a7176367 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -71,6 +71,57 @@ struct futex_private_hash {
 	struct futex_hash_bucket queues[];
 };
 
+int futex_robust_list_set(uintptr_t head, enum robust_list2_cmd cmd,
+			  unsigned int index)
+{
+	uintptr_t entry = FUTEX_ROBUST_LIST_ENTRY_INUSE;
+	uintptr_t *rl = current->futex_robust_lists;
+
+	if (!rl) {
+		rl = kcalloc(FUTEX_ROBUST_LIST2_MAX_IDX, sizeof(*rl), GFP_KERNEL);
+		if (!rl)
+			return -ENOMEM;
+
+		scoped_guard(mutex, &current->futex_exit_mutex) {
+			/* check if another thread set the list before us */
+			if (current->futex_robust_lists) {
+				kfree(rl);
+				rl = current->futex_robust_lists;
+			} else {
+				current->futex_robust_lists = rl;
+			}
+		}
+
+	}
+
+	switch (cmd) {
+	case FUTEX_ROBUST_LIST_CMD_SET_64:
+		if (futex_in_32bit_syscall())
+			return -EINVAL;
+		break;
+	case FUTEX_ROBUST_LIST_CMD_SET_32:
+		entry |= FUTEX_ROBUST_LIST_ENTRY_32BIT;
+		break;
+	case FUTEX_ROBUST_LIST_SET_NATIVE:
+		index = FUTEX_ROBUST_LIST_NATIVE_IDX;
+		break;
+	case FUTEX_ROBUST_LIST_SET_COMPAT:
+		if (!IS_ENABLED(CONFIG_64BIT))
+			return -EINVAL;
+		index = FUTEX_ROBUST_LIST_COMPAT_IDX;
+		entry |= FUTEX_ROBUST_LIST_ENTRY_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	entry |= head;
+	scoped_guard(mutex, &current->futex_exit_mutex)
+	rl[index] = entry;
+
+	return 0;
+}
+
 /*
  * Fault injections for futexes.
  */
@@ -1150,9 +1201,8 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
  *
  * We silently return on any sign of list-walking problem.
  */
-static void exit_robust_list(struct task_struct *curr)
+static void exit_robust_list(struct task_struct *curr, struct robust_list_head __user *head)
 {
-	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -1244,9 +1294,8 @@ fetch_robust_entry32(u32 *uentry, struct robust_list __user **entry,
  *
  * We silently return on any sign of list-walking problem.
  */
-static void exit_robust_list32(struct task_struct *curr)
+static void exit_robust_list32(struct task_struct *curr, struct robust_list_head32 __user *head)
 {
-	struct robust_list_head32 __user *head = curr->robust_list32;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -1311,7 +1360,15 @@ static void exit_robust_list32(struct task_struct *curr)
 		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
-#endif
+
+#else
+
+static void exit_robust_list32(struct task_struct *curr, struct robust_list_head32 __user *head)
+{
+	pr_crit("32-bit kernel should never call %s", __func__);
+}
+
+#endif /* CONFIG_64BIT */
 
 #ifdef CONFIG_FUTEX_PI
 
@@ -1404,20 +1461,60 @@ static void exit_pi_state_list(struct task_struct *curr)
 static inline void exit_pi_state_list(struct task_struct *curr) { }
 #endif
 
+static void exit_robust_lists(struct task_struct *tsk)
+{
+	uintptr_t *rl = tsk->futex_robust_lists;
+
+	tsk->futex_robust_lists = NULL;
+
+	for (unsigned int idx = 0; idx < FUTEX_ROBUST_LIST2_MAX_IDX; idx++) {
+		uintptr_t entry = rl[idx];
+
+		if (!(entry & FUTEX_ROBUST_LIST_ENTRY_MASK))
+			continue;
+
+		/*
+		 * If the list type is the same as the kernel bitness, always
+		 * calls exit_robust_list(). exit_robust_list32() is only for
+		 * 32-bit lists in a 64-bit kernel.
+		 */
+		if (IS_ENABLED(CONFIG_64BIT) && (entry & FUTEX_ROBUST_LIST_ENTRY_32BIT)) {
+			struct robust_list_head32 __user *head;
+
+			entry &= FUTEX_ROBUST_LIST_ENTRY_MASK;
+
+			head = (__force struct robust_list_head32 __user *)entry;
+			exit_robust_list32(tsk, head);
+		} else {
+			struct robust_list_head __user *head;
+
+			entry &= FUTEX_ROBUST_LIST_ENTRY_MASK;
+
+			head = (__force struct robust_list_head __user *)entry;
+			exit_robust_list(tsk, head);
+		}
+	}
+
+	kfree(rl);
+}
+
 static void futex_cleanup(struct task_struct *tsk)
 {
 	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk);
+		exit_robust_list(tsk, tsk->robust_list);
 		tsk->robust_list = NULL;
 	}
 
 #ifdef CONFIG_64BIT
 	if (unlikely(tsk->robust_list32)) {
-		exit_robust_list32(tsk);
+		exit_robust_list32(tsk, tsk->robust_list32);
 		tsk->robust_list32 = NULL;
 	}
 #endif
 
+	if (unlikely(tsk->futex_robust_lists))
+		exit_robust_lists(tsk);
+
 	if (unlikely(!list_empty(&tsk->pi_state_list)))
 		exit_pi_state_list(tsk);
 }
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 1de8ff230d54..0b7fa88aa34c 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -109,6 +109,47 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	return put_user(head, head_ptr);
 }
 
+SYSCALL_DEFINE4(set_robust_list2, struct robust_list_head *, head, unsigned int,
+		index, unsigned int, cmd, unsigned int, flags)
+{
+	uintptr_t entry = (__force uintptr_t)head;
+	size_t align = sizeof(u32);
+
+	if (flags)
+		return -EINVAL;
+
+	if (cmd >= FUTEX_ROBUST_LIST_CMD_USER_MAX)
+		return -EINVAL;
+
+	if (index >= FUTEX_ROBUST_LISTS_PER_USER)
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
+	switch (cmd) {
+	case FUTEX_ROBUST_LIST_CMD_SET_64:
+		if (futex_in_32bit_syscall())
+			return -EOPNOTSUPP;
+		align = sizeof(u64);
+		fallthrough;
+	case FUTEX_ROBUST_LIST_CMD_SET_32:
+		if (entry % align)
+			return -EINVAL;
+		return futex_robust_list_set(entry, cmd, index);
+	case FUTEX_ROBUST_LIST_CMD_LIST_LIMIT:
+		return FUTEX_ROBUST_LISTS_PER_USER;
+	}
+
+	return -EINVAL;
+}
+
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {

-- 
2.52.0


