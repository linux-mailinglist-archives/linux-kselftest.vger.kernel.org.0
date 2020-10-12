Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140BB28C4A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbgJLWVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389089AbgJLWVb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A70C0613D1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:30 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h20so12812996plr.9
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Z3QVbAjMYxj66ovZUFsdaRDaJ7wZm9Xl11qUB+7r03M=;
        b=EuSupCzG5goN5TFEGNYQXlb4FbnumPbXvngNvSG9wU1eQCdBWKErIl9g9WwOTlZCht
         ErJnnaCAG3NavaIhkBevZ8Bdtn6+gAGOBTghHedsBJ+cRR3fWR+kObgDerRmmPu3lrqj
         kNKOKhcBlMfuk1XKDXFR0D+eqVVo9I4K28WDN+I/TmuY37pXxAsdYYnrqSYg1TYaI2xg
         yJVNOgW256RvR5Dp8DaIHqE4btewk6bg1XCn53oZfKUTFIf6F1SbwIA5N54tclW4Wjsb
         XZvEhkCuVNAN4wi0scY0QO+4U9JvKPN1jqbA5a7M6bUqyKYNXkf5BkqHRmXm2jwFSXxJ
         P6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z3QVbAjMYxj66ovZUFsdaRDaJ7wZm9Xl11qUB+7r03M=;
        b=WKNbeIIgSfoH/aCAAR0aaH0LxnRAZckeaBIZdc5Dbv34ocgINpjCPPQkJYIG3V6p9b
         8pfLQsBS9tcWIlXPUjjwRVUH8p6zLrfd1SwOGre8jwi6OW1pX9NCdMzcFD5b9Adj9xml
         WHLyS7Ch7rFACxtAZm0PM4rytpHnnA+NN4wkcV6gLuJIC5E8PCYfv8F0YNmt4YVUFFVO
         PiOXo0wGzrMIQZt2s0ebFnsPLaYrUU//8lQVG0TCYYWOEHYtIIp1H4/CsYjSzUpUqxci
         CvatEYelV3Y0Wr2IeqtKCb8vY5jqTdqwRrc4kJJDUUfh8Hs3NohDXWffnnVnTQVnPk8V
         qhCw==
X-Gm-Message-State: AOAM531NXCbb+T7xvjDvrRwVAggiDbcRPQRXmfECXD8wD5XCciToQI0O
        t5gYAcoRDwX/3gF6HGETTxbD0/6xMFOTbA==
X-Google-Smtp-Source: ABdhPJzwTuaWk3URypnqTALS441P1IhCDlNGz4El2jl95BEbIKK+XnS7VLy3vKV8lJDdNtJ1JQVg3B1goU1I1A==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:8547:b029:d4:e2c7:1a32 with SMTP
 id d7-20020a1709028547b02900d4e2c71a32mr3440564plo.38.1602541290219; Mon, 12
 Oct 2020 15:21:30 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:45 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-8-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 07/12] kunit: mock: add internal mock infrastructure
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

Add the core internal mechanisms that mocks are implemented with; in
particular, this adds the mechanisms by which expectation on mocks are
validated and by which actions may be supplied and then executed when
mocks are called.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/mock.h | 126 +++++++++++++++
 lib/kunit/Makefile   |   1 +
 lib/kunit/mock.c     | 364 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 491 insertions(+)
 create mode 100644 include/kunit/mock.h
 create mode 100644 lib/kunit/mock.c

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
new file mode 100644
index 000000000000..299b423fdd51
--- /dev/null
+++ b/include/kunit/mock.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mocking API for KUnit.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_MOCK_H
+#define _KUNIT_MOCK_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h> /* For PARAMS(...) */
+#include <kunit/test.h>
+#include <kunit/kunit-stream.h>
+#include <kunit/params.h>
+
+/**
+ * struct mock_param_matcher - represents a matcher used in a *call expectation*
+ * @match: the function that performs the matching
+ *
+ * The matching function takes a couple of parameters:
+ *
+ * - ``this``: refers to the parent struct
+ * - ``stream``: a &kunit_stream to which a detailed message should be added as
+ *   to why the parameter matches or not
+ * - ``param``: a pointer to the parameter to check for a match
+ *
+ * The matching function should return whether or not the passed parameter
+ * matches.
+ */
+struct mock_param_matcher {
+	bool (*match)(struct mock_param_matcher *this,
+		      struct kunit_stream *stream,
+		      const void *param);
+};
+
+#define MOCK_MAX_PARAMS 255
+
+struct mock_matcher {
+	struct mock_param_matcher *matchers[MOCK_MAX_PARAMS];
+	int num;
+};
+
+/**
+ * struct mock_action - Represents an action that a mock performs when
+ *                      expectation is matched
+ * @do_action: the action to perform
+ *
+ * The action function is given some parameters:
+ *
+ * - ``this``: refers to the parent struct
+ * - ``params``: an array of pointers to the params passed into the mocked
+ *   method or function. **The class argument is excluded for a mocked class
+ *   method.**
+ * - ``len``: size of ``params``
+ *
+ * The action function returns a pointer to the value that the mocked method
+ * or function should be returning.
+ */
+struct mock_action {
+	void *(*do_action)(struct mock_action *this,
+			   const void **params,
+			   int len);
+};
+
+/**
+ * struct mock_expectation - represents a *call expectation* on a function.
+ * @action: A &struct mock_action to perform when the function is called.
+ * @max_calls_expected: maximum number of times an expectation may be called.
+ * @min_calls_expected: minimum number of times an expectation may be called.
+ * @retire_on_saturation: no longer match once ``max_calls_expected`` is
+ *			  reached.
+ *
+ * Represents a *call expectation* on a function created with
+ * KUNIT_EXPECT_CALL().
+ */
+struct mock_expectation {
+	struct mock_action *action;
+	int max_calls_expected;
+	int min_calls_expected;
+	bool retire_on_saturation;
+	/* private: internal use only. */
+	const char *expectation_name;
+	struct list_head node;
+	struct mock_matcher *matcher;
+	int times_called;
+};
+
+struct mock_method {
+	struct list_head node;
+	const char *method_name;
+	const void *method_ptr;
+	struct mock_action *default_action;
+	struct list_head expectations;
+};
+
+struct mock {
+	struct kunit_post_condition parent;
+	struct kunit *test;
+	struct list_head methods;
+	/* TODO(brendanhiggins@google.com): add locking to do_expect. */
+	const void *(*do_expect)(struct mock *mock,
+				 const char *method_name,
+				 const void *method_ptr,
+				 const char * const *param_types,
+				 const void **params,
+				 int len);
+};
+
+void mock_init_ctrl(struct kunit *test, struct mock *mock);
+
+void mock_validate_expectations(struct mock *mock);
+
+int mock_set_default_action(struct mock *mock,
+			    const char *method_name,
+			    const void *method_ptr,
+			    struct mock_action *action);
+
+struct mock_expectation *mock_add_matcher(struct mock *mock,
+					  const char *method_name,
+					  const void *method_ptr,
+					  struct mock_param_matcher *matchers[],
+					  int len);
+
+#endif /* _KUNIT_MOCK_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 1707660c8b1c..a51157970502 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
+					mock.o \
 					string-stream.o \
 					assert.o \
 					kunit-stream.o \
diff --git a/lib/kunit/mock.c b/lib/kunit/mock.c
new file mode 100644
index 000000000000..12fb88899451
--- /dev/null
+++ b/lib/kunit/mock.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mocking API for KUnit.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/mock.h>
+
+static bool mock_match_params(struct mock_matcher *matcher,
+			      struct kunit_stream *stream,
+			      const void **params,
+			      int len)
+{
+	struct mock_param_matcher *param_matcher;
+	bool ret = true, tmp;
+	int i;
+
+	BUG_ON(matcher->num != len);
+
+	for (i = 0; i < matcher->num; i++) {
+		param_matcher = matcher->matchers[i];
+		kunit_stream_add(stream, "\t");
+		tmp = param_matcher->match(param_matcher, stream, params[i]);
+		ret = ret && tmp;
+		kunit_stream_add(stream, "\n");
+	}
+
+	return ret;
+}
+
+static const void *mock_do_expect(struct mock *mock,
+				  const char *method_name,
+				  const void *method_ptr,
+				  const char * const *type_names,
+				  const void **params,
+				  int len);
+
+static void fail_and_flush(struct kunit *test, struct kunit_stream *stream)
+{
+	kunit_set_failure(test);
+	kunit_stream_commit(stream);
+}
+
+void mock_validate_expectations(struct mock *mock)
+{
+	struct mock_expectation *expectation, *expectation_safe;
+	struct kunit_stream *stream;
+	struct mock_method *method;
+	int times_called;
+
+	stream = alloc_kunit_stream(mock->test, GFP_KERNEL);
+	list_for_each_entry(method, &mock->methods, node) {
+		list_for_each_entry_safe(expectation, expectation_safe,
+					 &method->expectations, node) {
+			times_called = expectation->times_called;
+			if (!(expectation->min_calls_expected <= times_called &&
+			      times_called <= expectation->max_calls_expected)
+			    ) {
+				kunit_stream_add(stream,
+						 "Expectation was not called the specified number of times:\n\t");
+				kunit_stream_add(stream,
+						 "Function: %s, min calls: %d, max calls: %d, actual calls: %d\n",
+						 method->method_name,
+						 expectation->min_calls_expected,
+						 expectation->max_calls_expected,
+						 times_called);
+				fail_and_flush(mock->test, stream);
+			}
+			list_del(&expectation->node);
+		}
+	}
+}
+
+static void mock_validate_wrapper(struct kunit_post_condition *condition)
+{
+	struct mock *mock = container_of(condition, struct mock, parent);
+
+	mock_validate_expectations(mock);
+}
+
+void mock_init_ctrl(struct kunit *test, struct mock *mock)
+{
+	mock->test = test;
+	INIT_LIST_HEAD(&mock->methods);
+	mock->do_expect = mock_do_expect;
+	mock->parent.validate = mock_validate_wrapper;
+	list_add_tail(&mock->parent.node, &test->post_conditions);
+}
+
+static struct mock_method *mock_lookup_method(struct mock *mock,
+					      const void *method_ptr)
+{
+	struct mock_method *ret;
+
+	list_for_each_entry(ret, &mock->methods, node) {
+		if (ret->method_ptr == method_ptr)
+			return ret;
+	}
+
+	return NULL;
+}
+
+static struct mock_method *mock_add_method(struct mock *mock,
+					   const char *method_name,
+					   const void *method_ptr)
+{
+	struct mock_method *method;
+
+	method = kunit_kzalloc(mock->test, sizeof(*method), GFP_KERNEL);
+	if (!method)
+		return NULL;
+
+	INIT_LIST_HEAD(&method->expectations);
+	method->method_name = method_name;
+	method->method_ptr = method_ptr;
+	list_add_tail(&method->node, &mock->methods);
+
+	return method;
+}
+
+static int mock_add_expectation(struct mock *mock,
+				const char *method_name,
+				const void *method_ptr,
+				struct mock_expectation *expectation)
+{
+	struct mock_method *method;
+
+	method = mock_lookup_method(mock, method_ptr);
+	if (!method) {
+		method = mock_add_method(mock, method_name, method_ptr);
+		if (!method)
+			return -ENOMEM;
+	}
+
+	list_add_tail(&expectation->node, &method->expectations);
+
+	return 0;
+}
+
+struct mock_expectation *mock_add_matcher(struct mock *mock,
+					  const char *method_name,
+					  const void *method_ptr,
+					  struct mock_param_matcher *matchers[],
+					  int len)
+{
+	struct mock_expectation *expectation;
+	struct mock_matcher *matcher;
+	int ret;
+
+	expectation = kunit_kzalloc(mock->test,
+				   sizeof(*expectation),
+				   GFP_KERNEL);
+	if (!expectation)
+		return NULL;
+
+	matcher = kunit_kmalloc(mock->test, sizeof(*matcher), GFP_KERNEL);
+	if (!matcher)
+		return NULL;
+
+	memcpy(&matcher->matchers, matchers, sizeof(*matchers) * len);
+	matcher->num = len;
+
+	expectation->matcher = matcher;
+	expectation->max_calls_expected = 1;
+	expectation->min_calls_expected = 1;
+
+	ret = mock_add_expectation(mock, method_name, method_ptr, expectation);
+	if (ret < 0)
+		return NULL;
+
+	return expectation;
+}
+
+int mock_set_default_action(struct mock *mock,
+			    const char *method_name,
+			    const void *method_ptr,
+			    struct mock_action *action)
+{
+	struct mock_method *method;
+
+	method = mock_lookup_method(mock, method_ptr);
+	if (!method) {
+		method = mock_add_method(mock, method_name, method_ptr);
+		if (!method)
+			return -ENOMEM;
+	}
+
+	method->default_action = action;
+
+	return 0;
+}
+
+static void mock_format_param(struct kunit_stream *stream,
+			      const char *type_name,
+			      const void *param)
+{
+	/*
+	 * Cannot find formatter, so just print the pointer of the
+	 * symbol.
+	 */
+	kunit_stream_add(stream, "<%pS>", param);
+}
+
+static void mock_add_method_declaration_to_stream(
+		struct kunit_stream *stream,
+		const char *function_name,
+		const char * const *type_names,
+		const void **params,
+		int len)
+{
+	int i;
+
+	kunit_stream_add(stream, "%s(", function_name);
+	for (i = 0; i < len; i++) {
+		mock_format_param(stream, type_names[i], params[i]);
+		if (i < len - 1)
+			kunit_stream_add(stream, ", ");
+	}
+	kunit_stream_add(stream, ")\n");
+}
+
+static struct kunit_stream *mock_initialize_failure_message(
+		struct kunit *test,
+		const char *function_name,
+		const char * const *type_names,
+		const void **params,
+		int len)
+{
+	struct kunit_stream *stream;
+
+	stream = alloc_kunit_stream(test, GFP_KERNEL);
+	if (!stream)
+		return NULL;
+
+	kunit_stream_add(stream,
+			 "EXPECTATION FAILED: no expectation for call: ");
+	mock_add_method_declaration_to_stream(stream,
+					      function_name,
+					      type_names,
+					      params,
+					      len);
+	return stream;
+}
+
+static bool mock_is_expectation_retired(struct mock_expectation *expectation)
+{
+	return expectation->retire_on_saturation &&
+			expectation->times_called ==
+			expectation->max_calls_expected;
+}
+
+static void mock_add_method_expectation_error(struct kunit *test,
+					      struct kunit_stream *stream,
+					      char *message,
+					      struct mock *mock,
+					      struct mock_method *method,
+					      const char * const *type_names,
+					      const void **params,
+					      int len)
+{
+	kunit_stream_clear(stream);
+	kunit_stream_add(stream, message);
+	mock_add_method_declaration_to_stream(stream,
+		method->method_name, type_names, params, len);
+}
+
+static struct mock_expectation *mock_apply_expectations(
+		struct mock *mock,
+		struct mock_method *method,
+		const char * const *type_names,
+		const void **params,
+		int len)
+{
+	struct kunit_stream *attempted_matching_stream;
+	bool expectations_all_saturated = true;
+	struct kunit *test = mock->test;
+	struct kunit_stream *stream = alloc_kunit_stream(test, GFP_KERNEL);
+	struct mock_expectation *ret;
+
+	if (list_empty(&method->expectations)) {
+		mock_add_method_expectation_error(test, stream,
+			"Method was called with no expectations declared: ",
+			mock, method, type_names, params, len);
+		kunit_stream_commit(stream);
+		return NULL;
+	}
+
+	attempted_matching_stream = mock_initialize_failure_message(
+			test,
+			method->method_name,
+			type_names,
+			params,
+			len);
+
+	list_for_each_entry(ret, &method->expectations, node) {
+		if (mock_is_expectation_retired(ret))
+			continue;
+		expectations_all_saturated = false;
+
+		kunit_stream_add(attempted_matching_stream,
+				 "Tried expectation: %s, but\n",
+				 ret->expectation_name);
+		if (mock_match_params(ret->matcher,
+			attempted_matching_stream, params, len)) {
+			/*
+			 * Matcher was found; we won't print, so clean up the
+			 * log.
+			 */
+			kunit_stream_clear(attempted_matching_stream);
+			return ret;
+		}
+	}
+
+	if (expectations_all_saturated) {
+		mock_add_method_expectation_error(test, stream,
+			"Method was called with fully saturated expectations: ",
+			mock, method, type_names, params, len);
+	} else {
+		mock_add_method_expectation_error(test, stream,
+			"Method called that did not match any expectations: ",
+			mock, method, type_names, params, len);
+		kunit_stream_append(stream, attempted_matching_stream);
+	}
+	fail_and_flush(test, stream);
+	kunit_stream_clear(attempted_matching_stream);
+	return NULL;
+}
+
+static const void *mock_do_expect(struct mock *mock,
+				  const char *method_name,
+				  const void *method_ptr,
+				  const char * const *param_types,
+				  const void **params,
+				  int len)
+{
+	struct mock_expectation *expectation;
+	struct mock_method *method;
+	struct mock_action *action;
+
+	method = mock_lookup_method(mock, method_ptr);
+	if (!method)
+		return NULL;
+
+	expectation = mock_apply_expectations(mock,
+					      method,
+					      param_types,
+					      params,
+					      len);
+	if (!expectation) {
+		action = method->default_action;
+	} else {
+		expectation->times_called++;
+		if (expectation->action)
+			action = expectation->action;
+		else
+			action = method->default_action;
+	}
+	if (!action)
+		return NULL;
+
+	return action->do_action(action, params, len);
+}
-- 
2.28.0.1011.ga647a8990f-goog

