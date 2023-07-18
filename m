Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786A9757A67
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 13:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGRLZh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 07:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRLZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 07:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D9B1701
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689679496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uvmITmSWq5XdrG3a/DkmnJG1vY8QF6IRECe80ErATc=;
        b=FzyI/qy4PHPNTH1kVbgd4dWYRKOHUh7hEgmZ7FDp3Ku2tusEwYsabUlCnK+cSNdHrJLWg4
        bo6BYgWImGX/DgO0fAhO2pyKFENJWRbpvXzoCapVKL3emhO6YcPYq3wNOavkfB1eUhawzf
        y88HkY2etwk1X3gmzXzQOM19F9g1K6o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-LGfk1Tv0PfWeXJi6uITf7g-1; Tue, 18 Jul 2023 07:24:55 -0400
X-MC-Unique: LGfk1Tv0PfWeXJi6uITf7g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314256aedcbso3117610f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 04:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689679494; x=1692271494;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uvmITmSWq5XdrG3a/DkmnJG1vY8QF6IRECe80ErATc=;
        b=Heu8XCxkfuB6BO7XtTOWJf+yWRaIedxrFmXLOrKMdhs8Bitq0DV0/950aHIES/FxAK
         0psOYXXLE6T/8gMRZPvrOoLRTnKClF+wRotZvTxiOdyvkV83iESll5GDzXp8y73vUBKm
         1Drptt7ek18haVekidqxaDXkik7L9/KeYeH34Po8MTfBPL9HvHYTkkSgGry2V5cskWZt
         d+XngRdANFZy0hEZ3OIy/1/Y7oeA1U/fYS3y6Y0HQaANz5Y6Zx9XXjWxso4njcAzRz1P
         4EcNB0L7KRHpehl4CcARFu4W+VEkO3tOWYaWI63VrSxXmIVtzNjjUCdu9d235LIhdZr6
         eQbA==
X-Gm-Message-State: ABy/qLbE132xioDpuY2c3Vm4q8O+PD8KRO/gmS9qydZZI+7wJPEjiIzP
        zBWlvk+liWOT/BdFXaYHHFjW4nmVdvjktav/j10ckzC4l08i8jI5JyqJV5vvzbITSYGQE3qRskr
        0XlUUuTxuLiO39NZuIOM5FEPd3WBVvbJlIfxz
X-Received: by 2002:a5d:6603:0:b0:313:ee2e:dae1 with SMTP id n3-20020a5d6603000000b00313ee2edae1mr11776894wru.18.1689679493869;
        Tue, 18 Jul 2023 04:24:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHg7VIZgLtfc+4zjH3bLdSY+veUxJSqkHQDeMhRBUXaInjZYiNoZtklKOQkBINC56GiIEyvYw==
X-Received: by 2002:a5d:6603:0:b0:313:ee2e:dae1 with SMTP id n3-20020a5d6603000000b00313ee2edae1mr11776882wru.18.1689679493465;
        Tue, 18 Jul 2023 04:24:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:6200:84e1:eabc:8e2:7429? (p200300cbc740620084e1eabc08e27429.dip0.t-ipconnect.de. [2003:cb:c740:6200:84e1:eabc:8e2:7429])
        by smtp.gmail.com with ESMTPSA id n13-20020adff08d000000b0031433443265sm2136504wro.53.2023.07.18.04.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:24:52 -0700 (PDT)
Message-ID: <90a8b224-4566-5051-4903-f9ab83b26150@redhat.com>
Date:   Tue, 18 Jul 2023 13:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 6/8] selftests/mm: Make migration test robust to
 failure
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-7-ryan.roberts@arm.com>
 <20501a7c-19f6-4154-aebc-49df04c9b043@redhat.com>
 <2e5baba4-c8ef-9da4-a2d6-3cf383ed05bd@arm.com>
 <1314fe0e-dd32-bf10-0a33-2b571dad70bd@redhat.com>
Organization: Red Hat
In-Reply-To: <1314fe0e-dd32-bf10-0a33-2b571dad70bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18.07.23 13:23, David Hildenbrand wrote:
> On 18.07.23 12:49, Ryan Roberts wrote:
>> On 17/07/2023 18:40, David Hildenbrand wrote:
>>> On 17.07.23 12:31, Ryan Roberts wrote:
>>>> The `migration` test currently has a number of robustness problems that
>>>> cause it to hang and leak resources.
>>>>
>>>> Timeout: There are 3 tests, which each previously ran for 60 seconds.
>>>> However, the timeout in mm/settings for a single test binary was set to
>>>> 45 seconds. So when run using run_kselftest.sh, the top level timeout
>>>> would trigger before the test binary was finished. Solve this by meeting
>>>> in the middle; each of the 3 tests now runs for 20 seconds (for a total
>>>> of 60), and the top level timeout is set to 90 seconds.
>>>>
>>>> Leaking child processes: the `shared_anon` test fork()s some children
>>>> but then an ASSERT() fires before the test kills those children. The
>>>> assert causes immediate exit of the parent and leaking of the children.
>>>> Furthermore, if run using the run_kselftest.sh wrapper, the wrapper
>>>> would get stuck waiting for those children to exit, which never happens.
>>>> Solve this by deferring any asserts until after the children are killed.
>>>> The same pattern is used for the threaded tests for uniformity.
>>>>
>>>> With these changes, the test binary now runs to completion on arm64,
>>>> with 2 tests passing and the `shared_anon` test failing.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>     tools/testing/selftests/mm/migration.c | 14 ++++++++++----
>>>>     tools/testing/selftests/mm/settings    |  2 +-
>>>>     2 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/migration.c
>>>> b/tools/testing/selftests/mm/migration.c
>>>> index 379581567f27..189d7d9070e8 100644
>>>> --- a/tools/testing/selftests/mm/migration.c
>>>> +++ b/tools/testing/selftests/mm/migration.c
>>>> @@ -15,7 +15,7 @@
>>>>     #include <time.h>
>>>>       #define TWOMEG (2<<20)
>>>> -#define RUNTIME (60)
>>>> +#define RUNTIME (20)
>>>>       #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>>>>     @@ -118,6 +118,7 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>>>     {
>>>>         uint64_t *ptr;
>>>>         int i;
>>>> +    int ret;
>>>>           if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>>>             SKIP(return, "Not enough threads or NUMA nodes available");
>>>> @@ -131,9 +132,10 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>>>             if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
>>>>                 perror("Couldn't create thread");
>>>>     -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>>>> +    ret = migrate(ptr, self->n1, self->n2);
>>>>         for (i = 0; i < self->nthreads - 1; i++)
>>>>             ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
>>>> +    ASSERT_EQ(ret, 0);
>>>
>>> Why is that required? This does not involve fork.
>>
>> It's not required. I was just trying to keep everything aligned to the same pattern.
>>
>>>
>>>>     }
>>>>       /*
>>>> @@ -144,6 +146,7 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>>>         pid_t pid;
>>>>         uint64_t *ptr;
>>>>         int i;
>>>> +    int ret;
>>>>           if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>>>             SKIP(return, "Not enough threads or NUMA nodes available");
>>>> @@ -161,9 +164,10 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>>>                 self->pids[i] = pid;
>>>>         }
>>>>     -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>>>> +    ret = migrate(ptr, self->n1, self->n2);
>>>>         for (i = 0; i < self->nthreads - 1; i++)
>>>>             ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
>>>> +    ASSERT_EQ(ret, 0);
>>>
>>>
>>> Might be cleaner to also:
>>
>> Or instead of? I agree this is neater, so will undo the moving of the ASSERT()
>> and rely on this prctl.
> 
> I was thinking about possible races when our parent process already
> quits before our child managed to set the prctl. prctl() won't do
> anything in that case, hmmmm.
> 
> But similarly, existing code might already trigger the migrate() + kill
> before the child processes even started to access_mem().
> 
> Racy :)
> 

Maybe what would work, is checking after the prctl() in the child if the 
parent is already gone.

-- 
Cheers,

David / dhildenb

