Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F164530E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 05:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiLGEda (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 23:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLGEd2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 23:33:28 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8C53EFF
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 20:33:26 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id g13-20020a056a000b8d00b0056e28b15757so14449472pfj.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 20:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvWkeGtUjMlhesefa10GSIC9wVnySMexFE31r+XG6CU=;
        b=mgbl9t5PdlFHX60KL8e6/OKUKxgBLYRWTElHEga2nFDoYKO1K/hp4tEqDj/8CsChay
         05H/f7nGllxcL2au6eSy4air3rF+0D41Pxwg5/j8g455JVTiZbr59nHWwNU0IwYot5tL
         cR3x7gfBtOXJPdwNA6fpo6jJByat8ePTwr3rsZH1KIrsKoSmDdGubG6gx9nzW3QolKYM
         W0HqhvFUbjWxCuWXb4KLPKmwrmEm/SjJhzVTsBu2eYeetLx8beH6Zb3yoxsxhhow9N1T
         XUB8dZtlEohAS3LUb+nzG2nq0SPb/i/TsYc2k9P3NNWneShcHrVljnBCEGtEv5sYB6Cp
         AG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvWkeGtUjMlhesefa10GSIC9wVnySMexFE31r+XG6CU=;
        b=b5/E1C8X1eCx3WKY6HxuuMTZKX9k2ZKXtNujfYrD+z8LEweGJXXvPeTQ+nP51TnP/P
         FY6avp+piKp8cURqYvAM/hVahHe8P1QEo06vm6Y1zoafulnyQT8YRVTwdsRWq/uvj00c
         p6hPg/4JwKVPsUC6vn2F4fGaoLACM6trt65JXshRqw8CTeXnbUf0ZtWkHqoR9xe+aGIw
         oCEu49m+P2E93Jmt/q3mre2JpvdZ04pL8ZudsH8z9njSBAufFqGD81NSd5s37cZTnhA5
         rtXYmp9bwYIla62iJc9zDutRMXHAAzI86esrNwH+76+8LN19KCUhwdU/b8smtEqT8J7e
         tF9g==
X-Gm-Message-State: ANoB5pmA5MOyC1/NMbxx9ePHaZAf0nvSIRg7rLZwV/0xiq+CeMyVGpdz
        JNObAjfRg/H3oRQM0uxipEJj//jChn2lMw==
X-Google-Smtp-Source: AA0mqf4Hn+LnJNdhPwrPFWUhFWXsixlghXusLdty9oGmVKJYA1Hh9E9bL/uPYzqpSAo2da2yHtIaUoVFLSLhCw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:b81:b0:575:276b:d8c9 with SMTP
 id g1-20020a056a000b8100b00575276bd8c9mr46276896pfj.82.1670387605982; Tue, 06
 Dec 2022 20:33:25 -0800 (PST)
Date:   Wed,  7 Dec 2022 12:33:19 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207043319.1890954-1-davidgow@google.com>
Subject: [PATCH v2] Documentation: kunit: Fix "How Do I Use This" / "Next
 Steps" sections
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Rae Moar <rmoar@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     David Gow <davidgow@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
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

The "How Do I Use This" section of index.rst and "Next Steps" section of
start.rst were just copies of the table of contents, and therefore
weren't really useful either when looking a sphinx generated output
(which already had the TOC visible) or when reading the source (where
it's just a list of files that ls could give you).

Instead, provide a small number of concrete next steps, and a bit more
description about what the pages contain.

This also removes the broken reference to 'tips.rst', which was
previously removed.

Fixes: 4399c737a97d ("Documentation: kunit: Remove redundant 'tips.rst' page")
Signed-off-by: David Gow <davidgow@google.com>
---

Thanks everyone for reviewing v1. Since this is pretty much a complete
rewrite, I've left Reviewed-by tags off, as I don't feel the previous
reviews totally apply. Feel free to review again if you have any
comments.

Cheers,
-- David

Changes since v1:
https://lore.kernel.org/linux-kselftest/20221129094732.306449-1-davidgow@google.com/
- Totally rewrite both sections to only include (and provide more
  context for) the most concrete next steps.
  - Thanks Bagas for pointing out that this basically duplicates the TOC
    as-is.

---
 Documentation/dev-tools/kunit/index.rst | 19 ++++++++-----------
 Documentation/dev-tools/kunit/start.rst | 19 +++++++++----------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index d5629817cd72..b3593ae29ace 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -99,14 +99,11 @@ Read also :ref:`kinds-of-tests`.
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
+You can find a step-by-step guide to writing and running KUnit tests in
+Documentation/dev-tools/kunit/start.rst
+
+Alternatively, feel free to look through the rest of the KUnit documentation,
+or to experiment with tools/testing/kunit/kunit.py and the example test under
+lib/kunit/kunit-example-test.c
+
+Happy testing!
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index f4f504f1fb15..224387a43543 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -294,13 +294,12 @@ Congrats! You just wrote your first KUnit test.
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
+If you're interested in using some of the more advanced features of kunit.py,
+take a look at Documentation/dev-tools/kunit/run_wrapper.rst
+
+If you'd like to run tests without using kunit.py, check out
+Documentation/dev-tools/kunit/run_manual.rst
+
+For more information on writing KUnit tests (including some common techniques
+for testing different things), see Documentation/dev-tools/kunit/usage.rst
+
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

