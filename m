Return-Path: <linux-kselftest+bounces-11211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F58FB8B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 18:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FC71C21125
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F79147C98;
	Tue,  4 Jun 2024 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhEVfBTv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CCE143C7B;
	Tue,  4 Jun 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517921; cv=none; b=qk2ClEpmyWRU/q1PcXH5QHy8o4S+MctX028KK7h1ZOqgBqvKRiOLMXn5ZfRxalHy79nKphAcWl7KrY7AQYGltk8p+Cw+U++EeneCE5Zb0KlaR5bHoW8bG++LeGOysuX3Mle76inxoBgOmpCzFytZK6lrCqussDJJ+LHZ+s3k2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517921; c=relaxed/simple;
	bh=bE1vdHtIjSqwigCaLdryxWybdC+nY5atBDg6IDsGPHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDtSAhgh5yE+QKAXgdd+ZkD5CO4+6DWZnKnsfHjqXweQB2I5ode3QVP+OZq6gnbXRZoTIRup0G9OwNbYSq9W1zFTjshrRnC23sR85YN+RmY3Nz3j92/BfOslj9iFwzZt8L0E/+wOod7LAMesX+gaMKuCyzwBuV802WQBx5sA6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhEVfBTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092E4C32786;
	Tue,  4 Jun 2024 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717517920;
	bh=bE1vdHtIjSqwigCaLdryxWybdC+nY5atBDg6IDsGPHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhEVfBTvB89ICwH5kSGyU+pleoJh1UIenKoqhcNlXMpaRnyCpfs/VUD1SN68E+hij
	 QgA3qyEB068crCIK8AtSPuulcKGShjxkaRKryZjzmyMEIZi0TRUCfPM1tdRGU50u1x
	 AtQlGltWp1zvO4lFsyWqRt5t5kWxuuPFaZfZD4CnCi4j42z8v73LCvsDYLQ4y0v1eE
	 H1p+poDml21jEVERJAtULu3WKvdxeQymsrHWu/TRAwwckSdutPYyBCDTCImjOecubP
	 xXty3JGR2EX1zPl0RD+DrpHOyOhjLWTOeD29jO5Ze8ZEEaz2VwCXAQkxh8va+EW7zz
	 rVxYvdNQu0u1g==
Date: Tue, 4 Jun 2024 17:18:32 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 04/10] selftests/harness: Fix interleaved scheduling
 leading to race conditions
Message-ID: <53c0e2e5-46c9-4e49-8ec4-64ef58e6331c@sirena.org.uk>
References: <20240511171445.904356-1-mic@digikod.net>
 <20240511171445.904356-5-mic@digikod.net>
 <9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk>
 <187423fb-ec78-4318-9da0-5b27df62b71f@sirena.org.uk>
 <9eb1e48e-b273-475a-9740-52deedf11ee2@sirena.org.uk>
 <20240604.KaT6shae5eip@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d/oZ8G2r6TlAFN6b"
Content-Disposition: inline
In-Reply-To: <20240604.KaT6shae5eip@digikod.net>
X-Cookie: Is it clean in other dimensions?


--d/oZ8G2r6TlAFN6b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 06:06:48PM +0200, Micka=EBl Sala=FCn wrote:

> Thanks for the heads up.  I warned about not being able to test
> everything when fixing kselftest last time, but nobody show up.  Is
> there an easy way to run most kselftests?  We really need a (more
> accessible) CI...

You can just invoke the top level kselftests Makefile but between things
being flaky and runtime requirements there's a bunch of noise there.
KernelCI covers a bunch of it and would be my go to, I've got a good
chunk of the selftests that actually build and run reliably in my
personal CI but it has no visible UI.  Part of the issue here might be
platform specifics, I'm seeing this on arm64. =20

> > > FWIW I'm still seeing this on -rc2...

> > AFAICT this is due to the switch to using clone3() with CLONE_VFORK

> I guess it started with the previous vfork() that was later replaced
> with CLONE_VFORK.

Bisect did seem to point at this commit FWIW, I've not dug into any API
differences or anything here.  The immediate thing being replaced was a
plain fork() though I see it was vfork() at some point before that, and
I'd not have noticed if the individual testcases weren't hanging so the
timeout was needed.

> > I'm not clear what the original race being fixed here was but it seems
> > like we should revert this since the timeout functionality is pretty
> > important?

> It took me a while to fix all the previous issues and it would be much
> easier to just fix this issue too.

> I'm working on it.

Great, thanks.

--d/oZ8G2r6TlAFN6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfPlcACgkQJNaLcl1U
h9DBngf+IjDxDtusJc/iSMVrkM3BxNZGYxiJwiwd29R9Z1J4+xF1epkd3KXzUhGK
s7k2vCuJcyj3tj0CDKxLbC155dUIryEvIF8o9oJ5xY4z+l/8SSspGxm0Oly8fjZE
T3vZLiWmWFyZV6pC9FhXryFLgnCCwmHgKXpMQoRDZGSkpq/DhxYTNAH1n94F2P6e
vjEnCzuZb9YvH8ZEG7X5yiZs0Z6lUiVSFp4Uqf3AEFLZBl33JFREgnuYpuSsBo/p
vo6UOKR/TkP61x02iuq5QiL0OtuW/pusrq1yDmAlILHzh6z5DYHgf/iNAumjKykx
ZxQrgJtk5Fhc8P5nERw/c7Q07LjV/A==
=Ezzq
-----END PGP SIGNATURE-----

--d/oZ8G2r6TlAFN6b--

