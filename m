Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8B281995
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbgJBRjI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbgJBRio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890BC0613E3
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j19so1295994pjl.4
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9Rq3b4KCQ4FxOzHf+bfvfTJvSHiqKnvNkPrejY2mCg=;
        b=VDo5tX8n4jsCduuRAefxgt/QAwRPuJu1/HLnvEVBoGLlaKXu0Y7dFzTgxRh9jddvUt
         Q3b/kNGbu1xU9x6q6wcllv6bvJmm5fTg/sFvUYGYI1zIAkBSybVEKb85WGjaMiu+PyZx
         dsolwth7kcoko7RGcZIh94Z4NEFkV6nHlN5eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9Rq3b4KCQ4FxOzHf+bfvfTJvSHiqKnvNkPrejY2mCg=;
        b=XCZ0H+AbabWJuIzJHggud4IwdQh6QTpx8J3kk0Vu8GDwHK7DRb7tvpga357P1g4t6H
         eG0VAXssZQbOo39vwU8o0if6FQFVzYaWThHBnq8wVJoiGkXfHyH0IHO+CwDxgUkVaj8U
         b7jI1SYq0LJBEsESYibCZ9QAd7xkvgykDCoaQzhC1YMeV6oI3rvrceSQ3l+KNMaKRPC5
         4/1AgXE3x+IH9Hdk7Vr/k66woBPV6kt/ONbO0PLKWm43FCcV5U8rai63H3zDvZaHyohi
         g1ecIjWhPfuvcEKWp6ab6LUmH4kJZOKlLIF45ux9hb2J9uPyt8dLExIh2RcOhOTdmVD4
         Ui7A==
X-Gm-Message-State: AOAM533esZboTQnDTx3n6krdt+oU9+QA6Q+X8F0tLpEO873J00taiGNw
        uKcHYM0W+2B0U+lbsu3bGh0ZTw==
X-Google-Smtp-Source: ABdhPJzP9vRzKkF63PUjWCICE9WnxLmFLUnZ+dokL/JgGb+Ip1X/cPPBTnPGD9UkZWcuj3MNRxbwuw==
X-Received: by 2002:a17:90a:1992:: with SMTP id 18mr3867983pji.143.1601660324116;
        Fri, 02 Oct 2020 10:38:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g3sm2090472pjl.6.2020.10.02.10.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:42 -0700 (PDT)
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
Subject: [PATCH v5 13/16] fs/kernel_file_read: Add "offset" arg for partial reads
Date:   Fri,  2 Oct 2020 10:38:25 -0700
Message-Id: <20201002173828.2099543-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index d9a180148c4b..79f86466d472 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -499,7 +499,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
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
index ee51c1028658..84f7316792a7 100644
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
index adfa21dd3842..9c578e44abe7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4054,7 +4054,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
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

