Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB0C2819B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbgJBRj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbgJBRij (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5478EC0613D0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j19so1295851pjl.4
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/K2vbxHcCuzbq3sjR/rWmD4bsCHJIDz9hKxoTonXhFg=;
        b=EkUakFPirgEHphE/CEdYgZkBHLqYceFOyCHe3YH7O10Zem/lCGVTtu9aintmXEdVo4
         pMndBgaEY+25nAsHg1htLqHnRaBRZMLpIUDDn5A1pixBLvYZy82uhczmVeDj624bUWQN
         KY1wJyq61ozMyNOToiXb+MuyOxbNzLECOBDAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/K2vbxHcCuzbq3sjR/rWmD4bsCHJIDz9hKxoTonXhFg=;
        b=C6zQd3UhQn0c6QkUhWxIQ3AW/HrhcTG/5Nw/JotomZILaRNiZ2HTzZEceRKOwkPe8/
         y7m9C3swKB9CoeQSwRISniRQibuFSbwmJVZH2ybcDzG3qOoWIN6pO0AXEk4QnNlFeizd
         Vvv/wqfpWhi9mQKni1wTlyt0/K1+kLBwh986nhxXOjKI7s/1Z9Zd0IXZ6nly7LkvQAJ2
         1CPK7lksagftG9T1HV9slGks1O2LmP/oMlzt/5+EHfuf5s/DFfztfmuH4N5h9TmZ5Db1
         YMJ3LFU+aL7Z42kGYBNpy+qgp/vaNkmbKQen4OM+ItpT8osDRQDgaD4jqTMhmFNkDLmm
         8TaA==
X-Gm-Message-State: AOAM531PmDL0CMxBinqEeBiAA3gL3qIKaCWGbC3V4IJAUzdnS68vRsr/
        NZ8fIS54bRE+7mWEEAwJHdUfWw==
X-Google-Smtp-Source: ABdhPJwTjniVf2r8bEN3g+i0of7d1egPqTtv99FQjZYsLi51YRUppoZHrbkE8DsRbwK8KxmxQdJI8w==
X-Received: by 2002:a17:90b:104f:: with SMTP id gq15mr3803958pjb.215.1601660318833;
        Fri, 02 Oct 2020 10:38:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm2580343pfi.169.2020.10.02.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@google.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/16] LSM: Introduce kernel_post_load_data() hook
Date:   Fri,  2 Oct 2020 10:38:20 -0700
Message-Id: <20201002173828.2099543-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are a few places in the kernel where LSMs would like to have
visibility into the contents of a kernel buffer that has been loaded or
read. While security_kernel_post_read_file() (which includes the
buffer) exists as a pairing for security_kernel_read_file(), no such
hook exists to pair with security_kernel_load_data().

Earlier proposals for just using security_kernel_post_read_file() with a
NULL file argument were rejected (i.e. "file" should always be valid for
the security_..._file hooks, but it appears at least one case was
left in the kernel during earlier refactoring. (This will be fixed in
a subsequent patch.)

Since not all cases of security_kernel_load_data() can have a single
contiguous buffer made available to the LSM hook (e.g. kexec image
segments are separately loaded), there needs to be a way for the LSM to
reason about its expectations of the hook coverage. In order to handle
this, add a "contents" argument to the "kernel_load_data" hook that
indicates if the newly added "kernel_post_load_data" hook will be called
with the full contents once loaded. That way, LSMs requiring full contents
can choose to unilaterally reject "kernel_load_data" with contents=false
(which is effectively the existing hook coverage), but when contents=true
they can allow it and later evaluate the "kernel_post_load_data" hook
once the buffer is loaded.

With this change, LSMs can gain coverage over non-file-backed data loads
(e.g. init_module(2) and firmware userspace helper), which will happen
in subsequent patches.

Additionally prepare IMA to start processing these cases.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: KP Singh <kpsingh@google.com>
---
 drivers/base/firmware_loader/fallback.c       |  2 +-
 .../base/firmware_loader/fallback_platform.c  |  2 +-
 include/linux/ima.h                           | 13 ++++++++--
 include/linux/lsm_hook_defs.h                 |  4 +++-
 include/linux/lsm_hooks.h                     | 10 ++++++++
 include/linux/security.h                      | 14 +++++++++--
 kernel/kexec.c                                |  2 +-
 kernel/module.c                               |  2 +-
 security/integrity/ima/ima_main.c             | 24 ++++++++++++++++++-
 security/loadpin/loadpin.c                    |  2 +-
 security/security.c                           | 20 +++++++++++++---
 security/selinux/hooks.c                      |  2 +-
 12 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 283ca2de76d4..bff4717cc6b5 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -613,7 +613,7 @@ static bool fw_run_sysfs_fallback(u32 opt_flags)
 		return false;
 
 	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
-	ret = security_kernel_load_data(LOADING_FIRMWARE);
+	ret = security_kernel_load_data(LOADING_FIRMWARE, false);
 	if (ret < 0)
 		return false;
 
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 6958ab1a8059..a12c79d47efc 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE);
+	rc = security_kernel_load_data(LOADING_FIRMWARE, false);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 64804f78408b..af9fb8c5f16a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -20,7 +20,9 @@ extern void ima_post_create_tmpfile(struct inode *inode);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
-extern int ima_load_data(enum kernel_load_data_id id);
+extern int ima_load_data(enum kernel_load_data_id id, bool contents);
+extern int ima_post_load_data(char *buf, loff_t size,
+			      enum kernel_load_data_id id, char *description);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
@@ -78,7 +80,14 @@ static inline int ima_file_mprotect(struct vm_area_struct *vma,
 	return 0;
 }
 
-static inline int ima_load_data(enum kernel_load_data_id id)
+static inline int ima_load_data(enum kernel_load_data_id id, bool contents)
+{
+	return 0;
+}
+
+static inline int ima_post_load_data(char *buf, loff_t size,
+				     enum kernel_load_data_id id,
+				     char *description)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2a8c74d99015..83c6f1f5cc1e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -184,7 +184,9 @@ LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
 LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
 LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
 LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
-LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id)
+LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
+LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
+	 enum kernel_read_file_id id, char *description)
 LSM_HOOK(int, 0, kernel_read_file, struct file *file,
 	 enum kernel_read_file_id id)
 LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9e2e3e63719d..6bb4f1a0158c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -635,7 +635,17 @@
  * @kernel_load_data:
  *	Load data provided by userspace.
  *	@id kernel load data identifier
+ *	@contents if a subsequent @kernel_post_load_data will be called.
  *	Return 0 if permission is granted.
+ * @kernel_post_load_data:
+ *	Load data provided by a non-file source (usually userspace buffer).
+ *	@buf pointer to buffer containing the data contents.
+ *	@size length of the data contents.
+ *	@id kernel load data identifier
+ *	@description a text description of what was loaded, @id-specific
+ *	Return 0 if permission is granted.
+ *	This must be paired with a prior @kernel_load_data call that had
+ *	@contents set to true.
  * @kernel_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
diff --git a/include/linux/security.h b/include/linux/security.h
index 42df0d9b4c37..51c8e4e6b7cc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -387,7 +387,10 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
-int security_kernel_load_data(enum kernel_load_data_id id);
+int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
+int security_kernel_post_load_data(char *buf, loff_t size,
+				   enum kernel_load_data_id id,
+				   char *description);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
@@ -1014,7 +1017,14 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
-static inline int security_kernel_load_data(enum kernel_load_data_id id)
+static inline int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
+{
+	return 0;
+}
+
+static inline int security_kernel_post_load_data(char *buf, loff_t size,
+						 enum kernel_load_data_id id,
+						 char *description)
 {
 	return 0;
 }
diff --git a/kernel/kexec.c b/kernel/kexec.c
index f977786fe498..c82c6c06f051 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -205,7 +205,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
 		return -EPERM;
 
 	/* Permit LSMs and IMA to fail the kexec */
-	result = security_kernel_load_data(LOADING_KEXEC_IMAGE);
+	result = security_kernel_load_data(LOADING_KEXEC_IMAGE, false);
 	if (result < 0)
 		return result;
 
diff --git a/kernel/module.c b/kernel/module.c
index 0f11eaed047e..f47209e0fde6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3014,7 +3014,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE);
+	err = security_kernel_load_data(LOADING_MODULE, false);
 	if (err)
 		return err;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5f89970c5ab7..9dd9c5f4d736 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -676,6 +676,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 /**
  * ima_load_data - appraise decision based on policy
  * @id: kernel load data caller identifier
+ * @contents: whether the full contents will be available in a later
+ *	      call to ima_post_load_data().
  *
  * Callers of this LSM hook can not measure, appraise, or audit the
  * data provided by userspace.  Enforce policy rules requring a file
@@ -683,7 +685,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_load_data(enum kernel_load_data_id id)
+int ima_load_data(enum kernel_load_data_id id, bool contents)
 {
 	bool ima_enforce, sig_enforce;
 
@@ -723,6 +725,26 @@ int ima_load_data(enum kernel_load_data_id id)
 	return 0;
 }
 
+/**
+ * ima_post_load_data - appraise decision based on policy
+ * @buf: pointer to in memory file contents
+ * @size: size of in memory file contents
+ * @id: kernel load data caller identifier
+ * @description: @id-specific description of contents
+ *
+ * Measure/appraise/audit in memory buffer based on policy.  Policy rules
+ * are written in terms of a policy identifier.
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+int ima_post_load_data(char *buf, loff_t size,
+		       enum kernel_load_data_id load_id,
+		       char *description)
+{
+	return 0;
+}
+
 /*
  * process_buffer_measurement - Measure the buffer to ima log.
  * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 163c48216d13..28782412febb 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -177,7 +177,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	return 0;
 }
 
-static int loadpin_load_data(enum kernel_load_data_id id)
+static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 {
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
 }
diff --git a/security/security.c b/security/security.c
index 19d3150f68f4..531b855826fc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1695,17 +1695,31 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
-int security_kernel_load_data(enum kernel_load_data_id id)
+int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_load_data, 0, id);
+	ret = call_int_hook(kernel_load_data, 0, id, contents);
 	if (ret)
 		return ret;
-	return ima_load_data(id);
+	return ima_load_data(id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_load_data);
 
+int security_kernel_post_load_data(char *buf, loff_t size,
+				   enum kernel_load_data_id id,
+				   char *description)
+{
+	int ret;
+
+	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
+			    description);
+	if (ret)
+		return ret;
+	return ima_post_load_data(buf, size, id, description);
+}
+EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
+
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 96f5f8b3b9f0..558beee97d8d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4018,7 +4018,7 @@ static int selinux_kernel_read_file(struct file *file,
 	return rc;
 }
 
-static int selinux_kernel_load_data(enum kernel_load_data_id id)
+static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int rc = 0;
 
-- 
2.25.1

