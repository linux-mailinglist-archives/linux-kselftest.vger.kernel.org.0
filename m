Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F76BBF5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjCOVr6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjCOVr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 17:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F66B977
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678916839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzHsIdU3m4ZPZ+Fn4mq+l2BgK390N6OcjPBD6SNBiec=;
        b=CWghwsc0TnIOsrAx53PkilReocfx4RvwS5YOyJd105DohDAwL7UI/KFoV0YxgPLEwKHiFW
        XsXRHs67C71q13N3EIy0arqDnIAuGVGBDZAkImY8XlT+4OOKUzZ+2B1HbRX8BmijGhhu14
        USMTZydeFuhz0EmR9DnHdPkRptGHSdI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-XtPqQNvmMw63Aa3i9jcHwQ-1; Wed, 15 Mar 2023 17:47:15 -0400
X-MC-Unique: XtPqQNvmMw63Aa3i9jcHwQ-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b003e10d3e1c23so1597891wms.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 14:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916834;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzHsIdU3m4ZPZ+Fn4mq+l2BgK390N6OcjPBD6SNBiec=;
        b=04y/siDrXqf4hjISBNS2I6JULzSU8t39oBj6BiVJjWiRIC1SUJCV3Cnf4kiWJQBRTb
         4kpxlDk+3kYZcWge03OTO69sbwD6OVUV0vatl5yJ9jmg24LujOW4/VJlwzqIU+CLJfV5
         d1Aw3nVa3ohnw7IluPbExq4IwhtPfswbUKrquzY1LRgb71L4tOB+Ug0DvRvPFoPCeu+n
         B6fKkEBduQMAQQjdk0kLkGTvyobZaAPcqGPUcPRHXKZWbVszUIC/nzgxEjuMvswqOaiH
         YARbrrnU6eubHaEdbjsSip/ZJCMc/qMADz1ZcyGfM07t8+5HCrN4Utt4fUFU3bCRZS/z
         HdZA==
X-Gm-Message-State: AO0yUKWAi9Glq1HZqw3hpxGSeJYL/0oB8TGdyz4Eu9etuZpWhSsnRftv
        +ieFoKgDU40iI6iwmFUQM1BZxg2TCKxXEYcJNAh2v1FqM+2DyehJHIUa6JJ1SOx9mUIff69lVVW
        7yMwIPHF0ckRrBKr5E6UXh3eonlB8
X-Received: by 2002:adf:d0cb:0:b0:2ce:a6be:2bd with SMTP id z11-20020adfd0cb000000b002cea6be02bdmr2950859wrh.1.1678916834395;
        Wed, 15 Mar 2023 14:47:14 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ni6+8w5yOlHeBDamsaqeVxh0pzxFcbK3le1wv656bEc31mDssO2ZwpVB/It+BPM1a4ympQA==
X-Received: by 2002:adf:d0cb:0:b0:2ce:a6be:2bd with SMTP id z11-20020adfd0cb000000b002cea6be02bdmr2950838wrh.1.1678916834010;
        Wed, 15 Mar 2023 14:47:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000101000b002c54e26bca5sm5677331wrx.49.2023.03.15.14.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 14:47:13 -0700 (PDT)
Message-ID: <70340c6e-cf3e-746a-4893-7978e11d3817@redhat.com>
Date:   Wed, 15 Mar 2023 22:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, Mike Kravetz <mike.kravetz@oracle.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <273a2f82-928f-5ad1-0988-1a886d169e83@redhat.com>
 <20230315210545.GA116016@cmpxchg.org> <20230315211927.GB116016@cmpxchg.org>
 <c6a1c4fd-d8be-7942-bfe7-dc0e661a9c99@redhat.com>
Organization: Red Hat
In-Reply-To: <c6a1c4fd-d8be-7942-bfe7-dc0e661a9c99@redhat.com>
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

On 15.03.23 22:45, David Hildenbrand wrote:
> On 15.03.23 22:19, Johannes Weiner wrote:
>> On Wed, Mar 15, 2023 at 05:05:47PM -0400, Johannes Weiner wrote:
>>> On Wed, Mar 15, 2023 at 09:03:57PM +0100, David Hildenbrand wrote:
>>>> On 10.03.23 19:28, Stefan Roesch wrote:
>>>>> So far KSM can only be enabled by calling madvise for memory regions. To
>>>>> be able to use KSM for more workloads, KSM needs to have the ability to be
>>>>> enabled / disabled at the process / cgroup level.
>>>>>
>>>>> Use case 1:
>>>>> The madvise call is not available in the programming language. An example for
>>>>> this are programs with forked workloads using a garbage collected language without
>>>>> pointers. In such a language madvise cannot be made available.
>>>>>
>>>>> In addition the addresses of objects get moved around as they are garbage
>>>>> collected. KSM sharing needs to be enabled "from the outside" for these type of
>>>>> workloads.
>>>>>
>>>>> Use case 2:
>>>>> The same interpreter can also be used for workloads where KSM brings no
>>>>> benefit or even has overhead. We'd like to be able to enable KSM on a workload
>>>>> by workload basis.
>>>>>
>>>>> Use case 3:
>>>>> With the madvise call sharing opportunities are only enabled for the current
>>>>> process: it is a workload-local decision. A considerable number of sharing
>>>>> opportuniites may exist across multiple workloads or jobs. Only a higler level
>>>>> entity like a job scheduler or container can know for certain if its running
>>>>> one or more instances of a job. That job scheduler however doesn't have
>>>>> the necessary internal worklaod knowledge to make targeted madvise calls.
>>>>>
>>>>> Security concerns:
>>>>> In previous discussions security concerns have been brought up. The problem is
>>>>> that an individual workload does not have the knowledge about what else is
>>>>> running on a machine. Therefore it has to be very conservative in what memory
>>>>> areas can be shared or not. However, if the system is dedicated to running
>>>>> multiple jobs within the same security domain, its the job scheduler that has
>>>>> the knowledge that sharing can be safely enabled and is even desirable.
>>>>>
>>>>> Performance:
>>>>> Experiments with using UKSM have shown a capacity increase of around 20%.
>>>>
>>>> Stefan, can you do me a favor and investigate which pages we end up
>>>> deduplicating -- especially if it's mostly only the zeropage and if it's
>>>> still that significant when disabling THP?
>>>>
>>>>
>>>> I'm currently investigating with some engineers on playing with enabling KSM
>>>> on some selected processes (enabling it blindly on all VMAs of that process
>>>> via madvise() ).
>>>>
>>>> One thing we noticed is that such (~50 times) 20MiB processes end up saving
>>>> ~2MiB of memory per process. That made me suspicious, because it's the THP
>>>> size.
>>>>
>>>> What I think happens is that we have a 2 MiB area (stack?) and only touch a
>>>> single page. We get a whole 2 MiB THP populated. Most of that THP is zeroes.
>>>>
>>>> KSM somehow ends up splitting that THP and deduplicates all resulting
>>>> zeropages. Thus, we "save" 2 MiB. Actually, it's more like we no longer
>>>> "waste" 2 MiB. I think the processes with KSM have less (none) THP than the
>>>> processes with THP enabled, but I only took a look at a sample of the
>>>> process' smaps so far.
>>>
>>> THP and KSM is indeed an interesting problem. Better TLB hits with
>>> THPs, but reduced chance of deduplicating memory - which may or may
>>> not result in more IO that outweighs any THP benefits.
>>>
>>> That said, the service in the experiment referenced above has swap
>>> turned on and is under significant memory pressure. Unused splitpages
>>> would get swapped out. The difference from KSM was from deduplicating
>>> pages that were in active use, not internal THP fragmentation.
>>
>> Brainfart, my apologies. It could have been the ksm-induced splits
>> themselves that allowed the unused subpages to get swapped out in the
>> first place.
> 
> Yes, it's not easy to spot that this is implemented. I just wrote a
> simple reproducer to confirm: modifying a single subpage in a bunch of
> THP ranges will populate a THP whereby most of the THP is zeroes.
> 
> As long as you keep accessing the single subpage via the PMD I assume
> chances of getting it swapped out are lower, because the folio will be
> references/dirty.
> 
> KSM will come around and split the THP filled mostly with zeroes and
> deduplciate the resulting zero pages.
> 
> [that's where a zeropage-only KSM could be very valuable eventually I think]
> 
>>
>> But no, I double checked that workload just now. On a weekly average,
>> it has about 50 anon THPs and 12 million regular anon. THP is not a
>> factor in the reduction results.
> 
> You mean with KSM enabled or with KSM disabled for the process? Not sure
> if your observation reliably implies that the scenario described
> couldn't have happened, but it's late in Germany already :)
> 
> In any case, it would be nice to get a feeling for how much variety in
> these 20% of deduplicated pages are. For example, if it's 99% the same
> page or just a wild collection.
> 
> Maybe "cat /sys/kernel/mm/ksm/pages_shared" would be expressive already.
> But I seem to be getting "126" in my simple example where only zeropages
> should get deduplicated, so I have to take another look at the stats
> tomorrow ...
> 

On second thought, I guess it's because of "max_page_sharing". So one 
has to set that really high to make pages_shared more expressive.

-- 
Thanks,

David / dhildenb

