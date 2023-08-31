Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA178E714
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbjHaHRT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 03:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHaHRS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 03:17:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2C1A3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 00:17:15 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RbsrP5Qcxz1L9Nf;
        Thu, 31 Aug 2023 15:15:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 15:17:12 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH 3/4] kunit: Fix possible memory leak in kunit_filter_suites()
Date:   Thu, 31 Aug 2023 15:16:54 +0800
Message-ID: <20230831071655.2907683-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831071655.2907683-1-ruanjinjie@huawei.com>
References: <20230831071655.2907683-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If both filter_glob and filters are not NULL, and kunit_parse_glob_filter()
succeed, but kcalloc parsed_filters fails, the suite_glob and test_glob of
parsed kzalloc in kunit_parse_glob_filter() will be leaked.

Fixes: 1c9fd080dffe ("kunit: fix uninitialized variables bug in attributes filtering")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/executor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 25ce8d6e5fe7..7654c09c1ab1 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -176,10 +176,8 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 	if (filters) {
 		filter_count = kunit_get_filter_count(filters);
 		parsed_filters = kcalloc(filter_count, sizeof(*parsed_filters), GFP_KERNEL);
-		if (!parsed_filters) {
-			kfree(copy);
-			return filtered;
-		}
+		if (!parsed_filters)
+			goto err;
 		for (j = 0; j < filter_count; j++)
 			parsed_filters[j] = kunit_next_attr_filter(&filters, err);
 		if (*err)
-- 
2.34.1

