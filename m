Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA302323F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgG2R7X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 13:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgG2R7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 13:59:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D787C08C5DF
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id il6so2427815pjb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6dxMTnC8mm7wVLUL1y7lUu+yrbj06Q1SoL75qZmOEE=;
        b=M7Mhxd0VHTaCjwpeLi8bb8xRTEAHLRq1LaJcOFS7AmQH3RfeiwHFguYalSwk9UPXaM
         X4RpeIahd/8iTvKzIzAeBx58iaUbdKCRMrRhBy6MMLQKbK+ea2rWxsus3vf11lbiBFFc
         g9WlKEhCezbVivOz/NVWRQm51DCrYN4cYBXYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6dxMTnC8mm7wVLUL1y7lUu+yrbj06Q1SoL75qZmOEE=;
        b=FAVcYAJna84JH12C8jstbia5mLkdTW1b/aVOhg7mhk9ClPKMJ9fXVt37zsVaGuybFn
         SR0dBHMBblEGL445PQiiMzPtS9gCLtIu1oUli0S9deajGKDBmVz/icWQjwEzOrIIX0rR
         4jbl6ZY+ijTDUwiogb5ZHzw0szOyMS8seUmOO70y/+Cn3Evhy2O9uicywLodf/Yd6Tvq
         sPHK2v5HIHMv9maeNPQuCG71/ds59g4OP3KKGX2uG9/LzTb4KnvVikbAzlDAYm+lsVAb
         raGXuXQn2+hiTmSFKAbNJ6QjViLwhr/m6Ah/JapE4TKSacviIiIS2JyUrsCI+5WYhmUQ
         C+qA==
X-Gm-Message-State: AOAM530T1Ok7sQH2mHtRt9Iv+78K03hxEuI068rKsvy47YfCr/k1RFgQ
        N6nO+cdzXxFQsDp4iU/EBkIPyA==
X-Google-Smtp-Source: ABdhPJzd+GNo2MQY1vzIWQ6bA0AmjVMNq/K11NFESpj+C1FM+CA/agEp1qz6/BytDXhQGCqkERCRrw==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr10817500pju.177.1596045547560;
        Wed, 29 Jul 2020 10:59:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g10sm3096851pfb.82.2020.07.29.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:59:04 -0700 (PDT)
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
Subject: [PATCH v4 14/17] fs/kernel_file_read: Add "offset" arg for partial reads
Date:   Wed, 29 Jul 2020 10:58:42 -0700
Message-Id: <20200729175845.1745471-15-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To perform partial reads, callers of kernel_read_file*() must have a
non-NULL file_size argument and a preallocated buffer. The new "offset"
argument can then be used to seek to specific locations in the file to
fill the buffer to, at most, "buf_size" per call.

Where possible, the LSM hooks can report whether a full file has been
read or not so that the contents can be reasoned about.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/main.c |  2 +-
 fs/kernel_read_file.c               | 78 ++++++++++++++++++++---------
 include/linux/kernel_read_file.h    |  8 +--
 kernel/kexec_file.c                 |  4 +-
 kernel/module.c                     |  2 +-
 security/integrity/digsig.c         |  2 +-
 security/integrity/ima/ima_fs.c     |  3 +-
 7 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 6a5d407279e3..ff1808ed7547 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -494,7 +494,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		fw_priv->size = 0;
 
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
+		rc = kernel_read_file_from_path_initns(path, 0, &buffer, msize,
 						       NULL,
 						       READING_FIRMWARE);
 		if (rc < 0) {
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index d73bc3fa710a..90d255fbdd9b 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -9,6 +9,7 @@
  * kernel_read_file() - read file contents into a kernel buffer
  *
  * @file	file to read from
+ * @offset	where to start reading from (see below).
  * @buf		pointer to a "void *" buffer for reading into (if
  *		*@buf is NULL, a buffer will be allocated, and
  *		@buf_size will be ignored)
@@ -19,19 +20,31 @@
  * @id		the kernel_read_file_id identifying the type of
  *		file contents being read (for LSMs to examine)
  *
+ * @offset must be 0 unless both @buf and @file_size are non-NULL
+ * (i.e. the caller must be expecting to read partial file contents
+ * via an already-allocated @buf, in at most @buf_size chunks, and
+ * will be able to determine when the entire file was read by
+ * checking @file_size). This isn't a recommended way to read a
+ * file, though, since it is possible that the contents might
+ * change between calls to kernel_read_file().
+ *
  * Returns number of bytes read (no single read will be bigger
  * than INT_MAX), or negative on error.
  *
  */
-int kernel_read_file(struct file *file, void **buf,
+int kernel_read_file(struct file *file, loff_t offset, void **buf,
 		     size_t buf_size, size_t *file_size,
 		     enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
-	ssize_t bytes = 0;
+	size_t copied;
 	void *allocated = NULL;
+	bool whole_file;
 	int ret;
 
+	if (offset != 0 && (!*buf || !file_size))
+		return -EINVAL;
+
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EINVAL;
 
@@ -39,19 +52,27 @@ int kernel_read_file(struct file *file, void **buf,
 	if (ret)
 		return ret;
 
-	ret = security_kernel_read_file(file, id, true);
-	if (ret)
-		goto out;
-
 	i_size = i_size_read(file_inode(file));
 	if (i_size <= 0) {
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > INT_MAX || i_size > buf_size) {
+	/* The file is too big for sane activities. */
+	if (i_size > INT_MAX) {
+		ret = -EFBIG;
+		goto out;
+	}
+	/* The entire file cannot be read in one buffer. */
+	if (!file_size && offset == 0 && i_size > buf_size) {
 		ret = -EFBIG;
 		goto out;
 	}
+
+	whole_file = (offset == 0 && i_size <= buf_size);
+	ret = security_kernel_read_file(file, id, whole_file);
+	if (ret)
+		goto out;
+
 	if (file_size)
 		*file_size = i_size;
 
@@ -62,9 +83,14 @@ int kernel_read_file(struct file *file, void **buf,
 		goto out;
 	}
 
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+	pos = offset;
+	copied = 0;
+	while (copied < buf_size) {
+		ssize_t bytes;
+		size_t wanted = min_t(size_t, buf_size - copied,
+					      i_size - pos);
+
+		bytes = kernel_read(file, *buf + copied, wanted, &pos);
 		if (bytes < 0) {
 			ret = bytes;
 			goto out_free;
@@ -72,14 +98,17 @@ int kernel_read_file(struct file *file, void **buf,
 
 		if (bytes == 0)
 			break;
+		copied += bytes;
 	}
 
-	if (pos != i_size) {
-		ret = -EIO;
-		goto out_free;
-	}
+	if (whole_file) {
+		if (pos != i_size) {
+			ret = -EIO;
+			goto out_free;
+		}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+		ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	}
 
 out_free:
 	if (ret < 0) {
@@ -91,11 +120,11 @@ int kernel_read_file(struct file *file, void **buf,
 
 out:
 	allow_write_access(file);
-	return ret == 0 ? pos : ret;
+	return ret == 0 ? copied : ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf,
+int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
 			       size_t buf_size, size_t *file_size,
 			       enum kernel_read_file_id id)
 {
@@ -109,14 +138,15 @@ int kernel_read_file_from_path(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, buf_size, file_size, id);
+	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      size_t buf_size, size_t *file_size,
+int kernel_read_file_from_path_initns(const char *path, loff_t offset,
+				      void **buf, size_t buf_size,
+				      size_t *file_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -135,14 +165,14 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, buf_size, file_size, id);
+	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
-			     size_t *file_size,
+int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
+			     size_t buf_size, size_t *file_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -151,7 +181,7 @@ int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, buf_size, file_size, id);
+	ret = kernel_read_file(f.file, offset, buf, buf_size, file_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 023293eaf948..575ffa1031d3 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -35,19 +35,19 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
-int kernel_read_file(struct file *file,
+int kernel_read_file(struct file *file, loff_t offset,
 		     void **buf, size_t buf_size,
 		     size_t *file_size,
 		     enum kernel_read_file_id id);
-int kernel_read_file_from_path(const char *path,
+int kernel_read_file_from_path(const char *path, loff_t offset,
 			       void **buf, size_t buf_size,
 			       size_t *file_size,
 			       enum kernel_read_file_id id);
-int kernel_read_file_from_path_initns(const char *path,
+int kernel_read_file_from_path_initns(const char *path, loff_t offset,
 				      void **buf, size_t buf_size,
 				      size_t *file_size,
 				      enum kernel_read_file_id id);
-int kernel_read_file_from_fd(int fd,
+int kernel_read_file_from_fd(int fd, loff_t offset,
 			     void **buf, size_t buf_size,
 			     size_t *file_size,
 			     enum kernel_read_file_id id);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 878ca684a3a1..45726bc8f6ce 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -221,7 +221,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	int ret;
 	void *ldata;
 
-	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
+	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
 				       INT_MAX, NULL, READING_KEXEC_IMAGE);
 	if (ret < 0)
 		return ret;
@@ -241,7 +241,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
+		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
 					       INT_MAX, NULL,
 					       READING_KEXEC_INITRAMFS);
 		if (ret < 0)
diff --git a/kernel/module.c b/kernel/module.c
index 72e33e25d7b9..a89900adeb6c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4010,7 +4010,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
-	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX, NULL,
+	err = kernel_read_file_from_fd(fd, 0, &hdr, INT_MAX, NULL,
 				       READING_MODULE);
 	if (err < 0)
 		return err;
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 8a523dfd7fd7..0f518dcfde05 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -175,7 +175,7 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL,
+	rc = kernel_read_file_from_path(path, 0, &data, INT_MAX, NULL,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 5fc56ccb6678..ea8ff8a07b36 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -284,7 +284,8 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL, READING_POLICY);
+	rc = kernel_read_file_from_path(path, 0, &data, INT_MAX, NULL,
+					READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
-- 
2.25.1

