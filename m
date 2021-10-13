Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5A42C9B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhJMTPb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhJMTPa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 15:15:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B99C061749
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 12:13:27 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id hf12-20020a0562140e8c00b00382cdfe644eso3457189qvb.23
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MKK+CXEpaQqB6Bpq/+AFr2QdyHGAw0BrPgXonyk0YJw=;
        b=r1XBWugv3/h3NPRZYYpAoUC6yGmLu4NNqWLPNapN5Mfiy5DSNxdHnWD+wlQTcxtRBH
         +fCFj2kxzzbwNCcQEaR+AtJVCu5MrkFyq05a2W/wHtl5NGuYckeWjuwEU7EjmaUeUW3B
         QrComWj4HtvEB04eXP1fglFVrKTc5ZgGyTV9ellv+UljODd1F6NgDvuvort/Cn9w8s00
         E4e2rC88R2C4KSa7b7y3t0WdC3Fe6qoi1MJxEIeY5mBK79Ut6cX+9aX4yqu6Uibwfoxu
         9He3l6oZcfzAj+PRuQtD2GH5Ez9CWWNNpMUrc82d+GLz7avCt6K6manL/iX8Xqmsa1Vb
         dPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MKK+CXEpaQqB6Bpq/+AFr2QdyHGAw0BrPgXonyk0YJw=;
        b=huaLklV8qzhxmTpZDXrccbUkIcKj5CGZ0J2hx0oV7F18yosIXwnhYhFyCmUHvmdvj7
         KXKIq1VNman4SiKt3JfjnMYNMJO9ZVS18slRUrAbnl/WZNSPVLH+bTxDin2gJDDsSrbU
         v93jLTadtPh5RPeBUeKtdCtofrTwBPIwvI5UTa3cmzBat5PoVLlJ9ufSTh1N3RGgvGxB
         U6s7T5Jph1xdTpaPTbOjW3fYHq9CNE9nJT2UwYq71HBLhNhUYDKWEPhuMKPSxHY/wG63
         Vxdg3vtZYi+t1WObgChZJUdQK88BYn5w+3dWcL8ceiuKzOQfd+5C1XzousPRJjerB/0o
         LeTw==
X-Gm-Message-State: AOAM532PWFmK11knl7M2F/NI15952MGb8NXXsGxsdS9BY3SKK4PIvowr
        ZRBBUKSD8B/Ni87b00WlhjZ99JRsXfOw6w==
X-Google-Smtp-Source: ABdhPJztb5MFeGXcX38720qLFiM1184+DmM1Ml/EPVf5wv6RUl8vOPzH9g3YnMEegNFmXoZnkfPH/Ov7tL/o/g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:6adf:4441:ce1f:a848])
 (user=dlatypov job=sendgmr) by 2002:ac8:3e8a:: with SMTP id
 y10mr1364349qtf.31.1634152406327; Wed, 13 Oct 2021 12:13:26 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:13:20 -0700
Message-Id: <20211013191320.2490913-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH] kunit: flatten kunit_suite*** to kunit_suite** in executor
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Per [1], we might not need the array-of-array of kunit_suite's.

This RFC patch previews the changes we'd make to the executor to
accommodate that by making the executor automatically flatten the
kunit_suite*** into a kunit_suite**.

The test filtering support [2] added the largest dependency on the
current kunit_suite*** layout, so this patch is based on that.

It actually drastically simplifies the code, so it might be useful to
keep the auto-flattening step until we actually make the change.

[1] https://lore.kernel.org/linux-kselftest/101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=3b29021ddd10cfb6b2565c623595bd3b02036f33

Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c      | 132 +++++++++++++++-----------------------
 lib/kunit/executor_test.c | 131 ++++++++++---------------------------
 2 files changed, 85 insertions(+), 178 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 22640c9ee819..3a7246336625 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -88,60 +88,18 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
 static char *kunit_shutdown;
 core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
 
-static struct kunit_suite * const *
-kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
-		      struct kunit_test_filter *filter)
-{
-	int i, n = 0;
-	struct kunit_suite **filtered, *filtered_suite;
-
-	n = 0;
-	for (i = 0; subsuite[i]; ++i) {
-		if (glob_match(filter->suite_glob, subsuite[i]->name))
-			++n;
-	}
-
-	if (n == 0)
-		return NULL;
-
-	filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
-	if (!filtered)
-		return NULL;
-
-	n = 0;
-	for (i = 0; subsuite[i] != NULL; ++i) {
-		if (!glob_match(filter->suite_glob, subsuite[i]->name))
-			continue;
-		filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
-		if (filtered_suite)
-			filtered[n++] = filtered_suite;
-	}
-	filtered[n] = NULL;
-
-	return filtered;
-}
-
+/* Stores a NULL-terminated array of suites. */
 struct suite_set {
-	struct kunit_suite * const * const *start;
-	struct kunit_suite * const * const *end;
+	struct kunit_suite * const *start;
+	struct kunit_suite * const *end;
 };
 
-static void kunit_free_subsuite(struct kunit_suite * const *subsuite)
-{
-	unsigned int i;
-
-	for (i = 0; subsuite[i]; i++)
-		kfree(subsuite[i]);
-
-	kfree(subsuite);
-}
-
 static void kunit_free_suite_set(struct suite_set suite_set)
 {
-	struct kunit_suite * const * const *suites;
+	struct kunit_suite * const *suites;
 
 	for (suites = suite_set.start; suites < suite_set.end; suites++)
-		kunit_free_subsuite(*suites);
+		kfree(*suites);
 	kfree(suite_set.start);
 }
 
@@ -149,10 +107,11 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 					    const char *filter_glob)
 {
 	int i;
-	struct kunit_suite * const **copy, * const *filtered_subsuite;
+	struct kunit_suite **copy, *filtered_suite;
 	struct suite_set filtered;
 	struct kunit_test_filter filter;
 
+	/* Note: this includes space for the terminating NULL. */
 	const size_t max = suite_set->end - suite_set->start;
 
 	copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
@@ -164,11 +123,17 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 
 	kunit_parse_filter_glob(&filter, filter_glob);
 
-	for (i = 0; i < max; ++i) {
-		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
-		if (filtered_subsuite)
-			*copy++ = filtered_subsuite;
+	for (i = 0; suite_set->start[i] != NULL; i++) {
+		if (!glob_match(filter.suite_glob, suite_set->start[i]->name))
+			continue;
+
+		filtered_suite = kunit_filter_tests(suite_set->start[i], filter.test_glob);
+		if (!filtered_suite)
+			continue;
+
+		*copy++ = filtered_suite;
 	}
+	*copy = NULL;
 	filtered.end = copy;
 
 	kfree(filter.suite_glob);
@@ -190,52 +155,56 @@ static void kunit_handle_shutdown(void)
 
 }
 
-static void kunit_print_tap_header(struct suite_set *suite_set)
-{
-	struct kunit_suite * const * const *suites, * const *subsuite;
-	int num_of_suites = 0;
-
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		for (subsuite = *suites; *subsuite != NULL; subsuite++)
-			num_of_suites++;
-
-	pr_info("TAP version 14\n");
-	pr_info("1..%d\n", num_of_suites);
-}
-
 static void kunit_exec_run_tests(struct suite_set *suite_set)
 {
-	struct kunit_suite * const * const *suites;
-
-	kunit_print_tap_header(suite_set);
+	pr_info("TAP version 14\n");
+	pr_info("1..%zu\n", suite_set->end - suite_set->start);
 
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		__kunit_test_suites_init(*suites);
+	__kunit_test_suites_init(suite_set->start);
 }
 
 static void kunit_exec_list_tests(struct suite_set *suite_set)
 {
-	unsigned int i;
-	struct kunit_suite * const * const *suites;
+	struct kunit_suite * const *suites;
 	struct kunit_case *test_case;
 
 	/* Hack: print a tap header so kunit.py can find the start of KUnit output. */
 	pr_info("TAP version 14\n");
 
 	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		for (i = 0; (*suites)[i] != NULL; i++) {
-			kunit_suite_for_each_test_case((*suites)[i], test_case) {
-				pr_info("%s.%s\n", (*suites)[i]->name, test_case->name);
-			}
+		kunit_suite_for_each_test_case((*suites), test_case) {
+			pr_info("%s.%s\n", (*suites)->name, test_case->name);
 		}
 }
 
+// TODO(dlatypov@google.com): delete this when we store suites in a single array.
+static struct suite_set make_suite_set(void)
+{
+	struct suite_set flattened;
+	size_t num_of_suites = 0;
+
+	struct kunit_suite * const * const *suites, * const *subsuite;
+	struct kunit_suite **end;
+
+	for (suites = __kunit_suites_start; suites < __kunit_suites_end; suites++)
+		for (subsuite = *suites; *subsuite != NULL; subsuite++)
+			num_of_suites++;
+
+	end = kcalloc(num_of_suites + 1, sizeof(*flattened.start), GFP_KERNEL);
+	flattened.start = end;
+
+	for (suites = __kunit_suites_start; suites < __kunit_suites_end; suites++)
+		for (subsuite = *suites; *subsuite != NULL; subsuite++)
+			*end++ = *subsuite;
+	*end = NULL;
+	flattened.end = end;
+	return flattened;
+}
+
 int kunit_run_all_tests(void)
 {
-	struct suite_set suite_set = {
-		.start = __kunit_suites_start,
-		.end = __kunit_suites_end,
-	};
+	struct suite_set suite_set = make_suite_set();
+	struct kunit_suite * const *unfiltered = suite_set.start; /* need to free at end */
 
 	if (filter_glob_param)
 		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
@@ -247,9 +216,10 @@ int kunit_run_all_tests(void)
 	else
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
-	if (filter_glob_param) { /* a copy was made of each array */
+	if (filter_glob_param) { /* a copy was made of each suite */
 		kunit_free_suite_set(suite_set);
 	}
+	kfree(unfiltered);
 
 	kunit_handle_shutdown();
 
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 7d2b8dc668b1..d9fce637eb56 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -9,8 +9,6 @@
 #include <kunit/test.h>
 
 static void kfree_at_end(struct kunit *test, const void *to_free);
-static void free_subsuite_at_end(struct kunit *test,
-				 struct kunit_suite *const *to_free);
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 					    const char *suite_name,
 					    struct kunit_case *test_cases);
@@ -41,124 +39,77 @@ static void parse_filter_test(struct kunit *test)
 	kfree(filter.test_glob);
 }
 
-static void filter_subsuite_test(struct kunit *test)
+static void filter_suites_test(struct kunit *test)
 {
 	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "suite2",
-		.test_glob = NULL,
-	};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2, NULL */
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
-	free_subsuite_at_end(test, filtered);
+	got = kunit_filter_suites(&suite_set, "suite2");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
-	KUNIT_EXPECT_FALSE(test, filtered[1]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
+	// DO NOT SUBMIT: null-terminated for now.
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
+	KUNIT_EXPECT_FALSE(test, *got.end);
 }
 
-static void filter_subsuite_test_glob_test(struct kunit *test)
+static void filter_suites_test_glob_test(struct kunit *test)
 {
 	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "suite2",
-		.test_glob = "test2",
-	};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
 	/* Want: suite1, suite2, NULL -> suite2 (just test1), NULL */
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered);
-	free_subsuite_at_end(test, filtered);
+	got = kunit_filter_suites(&suite_set, "suite2.test2");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
+	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->name, "suite2");
-	KUNIT_EXPECT_FALSE(test, filtered[1]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
+	// DO NOT SUBMIT: null-terminated for now.
+	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
+	KUNIT_EXPECT_FALSE(test, *got.end);
 
 	/* Now validate we just have test2 */
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered[0]->test_cases);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered[0]->test_cases[0].name, "test2");
-	KUNIT_EXPECT_FALSE(test, filtered[0]->test_cases[1].name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
+	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
+	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
 }
 
-static void filter_subsuite_to_empty_test(struct kunit *test)
+static void filter_suites_to_empty_test(struct kunit *test)
 {
 	struct kunit_suite *subsuite[3] = {NULL, NULL, NULL};
-	struct kunit_suite * const *filtered;
-	struct kunit_test_filter filter = {
-		.suite_glob = "not_found",
-		.test_glob = NULL,
-	};
+	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
+	struct suite_set got;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
 
-	filtered = kunit_filter_subsuite(subsuite, &filter);
-	free_subsuite_at_end(test, filtered); /* just in case */
-
-	KUNIT_EXPECT_FALSE_MSG(test, filtered,
-			       "should be NULL to indicate no match");
-}
-
-static void kfree_subsuites_at_end(struct kunit *test, struct suite_set *suite_set)
-{
-	struct kunit_suite * const * const *suites;
+	got = kunit_filter_suites(&suite_set, "not_found");
+	kfree_at_end(test, got.start); /* just in case */
 
-	kfree_at_end(test, suite_set->start);
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
-		free_subsuite_at_end(test, *suites);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
+				"should be empty to indicate no match");
 }
 
-static void filter_suites_test(struct kunit *test)
-{
-	/* Suites per-file are stored as a NULL terminated array */
-	struct kunit_suite *subsuites[2][2] = {
-		{NULL, NULL},
-		{NULL, NULL},
-	};
-	/* Match the memory layout of suite_set */
-	struct kunit_suite * const * const suites[2] = {
-		subsuites[0], subsuites[1],
-	};
-
-	const struct suite_set suite_set = {
-		.start = suites,
-		.end = suites + 2,
-	};
-	struct suite_set filtered = {.start = NULL, .end = NULL};
-
-	/* Emulate two files, each having one suite */
-	subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
-	subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
-
-	/* Filter out suite1 */
-	filtered = kunit_filter_suites(&suite_set, "suite0");
-	kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
-	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
-
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0]);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start[0][0]);
-	KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
-}
 
 static struct kunit_case executor_test_cases[] = {
 	KUNIT_CASE(parse_filter_test),
-	KUNIT_CASE(filter_subsuite_test),
-	KUNIT_CASE(filter_subsuite_test_glob_test),
-	KUNIT_CASE(filter_subsuite_to_empty_test),
 	KUNIT_CASE(filter_suites_test),
+	KUNIT_CASE(filter_suites_test_glob_test),
+	KUNIT_CASE(filter_suites_to_empty_test),
 	{}
 };
 
@@ -188,20 +139,6 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 				     (void *)to_free);
 }
 
-static void free_subsuite_res_free(struct kunit_resource *res)
-{
-	kunit_free_subsuite(res->data);
-}
-
-static void free_subsuite_at_end(struct kunit *test,
-				 struct kunit_suite *const *to_free)
-{
-	if (IS_ERR_OR_NULL(to_free))
-		return;
-	kunit_alloc_resource(test, NULL, free_subsuite_res_free,
-			     GFP_KERNEL, (void *)to_free);
-}
-
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 					    const char *suite_name,
 					    struct kunit_case *test_cases)

base-commit: e7198adb84dcad671ad4f0e90aaa7e9fabf258dc
-- 
2.33.0.882.g93a45727a2-goog

