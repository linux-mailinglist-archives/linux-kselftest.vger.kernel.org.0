Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7E29700
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 13:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbfEXLUb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 07:20:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390535AbfEXLUa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 07:20:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C89F4374;
        Fri, 24 May 2019 04:20:29 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B166B3F703;
        Fri, 24 May 2019 04:20:23 -0700 (PDT)
Date:   Fri, 24 May 2019 12:20:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     enh <enh@google.com>, Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
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
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190524112020.xcio5jrx6kzmrdnz@mbp>
References: <20190521182932.sm4vxweuwo5ermyd@mbp>
 <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp>
 <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
 <20190522163527.rnnc6t4tll7tk5zw@mbp>
 <201905221316.865581CF@keescook>
 <20190523144449.waam2mkyzhjpqpur@mbp>
 <201905230917.DEE7A75EF0@keescook>
 <20190523174345.6sv3kcipkvlwfmox@mbp>
 <201905231327.77CA8D0A36@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905231327.77CA8D0A36@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 02:31:16PM -0700, Kees Cook wrote:
> On Thu, May 23, 2019 at 06:43:46PM +0100, Catalin Marinas wrote:
> > On Thu, May 23, 2019 at 09:38:19AM -0700, Kees Cook wrote:
> > > What about testing tools that intentionally insert high bits for syscalls
> > > and are _expecting_ them to fail? It seems the TBI series will break them?
> > > In that case, do we need to opt into TBI as well?
> > 
> > If there are such tools, then we may need a per-process control. It's
> > basically an ABI change.
> 
> syzkaller already attempts to randomly inject non-canonical and
> 0xFFFF....FFFF addresses for user pointers in syscalls in an effort to
> find bugs like CVE-2017-5123 where waitid() via unchecked put_user() was
> able to write directly to kernel memory[1].
> 
> It seems that using TBI by default and not allowing a switch back to
> "normal" ABI without a reboot actually means that userspace cannot inject
> kernel pointers into syscalls any more, since they'll get universally
> stripped now. Is my understanding correct, here? i.e. exploiting
> CVE-2017-5123 would be impossible under TBI?

Unless the kernel is also using TBI (khwasan), in which case masking out
the top byte wouldn't help. Anyway, as per this discussion, we want the
tagged pointer to remain intact all the way to put_user(), so nothing
gets masked out. I don't think this would have helped with the waitid()
bug.

> If so, then I think we should commit to the TBI ABI and have a boot
> flag to disable it, but NOT have a process flag, as that would allow
> attackers to bypass the masking. The only flag should be "TBI or MTE".
> 
> If so, can I get top byte masking for other architectures too? Like,
> just to strip high bits off userspace addresses? ;)

But you didn't like my option 2 shim proposal which strips the tag on
kernel entry because it lowers the value of MTE ;).

> (Oh, in looking I see this is implemented with sign-extension... why
> not just a mask? So it'll either be valid userspace address or forced
> into the non-canonical range?)

The TTBR0/1 selection on memory accesses is done based on bit 63 if TBI
is disabled and bit 55 when enabled. Sign-extension allows us to use the
same macro for both user and kernel tagged pointers. With MTE tag 0
would be match-all for TTBR0 and 0xff for TTBR1 (so that we don't modify
the virtual address space of the kernel; I need to check the latest spec
to be sure). Note that the VA space for both user and kernel is limited
to 52-bit architecturally so, on access, bits 55..52 must be the same, 0
or 1, otherwise you get a fault.

Since the syzkaller tests would also need to set bits 55-52 (actually 48
for kernel addresses, we haven't merged the 52-bit kernel VA patches
yet) to hit a valid kernel address, I don't think ignoring the top byte
makes much difference to the expected failure scenario.

> > > Alright, the tl;dr appears to be:
> > > - you want more assurances that we can find __user stripping in the
> > >   kernel more easily. (But this seems like a parallel problem.)
> > 
> > Yes, and that we found all (most) cases now. The reason I don't see it
> > as a parallel problem is that, as maintainer, I promise an ABI to user
> > and I'd rather stick to it. I don't want, for example, ncurses to stop
> > working because of some ioctl() rejecting tagged pointers.
> 
> But this is what I don't understand: it would need to be ncurses _using
> TBI_, that would stop working (having started to work before, but then
> regress due to a newly added one-off bug). Regular ncurses will be fine
> because it's not using TBI. So The Golden Rule isn't violated,

Once we introduced TBI and the libc starts tagging heap allocations,
this becomes the new "regular" user space behaviour (i.e. using TBI). So
a new bug would break the golden rule. It could also be an old bug that
went unnoticed (i.e. you changed the graphics card and its driver gets
confused by tagged pointers coming from user-space).

> and by definition, it's a specific regression caused by some bug
> (since TBI would have had to have worked _before_ in the situation to
> be considered a regression now). Which describes the normal path for
> kernel development... add feature, find corner cases where it doesn't
> work, fix them, encounter new regressions, fix those, repeat forever.
> 
> > If it's just the occasional one-off bug I'm fine to deal with it. But
> > no-one convinced me yet that this is the case.
> 
> You believe there still to be some systemic cases that haven't been
> found yet? And even if so -- isn't it better to work on that
> incrementally?

I want some way to systematically identify potential issues (sparse?).
Since problems are most likely in drivers, I don't have all devices to
check and not all users have the knowledge to track down why something
failed.

I think we can do this incrementally as long the TBI ABI is not the
default. Even better if we made it per process.

> > As for the generic driver code (filesystems or other subsystems),
> > without some clear direction for developers, together with static
> > checking/sparse, on how user pointers are cast to longs (one example),
> > it would become my responsibility to identify and fix them up with any
> > kernel release. This series is not providing such guidance, just adding
> > untagged_addr() in some places that we think matter.
> 
> What about adding a nice bit of .rst documentation that describes the
> situation and shows how to use untagged_addr(). This is the kind of
> kernel-wide change that "everyone" needs to know about, and shouldn't
> be the arch maintainer's sole responsibility to fix.

This works (if people read it) but we also need to be more prescriptive
in how casting is done and how we differentiate between a pointer for
dereference (T __user *) and address space management (usually unsigned
long). On top of that, we'd get sparse to check for such conversions and
maybe even checkpatch for some low-hanging fruit.

> > > - we might need to opt in to TBI with a prctl()
> > 
> > Yes, although still up for discussion.
> 
> I think I've talked myself out of it. I say boot param only! :)

I hope I talked you in again ;). I don't see TBI as improving kernel
security.

> So what do you say to these next steps:
> 
> - change untagged_addr() to use a static branch that is controlled with
>   a boot parameter.

access_ok() as well.

> - add, say, Documentation/core-api/user-addresses.rst to describe
>   proper care and handling of user space pointers with untagged_addr(),
>   with examples based on all the cases seen so far in this series.

We have u64_to_user_ptr(). What about the reverse? And maybe changing
get_user_pages() to take void __user *.

> - continue work to improve static analysis.

Andrew Murray in the ARM kernel team started revisiting the old sparse
threads, let's see how it goes.

-- 
Catalin
