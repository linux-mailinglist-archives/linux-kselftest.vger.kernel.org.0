Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53F6BBF54
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 22:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjCOVqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 17:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCOVqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 17:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF9E72012
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678916735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2w0EoBdyGMAStnY9ncA9Hff5vn5E9IGC8OhITWijw/M=;
        b=FMbml4r2hMF98wNYgYixPtNuhGzZTOdzIbYKLaOLd01wq/iKhRwOeqN0sxbpQt3q5Rb22q
        Olr0qkKMe2XuGb+JBiWcaW4F2JwzSCLOs2cKPJ0EZfiPs9tVxzAzMN6vgAR+hvcYVDlZKh
        neBd/yGOf0NIuhAx5LXKKgMlfOEJ+Ws=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-amR1g7BSPYOveviG_YMbbw-1; Wed, 15 Mar 2023 17:45:34 -0400
X-MC-Unique: amR1g7BSPYOveviG_YMbbw-1
Received: by mail-wm1-f69.google.com with SMTP id v8-20020a05600c470800b003ed3b575374so635902wmo.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 14:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916733;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w0EoBdyGMAStnY9ncA9Hff5vn5E9IGC8OhITWijw/M=;
        b=MTj0QPVSIBGR6m1hKQQkq7rjAZXWfccbEOXk2mgHZU0y6O3cBOAk6xKcxQPWfc7kxb
         BI/WOcSuDjAnKpaAoUPdq7ZHGfn2LpfICHVDda6HWAiv0L65gnSSmP9H4nbVbWpNE4n9
         2xazygxWOL7cs45qoo18XkGmXKro9opLXppwRnwtPAV4/6aEYQiX/RRm3SQsnTPjxCKM
         OnjgEhWDWBC8uJfTYKL2jyf1z6He7bawRX4fgMQHy1tHhCkYqp+uoEhhYzGZ6Misx8ph
         pxCW0fomXurTsB0Z07rp/G8jUuXKwkjDCaKn5lqRBB14GZv3cA5vTBFuLLSJ6S5o/DWi
         iKiQ==
X-Gm-Message-State: AO0yUKWiYyfLb5nVnW6mtI2g1rrW7uANRRkaHK+pmvfHgUkCnZOiGc8m
        9psrSgR62WRPROAeXI36ntPYooXKI9k7Vdl6g8+jhQezu6tFGiy56dUKhhpFei4c6XTJeNoZNIk
        Qpg1vA3zkYaTrVubgH7LEk5JK4IOl
X-Received: by 2002:a05:600c:b8c:b0:3ed:2f1a:883c with SMTP id fl12-20020a05600c0b8c00b003ed2f1a883cmr6853231wmb.14.1678916732980;
        Wed, 15 Mar 2023 14:45:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set9DJlfSAzyK1UirrgQ3RE0vPytiyldFZWHR/k2PWAfw/ZZ52cTw/0QmNxiag4vGApkQU2kUxw==
X-Received: by 2002:a05:600c:b8c:b0:3ed:2f1a:883c with SMTP id fl12-20020a05600c0b8c00b003ed2f1a883cmr6853214wmb.14.1678916732598;
        Wed, 15 Mar 2023 14:45:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe785000000b002c7066a6f77sm5610937wrm.31.2023.03.15.14.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 14:45:32 -0700 (PDT)
Message-ID: <c6a1c4fd-d8be-7942-bfe7-dc0e661a9c99@redhat.com>
Date:   Wed, 15 Mar 2023 22:45:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <273a2f82-928f-5ad1-0988-1a886d169e83@redhat.com>
 <20230315210545.GA116016@cmpxchg.org> <20230315211927.GB116016@cmpxchg.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
In-Reply-To: <20230315211927.GB116016@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15.03.23 22:19, Johannes Weiner wrote:
> On Wed, Mar 15, 2023 at 05:05:47PM -0400, Johannes Weiner wrote:
>> On Wed, Mar 15, 2023 at 09:03:57PM +0100, David Hildenbrand wrote:
>>> On 10.03.23 19:28, Stefan Roesch wrote:
>>>> So far KSM can only be enabled by calling madvise for memory regions. To
>>>> be able to use KSM for more workloads, KSM needs to have the ability to be
>>>> enabled / disabled at the process / cgroup level.
>>>>
>>>> Use case 1:
>>>> The madvise call is not available in the programming language. An example for
>>>> this are programs with forked workloads using a garbage collected language without
>>>> pointers. In such a language madvise cannot be made available.
>>>>
>>>> In addition the addresses of objects get moved around as they are garbage
>>>> collected. KSM sharing needs to be enabled "from the outside" for these type of
>>>> workloads.
>>>>
>>>> Use case 2:
>>>> The same interpreter can also be used for workloads where KSM brings no
>>>> benefit or even has overhead. We'd like to be able to enable KSM on a workload
>>>> by workload basis.
>>>>
>>>> Use case 3:
>>>> With the madvise call sharing opportunities are only enabled for the current
>>>> process: it is a workload-local decision. A considerable number of sharing
>>>> opportuniites may exist across multiple workloads or jobs. Only a higler level
>>>> entity like a job scheduler or container can know for certain if its running
>>>> one or more instances of a job. That job scheduler however doesn't have
>>>> the necessary internal worklaod knowledge to make targeted madvise calls.
>>>>
>>>> Security concerns:
>>>> In previous discussions security concerns have been brought up. The problem is
>>>> that an individual workload does not have the knowledge about what else is
>>>> running on a machine. Therefore it has to be very conservative in what memory
>>>> areas can be shared or not. However, if the system is dedicated to running
>>>> multiple jobs within the same security domain, its the job scheduler that has
>>>> the knowledge that sharing can be safely enabled and is even desirable.
>>>>
>>>> Performance:
>>>> Experiments with using UKSM have shown a capacity increase of around 20%.
>>>
>>> Stefan, can you do me a favor and investigate which pages we end up
>>> deduplicating -- especially if it's mostly only the zeropage and if it's
>>> still that significant when disabling THP?
>>>
>>>
>>> I'm currently investigating with some engineers on playing with enabling KSM
>>> on some selected processes (enabling it blindly on all VMAs of that process
>>> via madvise() ).
>>>
>>> One thing we noticed is that such (~50 times) 20MiB processes end up saving
>>> ~2MiB of memory per process. That made me suspicious, because it's the THP
>>> size.
>>>
>>> What I think happens is that we have a 2 MiB area (stack?) and only touch a
>>> single page. We get a whole 2 MiB THP populated. Most of that THP is zeroes.
>>>
>>> KSM somehow ends up splitting that THP and deduplicates all resulting
>>> zeropages. Thus, we "save" 2 MiB. Actually, it's more like we no longer
>>> "waste" 2 MiB. I think the processes with KSM have less (none) THP than the
>>> processes with THP enabled, but I only took a look at a sample of the
>>> process' smaps so far.
>>
>> THP and KSM is indeed an interesting problem. Better TLB hits with
>> THPs, but reduced chance of deduplicating memory - which may or may
>> not result in more IO that outweighs any THP benefits.
>>
>> That said, the service in the experiment referenced above has swap
>> turned on and is under significant memory pressure. Unused splitpages
>> would get swapped out. The difference from KSM was from deduplicating
>> pages that were in active use, not internal THP fragmentation.
> 
> Brainfart, my apologies. It could have been the ksm-induced splits
> themselves that allowed the unused subpages to get swapped out in the
> first place.

Yes, it's not easy to spot that this is implemented. I just wrote a 
simple reproducer to confirm: modifying a single subpage in a bunch of 
THP ranges will populate a THP whereby most of the THP is zeroes.

As long as you keep accessing the single subpage via the PMD I assume 
chances of getting it swapped out are lower, because the folio will be 
references/dirty.

KSM will come around and split the THP filled mostly with zeroes and 
deduplciate the resulting zero pages.

[that's where a zeropage-only KSM could be very valuable eventually I think]

> 
> But no, I double checked that workload just now. On a weekly average,
> it has about 50 anon THPs and 12 million regular anon. THP is not a
> factor in the reduction results.

You mean with KSM enabled or with KSM disabled for the process? Not sure 
if your observation reliably implies that the scenario described 
couldn't have happened, but it's late in Germany already :)

In any case, it would be nice to get a feeling for how much variety in 
these 20% of deduplicated pages are. For example, if it's 99% the same 
page or just a wild collection.

Maybe "cat /sys/kernel/mm/ksm/pages_shared" would be expressive already. 
But I seem to be getting "126" in my simple example where only zeropages 
should get deduplicated, so I have to take another look at the stats 
tomorrow ...

-- 
Thanks,

David / dhildenb

