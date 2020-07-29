Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C2232421
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgG2R76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgG2R7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 13:59:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6642EC08C5C0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so14684594pgb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8FXcJVqBHjcgT1Agm86XnnWSLKBXkfAqvFnOxkisTqQ=;
        b=BmjVjoWKA8kMgg8+hHzQgXql4nM5ujsG2sEYnBcdy7xaNlTgyBePPNTGBEbQ6MDFV1
         d6Y9Z0cuDbncD+mzS7Rl6gxkg/qiz/DE9kVm7QK1iCHYoKpCxAHaYXBt+o9T0bXhMFay
         k2FzeyjXJC9jz/eqoAjjdLxVY02VrroizS3K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8FXcJVqBHjcgT1Agm86XnnWSLKBXkfAqvFnOxkisTqQ=;
        b=D5eh+rpC/LgWHQ+UvLVFc1xDaOf2gzFI+5/hoaWG70oGiRHgQiZ/LIUwst9qfFctma
         +mWetUbZUvW8HwT1kqhTwiFAWfV8jc25mDIzLctvwakwQ2a3wEm0VlDN27hpPOf9pJwn
         HQ/oT17T2NXZBmHYZygYBGA6fPTpYBbZ+g+HRl/mwQpy8SmSRSYRXGUphI4Puu8hoDpL
         7q/wvTpHkivJT/oJ6hy0lzeu/XOHlrNEcBDmICLPIujPpLsj1FBzINXFDij8b/EmktgF
         4d68YsMtvQG7fl0ba0A2zVG3ekbMZR2bqfSxAcsVPffHxPxkujfjHv4LLXnBXsr/tTVT
         o2cA==
X-Gm-Message-State: AOAM530Xgk6tGVzj2nPYZSba8yBMpbGwPL8YNvyQwBCZf/mlSC3a2qE8
        ZIhdnWdmne2PCJoAIWNPrSbi7A==
X-Google-Smtp-Source: ABdhPJx8EX4pc8bYnKpIrYzoFGT5+7PS/5s/buTOZrRuN/iRGO620gNUO5macxBQPeRbg/cVCrULPg==
X-Received: by 2002:a05:6a00:7ca:: with SMTP id n10mr18901795pfu.129.1596045541943;
        Wed, 29 Jul 2020 10:59:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l16sm2981366pff.167.2020.07.29.10.58.55
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
Subject: [PATCH v4 07/17] fs/kernel_read_file: Switch buffer size arg to size_t
Date:   Wed, 29 Jul 2020 10:58:35 -0700
Message-Id: <20200729175845.1745471-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for further refactoring of kernel_read_file*(), rename
the "max_size" argument to the more accurate "buf_size", and correct
its type to size_t. Add kerndoc to explain the specifics of how the
arguments will be used. Note that with buf_size now size_t, it can no
longer be negative (and was never called with a negative value). Adjust
callers to use it as a "maximum size" when *buf is NULL.

Acked-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernel_read_file.c            | 34 +++++++++++++++++++++++---------
 include/linux/kernel_read_file.h |  8 ++++----
 security/integrity/digsig.c      |  2 +-
 security/integrity/ima/ima_fs.c  |  2 +-
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index dc28a8def597..e21a76001fff 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -5,15 +5,31 @@
 #include <linux/security.h>
 #include <linux/vmalloc.h>
 
+/**
+ * kernel_read_file() - read file contents into a kernel buffer
+ *
+ * @file	file to read from
+ * @buf		pointer to a "void *" buffer for reading into (if
+ *		*@buf is NULL, a buffer will be allocated, and
+ *		@buf_size will be ignored)
+ * @buf_size	size of buf, if already allocated. If @buf not
+ *		allocated, this is the largest size to allocate.
+ * @id		the kernel_read_file_id identifying the type of
+ *		file contents being read (for LSMs to examine)
+ *
+ * Returns number of bytes read (no single read will be bigger
+ * than INT_MAX), or negative on error.
+ *
+ */
 int kernel_read_file(struct file *file, void **buf,
-		     loff_t max_size, enum kernel_read_file_id id)
+		     size_t buf_size, enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
 	void *allocated = NULL;
 	int ret;
 
-	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
+	if (!S_ISREG(file_inode(file)->i_mode))
 		return -EINVAL;
 
 	ret = deny_write_access(file);
@@ -29,7 +45,7 @@ int kernel_read_file(struct file *file, void **buf,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
+	if (i_size > INT_MAX || i_size > buf_size) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -75,7 +91,7 @@ int kernel_read_file(struct file *file, void **buf,
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
 int kernel_read_file_from_path(const char *path, void **buf,
-			       loff_t max_size, enum kernel_read_file_id id)
+			       size_t buf_size, enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -87,14 +103,14 @@ int kernel_read_file_from_path(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, max_size, id);
+	ret = kernel_read_file(file, buf, buf_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
 int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t max_size,
+				      size_t buf_size,
 				      enum kernel_read_file_id id)
 {
 	struct file *file;
@@ -113,13 +129,13 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, max_size, id);
+	ret = kernel_read_file(file, buf, buf_size, id);
 	fput(file);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
+int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
@@ -128,7 +144,7 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, max_size, id);
+	ret = kernel_read_file(f.file, buf, buf_size, id);
 out:
 	fdput(f);
 	return ret;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 0ca0bdbed1bd..910039e7593e 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -36,16 +36,16 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 }
 
 int kernel_read_file(struct file *file,
-		     void **buf, loff_t max_size,
+		     void **buf, size_t buf_size,
 		     enum kernel_read_file_id id);
 int kernel_read_file_from_path(const char *path,
-			       void **buf, loff_t max_size,
+			       void **buf, size_t buf_size,
 			       enum kernel_read_file_id id);
 int kernel_read_file_from_path_initns(const char *path,
-				      void **buf, loff_t max_size,
+				      void **buf, size_t buf_size,
 				      enum kernel_read_file_id id);
 int kernel_read_file_from_fd(int fd,
-			     void **buf, loff_t max_size,
+			     void **buf, size_t buf_size,
 			     enum kernel_read_file_id id);
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 97661ffabc4e..04f779c4f5ed 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -175,7 +175,7 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	int rc;
 	key_perm_t perm;
 
-	rc = kernel_read_file_from_path(path, &data, 0,
+	rc = kernel_read_file_from_path(path, &data, INT_MAX,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 602f52717757..692b83e82edf 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -284,7 +284,7 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, 0, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, INT_MAX, READING_POLICY);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
-- 
2.25.1

