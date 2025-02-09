Return-Path: <linux-kselftest+bounces-26139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10327A2E18E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 00:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBD53A4216
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3586252;
	Sun,  9 Feb 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R1vAGGAU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304E243398;
	Sun,  9 Feb 2025 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144872; cv=none; b=sTm3zYI6I0ZrDBG3NLCR93TdrHo+biVoART97eGlD+BUoLK98IA3O+Oscp/q6ytTYLFoX0LmSaaGPxiwbmK3k41TY8v+u6jao55XsHWrg/W0LuFaLNb8349JOHxms7ZYXG4O75e9ZIKu5GAGg6HbVJLlN6udWGQoPPaGBeVY+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144872; c=relaxed/simple;
	bh=K5FQS1s/N4NX8Q6lrgoCVP7sT/sJtb8Ma3K8r2bhXZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVjBkhQI/uRTFJeUTk7JXZQBWelhKSpxhCMZYfxfKHiU/ni/TCResS+t3zyQ3T2zBjTF0UdXOdw1VCSDzsThkL4IhJWLKUtyWU1dpCka/eLbOXbbcPvCs2PENHQaVUq8AxQT77Wp2ReCA3Nbwq66cYIkAzUOw7jwQMQEJ+Fd95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=R1vAGGAU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1739144868;
	bh=K5FQS1s/N4NX8Q6lrgoCVP7sT/sJtb8Ma3K8r2bhXZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1vAGGAUfGv+5bOipOemqmM5ASiBVagx4KlUly21yX88sATK64KsEfbEXNsdI4qv1
	 G3RLNzWzpHghPecgbSg4myII0wMIsBGBQvahjZDWI9wW31Qzn4qh6cPg6QBjyfQKLZ
	 l4QWC0gHYN/n64cchniE4X85BSIYdjpmxcxSrMG8Dt7I+3StLuyJabveeQHmLCNYEY
	 ZWzSthmugEC1Xb/AGePa5XDA5cEhdKb0QweLyFiEuVPZSMISi4KiLqFCEM9TYM3vWJ
	 4AgMAMr8vHjC8/jrYA2wwQArHKJzt5LsjSqsKUxQtECPaS1UrF8gQSC6fjGwX+/3Za
	 MOKVxlf7/sILQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Yrksb30ZMz4wbn;
	Mon, 10 Feb 2025 10:47:47 +1100 (AEDT)
Date: Mon, 10 Feb 2025 10:47:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Brendan Higgins
 <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development
 <kunit-dev@googlegroups.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] KUnit test moves / renames
Message-ID: <20250210104746.49eb1dd8@canb.auug.org.au>
In-Reply-To: <CAKRRn-cFvCOay-J6BEsGjcB309_k-4rr9u=yKU7BCmiW-OcVcA@mail.gmail.com>
References: <20241011072509.3068328-2-davidgow@google.com>
	<e67664ac-dd20-40f3-9bee-0785d428ecce@linuxfoundation.org>
	<202502081313.054EB7B@keescook>
	<CAKRRn-cFvCOay-J6BEsGjcB309_k-4rr9u=yKU7BCmiW-OcVcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XAgsktbiHLJXsFjxvxAWmIR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XAgsktbiHLJXsFjxvxAWmIR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 10 Feb 2025 04:43:28 +0530 Shuah Khan <skhan@linuxfoundation.org> w=
rote:
>
> On Sun, Feb 9, 2025, 2:44=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>=20
> > On Fri, Oct 11, 2024 at 07:53:43AM -0600, Shuah Khan wrote: =20
> > > On 10/11/24 01:25, David Gow wrote: =20
> > > > As discussed in [1], the KUnit test naming scheme has changed to av=
oid
> > > > name conflicts (and tab-completion woes) with the files being teste=
d.
> > > > These renames and moves have caused a nasty set of merge conflicts,=
 so
> > > > this series collates and rebases them all to be applied via
> > > > mm-nonmm-unstable alongside any lib/ changes[2].
> >
> > Shall I carry this in the hardening tree? I didn't see it land in the
> > merge window, and I still don't see it in -next?
> > =20
>=20
> My thinking was that this series would go through Andrew's tree to avoid
> conflicts. Please take it through yours.

If they have been rebased onto mm-nonmm-unstable, then they really need
to go through Andrew' tree (since mm-nonmm-unstable gets rebased often).

--=20
Cheers,
Stephen Rothwell

--Sig_/XAgsktbiHLJXsFjxvxAWmIR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmepPqIACgkQAVBC80lX
0GxW2ggAnwfBviD12QDuHVGG/lhfYRwqjkWuY+NJWx0vno0ruHyUnCk074vsx7lt
dphIgSzh5euPaBc+7UxWD8yK83Odmt+dyoRgr/YzrnE+btFCapkQxal4dFnzyQf5
H5Y6lw6Gfck5kUXbLBAZLiZ35ZPeig122kB2s5I8z227Ts4esEUJyS0sYJIqW0rA
WPPzKghBVwSmzpFuHcDdqB1tfbubEIUgiSi+slgAVKP2zAgB3GxvbTKpQUOxymuf
Gst07XYrYxa7PDfGye2jpcTeGgmJ0IMJQlAfE8xuwtAB2FAWEodIUA+E6QL8sxz8
KQPK6OjjFkZm67Hmtmoe7uWaospVWg==
=GkLC
-----END PGP SIGNATURE-----

--Sig_/XAgsktbiHLJXsFjxvxAWmIR--

