Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3886D9E3B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbjDFRMB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbjDFRLz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 13:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2B83F2
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680801064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9BEmWCga9rATnS7k1cV/U68L/kkD9CUtlqpFM/Am+c=;
        b=ekiveZ47v8KiOMq2aP/0AY6VvV65dQOBxZHBcx1teBQiL/DBt2hOCYo7e0Qdu8eEwYVhXk
        +fSndhNS/mg7/eexh4FNuoIrNuagBxHICRukONxMDYS/aoqGG3UhBwhPrwNWe3OUyhaOt9
        w7xgSCkRl3NP0A5Ocb4csxDtJzZ9dJ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-qr_l4LhfPuKvWxP6VPb1Cw-1; Thu, 06 Apr 2023 13:11:03 -0400
X-MC-Unique: qr_l4LhfPuKvWxP6VPb1Cw-1
Received: by mail-wr1-f69.google.com with SMTP id o13-20020adfa10d000000b002d34203df59so5005399wro.9
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 10:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801062; x=1683393062;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9BEmWCga9rATnS7k1cV/U68L/kkD9CUtlqpFM/Am+c=;
        b=x2bmWJNEBrU6O4NxbzIu+twKJaUNH9VL0wpegtqGGef5jTNOeEoNKCY883+OmdvEq9
         ZuaPgne89FF4sQNBCul8/6dqmYxd05ip0W4Gu+oTPGkBiwXMuwHuw2b3aQn9YqKizFAg
         C/znIs2UF3aQ3DObH97fqIi2W+fxdg4VJ6yNJGHHfGoPFGcWewrZkfs4Wd9pqtzTgJVa
         uhbsTu7tJ+9k8HmfEiZDf8r2FZBcbZoYlJY8b9VekZ3rjltDAYuNzH3+M8ZLfi24o7Zk
         H2NFi35mN2S5xdj2ziqVm0VM9bnreBxJk1k+phSeSUJucV6VU+hePMvtupuDJ1f6rZ12
         p6hw==
X-Gm-Message-State: AAQBX9fGmge1ZMhpottqgasT4iS7GAzbkXdNda++xtYP+k5TIfZMaubG
        CEUraPvs+1T6PRReEF6dn9DsWfQvB85UQriyXhS176ls0xI9SiMNtwbYY0Pmv7adCoOo5QKATvp
        Hk4EtHnza0YC/SN/9YCyvutqPm26i
X-Received: by 2002:adf:f201:0:b0:2cf:e74f:2957 with SMTP id p1-20020adff201000000b002cfe74f2957mr7401239wro.33.1680801062100;
        Thu, 06 Apr 2023 10:11:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350avrWUB3Clk/HKyyujt4hLYkFiffOizvgUlgZPG1DjbaTTYFi5GJEZjRmoaZaveorZkIYNxLg==
X-Received: by 2002:adf:f201:0:b0:2cf:e74f:2957 with SMTP id p1-20020adff201000000b002cfe74f2957mr7401219wro.33.1680801061763;
        Thu, 06 Apr 2023 10:11:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:6300:a8be:c1ad:41a1:2bf7? (p200300cbc7056300a8bec1ad41a12bf7.dip0.t-ipconnect.de. [2003:cb:c705:6300:a8be:c1ad:41a1:2bf7])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b003ef67848a21sm5825259wmb.13.2023.04.06.10.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:11:01 -0700 (PDT)
Message-ID: <10dd1fd4-4d10-c25d-174b-de37f01bef48@redhat.com>
Date:   Thu, 6 Apr 2023 19:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230328160914.5b6b66e4a5ad39e41fd63710@linux-foundation.org>
 <37dcd52a-2e32-c01d-b805-45d862721fbc@redhat.com>
 <ZCWcJelF5bEdF4N3@cmpxchg.org>
 <ff599dc1-729d-52dc-d605-8a8ac890ad15@redhat.com>
 <qvqwv8ii89x6.fsf@dev0134.prn3.facebook.com>
 <f969cb1f-651f-592f-7540-89f73e175c7d@redhat.com>
 <qvqwlej8vrst.fsf@dev0134.prn3.facebook.com>
 <qvqw4jptc59w.fsf@dev0134.prn3.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <qvqw4jptc59w.fsf@dev0134.prn3.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06.04.23 18:59, Stefan Roesch wrote:
> 
> Stefan Roesch <shr@devkernel.io> writes:
> 
>> David Hildenbrand <david@redhat.com> writes:
>>
>>>>>> Obviously we could spend months analysing which exact allocations are
>>>>>> identical, and then more months or years reworking the architecture to
>>>>>> deduplicate them by hand and in userspace. But this isn't practical,
>>>>>> and KSM is specifically for cases where this isn't practical.
>>>>>> Based on your request in the previous thread, we investigated whether
>>>>>> the boost was coming from the unintended side effects of KSM splitting
>>>>>> THPs. This wasn't the case.
>>>>>> If you have other theories on how the results could be bogus, we'd be
>>>>>> happy to investigate those as well. But you have to let us know what
>>>>>> you're looking for.
>>>>>>
>>>>>
>>>>> Maybe I'm bad at making such requests but
>>>>>
>>>>> "Stefan, can you do me a favor and investigate which pages we end up
>>>>> deduplicating -- especially if it's mostly only the zeropage and if it's
>>>>> still that significant when disabling THP?"
>>>>>
>>>>> "In any case, it would be nice to get a feeling for how much variety in
>>>>> these 20% of deduplicated pages are. "
>>>>>
>>>>> is pretty clear to me. And shouldn't take months.
>>>>>
>>>
>>> Just to clarify: the details I requested are not meant to decide whether to
>>> reject the patch set (I understand that it can be beneficial to have); I
>>> primarily want to understand if we're really dealing with a workload where KSM
>>> is able to deduplicate pages that are non-trivial, to maybe figure out if there
>>> are other workloads that could similarly benefit -- or if we could optimize KSM
>>> for these specific cases or avoid the memory deduplication altogether.
>>>
>>> In contrast to e.g.:
>>>
>>> 1) THP resulted in many zeropages we end up deduplicating again. The THP
>>>     placement was unfortunate.
>>>
>>> 2) Unoptimized memory allocators that leave many identical pages mapped
>>>     after freeing up memory (e.g., zeroed pages, pages all filled with
>>>     poison values) instead of e.g., using MADV_DONTNEED to free up that
>>>     memory.
>>>
>>>
>>
>> I repeated an experiment with and without KSM. In terms of THP there is
>> no huge difference between the two. On a 64GB main memory machine I see
>> between 100 - 400MB in AnonHugePages.
>>
>>>> /sys/kernel/mm/ksm/pages_shared is over 10000 when we run this on an
>>>> Instagram workload. The workload consists of 36 processes plus a few
>>>> sidecar processes.
>>>
>>> Thanks! To which value is /sys/kernel/mm/ksm/max_page_sharing set in that
>>> environment?
>>>
>>
>> It's set to the standard value of 256.
>>
>> In the meantime I have run experiments with different settings for
>> pages_to_scan. With the default value of 100, we only get a relatively
>> small benefit of KSM. If I increase the value to for instance to 2000 or
>> 3000 the savings are substantial. (The workload is memory bound, not
>> CPU bound).
>>
>> Here are some stats for setting pages_to_scan to 3000:
>>
>> full_scans: 560
>> general_profit: 20620539008
>> max_page_sharing: 256
>> merge_across_nodes: 1
>> pages_shared: 125446
>> pages_sharing: 5259506
>> pages_to_scan: 3000
>> pages_unshared: 1897537
>> pages_volatile: 12389223
>> run: 1
>> sleep_millisecs: 20
>> stable_node_chains: 176
>> stable_node_chains_prune_millisecs: 2000
>> stable_node_dups: 2604
>> use_zero_pages: 0
>> zero_pages_sharing: 0
>>
>>
>>> What would be interesting is pages_shared after max_page_sharing was set to a
>>> very high number such that pages_shared does not include duplicates. Then
>>> pages_shared actually expresses how many different pages we deduplicate. No need
>>> to run without THP in that case.
>>>
>>
>> Thats on my list for the next set of experiments.
>>
> 
> In the new experiment I increased the max_page_sharing value to 16384.
> This reduced the number of stable_node_dups considerably (its around 3%
> of the previous value). However pages_sharing is still very high for
> this workload.
> 
> full_scans: 138
> general_profit: 24442268608
> max_page_sharing: 16384
> merge_across_nodes: 1
> pages_shared: 144590
> pages_sharing: 6230983
> pages_to_scan: 3000
> pages_unshared: 2120307
> pages_volatile: 14590780
> run: 1
> sleep_millisecs: 20
> stable_node_chains: 23
> stable_node_chains_prune_millisecs: 2000
> stable_node_dups: 78
> use_zero_pages: 0
> zero_pages_sharing: 0

Interesting, thanks!

I wonder if it's really many interpreters performing (and caching?) 
essentially same blobs (for example, for a JIT the IR and/or target 
executable code). So maybe in general, such multi-instance interpreters 
are a good candidate for KSM. (I recall there were some processes where 
a server would perform and cache the translations instead) But just a 
pure speculation :)

-- 
Thanks,

David / dhildenb

