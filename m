Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6804475251F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGMOaK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGMOaJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B522680
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689258560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWheRexL9/dCgbw7jig9WF+1nd9uSSsREdM3sWtNnIk=;
        b=FO71NzlPsjfYJSx2BgbvmeuLJWJIefkh9o2JqBD9tXH0awWS1YGoKQifU0OYo+bI2g8PBQ
        7i34+Jn+7ySJxoKAqB22aZ+5qihgGqC2FasJw5XPpDNIqUKxtcQzLWz+/YL5qlNuQsvUaW
        qKWbweTE1YWeRD+WFkQsaElSMERJ2XE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-SLwnFzgFNsiB3UZTb0U7gA-1; Thu, 13 Jul 2023 10:29:18 -0400
X-MC-Unique: SLwnFzgFNsiB3UZTb0U7gA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbcae05906so3365785e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258556; x=1691850556;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWheRexL9/dCgbw7jig9WF+1nd9uSSsREdM3sWtNnIk=;
        b=Fq3jz8vhlAeIWH0wTxkY8NnSB2BjxOtAJZzLnbAwg+WXBy+BaQPKcUc3qqf6gkdLOO
         zVuuyr17rC+ZvuTsv3H5GJjx4kQqucY0z1QnxgKnCQJx8evjhpGMxNEeuHCgBnpqnFGp
         3o2azOqxXv+kScJbmAxnNIOCI41zECrqQztVaTxYBvriA89FqDt1zoVRYOlWupu1RRaF
         QONIQSROD2t5itvNpQ2gSvXoELmZKMFeC7A9lDQEjDre1ocooFQU/0G6Y9qHmrqGjVaL
         /N/XhZ4jtEvkJa8T3yrTwSpvDk/IqOhnbXTWKVKZVnMxcpsAubQd9ogfq0v2dMNOFRVq
         IIqw==
X-Gm-Message-State: ABy/qLbVfL9KXrV6MCNTH+MXeWTtUhJbzKm0V0NvcX7v0l768WcoX2kv
        AmQHPVzVKEEWxcoBNdb2DP/KpVio++Qpg7zRXwQknhSOipQ9XbRFOrEHnkgRyeHqEKMgoKDjIyq
        mg0Pwl9uY9dj8+kZ0qdASPxMc/vgc
X-Received: by 2002:a5d:5185:0:b0:30f:d1e3:22b7 with SMTP id k5-20020a5d5185000000b0030fd1e322b7mr2068831wrv.6.1689258556556;
        Thu, 13 Jul 2023 07:29:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCo+2nmgVTcBRc9JOJoYST2pj1+6ivlrd1rEq1VKgGw7EbnCrodlPYzOGiJn5LwTkY0iPvLw==
X-Received: by 2002:a5d:5185:0:b0:30f:d1e3:22b7 with SMTP id k5-20020a5d5185000000b0030fd1e322b7mr2068802wrv.6.1689258556128;
        Thu, 13 Jul 2023 07:29:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id q10-20020adff50a000000b003144bfbd0b3sm8156598wro.37.2023.07.13.07.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:29:15 -0700 (PDT)
Message-ID: <aacd934b-9249-cb84-5efa-bf331e78688f@redhat.com>
Date:   Thu, 13 Jul 2023 16:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-4-ryan.roberts@arm.com>
 <cf3c237e-69c8-dd6e-26fc-fe19de910813@redhat.com>
 <773cc0a8-24b8-7fcb-2980-7676fc772014@arm.com>
 <3c566e28-c7ad-7ba8-4583-619266282387@redhat.com>
 <556d05f0-7103-1079-fce1-1fb6bd40b17c@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <556d05f0-7103-1079-fce1-1fb6bd40b17c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.07.23 16:14, Ryan Roberts wrote:
> On 13/07/2023 15:09, David Hildenbrand wrote:
>> On 13.07.23 16:03, Ryan Roberts wrote:
>>> On 13/07/2023 14:56, David Hildenbrand wrote:
>>>> On 13.07.23 15:54, Ryan Roberts wrote:
>>>>> arm64 does not support the soft-dirty PTE bit. However there are tests
>>>>> in `madv_populate` and `soft-dirty` which assume it is supported and
>>>>> cause spurious failures to be reported when preferred behaviour would be
>>>>> to mark the tests as skipped.
>>>>>
>>>>> Unfortunately, the only way to determine if the soft-dirty dirty bit is
>>>>> supported is to write to a page, then see if the bit is set in
>>>>> /proc/self/pagemap. But the tests that we want to conditionally execute
>>>>> are testing precicesly this. So if we introduced this feature check, we
>>>>> could accedentally turn a real failure (on a system that claims to
>>>>> support soft-dirty) into a skip.
>>>>>
>>>>> So instead, do the check based on architecture; for arm64, we report
>>>>> that soft-dirty is not supported. This is wrapped up into a utility
>>>>> function `system_has_softdirty()`, which is used to skip the whole
>>>>> `soft-dirty` suite, and mark the soft-dirty tests in the `madv_populate`
>>>>> suite as skipped.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>     tools/testing/selftests/mm/madv_populate.c | 18 +++++++++++++-----
>>>>>     tools/testing/selftests/mm/soft-dirty.c    |  3 +++
>>>>>     tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
>>>>>     tools/testing/selftests/mm/vm_util.h       |  1 +
>>>>>     4 files changed, 34 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/mm/madv_populate.c
>>>>> b/tools/testing/selftests/mm/madv_populate.c
>>>>> index 60547245e479..5a8c176d7fec 100644
>>>>> --- a/tools/testing/selftests/mm/madv_populate.c
>>>>> +++ b/tools/testing/selftests/mm/madv_populate.c
>>>>> @@ -232,6 +232,14 @@ static bool range_is_not_softdirty(char *start, ssize_t
>>>>> size)
>>>>>         return ret;
>>>>>     }
>>>>>
>>>>> +#define ksft_test_result_if_softdirty(cond, ...)    \
>>>>> +do {                            \
>>>>> +    if (system_has_softdirty())            \
>>>>> +        ksft_test_result(cond, __VA_ARGS__);    \
>>>>> +    else                        \
>>>>> +        ksft_test_result_skip(__VA_ARGS__);    \
>>>>> +} while (0)
>>>>> +
>>>>>     static void test_softdirty(void)
>>>>>     {
>>>>>         char *addr;
>>>>> @@ -246,19 +254,19 @@ static void test_softdirty(void)
>>>>>
>>>>>         /* Clear any softdirty bits. */
>>>>>         clear_softdirty();
>>>>> -    ksft_test_result(range_is_not_softdirty(addr, SIZE),
>>>>> +    ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>>>>>                  "range is not softdirty\n");
>>>>>
>>>>>         /* Populating READ should set softdirty. */
>>>>>         ret = madvise(addr, SIZE, MADV_POPULATE_READ);
>>>>> -    ksft_test_result(!ret, "MADV_POPULATE_READ\n");
>>>>> -    ksft_test_result(range_is_not_softdirty(addr, SIZE),
>>>>> +    ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_READ\n");
>>>>> +    ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>>>>>                  "range is not softdirty\n");
>>>>>
>>>>>         /* Populating WRITE should set softdirty. */
>>>>>         ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
>>>>> -    ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
>>>>> -    ksft_test_result(range_is_softdirty(addr, SIZE),
>>>>> +    ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_WRITE\n");
>>>>> +    ksft_test_result_if_softdirty(range_is_softdirty(addr, SIZE),
>>>>>                  "range is softdirty\n");
>>>>
>>>> We probably want to skip the whole test_*softdirty* test instead of adding this
>>>> (IMHO suboptimal) ksft_test_result_if_softdirty.
>>>
>>> Yeah I thought about doing it that way, but then the output just looks like
>>> there were fewer tests and they all passed. But thinking about it now, I guess
>>> the TAP header outputs the number of planned tests and the number of tests
>>> executed are fewer, so a machine parser would still notice. I just don't like
>>> that it outputs skipped:0.
>>>
>>> But it a lightly held view. Happy to just do:
>>>
>>>      if (system_has_softdirty())
>>>          test_softdirty()
>>>
>>> If you insist. ;-)
>>
>> diff --git a/tools/testing/selftests/mm/madv_populate.c
>> b/tools/testing/selftests/mm/madv_populate.c
>> index 60547245e479..33fda0337b32 100644
>> --- a/tools/testing/selftests/mm/madv_populate.c
>> +++ b/tools/testing/selftests/mm/madv_populate.c
>> @@ -266,12 +266,16 @@ static void test_softdirty(void)
>>   
>>   int main(int argc, char **argv)
>>   {
>> +       int nr_tests = 16;
>>          int err;
>>   
>>          pagesize = getpagesize();
>>   
>> +       if (system_has_softdirty())
>> +               nr_tests += 5;
> 
> This is the opposite of the point I was trying to make; If there are 21 tests in
> a suite, I'd like to know that there are 21 tests, 16 of which passed and 5 of
> which were skipped. This will hide the 5 from the test report.

Well, these test are impossible on that architecture, which is IMHO 
different to some kind of "impossible in the configuration" like "no 
swap", "no hugetlb", "no THP available".

-- 
Cheers,

David / dhildenb

