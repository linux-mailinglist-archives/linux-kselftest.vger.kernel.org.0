Return-Path: <linux-kselftest+bounces-3790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449BE84334B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6970C1C20F75
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BD4EADB;
	Wed, 31 Jan 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="XokxqTmI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FD566B;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667367; cv=none; b=K6XAcVIz3UOzeZ9MfEzoPhjn/Nf3zJFHnHmpJMGvBJO8K4bccLwRY2EuTAHgtrx4WqZAYGQ+Go+rM5tg46P/+Ihe50PjENhUD5FJNoaHeuA8bvD7NrGeIDj2ZlSQ1IuDtyr5twmFN5SNxuuqQwtgFnedZo11dPLQcp9BMuUumlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667367; c=relaxed/simple;
	bh=O5K1LmGQcFzW45Q6iMNwCezjStTLj4HXs8KymesmOXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjHk2nAEkt+JW4BqJEmjWIwAxlV8Wh8oJkDAqHd86305mDZWb9hiswNbJB9sbWqxKZRdIBe8vAoz97YCNVQe3REXclL1M3OJ1fPhzHUJA0sadXoBFUdqeWiD3SXmn1Nrj0gTkLOPdxywK1SPtJwYeXFehCWqWSZfU1CFQFYvCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=XokxqTmI; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=SMlzEM56sFeNJJQFrjOO36bPFoUHb9ev3VvNS+3GYKc=; b=XokxqTmIGX0Rw4fNgYQ2FcjfID
	ilNGxziyyFthA6wx5lM/7tMmvNh3YhBw1dxjrnBJB5pgN0TlWYUc1LBHyF1V55kZxRVGlwif8/t7X
	xIVOZf6MuVylg3ifStFeA19GP3AVMHDZcOMmO0srK+dYLyF2naM5L5Ca1ObwsiJp+muNHJ684dWWA
	ouOP3i4PlsRg1tDpusvYKZyFwaT9wXbaDVrNNzyEwJ86O+jE2BTOEIK5rvao17A79tYyeP6ozysbE
	XLEWfNdQySU3lUA7LMCN+y0E8a1O7DwV6zSTuB6CBiMG8h0rvMcoc9VXSyeVujN6ARCMX1W87l2FD
	o7FtKjzA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08m-0038Kv-1s;
	Tue, 30 Jan 2024 20:15:52 -0600
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
Subject: [RFC PATCH v2 03/29] ntsync: Introduce NTSYNC_IOC_SEM_POST.
Date: Tue, 30 Jan 2024 20:13:30 -0600
Message-ID: <20240131021356.10322-4-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtReleaseSemaphore().

This increases the semaphore's internal counter by the given value, and returns
the previous value. If the counter would overflow the defined maximum, the
function instead fails and returns -EOVERFLOW.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 68 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |  2 ++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 3ad86d98b82d..1af38969f9a2 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -20,23 +20,68 @@ enum ntsync_type {
 };
 
 struct ntsync_obj {
+	spinlock_t lock;
+
 	enum ntsync_type type;
 
+	struct file *file;
+	struct ntsync_device *dev;
+
+	/* The following fields are protected by the object lock. */
 	union {
 		struct {
 			__u32 count;
 			__u32 max;
 		} sem;
 	} u;
-
-	struct file *file;
-	struct ntsync_device *dev;
 };
 
 struct ntsync_device {
 	struct file *file;
 };
 
+/*
+ * Actually change the semaphore state, returning -EOVERFLOW if it is made
+ * invalid.
+ */
+static int post_sem_state(struct ntsync_obj *sem, __u32 count)
+{
+	lockdep_assert_held(&sem->lock);
+
+	if (sem->u.sem.count + count < sem->u.sem.count ||
+	    sem->u.sem.count + count > sem->u.sem.max)
+		return -EOVERFLOW;
+
+	sem->u.sem.count += count;
+	return 0;
+}
+
+static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
+{
+	__u32 __user *user_args = argp;
+	__u32 prev_count;
+	__u32 args;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (sem->type != NTSYNC_TYPE_SEM)
+		return -EINVAL;
+
+	spin_lock(&sem->lock);
+
+	prev_count = sem->u.sem.count;
+	ret = post_sem_state(sem, args);
+
+	spin_unlock(&sem->lock);
+
+	if (!ret && put_user(prev_count, user_args))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -47,9 +92,25 @@ static int ntsync_obj_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long parm)
+{
+	struct ntsync_obj *obj = file->private_data;
+	void __user *argp = (void __user *)parm;
+
+	switch (cmd) {
+	case NTSYNC_IOC_SEM_POST:
+		return ntsync_sem_post(obj, argp);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct file_operations ntsync_obj_fops = {
 	.owner		= THIS_MODULE,
 	.release	= ntsync_obj_release,
+	.unlocked_ioctl	= ntsync_obj_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= no_llseek,
 };
 
@@ -64,6 +125,7 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 	obj->type = type;
 	obj->dev = dev;
 	get_file(dev->file);
+	spin_lock_init(&obj->lock);
 
 	return obj;
 }
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index f38818e7759d..878ec4f0f2e8 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -18,4 +18,6 @@ struct ntsync_sem_args {
 
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
 
+#define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
+
 #endif
-- 
2.43.0


