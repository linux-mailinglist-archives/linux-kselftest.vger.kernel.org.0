Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801187A1F5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjIOM6t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 08:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjIOM6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 08:58:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69DFE7
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 05:58:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso1399186f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694782720; x=1695387520; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7ZWYDZGQuzlBAXJCNo7Xno7YKGhDfk16+TT8ZwVTUw=;
        b=hAyF3SgTTjKfV7U6v7qzdp1Sv0zwbbiyuKTb5j5gRmrZRsBPqRsCGOguu9DVvJKFVp
         1C46Jjhnob9SDRC5j6IIFiiO/daQ13ubq+px10WaBiASwnatJhNHR2OIwPCK9aREHMBx
         D8zWGypDZng4t3tkDhW12mlrpbv3DWa5fZjawVRThZq8o2ozvpaDt2QBOozsbmHTxFzp
         rrINXEzUL4cA92KZyFE8SLKQY1JOOQHEGVoLqFA464mK/vGtS/d0APye1enWqmT9fUQj
         3RqIBKosMK21qcU+oONsBSeebghfeEZHNXJfnbY17i4iK9g+iwB+VeWmAKDHmVHbYDoc
         CeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694782720; x=1695387520;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7ZWYDZGQuzlBAXJCNo7Xno7YKGhDfk16+TT8ZwVTUw=;
        b=Qm3l4/QuV0Tsu0mkdjF7YCgSchinIRe8xGzXETCdyQZCr7oxd9lTOV/NtHLhjUkRpc
         uC7v8KArHEwJ7JhSK8FXNFpWoopa+lrkbnn1ssgUltbiJN1xA9iSB+2OT44nBTzQXYBK
         Nz0gyhxdtgyrop9XHASAPE/7nbadhMndh8h7ujCve8OzyGu2RqThvg2N3x7yxorDrB3C
         ZLbNQQ/3Q+6MrD2oCHtU6hf+3LRfFXJBHYRXGLT4c9pymMZcSG0KDhP72qdvKkEIFFgO
         NMKy+kh2w5aKIcaO/cd5VHcCFje4cbQsVAVQF6C0EYZO3mxgGaph3VwbuksArnVZwEcO
         avkg==
X-Gm-Message-State: AOJu0YzMILy0W1B46pZL+JHKbC/6W6HObRuJ2TauIXcng267odAMasxq
        gIMrv1Ykxod2xTECZIoFsqqYvQ==
X-Google-Smtp-Source: AGHT+IETdqMFnPZsMGf7ZX6xA1sbJ/Dg46j6mhed2L+2K/snLfuksADiUBenVOmBPxVHnslA4OD/Iw==
X-Received: by 2002:adf:dd8d:0:b0:313:f75b:c552 with SMTP id x13-20020adfdd8d000000b00313f75bc552mr1149560wrl.15.1694782720260;
        Fri, 15 Sep 2023 05:58:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f10-20020adff8ca000000b0031ffa453affsm224905wrq.17.2023.09.15.05.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:58:40 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:58:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: Check for kunit_parse_glob_filter() failure
Message-ID: <3ff9d019-75b6-45ee-9b03-9d6ec7c5364f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Smatch complains that the missing error checks would lead to a crash:

    lib/kunit/executor_test.c:40 parse_filter_test()
    error: double free of 'filter.test_glob'

We may as well do it right...

Fixes: a127b154a8f2 ("kunit: tool: allow filtering test cases via glob")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/kunit/executor_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index b4f6f96b2844..176c9c9dfcfc 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -27,13 +27,15 @@ static void parse_filter_test(struct kunit *test)
 {
 	struct kunit_glob_filter filter = {NULL, NULL};
 
-	kunit_parse_glob_filter(&filter, "suite");
+	if (!kunit_parse_glob_filter(&filter, "suite"))
+		return;
 	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
 	KUNIT_EXPECT_FALSE(test, filter.test_glob);
 	kfree(filter.suite_glob);
 	kfree(filter.test_glob);
 
-	kunit_parse_glob_filter(&filter, "suite.test");
+	if (!kunit_parse_glob_filter(&filter, "suite.test"))
+		return;
 	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
 	KUNIT_EXPECT_STREQ(test, filter.test_glob, "test");
 	kfree(filter.suite_glob);
-- 
2.39.2

