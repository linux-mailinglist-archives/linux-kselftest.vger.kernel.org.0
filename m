Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C58278B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfEWJEh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 05:04:37 -0400
Received: from foss.arm.com ([217.140.101.70]:40630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWJEh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 05:04:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 409B2341;
        Thu, 23 May 2019 02:04:36 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A78AC3F575;
        Thu, 23 May 2019 02:04:30 -0700 (PDT)
Date:   Thu, 23 May 2019 10:04:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Evgenii Stepanov <eugenis@google.com>
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
Subject: Re: [PATCH v15 05/17] arms64: untag user pointers passed to memory
 syscalls
Message-ID: <20190523090427.GA44383@arrakis.emea.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
 <20190522114910.emlckebwzv2qz42i@mbp>
 <CAFKCwrjyP+x0JJy=qpBFsp4pub3He6UkvU0qnf1UOKt6W1LPRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFKCwrjyP+x0JJy=qpBFsp4pub3He6UkvU0qnf1UOKt6W1LPRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 02:16:57PM -0700, Evgenii Stepanov wrote:
> On Wed, May 22, 2019 at 4:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, May 06, 2019 at 06:30:51PM +0200, Andrey Konovalov wrote:
> > > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > > pass tagged user pointers (with the top byte set to something else other
> > > than 0x00) as syscall arguments.
> > >
> > > This patch allows tagged pointers to be passed to the following memory
> > > syscalls: brk, get_mempolicy, madvise, mbind, mincore, mlock, mlock2,
> > > mmap, mmap_pgoff, mprotect, mremap, msync, munlock, munmap,
> > > remap_file_pages, shmat and shmdt.
> > >
> > > This is done by untagging pointers passed to these syscalls in the
> > > prologues of their handlers.
> >
> > I'll go through them one by one to see if we can tighten the expected
> > ABI while having the MTE in mind.
> >
> > > diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> > > index b44065fb1616..933bb9f3d6ec 100644
> > > --- a/arch/arm64/kernel/sys.c
> > > +++ b/arch/arm64/kernel/sys.c
> > > @@ -35,10 +35,33 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> > >  {
> > >       if (offset_in_page(off) != 0)
> > >               return -EINVAL;
> > > -
> > > +     addr = untagged_addr(addr);
> > >       return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> > >  }
> >
> > If user passes a tagged pointer to mmap() and the address is honoured
> > (or MAP_FIXED is given), what is the expected return pointer? Does it
> > need to be tagged with the value from the hint?
> 
> For HWASan the most convenient would be to use the tag from the hint.
> But since in the TBI (not MTE) mode the kernel has no idea what
> meaning userspace assigns to pointer tags, perhaps it should not try
> to guess, and should return raw (zero-tagged) address instead.

Then, just to relax the ABI for hwasan, shall we simply disallow tagged
pointers on mmap() arguments? We can leave them in for
mremap(old_address), madvise().

> > With MTE, we may want to use this as a request for the default colour of
> > the mapped pages (still under discussion).
> 
> I like this - and in that case it would make sense to return the
> pointer that can be immediately dereferenced without crashing the
> process, i.e. with the matching tag.

This came up from the Android investigation work where large memory
allocations (using mmap) could be more efficiently pre-tagged by the
kernel on page fault. Not sure about the implementation details yet.

-- 
Catalin
