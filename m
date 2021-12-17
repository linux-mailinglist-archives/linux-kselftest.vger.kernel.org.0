Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965DB479621
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhLQVUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 16:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229513AbhLQVUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 16:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639776033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IJZxPgG4L44oWGcui35r4UlNG5572tZdi98rWwaG8g=;
        b=ApO3o05P6MqO26v8j8WB3M6RGAzbCRgLobY6g7jDdqUVDfAWFH7yaRlmexJmH4E8fMkwcS
        jAvXcwNga9DOdXVhVrdURF5fT7SG1IUmVrA+OAr1mEydM00tP5uyvP9z4Gi19AkvMn7mDp
        b2GFnC9RvS6poGkBaDrcQN/pNT1d1EE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-crbjqcz5MAaNFaVA2zlbCg-1; Fri, 17 Dec 2021 16:20:32 -0500
X-MC-Unique: crbjqcz5MAaNFaVA2zlbCg-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso3503578wms.4
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8IJZxPgG4L44oWGcui35r4UlNG5572tZdi98rWwaG8g=;
        b=b2Vmab39BUnmRQSYGD+WvUgL4YXxyrJuvJz3w/wzu/1Ct3Qpktn6VExf0dnoCNNlSP
         9XNuSb+BujxblAtrVNgMZXICahU/a111D+VB2ddBQO4YoGjmanwp2E1Mtl7LwkkIxDRV
         bgSuFL+rmpGv0+2oXK/ohM+4s26sKzlvmBkSpDlB8r4ILZhCal8m4A0xctY2s8z0zRPg
         7YRbGjf4ZzxNTWlty5igsXfMvn0foUMXLMu7lphCqH5fIZFZZkTc+1xAUhMNPpYhUtRU
         wabC0plobnpgZpLdWc2ifuirjiZsdDLGUy0bbTCOWj03LRMPlIo51+kzspKxK2NkVutb
         mxdg==
X-Gm-Message-State: AOAM5329Z1PFq+jOsc/WllT1cXiPnqAEvg1lSEqS1KfQu59+9jm7AcUg
        6kR4huJNhO6oMjfJFBgqWPKG9/pRVgSlUGIKs1dtQFEaIhspgYxYAgnXvNFXNGEppXFAYmLRov8
        9qBl3EMwdNF8eMn9CK/sIcSeVE7Ud
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr3927158wrb.148.1639776031459;
        Fri, 17 Dec 2021 13:20:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynyrJqHzLIVQ/5dOHLdUALTS3GVx082kmC3nUnoCPPI43f3cBoGLl7cQzviQKhtACK6Zxaeg==
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr3927144wrb.148.1639776031272;
        Fri, 17 Dec 2021 13:20:31 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id b13sm8544391wrh.32.2021.12.17.13.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:20:30 -0800 (PST)
Message-ID: <0d96835d-bcf4-1192-536c-0af314405880@redhat.com>
Date:   Fri, 17 Dec 2021 22:20:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 22:15, Nadav Amit wrote:
> 
> 
>> On Dec 17, 2021, at 12:47 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Fri, Dec 17, 2021 at 12:36:43PM -0800, Linus Torvalds wrote:
>>
>>>> 5. Take a R/O pin (RDMA, VFIO, ...)
>>>> -> refcount > 1
>>>>
>>>> 6. memset(mem, 0xff, pagesize);
>>>> -> Write fault -> COW
>>>
>>> I do not believe this is actually a bug.
>>>
>>> You asked for a R/O pin, and you got one.
>>>
>>> Then somebody else modified that page, and you got exactly what you
>>> asked for - a COW event. The original R/O pin has the original page
>>> that it asked for, and can read it just fine.
>>
>> To remind all, the GUP users, like RDMA, VFIO use
>> FOLL_FORCE|FOLL_WRITE to get a 'r/o pin' specifically because of the
>> COW breaking the coherence. In these case 'r/o pin' does not mean
>> "snapshot the data", but its only a promise not to write to the pages
>> and still desires coherence with the memory map.
>>
>> Eg in RDMA we know of apps asking for a R/O pin of something in .bss
>> then filling that something with data finally doing the actual
>> DMA. Breaking COW after pin breaks those apps.
>>
>> The above #5 can occur for O_DIRECT read and in that case the
>> 'snapshot the data' is perfectly fine as racing the COW with the
>> O_DIRECT read just resolves the race toward the read() direction.
>>
>> IIRC there is some other scenario that motivated this patch?
> 
> I think that there is an assumption that once a page is COW-broken,
> it would never have another write-fault that might lead to COW
> breaking later.
> 
> AFAIK at least after userfaultfd-WP followed by
> userfaultfd-write-unprotect a page might be write-protected and
> go through do_wp_page() a second time to be COW-broken again. In
> such case, I think the FOLL_FORCE|FOLL_WRITE would not help.
> 
> I suspect (not sure) that this might even happen with mprotect()
> since I do not see all code-paths preserving whether the page
> was writable.
> 

uffd-wp and mprotect() are broken as well, yes. But the easiest example
is just swap + read fault.

Section 2 and 3 in [1], along with reproducers.

Note that I didn't mention uffd-wp and mprotect(), because these require
"manual intervention". With swap, it's not your application doing
something "special".

[1]
https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com

-- 
Thanks,

David / dhildenb

