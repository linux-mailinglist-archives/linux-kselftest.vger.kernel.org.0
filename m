Return-Path: <linux-kselftest+bounces-23350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95569F1642
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E8716B7D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20E1F5410;
	Fri, 13 Dec 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="doMXkxil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977761F2C49;
	Fri, 13 Dec 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118552; cv=none; b=e+w0ZI/oBuatWvVpgpJ48Dbr6UzO3ndqWaMnMWcw/CbqTna/0QaCQB6saDDEJAL2o6sMB2URheTqGptrWNb4l51oNHMU+VbYM5DPpayKiVDxLpB1XRUFsINt2CYlUaZM7mLg5TH5NwBUMOtxmAM7Ur7mmSr0moj+xBjvzS+qvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118552; c=relaxed/simple;
	bh=fW5D1wfxvpuIdkNkQSqJ2LlNqfQqwXp0C4GvIUfZr5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKISwvSzE520LkChrZxnIHJLJ99l9s0VQbfSG3Sf3kPQrEuEtdhlEoOhcfkGQRb/H7MnQztUKe7xooYrSwvVLIm7dO75JKZE6AGKff8gLsnTs3Y6q9bHfHXuKQzaf4OV4AtY9M3gqaSQRj3gJv0qiEplxp4+Lddf+fUSTOqwWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=doMXkxil; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yumYMezSS0n5QG01GR01eRlgdm/x9BMNJ2FrV2khi04=; b=doMXkxill1LTog3fO4ROPH0ewe
	IYwKvtAz/3zVbxIa+RWDn5SWc8v6gz7K8fMcmFjIuduwt17U8hTYgrilyq4sL+vAb17NsgFlBdcgK
	kiqn2bHh2GrfCjmogb+hzgNbtxzLaFXkgzwqtEPr7ntjG5vQH8Q7PgdYERKTooxHE6RvLS9YzZ/xt
	uVowy1Abc8EHMWVbF2mAqRHeiR+s1tHYj2cukPn3kd59cr2Sb8Nt7hvXkQrUBHPp6UWoOPjKzRIFA
	qpRyAf258Fyqw6YrHnBj8Rzo53HZejPSOQY00NAz43zgyQUrEtkuSH617AP0DZY889vbYJIX9GHgf
	AuCVrIdQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRs-00ASsZ-2U;
	Fri, 13 Dec 2024 13:35:40 -0600
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
Subject: [PATCH v7 07/30] ntsync: Introduce NTSYNC_IOC_MUTEX_KILL.
Date: Fri, 13 Dec 2024 13:34:48 -0600
Message-ID: <20241213193511.457338-8-zfigura@codeweavers.com>
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

This does not correspond to any NT syscall. Rather, when a thread dies, it
should be called by the NT emulator for each mutex, with the TID of the dying
thread.

NT mutexes are robust (in the pthread sense). When an NT thread dies, any
mutexes it owned are immediately released. Acquisition of those mutexes by other
threads will return a special value indicating that the mutex was abandoned,
like EOWNERDEAD returned from pthread_mutex_lock(), and EOWNERDEAD is indeed
used here for that purpose.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 61 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 33e26240d9e7..03768ac25425 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -59,6 +59,7 @@ struct ntsync_obj {
 		struct {
 			__u32 count;
 			pid_t owner;
+			bool ownerdead;
 		} mutex;
 	} u;
 
@@ -107,6 +108,7 @@ struct ntsync_q {
 	atomic_t signaled;
 
 	bool all;
+	bool ownerdead;
 	__u32 count;
 	struct ntsync_q_entry entries[];
 };
@@ -275,6 +277,9 @@ static void try_wake_all(struct ntsync_device *dev, struct ntsync_q *q,
 				obj->u.sem.count--;
 				break;
 			case NTSYNC_TYPE_MUTEX:
+				if (obj->u.mutex.ownerdead)
+					q->ownerdead = true;
+				obj->u.mutex.ownerdead = false;
 				obj->u.mutex.count++;
 				obj->u.mutex.owner = q->owner;
 				break;
@@ -338,6 +343,9 @@ static void try_wake_any_mutex(struct ntsync_obj *mutex)
 			continue;
 
 		if (atomic_try_cmpxchg(&q->signaled, &signaled, entry->index)) {
+			if (mutex->u.mutex.ownerdead)
+				q->ownerdead = true;
+			mutex->u.mutex.ownerdead = false;
 			mutex->u.mutex.count++;
 			mutex->u.mutex.owner = q->owner;
 			wake_up_process(q->task);
@@ -447,6 +455,52 @@ static int ntsync_mutex_unlock(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state to mark its owner as dead,
+ * returning -EPERM if not the owner.
+ */
+static int kill_mutex_state(struct ntsync_obj *mutex, __u32 owner)
+{
+	ntsync_assert_held(mutex);
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
+	bool all;
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
+	all = ntsync_lock_obj(dev, mutex);
+
+	ret = kill_mutex_state(mutex, owner);
+	if (!ret) {
+		if (all)
+			try_wake_all_obj(dev, mutex);
+		try_wake_any_mutex(mutex);
+	}
+
+	ntsync_unlock_obj(dev, mutex, all);
+
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -468,6 +522,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_sem_release(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
+	case NTSYNC_IOC_MUTEX_KILL:
+		return ntsync_mutex_kill(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -652,6 +708,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
 	q->all = all;
+	q->ownerdead = false;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -760,7 +817,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
@@ -841,7 +898,7 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 9186304b253c..633958d90be3 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -41,5 +41,6 @@ struct ntsync_wait_args {
 
 #define NTSYNC_IOC_SEM_RELEASE		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
+#define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 
 #endif
-- 
2.45.2


