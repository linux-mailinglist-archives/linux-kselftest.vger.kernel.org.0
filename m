Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75A2043B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbgFVWdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 18:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgFVWdn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 18:33:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22837C061573;
        Mon, 22 Jun 2020 15:33:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so19619582ejc.8;
        Mon, 22 Jun 2020 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CGd4i4NLS2EMxIc+JA74Q15iFKLfdGBhD37cRnfN0VU=;
        b=VZ2dE7Guy9EfwntiDuunRUKwi9Bve6L3GsKayZWfpNDHAe7HdHCi0/SdyuCYhV3SPd
         F851tdd5C4hPYXJPhi5fF02o4Orzvtv6ocW8RbqLtLiZtAKFML788/Za0oBLAZ2TppwN
         TJTu5Bn2+gmIPk8L0fSmt/cAu91j3INWNH+i+O2+8+tn1sI1R5LCtbEJ4PGNN7qvIGMc
         KH1SjD8EEWKANF7LoAV+pkDhQYNGzkGBQ8V4yw5t6xZd2jaGXZWBaWYLnrCOyPqhsQUV
         O6IXdoc3j8DTrnHy+nwG5IdvPqZWM6ENSCRa6Q8Ul3xkiS34MuwHhryqr6kWPE0bWY+9
         iCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CGd4i4NLS2EMxIc+JA74Q15iFKLfdGBhD37cRnfN0VU=;
        b=lXlKj7dMOu/ihddijaPb6edFK7MhbEvgNl5VA/+x4nq3LhXJIY9OVsw86bU+4lf723
         jVAM9GJQL5YxSrbEJCkrCZX8JAQ9a3C4PYZbRYUvf0/48HpXJOh0ih31T+Js3hdX3us9
         oGPL88WDaL2pwgPdGGuxWjpcZ0uZsGJV2JyOKBdTZNLCGwVFPLtbCE/8KyxOQ7I9Gy/m
         L9k2/RCY/Mp2OVArlf5ZsD0zpTMB5hGMOUrMJR5dTWhi+nDXeS47ZZuwQZAGxoq71sWQ
         pXpTOpi8U4klgzHIL78K1+P+f+TvrH3TqLIDjwsOrR3PU9MijJyV5LWU73XvOni0AQ8E
         tAbg==
X-Gm-Message-State: AOAM531DQnwMpBWXIaFNgAhcIA/Mr9XvUNMuN+xtYVTTJtWfbSOQq0qa
        ZCr0TggFnxH0Q7JoTDCM4nzdOEY178wN4lChn5s=
X-Google-Smtp-Source: ABdhPJzQX3qNgoDhhgy7btnOZDEEF+vGCPfDMp6W5HDW1RlpZtT2TWgHOzDDiCjHbgYw9d8UQAAQiHTr7k5S+LeirLU=
X-Received: by 2002:a17:907:2058:: with SMTP id pg24mr9311905ejb.79.1592865221789;
 Mon, 22 Jun 2020 15:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200619215649.32297-1-rcampbell@nvidia.com> <20200619215649.32297-14-rcampbell@nvidia.com>
 <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com> <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
 <C7BEB563-3698-442C-A188-1B66CBE4CF63@nvidia.com> <a5f502f8-70cd-014b-8066-bbaeb8024a29@nvidia.com>
 <4C364E23-0716-4D59-85A1-0C293B86BC2C@nvidia.com> <CAHbLzkqe50+KUsRH92O4Be2PjuwAYGw9nK+d-73syxi2Xnf9-Q@mail.gmail.com>
In-Reply-To: <CAHbLzkqe50+KUsRH92O4Be2PjuwAYGw9nK+d-73syxi2Xnf9-Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 Jun 2020 15:33:15 -0700
Message-ID: <CAHbLzko=BqtPhxgf7f1bKKqoQxK9XCCPdp4YdL80K_uXFfcETQ@mail.gmail.com>
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

On Mon, Jun 22, 2020 at 3:30 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Jun 22, 2020 at 2:53 PM Zi Yan <ziy@nvidia.com> wrote:
> >
> > On 22 Jun 2020, at 17:31, Ralph Campbell wrote:
> >
> > > On 6/22/20 1:10 PM, Zi Yan wrote:
> > >> On 22 Jun 2020, at 15:36, Ralph Campbell wrote:
> > >>
> > >>> On 6/21/20 4:20 PM, Zi Yan wrote:
> > >>>> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
> > >>>>
> > >>>>> Support transparent huge page migration to ZONE_DEVICE private me=
mory.
> > >>>>> A new flag (MIGRATE_PFN_COMPOUND) is added to the input PFN array=
 to
> > >>>>> indicate the huge page was fully mapped by the CPU.
> > >>>>> Export prep_compound_page() so that device drivers can create hug=
e
> > >>>>> device private pages after calling memremap_pages().
> > >>>>>
> > >>>>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > >>>>> ---
> > >>>>>    include/linux/migrate.h |   1 +
> > >>>>>    include/linux/mm.h      |   1 +
> > >>>>>    mm/huge_memory.c        |  30 ++++--
> > >>>>>    mm/internal.h           |   1 -
> > >>>>>    mm/memory.c             |  10 +-
> > >>>>>    mm/memremap.c           |   9 +-
> > >>>>>    mm/migrate.c            | 226 ++++++++++++++++++++++++++++++++=
--------
> > >>>>>    mm/page_alloc.c         |   1 +
> > >>>>>    8 files changed, 226 insertions(+), 53 deletions(-)
> > >>>>>
> > >>>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > >>>>> index 3e546cbf03dd..f6a64965c8bd 100644
> > >>>>> --- a/include/linux/migrate.h
> > >>>>> +++ b/include/linux/migrate.h
> > >>>>> @@ -166,6 +166,7 @@ static inline int migrate_misplaced_transhuge=
_page(struct mm_struct *mm,
> > >>>>>    #define MIGRATE_PFN_MIGRATE    (1UL << 1)
> > >>>>>    #define MIGRATE_PFN_LOCKED     (1UL << 2)
> > >>>>>    #define MIGRATE_PFN_WRITE      (1UL << 3)
> > >>>>> +#define MIGRATE_PFN_COMPOUND     (1UL << 4)
> > >>>>>    #define MIGRATE_PFN_SHIFT      6
> > >>>>>
> > >>>>>    static inline struct page *migrate_pfn_to_page(unsigned long m=
pfn)
> > >>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> > >>>>> index dc7b87310c10..020b9dd3cddb 100644
> > >>>>> --- a/include/linux/mm.h
> > >>>>> +++ b/include/linux/mm.h
> > >>>>> @@ -932,6 +932,7 @@ static inline unsigned int page_shift(struct =
page *page)
> > >>>>>    }
> > >>>>>
> > >>>>>    void free_compound_page(struct page *page);
> > >>>>> +void prep_compound_page(struct page *page, unsigned int order);
> > >>>>>
> > >>>>>    #ifdef CONFIG_MMU
> > >>>>>    /*
> > >>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > >>>>> index 78c84bee7e29..25d95f7b1e98 100644
> > >>>>> --- a/mm/huge_memory.c
> > >>>>> +++ b/mm/huge_memory.c
> > >>>>> @@ -1663,23 +1663,35 @@ int zap_huge_pmd(struct mmu_gather *tlb, =
struct vm_area_struct *vma,
> > >>>>>           } else {
> > >>>>>                   struct page *page =3D NULL;
> > >>>>>                   int flush_needed =3D 1;
> > >>>>> +         bool is_anon =3D false;
> > >>>>>
> > >>>>>                   if (pmd_present(orig_pmd)) {
> > >>>>>                           page =3D pmd_page(orig_pmd);
> > >>>>> +                 is_anon =3D PageAnon(page);
> > >>>>>                           page_remove_rmap(page, true);
> > >>>>>                           VM_BUG_ON_PAGE(page_mapcount(page) < 0,=
 page);
> > >>>>>                           VM_BUG_ON_PAGE(!PageHead(page), page);
> > >>>>>                   } else if (thp_migration_supported()) {
> > >>>>>                           swp_entry_t entry;
> > >>>>>
> > >>>>> -                 VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
> > >>>>>                           entry =3D pmd_to_swp_entry(orig_pmd);
> > >>>>> -                 page =3D pfn_to_page(swp_offset(entry));
> > >>>>> +                 if (is_device_private_entry(entry)) {
> > >>>>> +                         page =3D device_private_entry_to_page(e=
ntry);
> > >>>>> +                         is_anon =3D PageAnon(page);
> > >>>>> +                         page_remove_rmap(page, true);
> > >>>>> +                         VM_BUG_ON_PAGE(page_mapcount(page) < 0,=
 page);
> > >>>>> +                         VM_BUG_ON_PAGE(!PageHead(page), page);
> > >>>>> +                         put_page(page);
> > >>>>
> > >>>> Why do you hide this code behind thp_migration_supported()? It see=
ms that you just need
> > >>>> pmd swap entry not pmd migration entry. Also the condition is not =
consistent with the code
> > >>>> in __handle_mm_fault(), in which you handle is_device_private_entr=
y() directly without
> > >>>> checking thp_migration_support().
> > >>>
> > >>> Good point, I think "else if (thp_migration_supported())" should be
> > >>> "else if (is_pmd_migration_entry(orig_pmd))" since if the PMD *is*
> > >>> a device private or migration entry, then it should be handled and =
the
> > >>> VM_BUG_ON() should be that thp_migration_supported() is true
> > >>> (or maybe remove the VM_BUG_ON?).
> > >>
> > >> I disagree. A device private entry is independent of a PMD migration=
 entry, since a device private
> > >> entry is just a swap entry, which is available when CONFIG_TRANSPARE=
NT_HUGEPAGE. So for architectures
> > >> support THP but not THP migration (like ARM64), your code should sti=
ll work.
> > >
> > > I'll fix this up for v2 and you can double check me.
> >
> > Sure.
> >
> > >
> > >> I would suggest you to check all the use of is_swap_pmd() and make s=
ure the code
> > >> can handle is_device_private_entry().
> > >
> > > OK.
> > >
> > >> For new device private code, you might need to guard it either stati=
cally or dynamically in case
> > >> CONFIG_DEVICE_PRIVATE is disabled. Potentially, you would like to ma=
ke sure a system without
> > >> CONFIG_DEVICE_PRIVATE will not see is_device_private_entry() =3D=3D =
true and give errors when it does.
> > >
> > > I have compiled and run with CONFIG_DEVICE_PRIVATE off but I can test=
 more combinations of
> > > config settings.
> >
> > Thanks.
> >
> > >
> > >>>
> > >>>> Do we need to support split_huge_pmd() if a page is migrated to de=
vice? Any new code
> > >>>> needed in split_huge_pmd()?
> > >>>
> > >>> I was thinking that any CPU usage of the device private page would =
cause it to be
> > >>> migrated back to system memory as a whole PMD/PUD page but I'll dou=
ble check.
> > >>> At least there should be a check that the page isn't a device priva=
te page.
> > >>
> > >> Well, that depends. If we can allocate a THP on CPU memory, we can m=
igrate the whole page back.
> > >> But if no THP is allocated due to low on free memory or memory fragm=
entation, I think you
> > >> might need a fallback plan, either splitting the device private page=
 and migrating smaller
> > >> pages instead or reclaiming CPU memory until you get a THP. IMHO, th=
e former might be preferred,
> > >> since the latter might cost a lot of CPU cycles but still gives no T=
HP after all.
> > >
> > > Sounds reasonable. I'll work on adding the fallback path for v2.
> >
> > Ying(cc=E2=80=99d) developed the code to swapout and swapin THP in one =
piece: https://lore.kernel.org/linux-mm/20181207054122.27822-1-ying.huang@i=
ntel.com/.
> > I am not sure whether the patchset makes into mainstream or not. It cou=
ld be a good technical reference
> > for swapping in device private pages, although swapping in pages from d=
isk and from device private
> > memory are two different scenarios.
> >
> > Since the device private memory swapin impacts core mm performance, we =
might want to discuss your patches
> > with more people, like the ones from Ying=E2=80=99s patchset, in the ne=
xt version.
>
> I believe Ying will give you more insights about how THP swap works.
>
> But, IMHO device memory migration (migrate to system memory) seems
> like THP CoW more than swap.
>
> When migrating in:

Sorry for my fat finger, hit sent button inadvertently, let me finish here.

When migrating in:

        - if THP is enabled: allocate THP, but need handle allocation
failure by falling back to base page
        - if THP is disabled: fallback to base page

>
> >
> >
> >
> > =E2=80=94
> > Best Regards,
> > Yan Zi
