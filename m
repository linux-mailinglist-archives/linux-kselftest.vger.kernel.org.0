Return-Path: <linux-kselftest+bounces-23345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D259F1629
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61784284CB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79AA1F426F;
	Fri, 13 Dec 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="TyW2/sr2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807351F12E6;
	Fri, 13 Dec 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118549; cv=none; b=qzIIqX7Lbi5BdiqAzEypGTL6XO/7vtYoManL716AqvAboJQ18/ScXBP9rqfc5Em857cA/+7w/g6sW6j8h2uZh960pounIz3SYeWaTy0b5XUAi9oN5ZgPPl/0VjiyKOtgznLO8JchYVDqHXRq1MPWNvSmkRj/Ir1pXVFoSVlMDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118549; c=relaxed/simple;
	bh=soUHT5Q6NiBrQw5leff3FlQpjy9UmL5iYhhmPdwogX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+JUZ0zLAMlHnv03CSrdEauoXUfOp1MwC30UtVI9hBsvjJuprgpeoc88QXP2ayWk2MbPXWWg8NaCwgIBZLzEVkpyIbXVoxCVXMs4rq8ptYsMwx4/LmHe2sVNpKXdV2MscmUD7enk4WQJ6LZqhJQwez2loWfuNS8yEMPD4TLUves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=TyW2/sr2; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aJq8f/0oOvkymxR1ndbEUKuIJijdmgZxi2p5YzkfP9M=; b=TyW2/sr2BOp+z56NKX1s/2hmbm
	Wm4iZfr6u5dfY5rlzDyakRUkoRUaD7+DNlTJ9dk8h8TZON8N9/1SeK2Kv7nGRm/ayLbB9Ml652KG6
	gqIUn8C3rtuEurIHdfh7iTPpE7W0/OxjjcIqf9K+wveUmU5CfhkZOmyMDDNDayOioj3wRLBBprbF8
	Hrssr+K5QmfuV2N7SEuTbesvLXs33Vqh5xu+fq17UaFKDFKmmOXy7Oe5U/J99/4jTRymhPV2voSmx
	pJeAsEEDENu+MxdsXUVLeM8YEkQwsR6Ychn3VEWTYat4Hp1BvwN4jA8KPfrMxzWA8OhyfPugiC45J
	sodwIOLA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRl-00ASsZ-1S;
	Fri, 13 Dec 2024 13:35:34 -0600
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
Subject: [PATCH v7 03/30] ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
Date: Fri, 13 Dec 2024 13:34:44 -0600
Message-ID: <20241213193511.457338-4-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213193511.457338-1-zfigura@codeweavers.com>
References: <20241213193511.457338-1-zfigura@codeweavers.com>
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

This patch therefore implements the wait/wake infrastructure which comprises the
core of ntsync's functionality.

NTSYNC_IOC_WAIT_ANY is a vectored wait function similar to poll(). Unlike
poll(), it "consumes" objects when they are signaled. For semaphores, this means
decreasing one from the internal counter. At most one object can be consumed by
this function.

This wait/wake model is fundamentally different from that used anywhere else in
the kernel, and for that reason ntsync does not use any existing infrastructure,
such as futexes, kernel mutexes or semaphores, or wait_event().

Up to 64 objects can be waited on at once. As soon as one is signaled, the
object with the lowest index is consumed, and that index is returned via the
"index" field.

A timeout is supported. The timeout is passed as a u64 nanosecond value, which
represents absolute time measured against either the MONOTONIC or REALTIME clock
(controlled by the flags argument). If U64_MAX is passed, the ioctl waits
indefinitely.

This ioctl validates that all objects belong to the relevant device. This is not
necessary for any technical reason related to NTSYNC_IOC_WAIT_ANY, but will be
necessary for NTSYNC_IOC_WAIT_ALL introduced in the following patch.

Some padding fields are added for alignment and for fields which will be added
in future patches (split out to ease review).

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 247 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/ntsync.h |  14 ++
 2 files changed, 260 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index cb3a3bd97ba0..900cc5ce5761 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -6,11 +6,16 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/atomic.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/hrtimer.h>
+#include <linux/ktime.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <uapi/linux/ntsync.h>
@@ -30,6 +35,8 @@ enum ntsync_type {
  *
  * Both rely on struct file for reference counting. Individual
  * ntsync_obj objects take a reference to the device when created.
+ * Wait operations take a reference to each object being waited on for
+ * the duration of the wait.
  */
 
 struct ntsync_obj {
@@ -47,12 +54,55 @@ struct ntsync_obj {
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
+
+	/*
+	 * Protected via atomic_try_cmpxchg(). Only the thread that wins the
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
+		int signaled = -1;
+
+		if (!sem->u.sem.count)
+			break;
+
+		if (atomic_try_cmpxchg(&q->signaled, &signaled, entry->index)) {
+			sem->u.sem.count--;
+			wake_up_process(q->task);
+		}
+	}
+}
+
 /*
  * Actually change the semaphore state, returning -EOVERFLOW if it is made
  * invalid.
@@ -87,7 +137,9 @@ static int ntsync_sem_release(struct ntsync_obj *sem, void __user *argp)
 	spin_lock(&sem->lock);
 
 	prev_count = sem->u.sem.count;
-	ret = release_sem_state(sem, args);
+	ret = post_sem_state(sem, args);
+	if (!ret)
+		try_wake_any_sem(sem);
 
 	spin_unlock(&sem->lock);
 
@@ -140,6 +192,7 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 	obj->dev = dev;
 	get_file(dev->file);
 	spin_lock_init(&obj->lock);
+	INIT_LIST_HEAD(&obj->any_waiters);
 
 	return obj;
 }
@@ -187,6 +240,196 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 	return fd;
 }
 
+static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
+{
+	struct file *file = fget(fd);
+	struct ntsync_obj *obj;
+
+	if (!file)
+		return NULL;
+
+	if (file->f_op != &ntsync_obj_fops) {
+		fput(file);
+		return NULL;
+	}
+
+	obj = file->private_data;
+	if (obj->dev != dev) {
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
+static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_args *args)
+{
+	ktime_t timeout = ns_to_ktime(args->timeout);
+	clockid_t clock = CLOCK_MONOTONIC;
+	ktime_t *timeout_ptr;
+	int ret = 0;
+
+	timeout_ptr = (args->timeout == U64_MAX ? NULL : &timeout);
+
+	if (args->flags & NTSYNC_WAIT_REALTIME)
+		clock = CLOCK_REALTIME;
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
+		ret = schedule_hrtimeout_range_clock(timeout_ptr, 0, HRTIMER_MODE_ABS, clock);
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
+	if (args->pad[0] || args->pad[1] || args->pad[2] || (args->flags & ~NTSYNC_WAIT_REALTIME))
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
+	ret = ntsync_schedule(q, &args);
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
@@ -218,6 +461,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_CREATE_SEM:
 		return ntsync_create_sem(dev, argp);
+	case NTSYNC_IOC_WAIT_ANY:
+		return ntsync_wait_any(dev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 9af9d8125553..40ffdc41d5bb 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -15,7 +15,21 @@ struct ntsync_sem_args {
 	__u32 max;
 };
 
+#define NTSYNC_WAIT_REALTIME	0x1
+
+struct ntsync_wait_args {
+	__u64 timeout;
+	__u64 objs;
+	__u32 count;
+	__u32 index;
+	__u32 flags;
+	__u32 pad[3];
+};
+
+#define NTSYNC_MAX_WAIT_COUNT 64
+
 #define NTSYNC_IOC_CREATE_SEM		_IOW ('N', 0x80, struct ntsync_sem_args)
+#define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 
 #define NTSYNC_IOC_SEM_RELEASE		_IOWR('N', 0x81, __u32)
 
-- 
2.45.2


