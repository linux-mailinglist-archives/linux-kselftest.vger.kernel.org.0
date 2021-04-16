Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B00362AD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Apr 2021 00:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhDPWKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Apr 2021 18:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbhDPWKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Apr 2021 18:10:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3154C061756
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 15:10:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n13-20020ac86f4d0000b02901b35920b3cbso6881371qtv.23
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qNkOejDnfXHGscacqH62figfo+8IhNisX4n6Qdvr/o4=;
        b=YqtYAXvIcArBGSwz/ErHlrxh8U0ktGkLAZRVkNRF8fQxhfKbafNQ6gQ0f/qVcVmEcc
         8LLUwGvnjy9aOa/X7YJiel1qESBGNdgSBiXP8TtCPV3L7iqYel1hfaq7oGqjaCuscons
         Lk/LgPSx+oQMnuYrdQwHfKNHiHzsGNmswNn5XMJks/nHUT9rKcTzoH73krC3jZbuT9P/
         XIAXLBmN14lDW1fX6zqxq5p/1VL3i6dXoNRtH60YNQlpejkW1DWaMGjkyCn1Vs1ewzNI
         OjMoiPE11EoNxeUJaJ3+9XyB3UuGv2RJQ0JLddkBbT+tPtspncg+7uzhizNDCGRzWg2l
         FYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qNkOejDnfXHGscacqH62figfo+8IhNisX4n6Qdvr/o4=;
        b=gn8/E5vbUFahbNV0f/y9vSbNxi5YrBFoYC3Ew41IlDxs/IWRYXh+FhSvFgcyyfODNy
         FsKoCrNm0gSLNPyAibXqR4kOkFDIhc8bRejZQoQ8hW6SJHzbjBv2ryyAQuMc1wzZVBwS
         9l4+U8lKj1A4gt9DWvxpKYenyn45gi2zEcl7Af4qQez8K91yDpZg+14tDi18LizVZgtz
         /67d7ug4uKrfCGhaBtvLzMar2W9gzJNzt/Fz1mbHv2Y31yz8dJ/qZnX4S5G+duDbg1w+
         7Ncuiubhda4lWitimis8zYLFJkZqGueXXr/KAjFfKSGGCPNUzHOns2nuSNkEcr1RaZLD
         iXqQ==
X-Gm-Message-State: AOAM530yiaJfNagku5hI+sFvmgcaPNq6FIqQUXTIohsGnGeWOMV/IGYC
        V61/U2oUm6Ft5bjtn3rgx9oCYcy7mlvSNQ==
X-Google-Smtp-Source: ABdhPJyE2ESP+SIKPjKZ6RYDvfQqqeZE5WKd+Wjcwact46ZiqY320X4Wro8LTQ5l6TQWZUq/Lau0ukkFyZwyLw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:29a1:5b57:c414:df21])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:4b0:: with SMTP id
 w16mr10364598qvz.54.1618611017946; Fri, 16 Apr 2021 15:10:17 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:09:55 -0700
Message-Id: <20210416220955.1577372-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2] kunit: add unit test for filtering suites by names
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
v1 -> v2:
* Fix missing free in kfree_subsuites_at_end()
---
 lib/kunit/executor.c      |  26 ++++----
 lib/kunit/executor_test.c | 133 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 11 deletions(-)
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

base-commit: 151501160401e2dc669ea7dac2c599b53f220c33
-- 
2.31.1.368.gbe11c130af-goog

