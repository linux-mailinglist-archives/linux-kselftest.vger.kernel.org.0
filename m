Return-Path: <linux-kselftest+bounces-5817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D486FCE5
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100B21F2282A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7015D1B7FE;
	Mon,  4 Mar 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP+FZFPX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82F12E73;
	Mon,  4 Mar 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543713; cv=none; b=Y9xzeLWP8mQqAkl3N+qp3hCE0lTLU3c1RZ0vR9scSgx7gj1kUodR5z5Q/UJ8tWiTFio2uepBeMXikEIi2pfz3HaRRG0MFe87bNz3M0qTz2RTfRfHkqjFRvSh4Vkfi9V92K0e+mJKX0pHl+bHQlWgwksscL5L/3Gy4m8xSt60p4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543713; c=relaxed/simple;
	bh=/HGmx2mq7+zg1VO1bSo8RtqdxxMsZLXO968The90xlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q37i9ms1wyoOX/LdGQST/U7xEXOSRkqhpLf/YXCS50hSAuFcyMfB4bC9Q66+tHBkL4gQO0KD3TeRBCjh7dEw572WHFAkvbzT2yR85VHL2mUGDEEB80jYFHzBWpgAVBs7proUxpr0+OgT+ldrpkyFa1R3pQIhKUxxNS0OY3Z96xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP+FZFPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53598C433F1;
	Mon,  4 Mar 2024 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709543712;
	bh=/HGmx2mq7+zg1VO1bSo8RtqdxxMsZLXO968The90xlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HP+FZFPXOKKVJQsIdgavlDGoYvqXJQUUJTik+VmyfcSVlIHCJoOStOdSi67o8BgPM
	 RNxJ35itRHMj1xY40xFyKnCgdz3eUb8MP1wyTyhkKisRaFFZJxOXzFUwUuguJ2jNT2
	 GqcVwRbfg/acC7TVu9+6Mfvs+gkXBi4QWXYhuEbnN9CSGMlzH+GPwt3QyHJj/Bx3tp
	 Gpk/72avlZJlrZv+YakX+vBFNnYwKVT/EYQZUskVAkmgb05w5CnLqJK3yGfkQEr7gW
	 QK00Wouky8PtAZDqSL9ruRet3bKRKQhct0Nhq2l5tqQpqGgxjXjFk/i6v3wuSzk4/U
	 XwIwYdTcGOzbg==
Date: Mon, 4 Mar 2024 10:15:10 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Guenter Roeck <groeck@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Nikolai Kondrashov <spbnick@gmail.com>, Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, kernelci@lists.linux.dev, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, nfraprado@collabora.com, 
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20240304-transparent-oriole-of-honeydew-f4174e@houat>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <269232e6-41c9-4aa1-9320-662beabcd69b@infradead.org>
 <CAMuHMdXuXV9WV3aANFTteuP8Q3JY6R5OWsVBedGOP7e_JguxqA@mail.gmail.com>
 <CAMuHMdWi069YAvOoXe7sHJ_o702tY4tDQgL3sfApPR3aCnZboQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjbdi6a4euq6tzrc"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWi069YAvOoXe7sHJ_o702tY4tDQgL3sfApPR3aCnZboQ@mail.gmail.com>


--pjbdi6a4euq6tzrc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:12:38AM +0100, Geert Uytterhoeven wrote:
> On Sun, Mar 3, 2024 at 10:30=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Sun, Mar 3, 2024 at 3:30=E2=80=AFAM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> > > On 3/2/24 14:10, Guenter Roeck wrote:
> > > > While checkpatch is indeed of arguable value, I think it would help=
 a
> > > > lot not having to bother about the persistent _build_ failures on
> > > > 32-bit systems. You mentioned the fancy drm CI system above, but th=
ey
> > > > don't run tests and not even test builds on 32-bit targets, which h=
as
> > > > repeatedly caused (and currently does cause) build failures in drm
> > > > code when trying to build, say, arm:allmodconfig in linux-next. Most
> > > > trivial build failures in linux-next (and, yes, sometimes mainline)
> > > > could be prevented with a simple generic CI.
> > >
> > > Yes, definitely. Thanks for bringing that up.
> >
> > +1
>=20
> > Kisskb can send out email when builds get broken, and when they get
> > fixed again.  I receive such emails for the m68k builds.
>=20
> Like this (yes, one more in DRM; sometimes I wonder if DRM is meant only
> for 64-bit little-endian platforms with +200 GiB/s memory bandwidth):
>
> ---8<-------------------------------------------------------------------
> Subject: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Mon Mar 04=
, 06:35
> To: geert@linux-m68k.org
> Date: Mon, 04 Mar 2024 08:05:14 -0000
>=20
> FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Mon Mar 04, 06:35
>=20
> http://kisskb.ellerman.id.au/kisskb/buildresult/15135537/
>=20
> Commit:   Add linux-next specific files for 20240304
>           67908bf6954b7635d33760ff6dfc189fc26ccc89
> Compiler: m68k-linux-gcc (GCC) 8.5.0 / GNU ld (GNU Binutils) 2.36.1
>=20
> Possible errors
> ---------------
>=20
> ERROR: modpost: "__udivdi3" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] und=
efined!
> make[3]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[2]: *** [Makefile:1871: modpost] Error 2
> make[1]: *** [Makefile:240: __sub-make] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>=20
> No warnings found in log.
> ------------------------------------------------------------------->8---

The driver is meant for a controller featured in an SoC with a Cortex-A8
ARM CPU and less than a GiB/s memory bandwidth.

And I just sent a fix for that one, thanks for the report.

Maxime

--pjbdi6a4euq6tzrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeWRHQAKCRDj7w1vZxhR
xWFcAPoCgSeoB/8bmUbd4z1ay49ZfEoCqaiqzPyPCcSF7f1QgwD/d8uPHuZl+yLF
9/aw+Ej9d0qSGEpya7QRzssHubW/7wA=
=khgr
-----END PGP SIGNATURE-----

--pjbdi6a4euq6tzrc--

