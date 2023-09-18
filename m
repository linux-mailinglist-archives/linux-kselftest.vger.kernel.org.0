Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF427A41E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjIRHPK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbjIRHPF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 03:15:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124D186;
        Mon, 18 Sep 2023 00:12:53 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rpwtb19WqzrSJQ;
        Mon, 18 Sep 2023 15:10:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 15:12:50 +0800
Message-ID: <51f76d81-77f7-48b0-7a94-b28b2e5ed868@huawei.com>
Date:   Mon, 18 Sep 2023 15:12:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND 2/2] mm/damon/core-test: Fix memory leak in
 damon_new_ctx()
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
CC:     <akpm@linux-foundation.org>, <brendan.higgins@linux.dev>,
        <feng.tang@intel.com>, <damon@lists.linux.dev>,
        <linux-mm@kvack.org>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230918054326.74929-1-sj@kernel.org>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230918054326.74929-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 2023/9/18 13:43, SeongJae Park wrote:
> Hi Jinjie,
> 
> On Mon, 18 Sep 2023 13:10:44 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> The damon_ctx which is allocated by kzalloc() in damon_new_ctx() in
>> damon_test_ops_registration() and damon_test_set_attrs() are not freed and
>> it causes below memory leak. So use damon_destroy_ctx() to free it.
>>
>> unreferenced object 0xffff2b49c6968800 (size 512):
>>   comm "kunit_try_catch", pid 350, jiffies 4294895294 (age 557.028s)
>>   hex dump (first 32 bytes):
>>     88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
>>     00 87 93 03 00 00 00 00 0a 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>>     [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
>>     [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
>>     [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
>>     [<00000000daf6227b>] damon_test_ops_registration+0x34/0x328
>>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>>     [<000000003c3e9211>] kthread+0x124/0x130
>>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20
>> unreferenced object 0xffff2b49c1a9cc00 (size 512):
>>   comm "kunit_try_catch", pid 356, jiffies 4294895306 (age 557.000s)
>>   hex dump (first 32 bytes):
>>     88 13 00 00 00 00 00 00 a0 86 01 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>>     [<0000000073acab3b>] __kmem_cache_alloc_node+0x174/0x290
>>     [<00000000b5f89cef>] kmalloc_trace+0x40/0x164
>>     [<00000000eb19e83f>] damon_new_ctx+0x28/0xb4
>>     [<00000000058495c4>] damon_test_set_attrs+0x30/0x1a8
>>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>>     [<000000003c3e9211>] kthread+0x124/0x130
>>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20
> 
> Same to the comment on the first patch of this patchset, simply letting others
> know the name of the tool you used for making this cool output could be
> helpful.  Could you please add it?
> 
> Also, I prefer adding four spaces indent to quoted command outputs on commit
> messages.  Could you please add that indentation?
> 
> Also, I cannot 'git am' this patch on top of mm-unstable[1].  Could you please
> double check and rebase on latest mm-unstable if I din't miss something?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-unstable

Sure. Thank you very much!

> 
>>
>> Fixes: d1836a3b2a9a ("mm/damon/core-test: initialise context before test in damon_test_set_attrs()")
>> Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  mm/damon/core-test.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
>> index 255f8c925c00..ce86ed30fb47 100644
>> --- a/mm/damon/core-test.h
>> +++ b/mm/damon/core-test.h
>> @@ -266,6 +266,8 @@ static void damon_test_ops_registration(struct kunit *test)
>>  
>>  	/* Check double-registration failure again */
>>  	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
>> +
>> +	damon_destroy_ctx(c);
>>  }
>>  
>>  static void damon_test_set_regions(struct kunit *test)
>> @@ -342,6 +344,8 @@ static void damon_test_set_attrs(struct kunit *test)
>>  	invalid_attrs = valid_attrs;
>>  	invalid_attrs.aggr_interval = 4999;
>>  	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
>> +
>> +	damon_destroy_ctx(c);
>>  }
>>  
>>  static void damos_test_new_filter(struct kunit *test)
> 
> Other than above comments, changes look good to me.
> 
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> SJ
