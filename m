Return-Path: <linux-kselftest+bounces-3807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7DC843384
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC2CB2160B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE12134A;
	Wed, 31 Jan 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ZAO2TWh/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966075673;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667369; cv=none; b=P/nGY8dhhv7fZ+nU//Z0EII3xaQ81Uv9n5BZPiLCyeI4R2+m2mxwtL31Iy6e9a0LPyZSoyixm+yhRnF4l0CgzT1rKVhD3cUMkWj7n43MwteFDtY8llvbBwRAxTFYNvmkmqVYCLdgRq45iB4Gla8+KYXL93uVuPa4RXbRnC4ytj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667369; c=relaxed/simple;
	bh=5/Mn5ps7n4SQKWZX1KTG6D74zm3D8qkkGwwpR0oR9YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS1kiW7N3Pox4AUQ1tfLPWHHOww2V4KrVXC+leImlDyZLwdsjCo/WnASd8caJLRoVC36hfgs8A9Wa6Ja/yGfJ8sy8V6AZU51ym0r+myY+3P3S4FTOXVz+6W2K339b3WC9GOPxw9DVRYSLKzvKCpjuBZMp1N7suY0elVQp+o/v3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ZAO2TWh/; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=lHwW4zT2kOoH+YNEOKMeIBkf5DIZZR6wMENN39LT3Xo=; b=ZAO2TWh/Q8+pJvPbbxqwQoM9R9
	9ZPW73MChfg6JkEcWsigGdoEj83UJyjWRohSYglif7FrKzlk+wweD/Acvzwg/tbOLlPMjMcu/afos
	dgDCZyhwoBnaTW/yCumd5FWB/AqBOAs8KqWwjC0bLqgjCBuyDMNygAAziX6Aq6DACWlUB/llU9Vgp
	qJjuARbo7Kkrjwf2+BW99YtdM/VeBAozb3n0QG7PRimGxFG+J/b2FauOXq1tVu80htaOhtA3154C+
	JDAKQUpNkRs2yXtWzX4efUl83ktbEfuVMNtT2+T6I5uyjegLH9f65BiRRD9LgG/jlB2FkxVSZboJB
	yHd54Ikg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08m-0038Kv-10;
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
Subject: [RFC PATCH v2 02/29] ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
Date: Tue, 30 Jan 2024 20:13:29 -0600
Message-ID: <20240131021356.10322-3-zfigura@codeweavers.com>
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


