Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D050393E4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 10:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhE1ICg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 May 2021 04:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbhE1ICE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 May 2021 04:02:04 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD9C061760
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 00:59:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a7-20020a05622a02c7b02901fbef073c99so1669556qtx.15
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eQHu2YdWATuwRdd03+33a1i15kG3qW3lUQiAO7CgbYM=;
        b=WbYbq3S49gzHHeCT4z1fGJmZKXEZI0AUV4OUBbBeqYD0nqxQlhXriGu9WFhE2TWEsa
         AGihSouN7nLW8cSmND1AGcxaM9Jq3J2PvtUypUHakxo1D2RySovKCzUmMAP4+TH2qjf7
         ueniZOAUXvX1FSEphD5vMaKGLcALTMBtiMoz7b8XvN/gPI4JWp5ejto2vRQi1l34Iq/k
         LB+lLQVjRTVgl5RIrZeNr8okG7kYihoUlQ68hHkDW9akb38p3xi0Em6nJtF4O7281Jk0
         e0uor5azoYL+3TDTuPut/fZcNf1+nICMStUCcV1hGAtKd3v3nAczxaV+0mJFkFHRr/Yg
         khPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eQHu2YdWATuwRdd03+33a1i15kG3qW3lUQiAO7CgbYM=;
        b=JsXubQnqbH5VLzihS94KrZ316i3cAW+hzugJMleYi1uLQTlv1qurDNoMHllw+tA+AR
         Aotw4TdGEREeDpWmwAIH2Ne3k/Q0EjiC93e2vPEhubuys/4Zj+MiiHSFsOO7I2H7VQIp
         TilQkoAaJMXMqi9zXCjChNa/Ic4rWAcEfoMb+MYysti2nz6XcXI8oY1Nnch/vuyJNQFG
         gnTya991PIkYdQzI7+QsxLYze0DGUkdKUhWe1cA4YVafapUXzLo3dCfYKDu7UwgnsQM9
         OsIENMACEykXtQ1L+AHZ6MlzZxJNH26cxQ95oEVNNRfOIh6hDVtmwRGi+CZwOBJ8zrSA
         O6Cw==
X-Gm-Message-State: AOAM531Cdcdizwzz6k7mt16BWDI5UcdPRQ3eJyxHYHkmbpFChpxSd1Gi
        ReZtxgboPIXXVhDisygH7K/FvoGhayAxNQ==
X-Google-Smtp-Source: ABdhPJwdlbBkTjSZEB2JTLX98zimYFThcL5s2BVzI+8+ChDFzyXtBcfXEcKUcVTUABdxQ9tpIFcBD+ipVkl96g==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:621b:e8e2:f86a:41f])
 (user=davidgow job=sendgmr) by 2002:a0c:f642:: with SMTP id
 s2mr2713238qvm.32.1622188777804; Fri, 28 May 2021 00:59:37 -0700 (PDT)
Date:   Fri, 28 May 2021 00:59:29 -0700
Message-Id: <20210528075932.347154-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 1/4] kunit: Support skipped tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit_mark_skipped() macro marks the current test as "skipped", with
the provided reason. The kunit_skip() macro will mark the test as
skipped, and abort the test.

The TAP specification supports this "SKIP directive" as a comment after
the "ok" / "not ok" for a test. See the "Directives" section of the TAP
spec for details:
https://testanything.org/tap-specification.html#directives

The 'success' field for KUnit tests is replaced with a kunit_status
enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
'status_comment' containing information on why a test was skipped.

A new 'kunit_status' test suite is added to test this.

Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Marco Elver <elver@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210526081112.3652290-1-davidgow@google.com/
- Renamed kunit_status_to_string() to kunit_status_to_ok_not_ok
- Fixed incorrect printing of status comments on non-skipped tests.

Not changes:
- Still using kunit_log(KERN_INFO,...) instead of kunit_info() as it
  seems to be consistently used for printing results in the KUnit code.

 include/kunit/test.h   | 68 ++++++++++++++++++++++++++++++++++++++----
 lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++-
 lib/kunit/test.c       | 51 ++++++++++++++++++-------------
 3 files changed, 134 insertions(+), 27 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b68c61348121..1401c620ac5e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -105,6 +105,18 @@ struct kunit;
 #define KUNIT_SUBTEST_INDENT		"    "
 #define KUNIT_SUBSUBTEST_INDENT		"        "
 
+/**
+ * enum kunit_status - Type of result for a test or test suite
+ * @KUNIT_SUCCESS: Denotes the test suite has not failed nor been skipped
+ * @KUNIT_FAILURE: Denotes the test has failed.
+ * @KUNIT_SKIPPED: Denotes the test has been skipped.
+ */
+enum kunit_status {
+	KUNIT_SUCCESS,
+	KUNIT_FAILURE,
+	KUNIT_SKIPPED,
+};
+
 /**
  * struct kunit_case - represents an individual test case.
  *
@@ -148,13 +160,20 @@ struct kunit_case {
 	const void* (*generate_params)(const void *prev, char *desc);
 
 	/* private: internal use only. */
-	bool success;
+	enum kunit_status status;
 	char *log;
 };
 
-static inline char *kunit_status_to_string(bool status)
+static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 {
-	return status ? "ok" : "not ok";
+	switch (status) {
+	case KUNIT_SKIPPED:
+	case KUNIT_SUCCESS:
+		return "ok";
+	case KUNIT_FAILURE:
+		return "not ok";
+	}
+	return "invalid";
 }
 
 /**
@@ -212,6 +231,7 @@ struct kunit_suite {
 	struct kunit_case *test_cases;
 
 	/* private: internal use only */
+	char status_comment[256];
 	struct dentry *debugfs;
 	char *log;
 };
@@ -245,19 +265,21 @@ struct kunit {
 	 * be read after the test case finishes once all threads associated
 	 * with the test case have terminated.
 	 */
-	bool success; /* Read only after test_case finishes! */
 	spinlock_t lock; /* Guards all mutable test state. */
+	enum kunit_status status; /* Read only after test_case finishes! */
 	/*
 	 * Because resources is a list that may be updated multiple times (with
 	 * new resources) from any thread associated with a test case, we must
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+
+	char status_comment[256];
 };
 
 static inline void kunit_set_failure(struct kunit *test)
 {
-	WRITE_ONCE(test->success, false);
+	WRITE_ONCE(test->status, KUNIT_FAILURE);
 }
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
@@ -348,7 +370,7 @@ static inline int kunit_run_all_tests(void)
 #define kunit_suite_for_each_test_case(suite, test_case)		\
 	for (test_case = suite->test_cases; test_case->run_case; test_case++)
 
-bool kunit_suite_has_succeeded(struct kunit_suite *suite);
+enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
 
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
@@ -612,6 +634,40 @@ void kunit_cleanup(struct kunit *test);
 
 void kunit_log_append(char *log, const char *fmt, ...);
 
+/**
+ * kunit_mark_skipped() - Marks @test_or_suite as skipped
+ *
+ * @test_or_suite: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Marks the test as skipped. @fmt is given output as the test status
+ * comment, typically the reason the test was skipped.
+ *
+ * Test execution continues after kunit_mark_skipped() is called.
+ */
+#define kunit_mark_skipped(test_or_suite, fmt, ...)			\
+	do {								\
+		WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);	\
+		scnprintf((test_or_suite)->status_comment, 256, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+/**
+ * kunit_skip() - Marks @test_or_suite as skipped
+ *
+ * @test_or_suite: The test context object.
+ * @fmt:  A printk() style format string.
+ *
+ * Skips the test. @fmt is given output as the test status
+ * comment, typically the reason the test was skipped.
+ *
+ * Test execution is halted after kunit_skip() is called.
+ */
+#define kunit_skip(test_or_suite, fmt, ...)				\
+	do {								\
+		kunit_mark_skipped((test_or_suite), fmt, ##__VA_ARGS__);\
+		kunit_try_catch_throw(&((test_or_suite)->try_catch));	\
+	} while (0)
+
 /*
  * printk and log to per-test or per-suite log buffer.  Logging only done
  * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 69f902440a0e..d69efcbed624 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -437,7 +437,47 @@ static void kunit_log_test(struct kunit *test)
 #endif
 }
 
+static void kunit_status_set_failure_test(struct kunit *test)
+{
+	struct kunit fake;
+
+	kunit_init_test(&fake, "fake test", NULL);
+
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SUCCESS);
+	kunit_set_failure(&fake);
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
+}
+
+static void kunit_status_mark_skipped_test(struct kunit *test)
+{
+	struct kunit fake;
+
+	kunit_init_test(&fake, "fake test", NULL);
+
+	/* Before: Should be SUCCESS with no comment. */
+	KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
+	KUNIT_EXPECT_STREQ(test, fake.status_comment, "");
+
+	/* Mark the test as skipped. */
+	kunit_mark_skipped(&fake, "Accepts format string: %s", "YES");
+
+	/* After: Should be SKIPPED with our comment. */
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_SKIPPED);
+	KUNIT_EXPECT_STREQ(test, fake.status_comment, "Accepts format string: YES");
+}
+
+static struct kunit_case kunit_status_test_cases[] = {
+	KUNIT_CASE(kunit_status_set_failure_test),
+	KUNIT_CASE(kunit_status_mark_skipped_test),
+	{}
+};
+
+static struct kunit_suite kunit_status_test_suite = {
+	.name = "kunit_status",
+	.test_cases = kunit_status_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
-		  &kunit_log_test_suite);
+		  &kunit_log_test_suite, &kunit_status_test_suite);
 
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 2f6cc0123232..8ce0c8fddb96 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -98,12 +98,14 @@ static void kunit_print_subtest_start(struct kunit_suite *suite)
 
 static void kunit_print_ok_not_ok(void *test_or_suite,
 				  bool is_test,
-				  bool is_ok,
+				  enum kunit_status status,
 				  size_t test_number,
-				  const char *description)
+				  const char *description,
+				  const char *directive)
 {
 	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
 	struct kunit *test = is_test ? test_or_suite : NULL;
+	const char *directive_header = (status == KUNIT_SKIPPED) ? " # SKIP " : "";
 
 	/*
 	 * We do not log the test suite results as doing so would
@@ -114,25 +116,31 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s\n",
-			kunit_status_to_string(is_ok),
-			test_number, description);
+		pr_info("%s %zd - %s%s%s\n",
+			kunit_status_to_ok_not_ok(status),
+			test_number, description, directive_header,
+			(status == KUNIT_SKIPPED) ? directive : "");
 	else
-		kunit_log(KERN_INFO, test, KUNIT_SUBTEST_INDENT "%s %zd - %s",
-			  kunit_status_to_string(is_ok),
-			  test_number, description);
+		kunit_log(KERN_INFO, test,
+			  KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
+			  kunit_status_to_ok_not_ok(status),
+			  test_number, description, directive_header,
+			  (status == KUNIT_SKIPPED) ? directive : "");
 }
 
-bool kunit_suite_has_succeeded(struct kunit_suite *suite)
+enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 {
 	const struct kunit_case *test_case;
+	enum kunit_status status = KUNIT_SKIPPED;
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-		if (!test_case->success)
-			return false;
+		if (test_case->status == KUNIT_FAILURE)
+			return KUNIT_FAILURE;
+		else if (test_case->status == KUNIT_SUCCESS)
+			status = KUNIT_SUCCESS;
 	}
 
-	return true;
+	return status;
 }
 EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
 
@@ -143,7 +151,8 @@ static void kunit_print_subtest_end(struct kunit_suite *suite)
 	kunit_print_ok_not_ok((void *)suite, false,
 			      kunit_suite_has_succeeded(suite),
 			      kunit_suite_counter++,
-			      suite->name);
+			      suite->name,
+			      suite->status_comment);
 }
 
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
@@ -252,7 +261,8 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 	test->log = log;
 	if (test->log)
 		test->log[0] = '\0';
-	test->success = true;
+	test->status = KUNIT_SUCCESS;
+	test->status_comment[0] = '\0';
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
@@ -376,7 +386,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
-	test_case->success = test->success;
+	test_case->status = test->status;
+
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
@@ -388,7 +399,6 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
-		bool test_success = true;
 
 		if (test_case->generate_params) {
 			/* Get initial param. */
@@ -398,7 +408,6 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		do {
 			kunit_run_case_catch_errors(suite, test_case, &test);
-			test_success &= test_case->success;
 
 			if (test_case->generate_params) {
 				if (param_desc[0] == '\0') {
@@ -410,7 +419,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 					  KUNIT_SUBTEST_INDENT
 					  "# %s: %s %d - %s",
 					  test_case->name,
-					  kunit_status_to_string(test.success),
+					  kunit_status_to_ok_not_ok(test.status),
 					  test.param_index + 1, param_desc);
 
 				/* Get next param. */
@@ -420,9 +429,10 @@ int kunit_run_tests(struct kunit_suite *suite)
 			}
 		} while (test.param_value);
 
-		kunit_print_ok_not_ok(&test, true, test_success,
+		kunit_print_ok_not_ok(&test, true, test_case->status,
 				      kunit_test_case_num(suite, test_case),
-				      test_case->name);
+				      test_case->name,
+				      test.status_comment);
 	}
 
 	kunit_print_subtest_end(suite);
@@ -434,6 +444,7 @@ EXPORT_SYMBOL_GPL(kunit_run_tests);
 static void kunit_init_suite(struct kunit_suite *suite)
 {
 	kunit_debugfs_create_suite(suite);
+	suite->status_comment[0] = '\0';
 }
 
 int __kunit_test_suites_init(struct kunit_suite * const * const suites)
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

