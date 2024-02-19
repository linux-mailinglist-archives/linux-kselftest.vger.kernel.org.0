Return-Path: <linux-kselftest+bounces-4966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8285AED9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D51F23C48
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16595916B;
	Mon, 19 Feb 2024 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="U2GbVPBm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21315674D;
	Mon, 19 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382381; cv=none; b=q0qT0INtZ07R8RUyu7Hd7BeU72WQH5388F8mXQypeSdmZAJVAMR6HVXTZrl97Y8Yz3PHTZdmn+dWc3XMw01mLbLyerEaJ6orBVisc708cU/xWO7fWdWjrW4EWTvCZIxdlCgMJkKYO4PwV2l05kBflGe3xRAVvpY/g3TMuhVy6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382381; c=relaxed/simple;
	bh=fdEV6NvWPOr3H9DhWoCHZa8j5eufVwiEJHht5U0PHvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhc5v8VtO4KHL6zbj3K80mSKQPFW4lt5ilRCtWebyIywez03YeobF3MosnI+GDIlWRMxh/jz/P7+Ik9S+sIjnO6TNjjNWMhpy5Ka+5AIexCGkZfB0901lLL0d7OER9ZQCBylymdemXatPyHaou5ZYL5YQ/SUrjn9c6ON1y+qM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=U2GbVPBm; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Nr8IOHHYhllR3HYtyEHbvyYMxtrQLzWrxlWMFjNl1S0=; b=U2GbVPBmcPv0ue+WIVhjwir5Wb
	zp0OzBobNKawn6rZnuX92KR13VVogrx23btfdDwHYXt5ceF8EXvdmsNZQTy90JzvdMPGcWp7OjFYi
	CCXNu7N1dKbs8qH0hNOONcwHzjWStVBtYOEVdK0G9FeNR1pqdz220S7smBPW4C+3L8k9n8cb7KMQ7
	Oh03as2J1iogXCYyI249kNWtAuxkzxxurEEzCfVl97YTb3QQ/GUZ6CA2mIdNMOEIXW7rDk2dpRgob
	YROzom9ELXZpX7B105sIHyk9bntWG0oRtcb+yJgZXBcSwxFQ8VTMXSLeGf8TafPO77qPBZfUwA+wH
	BmQHxmTQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIL-0037Oz-0D;
	Mon, 19 Feb 2024 16:39:29 -0600
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
Subject: [PATCH v2 03/31] ntsync: Introduce NTSYNC_IOC_SEM_POST.
Date: Mon, 19 Feb 2024 16:38:05 -0600
Message-ID: <20240219223833.95710-4-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
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


