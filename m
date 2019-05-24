Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CD528FE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 06:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfEXEXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 00:23:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46829 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEXEXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 00:23:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id a95so3023207uaa.13
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 21:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAYnRWw3Tu8/93j9I1Decyj4SiwalEXjnp8HjDGWVMk=;
        b=WnRK49CElZNooeneU/rmiXD4MNL+NGJ+1q+LoLrd8r1BWPG0vFLLn5srrzAwJdtZCr
         YNvRiKrpydE8yY/WwhILnly3Zvune3jCfbXw7GsuMvu4P+dyMtapEbIZ2jkKw+bAAaZT
         /NstjIQP+l4nVYqupG3KK3t/H/Zt2rSh8UshTl0ZeyMDpnbmZlbVjVV+q+S0iwZ4uNET
         wEULW4QLu8xXLGSpfqZElCLKOXZT2Zp/eFOfWYxNKR73Qs1kFKXoJK7Lexkh9qJC8nqp
         yZ2rrh8i3toWpfjsayQpALHrdDwRoiqV6AXbdW6lkKZym6fAr2YHiokI7QWgzJYQeySd
         EWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAYnRWw3Tu8/93j9I1Decyj4SiwalEXjnp8HjDGWVMk=;
        b=eqzo8bu7IsJkIahdLJzZ7S3RdcU8c/FK7/Q800+6Tls9XtxRlQok4a1a28Jq6xB43L
         YvaxBuKX+1hZ+kDCfbsn+fg2ToIyXJE7I3++TvGjuZLKzQR46EGW6PaANad/tFv55dIY
         908L5fFkUTUZd02Fc0DBf6yHwVVcqLU5jq8y4gJxlPYK6zRI3Y5biw4WKiJHDaxa5Yt1
         JvpxsayTlAKTsJoomlXtKdhH9zwrmEare1RTT3qWJUSuIgkv9QwIX39yZiX0N23LpW/k
         nNNoMHytYIZ+cB6KnuiDsbkTtYv6u5llXXuW+50oapMM7xYuVxnf/j4FWXEcY5JzaHw2
         GZaw==
X-Gm-Message-State: APjAAAXc9AuaWQiFpkRYbMZBKDnvA2UKq/BiFqoKg3Yr3N1iJgbW8iVo
        gpDJ2PpdQhoZzQ4ZhQ8ZY9e2rkHSKTTV1vVVJPjlHQ==
X-Google-Smtp-Source: APXvYqx5Zm1ZYEN7Vn9AdcFTjSw8M3oFO3UV+ZriQQ1V2wP6o6e1yzY7Ig//CYIK3KGeMPCh4oSMGn+kEBJ+ngdeAaM=
X-Received: by 2002:ab0:3109:: with SMTP id e9mr449008ual.66.1558671802883;
 Thu, 23 May 2019 21:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com> <00eb4c63fefc054e2c8d626e8fedfca11d7c2600.1557160186.git.andreyknvl@google.com>
 <20190522114910.emlckebwzv2qz42i@mbp> <CAFKCwrjyP+x0JJy=qpBFsp4pub3He6UkvU0qnf1UOKt6W1LPRQ@mail.gmail.com>
 <20190523090427.GA44383@arrakis.emea.arm.com>
In-Reply-To: <20190523090427.GA44383@arrakis.emea.arm.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Thu, 23 May 2019 21:23:13 -0700
Message-ID: <CAFKCwrgk0+yR48Z5nhuZG5f7g==vRb4u+CS-4FS0mM7Eriavgw@mail.gmail.com>
Subject: Re: [PATCH v15 05/17] arms64: untag user pointers passed to memory syscalls
To:     Catalin Marinas <catalin.marinas@arm.com>
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 2:04 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, May 22, 2019 at 02:16:57PM -0700, Evgenii Stepanov wrote:
> > On Wed, May 22, 2019 at 4:49 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, May 06, 2019 at 06:30:51PM +0200, Andrey Konovalov wrote:
> > > > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > > > pass tagged user pointers (with the top byte set to something else other
> > > > than 0x00) as syscall arguments.
> > > >
> > > > This patch allows tagged pointers to be passed to the following memory
> > > > syscalls: brk, get_mempolicy, madvise, mbind, mincore, mlock, mlock2,
> > > > mmap, mmap_pgoff, mprotect, mremap, msync, munlock, munmap,
> > > > remap_file_pages, shmat and shmdt.
> > > >
> > > > This is done by untagging pointers passed to these syscalls in the
> > > > prologues of their handlers.
> > >
> > > I'll go through them one by one to see if we can tighten the expected
> > > ABI while having the MTE in mind.
> > >
> > > > diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> > > > index b44065fb1616..933bb9f3d6ec 100644
> > > > --- a/arch/arm64/kernel/sys.c
> > > > +++ b/arch/arm64/kernel/sys.c
> > > > @@ -35,10 +35,33 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> > > >  {
> > > >       if (offset_in_page(off) != 0)
> > > >               return -EINVAL;
> > > > -
> > > > +     addr = untagged_addr(addr);
> > > >       return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> > > >  }
> > >
> > > If user passes a tagged pointer to mmap() and the address is honoured
> > > (or MAP_FIXED is given), what is the expected return pointer? Does it
> > > need to be tagged with the value from the hint?
> >
> > For HWASan the most convenient would be to use the tag from the hint.
> > But since in the TBI (not MTE) mode the kernel has no idea what
> > meaning userspace assigns to pointer tags, perhaps it should not try
> > to guess, and should return raw (zero-tagged) address instead.
>
> Then, just to relax the ABI for hwasan, shall we simply disallow tagged
> pointers on mmap() arguments? We can leave them in for
> mremap(old_address), madvise().

I think this would be fine. We should allow tagged in pointers in
mprotect though.

> > > With MTE, we may want to use this as a request for the default colour of
> > > the mapped pages (still under discussion).
> >
> > I like this - and in that case it would make sense to return the
> > pointer that can be immediately dereferenced without crashing the
> > process, i.e. with the matching tag.
>
> This came up from the Android investigation work where large memory
> allocations (using mmap) could be more efficiently pre-tagged by the
> kernel on page fault. Not sure about the implementation details yet.
>
> --
> Catalin
