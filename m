Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78EB26864
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfEVQfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 12:35:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbfEVQfg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 12:35:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39D60341;
        Wed, 22 May 2019 09:35:36 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE693F5AF;
        Wed, 22 May 2019 09:35:29 -0700 (PDT)
Date:   Wed, 22 May 2019 17:35:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     enh <enh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Evgenii Stepanov <eugenis@google.com>,
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
Message-ID: <20190522163527.rnnc6t4tll7tk5zw@mbp>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp>
 <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp>
 <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 08:30:21AM -0700, enh wrote:
> On Wed, May 22, 2019 at 3:11 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, May 21, 2019 at 05:04:39PM -0700, Kees Cook wrote:
> > > I just want to make sure I fully understand your concern about this
> > > being an ABI break, and I work best with examples. The closest situation
> > > I can see would be:
> > >
> > > - some program has no idea about MTE
> >
> > Apart from some libraries like libc (and maybe those that handle
> > specific device ioctls), I think most programs should have no idea about
> > MTE. I wouldn't expect programmers to have to change their app just
> > because we have a new feature that colours heap allocations.
> 
> obviously i'm biased as a libc maintainer, but...
> 
> i don't think it helps to move this to libc --- now you just have an
> extra dependency where to have a guaranteed working system you need to
> update your kernel and libc together. (or at least update your libc to
> understand new ioctls etc _before_ you can update your kernel.)

That's not what I meant (or I misunderstood you). If we have a relaxed
ABI in the kernel and a libc that returns tagged pointers on malloc() I
wouldn't expect the programmer to do anything different in the
application code like explicit untagging. Basically the program would
continue to run unmodified irrespective of whether you use an old libc
without tagged pointers or a new one which tags heap allocations.

What I do expect is that the libc checks for the presence of the relaxed
ABI, currently proposed as an AT_FLAGS bit (for MTE we'd have a
HWCAP_MTE), and only tag the malloc() pointers if the kernel supports
the relaxed ABI. As you said, you shouldn't expect that the C library
and kernel are upgraded together, so they should be able to work in any
new/old version combination.

> > > The trouble I see with this is that it is largely theoretical and
> > > requires part of userspace to collude to start using a new CPU feature
> > > that tickles a bug in the kernel. As I understand the golden rule,
> > > this is a bug in the kernel (a missed ioctl() or such) to be fixed,
> > > not a global breaking of some userspace behavior.
> >
> > Yes, we should follow the rule that it's a kernel bug but it doesn't
> > help the user that a newly installed kernel causes user space to no
> > longer reach a prompt. Hence the proposal of an opt-in via personality
> > (for MTE we would need an explicit opt-in by the user anyway since the
> > top byte is no longer ignored but checked against the allocation tag).
> 
> but realistically would this actually get used in this way? or would
> any given system either be MTE or non-MTE. in which case a kernel
> configuration option would seem to make more sense. (because either
> way, the hypothetical user basically needs to recompile the kernel to
> get back on their feet. or all of userspace.)

The two hard requirements I have for supporting any new hardware feature
in Linux are (1) a single kernel image binary continues to run on old
hardware while making use of the new feature if available and (2) old
user space continues to run on new hardware while new user space can
take advantage of the new feature.

The distro user space usually has a hard requirement that it continues
to run on (certain) old hardware. We can't enforce this in the kernel
but we offer the option to user space developers of checking feature
availability through HWCAP bits.

The Android story may be different as you have more control about which
kernel configurations are deployed on specific SoCs. I'm looking more
from a Linux distro angle where you just get an off-the-shelf OS image
and install it on your hardware, either taking advantage of new features
or just not using them if the software was not updated. Or, if updated
software is installed on old hardware, it would just run.

For MTE, we just can't enable it by default since there are applications
who use the top byte of a pointer and expect it to be ignored rather
than failing with a mismatched tag. Just think of a hwasan compiled
binary where TBI is expected to work and you try to run it with MTE
turned on.

I would also expect the C library or dynamic loader to check for the
presence of a HWCAP_MTE bit before starting to tag memory allocations,
otherwise it would get SIGILL on the first MTE instruction it tries to
execute.

> i'm not sure i see this new way for a kernel update to break my system
> and need to be fixed forward/rolled back as any different from any of
> the existing ways in which this can happen :-) as an end-user i have
> to rely on whoever's sending me software updates to test adequately
> enough that they find the problems. as an end user, there isn't any
> difference between "my phone rebooted when i tried to take a photo
> because of a kernel/driver leak", say, and "my phone rebooted when i
> tried to take a photo because of missing untagging of a pointer passed
> via ioctl".
> 
> i suspect you and i have very different people in mind when we say "user" :-)

Indeed, I think we have different users in mind. I didn't mean the end
user who doesn't really care which C library version it's running on
their phone but rather advanced users (not necessarily kernel
developers) that prefer to build their own kernels with every release.
We could extend this to kernel developers who don't have time to track
down why a new kernel triggers lots of SIGSEGVs during boot.

-- 
Catalin
