Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3042F80F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbhJOQ1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbhJOQ1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 12:27:31 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB7C061764
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 09:25:24 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so7728964ilb.9
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q21BemEBT9xiSl83II9mI72B4tHLilVao/GwBgbq/bE=;
        b=KS89ThOuupxwC7b/hhZU+KwujC/82lQzJJWhndOGIXtwtCE3vT1I2iKDxSQgyw38Gy
         gRElRcu+P6GjaAosUyTPNiUUlVk2lmsGwCDAV6lONm5DUYbhnWtSflYde1o0HSj1u49Q
         KVa6ZSPD3TWuSmw9nYqBgNlsvA83B5I96Atkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q21BemEBT9xiSl83II9mI72B4tHLilVao/GwBgbq/bE=;
        b=UOtzco5QVL7rG8Xg80vSh7lFck+2FdqbpmDmVwYH8JWexqAHkHfKcLeAn4r3e2X5lx
         wHlieyCyCsZwj1DDo2X/kxACc9OZ34syVjsr/Jbu7PCsOa+uf2L1sI1s5nlmNLLPXkFR
         9LArjmw9lARnh4GP6aE6IY8HFLC+qUKwe5O1WwDKc4g8KtuMbUuGKvTGE11hhkxFnVto
         3+wtAAKNl9jTfuW0I3s6EtHlRYvpDAfn1u2RRwsz8XModBGnpGZ69t9tCodzyVU/C8Iu
         tPeDMNAhoJR0EcQjtb74+LvMDpR/20wQ1v4xYuwb1cPT77uIRKM/TtsErgZtjOYG3Z+Y
         jspw==
X-Gm-Message-State: AOAM531V5hcI2yzz5D7Gaj0gV2bBMWiVteBd13PxyMGRlQndmoP8Qy+5
        D0huBtqRJUzaaMLjDK3eycAwiMvMzPGcUQ==
X-Google-Smtp-Source: ABdhPJzHCD1JuXKvTRWgbClkluSbO3TxsQmnt43iHGlXGFbozeIo5OLhS+Oxnk3gYh3ORBSvo+1C2Q==
X-Received: by 2002:a05:6e02:1e02:: with SMTP id g2mr4417981ila.89.1634315123955;
        Fri, 15 Oct 2021 09:25:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g20sm2936776ilk.64.2021.10.15.09.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:25:23 -0700 (PDT)
Subject: Re: selftests/vm madv_populate.c test
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
 <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
 <77f4c6a9-141d-e103-7339-0055cc00f752@redhat.com>
 <ccd3b3e4-6441-34f3-a099-392cda82cb8e@redhat.com>
 <78de0991-8e9a-693c-c020-472daa9ce916@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dd300ce7-f336-5815-ae0d-6064eea438b6@linuxfoundation.org>
Date:   Fri, 15 Oct 2021 10:25:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <78de0991-8e9a-693c-c020-472daa9ce916@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/15/21 10:19 AM, David Hildenbrand wrote:
> On 15.10.21 18:15, David Hildenbrand wrote:
>> On 15.10.21 18:06, David Hildenbrand wrote:
>>> On 15.10.21 17:47, David Hildenbrand wrote:
>>>> On 15.10.21 17:45, Shuah Khan wrote:
>>>>> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>>>>>> On 18.09.21 00:45, Shuah Khan wrote:
>>>>>>> Hi David,
>>>>>>>
>>>>>>> I am running into the following warning when try to build this test:
>>>>>>>
>>>>>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>>>>>      334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>>>          |  ^~~~~~~
>>>>>>>
>>>>>>>
>>>>>>> I see that the following handling is in place. However there is no
>>>>>>> other information to explain why the check is necessary.
>>>>>>>
>>>>>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>>>>>
>>>>>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>>>>>
>>>>>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>>>
>>>>>>> I do see these defined in:
>>>>>>>
>>>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>>>>>
>>>>>>> Is this the case of missing include from madv_populate.c?
>>>>>>
>>>>>> Hi Shuan,
>>>>>>
>>>>>> note that we're including "#include <sys/mman.h>", which in my
>>>>>> understanding maps to the version installed on your system instead
>>>>>> of the one in our build environment.ing.
>>>>>>
>>>>>> So as soon as you have a proper kernel + the proper headers installed
>>>>>> and try to build, it would pick up MADV_POPULATE_READ and
>>>>>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>>>>>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>>>>>> that doesn't support it.
>>>>>>
>>>>>> See vm/userfaultfd.c where we do something similar.
>>>>>>
>>>>>
>>>>> Kselftest is for testing the kernel with kernel headers. That is the
>>>>> reason why there is the dependency on header install.
>>>>>
>>>>>>
>>>>>> As soon as we have a proper environment, it seems to work just fine:
>>>>>>
>>>>>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>> [root@vm-0 linux]# cat /etc/redhat-release
>>>>>> Fedora release 36 (Rawhide)
>>>>>
>>>>> This is a distro release. We don't want to have dependency on headers
>>>>> from the distro to run selftests. Hope this makes sense.
>>>>>
>>>>> I still see this on my test system running Linux 5.15-rc5.
>>>>
>>>> Did you also install Linux headers? I assume no, correct?
>>>>
>>>
>>> What happens in your environment when compiling and running the
>>> memfd_secret test?
>>>
>>> If assume you'll see a "skip" when executing, because it might also
>>> refer to the local version of linux headers and although it builds, it
>>> really cannot build something "functional". It just doesn't add a
>>> "#warning" to make that obvious.
>>>
>>
>> The following works but looks extremely hackish.
>>
>> diff --git a/tools/testing/selftests/vm/madv_populate.c
>> b/tools/testing/selftests/vm/madv_populate.c
>> index b959e4ebdad4..ab26163db540 100644
>> --- a/tools/testing/selftests/vm/madv_populate.c
>> +++ b/tools/testing/selftests/vm/madv_populate.c
>> @@ -14,12 +14,11 @@
>>   #include <unistd.h>
>>   #include <errno.h>
>>   #include <fcntl.h>
>> +#include "../../../../usr/include/linux/mman.h"
>>   #include <sys/mman.h>
>>
>>   #include "../kselftest.h"
>>
>> -#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>> -
>>   /*
>>    * For now, we're using 2 MiB of private anonymous memory for all tests.
>>    */
>> @@ -328,15 +327,3 @@ int main(int argc, char **argv)
>>                                     err, ksft_test_num());
>>          return ksft_exit_pass();
>>   }
>> -
>> -#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>> -
>> -#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>> -
>> -int main(int argc, char **argv)
>> -{
>> -       ksft_print_header();
>> -       ksft_exit_skip("MADV_POPULATE_READ or MADV_POPULATE_WRITE not
>> defined\n");
>> -}
>> -
>> -#endif /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>
>>
>> There has to be some clean way to achieve the same.
>>
> 
> Sorry for the spam,
> 
> diff --git a/tools/testing/selftests/vm/Makefile
> b/tools/testing/selftests/vm/Makefile
> index d9605bd10f2d..ce198b329ff5 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -23,7 +23,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e
> 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>   # LDLIBS.
>   MAKEFLAGS += --no-builtin-rules
> 
> -CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
> +CFLAGS = -Wall -idirafter ../../../../usr/include $(EXTRA_CFLAGS)
>   LDLIBS = -lrt -lpthread
>   TEST_GEN_FILES = compaction_test
>   TEST_GEN_FILES += gup_test
> 
> 
> Seems to set the right include path priority.
> 
> 

Yes. It works on linux-next-20211012

Do you mind sending a me patch for this?

thanks,
-- Shuah
