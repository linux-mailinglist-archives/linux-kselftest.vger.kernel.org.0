Return-Path: <linux-kselftest+bounces-3800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A073884336E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B76B289D4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AD517BD7;
	Wed, 31 Jan 2024 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="PPni3DAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965CB5672;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667368; cv=none; b=qbornavIPhx1ljnVfDBXoq5iSEpe80mO+JrqZoS0YvWN9Zlez40X8fUaZtmFp05doUw96A8srxi8MW3VEkT37Ropj4qIMZ4mpnA9qTrddxY2+Idqnj9Bc1RfQnJrxAvQFycp+wSQ5ZA6JBwQjXWZ8TqiWTI9b49rWbcVxWuBKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667368; c=relaxed/simple;
	bh=9wT+B7+F1Vv/UHIWNs5HiJCid1GsqOvXjQ+iDzWwuzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K83Hu/NphHFJn0r/wGcD1LZBSAdahGrAVHg9b4x4KUmmN9+by3o5WSof1yIuqOBeUaHOIIsfFS8t58eIsZrUyDl0DtTp4KZpsKsXqW9LteXHjB5rTcQEAE+oyE6iQ2tDHIwL/a89a6Dn9eSgRVS43crJT3NZXr1RHiaqvahFsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=PPni3DAK; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=P3QYzBA4EV4T10nQsEVxMllwkWrG/Pg5gVd9g6PO8jQ=; b=PPni3DAKGSUoK7BXRjdWNHpeBL
	54ckrLRisbmRDYFHO/ZczaH9HL2BMd+yCcG7TCPzdE1vSys0KSDbB+B3xTikGyATyLH6C7QH1R7ie
	HcJ81uHAOre+bjwvAbfzg2XYiGyo9NEH9MqaJxD1+nyGa/oVDMkc1H6DI2lEtl4ModNOQE2yb9plf
	jbHpRCYAGcL+3GcUihUpnjrRBOUj4SOSz0d7BDXpy9COvSvorfLA2yHQVpYeUleZ/FzziTd79Ymub
	6f61LhVacFnD2GPTn/e8/N2qUoTZ5HeV/gTucyOw6SikwPnK9QuGtE8rA1wsHXb72t6GjGkoNUb2h
	A0LIUyvw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08n-0038Kv-1L;
	Tue, 30 Jan 2024 20:15:53 -0600
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
Subject: [RFC PATCH v2 07/29] ntsync: Introduce NTSYNC_IOC_MUTEX_UNLOCK.
Date: Tue, 30 Jan 2024 20:13:34 -0600
Message-ID: <20240131021356.10322-8-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131021356.10322-1-zfigura@codeweavers.com>
References: <20240131021356.10322-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to the NT syscall NtReleaseMutant().

This syscall decrements the mutex's recursion count by one, and returns the
previous value. If the mutex is not owned by the given owner ID, the function
instead fails and returns -EPERM.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 64 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 484219a266ae..1770ec4008af 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -290,6 +290,68 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state, returning -EPERM if not the owner.
+ */
+static int unlock_mutex_state(struct ntsync_obj *mutex,
+			      const struct ntsync_mutex_args *args)
+{
+	lockdep_assert_held(&mutex->lock);
+
+	if (mutex->u.mutex.owner != args->owner)
+		return -EPERM;
+
+	if (!--mutex->u.mutex.count)
+		mutex->u.mutex.owner = 0;
+	return 0;
+}
+
+static int ntsync_mutex_unlock(struct ntsync_obj *mutex, void __user *argp)
+{
+	struct ntsync_mutex_args __user *user_args = argp;
+	struct ntsync_device *dev = mutex->dev;
+	struct ntsync_mutex_args args;
+	__u32 prev_count;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+	if (!args.owner)
+		return -EINVAL;
+
+	if (mutex->type != NTSYNC_TYPE_MUTEX)
+		return -EINVAL;
+
+	if (atomic_read(&mutex->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
+
+		prev_count = mutex->u.mutex.count;
+		ret = unlock_mutex_state(mutex, &args);
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
+		prev_count = mutex->u.mutex.count;
+		ret = unlock_mutex_state(mutex, &args);
+		if (!ret)
+			try_wake_any_mutex(mutex);
+
+		spin_unlock(&mutex->lock);
+	}
+
+	if (!ret && put_user(prev_count, &user_args->count))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -309,6 +371,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_POST:
 		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_MUTEX_UNLOCK:
+		return ntsync_mutex_unlock(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index d68f24fd75a2..a3f5f4f13798 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -39,5 +39,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
+#define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


