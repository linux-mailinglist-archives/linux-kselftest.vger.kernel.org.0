Return-Path: <linux-kselftest+bounces-23337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFF9F160B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEBD2830EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1181EE028;
	Fri, 13 Dec 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qg7ASRzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94719CD08;
	Fri, 13 Dec 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118545; cv=none; b=S6NC03CWWaej2/o09mwdK06nWt1kK/4oi+gRfB9zWv1undkgOxvUgzb2us+oDxcqCVHb9prR0rwI3JfQqDb9p8Q6xnC6zt6/ZaQ7vrSkmoPMcGeWzeTN2ePehXFBKsrcNVcbueaNhaZBBbQn9R+MAsE1GkVhmbeOCHhWpbkFy9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118545; c=relaxed/simple;
	bh=3wFADFYeVj3fTxUeD+NvenZCkO+2yUEH4rpOzVOg2Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MACrhifuWtVPnCNJ1Ns+nDGaS3PdNqjR2CZS61o94MAInhcXRE3VaQQaf9udyavw8Hnz063zwrUVgOJ7M5AFfRMEAFTBFsa2HHnQdttkCWUxxXJXy3+drDerlgKLsYBJqAlca7GVFCZBUc1rtMBOowFrrkCA9K9B6vfytAaOhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=qg7ASRzu; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S/1CicU0OsNNi8hZdym72pBmmuJZmB6WjH/rx9DAiLg=; b=qg7ASRzuCTHPZwqWJCl88HwNWF
	WJNsaQpKj9DvjyZhKbnVvDQWvV5gYUEazC5e1ShEEWUfQBkFL9fU7tcLh2sJQLGfFEaj3ptnXwwNz
	bPuvMos/kYn02L0gHHz3j8vMBOG++9d/HcMAkgWA0zBDV+KyPEFpZE7LiBkECE30Atg2Oqh4bt2sG
	YuSax/vd9KUg9+YJ7me+tshddw9Z2iMuoQC0PAUwX8ULJBIYvKzOUPfSe4M+y1xPEywwRCadeTmts
	MmFXbNniLHgrOSV4hQb9raSID13tnH9dtv92NMOCJEzpN69jBUpwxWcwrmiDVztCLxVPlzH30exbA
	Cmkb/lBA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRt-00ASsZ-11;
	Fri, 13 Dec 2024 13:35:41 -0600
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
Subject: [PATCH v7 08/30] ntsync: Introduce NTSYNC_IOC_CREATE_EVENT.
Date: Fri, 13 Dec 2024 13:34:49 -0600
Message-ID: <20241213193511.457338-9-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 59 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  6 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 03768ac25425..3e8827b6f480 100644
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
@@ -622,6 +655,27 @@ static int ntsync_create_mutex(struct ntsync_device *dev, void __user *argp)
 	return fd;
 }
 
+static int ntsync_create_event(struct ntsync_device *dev, void __user *argp)
+{
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
+	if (fd < 0)
+		kfree(event);
+
+	return fd;
+}
+
 static struct ntsync_obj *get_obj(struct ntsync_device *dev, int fd)
 {
 	struct file *file = fget(fd);
@@ -752,6 +806,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_MUTEX:
 		try_wake_any_mutex(obj);
 		break;
+	case NTSYNC_TYPE_EVENT:
+		try_wake_any_event(obj);
+		break;
 	}
 }
 
@@ -941,6 +998,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_EVENT:
+		return ntsync_create_event(dev, argp);
 	case NTSYNC_IOC_CREATE_MUTEX:
 		return ntsync_create_mutex(dev, argp);
 	case NTSYNC_IOC_CREATE_SEM:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 633958d90be3..e08aa02f4dcc 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -20,6 +20,11 @@ struct ntsync_mutex_args {
 	__u32 count;
 };
 
+struct ntsync_event_args {
+	__u32 manual;
+	__u32 signaled;
+};
+
 #define NTSYNC_WAIT_REALTIME	0x1
 
 struct ntsync_wait_args {
@@ -38,6 +43,7 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_WAIT_ANY		_IOWR('N', 0x82, struct ntsync_wait_args)
 #define NTSYNC_IOC_WAIT_ALL		_IOWR('N', 0x83, struct ntsync_wait_args)
 #define NTSYNC_IOC_CREATE_MUTEX		_IOW ('N', 0x84, struct ntsync_mutex_args)
+#define NTSYNC_IOC_CREATE_EVENT		_IOW ('N', 0x87, struct ntsync_event_args)
 
 #define NTSYNC_IOC_SEM_RELEASE		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
-- 
2.45.2


