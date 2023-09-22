Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6B7AA92D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjIVGiE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjIVGiD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 02:38:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9292083
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 23:37:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RsMvK61FLzVl3X;
        Fri, 22 Sep 2023 14:34:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 14:37:54 +0800
Message-ID: <dbfa620b-8be1-13bb-d0a9-0ee61dbc5d3e@huawei.com>
Date:   Fri, 22 Sep 2023 14:37:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/4] kunit: test: Fix the possible memory leak in
 executor_test
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
References: <20230921014008.3887257-1-ruanjinjie@huawei.com>
 <20230921014008.3887257-5-ruanjinjie@huawei.com>
 <CA+GJov5OynJa5W=ofWA1zLrq+CBFaJgOn-LQMc+40TEaZNkD+g@mail.gmail.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <CA+GJov5OynJa5W=ofWA1zLrq+CBFaJgOn-LQMc+40TEaZNkD+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/9/22 3:50, Rae Moar wrote:
> On Wed, Sep 20, 2023 at 9:41 PM 'Jinjie Ruan' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
>>
>> When CONFIG_KUNIT_ALL_TESTS=y, making CONFIG_DEBUG_KMEMLEAK=y and
>> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
>>
>> If kunit_filter_suites() succeeds, not only copy but also filtered_suite
>> and filtered_suite->test_cases should be freed.
>>
>> So use kunit_free_suite_set() to free the filtered_suite,
>> filtered_suite->test_cases and copy as kunit_module_exit() and
>> kunit_run_all_tests() do it. And the func kfree_at_end() is not used so
>> remove it. After applying this patch, the following memory leak is never
>> detected.
>>
>> unreferenced object 0xffff8881001de400 (size 1024):
>>   comm "kunit_try_catch", pid 1396, jiffies 4294720452 (age 932.801s)
>>   hex dump (first 32 bytes):
>>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>>     [<ffffffff829e961d>] kunit_filter_suites+0x44d/0xcc0
>>     [<ffffffff829eb69f>] filter_suites_test+0x12f/0x360
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>> unreferenced object 0xffff8881052cd388 (size 192):
>>   comm "kunit_try_catch", pid 1396, jiffies 4294720452 (age 932.801s)
>>   hex dump (first 32 bytes):
>>     a0 85 9e 82 ff ff ff ff 80 cd 7c 84 ff ff ff ff  ..........|.....
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>>     [<ffffffff829e9651>] kunit_filter_suites+0x481/0xcc0
>>     [<ffffffff829eb69f>] filter_suites_test+0x12f/0x360
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>>
>> unreferenced object 0xffff888100da8400 (size 1024):
>>   comm "kunit_try_catch", pid 1398, jiffies 4294720454 (age 781.945s)
>>   hex dump (first 32 bytes):
>>     73 75 69 74 65 32 00 00 00 00 00 00 00 00 00 00  suite2..........
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>>     [<ffffffff829e961d>] kunit_filter_suites+0x44d/0xcc0
>>     [<ffffffff829eb13f>] filter_suites_test_glob_test+0x12f/0x560
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>> unreferenced object 0xffff888105117878 (size 96):
>>   comm "kunit_try_catch", pid 1398, jiffies 4294720454 (age 781.945s)
>>   hex dump (first 32 bytes):
>>     a0 85 9e 82 ff ff ff ff a0 ac 7c 84 ff ff ff ff  ..........|.....
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>>     [<ffffffff829e9651>] kunit_filter_suites+0x481/0xcc0
>>     [<ffffffff829eb13f>] filter_suites_test_glob_test+0x12f/0x560
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>> unreferenced object 0xffff888102c31c00 (size 1024):
>>   comm "kunit_try_catch", pid 1404, jiffies 4294720460 (age 781.948s)
>>   hex dump (first 32 bytes):
>>     6e 6f 72 6d 61 6c 5f 73 75 69 74 65 00 00 00 00  normal_suite....
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>>     [<ffffffff829ecf17>] kunit_filter_attr_tests+0xf7/0x860
>>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>>     [<ffffffff829ea975>] filter_attr_test+0x195/0x5f0
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>> unreferenced object 0xffff8881052cd250 (size 192):
>>   comm "kunit_try_catch", pid 1404, jiffies 4294720460 (age 781.948s)
>>   hex dump (first 32 bytes):
>>     a0 85 9e 82 ff ff ff ff 00 a9 7c 84 ff ff ff ff  ..........|.....
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>>     [<ffffffff829ecfc1>] kunit_filter_attr_tests+0x1a1/0x860
>>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>>     [<ffffffff829ea975>] filter_attr_test+0x195/0x5f0
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>> unreferenced object 0xffff888104f4e400 (size 1024):
>>   comm "kunit_try_catch", pid 1408, jiffies 4294720464 (age 781.944s)
>>   hex dump (first 32 bytes):
>>     73 75 69 74 65 00 00 00 00 00 00 00 00 00 00 00  suite...........
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817db753>] __kmalloc_node_track_caller+0x53/0x150
>>     [<ffffffff817bd242>] kmemdup+0x22/0x50
>>     [<ffffffff829ecf17>] kunit_filter_attr_tests+0xf7/0x860
>>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>>     [<ffffffff829e9fc3>] filter_attr_skip_test+0x133/0x6e0
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>> unreferenced object 0xffff8881052cc620 (size 192):
>>   comm "kunit_try_catch", pid 1408, jiffies 4294720464 (age 781.944s)
>>   hex dump (first 32 bytes):
>>     a0 85 9e 82 ff ff ff ff c0 a8 7c 84 ff ff ff ff  ..........|.....
>>     00 00 00 00 00 00 00 00 02 00 00 00 02 00 00 00  ................
>>   backtrace:
>>     [<ffffffff817dbad2>] __kmalloc+0x52/0x150
>>     [<ffffffff829ecfc1>] kunit_filter_attr_tests+0x1a1/0x860
>>     [<ffffffff829e99ff>] kunit_filter_suites+0x82f/0xcc0
>>     [<ffffffff829e9fc3>] filter_attr_skip_test+0x133/0x6e0
>>     [<ffffffff829e802a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>>     [<ffffffff81236fc6>] kthread+0x2b6/0x380
>>     [<ffffffff81096afd>] ret_from_fork+0x2d/0x70
>>     [<ffffffff81003511>] ret_from_fork_asm+0x11/0x20
>>
>> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202309142251.uJ8saAZv-lkp@intel.com/
> 
> Hello!
> 
> Thanks for sending out a new version and responding to my comments. I
> do have one issue below.
> 
> Thanks!
> -Rae
> 
>> ---
>> v2:
>> - Add the memory leak backtrace.
>> - Remove the unused func kfree_at_end() kernel test robot noticed.
>> - Update the commit message.
>> ---
>>  lib/kunit/executor_test.c | 40 ++++++++++++++++++---------------------
>>  1 file changed, 18 insertions(+), 22 deletions(-)
>>
>> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
>> index b4f6f96b2844..88d26c9cdce8 100644
>> --- a/lib/kunit/executor_test.c
>> +++ b/lib/kunit/executor_test.c
>> @@ -9,7 +9,6 @@
>>  #include <kunit/test.h>
>>  #include <kunit/attributes.h>
>>
>> -static void kfree_at_end(struct kunit *test, const void *to_free);
>>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>>                                             const char *suite_name,
>>                                             struct kunit_case *test_cases);
>> @@ -56,7 +55,6 @@ static void filter_suites_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have suite2 */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -64,6 +62,9 @@ static void filter_suites_test(struct kunit *test)
>>
>>         /* Contains one element (end is 1 past end) */
>>         KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> 
> If filtering incorrectly outputs more than one suite, the line above
> will fail. This will cause the test to exit immediately because this
> is an ASSERT statement instead of an EXPECT statement.
> 
> If this happens, the suite set will never be freed. Instead we should
> change this to KUNIT_EXPECT_EQ so the test will continue to the below
> if statement.
> 
> We should change this for all similar lines where we still want to
> free the suite if they fail.

Right! It is better to update the kfree_at_end() func to solve these
problems. I'll try to do it sooner.

> 
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
>>  }
>>
>>  static void filter_suites_test_glob_test(struct kunit *test)
>> @@ -82,7 +83,6 @@ static void filter_suites_test_glob_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have suite2 */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -93,6 +93,9 @@ static void filter_suites_test_glob_test(struct kunit *test)
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>>         KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
> Again I recommend changing the line in this test from
> "KUNIT_ASSERT_EQ(test, got.end - got.start, 1);" to an EXPECT
> statement.
> 
>>  }
>>
>>  static void filter_suites_to_empty_test(struct kunit *test)
>> @@ -109,10 +112,12 @@ static void filter_suites_to_empty_test(struct kunit *test)
>>
>>         got = kunit_filter_suites(&suite_set, "not_found", NULL, NULL, &err);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start); /* just in case */
>>
>>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>>                                 "should be empty to indicate no match");
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
> This test seems good.
> 
>>  }
>>
>>  static void parse_filter_attr_test(struct kunit *test)
>> @@ -172,7 +177,6 @@ static void filter_attr_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have normal_suite */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -183,6 +187,9 @@ static void filter_attr_test(struct kunit *test)
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>>         KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "normal");
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
> Again I recommend changing the line in this test from
> "KUNIT_ASSERT_EQ(test, got.end - got.start, 1);" to an EXPECT
> statement.
> 
>>  }
>>
>>  static void filter_attr_empty_test(struct kunit *test)
>> @@ -200,10 +207,12 @@ static void filter_attr_empty_test(struct kunit *test)
>>
>>         got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start); /* just in case */
>>
>>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>>                                 "should be empty to indicate no match");
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
> This test seems good.
> 
>>  }
>>
>>  static void filter_attr_skip_test(struct kunit *test)
>> @@ -222,7 +231,6 @@ static void filter_attr_skip_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we have both the slow and normal test */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>> @@ -233,6 +241,9 @@ static void filter_attr_skip_test(struct kunit *test)
>>         /* Now ensure slow is skipped and normal is not */
>>         KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
> Similarly, the line "KUNIT_ASSERT_EQ(test,
> kunit_suite_num_test_cases(got.start[0]), 2)" may exit causing the
> suite to not be freed. This should be changed to an EXPECT statement.
> However, we may then want to check before accessing the test cases.
> 
>>  }
>>
>>  static struct kunit_case executor_test_cases[] = {
>> @@ -255,21 +266,6 @@ static struct kunit_suite executor_test_suite = {
>>  kunit_test_suites(&executor_test_suite);
>>
>>  /* Test helpers */
>> -
>> -/* Use the resource API to register a call to kfree(to_free).
>> - * Since we never actually use the resource, it's safe to use on const data.
>> - */
>> -static void kfree_at_end(struct kunit *test, const void *to_free)
>> -{
>> -       /* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
>> -       if (IS_ERR_OR_NULL(to_free))
>> -               return;
>> -
>> -       kunit_add_action(test,
>> -                       (kunit_action_t *)kfree,
>> -                       (void *)to_free);
>> -}
>> -
>>  static struct kunit_suite *alloc_fake_suite(struct kunit *test,
>>                                             const char *suite_name,
>>                                             struct kunit_case *test_cases)
>> --
>> 2.34.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230921014008.3887257-5-ruanjinjie%40huawei.com.
> 
