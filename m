Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F21389968
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 00:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhESWnI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 18:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhESWnH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 18:43:07 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27052C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:41:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r4so13936813iol.6
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcqtO1CtaLa8z6M5nlZ3QeZ3mf8zCX+YEJE4681MSBo=;
        b=NodoC4zTGnAiwAF3uEmVQvvaexcnStLREQVJB3qJNnDUYvT3rKMA0pgONxHXz8DDO6
         3TBkPh+BHW4bSnR6n7G4yH//13vcVA4ZRMPzY34OzffwDUfUz/Uww1elKu7gSvXaOQ2L
         l5gt3JyUrEDJCEWg2MsAprINHnr2Wb+ywWUVV0rBSX58uwP2mK4UJvh4mo4fTG+D4NqH
         WCZUg8TH0ALBA+iYEhWRnpeDIw0FnI5kdJrUW8h7dYCceDNWvdmxMpTgGe3gHqnjbaCg
         QgW0FNY51fnx/+wET6bQS6Fw9CbwjT2pkjvUVWz3zc363JvMmmYpTkn7rWxRwiljHKmq
         Izqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcqtO1CtaLa8z6M5nlZ3QeZ3mf8zCX+YEJE4681MSBo=;
        b=Bdo/nSjNLdWIqOWs4Q2TdhtFkseYH0HIAXawc6Tf91ClJZLBPuA44yJhVUW9WTB6j9
         khpmkilSp7Re4xuWijgXCsIgONOhA2P+Ax15Wqivl+n3K6lx5+zDLoZw5kCJrepqEPWl
         SQo0Ixjg66srv6eZKYpBkUVCaM09hO1K/WGDgvKZ0DoxHpoCStjULfOTPRN57S40Oirj
         NH7nXBNdFPwfjzTlbbfrElkX/gfqt9IJRyxvFiO7QsNCTHVVoTZ6uSgeyXD8WECa1NNa
         YHQwNmInLF3BuYXrvwc3Bb2Pz1pBsQ5YZ3MdYC9cxeN294ga4S6R1Y4Hth/ImDIvyQIa
         4JYQ==
X-Gm-Message-State: AOAM533KO1BOtYC2tv1hJqSx2KrzbgNiGdGpPYmrXyltB9dt19xPIJqB
        w1AwOPUEwJlGi9CKru7Kkkdo3/VugRYQ0MCKuDq2xw==
X-Google-Smtp-Source: ABdhPJw+Tk9z9xzuqkToRYpurmkITXR1SXjRytwROVwqp8ChOJMRcNFrbNj1pDokDuNoQWORMgwhdiDlzFB7HOqgmUU=
X-Received: by 2002:a05:6638:124b:: with SMTP id o11mr1888715jas.4.1621464106191;
 Wed, 19 May 2021 15:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210519210437.1688484-1-jthoughton@google.com>
In-Reply-To: <20210519210437.1688484-1-jthoughton@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 19 May 2021 15:41:35 -0700
Message-ID: <CANgfPd-=+-0+UzXD+zpqX50SGEi_wCLVJfsv63Rq9GYR+4-dCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Deliver VM fault signals to userspace
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 19, 2021 at 2:04 PM James Houghton <jthoughton@google.com> wrote:
>
> This patch has been written to support page-ins using userfaultfd's
> SIGBUS feature.  When a userfaultfd is created with UFFD_FEATURE_SIGBUS,
> `handle_userfault` will return VM_FAULT_SIGBUS instead of putting the
> calling thread to sleep. Normal (non-guest) threads that access memory
> that has been registered with a UFFD_FEATURE_SIGBUS userfaultfd receive
> a SIGBUS.
>
> When a vCPU gets an EPT page fault in a userfaultfd-registered region,
> KVM calls into `handle_userfault` to resolve the page fault. With
> UFFD_FEATURE_SIGBUS, VM_FAULT_SIGBUS is returned, but a SIGBUS is never
> delivered to the userspace thread. This patch propagates the
> VM_FAULT_SIGBUS error up to KVM, where we then send the signal.
>
> Upon receiving a VM_FAULT_SIGBUS, the KVM_RUN ioctl will exit to
> userspace. This functionality already exists. This allows a hypervisor
> to do page-ins with UFFD_FEATURE_SIGBUS:
>
> 1. Setup a SIGBUS handler to save the address of the SIGBUS (to a
>    thread-local variable).
> 2. Enter the guest.
> 3. Immediately after KVM_RUN returns, check if the address has been set.
> 4. If an address has been set, we exited due to a page fault that we can
>    now handle.
> 5. Userspace can do anything it wants to make the memory available,
>    using MODE_NOWAKE for the UFFDIO memory installation ioctls.
> 6. Re-enter the guest. If the memory still isn't ready, this process
>    will repeat.
>
> This style of demand paging is significantly faster than the standard
> poll/read/wake mechanism userfaultfd uses and completely bypasses the
> userfaultfd waitq. For a single vCPU, page-in throughput increases by
> about 3-4x.

Wow that's an awesome improvement! My impression is that the
improvement is even more significant with more vCPUs because we avoid
wait queue contention. Is that right?

How does this mode deal with situations where returning back to
userspace isn't feasible? For example, if we're buried deep in some
nested instruction emulation path, there may be no way to return back
to userspace without creating unintended side effects. Do we have the
facility to do a regular UFFD request in a case like that?

As an aside, if you can think of a way to split this patch it would be
easier to review. I realize most of the changes are propagating the
fault_error parameter around though, so splitting the patch might not
be easy.

>
> Signed-off-by: James Houghton <jthoughton@google.com>
> Suggested-by: Jue Wang <juew@google.com>
> ---
>  include/linux/hugetlb.h |  2 +-
>  include/linux/mm.h      |  3 ++-
>  mm/gup.c                | 57 +++++++++++++++++++++++++++--------------
>  mm/hugetlb.c            |  5 +++-
>  virt/kvm/kvm_main.c     | 30 +++++++++++++++++++++-
>  5 files changed, 74 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index b92f25ccef58..a777fb254df0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -119,7 +119,7 @@ int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_ar
>  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>                          struct page **, struct vm_area_struct **,
>                          unsigned long *, unsigned long *, long, unsigned int,
> -                        int *);
> +                        int *, int *);
>  void unmap_hugepage_range(struct vm_area_struct *,
>                           unsigned long, unsigned long, struct page *);
>  void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 322ec61d0da7..1dcd1ac81992 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1824,7 +1824,8 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>  long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
>                     unsigned int gup_flags, struct page **pages, int *locked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> -                   struct page **pages, unsigned int gup_flags);
> +                   struct page **pages, unsigned int gup_flags,
> +                   int *fault_error);
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>                     struct page **pages, unsigned int gup_flags);
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 0697134b6a12..ab55a67aef78 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -881,7 +881,8 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
>   * is, *@locked will be set to 0 and -EBUSY returned.
>   */
>  static int faultin_page(struct vm_area_struct *vma,
> -               unsigned long address, unsigned int *flags, int *locked)
> +               unsigned long address, unsigned int *flags, int *locked,
> +               int *fault_error)
>  {
>         unsigned int fault_flags = 0;
>         vm_fault_t ret;
> @@ -906,6 +907,8 @@ static int faultin_page(struct vm_area_struct *vma,
>         }
>
>         ret = handle_mm_fault(vma, address, fault_flags, NULL);
> +       if (fault_error)
> +               *fault_error = ret;
>         if (ret & VM_FAULT_ERROR) {
>                 int err = vm_fault_to_errno(ret, *flags);
>
> @@ -996,6 +999,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   * @vmas:      array of pointers to vmas corresponding to each page.
>   *             Or NULL if the caller does not require them.
>   * @locked:     whether we're still with the mmap_lock held
> + * @fault_error: VM fault error from handle_mm_fault. NULL if the caller
> + *             does not require this error.
>   *
>   * Returns either number of pages pinned (which may be less than the
>   * number requested), or an error. Details about the return value:
> @@ -1040,6 +1045,13 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   * when it's been released.  Otherwise, it must be held for either
>   * reading or writing and will not be released.
>   *
> + * If @fault_error != NULL, __get_user_pages will return the VM fault error
> + * from handle_mm_fault() in this argument in the event of a VM fault error.
> + * On success (ret == nr_pages) fault_error is zero.
> + * On failure (ret != nr_pages) fault_error may still be 0 if the error did
> + * not originate from handle_mm_fault().
> + *
> + *
>   * In most cases, get_user_pages or get_user_pages_fast should be used
>   * instead of __get_user_pages. __get_user_pages should be used only if
>   * you need some special @gup_flags.
> @@ -1047,7 +1059,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  static long __get_user_pages(struct mm_struct *mm,
>                 unsigned long start, unsigned long nr_pages,
>                 unsigned int gup_flags, struct page **pages,
> -               struct vm_area_struct **vmas, int *locked)
> +               struct vm_area_struct **vmas, int *locked,
> +               int *fault_error)
>  {
>         long ret = 0, i = 0;
>         struct vm_area_struct *vma = NULL;
> @@ -1097,7 +1110,7 @@ static long __get_user_pages(struct mm_struct *mm,
>                         if (is_vm_hugetlb_page(vma)) {
>                                 i = follow_hugetlb_page(mm, vma, pages, vmas,
>                                                 &start, &nr_pages, i,
> -                                               gup_flags, locked);
> +                                               gup_flags, locked, fault_error);
>                                 if (locked && *locked == 0) {
>                                         /*
>                                          * We've got a VM_FAULT_RETRY
> @@ -1124,7 +1137,8 @@ static long __get_user_pages(struct mm_struct *mm,
>
>                 page = follow_page_mask(vma, start, foll_flags, &ctx);
>                 if (!page) {
> -                       ret = faultin_page(vma, start, &foll_flags, locked);
> +                       ret = faultin_page(vma, start, &foll_flags, locked,
> +                                          fault_error);
>                         switch (ret) {
>                         case 0:
>                                 goto retry;
> @@ -1280,7 +1294,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>                                                 struct page **pages,
>                                                 struct vm_area_struct **vmas,
>                                                 int *locked,
> -                                               unsigned int flags)
> +                                               unsigned int flags,
> +                                               int *fault_error)
>  {
>         long ret, pages_done;
>         bool lock_dropped;
> @@ -1311,7 +1326,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>         lock_dropped = false;
>         for (;;) {
>                 ret = __get_user_pages(mm, start, nr_pages, flags, pages,
> -                                      vmas, locked);
> +                                      vmas, locked, fault_error);
>                 if (!locked)
>                         /* VM_FAULT_RETRY couldn't trigger, bypass */
>                         return ret;
> @@ -1371,7 +1386,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>
>                 *locked = 1;
>                 ret = __get_user_pages(mm, start, 1, flags | FOLL_TRIED,
> -                                      pages, NULL, locked);
> +                                      pages, NULL, locked, fault_error);
>                 if (!*locked) {
>                         /* Continue to retry until we succeeded */
>                         BUG_ON(ret != 0);
> @@ -1458,7 +1473,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
>          * not result in a stack expansion that recurses back here.
>          */
>         return __get_user_pages(mm, start, nr_pages, gup_flags,
> -                               NULL, NULL, locked);
> +                               NULL, NULL, locked, NULL);
>  }
>
>  /*
> @@ -1524,7 +1539,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
>                 unsigned long nr_pages, struct page **pages,
>                 struct vm_area_struct **vmas, int *locked,
> -               unsigned int foll_flags)
> +               unsigned int foll_flags, int *fault_error)
>  {
>         struct vm_area_struct *vma;
>         unsigned long vm_flags;
> @@ -1590,7 +1605,8 @@ struct page *get_dump_page(unsigned long addr)
>         if (mmap_read_lock_killable(mm))
>                 return NULL;
>         ret = __get_user_pages_locked(mm, addr, 1, &page, NULL, &locked,
> -                                     FOLL_FORCE | FOLL_DUMP | FOLL_GET);
> +                                     FOLL_FORCE | FOLL_DUMP | FOLL_GET,
> +                                     NULL);
>         if (locked)
>                 mmap_read_unlock(mm);
>
> @@ -1704,11 +1720,11 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>
>         if (!(gup_flags & FOLL_LONGTERM))
>                 return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> -                                              NULL, gup_flags);
> +                                              NULL, gup_flags, NULL);
>         flags = memalloc_pin_save();
>         do {
>                 rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> -                                            NULL, gup_flags);
> +                                            NULL, gup_flags, NULL);
>                 if (rc <= 0)
>                         break;
>                 rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
> @@ -1764,7 +1780,8 @@ static long __get_user_pages_remote(struct mm_struct *mm,
>
>         return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
>                                        locked,
> -                                      gup_flags | FOLL_TOUCH | FOLL_REMOTE);
> +                                      gup_flags | FOLL_TOUCH | FOLL_REMOTE,
> +                                      NULL);
>  }
>
>  /**
> @@ -1941,7 +1958,7 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>
>         return __get_user_pages_locked(current->mm, start, nr_pages,
>                                        pages, NULL, locked,
> -                                      gup_flags | FOLL_TOUCH);
> +                                      gup_flags | FOLL_TOUCH, NULL);
>  }
>  EXPORT_SYMBOL(get_user_pages_locked);
>
> @@ -1961,7 +1978,8 @@ EXPORT_SYMBOL(get_user_pages_locked);
>   * (e.g. FOLL_FORCE) are not required.
>   */
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> -                            struct page **pages, unsigned int gup_flags)
> +                            struct page **pages, unsigned int gup_flags,
> +                            int *fault_error)
>  {
>         struct mm_struct *mm = current->mm;
>         int locked = 1;
> @@ -1978,7 +1996,8 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>
>         mmap_read_lock(mm);
>         ret = __get_user_pages_locked(mm, start, nr_pages, pages, NULL,
> -                                     &locked, gup_flags | FOLL_TOUCH);
> +                                     &locked, gup_flags | FOLL_TOUCH,
> +                                     fault_error);
>         if (locked)
>                 mmap_read_unlock(mm);
>         return ret;
> @@ -2550,7 +2569,7 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>                 mmap_read_unlock(current->mm);
>         } else {
>                 ret = get_user_pages_unlocked(start, nr_pages,
> -                                             pages, gup_flags);
> +                                             pages, gup_flags, NULL);
>         }
>
>         return ret;
> @@ -2880,7 +2899,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>                 return -EINVAL;
>
>         gup_flags |= FOLL_PIN;
> -       return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
> +       return get_user_pages_unlocked(start, nr_pages, pages, gup_flags, NULL);
>  }
>  EXPORT_SYMBOL(pin_user_pages_unlocked);
>
> @@ -2909,6 +2928,6 @@ long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
>         gup_flags |= FOLL_PIN;
>         return __get_user_pages_locked(current->mm, start, nr_pages,
>                                        pages, NULL, locked,
> -                                      gup_flags | FOLL_TOUCH);
> +                                      gup_flags | FOLL_TOUCH, NULL);
>  }
>  EXPORT_SYMBOL(pin_user_pages_locked);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3db405dea3dc..889ac33d57d5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5017,7 +5017,8 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>                          struct page **pages, struct vm_area_struct **vmas,
>                          unsigned long *position, unsigned long *nr_pages,
> -                        long i, unsigned int flags, int *locked)
> +                        long i, unsigned int flags, int *locked,
> +                        int  *fault_error)
>  {
>         unsigned long pfn_offset;
>         unsigned long vaddr = *position;
> @@ -5103,6 +5104,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>                         }
>                         ret = hugetlb_fault(mm, vma, vaddr, fault_flags);
>                         if (ret & VM_FAULT_ERROR) {
> +                               if (fault_error)
> +                                       *fault_error = ret;
>                                 err = vm_fault_to_errno(ret, flags);
>                                 remainder = 0;
>                                 break;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2799c6660cce..0a20d926ae32 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2004,6 +2004,30 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
>         return false;
>  }
>
> +static void kvm_send_vm_fault_signal(int fault_error, int errno,
> +                                    unsigned long address,
> +                                    struct task_struct *tsk)
> +{
> +       kernel_siginfo_t info;
> +
> +       clear_siginfo(&info);
> +
> +       if (fault_error == VM_FAULT_SIGBUS)
> +               info.si_signo = SIGBUS;
> +       else if (fault_error == VM_FAULT_SIGSEGV)
> +               info.si_signo = SIGSEGV;
> +       else
> +               // Other fault errors should not result in a signal.
> +               return;
> +
> +       info.si_errno = errno;
> +       info.si_code = BUS_ADRERR;
> +       info.si_addr = (void __user *)address;
> +       info.si_addr_lsb = PAGE_SHIFT;
> +
> +       send_sig_info(info.si_signo, &info, tsk);
> +}
> +
>  /*
>   * The slow path to get the pfn of the specified host virtual address,
>   * 1 indicates success, -errno is returned if error is detected.
> @@ -2014,6 +2038,7 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
>         unsigned int flags = FOLL_HWPOISON;
>         struct page *page;
>         int npages = 0;
> +       int fault_error;
>
>         might_sleep();
>
> @@ -2025,7 +2050,10 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
>         if (async)
>                 flags |= FOLL_NOWAIT;
>
> -       npages = get_user_pages_unlocked(addr, 1, &page, flags);
> +       npages = get_user_pages_unlocked(addr, 1, &page, flags, &fault_error);
> +       if (fault_error & VM_FAULT_ERROR)
> +               kvm_send_vm_fault_signal(fault_error, npages, addr, current);
> +
>         if (npages != 1)
>                 return npages;
>
> --
> 2.31.1.751.gd2f1c929bd-goog
>
