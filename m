Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748D0270412
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIRScJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgIRScH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 14:32:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B985C0613D2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:07 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q131so5265682qke.22
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=y15UkrpVILsyPpJzSCvvGnSuGfIrAVdnneb1O3jNsec=;
        b=GsTN0Fqqhr374zpwIsk8tbfwFUnxs21Z1dtpKfsPyeb7jpd9rHIdP8GYAg8FnOXys1
         OIELCjgsdH3BIVjw86Wfbp18sFXjglTYNmRe6WyWgnHdOnmLf5OHztZ1z1ZsqesIbc/F
         ESNH2BQqgu6t3B+r0/gAd+vKO/SpgK/Pf81UF3UtC1s7TjsIsWzzw46LzqRHl/I2DYbi
         rWiuctWHFJSS6NqpRtIJ/yInOZp/06u+5rFNOk48qJN7KI+sTVNFrZxcQAqy2Rwyaf8u
         GKZXXZ6VfYpG0agd95n5l1D9JPG7YS586nJzRMU4OZfPEhJa+ScjBra5/BaqPPynH/yV
         jtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y15UkrpVILsyPpJzSCvvGnSuGfIrAVdnneb1O3jNsec=;
        b=a+3q7BafcOcJoq/72lxtIXybpLYfvXe0LOdkjQcFqa1ivkYysIB8ErGqd1tuMrH5Bw
         BQymVlH/gsRDY5rZZKe/PtKoZ/g1UlPWMrR7r7fCymX9dOPZ8ERS1kHrLmuyWIAUCL/v
         uqVJ/YANvu+yhAwnzHgeX4K2zDj3PLaER9XV1uUZk2U33GLv4soWrmOFP570MnpNx/16
         8a1mW+I9rlBb99BE+tVo23aH9gvwTF+IXYDXLvi9QP1pwhT512LJFzPFro7cDvSn8EcJ
         tPh8y/QMsGK8SJAxV6e2vUYV109insGOx2RrX4yYPJXmR9BHeDt2WHvtqHlu8AWjBDzt
         fwFg==
X-Gm-Message-State: AOAM531fNndCWel8jNGp7uTE4TsOaMTc9sAR0IcLkohlh4w0dS+UcylA
        0YubvgauLsF+sEByA81YwMxmkMfiUDl3iA==
X-Google-Smtp-Source: ABdhPJzjKGUVA/MU3if7G/38erCuSrsG3UTt9u//MEEn/WGslt9fIIYhmXXIsbH6L0FlpdMCZ1OrFueu6Rarmw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:ad4:58e7:: with SMTP id
 di7mr18236843qvb.36.1600453926645; Fri, 18 Sep 2020 11:32:06 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:09 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-8-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 07/12] kunit: mock: add internal mock infrastructure
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Latypov <dlatypov@google.com>
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
2.28.0.681.g6f77f65b4e-goog

