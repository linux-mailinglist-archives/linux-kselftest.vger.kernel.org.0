Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2742B1B11D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDTQkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726608AbgDTQkJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E82C03C1A6
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 09:28:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so244252wmh.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fgv/fcDXTDFVmuGXIXdyLKuOfq35HUlELweudxMRWMs=;
        b=VFFAf7TaByt79/td+R9MQq1SqtoZXDKAOcTDMlWkG1L1PLw21xv8HLgDBNcQSWfiWA
         HnR9FC+IQkFnUxqKUgCHD1MYjYHWoKAFe+8oJyLPyBsTop34P2Y8KSK5GVCcxer5UW3k
         fZ9KICtnOPYcpsjmZwL2+eg7RGK8PhuodgzDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fgv/fcDXTDFVmuGXIXdyLKuOfq35HUlELweudxMRWMs=;
        b=i6t1zBeMsDyaiT9+c157y/ytJoWti2hy5a+G20D8kVyd06t47IuEqbClCFN+zaGk86
         L2UzVMR5ISdAlRGOgrN8ApuljyZFMD3bh3vFltMNmAuUCepHzQiLf9egh0VZ8DFt0VAu
         anm4hL8OKqCj1yt4Xf+rjYLx54u3DSOvhlGUmZuBjx1UciQBTKyVqMoTlsPh7j6w8zZH
         Dw8mEAGytuTyeAJsAwSw5nchxzf5RreCcglfU7XeagCIbaScJydnzuEPJXBqwgGd3dCs
         20DGL6S+cp5YaM1ybLOYKawuuZyYdPGDYNajL2hUbyQdjz4iE/Y1D/bgMpJdIuTpvM0d
         tGKw==
X-Gm-Message-State: AGi0PuZ4GUdhex8ptdVn+X1GFck6SoXqjq3ndOjClk10fwNqjm1Qh98v
        E0CINILd8mYMgGXmydLNMc5neg==
X-Google-Smtp-Source: APiQypK54LoI/e+Xjtzwms/1bdMv5dH25Ef90yEMFICK8CuHWpZ4R0pd0wAO9Mbj/lDwRrWoagoxkg==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr167789wmm.104.1587400114304;
        Mon, 20 Apr 2020 09:28:34 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 36sm14882wrc.35.2020.04.20.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:28:33 -0700 (PDT)
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
Subject: [PATCH v3 1/7] fs: introduce kernel_pread_file* support
Date:   Mon, 20 Apr 2020 09:28:03 -0700
Message-Id: <20200420162809.17529-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420162809.17529-1-scott.branden@broadcom.com>
References: <20200420162809.17529-1-scott.branden@broadcom.com>
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
 fs/exec.c          | 96 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h | 20 ++++++++++
 2 files changed, 95 insertions(+), 21 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..cfab212fab9d 100644
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
@@ -979,15 +1005,25 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
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
 
-int kernel_read_file_from_path_initns(const char *path, void **buf,
-				      loff_t *size, loff_t max_size,
-				      enum kernel_read_file_id id)
+extern int kernel_pread_file_from_path_initns(const char *path, void **buf,
+					      loff_t *size, loff_t pos,
+					      loff_t max_size,
+					      unsigned int flags,
+					      enum kernel_read_file_id id)
 {
 	struct file *file;
 	struct path root;
@@ -1005,14 +1041,24 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, pos, max_size, flags, id);
 	fput(file);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file_from_path_initns);
+
+int kernel_read_file_from_path_initns(const char *path, void **buf,
+				      loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path_initns(path, buf, size, 0, max_size,
+						  KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size, loff_t pos,
+			      loff_t max_size, unsigned int flags,
+			      enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
@@ -1020,11 +1066,19 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
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
index 4f6f59b4f22a..03441fbcad6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3014,12 +3014,32 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
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
+extern int kernel_pread_file_from_path_initns(const char *path, void **buf,
+					      loff_t *size, loff_t pos,
+					      loff_t max_size,
+					      unsigned int flags,
+					      enum kernel_read_file_id id);
 extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
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

