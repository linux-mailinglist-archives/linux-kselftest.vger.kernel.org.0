Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087CE7A41DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjIRHOi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 03:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbjIRHOO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 03:14:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB7B1A5;
        Mon, 18 Sep 2023 00:13:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rpwrz18XpzNndR;
        Mon, 18 Sep 2023 15:09:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 15:13:08 +0800
Message-ID: <efa81da6-f8c6-e4c0-1d9c-24fb72681c54@huawei.com>
Date:   Mon, 18 Sep 2023 15:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND 1/2] mm/damon/core-test: Fix memory leak in
 damon_new_region()
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
CC:     <akpm@linux-foundation.org>, <brendan.higgins@linux.dev>,
        <feng.tang@intel.com>, <damon@lists.linux.dev>,
        <linux-mm@kvack.org>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230918053320.61408-1-sj@kernel.org>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230918053320.61408-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2023/9/18 13:33, SeongJae Park wrote:
> Hi Jinjie,
> 
> 
> Thank you for this patchset!
> 
> On Mon, 18 Sep 2023 13:10:43 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> The damon_region which is allocated by kmem_cache_alloc() in
>> damon_new_region() in damon_test_regions() and
>> damon_test_update_monitoring_result() are not freed and it causes below
>> memory leak. So use damon_free_region() to free it.
>>
>> unreferenced object 0xffff2b49c3edc000 (size 56):
>>   comm "kunit_try_catch", pid 338, jiffies 4294895280 (age 557.084s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 49 2b ff ff  ............I+..
>>   backtrace:
>>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>>     [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
>>     [<000000008603f022>] damon_new_region+0x28/0x54
>>     [<00000000a3b8c64e>] damon_test_regions+0x38/0x270
>>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>>     [<000000003c3e9211>] kthread+0x124/0x130
>>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20
>> unreferenced object 0xffff2b49c5b20000 (size 56):
>>   comm "kunit_try_catch", pid 354, jiffies 4294895304 (age 556.988s)
>>   hex dump (first 32 bytes):
>>     03 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 96 00 00 00 49 2b ff ff  ............I+..
>>   backtrace:
>>     [<0000000088e71769>] slab_post_alloc_hook+0xb8/0x368
>>     [<00000000b528f67c>] kmem_cache_alloc+0x168/0x284
>>     [<000000008603f022>] damon_new_region+0x28/0x54
>>     [<00000000ca019f80>] damon_test_update_monitoring_result+0x18/0x34
>>     [<00000000559c4801>] kunit_try_run_case+0x50/0xac
>>     [<000000003932ed49>] kunit_generic_run_threadfn_adapter+0x20/0x2c
>>     [<000000003c3e9211>] kthread+0x124/0x130
>>     [<0000000028f85bdd>] ret_from_fork+0x10/0x20
> 
> Nice finding!  Could you please share just a brief more detail about above cool
> output, e.g., just the name of the tool you used, so that others can learn it
> from your awesome commit message?
> 
>>
>> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
>> Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  mm/damon/core-test.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
>> index 6cc8b245586d..255f8c925c00 100644
>> --- a/mm/damon/core-test.h
>> +++ b/mm/damon/core-test.h
>> @@ -34,6 +34,7 @@ static void damon_test_regions(struct kunit *test)
>>  	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
>>  
>>  	damon_free_target(t);
>> +	damon_free_region(r);
> 
> There is damon_destroy_region() function, which simply calls damon_del_region()
> and damon_free_region().  Unless there is needs to access the region before
> removing from the region, doing memory return together via the function is
> recommended.
> 
> And this test code calls damon_del_region() just beofre above
> KUNIT_EXPECT_EQ().  Hence, I think replacing the damon_del_region() call with
> damon_destroy_region() rather than calling damon_free_region() may be simpler
> and shorter.  Could you please do so?

Sure. Thank you very much!

> 
>>  }
>>  
>>  static unsigned int nr_damon_targets(struct damon_ctx *ctx)
>> @@ -316,6 +317,8 @@ static void damon_test_update_monitoring_result(struct kunit *test)
>>  	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
>>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
>>  	KUNIT_EXPECT_EQ(test, r->age, 20);
>> +
>> +	damon_free_region(r);
> 
> This looks nice.  Thank you for fixing this!
> 
>>  }
>>  
>>  static void damon_test_set_attrs(struct kunit *test)
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> SJ
