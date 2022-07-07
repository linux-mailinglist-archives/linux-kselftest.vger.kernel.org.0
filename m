Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833556AE89
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 00:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiGGWcu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jul 2022 18:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbiGGWck (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jul 2022 18:32:40 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812565D7F
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Jul 2022 15:32:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l81so25049223oif.9
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Jul 2022 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ze62Gr6yFI9YlZaCLh0XPJZ5QPI4eIkzUPPZ4mag1A=;
        b=Hjz2P6X2I1Fth6pZf+hGpgOQm1DMiy9L3g2o/gJ5yJGZFPSgpQkF362RzMHiiUskYa
         ngBdGQovMO2B3pfO+EpXtaDC79YUJJvDLqDr+oJrNm3GwsaNflwgOG6TSCmAD/tuwdsE
         o8CjTO+CykD3nVVlWp1MldRIv8CUqJ0r/ok6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ze62Gr6yFI9YlZaCLh0XPJZ5QPI4eIkzUPPZ4mag1A=;
        b=uyh548hjZ4vGegYgTwIWqOfVA8OKe7W54EG6zbJv3NYiUlWpc+nNXL8cRVAh9lKEBA
         4a3b9IQ4tMsZoWYu1SEvXbMdTf4dWQq14UxJZKaZwOz0Zfn7Pcv9fPMdwiHTnSriUXsh
         zc9yryFsCUN7svOku3fl0z5QTQnJo3y+eIpdEFONEmmfGccFd+aXP36IS5lf2Y1auY8e
         U8B9ROXzTw3arQb3GciRR0W6Ty+TtaZ0Xf+/OpX1LFf+MFjwJKKJuewy6EiawQqAzy+z
         2J8c0z7IvJwseGllm8cgc68OsINhDIOlntINbKElR8R5Ch1ClabF9hqGDDjV6Sx2ii/9
         ZS/A==
X-Gm-Message-State: AJIora/jJ/Cx75bwXJCwaE1mUFfj3/qYSzefdYPc0jxgo1eJzfcpPwd6
        +Fvm+MZPKhJQUX2M98/XW+zx1A==
X-Google-Smtp-Source: AGRyM1spTnHtSiohzejr09iqgEQq6SB21VULSXN2tn7SabY+Ll4UuXdWDcBCQ14/WEJipjBZIcHNCQ==
X-Received: by 2002:a54:4393:0:b0:335:cdb9:16a9 with SMTP id u19-20020a544393000000b00335cdb916a9mr157809oiv.112.1657233158219;
        Thu, 07 Jul 2022 15:32:38 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id i16-20020a05683033f000b00616b835f5e7sm16246222otu.43.2022.07.07.15.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:32:37 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v2 1/4] security, lsm: Introduce security_create_user_ns()
Date:   Thu,  7 Jul 2022 17:32:25 -0500
Message-Id: <20220707223228.1940249-2-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707223228.1940249-1-fred@cloudflare.com>
References: <20220707223228.1940249-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Preventing user namespace (privileged or otherwise) creation comes in a
few of forms in order of granularity:

        1. /proc/sys/user/max_user_namespaces sysctl
        2. OS specific patch(es)
        3. CONFIG_USER_NS

To block a task based on its attributes, the LSM hook cred_prepare is a
good candidate for use because it provides more granular control, and
it is called before create_user_ns():

        cred = prepare_creds()
                security_prepare_creds()
                        call_int_hook(cred_prepare, ...
        if (cred)
                create_user_ns(cred)

Since security_prepare_creds() is meant for LSMs to copy and prepare
credentials, access control is an unintended use of the hook. Therefore
introduce a new function security_create_user_ns() with an accompanying
create_user_ns LSM hook.

This hook takes the prepared creds for LSM authors to write policy
against. On success, the new namespace is applied to credentials,
otherwise an error is returned.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v1:
- Changed commit wording
- Moved execution to be after id mapping check
- Changed signature to only accept a const struct cred *
---
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 6 ++++++
 kernel/user_namespace.c       | 5 +++++
 security/security.c           | 5 +++++
 5 files changed, 21 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eafa1d2489fd..3eabd6b10776 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -223,6 +223,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
 	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
 LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
+LSM_HOOK(int, 0, create_user_ns, const struct cred *cred)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
 LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
 	 u32 *secid)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 91c8146649f5..07f833da0bbf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -799,6 +799,10 @@
  *	security attributes, e.g. for /proc/pid inodes.
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
+ * @create_user_ns:
+ *	Check permission prior to creating a new user namespace.
+ *	@cred points to prepared creds.
+ *	Return 0 if successful, otherwise < 0 error code.
  *
  * Security hooks for Netlink messaging.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index 7fc4e9f49f54..a195bf33246a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -435,6 +435,7 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+int security_create_user_ns(const struct cred *cred);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1185,6 +1186,11 @@ static inline int security_task_prctl(int option, unsigned long arg2,
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 { }
 
+static inline int security_create_user_ns(const struct cred *cred)
+{
+	return 0;
+}
+
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 					  short flag)
 {
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 5481ba44a8d6..3f464bbda0e9 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -9,6 +9,7 @@
 #include <linux/highuid.h>
 #include <linux/cred.h>
 #include <linux/securebits.h>
+#include <linux/security.h>
 #include <linux/keyctl.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
@@ -113,6 +114,10 @@ int create_user_ns(struct cred *new)
 	    !kgid_has_mapping(parent_ns, group))
 		goto fail_dec;
 
+	ret = security_create_user_ns(new);
+	if (ret < 0)
+		goto fail_dec;
+
 	ret = -ENOMEM;
 	ns = kmem_cache_zalloc(user_ns_cachep, GFP_KERNEL);
 	if (!ns)
diff --git a/security/security.c b/security/security.c
index 188b8f782220..c700dbdc14fe 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1903,6 +1903,11 @@ void security_task_to_inode(struct task_struct *p, struct inode *inode)
 	call_void_hook(task_to_inode, p, inode);
 }
 
+int security_create_user_ns(const struct cred *cred)
+{
+	return call_int_hook(create_user_ns, 0, cred);
+}
+
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
-- 
2.30.2

