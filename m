Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC796D413B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjDCJu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 05:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjDCJuj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 05:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577D6A77
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680515343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCVfONq4QX1WJA6KEQBIqDdCC3Zi4ZQ6oAhIXBiY4Aw=;
        b=jO7zvEOgkKgF6O1Tb43/eiqFv7vFtilOq6sJhZiMCqOF2lSCMw7Fcl6o/ms9S70gpV54Io
        5Fo4UY9WtlrPP0IKfutAVoHkVPCI7N3xAi2v96Z4yt5ZQj1J9l3zEywjdw6CLp/4QOa4OC
        ipVR+/9yzTWSQ1X4JRzbCxRY4sPslPg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-mGerhs9nPJulo0K0aR3Fzg-1; Mon, 03 Apr 2023 05:49:02 -0400
X-MC-Unique: mGerhs9nPJulo0K0aR3Fzg-1
Received: by mail-wr1-f72.google.com with SMTP id k16-20020adfd230000000b002cfe7555486so3110140wrh.13
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 02:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515341;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCVfONq4QX1WJA6KEQBIqDdCC3Zi4ZQ6oAhIXBiY4Aw=;
        b=YqW7C7fIwOfhVibFE+lp3CTwpuLUikt3b0edLkplQ+oR9Ih16g9Au9xtkxmaox5L4B
         F8AQuulZSS8wlQ6wf2/58bMsUKIvp030Juw/4r63A5vwoiBf8ZjCJgM8q1LabyTclLRC
         oqacQl+sg2Pqd3DAWej0ceYjTKExvVkUSnCcPnfRhDTMQgtZvYKQn+g+SUID95ifZmM+
         9nvvQeiUfz8uducq6WbmLzcazJV+npHVT19zlQgm29zkkJ+HmKcbDowYvEN2LVSIDjMY
         eSaEycGUt0/fwmXKhzLjwknp1eIGbS3wJgkDxbAtQr8AWMW08raND4Snh+vHhWBVgfC0
         nrxw==
X-Gm-Message-State: AAQBX9dVOZQ2WooEoFYxIl9v47EPD/7HP2tEIIGztDkwAUJ5hFhTEFvt
        qbO18I7ohhVvei+EutmHEDZrvTcjYc79RQufG2ZTDwKmBh576UlHg+z3GSM+mFAotv+g702n6Vl
        ub4DB1Eiv6Zj6fS4iXkbQPxscUcjMPaMSGJg+
X-Received: by 2002:a5d:460b:0:b0:2d2:59cf:468f with SMTP id t11-20020a5d460b000000b002d259cf468fmr13074449wrq.15.1680515341385;
        Mon, 03 Apr 2023 02:49:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350arsxFGGG4mFkfzu2mP7wXMWNJhAfCsHB0QkcMrhf+hYAHPVuXlVhP82orVZo6dQiD7R1JfuA==
X-Received: by 2002:a5d:460b:0:b0:2d2:59cf:468f with SMTP id t11-20020a5d460b000000b002d259cf468fmr13074432wrq.15.1680515341062;
        Mon, 03 Apr 2023 02:49:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002c55ec7f661sm9350194wrr.5.2023.04.03.02.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:49:00 -0700 (PDT)
Message-ID: <f969cb1f-651f-592f-7540-89f73e175c7d@redhat.com>
Date:   Mon, 3 Apr 2023 11:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 0/3] mm: process/cgroup ksm support
In-Reply-To: <qvqwv8ii89x6.fsf@dev0134.prn3.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>>> Obviously we could spend months analysing which exact allocations are
>>> identical, and then more months or years reworking the architecture to
>>> deduplicate them by hand and in userspace. But this isn't practical,
>>> and KSM is specifically for cases where this isn't practical.
>>> Based on your request in the previous thread, we investigated whether
>>> the boost was coming from the unintended side effects of KSM splitting
>>> THPs. This wasn't the case.
>>> If you have other theories on how the results could be bogus, we'd be
>>> happy to investigate those as well. But you have to let us know what
>>> you're looking for.
>>>
>>
>> Maybe I'm bad at making such requests but
>>
>> "Stefan, can you do me a favor and investigate which pages we end up
>> deduplicating -- especially if it's mostly only the zeropage and if it's
>> still that significant when disabling THP?"
>>
>> "In any case, it would be nice to get a feeling for how much variety in
>> these 20% of deduplicated pages are. "
>>
>> is pretty clear to me. And shouldn't take months.
>>

Just to clarify: the details I requested are not meant to decide whether 
to reject the patch set (I understand that it can be beneficial to 
have); I primarily want to understand if we're really dealing with a 
workload where KSM is able to deduplicate pages that are non-trivial, to 
maybe figure out if there are other workloads that could similarly 
benefit -- or if we could optimize KSM for these specific cases or avoid 
the memory deduplication altogether.

In contrast to e.g.:

1) THP resulted in many zeropages we end up deduplicating again. The THP
    placement was unfortunate.

2) Unoptimized memory allocators that leave many identical pages mapped
    after freeing up memory (e.g., zeroed pages, pages all filled with
    poison values) instead of e.g., using MADV_DONTNEED to free up that
    memory.


> 
> /sys/kernel/mm/ksm/pages_shared is over 10000 when we run this on an
> Instagram workload. The workload consists of 36 processes plus a few
> sidecar processes.

Thanks! To which value is /sys/kernel/mm/ksm/max_page_sharing set in 
that environment?

What would be interesting is pages_shared after max_page_sharing was set 
to a very high number such that pages_shared does not include 
duplicates. Then pages_shared actually expresses how many different 
pages we deduplicate. No need to run without THP in that case.

Similarly, enabling "use_zero_pages" could highlight if your workload 
ends up deduplciating a lot of zeropages. But maxing out 
max_page_sharing would be sufficient to understand what's happening.


> 
> Each of these individual processes has around 500MB in KSM pages.
> 

That's really a lot, thanks.

> Also to give some idea for individual VMA's
> 
> 7ef5d5600000-7ef5e5600000 rw-p 00000000 00:00 0 (Size: 262144 KB, KSM:
> 73160 KB)
> 

I'll have a look at the patches today.

-- 
Thanks,

David / dhildenb

