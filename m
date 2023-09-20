Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D747A738F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 09:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjITHAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjITHA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 03:00:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDED7
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:00:18 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rr8W36hG5zrSsQ;
        Wed, 20 Sep 2023 14:58:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 15:00:13 +0800
Message-ID: <83732fd6-32bb-327c-34df-f54ad3495ac2@huawei.com>
Date:   Wed, 20 Sep 2023 15:00:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] kunit: test: Fix the possible memory leak in
 executor_test
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
References: <20230914114629.1517650-1-ruanjinjie@huawei.com>
 <20230914114629.1517650-5-ruanjinjie@huawei.com>
 <CA+GJov7Uya8r4T6EtQQ03KQ7BPRsCb8N3y687eDxDitnJ3Aifw@mail.gmail.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <CA+GJov7Uya8r4T6EtQQ03KQ7BPRsCb8N3y687eDxDitnJ3Aifw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/9/20 5:19, Rae Moar wrote:
> On Thu, Sep 14, 2023 at 7:47 AM 'Jinjie Ruan' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
>>
>> If kunit_filter_suites() succeeds, not only copy but also filtered_suite
>> and filtered_suite->test_cases should be freed.
>>
>> So use kunit_free_suite_set() to free the filtered_suite,
>> filtered_suite->test_cases and copy as kunit_module_exit() and
>> kunit_run_all_tests() do it.
>>
>> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Hello!
> 
> This looks mostly good to me. But I have one notable comment. See below.
> 
> Thanks!
> -Rae
> 
>> ---
>>  lib/kunit/executor_test.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
>> index b4f6f96b2844..987b81dce01e 100644
>> --- a/lib/kunit/executor_test.c
>> +++ b/lib/kunit/executor_test.c
>> @@ -56,7 +56,6 @@ static void filter_suites_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have suite2 */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -64,6 +63,9 @@ static void filter_suites_test(struct kunit *test)
>>
>>         /* Contains one element (end is 1 past end) */
>>         KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
> 
> I definitely appreciate the change to free all of "got" rather than
> just "got.start".
> 
> However, kfree_at_end used deferred actions to ensure the kfree would
> occur at the end of the test. With this change, if the test fails the
> suite set could not be freed.
> 
> Intead, is there any way to alter the function kfree_at_end (could be
> renamed) to take in "got" and then use deferred actions to ensure
> kunit_free_suite_set is called at the end of the test?

I try it and it seems unfeasible because the got is a local struct
kunit_suite_set and kunit_free_suite_set use it in another func will
cause wild-memory-access as the struct kunit_suite_set has been freed
already.

[   49.490158] general protection fault, probably for non-canonical
address 0xe006fbfff71d514d: 0000 [#1] PREEMPT SMP KASAN
[   49.493858] KASAN: maybe wild-memory-access in range
[0x0037ffffb8ea8a68-0x0037ffffb8ea8a6f]
[   49.495391] CPU: 2 PID: 1439 Comm: kunit_try_catch Tainted: G    B
        N 6.6.0-rc2+ #29
[   49.496578] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   49.497715] RIP: 0010:kunit_free_suite_set+0x8e/0x150
[   49.498419] Code: 4d 89 fe 49 c1 ee 03 49 01 de 48 89 e8 48 c1 e8 03
80 3c 18 00 75 7d 4c 8b 65 00 49 8d bc 24 20 01 00 00 48 89 f8 48 c1 e8
03 <80> 3c 18 00 0f 85 81 00 00 00 49 8b bc 24 20 01 00 00 e8 2b 90 e0
[   49.500918] RSP: 0000:ffff8881047f7e18 EFLAGS: 00010207
[   49.501627] RAX: 0006fffff71d514d RBX: dffffc0000000000 RCX:
1ffff11020814d9e
[   49.502597] RDX: 1ffff110214f6fbc RSI: 0000000000000004 RDI:
0037ffffb8ea8a6c
[   49.503553] RBP: ffffffff811d098f R08: 0000000000000001 R09:
ffffed1020814d99
[   49.504526] R10: ffff8881040a6ccb R11: 0000000000000400 R12:
0037ffffb8ea894c
[   49.505489] R13: ffff88810a7b7dd8 R14: ffffed10214f6fbc R15:
ffff88810a7b7de0
[   49.506470] FS:  0000000000000000(0000) GS:ffff888119d00000(0000)
knlGS:0000000000000000
[   49.507497] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.508200] CR2: ffff88811948dfff CR3: 0000000005286001 CR4:
0000000000770ee0
[   49.509078] DR0: ffffffff8fdd6ce8 DR1: ffffffff8fdd6ce9 DR2:
ffffffff8fdd6cea
[   49.509909] DR3: ffffffff8fdd6ceb DR6: 00000000fffe0ff0 DR7:
0000000000000600
[   49.510790] PKRU: 55555554
[   49.511127] Call Trace:
[   49.511448]  <TASK>
[   49.511715]  ? die_addr+0x3d/0xa0
[   49.512133]  ? exc_general_protection+0x144/0x220
[   49.512725]  ? asm_exc_general_protection+0x22/0x30
[   49.513323]  ? do_exit+0x125f/0x2240
[   49.513785]  ? kunit_free_suite_set+0x8e/0x150
[   49.514330]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   49.514901]  kunit_remove_resource+0x191/0x2a0
[   49.515464]  ? __sched_text_end+0xa/0xa
[   49.515949]  ? __sched_text_end+0xa/0xa
[   49.516432]  kunit_cleanup+0x6f/0x110
[   49.516885]  ? kunit_cleanup+0x110/0x110
[   49.517374]  kunit_generic_run_threadfn_adapter+0x4a/0x90
[   49.518045]  ? kunit_try_catch_throw+0x80/0x80
[   49.518623]  kthread+0x2b5/0x380
[   49.519032]  ? kthread_complete_and_exit+0x20/0x20
[   49.519626]  ret_from_fork+0x2d/0x70
[   49.520078]  ? kthread_complete_and_exit+0x20/0x20
[   49.520679]  ret_from_fork_asm+0x11/0x20
[   49.521179]  </TASK>
[   49.521459] Modules linked in:
[   49.521849] Dumping ftrace buffer:
[   49.522273]    (ftrace buffer empty)
[   49.522764] ---[ end trace 0000000000000000 ]---
[   49.523416] RIP: 0010:kunit_free_suite_set+0x8e/0x150
[   49.524049] Code: 4d 89 fe 49 c1 ee 03 49 01 de 48 89 e8 48 c1 e8 03
80 3c 18 00 75 7d 4c 8b 65 00 49 8d bc 24 20 01 00 00 48 89 f8 48 c1 e8
03 <80> 3c 18 00 0f 85 81 00 00 00 49 8b bc 24 20 01 00 00 e8 2b 90 e0
[   49.526357] RSP: 0000:ffff8881047f7e18 EFLAGS: 00010207
[   49.527026] RAX: 0006fffff71d514d RBX: dffffc0000000000 RCX:
1ffff11020814d9e
[   49.527898] RDX: 1ffff110214f6fbc RSI: 0000000000000004 RDI:
0037ffffb8ea8a6c
[   49.528765] RBP: ffffffff811d098f R08: 0000000000000001 R09:
ffffed1020814d99
[   49.529633] R10: ffff8881040a6ccb R11: 0000000000000400 R12:
0037ffffb8ea894c
[   49.530524] R13: ffff88810a7b7dd8 R14: ffffed10214f6fbc R15:
ffff88810a7b7de0
[   49.531405] FS:  0000000000000000(0000) GS:ffff888119d00000(0000)
knlGS:0000000000000000
[   49.532386] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.533094] CR2: ffff88811948dfff CR3: 0000000005286001 CR4:
0000000000770ee0
[   49.533971] DR0: ffffffff8fdd6ce8 DR1: ffffffff8fdd6ce9 DR2:
ffffffff8fdd6cea
[   49.534879] DR3: ffffffff8fdd6ceb DR6: 00000000fffe0ff0 DR7:
0000000000000600
[   49.535774] PKRU: 55555554
[   49.536108] Kernel panic - not syncing: Fatal exception
[   49.537673] Dumping ftrace buffer:
[   49.538076]    (ftrace buffer empty)
[   49.538531] Kernel Offset: disabled
[   49.538963] Rebooting in 1 seconds..

> 
> Let me know what you think about this.
> 
> 
>>  }
>>
>>  static void filter_suites_test_glob_test(struct kunit *test)
>> @@ -82,7 +84,6 @@ static void filter_suites_test_glob_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, "suite2.test2", NULL, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have suite2 */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -93,6 +94,9 @@ static void filter_suites_test_glob_test(struct kunit *test)
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>>         KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0].name, "test2");
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static void filter_suites_to_empty_test(struct kunit *test)
>> @@ -109,10 +113,12 @@ static void filter_suites_to_empty_test(struct kunit *test)
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
>>  }
>>
>>  static void parse_filter_attr_test(struct kunit *test)
>> @@ -172,7 +178,6 @@ static void filter_attr_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we just have normal_suite */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
>> @@ -183,6 +188,9 @@ static void filter_attr_test(struct kunit *test)
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>>         KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "normal");
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static void filter_attr_empty_test(struct kunit *test)
>> @@ -200,10 +208,12 @@ static void filter_attr_empty_test(struct kunit *test)
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
>>  }
>>
>>  static void filter_attr_skip_test(struct kunit *test)
>> @@ -222,7 +232,6 @@ static void filter_attr_skip_test(struct kunit *test)
>>         got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>>         KUNIT_ASSERT_EQ(test, err, 0);
>> -       kfree_at_end(test, got.start);
>>
>>         /* Validate we have both the slow and normal test */
>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>> @@ -233,6 +242,9 @@ static void filter_attr_skip_test(struct kunit *test)
>>         /* Now ensure slow is skipped and normal is not */
>>         KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_SKIPPED);
>>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
>> +
>> +       if (!err)
>> +               kunit_free_suite_set(got);
>>  }
>>
>>  static struct kunit_case executor_test_cases[] = {
>> --
>> 2.34.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230914114629.1517650-5-ruanjinjie%40huawei.com.
> 
