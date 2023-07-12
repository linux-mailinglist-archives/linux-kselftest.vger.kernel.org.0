Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC67509EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjGLNqy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 09:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjGLNqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 09:46:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC219BC;
        Wed, 12 Jul 2023 06:46:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3141c3a7547so7217345f8f.2;
        Wed, 12 Jul 2023 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689169610; x=1691761610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrULn3erFwU+XaUY+RvPSd25FEdfChxFqzk38hJNgVA=;
        b=cRRpQ8cUsltI+oRXJ2bAVSmeDXGxx/qCxmtsM0YPOqLSbJeeVsyHmq0fMP/AIg0358
         HYxONQolujXyBBMUMPwlXQbZ07TxJJiHDmO5H89Z3urLiI3YnToMGd+BEOMvgGhoE9gk
         3im4y2XLqKIpdAmvDgfqOnfg6fuZ/MQev3d/w8Q81xm+lHaUOzGShTo+4NA8CJACnc8N
         x7EfRc6ahzTyX9YLXXrWf2wACaTv/N1mb2mBPzv3hhoabGe6J7318kYkNc3qDo678Kbt
         fOon06R2RGR9QyqoHk+yOu7w+MqFMqMhSx1asAeBbU9wsmlXzFuyIwOGFXe4blEu8Zh4
         TVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169610; x=1691761610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrULn3erFwU+XaUY+RvPSd25FEdfChxFqzk38hJNgVA=;
        b=CSXUxj7oagQ4EkijBuehXWIa3Q64H/Txpxkl4VA3ZdA3uwjcJSd8+mlmwVKUxR5lWT
         AtcvLp+xIheTOGmxDm/2yCvnRvNuHcQ1jTqyoFpsCOvfndoGBp3Jy94XBoPNjcJp0F/D
         uc25ip/MeYRpEVHFcYpt2i+RPLWNjxBJYc/ZT3g5BUq8o3drnQgxYwxKKkdrslymrYzt
         jGLKxEX/QVyYNuwfHOCKfv5ev1saAMtHuTyhdjOvJOHCbNx5PuQJpKktdY+RHmu6TrJj
         85uEU/9pO2mWDY/q65bh5sMKeDatar6yFDInqWRTzT6PvbYinVFZSm6n5QFcOP0odo/w
         ls6Q==
X-Gm-Message-State: ABy/qLYChgCgHFPgfT5TQkj6XvRe64y+iZF1geg7G6bMFRpa4BbYbx9v
        jbHQQg6LuLBxXllCWr35QNM=
X-Google-Smtp-Source: APBJJlFZICy2vhMZpUxSaUh1uacPscbsSMw0Z2O/QOnBWI+UPLZ2HtVR5p0wQLU9wYLiQlW4YtiJPQ==
X-Received: by 2002:adf:e0c7:0:b0:313:f862:6e3e with SMTP id m7-20020adfe0c7000000b00313f8626e3emr18227576wri.40.1689169609614;
        Wed, 12 Jul 2023 06:46:49 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y18-20020adffa52000000b00313f031876esm5161583wrr.43.2023.07.12.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:46:49 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/mm: mkdirty: Fix incorrect position of #endif
Date:   Wed, 12 Jul 2023 14:46:48 +0100
Message-Id: <20230712134648.456349-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The #endif is the wrong side of a } causing a build failure when
__NR_userfaultfd is not defined. Fix this by moving the #end to
enclose the }

Fixes: 9eac40fc0cc7 ("selftests/mm: mkdirty: test behavior of (pte|pmd)_mkdirty on VMAs without write permissions")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/mm/mkdirty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 6d71d972997b..301abb99e027 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -321,8 +321,8 @@ static void test_uffdio_copy(void)
 munmap:
 	munmap(dst, pagesize);
 	free(src);
-#endif /* __NR_userfaultfd */
 }
+#endif /* __NR_userfaultfd */
 
 int main(void)
 {
-- 
2.39.2

