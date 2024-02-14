Return-Path: <linux-kselftest+bounces-4683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29263855793
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B5C287D40
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94D145B3F;
	Wed, 14 Feb 2024 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="SFcIg0pv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181D145B2C;
	Wed, 14 Feb 2024 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954802; cv=none; b=UzCYQrXgAokpi1zexWRp+zEf4s5gynIOh5lN7DVRqx1v+siQCy8xg56hwVxSi43BhKYKtwES0i3qje5lM4pMHwHlxToibL52Qs+JgQqfSzkBryqgTNm7BQWnal24mnP0Wb7hgoGCRyIoUqydYU2NHkhfN2flz6jWm/NOpZR7zbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954802; c=relaxed/simple;
	bh=5/Mn5ps7n4SQKWZX1KTG6D74zm3D8qkkGwwpR0oR9YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InLV5DNpvHg7KfXquAmIiILGaydfUfYQaF+oayQfYK4oReRewugQlHL4R4W7R/i8vqD13jCZw/mp90/bSKCuqkqVDCF5Mjnxl1w4NQgR6RfBtYiECWeIF7x1CiMYYpPT9LV+PK1xhqfpqSA3hgMulrnusCqtdcyvSyiXXbdd7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=SFcIg0pv; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=lHwW4zT2kOoH+YNEOKMeIBkf5DIZZR6wMENN39LT3Xo=; b=SFcIg0pvgcPYO26bsLRnZN1/BY
	56/VIa6wwRjQtaSO1R2Svk7IupKtdmSjW46ZvScESkC7VS+S09steAgZYRalXzidwFTZmx3X5OJo1
	58s/F7h47GWDMQ7h936/ut2Gc4v54D9Q9fYlL0YIJ08i09gWUTOtEd+Vt0cL30zCo954oFaiieWA2
	gB2evYh6AlckC5BwzpH21+NSZOLSejBhVBUPDXSKMfb5/fUs627GTGbbfIB3TtgPkjZqeaN5tDA7c
	zWYYU0wliKpp5z2OLiNDEklnYyCYS8hSsIp7Ads7a5E2vw78iXsrmImYe9LUokZ0O2pxr/XfYmYYJ
	cSPL9Zkg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raOoW-00GbiL-0b;
	Wed, 14 Feb 2024 17:37:16 -0600
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
Subject: [PATCH 02/31] ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
Date: Wed, 14 Feb 2024 17:36:38 -0600
Message-ID: <20240214233645.9273-3-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtCreateSemaphore().

Semaphores are one of three types of object to be implemented in this driver,
the others being mutexes and events.

An NT semaphore contains a 32-bit counter, and is signaled and can be acquired
when the counter is nonzero. The counter has a maximum value which is specified
at creation time. The initial value of the semaphore is also specified at
creation time. There are no restrictions on the maximum and initial value.

Each object is exposed as an file, to which any number of fds may be opened.
When all fds are closed, the object is deleted.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/misc/ntsync.c                         | 120 ++++++++++++++++++
 include/uapi/linux/ntsync.h                   |  21 +++
 3 files changed, 143 insertions(+)
 create mode 100644 include/uapi/linux/ntsync.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..2f5c6994f042 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -173,6 +173,8 @@ Code  Seq#    Include File                                           Comments
 'M'   00-0F  drivers/video/fsl-diu-fb.h                              conflict!
 'N'   00-1F  drivers/usb/scanner.h
 'N'   40-7F  drivers/block/nvme.c
+'N'   80-8F  uapi/linux/ntsync.h                                     NT synchronization primitives
+                                                                     <mailto:wine-devel@winehq.org>
 'O'   00-06  mtd/ubi-user.h                                          UBI
 'P'   all    linux/soundcard.h                                       conflict!
 'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index e4969ef90722..3ad86d98b82d 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -5,26 +5,146 @@
  * Copyright (C) 2024 Elizabeth Figura
  */
 
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <uapi/linux/ntsync.h>
 
 #define NTSYNC_NAME	"ntsync"
 
+enum ntsync_type {
+	NTSYNC_TYPE_SEM,
+};
+
+struct ntsync_obj {
+	enum ntsync_type type;
+
+	union {
+		struct {
+			__u32 count;
+			__u32 max;
+		} sem;
+	} u;
+
+	struct file *file;
+	struct ntsync_device *dev;
+};
+
+struct ntsync_device {
+	struct file *file;
+};
+
+static int ntsync_obj_release(struct inode *inode, struct file *file)
+{
+	struct ntsync_obj *obj = file->private_data;
+
+	fput(obj->dev->file);
+	kfree(obj);
+
+	return 0;
+}
+
+static const struct file_operations ntsync_obj_fops = {
+	.owner		= THIS_MODULE,
+	.release	= ntsync_obj_release,
+	.llseek		= no_llseek,
+};
+
+static struct ntsync_obj *ntsync_alloc_obj(struct ntsync_device *dev,
+					   enum ntsync_type type)
+{
+	struct ntsync_obj *obj;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return NULL;
+	obj->type = type;
+	obj->dev = dev;
+	get_file(dev->file);
+
+	return obj;
+}
+
+static int ntsync_obj_get_fd(struct ntsync_obj *obj)
+{
+	struct file *file;
+	int fd;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+	file = anon_inode_getfile("ntsync", &ntsync_obj_fops, obj, O_RDWR);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+	obj->file = file;
+	fd_install(fd, file);
+
+	return fd;
+}
+
+static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
+{
+	struct ntsync_sem_args __user *user_args = argp;
+	struct ntsync_sem_args args;
+	struct ntsync_obj *sem;
+	int fd;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	if (args.count > args.max)
+		return -EINVAL;
+
+	sem = ntsync_alloc_obj(dev, NTSYNC_TYPE_SEM);
+	if (!sem)
+		return -ENOMEM;
+	sem->u.sem.count = args.count;
+	sem->u.sem.max = args.max;
+	fd = ntsync_obj_get_fd(sem);
+	if (fd < 0) {
+		kfree(sem);
+		return fd;
+	}
+
+	return put_user(fd, &user_args->sem);
+}
+
 static int ntsync_char_open(struct inode *inode, struct file *file)
 {
+	struct ntsync_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	file->private_data = dev;
+	dev->file = file;
 	return nonseekable_open(inode, file);
 }
 
 static int ntsync_char_release(struct inode *inode, struct file *file)
 {
+	struct ntsync_device *dev = file->private_data;
+
+	kfree(dev);
+
 	return 0;
 }
 
 static long ntsync_char_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long parm)
 {
+	struct ntsync_device *dev = file->private_data;
+	void __user *argp = (void __user *)parm;
+
 	switch (cmd) {
+	case NTSYNC_IOC_CREATE_SEM:
+		return ntsync_create_sem(dev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
new file mode 100644
index 000000000000..f38818e7759d
--- /dev/null
+++ b/include/uapi/linux/ntsync.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Kernel support for NT synchronization primitive emulation
+ *
+ * Copyright (C) 2021-2022 Elizabeth Figura
+ */
+
+#ifndef __LINUX_NTSYNC_H
+#define __LINUX_NTSYNC_H
+
+#include <linux/types.h>
+
+struct ntsync_sem_args {
+	__u32 sem;
+	__u32 count;
+	__u32 max;
+};
+
+#define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
+
+#endif
-- 
2.43.0


