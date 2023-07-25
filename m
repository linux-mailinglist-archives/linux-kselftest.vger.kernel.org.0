Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D178762454
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGYVZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjGYVZk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A01FFA
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so5523642276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320335; x=1690925135;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QRX0uJ1Dawaqn3oTc7CEfaqw28ncjMa2otOk0jIQRs=;
        b=qQs9SujaitBZk7sy3aSEOU2gNA6h45AH8WWgH0Cpo7Q8m/XIug887gIYEOLjTRdzQf
         ndR+9fJ00Qxc/c9PChNlXt7cQH/dJfYbS91B3UHLHyazVFvxREyqPCmjpU2U8TbaCUQd
         BK/VXGSSXJADw93rJ11L4N4Qfqp0LYkhm22O4U42o8mBS8kEUlAjXlcL1FSbxQ/oFUOq
         chRd+JNZbKL0RDG2Hg/L00ok+HfhtXD+okCyEap0xiD7ConPC4smMaBh4TZVuvwc+x1m
         dFt2OptAIOUzkse7svFUvFLYbJf/hD6Vj/mpS4NLK6HBHZHF2IgcCSnEffWcmqFMYAL1
         4AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320335; x=1690925135;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7QRX0uJ1Dawaqn3oTc7CEfaqw28ncjMa2otOk0jIQRs=;
        b=kfPcoHt5C1vC3OOYLlvkQdtaBf8u8znHkkBkVFFjFS3WXhaHN1UySLsefijRsBCn7r
         0aMmVilu1/v63L4jeOPrXzWSxHVIlPV1vS2BqfSaaB/U7l8wLbXgufVH7IHf5aCgshjP
         Ix3HuntKR674SrxMxYVITvjFXMZiLS1qgQ+taM8jGbRbCo8eEQN5/Zdt+bcx7ztO+YGG
         QZ9eEixDebc1ZGrzMksKYN32GFYIcAliXuNfA5IDXKDosOUecB3SXuKVx72WN8OdOOM7
         2DW9qMuzWIWsgx3Dv1FUq8RUWQ/+KcdZw6c9i/mGzr2Dls7en0VEDsnYdHMQW8CsOHJY
         DZ1g==
X-Gm-Message-State: ABy/qLZYN49U4O/9lwyOB8c3ZbmS6t6NRC3xjnijbmN/41epzBaEKHcR
        /H2K4gEbdQ2vaZFDSGgL1ld10yYgtA==
X-Google-Smtp-Source: APBJJlGxgaInCvz5noCMntvxT84vYGMu04TD8UwuQnOU3ZzzW6XOcjhrnmStxKTHb+TtH/S1A6+s+ASdbA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:3251:0:b0:c61:7151:6727 with SMTP id
 y78-20020a253251000000b00c6171516727mr1118yby.10.1690320335593; Tue, 25 Jul
 2023 14:25:35 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:15 +0000
In-Reply-To: <20230725212522.1622716-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230725212522.1622716-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-5-rmoar@google.com>
Subject: [PATCH v3 4/9] kunit: Add ability to filter attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add filtering of test attributes. Users can filter tests using the
module_param called "filter".

Filters are imputed in the format: <attribute_name><operation><value>

Example: kunit.filter=3D"speed>slow"

Operations include: >, <, >=3D, <=3D, !=3D, and =3D. These operations will =
act the
same for attributes of the same type but may not between types.

Note multiple filters can be inputted by separating them with a comma.
Example: kunit.filter=3D"speed=3Dslow, module!=3Dexample"

Since both suites and test cases can have attributes, there may be
conflicts. The process of filtering follows these rules:
- Filtering always operates at a per-test level.
- If a test has an attribute set, then the test's value is filtered on.
- Otherwise, the value falls back to the suite's value.
- If neither are set, the attribute has a global "default" value, which
  is used.

Filtered tests will not be run or show in output. The tests can instead be
skipped using the configurable option "kunit.filter_action=3Dskip".

Note the default settings for running tests remains unfiltered.

Finally, add "filter" methods for the speed and module attributes to parse
and compare attribute values.

Note this filtering functionality will be added to kunit.py in the next
patch.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- Remove extra line.
Changes since v1:
- Fix compile warning of use of uninitialized variable
Changes since RFC v2:
- Change to output only one error before exiting.
Changes since RFC v1:
- Change method for inputting filters to allow for spaces in filtering
  values
- Add option to skip filtered tests instead of not run or show them with
  the- =E2=80=93filter_skip flag

 include/kunit/attributes.h |  31 +++++
 lib/kunit/attributes.c     | 271 +++++++++++++++++++++++++++++++++++++
 lib/kunit/executor.c       |  93 ++++++++++---
 lib/kunit/executor_test.c  |  12 +-
 lib/kunit/test.c           |  10 +-
 5 files changed, 389 insertions(+), 28 deletions(-)

diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
index 9fcd184cce36..bc76a0b786d2 100644
--- a/include/kunit/attributes.h
+++ b/include/kunit/attributes.h
@@ -9,6 +9,20 @@
 #ifndef _KUNIT_ATTRIBUTES_H
 #define _KUNIT_ATTRIBUTES_H
=20
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
 void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test=
_level);
=20
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
+struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *cons=
t suite,
+		struct kunit_attr_filter filter, char *action, int *err);
+
 #endif /* _KUNIT_ATTRIBUTES_H */
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 9dce4f4d726c..d37c40c0ce4f 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -67,6 +67,104 @@ static const char *attr_string_to_string(void *attr, bo=
ol *to_free)
 	return (char *) attr;
 }
=20
+/* Filter Methods */
+
+static const char op_list[] =3D "<>!=3D";
+
+/*
+ * Returns whether the inputted integer value matches the filter given
+ * by the operation string and inputted integer.
+ */
+static int int_filter(long val, const char *op, int input, int *err)
+{
+	if (!strncmp(op, "<=3D", 2))
+		return (val <=3D input);
+	else if (!strncmp(op, ">=3D", 2))
+		return (val >=3D input);
+	else if (!strncmp(op, "!=3D", 2))
+		return (val !=3D input);
+	else if (!strncmp(op, ">", 1))
+		return (val > input);
+	else if (!strncmp(op, "<", 1))
+		return (val < input);
+	else if (!strncmp(op, "=3D", 1))
+		return (val =3D=3D input);
+	*err =3D -EINVAL;
+	pr_err("kunit executor: invalid filter operation: %s\n", op);
+	return false;
+}
+
+/*
+ * Returns whether the inputted enum value "attr" matches the filter given
+ * by the input string. Note: the str_list includes the corresponding stri=
ng
+ * list to the enum values.
+ */
+static int attr_enum_filter(void *attr, const char *input, int *err,
+		const char * const str_list[], int max)
+{
+	int i, j, input_int;
+	long test_val =3D (long)attr;
+	const char *input_val =3D NULL;
+
+	for (i =3D 0; input[i]; i++) {
+		if (!strchr(op_list, input[i])) {
+			input_val =3D input + i;
+			break;
+		}
+	}
+
+	if (!input_val) {
+		*err =3D -EINVAL;
+		pr_err("kunit executor: filter value not found: %s\n", input);
+		return false;
+	}
+
+	for (j =3D 0; j <=3D max; j++) {
+		if (!strcmp(input_val, str_list[j]))
+			input_int =3D j;
+	}
+
+	if (!input_int) {
+		*err =3D -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	}
+
+	return int_filter(test_val, input, input_int, err);
+}
+
+static int attr_speed_filter(void *attr, const char *input, int *err)
+{
+	return attr_enum_filter(attr, input, err, speed_str_list, KUNIT_SPEED_MAX=
);
+}
+
+/*
+ * Returns whether the inputted string value (attr) matches the filter giv=
en
+ * by the input string.
+ */
+static int attr_string_filter(void *attr, const char *input, int *err)
+{
+	char *str =3D attr;
+
+	if (!strncmp(input, "<", 1)) {
+		*err =3D -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	} else if (!strncmp(input, ">", 1)) {
+		*err =3D -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	} else if (!strncmp(input, "!=3D", 2)) {
+		return (strcmp(input + 2, str) !=3D 0);
+	} else if (!strncmp(input, "=3D", 1)) {
+		return (strcmp(input + 1, str) =3D=3D 0);
+	}
+	*err =3D -EINVAL;
+	pr_err("kunit executor: invalid filter operation: %s\n", input);
+	return false;
+}
+
+
 /* Get Attribute Methods */
=20
 static void *attr_speed_get(void *test_or_suite, bool is_test)
@@ -99,6 +197,7 @@ static struct kunit_attr kunit_attr_list[] =3D {
 		.name =3D "speed",
 		.get_attr =3D attr_speed_get,
 		.to_string =3D attr_speed_to_string,
+		.filter =3D attr_speed_filter,
 		.attr_default =3D (void *)KUNIT_SPEED_NORMAL,
 		.print =3D PRINT_ALWAYS,
 	},
@@ -106,6 +205,7 @@ static struct kunit_attr kunit_attr_list[] =3D {
 		.name =3D "module",
 		.get_attr =3D attr_module_get,
 		.to_string =3D attr_string_to_string,
+		.filter =3D attr_string_filter,
 		.attr_default =3D (void *)"",
 		.print =3D PRINT_SUITE,
 	}
@@ -113,6 +213,11 @@ static struct kunit_attr kunit_attr_list[] =3D {
=20
 /* Helper Functions to Access Attributes */
=20
+const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
+{
+	return filter.attr->name;
+}
+
 void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test=
_level)
 {
 	int i;
@@ -145,3 +250,169 @@ void kunit_print_attr(void *test_or_suite, bool is_te=
st, unsigned int test_level
 		}
 	}
 }
+
+/* Helper Functions to Filter Attributes */
+
+int kunit_get_filter_count(char *input)
+{
+	int i, comma_index, count =3D 0;
+
+	for (i =3D 0; input[i]; i++) {
+		if (input[i] =3D=3D ',') {
+			if ((i - comma_index) > 1)
+				count++;
+			comma_index =3D i;
+		}
+	}
+	if ((i - comma_index) > 0)
+		count++;
+	return count;
+}
+
+struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err)
+{
+	struct kunit_attr_filter filter =3D {};
+	int i, j, comma_index, new_start_index;
+	int op_index =3D -1, attr_index =3D -1;
+	char op;
+	char *input =3D *filters;
+
+	/* Parse input until operation */
+	for (i =3D 0; input[i]; i++) {
+		if (op_index < 0 && strchr(op_list, input[i])) {
+			op_index =3D i;
+		} else if (!comma_index && input[i] =3D=3D ',') {
+			comma_index =3D i;
+		} else if (comma_index && input[i] !=3D ' ') {
+			new_start_index =3D i;
+			break;
+		}
+	}
+
+	if (op_index <=3D 0) {
+		*err =3D -EINVAL;
+		pr_err("kunit executor: filter operation not found: %s\n", input);
+		return filter;
+	}
+
+	/* Temporarily set operator to \0 character. */
+	op =3D input[op_index];
+	input[op_index] =3D '\0';
+
+	/* Find associated kunit_attr object */
+	for (j =3D 0; j < ARRAY_SIZE(kunit_attr_list); j++) {
+		if (!strcmp(input, kunit_attr_list[j].name)) {
+			attr_index =3D j;
+			break;
+		}
+	}
+
+	input[op_index] =3D op;
+
+	if (attr_index < 0) {
+		*err =3D -EINVAL;
+		pr_err("kunit executor: attribute not found: %s\n", input);
+	} else {
+		filter.attr =3D &kunit_attr_list[attr_index];
+	}
+
+	if (comma_index) {
+		input[comma_index] =3D '\0';
+		filter.input =3D input + op_index;
+		input =3D input + new_start_index;
+	} else {
+		filter.input =3D input + op_index;
+		input =3D NULL;
+	}
+
+	*filters =3D input;
+
+	return filter;
+}
+
+struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *cons=
t suite,
+		struct kunit_attr_filter filter, char *action, int *err)
+{
+	int n =3D 0;
+	struct kunit_case *filtered, *test_case;
+	struct kunit_suite *copy;
+	void *suite_val, *test_val;
+	bool suite_result, test_result, default_result, result;
+
+	/* Allocate memory for new copy of suite and list of test cases */
+	copy =3D kmemdup(suite, sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
+
+	kunit_suite_for_each_test_case(suite, test_case) { n++; }
+
+	filtered =3D kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
+	if (!filtered) {
+		kfree(copy);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	n =3D 0;
+
+	/* Save filtering result on default value */
+	default_result =3D filter.attr->filter(filter.attr->attr_default, filter.=
input, err);
+	if (*err) {
+		kfree(copy);
+		kfree(filtered);
+		return NULL;
+	}
+
+	/* Save suite attribute value and filtering result on that value */
+	suite_val =3D filter.attr->get_attr((void *)suite, false);
+	suite_result =3D filter.attr->filter(suite_val, filter.input, err);
+	if (*err) {
+		kfree(copy);
+		kfree(filtered);
+		return NULL;
+	}
+
+	/* For each test case, save test case if passes filtering. */
+	kunit_suite_for_each_test_case(suite, test_case) {
+		test_val =3D filter.attr->get_attr((void *) test_case, true);
+		test_result =3D filter.attr->filter(filter.attr->get_attr(test_case, tru=
e),
+				filter.input, err);
+		if (*err) {
+			kfree(copy);
+			kfree(filtered);
+			return NULL;
+		}
+
+		/*
+		 * If attribute value of test case is set, filter on that value.
+		 * If not, filter on suite value if set. If not, filter on
+		 * default value.
+		 */
+		result =3D false;
+		if (test_val) {
+			if (test_result)
+				result =3D true;
+		} else if (suite_val) {
+			if (suite_result)
+				result =3D true;
+		} else if (default_result) {
+			result =3D true;
+		}
+
+		if (result) {
+			filtered[n++] =3D *test_case;
+		} else if (action && strcmp(action, "skip") =3D=3D 0) {
+			test_case->status =3D KUNIT_SKIPPED;
+			filtered[n++] =3D *test_case;
+		}
+	}
+
+	if (n =3D=3D 0) {
+		kfree(copy);
+		kfree(filtered);
+		return NULL;
+	}
+
+	copy->test_cases =3D filtered;
+
+	return copy;
+}
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 12e38a48a5cc..483f7b7873a7 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -17,6 +17,8 @@ extern struct kunit_suite * const __kunit_suites_end[];
=20
 static char *filter_glob_param;
 static char *action_param;
+static char *filter_param;
+static char *filter_action_param;
=20
 module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
@@ -27,15 +29,23 @@ MODULE_PARM_DESC(action,
 		 "<none>: run the tests like normal\n"
 		 "'list' to list test names instead of running them.\n"
 		 "'list_attr' to list test names and attributes instead of running them.=
\n");
+module_param_named(filter, filter_param, charp, 0);
+MODULE_PARM_DESC(filter,
+		"Filter which KUnit test suites/tests run at boot-time using attributes,=
 e.g. speed>slow");
+module_param_named(filter_action, filter_action_param, charp, 0);
+MODULE_PARM_DESC(filter_action,
+		"Changes behavior of filtered tests using attributes, valid values are:\=
n"
+		"<none>: do not run filtered tests as normal\n"
+		"'skip': skip all filtered tests instead so tests will appear in output\=
n");
=20
 /* glob_match() needs NULL terminated strings, so we need a copy of filter=
_glob_param. */
-struct kunit_test_filter {
+struct kunit_glob_filter {
 	char *suite_glob;
 	char *test_glob;
 };
=20
 /* Split "suite_glob.test_glob" into two. Assumes filter_glob is not empty=
. */
-static void kunit_parse_filter_glob(struct kunit_test_filter *parsed,
+static void kunit_parse_glob_filter(struct kunit_glob_filter *parsed,
 				    const char *filter_glob)
 {
 	const int len =3D strlen(filter_glob);
@@ -57,7 +67,7 @@ static void kunit_parse_filter_glob(struct kunit_test_fil=
ter *parsed,
=20
 /* Create a copy of suite with only tests that match test_glob. */
 static struct kunit_suite *
-kunit_filter_tests(const struct kunit_suite *const suite, const char *test=
_glob)
+kunit_filter_glob_tests(const struct kunit_suite *const suite, const char =
*test_glob)
 {
 	int n =3D 0;
 	struct kunit_case *filtered, *test_case;
@@ -111,12 +121,15 @@ static void kunit_free_suite_set(struct suite_set sui=
te_set)
=20
 static struct suite_set kunit_filter_suites(const struct suite_set *suite_=
set,
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
=20
 	const size_t max =3D suite_set->end - suite_set->start;
=20
@@ -127,17 +140,52 @@ static struct suite_set kunit_filter_suites(const str=
uct suite_set *suite_set,
 		return filtered;
 	}
=20
-	kunit_parse_filter_glob(&filter, filter_glob);
+	if (filter_glob)
+		kunit_parse_glob_filter(&parsed_glob, filter_glob);
=20
-	for (i =3D 0; &suite_set->start[i] !=3D suite_set->end; i++) {
-		if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
-			continue;
-
-		filtered_suite =3D kunit_filter_tests(suite_set->start[i], filter.test_g=
lob);
-		if (IS_ERR(filtered_suite)) {
-			*err =3D PTR_ERR(filtered_suite);
+	/* Parse attribute filters */
+	if (filters) {
+		filter_count =3D kunit_get_filter_count(filters);
+		parsed_filters =3D kcalloc(filter_count + 1, sizeof(*parsed_filters), GF=
P_KERNEL);
+		for (j =3D 0; j < filter_count; j++)
+			parsed_filters[j] =3D kunit_next_attr_filter(&filters, err);
+		if (*err)
 			return filtered;
+	}
+
+	for (i =3D 0; &suite_set->start[i] !=3D suite_set->end; i++) {
+		filtered_suite =3D suite_set->start[i];
+		if (filter_glob) {
+			if (!glob_match(parsed_glob.suite_glob, filtered_suite->name))
+				continue;
+			filtered_suite =3D kunit_filter_glob_tests(filtered_suite,
+					parsed_glob.test_glob);
+			if (IS_ERR(filtered_suite)) {
+				*err =3D PTR_ERR(filtered_suite);
+				return filtered;
+			}
 		}
+		if (filter_count) {
+			for (k =3D 0; k < filter_count; k++) {
+				new_filtered_suite =3D kunit_filter_attr_tests(filtered_suite,
+						parsed_filters[k], filter_action, err);
+
+				/* Free previous copy of suite */
+				if (k > 0 || filter_glob)
+					kfree(filtered_suite);
+				filtered_suite =3D new_filtered_suite;
+
+				if (*err)
+					return filtered;
+				if (IS_ERR(filtered_suite)) {
+					*err =3D PTR_ERR(filtered_suite);
+					return filtered;
+				}
+				if (!filtered_suite)
+					break;
+			}
+		}
+
 		if (!filtered_suite)
 			continue;
=20
@@ -145,8 +193,14 @@ static struct suite_set kunit_filter_suites(const stru=
ct suite_set *suite_set,
 	}
 	filtered.end =3D copy;
=20
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
=20
@@ -206,8 +260,9 @@ int kunit_run_all_tests(void)
 		goto out;
 	}
=20
-	if (filter_glob_param) {
-		suite_set =3D kunit_filter_suites(&suite_set, filter_glob_param, &err);
+	if (filter_glob_param || filter_param) {
+		suite_set =3D kunit_filter_suites(&suite_set, filter_glob_param,
+				filter_param, filter_action_param, &err);
 		if (err) {
 			pr_err("kunit executor: error filtering suites: %d\n", err);
 			goto out;
@@ -223,7 +278,7 @@ int kunit_run_all_tests(void)
 	else
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
=20
-	if (filter_glob_param) { /* a copy was made of each suite */
+	if (filter_glob_param || filter_param) { /* a copy was made of each suite=
 */
 		kunit_free_suite_set(suite_set);
 	}
=20
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index ce6749af374d..d7ab069324b5 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -24,15 +24,15 @@ static struct kunit_case dummy_test_cases[] =3D {
=20
 static void parse_filter_test(struct kunit *test)
 {
-	struct kunit_test_filter filter =3D {NULL, NULL};
+	struct kunit_glob_filter filter =3D {NULL, NULL};
=20
-	kunit_parse_filter_glob(&filter, "suite");
+	kunit_parse_glob_filter(&filter, "suite");
 	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
 	KUNIT_EXPECT_FALSE(test, filter.test_glob);
 	kfree(filter.suite_glob);
 	kfree(filter.test_glob);
=20
-	kunit_parse_filter_glob(&filter, "suite.test");
+	kunit_parse_glob_filter(&filter, "suite.test");
 	KUNIT_EXPECT_STREQ(test, filter.suite_glob, "suite");
 	KUNIT_EXPECT_STREQ(test, filter.test_glob, "test");
 	kfree(filter.suite_glob);
@@ -50,7 +50,7 @@ static void filter_suites_test(struct kunit *test)
 	subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_test_cases);
=20
 	/* Want: suite1, suite2, NULL -> suite2, NULL */
-	got =3D kunit_filter_suites(&suite_set, "suite2", &err);
+	got =3D kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -74,7 +74,7 @@ static void filter_suites_test_glob_test(struct kunit *te=
st)
 	subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_test_cases);
=20
 	/* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
-	got =3D kunit_filter_suites(&suite_set, "suite2.test2", &err);
+	got =3D kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err)=
;
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -100,7 +100,7 @@ static void filter_suites_to_empty_test(struct kunit *t=
est)
 	subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_test_cases);
=20
-	got =3D kunit_filter_suites(&suite_set, "not_found", &err);
+	got =3D kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start); /* just in case */
=20
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 9ee55139ecd1..cb9797fa6303 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -613,18 +613,22 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test =3D { .param_value =3D NULL, .param_index =3D 0 };
 		struct kunit_result_stats param_stats =3D { 0 };
-		test_case->status =3D KUNIT_SKIPPED;
=20
 		kunit_init_test(&test, test_case->name, test_case->log);
-
-		if (!test_case->generate_params) {
+		if (test_case->status =3D=3D KUNIT_SKIPPED) {
+			/* Test marked as skip */
+			test.status =3D KUNIT_SKIPPED;
+			kunit_update_stats(&param_stats, test.status);
+		} else if (!test_case->generate_params) {
 			/* Non-parameterised test. */
+			test_case->status =3D KUNIT_SKIPPED;
 			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
 		} else {
 			/* Get initial param. */
 			param_desc[0] =3D '\0';
 			test.param_value =3D test_case->generate_params(NULL, param_desc);
+			test_case->status =3D KUNIT_SKIPPED;
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
--=20
2.41.0.487.g6d72f3e995-goog

