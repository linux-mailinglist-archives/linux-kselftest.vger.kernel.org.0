Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FE2819C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbgJBRjv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbgJBRii (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D416FC0613B1
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o25so1250594pgm.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHyyy0ZSHaOUioCUVDRjNSsPX3gvfN1E9+TUE31KLYU=;
        b=fG7iaIi/EkiRrDp3S/3jPDCdiKVQFg4CWGQCh/JJxSzGnrmPPkXhNymzkDpt4fGY4v
         y0lVJsGJ3CaPLaR8bZuV++9JOEe/0k4lIgn/f3eOzCK7C/e4CuTLeLCGvbUaRDrzaAXo
         L+OluWT/ieOL7lGWFAIrFuCtnJhbQHJ+oEgsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHyyy0ZSHaOUioCUVDRjNSsPX3gvfN1E9+TUE31KLYU=;
        b=U4wK1EAIt5ab2cgkeiFiLUUJ3YDylbmgtTIOeLTeZX5YCeQgfrA6b+URugVidOdCZA
         fsI0eAayE4DhzD3/V2T40kYkz2NJDYnmKc4dDNKGw1yTAibAzRKl+mGqZ7uMfFQasbB0
         XtyTxIIS4JvVg+HbMwxBMPNzOMdPK3Kl+69uuWSBB4SQZBq8h802I5XPtLpdmui8063+
         hcOvdXlzUiug8TD+QkERfBrUG9cgGIBYrD5AdAzkI0e9QZ4KVd3oBFZkQUZwb9m2w9l/
         7jdj9CkV1GrrkRtq6cAGV9emDVFRhhUHD/Db6O7C2QJb5nWRd2KNblYT0M57CgiIO9VU
         GMrw==
X-Gm-Message-State: AOAM530xED7ds3ZIdDUyuWYrfgH9HBuBuyAgWrHGiQWrbELVZ6+pHr2x
        4ldY1bUmc3+OuuGeT92qMlMmwA==
X-Google-Smtp-Source: ABdhPJxmEnnWLJW5a4HJU+tTjLEjsXGykEgIGWl+0XUOfTar1+/CpbL7p/bRLg/E5PqUZSxLsj42sg==
X-Received: by 2002:a63:1016:: with SMTP id f22mr3227571pgl.226.1601660316347;
        Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8sm2169969pjm.7.2020.10.02.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        James Morris <jamorris@linux.microsoft.com>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/16] fs/kernel_read_file: Split into separate include file
Date:   Fri,  2 Oct 2020 10:38:15 -0700
Message-Id: <20201002173828.2099543-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>

Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
include file. That header gets pulled in just about everywhere
and doesn't really need functions not related to the general fs interface.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Link: https://lore.kernel.org/r/20200706232309.12010-2-scott.branden@broadcom.com
---
 drivers/base/firmware_loader/main.c |  1 +
 fs/exec.c                           |  1 +
 include/linux/fs.h                  | 38 ---------------------
 include/linux/ima.h                 |  1 +
 include/linux/kernel_read_file.h    | 51 +++++++++++++++++++++++++++++
 include/linux/security.h            |  1 +
 kernel/kexec_file.c                 |  1 +
 kernel/module.c                     |  1 +
 security/integrity/digsig.c         |  1 +
 security/integrity/ima/ima_fs.c     |  1 +
 security/integrity/ima/ima_main.c   |  1 +
 security/integrity/ima/ima_policy.c |  1 +
 security/loadpin/loadpin.c          |  1 +
 security/security.c                 |  1 +
 security/selinux/hooks.c            |  1 +
 15 files changed, 64 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/kernel_read_file.h

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b0ec2721f55d..8c6ea389afcf 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -12,6 +12,7 @@
 
 #include <linux/capability.h>
 #include <linux/device.h>
+#include <linux/kernel_read_file.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/timer.h>
diff --git a/fs/exec.c b/fs/exec.c
index 9233cd50dc4c..c454af329413 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -23,6 +23,7 @@
  * formats.
  */
 
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3fb7af12d033..0885d53afb11 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2858,44 +2858,6 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
-/* This is a list of *what* is being read, not *how* nor *where*. */
-#define __kernel_read_file_id(id) \
-	id(UNKNOWN, unknown)		\
-	id(FIRMWARE, firmware)		\
-	id(MODULE, kernel-module)		\
-	id(KEXEC_IMAGE, kexec-image)		\
-	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-	id(POLICY, security-policy)		\
-	id(X509_CERTIFICATE, x509-certificate)	\
-	id(MAX_ID, )
-
-#define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
-#define __fid_stringify(dummy, str) #str,
-
-enum kernel_read_file_id {
-	__kernel_read_file_id(__fid_enumify)
-};
-
-static const char * const kernel_read_file_str[] = {
-	__kernel_read_file_id(__fid_stringify)
-};
-
-static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
-{
-	if ((unsigned)id >= READING_MAX_ID)
-		return kernel_read_file_str[READING_UNKNOWN];
-
-	return kernel_read_file_str[id];
-}
-
-extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
-			    enum kernel_read_file_id);
-extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
-				      enum kernel_read_file_id);
-extern int kernel_read_file_from_path_initns(const char *, void **, loff_t *, loff_t,
-					     enum kernel_read_file_id);
-extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
-				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index d15100de6cdd..64804f78408b 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_IMA_H
 #define _LINUX_IMA_H
 
+#include <linux/kernel_read_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
new file mode 100644
index 000000000000..78cf3d7dc835
--- /dev/null
+++ b/include/linux/kernel_read_file.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KERNEL_READ_FILE_H
+#define _LINUX_KERNEL_READ_FILE_H
+
+#include <linux/file.h>
+#include <linux/types.h>
+
+/* This is a list of *what* is being read, not *how* nor *where*. */
+#define __kernel_read_file_id(id) \
+	id(UNKNOWN, unknown)		\
+	id(FIRMWARE, firmware)		\
+	id(MODULE, kernel-module)		\
+	id(KEXEC_IMAGE, kexec-image)		\
+	id(KEXEC_INITRAMFS, kexec-initramfs)	\
+	id(POLICY, security-policy)		\
+	id(X509_CERTIFICATE, x509-certificate)	\
+	id(MAX_ID, )
+
+#define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
+#define __fid_stringify(dummy, str) #str,
+
+enum kernel_read_file_id {
+	__kernel_read_file_id(__fid_enumify)
+};
+
+static const char * const kernel_read_file_str[] = {
+	__kernel_read_file_id(__fid_stringify)
+};
+
+static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
+{
+	if ((unsigned int)id >= READING_MAX_ID)
+		return kernel_read_file_str[READING_UNKNOWN];
+
+	return kernel_read_file_str[id];
+}
+
+int kernel_read_file(struct file *file,
+		     void **buf, loff_t *size, loff_t max_size,
+		     enum kernel_read_file_id id);
+int kernel_read_file_from_path(const char *path,
+			       void **buf, loff_t *size, loff_t max_size,
+			       enum kernel_read_file_id id);
+int kernel_read_file_from_path_initns(const char *path,
+				      void **buf, loff_t *size, loff_t max_size,
+				      enum kernel_read_file_id id);
+int kernel_read_file_from_fd(int fd,
+			     void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id);
+
+#endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 0a0a03b36a3b..42df0d9b4c37 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -23,6 +23,7 @@
 #ifndef __LINUX_SECURITY_H
 #define __LINUX_SECURITY_H
 
+#include <linux/kernel_read_file.h>
 #include <linux/key.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a61..1cc82557f4c1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
diff --git a/kernel/module.c b/kernel/module.c
index b2808acac46b..4218abd272ee 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index ac02b7632353..f8869be45d8f 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
+#include <linux/kernel_read_file.h>
 #include <linux/key-type.h>
 #include <linux/digsig.h>
 #include <linux/vmalloc.h>
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 15a44c5022f7..e13ffece3726 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/fcntl.h>
+#include <linux/kernel_read_file.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2f187784c5bc..5f89970c5ab7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
+#include <linux/kernel_read_file.h>
 #include <linux/mount.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b4de33074b37..3b0b43e18ecf 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -9,6 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/kernel_read_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/magic.h>
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 670a1aebb8a1..163c48216d13 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mount.h>
 #include <linux/blkdev.h>
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..19d3150f68f4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
 #include <linux/integrity.h>
 #include <linux/ima.h>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a340986aa92e..96f5f8b3b9f0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/kd.h>
 #include <linux/kernel.h>
+#include <linux/kernel_read_file.h>
 #include <linux/tracehook.h>
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
-- 
2.25.1

