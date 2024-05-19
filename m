Return-Path: <linux-kselftest+bounces-10412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BB8C967A
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875B71F21261
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958397A15C;
	Sun, 19 May 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="UxpKGxEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D29745FD;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150321; cv=none; b=LRGjb/siA/yxA5OAImSgYqiyuTBsgUMkW72QrQ9jDFVxagVCAvO11jt8zfEDGbTEHwUAKdh+iLKsr+XyxrIRCqG+0AQ1z6F2PiOYzlOayfn4b2bt4G8Yr4QY3MbhG7m99lJFBSUlinS9tm5GHm3qbjcsjQ9EmGdbR+Rb+O9rVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150321; c=relaxed/simple;
	bh=O6pZ7douG1wzU+ulrX8Og0hWJD7BuLVJKerv0vxm/10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/k2XMuZKPgY0R96Cvp6943rW4+7ffXTW9pcAZIdYMZ0/KBYGLCfXxJolmTxtKcNnvwQC8hzggIdwVWHTwBU2fzFhpzSFfijl3ms4VvtA8GWUyqBw4RWmXrBT/tFBg4BK/eJJHrMkebDcq5AeBoWz8MWzGaEmH/FtcS17Par0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=UxpKGxEf; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Q3igaEQxpSWMeILoj0hVqmOUYjiaFqrzya8EJNTRHxM=; b=UxpKGxEfEjkYwB4SS7myShHCO6
	K+rnS3v/QIdGY4D9ZMsNgzX75LMmx3PTw0DtqU7SIGoAJ0buZv4lHU+cisPNLc95CJoEPZnOZsC6j
	TGDoXrbp3p24C/hATSDohSpcjlut64PzbPWzGbS3ndt3IqC3HKu/Zqsnd5M7H6Dp1AEmy0xNGeSl/
	okB2D8HwY6NPPyUR+2udcYbtWCGemumleBFomdwl0boIzByhr2oyEfj38/HWVjY6Y7YPb+6cayBqd
	TgTN3Jf9jg0aYxPTllA1KK4nvKmiDaS6p9PNK+O/Z7Xd60XS83eGK0TykhTFuBChImBpUGdre+HDV
	xd/6B7Bg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5b-008wIn-1a;
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
Subject: [PATCH v5 03/28] ntsync: Introduce NTSYNC_IOC_CREATE_MUTEX.
Date: Sun, 19 May 2024 15:24:29 -0500
Message-ID: <20240519202454.1192826-4-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to the NT syscall NtCreateMutant().

An NT mutex is recursive, with a 32-bit recursion counter. When acquired via
NtWaitForMultipleObjects(), the recursion counter is incremented by one. The OS
records the thread which acquired it.

The OS records the thread which acquired it. However, in order to keep this
driver self-contained, the owning thread ID is managed by user-space, and passed
as a parameter to all relevant ioctls.

The initial owner and recursion count, if any, are specified when the mutex is
created.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 77 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h | 10 ++++-
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index a2f2dfadc3ee..cfe802c79d7d 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -25,6 +25,7 @@
 
 enum ntsync_type {
 	NTSYNC_TYPE_SEM,
+	NTSYNC_TYPE_MUTEX,
 };
 
 /*
@@ -55,6 +56,10 @@ struct ntsync_obj {
 			__u32 count;
 			__u32 max;
 		} sem;
+		struct {
+			__u32 count;
+			pid_t owner;
+		} mutex;
 	} u;
 
 	/*
@@ -92,6 +97,7 @@ struct ntsync_q_entry {
 
 struct ntsync_q {
 	struct task_struct *task;
+	__u32 owner;
 
 	/*
 	 * Protected via atomic_try_cmpxchg(). Only the thread that wins the
@@ -214,13 +220,17 @@ static void ntsync_unlock_obj(struct ntsync_device *dev, struct ntsync_obj *obj,
 		       ((lockdep_is_held(&(obj)->dev->wait_all_lock) != LOCK_STATE_NOT_HELD) && \
 			(obj)->dev_locked))
 
-static bool is_signaled(struct ntsync_obj *obj)
+static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
 {
 	ntsync_assert_held(obj);
 
 	switch (obj->type) {
 	case NTSYNC_TYPE_SEM:
 		return !!obj->u.sem.count;
+	case NTSYNC_TYPE_MUTEX:
+		if (obj->u.mutex.owner && obj->u.mutex.owner != owner)
+			return false;
+		return obj->u.mutex.count < UINT_MAX;
 	}
 
 	WARN(1, "bad object type %#x\n", obj->type);
@@ -250,7 +260,7 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 	}
 
 	for (i = 0; i < count; i++) {
-		if (!is_signaled(q->entries[i].obj)) {
+		if (!is_signaled(q->entries[i].obj, q->owner)) {
 			can_wake = false;
 			break;
 		}
@@ -264,6 +274,10 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 			case NTSYNC_TYPE_SEM:
 				obj->u.sem.count--;
 				break;
+			case NTSYNC_TYPE_MUTEX:
+				obj->u.mutex.count++;
+				obj->u.mutex.owner = q->owner;
+				break;
 			}
 		}
 		wake_up_process(q->task);
@@ -307,6 +321,30 @@ static void try_wake_any_sem(struct ntsync_obj *sem)
 	}
 }
 
+static void try_wake_any_mutex(struct ntsync_obj *mutex)
+{
+	struct ntsync_q_entry *entry;
+
+	ntsync_assert_held(mutex);
+	lockdep_assert(mutex->type == NTSYNC_TYPE_MUTEX);
+
+	list_for_each_entry(entry, &mutex->any_waiters, node) {
+		struct ntsync_q *q = entry->q;
+		int signaled = -1;
+
+		if (mutex->u.mutex.count == UINT_MAX)
+			break;
+		if (mutex->u.mutex.owner && mutex->u.mutex.owner != q->owner)
+			continue;
+
+		if (atomic_try_cmpxchg(&q->signaled, &signaled, entry->index)) {
+			mutex->u.mutex.count++;
+			mutex->u.mutex.owner = q->owner;
+			wake_up_process(q->task);
+		}
+	}
+}
+
 /*
  * Actually change the semaphore state, returning -EOVERFLOW if it is made
  * invalid.
@@ -455,6 +493,33 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 	return put_user(fd, &user_args->sem);
 }
 
+static int ntsync_create_mutex(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_mutex_args __user *user_args = argp;
+	struct ntsync_mutex_args args;
+	struct ntsync_obj *mutex;
+	int fd;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (!args.owner != !args.count)
+		return -EINVAL;
+
+	mutex = ntsync_alloc_obj(dev, NTSYNC_TYPE_MUTEX);
+	if (!mutex)
+		return -ENOMEM;
+	mutex->u.mutex.count = args.count;
+	mutex->u.mutex.owner = args.owner;
+	fd = ntsync_obj_get_fd(mutex);
+	if (fd < 0) {
+		kfree(mutex);
+		return fd;
+	}
+
+	return put_user(fd, &user_args->mutex);
+}
+
 static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
 {
 	struct file *file = fget(fd);
@@ -524,7 +589,7 @@ static int setup_wait(struct ntsync_device *dev,
 	struct ntsync_q *q;
 	__u32 i, j;
 
-	if (args->pad[0] || args->pad[1] || args->pad[2] || (args->flags & ~NTSYNC_WAIT_REALTIME))
+	if (args->pad[0] || args->pad[1] || (args->flags & ~NTSYNC_WAIT_REALTIME))
 		return -EINVAL;
 
 	if (args->count > NTSYNC_MAX_WAIT_COUNT)
@@ -538,6 +603,7 @@ static int setup_wait(struct ntsync_device *dev,
 	if (!q)
 		return -ENOMEM;
 	q->task = current;
+	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
 	q->all = all;
 	q->count = count;
@@ -580,6 +646,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_SEM:
 		try_wake_any_sem(obj);
 		break;
+	case NTSYNC_TYPE_MUTEX:
+		try_wake_any_mutex(obj);
+		break;
 	}
 }
 
@@ -769,6 +838,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_MUTEX:
+		return ntsync_create_mutex(dev, argp);
 	case NTSYNC_IOC_CREATE_SEM:
 		return ntsync_create_sem(dev, argp);
 	case NTSYNC_IOC_WAIT_ALL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index addf187b1573..d5e5a2fbcb4d 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -16,6 +16,12 @@ struct ntsync_sem_args {
 	__u32 max;
 };
 
+struct ntsync_mutex_args {
+	__u32 mutex;
+	__u32 owner;
+	__u32 count;
+};
+
 #define NTSYNC_WAIT_REALTIME	0x1
 
 struct ntsync_wait_args {
@@ -24,7 +30,8 @@ struct ntsync_wait_args {
 	__u32 count;
 	__u32 index;
 	__u32 flags;
-	__u32 pad[3];
+	__u32 owner;
+	__u32 pad[2];
 };
 
 #define NTSYNC_MAX_WAIT_COUNT 64
@@ -32,6 +39,7 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 #define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
+#define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 
-- 
2.43.0


