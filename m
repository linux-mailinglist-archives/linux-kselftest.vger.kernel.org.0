Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EBE7AA9CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjIVHLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjIVHLL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 03:11:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15CEC2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:11:04 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RsNdZ0NckzVl9P;
        Fri, 22 Sep 2023 15:08:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 22 Sep
 2023 15:11:02 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <rmoar@google.com>, <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v3 4/4] kunit: test: Fix the possible memory leak in executor_test
Date:   Fri, 22 Sep 2023 15:10:20 +0800
Message-ID: <20230922071020.2554677-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922071020.2554677-1-ruanjinjie@huawei.com>
References: <20230922071020.2554677-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

When CONFIG_KUNIT_ALL_TESTS=y, making CONFIG_DEBUG_KMEMLEAK=y and
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.

If kunit_filter_suites() succeeds, not only copy but also filtered_suite
and filtered_suite->test_cases should be freed.

So as Rae suggested, to avoid the suite set never be freed when
KUNIT_ASSERT_EQ() fails and exits after kunit_filter_suites() succeeds,
update kfree_at_end() func to free_suite_set_at_end() to use
kunit_free_suite_set() to free them as kunit_module_exit() and
kunit_run_all_tests() do it. As the second arg got of
free_suite_set_at_end() is a local variable, copy it for free to avoid
wild-memory-access. After applying this patch, the following memory leak
is never detected.

unreferenced object 0xffff8881001de400 (size 1024):
  comm "kunit_try_catch", pid 1396, jiffies 4294720452 (age 932.801s)
  hex dump (first 32 bytes):
    73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
    [<ffffffff817bd242>] kmemdup+0x22/0x50
    [<ffffffff829e961d>] kunit_filter_suites+0x44d/0xcc0
    [<ffffffff829eb69f>] filter_suites_test+0x12f/0x360
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff8881052cd388 (size 192):
  comm "kunit_try_catch", pid 1396, jiffies 4294720452 (age 932.801s)
  hex dump (first 32 bytes):
    a0 85 9e 82 ff ff ff ff 80 cd 7c 84 ff ff ff ff  ..........|.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817dbad2>] __kmalloc+0x52/0x150
    [<ffffffff829e9651>] kunit_filter_suites+0x481/0xcc0
    [<ffffffff829eb69f>] filter_suites_test+0x12f/0x360
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20

unreferenced object 0xffff888100da8400 (size 1024):
  comm "kunit_try_catch", pid 1398, jiffies 4294720454 (age 781.945s)
  hex dump (first 32 bytes):
    73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
    [<ffffffff817bd242>] kmemdup+0x22/0x50
    [<ffffffff829e961d>] kunit_filter_suites+0x44d/0xcc0
    [<ffffffff829eb13f>] filter_suites_test_glob_test+0x12f/0x560
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888105117878 (size 96):
  comm "kunit_try_catch", pid 1398, jiffies 4294720454 (age 781.945s)
  hex dump (first 32 bytes):
    a0 85 9e 82 ff ff ff ff a0 ac 7c 84 ff ff ff ff  ..........|.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817dbad2>] __kmalloc+0x52/0x150
    [<ffffffff829e9651>] kunit_filter_suites+0x481/0xcc0
    [<ffffffff829eb13f>] filter_suites_test_glob_test+0x12f/0x560
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888102c31c00 (size 1024):
  comm "kunit_try_catch", pid 1404, jiffies 4294720460 (age 781.948s)
  hex dump (first 32 bytes):
    6e 6f 72 6d 61 6c 5f 73 75 69 74 65 00 00 00 00  normal_suite....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
    [<ffffffff817bd242>] kmemdup+0x22/0x50
    [<ffffffff829ecf17>] kunit_filter_attr_tests+0xf7/0x860
    [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
    [<ffffffff829ea975>] filter_attr_test+0x195/0x5f0
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff8881052cd250 (size 192):
  comm "kunit_try_catch", pid 1404, jiffies 4294720460 (age 781.948s)
  hex dump (first 32 bytes):
    a0 85 9e 82 ff ff ff ff 00 a9 7c 84 ff ff ff ff  ..........|.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817dbad2>] __kmalloc+0x52/0x150
    [<ffffffff829ecfc1>] kunit_filter_attr_tests+0x1a1/0x860
    [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
    [<ffffffff829ea975>] filter_attr_test+0x195/0x5f0
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888104f4e400 (size 1024):
  comm "kunit_try_catch", pid 1408, jiffies 4294720464 (age 781.944s)
  hex dump (first 32 bytes):
    73 75 69 74 65 00 00 00 00 00 00 00 00 00 00 00  suite...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
    [<ffffffff817bd242>] kmemdup+0x22/0x50
    [<ffffffff829ecf17>] kunit_filter_attr_tests+0xf7/0x860
    [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
    [<ffffffff829e9fc3>] filter_attr_skip_test+0x133/0x6e0
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff8881052cc620 (size 192):
  comm "kunit_try_catch", pid 1408, jiffies 4294720464 (age 781.944s)
  hex dump (first 32 bytes):
    a0 85 9e 82 ff ff ff ff c0 a8 7c 84 ff ff ff ff  ..........|.....
    00 00 00 00 00 00 00 00 02 00 00 00 02 00 00 00  ................
  backtrace:
    [<ffffffff817dbad2>] __kmalloc+0x52/0x150
    [<ffffffff829ecfc1>] kunit_filter_attr_tests+0x1a1/0x860
    [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
    [<ffffffff829e9fc3>] filter_attr_skip_test+0x133/0x6e0
    [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81236fc6>] kthread+0x2b6/0x380
    [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
    [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20

Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Rae Moar <rmoar@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309142251.uJ8saAZv-lkp@intel.com/
---
v3:
- Update the kfree_at_end() to use kunit_free_suite_set() instead calling it
  directly.
- Update the commit message.
- Add Suggested-by.
v2:
- Add the memory leak backtrace.
- Remove the unused func kfree_at_end() kernel test robot noticed.
- Update the commit message.
---
 lib/kunit/executor_test.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index b4f6f96b2844..6b68959def9d 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -9,7 +9,7 @@
 #include <kunit/test.h>
 #include <kunit/attributes.h>
 
-static void kfree_at_end(struct kunit *test, const void *to_free);
+static void free_suite_set_at_end(struct kunit *test, const void *to_free);
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
 					    const char *suite_name,
 					    struct kunit_case *test_cases);
@@ -56,7 +56,7 @@ static void filter_suites_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
+	free_suite_set_at_end(test, &got);
 
 	/* Validate we just have suite2 */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
@@ -82,7 +82,7 @@ static void filter_suites_test_glob_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
+	free_suite_set_at_end(test, &got);
 
 	/* Validate we just have suite2 */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
@@ -109,7 +109,7 @@ static void filter_suites_to_empty_test(struct kunit *test)
 
 	got = kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start); /* just in case */
+	free_suite_set_at_end(test, &got); /* just in case */
 
 	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
 				"should be empty to indicate no match");
@@ -172,7 +172,7 @@ static void filter_attr_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
+	free_suite_set_at_end(test, &got);
 
 	/* Validate we just have normal_suite */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
@@ -200,7 +200,7 @@ static void filter_attr_empty_test(struct kunit *test)
 
 	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start); /* just in case */
+	free_suite_set_at_end(test, &got); /* just in case */
 
 	KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
 				"should be empty to indicate no match");
@@ -222,7 +222,7 @@ static void filter_attr_skip_test(struct kunit *test)
 	got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	kfree_at_end(test, got.start);
+	free_suite_set_at_end(test, &got);
 
 	/* Validate we have both the slow and normal test */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
@@ -256,18 +256,27 @@ kunit_test_suites(&executor_test_suite);
 
 /* Test helpers */
 
-/* Use the resource API to register a call to kfree(to_free).
+static void free_suite_set(struct kunit_suite_set *suite_set)
+{
+	kunit_free_suite_set(*suite_set);
+	kfree(suite_set);
+}
+
+/* Use the resource API to register a call to free_suite_set.
  * Since we never actually use the resource, it's safe to use on const data.
  */
-static void kfree_at_end(struct kunit *test, const void *to_free)
+static void free_suite_set_at_end(struct kunit *test, const void *to_free)
 {
-	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
-	if (IS_ERR_OR_NULL(to_free))
+	if (!((struct kunit_suite_set *)to_free)->start)
 		return;
 
+	struct kunit_suite_set *free = kzalloc(sizeof(struct kunit_suite_set),
+					       GFP_KERNEL);
+	*free = *(struct kunit_suite_set *)to_free;
+
 	kunit_add_action(test,
-			(kunit_action_t *)kfree,
-			(void *)to_free);
+			(kunit_action_t *)free_suite_set,
+			(void *)free);
 }
 
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
-- 
2.34.1

