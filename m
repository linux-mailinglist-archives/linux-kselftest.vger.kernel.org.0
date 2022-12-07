Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEA645DF0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGPt4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 10:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLGPtv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215B5BD4F
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 07:49:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cm20so18004644pjb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 07:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=br+NzT6Ekl7un/bONAJTTP+zVNWLoPX0fUe5M313tYk=;
        b=KveNxSwrAsaP96yq/2ARVH0FCPenY0jXv1lv5clhnkzL7NYz4dsA1XuERs7Zl08c5t
         8vCBKRTn59G+ilGEelru03ZLrBZQfDmbySTIZfw8NCC1D/7Z0wESKY45SOkudNKxEzZ8
         +FtkzZYTl3DL+21FEiiiK6YesMBG9HrOrbn8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=br+NzT6Ekl7un/bONAJTTP+zVNWLoPX0fUe5M313tYk=;
        b=bHaKQc9MlqgekUrNuraLn9qgTK6Bz/XR6eAXYDb//t/xRW1xT97kUxiyEl62wIi9uf
         DDjp6vZboPuqcgtIw3HveH8gVi7uq0byoBek3WjqpHnabve8VMz08G8CFbnA4Ykk0c6C
         FHMnbRThMpMA67BfgDBRdPSqJFFplgqNjL1w05bfLhD1m8AOqWvt6AA30f/+qwRwz5cg
         PK0/zmi9Ixiv6raFPf1lOqS+lTgHqhJE1D/1Dm5joY9yH2KeVeZWQmkgt4hE7/FR/WS9
         yPhRbykRQZgFnGeMa1TiqD0YHlsY7srN4lNqKuvma75XPpJsioF6o7TSHP7RflpeKlYo
         ehjQ==
X-Gm-Message-State: ANoB5pniaNozWyfIyp4qbAeJ2zuvLHgEQecETQh4tHt2vmkgPyLCBbZC
        94p10az6Zo7EuQWQkTjLcrVtIQ==
X-Google-Smtp-Source: AA0mqf57dGN3HP5pxzO/6ZrtWfZYkkrlIG8JgxnnEiR9bTT2jaGtlpyPcPbFFAjo3seHVll29EA/mQ==
X-Received: by 2002:a17:902:b611:b0:188:f570:7bdf with SMTP id b17-20020a170902b61100b00188f5707bdfmr682078pls.40.1670428190523;
        Wed, 07 Dec 2022 07:49:50 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017f7628cbddsm14920934plh.30.2022.12.07.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:49:49 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 6/6] mm/memfd: security hook for memfd_create
Date:   Wed,  7 Dec 2022 15:49:39 +0000
Message-Id: <20221207154939.2532830-7-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221207154939.2532830-1-jeffxu@google.com>
References: <20221207154939.2532830-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

The new security_memfd_create allows lsm to check flags of
memfd_create.

The security by default system (such as chromeos) can use this
to implement system wide lsm to allow only non-executable memfd
being created.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  4 ++++
 include/linux/security.h      |  6 ++++++
 mm/memfd.c                    |  5 +++++
 security/security.c           | 13 +++++++++++++
 5 files changed, 29 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ec119da1d89b..fd40840927c8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
+LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e..5a18a6552278 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -543,6 +543,10 @@
  *	simple integer value.  When @arg represents a user space pointer, it
  *	should never be used by the security module.
  *	Return 0 if permission is granted.
+ * @memfd_create:
+ *	@name is the name of memfd file.
+ *	@flags is the flags used in memfd_create.
+ *	Return 0 if permission is granted.
  * @mmap_addr :
  *	Check permissions for a mmap operation at @addr.
  *	@addr contains virtual address that will be used for the operation.
diff --git a/include/linux/security.h b/include/linux/security.h
index ca1b7109c0db..5b87a780822a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_memfd_create(char *name, unsigned int flags);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_memfd_create(char *name, unsigned int flags)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
 {
diff --git a/mm/memfd.c b/mm/memfd.c
index 92f0a5765f7c..f04ed5f0474f 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -356,6 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
 		goto err_name;
 	}
 
+	/* security hook for memfd_create */
+	error = security_memfd_create(name, flags);
+	if (error)
+		return error;
+
 	if (flags & MFD_HUGETLB) {
 		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
 					HUGETLB_ANONHUGE_INODE,
diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..5c018e080923 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1010,6 +1010,19 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
+int security_add_mnt_opt(const char *option, const char *val, int len,
+			 void **mnt_opts)
+{
+	return call_int_hook(sb_add_mnt_opt, -EINVAL,
+					option, val, len, mnt_opts);
+}
+EXPORT_SYMBOL(security_add_mnt_opt);
+
+int security_memfd_create(char *name, unsigned int flags)
+{
+	return call_int_hook(memfd_create, 0, name, flags);
+}
+
 int security_move_mount(const struct path *from_path, const struct path *to_path)
 {
 	return call_int_hook(move_mount, 0, from_path, to_path);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

