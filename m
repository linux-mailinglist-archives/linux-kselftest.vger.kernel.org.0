Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D633523F61
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbiEKVRR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348188AbiEKVQi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 17:16:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FD2314D
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:16:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m136-20020a25268e000000b0064b233e03d1so2944719ybm.14
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RmwhTmtOKEfJCDjFlaEgB2jMmIYPJxSkJAhFJBeKz2I=;
        b=XkKSkM+v9S3PTc6l4ZTy49ewMfC2s4c5zMAg5UodUAo9tE3JjZGsHLiJZuutanSW/t
         0PB1vzo+tXSImfHZPiGGWNQoWj/OsCpusTgXi9w15rSHH3t3+S2DZesoDXU52lamaqTv
         6XL0EHRaDO6Ni1QV7CFRJ+DGgn9Mt2C7M4tGXW4u+r1NfQh+8CAeQMDlf18PXGERMkAG
         Ww/NLII6pTmYG3t6DW3HAaTr3EUgtVWawVHmCI8bfIFXwAU3LqjPLfhojmZ6OE6lLxLQ
         9telHSSUmU10mBg86HgEinjHRAqd7vyCOxBDQ7uitqe351eEz46zqPyUVZ3DnD+jBMu3
         hyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RmwhTmtOKEfJCDjFlaEgB2jMmIYPJxSkJAhFJBeKz2I=;
        b=gAz6Nf8sB5E9aQpz6elJ6EbDYLkormcz6jqDEtz4jn+b02qpFXR175IznM6TAiaSGF
         pkgPwq9aDFycF88qNkM8tPNlxF2lWC2UwYfodJ4TtXoGpjZPTr3wQkZbb9ZjS1GlGdbW
         Ar01ncWZfnzPSVoz1jDuFfqSsNTZhF0FlsjbQeYcuLPJBDkiLv3FhvpEMi6ysmiFIQxn
         /A0OIgN5ZFfn5iqR0Xx5fJ1+Ub5BoB8W8gpjqKRjF7iapBIdi9RJqQzkB064VLn8C+jv
         6IYl2z1XZ6q4nFej+8j+FXj1MmxKmQlJShOJII+9KenP8vJxpI6Z+C8zbVkVp9IgwYaW
         jZ1Q==
X-Gm-Message-State: AOAM531nywl+yusQzT2TsJGhYUsJ0i0fI5ofOskR91z2FlPG1Y/eQ0FB
        g8+ciEd4DahXwLI4i8uvRnJ7ei/0AdFW3w==
X-Google-Smtp-Source: ABdhPJxJscghYLknils0sPWTYiEWVf78KVRHjcnWmn2vXU7QMv4mIWF7u8hTkTvT9PIbzJ1Ow/LHJH9iF1/OvQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd59:7b9f:6863:5402])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:704:b0:649:cadc:bcf0 with SMTP
 id k4-20020a056902070400b00649cadcbcf0mr25704910ybt.537.1652303793100; Wed,
 11 May 2022 14:16:33 -0700 (PDT)
Date:   Wed, 11 May 2022 14:16:26 -0700
Message-Id: <20220511211626.3345036-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2] kunit: bail out of test filtering logic quicker if OOM
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Zeal Robot <zealci@zte.com.cn>, Lv Ruyi <lv.ruyi@zte.com.cn>
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

When filtering what tests to run (suites and/or cases) via
kunit.filter_glob (e.g. kunit.py run <glob>), we allocate copies of
suites.

These allocations can fail, and we largely don't handle that.
Note: realistically, this probably doesn't matter much.
We're not allocating much memory and this happens early in boot, so if
we can't do that, then there's likely far bigger problems.

This patch makes us immediately bail out from the top-level function
(kunit_filter_suites) with -ENOMEM if any of the underlying kmalloc()
calls return NULL.

Implementation note: we used to return NULL pointers from some functions
to indicate either that all suites/tests were filtered out or there was
an error allocating the new array.

We'll log a short error in this case and not run any tests or print a
TAP header. From a kunit.py user's perspective, they'll get a message
about missing/invalid TAP output and have to dig into the test.log to
see it. Since hitting this error seems so unlikely, it's probably fine
to not invent a way to plumb this error message more visibly.

See also: https://lore.kernel.org/linux-kselftest/20220329103919.2376818-1-lv.ruyi@zte.com.cn/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reported-by: Zeal Robot <zealci@zte.com.cn>
Reported-by: Lv Ruyi <lv.ruyi@zte.com.cn>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: no code changes.
Fix Reported-by tag, add Brendan's Reviewed-by.
---
 lib/kunit/executor.c      | 27 ++++++++++++++++++++++-----
 lib/kunit/executor_test.c |  4 +++-
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 22640c9ee819..2f73a6a35a7e 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -71,9 +71,13 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
 
 	/* Use memcpy to workaround copy->name being const. */
 	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
 	memcpy(copy, suite, sizeof(*copy));
 
 	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
+	if (!filtered)
+		return ERR_PTR(-ENOMEM);
 
 	n = 0;
 	kunit_suite_for_each_test_case(suite, test_case) {
@@ -106,14 +110,16 @@ kunit_filter_subsuite(struct kunit_suite * const * const subsuite,
 
 	filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
 	if (!filtered)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	n = 0;
 	for (i = 0; subsuite[i] != NULL; ++i) {
 		if (!glob_match(filter->suite_glob, subsuite[i]->name))
 			continue;
 		filtered_suite = kunit_filter_tests(subsuite[i], filter->test_glob);
-		if (filtered_suite)
+		if (IS_ERR(filtered_suite))
+			return ERR_CAST(filtered_suite);
+		else if (filtered_suite)
 			filtered[n++] = filtered_suite;
 	}
 	filtered[n] = NULL;
@@ -146,7 +152,8 @@ static void kunit_free_suite_set(struct suite_set suite_set)
 }
 
 static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
-					    const char *filter_glob)
+					    const char *filter_glob,
+					    int *err)
 {
 	int i;
 	struct kunit_suite * const **copy, * const *filtered_subsuite;
@@ -166,6 +173,10 @@ static struct suite_set kunit_filter_suites(const struct suite_set *suite_set,
 
 	for (i = 0; i < max; ++i) {
 		filtered_subsuite = kunit_filter_subsuite(suite_set->start[i], &filter);
+		if (IS_ERR(filtered_subsuite)) {
+			*err = PTR_ERR(filtered_subsuite);
+			return filtered;
+		}
 		if (filtered_subsuite)
 			*copy++ = filtered_subsuite;
 	}
@@ -236,9 +247,15 @@ int kunit_run_all_tests(void)
 		.start = __kunit_suites_start,
 		.end = __kunit_suites_end,
 	};
+	int err;
 
-	if (filter_glob_param)
-		suite_set = kunit_filter_suites(&suite_set, filter_glob_param);
+	if (filter_glob_param) {
+		suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
+		if (err) {
+			pr_err("kunit executor: error filtering suites: %d\n", err);
+			return err;
+		}
+	}
 
 	if (!action_param)
 		kunit_exec_run_tests(&suite_set);
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 4ed57fd94e42..eac6ff480273 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -137,14 +137,16 @@ static void filter_suites_test(struct kunit *test)
 		.end = suites + 2,
 	};
 	struct suite_set filtered = {.start = NULL, .end = NULL};
+	int err = 0;
 
 	/* Emulate two files, each having one suite */
 	subsuites[0][0] = alloc_fake_suite(test, "suite0", dummy_test_cases);
 	subsuites[1][0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
 
 	/* Filter out suite1 */
-	filtered = kunit_filter_suites(&suite_set, "suite0");
+	filtered = kunit_filter_suites(&suite_set, "suite0", &err);
 	kfree_subsuites_at_end(test, &filtered); /* let us use ASSERTs without leaking */
+	KUNIT_EXPECT_EQ(test, err, 0);
 	KUNIT_ASSERT_EQ(test, filtered.end - filtered.start, (ptrdiff_t)1);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filtered.start);

base-commit: 38289a26e1b8a37755f3e07056ca416c1ee2a2e8
-- 
2.36.0.512.ge40c2bad7a-goog

