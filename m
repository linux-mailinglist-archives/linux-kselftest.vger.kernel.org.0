Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76F47C520
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhLURkg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 12:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240445AbhLURkf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 12:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640108435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTn6ty+kzmeA4UQ1/Ws+T/26zaoQLtQZsZ4DV9Wnbqs=;
        b=I4nqaFynur+1l0SVL/QQ0fkhH1q/ufiOofQcOeARs1t7ayyRct+CMlOEZOIrLaygtFUMos
        WeWVXjL6N4bObCOaF0Dga8/kDaYLBqrLRH9BfHS3WDe+0ldTyXyz7XAJNRRz5F1gb5lp95
        A/0fEbGURPPTj0PPH6A75nANgjGiGUI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-3-svf4tjNJ-2PYNvhxJmFQ-1; Tue, 21 Dec 2021 12:40:34 -0500
X-MC-Unique: 3-svf4tjNJ-2PYNvhxJmFQ-1
Received: by mail-wr1-f69.google.com with SMTP id h12-20020adfa4cc000000b001a22dceda69so4874208wrb.16
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 09:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=bTn6ty+kzmeA4UQ1/Ws+T/26zaoQLtQZsZ4DV9Wnbqs=;
        b=YqHF7cG/WxPRaZwtJoq/oV/1f//1KxjWXS1MJRdXMy+MjhYDxxNPJINoSDiRDbQAMY
         6bj2xs9SJBd/1nYpH7J8CkntlArmXqF/9AeVp5S1d7jUwJQEWVFWsqDFxYZk/7NA3dBx
         H9qlHGJ8YHgJa6UfR1M3+d0dPoL1sYEh0G8rjEsgwEZLwa1pqXYGciXPP513fp7gjY7o
         ADFf8ykiMJd11eyvwfPQnXEnAlgV8Z7F11U2cscXV7FG8yaPyXYJSifl/vM/4MKJwTuw
         hmJ4lJIdKnd/cKfJgoYYIgUqcUsWWg4joNcr567FhXZKqKNZ2aTFfdI7KaJVu7Dz39jT
         pSMg==
X-Gm-Message-State: AOAM531YvqodBxZQInVlA7/15v6ZfE3veFn6AYlyceQMeklWL74ZFQJK
        +26mQF9gdRoJ6S0Z9uN0Ae3tyYDFSY0PPyBjewY9TGyJ0bsQ305y07HQZjBV/uZG3tpWZtV2Jur
        XXQkVfXRd6UAMPJiX7tt8lj5bVX23
X-Received: by 2002:a5d:4646:: with SMTP id j6mr3414579wrs.485.1640108432791;
        Tue, 21 Dec 2021 09:40:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6TrC3opWBpA4xtsU2Ox1SfYvwNj8ZwSQFSsgH0d9atBHHNIQ/OB02i/QZee6YXZQjbzilkQ==
X-Received: by 2002:a5d:4646:: with SMTP id j6mr3414546wrs.485.1640108432439;
        Tue, 21 Dec 2021 09:40:32 -0800 (PST)
Received: from [192.168.3.132] (p5b0c64a4.dip0.t-ipconnect.de. [91.12.100.164])
        by smtp.gmail.com with ESMTPSA id h204sm3200668wmh.33.2021.12.21.09.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:40:31 -0800 (PST)
Message-ID: <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
Date:   Tue, 21 Dec 2021 18:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Nadav Amit <namit@vmware.com>,
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
References: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21.12.21 18:05, Linus Torvalds wrote:
> On Tue, Dec 21, 2021 at 12:58 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.12.21 02:03, Jason Gunthorpe wrote:
>>
>>> I'm having a hard time imagining how gup_fast can maintain any sort of
>>> bit - it lacks all forms of locks so how can we do an atomic test and
>>> set between two pieces of data?
>>
>> And exactly that is to be figured out.
> 
> So my preference would be to just always maintain the "exclusive to
> this VM" bit in the 'struct page', because that makes things easier to
> think about.
> 
> [ Of course - the bit could be reversed, and be a 'not exclusive to
> this VM' bit, semantically the set-or-cleared issue doesn't matter.
> Also, when I talk about some "exclusive to this VM" bit, I'm purely
> talking about pages that are marked PageAnon(), so the bit may or may
> not even exist for other pager types ]

Yes, whatever I say applies to PageAnon() only -- including the
(overloaded bit), called PG_anon_exclusive now.

> 
> And then all GUP-fast would need to do is to refuse to look up a page
> that isn't exclusive to that VM. We already have the situation that
> GUP-fast can fail for non-writable pages etc, so it's just another
> test.

Right, the simplest way is simply failing GUP fast if the bit isn't set,
forcing it into the slow path. If that would primarily happens for R/O
pins after fork(), fine with me.

> 
>> Note that I am trying to make also any kind of R/O pins on an anonymous
>> page work as expected as well, to fix any kind of GUP after fork() and
>> GUP before fork(). So taking a R/O pin on an !PageAnonExclusive() page
>> similarly has to make sure that the page is exclusive -- even if it's
>> mapped R/O (!).
> 
> I do think the existing "maybe_pinned()" logic is fine for that. The
> "exclusive to this VM" bit can be used to *help* that decision -
> because only an exclusive page can be pinned - bit I don't think it
> should _replace_ that logic.

The issue is that O_DIRECT uses FOLL_GET and cannot easily be changed to
FOLL_PIN unfortunately. So I'm *trying* to make it more generic such
that such corner cases can be handled as well correctly. But yeah, I'll
see where this goes ... O_DIRECT has to be fixed one way or the other.

John H. mentioned that he wants to look into converting that to
FOLL_PIN. So maybe that will work eventually.

> 
> There's a quite fundamental difference between
> 
>  (a) COW and GUP: these two operations _have_ to know that they get an
> exclusive page in order to re-use or look up the page respectively
> 
>  (b) the pre-cow logic in fork() or the "add this to the swap cache"
> logic in vmscan that decides whether a page can be turned into a COW
> page by adding a reference coutn to it (whether due to fork or swap
> cache doesn't matter - the end result is the same).
> 
> The difference is that in (a) the thing we *have* to get right is
> whether a page is exclusively owned by that VM or not. We can COW too
> much, but we can never share a page unless it's exclusive. That's true
> whether it's pinned or not.

Exactly. Once a page is "exclusive" it must not get shared *unless* we
can turn it into a "shared" page during fork().

There are some ugly corner cases that will require some thought.

> 
> In (b), the "have to get right" is different. In (b), it's perfectly
> ok to COW an exclusive page and turn it non-exclusive. But we must
> never COW a pinned page.
> 
> So (a) and (b) are very different situations, and have different logic.
> 
> If we always maintain an exclusive bit for AnonPage pages, then both
> (a) and (b) can use that bit, but they'll use it very differently. In
> (a) we'll refuse to look it up and will force a 'handle_mm_fault()' to
> get an exclusive copy. And in (b), we just use it as a "we know only
> exclusive pages can be pinned", so it's just another check for
> page_needs_cow_for_dma(), the same way we currently check
> "MMF_HAS_PINNED" to narrow down the whole "page count indicates this
> may be a pinned page" question.

If we use page_needs_cow_for_dma() for that purpose we can still have
other references from our process referencing the page, including right
now O_DIRECT ones. So the safest thing to do would be relying on the
same logic as we do in the COW path regarding the pagecount ... but that
might result in unnecessary copies as I mentioned.

It would be perfect if just anything that modifies page content would be
using FOLL_PIN, unfortunately that's not reality ...


> 
> And the "page is exclusive" would actually be the *common* case for
> almost all pages. Any time you've written to a page and you haven't
> forked after the write (and it hasn't been turned into a swap page),
> that page would be exclusive to that VM.

Yes. Essentially every time we create a new anonymous page it would end
up as exclusive. Or if we're in a fault and can convert the "exclusive"
page into a "shared" page (essentially the COW reuse logic).

> 
> Doesn't this seem like really straightforward semantics to maintain
> (and think about)?
> 
> I'd like the exclusive page bit to *not* be directly about "has this
> page been pinned" exactly because we already have too many special
> cases for GUP. It would be nicer to have a page bit that has very
> clear semantics even in the absence of GUP.

What adds complexity to correctly maintain the "exclusive" state are at
least:
* KSM (might be harder, have to think about it)
* migration (might be easy to just copy the bit)
* fork() with migration/swap entries that reference a page that is
  "exclusive". I'll have to think about that more.

So I have plenty of stuff to look into.


Just so we're on the same page what I'd like to achieve with anonymous
pages:

1) If we take a R/W pin on an anonymous page, we will always pin an
"exclusive page".

2) If we take a R/O pin on an anonymous page, we will always pin an
"exclusive page", even if the page is mapped R/O.

3) "Exclusive" pages cannot be turned "shared" during fork (and ksm? :/
) if pinned.

4) "Exclusive" pages can be turned "shared" during fork if not pinned.

5) "Exclusive" pages will never be COWed but remain there for all
eternity, until unmapped ... well or until converted into "shared" again
if possible


Ideally we'd handle O_DIRECT ... :(


2) is certainly the cherry on top. But it just means that R/O pins don't
have to be the weird kid. And yes, achieving 2) would require
FAULT_FLAG_EXCLUSIVE / FAULT_FLAG_UNSHARED, but it would really 99% do
what existing COW logic does, just bypass the "map writable" and
"trigger write fault" semantics.

I hope we agree that R/O pins don't have to have weird kid if we can
"get it right" with the same approach.


-- 
Thanks,

David / dhildenb

