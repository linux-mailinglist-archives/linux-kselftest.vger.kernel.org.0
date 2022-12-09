Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224B2648627
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLIQFc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Dec 2022 11:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLIQFY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Dec 2022 11:05:24 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE07D089
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Dec 2022 08:05:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w37so3822835pga.5
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Dec 2022 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO2vEZu0Db7wP8hwByIkT/4WBK5RsSRu/0g8CrsVk0Q=;
        b=Nz9hhcL5VUT1DNeWW7Mvl2m+8tMK4KUW9ZM63sJBU7BZC5BXcP0QrGhhfixxQYFJr6
         jaW0mxnuLY9YKm9/eIJoGL3j7a2Nnz/LO5wqZBulnXeLBCJR0YvayQPJuPVgnkWRqUzs
         VIPCWg63G260HdzCt34cupUwQj6+eayz1j76w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO2vEZu0Db7wP8hwByIkT/4WBK5RsSRu/0g8CrsVk0Q=;
        b=sKkFEnwEz3eJ7zWsxRaU6So5mH5CyaT0AKuqnZUIFs75evZcEKrMatTJF5UONsUrM5
         POJjpFkTV2Cy545GMYutSMyy4b+hr3FaK3H5sfAfG4GYdhEBG4gKf7jT7/hinRuHoWcO
         jwbfvvYm69xe4l7fshrJTARKSbvQgOHODiNY7d6jhH7xZTqhERLmnWqFVnhnaYDq5vaW
         wYrTkuybVbW7sf7qRlmvLX+VMTDxxoBOYCLsQgjpagbw6WMvugpWJsiH8a2P+3Cj7PPJ
         yA9MXdSuaP5WBCQ8jXRZ4ZfoATQ+d6QZzq7yy3HLLP6UK/SkJlqHA0HvO3RpmRPKjQnX
         q+bw==
X-Gm-Message-State: ANoB5pnC1wKNxc93iXpH2BQBlVmSlCaoVVwxcT9slkZwiCHrXYa2Fb7C
        NH9sh9/vfiHh/d8Z0Zt3hDrcSA==
X-Google-Smtp-Source: AA0mqf4lfbpdBsIBddA74mG397/PLLPHeHkEdS4bVrJWMAdItf41izLMuA+5lLn6aq2S10oXpsQr3A==
X-Received: by 2002:aa7:858a:0:b0:575:de28:b1f4 with SMTP id w10-20020aa7858a000000b00575de28b1f4mr5165976pfn.16.1670601905655;
        Fri, 09 Dec 2022 08:05:05 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b00576670cc170sm1460504pfk.93.2022.12.09.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:05:05 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
Date:   Fri,  9 Dec 2022 16:04:53 +0000
Message-Id: <20221209160453.3246150-7-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
References: <20221209160453.3246150-1-jeffxu@google.com>
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
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 6 ++++++
 mm/memfd.c                    | 5 +++++
 security/security.c           | 5 +++++
 5 files changed, 21 insertions(+)

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
index 79d82cb6e469..57788cf94075 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1010,6 +1010,11 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
+int security_memfd_create(char *name, unsigned int flags)
+{
+	return call_int_hook(memfd_create, 0, name, flags);
+}
+
 int security_move_mount(const struct path *from_path, const struct path *to_path)
 {
 	return call_int_hook(move_mount, 0, from_path, to_path);
-- 
2.39.0.rc1.256.g54fd8350bd-goog

