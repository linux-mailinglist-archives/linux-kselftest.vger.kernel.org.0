Return-Path: <linux-kselftest+bounces-43284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED00BE18AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C8B48059D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502002494F0;
	Thu, 16 Oct 2025 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8O9WK13"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A92459ED;
	Thu, 16 Oct 2025 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593387; cv=none; b=WAYJ3C7kdwgalCNVRczLcqjyJ3rve9dFKn8KjegFi8oAA9VZpuuIJrf/8+5E+yXMph6uYHuCRItDz7ozwT97PujGA76FtTQ9MbryRR3Bbb4DnDyurjeMsaVswBrvKRPo5UGcp4oIZqxow+r5gZJRWSyvJty2a5TUs0YNdHnCAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593387; c=relaxed/simple;
	bh=8BMbHiSLkDMMANbw+KKMDG0ygUk8JdmWnPcT/VE9x8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqib8iwY4yLrcZVD1HsGjd9KXPPWmnAI7y0/L7APZscqgWb59FzMI45JWRiAVgr5+yatmGEZZaByZUarRZLSOo6n6Ue32RorltLtGLgxXDP1+MX1d+h8ebg+my4qDr0Xwsn0/L1fE/unIX/3mtqd314P5CR48o8o97uygD+k3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8O9WK13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1714FC4CEF1;
	Thu, 16 Oct 2025 05:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760593386;
	bh=8BMbHiSLkDMMANbw+KKMDG0ygUk8JdmWnPcT/VE9x8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8O9WK13a9InIrG8b5bi7SmmDmjkzzGQhaZPwU7sHBzskRbscLVSYU8ailonuYpYg
	 L4TvTLFHtU5ZNCYKTt4FVDx7D8W416KzFd68CWxJ5wFMqUh4cGH7zv3x4BdO6wH18l
	 BmaoMvWKL10eJGH8SMldSp1kD561x2l7yidQ4ZlnVlScouTq0XUpkjFogSC+zNgwR9
	 Ui3NAO19SxnWMFj3E0KyfFks5PDJKyPvinI9bkkPIQmwN6zJMYt/nkF6G1ztbSFvAj
	 B8YH37XsuDhS/CxmrQSPZ9UresUZYLKzUfNhfZC52oELiyNPUBVOcZjOSxqxWY5wZt
	 PxGpLxrrtm8UQ==
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
Subject: [PATCH v5 5/7] revocable: Add fops replacement
Date: Thu, 16 Oct 2025 05:42:02 +0000
Message-ID: <20251016054204.1523139-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251016054204.1523139-1-tzungbi@kernel.org>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce fs_revocable_replace() to simplify the use of the revocable
API with file_operations.

The function, should be called from a driver's ->open(), replaces the
fops with a wrapper that automatically handles the `try_access` and
`withdraw_access`.

When the file is closed, the wrapper's ->release() restores the original
fops and cleanups.  This centralizes the revocable logic, making drivers
cleaner and easier to maintain.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
PoC patch.

Known issues:
- All file operations call revocable_try_access() for guaranteeing the
  resource even if the resource may be unused in the fops.

v5:
- Rename to "fs_revocable".
- Move the replacement context to struct file.
- Support multiple revocable providers.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-6-tzungbi@kernel.org
- New in the series.

 fs/Makefile                  |   2 +-
 fs/fs_revocable.c            | 154 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h           |   2 +
 include/linux/fs_revocable.h |  21 +++++
 4 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 fs/fs_revocable.c
 create mode 100644 include/linux/fs_revocable.h

diff --git a/fs/Makefile b/fs/Makefile
index e3523ab2e587..ec2b21385deb 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
-		file_attr.o
+		file_attr.o fs_revocable.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/fs_revocable.c b/fs/fs_revocable.c
new file mode 100644
index 000000000000..4b6d755abfed
--- /dev/null
+++ b/fs/fs_revocable.c
@@ -0,0 +1,154 @@
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
+struct fs_revocable_replacement {
+	const struct fs_revocable_operations *frops;
+	const struct file_operations *orig_fops;
+	struct file_operations fops;
+	struct revocable **revs;
+	size_t num_revs;
+};
+
+static int fs_revocable_try_access(struct file *filp)
+{
+	struct fs_revocable_replacement *rr = filp->f_rr;
+
+	return rr->frops->try_access(rr->revs, rr->num_revs,
+				     filp->private_data);
+}
+
+static void fs_revocable_withdraw_access(struct fs_revocable_replacement *rr)
+{
+	for (size_t i = 0; i < rr->num_revs; ++i)
+		revocable_withdraw_access(rr->revs[i]);
+}
+
+DEFINE_FREE(fs_revocable_replacement, struct fs_revocable_replacement *,
+	    if (_T) fs_revocable_withdraw_access(_T))
+
+static ssize_t fs_revocable_read(struct file *filp, char __user *buffer,
+				 size_t length, loff_t *offset)
+{
+	struct fs_revocable_replacement *rr
+			__free(fs_revocable_replacement) = filp->f_rr;
+	int ret;
+
+	ret = fs_revocable_try_access(filp);
+	if (ret)
+		return ret;
+	return rr->orig_fops->read(filp, buffer, length, offset);
+}
+
+static __poll_t fs_revocable_poll(struct file *filp, poll_table *wait)
+{
+	struct fs_revocable_replacement *rr
+			__free(fs_revocable_replacement) = filp->f_rr;
+	int ret;
+
+	ret = fs_revocable_try_access(filp);
+	if (ret)
+		return ret;
+	return rr->orig_fops->poll(filp, wait);
+}
+
+static long fs_revocable_unlocked_ioctl(struct file *filp, unsigned int cmd,
+					unsigned long arg)
+{
+	struct fs_revocable_replacement *rr
+			__free(fs_revocable_replacement) = filp->f_rr;
+	int ret;
+
+	ret = fs_revocable_try_access(filp);
+	if (ret)
+		return ret;
+	return rr->orig_fops->unlocked_ioctl(filp, cmd, arg);
+}
+
+static int fs_revocable_release(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+	struct fs_revocable_replacement *rr = filp->f_rr;
+
+	if (!rr->orig_fops->release)
+		goto recover;
+
+	ret = fs_revocable_try_access(filp);
+	if (ret)
+		goto recover;
+
+	ret = rr->orig_fops->release(inode, filp);
+
+	fs_revocable_withdraw_access(rr);
+recover:
+	filp->f_op = rr->orig_fops;
+	filp->f_rr = NULL;
+
+	for (size_t i = 0; i < rr->num_revs; ++i)
+		revocable_free(rr->revs[i]);
+	kfree(rr->revs);
+	kfree(rr);
+
+	return ret;
+}
+
+/**
+ * fs_revocable_replace() - Replace the file operations to be revocable-aware.
+ *
+ * Should be used only from ->open() instances.
+ */
+int fs_revocable_replace(struct file *filp,
+			 const struct fs_revocable_operations *frops,
+			 struct revocable_provider **rps, size_t num_rps)
+{
+	struct fs_revocable_replacement *rr;
+	size_t i;
+
+	rr = kzalloc(sizeof(*rr), GFP_KERNEL);
+	if (!rr)
+		return -ENOMEM;
+	filp->f_rr = rr;
+
+	rr->frops = frops;
+	rr->revs = kcalloc(num_rps, sizeof(*rr->revs), GFP_KERNEL);
+	if (!rr->revs)
+		goto free_rr;
+	for (i = 0; i < num_rps; ++i) {
+		rr->revs[i] = revocable_alloc(rps[i]);
+		if (!rr->revs[i])
+			goto free_revs;
+	}
+	rr->num_revs = num_rps;
+	rr->orig_fops = filp->f_op;
+
+	memcpy(&rr->fops, filp->f_op, sizeof(rr->fops));
+	rr->fops.release = fs_revocable_release;
+
+	if (rr->fops.read)
+		rr->fops.read = fs_revocable_read;
+	if (rr->fops.poll)
+		rr->fops.poll = fs_revocable_poll;
+	if (rr->fops.unlocked_ioctl)
+		rr->fops.unlocked_ioctl = fs_revocable_unlocked_ioctl;
+
+	filp->f_op = &rr->fops;
+	return 0;
+free_revs:
+	if (i) {
+		while (--i)
+			revocable_free(rr->revs[i]);
+	}
+	kfree(rr->revs);
+free_rr:
+	kfree(rr);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(fs_revocable_replace);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68c4a59ec8fb..a03dd7f343a9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -80,6 +80,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct file_kattr;
 struct iomap_ops;
+struct fs_revocable_replacement;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -1248,6 +1249,7 @@ struct file {
 	};
 	file_ref_t			f_ref;
 	/* --- cacheline 3 boundary (192 bytes) --- */
+	struct fs_revocable_replacement *f_rr;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/linux/fs_revocable.h b/include/linux/fs_revocable.h
new file mode 100644
index 000000000000..bb066392d232
--- /dev/null
+++ b/include/linux/fs_revocable.h
@@ -0,0 +1,21 @@
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
+struct fs_revocable_operations {
+	int (*try_access)(struct revocable **revs, size_t num_revs, void *data);
+};
+
+int fs_revocable_replace(struct file *filp,
+			 const struct fs_revocable_operations *frops,
+			 struct revocable_provider **rps, size_t num_rps);
+
+#endif /* __LINUX_FS_REVOCABLE_H */
-- 
2.51.0.788.g6d19910ace-goog


