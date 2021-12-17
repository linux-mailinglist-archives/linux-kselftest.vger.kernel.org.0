Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236C64794A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 20:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbhLQTMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 14:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbhLQTMb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 14:12:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07072C061574;
        Fri, 17 Dec 2021 11:12:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o20so11544333eds.10;
        Fri, 17 Dec 2021 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtA+D/GKcXkmGS81BrQab99wr1YM7atdDJaaJPs4yd4=;
        b=OAE3NSrqY7N8TDFAl/ZfWhdiOltwuyGlstIhlKoag/+sDbeTKXt5kLlhoISXOnLPPe
         6ZKiOTpWvOO3kWFSrmahXXY+DYJu2x8h543xRPfRXGVSj236yIYD1Rv+SrWfwGV5wpjb
         haWDNTdHnAY/NbqrAdJ+ur356PVG+dAWH7pxJde5bwKXpv2UtjYUvqRTpOvCUXGOjx/l
         ddwPPT0O6CtClv59mBd4YZRSYZC5EJL9EXdshNhmSaDaDM8lypbIdmQNWBYuwNL3kkz+
         JPGewUnb71vTWDNiNouWe4tOllZNmaPHxGLFqXc9XkjhwuzzagUN0FG98sVXM2CDQDmE
         tDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtA+D/GKcXkmGS81BrQab99wr1YM7atdDJaaJPs4yd4=;
        b=kYOePxtLPQRulut2wlOnFneYLFMXjVYxdZi/Jp6fqA0KTNvs23OtXWDouByV5SdE00
         0KN1PUmsnPcaijcMcXvo6IQqgikJXH3w0/uFSeLriJY+6aDeRpw1TdoEhAkduEOf5Upg
         cSa5tQ+jjMpytb22+dTznFkdj2DXwqD5VavpesSXhjIRlEpYhnDBOJDV9uKgrIchgspV
         8Qk1/cTV2QyQZk+Um55UXO7W7hSrkQihmkMa9BAeYjZmp9usDBVQ2P63vMhSb8ugV7sQ
         2YtRZojGvnMj9yvyujxUf+3OeSYEqH8S9tMG8eepiO8FXz9eiZ4D6kSQk8BWbbKdtmnN
         VybA==
X-Gm-Message-State: AOAM531FpP1gVvhx4ivtsbv0FDSSaEIjq3nMDFC7rswhAjnHBg6UPLhT
        nR4NxUreB2PWS6ntuEW/YioVbogkIJaLbV2QCuI=
X-Google-Smtp-Source: ABdhPJyrymEFaHUqSzfHGmo/atDOMQ/Ei62r4vaOWyPsPrS5v/f+Cp5Matsz3dCoqYC/uuCPuteamxm5V9/Jx/4Yt6U=
X-Received: by 2002:aa7:c641:: with SMTP id z1mr742013edr.84.1639768349688;
 Fri, 17 Dec 2021 11:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-5-david@redhat.com>
In-Reply-To: <20211217113049.23850-5-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Dec 2021 11:12:17 -0800
Message-ID: <CAHbLzkrY3MBsr+xKp_6zr8jwe=d1ua_5tpgVHjBgU90srW2Srw@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] mm: thp: simlify total_mapcount()
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
> Let's simplify a bit, returning for PageHuge() early and using
> head_compound_page() as we are only getting called for HEAD pages.
>
> Note the VM_BUG_ON_PAGE(PageTail(page), page) check at the beginning of
> total_mapcount().
>
> This is a preparation for further changes.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4751d03947da..826cabcad11a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2506,12 +2506,11 @@ int total_mapcount(struct page *page)
>
>         if (likely(!PageCompound(page)))
>                 return atomic_read(&page->_mapcount) + 1;
> +       if (PageHuge(page))
> +               return head_compound_mapcount(page);
>
> -       compound = compound_mapcount(page);
>         nr = compound_nr(page);
> -       if (PageHuge(page))
> -               return compound;
> -       ret = compound;
> +       ret = compound = head_compound_mapcount(page);
>         for (i = 0; i < nr; i++)
>                 ret += atomic_read(&page[i]._mapcount) + 1;
>         /* File pages has compound_mapcount included in _mapcount */
> --
> 2.31.1
>
