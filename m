Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713A0270AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEVUQM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 16:16:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45406 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfEVUQM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 16:16:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so3271169lja.12
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2019 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QfgGpfBPenuVTK4QBHqIOfbfu3mYm6801nPB6AtTbg=;
        b=efNzGroYusRAaEDsxj++TPJsvxks1eNated5nn5y7tlpjx/+YV4iarteHjAsgVRWyv
         qV1iM2jFkqeqVZ60hyGrgA+iKj9XLYoinAIbx9aKQGymsFhsi8sDNA4x7lKxk9I/yxf9
         zx43H2ftRI4hpAeLvUaCSFwSlmKo8BKAgAeCJSD9hxfs7RtSGY9pmt5vsnNtNJ56rv67
         jIGc/hrimcITUdfG9J7ly3HBYArn3SKohhDYcSqAbppqL0mNbFyjlLDnYeaHM9uonO4O
         ufZRlzizHiSyf/pfX51aVvjz0xzqbcySuny4AVjp7wVtb4QBwDkwZrZ0z/Q3p7onR8yt
         etJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QfgGpfBPenuVTK4QBHqIOfbfu3mYm6801nPB6AtTbg=;
        b=N15SSsjI7aybrmKHRIAw4kEkWX3XbvSRao3py3RnaHotV+dC37k5T4JsWXUDCviK+Y
         EVy9uP8Kz+uAaWEIxqtkAnyvabKQKr7gWbEo7vtoE1P82RmfHW5mm2TjXfws23WWRXOo
         e5DE+Mb6/YwoFM96AoSYKrREKjRPJWJYJ/Z0E8x3nLNCb1qtgQf8dGLwzzTKt/CJ5MPS
         WHxc4XJgqPWE64emYtO91J4+AMP2lfGmHN1on7J0wdrwUm1/iXJv7xLUGjlGJCP2Yi5b
         sAW4ftdpAjPcjJAZRsz8D0sUGhJ3bxHXSsl+ptYbKyHSEI2iuOOUN/nFNTlmgpTJ5sSW
         aBOg==
X-Gm-Message-State: APjAAAW2ePZvc8wdg9ZvIMm3dR4b27DdnS2c9z8xZPO/j0GxLLRvxqUu
        hNuLK8DebIsOAnOcqpe5SAsYeTJcY0HwK0WbbIRS2Q==
X-Google-Smtp-Source: APXvYqygGa8rtRNIFjzwi6ULooCIPc9lOrOSeVX/ax8A+QrN8e39fSC+EkrWuLWAGu39QnHtsT9z6aUFsbTAkajmkCU=
X-Received: by 2002:a2e:9d4e:: with SMTP id y14mr20404646ljj.199.1558556169212;
 Wed, 22 May 2019 13:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp> <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp> <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
 <201905221157.A9BAB1F296@keescook>
In-Reply-To: <201905221157.A9BAB1F296@keescook>
From:   enh <enh@google.com>
Date:   Wed, 22 May 2019 13:15:57 -0700
Message-ID: <CAJgzZooRCx5MFL8dWuG8VaV=esYBADji7-L49fMeQa6niieWnw@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 12:21 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, May 22, 2019 at 08:30:21AM -0700, enh wrote:
> > On Wed, May 22, 2019 at 3:11 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Tue, May 21, 2019 at 05:04:39PM -0700, Kees Cook wrote:
> > > > I just want to make sure I fully understand your concern about this
> > > > being an ABI break, and I work best with examples. The closest situation
> > > > I can see would be:
> > > >
> > > > - some program has no idea about MTE
> > >
> > > Apart from some libraries like libc (and maybe those that handle
> > > specific device ioctls), I think most programs should have no idea about
> > > MTE. I wouldn't expect programmers to have to change their app just
> > > because we have a new feature that colours heap allocations.
>
> Right -- things should Just Work from the application perspective.
>
> > obviously i'm biased as a libc maintainer, but...
> >
> > i don't think it helps to move this to libc --- now you just have an
> > extra dependency where to have a guaranteed working system you need to
> > update your kernel and libc together. (or at least update your libc to
> > understand new ioctls etc _before_ you can update your kernel.)
>
> I think (hope?) we've all agreed that we shouldn't pass this off to
> userspace. At the very least, it reduces the utility of MTE, and at worst
> it complicates userspace when this is clearly a kernel/architecture issue.
>
> >
> > > > - malloc() starts returning MTE-tagged addresses
> > > > - program doesn't break from that change
> > > > - program uses some syscall that is missing untagged_addr() and fails
> > > > - kernel has now broken userspace that used to work
> > >
> > > That's one aspect though probably more of a case of plugging in a new
> > > device (graphics card, network etc.) and the ioctl to the new device
> > > doesn't work.
>
> I think MTE will likely be rather like NX/PXN and SMAP/PAN: there will
> be glitches, and we can disable stuff either via CONFIG or (as is more
> common now) via a kernel commandline with untagged_addr() containing a
> static branch, etc. But I actually don't think we need to go this route
> (see below...)
>
> > > The other is that, assuming we reach a point where the kernel entirely
> > > supports this relaxed ABI, can we guarantee that it won't break in the
> > > future. Let's say some subsequent kernel change (some refactoring)
> > > misses out an untagged_addr(). This renders a previously TBI/MTE-capable
> > > syscall unusable. Can we rely only on testing?
> > >
> > > > The trouble I see with this is that it is largely theoretical and
> > > > requires part of userspace to collude to start using a new CPU feature
> > > > that tickles a bug in the kernel. As I understand the golden rule,
> > > > this is a bug in the kernel (a missed ioctl() or such) to be fixed,
> > > > not a global breaking of some userspace behavior.
> > >
> > > Yes, we should follow the rule that it's a kernel bug but it doesn't
> > > help the user that a newly installed kernel causes user space to no
> > > longer reach a prompt. Hence the proposal of an opt-in via personality
> > > (for MTE we would need an explicit opt-in by the user anyway since the
> > > top byte is no longer ignored but checked against the allocation tag).
> >
> > but realistically would this actually get used in this way? or would
> > any given system either be MTE or non-MTE. in which case a kernel
> > configuration option would seem to make more sense. (because either
> > way, the hypothetical user basically needs to recompile the kernel to
> > get back on their feet. or all of userspace.)
>
> Right: the point is to design things so that we do our best to not break
> userspace that is using the new feature (which I think this series has
> done well). But supporting MTE/TBI is just like supporting PAN: if someone
> refactors a driver and swaps a copy_from_user() to a memcpy(), it's going
> to break under PAN. There will be the same long tail of these bugs like
> any other, but my sense is that they are small and rare. But I agree:
> they're going to be pretty weird bugs to track down. The final result,
> however, will be excellent annotation in the kernel for where userspace
> addresses get used and people make assumptions about them.
>
> The sooner we get the series landed and gain QEMU support (or real
> hardware), the faster we can hammer out these missed corner-cases.
> What's the timeline for either of those things, BTW?
>
> > > > I feel like I'm missing something about this being seen as an ABI
> > > > break. The kernel already fails on userspace addresses that have high
> > > > bits set -- are there things that _depend_ on this failure to operate?
> > >
> > > It's about providing a relaxed ABI which allows non-zero top byte and
> > > breaking it later inadvertently without having something better in place
> > > to analyse the kernel changes.
>
> It sounds like the question is how to switch a process in or out of this
> ABI (but I don't think that's the real issue: I think it's just a matter
> of whether or not a process uses tags at all). Doing it at the prctl()
> level doesn't make sense to me, except maybe to detect MTE support or
> something. ("Should I tag allocations?") And that state is controlled
> by the kernel: the kernel does it or it doesn't.
>
> If a process wants to not tag, that's also up to the allocator where
> it can decide not to ask the kernel, and just not tag. Nothing breaks in
> userspace if a process is NOT tagging and untagged_addr() exists or is
> missing. This, I think, is the core way this doesn't trip over the
> golden rule: an old system image will run fine (because it's not
> tagging). A *new* system may encounter bugs with tagging because it's a
> new feature: this is The Way Of Things. But we don't break old userspace
> because old userspace isn't using tags.
>
> So the agreement appears to be between the kernel and the allocator.
> Kernel says "I support this" or not. Telling the allocator to not tag if
> something breaks sounds like an entirely userspace decision, yes?

sgtm, and the AT_FLAGS suggestion sounds fine for our needs in that regard.

> --
> Kees Cook
