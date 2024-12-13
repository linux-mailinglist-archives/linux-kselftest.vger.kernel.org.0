Return-Path: <linux-kselftest+bounces-23348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B99F1638
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43E02851C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB71F4721;
	Fri, 13 Dec 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="isyJNxfp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FA1F2C5E;
	Fri, 13 Dec 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118550; cv=none; b=EK3N42PMA4D+WHA40IRPOZ+xy1w1IShpbcBf89wOaQe07+wtqrRbaQwBjeoO+8Pbw56AxK8w7T5bvBJpzZu4Dt0PdN+WuX6WTii0Y9eg16e/zapTcftR0HfZYaTalLga0Lmq57bUbK6zLvGUO9kIICox2Vn9f5BQ9DC+shtG4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118550; c=relaxed/simple;
	bh=447hT/OdNH6VEcDUkkxZvBohxqhhWzFAJq1IM84XXpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKwrVv24D0AENm33euGg6iZ/VuNK9bUmY0KjVeaBGEafP26W7axyHtcNiEzXVElchkgfKCrV6oobNOHpuU6bUwY304Xet3l2kIN56QJ5w7Oj4xu1sp24tCH/0QcW4OuM9IwOD498PWovVTCXDLxcfuiOzmecZRqaY6JaCokQy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=isyJNxfp; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i0Lw/XP8iFK0y4W41V408OKiPsw7/oF/aH4FIqVRsoE=; b=isyJNxfpuBg8y8LjD26oexSxlX
	l7ZZPi6MSOUhW9+oxJ/8s4NjhWWi0uMccmf1zOCGFMaqpQMyvCcoLjo92qHjL7yVBjMeKMNaq39M0
	BAP175QEFfKfAM4gMNZ6OIikPln2eY+qUpcO+gRW3jiC68dZz/1oBQ90TpM6LRv5rayD+1CYMcY+E
	rxTnnJsXqimP/QB9OjnYl8p9WnvKPGAf3CWwFmoMbVZgLrSQulpnbPioN12LuWkVlC8rr8LOqV1Uy
	dVMyFfLw0a0t5eYd1L/sg43giyO5YXJ+QM4AYVoejg69jHuOry0Ftqi2JNaWMT7hHbRUO6vJVNfSE
	e8Ub9fvg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRs-00ASsZ-02;
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
Subject: [PATCH v7 06/30] ntsync: Introduce NTSYNC_IOC_MUTEX_UNLOCK.
Date: Fri, 13 Dec 2024 13:34:47 -0600
Message-ID: <20241213193511.457338-7-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtReleaseMutant().

This syscall decrements the mutex's recursion count by one, and returns the
previous value. If the mutex is not owned by the current task, the function
instead fails and returns -EPERM.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 53 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 54 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index a2826dbff2f4..33e26240d9e7 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -396,6 +396,57 @@ static int ntsync_sem_release(struct ntsync_obj *sem, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state, returning -EPERM if not the owner.
+ */
+static int unlock_mutex_state(struct ntsync_obj *mutex,
+			      const struct ntsync_mutex_args *args)
+{
+	ntsync_assert_held(mutex);
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
+	bool all;
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
+	all = ntsync_lock_obj(dev, mutex);
+
+	prev_count = mutex->u.mutex.count;
+	ret = unlock_mutex_state(mutex, &args);
+	if (!ret) {
+		if (all)
+			try_wake_all_obj(dev, mutex);
+		try_wake_any_mutex(mutex);
+	}
+
+	ntsync_unlock_obj(dev, mutex, all);
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
@@ -415,6 +466,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_RELEASE:
 		return ntsync_sem_release(obj, argp);
+	case NTSYNC_IOC_MUTEX_UNLOCK:
+		return ntsync_mutex_unlock(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index bb7fb94f5856..9186304b253c 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -40,5 +40,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_CREATE_MUTEX		_IOW ('N', 0x84, struct ntsync_mutex_args)
 
 #define NTSYNC_IOC_SEM_RELEASE		_IOWR('N', 0x81, __u32)
+#define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 
 #endif
-- 
2.45.2


