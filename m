Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7977A0301
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjINLrs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbjINLro (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 07:47:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620071FE0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 04:47:40 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rmb8d2Tn1zVkf2;
        Thu, 14 Sep 2023 19:44:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 19:47:37 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <rmoar@google.com>, <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH 4/4] kunit: test: Fix the possible memory leak in executor_test
Date:   Thu, 14 Sep 2023 19:46:29 +0800
Message-ID: <20230914114629.1517650-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914114629.1517650-1-ruanjinjie@huawei.com>
References: <20230914114629.1517650-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If kunit_filter_suites() succeeds, not only copy but also filtered_suite
and filtered_suite->test_cases should be freed.

So use kunit_free_suite_set() to free the filtered_suite,
filtered_suite->test_cases and copy as kunit_module_exit() and
kunit_run_all_tests() do it.

Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/executor_test.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index b4f6f96b2844..987b81dce01e 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -56,7 +56,6 @@ static void filter_suites_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
@@ -64,6 +63,9 @@ static void filter_suites_test(struct kunit *test)
 
 	/* Contains one element (end is 1 past end) */
 	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
+
+	if (!err)
+		kunit_free_suite_set(got);
 }
 
 static void filter_suites_test_glob_test(struct kunit *test)
@@ -82,7 +84,6 @@ static void filter_suites_test_glob_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
 
 	/* Validate we just have suite2 */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
@@ -93,6 +94,9 @@ static void filter_suites_test_glob_test(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
 	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
 	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
+
+	if (!err)
+		kunit_free_suite_set(got);
 }
 
 static void filter_suites_to_empty_test(struct kunit *test)
@@ -109,10 +113,12 @@ static void filter_suites_to_empty_test(struct kunit *test)
 
 	got = kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start); /* just in case */
 
 	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
 				"should be empty to indicate no match");
+
+	if (!err)
+		kunit_free_suite_set(got);
 }
 
 static void parse_filter_attr_test(struct kunit *test)
@@ -172,7 +178,6 @@ static void filter_attr_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
 
 	/* Validate we just have normal_suite */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
@@ -183,6 +188,9 @@ static void filter_attr_test(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
 	KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "normal");
 	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
+
+	if (!err)
+		kunit_free_suite_set(got);
 }
 
 static void filter_attr_empty_test(struct kunit *test)
@@ -200,10 +208,12 @@ static void filter_attr_empty_test(struct kunit *test)
 
 	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start); /* just in case */
 
 	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
 				"should be empty to indicate no match");
+
+	if (!err)
+		kunit_free_suite_set(got);
 }
 
 static void filter_attr_skip_test(struct kunit *test)
@@ -222,7 +232,6 @@ static void filter_attr_skip_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
 
 	/* Validate we have both the slow and normal test */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
@@ -233,6 +242,9 @@ static void filter_attr_skip_test(struct kunit *test)
 	/* Now ensure slow is skipped and normal is not */
 	KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
 	KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
+
+	if (!err)
+		kunit_free_suite_set(got);
 }
 
 static struct kunit_case executor_test_cases[] = {
-- 
2.34.1

