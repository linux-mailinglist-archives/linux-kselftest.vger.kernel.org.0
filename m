Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4AD22D0D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 23:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGXVhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgGXVgx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E85C08C5F3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:51 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so6126825pge.12
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85bNNdGOhW+Ma/bZfAvFnKS9zt0a/6SXyJ36wXOo14s=;
        b=PTlcaXvGhGRizhHNFk0TaJKRG/RHUffNOK2e7kItuXBPH5qX8gvDz4DdekPnD7PpYt
         fVRfC0aWAKTcNZHwEJw4MvwSvfYTSxShXLYzhwpSTeJ2MEREWvAeJ+dBKR+l47bkFwBn
         OUbrIiYHcufGoxgWPpwOY//ftIvNlEHXSf5vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85bNNdGOhW+Ma/bZfAvFnKS9zt0a/6SXyJ36wXOo14s=;
        b=qbEJ8YNg2JRweq2IAArw6GroxHRQo2Pd/AI06nyYMY0xiCOSQX2luNkfpQgt3Ku1b3
         q7A5BdjaldDoTAacjkYXhGk16UsNJjSQPRwjflkoMBkgmKQzbWdmS9tQONNFirBt03MB
         4kSYJLZj7+y8OdoDrEIhFDZkvMYeaLDnK4xa8KJTMCKGriL+Oz7yWAalvWuLGut/WJbE
         8nGH8kAI2NaXLD3iZIQZPIyanHg2Hq2CFCpAZThM2I/5bykQE3v/eky3+iW+FkV2aX/A
         AJzTTIwKX/PW3fXQOyRMIvIkWkAdmUJ7D5CO2NlNjoLJKDNt8r6UQD82NT9uWTnAAUVM
         XoNg==
X-Gm-Message-State: AOAM532kq0vEinKJBzH1ijytpn+yoC5QG3MHAUD3G/TKsvfYrOW9GvFj
        /udWn5eYqq5Nj+kYhESnTLqHmg==
X-Google-Smtp-Source: ABdhPJxJUqAc5FXnhiffj9qkjKqxmSmbFuOwEkujmuT7O4l3ErwBR9U1pC41jpeYuQVufXGz9NfSeA==
X-Received: by 2002:a62:7a56:: with SMTP id v83mr10555845pfc.114.1595626611378;
        Fri, 24 Jul 2020 14:36:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u16sm6975339pfn.52.2020.07.24.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/19] fs/kernel_read_file: Add file_size output argument
Date:   Fri, 24 Jul 2020 14:36:31 -0700
Message-Id: <20200724213640.389191-11-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for adding partial read support, add an optional output
argument to kernel_read_file*() that reports the file size so callers
can reason more easily about their reading progress.

Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/main.c |  1 +
 fs/kernel_read_file.c               | 19 +++++++++++++------
 include/linux/kernel_read_file.h    |  4 ++++
 kernel/kexec_file.c                 |  4 ++--
 kernel/module.c                     |  2 +-
 security/integrity/digsig.c         |  2 +-
 security/integrity/ima/ima_fs.c     |  2 +-
 7 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index f80c0d102be8..bd199404935f 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -495,6 +495,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 
 		/* load firmware files from the mount namespace of init */
 		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
+						       NULL,
 						       READING_FIRMWARE);
 		if (rc < 0) {
 			if (rc != -ENOENT)
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index e21a76001fff..2e29c38eb4df 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -14,6 +14,8 @@
  *		@buf_size will be ignored)
  * @buf_size	size of buf, if already allocated. If @buf not
  *		allocated, this is the largest size to allocate.
+ * @file_size	if non-NULL, the full size of @file will be
+ *		written here.
  * @id		the kernel_read_file_id identifying the type of
  *		file contents being read (for LSMs to examine)
  *
@@ -22,7 +24,8 @@
  *
  */
 int kernel_read_file(struct file *file, void **buf,
-		     size_t buf_size, enum kernel_read_file_id id)
+		     size_t buf_size, size_t *file_size,
+		     enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
@@ -49,6 +52,8 @@ int kernel_read_file(struct file *file, void **buf,
 		ret = -EFBIG;
 		goto out;
 	}
+	if (file_size)
+		*file_size = i_size;
 
 	if (!*buf)
 		*buf = allocated = vmalloc(i_size);
@@ -91,7 +96,8 @@ int kernel_read_file(struct file *file, void **buf,
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
 int kernel_read_file_from_path(const char *path, void **buf,
-			       size_t buf_size, enum kernel_read_file_id id)
+			       size_t buf_size, size_t *file_size,
+			       enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -103,14 +109,14 @@ int kernel_read_file_from_path(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, buf_size, id);
+	ret = kernel_read_file(file, buf, buf_size, file_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
 int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      size_t buf_size,
+				      size_t buf_size, size_t *file_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -129,13 +135,14 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, buf_size, id);
+	ret = kernel_read_file(file, buf, buf_size, file_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
 int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
+			     size_t *file_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -144,7 +151,7 @@ int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, buf_size, id);
+	ret = kernel_read_file(f.file, buf, buf_size, file_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 910039e7593e..023293eaf948 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -37,15 +37,19 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 
 int kernel_read_file(struct file *file,
 		     void **buf, size_t buf_size,
+		     size_t *file_size,
 		     enum kernel_read_file_id id);
 int kernel_read_file_from_path(const char *path,
 			       void **buf, size_t buf_size,
+			       size_t *file_size,
 			       enum kernel_read_file_id id);
 int kernel_read_file_from_path_initns(const char *path,
 				      void **buf, size_t buf_size,
+				      size_t *file_size,
 				      enum kernel_read_file_id id);
 int kernel_read_file_from_fd(int fd,
 			     void **buf, size_t buf_size,
+			     size_t *file_size,
 			     enum kernel_read_file_id id);
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eda19ca256a3..878ca684a3a1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -222,7 +222,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	void *ldata;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
-				       INT_MAX, READING_KEXEC_IMAGE);
+				       INT_MAX, NULL, READING_KEXEC_IMAGE);
 	if (ret < 0)
 		return ret;
 	image->kernel_buf_len = ret;
@@ -242,7 +242,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-					       INT_MAX,
+					       INT_MAX, NULL,
 					       READING_KEXEC_INITRAMFS);
 		if (ret < 0)
 			goto out;
diff --git a/kernel/module.c b/kernel/module.c
index b6fd4f51cc30..860d713dd910 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4001,7 +4001,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
-	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX,
+	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX, NULL,
 				       READING_MODULE);
 	if (err < 0)
 		return err;
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 04f779c4f5ed..8a523dfd7fd7 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -175,7 +175,7 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, INT_MAX,
+	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 692b83e82edf..5fc56ccb6678 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -284,7 +284,7 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, INT_MAX, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL, READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
-- 
2.25.1

