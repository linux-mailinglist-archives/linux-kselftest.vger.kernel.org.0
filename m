Return-Path: <linux-kselftest+bounces-3793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BD2843354
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FA1C21122
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A083F9CF;
	Wed, 31 Jan 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="CxRMRmK8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A2538A;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667367; cv=none; b=hvXsB86mjevxkQ4Kc2Vr8Xqkp+QuExkJCbC/bbpxEvN7F7BfC3Pk3gJeLb8d5MUVJYyYSP99T03npkDQrveOqMOU1MPk35cetKDEx1PJLcnduBlNHkZztDQ3bOAvTEtONqGojLaHSq8g0XacYU7V1XpzrmN+ryxtSRcwdhwtv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667367; c=relaxed/simple;
	bh=blvWdmAlT8N2pI4NeUMKOVsakHhLte/Ud+yLGi+AMhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRdxcXwMtEmA5ibkNDPaQhbALqpFNymS+L84AmorWlFYPvdPvtewSLdldIdWI+RLWJ+VlthMxEplUjgK7hSpCKUv8eaEOVuOcP9zT2UIZ+5DP35Tv6sqZlmqTdCE9TphQSE8hjxh8DYLP79//1/0XGfq9PwxRkDK6bLCvgR7dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=CxRMRmK8; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=dBqQoWEccHAFufDAEgUe6Vd0qbJ3tQL100kMCYoxJh0=; b=CxRMRmK8l3r4pC2PM/mTZLAsWW
	VoLkYLIYcBcbRA1oPBu1FMhm4kW7Bm3IaakaJMYUPDNmmnQB/3fx+vmze4diV6CdM504owE1BL3eX
	OZGuZXfNInLbiulypZ3IJku6m2p3mbCOFtd4lv8DUR14GKnZIS98QkA/W439TUy+W8M0AGLGaQFgZ
	GyKIfmFUCp7b0/azvcp6NArQZyu81SQbzH4NVbmlPcWd4Bz8YnhdMEHWsO+exAJ9EnA4nFp6/Ns0k
	XgBrTPfYbAQYToyBqIs7Gv7kdgrbwxnp6asSZrcC4PqU9mltlf47v/2gwUAAav4DzxRyN8+g3czLT
	rpAwAsOw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08m-0038Kv-2R;
	Tue, 30 Jan 2024 20:15:52 -0600
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH v2 04/29] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Tue, 30 Jan 2024 20:13:31 -0600
Message-ID: <20240131021356.10322-5-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131021356.10322-1-zfigura@codeweavers.com>
References: <20240131021356.10322-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to part of the functionality of the NT syscall
NtWaitForMultipleObjects(). Specifically, it implements the behaviour where
the third argument (wait_any) is TRUE, and it does not handle alertable waits.
Those features have been split out into separate patches to ease review.

NTSYNC_IOC_WAIT_ANY is a vectored wait function similar to poll(). Unlike
poll(), it "consumes" objects when they are signaled. For semaphores, this means
decreasing one from the internal counter. At most one object can be consumed by
this function.

Up to 64 objects can be waited on at once. As soon as one is signaled, the
object with the lowest index is consumed, and that index is returned via the
"index" field.

A timeout is supported. The timeout is passed as a u64 nanosecond value, which
represents absolute time measured against the MONOTONIC clock. If U64_MAX is
passed, the ioctl waits indefinitely.

This ioctl validates that all objects belong to the relevant device. This is not
necessary for any technical reason related to NTSYNC_IOC_WAIT_ANY, but will be
necessary for NTSYNC_IOC_WAIT_ALL introduced in the following patch.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 232 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  12 ++
 2 files changed, 244 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 1af38969f9a2..0a0ab755d57f 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -34,12 +34,55 @@ struct ntsync_obj {
 			__u32 max;
 		} sem;
 	} u;
+
+	struct list_head any_waiters;
+};
+
+struct ntsync_q_entry {
+	struct list_head node;
+	struct ntsync_q *q;
+	struct ntsync_obj *obj;
+	__u32 index;
+};
+
+struct ntsync_q {
+	struct task_struct *task;
+	__u32 owner;
+
+	/*
+	 * Protected via atomic_cmpxchg(). Only the thread that wins the
+	 * compare-and-swap may actually change object states and wake this
+	 * task.
+	 */
+	atomic_t signaled;
+
+	__u32 count;
+	struct ntsync_q_entry entries[];
 };
 
 struct ntsync_device {
 	struct file *file;
 };
 
+static void try_wake_any_sem(struct ntsync_obj *sem)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&sem->lock);
+
+	list_for_each_entry(entry, &sem->any_waiters, node) {
+		struct ntsync_q *q = entry->q;
+
+		if (!sem->u.sem.count)
+			break;
+
+		if (atomic_cmpxchg(&q->signaled, -1, entry->index) == -1) {
+			sem->u.sem.count--;
+			wake_up_process(q->task);
+		}
+	}
+}
+
 /*
  * Actually change the semaphore state, returning -EOVERFLOW if it is made
  * invalid.
@@ -73,6 +116,8 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 
 	prev_count = sem->u.sem.count;
 	ret = post_sem_state(sem, args);
+	if (!ret)
+		try_wake_any_sem(sem);
 
 	spin_unlock(&sem->lock);
 
@@ -126,6 +171,7 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 	obj->dev = dev;
 	get_file(dev->file);
 	spin_lock_init(&obj->lock);
+	INIT_LIST_HEAD(&obj->any_waiters);
 
 	return obj;
 }
@@ -176,6 +222,190 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 	return put_user(fd, &user_args->sem);
 }
 
+static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
+{
+	struct file *file = fget(fd);
+	struct ntsync_obj *obj;
+
+	if (file->f_op != &ntsync_obj_fops)
+	{
+		fput(file);
+		return NULL;
+	}
+
+	obj = file->private_data;
+	if (obj->dev != dev)
+	{
+		fput(file);
+		return NULL;
+	}
+
+	return obj;
+}
+
+static void put_obj(struct ntsync_obj *obj)
+{
+	fput(obj->file);
+}
+
+static int ntsync_schedule(const struct ntsync_q *q, ktime_t *timeout)
+{
+	int ret = 0;
+
+	do {
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (atomic_read(&q->signaled) != -1) {
+			ret = 0;
+			break;
+		}
+		ret = schedule_hrtimeout(timeout, HRTIMER_MODE_ABS);
+	} while (ret < 0);
+	__set_current_state(TASK_RUNNING);
+
+	return ret;
+}
+
+/*
+ * Allocate and initialize the ntsync_q structure, but do not queue us yet.
+ */
+static int setup_wait(struct ntsync_device *dev,
+		      const struct ntsync_wait_args *args,
+		      struct ntsync_q **ret_q)
+{
+	const __u32 count = args->count;
+	int fds[NTSYNC_MAX_WAIT_COUNT];
+	struct ntsync_q *q;
+	__u32 i, j;
+
+	if (!args->owner || args->pad)
+		return -EINVAL;
+
+	if (args->count > NTSYNC_MAX_WAIT_COUNT)
+		return -EINVAL;
+
+	if (copy_from_user(fds, u64_to_user_ptr(args->objs),
+			   array_size(count, sizeof(*fds))))
+		return -EFAULT;
+
+	q = kmalloc(struct_size(q, entries, count), GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+	q->task = current;
+	q->owner = args->owner;
+	atomic_set(&q->signaled, -1);
+	q->count = count;
+
+	for (i = 0; i < count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = get_obj(dev, fds[i]);
+
+		if (!obj)
+			goto err;
+
+		entry->obj = obj;
+		entry->q = q;
+		entry->index = i;
+	}
+
+	*ret_q = q;
+	return 0;
+
+err:
+	for (j = 0; j < i; j++)
+		put_obj(q->entries[j].obj);
+	kfree(q);
+	return -EINVAL;
+}
+
+static void try_wake_any_obj(struct ntsync_obj *obj)
+{
+	switch (obj->type) {
+	case NTSYNC_TYPE_SEM:
+		try_wake_any_sem(obj);
+		break;
+	}
+}
+
+static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_wait_args args;
+	struct ntsync_q *q;
+	ktime_t timeout;
+	int signaled;
+	__u32 i;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	ret = setup_wait(dev, &args, &q);
+	if (ret < 0)
+		return ret;
+
+	/* queue ourselves */
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		spin_lock(&obj->lock);
+		list_add_tail(&entry->node, &obj->any_waiters);
+		spin_unlock(&obj->lock);
+	}
+
+	/* check if we are already signaled */
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_obj *obj = q->entries[i].obj;
+
+		if (atomic_read(&q->signaled) != -1)
+			break;
+
+		spin_lock(&obj->lock);
+		try_wake_any_obj(obj);
+		spin_unlock(&obj->lock);
+	}
+
+	/* sleep */
+
+	timeout = ns_to_ktime(args.timeout);
+	ret = ntsync_schedule(q, args.timeout == U64_MAX ? NULL : &timeout);
+
+	/* and finally, unqueue */
+
+	for (i = 0; i < args.count; i++) {
+		struct ntsync_q_entry *entry = &q->entries[i];
+		struct ntsync_obj *obj = entry->obj;
+
+		spin_lock(&obj->lock);
+		list_del(&entry->node);
+		spin_unlock(&obj->lock);
+
+		put_obj(obj);
+	}
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
@@ -207,6 +437,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_CREATE_SEM:
 		return ntsync_create_sem(dev, argp);
+	case NTSYNC_IOC_WAIT_ANY:
+		return ntsync_wait_any(dev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 878ec4f0f2e8..9cd1dd05d971 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -16,7 +16,19 @@ struct ntsync_sem_args {
 	__u32 max;
 };
 
+struct ntsync_wait_args {
+	__u64 timeout;
+	__u64 objs;
+	__u32 count;
+	__u32 owner;
+	__u32 index;
+	__u32 pad;
+};
+
+#define NTSYNC_MAX_WAIT_COUNT 64
+
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
+#define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 
-- 
2.43.0


