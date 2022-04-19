Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75BC5072EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354581AbiDSQYh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354555AbiDSQYf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 12:24:35 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C939691
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 09:21:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e189so18655253oia.8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p2epm3ggiLebFuCe5K1Ff3vTQYYQk5e79Z+aoVpOO8c=;
        b=K5l5cdzTlkLERj2yYONu1tJVvYdG+sLFQVzP93XZDitHEplZYpPnEcxQOHejajdl2h
         iFtoGwzy5AVV08oKBsEQBNjtWWuoAs6Yg53E0t/UPJfwi2DhebcaAbPR7ExCSotRBM7W
         ZYnLRWZaOmVbDuGxbRLhh2ikFTaiwe8qz3hrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2epm3ggiLebFuCe5K1Ff3vTQYYQk5e79Z+aoVpOO8c=;
        b=r7uS8RdUlCoZtxn7OlGrC9TtwZelwwmo6MFe5AiRiDCZayZiNNoxN2ss3Oymgkv7Ao
         SoUFFVj688fCTMfVGi/dnt/+3RjTQ4zeJE1raL2xybauHENEYLHU7MwLFDqWNBlzS8W5
         f67fS3orLmB5uJMWdR2LPIXUx3wsjzIc3kLOCjzT3BtL7A80+lFtiTRljbHPIC1HY4Df
         /KEXYjdqnan10ApjK2wyaKl47FsyIIH7o761Smm+oSO6rdOLXj17eUkxOdgw7fv8MtMA
         e7DHefToTEi5Ir3dCfTxHzXnay6dPoBuz2Qn0pBHFOsEgm3gcndltzBmsezq8B76itoA
         ruIA==
X-Gm-Message-State: AOAM531Gq4tvxMlbRPUYTzwuedzANvAl4PMclzT17l8JTfcjJQIeFjvI
        tBu058NEdK7kvW7IYzxkhZlzLdMcqXgZsg==
X-Google-Smtp-Source: ABdhPJz5UABEfyTQPKsXaQtN5IE89LP+Ydx+2cHyTVuIZKVTLQxS6mdEu/bRG49gSlWxHy1/sCrJAQ==
X-Received: by 2002:a05:6808:2085:b0:322:b167:77f9 with SMTP id s5-20020a056808208500b00322b16777f9mr2986961oiw.152.1650385311996;
        Tue, 19 Apr 2022 09:21:51 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm5617178oos.22.2022.04.19.09.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 09:21:51 -0700 (PDT)
Subject: Re: [PATCH 2/4] selftest/vm: verify remap destination address in
 mremap_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
 <20220414171529.62058-3-sidhartha.kumar@oracle.com>
 <e6cc5cf6-b6bc-2eca-255d-5dd247253255@linuxfoundation.org>
 <7b1c0a82-f7c3-4f60-ccb3-893caf4221f9@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3a062d04-b35c-868a-cd94-5d57fef68813@linuxfoundation.org>
Date:   Tue, 19 Apr 2022 10:21:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7b1c0a82-f7c3-4f60-ccb3-893caf4221f9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/22 4:24 PM, Sidhartha Kumar wrote:
> 
> 
> On 4/14/22 2:47 PM, Shuah Khan wrote:
>> On 4/14/22 11:15 AM, Sidhartha Kumar wrote:
>>> Because mremap does not have a NOREPLACE flag,
>>> it can destroy existing mappings. This can
>>> cause a segfault if regions such as text are
>>> destroyed.
>>
>> Please explain the reason for segfault.
>>
> With the MREMAP_FIXED flag used by the test,
> the text region, which fell in the range of the remap
> region, got unmapped. This caused a segfault when
> trying to fetch the next instruction after the mremap()
> call.
>> Add a blank line here. Makes it easier to read.
>>
>> Verify the requested mremap destination
>>> address does not overlap any existing mappings
>>> by using mmap's FIXED_NOREPLACE flag and checking
>>
>> Spell this out fully - MAP_FIXED_NOREPLACE
>>> for the EEXIST error code. Keep incrementing the
>>> destination address until a valid mapping is found
>>> or max address is reached.
>>>
>>
>> Essentially mremap() doesn't check for overlaps and removes
>> or overwrites existing mappings? The way you are fixing it
>> is by verifying by calling mremap() with MAP_FIXED_NOREPLACE
>> flag and check for EEXIST.
>>
> Yes, with the MREMAP_FIXED flag that the test uses, any previous
> mapping in the address range of the remap region gets unmapped.
> Yes, fixing this issue by calling mmap() with MAP_FIXED_NOREPLACE
> flag and checking for EEXIST.
> 
>> What happens when max address is reached?
>>
> That is covered by the check if (addr > ULLONG_MAX - region size)
> in the remap_region_valid() function.
>> Same comment on # of chars per line in commit log. Also
>>
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> ---
>>>   tools/testing/selftests/vm/mremap_test.c | 36 ++++++++++++++++++++++++
>>>   1 file changed, 36 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
>>> index 58600fee4b81..98e9cff34aa7 100644
>>> --- a/tools/testing/selftests/vm/mremap_test.c
>>> +++ b/tools/testing/selftests/vm/mremap_test.c
>>> @@ -10,6 +10,7 @@
>>>   #include <string.h>
>>>   #include <sys/mman.h>
>>>   #include <time.h>
>>> +#include <limits.h>
>>>     #include "../kselftest.h"
>>>   @@ -65,6 +66,34 @@ enum {
>>>       .expect_failure = should_fail                \
>>>   }
>>>   +/*
>>> + * Returns 0 if the requested remap region overlaps with an
>>> + * existing mapping (e.g text, stack) else returns 1.
>>> + */
>>> +static int remap_region_valid(void *addr, unsigned long long size)
>>
>> This returns bool 0 (false) 1 (true)
>>
>> Please name the routine - is_remap_region_valid() and change it to
>> return bool.
>>
>>> +{
>>> +    void *remap_addr = NULL;
>>> +    int ret = 1;
>>> +
>>> +    if ((unsigned long long) addr > ULLONG_MAX - size) {
>>> +        ksft_print_msg("Can't find a valid region to remap to\n");
>>
>> Change it to "Couldn't" - also this message doesn't look right. We hav't
>> looked for valid region yet and it just exceeds the limits?
>>
> Because this function is called in a loop in remap_region() and addr is being
> incremented continuously, we could enter this function with addr high enough that
> another increment would cause overflow.
>>

What this means is we could see lots of these messages that just say
"Can't find" without any other information such as the "addr"?

We probably don't want this message printed in a loop and print from
caller after the while loop ends without finding valid mapping.

>>> +        exit(KSFT_SKIP);> +    }
>>> +
>>> +    /* Use MAP_FIXED_NOREPLACE flag to ensure region is not mapped */
>>> +    remap_addr = mmap(addr, size, PROT_READ | PROT_WRITE,
>>> +            MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
>>> +            -1, 0);
>>
>> Alignment should match open parenthesis here and in other places. Makes it
>> easier to read the code.
>>
>>> +    if (remap_addr == MAP_FAILED) {
>>> +        if (errno == EEXIST)
>>> +            ret = 0;
>>> +    } else {
>>> +        munmap(remap_addr, size);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   /* Returns mmap_min_addr sysctl */
>>>   static unsigned long long get_mmap_min_addr(void)
>>>   {
>>> @@ -180,6 +209,13 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
>>>       if (!((unsigned long long) addr & c.dest_alignment))
>>>           addr = (void *) ((unsigned long long) addr | c.dest_alignment);
>>>   +    /* Don't destroy existing mappings unless expected to overlap */
>>> +    while (!remap_region_valid(addr, c.region_size)) {
>>> +        if (c.overlapping)
>>> +            break;
>>> +        addr += c.src_alignment;
>>> +    }
>>> +

Here instead of in the loop.

>>>       clock_gettime(CLOCK_MONOTONIC, &t_start);
>>>       dest_addr = mremap(src_addr, c.region_size, c.region_size,
>>>               MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
>>>
>>

thanks,
-- Shuah
