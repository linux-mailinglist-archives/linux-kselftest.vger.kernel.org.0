Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED86B1137
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 19:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCHSmY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 13:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCHSmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 13:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D66CAF28A
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 10:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678300890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWZnH/S2SSsps7LCJKfYBHl/qAsBXwWRiKVfSsyg8WE=;
        b=hLKqKm/FfiVp/sgcBs3MjsIY/eZt1wlwMPZSh5MkP+8wKR6F3G1h94u22GGgq2Kvj+ABsE
        TYWTqubhSZjzLUARRNS/sQywI4wRkIJzQNW87x31bu26gkqpzZxvt41Y2AJ0/gtnDOm65v
        FpAmdrTqstmk7VtsFkGjsPYNJbmcK0Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-c1c_n-vJOYOdApyagPtKxQ-1; Wed, 08 Mar 2023 13:41:29 -0500
X-MC-Unique: c1c_n-vJOYOdApyagPtKxQ-1
Received: by mail-wm1-f69.google.com with SMTP id bi21-20020a05600c3d9500b003e836e354e0so1150761wmb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 10:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300888;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWZnH/S2SSsps7LCJKfYBHl/qAsBXwWRiKVfSsyg8WE=;
        b=i9e84PvgNtrst4W709iFykiKUzJaDAFvGH2qQbZITT6fH6Tc8n4QeX1wtcf7MDN/3i
         dfhEhIBNXjji9m8EmlnIWbYtJ7RmvVszIKbjhad8G/uLPFKzipytuUqHX8AsJJlqFLT/
         L8zFfROSgB4+c7KJMfLvKkUk0m/VP6lhRy+Lb1cI6XmTjb9C1BnesSDSOj6wllFQKbMz
         XdPriLvBHtj3xXYR4n3gM+yuNKmbIrH2n8a5wTg2WWSIdyYw8lBaeLZ2cF9DTDGzjUZV
         zvbKvZmYIa1DuCr+dhf1q1IwxBlIJm3DxxhXXxX2IQzQvpFvW8lXkSoM7NQW4bn4lZ/5
         ZzlA==
X-Gm-Message-State: AO0yUKVxARaS72hPU/lDvHLlvaRAYli7M1N/ppuHltMSHI5HXXmQ7LiV
        8LabQ+iadZIwOpBD6wsD8C0AwcNeS+zZ3HjBd437HkcJeSzi3rSZMWLqk9Btzsy7d8DDaCAgI2n
        hyprlrHEeff6opfv/coEYdzT9UWuD
X-Received: by 2002:adf:f58b:0:b0:2c3:f8ea:da26 with SMTP id f11-20020adff58b000000b002c3f8eada26mr16652260wro.32.1678300887902;
        Wed, 08 Mar 2023 10:41:27 -0800 (PST)
X-Google-Smtp-Source: AK7set93OfqYv05KREWPRO+0DybPoGhN1GL8gAnuaMlfcRqFfsvDFgS21mzSjowtRSl6fzupzlTwMQ==
X-Received: by 2002:adf:f58b:0:b0:2c3:f8ea:da26 with SMTP id f11-20020adff58b000000b002c3f8eada26mr16652246wro.32.1678300887477;
        Wed, 08 Mar 2023 10:41:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:cb00:d372:1da8:9e9e:422d? (p200300cbc71bcb00d3721da89e9e422d.dip0.t-ipconnect.de. [2003:cb:c71b:cb00:d372:1da8:9e9e:422d])
        by smtp.gmail.com with ESMTPSA id p13-20020a056000018d00b002c5691f13eesm15692031wrx.50.2023.03.08.10.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:41:27 -0800 (PST)
Message-ID: <f531ab1e-5fc0-c47a-b3e9-2e9c2f76ab81@redhat.com>
Date:   Wed, 8 Mar 2023 19:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org
References: <20230224044000.3084046-1-shr@devkernel.io>
 <d9727ac4-4976-0de7-2d16-676ad7db5e89@redhat.com>
 <20230308173006.GA476158@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 0/3] mm: process/cgroup ksm support
In-Reply-To: <20230308173006.GA476158@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


>> One point that popped up in the past and that I raised on the last RFC: we
>> should think about letting processes *opt out/disable* KSM on their own.
>> Either completely, or for selected VMAs.
>>
>> Reasoning is, that if you have an application that really doesn't want some
>> memory regions to be applicable to KSM (memory de-duplication attacks?
>> Knowing that KSM on some regions will be counter-productive)
>>
>> For example, remembering if MADV_UNMERGEABLE was called and not only
>> clearing the VMA flag. So even if KSM would be force-enabled by some tooling
>> after the process started, such regions would not get considered for KSM.
>>
>> It would a bit like how we handle THP.
> 
> I'm not sure the THP comparison is apt. THP is truly a local
> optimization that depends on the workload's access patterns. The
> environment isn't a true factor. It makes some sense that if there is
> a global policy to generally use THP the workload be able to opt out
> based on known sparse access patterns. At least until THP allocation
> strategy inside the kernel becomes smarter!

Yes, and some features really don't want THP, at least for some period 
of time (e.g., userfaultfd), because they are to some degree 
incompatible with the idea of THP populating more memory than was accessed.

Page pinning + KSM was one of the remaining cases where force-enabling 
KSM could have made a real difference (IOW buggy) that we discussed the 
last time this was proposed. That should be fixed now. I guess besides 
that, most features should be compatible with KSM nowadays. So 
force-enabling it should not result in actual issues I guess.

> 
> Merging opportunities and security questions are trickier. The
> application might know which data is sensitive, but it doesn't know
> whether its environment is safe or subject do memory attacks, so it
> cannot make that decision purely from inside.

I agree regarding security. Regarding merging opportunities, I am not so 
sure. There are certainly examples where an application knows best that 
memory deduplication is mostly a lost bet (if a lot of randomization or 
pointers are involved most probably).

> 
> There is a conceivable usecase where multiple instances of the same
> job are running inside a safe shared security domain and using the
> same sensitive data.

Yes. IMHO, such special applications could just enable KSM manually, 
though, instead of enabling it for each and every last piece of 
anonymous memory that doesn't make sense to get deduplciated :)

But of course, I see the simplicity in just enabling it globally.

> 
> There is a conceivable usecase where the system and the workload
> collaborate to merge insensitive data across security domains.
> 
> I'm honestly not sure which usecase is more likely. My gut feeling is
> the first one, simply because of broader concerns of multiple security
> domains sharing kernel instances or physical hardware.
> 

See my side note below.

>> On 24.02.23 05:39, Stefan Roesch wrote:
>>> So far KSM can only be enabled by calling madvise for memory regions. To
>>> be able to use KSM for more workloads, KSM needs to have the ability to be
>>> enabled / disabled at the process / cgroup level.
>>>
>>> Use case 1:
>>> The madvise call is not available in the programming language. An example for
>>> this are programs with forked workloads using a garbage collected language without
>>> pointers. In such a language madvise cannot be made available.
>>>
>>> In addition the addresses of objects get moved around as they are garbage
>>> collected. KSM sharing needs to be enabled "from the outside" for these type of
>>> workloads.
>>>
>>> Use case 2:
>>> The same interpreter can also be used for workloads where KSM brings no
>>> benefit or even has overhead. We'd like to be able to enable KSM on a workload
>>> by workload basis.
>>>
>>> Use case 3:
>>> With the madvise call sharing opportunities are only enabled for the current
>>> process: it is a workload-local decision. A considerable number of sharing
>>> opportuniites may exist across multiple workloads or jobs. Only a higler level
>>> entity like a job scheduler or container can know for certain if its running
>>> one or more instances of a job. That job scheduler however doesn't have
>>> the necessary internal worklaod knowledge to make targeted madvise calls.
>>>
>>> Security concerns:
>>> In previous discussions security concerns have been brought up. The problem is
>>> that an individual workload does not have the knowledge about what else is
>>> running on a machine. Therefore it has to be very conservative in what memory
>>> areas can be shared or not. However, if the system is dedicated to running
>>> multiple jobs within the same security domain, its the job scheduler that has
>>> the knowledge that sharing can be safely enabled and is even desirable.
>>
>> Note that there are some papers about why limiting memory deduplciation
>> attacks to single security domains is not sufficient. Especially, the remote
>> deduplication attacks fall into that category IIRC.
> 
> I think it would be good to elaborate on that and include any caveats
> in the documentation.

Yes. The main point I would make is that we should encourage eventual 
users to think twice instead of blindly enabling this feature. Good 
documentation is certainly helpful.

> 
> Ultimately, the bar isn't whether there are attack vectors on a subset
> of possible usecases, but whether there are usecases where this can be
> used safely, which is obviously true.

I agree. But still I have to raise that the security implications might 
be rather subtle and surprising (e.g., single security domain). Sure, 
there are setups that certainly don't care, I totally agree.



Side note:


Of course, I wonder how many workloads would place identical data into 
anonymous memory where it would have to get deduplicated instead, say, 
mmaping a file instead.

In the VM world it all makes sense to me, because the kernel, libraries, 
...executables may be identical and loaded into guest memory (-> 
anonymous memory) where we'd just wish to deduplciate them. In ordinary 
process, I'm not so sure how much deduplication potential there really 
is once pointers etc. are involved and memory allocators go crazy on 
placing unrelated data into the same page. There is one prime example, 
though, that might be different, which is the shared zeropage I guess.


I'd be curious which data the mentioned 20% actually deduplicate: 
according to [1], some workloads mostly only deduplicate the shared 
zeropage (in their Microsoft Edge scenario, 84% -- 93% of all 
deduplicated pages are zeropage). Deduplicating the shared zeropage is 
obviously "less security" relevant and one could optimize KSM easily to 
only try deduplicating that and avoid a lot of unstable nodes.

Of course, just a thought on memory deduplication on process level.


[1] https://ieeexplore.ieee.org/document/7546546

-- 
Thanks,

David / dhildenb

