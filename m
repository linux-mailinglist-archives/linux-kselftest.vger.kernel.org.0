Return-Path: <linux-kselftest+bounces-3985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DEF8466CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 05:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C271C23367
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67C8DF5D;
	Fri,  2 Feb 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="4e7qlbpO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E80D526;
	Fri,  2 Feb 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847041; cv=none; b=FrsYCYhCfQsEs7iwTDPGbDeLc9cvZjcXrz5vSuwziXdOIOFkX5wNyQXseTOhMDXyWfiD6vVD89985S/Ah1C8ES7Rgd7x4125FEFmQFpD/OxaKifa9zlIdKcVSZZN5j2nqpBL3V3iMkGqhGHMVdtUsirDO177SXRRmic/MV4FrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847041; c=relaxed/simple;
	bh=t8TOoWGr0mcyEMEUUA9Zr9vcjWer6I2JFmiElhVMlm4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=HgMwt4P+sHyaaNdktb7xpncIpm3y2qaiKa7ldL3Ke4LJxAbaQI/Nk3Jad9kRD+haAbmX8XTMVDFVIi5iW6Im0ZEN7EpiBRA1Yrch4URnMiFfhJuJ+xpwVL8FkEUnJvxE5iXSvBtmcbZmBf2IvTnAI88PqMbe5zhKqFlJ4vY7jsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=4e7qlbpO; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=t8TOoWGr0m
	cyEMEUUA9Zr9vcjWer6I2JFmiElhVMlm4=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=4e7qlbpOvso68la6pAFV9vdLZCsRaFhZd
	H6mFWFXZCl7o3iu6kzblO8V+HFKqFVZxUjCMBXuu8IwswO5pGQ5/Ri44vGpmfdAWncYdVM
	JXnBwNuYWJK+Ar5ZehqDJW7bhv+874OLtBw9DGHw26DVmjeJXXCBVLJOGXR/2/oqj6dsZ1
	m/mz/1+KQtRFnhMAiB37fr2a5CbRrUZcGJ2s7WYLKZvpVW3SySmXWgJ4Xib1V200/ClE/x
	d349ddfnnu981rqmjLUW1/SU91pCMN80x3pvsbRqcraJTh3dC0ma2JsuIVyKy8ZZ4SLarl
	kRi70QVJo0Zygt0A3hP2aE44CMnlA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 6f32be00;
	Thu, 1 Feb 2024 21:10:38 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: Eric Biggers <ebiggers@kernel.org>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 2/4] mseal: add mseal syscall
In-reply-to: <CABi2SkWP=N_V9+VvH3omw3gw=VcRqhqenti-qABijo-SNqXxhQ@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131175027.3287009-3-jeffxu@chromium.org> <20240201231151.GA41472@sol.localdomain> <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com> <96087.1706846050@cvs.openbsd.org> <CABi2SkWP=N_V9+VvH3omw3gw=VcRqhqenti-qABijo-SNqXxhQ@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Thu, 01 Feb 2024 20:03:45 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 21:10:38 -0700
Message-ID: <72434.1706847038@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> On Thu, Feb 1, 2024 at 7:54=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org=
> wrote:
> >
> > Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > > On Thu, Feb 1, 2024 at 3:11=E2=80=AFPM Eric Biggers <ebiggers@kernel.=
org> wrote:
> > > >
> > > > On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wrote:
> > > > > [PATCH v8 2/4] mseal: add mseal syscall
> > > > [...]
> > > > > +/*
> > > > > + * The PROT_SEAL defines memory sealing in the prot argument of =
mmap().
> > > > > + */
> > > > > +#define PROT_SEAL    0x04000000      /* _BITUL(26) */
> > > > > +
> > > > >  /* 0x01 - 0x03 are defined in linux/mman.h */
> > > > >  #define MAP_TYPE     0x0f            /* Mask for type of mapping=
 */
> > > > >  #define MAP_FIXED    0x10            /* Interpret addr exactly */
> > > > > @@ -33,6 +38,9 @@
> > > > >  #define MAP_UNINITIALIZED 0x4000000  /* For anonymous mmap, memo=
ry could be
> > > > >                                        * uninitialized */
> > > > >
> > > > > +/* map is sealable */
> > > > > +#define MAP_SEALABLE 0x8000000       /* _BITUL(27) */
> > > >
> > > > IMO this patch is misleading, as it claims to just be adding a new =
syscall, but
> > > > it actually adds three new UAPIs, only one of which is the new sysc=
all.  The
> > > > other two new UAPIs are new flags to the mmap syscall.
> > > >
> > > The description does include all three. I could update the patch titl=
e.
> > >
> > > > Based on recent discussions, it seems the usefulness of the new mma=
p flags has
> > > > not yet been established.  Note also that there are only a limited =
number of
> > > > mmap flags remaining, so we should be careful about allocating them.
> > > >
> > > > Therefore, why not start by just adding the mseal syscall, without =
the new mmap
> > > > flags alongside it?
> > > >
> > > > I'll also note that the existing PROT_* flags seem to be convention=
ally used for
> > > > the CPU page protections, as opposed to kernel-specific properties =
of the VMA
> > > > object.  As such, PROT_SEAL feels a bit out of place anyway.  If it=
's added at
> > > > all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure th=
is aspect has
> > > > been properly discussed yet, seeing as the patchset is presented as=
 just adding
> > > > sys_mseal().  Some reviewers may not have noticed or considered the=
 new flags.
> > > >
> > > MAP_ flags is more used for type of mapping, such as MAP_FIXED_NOREPL=
ACE.
> > >
> > > The PROT_SEAL might make more sense because sealing the protection bit
> > > is the main functionality of the sealing at this moment.
> >
> > Jeff, please show a piece of software that needs to do PROT_SEAL as
> > mprotect() or mmap() argument.
> >
> I didn't propose mprotect().
>=20
> for mmap() here is a potential use case:
>=20
> fs/binfmt_elf.c
> if (current->personality & MMAP_PAGE_ZERO) {
>                 /* Why this, you ask???  Well SVr4 maps page 0 as read-on=
ly,
>                    and some applications "depend" upon this behavior.
>                    Since we do not have the power to recompile these, we
>                    emulate the SVr4 behavior. Sigh. */
>=20
>                 error =3D vm_mmap(NULL, 0, PAGE_SIZE,
>                                 PROT_READ | PROT_EXEC,   <-- add PROT_SEAL
>                                 MAP_FIXED | MAP_PRIVATE, 0);
>         }
>=20
> I don't see the benefit of RWX page 0, which might make a null
> pointers error to become executable for some code.



And this is a lot faster than doing the operation as a second step?


But anyways, that's kernel code.  It is not userland exposed API used
by programs.

The question is the damage you create by adding API exposed to
userland (since this is Linux: forever).

I should be the first person thrilled to see Linux make API/ABI mistakes
they have to support forever, but I can't be that person.



