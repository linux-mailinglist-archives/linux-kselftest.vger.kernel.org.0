Return-Path: <linux-kselftest+bounces-4972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465C85AEEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B75E281220
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E15A109;
	Mon, 19 Feb 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Ay+HJSKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6656448;
	Mon, 19 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382382; cv=none; b=LYM9/6DorGtwT6zqn9O3Ca+nxl7LR23iKdqD4httRvemfJFhV2X1DHHxUBqhxvSTDodQ7ICK+xcAx+wEhDHRggDlQV222w1wWpIxXHWyhMKXrkUejFhPyYaoKM61vXbsQ+7hX/noZb6LkVmolbqS9CLKk2046olJzWgqPeFICHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382382; c=relaxed/simple;
	bh=BBwhnd4e/5Hzqokna6vQPmzzEWFI0NSgSGZbVRpIq5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+oyBk8ZQWxdkHJZ2Low1P4UTIqkwk51qY/bFgKoXHkguRhA0a6w+tgD/K1jwMlCBxUGnjclWcjmEr1wofidlvoYTTB54mOOrIn2vJBQ3w41cX4W5ov+ffhrXcdbxPifE0MB2C90OkyuuYyIqZjjy9w1hlwh71YqM9vKwGPnnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Ay+HJSKO; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=SbLUeXrN9DzfDtOU400XFJhiRhyh0iRPAXDOtUpeLps=; b=Ay+HJSKO5sFdmNj7AoY5uVI67T
	S+1jIVg7dR2LWeL01FldZe58u6G3e0JaBf27piAFb6wcXIE2wI8qx47jqlKDlsUT0F/ixO7xbs4HD
	IvFMim1AMWQs8S8mzoB3AU9T9aHee2i9hZ8oq713Z+iDpkRuqnXKGhAl/UgL3jSK+vBxrCwyNai/p
	yCxoxcAl1UKQ/wa3h5P1fKU8ajQdrzoAnHQ4xA94FttgfMlW52cVbjeCNwTc/E2NZU+YMu5LpLvtK
	YJ7jMojl8o9cQsmhQzuDJ0cJsZwwE1c3Y/T0R4ZPiaq1eOKwSEDhiZFEXDcRk0O4z/Xg0SQ9lzloB
	QpAJUjhw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIL-0037Oz-26;
	Mon, 19 Feb 2024 16:39:29 -0600
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v2 05/31] ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
Date: Mon, 19 Feb 2024 16:38:07 -0600
Message-ID: <20240219223833.95710-6-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is similar to NTSYNC_IOC_WAIT_ANY, but waits until all of the objects are
simultaneously signaled, and then acquires all of them as a single atomic
operation.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 242 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |   1 +
 2 files changed, 235 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index ad93ca0f8b84..d5759e9a3a8e 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -55,7 +55,34 @@ struct ntsync_obj {
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
+	 * This hint isn't protected by any lock. It might change during the
+	 * course of a wake, but there's no meaningful race there; it's only a
+	 * hint.
+	 *
+	 * Since wait requests must originate from user-space threads, we're
+	 * limited here by PID_MAX_LIMIT, so there's no risk of overflow.
+	 */
+	atomic_t all_hint;
 };
 
 struct ntsync_q_entry {
@@ -76,14 +103,99 @@ struct ntsync_q {
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
+	 * We achieve this by grabbing multiple object locks at the same time.
+	 * However, this creates a lock ordering problem. To solve that problem,
+	 * wait_all_lock is taken first whenever multiple objects must be locked
+	 * at the same time.
+	 */
+	spinlock_t wait_all_lock;
+
 	struct file *file;
 };
 
+static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
+{
+	lockdep_assert_held(&obj->lock);
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
+	__u32 i;
+
+	lockdep_assert_held(&dev->wait_all_lock);
+	if (locked_obj)
+		lockdep_assert_held(&locked_obj->lock);
+
+	for (i = 0; i < count; i++) {
+		if (q->entries[i].obj != locked_obj)
+			spin_lock_nest_lock(&q->entries[i].obj->lock, &dev->wait_all_lock);
+	}
+
+	for (i = 0; i < count; i++) {
+		if (!is_signaled(q->entries[i].obj, q->owner)) {
+			can_wake = false;
+			break;
+		}
+	}
+
+	if (can_wake && atomic_cmpxchg(&q->signaled, -1, 0) == -1) {
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
+			spin_unlock(&q->entries[i].obj->lock);
+	}
+}
+
+static void try_wake_all_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&dev->wait_all_lock);
+	lockdep_assert_held(&obj->lock);
+
+	list_for_each_entry(entry, &obj->all_waiters, node)
+		try_wake_all(dev, entry->q, obj);
+}
+
 static void try_wake_any_sem(struct ntsync_obj *sem)
 {
 	struct ntsync_q_entry *entry;
@@ -123,6 +235,7 @@ static int post_sem_state(struct ntsync_obj *sem, __u32 count)
 
 static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 {
+	struct ntsync_device *dev = sem->dev;
 	__u32 __user *user_args = argp;
 	__u32 prev_count;
 	__u32 args;
@@ -134,14 +247,29 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 	if (sem->type != NTSYNC_TYPE_SEM)
 		return -EINVAL;
 
-	spin_lock(&sem->lock);
+	if (atomic_read(&sem->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&sem->lock, &dev->wait_all_lock);
 
-	prev_count = sem->u.sem.count;
-	ret = post_sem_state(sem, args);
-	if (!ret)
-		try_wake_any_sem(sem);
+		prev_count = sem->u.sem.count;
+		ret = post_sem_state(sem, args);
+		if (!ret) {
+			try_wake_all_obj(dev, sem);
+			try_wake_any_sem(sem);
+		}
 
-	spin_unlock(&sem->lock);
+		spin_unlock(&sem->lock);
+		spin_unlock(&dev->wait_all_lock);
+	} else {
+		spin_lock(&sem->lock);
+
+		prev_count = sem->u.sem.count;
+		ret = post_sem_state(sem, args);
+		if (!ret)
+			try_wake_any_sem(sem);
+
+		spin_unlock(&sem->lock);
+	}
 
 	if (!ret && put_user(prev_count, user_args))
 		ret = -EFAULT;
@@ -194,6 +322,8 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 	get_file(dev->file);
 	spin_lock_init(&obj->lock);
 	INIT_LIST_HEAD(&obj->any_waiters);
+	INIT_LIST_HEAD(&obj->all_waiters);
+	atomic_set(&obj->all_hint, 0);
 
 	return obj;
 }
@@ -298,7 +428,7 @@ static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_ar
  * Allocate and initialize the ntsync_q structure, but do not queue us yet.
  */
 static int setup_wait(struct ntsync_device *dev,
-		      const struct ntsync_wait_args *args,
+		      const struct ntsync_wait_args *args, bool all,
 		      struct ntsync_q **ret_q)
 {
 	const __u32 count = args->count;
@@ -322,6 +452,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->task = current;
 	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
+	q->all = all;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -331,6 +462,16 @@ static int setup_wait(struct ntsync_device *dev,
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
@@ -366,7 +507,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 	if (copy_from_user(&args, argp, sizeof(args)))
 		return -EFAULT;
 
-	ret = setup_wait(dev, &args, &q);
+	ret = setup_wait(dev, &args, false, &q);
 	if (ret < 0)
 		return ret;
 
@@ -428,6 +569,87 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
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
+	spin_lock(&dev->wait_all_lock);
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
+	spin_unlock(&dev->wait_all_lock);
+
+	/* sleep */
+
+	ret = ntsync_schedule(q, &args);
+
+	/* and finally, unqueue */
+
+	spin_lock(&dev->wait_all_lock);
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
+	spin_unlock(&dev->wait_all_lock);
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
@@ -436,6 +658,8 @@ static int ntsync_char_open(struct inode *inode, struct file *file)
 	if (!dev)
 		return -ENOMEM;
 
+	spin_lock_init(&dev->wait_all_lock);
+
 	file->private_data = dev;
 	dev->file = file;
 	return nonseekable_open(inode, file);
@@ -459,6 +683,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_CREATE_SEM:
 		return ntsync_create_sem(dev, argp);
+	case NTSYNC_IOC_WAIT_ALL:
+		return ntsync_wait_all(dev, argp);
 	case NTSYNC_IOC_WAIT_ANY:
 		return ntsync_wait_any(dev, argp);
 	default:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 56b643fab611..19c37e27a4f8 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -29,6 +29,7 @@ struct ntsync_wait_args {
 
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
+#define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 
-- 
2.43.0


