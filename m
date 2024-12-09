Return-Path: <linux-kselftest+bounces-23085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE85C9E9F13
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C253F2851AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC741A9B25;
	Mon,  9 Dec 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="iaR8KX+p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617A1A707A;
	Mon,  9 Dec 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770995; cv=none; b=Gnfs/Ehi6K+DItMkPWFGIPXJNfFiGk1uzDfgA7BLMhcZmot0WhDrkAeinKGcZUrbD7ge5aGNhUn4cvTRolJjiAw/eKAW/tZJRFlqJAOSynibsLMT1cS3J4AxSLCm6vFryimacSry7tOZuShz6/p+0MDceDGwQueyMHTfSe4QHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770995; c=relaxed/simple;
	bh=CSWtZmYdEPGFhBHR00Jti0zhe4Sl3AMpzKwLnC89Cbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYHQMo4b7Ppt4KDxsN3QkG5NizjZvFr+EF9NxxHe3zTSHfdTlJ3zc2ibOdjPTXvQmMiS/nMaTRCBENpb+grdwihA5NaJbQ6iRWPpt+CEBpAf+uTgjERMwP0edXdRCRO4c1hhMuobPNO/ygDG6bkkgBjI+8iZ/ntuUqNbcmV9e2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=iaR8KX+p; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SN9QY4qrQDEzA/GyZ+ov1ABljEcCDLyc0yuR+RDikLY=; b=iaR8KX+pTAiTcpKsay91WO9/mM
	rswAT6SQMlJadz5QUpevtvu6zePqFj+YHOp2kr1AEiRJxwNr1n1vaMTDKwN37SaRXHISMjga+8har
	+XBsj1h+LXYN+GepNAY69LvNJ7mn2Eik659pP0mshLS7OpuAipK068yq7xsFSNw550B9jBYpFdWLh
	nE15uf03XC/iYmOIzkwc4L+WVmC3/ZQlAYOPquuQ6s5HPG/ufX0KcoLHA0MeYOF8+LIVWLu4PoZxH
	n/bNsmdCDNlBMh9tdLKkR0E5pfBC3xCP70pCTkIuH4fBQ1PcmoBgwFTnZ26PJd2/1Q4pspCqeiAYy
	9NTq3nMw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyY-001Gd5-2f;
	Mon, 09 Dec 2024 12:59:23 -0600
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
Subject: [PATCH v6 06/28] ntsync: Introduce NTSYNC_IOC_CREATE_EVENT.
Date: Mon,  9 Dec 2024 12:58:42 -0600
Message-ID: <20241209185904.507350-7-zfigura@codeweavers.com>
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
index 0ed864d291a6..ef8949ee2d4b 100644
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
@@ -628,6 +661,30 @@ static int ntsync_create_mutex(struct ntsync_device *dev, void __user *argp)
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
@@ -758,6 +815,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 	case NTSYNC_TYPE_MUTEX:
 		try_wake_any_mutex(obj);
 		break;
+	case NTSYNC_TYPE_EVENT:
+		try_wake_any_event(obj);
+		break;
 	}
 }
 
@@ -947,6 +1007,8 @@ static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
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
2.45.2


