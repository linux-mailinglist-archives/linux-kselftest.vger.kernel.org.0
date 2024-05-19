Return-Path: <linux-kselftest+bounces-10395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1A8C9642
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1657C281039
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72E745ED;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="HIZ2ZFdc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516C6CDBA;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150318; cv=none; b=gDt7bGrarPVgngTUbr8HmFVaOeP2tT4xx0rR/K8Hz/dPvQceTRD2eq+SXW7TeBsezT5nJf4DKfznnnh4QH2+i6JaMKjU/0emKy9XszuZKXogzQ74zgtk0kfp1N+PUTXjyUOdS8tHPX/iOAJcsHZ60VHglJKpswzxsVTlnJhY3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150318; c=relaxed/simple;
	bh=kOb1FH9djmQc7LvELwKAp6hnBl6kdCrtJvzOkAIBB/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXUBtwuZQQWiChHuLBU+EBc5HWih+3rhmjsw13AoV49MtZsHMc7GwO7nOM0JNA0AQG+ht9Tk+8HQtgn3fWL6+yRUQ+i+Rcoj1TtqRO/F051LvHT7OtC6kOBgS3kwl/aVBh0uR7m8VHLi3DFLCOwvvq+7thmAdowE4Pg84ux5aR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=HIZ2ZFdc; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=BgBNC2xcSXEjJ2rv6QHhrjFmmRQcAuTFy5j2XSEnzPU=; b=HIZ2ZFdcA/0NcduNT8tydrObm2
	Y/J0xjLjbHcRHfZoHrNVskfdyzZ/vItrQQDUNMfCvORwCeeUYeSuvaVlMZdGEdeOEYFrdATwMnUsP
	oYHCvU7XsjHhGg0u6oVWg4E9W0vPxk2oGbjOQGtFAEuWBTvTfVXLX+1+fKaMzfW5b9Mv58EDlpHzF
	Qqb6jJA6xBaBSUwLdyYOiMMiBPT+wFNWvqWzwuD3TVUInbhZx/+s8LLSOTh88qxFyS9buog7//3au
	0+1yDg4fypkpcdlgSbcSSzXdBshIKE14VcEP7YE16V6YHbgCukwtsoLjEnWAc0vd/hxsmWt5a0GQ3
	7BOgnVhQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5b-008wIn-36;
	Sun, 19 May 2024 15:25:04 -0500
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
Subject: [PATCH v5 06/28] ntsync: Introduce NTSYNC_IOC_CREATE_EVENT.
Date: Sun, 19 May 2024 15:24:32 -0500
Message-ID: <20240519202454.1192826-7-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 62 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  7 +++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 5aaf9dad76b6..2bce03187c17 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -26,6 +26,7 @@
 enum ntsync_type {
 	NTSYNC_TYPE_SEM,
 	NTSYNC_TYPE_MUTEX,
+	NTSYNC_TYPE_EVENT,
 };
 
 /*
@@ -61,6 +62,10 @@ struct ntsync_obj {
 			pid_t owner;
 			bool ownerdead;
 		} mutex;
+		struct {
+			bool manual;
+			bool signaled;
+		} event;
 	} u;
 
 	/*
@@ -233,6 +238,8 @@ static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
 		if (obj->u.mutex.owner && obj->u.mutex.owner != owner)
 			return false;
 		return obj->u.mutex.count < UINT_MAX;
+	case NTSYNC_TYPE_EVENT:
+		return obj->u.event.signaled;
 	}
 
 	WARN(1, "bad object type %#x\n", obj->type);
@@ -283,6 +290,10 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
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
@@ -353,6 +364,28 @@ static void try_wake_any_mutex(struct ntsync_obj *mutex)
 	}
 }
 
+static void try_wake_any_event(struct ntsync_obj *event)
+{
+	struct ntsync_q_entry *entry;
+
+	ntsync_assert_held(event);
+	lockdep_assert(event->type == NTSYNC_TYPE_EVENT);
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
@@ -629,6 +662,30 @@ static int ntsync_create_mutex(struct ntsync_device *dev, void __user *argp)
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
@@ -759,6 +816,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_MUTEX:
 		try_wake_any_mutex(obj);
 		break;
+	case NTSYNC_TYPE_EVENT:
+		try_wake_any_event(obj);
+		break;
 	}
 }
 
@@ -948,6 +1008,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_EVENT:
+		return ntsync_create_event(dev, argp);
 	case NTSYNC_IOC_CREATE_MUTEX:
 		return ntsync_create_mutex(dev, argp);
 	case NTSYNC_IOC_CREATE_SEM:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index d7996180c1d2..4c0c4271c7de 100644
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
@@ -40,6 +46,7 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 #define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
 #define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
+#define NTSYNC_IOC_CREATE_EVENT		_IOWR('N', 0x87, struct ntsync_event_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
-- 
2.43.0


