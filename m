Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F54D2A7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiCIIUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 03:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiCIIUm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 03:20:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C396F1197;
        Wed,  9 Mar 2022 00:19:39 -0800 (PST)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KD4nL3RngzBrhW;
        Wed,  9 Mar 2022 16:17:42 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:19:37 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:19:36 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <brendanhiggins@google.com>, <glider@google.com>,
        <elver@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>
CC:     <wangkefeng.wang@huawei.com>, <liupeng256@huawei.com>
Subject: [PATCH v2 1/3] kunit: fix UAF when run kfence test case test_gfpzero
Date:   Wed, 9 Mar 2022 08:37:51 +0000
Message-ID: <20220309083753.1561921-2-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220309083753.1561921-1-liupeng256@huawei.com>
References: <20220309083753.1561921-1-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kunit will create a new thread to run an actual test case, and the
main process will wait for the completion of the actual test thread
until overtime. The variable "struct kunit test" has local property
in function kunit_try_catch_run, and will be used in the test case
thread. Task kunit_try_catch_run will free "struct kunit test" when
kunit runs overtime, but the actual test case is still run and an
UAF bug will be triggered.

The above problem has been both observed in a physical machine and
qemu platform when running kfence kunit tests. The problem can be
triggered when setting CONFIG_KFENCE_NUM_OBJECTS = 65535. Under
this setting, the test case test_gfpzero will cost hours and kunit
will run to overtime. The follows show the panic log.

  BUG: unable to handle page fault for address: ffffffff82d882e9

  Call Trace:
   kunit_log_append+0x58/0xd0
   ...
   test_alloc.constprop.0.cold+0x6b/0x8a [kfence_test]
   test_gfpzero.cold+0x61/0x8ab [kfence_test]
   kunit_try_run_case+0x4c/0x70
   kunit_generic_run_threadfn_adapter+0x11/0x20
   kthread+0x166/0x190
   ret_from_fork+0x22/0x30
  Kernel panic - not syncing: Fatal exception
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
  Ubuntu-1.8.2-1ubuntu1 04/01/2014

To solve this problem, the test case thread should be stopped when
the kunit frame runs overtime. The stop signal will send in function
kunit_try_catch_run, and test_gfpzero will handle it.

Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
 lib/kunit/try-catch.c   | 1 +
 mm/kfence/kfence_test.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index be38a2c5ecc2..6b3d4db94077 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -78,6 +78,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	if (time_remaining == 0) {
 		kunit_err(test, "try timed out\n");
 		try_catch->try_result = -ETIMEDOUT;
+		kthread_stop(task_struct);
 	}
 
 	exit_code = try_catch->try_result;
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 50dbb815a2a8..caed6b4eba94 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -623,7 +623,7 @@ static void test_gfpzero(struct kunit *test)
 			break;
 		test_free(buf2);
 
-		if (i == CONFIG_KFENCE_NUM_OBJECTS) {
+		if (kthread_should_stop() || (i == CONFIG_KFENCE_NUM_OBJECTS)) {
 			kunit_warn(test, "giving up ... cannot get same object back\n");
 			return;
 		}
-- 
2.18.0.huawei.25

