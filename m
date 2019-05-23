Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC1283EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfEWQiZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 12:38:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43118 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfEWQiW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 12:38:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn7so2961709plb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lscewINPN3hq/l0Swcavzj6U0JCykRwN+VKQYmeGavk=;
        b=MzIBf/cg8HqX7LDHDmH3NduBH/GNHyk36BoEHjmaEfwdA0mOkdLBAg0EUXF7biIGPX
         1D7AzOrIM750xRnkubOq1jGRkMcjIZjIYf+kPatHpylhUSqCQfdwGLTrWn4J8esTRBLk
         Xcvmw1TY3lT5og+Fj9TWzv82uZX9wel5U8qi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lscewINPN3hq/l0Swcavzj6U0JCykRwN+VKQYmeGavk=;
        b=oaTN04zUvMHNI5ceJBYzgmNkJLqkWFmjOniLD14ECThj6ynrwM4exObcxUZ3X9Fla4
         mTwXfXuahNLBpROOG2ttc55cpe3XWRBat3nWjUojiTU+bv6+neazN4lsdYc4aWp+b4fO
         XrRH3uKsCQiT+yffMnwWpSn6MU/p0ymjcYD2BTwzv1nZDZ2ofMVATlN4e7nfoZPsyfNz
         66Vk8krd1SmNLvBVhJImCBwZN9zJS17Fjx4vPy7ETEPsmoU8g/ntgzLXkUGnMeDoajTa
         7P/ZL55nZAQUaDWZ/jf/anUdR0atZ3xZ9Rr/eZy0aw92NM/vP6Ltj2wqd0QB+/W8JcMq
         lF+g==
X-Gm-Message-State: APjAAAXgdKNhKjC/997PNoVf1KC/OEhylNU000iDNJ/j+MuvZxpDY4Pa
        J7ySb6gLp7lg2N0dWgnRYnVVJQ==
X-Google-Smtp-Source: APXvYqzxDNUT+zQ+3IUTM4Pfo29z2ussIuDSTH+Mz2tPZncaJ19KDxQ7w12Ra519k713lyeCzNKlsQ==
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr17743251plb.189.1558629502290;
        Thu, 23 May 2019 09:38:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19sm56536684pgj.75.2019.05.23.09.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 09:38:21 -0700 (PDT)
Date:   Thu, 23 May 2019 09:38:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <201905230917.DEE7A75EF0@keescook>
References: <cover.1557160186.git.andreyknvl@google.com>
 <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp>
 <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp>
 <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
 <20190522163527.rnnc6t4tll7tk5zw@mbp>
 <201905221316.865581CF@keescook>
 <20190523144449.waam2mkyzhjpqpur@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523144449.waam2mkyzhjpqpur@mbp>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 03:44:49PM +0100, Catalin Marinas wrote:
> There is also the obvious requirement which I didn't mention: new user
> space continues to run on new/subsequent kernel versions. That's one of
> the points of contention for this series (ignoring MTE) with the
> maintainers having to guarantee this without much effort. IOW, do the
> 500K+ new lines in a subsequent kernel version break any user space out
> there? I'm only talking about the relaxed TBI ABI. Are the usual LTP,
> syskaller sufficient? Better static analysis would definitely help.

We can't have perfect coverage of people actively (or accidentally)
working to trick static analyzers (and the compiler) into "forgetting"
about a __user annotation. We can certainly improve analysis (I see
the other sub-thread on that), but I'd like that work not to block
this series.

What on this front would you be comfortable with? Given it's a new
feature isn't it sufficient to have a CONFIG (and/or boot option)?

> Or, if we ever want MTE to be turned on by default (i.e. tag checking),
> even if everything is tagged with 0, we have to disallow TBI for user
> and this includes hwasan. There were a small number of programs using
> the TBI (I think some JavaScript compilers tried this). But now we are
> bringing in the hwasan support and this can be a large user base. Shall
> we add an ELF note for such binaries that use TBI/hwasan?

Just to be clear, you say "disallow TBI for user" -- you mean a
particular process, yes? i.e. there is no architectural limitation that
says once we're using MTE nothing can switch to TBI. i.e. a process is
either doing MTE or TBI (or nothing, but that's the same as TBI).

> This needs solving as well. Most driver developers won't know why
> untagged_addr() is needed unless we have more rigorous types or type
> annotations and a tool to check them (we should probably revive the old
> sparse thread).

This seems like a parallel concern: we can do that separately from this
series. Without landing it, is it much harder for people to test it,
look for bugs, help with types/annotations, etc.

> > So there needs to be some way to let the kernel know which of three
> > things it should be doing:
> > 1- leaving userspace addresses as-is (present)
> > 2- wiping the top bits before using (this series)
> 
> (I'd say tolerating rather than wiping since get_user still uses the tag
> in the current series)
> 
> The current series does not allow any choice between 1 and 2, the
> default ABI basically becomes option 2.

What about testing tools that intentionally insert high bits for syscalls
and are _expecting_ them to fail? It seems the TBI series will break them?
In that case, do we need to opt into TBI as well?

> > 3- wiping the top bits for most things, but retaining them for MTE as
> >    needed (the future)
> 
> 2 and 3 are not entirely compatible as a tagged pointer may be checked
> against the memory colour by the hardware. So you can't have hwasan
> binary with MTE enabled.

Right: a process must be either MTE or TBI, not both.

> > I expect MTE to be the "default" in the future. Once a system's libc has
> > grown support for it, everything will be trying to use MTE. TBI will be
> > the special case (but TBI is effectively a prerequisite).
> 
> The kernel handling of tagged pointers is indeed a prerequisite. The ABI
> distinction between the above 2 and 3 needs to be solved.

Does that need solving now or when the MTE series appears? As there is
no reason to distinguish between "normal" and "TBI", that doesn't seem
to need solving at this point?

> > AFAICT, the only difference I see between 2 and 3 will be the tag handling
> > in usercopy (all other places will continue to ignore the top bits). Is
> > that accurate?
> 
> Yes, mostly (for the kernel). If MTE is enabled by default for a hwasan
> binary, it will SEGFAULT (either in user space or in kernel uaccess).
> How does the kernel choose between 2 and 3?

Right -- that was my question as well.

> > Is "1" a per-process state we want to keep? (I assume not, but rather it
> > is available via no TBI/MTE CONFIG or a boot-time option, if at all?)
> 
> Possibly, though not necessarily per process. For testing or if
> something goes wrong during boot, a command line option with a static
> label would do. The AT_FLAGS bit needs to be checked by user space. My
> preference would be per-process.

I would agree.

> > To choose between "2" and "3", it seems we need a per-process flag to
> > opt into TBI (and out of MTE).
> 
> Or leave option 2 the default and get it to opt in to MTE.

Given that MTE has to "start" at some point in the binary lifetime, I'm
fine with opting into MTE. I do expect, though, this will feel redundant
in a couple years as everything will immediately opt-in. But, okay, this
is therefore an issue for the MTE series.

> The current plan is that a future binary issues a prctl(), after
> checking the HWCAP_MTE bit (as I replied to Elliot, the MTE instructions
> are not in the current NOP space). I'd expect this to be done by the
> libc or dynamic loader under the assumption that the binaries it loads
> do _not_ use the top pointer byte for anything else. With hwasan
> compiled objects this gets more confusing (any ELF note to identify
> them?).

Okay, sounds fine.

> (there is also the risk of existing applications using TBI already but
> I'm not aware of any still using this feature other than hwasan)

Correct.


Alright, the tl;dr appears to be:
- you want more assurances that we can find __user stripping in the
  kernel more easily. (But this seems like a parallel problem.)
- we might need to opt in to TBI with a prctl()
- all other concerns are for the future MTE series (though it sounds
  like HWCAP_MTE and a prctl() solve those issues too).

Is this accurate? What do you see as the blockers for this series at
this point?

-- 
Kees Cook
