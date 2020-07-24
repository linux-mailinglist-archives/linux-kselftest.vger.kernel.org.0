Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19ED22D0CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGXVha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgGXVgy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA76C08C5FA
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so6122099pgg.10
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktfL7PCfkGNfcQML9vhQeWAuzsYDYwRwOwIVvLD1QQM=;
        b=dhMZmqitoswhDDnqhI7fqqENsRXkbi0aJkyN67q56qBaZxyj9DBtETA5izYKPenKIb
         IAA895SssUy35qnL6ISQ0OfrZJ/pgHBVZaFKKak6uYfydFaKj682mPWg7epXKZZyddZs
         T3DuVuskZpdDqDA8AgzrOiVIMVdqaSpwb9xgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktfL7PCfkGNfcQML9vhQeWAuzsYDYwRwOwIVvLD1QQM=;
        b=hLePRE+6wshirzbzT9DqpXz2TRE4bNOb6+MNAxBjjEjhhnDoiUiEx8HX2obObwCJ9W
         22XT0+TzD6xz685H7RWEOBf7bzpSktZfATrqNgTOmM9TNuF3C0JiF4uyRMVUyAm0EIvB
         WlSl29W9zDO6Z3CD7KGHr9tXkY/EDO/o0G4p40vyBVWSWTTca84AYBiZ0MB1g/abg2F2
         /RygaFX7JEXo4vDyUwBja36slszE5UZ5Y2JgMJ1vU/UMfsAWK1YTi5UOR/bfBY8FMZvt
         i8Aq2wjXs0hymZs1SWeGFJ4KaP10sDRIuwrgjLvoLgKkl2HmN9bncwWvSzLF9VRQaOto
         DHNw==
X-Gm-Message-State: AOAM533UvEsLOSZRNvkYaHxxjo3qPaifd59Gv35vpSx3KQy4hM1fMCKG
        RVuBLq3ggFQRKhdVXpNbqu54BA==
X-Google-Smtp-Source: ABdhPJxPiwOWumK7iB7em93WDvm1T9O9eKLXgdw3l3bdQUkE9TEj5aVjJXnsZbGTMOYCLVq9DZ99YA==
X-Received: by 2002:aa7:8f2a:: with SMTP id y10mr10274382pfr.182.1595626612022;
        Fri, 24 Jul 2020 14:36:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y200sm7301371pfb.33.2020.07.24.14.36.46
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
Subject: [PATCH v3 09/19] fs/kernel_read_file: Switch buffer size arg to size_t
Date:   Fri, 24 Jul 2020 14:36:30 -0700
Message-Id: <20200724213640.389191-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
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

