Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB05534096
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiEYPpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245281AbiEYPpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 11:45:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B331378
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:45:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fed274f3fbso180661307b3.17
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8crKctF/FapgbNwtKywxdiRKxJS9KDB6fu8ZFm9leIY=;
        b=HD0dnRcINZlIc28mvYS69ByWX+qQxZpdVeIizu3L/fs8eMaiizEOW5O0gY2kNm3R0L
         yaItTi+yrlaV/PsjehHgrVKTSmRgEJO4r018YLG1lc09l74nejdM+P5GAVaqqujGtJ3t
         ThxEHpfFz4jWZVGaFigAq5VT+n0jZiiFoiEUJcjVwxYh51J2YTMl7v/3EwOJFNsDgupy
         Cw4cgTSpASYp8AyzW/7xuF1dabTAcwmQSNAW87x3FjCYiLAamLU8Dr0UVMmK1kgDKpBZ
         aQx17405zIqpx6smduoBe0YD6+OGooQSsZzEC6t73mOAgOEyirzHAL/D7cqEnhaqF0/r
         2amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8crKctF/FapgbNwtKywxdiRKxJS9KDB6fu8ZFm9leIY=;
        b=7y9pg7h9Z2S2EvdKUUXF0CbANGvnSfMP2RNBxErhjYhHhnA8v+c+BUKu2R0gvdPUmu
         d+obB+SESW6L11vC32/N1ntxUIJJbzu6Q7z1RGeFW0Z/3UdtMZC1IG2f0FSOQ3NTgRLg
         kjSixsFWneJUZv7iW/UExc2ipzd6OpMq+fe0hqwVTILKUJ9gFULgRlAMLrwuknpG7McY
         xLaIB0VHYsQY5jr4kvGXJn4/WtwLwLBhv4/fJhboO3Df2rbftADHXgP4FBQPHkwj37Ub
         9AbtgBAm/ItVZPoIAWuC5Y6DjVDyRN7v0cMj/tE3tMcU33gsbikTcZwJLrVMbdyAWlEJ
         1Z9w==
X-Gm-Message-State: AOAM531z8p3+v+XKYlbLRtBijEyF0Ay6hKVAvtYxtwulDtATbeXHtSVF
        ySetp5PeNPd32pnRsUy8J6G3kHbol7PL0g==
X-Google-Smtp-Source: ABdhPJxILJCqLH0vLgrdn2WPeC0lY9gp5yI55a6IR4a66YCH2wlHlcpCY79q19ipw1SsuXvLeiLMV66R9sTbIQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5bba:b161:2a8a:2ddd])
 (user=dlatypov job=sendgmr) by 2002:a0d:d503:0:b0:300:d3cb:cee1 with SMTP id
 x3-20020a0dd503000000b00300d3cbcee1mr1127476ywd.368.1653493504657; Wed, 25
 May 2022 08:45:04 -0700 (PDT)
Date:   Wed, 25 May 2022 08:44:42 -0700
In-Reply-To: <20220525154442.1438081-1-dlatypov@google.com>
Message-Id: <20220525154442.1438081-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20220525154442.1438081-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH 4/4] kunit: delcare kunit_assert structs as const
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
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

Everywhere we use the assert structs now takes them via const*, as of
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=7466886b400b1904ce30fa311904849e314a2cf4

So now let's properly declare the structs as const as well.
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e4b54f5d2731..fa5955c8b412 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -514,7 +514,7 @@ void kunit_do_failed_assertion(struct kunit *test,
 
 #define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
 	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
-	struct assert_class __assertion = INITIALIZER;			       \
+	const struct assert_class __assertion = INITIALIZER;		       \
 	kunit_do_failed_assertion(test,					       \
 				  &__loc,				       \
 				  assert_type,				       \
-- 
2.36.1.124.g0e6072fb45-goog

