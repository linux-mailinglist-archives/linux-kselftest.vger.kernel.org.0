Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FF2644797
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiLFPHp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiLFPGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1402F383
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 07:03:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so14209760pli.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP30KXKl/PR6YPpKgU+DDNG5UwR2kZxBVDTlEl1cNxU=;
        b=HPjs8mheLAahBm8OUAn4PnD0Mw9299JNdm/Ya3WP81eG9XgGqqNUb1NxHROe4uAzpa
         pxH4GbCDjdsUHJZFXJDWpAGkq0hfWPstAQ4vbO8Nd7CmrtGPKaiK0LCfcK9X8GCoRloL
         pYH55QtHDsWGwxU98YexyagX1ikk0x6JAHEyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP30KXKl/PR6YPpKgU+DDNG5UwR2kZxBVDTlEl1cNxU=;
        b=UG00bucSIuOIKVVYzIPQ+72kD/KidV3MQchJZxq6dSmkVx3nUGU4JyNR388syVcebv
         MTBgWSqQ3eeadZDYY1qyRZt/VJIbUUIlZ9UISUWiZ5xLvHUd8yygXHIboksJUw3/5NFl
         LhMhTD0hYotANJQdsxUyuteXZK7N/xolQb9EZqiCLz0t070+ljahnLJKE5hMMMoTqB6f
         t9fI45KmTlxt0D675US8m4Ol4Gy/SlEpYpQxBPEDHMvZuFxQhU2EHfE12bi9rErDd01f
         eF0W/reMzgKwxZLjMkDVsteobvRryCB2emuEUEdpD8OZ5GpeUexIdFvRQLX/4+BETgEx
         aWVA==
X-Gm-Message-State: ANoB5pnyMPvmpdIu4J03MBxVEqOz/BbOLbuePX4DJaUKXaPoAEfDCeNL
        /NhANAMXUslDnyHnvN/+XM2GWQ==
X-Google-Smtp-Source: AA0mqf6IKN3LZHIUjL7BHnLwCPmED6KHQZ9tjiZ4ffklorTZcvYizCxxLPNGz7/31lHRh1As5QqOWA==
X-Received: by 2002:a17:90a:13c4:b0:219:e3de:53e3 with SMTP id s4-20020a17090a13c400b00219e3de53e3mr7665466pjf.87.1670338978111;
        Tue, 06 Dec 2022 07:02:58 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3343019pfu.61.2022.12.06.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:02:57 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 6/6] mm/memfd: security hook for memfd_create
Date:   Tue,  6 Dec 2022 15:02:33 +0000
Message-Id: <20221206150233.1963717-7-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206150233.1963717-1-jeffxu@google.com>
References: <20221206150233.1963717-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

The new security_memfd_create allows lsm to check flags of
memfd_create.

The security by default system (such as chromeos) can use this
to implement system wide lsm to allow only non-executable memfd
being created.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
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

