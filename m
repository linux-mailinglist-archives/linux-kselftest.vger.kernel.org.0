Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3599F23242D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgG2SAF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgG2R7A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 13:59:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44273C0619D5
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so12168041plk.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8pBSpCBzAxEXSHFMED25Y5ODq87rGH8b/wr0X9QC7I=;
        b=Uy1qxMG9Wk7KhOJd3h1FBwTDF5og6PjBAQI16Z27ZpZm2EIrFW3BdRtpDli8mZi1t6
         2NNjargrYHFlYLP8pNZ29iVEsGle8JrqmrtsHwy/+EiM9ae/EoP6+HBD5yz/FBTmfY5o
         YT+z+TKhc/UG0zOYcimMA/QrptC9N69IWpT60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8pBSpCBzAxEXSHFMED25Y5ODq87rGH8b/wr0X9QC7I=;
        b=G8ro70sK0acA2le7rNL/P9jfvKKUIC7o1K/TTxRoyClkYFHt8UWBpzQJjdtPyJJ7RK
         CZrMFM47dUhsUZtFNRuB8EZ+Ig/Uz+I9QHcsOvnIcICT8U/JQXySFkSQO+o+nS08PuGC
         w9gjJ65BrZbSnSuMxIl+V4nQLBQM0p/5okAV4Kr9EsYeQY9kG3nJzKkqhhhA1yKvodEI
         3g0kd7ohBEvCQ/zg2niK/xJlzXx7iqNgCgG2pMg5g62DHZUZo/xcIrR1KhrE8t7b5Ecu
         AyRBZl+Wy3o91IOpCK6huFZqcylNxDgp1Eo6xIm/XBDge95P7LexoDw45jOE0pALIcb+
         2kQA==
X-Gm-Message-State: AOAM531XyNNRNoW9OQbKvi2/0YeKnuJA6BV5Xhu+E7AtbJdocF5MY1qk
        IvI2IcPs4IGGgX7UqqRbdagTtA==
X-Google-Smtp-Source: ABdhPJzo9IxoT9gvuXx2GpK4yoZzBFJYjOX4Gn6EU8vWiGKG8RTXVOjsQFEjv28d+YZFT5W01YafVw==
X-Received: by 2002:a17:902:7086:: with SMTP id z6mr27406701plk.4.1596045539786;
        Wed, 29 Jul 2020 10:58:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2sm3138576pfl.21.2020.07.29.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:58:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/17] fs/kernel_read_file: Split into separate source file
Date:   Wed, 29 Jul 2020 10:58:33 -0700
Message-Id: <20200729175845.1745471-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These routines are used in places outside of exec(2), so in preparation
for refactoring them, move them into a separate source file,
fs/kernel_read_file.c.

Acked-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/Makefile           |   3 +-
 fs/exec.c             | 132 ----------------------------------------
 fs/kernel_read_file.c | 138 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 133 deletions(-)
 create mode 100644 fs/kernel_read_file.c

diff --git a/fs/Makefile b/fs/Makefile
index 2ce5112b02c8..a05fc247b2a7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,7 +13,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_types.o fs_context.o fs_parser.o fsopen.o
+		fs_types.o fs_context.o fs_parser.o fsopen.o \
+		kernel_read_file.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/exec.c b/fs/exec.c
index 07a7fe9ac5be..d619b79aab30 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -923,138 +923,6 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
-	ssize_t bytes = 0;
-	void *allocated = NULL;
-	int ret;
-
-	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
-		return -EINVAL;
-
-	ret = deny_write_access(file);
-	if (ret)
-		return ret;
-
-	ret = security_kernel_read_file(file, id);
-	if (ret)
-		goto out;
-
-	i_size = i_size_read(file_inode(file));
-	if (i_size <= 0) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
-		ret = -EFBIG;
-		goto out;
-	}
-
-	if (!*buf)
-		*buf = allocated = vmalloc(i_size);
-	if (!*buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
-		if (bytes < 0) {
-			ret = bytes;
-			goto out_free;
-		}
-
-		if (bytes == 0)
-			break;
-	}
-
-	if (pos != i_size) {
-		ret = -EIO;
-		goto out_free;
-	}
-
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
-	if (!ret)
-		*size = pos;
-
-out_free:
-	if (ret < 0) {
-		if (allocated) {
-			vfree(*buf);
-			*buf = NULL;
-		}
-	}
-
-out:
-	allow_write_access(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file);
-
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
-{
-	struct file *file;
-	int ret;
-
-	if (!path || !*path)
-		return -EINVAL;
-
-	file = filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	ret = kernel_read_file(file, buf, size, max_size, id);
-	fput(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
-
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
-				      enum kernel_read_file_id id)
-{
-	struct file *file;
-	struct path root;
-	int ret;
-
-	if (!path || !*path)
-		return -EINVAL;
-
-	task_lock(&init_task);
-	get_fs_root(init_task.fs, &root);
-	task_unlock(&init_task);
-
-	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
-	path_put(&root);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	ret = kernel_read_file(file, buf, size, max_size, id);
-	fput(file);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
-
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
-{
-	struct fd f = fdget(fd);
-	int ret = -EBADF;
-
-	if (!f.file)
-		goto out;
-
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
-	fdput(f);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-
 #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
     defined(CONFIG_BINFMT_ELF_FDPIC)
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
new file mode 100644
index 000000000000..54d972d4befc
--- /dev/null
+++ b/fs/kernel_read_file.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/fs.h>
+#include <linux/fs_struct.h>
+#include <linux/kernel_read_file.h>
+#include <linux/security.h>
+#include <linux/vmalloc.h>
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	loff_t i_size, pos;
+	ssize_t bytes = 0;
+	void *allocated = NULL;
+	int ret;
+
+	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
+		return -EINVAL;
+
+	ret = deny_write_access(file);
+	if (ret)
+		return ret;
+
+	ret = security_kernel_read_file(file, id);
+	if (ret)
+		goto out;
+
+	i_size = i_size_read(file_inode(file));
+	if (i_size <= 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+		ret = -EFBIG;
+		goto out;
+	}
+
+	if (!*buf)
+		*buf = allocated = vmalloc(i_size);
+	if (!*buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pos = 0;
+	while (pos < i_size) {
+		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+		if (bytes < 0) {
+			ret = bytes;
+			goto out_free;
+		}
+
+		if (bytes == 0)
+			break;
+	}
+
+	if (pos != i_size) {
+		ret = -EIO;
+		goto out_free;
+	}
+
+	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	if (!ret)
+		*size = pos;
+
+out_free:
+	if (ret < 0) {
+		if (allocated) {
+			vfree(*buf);
+			*buf = NULL;
+		}
+	}
+
+out:
+	allow_write_access(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file);
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	struct file *file;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = kernel_read_file(file, buf, size, max_size, id);
+	fput(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
+
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	struct file *file;
+	struct path root;
+	int ret;
+
+	if (!path || !*path)
+		return -EINVAL;
+
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
+	path_put(&root);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = kernel_read_file(file, buf, size, max_size, id);
+	fput(file);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	struct fd f = fdget(fd);
+	int ret = -EBADF;
+
+	if (!f.file)
+		goto out;
+
+	ret = kernel_read_file(f.file, buf, size, max_size, id);
+out:
+	fdput(f);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.25.1

