Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB62707A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfEVUEW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 16:04:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44409 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfEVTVa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 15:21:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1785572pgp.11
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2019 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NP4JWkHqbCIs5rs8MQbZ/rJv31PHu50+VP85AcMzbbU=;
        b=GFshwxVjgFyTBuVsTzhm7IUt1UjnhWPD0MinKNguPB3el83BFNud8bHr5plz3emii+
         cTc7Cjy2KfiVySMa4vl3S45MUDV6ughBv+eP5o9C9KIg6ntk97RzOYluREumaUsuEfOH
         SjJgP3hh0ohPvQPPbSdKkfRYeqkQoVWPqO5e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NP4JWkHqbCIs5rs8MQbZ/rJv31PHu50+VP85AcMzbbU=;
        b=FLZqkDZOy0fLgBef+tdcZW+cIw5LAWiQdimDD5oX0KswaX5i8Aap4EyW8/H9IlLwse
         nZLDqlhQ0iHrwSJUtBMt6eWc05px1BUb+1cqRWywNLonyjZk6y9WDCl7gFJJiqYMXFQw
         9efTton9qVigilDmXx5nNZjh/mEybdzm0CtLYhYS/QCz5F/Ytpp674HijB9iUh7T4PNo
         9lBijN4PeWO1W0V6wnCGNYfLjISE0Tyzm7jaKYw0Fdocp/fPuh9kqwYX609eoFxHQ2vy
         VRY4BJMTnnTHZ2ik0+FCW8j9ahv5tSIJcPOJGfbtNyvuhSWTjg5PLYfpbOcAETCeTLlX
         PLKg==
X-Gm-Message-State: APjAAAUNqTUUgUflNyKFDfhwWavxqinkQstD9Aes9Ey34PffWSuiXVmu
        as9HQOwaaO40+RQ00UYZP9NHFA==
X-Google-Smtp-Source: APXvYqzNjksdiGtBA2K0Yn7lD7hXz0a3WOc+KaCHe5Lfb///NUHl50P+zldmTZ4Tu8MFGQvOw+1qnw==
X-Received: by 2002:a62:6456:: with SMTP id y83mr32990581pfb.71.1558552889913;
        Wed, 22 May 2019 12:21:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10sm37135797pfj.136.2019.05.22.12.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 12:21:28 -0700 (PDT)
Date:   Wed, 22 May 2019 12:21:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     enh <enh@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <201905221157.A9BAB1F296@keescook>
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

Right -- things should Just Work from the application perspective.

> obviously i'm biased as a libc maintainer, but...
> 
> i don't think it helps to move this to libc --- now you just have an
> extra dependency where to have a guaranteed working system you need to
> update your kernel and libc together. (or at least update your libc to
> understand new ioctls etc _before_ you can update your kernel.)

I think (hope?) we've all agreed that we shouldn't pass this off to
userspace. At the very least, it reduces the utility of MTE, and at worst
it complicates userspace when this is clearly a kernel/architecture issue.

> 
> > > - malloc() starts returning MTE-tagged addresses
> > > - program doesn't break from that change
> > > - program uses some syscall that is missing untagged_addr() and fails
> > > - kernel has now broken userspace that used to work
> >
> > That's one aspect though probably more of a case of plugging in a new
> > device (graphics card, network etc.) and the ioctl to the new device
> > doesn't work.

I think MTE will likely be rather like NX/PXN and SMAP/PAN: there will
be glitches, and we can disable stuff either via CONFIG or (as is more
common now) via a kernel commandline with untagged_addr() containing a
static branch, etc. But I actually don't think we need to go this route
(see below...)

> > The other is that, assuming we reach a point where the kernel entirely
> > supports this relaxed ABI, can we guarantee that it won't break in the
> > future. Let's say some subsequent kernel change (some refactoring)
> > misses out an untagged_addr(). This renders a previously TBI/MTE-capable
> > syscall unusable. Can we rely only on testing?
> >
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

Right: the point is to design things so that we do our best to not break
userspace that is using the new feature (which I think this series has
done well). But supporting MTE/TBI is just like supporting PAN: if someone
refactors a driver and swaps a copy_from_user() to a memcpy(), it's going
to break under PAN. There will be the same long tail of these bugs like
any other, but my sense is that they are small and rare. But I agree:
they're going to be pretty weird bugs to track down. The final result,
however, will be excellent annotation in the kernel for where userspace
addresses get used and people make assumptions about them.

The sooner we get the series landed and gain QEMU support (or real
hardware), the faster we can hammer out these missed corner-cases.
What's the timeline for either of those things, BTW?

> > > I feel like I'm missing something about this being seen as an ABI
> > > break. The kernel already fails on userspace addresses that have high
> > > bits set -- are there things that _depend_ on this failure to operate?
> >
> > It's about providing a relaxed ABI which allows non-zero top byte and
> > breaking it later inadvertently without having something better in place
> > to analyse the kernel changes.

It sounds like the question is how to switch a process in or out of this
ABI (but I don't think that's the real issue: I think it's just a matter
of whether or not a process uses tags at all). Doing it at the prctl()
level doesn't make sense to me, except maybe to detect MTE support or
something. ("Should I tag allocations?") And that state is controlled
by the kernel: the kernel does it or it doesn't.

If a process wants to not tag, that's also up to the allocator where
it can decide not to ask the kernel, and just not tag. Nothing breaks in
userspace if a process is NOT tagging and untagged_addr() exists or is
missing. This, I think, is the core way this doesn't trip over the
golden rule: an old system image will run fine (because it's not
tagging). A *new* system may encounter bugs with tagging because it's a
new feature: this is The Way Of Things. But we don't break old userspace
because old userspace isn't using tags.

So the agreement appears to be between the kernel and the allocator.
Kernel says "I support this" or not. Telling the allocator to not tag if
something breaks sounds like an entirely userspace decision, yes?

-- 
Kees Cook
