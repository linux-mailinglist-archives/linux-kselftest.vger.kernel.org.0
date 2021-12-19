Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952AB479E92
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 01:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhLSAgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 19:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhLSAgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 19:36:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C8FC061574
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 16:36:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o20so22815467eds.10
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 16:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BdNgjsIj5tOuYGKYyecvDBuTvXGSK6kpZuYnfNKXfG4=;
        b=SBxRL68wKMh0mduwSJE8/TfpEylwfB/WWVjsuh2IHwg8CZkHVGsqgob31zTym1LDw8
         vdy+NGL8vOBy87OVzXh0Q8UvJOMiQrtOLu4VhyLbcgfDGZ8O8+aZwDZsospELMVmT4RW
         ZwwD7WDaGLKyjNt/mpUr+96sjQo2JE152A2hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BdNgjsIj5tOuYGKYyecvDBuTvXGSK6kpZuYnfNKXfG4=;
        b=HlCTwPK9iFJFMApFn7EJLb4DdZAMW5puBLsaGo8Ubrmic6HSZ/AYH58lzFy1WZLrTU
         Rx7lzLt+xHcJiimIFIDc4Q+rTtp9rUIyrFbdEX01asXWbImFr5z6bWonKZAOS3biIYao
         TOSGRRacLB4PZBaIoj7L3fuAediQF7m5eLpm3HozAUbCDuF/rzkhc8zUUYjLxmzYMO1Y
         lrEbE71y9MwI3tGGz/MQHo7oxiaP+uOm3VXSg9jBiiONJOnkP5T0f3bCyPWZyEiEkylf
         9tR769XiKL/MBET+sv8UTpk0fNGOOE0dphy3yxXpH9y7zmK4UE+XuHyQ513RuIvWpmtZ
         /M7A==
X-Gm-Message-State: AOAM5332tC09ozLMDFGkHxFMka+Ayv2kZdU/Sd/F+uNUDF4hKgiVhZG1
        KgP8WeKYAUQWeDyyXIxM6w2k00i7X0VKb7kRtlk=
X-Google-Smtp-Source: ABdhPJzCEMvb1qQ6revctPACwuGArstDUmT6NkgX7NDplA/u2DLfZmCbQhvD+Z+U6+hxChNrc4LQ7A==
X-Received: by 2002:a17:907:d14:: with SMTP id gn20mr7561813ejc.73.1639874172420;
        Sat, 18 Dec 2021 16:36:12 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id gt17sm1813332ejc.151.2021.12.18.16.36.12
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 16:36:12 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so6875322wmb.0
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Dec 2021 16:36:12 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr8286016wms.144.1639874161442;
 Sat, 18 Dec 2021 16:36:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com> <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com> <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
 <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com> <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com> <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
In-Reply-To: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Dec 2021 16:35:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
Message-ID: <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 18, 2021 at 4:19 PM Nadav Amit <namit@vmware.com> wrote:
>
> I have always felt that the PTE software-bits limit is very artificial.
> We can just allocate two adjacent pages when needed, one for PTEs and
> one for extra software bits. A software bit in the PTE can indicate
> =E2=80=9Cextra software bits=E2=80=9D are relevant (to save cache-misses)=
, and a bit
> in the PTEs' page-struct indicate whether there is adjacent =E2=80=9Cextr=
a
> software bits=E2=80=9D page.

Hmm. That doesn't sound very bad, no. And it would be nice to have
more software bits (and have them portably).

> I don=E2=80=99t think that I am following. The write-protection of UFFD m=
eans
> that the userspace wants to intervene before anything else (including
> COW).

The point I was making (badly) is that UFFD_WP is only needed to for
the case where the pte isn't already non-writable for other reasons.

> UFFD_WP indications are recorded per PTE (i.e., not VMA).

The changing of those bits are basically a bastardized 'mprotect()',
and does already require the vma to be marked VM_UFFD_WP.

And the way you set (or clear) the bits is with a range operation. It
really could have been done with mprotect(), and with actual explicit
vma bits.

The fact that it now uses the page table bit is rather random. I think
it would actually be cleaner to make that userfaultfd_writeprotect
truly *be* a vma range.

Right now it's kind of "half this, half that".

Of course, it's possible that because of this situation, some users do
a lot of fine-grained VM_UFFD_WP setting, and they kind of expect to
not have issues with lots of vma fragments. So practical concerns may
have made the implementation set in stone.

(I have only ever seen the kernel side of uffd, not the actual user
side, so I'm not sure about the use patterns).

That said, your suggestion of a shadow sw page table bit thing would
also work. And it would solve some problems we have in core areas
(notably "page_special()" which right now has that
ARCH_HAS_PTE_SPECIAL thing).

It would make it really easy to have that "this page table entry is
pinned" flag too.

              Linus
