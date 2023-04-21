Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236756EA28B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 06:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjDUEC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 00:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjDUECk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 00:02:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58B5251
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 21:02:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so3685875276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 21:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682049758; x=1684641758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHcf3TtAxqYUDjiNAmiyf7rcYOiQRzr3HgI4M/rAcaU=;
        b=vhOy+/6XGUNImozjW6uXE3awKrpBeiSgUUKudpv9mylXFGdVs6orwkvboBIKJ+gUSI
         fYZxsGRNlFm42JgTEFcUFLD1/1BFY8psdjXBoP38wBHcHbK+wyMHxCGzN+w61d7gytkU
         vu9cmM7aNMUhG0WLCVGBj+xxPFj9ebAu54bdHCIxwewn0vAO1Cqhp29CDwt7vEBNgg9Q
         jrC7EJhVkPl+hArDZNM17DQB7/02YtPjoh48F2mhv8wHzWaUCan39/Vnac6KexCLRV0V
         hXowYu8GYiC8PFpOmN/hmhw7rl1DR50qb8sDWApZ6QcE+iUGe+OnLapi388bUTfWh++g
         r0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682049758; x=1684641758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHcf3TtAxqYUDjiNAmiyf7rcYOiQRzr3HgI4M/rAcaU=;
        b=Ibi3Y3tfS4EGBWQlcwqcHBoO91yuj1WMs4fXU2ms93WDULBF0Tbmj2vLf0jSO8AO7g
         1pWrN6J1zOIkVnbXkDt1cXAkaWYqEVYFiaUIcDoZ62Pz/aAEoxG/2eSEo8Plqm3hKb8u
         vjLA4ZnyxOj8vz3vF5SyZG04TlOekJ8wWm0yw7mvjUb2ub7VUBE7i1pddakvjuuQ089i
         oQA96LCboKl4CQp6QjNG2WOD6esv+iO1bV5pFX0wx0FX1Mqtt28FCattI5ZrYecwoTz/
         LNJYHbT1O4Yc8S6CUBt53dQwdDgSant0TrylcTG7dZxsu2BTviAXOj0Yel3qHiATM0JG
         Kk7Q==
X-Gm-Message-State: AAQBX9f6Kf976AI8r8+pV0bN4aBnGzmrvPalmlqAMfy45QmdtNO1k9ZG
        ZDUKSPZTjc5lJhLa8TLLTaj8XrAgSKy4iA==
X-Google-Smtp-Source: AKy350Y54kiwT82AuAuLomhBMXGh6hDiOxSmVnuqZHCRGMCYguaPXyqmvOXzegJ/z1hHhEwjXIqd/8eSj0tc5g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:2b88:b0:54c:15ad:11e4 with SMTP
 id en8-20020a05690c2b8800b0054c15ad11e4mr897255ywb.0.1682049758080; Thu, 20
 Apr 2023 21:02:38 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:02:18 +0800
In-Reply-To: <20230421040218.2156548-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230421040218.2156548-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421040218.2156548-4-davidgow@google.com>
Subject: [PATCH v3 4/4] kunit: example: Provide example exit functions
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
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

Add an example .exit and .suite_exit function to the KUnit example
suite. Given exit functions are a bit more subtle than init functions
(due to running in a different kthread, and running even after tests or
test init functions fail), providing an easy place to experiment with
them is useful.

Signed-off-by: David Gow <davidgow@google.com>
---

This patch was introduced in v3.

---
 lib/kunit/kunit-example-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index cd8b7e51d02b..24315c882b31 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -41,6 +41,16 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This is run once after each test case, see the comment on
+ * example_test_suite for more information.
+ */
+static void example_test_exit(struct kunit *test)
+{
+	kunit_info(test, "cleaning up\n");
+}
+
+
 /*
  * This is run once before all test cases in the suite.
  * See the comment on example_test_suite for more information.
@@ -52,6 +62,16 @@ static int example_test_init_suite(struct kunit_suite *suite)
 	return 0;
 }
 
+/*
+ * This is run once after all test cases in the suite.
+ * See the comment on example_test_suite for more information.
+ */
+static void example_test_exit_suite(struct kunit_suite *suite)
+{
+	kunit_info(suite, "exiting suite\n");
+}
+
+
 /*
  * This test should always be skipped.
  */
@@ -211,7 +231,9 @@ static struct kunit_case example_test_cases[] = {
 static struct kunit_suite example_test_suite = {
 	.name = "example",
 	.init = example_test_init,
+	.exit = example_test_exit,
 	.suite_init = example_test_init_suite,
+	.suite_exit = example_test_exit_suite,
 	.test_cases = example_test_cases,
 };
 
-- 
2.40.0.634.g4ca3ef3211-goog

