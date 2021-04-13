Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD67635D453
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 02:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbhDMAIb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 20:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbhDMAIb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 20:08:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59691C061756
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 17:08:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c4so1152041ybp.6
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=528n/XU1I2aQix/5LzpH6U+fVKtBCozvVZSzDVU9kHk=;
        b=QFEOkq5d8vO/qSnz0eiFMeEa/WpbJXLNxN4qNchD6wj5dfcyJ8PNA4oHZTEz7KSHY8
         qy3i7ywZ9nmbW0eDWB9pzPkOj469JGJBp5CRDb3lL+QIntai8MQVn0OZcBiwKsC+Jw0D
         8XK7bkVqWKfVGvvaT4icvpu43V0+FMXKCVVyQ2OTy6uyOEI6Zd4FsoruhRLqZxwnxa8V
         UNSrJkHZb6F0faqL97QQyp5+uEu9ydicbixNqnCP0Jg1izG8ZR7jDSNcXlv4t892ciZG
         ZTZeNCgYq04gwqs4waUZNkGD1HvBEboOkESWvK6IL2vzb/2h29fOXjed4wDh3jUqGPc9
         xm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=528n/XU1I2aQix/5LzpH6U+fVKtBCozvVZSzDVU9kHk=;
        b=WewGi+qg0SUSFxrwAqMe5zkozA+ANBROvtil5EySYJCWihd6lZLUXfQIlUTxk5r8h4
         ypTO7W8wq0B+IIDTTejXjBWG3V5rjWaI7fYAe0TCkbrylzf3OE+hw85270HaL0kusUfg
         MysE0ulO6YAl3X2PisNMFzn/+Kl5OVNfwpGdEfeE+WK7wrukqXzR/6APcbsNk9tH1YiZ
         Yultoda/CNjtKKZ5uvdm5x2NmI7fE1n/5u6dOJyXFx8kBr2Y2z6NcrNlHpPzBrjUwx0E
         AKZARNdkuURdKi4CaCOvbSHxd4wvyU/9W2hTLweCGrfpYa8D0A/qik30AP1LO9tGIaJl
         Phbg==
X-Gm-Message-State: AOAM532DaPQek4Oz88Y3Xazy+nKj9WtpAtnFkph0H9Fh71JjFRf+y0MD
        3WozJUBzu68V++eaH6n/xrSOlLuxYB19FA==
X-Google-Smtp-Source: ABdhPJya6eMpR5lhPM6eJCOliv3v2eGzjeSxZeG+5umxlWDyjW+zvpFGG4fttZrVefwTowrqg3GM2v0oSfMCKA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:9582:4774:7806:b32])
 (user=dlatypov job=sendgmr) by 2002:a25:d7d4:: with SMTP id
 o203mr31497028ybg.95.1618272491634; Mon, 12 Apr 2021 17:08:11 -0700 (PDT)
Date:   Mon, 12 Apr 2021 17:08:03 -0700
Message-Id: <20210413000803.778099-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH] kunit: add unit test for filtering suites by names
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
---
 lib/kunit/executor.c      |  26 ++++----
 lib/kunit/executor_test.c | 132 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 11 deletions(-)
 create mode 100644 lib/kunit/executor_test.c

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 15832ed44668..96a4ae983786 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -19,7 +19,7 @@ MODULE_PARM_DESC(filter_glob,
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
@@ -98,8 +93,13 @@ static void kunit_print_tap_header(struct suite_set *suite_set)
 int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
+	struct suite_set suite_set = {
+		.start = __kunit_suites_start,
+		.end = __kunit_suites_end,
+	};
 
-	struct suite_set suite_set = kunit_filter_suites();
+	if (filter_glob)
+		suite_set = kunit_filter_suites(&suite_set, filter_glob);
 
 	kunit_print_tap_header(&suite_set);
 
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
index 000000000000..8e925395beeb
--- /dev/null
+++ b/lib/kunit/executor_test.c
@@ -0,0 +1,132 @@
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
+	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t) 1);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
+	KUNIT_EXPECT_PTR_EQ(test, filtered.start[0][0], subsuites[0][0]);
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
+	strncpy((char *)suite->name, suite_name, sizeof(suite->name));
+
+	return suite;
+}

base-commit: 1678e493d530e7977cce34e59a86bb86f3c5631e
-- 
2.31.1.295.g9ea45b61b8-goog

