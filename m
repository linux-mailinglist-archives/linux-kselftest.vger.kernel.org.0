Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF6522166
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347471AbiEJQkH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347498AbiEJQkA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:40:00 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8512CDE5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:36:02 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id f6-20020a4ace86000000b0035f083d2216so3306452oos.4
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HlN/qXnWAzpT0XOb6xZ1b8xPCTnujWMOoy9VjZoHjw8=;
        b=igSVZrItvpaAIWfSwmdQ+2sJD5RE7Dj0f2Xqwhu0KGvpZgTPz1h/UfTdbU8RtORw6X
         OYsdZqH3N9kneUqpwnqTaDbIhe7+rZisIsfWt7hGBpMiKYnC0DEUlODrpvlLeoM7Ke/3
         gSJshV5rl+gTE4W/dIwTahy54Rq6ev+lZH2i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HlN/qXnWAzpT0XOb6xZ1b8xPCTnujWMOoy9VjZoHjw8=;
        b=NeBCaiwDTnOxQEIn8MHrePs/fV9L6Vgfn+jGPVgSFOLFuNwdvOsl8IelK3g6gsV96J
         Gf+m6HqpVzd/uI77HuLDCTWfECrfxaC5wFBxJl3R/aA33lKvPY4n/EQpiMSxSFWdExRI
         nkMPmmEQEs1ouH+29gNE4GBu7v43IyP708MdL/fSZ5PeOK0MeGjTJ9QmBrLENExr683e
         CEWzLsjyIGpRraHLmvV7xA7U8O/kILZciiQmC/mH8XpJc8mcPdcdyjk7S4HhrJhKn7Gg
         poYIgJZG8jYjg/PXEV6fu5nZaTklJ3XQ1eTLklNLN7Nkgm5zBjQoGA7oUubXd0JPjOF7
         rmeg==
X-Gm-Message-State: AOAM530raZ/WNtynLoPxaG5SmC1weWKHTTmmc4+VXePXAoUEk3qDMZiI
        uiYLqVRbVdDROpFmcVwSBy2PKg==
X-Google-Smtp-Source: ABdhPJx93Z3ylX4pk92oPHE+DdIJ5Ls6uO64R9apfqz6sABtiyzl6X1YdcErOscFNGVi1H4MtujyCg==
X-Received: by 2002:a4a:870d:0:b0:35f:7c65:1340 with SMTP id z13-20020a4a870d000000b0035f7c651340mr4597180ooh.46.1652200559980;
        Tue, 10 May 2022 09:35:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bj6-20020a056808198600b00326bab99fe5sm2726538oib.40.2022.05.10.09.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 09:35:59 -0700 (PDT)
Subject: Re: [PATCH 1/3] selftests: vm: add process_mrelease tests
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510030014.3842475-1-surenb@google.com>
 <04858a5d-98c8-69be-025f-214e4b10d502@linuxfoundation.org>
 <CAJuCfpEAqEEf-SCi87-VZrFYcoPff8Gkda5uF8fYRyKQo_vkjw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ebaad398-110d-6a6b-70a5-3abeacfcb14a@linuxfoundation.org>
Date:   Tue, 10 May 2022 10:35:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEAqEEf-SCi87-VZrFYcoPff8Gkda5uF8fYRyKQo_vkjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 10:29 AM, Suren Baghdasaryan wrote:
> On Tue, May 10, 2022 at 8:43 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
>>> Introduce process_mrelease syscall sanity tests. They include tests of
>>> invalid pidfd and flags inputs, attempting to call process_mrelease
>>> with a live process and a valid usage of process_mrelease. Because
>>> process_mrelease has to be used against a process with a pending SIGKILL,
>>> it's possible that the process exits before process_mrelease gets called.
>>> In such cases we retry the test with a victim that allocates twice more
>>> memory up to 1GB. This would require the victim process to spend more
>>> time during exit and process_mrelease has a better chance of catching
>>> the process before it exits.
>>>
>>
>> +1 on Mike's comments on improving the change log. List what is getting
>> tested as opposed to describing the test code.
> 
> I'll try to improve the description but IMHO it does describe what
> it's testing - the process_mrelease syscall with valid and invalid
> inputs. I could omit the implementation details if that helps.
> 
>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>    tools/testing/selftests/vm/Makefile        |   1 +
>>>    tools/testing/selftests/vm/mrelease_test.c | 176 +++++++++++++++++++++
>>>    tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
>>>    3 files changed, 193 insertions(+)
>>>    create mode 100644 tools/testing/selftests/vm/mrelease_test.c
>>
>> Please update .gitignore with the new executable.
> 
> Ack.
> 
>>
>>>
>>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>>> index 04a49e876a46..733fccbff0ef 100644
>>> --- a/tools/testing/selftests/vm/Makefile
>>> +++ b/tools/testing/selftests/vm/Makefile
>>> @@ -43,6 +43,7 @@ TEST_GEN_FILES += map_populate
>>>    TEST_GEN_FILES += memfd_secret
>>>    TEST_GEN_FILES += mlock-random-test
>>>    TEST_GEN_FILES += mlock2-tests
>>> +TEST_GEN_FILES += mrelease_test
>>>    TEST_GEN_FILES += mremap_dontunmap
>>>    TEST_GEN_FILES += mremap_test
>>>    TEST_GEN_FILES += on-fault-limit
>>> diff --git a/tools/testing/selftests/vm/mrelease_test.c b/tools/testing/selftests/vm/mrelease_test.c
>>> new file mode 100644
>>> index 000000000000..a61061bf8433
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/vm/mrelease_test.c
>>> @@ -0,0 +1,176 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2022 Google LLC
>>> + */
>>> +#define _GNU_SOURCE
>>> +#include <errno.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <sys/wait.h>
>>> +#include <unistd.h>
>>> +
>>> +#include "util.h"
>>> +
>>> +static inline int pidfd_open(pid_t pid, unsigned int flags)
>>> +{
>>> +#ifdef __NR_pidfd_open
>>> +     return syscall(__NR_pidfd_open, pid, flags);
>>> +#else
>>> +     errno = ENOSYS;
>>
>> This isn't an error - this would be skip because this syscall
>> isn't supported.
> 
> Ack.
> 
>>
>>> +     return -1;
>>> +#endif
>>
>> Key off of syscall return instead of these ifdefs - same comment
>> on all of the ifdefs
> 
> Ack. I was using some other test as an example but I guess that was
> not a good model.
> 
>>
>>> +}
>>> +
>>
>> I am not seeing any reason for breaking this code up have a separate
>> routine for pidfd_open().
> 
> I'm a bit unclear what you mean. Do you mean that userspace headers
> should already define pidfd_open() and I don't need to define it?
> 

Do you need pidfd_open() or can this be part of main? Without the ifdefs,
it is really a one line code.

thanks,
-- Shuah
