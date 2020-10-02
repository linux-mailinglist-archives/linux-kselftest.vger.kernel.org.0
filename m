Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D628197B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbgJBRim (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbgJBRii (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85956C0613A5
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a17so575249pju.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MqCu1ZX3AyLQ2vV5pdqQHPUd5k1PtZXNO4rLUl2DsAc=;
        b=Fa1+kpkykeFSwotBKaUhSCt6EUI9L9UZDp8Mcc/Tk+rIh6nvLPqKq66QHkPhQKmqHS
         KKHW+WI5V4B8vdik79XG6H+40mGyt6NiwqX1N+jKHCc2O3xV4QGunHRUPPIIvYu1sxmj
         1LQzZ77GWGoxfVAiZDdWv0m5zAKvalCLJO2Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqCu1ZX3AyLQ2vV5pdqQHPUd5k1PtZXNO4rLUl2DsAc=;
        b=ERFzppdSu8HLqogSElGKrZUcXb2brewNoWlNSn54qw3HnWGXot1iOYErl3E9cDsexK
         oXbB1mNo8m2h/yrL1nPSylyRx0lXNdw2MSmLlV9J0Hbs6y941LtIAw0Q0eDX8M9ezPFS
         Sd64Dy8G3F7r+rbRjc+HD+U8A6M3FoWizKdJPESfWDiLlTYd+xdcSKPhAfgMarRMBPRz
         /wu7nOtkyHIL2aD3ZdH3zpyWCqYcT8hvGR5Rga227uPOAwD38ogzVBhCaUHGzlNoc2/p
         bk3oefSTVSta2lC9J3C6Mh+/Es3J4bb8eJi/IvJcrIaihSzTf2uD9sRuDJ/tbAVX/Pcx
         xy8Q==
X-Gm-Message-State: AOAM533TIolz1OVdFjfdHjCA06zGGZXl761y4LsMsu2CaGzfRcC8GOVt
        WN77dk3ggR0iiOyP5Y9WTAHduA==
X-Google-Smtp-Source: ABdhPJxhiBbfvmXyBnGdtdXmsEgxOV/rva06BsW7dLnCt65Cg/BPKnR441EU624drgIyW4k0ZyYU9Q==
X-Received: by 2002:a17:90a:3848:: with SMTP id l8mr3824347pjf.163.1601660315030;
        Fri, 02 Oct 2020 10:38:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ca6sm2086832pjb.53.2020.10.02.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/16] fs/kernel_read_file: Split into separate source file
Date:   Fri,  2 Oct 2020 10:38:16 -0700
Message-Id: <20201002173828.2099543-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These routines are used in places outside of exec(2), so in preparation
for refactoring them, move them into a separate source file,
fs/kernel_read_file.c.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/Makefile           |   3 +-
 fs/exec.c             | 132 ----------------------------------------
 fs/kernel_read_file.c | 138 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 133 deletions(-)
 create mode 100644 fs/kernel_read_file.c

diff --git a/fs/Makefile b/fs/Makefile
index 1c7b0e3f6daa..40c19ff3d570 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,7 +13,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_types.o fs_context.o fs_parser.o fsopen.o init.o
+		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
+		kernel_read_file.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/exec.c b/fs/exec.c
index c454af329413..9f094406ea82 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -950,138 +950,6 @@ struct file *open_exec(const char *name)
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

