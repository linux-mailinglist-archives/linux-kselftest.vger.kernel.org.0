Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC13747D1E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 08:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGEGd0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 02:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGEGdZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 02:33:25 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BE1703
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 23:33:21 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-47e793ccdc7so150126e0c.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 23:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688538800; x=1691130800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+MSmdpLaQYcYfYw7xJr5lmjiO0vLCrOZIxlLos01I4=;
        b=bFlmbiX7I0IMNBN+awjy44Gd2HHxolAdFzcioJ6vbbxbKEhkdrQChkaBrAG9TgBfKT
         x0Z2gtzkhzO55v/fQhqA0JPCBoHFOFGB4fsAyofg2LzDmXjriBm2FqrokpTc7btoXEHH
         bLA19vYllamBMyiqrr9cjjjuZUbPI0WKT4WEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538800; x=1691130800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+MSmdpLaQYcYfYw7xJr5lmjiO0vLCrOZIxlLos01I4=;
        b=l13ys7WwI1rOiMAaNxYS2C5TKrlEBV6G7d4oiTG48phG/xKGWiw1+VlePQbytzIgKC
         mBXIb+SJVHl6VaYKLxPKYC+4NgNuKmOOPLYzhCZVzEMqJzaRNggb5eifO5ga3GeN2Fpe
         l/X2ecfEmdrd4t0Ww9cPpjAOidI/Wq3w7FADGjYAp4g+uNqdrMbqN3MQVBL19VZR9LTu
         56OKtvzNnioQAnKThuV8uNNH3dVFzrsMQ4jy3TN7GBoFM9yNdKmXLyRYXJ7SGQ0y/drE
         kSK0Zy5QzEk07wbVF0SUz+KkPKuOi9QateGufLqURH1pMgUgqB67P9PdvloLwksG8Iue
         eaRQ==
X-Gm-Message-State: ABy/qLYxtgtyQI4qIJsFf9RZ/o5PoxgoKSjSwwLI1rSpRhAvpKrKuHog
        sY+D6cZjEhJLHu3U8t19pmGadw==
X-Google-Smtp-Source: APBJJlFcgKaSPJKkbCoS2vIlhS3WYafUAvQl5v36URdmF0hDQjm/PTL88mvcn7PB87UgQocXD3sayA==
X-Received: by 2002:a05:6122:2af:b0:46e:6af4:3333 with SMTP id 15-20020a05612202af00b0046e6af43333mr6858407vkq.5.1688538800100;
        Tue, 04 Jul 2023 23:33:20 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id bj2-20020a17090b088200b002633fa95ac2sm633631pjb.13.2023.07.04.23.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:33:19 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Wed,  5 Jul 2023 06:33:14 +0000
Message-ID: <20230705063315.3680666-2-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230705063315.3680666-1-jeffxu@google.com>
References: <20230705063315.3680666-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Closes: https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306301351.kkbSegQW-lkp@intel.com/
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/memfd.c | 57 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index e763e76f1106..0bdbd2335af7 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -268,6 +268,36 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 
 #define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
 
+static int check_sysctl_memfd_noexec(unsigned int *flags)
+{
+#ifdef CONFIG_SYSCTL
+	char comm[TASK_COMM_LEN];
+	int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
+	struct pid_namespace *ns;
+
+	ns = task_active_pid_ns(current);
+	if (ns)
+		sysctl = ns->memfd_noexec_scope;
+
+	if (!(*flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
+		if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
+			*flags |= MFD_NOEXEC_SEAL;
+		else
+			*flags |= MFD_EXEC;
+	}
+
+	if (*flags & MFD_EXEC && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
+		pr_warn_once(
+			"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
+			task_pid_nr(current), get_task_comm(comm, current));
+
+		return -EACCES;
+	}
+#endif
+
+	return 0;
+}
+
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
@@ -294,35 +324,14 @@ SYSCALL_DEFINE2(memfd_create,
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
-			flags |= MFD_NOEXEC_SEAL;
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
 		pr_warn_once(
 			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
 			task_pid_nr(current), get_task_comm(comm, current));
 	}
 
+	if (check_sysctl_memfd_noexec(&flags) < 0)
+		return -EACCES;
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
-- 
2.41.0.255.g8b1d071c50-goog

