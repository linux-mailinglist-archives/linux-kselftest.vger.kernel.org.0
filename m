Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5974842F84A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhJOQg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 12:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235125AbhJOQg1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 12:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634315660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbnAJ/JYbWs55/hlgaOj60xCkmuL/oyjq98D827Oztg=;
        b=TcCs8Tc1fFC8OPk6RpwP/3V5ravWPKlmI0Zt1IPCRE405DOWfyNCP2i+8TI1e1QV/VPgC4
        DV1BBh+N53EX9IW1OnTN0F9JN3O0sCLn4tkD4PFS8t2+UsZAc6yNU97H40mvET+IGcqsZ1
        lj6qZoeV5+LSpfHHrbDX9nuCjFySZZk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-GNWJctJXNg-n_mp1Vadx0g-1; Fri, 15 Oct 2021 12:34:18 -0400
X-MC-Unique: GNWJctJXNg-n_mp1Vadx0g-1
Received: by mail-wm1-f72.google.com with SMTP id n17-20020a7bc5d1000000b0030d4041f73eso966879wmk.4
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 09:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=MbnAJ/JYbWs55/hlgaOj60xCkmuL/oyjq98D827Oztg=;
        b=ubf4uf76bILMNUqbKFqkUcaBwdK8n701fvtzOs0n2dNSv2REtkZ0e7qYFAEydKGrTu
         GPmiRLm2npQIKaJ+ZXhdKb+X87ECnpxQORKIWZPpmhpZVrF5+sHvgpgllkUQZdVqMd7C
         NyEyUF5en9A7Kw/lR07abjTuXJQdLDDowfR8zORuu7Gp9PJ6qBBm979qeJANMSQeGHYO
         Xv86ExPNArZQT8ozYi2KelknK4i0h9gnfCwfwWcMlSdXnVjeEc3/9+LXAWB9/4vu54m+
         Oj/kOnrVl/7WaRQAsMNT/NeSG63bTG6NV3Wh7kAzHvJN6EOjBbQp0nMxwVNZDlx/cR2j
         QOxg==
X-Gm-Message-State: AOAM533oSasgTkRPXh+85sbVS7BIjBJ2Z0SSLEuRTgrFp5byMmjkTfCZ
        jM3/H6tGmY8HFTZHmIBL7LcmGIGbZdpWts52ABszzBBO6I+N7Tn/3PTeLARbLT8cdIMfYhkGFuG
        0xwMFRRAPee4NCb1XMiaznMU/7j7N
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr13622631wmq.118.1634315657683;
        Fri, 15 Oct 2021 09:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydmtNnoyo6UYlqXxn8KvTmaAzif4RxypOSmVanpXoRQXfi+QT+amosb6Ct1yrtwaV//Xguww==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr13622609wmq.118.1634315657400;
        Fri, 15 Oct 2021 09:34:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id o23sm5301187wms.18.2021.10.15.09.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:34:16 -0700 (PDT)
Message-ID: <7ac3c6da-a781-91d5-7ee2-ec05ac167611@redhat.com>
Date:   Fri, 15 Oct 2021 18:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: selftests/vm madv_populate.c test
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <54baa765-9ad6-233a-dc60-25073c1625f4@redhat.com>
Organization: Red Hat
In-Reply-To: <54baa765-9ad6-233a-dc60-25073c1625f4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15.10.21 18:28, David Hildenbrand wrote:
> On 15.10.21 18:25, Shuah Khan wrote:
>> On 10/15/21 10:19 AM, David Hildenbrand wrote:
>>> On 15.10.21 18:15, David Hildenbrand wrote:
>>>> On 15.10.21 18:06, David Hildenbrand wrote:
>>>>> On 15.10.21 17:47, David Hildenbrand wrote:
>>>>>> On 15.10.21 17:45, Shuah Khan wrote:
>>>>>>> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>>>>>>>> On 18.09.21 00:45, Shuah Khan wrote:
>>>>>>>>> Hi David,
>>>>>>>>>
>>>>>>>>> I am running into the following warning when try to build this test:
>>>>>>>>>
>>>>>>>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>>>>>>>      334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>>>>>          |  ^~~~~~~
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I see that the following handling is in place. However there is no
>>>>>>>>> other information to explain why the check is necessary.
>>>>>>>>>
>>>>>>>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>>>>>>>
>>>>>>>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>>>>>>>
>>>>>>>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>>>>>
>>>>>>>>> I do see these defined in:
>>>>>>>>>
>>>>>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>>>>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>>>>>>>
>>>>>>>>> Is this the case of missing include from madv_populate.c?
>>>>>>>>
>>>>>>>> Hi Shuan,
>>>>>>>>
>>>>>>>> note that we're including "#include <sys/mman.h>", which in my
>>>>>>>> understanding maps to the version installed on your system instead
>>>>>>>> of the one in our build environment.ing.
>>>>>>>>
>>>>>>>> So as soon as you have a proper kernel + the proper headers installed
>>>>>>>> and try to build, it would pick up MADV_POPULATE_READ and
>>>>>>>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>>>>>>>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>>>>>>>> that doesn't support it.
>>>>>>>>
>>>>>>>> See vm/userfaultfd.c where we do something similar.
>>>>>>>>
>>>>>>>
>>>>>>> Kselftest is for testing the kernel with kernel headers. That is the
>>>>>>> reason why there is the dependency on header install.
>>>>>>>
>>>>>>>>
>>>>>>>> As soon as we have a proper environment, it seems to work just fine:
>>>>>>>>
>>>>>>>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>>> [root@vm-0 linux]# cat /etc/redhat-release
>>>>>>>> Fedora release 36 (Rawhide)
>>>>>>>
>>>>>>> This is a distro release. We don't want to have dependency on headers
>>>>>>> from the distro to run selftests. Hope this makes sense.
>>>>>>>
>>>>>>> I still see this on my test system running Linux 5.15-rc5.
>>>>>>
>>>>>> Did you also install Linux headers? I assume no, correct?
>>>>>>
>>>>>
>>>>> What happens in your environment when compiling and running the
>>>>> memfd_secret test?
>>>>>
>>>>> If assume you'll see a "skip" when executing, because it might also
>>>>> refer to the local version of linux headers and although it builds, it
>>>>> really cannot build something "functional". It just doesn't add a
>>>>> "#warning" to make that obvious.
>>>>>
>>>>
>>>> The following works but looks extremely hackish.
>>>>
>>>> diff --git a/tools/testing/selftests/vm/madv_populate.c
>>>> b/tools/testing/selftests/vm/madv_populate.c
>>>> index b959e4ebdad4..ab26163db540 100644
>>>> --- a/tools/testing/selftests/vm/madv_populate.c
>>>> +++ b/tools/testing/selftests/vm/madv_populate.c
>>>> @@ -14,12 +14,11 @@
>>>>   #include <unistd.h>
>>>>   #include <errno.h>
>>>>   #include <fcntl.h>
>>>> +#include "../../../../usr/include/linux/mman.h"
>>>>   #include <sys/mman.h>
>>>>
>>>>   #include "../kselftest.h"
>>>>
>>>> -#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>> -
>>>>   /*
>>>>    * For now, we're using 2 MiB of private anonymous memory for all tests.
>>>>    */
>>>> @@ -328,15 +327,3 @@ int main(int argc, char **argv)
>>>>                                     err, ksft_test_num());
>>>>          return ksft_exit_pass();
>>>>   }
>>>> -
>>>> -#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>> -
>>>> -#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>> -
>>>> -int main(int argc, char **argv)
>>>> -{
>>>> -       ksft_print_header();
>>>> -       ksft_exit_skip("MADV_POPULATE_READ or MADV_POPULATE_WRITE not
>>>> defined\n");
>>>> -}
>>>> -
>>>> -#endif /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>>
>>>>
>>>> There has to be some clean way to achieve the same.
>>>>
>>>
>>> Sorry for the spam,
>>>
>>> diff --git a/tools/testing/selftests/vm/Makefile
>>> b/tools/testing/selftests/vm/Makefile
>>> index d9605bd10f2d..ce198b329ff5 100644
>>> --- a/tools/testing/selftests/vm/Makefile
>>> +++ b/tools/testing/selftests/vm/Makefile
>>> @@ -23,7 +23,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e
>>> 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>>>   # LDLIBS.
>>>   MAKEFLAGS += --no-builtin-rules
>>>
>>> -CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
>>> +CFLAGS = -Wall -idirafter ../../../../usr/include $(EXTRA_CFLAGS)
>>>   LDLIBS = -lrt -lpthread
>>>   TEST_GEN_FILES = compaction_test
>>>   TEST_GEN_FILES += gup_test
>>>
>>>
>>> Seems to set the right include path priority.
>>>
>>>
>>
>> Yes. It works on linux-next-20211012
>>
>> Do you mind sending a me patch for this?
> 
> I just double-checked (after make clean) and there is still something
> wrong :( the only think that seems to work is the
> 
> +#include "../../../../usr/include/linux/mman.h"
>  #include <sys/mman.h>
> 
> hack.
> 
> Using "-nostdinc" won't work because we need other headers :(
> 

And ... I think I know the problem.

In ../../../../usr/include, there is no "sys" directory. It's called
"linux".

But including <linux/mman.h> instead of <sys/mman.h> doesn't work
either. The only thing that seems to work is


diff --git a/tools/testing/selftests/vm/madv_populate.c
b/tools/testing/selftests/vm/madv_populate.c
index b959e4ebdad4..3ee0e8275600 100644
--- a/tools/testing/selftests/vm/madv_populate.c
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -14,12 +14,11 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/mman.h>
 #include <sys/mman.h>

 #include "../kselftest.h"

-#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
-
 /*
  * For now, we're using 2 MiB of private anonymous memory for all tests.
  */
@@ -328,15 +327,3 @@ int main(int argc, char **argv)
                                   err, ksft_test_num());
        return ksft_exit_pass();
 }
-
-#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
-
-#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
-
-int main(int argc, char **argv)
-{
-       ksft_print_header();
-       ksft_exit_skip("MADV_POPULATE_READ or MADV_POPULATE_WRITE not
defined\n");
-}
-
-#endif /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */


-- 
Thanks,

David / dhildenb

