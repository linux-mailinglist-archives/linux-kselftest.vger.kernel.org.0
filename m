Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9997A7432FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF3DRi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 23:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjF3DRc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 23:17:32 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E46D3596
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:17:30 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5634db21a78so978790eaf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095049; x=1690687049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53ZMdGhNmZ+BOpMUbgSFLyEDTkK0ZHteXsorexZvGcc=;
        b=Hhds97GUYBeppbOwT50AZutzB1nVVfNLRInAfnNP58IkESH6yufdJYjjXoko1dy9G+
         7Ur8NWUwfJrbcpQSpTt286069+coFcb6LHT+Hpu/39T4cIbHcx3ohwZzEN7MljiB4mGX
         nGNyBGTlMBhsV2p04QbZotAIplV3r6a4qLE4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095049; x=1690687049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53ZMdGhNmZ+BOpMUbgSFLyEDTkK0ZHteXsorexZvGcc=;
        b=BwdglZH8NNHrpgPGlYIwTNYQNJ8PaAnlwjaipr25ins6xfsnk4bxUbRoD9d1j0dHZ8
         Y7ltk6Tex8CFq4CVb1tBFuUfbbZfcytPnHdxpDP0XSdjq/xg9EriVVoNZHbU+Wgttc/r
         0+Nky5JTiVwSsI4zS48wHjN9AkH+hirGF5pSHizXVwhzLudbv7n1zsgNrxAzvSMWVzeD
         Q5YeKeQIkgoXqJKdiM778vzYXmlKXIccB3MUDc5N7oNbx8EXc5A2T2ccWCuye2nkFO3L
         iB01N+TkhB3VP6VRHwz/QR08H0uDO9vp05RBrR+H67LqGFGbvNLs2WgfE/cJ1v+1QhIx
         rlCA==
X-Gm-Message-State: AC+VfDxyFA5vR0VfWEPZqoGt3NLlVR8d0jvS2yNDijCjMWU2kGQWu6bg
        YjclynI79oxJHNmFklvKnoUZsQ==
X-Google-Smtp-Source: ACHHUZ7w0MIcW5kZcKcCzQ5+ZTjH6ysBlmgQ4PxTyUtw8h8Kk3p3zrfxkxjd+Odq2hqr4KUnUW6Icw==
X-Received: by 2002:a05:6808:1921:b0:3a3:7e8f:2f2a with SMTP id bf33-20020a056808192100b003a37e8f2f2amr1773186oib.11.1688095049673;
        Thu, 29 Jun 2023 20:17:29 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id x24-20020aa784d8000000b0065438394fa4sm1622577pfn.90.2023.06.29.20.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:17:29 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/2] mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Fri, 30 Jun 2023 03:17:19 +0000
Message-ID: <20230630031721.623955-2-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630031721.623955-1-jeffxu@google.com>
References: <20230630031721.623955-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

When vm.memfd_noexec is 2 (MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED),
memfd_create(.., MFD_EXEC) should fail.

This complies with how MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED is
defined - "memfd_create() without MFD_NOEXEC_SEAL will be rejected"

Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/memfd.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index e763e76f1106..812750298e8a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -268,6 +268,19 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 
 #define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
 
+static int sysctl_memfd_noexec(void)
+{
+	int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
+#ifdef CONFIG_SYSCTL
+	struct pid_namespace *ns;
+
+	ns = task_active_pid_ns(current);
+	if (ns)
+		sysctl = ns->memfd_noexec_scope;
+#endif
+	return sysctl;
+}
+
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
@@ -278,6 +291,7 @@ SYSCALL_DEFINE2(memfd_create,
 	int fd, error;
 	char *name;
 	long len;
+	int sysctl = sysctl_memfd_noexec();
 
 	if (!(flags & MFD_HUGETLB)) {
 		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
@@ -294,35 +308,23 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-#ifdef CONFIG_SYSCTL
-		int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
-		struct pid_namespace *ns;
-
-		ns = task_active_pid_ns(current);
-		if (ns)
-			sysctl = ns->memfd_noexec_scope;
-
-		switch (sysctl) {
-		case MEMFD_NOEXEC_SCOPE_EXEC:
-			flags |= MFD_EXEC;
-			break;
-		case MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL:
+		if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
 			flags |= MFD_NOEXEC_SEAL;
-			break;
-		default:
-			pr_warn_once(
-				"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
-				task_pid_nr(current), get_task_comm(comm, current));
-			return -EINVAL;
-		}
-#else
-		flags |= MFD_EXEC;
-#endif
+		else
+			flags |= MFD_EXEC;
+
 		pr_warn_once(
 			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
 			task_pid_nr(current), get_task_comm(comm, current));
 	}
 
+	if (flags & MFD_EXEC && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
+		pr_warn_once(
+			"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
+			task_pid_nr(current), get_task_comm(comm, current));
+		return -EACCES;
+	}
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
-- 
2.41.0.255.g8b1d071c50-goog

