Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECB6790B15
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjICGhR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbjICGhR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 02:37:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE07128
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Sep 2023 23:37:12 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rdhmx2kHRzQjN7;
        Sun,  3 Sep 2023 14:33:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sun, 3 Sep 2023 14:37:09 +0800
Message-ID: <f1308283-31bd-4cc9-8a7a-0ea40ff871c7@huawei.com>
Date:   Sun, 3 Sep 2023 14:37:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] kunit: Fix the wrong error path in
 kunit_filter_suites()
Content-Language: en-US
To:     David Gow <davidgow@google.com>
CC:     <brendan.higgins@linux.dev>, <skhan@linuxfoundation.org>,
        <jk@codeconstruct.com.au>, <dlatypov@google.com>,
        <rmoar@google.com>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>
References: <20230831071655.2907683-1-ruanjinjie@huawei.com>
 <20230831071655.2907683-5-ruanjinjie@huawei.com>
 <CABVgOSk5yOxMoaEoi-GYiwZpHRs7ytTKwWF=CT7vBhOJrBaYcw@mail.gmail.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <CABVgOSk5yOxMoaEoi-GYiwZpHRs7ytTKwWF=CT7vBhOJrBaYcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023/9/1 13:18, David Gow wrote:
> On Thu, 31 Aug 2023 at 15:17, 'Jinjie Ruan' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
>>
>> Take the last kfree(parsed_filters) and add it to be the first. Take
>> the first kfree(copy) and add it to be the last. The Best practice is to
>> return these errors reversely.
>>
>> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
>> Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_suites()")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
> 
> Agreed, these should be freed in reverse order.
> 
> Would it make sense to initialise 'copy' to NULL, and free it if (copy
> != NULL), rather than if (*err)? As mentioned in the previous patch, I
> think that'd be more correct.

There is a problem because the normal return also go through the all err
paths but 'copy' is not NULL and should not be freed.

> 
> We could also have several labels which target only the things which
> actually have been allocated so far.

That's a good idea!

> 
> Thoughts?
> -- David
> 
>>  lib/kunit/executor.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
>> index 7654c09c1ab1..da9444d22711 100644
>> --- a/lib/kunit/executor.c
>> +++ b/lib/kunit/executor.c
>> @@ -229,16 +229,16 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>>         filtered.end = copy;
>>
>>  err:
>> -       if (*err)
>> -               kfree(copy);
>> +       if (filter_count)
>> +               kfree(parsed_filters);
>>
>>         if (filter_glob) {
>>                 kfree(parsed_glob.suite_glob);
>>                 kfree(parsed_glob.test_glob);
>>         }
> 
> I think this might also be potentially broken. If
> parsed_glob.{suite,test}_glob are not successfully allocated,
> filter_glob will still be set, and we'll kfree() something invalid.
> Should we also init parsed_glob.* to NULL, and free them if non-NULL,
> rather than relying on the presence of filter_glob?

if not successsfully allocated, it will be NULL and kfree NULL is ok.

> 
> 
> 
>>
>> -       if (filter_count)
>> -               kfree(parsed_filters);
>> +       if (*err)
>> +               kfree(copy);
>>
>>         return filtered;
>>  }
>> --
>> 2.34.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230831071655.2907683-5-ruanjinjie%40huawei.com.
