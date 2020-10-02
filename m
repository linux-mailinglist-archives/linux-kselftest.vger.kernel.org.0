Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F313428199C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgJBRjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388404AbgJBRio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8831C0613B3
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p21so1309813pju.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iS/6sG1Z4X2NGBdo1TTYRLUvbymOQKdrvWIO+/geSmU=;
        b=D85k7ABO+aDlKXNecga+ObrsZiD9SSJ+Chan4tQllXSgijtmuecq0jaN6JmfURzU+L
         4SAZYX11D7rvIpgoOAIoNHbnkfAFDQwHITHBSz8Pk6tl6XzIwnY7GWgcXA+//h99i749
         M0/wZRDSBG/053iJi6nD1TXm+S33QV9BTmovE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iS/6sG1Z4X2NGBdo1TTYRLUvbymOQKdrvWIO+/geSmU=;
        b=k5/FPCAndE1P9a8d+v+OR1YtdyVC3TTkOEqsvIeTghIePOXyCzoRE8aey8cx7jvMTU
         v30JM2WFwmf46CMioXrDWLgR3rvbrrl6K56SKw+u7hVIyyB5RAaVYGWyh3clNpSXZ+7v
         49hZQL5KFG+ZbiNPOji9WV0Q0meZ3K0DDSrVJBNwLVvsualyc0A2KXt/v0/gYVuLaPGU
         lyl8twZUEoWlvMmYEboHUVwKE51UmNXQRcCyvL3kau7WhTMTuwbp2pAG9WCkefPx9hYe
         yUlgHLSAgs84j6SV+k8JgdeQIpK/dW7m8krClz3iEoP9IqHDtTz/sT4SWgbmBwPVYXrW
         gtgg==
X-Gm-Message-State: AOAM530yV/tUk5uNjl9b34yLrtZ9quZeghSJW2QIZjhB3R7R/H3x7iAW
        9vYYXnGNmhfKEccyRmd6YyUITw==
X-Google-Smtp-Source: ABdhPJy9M0P3qffN5JZsx5TaefpHfSqkP+NCo5gHXu1SJZ9SL5f69WoQNxy2LGkHywryrC80KiB+Fw==
X-Received: by 2002:a17:90b:3444:: with SMTP id lj4mr3769724pjb.78.1601660321165;
        Fri, 02 Oct 2020 10:38:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm2224149pgg.75.2020.10.02.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/16] LSM: Add "contents" flag to kernel_read_file hook
Date:   Fri,  2 Oct 2020 10:38:23 -0700
Message-Id: <20201002173828.2099543-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As with the kernel_load_data LSM hook, add a "contents" flag to the
kernel_read_file LSM hook that indicates whether the LSM can expect
a matching call to the kernel_post_read_file LSM hook with the full
contents of the file. With the coming addition of partial file read
support for kernel_read_file*() API, the LSM will no longer be able
to always see the entire contents of a file during the read calls.

For cases where the LSM must read examine the complete file contents,
it will need to do so on its own every time the kernel_read_file
hook is called with contents=false (or reject such cases). Adjust all
existing LSMs to retain existing behavior.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/kernel_read_file.c             |  2 +-
 include/linux/ima.h               |  6 ++++--
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/lsm_hooks.h         |  3 +++
 include/linux/security.h          |  6 ++++--
 security/integrity/ima/ima_main.c | 10 +++++++++-
 security/loadpin/loadpin.c        | 14 ++++++++++++--
 security/security.c               |  7 ++++---
 security/selinux/hooks.c          |  5 +++--
 9 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 2e29c38eb4df..d73bc3fa710a 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -39,7 +39,7 @@ int kernel_read_file(struct file *file, void **buf,
 	if (ret)
 		return ret;
 
-	ret = security_kernel_read_file(file, id);
+	ret = security_kernel_read_file(file, id, true);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index af9fb8c5f16a..8fa7bcfb2da2 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -23,7 +23,8 @@ extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id, bool contents);
 extern int ima_post_load_data(char *buf, loff_t size,
 			      enum kernel_load_data_id id, char *description);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
+extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
+			 bool contents);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
@@ -92,7 +93,8 @@ static inline int ima_post_load_data(char *buf, loff_t size,
 	return 0;
 }
 
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
+static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
+				bool contents)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 83c6f1f5cc1e..d67cb3502310 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -188,7 +188,7 @@ LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
 	 enum kernel_read_file_id id, char *description)
 LSM_HOOK(int, 0, kernel_read_file, struct file *file,
-	 enum kernel_read_file_id id)
+	 enum kernel_read_file_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
 	 loff_t size, enum kernel_read_file_id id)
 LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6bb4f1a0158c..8814e3d5952d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -651,6 +651,7 @@
  *	@file contains the file structure pointing to the file being read
  *	by the kernel.
  *	@id kernel read file identifier
+ *	@contents if a subsequent @kernel_post_read_file will be called.
  *	Return 0 if permission is granted.
  * @kernel_post_read_file:
  *	Read a file specified by userspace.
@@ -659,6 +660,8 @@
  *	@buf pointer to buffer containing the file contents.
  *	@size length of the file contents.
  *	@id kernel read file identifier
+ *	This must be paired with a prior @kernel_read_file call that had
+ *	@contents set to true.
  *	Return 0 if permission is granted.
  * @task_fix_setuid:
  *	Update the module's state after setting one or more of the user
diff --git a/include/linux/security.h b/include/linux/security.h
index 51c8e4e6b7cc..bc2725491560 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -391,7 +391,8 @@ int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
 int security_kernel_post_load_data(char *buf, loff_t size,
 				   enum kernel_load_data_id id,
 				   char *description);
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			      bool contents);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
@@ -1030,7 +1031,8 @@ static inline int security_kernel_post_load_data(char *buf, loff_t size,
 }
 
 static inline int security_kernel_read_file(struct file *file,
-					    enum kernel_read_file_id id)
+					    enum kernel_read_file_id id,
+					    bool contents)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6f2b8352573a..939f53d02627 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -602,6 +602,7 @@ void ima_post_path_mknod(struct dentry *dentry)
  * ima_read_file - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
  * @read_id: caller identifier
+ * @contents: whether a subsequent call will be made to ima_post_read_file()
  *
  * Permit reading a file based on policy. The policy rules are written
  * in terms of the policy identifier.  Appraising the integrity of
@@ -609,8 +610,15 @@ void ima_post_path_mknod(struct dentry *dentry)
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
+int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
+		  bool contents)
 {
+	/* Reject all partial reads during appraisal. */
+	if (!contents) {
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			return -EACCES;
+	}
+
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
 	 * firmware being accessible to the device prior to the completion
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 28782412febb..b12f7d986b1e 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -118,11 +118,21 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	}
 }
 
-static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
+static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
+			     bool contents)
 {
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
 
+	/*
+	 * If we will not know that we'll be seeing the full contents
+	 * then we cannot trust a load will be complete and unchanged
+	 * off disk. Treat all contents=false hooks as if there were
+	 * no associated file struct.
+	 */
+	if (!contents)
+		file = NULL;
+
 	/* If the file id is excluded, ignore the pinning. */
 	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
 	    ignore_read_file_id[id]) {
@@ -179,7 +189,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 
 static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 {
-	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
+	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
diff --git a/security/security.c b/security/security.c
index 531b855826fc..a28045dc9e7f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1672,14 +1672,15 @@ int security_kernel_module_request(char *kmod_name)
 	return integrity_kernel_module_request(kmod_name);
 }
 
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			      bool contents)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_read_file, 0, file, id);
+	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
 	if (ret)
 		return ret;
-	return ima_read_file(file, id);
+	return ima_read_file(file, id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 558beee97d8d..dec654d52b68 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4003,13 +4003,14 @@ static int selinux_kernel_module_from_file(struct file *file)
 }
 
 static int selinux_kernel_read_file(struct file *file,
-				    enum kernel_read_file_id id)
+				    enum kernel_read_file_id id,
+				    bool contents)
 {
 	int rc = 0;
 
 	switch (id) {
 	case READING_MODULE:
-		rc = selinux_kernel_module_from_file(file);
+		rc = selinux_kernel_module_from_file(contents ? file : NULL);
 		break;
 	default:
 		break;
-- 
2.25.1

