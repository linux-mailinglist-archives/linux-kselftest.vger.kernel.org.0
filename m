Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81343B4250
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFYLSj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 07:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYLSj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 07:18:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D699C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 04:16:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f125-20020a2538830000b02905572a385ae5so3714998yba.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NaD3eWAKNT95Z3ftTE0FSmd29ZM9wJJVehskxEyh6Bs=;
        b=rh2DRYsOnyU4K66JbmFmfersLcB3CH5kFw/V2x3WyHocDAqN9QlOQ+pBemdFkzs10t
         qdPiIlTUZonkVe0TkjkwRjG5D5gxFtAyQ3Q7Dwdyt+yM5mxIDkXbJnAkP9APJBFks+Bn
         vKF5AafrGLNRLVOXWAaBYV759rEd5ggvrBzDlMkRsQaCnhE0PFTsjiKSCA9XeNYT679A
         xCbdE3anO8qW+tKtFNG3iVJic/mRHbZwlRCqPyQbWCbgy3l8I7xokOs0ZnTn01dqvMEC
         T3Zdp7NQoZ6PmEtdq2CWHkJre+Cx9eAYQokbMycsNZQpDKWoQY/3RASP3huSYX25V5cY
         hMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NaD3eWAKNT95Z3ftTE0FSmd29ZM9wJJVehskxEyh6Bs=;
        b=C0SH/rNLWOwTesxPseqWh/ZSDxyP8/adNEDxW2+ykDdgn5DpIBxKcVBwrmc4WbbxzC
         sgz7OM3PFAEHvsL0mUy3uphsG9pfk6uC8Ikx+/Lfr6Jbduq+C8MSZ87cE7t/06Vg6ukW
         b2T5ofpdBEOsht5UNvhvqlkvVHSksUIRYXWAAb7mQfzCyVV7/yg6Jcgc6PkJKVFjzr6a
         bBkPn1pqZYH8tvKWFVhR+G+R/qNsSR22SyM4O/HNfLeezpE6Z4NwM8GGPDqOOD9WA+i1
         PvVPkVT2NlmUpbTIDN1OtonhQ/zUcDDIeOB5zUXGZTE08FCmgsSLVmuVh+elXy3bFZni
         DKUw==
X-Gm-Message-State: AOAM531BKkcEkOOwIMr22xBQogiLMTLsRA0T4uvvJblc2D8PyJFlia5K
        YHzAmvMVcOLydrc2kiSdcga/tXCWx6naXg==
X-Google-Smtp-Source: ABdhPJyU4em87MWziADvMkZfNrxMozNiRF7+SKP/C5pjjZZarOlkRu1c18768x/NpxmRf0Wof/4UkIb9ZdbQDw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:2dbe:56d6:eac0:60b0])
 (user=davidgow job=sendgmr) by 2002:a25:1885:: with SMTP id
 127mr11480239yby.199.1624619776669; Fri, 25 Jun 2021 04:16:16 -0700 (PDT)
Date:   Fri, 25 Jun 2021 04:16:03 -0700
Message-Id: <20210625111603.358518-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] kunit: Fix merge issue in suite filtering test
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There were a couple of errors introuced when
"kunit: add unit test for filtering suites by names"[1] was merged in
c9d80ffc5a.

An erroneous '+' was introduced in executor.c, and the executor_test.c
file went missing. This causes the kernel to fail to compile if
CONFIG_KUNIT is enabled, as reported in [2,3].

As with the original, I've tested by running just the new tests using
itself:
$ ./tools/testing/kunit/kunit.py run '*exec*'

[1]: https://lore.kernel.org/linux-kselftest/20210421020427.2384721-1-dlatypov@google.com/
[2]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/6IKQX5JXZF7I3NFH4IAWUMHXEQSCPNDP/
[3]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/EKY7ZH5YDCCTSJF2G7XFPMGIXQSUVD3Y/

Fixes: c9d80ffc5a ("kunit: add unit test for filtering suites by names")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Gow <davidgow@google.com>
---

This is another fix for the kunit-fixes branch, where there seems to
have been an issue merging the "kunit: add unit test for filtering
suites by names" patch here:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=c9d80ffc5a0a30955de0b8c5c46a05906d417800

Again, feel free to squash this into the original patch if that works
better.

Cheers,
-- David

 lib/kunit/executor.c      |   2 +-
 lib/kunit/executor_test.c | 133 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 lib/kunit/executor_test.c

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 672f91486d23..acd1de436f59 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -23,7 +23,7 @@ static char *kunit_shutdown;
 core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
 
 static struct kunit_suite * const *
-+kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
+kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
 			const char *filter_glob)
 {
 	int i, n = 0;
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
-- 
2.32.0.93.g670b81a890-goog

