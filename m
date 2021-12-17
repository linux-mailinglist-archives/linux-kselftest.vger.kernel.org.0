Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB00479728
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 23:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhLQW3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 17:29:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhLQW3t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 17:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639780189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qL/JIX8EEyFG7lDdEcEOcgCQUQYx1MZeqTzUDIdfXMM=;
        b=fy2uuB7xqaT1HBwqlcC9asm3mhqHl/caHSHCP+Q7H+pGE/xLwh6DNq42ZoS80yb2ukuodZ
        2jqnlVaQZzX3+OHaYlYJhEMqmINPr2CMnxMoHkxBiJtPzS2mCWXkN9wfc3FR/3wgIzc7et
        XequAnpndNnRCUb9hMmFyBUjJMmVn4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-ySaEu7A4Osi_psQjObyjLg-1; Fri, 17 Dec 2021 17:29:48 -0500
X-MC-Unique: ySaEu7A4Osi_psQjObyjLg-1
Received: by mail-wm1-f70.google.com with SMTP id j20-20020a05600c1c1400b00343ad0c4c40so3607051wms.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 14:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=qL/JIX8EEyFG7lDdEcEOcgCQUQYx1MZeqTzUDIdfXMM=;
        b=RFkMhxVMNGD4Mnm1n7CzHDc5AFO5FMM8DsxKasxAy+Xjtlb5ReZul4WraIcZ6Uf9NG
         8dAkiBEytAO0xZlCPrKrS35XLquEnxgqb+8+i/GpKrF+xGpIjdbqrxWybJuWP/OJWPuY
         zeDe6kUD5rw5BUx3+vqLCqRzCVsNakwaNaS6FzAc+Xrmuqt3FtnyvI8MhrSFi4Tn+0jX
         wEGr/JE+FEDVM7bR92btubazdigFQvaZqXE4vp2SMUW1Nh0howeimPm8PPQREun0C7TC
         W3HWhh7iuJsiPgYsh85S/DPTLyGfdUncOrUQZrUGF26FHUckWl7exetAFHgJhW/XWy+Z
         Qfjg==
X-Gm-Message-State: AOAM531At00p8YrN5RGZNzXFMVXirJFgO5JPLCzJphggmzRmaOoyTx4S
        aDWMEWcICoqxpjAPTUYAVdS11FlPB5BcmVn955dkQpR2oozP9xxWNL/1O8XoQHneWghV0Dxrb1d
        00S+B1VCUdlyGUNnJ8mCcy4+1Fs0x
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr2672052wrp.351.1639780186951;
        Fri, 17 Dec 2021 14:29:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyY9P+G15WX8X9gRjoZbZF1GI9X6VoJGWLTrTMCgzZH7nR7syAHkYWmUCmVqISzyIQWE2QcUA==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr2672021wrp.351.1639780186681;
        Fri, 17 Dec 2021 14:29:46 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id e4sm7474338wrh.56.2021.12.17.14.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 14:29:46 -0800 (PST)
Message-ID: <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com>
Date:   Fri, 17 Dec 2021 23:29:44 +0100
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
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
 <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
 <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 22:50, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 1:47 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> For now I have not heard a compelling argument why the mapcount is
>> dubious, I repeat:
>>
>> * mapcount can only increase due to fork()
>> * mapcount can decrease due to unmap / zap
>>
>> We can protect from the transtition == 1 -> >1 using the mmap_lock.
>>
>> For COW the mapcount is the only thing that matters *if we take GUP* out
>> of the equation. And that's exactly what we
> 
> What do you have against just doing what we already do in other parts,
> that a/b thing?

Let me put it that way: I just want to get all of this fixed for good. I
don't particularly care how. *But* I will fight for something that is
superior, logically makes sense (at least to me :) ) and not super
complicated. And I call also avoiding unnecessary COW "superior".

I do know that what this series proposes fixes the CVE: GUP after fork.
I do know that the part 2 we'll be sending out next year will fix
everything else we discovered so far, and it will rely on this as a
basis, to not reintroduce any other COW issues we've seen so far.


If someone can propose something comparable that makes all discovered
problems go away I'll be *extremely* happy. We have reproducers for all
issues, so it's easy to verify, and I'm planning on extending the
selftests to cover even more corner cases.


So far, I am not convinced that using the mapcount is dubious or
problematic, I just don't see how. COW is an about sharing pages between
processes, each expressed in the mapcount. It's a pure optimization for
exactly that purpose.

GUP is the problem, not COW, not the mapcount. To me the mapcount is the
only thing that makes sense in COW+unsharing logic, and GUP has to be
taught to identify it and resolve it -> unshare when it detects a shared
anaonymous page.


> 
> Which avoids the whole mmap_sem issue. That was a big issue for the
> rdma people, afaik.

While I do care about future use cases, I cannot possibly see fork() not
requiring the mmap_lock in the foreseeable future. Just so much depends
on it as of now.

And after all, fixing everything what we discovered so far is more
important to me than something like that for the future. We have other
problems to solve in that regard.

----------------------------------------------------------------------

I didn't want to talk about hugetlb here but I will just because it's a
good example why using the refocunt is just wrong -- because unnecessary
COW are just absolutely problematic.

Assume you have a R/O mapped huge page that is only mapped into your
process and you get a write fault. What should your COW logic do?

a) Rely on the mapcount? Yes, iff GUP has been taught to unshare
   properly, because then it expresses exactly what we want to know.
   mapcount == 1 -> reuse. mapcount > 1 -> COW.

b) Rely on the refocunt? If we have a speculative refrence on the page
   we would COW. As huge pages are a scarce resource we can easily just
   not have a free huge page anymore and crash the application. The app
   didn't do anything wrong.

So teaching the hugetlb COW code to rely on the refount would just be
highly fragile.

-- 
Thanks,

David / dhildenb

