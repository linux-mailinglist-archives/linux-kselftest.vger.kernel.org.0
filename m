Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3947C696
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 19:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhLUS2t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 13:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241379AbhLUS2s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 13:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640111327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtSOKjHL5xLetWImuyMHWnGACFYDBlyV6QMnr6bSdxg=;
        b=KhUXtSQ6fECMU/5ju5c5l5ms9AyeZFOv09A2g92GOWc221wIn1/UN6LcILhrnQ5eYt3wO6
        N8gyrQeDF/lRBMp/Kg3vO9jujkKC1T/DFYEgKlWisp2y3u7DU+nBU4txfJLWWPW9pz9cGJ
        cIGFHTEpCm4Uh1BcutMvtCwMJ8mv+m0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-50ZwZ_HwM9qAtyaRil5gcA-1; Tue, 21 Dec 2021 13:28:46 -0500
X-MC-Unique: 50ZwZ_HwM9qAtyaRil5gcA-1
Received: by mail-wr1-f72.google.com with SMTP id r9-20020adfb1c9000000b001a2981d9356so1120742wra.20
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 10:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=NtSOKjHL5xLetWImuyMHWnGACFYDBlyV6QMnr6bSdxg=;
        b=1VawIoD5LDmSgzVD4sU3uQWHIQzhD9FNVunFbWsUNuEAd4LVX9xf2ug0YQzuHYBwB0
         0W+AGYTa6Jm1ds2gxO+MvQ0SZZdITkmDmZCph9OZb1Pmygo82w6WCzPOj8sqvTgm4T2t
         kEN44wzzCj9iz1Jn0h88zwr4V98irOOWsTW3MVCIhHrbpGwU0G97mKerAHnKNdXG+rgs
         KwaSRhOpcpcPGWCaTnWp+VPUIqZGbXE2a+MJMBUpzEDMkImOt01pfzfutErDHpgSTQzs
         ekdUe9/hXApn30PMMiR/GxjF4fy4FnqRX67SYq+AoV4YmPiSdsslzgb+re2dwBkqH0rk
         RlCQ==
X-Gm-Message-State: AOAM532KuMFOOqyo+RYXtcMXGlo75l3l7d9S/IxSREch1QoSA6uiQ5SS
        tfkFVJsyN64Zf8/nI3+Po44b6PppUcdfZ0oGR7dSTz3HbR+Uge6Ss4SpsFe0zQkxUiTu+KgBkjr
        fTG7jK7yg8jhr6SQiknax8mbfRShV
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr3571372wrx.266.1640111325112;
        Tue, 21 Dec 2021 10:28:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz4R0LUDyW9KEiVeNRITaI4SKFHU55LagiK5twVirj2yo/Q6yNnWnJ9xrKESiQeF8/jrJCBQ==
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr3571343wrx.266.1640111324857;
        Tue, 21 Dec 2021 10:28:44 -0800 (PST)
Received: from [192.168.3.132] (p5b0c64a4.dip0.t-ipconnect.de. [91.12.100.164])
        by smtp.gmail.com with ESMTPSA id u9sm2953335wmm.7.2021.12.21.10.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:28:44 -0800 (PST)
Message-ID: <dda021c8-69ec-c660-46be-793ae345a5bb@redhat.com>
Date:   Tue, 21 Dec 2021 19:28:42 +0100
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
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
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <CAHk-=wi191H+U0TNJhL7Jf7VAA+mA6y8MUQLy9DkkaS+tNgp+w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=wi191H+U0TNJhL7Jf7VAA+mA6y8MUQLy9DkkaS+tNgp+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21.12.21 19:00, Linus Torvalds wrote:
> On Tue, Dec 21, 2021 at 9:40 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>> I do think the existing "maybe_pinned()" logic is fine for that. The
>>> "exclusive to this VM" bit can be used to *help* that decision -
>>> because only an exclusive page can be pinned - bit I don't think it
>>> should _replace_ that logic.
>>
>> The issue is that O_DIRECT uses FOLL_GET and cannot easily be changed to
>> FOLL_PIN unfortunately. So I'm *trying* to make it more generic such
>> that such corner cases can be handled as well correctly. But yeah, I'll
>> see where this goes ... O_DIRECT has to be fixed one way or the other.
>>
>> John H. mentioned that he wants to look into converting that to
>> FOLL_PIN. So maybe that will work eventually.
> 
> I'd really prefer that as the plan.
> 
> What exactly is the issue with O_DIRECT? Is it purely that it uses
> "put_page()" instead of "unpin", or what?
> 
> I really think that if people look up pages and expect those pages to
> stay coherent with the VM they looked it up for, they _have_ to
> actively tell the VM layer - which means using FOLL_PIN.
> 
> Note that this is in absolutely no way a "new" issue. It has *always*
> been true. If some O_DIORECT path depends on pinning behavior, it has
> never worked correctly, and it is entirely on O_DIRECT, and not at all
> a VM issue. We've had people doing GUP games forever, and being burnt
> by those games not working reliably.
> 
> GUP (before we even had the notion of pinning) would always just take
> a reference to the page, but it would not guarantee that that exact
> page then kept an association with the VM.
> 
> Now, in *practice* this all works if:
> 
>  (a) the GUP user had always written to the page since the fork
> (either explicitly, or with FOLL_WRITE obviously acting as such)
> 
>  (b) the GUP user never forks afterwards until the IO is done
> 
>  (c) the GUP user plays no other VM games on that address
> 
> and it's also very possible that it has worked by pure luck (ie we've
> had a lot of random code that actively mis-used things and it would
> work in practice just because COW would happen to cut the right
> direction etc).
> 
> Is there some particular GUP user you happen to care about more than
> others? I think it's a valid option to try to fix things up one by
> one, even if you don't perhaps fix _all_ cases.

Yes, of course. The important part for me is to have a rough idea in how
to tackle all pieces and have a reliable design/approach. Besides the
security issue, highest priority is getting R/W pins (FOLL_WRITE) right,
including O_DIRECT, because that can silently break existing use cases.

Lower priority is getting R/O pins on anonymous memory right, because
that never worked reliably. Lowest priority is getting R/O pins on
MAP_PRIVATE file memory right.

I'd appreciate if someone could work on the O_DIRECT FOLL_PIN conversion
while I struggle with PageAnonExclusive() and R/W pins :)

[noting that I'll not get too much done within the next 2 weeks]

-- 
Thanks,

David / dhildenb

