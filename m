Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8561527179
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfEVVRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 17:17:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38842 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfEVVRL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 17:17:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id r19so1416048uap.5
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2019 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dHniiz5Iec+zX/39XStbUXbmPxCKmuaK7gygHepfyc=;
        b=BozsRedf7hxOrPEwc14/5gYKjPtcuYPfCzdL5Qh8eptxMopndG6sl6KK8l1wx0gHcO
         fX9KUGo72jJQy2d1m1wZ3No1Qi2uQpl1cB2uKNXeTTE0y7bVHQRp3jZ8gNy6f12oUbuZ
         9pqndA18D5HuCzEP7FakfNMcFjkFYSW5Qf6tTdWeb6YU5HYx7NFV4gOPaqZKnmwkQ5VN
         K2fCVmPCADr0j8VP+wLoOUFpEpW6WISMm8/ajD25DfdGIBy1SiKGnwF+/Lt+nHE51rtB
         vS7fbs1gYfPlwpTBaswd0RKzwzIK+7d4NhNx6dxPb1W6jd5YUGLoFQyi73p/mW3CKcJq
         v2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dHniiz5Iec+zX/39XStbUXbmPxCKmuaK7gygHepfyc=;
        b=ZxfYUPNKOtGy0rsthvdsoAssOBKOQ5w7yjRObW66y5zrUwUEsm7GEnTFHYAtrFPDmS
         6uWRwy9CtnwasuxjSWOBXh0rMa8f/X2HiRr4S4aMabm5OWgO3aTgS2udtVDaWnGQoxnO
         N7TRY+1k6oOUwIXLYBgx69U+oueFHi7zUvR4J8z0+niGfdpbsq1nUuaSU/SEXImrX1+R
         ZBPcQPVzO/N7LWmSxf4ccUliJ+ke/M0TTAz33TMskNYVrRNYXz0o985LzYqPEBT5bFCd
         QWOjzw4NCJ8qDuS0ZnJdpfmDVx4e9DHUbqGzXfhy24Nbh301kgddats3vPRDCgL1rriP
         ViiQ==
X-Gm-Message-State: APjAAAXct642uhBDI6jKjENX9vijlBIeTkL3CFDfQ3ZtRDS0OCuVZDjt
        STysw8N3Fpy6tkiVX8mekGzcKbzRQDklAOpgtxK6Zg==
X-Google-Smtp-Source: APXvYqxH4+lXdvKeAKR6IcV6qRcWyD41x0RLMgowdC0uvePb1uyY7QqZdIceH4zhHD2Gn25pj1INm9uTZm6L2qnPIh8=
X-Received: by 2002:ab0:115a:: with SMTP id g26mr16507991uac.84.1558559829704;
 Wed, 22 May 2019 14:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
 <20190522114910.emlckebwzv2qz42i@mbp>
In-Reply-To: <20190522114910.emlckebwzv2qz42i@mbp>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Wed, 22 May 2019 14:16:57 -0700
Message-ID: <CAFKCwrjyP+x0JJy=qpBFsp4pub3He6UkvU0qnf1UOKt6W1LPRQ@mail.gmail.com>
Subject: Re: [PATCH v15 05/17] arms64: untag user pointers passed to memory syscalls
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 4:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, May 06, 2019 at 06:30:51PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > This patch allows tagged pointers to be passed to the following memory
> > syscalls: brk, get_mempolicy, madvise, mbind, mincore, mlock, mlock2,
> > mmap, mmap_pgoff, mprotect, mremap, msync, munlock, munmap,
> > remap_file_pages, shmat and shmdt.
> >
> > This is done by untagging pointers passed to these syscalls in the
> > prologues of their handlers.
>
> I'll go through them one by one to see if we can tighten the expected
> ABI while having the MTE in mind.
>
> > diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> > index b44065fb1616..933bb9f3d6ec 100644
> > --- a/arch/arm64/kernel/sys.c
> > +++ b/arch/arm64/kernel/sys.c
> > @@ -35,10 +35,33 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> >  {
> >       if (offset_in_page(off) != 0)
> >               return -EINVAL;
> > -
> > +     addr = untagged_addr(addr);
> >       return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> >  }
>
> If user passes a tagged pointer to mmap() and the address is honoured
> (or MAP_FIXED is given), what is the expected return pointer? Does it
> need to be tagged with the value from the hint?

For HWASan the most convenient would be to use the tag from the hint.
But since in the TBI (not MTE) mode the kernel has no idea what
meaning userspace assigns to pointer tags, perhaps it should not try
to guess, and should return raw (zero-tagged) address instead.

> With MTE, we may want to use this as a request for the default colour of
> the mapped pages (still under discussion).

I like this - and in that case it would make sense to return the
pointer that can be immediately dereferenced without crashing the
process, i.e. with the matching tag.

> > +SYSCALL_DEFINE6(arm64_mmap_pgoff, unsigned long, addr, unsigned long, len,
> > +             unsigned long, prot, unsigned long, flags,
> > +             unsigned long, fd, unsigned long, pgoff)
> > +{
> > +     addr = untagged_addr(addr);
> > +     return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
> > +}
>
> We don't have __NR_mmap_pgoff on arm64.
>
> > +SYSCALL_DEFINE5(arm64_mremap, unsigned long, addr, unsigned long, old_len,
> > +             unsigned long, new_len, unsigned long, flags,
> > +             unsigned long, new_addr)
> > +{
> > +     addr = untagged_addr(addr);
> > +     new_addr = untagged_addr(new_addr);
> > +     return ksys_mremap(addr, old_len, new_len, flags, new_addr);
> > +}
>
> Similar comment as for mmap(), do we want the tag from new_addr to be
> preserved? In addition, should we check that the two tags are identical
> or mremap() should become a way to repaint a memory region?
>
> > +SYSCALL_DEFINE2(arm64_munmap, unsigned long, addr, size_t, len)
> > +{
> > +     addr = untagged_addr(addr);
> > +     return ksys_munmap(addr, len);
> > +}
>
> This looks fine.
>
> > +SYSCALL_DEFINE1(arm64_brk, unsigned long, brk)
> > +{
> > +     brk = untagged_addr(brk);
> > +     return ksys_brk(brk);
> > +}
>
> I wonder whether brk() should simply not accept tags, and should not
> return them (similar to the prctl(PR_SET_MM) discussion). We could
> document this in the ABI requirements.
>
> > +SYSCALL_DEFINE5(arm64_get_mempolicy, int __user *, policy,
> > +             unsigned long __user *, nmask, unsigned long, maxnode,
> > +             unsigned long, addr, unsigned long, flags)
> > +{
> > +     addr = untagged_addr(addr);
> > +     return ksys_get_mempolicy(policy, nmask, maxnode, addr, flags);
> > +}
> > +
> > +SYSCALL_DEFINE3(arm64_madvise, unsigned long, start,
> > +             size_t, len_in, int, behavior)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_madvise(start, len_in, behavior);
> > +}
> > +
> > +SYSCALL_DEFINE6(arm64_mbind, unsigned long, start, unsigned long, len,
> > +             unsigned long, mode, const unsigned long __user *, nmask,
> > +             unsigned long, maxnode, unsigned int, flags)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_mbind(start, len, mode, nmask, maxnode, flags);
> > +}
> > +
> > +SYSCALL_DEFINE2(arm64_mlock, unsigned long, start, size_t, len)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_mlock(start, len, VM_LOCKED);
> > +}
> > +
> > +SYSCALL_DEFINE2(arm64_mlock2, unsigned long, start, size_t, len)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_mlock(start, len, VM_LOCKED);
> > +}
> > +
> > +SYSCALL_DEFINE2(arm64_munlock, unsigned long, start, size_t, len)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_munlock(start, len);
> > +}
> > +
> > +SYSCALL_DEFINE3(arm64_mprotect, unsigned long, start, size_t, len,
> > +             unsigned long, prot)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_mprotect_pkey(start, len, prot, -1);
> > +}
> > +
> > +SYSCALL_DEFINE3(arm64_msync, unsigned long, start, size_t, len, int, flags)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_msync(start, len, flags);
> > +}
> > +
> > +SYSCALL_DEFINE3(arm64_mincore, unsigned long, start, size_t, len,
> > +             unsigned char __user *, vec)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_mincore(start, len, vec);
> > +}
>
> These look fine.
>
> > +SYSCALL_DEFINE5(arm64_remap_file_pages, unsigned long, start,
> > +             unsigned long, size, unsigned long, prot,
> > +             unsigned long, pgoff, unsigned long, flags)
> > +{
> > +     start = untagged_addr(start);
> > +     return ksys_remap_file_pages(start, size, prot, pgoff, flags);
> > +}
>
> While this has been deprecated for some time, I presume user space still
> invokes it?
>
> > +SYSCALL_DEFINE3(arm64_shmat, int, shmid, char __user *, shmaddr, int, shmflg)
> > +{
> > +     shmaddr = untagged_addr(shmaddr);
> > +     return ksys_shmat(shmid, shmaddr, shmflg);
> > +}
> > +
> > +SYSCALL_DEFINE1(arm64_shmdt, char __user *, shmaddr)
> > +{
> > +     shmaddr = untagged_addr(shmaddr);
> > +     return ksys_shmdt(shmaddr);
> > +}
>
> Do we actually want to allow shared tagged memory? Who's going to tag
> it? If not, we can document it as not supported.
>
> --
> Catalin
