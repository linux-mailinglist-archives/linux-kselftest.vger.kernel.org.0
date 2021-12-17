Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3FC479493
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 20:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbhLQTIH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 14:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhLQTIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 14:08:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D4C061574;
        Fri, 17 Dec 2021 11:08:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z29so11539949edl.7;
        Fri, 17 Dec 2021 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WK+ToRqRpjFtq55fzYiMQ1E3tNzI8dYyryjt+FG5VtA=;
        b=e3QOqhJFnWNU33dn6TdBmexF6Tj1Ak7tnkpcMVyJfCT0u0P8ryrezyUiXLZfV3VbJ0
         2G9O9DuPHQ6udecssDn3Tk2EFn6tJHwYNPrDaW9+4R/QAg5nBeUVngPwmhyBRzWvnLRY
         TtVzMMJfYcm5sdj9uORbLvFDR1UOT7LFi0EOAtYyXmFoxTN3xsgtl6VNVyYdYbiPshd2
         YBBapDFxpVF6HY/m8xNCYiOg1tvdqhtus9Ql8+kS3jBIY9fQvswUAn2acIY6CMDaEYLR
         JZ+Mb+0Tp/SdWbk6XyNv5K8lJXQbQm8ULUIxB6VGbgfvxLPTDNrDVOFcZRANVR2S8YKs
         KBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WK+ToRqRpjFtq55fzYiMQ1E3tNzI8dYyryjt+FG5VtA=;
        b=QJnS/xqi1y41k3BnefSxN8yZGA3pp3DSUszg3zMW41uQ9gUSQ/UX3IbOwbDETdGM1N
         bTzUrzozMTok4v2UJqtzW+TFHlbDCB2fM299ZAmQPkx6JX8+Ny0AFC0XQKhv5e3IBdqo
         8Hr4cJEZHGRGtX8DKOTCA8rsRyS7O7LyE39GzJmZTkk3GpL8mD/XyMD8lSv5DDuYcqlh
         73grLJsgpmHY01yDaheczPc6lII4vGjY1si7yMuGVkIGSy5txrx4r9X81DNRnGACx9p2
         A6ocSmyfi4KLZgjCM3Am/6vIQf3TGgoUJ/0NlVJtnioxGoi5XqIgOeSpzkcZPchqqWym
         kMOg==
X-Gm-Message-State: AOAM533mGBlZZ6R0CneUNfLPTtIlzIzPV4oxf/4n4Eg0TCXB5ZoRQscu
        vaxpOJpHv6qhM3eGeugOeGFKS+jWQiQO7hl86wA=
X-Google-Smtp-Source: ABdhPJxmvZsapI9CGh3nUlgNVxMedtvtv3rAtu/K2ti94lr2XS6pUN4PkGiaeOCycRylTjivSImbajYp/8Nj+gol7G4=
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr4102234edc.93.1639768084985;
 Fri, 17 Dec 2021 11:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-4-david@redhat.com>
In-Reply-To: <20211217113049.23850-4-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Dec 2021 11:07:52 -0800
Message-ID: <CAHbLzkpgqu0HWtxRqf7vhVBmeMAP0OxXdidHeM8NRjC_uUwo=A@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] mm: simplify hugetlb and file-THP handling in __page_mapcount()
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
> Let's return early for hugetlb, which really only relies on the compound
> mapcount so far and does not support PageDoubleMap() yet. Use the chance
> to cleanup the file-THP case to make it easier to grasp. While at it, use
> head_compound_mapcount().
>
> This is a preparation for further changes.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/util.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index 741ba32a43ac..3239e75c148d 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -732,15 +732,18 @@ int __page_mapcount(struct page *page)
>  {
>         int ret;
>
> -       ret = atomic_read(&page->_mapcount) + 1;
> +       if (PageHuge(page))
> +               return compound_mapcount(page);
>         /*
>          * For file THP page->_mapcount contains total number of mapping
>          * of the page: no need to look into compound_mapcount.
>          */
> -       if (!PageAnon(page) && !PageHuge(page))
> -               return ret;
> +       if (!PageAnon(page))
> +               return atomic_read(&page->_mapcount) + 1;
> +
> +       ret = atomic_read(&page->_mapcount) + 1;
>         page = compound_head(page);
> -       ret += atomic_read(compound_mapcount_ptr(page)) + 1;
> +       ret += head_compound_mapcount(page);
>         if (PageDoubleMap(page))
>                 ret--;
>         return ret;
> --
> 2.31.1
>
