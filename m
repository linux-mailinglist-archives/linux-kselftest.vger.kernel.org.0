Return-Path: <linux-kselftest+bounces-4957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C185AEBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098242814CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE657334;
	Mon, 19 Feb 2024 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ifEIv+bo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128954BC4;
	Mon, 19 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382380; cv=none; b=VRTysZZFbnYFrk/jrmQLnBHHx9W930mzP46K+uwAfUQfiDCVpg7aXxJ10Fzo6/Xdxbt5Kmm3W24mfl51T8zpkq20YHSbJ+uG1YaJ9egU8CNn0L3li3duGmC0yyHNHc9Axe5boWaXxCsEZqsSJ6098AhZbOsYiTQg0iRovtPVmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382380; c=relaxed/simple;
	bh=g9RWuZtC7he717kJRvybOS/DWVR3tzwH5luwapkwbpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR2C6EtgD1UYvUR+mDs8erF3u89pXz8Ctk5cPbEKSviLAJS1gKKV7Ajd3Ewfac2q/yR723APm2mJlZ1MHTrJ54DuZfacrg+npJZWTr7w91/PxTqcb8SeEMQ915pAJfD56jxBOOVuhZSUPfB4CsajbnVRLMcfJkLgw2WaEEbhRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ifEIv+bo; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=LJ9zQbFRAXQYsgUiGqfhlDGHUr76nq8+nalQeidRqak=; b=ifEIv+boKsWtoQmogdKRmSePIl
	KwwPTo5N6d7yrFdAdeJKcXfalTIP97y7fYRIGDoXcQTS7QFJ4IWfKY0kJCDqMhbnoH+6YIa9EJVwA
	9ud5kSZEuubSPcZ3wblAH2jPr9XrNUbVmI7y/gFFvdBWRxsRpXtLDc/+IJEoKB1av4lDuHhPIjgGn
	pyZmaO0UkdNwh7D8NuG7Ydk56oOgHEHZrBQu27BY09ZUsUqkYukNuzsfXN79SAcmQICzd+gTorPMK
	nc/rRmFLQUz7poiSJcUu0whht9GcKWc3izHRhoyXJRHXm8Bzdx9Y1ymVRXMh23uD0w5kLytxJiCNS
	nn4t8uSA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIL-0037Oz-2d;
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
Subject: [PATCH v2 06/31] ntsync: Introduce NTSYNC_IOC_CREATE_MUTEX.
Date: Mon, 19 Feb 2024 16:38:08 -0600
Message-ID: <20240219223833.95710-7-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtCreateMutant().

An NT mutex is recursive, with a 32-bit recursion counter. When acquired via
NtWaitForMultipleObjects(), the recursion counter is incremented by one.

The OS records the thread which acquired it. However, in order to keep this
driver self-contained, the owning thread ID is managed by user-space, and passed
as a parameter to all relevant ioctls.

The initial owner and recursion count, if any, are specified when the mutex is
created.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 67 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  7 ++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index d5759e9a3a8e..6f7086d0440a 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -24,6 +24,7 @@
 
 enum ntsync_type {
 	NTSYNC_TYPE_SEM,
+	NTSYNC_TYPE_MUTEX,
 };
 
 /*
@@ -53,6 +54,10 @@ struct ntsync_obj {
 			__u32 count;
 			__u32 max;
 		} sem;
+		struct {
+			__u32 count;
+			__u32 owner;
+		} mutex;
 	} u;
 
 	/*
@@ -132,6 +137,10 @@ static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
 	switch (obj->type) {
 	case NTSYNC_TYPE_SEM:
 		return !!obj->u.sem.count;
+	case NTSYNC_TYPE_MUTEX:
+		if (obj->u.mutex.owner && obj->u.mutex.owner != owner)
+			return false;
+		return obj->u.mutex.count < UINT_MAX;
 	}
 
 	WARN(1, "bad object type %#x\n", obj->type);
@@ -174,6 +183,10 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
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
@@ -215,6 +228,28 @@ static void try_wake_any_sem(struct ntsync_obj *sem)
 	}
 }
 
+static void try_wake_any_mutex(struct ntsync_obj *mutex)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&mutex->lock);
+
+	list_for_each_entry(entry, &mutex->any_waiters, node) {
+		struct ntsync_q *q = entry->q;
+
+		if (mutex->u.mutex.count == UINT_MAX)
+			break;
+		if (mutex->u.mutex.owner && mutex->u.mutex.owner != q->owner)
+			continue;
+
+		if (atomic_cmpxchg(&q->signaled, -1, entry->index) == -1) {
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
@@ -374,6 +409,33 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
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
@@ -493,6 +555,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_SEM:
 		try_wake_any_sem(obj);
 		break;
+	case NTSYNC_TYPE_MUTEX:
+		try_wake_any_mutex(obj);
+		break;
 	}
 }
 
@@ -681,6 +746,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_MUTEX:
+		return ntsync_create_mutex(dev, argp);
 	case NTSYNC_IOC_CREATE_SEM:
 		return ntsync_create_sem(dev, argp);
 	case NTSYNC_IOC_WAIT_ALL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 19c37e27a4f8..8ac9d419c360 100644
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
 struct ntsync_wait_args {
 	__u64 timeout;
 	__u64 objs;
@@ -30,6 +36,7 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 #define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
+#define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 
-- 
2.43.0


