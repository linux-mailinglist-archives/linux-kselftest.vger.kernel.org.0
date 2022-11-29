Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C545C63BD3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 10:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiK2Jro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 04:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiK2Jrl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 04:47:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACBA2AA
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 01:47:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3ceb4c331faso20349227b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUYvtMPSKjTs5g6MPMmEMkOFRg4aOqr2pjUMfkz/qL0=;
        b=VQ+VIAZ+G3oo5EFPjNjRqx8Z8Psg8ZPV0zITQA1aPIi9vO2Cpg0DrBU3vtvPcGyT2Y
         nMV9ijpQ8uFbAwUt95JvQuGa/kqtpAt9OmTGt+VGfGd244AgOKUNGUQ5JHjhUK6+6mQU
         ZfLDINbdMs+HC7aZHpe4SWXzozkIphqrMNLD8/Xr0sqr7Egy9DVfNy7wMyCuvpN33k9a
         nFafoqr9wQFcP8RzADkbXouMmadafPfQQ+Hz+G+tuItnwuzMqy6hG0Gt5pEbytpYKffB
         K8MXyWDFqbobn0eHIVND4B6Osl15gRKgtC2sszltuv7A6zdizeCmCEg5ec1pe7O7Ygei
         GI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUYvtMPSKjTs5g6MPMmEMkOFRg4aOqr2pjUMfkz/qL0=;
        b=TNBE/xAsF/pg+RDQfRkBPC/BOhoEYSOfxAz1ZVM9QBsa8EHx4oF/Zlg3oLU9raRMtD
         YISZbSjxrnAug/QPlaqfQPT6LaLleX2QLXOnxodPKfToWJYjLFQ0R+nGN4bJjtyYLXPH
         y3OVnxjp5+0PYKCwjc0Gws9v8zngGd5YnX+xvqBg/QLCTv6P/cOomXiYVLtXb2lPJLkw
         6nYpeZaEEr1TWFa2Qt/c+ig+BNJqivmzIVj0oxOOpf9vREnHHMPc2Gc8BJ531KYUaGdA
         3OGzX+4wEnYgMP7Z/E0KBVOORvdKvAuuO2GX5d6LEyuHbFzkk+PjBAfvZOhoTLLU8McT
         xCYw==
X-Gm-Message-State: ANoB5pk9kJHSbA4OUu59QhD4ukxF3sLo9jMijChWZij926sd2q5u/i2P
        8Ml16VHYoyLzxG7ilpz8SX6PzRQlP4jzRg==
X-Google-Smtp-Source: AA0mqf7kQDdqeLRiGzeiyFv4w0FSFwHN284HPSYc1KooqTV79U9t2R1k8LQc1SmNrdp8VPuuG9B3LC9I9UjRGg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:aa05:0:b0:38f:f363:c996 with SMTP id
 i5-20020a81aa05000000b0038ff363c996mr35ywh.442.1669715258425; Tue, 29 Nov
 2022 01:47:38 -0800 (PST)
Date:   Tue, 29 Nov 2022 17:47:32 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129094732.306449-1-davidgow@google.com>
Subject: [PATCH] Documentation: kunit: Fix "How Do I Use This" / "Next Steps" sections
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Sadiya Kazi <sadiyakazi@google.com>
Cc:     David Gow <davidgow@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
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

The 'index' and 'start' pages end with very similar "How Do I Use This"
/ "Next Steps" sections respectively, which link to the other
documentation pages. This wasn't updated when the tips.rst page was
removed.

Remove the reference to tips.rst, as well as tidy up the descriptions on
all of the links (especially given that sphinx gives the page titles
anyway.

Fixes: 4399c737a97d ("Documentation: kunit: Remove redundant 'tips.rst' page")
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/index.rst | 18 +++++++-----------
 Documentation/dev-tools/kunit/start.rst | 16 ++++++----------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index d5629817cd72..beec6f847ef4 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -99,14 +99,10 @@ Read also :ref:`kinds-of-tests`.
 How do I use it?
 ================
 
-*   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
-*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
-*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
-*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
-*   Documentation/dev-tools/kunit/usage.rst - write tests.
-*   Documentation/dev-tools/kunit/tips.rst - best practices with
-    examples.
-*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
-    used for testing.
-*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
-    answers.
+*   Documentation/dev-tools/kunit/start.rst - for new KUnit users
+*   Documentation/dev-tools/kunit/architecture.rst - how KUnit is put together
+*   Documentation/dev-tools/kunit/run_wrapper.rst - run tests via kunit.py
+*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit.py
+*   Documentation/dev-tools/kunit/usage.rst - write tests
+*   Documentation/dev-tools/kunit/api/index.rst - API reference
+*   Documentation/dev-tools/kunit/faq.rst - common questions and answers
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index f4f504f1fb15..58c176348885 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -294,13 +294,9 @@ Congrats! You just wrote your first KUnit test.
 Next Steps
 ==========
 
-*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
-*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
-*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
-*   Documentation/dev-tools/kunit/usage.rst - write tests.
-*   Documentation/dev-tools/kunit/tips.rst - best practices with
-    examples.
-*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
-    used for testing.
-*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
-    answers.
+*   Documentation/dev-tools/kunit/architecture.rst - how KUnit is put together
+*   Documentation/dev-tools/kunit/run_wrapper.rst - run tests via kunit.py
+*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit.py
+*   Documentation/dev-tools/kunit/usage.rst - write tests
+*   Documentation/dev-tools/kunit/api/index.rst - API reference
+*   Documentation/dev-tools/kunit/faq.rst - common questions and answers
-- 
2.38.1.584.g0f3c55d4c2-goog

