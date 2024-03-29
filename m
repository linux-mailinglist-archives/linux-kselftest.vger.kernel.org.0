Return-Path: <linux-kselftest+bounces-6809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C0890F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB93128C0F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB63B799;
	Fri, 29 Mar 2024 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qR6fjy46"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8ED3B78E;
	Fri, 29 Mar 2024 00:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671847; cv=none; b=UeA393Hga1ccOYuyoGIHZiXtW+5OkHdMNMxTR2aegDfkqEaqvaxJsPLP4mm3OrnVtIUh2v/+o7+UUHlZaHFZe+PIYUVUro0ScggGxAk5Tx+CG8LUIqerSK2OXcfQ/kAFpT4/6kn9TegvrYPmjmu4QlrbNOBmXRW/uB/pSKRWoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671847; c=relaxed/simple;
	bh=fdEV6NvWPOr3H9DhWoCHZa8j5eufVwiEJHht5U0PHvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feUyKqjplYKLQDIW51sMJDNlPeFJLxVyMee+ss0v68w2EYZRkIblMJh4KxqpfxhNqCsDnPLSN/KXlOt6UiFMFa2zCOr4f+AZg4/PfS5jbUuKXmSrm68RcYICk3qlQRl8Jw8++P+b/XFLzes1Jai6ugwLiiXBdK8St/yIu3cnCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=qR6fjy46; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Nr8IOHHYhllR3HYtyEHbvyYMxtrQLzWrxlWMFjNl1S0=; b=qR6fjy46cf/YnVyMqxsjI0ltja
	h+DRm+jCJXCT36aXMK7rLi05zzJBov02iVS64RLO4o7GyQtpbDEtX4+2vVKB1/1vHECzXdowN2H4K
	Foq3Wgzl8RwYtG27806hUYAWkuk32kerObWIvhCg6ncGgefA2gANaiHI/4OGNlP0ZyKUAYxfvuCIk
	iU2ilLLQslFqSXJw6eawW6cgiQq+apWWOErzRQLw8ygQbHKNfyBMlab2QbKnJNec3u3DmTraqBBbw
	Wcr6m+sDNUwe2TJBe4rl98FOjCEB6xlVydmwu/W6cQXV4vsj5dc/Vs1HLKST6PzpGgVih2jO3dy2l
	IxvDXM3w==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlM-000iik-0l;
	Thu, 28 Mar 2024 19:06:28 -0500
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v3 03/30] ntsync: Introduce NTSYNC_IOC_SEM_POST.
Date: Thu, 28 Mar 2024 19:05:54 -0500
Message-ID: <20240329000621.148791-4-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 72 +++++++++++++++++++++++++++++++++++--
 include/uapi/linux/ntsync.h |  2 ++
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 20158ec148bc..3c2f743c58b0 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -10,7 +10,9 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <uapi/linux/ntsync.h>
 
 #define NTSYNC_NAME	"ntsync"
@@ -31,23 +33,70 @@ enum ntsync_type {
  */
 
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
+	__u32 sum;
+
+	lockdep_assert_held(&sem->lock);
+
+	if (check_add_overflow(sem->u.sem.count, count, &sum) ||
+	    sum > sem->u.sem.max)
+		return -EOVERFLOW;
+
+	sem->u.sem.count = sum;
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
@@ -58,9 +107,25 @@ static int ntsync_obj_release(struct inode *inode, struct file *file)
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
 
@@ -75,6 +140,7 @@ static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
 	obj->type = type;
 	obj->dev = dev;
 	get_file(dev->file);
+	spin_lock_init(&obj->lock);
 
 	return obj;
 }
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 6a4867a6c97b..dcfa38fdc93c 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -18,4 +18,6 @@ struct ntsync_sem_args {
 
 #define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
 
+#define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
+
 #endif
-- 
2.43.0


