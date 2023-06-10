Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450B572A71A
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 02:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjFJAwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 20:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjFJAwP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690A2717
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 17:52:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5692be06cb2so30571687b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 17:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358332; x=1688950332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JD9VPXNmaoVBy2gAiYJtNq7wx8MSqrStxnM3XpRxKVA=;
        b=q21OucQNW4R7TYegSZEEbLLbvxXRHbQGDJ96QH08pyz1J6KQBPHqxc1IazXONp2w81
         OM13ovDeJ5G/8Tm1+3t3jdOXgvDr8ol21ow3CnsdVYDIm75MWMPI76HnLsXVgbNQJ+RL
         rfWba9qn8no74J6QglcrmJCijppFt3g91rp8zDIT7RWkTz6TuGyLn/aMaahbT/GQdx5c
         RPLvfDR+QI1tRm+v5qLnkRQCVCdNow8zhlZ4xozUhyfzfoiEz2ElIzYcD9+dh5aLjSvV
         zGAeVaXrxnCxqrEwmdW1abucmorAsp76hmagmxJSeMltB73RVuVr7Zn06wBU/ZLOPj5w
         lfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358332; x=1688950332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JD9VPXNmaoVBy2gAiYJtNq7wx8MSqrStxnM3XpRxKVA=;
        b=K91KyIls2ZYsNhSdmc2EtyiPPWAPbwvEZianvjRdr0aLuUuZWbVDgY4o0mjFc04NPr
         Jdnn5TmPyaXVy1TfloyEJrO7bStX3tL71owqZUAx/4A4HFUVJRH9JRovw17uxfKYX3or
         QgUJcf4sqkThxJVMrIFEqKCQp6Ih3WrP1EqOEPgkaSyZyjSCW5f/kZrQgIrKn976lF9S
         S9uEsqP+TBIieaSsUR70WjhaWysTpSTlZV02AzBzLvGraOJLvhxTxfguSnjFv5T8XpPQ
         kS1e5JHpC5BPnPTmIGnpHiZb/+gyAWt766CAc3Qb8igzuD0GFjo2IElZBX741WlJCp3V
         8xiQ==
X-Gm-Message-State: AC+VfDyl30xhjO3BZpQr3ZJbVR4QLoVplFZzRRIsX7XLM6XrKuT0JZBT
        YAiCUbWK++88AxS2lZ+ey21Kyv44qQ==
X-Google-Smtp-Source: ACHHUZ5wVXyVqF42eIZPBvG8hcKoYDyK+tpTpA1FekD4DK+IEpUzvBZpSbGfcRJ5leBMjHptgwFvrDbpuA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:af67:0:b0:561:94a8:29c4 with SMTP id
 x39-20020a81af67000000b0056194a829c4mr1583110ywj.2.1686358332355; Fri, 09 Jun
 2023 17:52:12 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:46 +0000
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-4-rmoar@google.com>
Subject: [RFC v1 3/6] kunit: Add ability to filter attributes
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

Add filtering of test attributes. Users can filter tests using a
module_param_array called "filter". This functionality will be added to
kunit.py in the next patch.

The filters will be imputed in the format:
"<attribute_name><operation><attribute_value>"

Example: "speed>slow"

Operations include: >, <, >=, <=, !=, and =. These operations do not need
to act the same for every attribute.

Add method to parse inputted filters.

Add the process of filtering tests based on attributes. The process of
filtering follows these rules:

A test case with a set attribute overrides its parent suite's attribute
during filtering.

Also, if both the test case attribute and suite attribute are unset the
test acts as the default attribute value during filtering.

Finally, add a "filter" method for the speed attribute to parse and compare
enum values of kunit_speed.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/kunit/attributes.h |  22 +++++
 lib/kunit/attributes.c     | 172 +++++++++++++++++++++++++++++++++++++
 lib/kunit/executor.c       |  79 +++++++++++++----
 lib/kunit/executor_test.c  |   8 +-
 4 files changed, 258 insertions(+), 23 deletions(-)

diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
index 9fcd184cce36..bca60d1181bb 100644
--- a/include/kunit/attributes.h
+++ b/include/kunit/attributes.h
@@ -9,6 +9,15 @@
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
 /*
  * Print all test attributes for a test case or suite.
  * Output format for test cases: "# <test_name>.<attribute>: <value>"
@@ -16,4 +25,17 @@
  */
 void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level);
 
+/*
+ * Parse attributes filter input and return an object containing the attribute
+ * object and the string input.
+ */
+struct kunit_attr_filter kunit_parse_filter_attr(char *input, int *err);
+
+
+/*
+ * Returns a copy of the suite containing only tests that pass the filter.
+ */
+struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
+		struct kunit_attr_filter filter, int *err);
+
 #endif /* _KUNIT_ATTRIBUTES_H */
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index e17889f94693..4f753a28e4ee 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -49,6 +49,66 @@ static const char *attr_speed_to_string(void *attr, bool *to_free)
 	return attr_enum_to_string(attr, speed_str_list, to_free);
 }
 
+/* Filter Methods */
+
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
+static int attr_enum_filter(void *attr, const char *input, int *err,
+		const char * const str_list[], int max)
+{
+	int i, j, input_int;
+	long test_val = (long)attr;
+	const char *input_val;
+
+	for (i = 0; input[i]; i++) {
+		if (!strchr("<!=>", input[i])) {
+			input_val = input + i;
+			break;
+		}
+	}
+
+	if (!input_val) {
+		*err = -EINVAL;
+		pr_err("kunit executor: filter operation not found: %s\n", input);
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
 /* Get Attribute Methods */
 
 static void *attr_speed_get(void *test_or_suite, bool is_test)
@@ -68,6 +128,7 @@ static const struct kunit_attr speed_attr = {
 	.name = "speed",
 	.get_attr = attr_speed_get,
 	.to_string = attr_speed_to_string,
+	.filter = attr_speed_filter,
 	.attr_default = (void *)KUNIT_SPEED_NORMAL,
 };
 
@@ -106,3 +167,114 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
 		}
 	}
 }
+
+/* Helper Functions to Filter Attributes */
+
+struct kunit_attr_filter kunit_parse_filter_attr(char *input, int *err)
+{
+	struct kunit_attr_filter filter;
+	int i, j, op_index = 0;
+	int attr_index = -1;
+	char op;
+
+	/* Parse input until operation */
+	for (i = 0; input[i]; i++) {
+		if (strchr("<>!=", input[i])) {
+			op_index = i;
+			break;
+		}
+		if (input[i] == ' ')
+			break;
+	}
+
+	if (!op_index) {
+		*err = -EINVAL;
+		pr_err("kunit executor: filter operation not found: %s\n", input);
+		return filter;
+	}
+
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
+	filter.input = input + op_index;
+
+	if (attr_index < 0) {
+		*err = -EINVAL;
+		pr_err("kunit executor: attribute not found: %s\n", input);
+	} else {
+		filter.attr = &kunit_attr_list[attr_index];
+	}
+
+	return filter;
+}
+
+struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suite,
+		struct kunit_attr_filter filter, int *err)
+{
+	int n = 0;
+	struct kunit_case *filtered, *test_case;
+	struct kunit_suite *copy;
+	void *suite_val, *test_val;
+	bool suite_result, test_result, default_result;
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
+		/*
+		 * If attribute value of test case is set, filter on that value.
+		 * If not, filter on suite value if set. If not, filter on
+		 * default value.
+		 */
+		if (test_val) {
+			if (test_result)
+				filtered[n++] = *test_case;
+		} else if (suite_val) {
+			if (suite_result)
+				filtered[n++] = *test_case;
+		} else if (default_result) {
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
+	return copy;
+}
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 767a84e32f06..c67657821eec 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -15,8 +15,12 @@ extern struct kunit_suite * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
+#define MAX_FILTERS 10 // Limit of number of attribute filters
 static char *filter_glob_param;
 static char *action_param;
+static int filter_count;
+static char *filter_param[MAX_FILTERS];
+
 
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
@@ -26,15 +30,16 @@ MODULE_PARM_DESC(action,
 		 "Changes KUnit executor behavior, valid values are:\n"
 		 "<none>: run the tests like normal\n"
 		 "'list' to list test names instead of running them.\n");
+module_param_array_named(filter, filter_param, charp, &filter_count, 0);
 
 /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
-struct kunit_test_filter {
+struct kunit_glob_filter {
 	char *suite_glob;
 	char *test_glob;
 };
 
 /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty. */
-static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
+static void kunit_parse_filter_glob(struct kunit_glob_filter *parsed,
 				    const char *filter_glob)
 {
 	const int len = strlen(filter_glob);
@@ -56,7 +61,7 @@ static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
 
 /* Create a copy of suite with only tests that match test_glob. */
 static struct kunit_suite *
-kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
+kunit_filter_glob_tests(const struct kunit_suite *const suite, const char *test_glob)
 {
 	int n = 0;
 	struct kunit_case *filtered, *test_case;
@@ -110,12 +115,15 @@ static void kunit_free_suite_set(struct suite_set suite_set)
 
 static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 					    const char *filter_glob,
+						char **filters,
+						int filter_count,
 					    int *err)
 {
-	int i;
-	struct kunit_suite **copy, *filtered_suite;
+	int i, j, k;
+	struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
 	struct suite_set filtered;
-	struct kunit_test_filter filter;
+	struct kunit_glob_filter parsed_glob;
+	struct kunit_attr_filter parsed_filters[MAX_FILTERS];
 
 	const size_t max = suite_set->end - suite_set->start;
 
@@ -126,17 +134,49 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 		return filtered;
 	}
 
-	kunit_parse_filter_glob(&filter, filter_glob);
+	if (filter_glob)
+		kunit_parse_filter_glob(&parsed_glob, filter_glob);
 
-	for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
-		if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
-			continue;
+	/* Parse attribute filters */
+	if (filter_count) {
+		for (j = 0; j < filter_count; j++) {
+			parsed_filters[j] = kunit_parse_filter_attr(filters[j], err);
+			if (*err)
+				return filtered;
+		}
+	}
 
-		filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
-		if (IS_ERR(filtered_suite)) {
-			*err = PTR_ERR(filtered_suite);
-			return filtered;
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
 		}
+		if (filter_count) {
+			for (k = 0; k < filter_count; k++) {
+				new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
+						parsed_filters[k], err);
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
+			}
+		}
+
 		if (!filtered_suite)
 			continue;
 
@@ -144,8 +184,8 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 	}
 	filtered.end = copy;
 
-	kfree(filter.suite_glob);
-	kfree(filter.test_glob);
+	kfree(parsed_glob.suite_glob);
+	kfree(parsed_glob.test_glob);
 	return filtered;
 }
 
@@ -203,8 +243,9 @@ int kunit_run_all_tests(void)
 		goto out;
 	}
 
-	if (filter_glob_param) {
-		suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
+	if (filter_glob_param || filter_count) {
+		suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
+				filter_param, filter_count, &err);
 		if (err) {
 			pr_err("kunit executor: error filtering suites: %d\n", err);
 			goto out;
@@ -218,7 +259,7 @@ int kunit_run_all_tests(void)
 	else
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
-	if (filter_glob_param) { /* a copy was made of each suite */
+	if (filter_glob_param || filter_count) { /* a copy was made of each suite */
 		kunit_free_suite_set(suite_set);
 	}
 
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index ce6749af374d..4c8cb46857b2 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -24,7 +24,7 @@ static struct kunit_case dummy_test_cases[] = {
 
 static void parse_filter_test(struct kunit *test)
 {
-	struct kunit_test_filter filter = {NULL, NULL};
+	struct kunit_glob_filter filter = {NULL, NULL};
 
 	kunit_parse_filter_glob(&filter, "suite");
 	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
@@ -50,7 +50,7 @@ static void filter_suites_test(struct kunit *test)
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2, NULL */
-	got = kunit_filter_suites(&suite_set, "suite2", &err);
+	got = kunit_filter_suites(&suite_set, "suite2", NULL, 0, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -74,7 +74,7 @@ static void filter_suites_test_glob_test(struct kunit *test)
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
-	got = kunit_filter_suites(&suite_set, "suite2.test2", &err);
+	got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, 0, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -100,7 +100,7 @@ static void filter_suites_to_empty_test(struct kunit *test)
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
-	got = kunit_filter_suites(&suite_set, "not_found", &err);
+	got = kunit_filter_suites(&suite_set, "not_found", NULL, 0, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start); /* just in case */
 
-- 
2.41.0.162.gfafddb0af9-goog

