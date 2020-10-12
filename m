Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABC28C4B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbgJLWVz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389479AbgJLWVz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:55 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DCC0613DA
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:40 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b195so622193pfb.9
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9Th6mUnf1orXMoZTMICnpRC/n4+G40+olevdzmz/HgE=;
        b=juTrzXlL2Q0Pwx2p4xz0BhaNDy7J5jjipurRYDi8Gl4v5DhfPH3YhWfYc6HUaUW0Y1
         Udm+/h3sP6kMWCsCN/QjuXUxoSkz6sib5GE66Foi1DY+1IOYUskvzJexEeccriN2I0F1
         XQlnzE8q5oSrP5ivcuZ2zPY06fTwC1tmmGDjyYzytEJSW+rEB/KL/zjogo+edLfjiTS5
         57jiEfGFvxYI+uwmCr7e77Mm1xzBeOrxMbikhmTAqeUB4x2dPGww8db48ovqLSRydlZH
         KrQKrM/DSgdgNpqZPxQPmbcR4aocrQemva1PtputWi9PjKRa7AU6UufUdZfYYrkhKFGc
         1QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9Th6mUnf1orXMoZTMICnpRC/n4+G40+olevdzmz/HgE=;
        b=GIDOm9GFGXtMmeRDQXfqACAPydcoTlbv62q9mtuVSGeq6dzBP+wQu5/XP3K5Wkss19
         Y4U3wCfGNrocjZ1iqx7woTR1tvTug05TH+dPHJxFK9u+AcaDrx+I2vSO0uka1DX3CDXa
         a6sx28Wmvr+XfhQwiIJACOyUbkqiJ1PjrqF/sHwzle6cwVqGcqfZ0cf05KSoBxUnihlF
         7X0w4UOFbnC11aTKlaMKOVVzeCl89y4R7Ee97qOH3Z9pFO+H7JMqGGa1Lurz1QdHOXVk
         WAESJUZupEnAAA1JArV3vAfZ/VRXdIg32VmwA5su5ikGYz/Zf8UewpW7QBIrLlrKsZdA
         Oa/g==
X-Gm-Message-State: AOAM530p4lfLHri+KC0V7E4otJpXYMln1i0PMFWxhDpG16jQZ4vAnMHo
        8hl/kqfo4RoKMp1XLekQ6dnjBQ0Z6f2Tnw==
X-Google-Smtp-Source: ABdhPJxdIiBhhKKuPn910V8JLEhKFAWzVKZJvQlUbkhuSeHIuyo1IdN4FoikCowbs2tdRCyZZ+HWO626m3+8+A==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:2e05:: with SMTP id
 q5mr706390pjd.0.1602541299837; Mon, 12 Oct 2020 15:21:39 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:50 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-13-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 12/12] kunit: mock: implement nice, strict and naggy mock distinctions
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

Nice mocks only fail when there is an expectation on a method, but none
match a given call. Strict mocks only pass when there is a matching
expectation for every call. Naggy mocks have the same pass/fail behavior
as nice, but report a warning in any case a strict mock would fail.

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/mock.h  |  63 ++++++++++++++++
 lib/kunit/mock-test.c | 171 ++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/mock.c      |  10 ++-
 3 files changed, 242 insertions(+), 2 deletions(-)

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index df99ae5ac721..12e70a3f82c5 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -95,10 +95,17 @@ struct mock_method {
 	struct list_head expectations;
 };
 
+enum mock_type {
+	MOCK_TYPE_NICE,
+	MOCK_TYPE_NAGGY,
+	MOCK_TYPE_STRICT
+};
+
 struct mock {
 	struct kunit_post_condition parent;
 	struct kunit *test;
 	struct list_head methods;
+	enum mock_type type;
 	/* TODO(brendanhiggins@google.com): add locking to do_expect. */
 	const void *(*do_expect)(struct mock *mock,
 				 const char *method_name,
@@ -108,6 +115,8 @@ struct mock {
 				 int len);
 };
 
+#define DEFAULT_MOCK_TYPE MOCK_TYPE_NAGGY
+
 void mock_init_ctrl(struct kunit *test, struct mock *mock);
 
 void mock_validate_expectations(struct mock *mock);
@@ -125,6 +134,60 @@ struct mock_expectation *mock_add_matcher(struct mock *mock,
 
 #define MOCK(name) name##_mock
 
+/**
+ * STRICT_MOCK() - sets the mock to be strict and returns the mock
+ * @mock: the mock
+ *
+ * For an example, see ``The Nice, the Strict, and the Naggy`` under
+ * ``Using KUnit``.
+ */
+#define STRICT_MOCK(mock) \
+({ \
+	mock_get_ctrl(mock)->type = MOCK_TYPE_STRICT; \
+	mock; \
+})
+
+static inline bool is_strict_mock(struct mock *mock)
+{
+	return mock->type == MOCK_TYPE_STRICT;
+}
+
+/**
+ * NICE_MOCK() - sets the mock to be nice and returns the mock
+ * @mock: the mock
+ *
+ * For an example, see ``The Nice, the Strict, and the Naggy`` under
+ * ``Using KUnit``.
+ */
+#define NICE_MOCK(mock) \
+({ \
+	mock_get_ctrl(mock)->type = MOCK_TYPE_NICE; \
+	mock; \
+})
+
+static inline bool is_nice_mock(struct mock *mock)
+{
+	return mock->type == MOCK_TYPE_NICE;
+}
+
+/**
+ * NAGGY_MOCK() - sets the mock to be naggy and returns the mock
+ * @mock: the mock
+ *
+ * For an example, see ``The Nice, the Strict, and the Naggy`` under
+ * ``Using KUnit``.
+ */
+#define NAGGY_MOCK(mock) \
+({ \
+	mock_get_ctrl(mock)->type = MOCK_TYPE_NAGGY; \
+	mock; \
+})
+
+static inline bool is_naggy_mock(struct mock *mock)
+{
+	return mock->type == MOCK_TYPE_NAGGY;
+}
+
 /**
  * KUNIT_EXPECT_CALL() - Declares a *call expectation* on a mock function.
  * @expectation_call: a mocked method or function with parameters replaced with
diff --git a/lib/kunit/mock-test.c b/lib/kunit/mock-test.c
index df0969b43ade..1c2aa2aa9c1b 100644
--- a/lib/kunit/mock-test.c
+++ b/lib/kunit/mock-test.c
@@ -243,6 +243,50 @@ static void mock_test_do_expect_default_return(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, expectation->times_called);
 }
 
+/**
+ * DOC: Testing the failure condition of different mock types.
+ *
+ * The following tests will test the behaviour of expectations under different
+ * conditions. For example, what happens when an expectation:
+ * - is not satisfied at the end of the test
+ * - is fulfilled but the expected function is called again
+ * - a function is called without expectations set on it
+ *
+ * For each of these conditions, there may be variations between the different
+ * types of mocks: nice mocks, naggy mocks (the default) and strict mocks.
+ *
+ * More information about these mocks can be found in the kernel documentation
+ * under Documentation/test/api/class-and-function-mocking
+ */
+
+/* Method called on strict mock with no expectations will fail */
+static void mock_test_strict_no_expectations_will_fail(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+	int param0 = 5, param1 = -5;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+
+	mock->type = MOCK_TYPE_STRICT;
+
+	mock_set_default_action(mock,
+				"add",
+				mock_add,
+				kunit_int_return(failing_test, -4));
+
+	mock->do_expect(mock,
+			"add",
+			mock_add,
+			two_param_types,
+			two_params,
+			ARRAY_SIZE(two_params));
+	mock_validate_expectations(mock);
+
+	KUNIT_EXPECT_FALSE(test, failing_test->success);
+}
+
 /*
  * Method called on naggy mock with no expectations will not fail, but will show
  * a warning message
@@ -257,6 +301,8 @@ static void mock_test_naggy_no_expectations_no_fail(struct kunit *test)
 	static const char * const two_param_types[] = {"int", "int"};
 	const void *two_params[] = {&param0, &param1};
 
+	mock->type = MOCK_TYPE_NAGGY;
+
 	mock_set_default_action(mock,
 				"add",
 				real_add,
@@ -282,6 +328,77 @@ static void mock_test_naggy_no_expectations_no_fail(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, failing_test->success);
 }
 
+/* Method called on nice mock with no expectations will do nothing. */
+static void mock_test_nice_no_expectations_do_nothing(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+	int param0 = 5, param1 = -5;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+
+	mock->type = MOCK_TYPE_NICE;
+
+	mock->do_expect(mock,
+			"add",
+			mock_add,
+			two_param_types,
+			two_params,
+			ARRAY_SIZE(two_params));
+	mock_validate_expectations(mock);
+
+	KUNIT_EXPECT_TRUE(test, failing_test->success);
+}
+
+/* Test that method called on a mock (of any type) with no matching expectations
+ * will fail test and print all the tried expectations.
+ */
+static void
+run_method_called_but_no_matching_expectation_test(struct kunit *test,
+						   enum mock_type mock_type)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+	int param0 = 5, param1 = -5;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+	struct mock_param_matcher *two_matchers[] = {
+		kunit_int_eq(failing_test, 100),
+		kunit_int_eq(failing_test, 100)
+	};
+
+	mock_add_matcher(mock, "add", mock_add, two_matchers,
+			 ARRAY_SIZE(two_matchers));
+
+	mock->type = mock_type;
+
+	mock->do_expect(mock, "add", mock_add, two_param_types, two_params,
+			ARRAY_SIZE(two_params));
+
+	/* Even nice mocks should fail if there's an unmet expectation. */
+	KUNIT_EXPECT_FALSE(test, failing_test->success);
+}
+
+static void mock_test_naggy_no_matching_expectations_fail(struct kunit *test)
+{
+	run_method_called_but_no_matching_expectation_test(test,
+							   MOCK_TYPE_NAGGY);
+}
+
+static void mock_test_strict_no_matching_expectations_fail(struct kunit *test)
+{
+	run_method_called_but_no_matching_expectation_test(test,
+							   MOCK_TYPE_STRICT);
+}
+
+static void mock_test_nice_no_matching_expectations_fail(struct kunit *test)
+{
+	run_method_called_but_no_matching_expectation_test(test,
+							   MOCK_TYPE_NICE);
+}
+
 static void mock_test_mock_validate_expectations(struct kunit *test)
 {
 	struct mock_test_context *ctx = test->priv;
@@ -309,6 +426,54 @@ static void mock_test_mock_validate_expectations(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, failing_test->success);
 }
 
+static void mock_test_validate_clears_expectations(struct kunit *test)
+{
+	struct mock_test_context *ctx = test->priv;
+	struct kunit *failing_test = ctx->failing_test;
+	struct mock *mock = ctx->mock;
+	struct mock_param_matcher *matchers[] = {
+		kunit_int_eq(failing_test, 5),
+		kunit_int_eq(failing_test, -4)
+	};
+	int param0 = 5, param1 = -4;
+	static const char * const two_param_types[] = {"int", "int"};
+	const void *two_params[] = {&param0, &param1};
+
+	struct mock_expectation *expectation;
+
+	mock->type = MOCK_TYPE_STRICT;
+
+	/* Add an arbitrary matcher for 0 calls */
+	expectation = mock_add_matcher(mock, "add", mock_add,
+				       matchers, ARRAY_SIZE(matchers));
+	expectation->times_called = 0;
+	expectation->min_calls_expected = 0;
+	expectation->max_calls_expected = 0;
+
+	/* Should have 0 calls and should clear the previous expectation */
+	mock_validate_expectations(mock);
+
+	/* Add a new matcher for 1 call */
+	expectation = mock_add_matcher(mock, "add", mock_add,
+				       matchers, ARRAY_SIZE(matchers));
+	expectation->times_called = 0;
+	expectation->min_calls_expected = 1;
+	expectation->max_calls_expected = 1;
+
+	/* Satisfy previous matcher */
+	mock->do_expect(mock, "add", mock_add, two_param_types, two_params,
+			ARRAY_SIZE(two_params));
+
+	/*
+	 * Validate previous satisfy; if we didn't clear the previous
+	 * expectation, it would fail the mock_test.
+	 */
+	mock_validate_expectations(mock);
+
+	/* If all goes well, shouldn't fail the test. */
+	KUNIT_EXPECT_TRUE(test, failing_test->success);
+}
+
 static int mock_test_init(struct kunit *test)
 {
 	struct mock_test_context *ctx;
@@ -346,7 +511,13 @@ static struct kunit_case mock_test_cases[] = {
 	KUNIT_CASE(mock_test_failed_expect_call_fails_test),
 	KUNIT_CASE(mock_test_do_expect_default_return),
 	KUNIT_CASE(mock_test_mock_validate_expectations),
+	KUNIT_CASE(mock_test_strict_no_expectations_will_fail),
 	KUNIT_CASE(mock_test_naggy_no_expectations_no_fail),
+	KUNIT_CASE(mock_test_nice_no_expectations_do_nothing),
+	KUNIT_CASE(mock_test_strict_no_matching_expectations_fail),
+	KUNIT_CASE(mock_test_naggy_no_matching_expectations_fail),
+	KUNIT_CASE(mock_test_nice_no_matching_expectations_fail),
+	KUNIT_CASE(mock_test_validate_clears_expectations),
 	{}
 };
 
diff --git a/lib/kunit/mock.c b/lib/kunit/mock.c
index 12fb88899451..f1fa7a5b9dd4 100644
--- a/lib/kunit/mock.c
+++ b/lib/kunit/mock.c
@@ -85,6 +85,7 @@ void mock_init_ctrl(struct kunit *test, struct mock *mock)
 	mock->test = test;
 	INIT_LIST_HEAD(&mock->methods);
 	mock->do_expect = mock_do_expect;
+	mock->type = DEFAULT_MOCK_TYPE;
 	mock->parent.validate = mock_validate_wrapper;
 	list_add_tail(&mock->parent.node, &test->post_conditions);
 }
@@ -283,7 +284,12 @@ static struct mock_expectation *mock_apply_expectations(
 		mock_add_method_expectation_error(test, stream,
 			"Method was called with no expectations declared: ",
 			mock, method, type_names, params, len);
-		kunit_stream_commit(stream);
+		if (is_strict_mock(mock))
+			fail_and_flush(test, stream);
+		else if (is_naggy_mock(mock))
+			kunit_stream_commit(stream);
+		else
+			kunit_stream_clear(stream);
 		return NULL;
 	}
 
@@ -313,7 +319,7 @@ static struct mock_expectation *mock_apply_expectations(
 		}
 	}
 
-	if (expectations_all_saturated) {
+	if (expectations_all_saturated && !is_nice_mock(mock)) {
 		mock_add_method_expectation_error(test, stream,
 			"Method was called with fully saturated expectations: ",
 			mock, method, type_names, params, len);
-- 
2.28.0.1011.ga647a8990f-goog

