Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482AE4792D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 18:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhLQR3J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 12:29:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239913AbhLQR3J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 12:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639762148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgM5OKxy2ebbpOfrvZEWcaXxpBQFY0BBq/cx7UULpgE=;
        b=Vp+PWHIUVog1/fIIigU0WWJbosJRe9kgqsMpQXK3bX7tppJuG1ZJ5FzFCWMFKSjwi2eCqH
        JUdn5ZOoucjTn++BfVUlapf8J/CwthDx3jq0LnxJ93etvKe7cRH4y0vYonN4gNnKyH+Xus
        I1HirD+mpz1BHukiywJcx66qRtIT20Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-BtaJfND-PnyKuP6X0o4fcw-1; Fri, 17 Dec 2021 12:29:07 -0500
X-MC-Unique: BtaJfND-PnyKuP6X0o4fcw-1
Received: by mail-wm1-f72.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so1357204wmb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 09:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=QgM5OKxy2ebbpOfrvZEWcaXxpBQFY0BBq/cx7UULpgE=;
        b=qwb+qgcWrWOeAm7ymC1zqQl2eklJDcSRbQhznh2/9bc3nVTgji1xdJvxyzF2XpKtRo
         J5Vt6lZKE4C/1HRwpDjzXQ7KAuR1St0FPy8Cbc8WRrPQ5eMHPKYIjSrKuT7J8DTAf79B
         uhse2NZcTAM9D+5gOVBLaGRx5W/UP5zLxQ4AYUeRRRTgzI8+zdtQoPSKU++fQ97erWFK
         JSaCVpeT9MZa5ed7KQz2hC2PZPMFlC13D7IqrTXttOJOspz2vaP532SaQnh5/VcMryUt
         n3oEfv+3YChSAUigPUicvQe4PEtl+xCYYYUg1ju8uo5gyGFqMGipnR3w6AZVaMntBp7x
         IyJQ==
X-Gm-Message-State: AOAM5331ofsp9/TqLds7pCnJDDRufU+SJ3mPbXe9TvHLUYUFVHAm68QA
        dqzIYtz7kMXvR36Sc4AmqIn7BjCMuWZJeZmL2aqahwdey6YEwL/aDkfIV/w/ro8H+PjR2QXJ7mY
        u7gcNi1Ug0sCg726I00EXyhflJRvN
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr10430301wmg.86.1639762145877;
        Fri, 17 Dec 2021 09:29:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7gC5YUCkIZUZCWG8Ebu8/gjKEd1bTxSMHmYM6ftIz/BMjlPy8ZbBH4hQzbwEvNufDCZ3BZw==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr10430292wmg.86.1639762145666;
        Fri, 17 Dec 2021 09:29:05 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id k7sm7910833wri.110.2021.12.17.09.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 09:29:05 -0800 (PST)
Message-ID: <058e97eb-1489-3d59-c6ee-94175dc13134@redhat.com>
Date:   Fri, 17 Dec 2021 18:29:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-2-david@redhat.com>
 <38BCB153-7E7C-4AAD-8657-E5C6F9E1EF9B@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 01/11] seqlock: provide lockdep-free raw_seqcount_t
 variant
In-Reply-To: <38BCB153-7E7C-4AAD-8657-E5C6F9E1EF9B@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 18:02, Nadav Amit wrote:
> 
> 
>> On Dec 17, 2021, at 3:30 AM, David Hildenbrand <david@redhat.com> wrote:
>>
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
>>
>> Provide raw_read_seqcount_retry(), to make it easy to match to
>> raw_read_seqcount_begin() in the code.
>>
>> Let's add a short documentation as well.
>>
>> Note: There might be other possible users for raw_seqcount_t where the
>>      lockdep part might be completely unused and just wastes memory --
>>      essentially any users that only use the raw_ function variants.
>>
> 
> Is it possible to force some policy when raw_seqcount_t is used to
> prevent its abuse? For instance not to allow to acquire other (certain?)
> locks when it is held?
> 

Good question ... in this series we won't be taking additional locks on
the reader or the writer side. Something like lockdep_forbid() /
lockdep_allow() to disallow any kind of locking. I haven't heard of
anything like that, maybe someone reading along has a clue?

The writer side might be easy to handle, but some seqcount operations
that don't do the full read()->retry() cycle are problematic
(->raw_read_seqcount).

> [ snip ]
> 
>> +/**
>> + * raw_seqcount_init() - runtime initializer for raw_seqcount_t
>> + * @s: Pointer to the raw_seqcount_t instance
>> + */
>> +# define raw_seqcount_init(s) __raw_seqcount_init(s)
>> +
>> #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>
>> # define SEQCOUNT_DEP_MAP_INIT(lockname)				\
>> @@ -111,11 +129,16 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
>> # define seqcount_lockdep_reader_access(x)
>> #endif
>>
>> +/**
>> + * RAW_SEQCNT_ZERO() - static initializer for raw_seqcount_t
>> + */
>> +#define RAW_SEQCNT_ZERO() 0
> 
> I am not sure why RAW_SWQCNT_ZERO() should be a function-like macro.
> 

I think I just went for consistency with SEQCNT_ZERO() -- but I agree,
that can just be simplified!

Thanks!


-- 
Thanks,

David / dhildenb

