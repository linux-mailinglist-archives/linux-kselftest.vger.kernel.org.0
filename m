Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97564D46A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 01:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLOAOU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 19:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOANl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF69532E4
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:15 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g10so5105534plo.11
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z0pNLRJ0HO6mEsQsP4xR7y3AzecdWz1BUkrTkkGBPM=;
        b=XjRcI72nPawquPIN5bRWzeD1IrnRGCrn2xOecV8quUxSYWi+9EgLb09J83xKRNESEE
         Fje6gfkM8VOrT54RFTc0zvPvFLENPYV2u0YEuaHM2TE7nnT5QFXwYFyPAkFspQOmx86N
         JdBvZ7VcmIX6VcU/OQP60sTESBMlSjCKUCfoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z0pNLRJ0HO6mEsQsP4xR7y3AzecdWz1BUkrTkkGBPM=;
        b=g6h1PnOdsvg6NJdvndTzpaaHEUcz9JW3LrbE/BdProaL59TeHJaFXW/roazsDDAnMS
         g5r19qgkQR2JSqLctLTKcwMuGivIoQ2JcsipvGprFYIcZaUAgUCk7SnzgcUqknNOxDh/
         bKn4jW+QyjNZqns/5lw9qDIwutnp0hwUBMxmAi1ndECvEdYvm97dGfU/3OHuflB8FWm3
         wAflks6UMPxzozada1VJ9pY1ejzgp0kXXyfI9LwDeCxOBTb9bHJrfrc3B0PKVCZZK7FS
         1wpudSL1WGAFJTqYY6DeNlQWbHSM+rEMfz3qjeKjY/bFKSvQNocCgLLBjohutQOVPSJd
         JoKA==
X-Gm-Message-State: ANoB5plfOrpd77OkYiAB/IDiHWPbeYmyk0KWvkzAcuh2knwDu6SO+97k
        UTHTzQzszNafVOIXnG6ZQYa5Uw==
X-Google-Smtp-Source: AA0mqf7+JGkwwniTj89lgqy5bz/Es9n9nNT8cgCfEq9KAwLbHDZVvEcOgQ8eA1MrQnvs5mxlbFF8lg==
X-Received: by 2002:a17:90a:a509:b0:219:ca8f:9c8b with SMTP id a9-20020a17090aa50900b00219ca8f9c8bmr27203708pjq.11.1671063134721;
        Wed, 14 Dec 2022 16:12:14 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:13 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 1/5] mm/memfd: add F_SEAL_EXEC
Date:   Thu, 15 Dec 2022 00:12:01 +0000
Message-Id: <20221215001205.51969-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221215001205.51969-1-jeffxu@google.com>
References: <20221215001205.51969-1-jeffxu@google.com>
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

From: Daniel Verkamp <dverkamp@chromium.org>

The new F_SEAL_EXEC flag will prevent modification of the exec bits:
written as traditional octal mask, 0111, or as named flags, S_IXUSR |
S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
any of these bits after the seal is applied will fail with errno EPERM.

This will preserve the execute bits as they are at the time of sealing,
so the memfd will become either permanently executable or permanently
un-executable.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 2 ++
 mm/shmem.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..e8c07da58c9f 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 08f5f8304746..4ebeab94aa74 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -147,6 +147,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
 		     F_SEAL_WRITE | \
@@ -175,6 +176,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	 *   SEAL_SHRINK: Prevent the file from shrinking
 	 *   SEAL_GROW: Prevent the file from growing
 	 *   SEAL_WRITE: Prevent write access to the file
+	 *   SEAL_EXEC: Prevent modification of the exec bits in the file mode
 	 *
 	 * As we don't require any trust relationship between two parties, we
 	 * must prevent seals from being removed. Therefore, sealing a file
diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..e18a9cf9d937 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1085,6 +1085,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		return error;
 
+	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
+		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
+			return -EPERM;
+		}
+	}
+
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
-- 
2.39.0.rc1.256.g54fd8350bd-goog

