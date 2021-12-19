Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D933447A1A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhLSR74 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 12:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236213AbhLSR74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 12:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639936795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5t0uLGB88euDBAUi/hIHWgd5nmy1opcjQo/ctPwzp+0=;
        b=PZF0pycGn+yHd/HDvzlVlvV5nwCsAdNGi1AYGjfJYzSs8ehmVoNMXnao7qm1DOSt/S6hRI
        e8Ue/raeHAcm2d2R5eY7FapxrKy/+2vDgqB0Vqm3px98SZezW9tu8veJIswqGDzpfxlg8d
        ET85TUPSFtwljOti1NWhizKXkw2guVk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-IFDfqRWFMVamwRwAUreMpQ-1; Sun, 19 Dec 2021 12:59:54 -0500
X-MC-Unique: IFDfqRWFMVamwRwAUreMpQ-1
Received: by mail-wm1-f70.google.com with SMTP id i15-20020a05600c354f00b0034566ac865bso2856344wmq.6
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 09:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=5t0uLGB88euDBAUi/hIHWgd5nmy1opcjQo/ctPwzp+0=;
        b=1nGYZ18XGBVAwC20/Ysoa4P+LDlrqF6/oAcA/ADK0DXY4gnFU6LR2TFMBwSa73EeT5
         V/RlCb9NUCzq/o22UWGurmn2qBf3Wu3UL3I/PaxBiEbC8nUidS7S1GEQdpHyAZ+MtUsM
         VgX0njlAchGMk89Vgxcue4lUxZ45onytQfVU36QQ2Ezgwc6nIazRNDuAjlMZfD80q6UV
         y7/j7MeLmTg0cwzyhRPzDNU+3n/G+e6by7y0Jbwh2jBmK6WMxzKNl/tx2E6L2U/LczGG
         Ov5yif9/Xow0hWTHnGNdJr+ZxyuDkbYM/vMltwvX0Vfmvq97AWRN7n0DzmBKXCqqOjNs
         VfKw==
X-Gm-Message-State: AOAM533lcII1m1/IU/nQq+S90cH9az/m14ZJtOIHBf7KaD9TSpmDesoJ
        QVwCGST6nqkBoprspVEeuS0AWZ69/UwIYGl7Rtdvn9bR+sgOmNWyJT6Bd7zcgmJT5xyys8lVjrY
        R7IxIFxy0QIzo9pBA+CZcg/FSWdRU
X-Received: by 2002:a05:600c:2943:: with SMTP id n3mr8015436wmd.167.1639936793327;
        Sun, 19 Dec 2021 09:59:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsJEpquzSqMiXV3ss+CHHi+TlMEUCcvL8NS/DbzmPPCdr4VFbmvYDBP18cD5LrX1DYfzRajQ==
X-Received: by 2002:a05:600c:2943:: with SMTP id n3mr8015420wmd.167.1639936793109;
        Sun, 19 Dec 2021 09:59:53 -0800 (PST)
Received: from [192.168.3.132] (p4ff23c6f.dip0.t-ipconnect.de. [79.242.60.111])
        by smtp.gmail.com with ESMTPSA id b197sm13271359wmb.24.2021.12.19.09.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 09:59:52 -0800 (PST)
Message-ID: <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
Date:   Sun, 19 Dec 2021 18:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
References: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com>
 <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
 <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
In-Reply-To: <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.12.21 18:44, Linus Torvalds wrote:
> David, you said that you were working on some alternative model. Is it
> perhaps along these same lines below?
> 
> I was thinking that a bit in the page tables to say "this page is
> exclusive to this VM" would be a really simple thing to deal with for
> fork() and swapout and friends.
> 
> But we don't have such a bit in general, since many architectures have
> very limited sets of SW bits, and even when they exist we've spent
> them on things like UDDF_WP.,
> 
> But the more I think about the "bit doesn't even have to be in the
> page tables", the more I think maybe that's the solution.
> 
> A bit in the 'struct page' itself.
> 

Exactly what I am prototyping right now.

> For hugepages, you'd have to distribute said bit when  you split the hugepage.

Yes, that's one tricky part ...

> 
> But other than that it looks quite simple: anybody who does a virtual
> copy will inevitably be messing with the page refcount, so clearing
> the "exclusive ownership" bit wouldn't be costly: the 'struct page'
> cacheline is already getting dirtied.
> 
> Or what was your model you were implying you were thinking about in
> your other email? You said

I'm playing with the idea of not setting the bit always during COW but
only on GUP request to set the bit (either manually if possible or via
FOLL_UNSHARE). That's a bit more tricky but allows for decoupling that
approach completely from the page_pin() counter.

fork() is allowed to clear the bit if page_count() == 1 and share the
page. So no GUP->no fork() performance changes (!) . Otherwise the bit
can only vanish if we swapout/migrate the page: in which case there are
no additional GUP/references on the page that rely on it!

The bit can be set directly if we have to copy the page in the fault
handler (COW or unshare). Outside of COW/Unshare code, the bit can only
be set if page_count() == 1 and we sync against fork(). (and that's the
problem for gup-fast-only that I'm investigating right now, because it
would then always have to fallback to the slow variant if the bit isn't
already set)

So the bit can "vanish" whenever there is no additional reference on the
page. GUP syncs against fork() and can thereby set the bit/request to
set the bit.

I'm trying to decouple it completely from the page_pin() counter to also
be able to handle FOLL_GET (O_DIRECT reproducers unfortunately) correctly.

Not set it stone, just an idea what I'm playing with right now ... and I
have to tripple-check if
* page is PTE mapped in the page table I'm walking
* page_count() == 1
Really means that "this is the only reference.". I do strongly believe
so .. :)

-- 
Thanks,

David / dhildenb

