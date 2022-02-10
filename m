Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1F4B1164
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbiBJPIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 10:08:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiBJPIq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 10:08:46 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB89BF
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 07:08:44 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s18so7603940ioa.12
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 07:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hp7QvZlzzROYEH5efuLIQi3BV5UCPx6fV4t5giE2B0o=;
        b=eWMjiv3DIgoG+N319e9OUDVFWv3MK5uB+VgCQTlN12e4mXc7WeyBQcF06s568P/rQA
         8uw/HPq2j3DMLGqxHhvR5dALW4Ralubr6nG0CgpSSJFFdsP26xkYzc8qJn6DXXISwztz
         b4zAguaGaFg1RQXJMmCzyBQIzYb9jhjOKV6js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hp7QvZlzzROYEH5efuLIQi3BV5UCPx6fV4t5giE2B0o=;
        b=AxLI5A7099GW6CuR3JhWVBg9XV0/Lv1woWGkmw12AGL7lFI9XWBz4xGkUXrBa7f7yn
         9e0OHKiFrB0O3FqCn8FHY9qzZpyFubX3awpDAw6UeT22w4RKGpQeOjthRl/p3J8epYgl
         UNcpQTW2Vd3IkeuJ6SpWaSuz7Yg334wfskS8RtCdPCnzlK/LNntKD0wK1ipgBL0uk7b3
         upjdzweJH2K/xCQNykB/yN+nGQ6JfjXTtWdZLnHBLb6+G793c2RwoHao9kNP5h5QSEUk
         8xpNus/Yea4E5uWrHsxJ8j8RW6mfLUoDjWTLoRaPetXcYl7/A60LfoQB9H3MRudCpODW
         xGzg==
X-Gm-Message-State: AOAM531WI0ailX3zro404oZiWjoVtyYHdp4nM5cnr2s0p7rVSfe4uN1c
        4iKHpuVKJdBgNa0sgFq3iDgLQTnWDlBz0A==
X-Google-Smtp-Source: ABdhPJwYK2ZTmK1mhm9ma5UmVH97aL8K2bUMDn8CEL5pw4CYaefr1l1mSN35amtlhqC5HZ+cT5n2ng==
X-Received: by 2002:a05:6602:492:: with SMTP id y18mr3922007iov.95.1644505723189;
        Thu, 10 Feb 2022 07:08:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id v4sm8269910ilc.21.2022.02.10.07.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:08:42 -0800 (PST)
Subject: Re: [PATCH] selftest/vm: Use correct PAGE_SHIFT value for ppc64
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
References: <20220209154301.42024-1-aneesh.kumar@linux.ibm.com>
 <84508bb4-9400-f429-e6d2-d8b05a1e8368@linuxfoundation.org>
 <87zgmz9x7e.fsf@linux.ibm.com>
 <eed2c443-21b0-3c0e-6571-551460fdf303@linuxfoundation.org>
 <d2c3d33a-9e4b-1efc-b956-66bbf9a6bac5@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6e8a74f-1c20-16da-2872-704df0bd4af1@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 08:08:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d2c3d33a-9e4b-1efc-b956-66bbf9a6bac5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 8:03 AM, Aneesh Kumar K V wrote:
> On 2/10/22 20:09, Shuah Khan wrote:
>> On 2/9/22 9:12 PM, Aneesh Kumar K.V wrote:
>>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>>
>>>> On 2/9/22 8:43 AM, Aneesh Kumar K.V wrote:
>>>>> Keep it simple by using a #define and limiting hugepage size to 2M.
>>>>> This keeps the test simpler instead of dynamically finding the page size
>>>>> and huge page size.
>>>>>
>>>>> Without this tests are broken w.r.t reading /proc/self/pagemap
>>>>>
>>>>>     if (pread(pagemap_fd, ent, sizeof(ent),
>>>>>             (uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
>>>>>         err(2, "read pagemap");
>>>>>
>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> ---
>>>>>    tools/testing/selftests/vm/ksm_tests.c        | 8 ++++++++
>>>>>    tools/testing/selftests/vm/transhuge-stress.c | 8 ++++++++
>>>>>    2 files changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
>>>>> index 1436e1a9a3d3..8200328ff018 100644
>>>>> --- a/tools/testing/selftests/vm/ksm_tests.c
>>>>> +++ b/tools/testing/selftests/vm/ksm_tests.c
>>>>> @@ -22,8 +22,16 @@
>>>>>    #define KSM_MERGE_ACROSS_NODES_DEFAULT true
>>>>>    #define MB (1ul << 20)
>>>>> +#ifdef __powerpc64__
>>>>> +#define PAGE_SHIFT    16
>>>>> +/*
>>>>> + * This will only work with radix 2M hugepage size
>>>>> + */
>>>>> +#define HPAGE_SHIFT 21
>>>>> +#else
>>>>>    #define PAGE_SHIFT 12
>>>>>    #define HPAGE_SHIFT 21
>>>>> +#endif
>>>>>    #define PAGE_SIZE (1 << PAGE_SHIFT)
>>>>>    #define HPAGE_SIZE (1 << HPAGE_SHIFT)
>>>>> diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
>>>>> index 5e4c036f6ad3..f04c8aa4bcf6 100644
>>>>> --- a/tools/testing/selftests/vm/transhuge-stress.c
>>>>> +++ b/tools/testing/selftests/vm/transhuge-stress.c
>>>>> @@ -16,8 +16,16 @@
>>>>>    #include <string.h>
>>>>>    #include <sys/mman.h>
>>>>> +#ifdef __powerpc64__
>>>>> +#define PAGE_SHIFT    16
>>>>> +/*
>>>>> + * This will only work with radix 2M hugepage size
>>>>> + */
>>>>> +#define HPAGE_SHIFT 21
>>>>
>>>> Why not have this is in common code?
>>>
>>> Can you suggest where I can move that. We also have helper functions
>>> like allocate_transhuge() duplicated between tests. I didn't find
>>> libutil.a or anything similar supported by the selftets build.
>>>
>>>>
>>
>> I noticed that HPAGE_SHIFT is defined in #ifdef __powerpc64__ block
>> as well as #else. I am asking is it necessary to be part of both
>> blocks.
>>
>> +#ifdef __powerpc64__
>> +#define PAGE_SHIFT    16
>> +/*
>> + * This will only work with radix 2M hugepage size
>> + */
>> +#define HPAGE_SHIFT 21  --- this one
>> +#else
>>    #define PAGE_SHIFT 12
>>    #define HPAGE_SHIFT 21   --- this one
>> +#endif
>>
> 
> 
> The reason I did that was to add the comment which is relevant only for ppc64. ppc64 supports two hugepage sizes, 2M and 16M. The test won't work correctly with 16M hugepage size. We do have other tests in selftest/vm/ with similar restrictions.
> 
> 

Right. You don't have to duplicate code for the comment. You can add the
comment and then clarify in the comment that it is only relevant to ppc64.

This way the comment is clear and we can avoid duplicate code that makes it
hard to maintain in the future.

thanks,
-- Shuah

