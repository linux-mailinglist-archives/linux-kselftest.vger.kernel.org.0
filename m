Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447C64796CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 23:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhLQWDB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 17:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231213AbhLQWC5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 17:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639778576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KoZY8J6zdihNxPty00DekWdMgSgINIRofX014qBfuXc=;
        b=b3ByYYAU/iKiN4JGsonPzBR3/8b0ovzTpDcExPJEhiDfgZDR3ur1tSziDSZ13LIo7s5pfM
        WOcqBLaQKmY71PuXq/e1/iHKKXCneJJxphX74yjB0QgiXbiCH0CSEOT/vTnuOOfUaU0QWl
        Dc/62chGivOaI60CDdPjxp05kd+BTCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-ssVtIyuOOoSTnyBYNuN1ew-1; Fri, 17 Dec 2021 17:02:55 -0500
X-MC-Unique: ssVtIyuOOoSTnyBYNuN1ew-1
Received: by mail-wr1-f70.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so974840wrr.13
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 14:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=KoZY8J6zdihNxPty00DekWdMgSgINIRofX014qBfuXc=;
        b=ww0da0/7HHhqhlhxcx+MvYQX/b1P4q/MjtstmlrVGYy2iXejUgld4RCCMUeeRqJmRv
         7jOCbmP+ocpc95ZFHlld91wiwQMjMTQ94l2K+mqvxz6tKWZPyyvHdw5sKYYVjXcffpBo
         QoNE/I+lhnz2yl42js9eTm7h1quvb+lT4AzRkMHLSRl9pykuPPxmALf6JcgZev7t9lny
         nOeHyyLAdTm8lsdDxsh7CCNc4mljaWas9ELSgzEOhh8NccBNR/wsHFcI4xeq8HNgYnIF
         GYkV4eVOlyOzxK/usCajrSL4i1Z25XrbYqyhy1QqpgazTxa2nnyipiFUuSAouom4feT+
         eWcQ==
X-Gm-Message-State: AOAM531CFSM4qITkvLZjF4FeJMeskkqMPSsP9hp29dfRVvskMIlpXIZq
        799BOYwvpwhsyRSD9js2rMcguRmmFgG33iTor2KY2p6Qq09FeQ3C3rsJKNV/etwSaPPFJ+qYkya
        3jzLb8QwFsMhapFGrbRofxhjnEQl9
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr4024617wrn.690.1639778574332;
        Fri, 17 Dec 2021 14:02:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuRL5qmAQJevVVPuYVbWt7BvxHm1ZgAzZFI4yLinNO0rt5Hd/+vPnwjD/ORD2+QLU8xQHpiA==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr4024592wrn.690.1639778574107;
        Fri, 17 Dec 2021 14:02:54 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id w25sm8541965wmk.20.2021.12.17.14.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 14:02:53 -0800 (PST)
Message-ID: <644daada-1d77-68bb-1682-fb67f0b427f0@redhat.com>
Date:   Fri, 17 Dec 2021 23:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-2-david@redhat.com> <87h7b6c44o.ffs@tglx>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 01/11] seqlock: provide lockdep-free raw_seqcount_t
 variant
In-Reply-To: <87h7b6c44o.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 22:28, Thomas Gleixner wrote:
> On Fri, Dec 17 2021 at 12:30, David Hildenbrand wrote:
>> Sometimes it is required to have a seqcount implementation that uses
>> a structure with a fixed and minimal size -- just a bare unsigned int --
>> independent of the kernel configuration. This is especially valuable, when
>> the raw_ variants of the seqlock function will be used and the additional
>> lockdep part of the seqcount_t structure remains essentially unused.
>>
>> Let's provide a lockdep-free raw_seqcount_t variant that can be used via
>> the raw functions to have a basic seqlock.
>>
>> The target use case is embedding a raw_seqcount_t in the "struct page",
>> where we really want a minimal size and cannot tolerate a sudden grow of
>> the seqcount_t structure resulting in a significant "struct page"
>> increase or even a layout change.
> 

Hi Thomas,

thanks for your feedback!

> Cannot tolerate? Could you please provide a reason and not just a
> statement?

Absolutely.

"struct page" is supposed to have a minimal size with a fixed layout.
Embedding something inside such a structure can change the fixed layout
in a way that it can just completely breaks any assumptions on location
of values.

Therefore, embedding a complex structure in it is usually avoided -- and
if we have to (spin_lock), we work around sudden size increases.

There are ways around it: allocate the lock and only store the pointer
in the struct page. But that most certainly adds complexity, which is
why I want to avoid it for now.


I'll extend that answer and add it to the patch description.

> 
>> Provide raw_read_seqcount_retry(), to make it easy to match to
>> raw_read_seqcount_begin() in the code.
>>
>> Let's add a short documentation as well.
>>
>> Note: There might be other possible users for raw_seqcount_t where the
>>       lockdep part might be completely unused and just wastes memory --
>>       essentially any users that only use the raw_ function variants.
> 
> Even when the reader side uses raw_seqcount_begin/retry() the writer
> side still can use the non-raw variant which validates that the
> associated lock is held on write.

Yes, that's my understanding as well.

> 
> Aside of that your proposed extra raw sequence count needs extra care
> vs. PREEMPT_RT and this want's to be very clearly documented. Why?
> 
> The lock association has two purposes:
> 
>     1) Lockdep coverage which unearthed bugs already

Yes, that's a real shame to lose.

> 
>     2) PREEMPT_RT livelock prevention
> 
>        Assume the following:
> 
>        spin_lock(wrlock);
>        write_seqcount_begin(seq);
> 
>        ---> preemption by a high priority reader
> 
>        seqcount_begin(seq); <-- live lock
> 
>        The RT substitution does:
> 
>        seqcount_begin(seq)
>            cnt = READ_ONCE(seq->sequence);
> 
>            if (cnt & 1) {
>            	lock(s->lock);
>                 unlock(s->lock);
>            }
> 
>        which prevents the deadlock because it makes the reader block on
>        the associated lock, which allows the preempted writer to make
>        progress.
> 
>        This applies to raw_seqcount_begin() as well.
> 
> I have no objections against the construct itself, but this has to be
> properly documented vs. the restriction this imposes.

Absolutely, any input is highly appreciated.

But to mention it again: whatever you can do with raw_seqcount_t, you
can do with seqcount_t, and there are already users relying completely
on the raw_ function variants (see my other reply).

So the documentation should most probably be extended to cover the raw_
functions and seqcount_t in general.

> 
> As you can see above the writer side therefore has to ensure that it
> cannot preempted on PREEMPT_RT, which limits the possibilities what you
> can do inside a preemption (or interrupt) disabled section on RT enabled
> kernels. See Documentation/locking/locktypes.rst for further information.

It's going to be used for THP, which are currently incompatible with
PREEMPT_RT (disabled in the Kconfig). But preemption is also disabled
because we're using bit_spin_lock(), which does a bit_spin_lock().

Certainly worth documenting!

Thanks for your input!

-- 
Thanks,

David / dhildenb

