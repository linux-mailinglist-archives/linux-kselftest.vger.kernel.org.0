Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B566EA285
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 06:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjDUEC2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 00:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDUEC0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 00:02:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9005840C7
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 21:02:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fc35ab48fso4405127b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 21:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682049744; x=1684641744;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o9d5prSVTa/w/iAx/0mRPU+MJNkirOzNMYWiYZtwtOw=;
        b=5qqiOD9JYyFpBBk6u/jB7iUcDv4aCe4LpP2tTwyJvFdy/RRC2Ydet8dhwQA02BIe6+
         xQFkxKU3Cb7FJKJPCKd7M/r72X3ddDsIyOeEQXjdVoHY5VbFoGq4pGTE8yTpsbgceLov
         Pb0YepRKcbUXq+QEl8ChusLCfRnbrHad+x0ennLc3phDdhOfazZhUZSWgwWap8OHNEXh
         Bm6pOZxhhSi3Jsrinee2ZSrkfrQeqz10Kg02iwIXt6Rdi0hF/nS0IDYJJxsPEGpzoTPS
         kcb4z+5nPSD7NiQCNTXfFB8h0bi6JB4Q2cLFuJZLRXSYedGs54zZVNNBo85EkTMh61vZ
         70CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682049744; x=1684641744;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9d5prSVTa/w/iAx/0mRPU+MJNkirOzNMYWiYZtwtOw=;
        b=G/GOfFumQeLZpqy/J8Impe0ELK3qvNKukqvFmqp96J2PwY25Y5zSqXopjluJZRi8p5
         o/mhcJk/KHYO75UT7uq7GnI8EoqY6uYWhVaEKS5jePssawT+3g06KB5/9aeCVEZN4PlI
         mO1Vnv5vD3F0XnG7MrukmCaUFTzrxcVQ6G76VjSAKjdlJG3ZUAvgjMTQzeLq9KuRsglW
         zIynXsTn0SOFIqpLzz3e913ySRYPrGY24x4ox8BUXjSdZQ/dM6hFXb7W+thIhuGvmkVh
         NWEsnPTJ4wiZ2It/ObwF9iLh/ahqp53du5r0IOzrNdn73r/BfnTIBYYvKxN9EkWO+oip
         kpGA==
X-Gm-Message-State: AAQBX9czSRxa9GoKNBgE1I+kJf4O+AiqRtPBIYsGJHyyVfc4I7tZ8L3B
        WXVfIbCmH8JlbeqUtadw9aXqQyGOAqBgOQ==
X-Google-Smtp-Source: AKy350auvqRIr2cxFc6OvBQ6nlmzF6QWoEWHmkIgQLzzTfkffTVCH4iJjocmiVjzpmkXW9Wc0DKBTyzP7KbROQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:450c:0:b0:545:883a:544d with SMTP id
 s12-20020a81450c000000b00545883a544dmr578383ywa.9.1682049743866; Thu, 20 Apr
 2023 21:02:23 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:02:15 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421040218.2156548-1-davidgow@google.com>
Subject: [PATCH v3 1/4] kunit: Always run cleanup from a test kthread
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit tests run in a kthread, with the current->kunit_test pointer set
to the test's context. This allows the kunit_get_current_test() and
kunit_fail_current_test() macros to work. Normally, this pointer is
still valid during test shutdown (i.e., the suite->exit function, and
any resource cleanup). However, if the test has exited early (e.g., due
to a failed assertion), the cleanup is done in the parent KUnit thread,
which does not have an active context.

Instead, in the event test terminates early, run the test exit and
cleanup from a new 'cleanup' kthread, which sets current->kunit_test,
and better isolates the rest of KUnit from issues which arise in test
cleanup.

If a test cleanup function itself aborts (e.g., due to an assertion
failing), there will be no further attempts to clean up: an error will
be logged and the test failed. For example:
	 # example_simple_test: test aborted during cleanup. continuing without cleaning up

This should also make it easier to get access to the KUnit context,
particularly from within resource cleanup functions, which may, for
example, need access to data in test->priv.

Signed-off-by: David Gow <davidgow@google.com>
---

This is an updated version of / replacement of "kunit: Set the current
KUnit context when cleaning up", which instead creates a new kthread
for cleanup tasks if the original test kthread is aborted. This protects
us from failed assertions during cleanup, if the test exited early.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20230419085426.1671703-1-davidgow@google.com/
- Always run cleanup in its own kthread
  - Therefore, never attempt to re-run it if it exits
  - Thanks, Benjamin.
Changes since v1:
https://lore.kernel.org/linux-kselftest/20230415091401.681395-1-davidgow@google.com/
- Move cleanup execution to another kthread
  - (Thanks, Benjamin, for pointing out the assertion issues)

---
 lib/kunit/test.c | 55 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e2910b261112..2025e51941e6 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -419,10 +419,50 @@ static void kunit_try_run_case(void *data)
 	 * thread will resume control and handle any necessary clean up.
 	 */
 	kunit_run_case_internal(test, suite, test_case);
-	/* This line may never be reached. */
+}
+
+static void kunit_try_run_case_cleanup(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+
+	current->kunit_test = test;
+
 	kunit_run_case_cleanup(test, suite);
 }
 
+static void kunit_catch_run_case_cleanup(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
+
+	/* It is always a failure if cleanup aborts. */
+	kunit_set_failure(test);
+
+	if (try_exit_code) {
+		/*
+		 * Test case could not finish, we have no idea what state it is
+		 * in, so don't do clean up.
+		 */
+		if (try_exit_code == -ETIMEDOUT) {
+			kunit_err(test, "test case cleanup timed out\n");
+		/*
+		 * Unknown internal error occurred preventing test case from
+		 * running, so there is nothing to clean up.
+		 */
+		} else {
+			kunit_err(test, "internal error occurred during test case cleanup: %d\n",
+				  try_exit_code);
+		}
+		return;
+	}
+
+	kunit_err(test, "test aborted during cleanup. continuing without cleaning up\n");
+}
+
+
 static void kunit_catch_run_case(void *data)
 {
 	struct kunit_try_catch_context *ctx = data;
@@ -448,12 +488,6 @@ static void kunit_catch_run_case(void *data)
 		}
 		return;
 	}
-
-	/*
-	 * Test case was run, but aborted. It is the test case's business as to
-	 * whether it failed or not, we just need to clean up.
-	 */
-	kunit_run_case_cleanup(test, suite);
 }
 
 /*
@@ -478,6 +512,13 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
+	/* Now run the cleanup */
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_try_run_case_cleanup,
+			     kunit_catch_run_case_cleanup);
+	kunit_try_catch_run(try_catch, &context);
+
 	/* Propagate the parameter result to the test case. */
 	if (test->status == KUNIT_FAILURE)
 		test_case->status = KUNIT_FAILURE;
-- 
2.40.0.634.g4ca3ef3211-goog

