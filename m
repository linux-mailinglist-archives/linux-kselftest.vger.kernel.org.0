Return-Path: <linux-kselftest+bounces-3982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47C8466A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729CC2839FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A4D27F;
	Fri,  2 Feb 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="srWsV+Hn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147AE54E;
	Fri,  2 Feb 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846058; cv=none; b=LPI4dzk38iDnUpy6v6h0sUsNs2VuPFdr2wv7/MtjinynnZMqEuNgpzz9ntXfmSIDPKnvNNFiYJV+K0MlAYhvR/AGNBR0JbhcZgZM3w3RcO9rAG0oJCsPrABw0wE2A5hiT5epUSnxxQTqKnEeDoJ4SVHW+xnMGoS9BKMI+2FMxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846058; c=relaxed/simple;
	bh=WjNo16b/STfHvXt9OMjgk8r1gC4Z6JZKxMLw9N2xD3U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=KS4r+KEIY7jJtRJyPg+URImPzMoRnHGiMMzgLwEdRVZPzf3BQVfTpGWcniCtlL5p5xJ+Vs/IhfvY+Re6GKAsgDNe1Aka1//CyQazu02+mn43zDwVl8rX4KMWkqzVb634nVikXea2Qm22fep3+muNdZmzLnp61Pi+eWUsnDbseBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=srWsV+Hn; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=WjNo16b/ST
	fHvXt9OMjgk8r1gC4Z6JZKxMLw9N2xD3U=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=srWsV+HnLtpvB+QfkypXALDhe89gSURfj
	9QsjUCoNIba8rQtIspUA96OUAxdwBAkIRZW3xRJBmvkFIdyXb1Rm5FEnEIWdincqLmS8zd
	U4uZo6sPDlyjwokrCJCtXMAq156XjvV8oSCpUKiPlEfKNz1EPrLzi091RLzpAhvQ40CTbc
	wL5ce3EhNX90O/708OLsIBaXjKZBbiq+O4dzoWvORnKo41Fv+hhrc6gNanQKMAURq6RKL7
	90593115uptjPwfy8yjnN47tHvh5AriEgZk3NBK7Dwmyb82tU03ZqR5pKbHd1heLe4TiDZ
	uIkHLQsUEg3nccHocwq/E40g/EcgA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 3f963060;
	Thu, 1 Feb 2024 20:54:10 -0700 (MST)
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
In-reply-to: <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131175027.3287009-3-jeffxu@chromium.org> <20240201231151.GA41472@sol.localdomain> <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Thu, 01 Feb 2024 19:30:29 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 20:54:10 -0700
Message-ID: <96087.1706846050@cvs.openbsd.org>

Jeff Xu <jeffxu@chromium.org> wrote:

> On Thu, Feb 1, 2024 at 3:11=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> >
> > On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wrote:
> > > [PATCH v8 2/4] mseal: add mseal syscall
> > [...]
> > > +/*
> > > + * The PROT_SEAL defines memory sealing in the prot argument of mmap=
().
> > > + */
> > > +#define PROT_SEAL    0x04000000      /* _BITUL(26) */
> > > +
> > >  /* 0x01 - 0x03 are defined in linux/mman.h */
> > >  #define MAP_TYPE     0x0f            /* Mask for type of mapping */
> > >  #define MAP_FIXED    0x10            /* Interpret addr exactly */
> > > @@ -33,6 +38,9 @@
> > >  #define MAP_UNINITIALIZED 0x4000000  /* For anonymous mmap, memory c=
ould be
> > >                                        * uninitialized */
> > >
> > > +/* map is sealable */
> > > +#define MAP_SEALABLE 0x8000000       /* _BITUL(27) */
> >
> > IMO this patch is misleading, as it claims to just be adding a new sysc=
all, but
> > it actually adds three new UAPIs, only one of which is the new syscall.=
  The
> > other two new UAPIs are new flags to the mmap syscall.
> >
> The description does include all three. I could update the patch title.
>=20
> > Based on recent discussions, it seems the usefulness of the new mmap fl=
ags has
> > not yet been established.  Note also that there are only a limited numb=
er of
> > mmap flags remaining, so we should be careful about allocating them.
> >
> > Therefore, why not start by just adding the mseal syscall, without the =
new mmap
> > flags alongside it?
> >
> > I'll also note that the existing PROT_* flags seem to be conventionally=
 used for
> > the CPU page protections, as opposed to kernel-specific properties of t=
he VMA
> > object.  As such, PROT_SEAL feels a bit out of place anyway.  If it's a=
dded at
> > all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure this a=
spect has
> > been properly discussed yet, seeing as the patchset is presented as jus=
t adding
> > sys_mseal().  Some reviewers may not have noticed or considered the new=
 flags.
> >
> MAP_ flags is more used for type of mapping, such as MAP_FIXED_NOREPLACE.
>=20
> The PROT_SEAL might make more sense because sealing the protection bit
> is the main functionality of the sealing at this moment.

Jeff, please show a piece of software that needs to do PROT_SEAL as
mprotect() or mmap() argument.

Please don't write it as a vague essay.

Instead, take a piece of existing code, write a diff, and show your work.

Then explain that diff, justify why doing the PROT_SEAL as an argument
of mprotect() or mmap() is a required improvement, and show your Linux
developer peers that you can do computer science.

I did the same work in OpenBSD, at least 25% time over 2 years, and I
had to prove my work inside my development community.  I had to prove
that it worked system wide, not in 1 program, with hand-waving for the
rest.  If I had said "Looks, it works in ssh, trust me it works in other
programs", it would not have gone further.

glibc is the best example to demonstrate, but smaller examples might
convince.

