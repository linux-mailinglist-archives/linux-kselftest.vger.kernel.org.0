Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C5425B01
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 02:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEVAEn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 20:04:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44327 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVAEn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 20:04:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so307301pgp.11
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2019 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h+HMpjJbOByDkcgcmqTFcjwM/Zjfkc20s8NGwt76Mr8=;
        b=Zf9QLE33qmPluiR2OGF4dL2quucaUAVgN4YPizfJiTzAzfLxxGI5FlE9xizVc831A4
         PZROfhtKhT/R7pMFQlHGrknlILzZeG3LHD5gyBNKzIo1iuXRcoC6OuM/wsNOYEBlL6Lp
         KGXm5hniO64celTxThJARG41BLIiM0pmyycsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h+HMpjJbOByDkcgcmqTFcjwM/Zjfkc20s8NGwt76Mr8=;
        b=qJSOVQfqq5keLoKqRSS8zkf4ZmK9RZPRQ6tOAlC+y/Uk8Sfy34T2z+imQxFipyUC/D
         cCzZy18oyFvoont13L7yvosTfQ6nBWaZ6kjyPGSS/WrUrTyPGN5NyCUllrKOAjjfz9Zd
         VH60KGkYVkcGXCtJKtsQaSwd8AwuqdDnL5fibwNHzvbe17zaUwM0P1xkmw7aaGkFRDKa
         hs+gEMbQH4NITYiMtsp6PHdbT0QLDlewQrERTibQ7+SSHZyvfvnQCuBQgA5QiCVq6XHJ
         epg0PKqbUiqS0HFHL+sExt0I9fI6pg3NqwTBErzWvMVIjVYFwmGQi4SYLdZQCZ/9iPn8
         Gc7A==
X-Gm-Message-State: APjAAAXUbhe1MkIkGOBNs6bFgydvns9Tkecb6dW49v+5BvDcLwIaNwmd
        fe/tbbAYgbvzUaaO3lJD4mRRlg==
X-Google-Smtp-Source: APXvYqyRHlp4k1ARvHRDx6pnXWJEks1ZEDsNIbDRibBeuJSxc6NZrbRUP3gWhA9hXypH8RUrMs25NQ==
X-Received: by 2002:a63:8dc8:: with SMTP id z191mr87505404pgd.9.1558483482349;
        Tue, 21 May 2019 17:04:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a11sm15675685pff.128.2019.05.21.17.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 17:04:40 -0700 (PDT)
Date:   Tue, 21 May 2019 17:04:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elliott Hughes <enh@google.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <201905211633.6C0BF0C2@keescook>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521182932.sm4vxweuwo5ermyd@mbp>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 21, 2019 at 07:29:33PM +0100, Catalin Marinas wrote:
> On Mon, May 20, 2019 at 04:53:07PM -0700, Evgenii Stepanov wrote:
> > On Fri, May 17, 2019 at 7:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > IMO (RFC for now), I see two ways forward:
> > > [...]
> > > 2. Similar shim to the above libc wrapper but inside the kernel
> > >    (arch/arm64 only; most pointer arguments could be covered with an
> > >    __SC_CAST similar to the s390 one). There are two differences from
> > >    what we've discussed in the past:
> > >
> > >    a) this is an opt-in by the user which would have to explicitly call
> > >       prctl(). If it returns -ENOTSUPP etc., the user won't be allowed
> > >       to pass tagged pointers to the kernel. This would probably be the
> > >       responsibility of the C lib to make sure it doesn't tag heap
> > >       allocations. If the user did not opt-in, the syscalls are routed
> > >       through the normal path (no untagging address shim).
> > >
> > >    b) ioctl() and other blacklisted syscalls (prctl) will not accept
> > >       tagged pointers (to be documented in Vicenzo's ABI patches).
> >
> > The way I see it, a patch that breaks handling of tagged pointers is
> > not that different from, say, a patch that adds a wild pointer
> > dereference. Both are bugs; the difference is that (a) the former
> > breaks a relatively uncommon target and (b) it's arguably an easier
> > mistake to make. If MTE adoption goes well, (a) will not be the case
> > for long.
> 
> It's also the fact such patch would go unnoticed for a long time until
> someone exercises that code path. And when they do, the user would be
> pretty much in the dark trying to figure what what went wrong, why a
> SIGSEGV or -EFAULT happened. What's worse, we can't even say we fixed
> all the places where it matters in the current kernel codebase (ignoring
> future patches).

So, looking forward a bit, this isn't going to be an ARM-specific issue
for long. In fact, I think we shouldn't have arm-specific syscall wrappers
in this series: I think untagged_addr() should likely be added at the
top-level and have it be a no-op for other architectures. So given this
becoming a kernel-wide multi-architecture issue (under the assumption
that x86, RISC-V, and others will gain similar TBI or MTE things),
we should solve it in a way that we can re-use.

We need something that is going to work everywhere. And it needs to be
supported by the kernel for the simple reason that the kernel needs to
do MTE checks during copy_from_user(): having that information stripped
means we lose any userspace-assigned MTE protections if they get handled
by the kernel, which is a total non-starter, IMO.

As an aside: I think Sparc ADI support in Linux actually side-stepped
this[1] (i.e. chose "solution 1"): "All addresses passed to kernel must
be non-ADI tagged addresses." (And sadly, "Kernel does not enable ADI
for kernel code.") I think this was a mistake we should not repeat for
arm64 (we do seem to be at least in agreement about this, I think).

[1] https://lore.kernel.org/patchwork/patch/654481/

> > This is a bit of a chicken-and-egg problem. In a world where memory
> > allocators on one or several popular platforms generate pointers with
> > non-zero tags, any such breakage will be caught in testing.
> > Unfortunately to reach that state we need the kernel to start
> > accepting tagged pointers first, and then hold on for a couple of
> > years until userspace catches up.
> 
> Would the kernel also catch up with providing a stable ABI? Because we
> have two moving targets.
> 
> On one hand, you have Android or some Linux distro that stick to a
> stable kernel version for some time, so they have better chance of
> clearing most of the problems. On the other hand, we have mainline
> kernel that gets over 500K lines every release. As maintainer, I can't
> rely on my testing alone as this is on a limited number of platforms. So
> my concern is that every kernel release has a significant chance of
> breaking the ABI, unless we have a better way of identifying potential
> issues.

I just want to make sure I fully understand your concern about this
being an ABI break, and I work best with examples. The closest situation
I can see would be:

- some program has no idea about MTE
- malloc() starts returning MTE-tagged addresses
- program doesn't break from that change
- program uses some syscall that is missing untagged_addr() and fails
- kernel has now broken userspace that used to work

The trouble I see with this is that it is largely theoretical and
requires part of userspace to collude to start using a new CPU feature
that tickles a bug in the kernel. As I understand the golden rule,
this is a bug in the kernel (a missed ioctl() or such) to be fixed,
not a global breaking of some userspace behavior.

I feel like I'm missing something about this being seen as an ABI
break. The kernel already fails on userspace addresses that have high
bits set -- are there things that _depend_ on this failure to operate?

-- 
Kees Cook
