Return-Path: <linux-kselftest+bounces-4689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB18557AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5861F215BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCB1474B3;
	Wed, 14 Feb 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="OjkZwJXh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3321468FF;
	Wed, 14 Feb 2024 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954813; cv=none; b=j2dv+EV2bMIuEacAEd8VFPttLzXW0qOA1KNK7XEr1TGJ7meZtlWBKOTU0bqa+IJan2oZLycHMEL80y2P+wA9Zuj9ZT9ECPklbyfibaMCn5mFNeHZn0PqORs0vVbRCaHW0Frna1AU9QHmV7QdjnkBv//Fn+vhFeq6c5mVKVp6TRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954813; c=relaxed/simple;
	bh=g2t5359dB4FigZaXrTNh4sSOe3d4Mc/XHu4ktisxSSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5YkUpg3ntRm3+SbnnoOebCLWFPRuwa6CBWAD57MhctIMp9SX55XxnqJ4Rdu/96laW9fc6U4lvwo5F62S3NEtXrcwJ6qNieeY+vMuVQy7KH45tjHbXgXRTE8U+k14DxgxURorC881UivfpDOTGKWYchRROaUMp2d3SuSCI91AVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=OjkZwJXh; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=L81PuhjSIRjAjeyJBw9VXn44xHf+EZrYzbujwA6VKQQ=; b=OjkZwJXhvLjM4LJJ2/Z7pkKK3+
	VUAD7carifJqWwtzDHOMkMVYJO0UX2IqqrcStW5Or1+unkvpslrwGilvo54TS/zWtuV35dblLdPXA
	zmHN98pYipcVfQp2c8hNRikNAeH8tUDdqNeR4tK16AWNC0lAChMllprGv/pVERRilpVoeIzM4I0eb
	D1iZBgdi5qzL3bn4SH/Eejzh3YSo7L1LRo6gYa7Ju4K3bwnFlExGE6QcEFZfpkkbilvsFMJNlMcXh
	G+hc2I6xiQG8+w1Uy3TPo+14VLt+/1tjYdzyQ3g9HIzhT92Sk7YeEhtSZHTQOmjbdq4ARcSCv4x42
	nH05oQxg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raOoa-00GbiL-0d;
	Wed, 14 Feb 2024 17:37:20 -0600
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
Subject: [PATCH 08/31] ntsync: Introduce NTSYNC_IOC_MUTEX_KILL.
Date: Wed, 14 Feb 2024 17:36:44 -0600
Message-ID: <20240214233645.9273-9-zfigura@codeweavers.com>
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
index 42041afd8d15..8cb951c76aca 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -44,6 +44,7 @@ struct ntsync_obj {
 		struct {
 			__u32 count;
 			__u32 owner;
+			bool ownerdead;
 		} mutex;
 	} u;
 
@@ -96,6 +97,7 @@ struct ntsync_q {
 	atomic_t signaled;
 
 	bool all;
+	bool ownerdead;
 	__u32 count;
 	struct ntsync_q_entry entries[];
 };
@@ -171,6 +173,9 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 				obj->u.sem.count--;
 				break;
 			case NTSYNC_TYPE_MUTEX:
+				if (obj->u.mutex.ownerdead)
+					q->ownerdead = true;
+				obj->u.mutex.ownerdead = false;
 				obj->u.mutex.count++;
 				obj->u.mutex.owner = q->owner;
 				break;
@@ -230,6 +235,9 @@ static void try_wake_any_mutex(struct ntsync_obj *mutex)
 			continue;
 
 		if (atomic_cmpxchg(&q->signaled, -1, entry->index) == -1) {
+			if (mutex->u.mutex.ownerdead)
+				q->ownerdead = true;
+			mutex->u.mutex.ownerdead = false;
 			mutex->u.mutex.count++;
 			mutex->u.mutex.owner = q->owner;
 			wake_up_process(q->task);
@@ -361,6 +369,62 @@ static int ntsync_mutex_unlock(struct ntsync_obj *mutex, void __user *argp)
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
@@ -382,6 +446,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_sem_post(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
+	case NTSYNC_IOC_MUTEX_KILL:
+		return ntsync_mutex_kill(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -566,6 +632,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
 	q->all = all;
+	q->ownerdead = false;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -673,7 +740,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
@@ -754,7 +821,7 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index a3f5f4f13798..3861397c6c2f 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -40,5 +40,6 @@ struct ntsync_wait_args {
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
+#define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 
 #endif
-- 
2.43.0


