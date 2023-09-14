Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471D67A0302
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbjINLrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbjINLrl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 07:47:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C91FE9
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 04:47:34 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rmb9V5jgbz1N808;
        Thu, 14 Sep 2023 19:45:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 19:47:32 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <rmoar@google.com>, <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH 3/4] kunit: Fix possible memory leak in kunit_filter_suites()
Date:   Thu, 14 Sep 2023 19:46:28 +0800
Message-ID: <20230914114629.1517650-4-ruanjinjie@huawei.com>
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

If the outer layer for loop is iterated more than once and it fails not
in the first iteration, the filtered_suite and filtered_suite->test_cases
allocated in the last kunit_filter_attr_tests() in last inner for loop
is leaked.

So add a new free_filtered_suite err label and free the filtered_suite
and filtered_suite->test_cases so far. And change kmalloc_array of copy
to kcalloc to Clear the copy to make the kfree safe.

Fixes: 5d31f71efcb6 ("kunit: add kunit.filter_glob cmdline option to filter suites")
Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/executor.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 9358ed2df839..1236b3cd2fbb 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -157,10 +157,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 	struct kunit_suite_set filtered = {NULL, NULL};
 	struct kunit_glob_filter parsed_glob;
 	struct kunit_attr_filter *parsed_filters = NULL;
+	struct kunit_suite * const *suites;
 
 	const size_t max = suite_set->end - suite_set->start;
 
-	copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
+	copy = kcalloc(max, sizeof(*filtered.start), GFP_KERNEL);
 	if (!copy) { /* won't be able to run anything, return an empty set */
 		return filtered;
 	}
@@ -195,7 +196,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 					parsed_glob.test_glob);
 			if (IS_ERR(filtered_suite)) {
 				*err = PTR_ERR(filtered_suite);
-				goto free_parsed_filters;
+				goto free_filtered_suite;
 			}
 		}
 		if (filter_count > 0 && parsed_filters != NULL) {
@@ -212,11 +213,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 				filtered_suite = new_filtered_suite;
 
 				if (*err)
-					goto free_parsed_filters;
+					goto free_filtered_suite;
 
 				if (IS_ERR(filtered_suite)) {
 					*err = PTR_ERR(filtered_suite);
-					goto free_parsed_filters;
+					goto free_filtered_suite;
 				}
 				if (!filtered_suite)
 					break;
@@ -231,6 +232,14 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 	filtered.start = copy_start;
 	filtered.end = copy;
 
+free_filtered_suite:
+	if (*err) {
+		for (suites = copy_start; suites < copy; suites++) {
+			kfree((*suites)->test_cases);
+			kfree(*suites);
+		}
+	}
+
 free_parsed_filters:
 	if (filter_count)
 		kfree(parsed_filters);
-- 
2.34.1

