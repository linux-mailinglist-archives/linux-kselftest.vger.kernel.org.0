Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785E96FD63E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 07:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEJFik (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 01:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJFij (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 01:38:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A3273D
        for <linux-kselftest@vger.kernel.org>; Tue,  9 May 2023 22:38:38 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643a9203dc2so3509269b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 May 2023 22:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683697118; x=1686289118;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sgUiCgU3PluO8I1muuqpEf3Ia4SIHEPSkMyiMMz9or4=;
        b=JKhkMANCdve8/KBZ4tWsLrb35Ucn/9dbb9jOBv/cRu6xQ/8H3lm0z/6DMAVTLAIzaw
         wkNm5xjm+/pjNc1SnszT3K4+5jNChom8yxYBZwbbIixJvKEh+sgePhKMCaTzfHtUeUaT
         gvod4z/BVz2J2+2WuGUi+SU7x1j0FYs7nO0M6QiVJH68DVPP5I9TGulaAFihJjXjnYnM
         oq9j5k/J4FDucGgQU4ZJQRRxegTkCqM/DJ1hK+Yl2Sbt6MSyxfoZjQ0TD/okUUhNfqx/
         rH6mAiZWWIXzFtImVi9wK8jQkVNqZ6dqYr3l9sVgJNGaqmXd2QXSh/EYgzNqiWHDloGY
         yrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697118; x=1686289118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgUiCgU3PluO8I1muuqpEf3Ia4SIHEPSkMyiMMz9or4=;
        b=ObJGBNm4o9Erau2Jxn+rZNakSjyCcwf7hkhT7OyIM3UWm5tBSFI6MergPHsqON22Z5
         Lx8SVToP/IJAVYuD15YDbV4PQCQzWhZbRGGj5nmV6MAGJjCbtGGbxKw/NdfqKbptQ+YU
         nc6uBG3jDKcvUhMWiZYa0FRVcB4x114QgEoDiMiHAEewDrjCy+0EHycunbMrGYOgB05D
         XLoHjt8fkNsz6sdWDhpXUJJxJLQCKJMQrLA5HFsi3VjD3FShLnWSE1OlJDYn+8hdKByQ
         6nZmpRyHwwk+vzgOPHdp/a9sWEaABzhdqIisjCGquY87KABoqnE/Rz8sO7mVm5g5CR+S
         /51g==
X-Gm-Message-State: AC+VfDx+eQsJDWVWpsuhSesSXqciqUYQpIa2v1BcsmEyfU55q457ygR/
        izEaniBy96DH2zAKdJHEZ/6MhdW9UNtIOA==
X-Google-Smtp-Source: ACHHUZ7vHZ8F8rpi4vKX8dfvMN6thxrKRmRi02Tukl1XOtNa2jsns36iWDO8yi0vzcNoxWchQEjeYLQNwfQc0w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:d5a:b0:643:536b:e764 with SMTP
 id n26-20020a056a000d5a00b00643536be764mr4660893pfv.4.1683697118051; Tue, 09
 May 2023 22:38:38 -0700 (PDT)
Date:   Wed, 10 May 2023 13:38:29 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510053832.438529-1-davidgow@google.com>
Subject: [PATCH v4 1/4] kunit: Always run cleanup from a test kthread
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>,
        Benjamin Berg <benjamin.berg@intel.com>
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

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: David Gow <davidgow@google.com>
---

This is an updated version of / replacement for "kunit: Set the current
KUnit context when cleaning up", which instead creates a new kthread
for cleanup tasks if the original test kthread is aborted. This protects
us from failed assertions during cleanup, if the test exited early.

Changes since v3:
https://lore.kernel.org/all/20230421040218.2156548-1-davidgow@google.com/
- Get rid of a unused 'suite' variable (kernel test robot)
- Add Benjamin and Maxime's Reviewed-by tags.

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
 lib/kunit/test.c | 56 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e2910b261112..f5e4ceffd282 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -419,15 +419,54 @@ static void kunit_try_run_case(void *data)
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
 	struct kunit *test = ctx->test;
-	struct kunit_suite *suite = ctx->suite;
 	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
 
 	if (try_exit_code) {
@@ -448,12 +487,6 @@ static void kunit_catch_run_case(void *data)
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
@@ -478,6 +511,13 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
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
2.40.1.521.gf1e218fcd8-goog

