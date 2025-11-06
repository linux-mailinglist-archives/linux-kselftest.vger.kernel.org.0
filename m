Return-Path: <linux-kselftest+bounces-44996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08499C3C0AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CBA1AA6EF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F6C28467D;
	Thu,  6 Nov 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8uSZZ7k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833426C3A5;
	Thu,  6 Nov 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442844; cv=none; b=dS1kcStWlQPWNCAxDfRqBPbot6FpftasImNy+2H7xkavyclJqEHAD1hftZEh1PROUJltpCtm8wXxg47+N3fpS9jR/6wE+cmwvMP6ebHAMwCaXQmmWHDtP7HMz/H2dgd9rGjpU+R7SIy6HjtorG4r6cimKnZ+9AYv2TvVrbb1xto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442844; c=relaxed/simple;
	bh=Acb9yzdrZQmNS74o9i7JBL4i0g1XnJXFYgY2tJ8ZUog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtQpgNFLyunnqqpNn3DCbUayqBJyO/9Jz6Tnf2AvgURqqXo7Zbgzw8MYMELSYWwZ5DoAKemz0MyHxDCGLlEfqgpOEjGKHWWNyeiyBAcWmRB0jVmkrB2bR5gWuBmDerdf1R7oa4UZP5aotbLgRRL8+QagfV5Pz4altRqNNlvmji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8uSZZ7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2360EC116C6;
	Thu,  6 Nov 2025 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442844;
	bh=Acb9yzdrZQmNS74o9i7JBL4i0g1XnJXFYgY2tJ8ZUog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8uSZZ7kQ0+af5HreadyZqOiiWUGp/kkTJe+RGVmiJ7pkaQib9IWs67/Jhwcs271/
	 reogVADFnN2GTmHwF3q7CT8M3gjolQW+ZoRyr9eS8k2PRojLsW+t6nLH2psmQoCmVE
	 PhU3lE0QYdkKiEawLuwKJEzFwkQ/DQyCvpnGV9IACTpfN4oFEqW2Ij6Z4A48oREHad
	 ZZr8s995wXJkhFSxx82MYaitFXvHJmixygTgCvbmiirQtkB8c/apc4OZ+/1x4tKgEC
	 Xkg+mLlgMeHBGWyjJz7/7rEY8AXBbSikgKZ+qWYnYSGBVeyf3noRbzf+12P/slI0iT
	 RSlqapHi0smzw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 1/3] revocable: Add fops replacement
Date: Thu,  6 Nov 2025 23:27:10 +0800
Message-ID: <20251106152712.11850-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106152712.11850-1-tzungbi@kernel.org>
References: <20251106152712.11850-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce fs_revocable_replace() to simplify the use of the revocable
APIs with file_operations.

The function should only be used after filp->f_op->open().  It assumes
the filp->private_data would be set only once in filp->f_op->open() and
wouldn't update in subsequent file operations.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v6:
- Use filp->private_data for the replacement context.
- Prevent file operations from calling if the resource has been revoked.
- Support only 1 resource again.
- Rename REVOCABLE_TRY_ACCESS_WITH() -> REVOCABLE_TRY_ACCESS_SCOPED().
- Use new REVOCABLE_TRY_ACCESS_WITH() if applicable.

v5: https://lore.kernel.org/chrome-platform/20251016054204.1523139-6-tzungbi@kernel.org
- Rename to "fs_revocable".
- Move the replacement context to struct file.
- Support multiple revocable providers.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-6-tzungbi@kernel.org
- New in the series.

 fs/Makefile                  |   2 +-
 fs/fs_revocable.c            | 156 +++++++++++++++++++++++++++++++++++
 include/linux/fs_revocable.h |  14 ++++
 3 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 fs/fs_revocable.c
 create mode 100644 include/linux/fs_revocable.h

diff --git a/fs/Makefile b/fs/Makefile
index a04274a3c854..f1e5d7b52781 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
-		file_attr.o
+		file_attr.o fs_revocable.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/fs_revocable.c b/fs/fs_revocable.c
new file mode 100644
index 000000000000..9ffa71cb67ed
--- /dev/null
+++ b/fs/fs_revocable.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ *
+ * File operation replacement with Revocable
+ */
+
+#include <linux/cleanup.h>
+#include <linux/fs_revocable.h>
+#include <linux/poll.h>
+#include <linux/revocable.h>
+
+struct fops_replacement {
+	struct file *filp;
+	void *orig_private_data;
+	const struct file_operations *orig_fops;
+	struct file_operations fops;
+	struct revocable *rev;
+};
+
+/*
+ * Recover the private_data to its original one.
+ */
+static struct fops_replacement *_recover_private_data(struct file *filp)
+{
+	struct fops_replacement *fr = filp->private_data;
+
+	filp->private_data = fr->orig_private_data;
+	return fr;
+}
+
+/*
+ * Replace the private_data to fops_replacement.
+ */
+static void _replace_private_data(struct fops_replacement *fr)
+{
+	fr->filp->private_data = fr;
+}
+
+DEFINE_CLASS(fops_replacement, struct fops_replacement *,
+	     _replace_private_data(_T), _recover_private_data(filp),
+	     struct file *filp)
+
+static ssize_t fs_revocable_read(struct file *filp, char __user *buffer,
+				 size_t length, loff_t *offset)
+{
+	void *any;
+	CLASS(fops_replacement, fr)(filp);
+
+	REVOCABLE_TRY_ACCESS_WITH(fr->rev, any);
+	if (!any)
+		return -ENODEV;
+
+	return fr->orig_fops->read(filp, buffer, length, offset);
+}
+
+static __poll_t fs_revocable_poll(struct file *filp, poll_table *wait)
+{
+	void *any;
+	CLASS(fops_replacement, fr)(filp);
+
+	REVOCABLE_TRY_ACCESS_WITH(fr->rev, any);
+	if (!any)
+		return -ENODEV;
+
+	return fr->orig_fops->poll(filp, wait);
+}
+
+static long fs_revocable_unlocked_ioctl(struct file *filp, unsigned int cmd,
+					unsigned long arg)
+{
+	void *any;
+	CLASS(fops_replacement, fr)(filp);
+
+	REVOCABLE_TRY_ACCESS_WITH(fr->rev, any);
+	if (!any)
+		return -ENODEV;
+
+	return fr->orig_fops->unlocked_ioctl(filp, cmd, arg);
+}
+
+static int fs_revocable_release(struct inode *inode, struct file *filp)
+{
+	struct fops_replacement *fr = _recover_private_data(filp);
+	int ret = 0;
+	void *any;
+
+	filp->f_op = fr->orig_fops;
+
+	if (!fr->orig_fops->release)
+		goto leave;
+
+	REVOCABLE_TRY_ACCESS_SCOPED(fr->rev, any) {
+		if (!any) {
+			ret = -ENODEV;
+			goto leave;
+		}
+
+		ret = fr->orig_fops->release(inode, filp);
+	}
+
+leave:
+	kfree(fr);
+	return ret;
+}
+
+/**
+ * fs_revocable_replace() - Replace the file operations to be revocable-aware.
+ * @rp: The revocable resource provider.
+ * @filp: The opening file.
+ *
+ * This replaces @filp->f_op to a set of wrappers.  The wrappers return -ENODEV
+ * if the resource provided by @rp has been revoked.  Note that it doesn't
+ * concern how the file operations access the resource but only care about if
+ * the resource is still available.
+ *
+ * This should only be used after @filp->f_op->open().  It assumes the
+ * @filp->private_data would be set only once in @filp->f_op->open() and wouldn't
+ * update in subsequent file operations.
+ */
+int fs_revocable_replace(struct revocable_provider *rp, struct file *filp)
+{
+	struct fops_replacement *fr;
+
+	fr = kzalloc(sizeof(*fr), GFP_KERNEL);
+	if (!fr)
+		return -ENOMEM;
+
+	fr->rev = revocable_alloc(rp);
+	if (!fr->rev)
+		goto free_fr;
+
+	fr->filp = filp;
+	fr->orig_private_data = filp->private_data;
+	fr->orig_fops = filp->f_op;
+
+	memcpy(&fr->fops, filp->f_op, sizeof(fr->fops));
+	fr->fops.release = fs_revocable_release;
+
+	if (fr->fops.read)
+		fr->fops.read = fs_revocable_read;
+	if (fr->fops.poll)
+		fr->fops.poll = fs_revocable_poll;
+	if (fr->fops.unlocked_ioctl)
+		fr->fops.unlocked_ioctl = fs_revocable_unlocked_ioctl;
+
+	filp->f_op = &fr->fops;
+	filp->private_data = fr;
+	return 0;
+free_fr:
+	kfree(fr);
+	if (filp->f_op->release)
+		filp->f_op->release(filp->f_inode, filp);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(fs_revocable_replace);
diff --git a/include/linux/fs_revocable.h b/include/linux/fs_revocable.h
new file mode 100644
index 000000000000..498d035315e6
--- /dev/null
+++ b/include/linux/fs_revocable.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2025 Google LLC
+ */
+
+#ifndef __LINUX_FS_REVOCABLE_H
+#define __LINUX_FS_REVOCABLE_H
+
+#include <linux/fs.h>
+#include <linux/revocable.h>
+
+int fs_revocable_replace(struct revocable_provider *rp, struct file *filp);
+
+#endif /* __LINUX_FS_REVOCABLE_H */
-- 
2.48.1


