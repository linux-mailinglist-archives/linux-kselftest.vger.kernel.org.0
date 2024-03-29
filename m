Return-Path: <linux-kselftest+bounces-6811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 653E3890F75
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8BD1F2425A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CC3B78E;
	Fri, 29 Mar 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="PZ9ypIUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB73A29C;
	Fri, 29 Mar 2024 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671852; cv=none; b=GRI+pJKbgFh9ycoX1dh8Ho9rnFg6xNXT+dkpOHdnpOauTrKGFQ83Q9K1R2Qa5/LeQxzXuD7zw8zPWky3Zu1ssD7jTQrtyrYSIiAuLYeHYI7ordKjI3uD+CZB4fy8vRJuqjrRwZ3yUf44eJnAti12733mOyVYvEcGF2uMf10SuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671852; c=relaxed/simple;
	bh=c8R+VxUo69vMYQ1eP3CJNxopBEh27useY7nE+bZWWSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHCYzqhaoowHebBMWaQ5S8kU0lbRE6HJKYpfU7wiPrdTd2442U1auqTMJ9CHkgsMLjkdFLF6bUcYJflj4Yauj1YddhKEEXmLU4zjKOMyhxTb1ZOomnuQteqZA3QaTejb4MgruEv2UY09FIEUj2KlyKu7j0rPazFGO6BLFUFilrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=PZ9ypIUD; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Ch6FoAtnY+pGrSMgyBWAEGs/xcT1LEePy9/Lu5Re5Sk=; b=PZ9ypIUDM+6mhVJ257hPdBO+9J
	BXsA9ztvqpGgwq39Nkr6zLDceWfFVR6/unl9jGu/ykI9o3lRVGOg05aJAyW4MphxyVD9t84sCEOdj
	9LJm9avo7p1yB8ZSvzmcI9ESS5JQAa3lIdxnxrRLHmERAvZTOLFoHOjfwFuzNv7ZhKtcYuPTgT4pS
	gP59o8hHceZ3GhMLLAJh6y8gO8NCZqt2T3uqVsRTFHXzNl0oBpaFKzblUFMOF2ULH6TJ5s+uRrX4G
	x6nOWJxOJ4n7PlR2EF5GvEeVByX3+qu5XNSXfAHNIXoNRYHBIPJsEPaXAuYaPbelbidgkj/FSHH4G
	aTk3kCBw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlM-000iik-0G;
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
Subject: [PATCH v3 02/30] ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
Date: Thu, 28 Mar 2024 19:05:53 -0500
Message-ID: <20240329000621.148791-3-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtCreateSemaphore().

Semaphores are one of three types of object to be implemented in this driver,
the others being mutexes and events.

An NT semaphore contains a 32-bit counter, and is signaled and can be acquired
when the counter is nonzero. The counter has a maximum value which is specified
at creation time. The initial value of the semaphore is also specified at
creation time. There are no restrictions on the maximum and initial value.

Each object is exposed as an file, to which any number of fds may be opened.
When all fds are closed, the object is deleted.

Objects hold a pointer to the ntsync_device that created them. The device's
reference count is driven by struct file.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/misc/ntsync.c                         | 131 ++++++++++++++++++
 include/uapi/linux/ntsync.h                   |  21 +++
 3 files changed, 154 insertions(+)
 create mode 100644 include/uapi/linux/ntsync.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index c472423412bf..a141e8e65c5d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -174,6 +174,8 @@ Code  Seq#    Include File                                           Comments
 'M'   00-0F  drivers/video/fsl-diu-fb.h                              conflict!
 'N'   00-1F  drivers/usb/scanner.h
 'N'   40-7F  drivers/block/nvme.c
+'N'   80-8F  uapi/linux/ntsync.h                                     NT synchronization primitives
+                                                                     <mailto:wine-devel@winehq.org>
 'O'   00-06  mtd/ubi-user.h                                          UBI
 'P'   all    linux/soundcard.h                                       conflict!
 'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index bd76e653d83e..20158ec148bc 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -5,26 +5,157 @@
  * Copyright (C) 2024 Elizabeth Figura <zfigura@codeweavers.com>
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
+/*
+ * Individual synchronization primitives are represented by
+ * struct ntsync_obj, and each primitive is backed by a file.
+ *
+ * The whole namespace is represented by a struct ntsync_device also
+ * backed by a file.
+ *
+ * Both rely on struct file for reference counting. Individual
+ * ntsync_obj objects take a reference to the device when created.
+ */
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
index 000000000000..6a4867a6c97b
--- /dev/null
+++ b/include/uapi/linux/ntsync.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Kernel support for NT synchronization primitive emulation
+ *
+ * Copyright (C) 2021-2022 Elizabeth Figura <zfigura@codeweavers.com>
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


