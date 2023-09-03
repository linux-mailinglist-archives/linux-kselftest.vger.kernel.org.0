Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A542E790B1E
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjICHLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjICHLK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 03:11:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C361A5
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 00:11:07 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RdjYr6y4pzrS8q;
        Sun,  3 Sep 2023 15:09:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 3 Sep
 2023 15:11:04 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2 4/4] kunit: Fix possible memory leak in kunit_filter_suites()
Date:   Sun, 3 Sep 2023 15:10:28 +0800
Message-ID: <20230903071028.1518913-5-ruanjinjie@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If both filter_glob and filters are not NULL, and kunit_parse_glob_filter()
succeed, but kcalloc parsed_filters fails, the suite_glob and test_glob of
parsed kzalloc in kunit_parse_glob_filter() will be leaked.

As Rae suggested, assign -ENOMEM to *err to correctly free copy and goto
free_parsed_glob to free the suite/test_glob of parsed.

Fixes: 1c9fd080dffe ("kunit: fix uninitialized variables bug in attributes filtering")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Rae Moar <rmoar@google.com>
---
v2:
- Add *err = -ENOMEM before goto to correctly free copy.
- Goto the new add identical purpose free_parsed_glob label.
- Update the commit message.
---
 lib/kunit/executor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 28f144de748b..a6348489d45f 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -175,8 +175,8 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 		filter_count = kunit_get_filter_count(filters);
 		parsed_filters = kcalloc(filter_count, sizeof(*parsed_filters), GFP_KERNEL);
 		if (!parsed_filters) {
-			kfree(copy);
-			return filtered;
+			*err = -ENOMEM;
+			goto free_parsed_glob;
 		}
 		for (j = 0; j < filter_count; j++)
 			parsed_filters[j] = kunit_next_attr_filter(&filters, err);
-- 
2.34.1

