Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6A42F81B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbhJOQav (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 12:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241324AbhJOQaP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 12:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634315289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVoo/wEaPXgvHRpj8N841l0tEm3CQ7P8YvLK3b5GSH8=;
        b=XByeGQ+1mdKVzVtOS/93aWnyihmZiiTpayRENPPTGeGJNFLOJHlWer/y6CU+DmWbMG8unu
        nc/jL4Qil68rvz6qZx0CndyKapl/rJ1FJ6dLV0cGDkgYFvB+Z83pNqGZSbTeJjivrJhI+X
        AVbP2x6fPzNKmEjp+0+Ox9Bwwuaxydo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-KICt9PlBP6-elzIs91qgVg-1; Fri, 15 Oct 2021 12:28:05 -0400
X-MC-Unique: KICt9PlBP6-elzIs91qgVg-1
Received: by mail-wm1-f71.google.com with SMTP id 128-20020a1c0486000000b0030dcd45476aso808697wme.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 09:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fVoo/wEaPXgvHRpj8N841l0tEm3CQ7P8YvLK3b5GSH8=;
        b=jrRf50gG8HynyEOPcSE65lpMYpvhwaQ9B/lCerV9hjpGkXEUNwKESWbNnAdkhRYwBN
         /l+xDzvnXVPLHj7922AkJ5YDHyDKHje8Oy6/or+Vzy9Zv9w6qqkwiRvDxqv9cg62Kr8v
         nJUgh8fYt9YCEuBDnF7k3CNn0iFDPT8sUgMmduq1IxCVnoQqjVvkuprH/NT6/LdttvWp
         dxO+RBN5f3mIh7RujcPec6JUELCn4+qrnKvChvvF07kmFeOaXjg/5TEYQvcYPJgtN910
         wyEPKx43taySZvVSvmogknjSdI0+eiBc+/wyii0SjqhTENjMw68Pe6VNEEA4BSURA4i9
         cmXw==
X-Gm-Message-State: AOAM531PXREbZheU3lKeROfMQi9f3hTAt4hooiPz0g/d5WNd7eEwCB/P
        I4+TIH87kvORnG/jLD9MgQWDxm/Y968jfkGEOIi6c3ZaOgsv+9h77Y6KYia4Pt4LlMdis/ICqEU
        7uubrnZW2HvfQNNmr8hANkP8RjvOU
X-Received: by 2002:adf:bbd1:: with SMTP id z17mr15316193wrg.61.1634315284536;
        Fri, 15 Oct 2021 09:28:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY38Kw6/5SnX3X+xiuKSGHMv/fr5pKGXrlQpNCFnZijaAf2HmdUja4ZtS2emZG3U+LBrAreQ==
X-Received: by 2002:adf:bbd1:: with SMTP id z17mr15316179wrg.61.1634315284327;
        Fri, 15 Oct 2021 09:28:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id 143sm11383330wma.37.2021.10.15.09.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:28:03 -0700 (PDT)
Message-ID: <54baa765-9ad6-233a-dc60-25073c1625f4@redhat.com>
Date:   Fri, 15 Oct 2021 18:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: selftests/vm madv_populate.c test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
 <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
 <77f4c6a9-141d-e103-7339-0055cc00f752@redhat.com>
 <ccd3b3e4-6441-34f3-a099-392cda82cb8e@redhat.com>
 <78de0991-8e9a-693c-c020-472daa9ce916@redhat.com>
 <dd300ce7-f336-5815-ae0d-6064eea438b6@linuxfoundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <dd300ce7-f336-5815-ae0d-6064eea438b6@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15.10.21 18:25, Shuah Khan wrote:
> On 10/15/21 10:19 AM, David Hildenbrand wrote:
>> On 15.10.21 18:15, David Hildenbrand wrote:
>>> On 15.10.21 18:06, David Hildenbrand wrote:
>>>> On 15.10.21 17:47, David Hildenbrand wrote:
>>>>> On 15.10.21 17:45, Shuah Khan wrote:
>>>>>> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>>>>>>> On 18.09.21 00:45, Shuah Khan wrote:
>>>>>>>> Hi David,
>>>>>>>>
>>>>>>>> I am running into the following warning when try to build this test:
>>>>>>>>
>>>>>>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>>>>>>      334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>>>>          |  ^~~~~~~
>>>>>>>>
>>>>>>>>
>>>>>>>> I see that the following handling is in place. However there is no
>>>>>>>> other information to explain why the check is necessary.
>>>>>>>>
>>>>>>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>>>>>>
>>>>>>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>>>>>>
>>>>>>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>>>>
>>>>>>>> I do see these defined in:
>>>>>>>>
>>>>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>>>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>>>>>>
>>>>>>>> Is this the case of missing include from madv_populate.c?
>>>>>>>
>>>>>>> Hi Shuan,
>>>>>>>
>>>>>>> note that we're including "#include <sys/mman.h>", which in my
>>>>>>> understanding maps to the version installed on your system instead
>>>>>>> of the one in our build environment.ing.
>>>>>>>
>>>>>>> So as soon as you have a proper kernel + the proper headers installed
>>>>>>> and try to build, it would pick up MADV_POPULATE_READ and
>>>>>>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>>>>>>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>>>>>>> that doesn't support it.
>>>>>>>
>>>>>>> See vm/userfaultfd.c where we do something similar.
>>>>>>>
>>>>>>
>>>>>> Kselftest is for testing the kernel with kernel headers. That is the
>>>>>> reason why there is the dependency on header install.
>>>>>>
>>>>>>>
>>>>>>> As soon as we have a proper environment, it seems to work just fine:
>>>>>>>
>>>>>>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>> [root@vm-0 linux]# cat /etc/redhat-release
>>>>>>> Fedora release 36 (Rawhide)
>>>>>>
>>>>>> This is a distro release. We don't want to have dependency on headers
>>>>>> from the distro to run selftests. Hope this makes sense.
>>>>>>
>>>>>> I still see this on my test system running Linux 5.15-rc5.
>>>>>
>>>>> Did you also install Linux headers? I assume no, correct?
>>>>>
>>>>
>>>> What happens in your environment when compiling and running the
>>>> memfd_secret test?
>>>>
>>>> If assume you'll see a "skip" when executing, because it might also
>>>> refer to the local version of linux headers and although it builds, it
>>>> really cannot build something "functional". It just doesn't add a
>>>> "#warning" to make that obvious.
>>>>
>>>
>>> The following works but looks extremely hackish.
>>>
>>> diff --git a/tools/testing/selftests/vm/madv_populate.c
>>> b/tools/testing/selftests/vm/madv_populate.c
>>> index b959e4ebdad4..ab26163db540 100644
>>> --- a/tools/testing/selftests/vm/madv_populate.c
>>> +++ b/tools/testing/selftests/vm/madv_populate.c
>>> @@ -14,12 +14,11 @@
>>>   #include <unistd.h>
>>>   #include <errno.h>
>>>   #include <fcntl.h>
>>> +#include "../../../../usr/include/linux/mman.h"
>>>   #include <sys/mman.h>
>>>
>>>   #include "../kselftest.h"
>>>
>>> -#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>> -
>>>   /*
>>>    * For now, we're using 2 MiB of private anonymous memory for all tests.
>>>    */
>>> @@ -328,15 +327,3 @@ int main(int argc, char **argv)
>>>                                     err, ksft_test_num());
>>>          return ksft_exit_pass();
>>>   }
>>> -
>>> -#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>> -
>>> -#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>> -
>>> -int main(int argc, char **argv)
>>> -{
>>> -       ksft_print_header();
>>> -       ksft_exit_skip("MADV_POPULATE_READ or MADV_POPULATE_WRITE not
>>> defined\n");
>>> -}
>>> -
>>> -#endif /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>
>>>
>>> There has to be some clean way to achieve the same.
>>>
>>
>> Sorry for the spam,
>>
>> diff --git a/tools/testing/selftests/vm/Makefile
>> b/tools/testing/selftests/vm/Makefile
>> index d9605bd10f2d..ce198b329ff5 100644
>> --- a/tools/testing/selftests/vm/Makefile
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -23,7 +23,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e
>> 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>>   # LDLIBS.
>>   MAKEFLAGS += --no-builtin-rules
>>
>> -CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
>> +CFLAGS = -Wall -idirafter ../../../../usr/include $(EXTRA_CFLAGS)
>>   LDLIBS = -lrt -lpthread
>>   TEST_GEN_FILES = compaction_test
>>   TEST_GEN_FILES += gup_test
>>
>>
>> Seems to set the right include path priority.
>>
>>
> 
> Yes. It works on linux-next-20211012
> 
> Do you mind sending a me patch for this?

I just double-checked (after make clean) and there is still something
wrong :( the only think that seems to work is the

+#include "../../../../usr/include/linux/mman.h"
 #include <sys/mman.h>

hack.

Using "-nostdinc" won't work because we need other headers :(

-- 
Thanks,

David / dhildenb

