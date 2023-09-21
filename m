Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AEB7A9093
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIUBlR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjIUBlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 21:41:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6393E5
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 18:41:10 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RrdNN4sD9zrSsn;
        Thu, 21 Sep 2023 09:39:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 21 Sep
 2023 09:41:07 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <rmoar@google.com>, <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2 1/4] kunit: Fix missed memory release in kunit_free_suite_set()
Date:   Thu, 21 Sep 2023 09:40:05 +0800
Message-ID: <20230921014008.3887257-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921014008.3887257-1-ruanjinjie@huawei.com>
References: <20230921014008.3887257-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

modprobe cpumask_kunit and rmmod cpumask_kunit, kmemleak detect
a suspected memory leak as below.

If kunit_filter_suites() in kunit_module_init() succeeds, the
suite_set.start will not be NULL and the kunit_free_suite_set() in
kunit_module_exit() should free all the memory which has not
been freed. However the test_cases in suites is left out.

unreferenced object 0xffff54ac47e83200 (size 512):
  comm "modprobe", pid 592, jiffies 4294913238 (age 1367.612s)
  hex dump (first 32 bytes):
    84 13 1a f0 d3 b6 ff ff 30 68 1a f0 d3 b6 ff ff  ........0h......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008dec63a2>] slab_post_alloc_hook+0xb8/0x368
    [<00000000ec280d8e>] __kmem_cache_alloc_node+0x174/0x290
    [<00000000896c7740>] __kmalloc+0x60/0x2c0
    [<000000007a50fa06>] kunit_filter_suites+0x254/0x5b8
    [<0000000078cc98e2>] kunit_module_notify+0xf4/0x240
    [<0000000033cea952>] notifier_call_chain+0x98/0x17c
    [<00000000973d05cc>] notifier_call_chain_robust+0x4c/0xa4
    [<000000005f95895f>] blocking_notifier_call_chain_robust+0x4c/0x74
    [<0000000048e36fa7>] load_module+0x1a2c/0x1c40
    [<0000000004eb8a91>] init_module_from_file+0x94/0xcc
    [<0000000037dbba28>] idempotent_init_module+0x184/0x278
    [<00000000161b75cb>] __arm64_sys_finit_module+0x68/0xa8
    [<000000006dc1669b>] invoke_syscall+0x44/0x100
    [<00000000fa87e304>] el0_svc_common.constprop.1+0x68/0xe0
    [<000000009d8ad866>] do_el0_svc+0x1c/0x28
    [<000000005b83c607>] el0_svc+0x3c/0xc4

Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
Fixes: b67abaad4d25 ("kunit: Allow kunit test modules to use test filtering")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Rae Moar <rmoar@google.com>
---
v2:
- Add Reviewed-by.
---
 lib/kunit/executor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index a6348489d45f..a037a46fae5e 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -137,8 +137,10 @@ void kunit_free_suite_set(struct kunit_suite_set suite_set)
 {
 	struct kunit_suite * const *suites;
 
-	for (suites = suite_set.start; suites < suite_set.end; suites++)
+	for (suites = suite_set.start; suites < suite_set.end; suites++) {
+		kfree((*suites)->test_cases);
 		kfree(*suites);
+	}
 	kfree(suite_set.start);
 }
 
-- 
2.34.1

