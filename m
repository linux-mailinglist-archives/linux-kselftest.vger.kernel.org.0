Return-Path: <linux-kselftest+bounces-23084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01DA9E9F0F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4917284F3C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3F1A4E98;
	Mon,  9 Dec 2024 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YoYD28m+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48E19EEBD;
	Mon,  9 Dec 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770992; cv=none; b=ABpSpVIRxADkCNbHMN68wGU2HaFWbkqAfEA0z8XUJQ2QBbZ/e5QW2PMEpKDg78OOww8zQ1Upf4w/5fe/qY4CXfh9NxQx99NFcp7+RkpMEPupUnW/FCGrGcg7zWeYnQMKp0wbGCENP4tAxfX0bjO9NbBSVGdmEP3tGVCRRzk/MjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770992; c=relaxed/simple;
	bh=cb66V+as2dtg11ZepZuG+P+2i30nRAGI6mzTBhnTPXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxh40kzz7B4/bV2c11pwsBhWpGwDorsdP5AEa8m8bc3fKAwYDHclxHWQONKdbWkyXbU4JsNxhsL8k7+gCc0OsZtj3DJLxs9I3OFPx35SY0KHWlo8ngcw0BR6Zo8KLlOB0s8VFIyn2cvD2bP6TnQsPem3ABwTyxAZbrK99nsiUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=YoYD28m+; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dxkbSXM8+NdWh2nFtUMzBGZ7TbW5+CQh4cSgojs2gxI=; b=YoYD28m+ITVR0ID16a0s5ziDNj
	C2r92jaJxOYrUCfxRgrN5k4RwWqwVxshFCpBhkhKFzv3uBZa7YBo6Qif8yvN2d2E8fUqGo4NnA4nu
	/gzBtREwXpEzYwRmV+zeoXeoErzVwjB0ZIUalbEFeRBV5KcANT1vxpbadBbHvxZu4w5unoM/r5z6s
	cw+rW4NHSMwi+EgolbtPm8/MC0FfJVTIg6jrfjn/vo/to3vLhlFa04mKwUkyTX3JkC/w9EUGotpUG
	OXo2xKqXfbGYY61iVhbzZbKQTV4qvedxP9n+y+CwwcAVmJJaiIu4JWAvU9YCPO4uE7XkhVAwuG0Xt
	gEYB12Tg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyY-001Gd5-15;
	Mon, 09 Dec 2024 12:59:22 -0600
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
Subject: [PATCH v6 03/28] ntsync: Introduce NTSYNC_IOC_CREATE_MUTEX.
Date: Mon,  9 Dec 2024 12:58:39 -0600
Message-ID: <20241209185904.507350-4-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
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
index 0f4da571fa33..30c0bbb442da 100644
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
@@ -454,6 +492,33 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
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
@@ -523,7 +588,7 @@ static int setup_wait(struct ntsync_device *dev,
 	struct ntsync_q *q;
 	__u32 i, j;
 
-	if (args->pad[0] || args->pad[1] || args->pad[2] || (args->flags & ~NTSYNC_WAIT_REALTIME))
+	if (args->pad[0] || args->pad[1] || (args->flags & ~NTSYNC_WAIT_REALTIME))
 		return -EINVAL;
 
 	if (args->count > NTSYNC_MAX_WAIT_COUNT)
@@ -537,6 +602,7 @@ static int setup_wait(struct ntsync_device *dev,
 	if (!q)
 		return -ENOMEM;
 	q->task = current;
+	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
 	q->all = all;
 	q->count = count;
@@ -579,6 +645,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_SEM:
 		try_wake_any_sem(obj);
 		break;
+	case NTSYNC_TYPE_MUTEX:
+		try_wake_any_mutex(obj);
+		break;
 	}
 }
 
@@ -768,6 +837,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
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
2.45.2


