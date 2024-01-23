Return-Path: <linux-kselftest+bounces-3436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB21F839907
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 20:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B08C295637
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F301823D4;
	Tue, 23 Jan 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="3HN6C8AJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62856823C6;
	Tue, 23 Jan 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036332; cv=none; b=oCzn7ZVQ23Fxs57fuC9TGRC0lwv1KBdHSZqOmLX3/aumepLsyQY1IzwiuK8D2l5DPzkwb8EIh4V8yp2wziWZc48A0+ympPbqQajBW6fkPWa0IAO8GOVeYaYK70NLsgSrQaGUr3MdUx6N0pU/wqWZKw7b89rV+Y8BmAs7p3+FDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036332; c=relaxed/simple;
	bh=85z1pDLNzf/l+6g12yGP+kL48gcbmAt/Exa7E4EizGU=;
	h=From:To:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=UGGTZb2XQHE1n3FPNWjsIw7rFBSmwe3tsloCu9e5xn1ykRtzyEq/78FJdwjhol95cI+nvXO+ZGsIsCPfL7IA+3xUcMHP9vCPmK96gDrLZUL598EUHnz0UDB6nLMC6UD+KinB3tcAM7W7DHG34jB/aYiWYYHrtRKBjTQVrNiH2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=3HN6C8AJ; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=85z1pDLNzf
	/l+6g12yGP+kL48gcbmAt/Exa7E4EizGU=; h=date:references:in-reply-to:
	subject:to:from; d=openbsd.org; b=3HN6C8AJTcP6apML6GvYnBtUjVM7yvJM4qGN
	fv1+L1Wt7+NSn4MNtQp6zwhhyrrCPm7inbeZioIntZNMgauhNHg8glINfZ8Bq7BevPRSNg
	ezzIyBqUhFDpFmfuuaePpLXwlNHz8pDVc8IGXxBtGszoTQDe6t0jAOaNupiENVkH1uT7DX
	Ej1vIXax9CpDddiomfw4zlm1DaSX/L+Z97aetWT7U/9Zo9zvquXPXyfRZ8+lt1Oj+9vqov
	2ylBate61fs0rb5U2+LKXMd7dtPKSrdVavU1JYms6RQ8kYs4o2InmG9r3PmaOPCIEafFKQ
	5XujUoKXxpuyzb/C11Aj8M/TGA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id f1a5780b;
	Tue, 23 Jan 2024 11:58:41 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
    Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
                  Jeff Xu <jeffxu@chromium.org>,
                  akpm@linux-foundation.org, keescook@chromium.org,
                  jannh@google.com, sroettger@google.com,
                  willy@infradead.org, gregkh@linuxfoundation.org,
                  torvalds@linux-foundation.org,
                  usama.anjum@collabora.com, rdunlap@infradead.org,
                  jeffxu@google.com, jorgelo@chromium.org,
                  groeck@chromium.org, linux-kernel@vger.kernel.org,
                  linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
                  pedro.falcato@gmail.com, dave.hansen@intel.com,
                  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Introduce mseal()
In-reply-to: <20240123173320.2xl3wygzbxnrei2c@revolver>
References: <20240122152905.2220849-1-jeffxu@chromium.org> <726.1705938579@cvs.openbsd.org> <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com> <86181.1705962897@cvs.openbsd.org> <20240123173320.2xl3wygzbxnrei2c@revolver>
Comments: In-reply-to "Liam R. Howlett" <Liam.Howlett@Oracle.com>
   message dated "Tue, 23 Jan 2024 12:33:20 -0500."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 11:58:41 -0700
Message-ID: <85359.1706036321@cvs.openbsd.org>

Liam R. Howlett <Liam.Howlett@Oracle.com> wrote:

> * Theo de Raadt <deraadt@openbsd.org> [240122 17:35]:
> > Jeff Xu <jeffxu@chromium.org> wrote:
> >=20
> > > On Mon, Jan 22, 2024 at 7:49=E2=80=AFAM Theo de Raadt <deraadt@openbs=
d.org> wrote:
> > > >
> > > > Regarding these pieces
> > > >
> > > > > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > > > > the map sealed since creation.
> > > >
> > > > OpenBSD won't be doing this.  I had PROT_IMMUTABLE as a draft.  In =
my
> > > > research I found basically zero circumstances when you userland does
> > > > that.  The most common circumstance is you create a RW mapping, fil=
l it,
> > > > and then change to a more restrictve mapping, and lock it.
> > > >
> > > > There are a few regions in the addressspace that can be locked whil=
e RW.
> > > > For instance, the stack.  But the kernel does that, not userland.  I
> > > > found regions where the kernel wants to do this to the address spac=
e,
> > > > but there is no need to export useless functionality to userland.
> > > >
> > > I have a feeling that most apps that need to use mmap() in their code
> > > are likely using RW mappings. Adding sealing to mmap() could stop
> > > those mappings from being executable. Of course, those apps would
> > > need to change their code. We can't do it for them.
> >=20
> > I don't have a feeling about it.
> >=20
> > I spent a year engineering a complete system which exercises the maximum
> > amount of memory you can lock.
> >=20
> > I saw nothing like what you are describing.  I had PROT_IMMUTABLE in my
> > drafts, and saw it turning into a dangerous anti-pattern.
> >=20
> > > Also, I believe adding this to mmap() has no downsides, only
> > > performance gain, as Pedro Falcato pointed out in [1].
> > >=20
> > > [1] https://lore.kernel.org/lkml/CAKbZUD2A+=3Dbp_sd+Q0Yif7NJqMu8p__eb=
4yguq0agEcmLH8SDQ@mail.gmail.com/
> >=20
> > Are you joking?  You don't have any code doing that today.  More feelin=
gs?
>=20
> The 'no downside" is to combining two calls together; mmap() & mseal(),
> at least that is how I read the linked discussion.
>=20
> The common case (since there are no users today) of just calling
> mmap()/munmap() will have the downside.
>=20
> There will be a performance impact once you have can_modify_mm() doing
> more than just returning true.  Certainly, the impact will be larger
> in munmap where multiple VMAs may need to be checked (assuming that's
> the plan?).
>=20
> This will require a new and earlier walk of the vma tree while holding
> the mmap_lock.  Since you are checking (potentially multiple) VMAs for
> something, I don't think there is a way around holding the lock.
>=20
> I'm not saying the cost will be large, but it will be a positive
> non-zero number.

For future glibc changes, I predict you will have zero cases where you
can call mmap+immutable or mprotect+immutable, I say so, because I ended
up having none.  You always have to fill the memory.  (At first glance
you might think it works for a new DSO's BSS, but RELRO overlaps it, and
since RELRO mprotect happens quite late, the permission locking is quite
delayed relative to the allocation).

I think chrome also won't lock memory at allocation.  I suspect the
generic allocator is quite seperate from the code using the allocation,
which knows which objects can have their permissions locked and which
objects can't.

In OpenBSD, the only cases where we could set immutable at the same time
as creating the mapping was in execve, for a new process's stack regions,
and that is kernel code, not the userland exposed system call APIs.
=20
This change could skip adding PROT_MSEAL today, and add it later when
there are facts the need.


It's the same with MAP_MSEALABLE.  I don't get it. So now there are 3
memory types:
       - cannot be sealed, ever
       - not yet sealed
       - sealed

What purpose does the first type serve?  Please explain the use case.

Today, processes have control over their entire address space.

What is the purpose of "permissions cannot be locked".  Please supply
an example.  If I am wrong, I'd like to know where I went wrong.


