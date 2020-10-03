Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559AA281FC3
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Oct 2020 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgJCAWD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgJCAWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 20:22:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DCCC0613E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 17:22:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so1900142pjr.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IxuQNcDjqnY+lEJz6FIG14oOUsoLZ6QcraJScTvL9vg=;
        b=YJO6lKbvt9z/M25DB5ebW7M9vnyLf17zMtoZ4eHZDRQcEMOGOgXjkycvGkhUqz846+
         LFoiX97lesGnYCIShDJmI0n5s4WkfJiSPJ8459xzsN/jtoP7cVhQeE6H5sTADa/uqiX7
         hjeAovvMD9weRgBoxRHsRkC8mdF3n04IZTzlcolUyaKGtHKukno7X+4tG42mxuqEtCgf
         lYyrphWkW3owV7oH2kvG+cJArl1cH7/aY5erC0So3alH0h5iy1EPLoCLoVDteMTCEGzq
         mq1O7LRmoJxAxB3xyU3GHIxUKkrs1ITsaiU3vJsDJ5dBFsLeoVG1NPbTh41cmUflbIPS
         i13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IxuQNcDjqnY+lEJz6FIG14oOUsoLZ6QcraJScTvL9vg=;
        b=Erbi4FXxOAqApXSVhuqAPuzWb7o1UkCfK9dNtT7Nc/nQp8m13LaCDQp7nXBOX3yeiz
         J3SjURGdKiJsnMj3YOKTUlRN+VQpQJFXKWGNovTz7zs0QPW4xG0MPz7mpZ5AkukiK1AS
         WcKWjo+Si/DqVZJkjhHYZ3bZiNbk3oB/E8kidZxMRFBwPTsCirChvbMuByyU2sSl0Fs4
         jVE4OdUISU+Te5F3p4AtH8StsGxlM86keuv9kwhpdT5NNoBzTfuarwPmnYm7L30yg06c
         6PG2Du4+016nU2S6t9/6/gThBZ4OoGS4RiYLc3CDQyEUKJaLpPyhIi/tcj5PvO69Y8t0
         e3WQ==
X-Gm-Message-State: AOAM530O7OcZDcg2x0s/7A+g7CvVVy6bQYwtR5fuy4YzGIeUUISKD9Ok
        YwbJ317020BGQ/sIelhedlPoykHJGfaoIu5dQ6mAlg==
X-Google-Smtp-Source: ABdhPJw9F8PAjxDX83VhzBc1Safp+5/8zzAo7j96NLjNjBKAGIlfQSDFQ9j6p8vyGsrr14MjXFM4JBN5DdPfOR5Oi3g=
X-Received: by 2002:a17:90a:634a:: with SMTP id v10mr5095711pjs.182.1601684519848;
 Fri, 02 Oct 2020 17:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201002162101.665549-1-kaleshsingh@google.com>
 <20201002162101.665549-4-kaleshsingh@google.com> <20201002165122.bm427a4ealmmmtqc@black.fi.intel.com>
 <CAC_TJvdcWV=cyszkOURekZGEZP2txvDyZKDyDgKB37+g+eg3hg@mail.gmail.com>
In-Reply-To: <CAC_TJvdcWV=cyszkOURekZGEZP2txvDyZKDyDgKB37+g+eg3hg@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 2 Oct 2020 20:21:48 -0400
Message-ID: <CAC_TJvfLUYThPi3dFa8-tW74=47++jtCf8npuLDJvocHdOgU2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mm: Speedup mremap on 1GB or larger regions
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        Brian Geffon <bgeffon@google.com>,
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

On Fri, Oct 2, 2020 at 6:08 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Hi Kirill, thank you for the feedback.
>
> On Fri, Oct 2, 2020 at 12:51 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Fri, Oct 02, 2020 at 04:20:48PM +0000, Kalesh Singh wrote:
> > > Android needs to move large memory regions for garbage collection.
> > > The GC requires moving physical pages of multi-gigabyte heap
> > > using mremap. During this move, the application threads have to
> > > be paused for correctness. It is critical to keep this pause as
> > > short as possible to avoid jitters during user interaction.
> > >
> > > Optimize mremap for >=3D 1GB-sized regions by moving at the PUD/PGD
> > > level if the source and destination addresses are PUD-aligned.
> > > For CONFIG_PGTABLE_LEVELS =3D=3D 3, moving at the PUD level in effect=
 moves
> > > PGD entries, since the PUD entry is =E2=80=9Cfolded back=E2=80=9D ont=
o the PGD entry.
> > > Add HAVE_MOVE_PUD so that architectures where moving at the PUD level
> > > isn't supported/tested can turn this off by not selecting the config.
> > >
> > > Fix build test error from v1 of this series reported by
> > > kernel test robot in [1].
> > >
> > > [1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thre=
ad/CKPGL4FH4NG7TGH2CVYX2UX76L25BTA3/
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > ---
> > > Changes in v2:
> > >   - Update commit message with description of Android GC's use case.
> > >   - Move set_pud_at() to a separate patch.
> > >   - Use switch() instead of ifs in move_pgt_entry()
> > >   - Fix build test error reported by kernel test robot on x86_64 in [=
1].
> > >     Guard move_huge_pmd() with IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE=
),
> > >     since this section doesn't get optimized out in the kernel test
> > >     robot's build test when HAVE_MOVE_PUD is enabled.
> > >   - Keep WARN_ON_ONCE(1) instead of BUILD_BUG() for the aforementione=
d
> > >     reason.
> >
> > Okay, but IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) on the caller side wo=
uld
> > do the trick, I believe.
> I tried moving this to the caller side in move_page_tables(),
> -                       if (extent =3D=3D HPAGE_PMD_SIZE &&
> +                       if (extent =3D=3D HPAGE_PMD_SIZE &&
> IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> but it produces the same error as reported by kernel test robot:
> ld.lld: error: undefined symbol: move_huge_pmd
> I'm not sure why these are different but the kernel test robot
> compiler complains.
I should mention also that the patch series compiles without having to
use IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) when using the test config
from kernel test robot=E2=80=99s report and clang --version:
Android (6443078 based on r383902) clang version 11.0.1
(https://android.googlesource.com/toolchain/llvm-project
b397f81060ce6d701042b782172ed13bee898b79)
> >
> > >
> > >  arch/Kconfig |   7 ++
> > >  mm/mremap.c  | 220 ++++++++++++++++++++++++++++++++++++++++++++-----=
--
> > >  2 files changed, 197 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index af14a567b493..5eabaa00bf9b 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -602,6 +602,13 @@ config HAVE_IRQ_TIME_ACCOUNTING
> > >         Archs need to ensure they use a high enough resolution clock =
to
> > >         support irq time accounting and then call enable_sched_clock_=
irqtime().
> > >
> > > +config HAVE_MOVE_PUD
> > > +     bool
> > > +     help
> > > +       Architectures that select this are able to move page tables a=
t the
> > > +       PUD level. If there are only 3 page table levels, the move ef=
fectively
> > > +       happens at the PGD level.
> > > +
> > >  config HAVE_MOVE_PMD
> > >       bool
> > >       help
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index 138abbae4f75..c1d6ab667d70 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -249,14 +249,176 @@ static bool move_normal_pmd(struct vm_area_str=
uct *vma, unsigned long old_addr,
> > >
> > >       return true;
> > >  }
> > > +#else
> > > +static inline bool move_normal_pmd(struct vm_area_struct *vma, unsig=
ned long old_addr,
> > > +               unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pm=
d)
> > > +{
> > > +     return false;
> > > +}
> > >  #endif
> > >
> > > +#ifdef CONFIG_HAVE_MOVE_PUD
> > > +static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> > > +{
> > > +     pgd_t *pgd;
> > > +     p4d_t *p4d;
> > > +     pud_t *pud;
> > > +
> > > +     pgd =3D pgd_offset(mm, addr);
> > > +     if (pgd_none_or_clear_bad(pgd))
> > > +             return NULL;
> > > +
> > > +     p4d =3D p4d_offset(pgd, addr);
> > > +     if (p4d_none_or_clear_bad(p4d))
> > > +             return NULL;
> > > +
> > > +     pud =3D pud_offset(p4d, addr);
> > > +     if (pud_none_or_clear_bad(pud))
> > > +             return NULL;
> > > +
> > > +     return pud;
> > > +}
> > > +
> > > +static pud_t *alloc_new_pud(struct mm_struct *mm, struct vm_area_str=
uct *vma,
> > > +                         unsigned long addr)
> > > +{
> > > +     pgd_t *pgd;
> > > +     p4d_t *p4d;
> > > +     pud_t *pud;
> > > +
> > > +     pgd =3D pgd_offset(mm, addr);
> > > +     p4d =3D p4d_alloc(mm, pgd, addr);
> > > +     if (!p4d)
> > > +             return NULL;
> > > +     pud =3D pud_alloc(mm, p4d, addr);
> > > +     if (!pud)
> > > +             return NULL;
> > > +
> > > +     return pud;
> > > +}
> >
> > Looks like a code duplication.
> >
> > Could you move these two helpers out of #ifdef CONFIG_HAVE_MOVE_PUD and
> > make get_old_pmd() and alloc_new_pmd() use them?
> Yes, that will be cleaner. I'll update it in the next version.
> >
> > > +
> > > +static bool move_normal_pud(struct vm_area_struct *vma, unsigned lon=
g old_addr,
> > > +               unsigned long new_addr, pud_t *old_pud, pud_t *new_pu=
d)
> > > +{
> > > +     spinlock_t *old_ptl, *new_ptl;
> > > +     struct mm_struct *mm =3D vma->vm_mm;
> > > +     pud_t pud;
> > > +
> > > +     /*
> > > +      * The destination pud shouldn't be established, free_pgtables(=
)
> > > +      * should have released it.
> > > +      */
> > > +     if (WARN_ON_ONCE(!pud_none(*new_pud)))
> > > +             return false;
> > > +
> > > +     /*
> > > +      * We don't have to worry about the ordering of src and dst
> > > +      * ptlocks because exclusive mmap_lock prevents deadlock.
> > > +      */
> > > +     old_ptl =3D pud_lock(vma->vm_mm, old_pud);
> > > +     new_ptl =3D pud_lockptr(mm, new_pud);
> > > +     if (new_ptl !=3D old_ptl)
> > > +             spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > > +
> > > +     /* Clear the pud */
> > > +     pud =3D *old_pud;
> > > +     pud_clear(old_pud);
> > > +
> > > +     VM_BUG_ON(!pud_none(*new_pud));
> > > +
> > > +     /* Set the new pud */
> > > +     set_pud_at(mm, new_addr, new_pud, pud);
> > > +     flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
> > > +     if (new_ptl !=3D old_ptl)
> > > +             spin_unlock(new_ptl);
> > > +     spin_unlock(old_ptl);
> > > +
> > > +     return true;
> > > +}
> > > +#else
> > > +static inline bool move_normal_pud(struct vm_area_struct *vma, unsig=
ned long old_addr,
> > > +               unsigned long new_addr, pud_t *old_pud, pud_t *new_pu=
d)
> > > +{
> > > +     return false;
> > > +}
> > > +#endif
> > > +
> > > +enum pgt_entry {
> > > +     NORMAL_PMD,
> > > +     HPAGE_PMD,
> > > +     NORMAL_PUD,
> > > +};
> > > +
> > > +/*
> > > + * Returns an extent of the corresponding size for the pgt_entry spe=
cified if valid.
> > > + * Else returns a smaller extent bounded by the end of the source an=
d destination
> > > + * pgt_entry. Returns 0 if an invalid pgt_entry is specified.
> > > + */
> > > +static unsigned long get_extent(enum pgt_entry entry, unsigned long =
old_addr,
> > > +                     unsigned long old_end, unsigned long new_addr)
> > > +{
> > > +     unsigned long next, extent, mask, size;
> > > +
> > > +     if (entry =3D=3D NORMAL_PMD || entry =3D=3D HPAGE_PMD) {
> > > +             mask =3D PMD_MASK;
> > > +             size =3D PMD_SIZE;
> > > +     } else if (entry =3D=3D NORMAL_PUD) {
> > > +             mask =3D PUD_MASK;
> > > +             size =3D PUD_SIZE;
> > > +     } else
> > > +             return 0;
> >
> > Em. Who would ever specify invalid pgt_entry? It's bug.
> > Again, switch()?
> Sounds good. I'll use BUG() and switch() instead.
> >
> > > +
> > > +     next =3D (old_addr + size) & mask;
> > > +     /* even if next overflowed, extent below will be ok */
> > > +     extent =3D (next > old_end) ? old_end - old_addr : next - old_a=
ddr;
> > > +     next =3D (new_addr + size) & mask;
> > > +     if (extent > next - new_addr)
> > > +             extent =3D next - new_addr;
> > > +     return extent;
> > > +}
> > > +
> > > +/*
> > > + * Attempts to speedup the move by moving entry at the level corresp=
onding to
> > > + * pgt_entry. Returns true if the move was successful, else false.
> > > + */
> > > +static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_stru=
ct *vma,
> > > +                     unsigned long old_addr, unsigned long new_addr,=
 void *old_entry,
> > > +                     void *new_entry, bool need_rmap_locks)
> > > +{
> > > +     bool moved =3D false;
> > > +
> > > +     /* See comment in move_ptes() */
> > > +     if (need_rmap_locks)
> > > +             take_rmap_locks(vma);
> > > +
> > > +     switch (entry) {
> > > +     case NORMAL_PMD:
> > > +             moved =3D  move_normal_pmd(vma, old_addr, new_addr, old=
_entry, new_entry);
> >
> > Nit: here and below, double space after '=3D'. Why?
> Sorry, editing mistake on my end. I'll clean this up before resending.
> >
> > > +             break;
> > > +     case NORMAL_PUD:
> > > +             moved =3D  move_normal_pud(vma, old_addr, new_addr, old=
_entry, new_entry);
> > > +             break;
> > > +     case HPAGE_PMD:
> > > +             moved =3D  IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > +                     move_huge_pmd(vma, old_addr, new_addr, old_entr=
y, new_entry);
> > > +             break;
> > > +     default:
> > > +             WARN_ON_ONCE(1);
> > > +             break;
> > > +     }
> > > +
> > > +     if (need_rmap_locks)
> > > +             drop_rmap_locks(vma);
> > > +
> > > +     return moved;
> > > +}
> > > +
> > >  unsigned long move_page_tables(struct vm_area_struct *vma,
> > >               unsigned long old_addr, struct vm_area_struct *new_vma,
> > >               unsigned long new_addr, unsigned long len,
> > >               bool need_rmap_locks)
> > >  {
> > > -     unsigned long extent, next, old_end;
> > > +     unsigned long extent, old_end;
> > >       struct mmu_notifier_range range;
> > >       pmd_t *old_pmd, *new_pmd;
> > >
> > > @@ -269,14 +431,27 @@ unsigned long move_page_tables(struct vm_area_s=
truct *vma,
> > >
> > >       for (; old_addr < old_end; old_addr +=3D extent, new_addr +=3D =
extent) {
> > >               cond_resched();
> > > -             next =3D (old_addr + PMD_SIZE) & PMD_MASK;
> > > -             /* even if next overflowed, extent below will be ok */
> > > -             extent =3D next - old_addr;
> > > -             if (extent > old_end - old_addr)
> > > -                     extent =3D old_end - old_addr;
> > > -             next =3D (new_addr + PMD_SIZE) & PMD_MASK;
> > > -             if (extent > next - new_addr)
> > > -                     extent =3D next - new_addr;
> > > +#ifdef CONFIG_HAVE_MOVE_PUD
> >
> > Any chance  if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD)) would work here?
> Once we move get_old_put() and alloc_new_pud() out of the #ifdefs as
> you suggested
> above, it should work. It would also now be possible to replace the
> #ifdef CONFIG_HAVE_MOVE_PMD in move_page_tables() with
> IS_ENABLED(CONFIG_HAVE_MOVE_PMD).
>
> Thanks,
> Kalesh
> >
> > > +             /*
> > > +              * If extent is PUD-sized try to speed up the move by m=
oving at the
> > > +              * PUD level if possible.
> > > +              */
> > > +             extent =3D get_extent(NORMAL_PUD, old_addr, old_end, ne=
w_addr);
> > > +             if (extent =3D=3D PUD_SIZE) {
> > > +                     pud_t *old_pud, *new_pud;
> > > +
> > > +                     old_pud =3D get_old_pud(vma->vm_mm, old_addr);
> > > +                     if (!old_pud)
> > > +                             continue;
> > > +                     new_pud =3D alloc_new_pud(vma->vm_mm, vma, new_=
addr);
> > > +                     if (!new_pud)
> > > +                             break;
> > > +                     if (move_pgt_entry(NORMAL_PUD, vma, old_addr, n=
ew_addr,
> > > +                                        old_pud, new_pud, need_rmap_=
locks))
> > > +                             continue;
> > > +             }
> > > +#endif
> > > +             extent =3D get_extent(NORMAL_PMD, old_addr, old_end, ne=
w_addr);
> > >               old_pmd =3D get_old_pmd(vma->vm_mm, old_addr);
> > >               if (!old_pmd)
> > >                       continue;
> > > @@ -284,18 +459,10 @@ unsigned long move_page_tables(struct vm_area_s=
truct *vma,
> > >               if (!new_pmd)
> > >                       break;
> > >               if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) |=
| pmd_devmap(*old_pmd)) {
> > > -                     if (extent =3D=3D HPAGE_PMD_SIZE) {
> > > -                             bool moved;
> > > -                             /* See comment in move_ptes() */
> > > -                             if (need_rmap_locks)
> > > -                                     take_rmap_locks(vma);
> > > -                             moved =3D move_huge_pmd(vma, old_addr, =
new_addr,
> > > -                                                   old_pmd, new_pmd)=
;
> > > -                             if (need_rmap_locks)
> > > -                                     drop_rmap_locks(vma);
> > > -                             if (moved)
> > > -                                     continue;
> > > -                     }
> > > +                     if (extent =3D=3D HPAGE_PMD_SIZE &&
> > > +                         move_pgt_entry(HPAGE_PMD, vma, old_addr, ne=
w_addr, old_pmd,
> > > +                                        new_pmd, need_rmap_locks))
> > > +                             continue;
> > >                       split_huge_pmd(vma, old_pmd, old_addr);
> > >                       if (pmd_trans_unstable(old_pmd))
> > >                               continue;
> > > @@ -305,15 +472,8 @@ unsigned long move_page_tables(struct vm_area_st=
ruct *vma,
> > >                        * If the extent is PMD-sized, try to speed the=
 move by
> > >                        * moving at the PMD level if possible.
> > >                        */
> > > -                     bool moved;
> > > -
> > > -                     if (need_rmap_locks)
> > > -                             take_rmap_locks(vma);
> > > -                     moved =3D move_normal_pmd(vma, old_addr, new_ad=
dr,
> > > -                                             old_pmd, new_pmd);
> > > -                     if (need_rmap_locks)
> > > -                             drop_rmap_locks(vma);
> > > -                     if (moved)
> > > +                     if (move_pgt_entry(NORMAL_PMD, vma, old_addr, n=
ew_addr, old_pmd,
> > > +                                        new_pmd, need_rmap_locks))
> > >                               continue;
> > >  #endif
> > >               }
> > > --
> > > 2.28.0.806.g8561365e88-goog
> > >
> >
> > --
> >  Kirill A. Shutemov
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
