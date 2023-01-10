Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31CF66406C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjAJM0F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 07:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjAJMZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 07:25:31 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0095F9D;
        Tue, 10 Jan 2023 04:25:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9EF07604F1;
        Tue, 10 Jan 2023 13:25:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673353527; bh=VeJArPQ6vKqPoHqGVssiiLXxT7q3qqWhs4HV7H9sSyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xKLD1GvLLCt3TIKW6MqymB2er08BfC64z3f5fvhPujl0L8C6Ofd3bhCPnUeJbUTf6
         gHhX94eR+I+87Zap98I4f/N842p+QbyUyNEYaHsnsEAST0XNpq5d9grWX77HF2Re83
         7rmX8O8odRlA0QIwUpAQBTEFLmvLPKXGVK28AbJ7U/zxrhci95T6WSjP50dD8TwqWW
         L3pltmsbZeW/CJ05nYjFfMF9sk3SIWmLN29GJjDxjN2UwWtj6rrOCbZ39ADisGjCr9
         lz5Ouroztk0dd2JNQ50Hxar3/D9dULzOj3Ka7vCbfpYwkk7pkQadbVEiYqd2AOkMde
         ScwslZ7qzBYJQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6CvrA81L_uoA; Tue, 10 Jan 2023 13:25:25 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id B7978604F0;
        Tue, 10 Jan 2023 13:25:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673353525; bh=VeJArPQ6vKqPoHqGVssiiLXxT7q3qqWhs4HV7H9sSyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mBcV/UXg0N4GxyNHy9mqg7rk1HhAPErILVk4U/adabEI7PMvnh2/5OHD/si5nmQlc
         AM4l3YKuAWJVpMMHUeEpdf5weFAjfuzVU6u4PiiSb8yuDLQcHcLz1QLJk3jwGPtzTV
         v6Zfh0y+ca1Oac48wHJZESto4dJnkhbAT450v8slkUgGyCqIMT67KwhzwTFvZRBWyL
         vfylKo60c84WnUBkucRL9H0qjROcCNxIuXUiq7gSCB+JsE7pN7gPRaBiMafqb/fKGy
         YgicNEJtT0hSEOKXHhXvHA5iRNmMuy5Gm/f0wJjiwfI7HCgnzQ4rWYE7K4p3QmRohC
         eGsyWIsHhwrlA==
Message-ID: <dda726db-6276-f312-be12-cee05228161d@alu.unizg.hr>
Date:   Tue, 10 Jan 2023 13:25:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_selftest/vm/cow=2ec_failed_to_compile_?=
 =?UTF-8?B?KOKAmE1BRFZfUEFHRU9VVOKAmSB1bmRlY2xhcmVkKQ==?=
Content-Language: en-US, hr
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0f117203-3227-cd16-61c2-2dd3de75ecc7@alu.unizg.hr>
 <0ee389dc-5e47-5b7e-4db5-637eb2b3fbc9@redhat.com>
 <0e692e52-0a4f-3892-ed25-f3fa12892b6f@alu.unizg.hr>
 <bac3f11b-db5f-113f-9cc3-8abf0e8e6ed6@redhat.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <bac3f11b-db5f-113f-9cc3-8abf0e8e6ed6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/10/23 11:05, David Hildenbrand wrote:
> On 09.01.23 22:41, Mirsad Goran Todorovac wrote:
>> On 1/9/2023 5:42 PM, David Hildenbrand wrote:
>>
>> Hi, thank you for your reply.
>>
>>>> I hope this is enough information for you to debug the issue.
>>>>
>>>> I am standing by for any additional diagnostics needed.
>>>
>>> Won't userfaultfd.c fail in a similar way?
>>>
>>> Anyhow, khugepaged.c jas
>>>
>>> #ifndef MADV_PAGEOUT
>>> #define MADV_PAGEOUT 21
>>> #endif
>>>
>>> So most probably we should do the same.
>>
>> Actually, David, it turned out that userfaultfd.c compiled
>> out-of-the-box, and side-by-side comparison showed that it also included
>> "/home/marvin/linux/kernel/linux_torvalds/usr/include/asm-generic/mman-common.h"
>>
>> The only remaining difference was including <linux/mman.h>, which fixed
>> the issue w/o #ifdef ... #endif
>>
>> Hope this helps.
>>
>> Please find the following diff.
>>
>> Regards,
>> Mirsad
>>
>> ------------------------------------------------------------------------------
>> diff --git a/tools/testing/selftests/vm/cow.c
>> b/tools/testing/selftests/vm/cow.c
>> index 26f6ea3079e2..dd8cf12c6776 100644
>> --- a/tools/testing/selftests/vm/cow.c
>> +++ b/tools/testing/selftests/vm/cow.c
>> @@ -16,6 +16,7 @@
>>    #include <fcntl.h>
>>    #include <dirent.h>
>>    #include <assert.h>
>> +#include <linux/mman.h>
>>    #include <sys/mman.h>
>>    #include <sys/ioctl.h>
>>    #include <sys/wait.h>
>>
> 
> I already sent a different fix [1]. I suspect when including
> linux/mman.h, it would still be problematic with older kernel
> headers that lack MADV_PAGEOUT (< v5.4).

I see your point.

> But yeah, I saw that userfaultfd.c was fixed that way:
> 
> commit b773827e361952b3f53ac6fa4c4e39ccd632102e
> Author: Chengming Zhou <zhouchengming@bytedance.com>
> Date:   Fri Mar 4 20:29:04 2022 -0800
> 
>      kselftest/vm: fix tests build with old libc
>      The error message when I build vm tests on debian10 (GLIBC 2.28):
>          userfaultfd.c: In function `userfaultfd_pagemap_test':
>          userfaultfd.c:1393:37: error: `MADV_PAGEOUT' undeclared (first use
>          in this function); did you mean `MADV_RANDOM'?
>            if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
>                                               ^~~~~~~~~~~~
>                                               MADV_RANDOM
>      This patch includes these newer definitions from UAPI linux/mman.h, is
>      useful to fix tests build on systems without these definitions in 
> glibc
>      sys/mman.h.
> 
> 
> [1] https://lkml.kernel.org/r/20230109171255.488749-1-david@redhat.com

You're the boss :)

However, IMHO, having MADV_PAGEOUT defined in three or four places could
make like miserable. OK, it is unlikely to change value, but something
tells me that the right way to do it is to guarantee that the macro
definition is unique.

I don't know what would be the right thing to do in pre-5.4 kernels
w/o MADV_PAGEOUT defined.

Probably then the "(madvise(area_dst, test_pgsize, MADV_PAGEOUT)" gives
EINVAL or is undefined?

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
