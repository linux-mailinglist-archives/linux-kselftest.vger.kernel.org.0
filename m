Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED7E1653C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 01:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgBTAsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 19:48:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40626 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTAsn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 19:48:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so819525plp.7
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2020 16:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PHpWXDTr6jV3C6iif6ncq7QaqfD+p0zDkr8t4LK8n2s=;
        b=UnfLCt7ZI/LJPiv9la+HUHVPOpCLsb/8lDB2QgzW6boVkAlLW+/1Ut8WR1iKRJNs8C
         NNQxZ58srqExB9/lyLJyw6dh2bf5K4xPkcaRAiZMiSSBm4f6NXAWtckrDh4WTd0rhT6l
         pE3zSEcxU0LMdxdTUfRoggIole3Vnwr9A+8iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PHpWXDTr6jV3C6iif6ncq7QaqfD+p0zDkr8t4LK8n2s=;
        b=H7YR3tPWB/yQ7I3YUbnONQsF1CIfpGEOWfeLgj1JFTnXZ5Jp6NSozKO8NQGP0QMfg6
         3hH8uxcfYyiqogyVNHDlcx84aVKsFSLVspjzZDwntWuRoUAMQn99XeDRnwPAG8LEV2OE
         KRZKyUDEU6QIK0ejMECCaqmzou1+5WaQXwPyOOQiDcO2Fn+kocM9PJD30azBGrzVEZHH
         1uCbic0M9I9tlHBUiGrZIdu2kQokFWPIQ/16U1TKzZZpgWwcZIAG+YU9PGa1VEImfQqR
         tFG7TpqZgsrImJbstMTmacAoBGDg4SEqYbH88yyeV7rjVlfdTHARV/XVNDeByo6lzl9x
         64rw==
X-Gm-Message-State: APjAAAUpau7ntF0P1DcsERBhiAj5kFP0IOUH1ANTu/O7YKu8U7rUSOtS
        M/hdAgDZ/pLfEbRXtW0PyMA5xQ==
X-Google-Smtp-Source: APXvYqwhgQGV8EyCQ5SA5mMgL1SQvdvjfoEgsElbBa8yRQQTse48LbXHxD4FJEf0ZLtID3TTzCbAvA==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr28970318pls.258.1582159722265;
        Wed, 19 Feb 2020 16:48:42 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 64sm816323pfd.48.2020.02.19.16.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:41 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 1/7] fs: introduce kernel_pread_file* support
Date:   Wed, 19 Feb 2020 16:48:19 -0800
Message-Id: <20200220004825.23372-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220004825.23372-1-scott.branden@broadcom.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kernel_pread_file* support to kernel to allow for partial read
of files with an offset into the file.  Existing kernel_read_file
functions call new kernel_pread_file functions with offset=0 and
flags=KERNEL_PREAD_FLAG_WHOLE.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c          | 77 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h | 15 +++++++++
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index db17be51b112..a38f8fb432fa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -896,10 +896,14 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t pos, loff_t max_size, unsigned int flags,
+		      enum kernel_read_file_id id)
+{
+	loff_t alloc_size;
+	loff_t buf_pos;
+	loff_t read_end;
+	loff_t i_size;
 	ssize_t bytes = 0;
 	int ret;
 
@@ -919,21 +923,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+
+	/* Default read to end of file */
+	read_end = i_size;
+
+	/* Allow reading partial portion of file */
+	if ((flags & KERNEL_PREAD_FLAG_PART) &&
+	    (i_size > (pos + max_size)))
+		read_end = pos + max_size;
+
+	alloc_size = read_end - pos;
+	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
 
 	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
+		*buf = vmalloc(alloc_size);
 	if (!*buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+	buf_pos = 0;
+	while (pos < read_end) {
+		bytes = kernel_read(file, *buf + buf_pos, read_end - pos, &pos);
 		if (bytes < 0) {
 			ret = bytes;
 			goto out_free;
@@ -941,14 +955,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 		if (bytes == 0)
 			break;
+
+		buf_pos += bytes;
 	}
 
-	if (pos != i_size) {
+	if (pos != read_end) {
 		ret = -EIO;
 		goto out_free;
 	}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
 	if (!ret)
 		*size = pos;
 
@@ -964,10 +980,20 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file);
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file(file, buf, size, 0, max_size,
+				 KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size, loff_t pos,
+				loff_t max_size, unsigned int flags,
+				enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -979,14 +1005,23 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, pos, max_size, flags, id);
 	fput(file);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file_from_path);
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path(path, buf, size, 0, max_size,
+					   KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size, loff_t pos,
+			      loff_t max_size, unsigned int flags,
+			      enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
@@ -994,11 +1029,19 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_pread_file(f.file, buf, size, pos, max_size, flags, id);
 out:
 	fdput(f);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file_from_fd);
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_fd(fd, buf, size, 0, max_size,
+					 KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..8f39530cfcc2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3008,10 +3008,25 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
+/* Flags used by kernel_pread_file functions */
+#define KERNEL_PREAD_FLAG_WHOLE	0x0000 /* Only Allow reading of whole file */
+#define KERNEL_PREAD_FLAG_PART	0x0001 /* Allow reading part of file */
+
+extern int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+			     loff_t pos, loff_t max_size, unsigned int flags,
+			     enum kernel_read_file_id id);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
+extern int kernel_pread_file_from_path(const char *path, void **buf,
+				       loff_t *size, loff_t pos,
+				       loff_t max_size, unsigned int flags,
+				       enum kernel_read_file_id id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+extern int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+				    loff_t pos, loff_t max_size,
+				    unsigned int flags,
+				    enum kernel_read_file_id id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.17.1

