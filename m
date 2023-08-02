Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3576D97D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjHBV2k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjHBV2j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:28:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E95019A0
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 14:28:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584126c65d1so1737677b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691011717; x=1691616517;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=icjiEwYAydMlzsRZ8GnEIvFOFSe1szS76VxxnsFH640=;
        b=gs1AYJ4+CvQT/+aMUh1flJrlvS3Qzwy5Q2A3K7MBW4sLteIo/kC24KqrmQFPM7t55S
         a2BhoOC55cwvp7PnytvAezuMeq0d301xQtaQbdFdct2XWWVdGm+3ID2oDQuqqdB57cdN
         ddH/bqDFQbWpU8thUIMs/CD2+GOifMgxCgu+O+Q7uU5kgFR5ttJnY7qknE14tffEEgHA
         dBFoP01vN5NBqV4vvKyRoG0KAgCntsT8skuZb8NyXLUpvK+77snvXHcvdVJ7eY71rq76
         oqqGbxYJdlDRZx8U13Ey+T6MWkYdeofxzX2m8mwi+05nimAhCgjvD0uJ5riI+RZQxN2L
         nYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691011717; x=1691616517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icjiEwYAydMlzsRZ8GnEIvFOFSe1szS76VxxnsFH640=;
        b=MTQ2JijBQasQ4UR7ufT1D4g1LnWk0xNO3ei3me4fIjuhKu+m4FXFc0BF2pAYjAAzoi
         m+IQu2GkJvYZEjbB54OmAx2JfQLfNg4avXO/IuvhmwfiznVfFb6z1AbVDS9HozA9IXH6
         kymErD6b56bHoQ+Ws0mdxvbuq87ci0ecTE22TgWN68+8ltlzdgWibAptKLLv+xAvQM1z
         oSIrhQGnKfda67NwaWxMBFJNhEEmuhBJDVzdTCLStoraouWOllmTtYs/pmyh2CF86LeG
         D+pj9Xvw24rgPPppPYwphCCPtU8jRcvY2j1b6NZuvsO/9ThFSaQrX8ma3mMUbp71uYVI
         mtfA==
X-Gm-Message-State: ABy/qLYTWpF+ZlJY1k56M4D5S1deYqeu51ZuWDGRY1zIWcjOww3Owh+A
        EQj4F6VAaNJihMTNoBOnllf5yL9Y1A==
X-Google-Smtp-Source: APBJJlG4oGBttMFLWAh4wb5lb/djVKbLKECONDMHKlsL1QIilZzq4Q9LdpyJ77FpiG3xEaVEoL2hzxOv7g==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:4304:0:b0:584:43af:7b0d with SMTP id
 q4-20020a814304000000b0058443af7b0dmr148419ywa.2.1691011717332; Wed, 02 Aug
 2023 14:28:37 -0700 (PDT)
Date:   Wed,  2 Aug 2023 21:28:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802212834.761327-1-rmoar@google.com>
Subject: [PATCH -next] kunit: fix uninitialized variables bug in attributes filtering
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev
Cc:     ruanjinjie@huawei.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix smatch warnings regarding uninitialized variables in the filtering
patch of the new KUnit Attributes feature.

Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307270610.s0w4NKEn-lkp@intel.com/

Signed-off-by: Rae Moar <rmoar@google.com>
---

Note that this is rebased on top of the recent fix:
("kunit: fix possible memory leak in kunit_filter_suites()").

 lib/kunit/attributes.c | 40 +++++++++++++++++-----------------------
 lib/kunit/executor.c   | 10 +++++++---
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index d37c40c0ce4f..5e3034b6be99 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -102,7 +102,7 @@ static int int_filter(long val, const char *op, int input, int *err)
 static int attr_enum_filter(void *attr, const char *input, int *err,
 		const char * const str_list[], int max)
 {
-	int i, j, input_int;
+	int i, j, input_int = -1;
 	long test_val = (long)attr;
 	const char *input_val = NULL;
 
@@ -124,7 +124,7 @@ static int attr_enum_filter(void *attr, const char *input, int *err,
 			input_int = j;
 	}
 
-	if (!input_int) {
+	if (input_int < 0) {
 		*err = -EINVAL;
 		pr_err("kunit executor: invalid filter input: %s\n", input);
 		return false;
@@ -186,8 +186,10 @@ static void *attr_module_get(void *test_or_suite, bool is_test)
 	// Suites get their module attribute from their first test_case
 	if (test)
 		return ((void *) test->module_name);
-	else
+	else if (kunit_suite_num_test_cases(suite) > 0)
 		return ((void *) suite->test_cases[0].module_name);
+	else
+		return (void *) "";
 }
 
 /* List of all Test Attributes */
@@ -221,7 +223,7 @@ const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
 void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level)
 {
 	int i;
-	bool to_free;
+	bool to_free = false;
 	void *attr;
 	const char *attr_name, *attr_str;
 	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
@@ -255,7 +257,7 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
 
 int kunit_get_filter_count(char *input)
 {
-	int i, comma_index, count = 0;
+	int i, comma_index = 0, count = 0;
 
 	for (i = 0; input[i]; i++) {
 		if (input[i] == ',') {
@@ -272,7 +274,7 @@ int kunit_get_filter_count(char *input)
 struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err)
 {
 	struct kunit_attr_filter filter = {};
-	int i, j, comma_index, new_start_index;
+	int i, j, comma_index = 0, new_start_index = 0;
 	int op_index = -1, attr_index = -1;
 	char op;
 	char *input = *filters;
@@ -316,7 +318,7 @@ struct kunit_attr_filter kunit_next_attr_filter(char **filters, int *err)
 		filter.attr = &kunit_attr_list[attr_index];
 	}
 
-	if (comma_index) {
+	if (comma_index > 0) {
 		input[comma_index] = '\0';
 		filter.input = input + op_index;
 		input = input + new_start_index;
@@ -356,31 +358,22 @@ struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suit
 
 	/* Save filtering result on default value */
 	default_result = filter.attr->filter(filter.attr->attr_default, filter.input, err);
-	if (*err) {
-		kfree(copy);
-		kfree(filtered);
-		return NULL;
-	}
+	if (*err)
+		goto err;
 
 	/* Save suite attribute value and filtering result on that value */
 	suite_val = filter.attr->get_attr((void *)suite, false);
 	suite_result = filter.attr->filter(suite_val, filter.input, err);
-	if (*err) {
-		kfree(copy);
-		kfree(filtered);
-		return NULL;
-	}
+	if (*err)
+		goto err;
 
 	/* For each test case, save test case if passes filtering. */
 	kunit_suite_for_each_test_case(suite, test_case) {
 		test_val = filter.attr->get_attr((void *) test_case, true);
 		test_result = filter.attr->filter(filter.attr->get_attr(test_case, true),
 				filter.input, err);
-		if (*err) {
-			kfree(copy);
-			kfree(filtered);
-			return NULL;
-		}
+		if (*err)
+			goto err;
 
 		/*
 		 * If attribute value of test case is set, filter on that value.
@@ -406,7 +399,8 @@ struct kunit_suite *kunit_filter_attr_tests(const struct kunit_suite *const suit
 		}
 	}
 
-	if (n == 0) {
+err:
+	if (n == 0 || *err) {
 		kfree(copy);
 		kfree(filtered);
 		return NULL;
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 481901d245d0..b6e07de2876a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -130,7 +130,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 	struct kunit_suite **copy, *filtered_suite, *new_filtered_suite;
 	struct suite_set filtered;
 	struct kunit_glob_filter parsed_glob;
-	struct kunit_attr_filter *parsed_filters;
+	struct kunit_attr_filter *parsed_filters = NULL;
 
 	const size_t max = suite_set->end - suite_set->start;
 
@@ -147,7 +147,11 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 	/* Parse attribute filters */
 	if (filters) {
 		filter_count = kunit_get_filter_count(filters);
-		parsed_filters = kcalloc(filter_count + 1, sizeof(*parsed_filters), GFP_KERNEL);
+		parsed_filters = kcalloc(filter_count, sizeof(*parsed_filters), GFP_KERNEL);
+		if (!parsed_filters) {
+			kfree(copy);
+			return filtered;
+		}
 		for (j = 0; j < filter_count; j++)
 			parsed_filters[j] = kunit_next_attr_filter(&filters, err);
 		if (*err)
@@ -166,7 +170,7 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 				goto err;
 			}
 		}
-		if (filter_count) {
+		if (filter_count > 0 && parsed_filters != NULL) {
 			for (k = 0; k < filter_count; k++) {
 				new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
 						parsed_filters[k], filter_action, err);

base-commit: 3bffe185ad11e408903d2782727877388d08d94e
-- 
2.41.0.585.gd2178a4bd4-goog

