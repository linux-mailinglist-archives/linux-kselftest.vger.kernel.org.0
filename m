Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1629666407C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 13:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjAJMaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 07:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjAJMaG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 07:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCC61CFE8
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 04:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673353760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zj7O7BsTwrlQivuxli/b/DVop3RoAUc26KLutE6aqJA=;
        b=FEO6LfoLnF5pquvPFLQmsjSJEzvlSYe85l9L9vo3tl1rR+6PQ8sdtb3A2yE5KCbKURUAFA
        0//DYJg/baz4zQ7MxktzfB4zPEkRkglM7GUTf8xLAFenqF1cash2Jwsy4mube+hh1pDxU1
        PJzwgSsX9b6vMCwGJByLjSPLVLO4NbU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-QV3vN33cNXKQxQvAJynk-w-1; Tue, 10 Jan 2023 07:29:19 -0500
X-MC-Unique: QV3vN33cNXKQxQvAJynk-w-1
Received: by mail-wr1-f71.google.com with SMTP id u4-20020adfc644000000b002ad64393461so1933736wrg.7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 04:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zj7O7BsTwrlQivuxli/b/DVop3RoAUc26KLutE6aqJA=;
        b=QWXqf+It88N6UWEBJospESZpiBYNKT3s8UxbgLGBxsbBgfdu9wCDJO4UuXndGzTDOG
         +IFkNfF+FNB5L3WKgVDGIbqHUzWkEhnrrBQ5/SoUmRpng+RjKGhBdLwEjw9KkzFhWJ7j
         YaI1P1Ex/Go3EIufB0GKctXkhZSu4nRTEhwvvbPmE1U/AXillld45FgSG/iCEUlUWQzl
         +yLcJhs7aIop/cAizqyePKxmPvcvFUUlwHBnqRGeFm94OilNCOhiATemrBd5tBbGx1nl
         htd+UF3DEdRubRcrViYmqCKpcqvQ0TibYkyAYwZhAOw8xLdvWy0dGx77sjOCpEYUzGU7
         eWXw==
X-Gm-Message-State: AFqh2krD0FEZcvt3P1Yc4XErHzf7+mZAPEZNXVagyP14XVb1YiPUCrOy
        9y/tQlY+aLOyLs94ve2FdnLMURaTWIPuQSb+tJwRTk24FRIRPj4Q4SN0kABpIOB9Y0fsYq9JbuW
        zmiW3Q4YGdto0Gvxc7y6NclL6yLoZ
X-Received: by 2002:a05:600c:a51:b0:3cf:6f4d:c259 with SMTP id c17-20020a05600c0a5100b003cf6f4dc259mr47849224wmq.39.1673353757900;
        Tue, 10 Jan 2023 04:29:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt74bXfj7jrQJ4WS8z+NMklJ4YVza2YaN6bDMjEL1Hh4N7QrP6Tx6DHyCHQc6eNCWGeQcwsrQ==
X-Received: by 2002:a05:600c:a51:b0:3cf:6f4d:c259 with SMTP id c17-20020a05600c0a5100b003cf6f4dc259mr47849214wmq.39.1673353757618;
        Tue, 10 Jan 2023 04:29:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:4200:65d9:4d0d:bb61:14c8? (p200300cbc708420065d94d0dbb6114c8.dip0.t-ipconnect.de. [2003:cb:c708:4200:65d9:4d0d:bb61:14c8])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003d9862ec435sm2609591wms.20.2023.01.10.04.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:29:17 -0800 (PST)
Message-ID: <a0985987-384a-d44f-c365-b0b2b935d417@redhat.com>
Date:   Tue, 10 Jan 2023 13:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_selftest/vm/cow=2ec_failed_to_compile_?=
 =?UTF-8?B?KOKAmE1BRFZfUEFHRU9VVOKAmSB1bmRlY2xhcmVkKQ==?=
Content-Language: en-US
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0f117203-3227-cd16-61c2-2dd3de75ecc7@alu.unizg.hr>
 <0ee389dc-5e47-5b7e-4db5-637eb2b3fbc9@redhat.com>
 <0e692e52-0a4f-3892-ed25-f3fa12892b6f@alu.unizg.hr>
 <bac3f11b-db5f-113f-9cc3-8abf0e8e6ed6@redhat.com>
 <dda726db-6276-f312-be12-cee05228161d@alu.unizg.hr>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <dda726db-6276-f312-be12-cee05228161d@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10.01.23 13:25, Mirsad Todorovac wrote:
> On 1/10/23 11:05, David Hildenbrand wrote:
>> On 09.01.23 22:41, Mirsad Goran Todorovac wrote:
>>> On 1/9/2023 5:42 PM, David Hildenbrand wrote:
>>>
>>> Hi, thank you for your reply.
>>>
>>>>> I hope this is enough information for you to debug the issue.
>>>>>
>>>>> I am standing by for any additional diagnostics needed.
>>>>
>>>> Won't userfaultfd.c fail in a similar way?
>>>>
>>>> Anyhow, khugepaged.c jas
>>>>
>>>> #ifndef MADV_PAGEOUT
>>>> #define MADV_PAGEOUT 21
>>>> #endif
>>>>
>>>> So most probably we should do the same.
>>>
>>> Actually, David, it turned out that userfaultfd.c compiled
>>> out-of-the-box, and side-by-side comparison showed that it also included
>>> "/home/marvin/linux/kernel/linux_torvalds/usr/include/asm-generic/mman-common.h"
>>>
>>> The only remaining difference was including <linux/mman.h>, which fixed
>>> the issue w/o #ifdef ... #endif
>>>
>>> Hope this helps.
>>>
>>> Please find the following diff.
>>>
>>> Regards,
>>> Mirsad
>>>
>>> ------------------------------------------------------------------------------
>>> diff --git a/tools/testing/selftests/vm/cow.c
>>> b/tools/testing/selftests/vm/cow.c
>>> index 26f6ea3079e2..dd8cf12c6776 100644
>>> --- a/tools/testing/selftests/vm/cow.c
>>> +++ b/tools/testing/selftests/vm/cow.c
>>> @@ -16,6 +16,7 @@
>>>     #include <fcntl.h>
>>>     #include <dirent.h>
>>>     #include <assert.h>
>>> +#include <linux/mman.h>
>>>     #include <sys/mman.h>
>>>     #include <sys/ioctl.h>
>>>     #include <sys/wait.h>
>>>
>>
>> I already sent a different fix [1]. I suspect when including
>> linux/mman.h, it would still be problematic with older kernel
>> headers that lack MADV_PAGEOUT (< v5.4).
> 
> I see your point.
> 
>> But yeah, I saw that userfaultfd.c was fixed that way:
>>
>> commit b773827e361952b3f53ac6fa4c4e39ccd632102e
>> Author: Chengming Zhou <zhouchengming@bytedance.com>
>> Date:   Fri Mar 4 20:29:04 2022 -0800
>>
>>       kselftest/vm: fix tests build with old libc
>>       The error message when I build vm tests on debian10 (GLIBC 2.28):
>>           userfaultfd.c: In function `userfaultfd_pagemap_test':
>>           userfaultfd.c:1393:37: error: `MADV_PAGEOUT' undeclared (first use
>>           in this function); did you mean `MADV_RANDOM'?
>>             if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
>>                                                ^~~~~~~~~~~~
>>                                                MADV_RANDOM
>>       This patch includes these newer definitions from UAPI linux/mman.h, is
>>       useful to fix tests build on systems without these definitions in
>> glibc
>>       sys/mman.h.
>>
>>
>> [1] https://lkml.kernel.org/r/20230109171255.488749-1-david@redhat.com
> 
> You're the boss :)

Heh, no I'm not :) I'm just raising that this turned out to be 
problematic unfortunately.

> 
> However, IMHO, having MADV_PAGEOUT defined in three or four places could
> make like miserable. OK, it is unlikely to change value, but something
> tells me that the right way to do it is to guarantee that the macro
> definition is unique.
> 
> I don't know what would be the right thing to do in pre-5.4 kernels
> w/o MADV_PAGEOUT defined.
> 
> Probably then the "(madvise(area_dst, test_pgsize, MADV_PAGEOUT)" gives
> EINVAL or is undefined?

Yes. The expectation is that it fails with ENOSYS or EINVAL if the 
kernel doesn't support it. The kernel might be different to the 
installed kernel headers.

In an ideal world, we'd be using the in-tree headers -- they are 
guaranteed to define what we need. So far, I failed to make it work (I 
thought it would work as expected before I had to do above mentioned 
fix). Maybe that can be made working?

-- 
Thanks,

David / dhildenb

