Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C54F6E7A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 01:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiDFXYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Apr 2022 19:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiDFXYo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Apr 2022 19:24:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151846C1E7
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Apr 2022 16:22:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h16-20020a056902009000b00628a70584b2so2918434ybs.6
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Apr 2022 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Kctwd9MuAxKTamshBg/2p/OqY2uBL1ZDHhqIATAaLOY=;
        b=CdLhv1Eb6cbl0H+k0cOpjJRGzzxVgfYfMQ7obmTApAWuJuzGSvJnTjbu7I/yWRUhMK
         vcpoygMBuoDvkPsF9tjqRYtpERq0RxRiTvQJK/v8ljp3p+fwBePJGOpz7xYgnkQZUJdv
         3dQf7sGw7D7M8Dzd96+mvn6Vb0Ze/S+/0GJCLr8TlAD9Pke/9kCAWmnTV83vK/nb0ejZ
         yq6l5eAGi1vTNjMUxPMVaT2i/lqN/VlHhmL5k57A2J18yTsaMKzSX1kPN5xL6DuS8dW0
         IGYJvkBe9zv6xrK9Qipea2bZWrCepAb1JE4tqrRnsHgq0RiyWQ/k13v0C2FjT3lp44xG
         4lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Kctwd9MuAxKTamshBg/2p/OqY2uBL1ZDHhqIATAaLOY=;
        b=kWjYQ9BMsGGMkkKjBlRuoFr7pCXqiI2BTy5DQg8TGnxUkTwaG824wkK7zy1ZstIXie
         sGkBBoUUkOf4uFdl5Rsus3gpr9XyoRInu+4et5io/Vc9WLQnkeSSwqXMz4xOpjFoabwL
         MyzMbqTBxcb1CUhm3yqFSQvbnj4s8TZOhzPTJpKWd8HcWRek9IcRVLuPkNDTmvM1aOlg
         d/L07oVUlroo9z8dXrR77+2Y86z2A9G9c0PLUtQuXG1lQzCz0JmwF3Wwdytrr1LQu7JW
         BaGWeGqvIszj2cGkqoVfYMHr2jQUOh/IfQTwV1rn1uPpGHp/b/CGIFnUrvELDf+te97n
         akhw==
X-Gm-Message-State: AOAM532AcRQX0bHPPORnz8+R2e8rt1cskiB4u+zMtATKIo0oUIRUZOWi
        hxmaY8vL8IRVDW7MYasDO+cZ7j+2588USw==
X-Google-Smtp-Source: ABdhPJzx+g6rjmKR0nlzc2H/femSZMuJ5VGXLH99Gu7UbibLOjBReX3Q015ws38Ihs6d0NXJPaZDDQjA/GNNEQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:aed6:d51d:dc38:e705])
 (user=dlatypov job=sendgmr) by 2002:a25:dc93:0:b0:63e:14f0:fce5 with SMTP id
 y141-20020a25dc93000000b0063e14f0fce5mr8411650ybe.8.1649287365162; Wed, 06
 Apr 2022 16:22:45 -0700 (PDT)
Date:   Wed,  6 Apr 2022 16:22:40 -0700
Message-Id: <20220406232240.1825048-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] kunit: bail out of test filtering logic quicker if OOM
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Zeal Robot <zealci@zte.com.cn>, Lv Ruyi <lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
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

base-commit: b04d1a8dc7e7ff7ca91a20bef053bcc04265d83a
-- 
2.35.1.1094.g7c7d902a7c-goog

