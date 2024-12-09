Return-Path: <linux-kselftest+bounces-23086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E19E9F23
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49660188B21E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F841A9B3B;
	Mon,  9 Dec 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="NFey2SuS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D91A9B45;
	Mon,  9 Dec 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771000; cv=none; b=OgfKWBVDIMsYOMKsl9Lhlgxb0AYfZQdEOGmGxFXZX8y5fFkbzkEMPLO0VOJ+wpo1omg89ukUXC3iXz4yiNLqoDdZIagGqKzmKnuTGNrIJvUX2M/+DTIzhNm1+Oa+msLkisKzqVmt7s6JL+bT8CSYVzb5STZrN+3JPKHkrRXGi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771000; c=relaxed/simple;
	bh=RjMIMeG6KnVk8HqQ6wwOgtfvSlf5nhwkGOnftj/ll5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCFW/YCDrT7U/z7NClvMFB73WPK/aw+VHzKPA3qO3XOhtO8LvYdJjbrLZ5iIIcQebMnhH1yN+8cQ8sQMCddWB2l4peWHYSUnW/qKPmGW9+FDGN6I2jU5Dj/bSD5SggstUxD/NJzrPJLD+V0mfAbWbUV8+91nQ0byp1yXg0719MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=NFey2SuS; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=InRezP3YW9qasHnPVT+1MKLKEEmKziLa94eVnmfKD/s=; b=NFey2SuSLSxS6Tiypbv0yntzkk
	Uzb5HAIgOkBxUMDiCpn3mOKBXS3sS60zixtEs30Wp+psJFjcupchrH3pa6MeiZY/QqyOnKt/LpcNt
	tnIEZmjiHpUCt0wwyKQdtov10+qsC8l7x1yz79DAZP1EmoAzF3CajHns82BL4qyVxphx1SOyAFevR
	kNVgLIiTWk4GIMlpp4iSDozZ9Zf8OeFaYOBXHmJ3TI3tUYCgEpOrIqvZufN6Or5AOMdz7h4tKdKuh
	prtq04W4EaQk5jOwYYFR83pqP6NG5RbP1weuEj+wGKZ5gLodQqkLu7GzKLod5Hml//gUaK/rowJj3
	CvO2ncyQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyY-001Gd5-2B;
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
Subject: [PATCH v6 05/28] ntsync: Introduce NTSYNC_IOC_MUTEX_KILL.
Date: Mon,  9 Dec 2024 12:58:41 -0600
Message-ID: <20241209185904.507350-6-zfigura@codeweavers.com>
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
index 6ed278c17be9..0ed864d291a6 100644
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
 		return ntsync_sem_post(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
+	case NTSYNC_IOC_MUTEX_KILL:
+		return ntsync_mutex_kill(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -658,6 +714,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->owner = args->owner;
 	atomic_set(&q->signaled, -1);
 	q->all = all;
+	q->ownerdead = false;
 	q->count = count;
 
 	for (i = 0; i < count; i++) {
@@ -766,7 +823,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
@@ -847,7 +904,7 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 		struct ntsync_wait_args __user *user_args = argp;
 
 		/* even if we caught a signal, we need to communicate success */
-		ret = 0;
+		ret = q->ownerdead ? -EOWNERDEAD : 0;
 
 		if (put_user(signaled, &user_args->index))
 			ret = -EFAULT;
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index a633db34f284..d7996180c1d2 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -43,5 +43,6 @@ struct ntsync_wait_args {
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
+#define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 
 #endif
-- 
2.45.2


