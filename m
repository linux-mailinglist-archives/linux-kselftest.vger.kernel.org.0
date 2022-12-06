Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D396447EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 16:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiLFPYO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 10:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiLFPYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 10:24:09 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DCE9FC4
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 07:24:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d3so14233449plr.10
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 07:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP30KXKl/PR6YPpKgU+DDNG5UwR2kZxBVDTlEl1cNxU=;
        b=fmR1lznJtSVRR9L4Ia3CMGkwAZ2v4hkWoOPZm7PR1nH/3nuAorOgqKoWJuydk4wqi1
         4Jv46XmZFzLlrkx7ctSkFgyRoHoerAtS2sX3lfOp8Jl6EZM58L/vapg/v4JYZQWR5omU
         taxuDneZ5WG7Y4370lPtuckGfA3P8kfdDM44o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP30KXKl/PR6YPpKgU+DDNG5UwR2kZxBVDTlEl1cNxU=;
        b=DKJZr/kYTbT61Q5xkPzZcqa95nXbqb7moFhlCehIPNZAxxMxYu5xmH4fvR/cLFLnZG
         xk1iLjMCJQmpbNYEYU0GBE+EqOjswZqnOHK54A+4GMV7/L0bsLBlA/NKtPLqQYF8rV3c
         2dW2mqEVg3raGSxEhCGE1bbsc1k8gMd9N2H3Hb7h0Pbp0QttZae0dnKoL0VpVTESYDZP
         HWl3StYxnyynP4N2VtHSBCI+H2gD17CgHKHfM7JTG3+LPXp5Gvjonpsp/vp0x3AJhUYT
         Ogek1Qr6gcB/DcA7aVoD8cjnVCndRfiAXWgAMcpXCV1Yk3BE7YhhBYx5HCA6anP8pSZY
         D3IQ==
X-Gm-Message-State: ANoB5pmDihn5WNcqkrMreJaocBCU19OYZBl20U1tIKqGsfzO78vjC8pH
        rrm5e9r9oQVG5eus/1MlZgsCUg==
X-Google-Smtp-Source: AA0mqf6EhFnYhQ5JfLUH2vxmtsq3k5PjP/AHU5doy5X0JZFulMFt5fVeH5kDyg6mfzg+AZ9j8VWMyw==
X-Received: by 2002:a17:902:7898:b0:188:584d:b6d4 with SMTP id q24-20020a170902789800b00188584db6d4mr70697461pll.170.1670340248607;
        Tue, 06 Dec 2022 07:24:08 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id r25-20020a635d19000000b0046b1dabf9a8sm10004686pgb.70.2022.12.06.07.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:24:07 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 6/6] mm/memfd: security hook for memfd_create
Date:   Tue,  6 Dec 2022 15:23:58 +0000
Message-Id: <20221206152358.1966099-7-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206152358.1966099-1-jeffxu@google.com>
References: <20221206152358.1966099-1-jeffxu@google.com>
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

