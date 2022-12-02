Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE49A63FDB5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 02:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiLBBgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 20:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiLBBgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 20:36:00 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB8D2DB7
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:35:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id r7so3537255pfl.11
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Dec 2022 17:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP31bsPSm9f+hAa3TK6LgXNEEfW0wwdldtJ51E5YYMM=;
        b=h54Ivo7q4Zdaa4YfuGYp4JEDINKQlEWi8Y7JROzg8A6deqnzT+HJ3ASFvDkyQDhVPt
         6bmrFOZPo7Ftex4TwpNnkPOGsFVX7JF7cuu99nPIRYwkovEhOOIAQSNjazxInWQoXHzy
         /tl+ViyHQ9zvXgJhzRK5IHKjw/NbaqwCPfWn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP31bsPSm9f+hAa3TK6LgXNEEfW0wwdldtJ51E5YYMM=;
        b=SMub4PiWA3PmbXuKcqeGqZ/fw7P3sqgoLYUuwmV24O4mMmKuW7GIRAJ9MGVEQ2D3p5
         19DaPg/SrjMtBJBAerO/ZNU7w/xNYiwHriYNL6m3lU4MXkNJ0UhrtNhlgZYihS43a6B5
         YxOl4c5EonkeFZHOJLwooY6caj2Z7OBeIaMbQ/TXZCldm0lJ7s3VDvKaiG4Zvwz1THtn
         374HUnHGe/v+qI7weLpfgkCl1nGLMhAyeJldqhDeI2bvY2g81huCCT0mNLYfNQl8LJLJ
         mlSeaDhp7sMmCXZbiuAWr9YSpwJjpx5dWR4GFQequnbjJxdMlcTREnZMcsBHChkqKMin
         Qj2w==
X-Gm-Message-State: ANoB5pmqD3zcugXeg8py7RRHGZJUZ20XFib19HT0s9CircV/G8Vz56Kt
        Hf2RKxpvVzHKmTe4TL27S6U7ew==
X-Google-Smtp-Source: AA0mqf6s5/DD/qEipDy95aXwC2Z3tWXhD0ZZ1Ih93gpvBAsrbgYstV1S9ORwEXoi15r0GE04k1z42A==
X-Received: by 2002:a63:185a:0:b0:476:e84c:ab63 with SMTP id 26-20020a63185a000000b00476e84cab63mr47437406pgy.496.1669944957535;
        Thu, 01 Dec 2022 17:35:57 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id s13-20020a65690d000000b00477fb27eaddsm3074241pgq.63.2022.12.01.17.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:35:57 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Fri,  2 Dec 2022 01:34:04 +0000
Message-Id: <20221202013404.163143-7-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
References: <20221202013404.163143-1-jeffxu@google.com>
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

When apply F_SEAL_EXEC to an executable memfd, add write seals also to
prevent modification of memfd.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/memfd.c                                 |  3 +++
 tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 96dcfbfed09e..3a04c0698957 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_ALL_SEALS;
+
 	*file_seals |= seals;
 	error = 0;
 
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 775c9e6c061e..0731e5b3cdce 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -32,6 +32,13 @@
 #define F_SEAL_EXEC	0x0020
 #endif
 
+#define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_SHRINK | \
+		     F_SEAL_GROW | \
+		     F_SEAL_WRITE | \
+		     F_SEAL_FUTURE_WRITE | \
+		     F_SEAL_EXEC)
+
 #ifndef MAX_PATH
 #define MAX_PATH 256
 #endif
@@ -1006,6 +1013,7 @@ static void test_exec_seal(void)
 
 	printf("%s SEAL-EXEC\n", memfd_str);
 
+	printf("%s	Apply SEAL_EXEC\n", memfd_str);
 	fd = mfd_assert_new("kern_memfd_seal_exec",
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
@@ -1024,7 +1032,24 @@ static void test_exec_seal(void)
 	mfd_fail_chmod(fd, 0700);
 	mfd_fail_chmod(fd, 0100);
 	mfd_assert_chmod(fd, 0666);
+	mfd_assert_write(fd);
+	close(fd);
+
+	printf("%s	Apply ALL_SEALS\n", memfd_str);
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
 
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_chmod(fd, 0700);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_ALL_SEALS);
+
+	mfd_fail_chmod(fd, 0711);
+	mfd_fail_chmod(fd, 0600);
+	mfd_fail_write(fd);
 	close(fd);
 }
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

