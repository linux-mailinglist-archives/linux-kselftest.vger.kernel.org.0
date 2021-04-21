Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E384366384
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 04:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhDUCFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 22:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhDUCFI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 22:05:08 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B03C06174A
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 19:04:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id e20-20020ad442b40000b029019aa511c767so12806338qvr.18
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 19:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9wnepvAIiPeI4uW68+y/nvurX2H2DUlpv6zhZL15jVQ=;
        b=jvtiPIWgF7Txh9+gr5TtPwIofSRPGiqKKSEkjH6CE9Hf/DY9yY6p7rDt7Vw83JJjzr
         WCSKoAf6UPRQCZ+gJwbchaQackZpfDouqsCXqnOEOEjNdTU7AafYlvuUdf0YrpfPod84
         UPf1FLjGTCYuq9ZwZdTOU8TnNm9U5eNExY0+dwt9NJ28mZjyW0uHpWzOurKPukDiPF4t
         foYHUUgFv9BezYxucYp2B4BXJUGER2cos2YpNpQ1/ZOwYRTfTsvcBqhF/WNfPpGoADIm
         eG+lVRWCmCbrIfziiB4XWQv8zaEAuscgsWtCsWKw/wHHeHJltzUJbIs5a+LqeinTEAoR
         VgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9wnepvAIiPeI4uW68+y/nvurX2H2DUlpv6zhZL15jVQ=;
        b=o7XwUkCzy3HVdQmZyEDjR9XDcqaZOo1iKwW2Jl/VWbfGH2WRtfNz/Ge9+7lCyzrrVu
         qiK+6zSMCJ1rWh3U86/sXBi44ODiyzwPMX9S3VzVJkjzfThro032orOgRmCWdHqCWkje
         +1H4UNcJnyY0Xh7oKh1o/9IpZNgLT67u5b1t1w4fH2t28PfQnPyHO2+aEuEIWvT4Wz71
         sGdmhx51EE/Dzl9IaMK2S7KGp0UAh/i5GIrfeqjazWVKxpAXBubNwVB6nhKyOm3YU3/v
         Y3ArcJMfOvg2UQ1K3qOFdZ72f9GIgDMp9Dq1W8u1NhdkwQJ7fcPgvQXuhd2keiGy92Ua
         3AtA==
X-Gm-Message-State: AOAM5302Ek8RidFk4sg19OtDb5Cy3jacdC34hXhmuNlC3KUUVu7zxl99
        7oH191fQwh9hbHYtj+zOUIRjMouwfyvanw==
X-Google-Smtp-Source: ABdhPJy/JnGNtnJt3hkZhhuTzoK3BcHB9Kg9kODkkyStq34OHMj+zPgo+F0HjhDR9efWiGBzLM3lCm+JoK+BWw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5d5e:54c8:8f31:890f])
 (user=dlatypov job=sendgmr) by 2002:a0c:a163:: with SMTP id
 d90mr24280178qva.24.1618970673572; Tue, 20 Apr 2021 19:04:33 -0700 (PDT)
Date:   Tue, 20 Apr 2021 19:04:27 -0700
Message-Id: <20210421020427.2384721-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3] kunit: add unit test for filtering suites by names
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds unit tests for kunit_filter_subsuite() and
kunit_filter_suites().

Note: what the executor means by "subsuite" is the array of suites
corresponding to each test file.

This patch lightly refactors executor.c to avoid the use of global
variables to make it testable.
It also includes a clever `kfree_at_end()` helper that makes this test
easier to write than it otherwise would have been.

Tested by running just the new tests using itself
$ ./tools/testing/kunit/kunit.py run '*exec*'

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v2 -> v3:
* Rename variable for filter_glob module param to avoid compiler
warnings. Couldn't think of a better name for the argument.
v1 -> v2:
* Fix missing free in kfree_subsuites_at_end()
---
 lib/kunit/executor.c      |  32 +++++----
 lib/kunit/executor_test.c | 133 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 14 deletions(-)
 create mode 100644 lib/kunit/executor_test.c

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 15832ed44668..b6af56267f9b 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -13,13 +13,13 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static char *filter_glob;
-module_param(filter_glob, charp, 0);
+static char *filter_glob_param;
+module_param_named(filter_glob, filter_glob_param, charp, 0);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites run at boot-time, e.g. list*");
 
 static struct kunit_suite * const *
-kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
+kunit_filter_subsuite(struct kunit_suite * const * const subsuite, const char *filter_glob)
 {
 	int i, n = 0;
 	struct kunit_suite **filtered;
@@ -52,19 +52,14 @@ struct suite_set {
 	struct kunit_suite * const * const *end;
 };
 
-static struct suite_set kunit_filter_suites(void)
+static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
+					    const char *filter_glob)
 {
 	int i;
 	struct kunit_suite * const **copy, * const *filtered_subsuite;
 	struct suite_set filtered;
 
-	const size_t max = __kunit_suites_end - __kunit_suites_start;
-
-	if (!filter_glob) {
-		filtered.start = __kunit_suites_start;
-		filtered.end = __kunit_suites_end;
-		return filtered;
-	}
+	const size_t max = suite_set->end - suite_set->start;
 
 	copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
 	filtered.start = copy;
@@ -74,7 +69,7 @@ static struct suite_set kunit_filter_suites(void)
 	}
 
 	for (i = 0; i < max; ++i) {
-		filtered_subsuite = kunit_filter_subsuite(__kunit_suites_start[i]);
+		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], filter_glob);
 		if (filtered_subsuite)
 			*copy++ = filtered_subsuite;
 	}
@@ -98,15 +93,20 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
+	struct suite_set suite_set = {
+		.start = __kunit_suites_start,
+		.end = __kunit_suites_end,
+	};
 
-	struct suite_set suite_set = kunit_filter_suites();
+	if (filter_glob_param)
+		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
 
 	kunit_print_tap_header(&suite_set);
 
 	for (suites = suite_set.start; suites < suite_set.end; suites++)
 		__kunit_test_suites_init(*suites);
 
-	if (filter_glob) { /* a copy was made of each array */
+	if (filter_glob_param) { /* a copy was made of each array */
 		for (suites = suite_set.start; suites < suite_set.end; suites++)
 			kfree(*suites);
 		kfree(suite_set.start);
@@ -115,4 +115,8 @@ int kunit_run_all_tests(void)
 	return 0;
 }
 
+#if IS_BUILTIN(CONFIG_KUNIT_TEST)
+#include "executor_test.c"
+#endif
+
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
new file mode 100644
index 000000000000..cdbe54b16501
--- /dev/null
+++ b/lib/kunit/executor_test.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the KUnit executor.
+ *
+ * Copyright (C) 2021, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#include <kunit/test.h>
+
+static void kfree_at_end(struct kunit *test, const void *to_free);
+static struct kunit_suite *alloc_fake_suite(struct kunit *test,
+					    const char *suite_name);
+
+static void filter_subsuite_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
+	struct kunit_suite * const *filtered;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1");
+	subsuite[1] = alloc_fake_suite(test, "suite2");
+
+	/* Want: suite1, suite2, NULL -> suite2, NULL */
+	filtered = kunit_filter_subsuite(subsuite, "suite2*");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
+	kfree_at_end(test, filtered);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
+
+	KUNIT_EXPECT_FALSE(test, filtered[1]);
+}
+
+static void filter_subsuite_to_empty_test(struct kunit *test)
+{
+	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
+	struct kunit_suite * const *filtered;
+
+	subsuite[0] = alloc_fake_suite(test, "suite1");
+	subsuite[1] = alloc_fake_suite(test, "suite2");
+
+	filtered = kunit_filter_subsuite(subsuite, "not_found");
+	kfree_at_end(test, filtered); /* just in case */
+
+	KUNIT_EXPECT_FALSE_MSG(test, filtered,
+			       "should be NULL to indicate no match");
+}
+
+static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_set)
+{
+	struct kunit_suite * const * const *suites;
+
+	kfree_at_end(test, suite_set->start);
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
+		kfree_at_end(test, *suites);
+}
+
+static void filter_suites_test(struct kunit *test)
+{
+	/* Suites per-file are stored as a NULL terminated array */
+	struct kunit_suite *subsuites[2][2] = {
+		{NULL, NULL},
+		{NULL, NULL},
+	};
+	/* Match the memory layout of suite_set */
+	struct kunit_suite * const * const suites[2] = {
+		subsuites[0], subsuites[1],
+	};
+
+	const struct suite_set suite_set = {
+		.start = suites,
+		.end = suites + 2,
+	};
+	struct suite_set filtered = {.start = NULL, .end = NULL};
+
+	/* Emulate two files, each having one suite */
+	subsuites[0][0] = alloc_fake_suite(test, "suite0");
+	subsuites[1][0] = alloc_fake_suite(test, "suite1");
+
+	/* Filter out suite1 */
+	filtered = kunit_filter_suites(&suite_set, "suite0");
+	kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
+	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
+}
+
+static struct kunit_case executor_test_cases[] = {
+	KUNIT_CASE(filter_subsuite_test),
+	KUNIT_CASE(filter_subsuite_to_empty_test),
+	KUNIT_CASE(filter_suites_test),
+	{}
+};
+
+static struct kunit_suite executor_test_suite = {
+	.name = "kunit_executor_test",
+	.test_cases = executor_test_cases,
+};
+
+kunit_test_suites(&executor_test_suite);
+
+/* Test helpers */
+
+static void kfree_res_free(struct kunit_resource *res)
+{
+	kfree(res->data);
+}
+
+/* Use the resource API to register a call to kfree(to_free).
+ * Since we never actually use the resource, it's safe to use on const data.
+ */
+static void kfree_at_end(struct kunit *test, const void *to_free)
+{
+	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
+	if (IS_ERR_OR_NULL(to_free))
+		return;
+	kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
+				     (void *)to_free);
+}
+
+static struct kunit_suite *alloc_fake_suite(struct kunit *test,
+					    const char *suite_name)
+{
+	struct kunit_suite *suite;
+
+	/* We normally never expect to allocate suites, hence the non-const cast. */
+	suite = kunit_kzalloc(test, sizeof(*suite), GFP_KERNEL);
+	strncpy((char *)suite->name, suite_name, sizeof(suite->name) - 1);
+
+	return suite;
+}

base-commit: 1fe5501ba1abf2b7e78295df73675423bd6899a0
-- 
2.31.1.368.gbe11c130af-goog

