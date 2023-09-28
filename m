Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D967B16F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjI1JPk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjI1JPj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:15:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42BE18F
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 02:15:37 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rx75Y4LDdzNmly;
        Thu, 28 Sep 2023 17:11:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 17:15:35 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <rmoar@google.com>,
        <marpagan@redhat.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH RESEND 2/3] kunit: Return error from kunit_module_init()
Date:   Thu, 28 Sep 2023 17:14:45 +0800
Message-ID: <20230928091446.1209703-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928091446.1209703-1-ruanjinjie@huawei.com>
References: <20230928091446.1209703-1-ruanjinjie@huawei.com>
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

When the module' state is MODULE_STATE_COMING, the return err code from
kunit_module_init() can be used to return. So when kunit_module_init()
fails, it will not be notified to go to kunit_module_exit() and the empty
checking can be removed. Because if kunit_filter_suites() succeeds, it
will notify the module state to MODULE_STATE_GOING otherwise it will not
and the test suites will be freed in kunit_filter_suites(). The best
practice is return the err code from MODULE_STATE_COMING func.

And if kunit_filter_suites() fails, both suite_set.start and suite_set.end
will be NULL, and the code behind it is dead code. so return err if
it fails.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 29a5f5ea8112..145f70219f46 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -734,7 +734,7 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
 #ifdef CONFIG_MODULES
-static void kunit_module_init(struct module *mod)
+static int kunit_module_init(struct module *mod)
 {
 	struct kunit_suite_set suite_set = {
 		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
@@ -760,6 +760,8 @@ static void kunit_module_init(struct module *mod)
 		kunit_exec_list_tests(&suite_set, true);
 	else
 		pr_err("kunit: unknown action '%s'\n", action);
+
+	return err;
 }
 
 static void kunit_module_exit(struct module *mod)
@@ -773,18 +775,18 @@ static void kunit_module_exit(struct module *mod)
 		__kunit_test_suites_exit(mod->kunit_suites,
 					 mod->num_kunit_suites);
 
-	if (suite_set.start)
-		kunit_free_suite_set(suite_set);
+	kunit_free_suite_set(suite_set);
 }
 
 static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 			       void *data)
 {
 	struct module *mod = data;
+	int ret = 0;
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		kunit_module_init(mod);
+		ret = kunit_module_init(mod);
 		break;
 	case MODULE_STATE_LIVE:
 		break;
@@ -795,7 +797,7 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 		break;
 	}
 
-	return 0;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block kunit_mod_nb = {
-- 
2.34.1

