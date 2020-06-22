Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCCF2043AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 00:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgFVWaq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 18:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVWaq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 18:30:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDAC061573;
        Mon, 22 Jun 2020 15:30:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so6056411ejb.11;
        Mon, 22 Jun 2020 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l7mIVPy1j/cnam/uUYY8bMLQFIQliSv4zuXgPQh246o=;
        b=Pwsb9oeBu0j8MMFXMvO/QoeRRQK/fHcITcJW55FVfh1JJjng4fwYpvXU1IneQcrRW7
         LD7dMNDGKuzrDMxgWhfTICpondbKKL9PAouUdCuORnS+zlIeZ6XEuWgr8onxlJfEH0/l
         6tsDPxVue6v2ZKjiRW9yzXflx087sb2Rux6xT6Uk6DeVg3Mb/yCRUNQGmbC3mMDpCXJl
         5whB7gWzJD8GUGjNF+1EQTJLnIE+e+sT+Cn1+tIj1hwBxZtBSa/lA2mUonbqbk4pntxt
         RX/FDMCurmb8TBfHodG01tzffxKeFuKvAUUcI+ie1XGa6iSr705nfpEfm7/HUlGBNM3x
         Tndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l7mIVPy1j/cnam/uUYY8bMLQFIQliSv4zuXgPQh246o=;
        b=mbF/mP1HvnKZYCsOJLzZfHBJIoBhG5QHwQ88bq4c8yop0+HfIXf98Q0W6s9Mbqvbqz
         ild5lOHz1intjEuayqdvzZenMVBHbyPtYmrR9EdQSq+w808+SEnrkonDlSG2y1Fv2SXN
         4o4l7IQmGFEpHLUCtzrUz/Xl8unXJ3Cn0FD/K4/rGC7uG9zrM9M20sUDEWKAtX7iqOtB
         EaCi0SOhPiDBWk4OTPPUdBNdEkAls0rbO7CZ+oHDk6QZw65enstAeh5Y6CPhMmimriMO
         ObdiZD0cbyVsNLtm17tuN5VwVc323zoBj+XLbamYwrcQIO++adLDUfCpCGArZKXQtj5p
         7Oyg==
X-Gm-Message-State: AOAM531PWsmlzS+rZWganmgCgA0fYqZv8LbBlfI9Tpg2RXilPPQ1kvJ0
        IA9FP4TP4Q1iVAVLn+XJNcsJqZHnu1hi4nH18J2M9Kvw
X-Google-Smtp-Source: ABdhPJzJ4tbwUKrBs9zx94rndjWy/D6LNvS8e9C2V2fig1gCFONmOKtK4IzllJJ5OXm3iVgG0hOxsdz/9Rv4cfIk3HA=
X-Received: by 2002:a17:906:fa13:: with SMTP id lo19mr9158149ejb.213.1592865044714;
 Mon, 22 Jun 2020 15:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200619215649.32297-1-rcampbell@nvidia.com> <20200619215649.32297-14-rcampbell@nvidia.com>
 <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com> <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
 <C7BEB563-3698-442C-A188-1B66CBE4CF63@nvidia.com> <a5f502f8-70cd-014b-8066-bbaeb8024a29@nvidia.com>
 <4C364E23-0716-4D59-85A1-0C293B86BC2C@nvidia.com>
In-Reply-To: <4C364E23-0716-4D59-85A1-0C293B86BC2C@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 Jun 2020 15:30:18 -0700
Message-ID: <CAHbLzkqe50+KUsRH92O4Be2PjuwAYGw9nK+d-73syxi2Xnf9-Q@mail.gmail.com>
Subject: Re: [PATCH 13/16] mm: support THP migration to device private memory
To:     Zi Yan <ziy@nvidia.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 22, 2020 at 2:53 PM Zi Yan <ziy@nvidia.com> wrote:
>
> On 22 Jun 2020, at 17:31, Ralph Campbell wrote:
>
> > On 6/22/20 1:10 PM, Zi Yan wrote:
> >> On 22 Jun 2020, at 15:36, Ralph Campbell wrote:
> >>
> >>> On 6/21/20 4:20 PM, Zi Yan wrote:
> >>>> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
> >>>>
> >>>>> Support transparent huge page migration to ZONE_DEVICE private memo=
ry.
> >>>>> A new flag (MIGRATE_PFN_COMPOUND) is added to the input PFN array t=
o
> >>>>> indicate the huge page was fully mapped by the CPU.
> >>>>> Export prep_compound_page() so that device drivers can create huge
> >>>>> device private pages after calling memremap_pages().
> >>>>>
> >>>>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> >>>>> ---
> >>>>>    include/linux/migrate.h |   1 +
> >>>>>    include/linux/mm.h      |   1 +
> >>>>>    mm/huge_memory.c        |  30 ++++--
> >>>>>    mm/internal.h           |   1 -
> >>>>>    mm/memory.c             |  10 +-
> >>>>>    mm/memremap.c           |   9 +-
> >>>>>    mm/migrate.c            | 226 ++++++++++++++++++++++++++++++++--=
------
> >>>>>    mm/page_alloc.c         |   1 +
> >>>>>    8 files changed, 226 insertions(+), 53 deletions(-)
> >>>>>
> >>>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> >>>>> index 3e546cbf03dd..f6a64965c8bd 100644
> >>>>> --- a/include/linux/migrate.h
> >>>>> +++ b/include/linux/migrate.h
> >>>>> @@ -166,6 +166,7 @@ static inline int migrate_misplaced_transhuge_p=
age(struct mm_struct *mm,
> >>>>>    #define MIGRATE_PFN_MIGRATE    (1UL << 1)
> >>>>>    #define MIGRATE_PFN_LOCKED     (1UL << 2)
> >>>>>    #define MIGRATE_PFN_WRITE      (1UL << 3)
> >>>>> +#define MIGRATE_PFN_COMPOUND     (1UL << 4)
> >>>>>    #define MIGRATE_PFN_SHIFT      6
> >>>>>
> >>>>>    static inline struct page *migrate_pfn_to_page(unsigned long mpf=
n)
> >>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>>>> index dc7b87310c10..020b9dd3cddb 100644
> >>>>> --- a/include/linux/mm.h
> >>>>> +++ b/include/linux/mm.h
> >>>>> @@ -932,6 +932,7 @@ static inline unsigned int page_shift(struct pa=
ge *page)
> >>>>>    }
> >>>>>
> >>>>>    void free_compound_page(struct page *page);
> >>>>> +void prep_compound_page(struct page *page, unsigned int order);
> >>>>>
> >>>>>    #ifdef CONFIG_MMU
> >>>>>    /*
> >>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>> index 78c84bee7e29..25d95f7b1e98 100644
> >>>>> --- a/mm/huge_memory.c
> >>>>> +++ b/mm/huge_memory.c
> >>>>> @@ -1663,23 +1663,35 @@ int zap_huge_pmd(struct mmu_gather *tlb, st=
ruct vm_area_struct *vma,
> >>>>>           } else {
> >>>>>                   struct page *page =3D NULL;
> >>>>>                   int flush_needed =3D 1;
> >>>>> +         bool is_anon =3D false;
> >>>>>
> >>>>>                   if (pmd_present(orig_pmd)) {
> >>>>>                           page =3D pmd_page(orig_pmd);
> >>>>> +                 is_anon =3D PageAnon(page);
> >>>>>                           page_remove_rmap(page, true);
> >>>>>                           VM_BUG_ON_PAGE(page_mapcount(page) < 0, p=
age);
> >>>>>                           VM_BUG_ON_PAGE(!PageHead(page), page);
> >>>>>                   } else if (thp_migration_supported()) {
> >>>>>                           swp_entry_t entry;
> >>>>>
> >>>>> -                 VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
> >>>>>                           entry =3D pmd_to_swp_entry(orig_pmd);
> >>>>> -                 page =3D pfn_to_page(swp_offset(entry));
> >>>>> +                 if (is_device_private_entry(entry)) {
> >>>>> +                         page =3D device_private_entry_to_page(ent=
ry);
> >>>>> +                         is_anon =3D PageAnon(page);
> >>>>> +                         page_remove_rmap(page, true);
> >>>>> +                         VM_BUG_ON_PAGE(page_mapcount(page) < 0, p=
age);
> >>>>> +                         VM_BUG_ON_PAGE(!PageHead(page), page);
> >>>>> +                         put_page(page);
> >>>>
> >>>> Why do you hide this code behind thp_migration_supported()? It seems=
 that you just need
> >>>> pmd swap entry not pmd migration entry. Also the condition is not co=
nsistent with the code
> >>>> in __handle_mm_fault(), in which you handle is_device_private_entry(=
) directly without
> >>>> checking thp_migration_support().
> >>>
> >>> Good point, I think "else if (thp_migration_supported())" should be
> >>> "else if (is_pmd_migration_entry(orig_pmd))" since if the PMD *is*
> >>> a device private or migration entry, then it should be handled and th=
e
> >>> VM_BUG_ON() should be that thp_migration_supported() is true
> >>> (or maybe remove the VM_BUG_ON?).
> >>
> >> I disagree. A device private entry is independent of a PMD migration e=
ntry, since a device private
> >> entry is just a swap entry, which is available when CONFIG_TRANSPARENT=
_HUGEPAGE. So for architectures
> >> support THP but not THP migration (like ARM64), your code should still=
 work.
> >
> > I'll fix this up for v2 and you can double check me.
>
> Sure.
>
> >
> >> I would suggest you to check all the use of is_swap_pmd() and make sur=
e the code
> >> can handle is_device_private_entry().
> >
> > OK.
> >
> >> For new device private code, you might need to guard it either statica=
lly or dynamically in case
> >> CONFIG_DEVICE_PRIVATE is disabled. Potentially, you would like to make=
 sure a system without
> >> CONFIG_DEVICE_PRIVATE will not see is_device_private_entry() =3D=3D tr=
ue and give errors when it does.
> >
> > I have compiled and run with CONFIG_DEVICE_PRIVATE off but I can test m=
ore combinations of
> > config settings.
>
> Thanks.
>
> >
> >>>
> >>>> Do we need to support split_huge_pmd() if a page is migrated to devi=
ce? Any new code
> >>>> needed in split_huge_pmd()?
> >>>
> >>> I was thinking that any CPU usage of the device private page would ca=
use it to be
> >>> migrated back to system memory as a whole PMD/PUD page but I'll doubl=
e check.
> >>> At least there should be a check that the page isn't a device private=
 page.
> >>
> >> Well, that depends. If we can allocate a THP on CPU memory, we can mig=
rate the whole page back.
> >> But if no THP is allocated due to low on free memory or memory fragmen=
tation, I think you
> >> might need a fallback plan, either splitting the device private page a=
nd migrating smaller
> >> pages instead or reclaiming CPU memory until you get a THP. IMHO, the =
former might be preferred,
> >> since the latter might cost a lot of CPU cycles but still gives no THP=
 after all.
> >
> > Sounds reasonable. I'll work on adding the fallback path for v2.
>
> Ying(cc=E2=80=99d) developed the code to swapout and swapin THP in one pi=
ece: https://lore.kernel.org/linux-mm/20181207054122.27822-1-ying.huang@int=
el.com/.
> I am not sure whether the patchset makes into mainstream or not. It could=
 be a good technical reference
> for swapping in device private pages, although swapping in pages from dis=
k and from device private
> memory are two different scenarios.
>
> Since the device private memory swapin impacts core mm performance, we mi=
ght want to discuss your patches
> with more people, like the ones from Ying=E2=80=99s patchset, in the next=
 version.

I believe Ying will give you more insights about how THP swap works.

But, IMHO device memory migration (migrate to system memory) seems
like THP CoW more than swap.

When migrating in:

>
>
>
> =E2=80=94
> Best Regards,
> Yan Zi
