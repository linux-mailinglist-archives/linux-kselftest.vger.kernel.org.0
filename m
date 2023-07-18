Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C407580D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjGRPZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjGRPZI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 11:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEB392
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689693850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHlHwKpoA0bi1nyvFXl3JPkte3c23L/WObN+n1+gtHA=;
        b=h8Grm7+Ysm1PFuwUkA+nxcSt9V94v5EqgdZUib7uTIgtnOog1xUIEcT2Bws0WAArfdOpSd
        cNZRSfzkZ8xRQDQPUlxl1zIC4by9hqfY1c7+UmoI8r8yds6lycnN0zcfs4y5Zww6hO5YCb
        J/3s17/hOmZ/99WxU82lt12ViGyIaGw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-iLDDpCx1PqeXRivaZZByrw-1; Tue, 18 Jul 2023 11:24:07 -0400
X-MC-Unique: iLDDpCx1PqeXRivaZZByrw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc0627eafbso26279905e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 08:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693846; x=1692285846;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHlHwKpoA0bi1nyvFXl3JPkte3c23L/WObN+n1+gtHA=;
        b=VUgbK7c5ycLTkuOwT5E5nx9RE2Y7HuDP3ZBvQqYAqipBgUuWP08Kx/nrzqJ8oVdli5
         38Cqrv+9wGvXoaJSl1gASU2KxUEs/5rtc+xi8ksABOXxgGCE6+suGhDFDZG9C5PmqP++
         BmvpH2sMqvTVjeqEGF/2b892VUsdd399oFwBr0acSAKxtRB8eZ6oZZ5gHJR5elRGubDf
         lhlMyoOvJn1B5tF9VvPsOFaAYUOapCrs52McsYuXqEcO2MiFPv+jB0mjhoDLE8hMMGPn
         4DAl9pwlTAYs5AYeR+lvyfDyIfyjh8jjaHwQ7FWzfZQzptef5fIRQ08WwtkIc7z5UIVB
         zyfw==
X-Gm-Message-State: ABy/qLYsOU5dJeVGWKy1FWMkRMPwBQn+zibUDviX54vZ1iPmryX6K3i0
        9oIyt2JiZy6yl8DPd7gVHYEe93LrMwGDOgiIa4i4QvhwW3olbSm5rhB4kyTGlvtDwEfq9v5NAEC
        ikPgCkdBHW43ky0S22Gy+ZdxgknV7
X-Received: by 2002:a05:600c:3ac6:b0:3fa:8c8b:716 with SMTP id d6-20020a05600c3ac600b003fa8c8b0716mr2305408wms.1.1689693845846;
        Tue, 18 Jul 2023 08:24:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFaI7LXpL6rcOJvQX9zLaYidgPaCoCUU3cJIXb0c7WgeTD+VlcmNLJ8Q7eYsOeTfcrz8/0FSw==
X-Received: by 2002:a05:600c:3ac6:b0:3fa:8c8b:716 with SMTP id d6-20020a05600c3ac600b003fa8c8b0716mr2305379wms.1.1689693845445;
        Tue, 18 Jul 2023 08:24:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:6200:84e1:eabc:8e2:7429? (p200300cbc740620084e1eabc08e27429.dip0.t-ipconnect.de. [2003:cb:c740:6200:84e1:eabc:8e2:7429])
        by smtp.gmail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm10735127wml.18.2023.07.18.08.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 08:24:04 -0700 (PDT)
Message-ID: <5cee5039-b641-82f6-547f-12d94057d0ad@redhat.com>
Date:   Tue, 18 Jul 2023 17:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
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
 <90a8b224-4566-5051-4903-f9ab83b26150@redhat.com>
 <cb2f093e-8312-0147-272d-e6f148f383da@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 6/8] selftests/mm: Make migration test robust to
 failure
In-Reply-To: <cb2f093e-8312-0147-272d-e6f148f383da@arm.com>
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

On 18.07.23 14:42, Ryan Roberts wrote:
> On 18/07/2023 12:24, David Hildenbrand wrote:
>> On 18.07.23 13:23, David Hildenbrand wrote:
>>> On 18.07.23 12:49, Ryan Roberts wrote:
>>>> On 17/07/2023 18:40, David Hildenbrand wrote:
>>>>> On 17.07.23 12:31, Ryan Roberts wrote:
>>>>>> The `migration` test currently has a number of robustness problems that
>>>>>> cause it to hang and leak resources.
>>>>>>
>>>>>> Timeout: There are 3 tests, which each previously ran for 60 seconds.
>>>>>> However, the timeout in mm/settings for a single test binary was set to
>>>>>> 45 seconds. So when run using run_kselftest.sh, the top level timeout
>>>>>> would trigger before the test binary was finished. Solve this by meeting
>>>>>> in the middle; each of the 3 tests now runs for 20 seconds (for a total
>>>>>> of 60), and the top level timeout is set to 90 seconds.
>>>>>>
>>>>>> Leaking child processes: the `shared_anon` test fork()s some children
>>>>>> but then an ASSERT() fires before the test kills those children. The
>>>>>> assert causes immediate exit of the parent and leaking of the children.
>>>>>> Furthermore, if run using the run_kselftest.sh wrapper, the wrapper
>>>>>> would get stuck waiting for those children to exit, which never happens.
>>>>>> Solve this by deferring any asserts until after the children are killed.
>>>>>> The same pattern is used for the threaded tests for uniformity.
>>>>>>
>>>>>> With these changes, the test binary now runs to completion on arm64,
>>>>>> with 2 tests passing and the `shared_anon` test failing.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>      tools/testing/selftests/mm/migration.c | 14 ++++++++++----
>>>>>>      tools/testing/selftests/mm/settings    |  2 +-
>>>>>>      2 files changed, 11 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/mm/migration.c
>>>>>> b/tools/testing/selftests/mm/migration.c
>>>>>> index 379581567f27..189d7d9070e8 100644
>>>>>> --- a/tools/testing/selftests/mm/migration.c
>>>>>> +++ b/tools/testing/selftests/mm/migration.c
>>>>>> @@ -15,7 +15,7 @@
>>>>>>      #include <time.h>
>>>>>>        #define TWOMEG (2<<20)
>>>>>> -#define RUNTIME (60)
>>>>>> +#define RUNTIME (20)
>>>>>>        #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>>>>>>      @@ -118,6 +118,7 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>>>>>      {
>>>>>>          uint64_t *ptr;
>>>>>>          int i;
>>>>>> +    int ret;
>>>>>>            if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>>>>>              SKIP(return, "Not enough threads or NUMA nodes available");
>>>>>> @@ -131,9 +132,10 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>>>>>              if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
>>>>>>                  perror("Couldn't create thread");
>>>>>>      -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>>>>>> +    ret = migrate(ptr, self->n1, self->n2);
>>>>>>          for (i = 0; i < self->nthreads - 1; i++)
>>>>>>              ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
>>>>>> +    ASSERT_EQ(ret, 0);
>>>>>
>>>>> Why is that required? This does not involve fork.
>>>>
>>>> It's not required. I was just trying to keep everything aligned to the same
>>>> pattern.
>>>>
>>>>>
>>>>>>      }
>>>>>>        /*
>>>>>> @@ -144,6 +146,7 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>>>>>          pid_t pid;
>>>>>>          uint64_t *ptr;
>>>>>>          int i;
>>>>>> +    int ret;
>>>>>>            if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>>>>>              SKIP(return, "Not enough threads or NUMA nodes available");
>>>>>> @@ -161,9 +164,10 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>>>>>                  self->pids[i] = pid;
>>>>>>          }
>>>>>>      -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>>>>>> +    ret = migrate(ptr, self->n1, self->n2);
>>>>>>          for (i = 0; i < self->nthreads - 1; i++)
>>>>>>              ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
>>>>>> +    ASSERT_EQ(ret, 0);
>>>>>
>>>>>
>>>>> Might be cleaner to also:
>>>>
>>>> Or instead of? I agree this is neater, so will undo the moving of the ASSERT()
>>>> and rely on this prctl.
>>>
>>> I was thinking about possible races when our parent process already
>>> quits before our child managed to set the prctl. prctl() won't do
>>> anything in that case, hmmmm.
>>>
>>> But similarly, existing code might already trigger the migrate() + kill
>>> before the child processes even started to access_mem().
>>>
>>> Racy :)
>>>
>>
>> Maybe what would work, is checking after the prctl() in the child if the parent
>> is already gone.
> 
> 
> Like this?
> 
> 	if (!pid) {
> 		prctl(PR_SET_PDEATHSIG, SIGHUP);
> 		/* Parent may have died before prctl so check now. */
> 		if (getppid() == 1)
> 			kill(getpid(), SIGHUP);
> 		access_mem(ptr);
> 	}

Staring at forget_original_parent(), that order should work.

I do wonder if there is a nicer way to handle that, but maybe that 
already is the "nice" way.

-- 
Cheers,

David / dhildenb

