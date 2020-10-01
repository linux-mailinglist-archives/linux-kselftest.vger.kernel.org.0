Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0A280420
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgJAQky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbgJAQkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 12:40:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997CEC0613D0
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Oct 2020 09:40:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so2175943pjr.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Oct 2020 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BhViEJ9kRSQ/IG1T1TkzoBPyuNu0pK+HvN/PTEqevH0=;
        b=C5gInYME/Klm/cpvzrfocmw5prsZd4pyMjj6JN917WouMPRNa3AKNrVLjkWaREizg4
         kzossL8UljyChrHfdbzses3iiLXNFDDZbUcvOXOqOX5ucmv5We+4KQBZtXOb//ynUWpq
         LQYA1sT02zAVplApoCnnAq4hRMr9DgQHbZZHZXqDfP60hjMIoTZkkg9ydUYwAJekoIzR
         uW7yaFiRsj3DhI1JGD8HShzSUxMWIikKi3Gz3ExkCd7AWicqmPI5gg1IA233dQhyTQXK
         gwIZEdr0UWh7n8cYLUjuwLxhE3zZGLJZzfjsixb863iauRMwCpsOI8e0ykkzN/dudQWq
         7HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BhViEJ9kRSQ/IG1T1TkzoBPyuNu0pK+HvN/PTEqevH0=;
        b=Ca9mxPFy1hDp/ncAtwGHFsDqyv1eYkhxGfxaX++zrGfYcfkuJDcH8FlHNvAhJflxk/
         8trpljP0dTefaJFGJf6WB4xTwBQe1AZQEHYD5SNC2SUtlkY4qjExPY5JJ8tDWXSdpu9M
         L5ytvJ1FQuIARSl42EXp4ipjC58t5+6MBtNf6d8TY2vXcMto/S7X2MxLb8gNpa1UQpQx
         CkT48ksjjbEppFsHdybjR832JvgCM+naAudu/86OwV3tdOdWjGYnXagkwPkiWIPZ8rQs
         uLkWY/NL1EymU2RBHc7+s68wTnZ6NPOipL1FGteCdl6LTaMVyJdFqb2kpLl9dZa0EQud
         yJ8Q==
X-Gm-Message-State: AOAM533mT60Tkx6Kuznz4QoMYVITxx51xLLsHLn4QSCZcq8/lHSZLw9D
        EO+HrSm3JR2VNgX4BHdMFh3ibN3plLwHanPVlSW9Mg==
X-Google-Smtp-Source: ABdhPJyx3q3zHvKuYsEdvxRmWaWvE04o9Ca60zBeZMuIt2zg98T8k94AANCWuXO4DTktW4giq9wmEk6piC7Jrf+W0tA=
X-Received: by 2002:a17:90a:17cd:: with SMTP id q71mr808545pja.52.1601570452875;
 Thu, 01 Oct 2020 09:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930222130.4175584-4-kaleshsingh@google.com> <20201001123651.arcr5gqtia2myt22@black.fi.intel.com>
In-Reply-To: <20201001123651.arcr5gqtia2myt22@black.fi.intel.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 1 Oct 2020 12:40:41 -0400
Message-ID: <CAC_TJvft1MfzF0AVBjZ_CCk+NKuwFzjduv5xoG2oLW70FzH8CQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: Speedup mremap on 1GB or larger regions
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Brian Geffon <bgeffon@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 1, 2020 at 8:37 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Sep 30, 2020 at 10:21:20PM +0000, Kalesh Singh wrote:
> > Android needs to move large memory regions for garbage collection.
> > Optimize mremap for >=3D 1GB-sized regions by moving at the PUD/PGD
> > level if the source and destination addresses are PUD-aligned.
> > For CONFIG_PGTABLE_LEVELS =3D=3D 3, moving at the PUD level in effect m=
oves
> > PGD entries, since the PUD entry is =E2=80=9Cfolded back=E2=80=9D onto =
the PGD entry.
> > Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
> > isn't supported/tested can turn this off by not selecting the config.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/Kconfig                     |   7 +
> >  arch/arm64/include/asm/pgtable.h |   1 +
> >  mm/mremap.c                      | 211 ++++++++++++++++++++++++++-----
> >  3 files changed, 189 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index af14a567b493..5eabaa00bf9b 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -602,6 +602,13 @@ config HAVE_IRQ_TIME_ACCOUNTING
> >         Archs need to ensure they use a high enough resolution clock to
> >         support irq time accounting and then call enable_sched_clock_ir=
qtime().
> >
> > +config HAVE_MOVE_PUD
> > +     bool
> > +     help
> > +       Architectures that select this are able to move page tables at =
the
> > +       PUD level. If there are only 3 page table levels, the move effe=
ctively
> > +       happens at the PGD level.
> > +
> >  config HAVE_MOVE_PMD
> >       bool
> >       help
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index d5d3fbe73953..8848125e3024 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -415,6 +415,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> >  #define pfn_pud(pfn,prot)    __pud(__phys_to_pud_val((phys_addr_t)(pfn=
) << PAGE_SHIFT) | pgprot_val(prot))
> >
> >  #define set_pmd_at(mm, addr, pmdp, pmd)      set_pte_at(mm, addr, (pte=
_t *)pmdp, pmd_pte(pmd))
> > +#define set_pud_at(mm, addr, pudp, pud)      set_pte_at(mm, addr, (pte=
_t *)pudp, pud_pte(pud))
> >
> >  #define __p4d_to_phys(p4d)   __pte_to_phys(p4d_pte(p4d))
> >  #define __phys_to_p4d_val(phys)      __phys_to_pte_val(phys)
>
> This doesn't belong to the patch.
Good catch. I'll move this into a separate patch.
>
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 138abbae4f75..a5a1440bd366 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -249,14 +249,167 @@ static bool move_normal_pmd(struct vm_area_struc=
t *vma, unsigned long old_addr,
> >
> >       return true;
> >  }
> > +#else
> > +static inline bool move_normal_pmd(struct vm_area_struct *vma, unsigne=
d long old_addr,
> > +               unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
> > +{
> > +     return false;
> > +}
> >  #endif
> >
> > +#ifdef CONFIG_HAVE_MOVE_PUD
> > +static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> > +{
> > +     pgd_t *pgd;
> > +     p4d_t *p4d;
> > +     pud_t *pud;
> > +
> > +     pgd =3D pgd_offset(mm, addr);
> > +     if (pgd_none_or_clear_bad(pgd))
> > +             return NULL;
> > +
> > +     p4d =3D p4d_offset(pgd, addr);
> > +     if (p4d_none_or_clear_bad(p4d))
> > +             return NULL;
> > +
> > +     pud =3D pud_offset(p4d, addr);
> > +     if (pud_none_or_clear_bad(pud))
> > +             return NULL;
> > +
> > +     return pud;
> > +}
> > +
> > +static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_struc=
t *vma,
> > +                         unsigned long addr)
> > +{
> > +     pgd_t *pgd;
> > +     p4d_t *p4d;
> > +     pud_t *pud;
> > +
> > +     pgd =3D pgd_offset(mm, addr);
> > +     p4d =3D p4d_alloc(mm, pgd, addr);
> > +     if (!p4d)
> > +             return NULL;
> > +     pud =3D pud_alloc(mm, p4d, addr);
> > +     if (!pud)
> > +             return NULL;
> > +
> > +     return pud;
> > +}
> > +
> > +static bool move_normal_pud(struct vm_area_struct *vma, unsigned long =
old_addr,
> > +               unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
> > +{
> > +     spinlock_t *old_ptl, *new_ptl;
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     pud_t pud;
> > +
> > +     /*
> > +      * The destination pud shouldn't be established, free_pgtables()
> > +      * should have released it.
> > +      */
> > +     if (WARN_ON_ONCE(!pud_none(*new_pud)))
> > +             return false;
> > +
> > +     /*
> > +      * We don't have to worry about the ordering of src and dst
> > +      * ptlocks because exclusive mmap_lock prevents deadlock.
> > +      */
> > +     old_ptl =3D pud_lock(vma->vm_mm, old_pud);
> > +     new_ptl =3D pud_lockptr(mm, new_pud);
> > +     if (new_ptl !=3D old_ptl)
> > +             spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > +
> > +     /* Clear the pud */
> > +     pud =3D *old_pud;
> > +     pud_clear(old_pud);
> > +
> > +     VM_BUG_ON(!pud_none(*new_pud));
> > +
> > +     /* Set the new pud */
> > +     set_pud_at(mm, new_addr, new_pud, pud);
> > +     flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
> > +     if (new_ptl !=3D old_ptl)
> > +             spin_unlock(new_ptl);
> > +     spin_unlock(old_ptl);
> > +
> > +     return true;
> > +}
> > +#else
> > +static inline bool move_normal_pud(struct vm_area_struct *vma, unsigne=
d long old_addr,
> > +               unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> > +enum pgt_entry {
> > +     NORMAL_PMD,
> > +     HPAGE_PMD,
> > +     NORMAL_PUD,
> > +};
> > +
> > +/*
> > + * Returns an extent of the corresponding size for the pgt_entry speci=
fied if valid.
> > + * Else returns a smaller extent bounded by the end of the source and =
destination
> > + * pgt_entry. Returns 0 if an invalid pgt_entry is specified.
> > + */
> > +static unsigned long get_extent(enum pgt_entry entry, unsigned long ol=
d_addr,
> > +                     unsigned long old_end, unsigned long new_addr)
> > +{
> > +     unsigned long next, extent, mask, size;
> > +
> > +     if (entry =3D=3D NORMAL_PMD || entry =3D=3D HPAGE_PMD) {
> > +             mask =3D PMD_MASK;
> > +             size =3D PMD_SIZE;
> > +     } else if (entry =3D=3D NORMAL_PUD) {
> > +             mask =3D PUD_MASK;
> > +             size =3D PUD_SIZE;
> > +     } else
> > +             return 0;
> > +
> > +     next =3D (old_addr + size) & mask;
> > +     /* even if next overflowed, extent below will be ok */
> > +     extent =3D (next > old_end) ? old_end - old_addr : next - old_add=
r;
> > +     next =3D (new_addr + size) & mask;
> > +     if (extent > next - new_addr)
> > +             extent =3D next - new_addr;
> > +     return extent;
> > +}
> > +
> > +/*
> > + * Attempts to speedup the move by moving entry at the level correspon=
ding to
> > + * pgt_entry. Returns true if the move was successful, else false.
> > + */
> > +static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct=
 *vma,
> > +                     unsigned long old_addr, unsigned long new_addr, v=
oid *old_entry,
> > +                     void *new_entry, bool need_rmap_locks)
> > +{
> > +     bool moved =3D false;
> > +
> > +     /* See comment in move_ptes() */
> > +     if (need_rmap_locks)
> > +             take_rmap_locks(vma);
> > +     if (entry =3D=3D NORMAL_PMD)
> > +             moved =3D  move_normal_pmd(vma, old_addr, new_addr, old_e=
ntry, new_entry);
> > +     else if (entry =3D=3D NORMAL_PUD)
> > +             moved =3D  move_normal_pud(vma, old_addr, new_addr, old_e=
ntry, new_entry);
> > +     else if (entry =3D=3D HPAGE_PMD)
> > +             moved =3D  move_huge_pmd(vma, old_addr, new_addr, old_ent=
ry, new_entry);
> > +     else
> > +             WARN_ON_ONCE(1);
>
> BUILD_BUG() should work.
This doesn't get caught at compile time since entry isn't a constant.
>
> And why not use switch() instead of ifs.
I'll move to switch() in the next version.
Thanks, Kalesh
>
> > +     if (need_rmap_locks)
> > +             drop_rmap_locks(vma);
> > +
> > +     return moved;
> > +}
> > +
> >  unsigned long move_page_tables(struct vm_area_struct *vma,
> >               unsigned long old_addr, struct vm_area_struct *new_vma,
> >               unsigned long new_addr, unsigned long len,
> >               bool need_rmap_locks)
> >  {
> > -     unsigned long extent, next, old_end;
> > +     unsigned long extent, old_end;
> >       struct mmu_notifier_range range;
> >       pmd_t *old_pmd, *new_pmd;
> >
> > @@ -269,14 +422,27 @@ unsigned long move_page_tables(struct vm_area_str=
uct *vma,
> >
> >       for (; old_addr < old_end; old_addr +=3D extent, new_addr +=3D ex=
tent) {
> >               cond_resched();
> > -             next =3D (old_addr + PMD_SIZE) & PMD_MASK;
> > -             /* even if next overflowed, extent below will be ok */
> > -             extent =3D next - old_addr;
> > -             if (extent > old_end - old_addr)
> > -                     extent =3D old_end - old_addr;
> > -             next =3D (new_addr + PMD_SIZE) & PMD_MASK;
> > -             if (extent > next - new_addr)
> > -                     extent =3D next - new_addr;
> > +#ifdef CONFIG_HAVE_MOVE_PUD
> > +             /*
> > +              * If extent is PUD-sized try to speed up the move by mov=
ing at the
> > +              * PUD level if possible.
> > +              */
> > +             extent =3D get_extent(NORMAL_PUD, old_addr, old_end, new_=
addr);
> > +             if (extent =3D=3D PUD_SIZE) {
> > +                     pud_t *old_pud, *new_pud;
> > +
> > +                     old_pud =3D get_old_pud(vma->vm_mm, old_addr);
> > +                     if (!old_pud)
> > +                             continue;
> > +                     new_pud =3D alloc_new_pud(vma->vm_mm, vma, new_ad=
dr);
> > +                     if (!new_pud)
> > +                             break;
> > +                     if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new=
_addr,
> > +                                        old_pud, new_pud, need_rmap_lo=
cks))
> > +                             continue;
> > +             }
> > +#endif
> > +             extent =3D get_extent(NORMAL_PMD, old_addr, old_end, new_=
addr);
> >               old_pmd =3D get_old_pmd(vma->vm_mm, old_addr);
> >               if (!old_pmd)
> >                       continue;
> > @@ -284,18 +450,10 @@ unsigned long move_page_tables(struct vm_area_str=
uct *vma,
> >               if (!new_pmd)
> >                       break;
> >               if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) || =
pmd_devmap(*old_pmd)) {
> > -                     if (extent =3D=3D HPAGE_PMD_SIZE) {
> > -                             bool moved;
> > -                             /* See comment in move_ptes() */
> > -                             if (need_rmap_locks)
> > -                                     take_rmap_locks(vma);
> > -                             moved =3D move_huge_pmd(vma, old_addr, ne=
w_addr,
> > -                                                   old_pmd, new_pmd);
> > -                             if (need_rmap_locks)
> > -                                     drop_rmap_locks(vma);
> > -                             if (moved)
> > -                                     continue;
> > -                     }
> > +                     if (extent =3D=3D HPAGE_PMD_SIZE &&
> > +                         move_pgt_entry(HPAGE_PMD, vma, old_addr, new_=
addr, old_pmd,
> > +                                        new_pmd, need_rmap_locks))
> > +                             continue;
> >                       split_huge_pmd(vma, old_pmd, old_addr);
> >                       if (pmd_trans_unstable(old_pmd))
> >                               continue;
> > @@ -305,15 +463,8 @@ unsigned long move_page_tables(struct vm_area_stru=
ct *vma,
> >                        * If the extent is PMD-sized, try to speed the m=
ove by
> >                        * moving at the PMD level if possible.
> >                        */
> > -                     bool moved;
> > -
> > -                     if (need_rmap_locks)
> > -                             take_rmap_locks(vma);
> > -                     moved =3D move_normal_pmd(vma, old_addr, new_addr=
,
> > -                                             old_pmd, new_pmd);
> > -                     if (need_rmap_locks)
> > -                             drop_rmap_locks(vma);
> > -                     if (moved)
> > +                     if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new=
_addr, old_pmd,
> > +                                        new_pmd, need_rmap_locks))
> >                               continue;
> >  #endif
> >               }
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >
>
> --
>  Kirill A. Shutemov
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
