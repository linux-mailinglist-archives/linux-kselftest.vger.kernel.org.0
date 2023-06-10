Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38272A71E
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 02:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjFJAwX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 20:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjFJAwT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4630E8
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 17:52:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso33561397b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358337; x=1688950337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcmdgdtrOaPERzGMLLSgLUzQ9hHmsIkGLHU1LmoZfH8=;
        b=22Hb/1PuiZ6DCILf0AAvPSn7RCceVmjHUMkry1uEt7SnQWVqm0GdauDWyayZNLHePk
         treeEyNSuxwZnzIj1JdAE3QODBhN0LUH3X7GPduL7LWybzUeWhV2S0tIMW917YmYmdrk
         uCGy0JI5whT0RAjzzYZI0O7rngpvEVwH8KfHyApXpcfFK57jGWcFz/1shb4TvOaF+QpR
         vAuhIqxiS520cOmhta6uqhv5XKIBro6kTWqQK9CLNO9YICKTNoh0xDQt8QfcoR1zHTKM
         UMLJhNgR4gn2Sewwd4+sflVmXIgvriDSlcI5c4hGOIumWhCEMZYgJTIbeFXcYhKJIYIj
         5zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358337; x=1688950337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcmdgdtrOaPERzGMLLSgLUzQ9hHmsIkGLHU1LmoZfH8=;
        b=jBI7rEcGxpICACHSRHzxqc3skmJwuQ88u1MWPCVeReTIPcBx0Ks7mCvflMWrN34HSD
         ulqE5zV9YRmmls1GtEIJZXDm0Vy4+1tLed9BOmYONI8+TSSuKQ7PEMFPYB8784g/ZcoD
         60SG7+cL3U+g538G/UM6sbVfq6GAFzZSIb0kOOOru3RHlEqtUGNhIIj/8en4jYOYUC/J
         dad1rSFydh0nlWrfgix2bQviB+cu4zlyBwHlkErs+SZHgtoitTDDSt6paXTyqBZUqSqJ
         lWyUPtwwaTtVH7udO6zICL0Qy6oWTlYwPuf0CTb0n2nETSrr7cBF9BU1Pjv7Y5TSl+9W
         S1Tg==
X-Gm-Message-State: AC+VfDwqOKpNfC7lZA2XCGGfm3yKSI/atkroIHygiJtgEUXXVRaGysQz
        90CBr0U5RBffmD6nBvn1Be8zpbySiw==
X-Google-Smtp-Source: ACHHUZ50X9vGPEaRfFB8Zyfp7hAGjAAFOLWkJmhz9m0q7Z+GgI9UAkMD03XJMau7OkFzqamRls5gtUVd/A==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:c14b:0:b0:561:b7fc:7445 with SMTP id
 e11-20020a81c14b000000b00561b7fc7445mr1706591ywl.1.1686358337108; Fri, 09 Jun
 2023 17:52:17 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:49 +0000
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-7-rmoar@google.com>
Subject: [RFC v1 6/6] kunit: time: Mark test as slow using test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
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

Mark the time KUnit test, time64_to_tm_test_date_range, as slow using test
attributes.

This test ran relatively much slower than most other KUnit tests.

By marking this test as slow, the test can now be filtered on using the
KUnit test attribute filtering feature. Example: --filter "speed>slow".
This will run only the tests that have speeds faster than slow. The slow
attribute will also be outputted in KTAP.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 kernel/time/time_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 831e8e779ace..ca058c8af6ba 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -86,7 +86,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 }
 
 static struct kunit_case time_test_cases[] = {
-	KUNIT_CASE(time64_to_tm_test_date_range),
+	KUNIT_CASE_SLOW(time64_to_tm_test_date_range),
 	{}
 };
 
-- 
2.41.0.162.gfafddb0af9-goog

