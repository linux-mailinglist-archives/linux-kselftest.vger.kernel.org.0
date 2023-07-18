Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390F2757A5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGRLY1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 07:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjGRLYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 07:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA030D8
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689679420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E25e9dvQIenP2167tOlvP3NdJMvW6/ZDuSZb/NoTrxg=;
        b=bM/TNRGC6ZNF+H/NKLH7/qBFAomXtYtgN0I9hc8S2oBq+t+SuOgSG04wBv7uUnqpjthJFs
        9Jl2yoFn2JauAK98psAOstJpM0ijCOxtTeCclwK6GMD+fiXAQ0zMFjrALYtJ9c95G2PuRq
        aYIXVeJ3/Kh206Hy6S7AXIHS0JddYvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-johJ48YvMJq5umQybh56Iw-1; Tue, 18 Jul 2023 07:23:38 -0400
X-MC-Unique: johJ48YvMJq5umQybh56Iw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3faabd8fd33so29798445e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 04:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689679417; x=1692271417;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E25e9dvQIenP2167tOlvP3NdJMvW6/ZDuSZb/NoTrxg=;
        b=Ij4ZijkxQBYzJ8X4Vmkeny/udABw3AvbyG5wmPzu0Nj2eLNiiR//7qF/trwIPb4IK6
         rAFNgDtrJzxFz9A7hc3vHlN8QYCLlO8viuMEu41Nlc3vpVrAgmPEgDcBsD+4itrLw3IL
         Rqj3IZbhDKJYzUlzyfjoxeRnGx7I90fHqhORYWMxVlob5eOzpqD3CwfhuiTK6LV2sQS8
         4hmgqy6AzTwJWMoOy3cXtLU0I/5HjMKzuWOsORzjgSMv/JxRyb60jjz8FlLfadIkrX9P
         eipnBJeYn5mAX9Zc7lx8ZIKGiN8VyApZ9bC//7c1NjMbx4B6Tx6m6idzK5mdQmJ4NZBn
         wnQA==
X-Gm-Message-State: ABy/qLZz8OLXWCJrqea2MJ72aQTMW7DfU4+LHcFqOqec9cAp9pjog8ah
        8RcOJAcHMfiX0le18FxD1cb3/9yspFoSvkstsvXUCrRMbwqWz/7qdAPyFi74cj7BvoXUHdyo+Xl
        iyfaffCwZTmPlJUYD0ZkyQnyUCDdW
X-Received: by 2002:a1c:750a:0:b0:3fb:f926:4937 with SMTP id o10-20020a1c750a000000b003fbf9264937mr1554391wmc.31.1689679417731;
        Tue, 18 Jul 2023 04:23:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcfZuXNRThSAK3VX4YePcYyb17v2vQFJ2pWXoCB5RExjoYRAh4jCIM+f39eOI/dJI2PCAPGg==
X-Received: by 2002:a1c:750a:0:b0:3fb:f926:4937 with SMTP id o10-20020a1c750a000000b003fbf9264937mr1554376wmc.31.1689679417344;
        Tue, 18 Jul 2023 04:23:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:6200:84e1:eabc:8e2:7429? (p200300cbc740620084e1eabc08e27429.dip0.t-ipconnect.de. [2003:cb:c740:6200:84e1:eabc:8e2:7429])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c379200b003fa973e6612sm9994481wmr.44.2023.07.18.04.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:23:36 -0700 (PDT)
Message-ID: <1314fe0e-dd32-bf10-0a33-2b571dad70bd@redhat.com>
Date:   Tue, 18 Jul 2023 13:23:36 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 6/8] selftests/mm: Make migration test robust to
 failure
In-Reply-To: <2e5baba4-c8ef-9da4-a2d6-3cf383ed05bd@arm.com>
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

On 18.07.23 12:49, Ryan Roberts wrote:
> On 17/07/2023 18:40, David Hildenbrand wrote:
>> On 17.07.23 12:31, Ryan Roberts wrote:
>>> The `migration` test currently has a number of robustness problems that
>>> cause it to hang and leak resources.
>>>
>>> Timeout: There are 3 tests, which each previously ran for 60 seconds.
>>> However, the timeout in mm/settings for a single test binary was set to
>>> 45 seconds. So when run using run_kselftest.sh, the top level timeout
>>> would trigger before the test binary was finished. Solve this by meeting
>>> in the middle; each of the 3 tests now runs for 20 seconds (for a total
>>> of 60), and the top level timeout is set to 90 seconds.
>>>
>>> Leaking child processes: the `shared_anon` test fork()s some children
>>> but then an ASSERT() fires before the test kills those children. The
>>> assert causes immediate exit of the parent and leaking of the children.
>>> Furthermore, if run using the run_kselftest.sh wrapper, the wrapper
>>> would get stuck waiting for those children to exit, which never happens.
>>> Solve this by deferring any asserts until after the children are killed.
>>> The same pattern is used for the threaded tests for uniformity.
>>>
>>> With these changes, the test binary now runs to completion on arm64,
>>> with 2 tests passing and the `shared_anon` test failing.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    tools/testing/selftests/mm/migration.c | 14 ++++++++++----
>>>    tools/testing/selftests/mm/settings    |  2 +-
>>>    2 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/migration.c
>>> b/tools/testing/selftests/mm/migration.c
>>> index 379581567f27..189d7d9070e8 100644
>>> --- a/tools/testing/selftests/mm/migration.c
>>> +++ b/tools/testing/selftests/mm/migration.c
>>> @@ -15,7 +15,7 @@
>>>    #include <time.h>
>>>      #define TWOMEG (2<<20)
>>> -#define RUNTIME (60)
>>> +#define RUNTIME (20)
>>>      #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>>>    @@ -118,6 +118,7 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>>    {
>>>        uint64_t *ptr;
>>>        int i;
>>> +    int ret;
>>>          if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>>            SKIP(return, "Not enough threads or NUMA nodes available");
>>> @@ -131,9 +132,10 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>>>            if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
>>>                perror("Couldn't create thread");
>>>    -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>>> +    ret = migrate(ptr, self->n1, self->n2);
>>>        for (i = 0; i < self->nthreads - 1; i++)
>>>            ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
>>> +    ASSERT_EQ(ret, 0);
>>
>> Why is that required? This does not involve fork.
> 
> It's not required. I was just trying to keep everything aligned to the same pattern.
> 
>>
>>>    }
>>>      /*
>>> @@ -144,6 +146,7 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>>        pid_t pid;
>>>        uint64_t *ptr;
>>>        int i;
>>> +    int ret;
>>>          if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>>>            SKIP(return, "Not enough threads or NUMA nodes available");
>>> @@ -161,9 +164,10 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>>>                self->pids[i] = pid;
>>>        }
>>>    -    ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
>>> +    ret = migrate(ptr, self->n1, self->n2);
>>>        for (i = 0; i < self->nthreads - 1; i++)
>>>            ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
>>> +    ASSERT_EQ(ret, 0);
>>
>>
>> Might be cleaner to also:
> 
> Or instead of? I agree this is neater, so will undo the moving of the ASSERT()
> and rely on this prctl.

I was thinking about possible races when our parent process already 
quits before our child managed to set the prctl. prctl() won't do 
anything in that case, hmmmm.

But similarly, existing code might already trigger the migrate() + kill 
before the child processes even started to access_mem().

Racy :)

-- 
Cheers,

David / dhildenb

