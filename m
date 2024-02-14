Return-Path: <linux-kselftest+bounces-4679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3A8855783
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04378287C70
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778541420CB;
	Wed, 14 Feb 2024 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qI/zQAPn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF11420B6;
	Wed, 14 Feb 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954791; cv=none; b=m1wsIJutpk0hhYogRofd0c0XzmRnLotjfMmtE6Hlx8fc6qoJU0lIpWIl+xS9t5ypIVKUQtqEXRSP4Zj04JvwME7E/XQ75esZFnrLPNM2TncK88U0DviDVxW/sfILh5zzfFmKg45rwu88k6hTMwd4yBRN+KvXVfLD4q4WN4zHZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954791; c=relaxed/simple;
	bh=l13BgqVKFJovtJfczy/tTQhCjfR6OdlM4okW+pv3D0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIT/R3CrtaztI7eyjI+6H0QQwUVa/3UILPPIVeekBeyXUMQvSGwUz6NX5CmKO2NfcI6csLeCKNy9WW4W47E16IWqALZVZRFExguYp1IEHVDdfogqU6dNDVPqmSIKDdDd8wbY9DrKTQRtCVFDJNAm2omeODoC/TBLL/XloVu8qkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=qI/zQAPn; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=kCe4tmwPVNV+GsMq6QYMed33sYkMNNuhATDpMCBOUxY=; b=qI/zQAPnmOYY5yx1FrZPOmnRni
	8Qqu8fDDFp8QP0NfLFDkc6fx6KlhwN72bbFqIsT+yy0Ote1xi3K8Ap8IV/yHBwccFyN/ZFQdY/MwR
	NXLwwRCdiTH/sEW/5iB792wwg1j65xp71nHcVHFy97KyxzQHSDniLD0Olf+jDNd0X7WBDusSMsaH/
	FHY9ePjuX6tyxoQ+NvBxdpS0yzWwJ0V+iNmFL48TF2pII6vC7/+6z+TTNxMaUzt329w30qIZiLjwI
	0rGNwSVbpWUItynfnefWGLyZwMEo6RSuEbDSQJ/i1rpDJFXKxAw4cx7Clg1VHeaQL2HO/3NH6N/gd
	PPTHLoyw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raOob-00GbiL-2M;
	Wed, 14 Feb 2024 17:37:22 -0600
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
Subject: [PATCH 09/31] ntsync: Introduce NTSYNC_IOC_CREATE_EVENT.
Date: Wed, 14 Feb 2024 17:36:45 -0600
Message-ID: <20240214233645.9273-10-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214233645.9273-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This correspond to the NT syscall NtCreateEvent().

An NT event holds a single bit of state denoting whether it is signaled or
unsignaled.

There are two types of events: manual-reset and automatic-reset. When an
automatic-reset event is acquired via a wait function, its state is reset to
unsignaled. Manual-reset events are not affected by wait functions.

Whether the event is manual-reset, and its initial state, are specified at
creation time.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 60 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  7 +++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 8cb951c76aca..2a21e7b0982a 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -25,6 +25,7 @@
 enum ntsync_type {
 	NTSYNC_TYPE_SEM,
 	NTSYNC_TYPE_MUTEX,
+	NTSYNC_TYPE_EVENT,
 };
 
 struct ntsync_obj {
@@ -46,6 +47,10 @@ struct ntsync_obj {
 			__u32 owner;
 			bool ownerdead;
 		} mutex;
+		struct {
+			bool manual;
+			bool signaled;
+		} event;
 	} u;
 
 	/*
@@ -130,6 +135,8 @@ static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
 		if (obj->u.mutex.owner && obj->u.mutex.owner != owner)
 			return false;
 		return obj->u.mutex.count < UINT_MAX;
+	case NTSYNC_TYPE_EVENT:
+		return obj->u.event.signaled;
 	}
 
 	WARN(1, "bad object type %#x\n", obj->type);
@@ -179,6 +186,10 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 				obj->u.mutex.count++;
 				obj->u.mutex.owner = q->owner;
 				break;
+			case NTSYNC_TYPE_EVENT:
+				if (!obj->u.event.manual)
+					obj->u.event.signaled = false;
+				break;
 			}
 		}
 		wake_up_process(q->task);
@@ -245,6 +256,26 @@ static void try_wake_any_mutex(struct ntsync_obj *mutex)
 	}
 }
 
+static void try_wake_any_event(struct ntsync_obj *event)
+{
+	struct ntsync_q_entry *entry;
+
+	lockdep_assert_held(&event->lock);
+
+	list_for_each_entry(entry, &event->any_waiters, node) {
+		struct ntsync_q *q = entry->q;
+
+		if (!event->u.event.signaled)
+			break;
+
+		if (atomic_cmpxchg(&q->signaled, -1, entry->index) == -1) {
+			if (!event->u.event.manual)
+				event->u.event.signaled = false;
+			wake_up_process(q->task);
+		}
+	}
+}
+
 /*
  * Actually change the semaphore state, returning -EOVERFLOW if it is made
  * invalid.
@@ -553,6 +584,30 @@ static int ntsync_create_mutex(struct ntsync_device *dev, void __user *argp)
 	return put_user(fd, &user_args->mutex);
 }
 
+static int ntsync_create_event(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_event_args __user *user_args = argp;
+	struct ntsync_event_args args;
+	struct ntsync_obj *event;
+	int fd;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	event = ntsync_alloc_obj(dev, NTSYNC_TYPE_EVENT);
+	if (!event)
+		return -ENOMEM;
+	event->u.event.manual = args.manual;
+	event->u.event.signaled = args.signaled;
+	fd = ntsync_obj_get_fd(event);
+	if (fd < 0) {
+		kfree(event);
+		return fd;
+	}
+
+	return put_user(fd, &user_args->event);
+}
+
 static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
 {
 	struct file *file = fget(fd);
@@ -676,6 +731,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_MUTEX:
 		try_wake_any_mutex(obj);
 		break;
+	case NTSYNC_TYPE_EVENT:
+		try_wake_any_event(obj);
+		break;
 	}
 }
 
@@ -864,6 +922,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_EVENT:
+		return ntsync_create_event(dev, argp);
 	case NTSYNC_IOC_CREATE_MUTEX:
 		return ntsync_create_mutex(dev, argp);
 	case NTSYNC_IOC_CREATE_SEM:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 3861397c6c2f..b8cf503365ef 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -22,6 +22,12 @@ struct ntsync_mutex_args {
 	__u32 count;
 };
 
+struct ntsync_event_args {
+	__u32 event;
+	__u32 manual;
+	__u32 signaled;
+};
+
 struct ntsync_wait_args {
 	__u64 timeout;
 	__u64 objs;
@@ -37,6 +43,7 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 #define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
 #define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
+#define NTSYNC_IOC_CREATE_EVENT		_IOWR('N', 0x87, struct ntsync_event_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
-- 
2.43.0


