Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8F451536D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379925AbiD2SQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 14:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379716AbiD2SQ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 14:16:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0705B1AB3
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 11:13:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 9-20020a250909000000b006484b89c979so7976845ybj.21
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tmbVGyHWnlJ8gG/+aK542d489GBFQrAnhxibyOD20PI=;
        b=oJkYYWfPlFNxpWPKmes11c1uNsw36Qs4NyVSb4xnhl0owZ1v4+hgfLggkUVwqsJ3OG
         kuBHGef7/XMigHi8T41U9jwE1Ws6eDYQTpp064jpFj4chi+Cg9Vrj+JUYaYCBJLHUuAg
         N+0gyLbeNlL0JMYVyMP/saHiHBqZjscUPKB3hGTRSQVtxqCZlVYD5GBn1I5+InfsnzzG
         ndMuGEOmgbI+lLCbNJEmnEwNZI8J5NtwSvkvbUq4VmKSz5qmfArHKGpQmdMB6vmSnltF
         ttYRr5qnEeiYSsjRqWwSvkyGbYxXQMZn3MyFjUThDidxkUwLlZlwIpEmPReoE0LsOH27
         SBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tmbVGyHWnlJ8gG/+aK542d489GBFQrAnhxibyOD20PI=;
        b=HtNDIPkgV9OIM0QGJeeTHKBUIceUTRG6eswuDeYg1r8SmPkkj1cRViJm/GrfPIRkS9
         fdiJL7LIqnMAkbemwfubbgTN4BOhls+aJYVYUmi9PJBl0ABAA5TamTIm61usIcTWGJay
         zC1f//KlHwz7Aynzus6BpkEcLo9lvCgkse4mdCMCGaMRkvSbhW/lTyxsUP+h3Xl5F+cM
         8mtI+/o4pNfNAwMpvyIDwkTm8EOhwUC0rFvlz8mgVruKuAKZr7pdog1czitTQEMeVbe5
         CTIwEp9HXRevORap2iw18LpVzzEDEWULvgXJPvsD067kF1n2ATA8dCghYUcWwkCOARl5
         0mLg==
X-Gm-Message-State: AOAM531mTJ+YhOPzMgATTqEUaEB33EM8t8NROU8i7XdyqO0G/G2WCXoF
        zzPVISsLgKM1gpYzyZQZbrG4bd7mbDg4WA==
X-Google-Smtp-Source: ABdhPJwfn6H3jkDfOm0T0xVJq/twaeRoLLoSnqOpELQeWQzr18SW0bB8RsYlvRfz3T/MANKfSOVv2GQsfAeXqA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:183a:36d7:2dcb:1773])
 (user=dlatypov job=sendgmr) by 2002:a81:6a46:0:b0:2f4:dc3f:e8f8 with SMTP id
 f67-20020a816a46000000b002f4dc3fe8f8mr579331ywc.292.1651255988924; Fri, 29
 Apr 2022 11:13:08 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:12:57 -0700
In-Reply-To: <20220429181259.622060-1-dlatypov@google.com>
Message-Id: <20220429181259.622060-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 2/4] kunit: add ability to specify suite-level init and
 exit functions
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
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

KUnit has support for setup/cleanup logic for each test case in a suite.
But it lacks the ability to specify setup/cleanup for the entire suite
itself.

This can be used to do setup that is too expensive or cumbersome to do
for each test.
Or it can be used to do simpler things like log debug information after
the suite completes.
It's a fairly common feature, so the lack of it is noticeable.

Some examples in other frameworks and languages:
* https://docs.python.org/3/library/unittest.html#setupclass-and-teardownclass
* https://google.github.io/googletest/reference/testing.html#Test::SetUpTestSuite

Meta:
This is very similar to this patch here: https://lore.kernel.org/linux-kselftest/20210805043503.20252-3-bvanassche@acm.org/
The changes from that patch:
* pass in `struct kunit *` so users can do stuff like
  `kunit_info(suite, "debug message")`
* makes sure the init failure is bubbled up as a failure
* updates kunit-example-test.c to use a suite init
* Updates kunit/usage.rst to mention the new support
* some minor cosmetic things
  * use `suite_{init,exit}` instead of `{init/exit}_suite`
  * make suite init error message more consistent w/ test init
  * etc.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: add suite_init_err to struct kunit_suite so
kunit_suite_has_succeeded() still works for CONFIG_KUNIT_DEBUGFS=y.
---
 Documentation/dev-tools/kunit/usage.rst | 19 +++++++++++--------
 include/kunit/test.h                    |  5 +++++
 lib/kunit/kunit-example-test.c          | 14 ++++++++++++++
 lib/kunit/test.c                        | 17 +++++++++++++++++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 1c83e7d60a8a..d62a04255c2e 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -125,8 +125,8 @@ We need many test cases covering all the unit's behaviors. It is common to have
 many similar tests. In order to reduce duplication in these closely related
 tests, most unit testing frameworks (including KUnit) provide the concept of a
 *test suite*. A test suite is a collection of test cases for a unit of code
-with a setup function that gets invoked before every test case and then a tear
-down function that gets invoked after every test case completes. For example:
+with optional setup and teardown functions that run before/after the whole
+suite and/or every test case. For example:
 
 .. code-block:: c
 
@@ -141,16 +141,19 @@ down function that gets invoked after every test case completes. For example:
 		.name = "example",
 		.init = example_test_init,
 		.exit = example_test_exit,
+		.suite_init = example_suite_init,
+		.suite_exit = example_suite_exit,
 		.test_cases = example_test_cases,
 	};
 	kunit_test_suite(example_test_suite);
 
-In the above example, the test suite ``example_test_suite`` would run the test
-cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``. Each
-would have ``example_test_init`` called immediately before it and
-``example_test_exit`` called immediately after it.
-``kunit_test_suite(example_test_suite)`` registers the test suite with the
-KUnit test framework.
+In the above example, the test suite ``example_test_suite`` would first run
+``example_suite_init``, then run the test cases ``example_test_foo``,
+``example_test_bar``, and ``example_test_baz``. Each would have
+``example_test_init`` called immediately before it and ``example_test_exit``
+called immediately after it. Finally, ``example_suite_exit`` would be called
+after everything else. ``kunit_test_suite(example_test_suite)`` registers the
+test suite with the KUnit test framework.
 
 .. note::
    A test case will only run if it is associated with a test suite.
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 97cd76461886..604eb5263b6b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -153,6 +153,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
  * @name:	the name of the test. Purely informational.
+ * @suite_init:	called once per test suite before the test cases.
+ * @suite_exit:	called once per test suite after all test cases.
  * @init:	called before every test case.
  * @exit:	called after every test case.
  * @test_cases:	a null terminated array of test cases.
@@ -167,6 +169,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 struct kunit_suite {
 	const char name[256];
+	int (*suite_init)(struct kunit_suite *suite);
+	void (*suite_exit)(struct kunit_suite *suite);
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
@@ -175,6 +179,7 @@ struct kunit_suite {
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
 	struct dentry *debugfs;
 	char *log;
+	int suite_init_err;
 };
 
 /**
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 91b1df7f59ed..f8fe582c9e36 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -40,6 +40,17 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This is run once before all test cases in the suite.
+ * See the comment on example_test_suite for more information.
+ */
+static int example_test_init_suite(struct kunit_suite *suite)
+{
+	kunit_info(suite, "initializing suite\n");
+
+	return 0;
+}
+
 /*
  * This test should always be skipped.
  */
@@ -142,17 +153,20 @@ static struct kunit_case example_test_cases[] = {
  * may be specified which runs after every test case and can be used to for
  * cleanup. For clarity, running tests in a test suite would behave as follows:
  *
+ * suite.suite_init(suite);
  * suite.init(test);
  * suite.test_case[0](test);
  * suite.exit(test);
  * suite.init(test);
  * suite.test_case[1](test);
  * suite.exit(test);
+ * suite.suite_exit(suite);
  * ...;
  */
 static struct kunit_suite example_test_suite = {
 	.name = "example",
 	.init = example_test_init,
+	.suite_init = example_test_init_suite,
 	.test_cases = example_test_cases,
 };
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 64ee6a9d8003..65c56bd0545d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -179,6 +179,9 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 	const struct kunit_case *test_case;
 	enum kunit_status status = KUNIT_SKIPPED;
 
+	if (suite->suite_init_err)
+		return KUNIT_FAILURE;
+
 	kunit_suite_for_each_test_case(suite, test_case) {
 		if (test_case->status == KUNIT_FAILURE)
 			return KUNIT_FAILURE;
@@ -498,6 +501,15 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	if (suite->suite_init) {
+		suite->suite_init_err = suite->suite_init(suite);
+		if (suite->suite_init_err) {
+			kunit_err(suite, KUNIT_SUBTEST_INDENT
+				  "# failed to initialize (%d)", suite->suite_init_err);
+			goto suite_end;
+		}
+	}
+
 	kunit_print_suite_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
@@ -551,7 +563,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 		kunit_accumulate_stats(&total_stats, param_stats);
 	}
 
+	if (suite->suite_exit)
+		suite->suite_exit(suite);
+
 	kunit_print_suite_stats(suite, suite_stats, total_stats);
+suite_end:
 	kunit_print_suite_end(suite);
 
 	return 0;
@@ -562,6 +578,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 {
 	kunit_debugfs_create_suite(suite);
 	suite->status_comment[0] = '\0';
+	suite->suite_init_err = 0;
 }
 
 int __kunit_test_suites_init(struct kunit_suite * const * const suites)
-- 
2.36.0.464.gb9c8b46e94-goog

