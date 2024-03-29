Return-Path: <linux-kselftest+bounces-6801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38AF890F4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7970328BDAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D242375F;
	Fri, 29 Mar 2024 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="AZv9bCo6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58A29D02;
	Fri, 29 Mar 2024 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671826; cv=none; b=pUwXmUbw3VoxHALeXF4SxALHnIjhKeHy0OGs1I/iwmhnlihT5AgwvqPzfDUu5yVuA7s1srfZX40s2mshYK5u0OmLXYywmLHvVT5KH4HPc6jpk6hALPGQBcYU1g8Bz/oU/Xox4SytHbjvBaVznpI2J6suqXP+mvAlxoLZxOiEKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671826; c=relaxed/simple;
	bh=qk0lOShQNh46Ivwy26TSgyRhbSnLQO0T3i9GzNtHLDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1NMvhA4HuTwE2n4yim4MGf6+IhGm4JOqhmeZProkSj+HRgBmwn/7mX0bYOgSK/kUfe/Ks595Z5SaAG8IAlPBOYd5mbLrFO65i7mRFLh5YZ991Dj2JRG6mxaY3inoFkVhmrEM0bjaS0Q71P74twPGgeoVeGWSzHjjlwgVMevw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=AZv9bCo6; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=cKdpBzNnrH572ZCQ0KkLAIrp1rHYDFK3Qi77ARszWL4=; b=AZv9bCo6UxCCsjdcPy9afMlsj1
	SgXI//YMObCuxx8zAA+UIfrZSo37TPgJNZkDsMovlw85ts/+DezgGFGv7Q7odl8Q5Ths9/nw4/i3r
	J5LmrPK2QuOeh/F29zAmDAp2gh6wfp1iOd7Gi0KlP1NWc2tL0uqKRbARad+yRb8B+zD1QBP+mJUQO
	Er6Kj56ZeNR45+CHbxCr8D3W23mdzX4dD5OUwaMgDVhvuowgblJQ0PdoPaWO32NYwr717si7oSi9/
	KO4DbsCTEAC872XyoeIho7Cr9WcseJRazBh5bR01d9Fx4r24uyR2Ubzb6IJ1qwx4Zpf9MiRcd/f9a
	7I1I4mFg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlN-000iik-1N;
	Thu, 28 Mar 2024 19:06:29 -0500
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
Subject: [PATCH v3 09/30] ntsync: Introduce NTSYNC_IOC_CREATE_EVENT.
Date: Thu, 28 Mar 2024 19:06:00 -0500
Message-ID: <20240329000621.148791-10-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 61 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  7 +++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 1e68f96bc2a6..3e125c805c00 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -25,6 +25,7 @@
 enum ntsync_type {
 	NTSYNC_TYPE_SEM,
 	NTSYNC_TYPE_MUTEX,
+	NTSYNC_TYPE_EVENT,
 };
 
 /*
@@ -59,6 +60,10 @@ struct ntsync_obj {
 			__u32 owner;
 			bool ownerdead;
 		} mutex;
+		struct {
+			bool manual;
+			bool signaled;
+		} event;
 	} u;
 
 	/*
@@ -143,6 +148,8 @@ static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
 		if (obj->u.mutex.owner && obj->u.mutex.owner != owner)
 			return false;
 		return obj->u.mutex.count < UINT_MAX;
+	case NTSYNC_TYPE_EVENT:
+		return obj->u.event.signaled;
 	}
 
 	WARN(1, "bad object type %#x\n", obj->type);
@@ -193,6 +200,10 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
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
@@ -261,6 +272,27 @@ static void try_wake_any_mutex(struct ntsync_obj *mutex)
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
+		int signaled = -1;
+
+		if (!event->u.event.signaled)
+			break;
+
+		if (atomic_try_cmpxchg(&q->signaled, &signaled, entry->index)) {
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
@@ -569,6 +601,30 @@ static int ntsync_create_mutex(struct ntsync_device *dev, void __user *argp)
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
@@ -702,6 +758,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_MUTEX:
 		try_wake_any_mutex(obj);
 		break;
+	case NTSYNC_TYPE_EVENT:
+		try_wake_any_event(obj);
+		break;
 	}
 }
 
@@ -890,6 +949,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_EVENT:
+		return ntsync_create_event(dev, argp);
 	case NTSYNC_IOC_CREATE_MUTEX:
 		return ntsync_create_mutex(dev, argp);
 	case NTSYNC_IOC_CREATE_SEM:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 1bff8f19d6d9..0d133f2eaf0b 100644
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
 #define NTSYNC_WAIT_REALTIME	0x1
 
 struct ntsync_wait_args {
@@ -41,6 +47,7 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 #define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
 #define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
+#define NTSYNC_IOC_CREATE_EVENT		_IOWR('N', 0x87, struct ntsync_event_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
-- 
2.43.0


