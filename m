Return-Path: <linux-kselftest+bounces-3375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E7837663
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BC928687A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF9212E5A;
	Mon, 22 Jan 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="CgEnb1nv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856B101C5;
	Mon, 22 Jan 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962902; cv=none; b=F9TrUaABcI5X3XuvwmcNdu149mNPnMUzqD4y2GCVO+J9qlV7rJsWxesbjykoVtbcZz2OgOgcNBrqMA6PU5ZkBwNchmOU5hWBfpo/6ewEdLaGj93B7Y6Lv/i0vxwypkDMy0E+IAWBhnVuI1uBQKmn/8/lfw2frdRG3FKEGEBzcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962902; c=relaxed/simple;
	bh=fW8RZaunINi3Cx/0kUOukws6BMxvvfRKRL6GyrdvzPU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=spy2efHQAkxWmd7PKcz2fiPT5xQsYSITfcJDIa3zPBOOJWJZ3xoZIZHr+KS/BCjN8qCaxpDQzByMzPkgc1ZTPN6jp8BV1tW/BIGhvZU8N0VDcjAr9eCuR5OZMP8FmTtNBY53lI8FCIE+YPMftQhgVP/SjCLfYQA4p9f8daoShs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=CgEnb1nv; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=fW8RZaunIN
	i3Cx/0kUOukws6BMxvvfRKRL6GyrdvzPU=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=CgEnb1nvZQetXaeg3BRJ3EjgbpFWzWJI8
	EfQavnvBUtlaD7UWqu0eQlfgiWHk3o10U4h4IFSVDMkrW3/LhYY68Whgf6WBoHKpbaBTLb
	2xX/jWnOZPndD+NMtkjmimYbqnfsAGpz+9h5x0i+yXuw9UFZ4FficA2ZegJoLd5hIvrJOR
	gwaUkfj40qZVzE61RTeitxYYvcTETq8OlS8cn9FUZ68vUHCsbTRHh75InHtvJe7fJDSEiY
	1N2erlahzki6kwMRW8eMhmt1pmBITZSKqTMnUoWaM4y3b+DRK/EzKYhFHut4ug8Sf5Mxye
	RIeDGbjH5CNy2ULEpEYFGJitS8CgA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 7bdc2336;
	Mon, 22 Jan 2024 15:34:57 -0700 (MST)
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
In-reply-to: <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com>
References: <20240122152905.2220849-1-jeffxu@chromium.org> <726.1705938579@cvs.openbsd.org> <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Mon, 22 Jan 2024 14:10:17 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2024 15:34:57 -0700
Message-ID: <86181.1705962897@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> On Mon, Jan 22, 2024 at 7:49=E2=80=AFAM Theo de Raadt <deraadt@openbsd.or=
g> wrote:
> >
> > Regarding these pieces
> >
> > > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > > the map sealed since creation.
> >
> > OpenBSD won't be doing this.  I had PROT_IMMUTABLE as a draft.  In my
> > research I found basically zero circumstances when you userland does
> > that.  The most common circumstance is you create a RW mapping, fill it,
> > and then change to a more restrictve mapping, and lock it.
> >
> > There are a few regions in the addressspace that can be locked while RW.
> > For instance, the stack.  But the kernel does that, not userland.  I
> > found regions where the kernel wants to do this to the address space,
> > but there is no need to export useless functionality to userland.
> >
> I have a feeling that most apps that need to use mmap() in their code
> are likely using RW mappings. Adding sealing to mmap() could stop
> those mappings from being executable. Of course, those apps would
> need to change their code. We can't do it for them.

I don't have a feeling about it.

I spent a year engineering a complete system which exercises the maximum
amount of memory you can lock.

I saw nothing like what you are describing.  I had PROT_IMMUTABLE in my
drafts, and saw it turning into a dangerous anti-pattern.

> Also, I believe adding this to mmap() has no downsides, only
> performance gain, as Pedro Falcato pointed out in [1].
>=20
> [1] https://lore.kernel.org/lkml/CAKbZUD2A+=3Dbp_sd+Q0Yif7NJqMu8p__eb4ygu=
q0agEcmLH8SDQ@mail.gmail.com/

Are you joking?  You don't have any code doing that today.  More feelings?

OpenBSD userland has zero places it can use mmap() MAP_IMMUTABLE.

It has two places where it has mprotect() + mimmutable() adjacent to each
other, two codepaths for late mprotect() of RELRO, and then make the RELRO
immutable.

I think this idea is a premature optimization, and intentionally incompatib=
le.

Like I say, I had a similar MAP_ flag for mprotect() and mmap() in my
development trees, and I recognized it was pointless, distracting developers
into the wrong patterns, and I threw it out.

> > OpenBSD now uses this for a high percent of the address space.  It might
> > be worth re-reading a description of the split of responsibility regard=
ing
> > who locks different types of memory in a process;
> > - kernel (the majority, based upon what ELF layout tell us),
> > - shared library linker (the next majority, dealing with shared
> >   library mappings and left-overs not determinable at kernel time),
> > - libc (a small minority, mostly regarding forced mutable objects)
> > - and the applications themselves (only 1 application today)
> >
> >     https://lwn.net/Articles/915662/
> >
> > > The MAP_SEALABLE bit in the flags field of mmap(). When present, it m=
arks
> > > the map as sealable. A map created without MAP_SEALABLE will not supp=
ort
> > > sealing, i.e. mseal() will fail.
> >
> > We definately won't be doing this.  We allow a process to lock any and =
all
> > it's memory that isn't locked already, even if it means it is shooting
> > itself in the foot.
> >
> > I think you are going to severely hurt the power of this mechanism,
> > because you won't be able to lock memory that has been allocated by a
> > different callsite not under your source-code control which lacks the
> > MAP_SEALABLE flag.  (Which is extremely common with the system-parts of
> > a process, meaning not just libc but kernel allocated objects).
> >
> MAP_SEALABLE was an open discussion item called out on V3 [2] and V4 [3].
>=20
> I acknowledge that additional coordination would be required if
> mapping were to be allocated by one software component and sealed in
> another. However, this is feasible.
>=20
> Considering the side effect of not having this flag (as discussed in
> V3/V4) and the significant implications of altering the lifetime of
> the mapping (since unmapping would not be possible), I believe it is
> reasonable to expect developers to exercise additional care and
> caution when utilizing memory sealing.
>
> [2] https://lore.kernel.org/linux-mm/20231212231706.2680890-2-jeffxu@chro=
mium.org/
> [3] https://lore.kernel.org/all/20240104185138.169307-1-jeffxu@chromium.o=
rg/

I disagree *strongly*.  Developers need to exercise additional care on
memory, period.  Memory sealing issues is the least of their worries.

(Except for handling RELRO, but only the ld.so developers will lose
their hair).


OK, so mseal and mimmutable are very different.

mimmutable can be used by any developer on the address space easily.

mseal requires control of the whole stack between allocation and consumptio=
n.

I'm sorry, but I don't think you understand how dangerous this MAP_SEALABLE
proposal is because of the difficulties it will create for use.

The immutable memory management we have today in OpenBSD would completely
impossible with such a flag.  Seperation between allocator (that doesn't kn=
ow
what is going to happen), and consumer (that does know), is completely comm=
on
in the systems environment (meaning the interaction between DSO, libc, other
libraries, and the underside of applications).

This is not not like an application where you can simply sprinkle the flag
into the mmap() calls that cause you problems.  That mmap() call is now in
someone else's code, and you CANNOT gain security advantage unless you
convince them to gain an understanding of what that flag means -- and it is
a flag that other Linux variants don't have, not even in their #include
files.

> > It may be fine inside a program like chrome, but I expect that flag to =
make
> > it harder to use in libc, and it will hinder adoption.
> >
> In the case of glibc and linux, as stated in the cover letter, Stephen
> is working on a change to glibc to add sealing support to the dynamic
> linker,  also I plan to make necessary code changes in the linux kernel.

How will ld.so seal memory which the kernel mapped?  The kernel will now
automatically puts MAP_SEALABLE on the text segment and stack?  Why not
put it on all mmap() allocations?  Why not just skip the flag entirely?

To me, this is all very bizzare.

I don't understand what the MAP_SEALABLE flag is trying to solve.

