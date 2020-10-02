Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE753281977
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbgJBRik (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbgJBRii (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FEC0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so1247222pgi.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZhM0u1Ixh6Kh+HXvNSm8TOvqXs6GWG/DhLCwiIZPAQ=;
        b=dhTPr3HfrcE87niKjHnrsTeF1TcXrwE3MtOzEVE6zgIgOvNW2rTQI9z3LOdcFoyVDM
         SBGNwTYXUuqJM/f0GmpP0X0+JEVgSuETIXvn6XfOmQ/TeXGBd3DyqhtRg4DFLO1+L2Mr
         i558wv0fKdwpBIUsFJJ9VnuXXiUIkFoFIk9vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZhM0u1Ixh6Kh+HXvNSm8TOvqXs6GWG/DhLCwiIZPAQ=;
        b=nh8V30YwIK60rfyvv2pJxXquITnxzDmVYt244CL1LfGChcrcaoTo8Fqv4Upou6lUaR
         GU8ArsrcfZzm+5ZDZHRP8Hd2tbeXrtE8nGc2+bM9NVdleHx1brCtmilQlgK0XVs5QQkR
         2+IgISRr1Eibe3CugBd8eIovFXTjyGKKPg5KKKjyZzBtMjD7tCMdR3ehIFJXhH3+jETZ
         HxpUYY+dI08J/irs8Vr4Ykm1DU+yo3oMfvxLg98nyzI5dDzkjUgf4NKGj0y5siQWrCND
         LwAaOSK+Ib1PQsaA3xdR6I/QuDo9Q8yMefEhYgyjnTCFN64a2zCgwRXIey1e8h/UO2WI
         M3ZA==
X-Gm-Message-State: AOAM533UzseCzNd0i3iuCEUGm60VvMtIsNBhO4UJ7kANVPbbD6vxzEB8
        ealeZrtv/bivczZ7IdCbe1a8EQ==
X-Google-Smtp-Source: ABdhPJwaD4NElc+GQ4IINbv7oc2YCpYC1zsjIXxVz9EyAd0B1Cyyi5Hk2RJaUftxrf7tj37r6wGe1A==
X-Received: by 2002:a62:3382:0:b029:150:bde9:d408 with SMTP id z124-20020a6233820000b0290150bde9d408mr4200055pfz.12.1601660318157;
        Fri, 02 Oct 2020 10:38:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10sm2157310pgp.25.2020.10.02.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        James Morris <jamorris@linux.microsoft.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/16] fs/kernel_read_file: Remove redundant size argument
Date:   Fri,  2 Oct 2020 10:38:17 -0700
Message-Id: <20201002173828.2099543-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for refactoring kernel_read_file*(), remove the redundant
"size" argument which is not needed: it can be included in the return
code, with callers adjusted. (VFS reads already cannot be larger than
INT_MAX.)

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/base/firmware_loader/main.c | 10 ++++++----
 fs/kernel_read_file.c               | 20 +++++++++-----------
 include/linux/kernel_read_file.h    |  8 ++++----
 kernel/kexec_file.c                 | 14 +++++++-------
 kernel/module.c                     |  7 +++----
 security/integrity/digsig.c         |  5 +++--
 security/integrity/ima/ima_fs.c     |  6 ++++--
 7 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 8c6ea389afcf..6df1bdcfeb9d 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -467,7 +467,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 					     size_t in_size,
 					     const void *in_buffer))
 {
-	loff_t size;
+	size_t size;
 	int i, len;
 	int rc = -ENOENT;
 	char *path;
@@ -499,10 +499,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		fw_priv->size = 0;
 
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, &buffer,
-						       &size, msize,
+		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
 						       READING_FIRMWARE);
-		if (rc) {
+		if (rc < 0) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
 					 path, rc);
@@ -511,6 +510,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 					 path);
 			continue;
 		}
+		size = rc;
+		rc = 0;
+
 		dev_dbg(device, "Loading firmware from %s\n", path);
 		if (decompress) {
 			dev_dbg(device, "f/w decompressing %s\n",
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 54d972d4befc..dc28a8def597 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -5,7 +5,7 @@
 #include <linux/security.h>
 #include <linux/vmalloc.h>
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
+int kernel_read_file(struct file *file, void **buf,
 		     loff_t max_size, enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
@@ -29,7 +29,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -59,8 +59,6 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	}
 
 	ret = security_kernel_post_read_file(file, *buf, i_size, id);
-	if (!ret)
-		*size = pos;
 
 out_free:
 	if (ret < 0) {
@@ -72,11 +70,11 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 out:
 	allow_write_access(file);
-	return ret;
+	return ret == 0 ? pos : ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+int kernel_read_file_from_path(const char *path, void **buf,
 			       loff_t max_size, enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -89,14 +87,14 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_read_file(file, buf, max_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
 int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
+				      loff_t max_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -115,13 +113,13 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_read_file(file, buf, max_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -130,7 +128,7 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_read_file(f.file, buf, max_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 78cf3d7dc835..0ca0bdbed1bd 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -36,16 +36,16 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 }
 
 int kernel_read_file(struct file *file,
-		     void **buf, loff_t *size, loff_t max_size,
+		     void **buf, loff_t max_size,
 		     enum kernel_read_file_id id);
 int kernel_read_file_from_path(const char *path,
-			       void **buf, loff_t *size, loff_t max_size,
+			       void **buf, loff_t max_size,
 			       enum kernel_read_file_id id);
 int kernel_read_file_from_path_initns(const char *path,
-				      void **buf, loff_t *size, loff_t max_size,
+				      void **buf, loff_t max_size,
 				      enum kernel_read_file_id id);
 int kernel_read_file_from_fd(int fd,
-			     void **buf, loff_t *size, loff_t max_size,
+			     void **buf, loff_t max_size,
 			     enum kernel_read_file_id id);
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1cc82557f4c1..b20cfde8a01d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -220,13 +220,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 {
 	int ret;
 	void *ldata;
-	loff_t size;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
-				       &size, INT_MAX, READING_KEXEC_IMAGE);
-	if (ret)
+				       INT_MAX, READING_KEXEC_IMAGE);
+	if (ret < 0)
 		return ret;
-	image->kernel_buf_len = size;
+	image->kernel_buf_len = ret;
 
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
@@ -243,11 +242,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-					       &size, INT_MAX,
+					       INT_MAX,
 					       READING_KEXEC_INITRAMFS);
-		if (ret)
+		if (ret < 0)
 			goto out;
-		image->initrd_buf_len = size;
+		image->initrd_buf_len = ret;
+		ret = 0;
 	}
 
 	if (cmdline_len) {
diff --git a/kernel/module.c b/kernel/module.c
index 4218abd272ee..9faa6322f17b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4035,7 +4035,6 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
 	struct load_info info = { };
-	loff_t size;
 	void *hdr = NULL;
 	int err;
 
@@ -4049,12 +4048,12 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
-	err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX,
+	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX,
 				       READING_MODULE);
-	if (err)
+	if (err < 0)
 		return err;
 	info.hdr = hdr;
-	info.len = size;
+	info.len = err;
 
 	return load_module(&info, uargs, flags);
 }
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f8869be45d8f..97661ffabc4e 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -171,16 +171,17 @@ int __init integrity_add_key(const unsigned int id, const void *data,
 int __init integrity_load_x509(const unsigned int id, const char *path)
 {
 	void *data = NULL;
-	loff_t size;
+	size_t size;
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, &size, 0,
+	rc = kernel_read_file_from_path(path, &data, 0,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
 	}
+	size = rc;
 
 	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e13ffece3726..602f52717757 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -275,7 +275,7 @@ static ssize_t ima_read_policy(char *path)
 {
 	void *data = NULL;
 	char *datap;
-	loff_t size;
+	size_t size;
 	int rc, pathlen = strlen(path);
 
 	char *p;
@@ -284,11 +284,13 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, &size, 0, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, 0, READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
 	}
+	size = rc;
+	rc = 0;
 
 	datap = data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
-- 
2.25.1

