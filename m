Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B358B267
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 00:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiHEWV5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 18:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbiHEWVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 18:21:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA241CB26
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 15:21:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4e870a17so31513087b3.9
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mbnTnCyzBrPsZ2cIyy/polFSFcHi5iA+y2wZHy5S50g=;
        b=O1tv2Chuzvi0NDU6zf4N/Fshq6yGCqiuDTuun/edjoU5VnoWU6HlwRqRq214Cym4mz
         noFPwUsXvo0SYNfeNEjWoXIVZcign3gEgsFpITz4QnZrbGOtKfeY+cDS9TK5falMgCNI
         DJ6xcL5LbkGOVjDMSML6SM3jRDsvX6GsPMXFLvFKSYD1BtYOfgnhaOBaYbe12JSlISWh
         zKPVACct5OHq40PuoLQGZTx+YFMcXX1RgsGmCiYPiEbumgKzZ847z4pJf7UeYvrXqLcR
         FAIEKIHGSOX0P4KPT7WoPV95vsdEH3BO4vgVQ2JI3EeE9rV4Ph0MSuemj+SCfQWNltzS
         3OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mbnTnCyzBrPsZ2cIyy/polFSFcHi5iA+y2wZHy5S50g=;
        b=HZE2/dZO4bqaDzx3/dcgqSJ4/E+ccWS/Ax9wHP+MIlELX7Xq43I9OObN9Pzc7DvEcT
         hI3R1xyEQIthBF++7rZPetd/W+zriMov1PFI7aNA458D2c/Ckb260B1Y2i1jewD6XVwg
         eMMDoV+yJ1rBRAE86QWYKoR/dNWcQ2UChmsWMK6gJHgTjtE39fWPZtjw+iij+fLNMKPO
         GgYnFxkgpmzd3cmD0xdiYmhH2WOXNkyUaLNyzALN3gsCrolYOgKKRaDdX2EH+DR5dS1y
         mnJkVJRatSrDLSXAk6IT9aeZteW6cf9RrS1IW4xRbjW2ZvF1bN18C1VFHmDlwxG87gbt
         JJLw==
X-Gm-Message-State: ACgBeo1vEX6VVU9eCvhBBftqY5knFHYIxx6Nx/SkdWkRb9ZjBcd859NZ
        9c5QroTV9wvJiUmeZzoDeX2TZXD02QY=
X-Google-Smtp-Source: AA6agR6sCneuMkIn8ODRd5RHoaPnFVjTcuaTHnQMf3gsH0n2vQfppBnVbsN+vr+g2fHjPeLdvPi2NkEA0yQ=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a05:6902:723:b0:677:115b:553c with SMTP id
 l3-20020a056902072300b00677115b553cmr7776175ybt.214.1659738108553; Fri, 05
 Aug 2022 15:21:48 -0700 (PDT)
Date:   Fri,  5 Aug 2022 22:21:22 +0000
In-Reply-To: <20220805222126.142525-1-jeffxu@google.com>
Message-Id: <20220805222126.142525-2-jeffxu@google.com>
Mime-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 1/5] mm/memfd: add F_SEAL_EXEC
From:   <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
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

Co-developed-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 2 ++
 mm/shmem.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..a472ba69596c 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_EXEC     0x0020  /* prevent chmod modifying exec bits */
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
index e5e43b990fdc..bb530f562bdd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1082,6 +1082,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
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
2.37.1.559.g78731f0fdb-goog

