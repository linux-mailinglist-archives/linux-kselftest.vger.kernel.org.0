Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D994825793
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfEUS3n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 14:29:43 -0400
Received: from foss.arm.com ([217.140.101.70]:39894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfEUS3n (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 14:29:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE4F80D;
        Tue, 21 May 2019 11:29:42 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 294B83F5AF;
        Tue, 21 May 2019 11:29:36 -0700 (PDT)
Date:   Tue, 21 May 2019 19:29:33 +0100
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elliott Hughes <enh@google.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190521182932.sm4vxweuwo5ermyd@mbp>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 20, 2019 at 04:53:07PM -0700, Evgenii Stepanov wrote:
> On Fri, May 17, 2019 at 7:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > IMO (RFC for now), I see two ways forward:
> >
> > 1. Make this a user space problem and do not allow tagged pointers into
> >    the syscall ABI. A libc wrapper would have to convert structures,
> >    parameters before passing them into the kernel. Note that we can
> >    still support the hardware MTE in the kernel by enabling tagged
> >    memory ranges, saving/restoring tags etc. but not allowing tagged
> >    addresses at the syscall boundary.
> >
> > 2. Similar shim to the above libc wrapper but inside the kernel
> >    (arch/arm64 only; most pointer arguments could be covered with an
> >    __SC_CAST similar to the s390 one). There are two differences from
> >    what we've discussed in the past:
> >
> >    a) this is an opt-in by the user which would have to explicitly call
> >       prctl(). If it returns -ENOTSUPP etc., the user won't be allowed
> >       to pass tagged pointers to the kernel. This would probably be the
> >       responsibility of the C lib to make sure it doesn't tag heap
> >       allocations. If the user did not opt-in, the syscalls are routed
> >       through the normal path (no untagging address shim).
> >
> >    b) ioctl() and other blacklisted syscalls (prctl) will not accept
> >       tagged pointers (to be documented in Vicenzo's ABI patches).
[...]
> Any userspace shim approach is problematic for Android because of the
> apps that use raw system calls. AFAIK, all apps written in Go are in
> that camp - I'm not sure how common they are, but getting them all
> recompiled is probably not realistic.

That's a fair point (I wasn't expecting it would get much traction
anyway ;)). OTOH, it allows upstreaming of the MTE patches while we
continue the discussions around TBI.

> The way I see it, a patch that breaks handling of tagged pointers is
> not that different from, say, a patch that adds a wild pointer
> dereference. Both are bugs; the difference is that (a) the former
> breaks a relatively uncommon target and (b) it's arguably an easier
> mistake to make. If MTE adoption goes well, (a) will not be the case
> for long.

It's also the fact such patch would go unnoticed for a long time until
someone exercises that code path. And when they do, the user would be
pretty much in the dark trying to figure what what went wrong, why a
SIGSEGV or -EFAULT happened. What's worse, we can't even say we fixed
all the places where it matters in the current kernel codebase (ignoring
future patches).

I think we should revisit the static checking discussions we had last
year. Run-time checking (even with compiler instrumentation and
syzkaller fuzzing) would only cover the code paths specific to a Linux
or Android installation.

> This is a bit of a chicken-and-egg problem. In a world where memory
> allocators on one or several popular platforms generate pointers with
> non-zero tags, any such breakage will be caught in testing.
> Unfortunately to reach that state we need the kernel to start
> accepting tagged pointers first, and then hold on for a couple of
> years until userspace catches up.

Would the kernel also catch up with providing a stable ABI? Because we
have two moving targets.

On one hand, you have Android or some Linux distro that stick to a
stable kernel version for some time, so they have better chance of
clearing most of the problems. On the other hand, we have mainline
kernel that gets over 500K lines every release. As maintainer, I can't
rely on my testing alone as this is on a limited number of platforms. So
my concern is that every kernel release has a significant chance of
breaking the ABI, unless we have a better way of identifying potential
issues.

> Perhaps we can start by whitelisting ioctls by driver?

This was also raised by Ruben in private but without a (static) tool to
to check, manually going through all the drivers doesn't scale. It's
very likely that most drivers don't care, just a get_user/put_user is
already handled by these patches. Searching for find_vma() was
identifying one such use-case but is this sufficient? Are there other
cases we need to explicitly untag a pointer?


The other point I'd like feedback on is 2.a above. I see _some_ value
into having the user opt-in to this relaxed ABI rather than blinding
exposing it to all applications. Dave suggested (in private) a new
personality (e.g. PER_LINUX_TBI) inherited by children. It would be the
responsibility of the C library to check the current personality bits
and only tag pointers on allocation *if* the kernel allowed it. The
kernel could provide the AT_FLAGS bit as in Vincenzo's patches if the
personality was set but can't set it retrospectively if the user called
sys_personality. By default, /sbin/init would not have this personality
and libc would not tag pointers, so we can guarantee that your distro
boots normally with a new kernel version. We could have an envp that
gets caught by /sbin/init so you can pass it on the kernel command line
(or a dynamic loader at run-time). But the default should be the current
ABI behaviour.

We can enforce the current behaviour by having access_ok() check the
personality or a TIF flag but we may relax this enforcement at some
point in the future as we learn more about the implications of TBI.

Thanks.

-- 
Catalin
