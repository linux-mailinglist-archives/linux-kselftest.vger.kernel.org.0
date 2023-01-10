Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24B9663D7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjAJKG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 05:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjAJKG2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 05:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC850068
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673345142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQos0rL6v0IJhlQcBZMrcxW60aPh1eJ2JqufvK5QrGs=;
        b=GSrgvO9ofcKnCj6ymkM+QUYyL8oyM1HdezXXINbjkj7WlTxMn9u1LezadMen15GQMHQoYl
        Qsj2wQLtI5usO8YrUDDf0G8ignQ68/tBNsxza5loLSBOuw556SDh9JbG9yJ/+7TTRDxVF1
        99PxFUCvqqj8nW31gcuBrTxwOp8UYIc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-MV4zDJ95M5eX3O_L1qTI0g-1; Tue, 10 Jan 2023 05:05:41 -0500
X-MC-Unique: MV4zDJ95M5eX3O_L1qTI0g-1
Received: by mail-wm1-f70.google.com with SMTP id q19-20020a1cf313000000b003d96c95e2f9so2368038wmq.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 02:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQos0rL6v0IJhlQcBZMrcxW60aPh1eJ2JqufvK5QrGs=;
        b=J03aagEVhFhaesK7vHBl/3eW/UDvPi/8ImKtm8UVBqSAqr4tQTQt6/fXncAIslpf1s
         9eTvReTpfD/ejQoVF53vHNncrIWlwC77jSG9v3o+L5DFcZ8Na/bUBku7hJHeCdiTb15L
         mg1rBXFsBou7VSSI0pKtE9vJD4PxTnp+ORWDXsR/RseqtrxSBC6Ntt6AWlYAOIzxHvTY
         RvPE5mtUDRDsaUuYZRj2nNOWHEkV+N09TiG38+Hu6/8etx0A1YbPEltBDBPvc0zcYaC+
         bDNJaA4mx7mt1XEnBxQl5gYTSVhTtiTtHovRAwfPeWk9yODxhbUrUyLMBx6eYsA/N1vV
         FAlg==
X-Gm-Message-State: AFqh2koP/MU87xkMvC0/CnvPaZ7MREmqySt2zRKtOAxGlRYvkCe7frXO
        vHtx3qQ8wJARB5O4OvE0FTrlQezdVacdSEb+qd0kedknlAe2VFAKfovzfiIIKrkjmORmu0exYIp
        RV6yDxdVxzAKws35pusIjBMANZg4b
X-Received: by 2002:a05:600c:3d8a:b0:3d3:4406:8a37 with SMTP id bi10-20020a05600c3d8a00b003d344068a37mr48796532wmb.41.1673345140647;
        Tue, 10 Jan 2023 02:05:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsFgWkzbQ2X01cVjAwNnoWvoKKf9DNAG5yZ3Ygp1x3LFRmRcYVTqXVI6DFXgV0rPJV/rKWJYA==
X-Received: by 2002:a05:600c:3d8a:b0:3d3:4406:8a37 with SMTP id bi10-20020a05600c3d8a00b003d344068a37mr48796515wmb.41.1673345140308;
        Tue, 10 Jan 2023 02:05:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:4200:65d9:4d0d:bb61:14c8? (p200300cbc708420065d94d0dbb6114c8.dip0.t-ipconnect.de. [2003:cb:c708:4200:65d9:4d0d:bb61:14c8])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003b4cba4ef71sm21771935wmb.41.2023.01.10.02.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:05:39 -0800 (PST)
Message-ID: <bac3f11b-db5f-113f-9cc3-8abf0e8e6ed6@redhat.com>
Date:   Tue, 10 Jan 2023 11:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0f117203-3227-cd16-61c2-2dd3de75ecc7@alu.unizg.hr>
 <0ee389dc-5e47-5b7e-4db5-637eb2b3fbc9@redhat.com>
 <0e692e52-0a4f-3892-ed25-f3fa12892b6f@alu.unizg.hr>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_selftest/vm/cow=2ec_failed_to_compile_?=
 =?UTF-8?B?KOKAmE1BRFZfUEFHRU9VVOKAmSB1bmRlY2xhcmVkKQ==?=
In-Reply-To: <0e692e52-0a4f-3892-ed25-f3fa12892b6f@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09.01.23 22:41, Mirsad Goran Todorovac wrote:
> On 1/9/2023 5:42 PM, David Hildenbrand wrote:
> 
> Hi, thank you for your reply.
> 
>>> I hope this is enough information for you to debug the issue.
>>>
>>> I am standing by for any additional diagnostics needed.
>>
>> Won't userfaultfd.c fail in a similar way?
>>
>> Anyhow, khugepaged.c jas
>>
>> #ifndef MADV_PAGEOUT
>> #define MADV_PAGEOUT 21
>> #endif
>>
>> So most probably we should do the same.
> 
> Actually, David, it turned out that userfaultfd.c compiled
> out-of-the-box, and side-by-side comparison showed that it also included
> "/home/marvin/linux/kernel/linux_torvalds/usr/include/asm-generic/mman-common.h"
> 
> The only remaining difference was including <linux/mman.h>, which fixed
> the issue w/o #ifdef ... #endif
> 
> Hope this helps.
> 
> Please find the following diff.
> 
> Regards,
> Mirsad
> 
> ------------------------------------------------------------------------------
> diff --git a/tools/testing/selftests/vm/cow.c
> b/tools/testing/selftests/vm/cow.c
> index 26f6ea3079e2..dd8cf12c6776 100644
> --- a/tools/testing/selftests/vm/cow.c
> +++ b/tools/testing/selftests/vm/cow.c
> @@ -16,6 +16,7 @@
>    #include <fcntl.h>
>    #include <dirent.h>
>    #include <assert.h>
> +#include <linux/mman.h>
>    #include <sys/mman.h>
>    #include <sys/ioctl.h>
>    #include <sys/wait.h>
>

I already sent a different fix [1]. I suspect when including
linux/mman.h, it would still be problematic with older kernel
headers that lack MADV_PAGEOUT (< v5.4).


But yeah, I saw that userfaultfd.c was fixed that way:

commit b773827e361952b3f53ac6fa4c4e39ccd632102e
Author: Chengming Zhou <zhouchengming@bytedance.com>
Date:   Fri Mar 4 20:29:04 2022 -0800

     kselftest/vm: fix tests build with old libc
     
     The error message when I build vm tests on debian10 (GLIBC 2.28):
     
         userfaultfd.c: In function `userfaultfd_pagemap_test':
         userfaultfd.c:1393:37: error: `MADV_PAGEOUT' undeclared (first use
         in this function); did you mean `MADV_RANDOM'?
           if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
                                              ^~~~~~~~~~~~
                                              MADV_RANDOM
     
     This patch includes these newer definitions from UAPI linux/mman.h, is
     useful to fix tests build on systems without these definitions in glibc
     sys/mman.h.


[1] https://lkml.kernel.org/r/20230109171255.488749-1-david@redhat.com

-- 
Thanks,

David / dhildenb

