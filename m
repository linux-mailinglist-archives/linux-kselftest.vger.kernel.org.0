Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C112819B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbgJBRjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388391AbgJBRik (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A3C0613A8
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h23so1220839pjv.5
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZNhkp+Ex7uixUZwdnKtRZuboVANPTY0Sz5Zyi22yrg=;
        b=ZXP+q7PnzQa6LfR5IqDwOiL+3aiyalH+lzrSji6XGSuLCygmO87wN8h/T1+VwRCrXo
         7l7zYzj8s9k1eycRAjGu0x2I4aY3HHR7HGBZU3XvySusni+7g+k1sm0CcCgX7Grls47g
         +/qsf06fs6BW7V8Nkk5YDWMp6ANViowBcWYDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZNhkp+Ex7uixUZwdnKtRZuboVANPTY0Sz5Zyi22yrg=;
        b=CNgnrB57Unz1t1i4or6XN7962vOje8U90ScjqbbTwPaA+t/G5XjYj3pPbJr/mmoEAY
         UWU/ig4VmCrXsUSSFkT30u8u+QnSae7sAsoNIlhXcGeRjRffp1RoDBVSEAdJQHkhPTA0
         oeBljJjdwx3vCOzjS4QM6s/QSLcRkyWnhoG7WrGvuwhF+pC8dj5j++dLcL9ieBV8QWtx
         abA0+hR/JHPP7tngiiPwROttA4/yTqy21QwGF52S/O/+tmU9xtbbLOH0XhMAl/RvNcyd
         aKvDTnHp4b+g4x7zE8LWTIe2JerKnNfmcvetjII7ePhIgeB7UusxxdHfL1rer67pvmIC
         XCyQ==
X-Gm-Message-State: AOAM531AdqO9WjoQdfhexnWFrHOV3Ak6cc9wioBL7NLKa+J12hw+IJ5u
        5G5DyXJnQrv5rXbZ9GBzocL2iQ==
X-Google-Smtp-Source: ABdhPJyor6I0OBDlhptSmA2CTw2A2FOz16orpOA1LJDZY8gyfQKIOZ86O1WsL37+jRrDp43R8+pnlA==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr2160961pjq.21.1601660319816;
        Fri, 02 Oct 2020 10:38:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z7sm2747869pfj.75.2020.10.02.10.38.35
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
Subject: [PATCH v5 07/16] fs/kernel_read_file: Add file_size output argument
Date:   Fri,  2 Oct 2020 10:38:19 -0700
Message-Id: <20201002173828.2099543-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for adding partial read support, add an optional output
argument to kernel_read_file*() that reports the file size so callers
can reason more easily about their reading progress.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
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
index 6df1bdcfeb9d..d9a180148c4b 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -500,6 +500,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 
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
index b20cfde8a01d..ee51c1028658 100644
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
index 9faa6322f17b..0f11eaed047e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4048,7 +4048,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
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

