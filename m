Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5793D6970CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 23:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjBNWie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 17:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjBNWid (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 17:38:33 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB04305C9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 14:38:29 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l3so20145751ljo.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 14:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gy2rV4J+ja7hqYAmwaZGviULfF35QaGdSmHtWGPFNyM=;
        b=FUUBxZa5ml3Un81F0om/KncOeDIm+8BxGRlfS6QAvKj1k2IXrd7UMmS3vjjWCK6K2g
         0F9jfL+1BovTtVTVLJiXDerlGYmIEekfSxq4Mb0DXLj+sWJetuPownobo1OulDeqRlQb
         SG+FJlIrhE/gJCT6YK3DXsYUKXgyxQOkEbLOHzifIwqjZ9YbWqBAufhdSZAsk9D5s8eq
         CieZWxi5Y4DYMFhbpvPUWzYdNEWM/LOS5vZlsF1c4j+KkQT07nXC56XJKR1DYlaE/pkF
         J+ijpoA2rNdewMPtPP3UxBTylppiqUzkquugZInVkyvu2Begd9NYiOySDfupWnssE6yl
         40Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy2rV4J+ja7hqYAmwaZGviULfF35QaGdSmHtWGPFNyM=;
        b=p4Rs7zGYxyyMo/KzHigg8aH/Rblb61nNtXJ58dOeDvJoXn8tOa0i1pR2xYM28FOFmL
         l7l1z/qmsNTosP4MG1sLr0LUM/tKy0muPUOIs7nPVmuFstEZvxGYvD8GDXkNiIo1xAH+
         H2Qx4HB8sx2YfkczPaWfeuFPn/3ToBzcrtv/MkY9zcN0R2jvriSb4et9cdF/1vm0KvlH
         /A82+jO7u5uIm6MhnwUbBXXqndYWhExms8APGLB4yilB8Ib6du5MxlXEWhdH+hH+j6gD
         Cf//VrHUjex4zki5ffJd/l19kPVJ1XDqdsu6PogGnKksLOZm/fSfTT+uod6xWSCF9Exb
         ZI1w==
X-Gm-Message-State: AO0yUKViSwdgc4/zTWQQjYQi85Cn8okiI06jlwu3a4RTqTZ3Hb9NFW3/
        cEig2oWMx7IleETX06i6CsQaC151+7t08pC2fyhzWQ==
X-Google-Smtp-Source: AK7set8JtivRNFdpenvkueamnWVzK0z8w/R8v2JtD3ACRknoCI0wZxwbOvjKZg2lJjR2WWs3l+WCLSrQ9cL779gNd2w=
X-Received: by 2002:a2e:9117:0:b0:293:4be7:14d5 with SMTP id
 m23-20020a2e9117000000b002934be714d5mr691370ljg.2.1676414307784; Tue, 14 Feb
 2023 14:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20230214215046.1187635-1-axelrasmussen@google.com> <Y+wIdeu3Lw/3kmXg@casper.infradead.org>
In-Reply-To: <Y+wIdeu3Lw/3kmXg@casper.infradead.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 14 Feb 2023 14:37:51 -0800
Message-ID: <CAJHvVciR=inDaKnmCfCQsxgBsJB6eQVDXQw67o0Foc9ofgbuow@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install
 WP PTEs
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 14, 2023 at 2:17 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Feb 14, 2023 at 01:50:46PM -0800, Axel Rasmussen wrote:
> > UFFDIO_COPY already has UFFDIO_COPY_MODE_WP, so when installing a new
> > PTE to resolve a missing fault, one can install a write-protected one.
> > This is useful when using UFFDIO_REGISTER_MODE_{MISSING,WP} in
> > combination.
> >
> > So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
> > but for *minor* faults.
> >
> > Rename "wp_copy" arguments to "wp_mode", since the mode now applies
> > more widely than just to the copy operation.
>
> Speaking as someone not familiar with this code, i do not care for
> this rename.  before, it says "bool wp_copy".  i'm not sure what "wp"
> is, but "copy" i understand.  so if it's true, i need to copy and false,
> i don't.  now it's "bool wp_mode".  so if it's true, it's a mode and if
> it's false it's not a mode?  what?

Agree it's confusing. The "copy" refers to the "UFFDIO_COPY" ioctl,
which specifically allocates a new page, and *copies* its contents
from userspace. Continue, on the other hand, doesn't do any page
allocation or copying, it just installs a PTE for a page already in
the page cache. This is why I thought leaving the "copy" around would
be confusing.

Honestly there are other existing cases where this confusion remains;
e.g. the function mcopy_atomic doesn't necessarily do any page
allocation or copying, because the same code path also handles the
continue case.

Agree that at the very least wp_enabled or something would make more
sense, given it's a bool.

>
> stepping back for a second, i think the real problem is that the argument
> list has got out of control.  8 arguments to hugetlb_mcopy_atomic_pte(),
> the same # to shmem_mfill_atomic_pte(), a subtly different 8 to
> mfill_atomic_pte().  someone needs to create a struct with a sensible
> name to contain all of this.  i bet it'll shrink the code too; marshalling
> all these arguments is unlikely to be cheap.

Agreed, it would likely be a nice cleanup. Peter, any objections? I
wouldn't mind writing a commit to do this sort of refactor, and rebase
my change on top of that.

>
> but more importantly, it lets you change the arguments without touching
> any of the code which is just passing them through.  look at struct
> vm_fault for inspiration (you probably don't want to reuse it, but maybe
> you do?)
>
> > Update the selftest to do some very basic exercising of the new flag.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c                         |  6 ++-
> >  include/linux/userfaultfd_k.h            |  3 +-
> >  include/uapi/linux/userfaultfd.h         |  7 ++++
> >  mm/hugetlb.c                             |  6 +--
> >  mm/shmem.c                               |  4 +-
> >  mm/userfaultfd.c                         | 49 ++++++++++++++----------
> >  tools/testing/selftests/vm/userfaultfd.c |  4 ++
> >  7 files changed, 51 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index cc694846617a..545dc033eec8 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1910,13 +1910,15 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
> >           uffdio_continue.range.start) {
> >               goto out;
> >       }
> > -     if (uffdio_continue.mode & ~UFFDIO_CONTINUE_MODE_DONTWAKE)
> > +     if (uffdio_continue.mode & ~(UFFDIO_CONTINUE_MODE_DONTWAKE |
> > +                                  UFFDIO_CONTINUE_MODE_WP))
> >               goto out;
> >
> >       if (mmget_not_zero(ctx->mm)) {
> >               ret = mcopy_continue(ctx->mm, uffdio_continue.range.start,
> >                                    uffdio_continue.range.len,
> > -                                  &ctx->mmap_changing);
> > +                                  &ctx->mmap_changing,
> > +                                  uffdio_continue.mode);
> >               mmput(ctx->mm);
> >       } else {
> >               return -ESRCH;
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 9df0b9a762cc..a53aa56e78ad 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -69,7 +69,8 @@ extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
> >                             unsigned long len,
> >                             atomic_t *mmap_changing);
> >  extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
> > -                           unsigned long len, atomic_t *mmap_changing);
> > +                           unsigned long len, atomic_t *mmap_changing,
> > +                           __u64 mode);
> >  extern int mwriteprotect_range(struct mm_struct *dst_mm,
> >                              unsigned long start, unsigned long len,
> >                              bool enable_wp, atomic_t *mmap_changing);
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > index 005e5e306266..14059a0861bf 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -297,6 +297,13 @@ struct uffdio_writeprotect {
> >  struct uffdio_continue {
> >       struct uffdio_range range;
> >  #define UFFDIO_CONTINUE_MODE_DONTWAKE                ((__u64)1<<0)
> > +     /*
> > +      * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
> > +      * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
> > +      * write protected ioctl is implemented for the range
> > +      * according to the uffdio_register.ioctls.
> > +      */
> > +#define UFFDIO_CONTINUE_MODE_WP                      ((__u64)1<<1)
> >       __u64 mode;
> >
> >       /*
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index bdbfeb6fb393..a1bd0b0c6c43 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6169,7 +6169,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                           unsigned long src_addr,
> >                           enum mcopy_atomic_mode mode,
> >                           struct page **pagep,
> > -                         bool wp_copy)
> > +                         bool wp_mode)
> >  {
> >       bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
> >       struct hstate *h = hstate_vma(dst_vma);
> > @@ -6306,7 +6306,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >        * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
> >        * with wp flag set, don't set pte write bit.
> >        */
> > -     if (wp_copy || (is_continue && !vm_shared))
> > +     if (wp_mode || (is_continue && !vm_shared))
> >               writable = 0;
> >       else
> >               writable = dst_vma->vm_flags & VM_WRITE;
> > @@ -6321,7 +6321,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       _dst_pte = huge_pte_mkdirty(_dst_pte);
> >       _dst_pte = pte_mkyoung(_dst_pte);
> >
> > -     if (wp_copy)
> > +     if (wp_mode)
> >               _dst_pte = huge_pte_mkuffd_wp(_dst_pte);
> >
> >       set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 0005ab2c29af..725e5d5d85ab 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2402,7 +2402,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> >                          struct vm_area_struct *dst_vma,
> >                          unsigned long dst_addr,
> >                          unsigned long src_addr,
> > -                        bool zeropage, bool wp_copy,
> > +                        bool zeropage, bool wp_mode,
> >                          struct page **pagep)
> >  {
> >       struct inode *inode = file_inode(dst_vma->vm_file);
> > @@ -2493,7 +2493,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> >               goto out_release;
> >
> >       ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > -                                    &folio->page, true, wp_copy);
> > +                                    &folio->page, true, wp_mode);
> >       if (ret)
> >               goto out_delete_from_cache;
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 0499907b6f1a..2ad4dcf72968 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -58,7 +58,7 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> >  int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >                            struct vm_area_struct *dst_vma,
> >                            unsigned long dst_addr, struct page *page,
> > -                          bool newly_allocated, bool wp_copy)
> > +                          bool newly_allocated, bool wp_mode)
> >  {
> >       int ret;
> >       pte_t _dst_pte, *dst_pte;
> > @@ -79,7 +79,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >        * Always mark a PTE as write-protected when needed, regardless of
> >        * VM_WRITE, which the user might change.
> >        */
> > -     if (wp_copy) {
> > +     if (wp_mode) {
> >               _dst_pte = pte_mkuffd_wp(_dst_pte);
> >               writable = false;
> >       }
> > @@ -147,7 +147,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                           unsigned long dst_addr,
> >                           unsigned long src_addr,
> >                           struct page **pagep,
> > -                         bool wp_copy)
> > +                         bool wp_mode)
> >  {
> >       void *page_kaddr;
> >       int ret;
> > @@ -208,7 +208,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
> >               goto out_release;
> >
> >       ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > -                                    page, true, wp_copy);
> > +                                    page, true, wp_mode);
> >       if (ret)
> >               goto out_release;
> >  out:
> > @@ -258,7 +258,7 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> >                               pmd_t *dst_pmd,
> >                               struct vm_area_struct *dst_vma,
> >                               unsigned long dst_addr,
> > -                             bool wp_copy)
> > +                             bool wp_mode)
> >  {
> >       struct inode *inode = file_inode(dst_vma->vm_file);
> >       pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> > @@ -284,7 +284,7 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> >       }
> >
> >       ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > -                                    page, false, wp_copy);
> > +                                    page, false, wp_mode);
> >       if (ret)
> >               goto out_release;
> >
> > @@ -330,7 +330,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                             unsigned long src_start,
> >                                             unsigned long len,
> >                                             enum mcopy_atomic_mode mode,
> > -                                           bool wp_copy)
> > +                                           bool wp_mode)
> >  {
> >       int vm_shared = dst_vma->vm_flags & VM_SHARED;
> >       ssize_t err;
> > @@ -427,7 +427,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >
> >               err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
> >                                              dst_addr, src_addr, mode, &page,
> > -                                            wp_copy);
> > +                                            wp_mode);
> >
> >               hugetlb_vma_unlock_read(dst_vma);
> >               mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > @@ -483,7 +483,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                     unsigned long src_start,
> >                                     unsigned long len,
> >                                     enum mcopy_atomic_mode mode,
> > -                                   bool wp_copy);
> > +                                   bool wp_mode);
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> >  static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> > @@ -493,13 +493,13 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >                                               unsigned long src_addr,
> >                                               struct page **page,
> >                                               enum mcopy_atomic_mode mode,
> > -                                             bool wp_copy)
> > +                                             bool wp_mode)
> >  {
> >       ssize_t err;
> >
> >       if (mode == MCOPY_ATOMIC_CONTINUE) {
> >               return mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > -                                         wp_copy);
> > +                                         wp_mode);
> >       }
> >
> >       /*
> > @@ -516,7 +516,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >               if (mode == MCOPY_ATOMIC_NORMAL)
> >                       err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> >                                              dst_addr, src_addr, page,
> > -                                            wp_copy);
> > +                                            wp_mode);
> >               else
> >                       err = mfill_zeropage_pte(dst_mm, dst_pmd,
> >                                                dst_vma, dst_addr);
> > @@ -524,12 +524,21 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> >               err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
> >                                            dst_addr, src_addr,
> >                                            mode != MCOPY_ATOMIC_NORMAL,
> > -                                          wp_copy, page);
> > +                                          wp_mode, page);
> >       }
> >
> >       return err;
> >  }
> >
> > +static inline bool wp_mode_enabled(enum mcopy_atomic_mode mcopy_mode, __u64 mode)
> > +{
> > +     switch (mode) {
> > +     case MCOPY_ATOMIC_NORMAL: return mode & UFFDIO_COPY_MODE_WP;
> > +     case MCOPY_ATOMIC_CONTINUE: return mode & UFFDIO_CONTINUE_MODE_WP;
> > +     default: return false;
> > +     }
> > +}
> > +
> >  static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >                                             unsigned long dst_start,
> >                                             unsigned long src_start,
> > @@ -544,7 +553,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >       unsigned long src_addr, dst_addr;
> >       long copied;
> >       struct page *page;
> > -     bool wp_copy;
> > +     bool wp_mode;
> >
> >       /*
> >        * Sanitize the command parameters:
> > @@ -594,8 +603,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >        * validate 'mode' now that we know the dst_vma: don't allow
> >        * a wrprotect copy if the userfaultfd didn't register as WP.
> >        */
> > -     wp_copy = mode & UFFDIO_COPY_MODE_WP;
> > -     if (wp_copy && !(dst_vma->vm_flags & VM_UFFD_WP))
> > +     wp_mode = wp_mode_enabled(mcopy_mode, mode);
> > +     if (wp_mode && !(dst_vma->vm_flags & VM_UFFD_WP))
> >               goto out_unlock;
> >
> >       /*
> > @@ -604,7 +613,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >       if (is_vm_hugetlb_page(dst_vma))
> >               return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
> >                                              src_start, len, mcopy_mode,
> > -                                            wp_copy);
> > +                                            wp_mode);
> >
> >       if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> >               goto out_unlock;
> > @@ -656,7 +665,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> >               BUG_ON(pmd_trans_huge(*dst_pmd));
> >
> >               err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > -                                    src_addr, &page, mcopy_mode, wp_copy);
> > +                                    src_addr, &page, mcopy_mode, wp_mode);
> >               cond_resched();
> >
> >               if (unlikely(err == -ENOENT)) {
> > @@ -718,10 +727,10 @@ ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
> >  }
> >
> >  ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
> > -                    unsigned long len, atomic_t *mmap_changing)
> > +                    unsigned long len, atomic_t *mmap_changing, __u64 mode)
> >  {
> >       return __mcopy_atomic(dst_mm, start, 0, len, MCOPY_ATOMIC_CONTINUE,
> > -                           mmap_changing, 0);
> > +                           mmap_changing, mode);
> >  }
> >
> >  void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > index 7f22844ed704..41c1f9abc481 100644
> > --- a/tools/testing/selftests/vm/userfaultfd.c
> > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > @@ -585,6 +585,8 @@ static void continue_range(int ufd, __u64 start, __u64 len)
> >       req.range.start = start;
> >       req.range.len = len;
> >       req.mode = 0;
> > +     if (test_uffdio_wp)
> > +             req.mode |= UFFDIO_CONTINUE_MODE_WP;
> >
> >       if (ioctl(ufd, UFFDIO_CONTINUE, &req))
> >               err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
> > @@ -1332,6 +1334,8 @@ static int userfaultfd_minor_test(void)
> >       uffdio_register.range.start = (unsigned long)area_dst_alias;
> >       uffdio_register.range.len = nr_pages * page_size;
> >       uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
> > +     if (test_uffdio_wp)
> > +             uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
> >       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> >               err("register failure");
> >
> > --
> > 2.39.1.581.gbfd45094c4-goog
> >
> >
