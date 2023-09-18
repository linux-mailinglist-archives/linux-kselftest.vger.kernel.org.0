Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A27A4952
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbjIRML0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 08:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbjIRMLS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 08:11:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA8CC8;
        Mon, 18 Sep 2023 05:10:30 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rq3RV4p9WztSbb;
        Mon, 18 Sep 2023 20:06:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 20:10:26 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <sj@kernel.org>, <akpm@linux-foundation.org>,
        <brendan.higgins@linux.dev>, <feng.tang@intel.com>,
        <damon@lists.linux.dev>, <linux-mm@kvack.org>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v3 1/2] mm/damon/core-test: Fix memory leak in damon_new_region()
Date:   Mon, 18 Sep 2023 20:09:50 +0800
Message-ID: <20230918120951.2230468-2-ruanjinjie@huawei.com>
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

The damon_region which is allocated by kmem_cache_alloc() in
damon_new_region() in damon_test_regions() and
damon_test_update_monitoring_result() are not freed.

So for damon_test_regions(), replace damon_del_region() call with
damon_destroy_region() so that it calls both damon_del_region() and
damon_free_region(), the latter will free the damon_region. For
damon_test_update_monitoring_result(), call damon_free_region() to
free it. After applying this patch, the following memory leak is never
detected.

    unreferenced object 0xffff2b49c3edc000 (size 56):
      comm "kunit_try_catch", pid 338, jiffies 4294895280 (age 557.084s)
      hex dump (first 32 bytes):
        01 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 49 2b ff ff  ............I+..
      backtrace:
        [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
        [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
        [<000000008603f022>] damon_new_region+0x28/0x54
        [<00000000a3b8c64e>] damon_test_regions+0x38/0x270
        [<00000000559c4801>] kunit_try_run_case+0x50/0xac
        [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
        [<000000003c3e9211>] kthread+0x124/0x130
        [<0000000028f85bdd>] ret_from_fork+0x10/0x20
    unreferenced object 0xffff2b49c5b20000 (size 56):
      comm "kunit_try_catch", pid 354, jiffies 4294895304 (age 556.988s)
      hex dump (first 32 bytes):
        03 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 96 00 00 00 49 2b ff ff  ............I+..
      backtrace:
        [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
        [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
        [<000000008603f022>] damon_new_region+0x28/0x54
        [<00000000ca019f80>] damon_test_update_monitoring_result+0x18/0x34
        [<00000000559c4801>] kunit_try_run_case+0x50/0xac
        [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
        [<000000003c3e9211>] kthread+0x124/0x130
        [<0000000028f85bdd>] ret_from_fork+0x10/0x20

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
v3:
- Update the commit message to be more accurate.
- Add Reviewed-by.
v2:
- Replace the damon_del_region() with damon_destroy_region() rather than
  calling damon_free_region().
- Update the commit message.
---
 mm/damon/core-test.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..28d24e698318 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -30,7 +30,7 @@ static void damon_test_regions(struct kunit *test)
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test, 1u, damon_nr_regions(t));
 
-	damon_del_region(r, t);
+	damon_destroy_region(r, t);
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_free_target(t);
@@ -316,6 +316,8 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 20);
+
+	damon_free_region(r);
 }
 
 static void damon_test_set_attrs(struct kunit *test)
-- 
2.34.1

