Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E294795F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 22:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbhLQVES (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 16:04:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239912AbhLQVEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 16:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639775055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X31p6tGXAI/4Wa5g0Y2TluwrYpW6tkT7axEPjjTo9xw=;
        b=BXT/qwyE3vw3b+IaCQAMPITXpcLto2ZBDYfa8Y1MGfWoIu0ywRR0FXKWTRTQ8VfeIyLDwn
        fmo1ayn2XwlMc9px0ejP/s+3UIXymyk/HhamhC/JlQsNl+ozje5u8xbNi2AKj/SROTfnjt
        p+KqsPHMAvP/rqPdUh1iEzQWYP7QSUQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-G9f6YzgDNaeoQ4JHUL2SJg-1; Fri, 17 Dec 2021 16:04:14 -0500
X-MC-Unique: G9f6YzgDNaeoQ4JHUL2SJg-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so3499314wma.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=X31p6tGXAI/4Wa5g0Y2TluwrYpW6tkT7axEPjjTo9xw=;
        b=u8qhtEgU3a9acDJJBWVElhoGl5Gcn4tGLjubxc0S+k9VOH0MeXuqPzII0oVqMGovWR
         FfNMkTKWOWZCerUzEcOMyiyLZ6Sd1OQFantRt9rgFL4DzazA53seOghiM8uzJN6IwTfX
         +EWc69aWH0PnY0D9hwRI/3bReF7oUV53qufyAFBJni0CHBnpmBqQiJDDqgkxWkbptql6
         KgdM6fv4rPnXXYy/IJE5uw4X4Sf6tdpLzLfqp/kvPB4bxVd0WIPSBQ0XG1T11qP/MaVe
         UJDN/61Ygn6r62nH0CFcDVv3Jd9URGPxoTJyaU+7NyG5YVtTrqePL/flGPlDCppmUWso
         fRTw==
X-Gm-Message-State: AOAM530nmdjyt7mgw4k5GKC4oHuekeXzyhMS4cvpNhB69PKdQfgPPXZZ
        N84Bj3jGs4UdK73PuhvoutxxDEjK9qSVTaRHTIBS1h74dXm09jEONMARhuDs8CSmA48EtviUse/
        0iF9Fp02Oj4LZXqSuiTDpbtZttxoo
X-Received: by 2002:a05:600c:4e01:: with SMTP id b1mr4204408wmq.109.1639775053288;
        Fri, 17 Dec 2021 13:04:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznXkM6loj8ay2QFCN9NcJYgHiicqLXnTDXzjHllmEEggLkSjiKUdQu6Tr1gd/pfJFDFDvzag==
X-Received: by 2002:a05:600c:4e01:: with SMTP id b1mr4204377wmq.109.1639775053074;
        Fri, 17 Dec 2021 13:04:13 -0800 (PST)
Received: from [192.168.3.132] (p4ff234b8.dip0.t-ipconnect.de. [79.242.52.184])
        by smtp.gmail.com with ESMTPSA id h19sm8592852wmq.0.2021.12.17.13.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:04:12 -0800 (PST)
Message-ID: <37dddd67-7e2d-8217-b1e2-31d79bb85693@redhat.com>
Date:   Fri, 17 Dec 2021 22:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <20211217204705.GF6385@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.12.21 21:47, Jason Gunthorpe wrote:
> On Fri, Dec 17, 2021 at 12:36:43PM -0800, Linus Torvalds wrote:
> 
>>> 5. Take a R/O pin (RDMA, VFIO, ...)
>>> -> refcount > 1
>>>
>>> 6. memset(mem, 0xff, pagesize);
>>> -> Write fault -> COW
>>
>> I do not believe this is actually a bug.
>>
>> You asked for a R/O pin, and you got one.
>>
>> Then somebody else modified that page, and you got exactly what you
>> asked for - a COW event. The original R/O pin has the original page
>> that it asked for, and can read it just fine.
> 

Hi Jason

> To remind all, the GUP users, like RDMA, VFIO use
> FOLL_FORCE|FOLL_WRITE to get a 'r/o pin' specifically because of the

I heard that statement often. Can you point me at the code?

VFIO: drivers/vfio/vfio_iommu_type1.c

vaddr_get_pfns() will end up doing a 
pin_user_pages_remote(FOLL_LONGTERM) without 
FOLL_FORCE|FOLL_WRITE.

Is that added automatically internally?

Note the comment in the next patch

+ *
+ * TODO: although the security issue described does no longer apply in any case,
+ * the full consistency between the pinned pages and the pages mapped into the
+ * page tables of the MM only apply to short-term pinnings only. For
+ * FOLL_LONGTERM, FOLL_WRITE|FOLL_FORCE is required for now, which can be
+ * inefficient and still result in some consistency issues. Extend this
+ * mechanism to also provide full synchronicity to FOLL_LONGTERM, avoiding
+ * FOLL_WRITE|FOLL_FORCE.

> 
> Eg in RDMA we know of apps asking for a R/O pin of something in .bss
> then filling that something with data finally doing the actual
> DMA. Breaking COW after pin breaks those apps.
> 
> The above #5 can occur for O_DIRECT read and in that case the
> 'snapshot the data' is perfectly fine as racing the COW with the
> O_DIRECT read just resolves the race toward the read() direction.
> 
> IIRC there is some other scenario that motivated this patch?

1. I want to fix the COW security issue as documented.
   Reproducers in patch #11

2. I want to fix all of the other issues as documented and linked
   in the cover letter that result from the imprecise page_count
   check in COW code. Especially the ones where we have memory
   corruptions, because this is just not acceptable. There are
   reproducers as well for everybody that doesn't believe me.

But this series really just wants to fix the security issue as "part 1".
Without any more breakages.

I'm sorry, but it's all described in the cover letter. Maybe TL;DR

-- 
Thanks,

David / dhildenb

