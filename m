Return-Path: <linux-kselftest+bounces-3480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A810A83B231
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53CDB2EBE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79B132C20;
	Wed, 24 Jan 2024 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="8eGYLoF5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC9132C07;
	Wed, 24 Jan 2024 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123885; cv=none; b=jXmpfKT7/nsyn2ZFBTGYqqr7LVqRKLAYkRyAimBOZsMORftZ1PJJHc/Z4Or5sfL+NuIB2DjeEhODUSngKqsSlZxQwlOE4O5NZr2ihU1OM4BK874X98K6TYFKIX7YV+nRFqoiSZQhOhYsSK6foCLbDJNlhGoSHtdSw+htiPqti9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123885; c=relaxed/simple;
	bh=ReYkUQG85kGHUHFtNFQl5xEK393GXYEVdMweirQJr0U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=pdjXlkJ+kIm86UixVhxSUy7/8i1yiGPlOGc+TrOSLOf+czdblyoDmSG9uKboRycl/vuhUt0cuTVztx6Cg2atxKMK8XDGnSrt0CBQ7aTowXcobklOXQsMjci5exUsYzxF6aSfcBHXWbRFbDNaOzyzoDEQOLZD60SgNKSiaxM+xUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=8eGYLoF5; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=ReYkUQG85k
	GHUHFtNFQl5xEK393GXYEVdMweirQJr0U=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=8eGYLoF51oSLNz47nVjX2lYWbixsRNTU3
	B95QGBDHDK7GpVzhWJLtDEosQLjHa4hyIier8N4pj/6FFhc1V0Y+fVO7XNS0ljpdJHzr3X
	x7gf0/FK1AUVi69SM3Jz5VEmR6LvN2X7lAt7aqz+f2N8uy+00bZjZ1tmdUjLZTEsGg4cda
	9Go6/2Qwh3AKZOv4sewMfMYIFV2Ptf/9pptsehb0b2gXrjzzFSAarpleN2w5nyrW2qVrRs
	xdMVaGo1TwCpH67kKBkKiLmFB9w4DxHq4IjT4n+9jQNHdGnjyAXrO7oNIT+7AcsEjHoVpq
	FelOaohIR6w1q5jTX+ZeQHvLtNWBw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id b7887865;
	Wed, 24 Jan 2024 12:17:56 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
    sroettger@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
    jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Introduce mseal()
In-reply-to: <CABi2SkXrMC_8Ew7uA=Tufyy1YJObkrFJWbJtZuONCw5XHv2LYQ@mail.gmail.com>
References: <20240122152905.2220849-1-jeffxu@chromium.org> <726.1705938579@cvs.openbsd.org> <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com> <86181.1705962897@cvs.openbsd.org> <CABi2SkXrMC_8Ew7uA=Tufyy1YJObkrFJWbJtZuONCw5XHv2LYQ@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Wed, 24 Jan 2024 10:55:39 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84351.1706123876.1@cvs.openbsd.org>
Date: Wed, 24 Jan 2024 12:17:56 -0700
Message-ID: <54500.1706123876@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> > I don't have a feeling about it.
> >
> > I spent a year engineering a complete system which exercises the maximum
> > amount of memory you can lock.
> >
> > I saw nothing like what you are describing.  I had PROT_IMMUTABLE in my
> > drafts, and saw it turning into a dangerous anti-pattern.
> >
> I'm sorry, I have never looked at one line of openBSD code, prototype
> or not, nor did I install openBSD before.

That is really disingeneous.

It is obvious to everyone that mseal is a derivative of the mimmutable
mechanism, the raw idea stems directly from this and you didn't need to
stay at a Holiday Express Inn.

> Because of this situation on my side, I failed to understand why you
> have such a strong opinion on PROC_SEAL in mmap() in linux kernel,
> based on your own OpenBSD's experience ?

Portable and compatible interfaces are good.

Historically, incompatible interfaces are less good.

> For PROT_SEAL in mmap(), I see it as a good and reasonable suggestion
> raised during the RFC process, and incorporate it into the patch set,
> there is nothing more and nothing less.

Yet, you and those who suggested it don't have a single line of userland
code ready which will use this.
 
> If openBSD doesn't want it, that is fine to me, it is not that I'm
> trying to force this into openBSD's kernel, I understand it is a
> different code base.

This has nothing to do with code base.

It is about attempting to decrease differences between systems; this
approach which has always been valuable.

Divergence has always been painful.

> > > > OpenBSD now uses this for a high percent of the address space.  It might
> > > > be worth re-reading a description of the split of responsibility regarding
> > > > who locks different types of memory in a process;
> > > > - kernel (the majority, based upon what ELF layout tell us),
> > > > - shared library linker (the next majority, dealing with shared
> > > >   library mappings and left-overs not determinable at kernel time),
> > > > - libc (a small minority, mostly regarding forced mutable objects)
> > > > - and the applications themselves (only 1 application today)
> > > >
> > > >     https://lwn.net/Articles/915662/
> > > >
> > > > > The MAP_SEALABLE bit in the flags field of mmap(). When present, it marks
> > > > > the map as sealable. A map created without MAP_SEALABLE will not support
> > > > > sealing, i.e. mseal() will fail.
> > > >
> > > > We definately won't be doing this.  We allow a process to lock any and all
> > > > it's memory that isn't locked already, even if it means it is shooting
> > > > itself in the foot.
> > > >
> > > > I think you are going to severely hurt the power of this mechanism,
> > > > because you won't be able to lock memory that has been allocated by a
> > > > different callsite not under your source-code control which lacks the
> > > > MAP_SEALABLE flag.  (Which is extremely common with the system-parts of
> > > > a process, meaning not just libc but kernel allocated objects).
> > > >
> > > MAP_SEALABLE was an open discussion item called out on V3 [2] and V4 [3].
> > >
> > > I acknowledge that additional coordination would be required if
> > > mapping were to be allocated by one software component and sealed in
> > > another. However, this is feasible.
> > >
> > > Considering the side effect of not having this flag (as discussed in
> > > V3/V4) and the significant implications of altering the lifetime of
> > > the mapping (since unmapping would not be possible), I believe it is
> > > reasonable to expect developers to exercise additional care and
> > > caution when utilizing memory sealing.
> > >
> > > [2] https://lore.kernel.org/linux-mm/20231212231706.2680890-2-jeffxu@chromium.org/
> > > [3] https://lore.kernel.org/all/20240104185138.169307-1-jeffxu@chromium.org/
> >
> > I disagree *strongly*.  Developers need to exercise additional care on
> > memory, period.  Memory sealing issues is the least of their worries.
> >
> > (Except for handling RELRO, but only the ld.so developers will lose
> > their hair).
> >
> >
> > OK, so mseal and mimmutable are very different.
> >
> > mimmutable can be used by any developer on the address space easily.
> >
> > mseal requires control of the whole stack between allocation and consumption.
> >
> > I'm sorry, but I don't think you understand how dangerous this MAP_SEALABLE
> > proposal is because of the difficulties it will create for use.
> >
> > The immutable memory management we have today in OpenBSD would completely
> > impossible with such a flag.  Seperation between allocator (that doesn't know
> > what is going to happen), and consumer (that does know), is completely common
> > in the systems environment (meaning the interaction between DSO, libc, other
> > libraries, and the underside of applications).
> >
> > This is not not like an application where you can simply sprinkle the flag
> > into the mmap() calls that cause you problems.  That mmap() call is now in
> > someone else's code, and you CANNOT gain security advantage unless you
> > convince them to gain an understanding of what that flag means -- and it is
> > a flag that other Linux variants don't have, not even in their #include
> > files.
> >
> I respect your reasoning with OpenBSD, but do you have a real example
> that this will be problematic for linux ?

See below.

> In my opinion, the extra communication part with mmap()'s owner has
> its pros and cons.

See below.

> The cons is what you mentioned: extra time for convincing and approval.

No, it is much worse than that.  See below.

> The pro is that there won't be unexpected behavior from the code owner
> point of view, once this communication process is completed. It can
> reduce the possibility of introducing bugs.
> 
> So far, I do not have enough information to say this is a bad idea.
> if you can provide a real example in the context of linux, e.g. DSO
> and libc you mentioned with details, that will be helpful.

Does the kernel map the main program's text segment, data segment, bss
segment, and stack with MAP_SEALABLE or without MAP_SEALABLE?

Once it is mapped, userland starts running.

If those objects don't have MAP_SEALABLE, then ld.so and libc cannot
perform locking of those mappings.  And ld.so or libc must do some of
those lockings later, some of these map lockings cannot be performed in
the kernel because userland makes data modifications and permission modifications
before proceeding into main().

This is unavoidable, because of RELRO; binaries with text relocation; binaries
with W|X mappings; it is probably required for IFUNC setup; and I strongly
suspect there are additional circumstances which require this, *just for glibc*
to use the mechanism.

If the kernel does map those regions with MAP_SEALABLE, then it seems
the most important parts of the address space are going to have MAP_SEALABLE
anyways.  So what were you trying to defend against?

So why are you doing this MAP_SEALABLE dance?   It makes no sense.

I'm sorry, but it is you who must justify these strange semantics which
you are introducing -- to change a mechanism previously engineered and
fully deployed in another operating system.  To me, not being able to
justify these behavious seems to be based on intentional ignorance.
"Not Invented Here", is what I see.

You say glibc will use this.  I call bollocks.  I see a specific behaviour
which will prevent use by glibc.  I designed my mechanism with libc specifically
considered -- it was a whole system environment.

You work on chrome.  You don't work on glibc.  The glibc people aren't publically
talking about this.  From my perspective, this is looking really dumb.

