Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E983578E715
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjHaHRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 03:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjHaHRT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 03:17:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A621B2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 00:17:16 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rbspd2G2KzLpJX;
        Thu, 31 Aug 2023 15:14:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 15:17:14 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <jk@codeconstruct.com.au>,
        <dlatypov@google.com>, <rmoar@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH 4/4] kunit: Fix the wrong error path in kunit_filter_suites()
Date:   Thu, 31 Aug 2023 15:16:55 +0800
Message-ID: <20230831071655.2907683-5-ruanjinjie@huawei.com>
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

Take the last kfree(parsed_filters) and add it to be the first. Take
the first kfree(copy) and add it to be the last. The Best practice is to
return these errors reversely.

Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_suites()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/executor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 7654c09c1ab1..da9444d22711 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -229,16 +229,16 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 	filtered.end = copy;
 
 err:
-	if (*err)
-		kfree(copy);
+	if (filter_count)
+		kfree(parsed_filters);
 
 	if (filter_glob) {
 		kfree(parsed_glob.suite_glob);
 		kfree(parsed_glob.test_glob);
 	}
 
-	if (filter_count)
-		kfree(parsed_filters);
+	if (*err)
+		kfree(copy);
 
 	return filtered;
 }
-- 
2.34.1

