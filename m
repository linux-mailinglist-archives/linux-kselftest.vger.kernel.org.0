Return-Path: <linux-kselftest+bounces-11117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09328D8747
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 18:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04941C21A54
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F4136669;
	Mon,  3 Jun 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTDQCUZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ADB132134;
	Mon,  3 Jun 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432072; cv=none; b=fHfa9D5SnfamtRjxlaQtTaVIvqi6zDjsq3qx6yseItXeAizt2r3H7+qHNnVHBnfu6XWOBm7DGzJobLhL40UgsDrtdheglEBcDFnO3EB5N45yRzo7qLR90BHmEN8cKJENGJqLsuAUWldGupQiE3tmmSxSdyugn3tEnzQwSuyW9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432072; c=relaxed/simple;
	bh=oRnkuVfmEo68h8xsojH0l6YCZM7vKTDbSA9MjVX8lcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkAUgo4ChS62jfRRc0Il/QszXYDEKcSLFn4j/vz1tCRA5DOU/FudeZKXOq+c6bUG92/suswTOTiPz6IvYKNYCWrK8Y3e4zAHaJEVQuof/G5VSNYFt80q4b4uKHLYYM4YeUsFlQZBbBfuAVi8TdKPsyE5fo/XvJsYZB0vmbwYWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTDQCUZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A0DC2BD10;
	Mon,  3 Jun 2024 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717432072;
	bh=oRnkuVfmEo68h8xsojH0l6YCZM7vKTDbSA9MjVX8lcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTDQCUZ72bRlkxaGtCsAqytSxIUqNNsLDD45miaFV68weGEv3pg0ZBst7gtAFNIHg
	 zItZc18cuDfFBVyrhoFztU2cZCGIWsYIvFgCm3YdtCqJJawZ7JI/Rcfw6x4j2IZuNm
	 wwJJnVm1re9PVNhckzmO4qN+yp2hxSTVPI17Q40/w4gqcKB0pn1NhpOIhIbwfXZjFQ
	 gn+dAf2KAveEpqKNb2RKKaxGVKty3ReE8eF2T8HVjYENoq4KpNogOFm0XQ+8Lrd6xP
	 UG/I+9/1iOTdEh21gPaiAwQKeyuOEKiy2a32p5eL1hmUC05Z/BUe9Seec1FGNDQq4x
	 0f06xk90PpiYg==
Date: Mon, 3 Jun 2024 17:27:43 +0100
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
Message-ID: <187423fb-ec78-4318-9da0-5b27df62b71f@sirena.org.uk>
References: <20240511171445.904356-1-mic@digikod.net>
 <20240511171445.904356-5-mic@digikod.net>
 <9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOjdVNyedpGvq4UL"
Content-Disposition: inline
In-Reply-To: <9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk>
X-Cookie: Don't let your status become too quo!


--fOjdVNyedpGvq4UL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 08:07:40PM +0100, Mark Brown wrote:
> On Sat, May 11, 2024 at 07:14:39PM +0200, Micka=EBl Sala=FCn wrote:

> > Fix a race condition when running several FIXTURE_TEARDOWN() managing
> > the same resource.  This fixes a race condition in the Landlock file
> > system tests when creating or unmounting the same directory.
>=20
> > Using clone3() with CLONE_VFORK guarantees that the child and grandchild
> > test processes are sequentially scheduled.  This is implemented with a
> > new clone3_vfork() helper replacing the fork() call.
>=20
> This is now in mainline and appears to be causing several tests (at
> least the ptrace vmaccess global_attach test on arm64, possibly also
> some of the epoll tests) that previously were timed out by the harness
> to to hang instead.  A bisect seems to point at this patch in
> particular, there was a bunch of discussion of the fallout of these
> patches but I'm afraid I lost track of it, is there something in flight
> for this?  -next is affected as well from the looks of it.

FWIW I'm still seeing this on -rc2...

--fOjdVNyedpGvq4UL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZd7v4ACgkQJNaLcl1U
h9AM+wf/ZmkJuaskXgcwXDXT1jI3wnrjvwPBo1nyTsX3wcmiDZXCGtR9qwuVn+XC
0N4ICDlxmX4lBZ8v6GJhe1blCagYT9WHp5g6aVe5D/kAf7m0IJG+I8JgPWjjg0J+
QIZ6vf4WjCml2ZpHWv/gB8ZAJeZyiRvpKlldLnZfrzJaGQFx4hhIj2G44jUa4T1y
3yHEgwaZfeeAYa2jZ1sZYD74zrPceqOUF38syHzbT9OgKDbPxXtI4KKDjXwe/aTp
6IOZMgeT5ivv0/47+PtodbX2QXl/5fSpQ/LOUW55xzIarOAhPx2EsfcBQW6RTaAv
R7Vzezy0MyONRIEvmdT1iCjwnlZvDw==
=tzUV
-----END PGP SIGNATURE-----

--fOjdVNyedpGvq4UL--

