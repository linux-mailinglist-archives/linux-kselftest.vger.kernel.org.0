Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4604C266F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfEVPah (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 11:30:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32954 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbfEVPag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 11:30:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so2537316ljw.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2019 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RM2Vs3BpRvxchuOeBY/wop/PzNSZzl64F2EeK+wEZZM=;
        b=YY6JA+LoUtjEOO757K58wra7rdXirZ4AlTHpmSQ+decwKFXSNcixrW+Od3xAIfHhzc
         E31pVzZHa1k0N1eBsu/pwx/4gJOY/Z23T1KlGxD+A3kg2G2nUjg2KBJXZgrs4NREuNVs
         TYlUYYtdAekOg5uSt0naDgODEcL0YeodFYzgZ2kMgQbeYv13wJLMpmBWE0SyYa3YKKBJ
         Ky8EOr/z31g0owz/7VlcdxKTQPp3/9K5jFnQ5GWfggZi2OZBL5soMXgy15fr5y5CKPxC
         m0te1S3imaMe8QwTNQlrTPoiVAA5L9886WXf4f0IGaQNg3NN+dFLYS9ofr5e9wU3GA29
         mQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RM2Vs3BpRvxchuOeBY/wop/PzNSZzl64F2EeK+wEZZM=;
        b=cKJUAG8lg2oeSWL4McArsqsE/6Wbg/sQMF9eLdsZyFu8VZU+0NK2Ga3e1MHzpimQo0
         Gc/E3xCl+p+4njhNJVRLlpkzLD0xeEBFsoL7BTx9qffvVeOawMUZ8iQqtSiTqUYpfmvJ
         yb1GTwqqJvp3lMuMQRuLnXIiGKkKLts6r2u5NzvKXkTnAKpMAlH3RpntY2TXAYdafC7L
         ecSXigsFUgMNT5Z1yZuAXM6y93Q4K4JGw/26g5lnDZ8snIOUHwM5WgiFou5V3rh8LZvn
         WEkY6ThohngXiDX3yzlm+eR8ivddRFYcnpQrdPmDoswzemeSTKREIU0E00KBFAAEILxE
         RwZA==
X-Gm-Message-State: APjAAAU2WTb29n8PToAnvL1M7EgjM4R29EfFzDDjCDVwgv2KuzoajK2H
        RmC9W4+oC0McUsB9q4pAV8JG/fHhT4LcAh+ZjoClig==
X-Google-Smtp-Source: APXvYqyXSCxhB+3RVGWUi2lXqAnCXVjRJMmGDtSQwaSdaunD3RrP1dCFavWCgkEVu7tMxmxxgJ5X4QeZFUMwuOfrpVg=
X-Received: by 2002:a2e:9601:: with SMTP id v1mr22163816ljh.60.1558539033496;
 Wed, 22 May 2019 08:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp> <201905211633.6C0BF0C2@keescook> <20190522101110.m2stmpaj7seezveq@mbp>
In-Reply-To: <20190522101110.m2stmpaj7seezveq@mbp>
From:   enh <enh@google.com>
Date:   Wed, 22 May 2019 08:30:21 -0700
Message-ID: <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 3:11 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Kees,
>
> Thanks for joining the thread ;).
>
> On Tue, May 21, 2019 at 05:04:39PM -0700, Kees Cook wrote:
> > On Tue, May 21, 2019 at 07:29:33PM +0100, Catalin Marinas wrote:
> > > On Mon, May 20, 2019 at 04:53:07PM -0700, Evgenii Stepanov wrote:
> > > > On Fri, May 17, 2019 at 7:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > IMO (RFC for now), I see two ways forward:
> > > > > [...]
> > > > > 2. Similar shim to the above libc wrapper but inside the kernel
> > > > >    (arch/arm64 only; most pointer arguments could be covered with an
> > > > >    __SC_CAST similar to the s390 one). There are two differences from
> > > > >    what we've discussed in the past:
> > > > >
> > > > >    a) this is an opt-in by the user which would have to explicitly call
> > > > >       prctl(). If it returns -ENOTSUPP etc., the user won't be allowed
> > > > >       to pass tagged pointers to the kernel. This would probably be the
> > > > >       responsibility of the C lib to make sure it doesn't tag heap
> > > > >       allocations. If the user did not opt-in, the syscalls are routed
> > > > >       through the normal path (no untagging address shim).
> > > > >
> > > > >    b) ioctl() and other blacklisted syscalls (prctl) will not accept
> > > > >       tagged pointers (to be documented in Vicenzo's ABI patches).
> > > >
> > > > The way I see it, a patch that breaks handling of tagged pointers is
> > > > not that different from, say, a patch that adds a wild pointer
> > > > dereference. Both are bugs; the difference is that (a) the former
> > > > breaks a relatively uncommon target and (b) it's arguably an easier
> > > > mistake to make. If MTE adoption goes well, (a) will not be the case
> > > > for long.
> > >
> > > It's also the fact such patch would go unnoticed for a long time until
> > > someone exercises that code path. And when they do, the user would be
> > > pretty much in the dark trying to figure what what went wrong, why a
> > > SIGSEGV or -EFAULT happened. What's worse, we can't even say we fixed
> > > all the places where it matters in the current kernel codebase (ignoring
> > > future patches).
> >
> > So, looking forward a bit, this isn't going to be an ARM-specific issue
> > for long.
>
> I do hope so.
>
> > In fact, I think we shouldn't have arm-specific syscall wrappers
> > in this series: I think untagged_addr() should likely be added at the
> > top-level and have it be a no-op for other architectures.
>
> That's what the current patchset does, so we have this as a starting
> point. Kostya raised another potential issue with the syscall wrappers:
> with MTE the kernel will be forced to enable the match-all (wildcard)
> pointers for user space accesses since copy_from_user() would only get a
> 0 tag. So it has wider implications than just uaccess routines not
> checking the colour.
>
> > So given this becoming a kernel-wide multi-architecture issue (under
> > the assumption that x86, RISC-V, and others will gain similar TBI or
> > MTE things), we should solve it in a way that we can re-use.
>
> Can we do any better to aid the untagged_addr() placement (e.g. better
> type annotations, better static analysis)? We have to distinguish
> between user pointers that may be dereferenced by the kernel (I think
> almost fully covered with this patchset) and user addresses represented
> as ulong that may:
>
> a) be converted to a user pointer and dereferenced; I think that's the
>    case for many overloaded ulong/u64 arguments
>
> b) used for address space management, rbtree look-ups etc. where the tag
>    is no longer relevant and it even gets in the way
>
> We tried last year to identify void __user * casts to unsigned long
> using sparse on the assumption that pointers can be tagged while ulong
> is about address space management and needs to lose such tag. I think we
> could have pushed this further. For example, get_user_pages() takes an
> unsigned long but it is perfectly capable of untagging the address
> itself. Shall we change its first argument to void __user * (together
> with all its callers)?
>
> find_vma(), OTOH, could untag the address but it doesn't help since
> vm_start/end don't have such information (that's more about the content
> or type that the user decided) and the callers check against it.
>
> Are there any other places where this matters? These patches tracked
> down find_vma() as some heuristics but we may need better static
> analysis to identify other cases.
>
> > We need something that is going to work everywhere. And it needs to be
> > supported by the kernel for the simple reason that the kernel needs to
> > do MTE checks during copy_from_user(): having that information stripped
> > means we lose any userspace-assigned MTE protections if they get handled
> > by the kernel, which is a total non-starter, IMO.
>
> Such feedback is welcomed ;).
>
> > As an aside: I think Sparc ADI support in Linux actually side-stepped
> > this[1] (i.e. chose "solution 1"): "All addresses passed to kernel must
> > be non-ADI tagged addresses." (And sadly, "Kernel does not enable ADI
> > for kernel code.") I think this was a mistake we should not repeat for
> > arm64 (we do seem to be at least in agreement about this, I think).
> >
> > [1] https://lore.kernel.org/patchwork/patch/654481/
>
> I tried to drag the SPARC guys into this discussion but without much
> success.
>
> > > > This is a bit of a chicken-and-egg problem. In a world where memory
> > > > allocators on one or several popular platforms generate pointers with
> > > > non-zero tags, any such breakage will be caught in testing.
> > > > Unfortunately to reach that state we need the kernel to start
> > > > accepting tagged pointers first, and then hold on for a couple of
> > > > years until userspace catches up.
> > >
> > > Would the kernel also catch up with providing a stable ABI? Because we
> > > have two moving targets.
> > >
> > > On one hand, you have Android or some Linux distro that stick to a
> > > stable kernel version for some time, so they have better chance of
> > > clearing most of the problems. On the other hand, we have mainline
> > > kernel that gets over 500K lines every release. As maintainer, I can't
> > > rely on my testing alone as this is on a limited number of platforms. So
> > > my concern is that every kernel release has a significant chance of
> > > breaking the ABI, unless we have a better way of identifying potential
> > > issues.
> >
> > I just want to make sure I fully understand your concern about this
> > being an ABI break, and I work best with examples. The closest situation
> > I can see would be:
> >
> > - some program has no idea about MTE
>
> Apart from some libraries like libc (and maybe those that handle
> specific device ioctls), I think most programs should have no idea about
> MTE. I wouldn't expect programmers to have to change their app just
> because we have a new feature that colours heap allocations.

obviously i'm biased as a libc maintainer, but...

i don't think it helps to move this to libc --- now you just have an
extra dependency where to have a guaranteed working system you need to
update your kernel and libc together. (or at least update your libc to
understand new ioctls etc _before_ you can update your kernel.)

> > - malloc() starts returning MTE-tagged addresses
> > - program doesn't break from that change
> > - program uses some syscall that is missing untagged_addr() and fails
> > - kernel has now broken userspace that used to work
>
> That's one aspect though probably more of a case of plugging in a new
> device (graphics card, network etc.) and the ioctl to the new device
> doesn't work.
>
> The other is that, assuming we reach a point where the kernel entirely
> supports this relaxed ABI, can we guarantee that it won't break in the
> future. Let's say some subsequent kernel change (some refactoring)
> misses out an untagged_addr(). This renders a previously TBI/MTE-capable
> syscall unusable. Can we rely only on testing?
>
> > The trouble I see with this is that it is largely theoretical and
> > requires part of userspace to collude to start using a new CPU feature
> > that tickles a bug in the kernel. As I understand the golden rule,
> > this is a bug in the kernel (a missed ioctl() or such) to be fixed,
> > not a global breaking of some userspace behavior.
>
> Yes, we should follow the rule that it's a kernel bug but it doesn't
> help the user that a newly installed kernel causes user space to no
> longer reach a prompt. Hence the proposal of an opt-in via personality
> (for MTE we would need an explicit opt-in by the user anyway since the
> top byte is no longer ignored but checked against the allocation tag).

but realistically would this actually get used in this way? or would
any given system either be MTE or non-MTE. in which case a kernel
configuration option would seem to make more sense. (because either
way, the hypothetical user basically needs to recompile the kernel to
get back on their feet. or all of userspace.)

i'm not sure i see this new way for a kernel update to break my system
and need to be fixed forward/rolled back as any different from any of
the existing ways in which this can happen :-) as an end-user i have
to rely on whoever's sending me software updates to test adequately
enough that they find the problems. as an end user, there isn't any
difference between "my phone rebooted when i tried to take a photo
because of a kernel/driver leak", say, and "my phone rebooted when i
tried to take a photo because of missing untagging of a pointer passed
via ioctl".

i suspect you and i have very different people in mind when we say "user" :-)

> > I feel like I'm missing something about this being seen as an ABI
> > break. The kernel already fails on userspace addresses that have high
> > bits set -- are there things that _depend_ on this failure to operate?
>
> It's about providing a relaxed ABI which allows non-zero top byte and
> breaking it later inadvertently without having something better in place
> to analyse the kernel changes.
>
> Thanks.
>
> --
> Catalin
