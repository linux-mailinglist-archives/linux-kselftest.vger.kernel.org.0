Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63727A6FAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjISXvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 19:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjISXvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 19:51:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE87C5
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 16:51:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so7634a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695167496; x=1695772296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6VMf/OUkQsSYVwJPsdAyGwcMTpYmYXfK2NiFd3HWh4=;
        b=11ZgRm5wLOTCTF6sjJgvDymfU4vDFWPUoLJkaypTnLETn5D7MFwI8gzhIx98pQ/yg7
         Nh8gVBhvjnQkR6xojAL9edKNu8Q9IsVtTf+JhkVoVMWOa4XXgYXt/kyFoVSr5yB9ccGi
         X+xOLZ/n0PJyqNDYG8bHUGpFEMGQCCrIUSZJXYBLaMYKcFsgSxM8iJIDn7JgLpVvCXdU
         jvFSmsMPTwChhQfHBvLxkR+t4mo9bZpvkCYVHzFlr6ZoNrb5iPLFHnVl34qIW54zW9sa
         wlGHgEftlJ2wmBL66R6O438SfV0X3ilQwpUQ1su/b7ZyTic1+pm8nzmN2g5Ods4Y6JDO
         JYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695167496; x=1695772296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6VMf/OUkQsSYVwJPsdAyGwcMTpYmYXfK2NiFd3HWh4=;
        b=clYEd5nW00m/UeAi6l4Wi6WD4Z29/rI44Ow817BJCDb2YCdzjmDrDM85o2d/UqcFNP
         QhnnBqCPhMfKL3XJ+vT4NSsA1UFefnNT2B2UP3DTL0vLLYNM57r9v/1PLtlyIkrbkv7I
         dycSRNPkKWkCxVJlJZgbYBdXlTe1g4eQkEmOeY1OZYOIRp2dm8aUJTmMrF6uS2OMctkb
         ZtTgY32L7BAIMezayujQOPzp26T4oNh/gEzUcww9MyVAtHctiLSR8vHXfMhNN608JTfL
         iHBj3d1jT+aHgJTPNi6wba9JReukappfKWKeDCRElkskkBwElwZsIX4B0cCbteNJd4ic
         5fjA==
X-Gm-Message-State: AOJu0Yx6fVxdstAqOrfPnuFyrRz0pq5nqU3hnYvWf3iT2MWeD/FWV6dG
        CoRDL3uqIrFh7b9AnAmln+dyoVdHKK/Ty7DNBoh1ng==
X-Google-Smtp-Source: AGHT+IEkCvERxvTYDfbrhAwIRpXY6kz99DLqVyOLYFXLV+eHS9DS62mqizZVcoB7cM3wk2N8dUWhx+CUmG5AJDEB40U=
X-Received: by 2002:a50:d71b:0:b0:52f:3376:8d7 with SMTP id
 t27-20020a50d71b000000b0052f337608d7mr18998edi.5.1695167495880; Tue, 19 Sep
 2023 16:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <CAG48ez0gN_nC8NrMOeq44QmUDT27EpT0bFuNu1ReVKDBt3zy7Q@mail.gmail.com> <CAJuCfpGdbc70aZPu=cNgemK1EFUyvLfZU8ELSjseZtfpSF+EEg@mail.gmail.com>
In-Reply-To: <CAJuCfpGdbc70aZPu=cNgemK1EFUyvLfZU8ELSjseZtfpSF+EEg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Sep 2023 01:50:57 +0200
Message-ID: <CAG48ez212+UjQMB94vKvyV4YAEgg=jBhdzg_1b4BRe6=SO09fA@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 1:08=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Thu, Sep 14, 2023 at 7:28=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Thu, Sep 14, 2023 at 5:26=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > From: Andrea Arcangeli <aarcange@redhat.com>
> > >
> > > This implements the uABI of UFFDIO_REMAP.
> > >
> > > Notably one mode bitflag is also forwarded (and in turn known) by the
> > > lowlevel remap_pages method.
[...]
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
[...]
> > > +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> > > +                        struct mm_struct *src_mm,
> > > +                        pmd_t *dst_pmd, pmd_t *src_pmd,
> > > +                        pmd_t dst_pmdval,
> > > +                        struct vm_area_struct *dst_vma,
> > > +                        struct vm_area_struct *src_vma,
> > > +                        unsigned long dst_addr,
> > > +                        unsigned long src_addr)
> > > +{
> > > +       pmd_t _dst_pmd, src_pmdval;
> > > +       struct page *src_page;
> > > +       struct anon_vma *src_anon_vma, *dst_anon_vma;
> > > +       spinlock_t *src_ptl, *dst_ptl;
> > > +       pgtable_t pgtable;
> > > +       struct mmu_notifier_range range;
> > > +
> > > +       src_pmdval =3D *src_pmd;
> > > +       src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> > > +
> > > +       BUG_ON(!pmd_trans_huge(src_pmdval));
> > > +       BUG_ON(!pmd_none(dst_pmdval));
> >
> > Why can we assert that pmd_none(dst_pmdval) is true here? Can we not
> > have concurrent faults (or userfaultfd operations) populating that
> > PMD?
>
> IIUC dst_pmdval is a copy of the value from dst_pmd, so that local
> copy should not change even if some concurrent operation changes
> dst_pmd. We can assert that it's pmd_none because we checked for that
> before calling remap_pages_huge_pmd. Later on we check if dst_pmd
> changed from under us (see pmd_same(*dst_pmd, dst_pmdval) check) and
> retry if that happened.

Oh, right, I don't know what I was thinking when I typed that.

But now I wonder about the check directly above that: What does this
code do for swap PMDs? It looks like that might splat on the
BUG_ON(!pmd_trans_huge(src_pmdval)). All we've checked on the path to
here is that the virtual memory area is aligned, that the destination
PMD is empty, and that pmd_trans_huge_lock() succeeded; but
pmd_trans_huge_lock() explicitly permits swap PMDs (which is the
swapped-out version of transhuge PMDs):

static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
                struct vm_area_struct *vma)
{
        if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
                return __pmd_trans_huge_lock(pmd, vma);
        else
                return NULL;
}

> >
> > > +       BUG_ON(!spin_is_locked(src_ptl));
> > > +       mmap_assert_locked(src_mm);
> > > +       mmap_assert_locked(dst_mm);
> > > +       BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> > > +       BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> > > +
> > > +       src_page =3D pmd_page(src_pmdval);
> > > +       BUG_ON(!PageHead(src_page));
> > > +       BUG_ON(!PageAnon(src_page));
> > > +       if (unlikely(page_mapcount(src_page) !=3D 1)) {
> > > +               spin_unlock(src_ptl);
> > > +               return -EBUSY;
> > > +       }
> > > +
> > > +       get_page(src_page);
> > > +       spin_unlock(src_ptl);
> > > +
> > > +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, =
src_addr,
> > > +                               src_addr + HPAGE_PMD_SIZE);
> > > +       mmu_notifier_invalidate_range_start(&range);
> > > +
> > > +       /* block all concurrent rmap walks */
> > > +       lock_page(src_page);
> > > +
> > > +       /*
> > > +        * split_huge_page walks the anon_vma chain without the page
> > > +        * lock. Serialize against it with the anon_vma lock, the pag=
e
> > > +        * lock is not enough.
> > > +        */
> > > +       src_anon_vma =3D folio_get_anon_vma(page_folio(src_page));
> > > +       if (!src_anon_vma) {
> > > +               unlock_page(src_page);
> > > +               put_page(src_page);
> > > +               mmu_notifier_invalidate_range_end(&range);
> > > +               return -EAGAIN;
> > > +       }
> > > +       anon_vma_lock_write(src_anon_vma);
> > > +
> > > +       dst_ptl =3D pmd_lockptr(dst_mm, dst_pmd);
> > > +       double_pt_lock(src_ptl, dst_ptl);
> > > +       if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
> > > +                    !pmd_same(*dst_pmd, dst_pmdval) ||
> > > +                    page_mapcount(src_page) !=3D 1)) {
> > > +               double_pt_unlock(src_ptl, dst_ptl);
> > > +               anon_vma_unlock_write(src_anon_vma);
> > > +               put_anon_vma(src_anon_vma);
> > > +               unlock_page(src_page);
> > > +               put_page(src_page);
> > > +               mmu_notifier_invalidate_range_end(&range);
> > > +               return -EAGAIN;
> > > +       }
> > > +
> > > +       BUG_ON(!PageHead(src_page));
> > > +       BUG_ON(!PageAnon(src_page));
> > > +       /* the PT lock is enough to keep the page pinned now */
> > > +       put_page(src_page);
> > > +
> > > +       dst_anon_vma =3D (void *) dst_vma->anon_vma + PAGE_MAPPING_AN=
ON;
> > > +       WRITE_ONCE(src_page->mapping, (struct address_space *) dst_an=
on_vma);
> > > +       WRITE_ONCE(src_page->index, linear_page_index(dst_vma, dst_ad=
dr));
> > > +
> > > +       if (!pmd_same(pmdp_huge_clear_flush(src_vma, src_addr, src_pm=
d),
> > > +                     src_pmdval))
> > > +               BUG_ON(1);
> >
> > I'm not sure we can assert that the PMDs are exactly equal; the CPU
> > might have changed the A/D bits under us?
>
> Yes. I wonder if I can simply remove the BUG_ON here like this:
>
> src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
>
> Technically we don't use src_pmdval after this but for the possible
> future use that would keep things correct. If A/D bits changed from
> under us we will still copy correct values into dst_pmd.

And when we set up the dst_pmd, we always mark it as dirty and
accessed... so I guess that's fine.

> > > +       _dst_pmd =3D mk_huge_pmd(src_page, dst_vma->vm_page_prot);
> > > +       _dst_pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma=
);
> > > +       set_pmd_at(dst_mm, dst_addr, dst_pmd, _dst_pmd);
> > > +
> > > +       pgtable =3D pgtable_trans_huge_withdraw(src_mm, src_pmd);
> > > +       pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
> >
> > Are we allowed to move page tables between mm_structs on all
> > architectures? The first example I found that looks a bit dodgy,
> > looking through various architectures' pte_alloc_one(), is s390's
> > page_table_alloc() which looks like page tables are tied to per-MM
> > lists sometimes.
> > If that's not allowed, we might have to allocate a new deposit table
> > and free the old one or something like that.
>
> Hmm. Yeah, looks like in the case of !CONFIG_PGSTE the table can be
> linked to mm->context.pgtable_list, so can't be moved to another mm. I
> guess I'll have to keep a pgtable allocated, ready to be deposited and
> free the old one. Maybe it's worth having an arch-specific function
> indicating whether moving a pgtable between MMs is supported? Or do it
> separately as an optimization. WDYT?

Hm, dunno. I guess you could have architectures opt in with some
config flag similar to how flags like
ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH are wired up - define it in
init/Kconfig, select it in the architectures that support it, and then
gate the fast version on that with #ifdef?

> > > +       if (dst_mm !=3D src_mm) {
> > > +               add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> > > +               add_mm_counter(src_mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > > +       }
> > > +       double_pt_unlock(src_ptl, dst_ptl);
> > > +
> > > +       anon_vma_unlock_write(src_anon_vma);
> > > +       put_anon_vma(src_anon_vma);
> > > +
> > > +       /* unblock rmap walks */
> > > +       unlock_page(src_page);
> > > +
> > > +       mmu_notifier_invalidate_range_end(&range);
> > > +       return 0;
> > > +}
> > > +#endif /* CONFIG_USERFAULTFD */
> > > +
> > >  /*
> > >   * Returns page table lock pointer if a given pmd maps a thp, NULL o=
therwise.
> > >   *
> > [...]
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 96d9eae5c7cc..0cca60dfa8f8 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > [...]
> > > +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_=
mm,
> > > +                   unsigned long dst_start, unsigned long src_start,
> > > +                   unsigned long len, __u64 mode)
> > > +{
> > [...]
> > > +
> > > +       if (pgprot_val(src_vma->vm_page_prot) !=3D
> > > +           pgprot_val(dst_vma->vm_page_prot))
> > > +               goto out;
> >
> > Does this check intentionally allow moving pages from a
> > PROT_READ|PROT_WRITE anonymous private VMA into a PROT_READ anonymous
> > private VMA (on architectures like x86 and arm64 where CoW memory has
> > the same protection flags as read-only memory), but forbid moving them
> > from a PROT_READ|PROT_EXEC VMA into a PROT_READ VMA? I think this
> > check needs at least a comment to explain what's going on here.
>
> The check is simply to ensure the VMAs have the same access
> permissions to prevent page copies that should have different
> permissions. The fact that x86 and arm64 have the same protection bits
> for R/O and COW memory is a "side-effect" IMHO. I'm not sure what
> comment would be good here but I'm open to suggestions.

I'm not sure if you can do a meaningful security check on the
->vm_page_prot. I also don't think it matters for anonymous VMAs.
I guess if you want to keep this check but make this behavior more
consistent, you could put another check in front of this that rejects
VMAs where vm_flags like VM_READ, VM_WRITE, VM_SHARED or VM_EXEC are
different?

[...]
> > > +       /*
> > > +        * Ensure the dst_vma has a anon_vma or this page
> > > +        * would get a NULL anon_vma when moved in the
> > > +        * dst_vma.
> > > +        */
> > > +       err =3D -ENOMEM;
> > > +       if (unlikely(anon_vma_prepare(dst_vma)))
> > > +               goto out;
> > > +
> > > +       for (src_addr =3D src_start, dst_addr =3D dst_start;
> > > +            src_addr < src_start + len;) {
> > > +               spinlock_t *ptl;
> > > +               pmd_t dst_pmdval;
> > > +
> > > +               BUG_ON(dst_addr >=3D dst_start + len);
> > > +               src_pmd =3D mm_find_pmd(src_mm, src_addr);
> >
> > (this would blow up pretty badly if we could have transparent huge PUD
> > in the region but I think that's limited to file VMAs so it's fine as
> > it currently is)
>
> Should I add a comment here as a warning if in the future we decide to
> implement support for file-backed pages?

Hm, yeah, I guess that might be a good idea.
