Return-Path: <linux-kselftest+bounces-10390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180DD8C9633
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85644B20B7D
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840B73183;
	Sun, 19 May 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Yz9AOFts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92454276;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150317; cv=none; b=nFo7kGqKqIqg345OgBSH23++W0DrgIWjClGd6qwxYFK5hY5DKqnaUGr6596OvzX/Zrwf0bVCs4hpU+kwPhjWx3oEJxB1PHRahezv/lSCLOC8jAHPC/b3o+SuLVAuXmo3xNsxnhlriM/9JvvNtgLLgCO5V1XZgx2bblD7jXlQD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150317; c=relaxed/simple;
	bh=HFZOccLCVufLB/iXFfBiCRKDWSFMiGNkRwM4OV9SAMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V96yMfYzdaaFFa3SyeYTWJ5sfPfH1zlKCuEp/y0Yd9IXjxNPsbdpK4IdBHpRnGjfpKdiRsfAk+eMYTThehvm8QfqTtnDXXz1ZoxYyvZ5TPadK7rBgfSTVdexJi65sSYlu2Ve9Anz9hCmuWks75slGPKd1wb2BYsbhMoUwWzwjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Yz9AOFts; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=ektnXPkoByKpm3deCEUyeEdGT+9w+Zulk/LOXkED6Bs=; b=Yz9AOFts8QInfZkvLO+XZ0qaNO
	orlqGsdR0RAjvKXe4JZd5EV8AWUWlL3KVJY6WEaNBg3Tc6adf0BnvR59fzlNqd3gfa92/p3JdwulW
	IkMLJMrWf4n9flaB9+vuK3hs/EOn6Dax1pSohcokhPtMYF5shUCPf3HtRAtvusGemQfR+qTrQapkZ
	B3MKaBLF4zkYd832EV2UxsebyfjTqaPh81svjvLJ2CxDud1w1G1tsot+dBp5bC88/bhQDmhwJWlTa
	2jHQGeLD0S5LjvhCpAN9ydl3bxrgbJ57Oy2wrjU9Z1fxI5dswYpf1i8J6hDRaVIByJtlbAzB7fvpg
	yczjG36Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5b-008wIn-10;
	Sun, 19 May 2024 15:25:03 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v5 02/28] ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
Date: Sun, 19 May 2024 15:24:28 -0500
Message-ID: <20240519202454.1192826-3-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is similar to NTSYNC_IOC_WAIT_ANY, but waits until all of the objects are
simultaneously signaled, and then acquires all of them as a single atomic
operation.

Because acquisition of multiple objects is atomic, some complex locking is
required. We cannot simply spin-lock multiple objects simultaneously, as that
may disable preëmption for a problematically long time.

Instead, modifying any object which may be involved in a wait-all operation takes
a device-wide sleeping mutex, "wait_all_lock", instead of the normal object
spinlock.

Because wait-for-all is a rare operation, in order to optimize wait-for-any,
this lock is only taken when necessary. "all_hint" is used to mark objects which
are involved in a wait-for-all operation, and if an object is not, only its
spinlock is taken.

The locking scheme used here was written by Peter Zijlstra.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 334 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |   1 +
 2 files changed, 322 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index d5864891caf0..a2f2dfadc3ee 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -13,6 +13,7 @@
 #include <linux/ktime.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
@@ -41,6 +42,7 @@ enum ntsync_type {
 
 struct ntsync_obj {
 	spinlock_t lock;
+	int dev_locked;
 
 	enum ntsync_type type;
 
@@ -55,7 +57,30 @@ struct ntsync_obj {
 		} sem;
 	} u;
 
+	/*
+	 * any_waiters is protected by the object lock, but all_waiters is
+	 * protected by the device wait_all_lock.
+	 */
 	struct list_head any_waiters;
+	struct list_head all_waiters;
+
+	/*
+	 * Hint describing how many tasks are queued on this object in a
+	 * wait-all operation.
+	 *
+	 * Any time we do a wake, we may need to wake "all" waiters as well as
+	 * "any" waiters. In order to atomically wake "all" waiters, we must
+	 * lock all of the objects, and that means grabbing the wait_all_lock
+	 * below (and, due to lock ordering rules, before locking this object).
+	 * However, wait-all is a rare operation, and grabbing the wait-all
+	 * lock for every wake would create unnecessary contention.
+	 * Therefore we first check whether all_hint is zero, and, if it is,
+	 * we skip trying to wake "all" waiters.
+	 *
+	 * Since wait requests must originate from user-space threads, we're
+	 * limited here by PID_MAX_LIMIT, so there's no risk of overflow.
+	 */
+	atomic_t all_hint;
 };
 
 struct ntsync_q_entry {
@@ -75,19 +100,198 @@ struct ntsync_q {
 	 */
 	atomic_t signaled;
 
+	bool all;
 	__u32 count;
 	struct ntsync_q_entry entries[];
 };
 
 struct ntsync_device {
+	/*
+	 * Wait-all operations must atomically grab all objects, and be totally
+	 * ordered with respect to each other and wait-any operations.
+	 * If one thread is trying to acquire several objects, another thread
+	 * cannot touch the object at the same time.
+	 *
+	 * This device-wide lock is used to serialize wait-for-all
+	 * operations, and operations on an object that is involved in a
+	 * wait-for-all.
+	 */
+	struct mutex wait_all_lock;
+
 	struct file *file;
 };
 
+/*
+ * Single objects are locked using obj->lock.
+ *
+ * Multiple objects are 'locked' while holding dev->wait_all_lock.
+ * In this case however, individual objects are not locked by holding
+ * obj->lock, but by setting obj->dev_locked.
+ *
+ * This means that in order to lock a single object, the sequence is slightly
+ * more complicated than usual. Specifically it needs to check obj->dev_locked
+ * after acquiring obj->lock, if set, it needs to drop the lock and acquire
+ * dev->wait_all_lock in order to serialize against the multi-object operation.
+ */
+
+static void dev_lock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	lockdep_assert_held(&dev->wait_all_lock);
+	lockdep_assert(obj->dev == dev);
+	spin_lock(&obj->lock);
+	/*
+	 * By setting obj->dev_locked inside obj->lock, it is ensured that
+	 * anyone holding obj->lock must see the value.
+	 */
+	obj->dev_locked = 1;
+	spin_unlock(&obj->lock);
+}
+
+static void dev_unlock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	lockdep_assert_held(&dev->wait_all_lock);
+	lockdep_assert(obj->dev == dev);
+	spin_lock(&obj->lock);
+	obj->dev_locked = 0;
+	spin_unlock(&obj->lock);
+}
+
+static void obj_lock(struct ntsync_obj *obj)
+{
+	struct ntsync_device *dev = obj->dev;
+
+	for (;;) {
+		spin_lock(&obj->lock);
+		if (likely(!obj->dev_locked))
+			break;
+
+		spin_unlock(&obj->lock);
+		mutex_lock(&dev->wait_all_lock);
+		spin_lock(&obj->lock);
+		/*
+		 * obj->dev_locked should be set and released under the same
+		 * wait_all_lock section, since we now own this lock, it should
+		 * be clear.
+		 */
+		lockdep_assert(!obj->dev_locked);
+		spin_unlock(&obj->lock);
+		mutex_unlock(&dev->wait_all_lock);
+	}
+}
+
+static void obj_unlock(struct ntsync_obj *obj)
+{
+	spin_unlock(&obj->lock);
+}
+
+static bool ntsync_lock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	bool all;
+
+	obj_lock(obj);
+	all = atomic_read(&obj->all_hint);
+	if (unlikely(all)) {
+		obj_unlock(obj);
+		mutex_lock(&dev->wait_all_lock);
+		dev_lock_obj(dev, obj);
+	}
+
+	return all;
+}
+
+static void ntsync_unlock_obj(struct ntsync_device *dev, struct ntsync_obj *obj, bool all)
+{
+	if (all) {
+		dev_unlock_obj(dev, obj);
+		mutex_unlock(&dev->wait_all_lock);
+	} else {
+		obj_unlock(obj);
+	}
+}
+
+#define ntsync_assert_held(obj) \
+	lockdep_assert((lockdep_is_held(&(obj)->lock) != LOCK_STATE_NOT_HELD) || \
+		       ((lockdep_is_held(&(obj)->dev->wait_all_lock) != LOCK_STATE_NOT_HELD) && \
+			(obj)->dev_locked))
+
+static bool is_signaled(struct ntsync_obj *obj)
+{
+	ntsync_assert_held(obj);
+
+	switch (obj->type) {
+	case NTSYNC_TYPE_SEM:
+		return !!obj->u.sem.count;
+	}
+
+	WARN(1, "bad object type %#x\n", obj->type);
+	return false;
+}
+
+/*
+ * "locked_obj" is an optional pointer to an object which is already locked and
+ * should not be locked again. This is necessary so that changing an object's
+ * state and waking it can be a single atomic operation.
+ */
+static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
+			 struct ntsync_obj *locked_obj)
+{
+	__u32 count = q->count;
+	bool can_wake = true;
+	int signaled = -1;
+	__u32 i;
+
+	lockdep_assert_held(&dev->wait_all_lock);
+	if (locked_obj)
+		lockdep_assert(locked_obj->dev_locked);
+
+	for (i = 0; i < count; i++) {
+		if (q->entries[i].obj != locked_obj)
+			dev_lock_obj(dev, q->entries[i].obj);
+	}
+
+	for (i = 0; i < count; i++) {
+		if (!is_signaled(q->entries[i].obj)) {
+			can_wake = false;
+			break;
+		}
+	}
+
+	if (can_wake && atomic_try_cmpxchg(&q->signaled, &signaled, 0)) {
+		for (i = 0; i < count; i++) {
+			struct ntsync_obj *obj = q->entries[i].obj;
+
+			switch (obj->type) {
+			case NTSYNC_TYPE_SEM:
+				obj->u.sem.count--;
+				break;
+			}
+		}
+		wake_up_process(q->task);
+	}
+
+	for (i = 0; i < count; i++) {
+		if (q->entries[i].obj != locked_obj)
+			dev_unlock_obj(dev, q->entries[i].obj);
+	}
+}
+
+static void try_wake_all_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&dev->wait_all_lock);
+	lockdep_assert(obj->dev_locked);
+
+	list_for_each_entry(entry, &obj->all_waiters, node)
+		try_wake_all(dev, entry->q, obj);
+}
+
 static void try_wake_any_sem(struct ntsync_obj *sem)
 {
 	struct ntsync_q_entry *entry;
 
-	lockdep_assert_held(&sem->lock);
+	ntsync_assert_held(sem);
+	lockdep_assert(sem->type == NTSYNC_TYPE_SEM);
 
 	list_for_each_entry(entry, &sem->any_waiters, node) {
 		struct ntsync_q *q = entry->q;
@@ -111,7 +315,7 @@ static int post_sem_state(struct ntsync_obj *sem, __u32 count)
 {
 	__u32 sum;
 
-	lockdep_assert_held(&sem->lock);
+	ntsync_assert_held(sem);
 
 	if (check_add_overflow(sem->u.sem.count, count, &sum) ||
 	    sum > sem->u.sem.max)
@@ -123,9 +327,11 @@ static int post_sem_state(struct ntsync_obj *sem, __u32 count)
 
 static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 {
+	struct ntsync_device *dev = sem->dev;
 	__u32 __user *user_args = argp;
 	__u32 prev_count;
 	__u32 args;
+	bool all;
 	int ret;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -134,14 +340,17 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 	if (sem->type != NTSYNC_TYPE_SEM)
 		return -EINVAL;
 
-	spin_lock(&sem->lock);
+	all = ntsync_lock_obj(dev, sem);
 
 	prev_count = sem->u.sem.count;
 	ret = post_sem_state(sem, args);
-	if (!ret)
+	if (!ret) {
+		if (all)
+			try_wake_all_obj(dev, sem);
 		try_wake_any_sem(sem);
+	}
 
-	spin_unlock(&sem->lock);
+	ntsync_unlock_obj(dev, sem, all);
 
 	if (!ret && put_user(prev_count, user_args))
 		ret = -EFAULT;
@@ -194,6 +403,8 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 	get_file(dev->file);
 	spin_lock_init(&obj->lock);
 	INIT_LIST_HEAD(&obj->any_waiters);
+	INIT_LIST_HEAD(&obj->all_waiters);
+	atomic_set(&obj->all_hint, 0);
 
 	return obj;
 }
@@ -305,7 +516,7 @@ static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_ar
  * Allocate and initialize the ntsync_q structure, but do not queue us yet.
  */
 static int setup_wait(struct ntsync_device *dev,
-		      const struct ntsync_wait_args *args,
+		      const struct ntsync_wait_args *args, bool all,
 		      struct ntsync_q **ret_q)
 {
 	const __u32 count = args->count;
@@ -328,6 +539,7 @@ static int setup_wait(struct ntsync_device *dev,
 		return -ENOMEM;
 	q->task = current;
 	atomic_set(&q->signaled, -1);
+	q->all = all;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -337,6 +549,16 @@ static int setup_wait(struct ntsync_device *dev,
 		if (!obj)
 			goto err;
 
+		if (all) {
+			/* Check that the objects are all distinct. */
+			for (j = 0; j < i; j++) {
+				if (obj == q->entries[j].obj) {
+					put_obj(obj);
+					goto err;
+				}
+			}
+		}
+
 		entry->obj = obj;
 		entry->q = q;
 		entry->index = i;
@@ -366,13 +588,14 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 	struct ntsync_wait_args args;
 	struct ntsync_q *q;
 	int signaled;
+	bool all;
 	__u32 i;
 	int ret;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
 		return -EFAULT;
 
-	ret = setup_wait(dev, &args, &q);
+	ret = setup_wait(dev, &args, false, &q);
 	if (ret < 0)
 		return ret;
 
@@ -382,9 +605,9 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = entry->obj;
 
-		spin_lock(&obj->lock);
+		all = ntsync_lock_obj(dev, obj);
 		list_add_tail(&entry->node, &obj->any_waiters);
-		spin_unlock(&obj->lock);
+		ntsync_unlock_obj(dev, obj, all);
 	}
 
 	/* check if we are already signaled */
@@ -395,9 +618,9 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		if (atomic_read(&q->signaled) != -1)
 			break;
 
-		spin_lock(&obj->lock);
+		all = ntsync_lock_obj(dev, obj);
 		try_wake_any_obj(obj);
-		spin_unlock(&obj->lock);
+		ntsync_unlock_obj(dev, obj, all);
 	}
 
 	/* sleep */
@@ -410,9 +633,9 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = entry->obj;
 
-		spin_lock(&obj->lock);
+		all = ntsync_lock_obj(dev, obj);
 		list_del(&entry->node);
-		spin_unlock(&obj->lock);
+		ntsync_unlock_obj(dev, obj, all);
 
 		put_obj(obj);
 	}
@@ -434,6 +657,87 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 	return ret;
 }
 
+static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_wait_args args;
+	struct ntsync_q *q;
+	int signaled;
+	__u32 i;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	ret = setup_wait(dev, &args, true, &q);
+	if (ret < 0)
+		return ret;
+
+	/* queue ourselves */
+
+	mutex_lock(&dev->wait_all_lock);
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		atomic_inc(&obj->all_hint);
+
+		/*
+		 * obj->all_waiters is protected by dev->wait_all_lock rather
+		 * than obj->lock, so there is no need to acquire obj->lock
+		 * here.
+		 */
+		list_add_tail(&entry->node, &obj->all_waiters);
+	}
+
+	/* check if we are already signaled */
+
+	try_wake_all(dev, q, NULL);
+
+	mutex_unlock(&dev->wait_all_lock);
+
+	/* sleep */
+
+	ret = ntsync_schedule(q, &args);
+
+	/* and finally, unqueue */
+
+	mutex_lock(&dev->wait_all_lock);
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		/*
+		 * obj->all_waiters is protected by dev->wait_all_lock rather
+		 * than obj->lock, so there is no need to acquire it here.
+		 */
+		list_del(&entry->node);
+
+		atomic_dec(&obj->all_hint);
+
+		put_obj(obj);
+	}
+
+	mutex_unlock(&dev->wait_all_lock);
+
+	signaled = atomic_read(&q->signaled);
+	if (signaled != -1) {
+		struct ntsync_wait_args __user *user_args = argp;
+
+		/* even if we caught a signal, we need to communicate success */
+		ret = 0;
+
+		if (put_user(signaled, &user_args->index))
+			ret = -EFAULT;
+	} else if (!ret) {
+		ret = -ETIMEDOUT;
+	}
+
+	kfree(q);
+	return ret;
+}
+
 static int ntsync_char_open(struct inode *inode, struct file *file)
 {
 	struct ntsync_device *dev;
@@ -442,6 +746,8 @@ static int ntsync_char_open(struct inode *inode, struct file *file)
 	if (!dev)
 		return -ENOMEM;
 
+	mutex_init(&dev->wait_all_lock);
+
 	file->private_data = dev;
 	dev->file = file;
 	return nonseekable_open(inode, file);
@@ -465,6 +771,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_CREATE_SEM:
 		return ntsync_create_sem(dev, argp);
+	case NTSYNC_IOC_WAIT_ALL:
+		return ntsync_wait_all(dev, argp);
 	case NTSYNC_IOC_WAIT_ANY:
 		return ntsync_wait_any(dev, argp);
 	default:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index edc12c7a10dc..addf187b1573 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -31,6 +31,7 @@ struct ntsync_wait_args {
 
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
+#define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 
-- 
2.43.0


