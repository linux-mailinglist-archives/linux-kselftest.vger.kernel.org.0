Return-Path: <linux-kselftest+bounces-12934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49791BFE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238BFB21527
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D160715B147;
	Fri, 28 Jun 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9sw+RsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0B1E89A;
	Fri, 28 Jun 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582435; cv=none; b=IS9grVPmDgSvtV5rPjiwNSMZR0VyNTmm5aOTEx/2VmjnqO9EhNG/oSypYQAzlwqtHhROh8CAF6Voh6/RoHEQbWmmAHBHYvDsrSHTF5SSEKwcUCMWDv4+DSM40OHZoxUb8eNLK/a1IXWDTKzefHNj3Jm1hCrZuz4L05DpJqvydcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582435; c=relaxed/simple;
	bh=FS//1TZSs1WZ3YJFiPtPltho+lKyma1cTnaZdC4fbXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urn2ymxy8Ly7sO4QpSQkXdcMEpraFjN8yX7f2ZICSbzwYZZZUhw9WTjCeR827TB05YGj4HavimGkl9fq0u8G0LfbKoz6H6jEgqwCaU9iEKxGVOCNZ+ZcLBeDf+7RyQYQ/aRwXNgVW8oZMaG/KqJ0pv/lrlpXqkQrWvrB2DgDPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9sw+RsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BABC116B1;
	Fri, 28 Jun 2024 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719582435;
	bh=FS//1TZSs1WZ3YJFiPtPltho+lKyma1cTnaZdC4fbXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9sw+RsB4P2csbcZLz2vEdy84OJJw2g40gHEBGepAb/SDZcoZJ8FybBky5QO+eQwu
	 7nVRjv1hyCLlFbWOHI3QbktLkNDNGKqeXATLAL4EcrTewN3XH36Dmg1ki9d39nAeuE
	 4vygeifYGCNzIn7xfJC/AWxmUedNC4vL6MYPyX4BftGMPGfhbgo2KYoaJOf2RQSkrA
	 hpCIjKwKsiE0dK91eQoQYIo8x+8YJ/AEW3vRaUGY6iWCCDdAMTkwQ5W2HdWMR0Bsrt
	 OruVUvGhR3IQh0wo1FkgtA1wIpfjGJKlkwZyX7qCz06y5pusXL86gtq6SewaGFdn6B
	 hbMXBLoPSOCVw==
Date: Fri, 28 Jun 2024 14:47:07 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH v1] selftests/harness: Fix tests timeout and race
 condition
Message-ID: <8e6bc353-fd6e-4fde-a485-304d0a823ad4@sirena.org.uk>
References: <20240621180605.834676-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JV1AaC4VJvVDdUvj"
Content-Disposition: inline
In-Reply-To: <20240621180605.834676-1-mic@digikod.net>
X-Cookie: divorce, n:


--JV1AaC4VJvVDdUvj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 08:06:05PM +0200, Micka=EBl Sala=FCn wrote:
> We cannot use CLONE_VFORK because we also need to wait for the timeout
> signal.
>=20
> Restore tests timeout by using the original fork() call in __run_test()
> but also in __TEST_F_IMPL().  Also fix a race condition when waiting for
> the test child process.

I've given this a quick test both by trying to apply it directly and
through yesterday's -next and there's *something* funky going on, the
epoll suite which was one of those hanging is somehow not getting run at
all although the binaries do appear to be getting built and end up in my
kselftest tarball that I'm deploying.  However the ptrace test which was
also hanging now manages to trigger it's timeout successfully when it
that happens so I think whatever is going on with epoll probably an
unrelated issue, I didn't get a chance to look at it properly.

Tested-by: Mark Brown <broonie@kernel.org>

--JV1AaC4VJvVDdUvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+vtoACgkQJNaLcl1U
h9AqVQf7BmANNDmwNfnBCc9S2hO8F3nCGHpPjwO7+27UYm4fg/pFABheUYMAAXqz
ezA0MkUQzic8Yv+OiJGLOQpjV3yblZ/iCZFemFmlvriyUmjZ7bK89oSGWhuKSziQ
GeyuSNX5pbkeEGeLamwHho/VSgMpqpAOWDLRUGhO7pfXvkfzLmy7aZu9NPHUFWDP
J18B/hUgwaWCcp6KYoDI8ZU255BXL1IdFEgDJSLYX2PLFISKOPq6PLzm7WRG6mIR
QFlJGHGNdoAVC6bs/HhrYzCAbooYyFk0enmAHfTCPeyRLiavC6yCVS+nx/Tgy5QV
4sgGN34sDpgSN+nRM6LbmgpUzv7rag==
=MYSk
-----END PGP SIGNATURE-----

--JV1AaC4VJvVDdUvj--

