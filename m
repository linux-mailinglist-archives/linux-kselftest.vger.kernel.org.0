Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE95F175E
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 02:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiJAA11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiJAA1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 20:27:02 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8410F
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id br14-20020a056a00440e00b00548434985cdso3570587pfb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 17:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=DrdzDq6t5Szhsu/Sk6P5GuM2F1JxchQr+0dbQd4xjqA=;
        b=GnykWZuUusySEmZRDRq89nbwQwUSS2BZ3mERFnQ4lw308/JrzIFUt3G3r3OyQyCjfY
         xAGBEhZoOjtYOPP8uKLKyaeuOwyTC5+Ne5KdeSKX1oOdmB7M82beLgNPk+c8TS/FODPr
         jdMKA28NUTHDe1EM7NYZEZ+ZFBuycXKzuRj0CGqja9/DOu2jNxbXBg5SmocYCMh1SZXU
         ZCNc4wgHNfJ5CS7hmVhiauHHfxSm0LB0ad444Mr3DMD2ttT4FviZTfx6IOcsxF6372ME
         yszZfuUwgArHETLd59mL3L4rLuGOmlZJnOjm+9F6SqME9JE5Dlb8r0bpg5tpT6xSp2Eh
         KsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=DrdzDq6t5Szhsu/Sk6P5GuM2F1JxchQr+0dbQd4xjqA=;
        b=2bpgrUWtjTiw1h7EHa5Qc9EapfAI8IgGyDcqlttm/tslzgWNesY1h75L67gLG2zHBn
         Iql7TZLJTPW50OL/WFGzwOIJv8uACC3SyWcQvmJLO6myUkaCqvQOc6b8sU/qEmseEgK9
         MJmHGkc+VD4SYaNA2vQyQ92pjpHHglKLSVk+mErQ1N8zls9cRTzmOki9uNa0872RYxBu
         bpEwCTFKjE9YkYXyzRtlVJIce1P8oe7Lgv/B88T4UeXG9gddbHtwdTt4wj2zcK92XQfz
         FpLVGJL/a30oaO5tXhHXuCZvv8MpjB6HRtSYf8j6D4qk+xDR6Zl2GsZEgzIS+l1XVLsV
         Ff2Q==
X-Gm-Message-State: ACrzQf05BDKntPRrGm2Dx26tKyfaAQ2XVxQGVOXzRKCPNbrxIt8/OAsR
        KyZ6LAR/+F8Pb5lEdLh1cmFqpIuwCvYkpg==
X-Google-Smtp-Source: AMsMyM7nL2AzNmgA6b7OLqOJyYnw86E/zsba9xXmPiPKN7886pdizJ5Lnh2FzZ9kEeNFeAPtVmNTcPPf1r1gVw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:3c49:b0:209:7137:4b7c with SMTP
 id pm9-20020a17090b3c4900b0020971374b7cmr876988pjb.115.1664584012978; Fri, 30
 Sep 2022 17:26:52 -0700 (PDT)
Date:   Fri, 30 Sep 2022 17:26:38 -0700
In-Reply-To: <20221001002638.2881842-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001002638.2881842-5-dlatypov@google.com>
Subject: [PATCH 4/4] kunit: declare kunit_assert structs as const
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        miguel.ojeda.sandonis@gmail.com,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Everywhere we use the assert structs now takes them via const*, as of
commit 7466886b400b ("kunit: take `kunit_assert` as `const`").

So now let's properly declare the structs as const as well.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e49348bbc6ee..d574c871dd9f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -477,7 +477,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 
 #define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
 	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
-	struct assert_class __assertion = INITIALIZER;			       \
+	const struct assert_class __assertion = INITIALIZER;		       \
 	kunit_do_failed_assertion(test,					       \
 				  &__loc,				       \
 				  assert_type,				       \
-- 
2.38.0.rc1.362.ged0d419d3c-goog

