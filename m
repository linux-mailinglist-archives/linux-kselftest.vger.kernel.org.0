Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875ED25B54D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIBUaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 16:30:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664AC061244;
        Wed,  2 Sep 2020 13:30:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so573306eja.3;
        Wed, 02 Sep 2020 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zH/GO18AuMjI+jK60xohkdSw2ATSnXJ1BTZdunQxr8=;
        b=IAoO8HB+G4Gyxmg6TnoHZXWP6md6wpAtsLFdpd3vUebwvRvqcoVRuBCDnz/KwTghTi
         FMiWdDJHnmdrDXvNpHBztg0GN7b8bTiFnsayrcfnI5gVZh6gHQL9mBRnYmP7nP+EZ9lZ
         TX97o8nHu5w0HGswgD+AbbJl4hU4O1TNzhIPFumoWsQFXQX8UWHdmpLFtVm1F5lO93sd
         4wxacqz8aXRzM2jY6iIRrO9fDA8ROkic5StX2H+QWptrC3xT6ASA8y/hnreHlV01VAQQ
         LvKvikYQuQseVGP2U3g1JwLzFdOhSLOMqVSUxAzm8qa3Olc6wd79QZJlwZFNTXIQ/dSx
         oz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zH/GO18AuMjI+jK60xohkdSw2ATSnXJ1BTZdunQxr8=;
        b=k/65fwrewiikprofofflsd+Laf/VacLprJM7SUtRd/617XDhwaLno8t/1pGknI6oJ2
         1cfsX5F684U6uzcwXUKYWJiAehwLeFuSWcInB+3MYGCJ+W3h91IGum0f7FPBIRUuUoZw
         yaRpcy5PzcofvKQwdZkMRz6WYWsntQGFJ5hBysy/Ja6nYgUZK+a+mHjwOcDRY7CflKSw
         tqezygQ7KwWOIve5WwxfQQEbFLkpr+pqqmI5Jic8fJNpR2UQKMXdBUnvI/XzHCpRC0z/
         Ihv7JBR9XXmetamcMKqHBFcSSNLjc2l/Jd0btHBZLHu9pkOw+WYImsK1Gnxpg/LgzVtr
         34dg==
X-Gm-Message-State: AOAM530/+WbXEPTy2LoVBBwaRSIV/MWO8CCj/Jdh8r8vVcPAkTMKZ8H4
        aMo6L9Ay2vO4h+PRiC1mfooczR3ozw6eAqhTA2Y=
X-Google-Smtp-Source: ABdhPJyzZFQeDPZketWOBEluKgnVpcrzxpuAdbHhXq4uZ8DSciz92IF8wEci8O8j7o4XyYup4i+USOLVMflTEi0tKuM=
X-Received: by 2002:a17:906:3a85:: with SMTP id y5mr1758578ejd.507.1599078608948;
 Wed, 02 Sep 2020 13:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200902165830.5367-1-rcampbell@nvidia.com> <20200902165830.5367-2-rcampbell@nvidia.com>
In-Reply-To: <20200902165830.5367-2-rcampbell@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Sep 2020 13:29:56 -0700
Message-ID: <CAHbLzkqAHfVq4upkJBvWQ9XtXFfFx5=qUO4+i5XjFeNwS9XVHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mm/thp: fix __split_huge_pmd_locked() for
 migration PMD
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>, nouveau@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 2, 2020 at 9:58 AM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> A migrating transparent huge page has to already be unmapped. Otherwise,
> the page could be modified while it is being copied to a new page and
> data could be lost. The function __split_huge_pmd() checks for a PMD
> migration entry before calling __split_huge_pmd_locked() leading one to
> think that __split_huge_pmd_locked() can handle splitting a migrating PMD.
> However, the code always increments the page->_mapcount and adjusts the
> memory control group accounting assuming the page is mapped.
> Also, if the PMD entry is a migration PMD entry, the call to
> is_huge_zero_pmd(*pmd) is incorrect because it calls pmd_pfn(pmd) instead
> of migration_entry_to_pfn(pmd_to_swp_entry(pmd)).
> Fix these problems by checking for a PMD migration entry.

Thanks for catching this. The fix looks good to me. Reviewed-by: Yang
Shi <shy828301@gmail.com>

I think this fix can go separately with the series.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  mm/huge_memory.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a468a4acb0a..606d712d9505 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2023,7 +2023,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 put_page(page);
>                 add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
>                 return;
> -       } else if (is_huge_zero_pmd(*pmd)) {
> +       } else if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
>                 /*
>                  * FIXME: Do we want to invalidate secondary mmu by calling
>                  * mmu_notifier_invalidate_range() see comments below inside
> @@ -2117,30 +2117,34 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 pte = pte_offset_map(&_pmd, addr);
>                 BUG_ON(!pte_none(*pte));
>                 set_pte_at(mm, addr, pte, entry);
> -               atomic_inc(&page[i]._mapcount);
> -               pte_unmap(pte);
> -       }
> -
> -       /*
> -        * Set PG_double_map before dropping compound_mapcount to avoid
> -        * false-negative page_mapped().
> -        */
> -       if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> -               for (i = 0; i < HPAGE_PMD_NR; i++)
> +               if (!pmd_migration)
>                         atomic_inc(&page[i]._mapcount);
> +               pte_unmap(pte);
>         }
>
> -       lock_page_memcg(page);
> -       if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
> -               /* Last compound_mapcount is gone. */
> -               __dec_lruvec_page_state(page, NR_ANON_THPS);
> -               if (TestClearPageDoubleMap(page)) {
> -                       /* No need in mapcount reference anymore */
> +       if (!pmd_migration) {
> +               /*
> +                * Set PG_double_map before dropping compound_mapcount to avoid
> +                * false-negative page_mapped().
> +                */
> +               if (compound_mapcount(page) > 1 &&
> +                   !TestSetPageDoubleMap(page)) {
>                         for (i = 0; i < HPAGE_PMD_NR; i++)
> -                               atomic_dec(&page[i]._mapcount);
> +                               atomic_inc(&page[i]._mapcount);
> +               }
> +
> +               lock_page_memcg(page);
> +               if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
> +                       /* Last compound_mapcount is gone. */
> +                       __dec_lruvec_page_state(page, NR_ANON_THPS);
> +                       if (TestClearPageDoubleMap(page)) {
> +                               /* No need in mapcount reference anymore */
> +                               for (i = 0; i < HPAGE_PMD_NR; i++)
> +                                       atomic_dec(&page[i]._mapcount);
> +                       }
>                 }
> +               unlock_page_memcg(page);
>         }
> -       unlock_page_memcg(page);
>
>         smp_wmb(); /* make pte visible before pmd */
>         pmd_populate(mm, pmd, pgtable);
> --
> 2.20.1
>
>
