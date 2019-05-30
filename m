Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451142FF00
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2019 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfE3PLQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 May 2019 11:11:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3PLQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 May 2019 11:11:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C00341;
        Thu, 30 May 2019 08:11:15 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9563F59C;
        Thu, 30 May 2019 08:11:09 -0700 (PDT)
Date:   Thu, 30 May 2019 16:11:07 +0100
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
Message-ID: <20190530151105.GA35418@arrakis.emea.arm.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
 <20190527143719.GA59948@MBP.local>
 <20190528145411.GA709@e119886-lin.cambridge.arm.com>
 <20190528154057.GD32006@arrakis.emea.arm.com>
 <11193998209cc6ff34e7d704f081206b8787b174.camel@oracle.com>
 <20190529142008.5quqv3wskmpwdfbu@mbp>
 <b2753e81-7b57-481f-0095-3c6fecb1a74c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2753e81-7b57-481f-0095-3c6fecb1a74c@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 29, 2019 at 01:16:37PM -0600, Khalid Aziz wrote:
> On 5/29/19 8:20 AM, Catalin Marinas wrote:
> > On Tue, May 28, 2019 at 05:33:04PM -0600, Khalid Aziz wrote:
> >> Steps 1 and 2 are accomplished by userspace by calling mprotect() with
> >> PROT_ADI. Tags are set by storing tags in a loop, for example:
> >>
> >>         version = 10;
> >>         tmp_addr = shmaddr;
> >>         end = shmaddr + BUFFER_SIZE;
> >>         while (tmp_addr < end) {
> >>                 asm volatile(
> >>                         "stxa %1, [%0]0x90\n\t"
> >>                         :
> >>                         : "r" (tmp_addr), "r" (version));
> >>                 tmp_addr += adi_blksz;
> >>         }
> > 
> > On arm64, a sequence similar to the above would live in the libc. So a
> > malloc() call will tag the memory and return the tagged address to thePre-coloring could easily be done by 
> > user.
> > 
> > We were not planning for a PROT_ADI/MTE but rather have MTE enabled for
> > all user memory ranges. We may revisit this before we upstream the MTE
> > support (probably some marginal benefit for the hardware not fetching
> > the tags from memory if we don't need to, e.g. code sections).
> > 
> > Given that we already have the TBI feature and with MTE enabled the top
> > byte is no longer ignored, we are planning for an explicit opt-in by the
> > user via prctl() to enable MTE.
> 
> OK. I had initially proposed enabling ADI for a process using prctl().
> Feedback I got was prctl was not a desirable interface and I ended up
> making mprotect() with PROT_ADI enable ADI on the process instead. Just
> something to keep in mind.

Thanks for the feedback. We'll keep this in mind when adding MTE
support. In the way we plan to deploy this, it would be a libc decision
to invoke the mmap() with the right flag.

This could actually simplify the automatic page faulting below brk(),
basically no tagged/coloured memory allowed implicitly. It needs
feedback from the bionic/glibc folk.

> >> With these semantics, giving mmap() or shamat() a tagged address is
> >> meaningless since no tags have been stored at the addresses mmap() will
> >> allocate and one can not store tags before memory range has been
> >> allocated. If we choose to allow tagged addresses to come into mmap()
> >> and shmat(), sparc code can strip the tags unconditionally and that may
> >> help simplify ABI and/or code.
> > 
> > We could say that with TBI (pre-MTE support), the top byte is actually
> > ignored on mmap(). Now, if you pass a MAP_FIXED with a tagged address,
> > should the user expect the same tagged address back or stripping the tag
> > is acceptable? If we want to keep the current mmap() semantics, I'd say
> > the same tag is returned. However, with MTE this also implies that the
> > memory was coloured.
> 
> Is assigning a tag aprivileged operationon ARM64? I am thinking not
> since you mentioned libc could do it in a loop for malloc'd memory.

Indeed it's not, the user can do it.

> mmap() can return the same tagged address but I am uneasy about kernel
> pre-coloring the pages. Database can mmap 100's of GB of memory. That is
> lot of work being offloaded to the kernel to pre-color the page even if
> done in batches as pages are faulted in.

For anonymous mmap() for example, the kernel would have to zero the
faulted in pages anyway. We can handle the colouring at the same time in
clear_user_page() (as I said below, we have to clear the colour anyway
from previous uses, so it's simply extending this to support something
other than tag/colour 0 by default with no additional overhead).

> > Since the user can probe the pre-existing colour in a faulted-in page
> > (either with some 'ldxa' instruction or by performing a tag-checked
> > access), the kernel should always pre-colour (even if colour 0) any
> > allocated page. There might not be an obvious security risk but I feel
> > uneasy about letting colours leak between address spaces (different user
> > processes or between kernel and user).
> 
> On sparc, tags 0 and 15 are special in that 0 means untagged memory and
> 15 means match any tag in the address. Colour 0 is the default for any
> newly faulted in page on sparc.

With MTE we don't have match-all/any tag in memory, only in the virtual
address/pointer. So if we turn on MTE for all pages and the user
accesses an address with a 0 tag, the underlying memory needs to be
coloured with the same 0 value.

> > Since we already need such loop in the kernel, we might as well allow
> > user space to require a certain colour. This comes in handy for large
> > malloc() and another advantage is that the C library won't be stuck
> > trying to paint the whole range (think GB).
> 
> If kernel is going to pre-color all pages in a vma, we will need to
> store the default tag in the vma. It will add more time to page fault
> handling code. On sparc M7, kernel will need to execute additional 128
> stxa instructions to set the tags on a normal page.

As I said, since the user can retrieve an old colour using ldxa, the
kernel should perform this operation anyway on any newly allocated page
(unless you clear the existing colour on page freeing).

> >> We can try to store tags for an entire region in vma but that is
> >> expensive, plus on sparc tags are set in userspace with no
> >> participation from kernel and now we need a way for userspace to
> >> communicate the tags to kernel.
> > 
> > We can't support finer granularity through the mmap() syscall and, as
> > you said, the vma is not the right thing to store the individual tags.
> > With the above extension to mmap(), we'd have to store a colour per vma
> > and prevent merging if different colours (we could as well use the
> > pkeys mechanism we already have in the kernel but use a colour per vma
> > instead of a key).
> 
> Since tags can change on any part of mmap region on sparc at any time
> without kernel being involved, I am not sure I see much reason for
> kernel to enforce any tag related restrictions.

It's not enforcing a tag, more like the default colour for a faulted in
page. Anyway, if sparc is going with default 0/untagged, that's fine as
well. We may add this mmap() option to arm64 only.

> >> From sparc point of view, making kernel responsible for assigning tags
> >> to a page on page fault is full of pitfalls.
> > 
> > This could be just some arm64-specific but if you plan to deploy it more
> > generically for sparc (at the C library level), you may find this
> > useful.
> 
> Common semantics from app developer point of view will be very useful to
> maintain. If arm64 says mmap with MAP_FIXED and a tagged address will
> return a pre-colored page, I would rather have it be the same on any
> architecture. Is there a use case that justifies kernel doing this extra
> work?

So if a database program is doing an anonymous mmap(PROT_TBI) of 100GB,
IIUC for sparc the faulted-in pages will have random colours (on 64-byte
granularity). Ignoring the information leak from prior uses of such
pages, it would be the responsibility of the db program to issue the
stxa. On arm64, since we also want to do this via malloc(), any large
allocation would require all pages to be faulted in so that malloc() can
set the write colour before being handed over to the user. That's what
we want to avoid and the user is free to repaint the memory as it likes.

-- 
Catalin
