Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326B17A4956
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbjIRML5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 08:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbjIRMLZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 08:11:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542AC9;
        Mon, 18 Sep 2023 05:10:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rq3T12BGVzVkwV;
        Mon, 18 Sep 2023 20:07:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 20:10:27 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <sj@kernel.org>, <akpm@linux-foundation.org>,
        <brendan.higgins@linux.dev>, <feng.tang@intel.com>,
        <damon@lists.linux.dev>, <linux-mm@kvack.org>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v3 2/2] mm/damon/core-test: Fix memory leak in damon_new_ctx()
Date:   Mon, 18 Sep 2023 20:09:51 +0800
Message-ID: <20230918120951.2230468-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918120951.2230468-1-ruanjinjie@huawei.com>
References: <20230918120951.2230468-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

When CONFIG_DAMON_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.

The damon_ctx which is allocated by kzalloc() in damon_new_ctx() in
damon_test_ops_registration() and damon_test_set_attrs() are not freed.
So use damon_destroy_ctx() to free it. After applying this patch, the
following memory leak is never detected

    unreferenced object 0xffff2b49c6968800 (size 512):
      comm "kunit_try_catch", pid 350, jiffies 4294895294 (age 557.028s)
      hex dump (first 32 bytes):
        88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
        00 87 93 03 00 00 00 00 0a 00 00 00 00 00 00 00  ................
      backtrace:
        [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
        [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
        [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
        [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
        [<00000000daf6227b>] damon_test_ops_registration+0x34/0x328
        [<00000000559c4801>] kunit_try_run_case+0x50/0xac
        [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
        [<000000003c3e9211>] kthread+0x124/0x130
        [<0000000028f85bdd>] ret_from_fork+0x10/0x20
    unreferenced object 0xffff2b49c1a9cc00 (size 512):
      comm "kunit_try_catch", pid 356, jiffies 4294895306 (age 557.000s)
      hex dump (first 32 bytes):
        88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00  ................
      backtrace:
        [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
        [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
        [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
        [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
        [<00000000058495c4>] damon_test_set_attrs+0x30/0x1a8
        [<00000000559c4801>] kunit_try_run_case+0x50/0xac
        [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
        [<000000003c3e9211>] kthread+0x124/0x130
        [<0000000028f85bdd>] ret_from_fork+0x10/0x20

Fixes: d1836a3b2a9a ("mm/damon/core-test: initialise context before test in damon_test_set_attrs()")
Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
v3:
- Add a new Reviewed-by.
v2:
- Add Reviewed-by.
- Rebased on mm-unstable.
- Update the commit message.
---
 mm/damon/core-test.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 28d24e698318..b2a388ee062d 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -265,6 +265,8 @@ static void damon_test_ops_registration(struct kunit *test)
 
 	/* Check double-registration failure again */
 	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
+
+	damon_destroy_ctx(c);
 }
 
 static void damon_test_set_regions(struct kunit *test)
@@ -341,6 +343,8 @@ static void damon_test_set_attrs(struct kunit *test)
 	invalid_attrs = valid_attrs;
 	invalid_attrs.aggr_interval = 4999;
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
+
+	damon_destroy_ctx(c);
 }
 
 static void damos_test_new_filter(struct kunit *test)
-- 
2.34.1

