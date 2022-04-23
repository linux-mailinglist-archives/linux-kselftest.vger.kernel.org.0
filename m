Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58C50C7AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 07:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiDWFrj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Apr 2022 01:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiDWFrg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Apr 2022 01:47:36 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EDDA88A6;
        Fri, 22 Apr 2022 22:44:40 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id j6so7574633pfe.13;
        Fri, 22 Apr 2022 22:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=P0diT9iDcYe1TifSZHN2PRcMMU/gU9bovyJTLCWyR74=;
        b=RXtShu8PuwriYVvaiNb9S0f6DcuyqCZz2jyrD+rfVgi44v9AT5AyHvdjAMaQ3q/pEg
         DNmhyDWVojm1KbfX7iecHeSlY5d7BqUZFGmm1ra4l/uSPzPrWfYtv/g7hdw8VBh0MtoV
         +KJXkBlZ/fy0SUnhMVrO9aNhEDsDgYd9Bm+2hASDwIra6Yc3xbhIws1yoHYYeTbupYE7
         g6QfLP2cFS/RoymD4FVKEvY6c7qMJN83sK5eSXOdoTNfTA5y+D1wNNsHy1x3gM/CspgP
         XsS13tIN8tBXtgM5AClJAfAcOy5ipWCAFyIZA2M7wbWaphlhsClS/jNbiVcldsnhHM6R
         fW8g==
X-Gm-Message-State: AOAM532dZnFXqCSC+Zy+M+6A3dZMMOZf8f8pdtokB4MPz12oJd/VnA44
        v57kqwsZh6SxFeb/3DjJIOhod+D+MtbPXA==
X-Google-Smtp-Source: ABdhPJw2ccwvag5NjSS5+MUAgUQEDEpmqr8eppkw74Vf5Pq3mfzCLLgKvn7hrVXUU3VlbyZAPbdxVg==
X-Received: by 2002:a63:5b43:0:b0:39d:1a2b:5904 with SMTP id l3-20020a635b43000000b0039d1a2b5904mr6663505pgm.533.1650692680213;
        Fri, 22 Apr 2022 22:44:40 -0700 (PDT)
Received: from karthik-strix-linux.karthek.com ([117.208.180.32])
        by smtp.gmail.com with ESMTPSA id m22-20020a17090aab1600b001cd4989fecbsm7653996pjq.23.2022.04.22.22.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 22:44:39 -0700 (PDT)
Date:   Sat, 23 Apr 2022 11:14:34 +0530
From:   Karthik Alapati <mail@karthek.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/binderfs: Improve message to provide more info
Message-ID: <YmOSQv2U8+Hs5WjP@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the binderfs test says what failure it encountered
without saying why it may occurred when it fails to mount
binderfs. So, Warn about enabling CONFIG_ANDROID_BINDERFS in the
running kernel.

Signed-off-by: Karthik Alapati <mail@karthek.com>
---
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 0315955ff0f4..bc1c407651fc 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -412,7 +412,8 @@ TEST(binderfs_stress)
 
 		ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
 		ASSERT_EQ(ret, 0) {
-			TH_LOG("%s - Failed to mount binderfs", strerror(errno));
+			TH_LOG("%s - Failed to mount binderfs, check if CONFIG_ANDROID_BINDERFS is enabled in the running kernel",
+				strerror(errno));
 		}
 
 		for (int i = 0; i < ARRAY_SIZE(fds); i++) {
-- 
2.35.2

