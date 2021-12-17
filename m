Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD147948A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhLQTGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 14:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhLQTGq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 14:06:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD936C061574;
        Fri, 17 Dec 2021 11:06:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so11625841edd.3;
        Fri, 17 Dec 2021 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdWa3VZPKatai3gF8Z+Urkz4ghMCS8ZDk6ZieZNqaIs=;
        b=ZIJEwmc3dUjMQ8EZETYRFKYSgxnB7pGz8xLptALl9BU9T00ihDHDK5FDNa1lYMJvjN
         MezA8fFtv3wu7YNOlCqI1D6Xa330lfBp1fRlHGc32VBxQcXb7/QN1MngCijkXmAK9K4f
         IowAITb4zD445Ivb0clvo+Fdia78+IZV9ZhBAIm9gxxL/jJAjzAtK4xRBVu0xKjGg9mN
         vNwY41BUKpZBiaGNxBoTXyWQIHN8xWofKrbQGG+dSAcD/S4srVPrX+fFafoa3Y7Z8qo7
         o3HJSdrU23xhXC0txymOh02wxJhmZEgWKAdYqxmnvXwBqAYOmDBa1Fd0cRhL+OEHOtU2
         EQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdWa3VZPKatai3gF8Z+Urkz4ghMCS8ZDk6ZieZNqaIs=;
        b=HW8+q5cUAZ6qn0DrM0pm11wqzOLugel334yqS8PNuCekMklMk3sEi/GRmRdnxPX5oi
         Ggwcwkyf2CpKbgXqyJu6Ya01Bsv8Qe2l5GSqFTPWhTZgbA755gW6wN1SKSXzYDi5+byh
         jhIDKJU9xLk8RMum/RFqNDhvaPihMlYM6GNSs7S8a6ZwwPK1A/OgiKs/0Vdczk8QIww+
         F6Luq7CEU6zK2Rr1zxtpo7sKdU5hxSeGe1LhkBLjd4yjjWHECIz+gvH4Voucv4HldYCa
         mzX832iyXGqo1BJa0wWWCxS/ZMEpGKnrZHivcY7yV9dpIVet4Vqds7LUd1NSdZm7n6nD
         ueRg==
X-Gm-Message-State: AOAM532fSLBfosn3pAhgGz7rzq2ntGZwn1tUIlJTzKzDv4ebacXR5r14
        vb5nwBgLCB8ZnbBalbP1rWaB+/iqLqVMfkc/XUg=
X-Google-Smtp-Source: ABdhPJwxDib3+r9/gWzmhjMAr3HWYlGtU2PoZVL15X+h8JOVYHxqutwxRbVQVuEYBvrj86uySi9x5gAUnGZyFvklEQY=
X-Received: by 2002:a50:c38c:: with SMTP id h12mr4189423edf.72.1639768004419;
 Fri, 17 Dec 2021 11:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-3-david@redhat.com>
In-Reply-To: <20211217113049.23850-3-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Dec 2021 11:06:31 -0800
Message-ID: <CAHbLzkp8B8zPSE-jdObqLJ=YxST8=J58FaiHxRq_ESgOG_LjCg@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] mm: thp: consolidate mapcount logic on THP split
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 3:33 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's consolidate the mapcount logic to make it easier to understand and
> to prepare for further changes.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e5483347291c..4751d03947da 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2101,21 +2101,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 pte = pte_offset_map(&_pmd, addr);
>                 BUG_ON(!pte_none(*pte));
>                 set_pte_at(mm, addr, pte, entry);
> -               if (!pmd_migration)
> -                       atomic_inc(&page[i]._mapcount);
>                 pte_unmap(pte);
>         }
>
>         if (!pmd_migration) {
> +               /* Sub-page mapcount accounting for above small mappings. */
> +               int val = 1;
> +
>                 /*
>                  * Set PG_double_map before dropping compound_mapcount to avoid
>                  * false-negative page_mapped().
> +                *
> +                * The first to set PageDoubleMap() has to increment all
> +                * sub-page mapcounts by one.
>                  */
> -               if (compound_mapcount(page) > 1 &&
> -                   !TestSetPageDoubleMap(page)) {
> -                       for (i = 0; i < HPAGE_PMD_NR; i++)
> -                               atomic_inc(&page[i]._mapcount);
> -               }
> +               if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page))
> +                       val++;
> +
> +               for (i = 0; i < HPAGE_PMD_NR; i++)
> +                       atomic_add(val, &page[i]._mapcount);
>
>                 lock_page_memcg(page);
>                 if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
> --
> 2.31.1
>
