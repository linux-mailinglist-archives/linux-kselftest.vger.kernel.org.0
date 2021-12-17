Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C1D47955A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 21:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhLQUSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 15:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233062AbhLQUSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 15:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639772282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2c0VJ6vHzyhRBdOsA/CnnUPbNYIb49wsJ7s121sWUXc=;
        b=Q7hPSNCO0OB4ewxvHR+/rFt3Lvl5v1t5QCDcRFhE6vNtFrpR2DoCUUHhy4OGxQG86a6yUt
        K2UQ+kdBo2zp9CeyQ/FHPQeB8N13ScoUPD2uHKsrsL2AFD/ZaSc+yk6MHJ2Fs4zTKAFHcW
        s2qHttDb2yXhVkrsgR6d3hyPCEWs3l4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-U1U-sv1mPCqx6XQiC2yCGA-1; Fri, 17 Dec 2021 15:18:01 -0500
X-MC-Unique: U1U-sv1mPCqx6XQiC2yCGA-1
Received: by mail-wm1-f69.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1517441wms.5
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 12:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=2c0VJ6vHzyhRBdOsA/CnnUPbNYIb49wsJ7s121sWUXc=;
        b=3+5MKd/nBoQPQeasayjzdDBF1W1o3Zjof7RsgeD2xEIi/lG3NfGBE2PeyZiGeBkVTb
         n5ckrZMCQkcBwoOsQ8gFVg7lXoxNlHEEajUlq//ku3KELW8Ouob9OKfcxjcDmEhbI9aj
         sbP96mK5Yp8OOcpr46x9/ATFluVA26L2A7VHuWJQCQLpHxjSbUPfcortCq3n6GCIqJcQ
         vd9VN6TiZad/0zlcplw3mxVFIW5qvp+73jqK+0hTdk6BzZixWG8CrjVv9Bh8NS5haZlk
         9O3QMc0P0PEJjk8iVTzK0dK3MFJ4Vi6cNpHIL5+jNOX1ryXn4+8a+4mO1M1PccXdpj9q
         Hqfw==
X-Gm-Message-State: AOAM53103TECF4NT8UoP5zeA5J2845nRBuE8eQgh9LuFoKqTyx+2fgjk
        nmRfjUFkBNVvwzdxxkvW6tWnbVvNHd+OLRxiNp1L0R7mq/fmE6aNdv1B3JBiYDqXZHhygecFRYy
        zcscBOaUckA2Q6L0AWymunaebdtCz
X-Received: by 2002:a1c:9d55:: with SMTP id g82mr8940539wme.58.1639772280237;
        Fri, 17 Dec 2021 12:18:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLQJHbpNL5QwotNaX3cEFF/5ZCFCReDKEtVQIwIqRfkG0LtWKZ65TBS/l/u2j7qT9xkJUMWw==
X-Received: by 2002:a1c:9d55:: with SMTP id g82mr8940497wme.58.1639772279937;
        Fri, 17 Dec 2021 12:17:59 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id o64sm8355019wme.28.2021.12.17.12.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:17:59 -0800 (PST)
Message-ID: <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
Date:   Fri, 17 Dec 2021 21:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 20:22, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 11:04 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> If we are doing a COW, we need an *exclusive* access to the page. That
>> is not mapcount, that is the page ref.
>>
>> mapcount is insane, and I think this is making this worse again.
> 
> Maybe I'm misreading this, but afaik
> 
>  - get a "readonly" copy of a local private page using FAULT_FLAG_UNSHARE.
> 
>    This just increments the page count, because mapcount == 1.
> 
>  - fork()
> 
>  - unmap in the original
> 
>  - child now has "mapcount == 1" on a page again, but refcount is
> elevated, and child HAS TO COW before writing.

Hi Linus,

This is just GUP before fork(), which is in general
problematic/incompatible with sharing. What we're concerned about in the
context of this series (see the security issue) is GUP after fork(). And
we're not changing GUP before fork() or even the COW logic in the
context of this series.

I agree that GUP before fork() has to be handled differently: during
fork(): don't share something that cannot possibly be shared in a safe
way. Don't allow COW semantics for something that is just broken with COW.

> 
> Notice? "mapcount" is complete BS. The number of times a page is
> mapped is irrelevant for COW. All that matters is that we get an
> exclusive access to the page before we can write to it.

We have to be very careful about the two sides of the story: GUP before
fork and GUP after fork.

> 
> Anybody who takes mapcount into account at COW time is broken, and it
> worries me how this is all mixing up with the COW logic.
> 
> Now, maybe this "unshare" case is sufficiently different from COW that
> it's ok to look at mapcount for FAULT_FLAG_UNSHARE, as long as it
> doesn't happen for a real COW.
> 
> But honestly, for "unshare", I still don't see that the mapcount
> matters. What does "mapcount == 1" mean? Why is it meaningful?

I'll reply to your first mail in a sec.

GUP is the problem with COW, not ordinary processes mapping a page
(mapcount), where you will only get new sharers during fork() -- in a
very controlled way. So GUP has to take care to unshare *before* taking
a reference, such that we can never reach the point of missed COW. GUP
really is the problematic bit with it all.

Without GUP, we'd be living in a wonderful world in regards to COW.

> 
> Because if COW does things right, and always breaks a COW based on
> refcount, then what's the problem with taking a read-only ref to the
> page whether it is mapped multiple times or mapped just once? Anybody
> who already had write access to the page can write to it regardless,
> and any new writers go through COW and get a new page.

Let's just take a look at what refcount does *wrong*. Let's use an
adjusted version of your example above, because it's a perfect fit:

1. mem = mmap(pagesize, MAP_PRIVATE)
-> refcount == 1

2. memset(mem, 0, pagesize); /* Page is mapped R/W */

3. fork() /* Page gets mapped R/O */
-> refcount > 1

4. child quits
-> refcount == 1

5. Take a R/O pin (RDMA, VFIO, ...)
-> refcount > 1

6. memset(mem, 0xff, pagesize);
-> Write fault -> COW

And GUP sees something different than our MM -- and this is perfectly
valid, the R/O pin is just reading page content we might be modifying
afterwrds. Take out 3. and 4. and it works as expected. This wouldn't
happen when relying on the mapcount.

And 3+4 can really be anything that results in a R/O mapping of an
anonymous page, even if it's just swapout followed by read fault that
maps the page R/O.

> 
> I must be missing something realyl fundamental here, but to me it
> really reads like "mapcount can fundamentally never be relevant for
> COW, and if it's not relevant for COW, how can it be relevant for a
> read-only copy?"

It really is the right value to use. Only GUP is the problematic bit
that has to trigger unsharing to not mess up COW logic later. Take GUP
out of the equation and COW just works as expected with the mapcount --
 as long as we can read an atomic value and synchronize against fork.
(again, still composing the other mail :) )

-- 
Thanks,

David / dhildenb

