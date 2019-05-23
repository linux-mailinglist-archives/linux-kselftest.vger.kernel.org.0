Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2254528014
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfEWOo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 10:44:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbfEWOo7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 10:44:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B972A80D;
        Thu, 23 May 2019 07:44:58 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DF2A3F690;
        Thu, 23 May 2019 07:44:52 -0700 (PDT)
Date:   Thu, 23 May 2019 15:44:49 +0100
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
Message-ID: <20190523144449.waam2mkyzhjpqpur@mbp>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp>
 <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp>
 <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
 <20190522163527.rnnc6t4tll7tk5zw@mbp>
 <201905221316.865581CF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905221316.865581CF@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 01:47:36PM -0700, Kees Cook wrote:
> On Wed, May 22, 2019 at 05:35:27PM +0100, Catalin Marinas wrote:
> > The two hard requirements I have for supporting any new hardware feature
> > in Linux are (1) a single kernel image binary continues to run on old
> > hardware while making use of the new feature if available and (2) old
> > user space continues to run on new hardware while new user space can
> > take advantage of the new feature.
> 
> Agreed! And I think the series meets these requirements, yes?

Yes. I mentioned this just to make sure people don't expect different
kernel builds for different hardware features.

There is also the obvious requirement which I didn't mention: new user
space continues to run on new/subsequent kernel versions. That's one of
the points of contention for this series (ignoring MTE) with the
maintainers having to guarantee this without much effort. IOW, do the
500K+ new lines in a subsequent kernel version break any user space out
there? I'm only talking about the relaxed TBI ABI. Are the usual LTP,
syskaller sufficient? Better static analysis would definitely help.

> > For MTE, we just can't enable it by default since there are applications
> > who use the top byte of a pointer and expect it to be ignored rather
> > than failing with a mismatched tag. Just think of a hwasan compiled
> > binary where TBI is expected to work and you try to run it with MTE
> > turned on.
> 
> Ah! Okay, here's the use-case I wasn't thinking of: the concern is TBI
> conflicting with MTE. And anything that starts using TBI suddenly can't
> run in the future because it's being interpreted as MTE bits? (Is that
> the ABI concern?

That's another aspect to figure out when we add the MTE support. I don't
think we'd be able to do this without an explicit opt-in by the user.

Or, if we ever want MTE to be turned on by default (i.e. tag checking),
even if everything is tagged with 0, we have to disallow TBI for user
and this includes hwasan. There were a small number of programs using
the TBI (I think some JavaScript compilers tried this). But now we are
bringing in the hwasan support and this can be a large user base. Shall
we add an ELF note for such binaries that use TBI/hwasan?

This series is still required for MTE but we may decide not to relax the
ABI blindly, therefore the opt-in (prctl) or personality idea.

> I feel like we got into the weeds about ioctl()s and one-off bugs...)

This needs solving as well. Most driver developers won't know why
untagged_addr() is needed unless we have more rigorous types or type
annotations and a tool to check them (we should probably revive the old
sparse thread).

> So there needs to be some way to let the kernel know which of three
> things it should be doing:
> 1- leaving userspace addresses as-is (present)
> 2- wiping the top bits before using (this series)

(I'd say tolerating rather than wiping since get_user still uses the tag
in the current series)

The current series does not allow any choice between 1 and 2, the
default ABI basically becomes option 2.

> 3- wiping the top bits for most things, but retaining them for MTE as
>    needed (the future)

2 and 3 are not entirely compatible as a tagged pointer may be checked
against the memory colour by the hardware. So you can't have hwasan
binary with MTE enabled.

> I expect MTE to be the "default" in the future. Once a system's libc has
> grown support for it, everything will be trying to use MTE. TBI will be
> the special case (but TBI is effectively a prerequisite).

The kernel handling of tagged pointers is indeed a prerequisite. The ABI
distinction between the above 2 and 3 needs to be solved.

> AFAICT, the only difference I see between 2 and 3 will be the tag handling
> in usercopy (all other places will continue to ignore the top bits). Is
> that accurate?

Yes, mostly (for the kernel). If MTE is enabled by default for a hwasan
binary, it will SEGFAULT (either in user space or in kernel uaccess).
How does the kernel choose between 2 and 3?

> Is "1" a per-process state we want to keep? (I assume not, but rather it
> is available via no TBI/MTE CONFIG or a boot-time option, if at all?)

Possibly, though not necessarily per process. For testing or if
something goes wrong during boot, a command line option with a static
label would do. The AT_FLAGS bit needs to be checked by user space. My
preference would be per-process.

> To choose between "2" and "3", it seems we need a per-process flag to
> opt into TBI (and out of MTE).

Or leave option 2 the default and get it to opt in to MTE.

> For userspace, how would a future binary choose TBI over MTE? If it's
> a library issue, we can't use an ELF bit, since the choice may be
> "late" after ELF load (this implies the need for a prctl().) If it's
> binary-only ("built with HWKASan") then an ELF bit seems sufficient.
> And without the marking, I'd expect the kernel to enforce MTE when
> there are high bits.

The current plan is that a future binary issues a prctl(), after
checking the HWCAP_MTE bit (as I replied to Elliot, the MTE instructions
are not in the current NOP space). I'd expect this to be done by the
libc or dynamic loader under the assumption that the binaries it loads
do _not_ use the top pointer byte for anything else. With hwasan
compiled objects this gets more confusing (any ELF note to identify
them?).

(there is also the risk of existing applications using TBI already but
I'm not aware of any still using this feature other than hwasan)

-- 
Catalin
