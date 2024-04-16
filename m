Return-Path: <linux-kselftest+bounces-8060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13598A5FD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AE4283666
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024862C1A0;
	Tue, 16 Apr 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="eZkAshJa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8177539C;
	Tue, 16 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229832; cv=none; b=RlQ2phVjoiu3ApGC9CUvVWblr5mRRGSywMTN3WqN7lRTkPbRO8T2AwvDL+gZ2xjxYtGph7EIKNhNuaH7j9sbDkLHHf+vXC/6qDw+sING7jgVHVbISMv5Xatea4bZ4jjeKbUETM9qx6fZDmH6MgZSwELj4PM/HmkGds01dRlxCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229832; c=relaxed/simple;
	bh=jMvq7fx/BS69F42/Buz/xgKn5BhcZLV7lKdNJQgqWcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIi0LySIq5E6ghT22Mfez4mY+XECFY/PgFP/WD86hYWnGNSa5lClPgK6V7+e+nalkXWI1HeGE3XMEMm3TDdTS4j5xV3BLCwon8plqwRNOuwe3oPWyatv2niKLu5m2M7/F6IKvf1Jka9EWdUqhhp2XbuGI7eqO79xam0Dw7+w0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=eZkAshJa; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=IdS3njZ516lDixLKMQGfXljzOoGHuaZPkJDeVL0RQ74=; b=eZkAshJa/IcvMZ5fbvLX4R9h6i
	QC3Hon4lpZEwPT0WOMP2ZakUIbp1Je2BYZ9aG3rZzdSR+fPQQkyoD6n8PgjRPBJ2dVf9NmbflQs2K
	75gxoS/PzgopQB0+fh/RF0bm9YvspCtoNDPpi+aABvTVgFbjRMpM6B6Th9tzx+FAC6In7qpKl7weS
	ANP+rZLQ0StulXUBuNgwEQPyc2OTvy0UOi605IbR70t5auZXR3oi7KoU4hqpJDFMIJfVGoNMLMe2D
	51Dyh/pE0FsjJ3dSBeQZkk0lZ9fH+x76f0jRWTGAJV40rU5lgSTevItbppvD7Jbo/tfUaPsAoVXrV
	CtjAjvXQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXKz-00FbQv-04;
	Mon, 15 Apr 2024 20:10:17 -0500
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
Subject: [PATCH v4 05/27] ntsync: Introduce NTSYNC_IOC_MUTEX_KILL.
Date: Mon, 15 Apr 2024 20:08:15 -0500
Message-ID: <20240416010837.333694-6-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416010837.333694-1-zfigura@codeweavers.com>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This does not correspond to any NT syscall. Rather, when a thread dies, it
should be called by the NT emulator for each mutex.

NT mutexes are robust (in the pthread sense). When an NT thread dies, any
mutexes it owned are immediately released. Acquisition of those mutexes by other
threads will return a special value indicating that the mutex was abandoned,
like EOWNERDEAD returned from pthread_mutex_lock(), and EOWNERDEAD is indeed
used here for that purpose.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 71 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index f7911ef78d5b..1e68f96bc2a6 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -57,6 +57,7 @@ struct ntsync_obj {
 		struct {
 			__u32 count;
 			__u32 owner;
+			bool ownerdead;
 		} mutex;
 	} u;
 
@@ -109,6 +110,7 @@ struct ntsync_q {
 	atomic_t signaled;
 
 	bool all;
+	bool ownerdead;
 	__u32 count;
 	struct ntsync_q_entry entries[];
 };
@@ -185,6 +187,9 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 				obj->u.sem.count--;
 				break;
 			case NTSYNC_TYPE_MUTEX:
+				if (obj->u.mutex.ownerdead)
+					q->ownerdead = true;
+				obj->u.mutex.ownerdead = false;
 				obj->u.mutex.count++;
 				obj->u.mutex.owner = q->owner;
 				break;
@@ -246,6 +251,9 @@ static void try_wake_any_mutex(struct ntsync_obj *mutex)
 			continue;
 
 		if (atomic_try_cmpxchg(&q->signaled, &signaled, entry->index)) {
+			if (mutex->u.mutex.ownerdead)
+				q->ownerdead = true;
+			mutex->u.mutex.ownerdead = false;
 			mutex->u.mutex.count++;
 			mutex->u.mutex.owner = q->owner;
 			wake_up_process(q->task);
@@ -377,6 +385,62 @@ static int ntsync_mutex_unlock(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state to mark its owner as dead,
+ * returning -EPERM if not the owner.
+ */
+static int kill_mutex_state(struct ntsync_obj *mutex, __u32 owner)
+{
+	lockdep_assert_held(&mutex->lock);
+
+	if (mutex->u.mutex.owner != owner)
+		return -EPERM;
+
+	mutex->u.mutex.ownerdead = true;
+	mutex->u.mutex.owner = 0;
+	mutex->u.mutex.count = 0;
+	return 0;
+}
+
+static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
+{
+	struct ntsync_device *dev = mutex->dev;
+	__u32 owner;
+	int ret;
+
+	if (get_user(owner, (__u32 __user *)argp))
+		return -EFAULT;
+	if (!owner)
+		return -EINVAL;
+
+	if (mutex->type != NTSYNC_TYPE_MUTEX)
+		return -EINVAL;
+
+	if (atomic_read(&mutex->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
+
+		ret = kill_mutex_state(mutex, owner);
+		if (!ret) {
+			try_wake_all_obj(dev, mutex);
+			try_wake_any_mutex(mutex);
+		}
+
+		spin_unlock(&mutex->lock);
+		spin_unlock(&dev->wait_all_lock);
+	} else {
+		spin_lock(&mutex->lock);
+
+		ret = kill_mutex_state(mutex, owner);
+		if (!ret)
+			try_wake_any_mutex(mutex);
+
+		spin_unlock(&mutex->lock);
+	}
+
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -398,6 +462,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_sem_post(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
+	case NTSYNC_IOC_MUTEX_KILL:
+		return ntsync_mutex_kill(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -592,6 +658,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
 	q->all = all;
+	q->ownerdead = false;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -699,7 +766,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
@@ -780,7 +847,7 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index fa2c9f638d77..1bff8f19d6d9 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -44,5 +44,6 @@ struct ntsync_wait_args {
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
+#define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 
 #endif
-- 
2.43.0


