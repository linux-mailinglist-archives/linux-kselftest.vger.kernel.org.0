Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6222652954A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 01:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiEPX2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 19:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbiEPX2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 19:28:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2309336B72
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 16:28:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e4so2339893ils.12
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aB42P+32Sum2YGY8sIwFisRp1PF9vp9paSBH6A92ZaE=;
        b=Zv6HbJakhqS+8wMgeAmCsL+LluuM1WF/O/iD6PBZbTfwaeoxl+nGIXjE0bxK3qLegV
         rZW7Cm8pz7iuOCC10rLuWZIo+EWIs3JKeOwt3XQu3Vv5z7pwl+sjDUwqFeUCC/RluqIs
         EIx+Op8FRpoPxCIwiSmmxs5FlU8Ez8p/fHPf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aB42P+32Sum2YGY8sIwFisRp1PF9vp9paSBH6A92ZaE=;
        b=GHUf2fOHDBxBdv8MmDXCB5kiOh49BpXPxE5PvveVxExm9XgLxJL944nDOtzf26Y/+5
         2hcM64cK8SG60K861aRh412XyRwLUDn8+RMKvAP4WIzc3HIUx/FW1D/s18jaXd9pDEhQ
         vzlbtJ9mFcXV0ChULQ0wWjVFkgSlshpRZ51yXs9FnhutBH7gVA9VoGyX0rlCi4SWj85V
         d7kUxZKTMacKVQFlKuV1XikRzm28y5dj+2vBLDqrByr0REwjByYxAqaAMXLMiVrLQc5E
         OJb99U9WErctUY7820fm1p5a5MIFWTvInqe41bs+N5zf2t8rYDwOF7GXrZ2rHqw7Twk4
         9QcQ==
X-Gm-Message-State: AOAM533zll8PKaL0v3cY2HycnftkQ52+coFcUEs5c15jCiA/HO/N2db6
        92YoGbbbonBZqyBFFcLU++Wrjg==
X-Google-Smtp-Source: ABdhPJzjAxpWuSAl3NSm2jw1j14nzqb8OMF43VWfK8MkCFKfzvQ5EPRFC8NsalLmZGBu91pdgn8guQ==
X-Received: by 2002:a05:6e02:1905:b0:2cf:1afa:7523 with SMTP id w5-20020a056e02190500b002cf1afa7523mr10791194ilu.234.1652743683444;
        Mon, 16 May 2022 16:28:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d76-20020a6bcd4f000000b0065a9e81df9dsm202417iog.4.2022.05.16.16.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 16:28:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] selftests: vm: add process_mrelease tests
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
References: <20220516075538.1276644-1-surenb@google.com>
 <78c3a163-551b-ef53-4018-7b6ba0640757@linuxfoundation.org>
 <CAJuCfpEW3kif-QAVdFKyZikVRT5QrLGwJ5pzua+yuVq=A=bv8w@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7f0fd407-18f5-2718-40b5-b16804163197@linuxfoundation.org>
Date:   Mon, 16 May 2022 17:28:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEW3kif-QAVdFKyZikVRT5QrLGwJ5pzua+yuVq=A=bv8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/16/22 2:47 PM, Suren Baghdasaryan wrote:
> On Mon, May 16, 2022 at 1:29 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/16/22 1:55 AM, Suren Baghdasaryan wrote:
>>> Introduce process_mrelease syscall sanity tests which include tests
>>> which expect to fail:
>>> - process_mrelease with invalid pidfd and flags inputs
>>> - process_mrelease on a live process with no pending signals
>>> and valid process_mrelease usage which is expected to succeed.
>>> Because process_mrelease has to be used against a process with a pending
>>> SIGKILL, it's possible that the process exits before process_mrelease
>>> gets called. In such cases we retry the test with a victim that allocates
>>> twice more memory up to 1GB. This would require the victim process to
>>> spend more time during exit and process_mrelease has a better chance of
>>> catching the process before it exits and succeeding.
>>>
>>> On success the test reports the amount of memory the child had to
>>> allocate for reaping to succeed. Sample output:
>>>       Success reaping a child with 1MB of memory allocations
>>>
>>> On failure the test reports the failure. Sample outputs:
>>>       All process_mrelease attempts failed!
>>>       process_mrelease: Invalid argument
>>>
>>
>> Nit: Please format this better - include actual example output from the
>> command and how to run the test examples.
> 
> Hmm... Those are the actual outputs from the command and it does not
> take any input arguments. Do you mean smth like this:
> 
> $ mrelease_test
> Success reaping a child with 1MB of memory allocations
> 
> $ mrelease_test
> All process_mrelease attempts failed!
> 
> $ mrelease_test
> process_mrelease: Invalid argument
> 
> ?

This looks good.

> 
>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>    tools/testing/selftests/vm/.gitignore      |   1 +
>>>    tools/testing/selftests/vm/Makefile        |   1 +
>>>    tools/testing/selftests/vm/mrelease_test.c | 214 +++++++++++++++++++++
>>>    tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
>>>    4 files changed, 232 insertions(+)
>>>    create mode 100644 tools/testing/selftests/vm/mrelease_test.c
>>>

[snip]

>>
>> Okay these above 3 routines are called once. I am not seeing any point
>> in making these separate routines. I made the same comment on v1.
> 
> I must have misunderstood your previous comment. Will change.
> 

Thank you.

>>

>>
>> Now the above code can be a separate function which will make it readable.
> 
> Ack.
> 
>>

>>> +
>>
>> Why do you need these ifdefs - syscall will return ENOSYS and you can
>> key off that. Please take a look at other usages of syscall in the
>> repo.
> 
> The issue is that I need to provide the syscall number when calling
> syscall() (in my case __NR_pidfd_open and __NR_process_mrelease) and
> if that number is not defined in the userspace headers on a given
> system then what should I pass instead?
> When implementing this I followed the examples of
> https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/memfd_secret.c#L30
> and https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/userfaultfd.c#L65.
> My original implementation was modeled after this approach:
> https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/mlock2.h#L15.
> If none of these are correct, could you please point me to the example
> you want me to follow?
> 

kselftests include kernel headers. As long as these syscalls are
defined in the kernel headers, the test will build.

Looks it is defined in include/uapi/asm-generic/unistd.h

You can assume it is defined and then if we find architectures that
don't, you can follow what tools/testing/selftests/pidfd/pidfd.h
does.

This way the test can simply call syscall and handle ENOSYS.

thanks,
-- Shuah




