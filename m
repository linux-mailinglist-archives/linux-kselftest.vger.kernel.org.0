Return-Path: <linux-kselftest+bounces-15888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860FB95A3D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FED1F21399
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92681B2527;
	Wed, 21 Aug 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi3QKZrS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE71494D1;
	Wed, 21 Aug 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261007; cv=none; b=nkRorurncDjRZ+yhuybgkW8k7ePCDL6DW4ZahXwaK7C7cP3+zdHpXLGuac1OryKc+OSOlK/ixUatm9siQvAkmqqN8fVASGUEJWiLz/F5tKjw4DrkXdCczJg3qa2y/Vra32t0YlTDR+9moIskVZaiwSQwHdLQj/47r+GRdQeZXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261007; c=relaxed/simple;
	bh=IphY4+kHIie7jEzz5vW5+DOoafboWztbY8zIGCvr5V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+f5p5Ue6hacFSnRBPr4qIC1P9hEaR4Nsl2e0vjHNWqmhl9OAcjr+Wcs3TNhIWl/x7wqPzvzd2ie1zGZ6KxloOyYfPIgO7WU2Hgtp3U/Jxo5Pbl0yNwxozz6W1Q4GCO4ZUsmkPG/04jVFekQXrjqIMJ5G1MSBtYxf3dpOCiT6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi3QKZrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C88C32781;
	Wed, 21 Aug 2024 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724261007;
	bh=IphY4+kHIie7jEzz5vW5+DOoafboWztbY8zIGCvr5V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi3QKZrSmr2YIEap/NV50J//OgRWwRS/aU7kSMwbQLaMQWqOIvRhnzttqB8TL4jcy
	 EjsBPTqAXJqBZ5DwEocYdOVLgZ61spLg1t6lwxL/nwMRcxUHERjgb7AC//CCJ6Qxm6
	 SeF+WV13tLHiFYQf8STSep/LkuwflygctUSwrBMTgoUSE/TwuegoJabXFIkI9ZUYY3
	 YPzKispDHwpI9pJFVKLrbfC0cxVL4LY5D1Hw26vvWgHeSlm8bVnmiV3NqrR52pOrrK
	 5cNKKEUcjHVnlXH3ozuwNRC+9lKw2g/NeKO9PWNz1fYs9t2B7mq8jW65eGcLsXFdLJ
	 zRgYsdMhUCbeQ==
Date: Wed, 21 Aug 2024 18:23:18 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"brauner@kernel.org" <brauner@kernel.org>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IjUWVOJ38MVk6Iyg"
Content-Disposition: inline
In-Reply-To: <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
X-Cookie: You are false data.


--IjUWVOJ38MVk6Iyg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 03:54:49PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-08-21 at 13:45 +0100, Mark Brown wrote:

> > It's entirely possible it just leaked.=A0 My own attempts to dig through
> > the archives haven't turned up anything on the subjecti either, it seems
> > to have been there from the get go and just gone in without comment.
> > Equally it could just be that people felt that this was a more tasteful
> > way of specifying stacks, or that some future use was envisioned.

> Ok, well I'm suspicious, but won't object over it. The rest seems settled=
 from
> my side. I may try to attract some other x86 attention to that CMPXCHG he=
lper,
> but otherwise.

OK, I'll post what I've got (with the current ABI) today, incorporating
your x86 fixes and the tighter validation and we can see what people
think.  Perhaps Christian remembers what's going on there?

> > > Sorry for that. I looked through all the old threads expecting to find
> > > discussion, but couldn't find an answer. Is clone3 support a dependen=
cy for
> > > arm
> > > shadow stacks?

> > Catalin didn't want to merge the arm64 support without clone3(), and
> > there's code dependencies as a result.=A0 I could unpick it and reverse
> > the ordering so long as the arm64 maintainers are OK with that since the
> > overlap is in the implementation of copy_thread() and some of the
> > dependency patches.

Actually in an off-list discussion today Catalin indicated that he's
fine with relaxing that a little so I'm in the process of picking the
dependency apart.

--IjUWVOJ38MVk6Iyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbGIoUACgkQJNaLcl1U
h9DFfAf+OzTGKCg7J4IIOd/eFMUWBcVyGpBEBAM2TCfPeCvemloWt7HhJ4xnjyjP
L3I8Zh+LcMh8NspUGwghleR+i+o12E+g2/VISH8FHUlD2Wzd3JOeIH2IA6eYo1QT
h1LlZfDAa8RJd0sJW1ToQWNmDGVzPyQxShCd7P56VwCC/NvN4TulMqiX3h8tJgc7
ExNQ4kuK4iI1c0AUZcMDxkrFFEZ/JlgCevFCEluNCpX3DzP8ng29DHQQdOLdfWne
bTPX5hqp/ziLiDKyguBNwyTkqcpXquZTf0KSRkNVP78KNBnbtbJm0Qzr4Vjaol+5
tFLPcB66vbMI6tV0e7yfeWKAX7NlVg==
=F/Cr
-----END PGP SIGNATURE-----

--IjUWVOJ38MVk6Iyg--

