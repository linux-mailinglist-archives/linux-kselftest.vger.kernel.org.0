Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A748E74B88A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjGGVKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGGVKE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:10:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49106213B
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:10:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57003dac4a8so50804267b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764200; x=1691356200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCDiFoM174/XeK8RqytuPsAx8b5w5bD9y8LbjxL4TRw=;
        b=fEn2mL2kfwY5wVTL0iXJ+3i1NVFqQtDboMri1bisIgPjhvdSxliV1cEm6VdqpThB4d
         pY3lkl97Zc1CF/cC8W3iAw4T140IiJkLEbGscDjZSa+Qspau044eM/l42e64XT6kRLL2
         bVw0P4XTyPvgBO44BUYTtHlZVxDtIVzRIeSsNJ3NmpRCubCzUSaAKm4UycqOq//uitD7
         BK5sdqlq5vcX4y3kSP7wKgmUSvZAbUaBAXRmigrpbWReLfij+4UoLob8GCmy7eS38mCA
         0vloSuZ6iCTMgLqS8/fWC1Arry+X1Jlopa500TU0LS9lt8ZsiaZf9cIdrH2azHvNdOCv
         k5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764200; x=1691356200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCDiFoM174/XeK8RqytuPsAx8b5w5bD9y8LbjxL4TRw=;
        b=HCv/R9jANmXBQJFq3CCfDwjlJ+RZ0yAd3TqEnaB7MT+dv/7OPUrUhrlGUjwfWwQIo+
         EVnM+Frxz3+C0ytuZo+JC/z2cSqjX1xIxsRPJTO8MCwv8pBo61ewhCINKFFCB3L6Z4HS
         ZKaF3QW4JgYTuzCjJwO68o/aXNj39YL9dgQv46BxybQp+bLvaaqq3GLrvo21rjHAZUw6
         2m9RKVIyU7cgDuWCEI8s7m1/Qf5vWccW5lTyQOXKzmiWkFEHsr/61134fMD93JUDnQhE
         b303zpU9CMym+/HdH14xBpm4SvtiEdsP8QqPl22zxzbslmrdFruYWWkjSiLyxGELGoPa
         tmBw==
X-Gm-Message-State: ABy/qLZq0T8yvgtf6rH+oIw3HM0Vlij0AkJaus7Sj3usI1ftsJn5MoNs
        8okbKLS+T6SOsHQXK5AenI863hAuAg==
X-Google-Smtp-Source: APBJJlHy/MAi13Tk58zHjKgiyIDuYxVngxMp3dBur7mRmtj7iTtHjEYEx+8ghiQLpdQSpwycGcFbD42kkQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:290b:b0:57a:5c90:a7f1 with SMTP id
 eg11-20020a05690c290b00b0057a5c90a7f1mr27597ywb.3.1688764200572; Fri, 07 Jul
 2023 14:10:00 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:42 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-5-rmoar@google.com>
Subject: [RFC v2 4/9] kunit: Add ability to filter attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add filtering of test attributes. Users can filter tests using the
module_param called "filter".

Filters are imputed in the format: <attribute_name><operation><value>

Example: kunit.filter="speed>slow"

Operations include: >, <, >=, <=, !=, and =. These operations will act the
same for attributes of the same type but may not between types.

Note multiple filters can be inputted by separating them with a comma.
Example: kunit.filter="speed=slow, module!=example"

Since both suites and test cases can have attributes, there may be
conflicts. The process of filtering follows these rules:
- Filtering always operates at a per-test level.
- If a test has an attribute set, then the test's value is filtered on.
- Otherwise, the value falls back to the suite's value.
- If neither are set, the attribute has a global "default" value, which
  is used.

Filtered tests will not be run or show in output. The tests can instead be
skipped using the configurable option "kunit.filter_action=skip".

Note the default settings for running tests remains unfiltered.

Finally, add "filter" methods for the speed and module attributes to parse
and compare attribute values.

Note this filtering functionality will be added to kunit.py in the next
patch.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- Change method for inputting filters to allow for spaces in filtering
  values
- Add option to skip filtered tests instead of not run or show them with
  the --filter_skip flag

 include/kunit/attributes.h |  31 +++++
 lib/kunit/attributes.c     | 256 +++++++++++++++++++++++++++++++++++++
 lib/kunit/executor.c       |  94 +++++++++++---
 lib/kunit/executor_test.c  |  12 +-
 lib/kunit/test.c           |  10 +-
 5 files changed, 375 insertions(+), 28 deletions(-)

diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
index 9fcd184cce36..bc76a0b786d2 100644
--- a/include/kunit/attributes.h
+++ b/include/kunit/attributes.h
@@ -9,6 +9,20 @@
 #ifndef _KUNIT_ATTRIBUTES_H
 #define _KUNIT_ATTRIBUTES_H
 
+/*
+ * struct kunit_attr_filter - representation of attributes filter with the
+ * attribute object and string input
+ */
+struct kunit_attr_filter {
+	struct kunit_attr *attr;
+	char *input;
+};
+
+/*
+ * Returns the name of the filter's attribute.
+ */
+const char *kunit_attr_filter_name(struct kunit_attr_filter filter);
+
 /*
  * Print all test attributes for a test case or suite.
  * Output format for test cases: "# <test_name>.<attribute>: <value>"
@@ -16,4 +30,21 @@
  */
 void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level);
 
+/*
+ * Returns the number of fitlers in input.
+ */
+int kunit_get_filter_count(char *input);
+
+/*
+ * Parse attributes filter input and return an objects containing the
+ * attribute object and the string input of the next filter.
+ */
+struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err);
+
+/*
+ * Returns a copy of the suite containing only tests that pass the filter.
+ */
+struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
+		struct kunit_attr_filter filter, char *action, int *err);
+
 #endif /* _KUNIT_ATTRIBUTES_H */
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 43dcb5de8b8f..91cbcacafba9 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -67,6 +67,104 @@ static const char *attr_string_to_string(void *attr, bool *to_free)
 	return (char *) attr;
 }
 
+/* Filter Methods */
+
+static const char op_list[] = "<>!=";
+
+/*
+ * Returns whether the inputted integer value matches the filter given
+ * by the operation string and inputted integer.
+ */
+static int int_filter(long val, const char *op, int input, int *err)
+{
+	if (!strncmp(op, "<=", 2))
+		return (val <= input);
+	else if (!strncmp(op, ">=", 2))
+		return (val >= input);
+	else if (!strncmp(op, "!=", 2))
+		return (val != input);
+	else if (!strncmp(op, ">", 1))
+		return (val > input);
+	else if (!strncmp(op, "<", 1))
+		return (val < input);
+	else if (!strncmp(op, "=", 1))
+		return (val == input);
+	*err = -EINVAL;
+	pr_err("kunit executor: invalid filter operation: %s\n", op);
+	return false;
+}
+
+/*
+ * Returns whether the inputted enum value "attr" matches the filter given
+ * by the input string. Note: the str_list includes the corresponding string
+ * list to the enum values.
+ */
+static int attr_enum_filter(void *attr, const char *input, int *err,
+		const char * const str_list[], int max)
+{
+	int i, j, input_int;
+	long test_val = (long)attr;
+	const char *input_val;
+
+	for (i = 0; input[i]; i++) {
+		if (!strchr(op_list, input[i])) {
+			input_val = input + i;
+			break;
+		}
+	}
+
+	if (!input_val) {
+		*err = -EINVAL;
+		pr_err("kunit executor: filter value not found: %s\n", input);
+		return false;
+	}
+
+	for (j = 0; j <= max; j++) {
+		if (!strcmp(input_val, str_list[j]))
+			input_int = j;
+	}
+
+	if (!input_int) {
+		*err = -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	}
+
+	return int_filter(test_val, input, input_int, err);
+}
+
+static int attr_speed_filter(void *attr, const char *input, int *err)
+{
+	return attr_enum_filter(attr, input, err, speed_str_list, KUNIT_SPEED_MAX);
+}
+
+/*
+ * Returns whether the inputted string value (attr) matches the filter given
+ * by the input string.
+ */
+static int attr_string_filter(void *attr, const char *input, int *err)
+{
+	char *str = attr;
+
+	if (!strncmp(input, "<", 1)) {
+		*err = -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	} else if (!strncmp(input, ">", 1)) {
+		*err = -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	} else if (!strncmp(input, "!=", 2)) {
+		return (strcmp(input + 2, str) != 0);
+	} else if (!strncmp(input, "=", 1)) {
+		return (strcmp(input + 1, str) == 0);
+	}
+	*err = -EINVAL;
+	pr_err("kunit executor: invalid filter operation: %s\n", input);
+	return false;
+}
+
+
 /* Get Attribute Methods */
 
 static void *attr_speed_get(void *test_or_suite, bool is_test)
@@ -98,6 +196,7 @@ static const struct kunit_attr speed_attr = {
 	.name = "speed",
 	.get_attr = attr_speed_get,
 	.to_string = attr_speed_to_string,
+	.filter = attr_speed_filter,
 	.attr_default = (void *)KUNIT_SPEED_NORMAL,
 	.print = PRINT_ALWAYS,
 };
@@ -106,6 +205,7 @@ static const struct kunit_attr module_attr = {
 	.name = "module",
 	.get_attr = attr_module_get,
 	.to_string = attr_string_to_string,
+	.filter = attr_string_filter,
 	.attr_default = (void *)"",
 	.print = PRINT_SUITE,
 };
@@ -116,6 +216,11 @@ static struct kunit_attr kunit_attr_list[] = {speed_attr, module_attr};
 
 /* Helper Functions to Access Attributes */
 
+const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
+{
+	return filter.attr->name;
+}
+
 void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level)
 {
 	int i;
@@ -148,3 +253,154 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
 		}
 	}
 }
+
+/* Helper Functions to Filter Attributes */
+
+int kunit_get_filter_count(char *input)
+{
+	int i, comma_index, count = 0;
+
+	for (i = 0; input[i]; i++) {
+		if (input[i] == ',') {
+			if ((i - comma_index) > 1)
+				count++;
+			comma_index = i;
+		}
+	}
+	if ((i - comma_index) > 1)
+		count++;
+	return count;
+}
+
+struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err)
+{
+	struct kunit_attr_filter filter;
+	int i, j, comma_index, new_start_index;
+	int op_index = -1, attr_index = -1;
+	char op;
+	char *input = *filters;
+
+	/* Parse input until operation */
+	for (i = 0; input[i]; i++) {
+		if (op_index < 0 && strchr(op_list, input[i])) {
+			op_index = i;
+		} else if (!comma_index && input[i] == ',') {
+			comma_index = i;
+		} else if (comma_index && input[i] != ' ') {
+			new_start_index = i;
+			break;
+		}
+	}
+
+	if (op_index <= 0) {
+		*err = -EINVAL;
+		pr_err("kunit executor: filter operation not found: %s\n", input);
+		return filter;
+	}
+
+	/* Temporarily set operator to \0 character. */
+	op = input[op_index];
+	input[op_index] = '\0';
+
+	/* Find associated kunit_attr object */
+	for (j = 0; j < ARRAY_SIZE(kunit_attr_list); j++) {
+		if (!strcmp(input, kunit_attr_list[j].name)) {
+			attr_index = j;
+			break;
+		}
+	}
+
+	input[op_index] = op;
+
+	if (attr_index < 0) {
+		*err = -EINVAL;
+		pr_err("kunit executor: attribute not found: %s\n", input);
+	} else {
+		filter.attr = &kunit_attr_list[attr_index];
+	}
+
+	if (comma_index) {
+		input[comma_index] = '\0';
+		filter.input = input + op_index;
+		input = input + new_start_index;
+	} else {
+		filter.input = input + op_index;
+		input = NULL;
+	}
+
+	*filters = input;
+
+	return filter;
+}
+
+struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
+		struct kunit_attr_filter filter, char *action, int *err)
+{
+	int n = 0;
+	struct kunit_case *filtered, *test_case;
+	struct kunit_suite *copy;
+	void *suite_val, *test_val;
+	bool suite_result, test_result, default_result, result;
+
+	/* Allocate memory for new copy of suite and list of test cases */
+	copy = kmemdup(suite, sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
+
+	kunit_suite_for_each_test_case(suite, test_case) { n++; }
+
+	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
+	if (!filtered) {
+		kfree(copy);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	n = 0;
+
+	/* Save filtering result on default value */
+	default_result = filter.attr->filter(filter.attr->attr_default, filter.input, err);
+
+	/* Save suite attribute value and filtering result on that value */
+	suite_val = filter.attr->get_attr((void *)suite, false);
+	suite_result = filter.attr->filter(suite_val, filter.input, err);
+
+	/* For each test case, save test case if passes filtering. */
+	kunit_suite_for_each_test_case(suite, test_case) {
+		test_val = filter.attr->get_attr((void *) test_case, true);
+		test_result = filter.attr->filter(filter.attr->get_attr(test_case, true),
+				filter.input, err);
+
+		/*
+		 * If attribute value of test case is set, filter on that value.
+		 * If not, filter on suite value if set. If not, filter on
+		 * default value.
+		 */
+		result = false;
+		if (test_val) {
+			if (test_result)
+				result = true;
+		} else if (suite_val) {
+			if (suite_result)
+				result = true;
+		} else if (default_result) {
+			result = true;
+		}
+
+		if (result) {
+			filtered[n++] = *test_case;
+		} else if (action && strcmp(action, "skip") == 0) {
+			test_case->status = KUNIT_SKIPPED;
+			filtered[n++] = *test_case;
+		}
+	}
+
+	if (n == 0) {
+		kfree(copy);
+		kfree(filtered);
+		return NULL;
+	}
+
+	copy->test_cases = filtered;
+
+	return copy;
+}
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 12e38a48a5cc..c286ae47435a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -17,6 +17,9 @@ extern struct kunit_suite * const __kunit_suites_end[];
 
 static char *filter_glob_param;
 static char *action_param;
+static char *filter_param;
+static char *filter_action_param;
+
 
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
@@ -27,15 +30,23 @@ MODULE_PARM_DESC(action,
 		 "<none>: run the tests like normal\n"
 		 "'list' to list test names instead of running them.\n"
 		 "'list_attr' to list test names and attributes instead of running them.\n");
+module_param_named(filter, filter_param, charp, 0);
+MODULE_PARM_DESC(filter,
+		"Filter which KUnit test suites/tests run at boot-time using attributes, e.g. speed>slow");
+module_param_named(filter_action, filter_action_param, charp, 0);
+MODULE_PARM_DESC(filter_action,
+		"Changes behavior of filtered tests using attributes, valid values are:\n"
+		"<none>: do not run filtered tests as normal\n"
+		"'skip': skip all filtered tests instead so tests will appear in output\n");
 
 /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
-struct kunit_test_filter {
+struct kunit_glob_filter {
 	char *suite_glob;
 	char *test_glob;
 };
 
 /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
-static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
+static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
 				    const char *filter_glob)
 {
 	const int len = strlen(filter_glob);
@@ -57,7 +68,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
 
 /* Create a copy of suite with only tests that match test_glob. */
 static struct kunit_suite *
-kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
+kunit_filter_glob_tests(const struct kunit_suite *const suite, const char *test_glob)
 {
 	int n = 0;
 	struct kunit_case *filtered, *test_case;
@@ -111,12 +122,15 @@ static void kunit_free_suite_set(struct suite_set suite_set)
 
 static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 					    const char *filter_glob,
+						char *filters,
+						char *filter_action,
 					    int *err)
 {
-	int i;
-	struct kunit_suite **copy, *filtered_suite;
+	int i, j, k, filter_count;
+	struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
 	struct suite_set filtered;
-	struct kunit_test_filter filter;
+	struct kunit_glob_filter parsed_glob;
+	struct kunit_attr_filter *parsed_filters;
 
 	const size_t max = suite_set->end - suite_set->start;
 
@@ -127,17 +141,52 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 		return filtered;
 	}
 
-	kunit_parse_filter_glob(&filter, filter_glob);
-
-	for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
-		if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
-			continue;
+	if (filter_glob)
+		kunit_parse_glob_filter(&parsed_glob, filter_glob);
 
-		filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
-		if (IS_ERR(filtered_suite)) {
-			*err = PTR_ERR(filtered_suite);
+	/* Parse attribute filters */
+	if (filters) {
+		filter_count = kunit_get_filter_count(filters);
+		parsed_filters = kcalloc(filter_count + 1, sizeof(*parsed_filters), GFP_KERNEL);
+		for (j = 0; j < filter_count; j++)
+			parsed_filters[j] = kunit_next_attr_filter(&filters, err);
+		if (*err)
 			return filtered;
+	}
+
+	for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
+		filtered_suite = suite_set->start[i];
+		if (filter_glob) {
+			if (!glob_match(parsed_glob.suite_glob, filtered_suite->name))
+				continue;
+			filtered_suite = kunit_filter_glob_tests(filtered_suite,
+					parsed_glob.test_glob);
+			if (IS_ERR(filtered_suite)) {
+				*err = PTR_ERR(filtered_suite);
+				return filtered;
+			}
+		}
+		if (filter_count) {
+			for (k = 0; k < filter_count; k++) {
+				new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
+						parsed_filters[k], filter_action, err);
+
+				/* Free previous copy of suite */
+				if (k > 0 || filter_glob)
+					kfree(filtered_suite);
+				filtered_suite = new_filtered_suite;
+
+				if (*err)
+					return filtered;
+				if (IS_ERR(filtered_suite)) {
+					*err = PTR_ERR(filtered_suite);
+					return filtered;
+				}
+				if (!filtered_suite)
+					break;
+			}
 		}
+
 		if (!filtered_suite)
 			continue;
 
@@ -145,8 +194,14 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 	}
 	filtered.end = copy;
 
-	kfree(filter.suite_glob);
-	kfree(filter.test_glob);
+	if (filter_glob) {
+		kfree(parsed_glob.suite_glob);
+		kfree(parsed_glob.test_glob);
+	}
+
+	if (filter_count)
+		kfree(parsed_filters);
+
 	return filtered;
 }
 
@@ -206,8 +261,9 @@ int kunit_run_all_tests(void)
 		goto out;
 	}
 
-	if (filter_glob_param) {
-		suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
+	if (filter_glob_param || filter_param) {
+		suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
+				filter_param, filter_action_param, &err);
 		if (err) {
 			pr_err("kunit executor: error filtering suites: %d\n", err);
 			goto out;
@@ -223,7 +279,7 @@ int kunit_run_all_tests(void)
 	else
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
-	if (filter_glob_param) { /* a copy was made of each suite */
+	if (filter_glob_param || filter_param) { /* a copy was made of each suite */
 		kunit_free_suite_set(suite_set);
 	}
 
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index ce6749af374d..d7ab069324b5 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -24,15 +24,15 @@ static struct kunit_case dummy_test_cases[] = {
 
 static void parse_filter_test(struct kunit *test)
 {
-	struct kunit_test_filter filter = {NULL, NULL};
+	struct kunit_glob_filter filter = {NULL, NULL};
 
-	kunit_parse_filter_glob(&filter, "suite");
+	kunit_parse_glob_filter(&filter, "suite");
 	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
 	KUNIT_EXPECT_FALSE(test, filter.test_glob);
 	kfree(filter.suite_glob);
 	kfree(filter.test_glob);
 
-	kunit_parse_filter_glob(&filter, "suite.test");
+	kunit_parse_glob_filter(&filter, "suite.test");
 	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
 	KUNIT_EXPECT_STREQ(test, filter.test_glob, "test");
 	kfree(filter.suite_glob);
@@ -50,7 +50,7 @@ static void filter_suites_test(struct kunit *test)
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2, NULL */
-	got = kunit_filter_suites(&suite_set, "suite2", &err);
+	got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -74,7 +74,7 @@ static void filter_suites_test_glob_test(struct kunit *test)
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
-	got = kunit_filter_suites(&suite_set, "suite2.test2", &err);
+	got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -100,7 +100,7 @@ static void filter_suites_to_empty_test(struct kunit *test)
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
-	got = kunit_filter_suites(&suite_set, "not_found", &err);
+	got = kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start); /* just in case */
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 9ee55139ecd1..cb9797fa6303 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -613,18 +613,22 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
 		struct kunit_result_stats param_stats = { 0 };
-		test_case->status = KUNIT_SKIPPED;
 
 		kunit_init_test(&test, test_case->name, test_case->log);
-
-		if (!test_case->generate_params) {
+		if (test_case->status == KUNIT_SKIPPED) {
+			/* Test marked as skip */
+			test.status = KUNIT_SKIPPED;
+			kunit_update_stats(&param_stats, test.status);
+		} else if (!test_case->generate_params) {
 			/* Non-parameterised test. */
+			test_case->status = KUNIT_SKIPPED;
 			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
 		} else {
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
+			test_case->status = KUNIT_SKIPPED;
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-- 
2.41.0.255.g8b1d071c50-goog

