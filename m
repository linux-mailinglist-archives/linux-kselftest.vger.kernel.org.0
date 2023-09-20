Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830BD7A7098
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 04:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjITCes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 22:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjITCel (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 22:34:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B7AC
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 19:34:35 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rr2bW2kg2zVl7T;
        Wed, 20 Sep 2023 10:31:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 10:34:32 +0800
Message-ID: <d6b0cccb-1b3f-d28e-fa26-f91370f86bfd@huawei.com>
Date:   Wed, 20 Sep 2023 10:34:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/4] kunit: Fix possible memory leak in
 kunit_filter_suites()
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
CC:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
References: <20230914114629.1517650-1-ruanjinjie@huawei.com>
 <20230914114629.1517650-4-ruanjinjie@huawei.com>
 <CA+GJov6VnaojY7aA7LvhwmWwPziyAVOLZB97oAJMTWRh19r0eg@mail.gmail.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <CA+GJov6VnaojY7aA7LvhwmWwPziyAVOLZB97oAJMTWRh19r0eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2023/9/20 5:18, Rae Moar wrote:
> On Thu, Sep 14, 2023 at 7:47 AM 'Jinjie Ruan' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
>>
>> If the outer layer for loop is iterated more than once and it fails not
>> in the first iteration, the filtered_suite and filtered_suite->test_cases
>> allocated in the last kunit_filter_attr_tests() in last inner for loop
>> is leaked.
>>
>> So add a new free_filtered_suite err label and free the filtered_suite
>> and filtered_suite->test_cases so far. And change kmalloc_array of copy
>> to kcalloc to Clear the copy to make the kfree safe.
>>
>> Fixes: 5d31f71efcb6 ("kunit: add kunit.filter_glob cmdline option to filter suites")
>> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Hello!
> 
> This looks good to me. I just have one comment below.
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
> Thanks!
> -Rae
> 
>> ---
>>  lib/kunit/executor.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
>> index 9358ed2df839..1236b3cd2fbb 100644
>> --- a/lib/kunit/executor.c
>> +++ b/lib/kunit/executor.c
>> @@ -157,10 +157,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>>         struct kunit_suite_set filtered = {NULL, NULL};
>>         struct kunit_glob_filter parsed_glob;
>>         struct kunit_attr_filter *parsed_filters = NULL;
>> +       struct kunit_suite * const *suites;
>>
>>         const size_t max = suite_set->end - suite_set->start;
>>
>> -       copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
>> +       copy = kcalloc(max, sizeof(*filtered.start), GFP_KERNEL);
>>         if (!copy) { /* won't be able to run anything, return an empty set */
>>                 return filtered;
>>         }
>> @@ -195,7 +196,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>>                                         parsed_glob.test_glob);
>>                         if (IS_ERR(filtered_suite)) {
>>                                 *err = PTR_ERR(filtered_suite);
>> -                               goto free_parsed_filters;
>> +                               goto free_filtered_suite;
>>                         }
>>                 }
>>                 if (filter_count > 0 && parsed_filters != NULL) {
>> @@ -212,11 +213,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>>                                 filtered_suite = new_filtered_suite;
>>
>>                                 if (*err)
>> -                                       goto free_parsed_filters;
>> +                                       goto free_filtered_suite;
>>
>>                                 if (IS_ERR(filtered_suite)) {
>>                                         *err = PTR_ERR(filtered_suite);
>> -                                       goto free_parsed_filters;
>> +                                       goto free_filtered_suite;
>>                                 }
>>                                 if (!filtered_suite)
>>                                         break;
>> @@ -231,6 +232,14 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>>         filtered.start = copy_start;
>>         filtered.end = copy;
>>
>> +free_filtered_suite:
>> +       if (*err) {
>> +               for (suites = copy_start; suites < copy; suites++) {
>> +                       kfree((*suites)->test_cases);
>> +                       kfree(*suites);
>> +               }
>> +       }
>> +
> 
> As this is pretty similar code to kunit_free_suite_set, I wish you
> could use that method instead but I'm not actually sure it would be
> cleaner.

There is a slight difference between here and kunit_free_suite_set(), it
do not kfree(suite_set.start) which is kfree(copy_start) here as it is
the first kcalloc.

> 
> 
>>  free_parsed_filters:
>>         if (filter_count)
>>                 kfree(parsed_filters);
>> --
>> 2.34.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230914114629.1517650-4-ruanjinjie%40huawei.com.
> 
