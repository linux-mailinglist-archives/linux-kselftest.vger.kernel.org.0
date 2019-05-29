Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA92DF81
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2019 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2OUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 May 2019 10:20:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46868 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfE2OUT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 May 2019 10:20:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00935A78;
        Wed, 29 May 2019 07:20:18 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6612C3F5AF;
        Wed, 29 May 2019 07:20:11 -0700 (PDT)
Date:   Wed, 29 May 2019 15:20:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Dmitry Vyukov <dvyukov@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v15 05/17] arms64: untag user pointers passed to memory
 syscalls
Message-ID: <20190529142008.5quqv3wskmpwdfbu@mbp>
References: <cover.1557160186.git.andreyknvl@google.com>
 <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
 <20190527143719.GA59948@MBP.local>
 <20190528145411.GA709@e119886-lin.cambridge.arm.com>
 <20190528154057.GD32006@arrakis.emea.arm.com>
 <11193998209cc6ff34e7d704f081206b8787b174.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11193998209cc6ff34e7d704f081206b8787b174.camel@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Khalid,

On Tue, May 28, 2019 at 05:33:04PM -0600, Khalid Aziz wrote:
> On Tue, 2019-05-28 at 16:40 +0100, Catalin Marinas wrote:
> > I think another aspect is how we define the ABI. Is allowing tags to
> > mlock() for example something specific to arm64 or would sparc ADI
> > need the same? In the absence of other architectures defining such
> > ABI, my preference would be to keep the wrappers in the arch code.
> > 
> > Assuming sparc won't implement untagged_addr(), we can place the
> > macros back in the generic code but, as per the review here, we need
> > to be more restrictive on where we allow tagged addresses. For
> > example, if mmap() gets a tagged address with MAP_FIXED, is it
> > expected to return the tag?
> 
> I would recommend against any ABI differences between ARM64 MTE/TBI and
> sparc ADI unless it simply can not be helped. My understanding of
> MTE/TBI is limited, so I will explain how sparc ADI works. On sparc, a
> tagged address has no meaning until following steps happen:

Before we go into the MTE/ADI similarities or differences, just to
clarify that TBI is something that we supported from the start of the
arm64 kernel port. TBI (top byte ignore) allows a user pointer to have
non-zero top byte and dereference it without causing a fault (the
hardware masks it out). The user/kernel ABI does not allow such tagged
pointers into the kernel, nor would the kernel return any such tagged
addresses.

With MTE (memory tagging extensions), the top-byte meaning is changed
from no longer being ignored to actually being checked against a tag in
the physical RAM (we call it allocation tag).

> 1. set the user mode PSTATE.mcde bit. This acts as the master switch to
> enable ADI for a process.
> 
> 2. set TTE.mcd bit on TLB entries that match the address range ADI is
> being enabled on.

Something close enough for MTE, with the difference that enabling it is
not a PSTATE bit but rather a system control bit (SCTLR_EL1 register),
so only the kernel can turn it on/off for the user.

> 3. Store version tag for the range of addresses userspace wants ADI
> enabled on using "stxa" instruction. These tags are stored in physical
> memory by the memory controller.

Do you have an "ldxa" instruction to load the tags from physical memory?

> Steps 1 and 2 are accomplished by userspace by calling mprotect() with
> PROT_ADI. Tags are set by storing tags in a loop, for example:
> 
>         version = 10;
>         tmp_addr = shmaddr;
>         end = shmaddr + BUFFER_SIZE;
>         while (tmp_addr < end) {
>                 asm volatile(
>                         "stxa %1, [%0]0x90\n\t"
>                         :
>                         : "r" (tmp_addr), "r" (version));
>                 tmp_addr += adi_blksz;
>         }

On arm64, a sequence similar to the above would live in the libc. So a
malloc() call will tag the memory and return the tagged address to the
user.

We were not planning for a PROT_ADI/MTE but rather have MTE enabled for
all user memory ranges. We may revisit this before we upstream the MTE
support (probably some marginal benefit for the hardware not fetching
the tags from memory if we don't need to, e.g. code sections).

Given that we already have the TBI feature and with MTE enabled the top
byte is no longer ignored, we are planning for an explicit opt-in by the
user via prctl() to enable MTE.

> With these semantics, giving mmap() or shamat() a tagged address is
> meaningless since no tags have been stored at the addresses mmap() will
> allocate and one can not store tags before memory range has been
> allocated. If we choose to allow tagged addresses to come into mmap()
> and shmat(), sparc code can strip the tags unconditionally and that may
> help simplify ABI and/or code.

We could say that with TBI (pre-MTE support), the top byte is actually
ignored on mmap(). Now, if you pass a MAP_FIXED with a tagged address,
should the user expect the same tagged address back or stripping the tag
is acceptable? If we want to keep the current mmap() semantics, I'd say
the same tag is returned. However, with MTE this also implies that the
memory was coloured.

> > My thoughts on allowing tags (quick look):
> > 
> > brk - no
> > get_mempolicy - yes
> > madvise - yes
> > mbind - yes
> > mincore - yes
> > mlock, mlock2, munlock - yes
> > mmap - no (we may change this with MTE but not for TBI)
> > mmap_pgoff - not used on arm64
> > mprotect - yes
> > mremap - yes for old_address, no for new_address (on par with mmap)
> > msync - yes
> > munmap - probably no (mmap does not return tagged ptrs)
> > remap_file_pages - no (also deprecated syscall)
> > shmat, shmdt - shall we allow tagged addresses on shared memory?
> > 
> > The above is only about the TBI ABI while ignoring hardware MTE. For
> > the latter, we may want to change the mmap() to allow pre-colouring
> > on page fault which means that munmap()/mprotect() should also
> > support tagged pointers. Possibly mremap() as well but we need to
> > decide whether it should allow re-colouring the page (probably no,
> > in which case old_address and new_address should have the same tag).
> > For some of these we'll end up with arm64 specific wrappers again,
> > unless sparc ADI adopts exactly the same ABI restrictions.
> 
> Let us keep any restrictions common across ARM64 and sparc. pre-
> coloring on sparc in the kernel would mean kernel will have to execute
> stxa instructions in a loop for each page being faulted in.

Since the user can probe the pre-existing colour in a faulted-in page
(either with some 'ldxa' instruction or by performing a tag-checked
access), the kernel should always pre-colour (even if colour 0) any
allocated page. There might not be an obvious security risk but I feel
uneasy about letting colours leak between address spaces (different user
processes or between kernel and user).

Since we already need such loop in the kernel, we might as well allow
user space to require a certain colour. This comes in handy for large
malloc() and another advantage is that the C library won't be stuck
trying to paint the whole range (think GB).

> Not that big a deal but doesn't that assume the entire page has the
> same tag which is dedcued from the upper bits of address? Shouldn't we
> support tags at the same granularity level as what the hardware
> supports?

That's mostly about large malloc() optimisation via mmap(), the latter
working on page granularity already. There is another use-case for
pre-coloured thread stacks, also allocated via anonymous mmap().

> We went through this discussion for sparc and decision was to support
> tags at the same granularity as hardware. That means we can not deduce
> tags from the first address that pioints into an mmap or shmat region.
> Those tags and the upper bytes of colored address could change for
> every cacheline sized block (64-bytes on sparc M7).

It's 16-byte for arm64, so smaller than the cacheline.

> We can try to store tags for an entire region in vma but that is
> expensive, plus on sparc tags are set in userspace with no
> participation from kernel and now we need a way for userspace to
> communicate the tags to kernel.

We can't support finer granularity through the mmap() syscall and, as
you said, the vma is not the right thing to store the individual tags.
With the above extension to mmap(), we'd have to store a colour per vma
and prevent merging if different colours (we could as well use the
pkeys mechanism we already have in the kernel but use a colour per vma
instead of a key).

Of course, the user is allowed to change the in-memory colours at a
finer granularity and the kernel will preserve them during swapping
out/in, page migration etc. The above mmap() proposal is just for the
first fault-in of a page in a given range/vma.

> From sparc point of view, making kernel responsible for assigning tags
> to a page on page fault is full of pitfalls.

This could be just some arm64-specific but if you plan to deploy it more
generically for sparc (at the C library level), you may find this
useful.

-- 
Catalin
