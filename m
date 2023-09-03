Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C145E790B1C
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 09:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjICHLD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjICHLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 03:11:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D53A1A5
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 00:10:59 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RdjWx0g80zQjL8;
        Sun,  3 Sep 2023 15:07:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 3 Sep
 2023 15:10:57 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>
Subject: [PATCH v2 2/4] kunit: Fix the wrong err path and add goto labels in kunit_filter_suites()
Date:   Sun, 3 Sep 2023 15:10:26 +0800
Message-ID: <20230903071028.1518913-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903071028.1518913-1-ruanjinjie@huawei.com>
References: <20230903071028.1518913-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Take the last kfree(parsed_filters) and add it to be the first. Take
the first kfree(copy) and add it to be the last. The Best practice is to
return these errors reversely.

And as David suggested, add several labels which target only the things
which actually have been allocated so far.

Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_suites()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Suggested-by: David Gow <davidgow@google.com>
---
v2:
- Add err path labels.
- Update the commit message and title.
---
 lib/kunit/executor.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 5181aa2e760b..0eda42b0c9bb 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -166,7 +166,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 		for (j = 0; j < filter_count; j++)
 			parsed_filters[j] = kunit_next_attr_filter(&filters, err);
 		if (*err)
-			goto err;
+			goto free_parsed_filters;
 	}
 
 	for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
@@ -178,7 +178,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 					parsed_glob.test_glob);
 			if (IS_ERR(filtered_suite)) {
 				*err = PTR_ERR(filtered_suite);
-				goto err;
+				goto free_parsed_filters;
 			}
 		}
 		if (filter_count > 0 && parsed_filters != NULL) {
@@ -195,10 +195,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 				filtered_suite = new_filtered_suite;
 
 				if (*err)
-					goto err;
+					goto free_parsed_filters;
+
 				if (IS_ERR(filtered_suite)) {
 					*err = PTR_ERR(filtered_suite);
-					goto err;
+					goto free_parsed_filters;
 				}
 				if (!filtered_suite)
 					break;
@@ -213,17 +214,19 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 	filtered.start = copy_start;
 	filtered.end = copy;
 
-err:
-	if (*err)
-		kfree(copy);
+free_parsed_filters:
+	if (filter_count)
+		kfree(parsed_filters);
 
+free_parsed_glob:
 	if (filter_glob) {
 		kfree(parsed_glob.suite_glob);
 		kfree(parsed_glob.test_glob);
 	}
 
-	if (filter_count)
-		kfree(parsed_filters);
+free_copy:
+	if (*err)
+		kfree(copy);
 
 	return filtered;
 }
-- 
2.34.1

