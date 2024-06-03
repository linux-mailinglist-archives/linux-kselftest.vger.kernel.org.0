Return-Path: <linux-kselftest+bounces-11119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1E8D87D0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F022F1F233E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05563136E13;
	Mon,  3 Jun 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShGdTUIW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80C1366;
	Mon,  3 Jun 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435360; cv=none; b=DWtorLhX/bCEnlAnjHI0COvSlOKrdLtetpcivTxXu7Wu61y466X76zaP1GSftJh3bh6Jf/dLrupyvnYNzOpJm2uTQC42sKDCpx3B31xAKcExUU2CYOhfZuALGuMzljOqSuXDS4Bm2/Cp6mu0apOKX2y8yqGhWHaoHubtjEmWWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435360; c=relaxed/simple;
	bh=PAcBig0jr2i/6jcLdHClnRIG0MzC33BZQfOwMSR1CeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua7Vu2pnTaNp7oV+s+RiWP6mr1ZMuGrufafjK7/ic6ubQoGII/YKes5+diJMQ6zaQSQoNHXArzOuBc6CGKshGicy4nhmR0z8EjSGNhrP9wlbctm3SCZ2vtno1jxycOpzjrVh9EgCWAD9GN5NU97F+PT/aUuIgwoQYkkQvvMIMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShGdTUIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2BCC2BD10;
	Mon,  3 Jun 2024 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717435360;
	bh=PAcBig0jr2i/6jcLdHClnRIG0MzC33BZQfOwMSR1CeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShGdTUIWtmzffiVjGvECIt5B2x/fwBnoKj6QesSZaUgfY9ZNM4xxYh+FB/v5gNubB
	 Y6hlpiaX2JT+xl4m9pwrbdO+z9xe1ENN75Wgi/WWNVRWe+LN8IZNjJQuF6umoh2kKN
	 DaaN2G5lLIXuOoVucv4Rap3sKiGmv7ehqOZG5q4V8RzX3oZgf2J0nut/frhmfVi/Ny
	 LQctRCkYzDWzYub9hJAGYVrK7+vXbb8jfPN6EDYBbO+4v6/tHW2RBDI5MmrJiDkk+Y
	 L83CD+yokh0imQYenPefjX+kpnycLECwQ0cJuh9I7ZAG1kvwyXNhhE+XaOj1uMftcN
	 yfaxAgcuhkzzA==
Date: Mon, 3 Jun 2024 18:22:32 +0100
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
Message-ID: <9eb1e48e-b273-475a-9740-52deedf11ee2@sirena.org.uk>
References: <20240511171445.904356-1-mic@digikod.net>
 <20240511171445.904356-5-mic@digikod.net>
 <9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk>
 <187423fb-ec78-4318-9da0-5b27df62b71f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="46cg5PHekJwEmoXH"
Content-Disposition: inline
In-Reply-To: <187423fb-ec78-4318-9da0-5b27df62b71f@sirena.org.uk>
X-Cookie: Don't let your status become too quo!


--46cg5PHekJwEmoXH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2024 at 05:27:52PM +0100, Mark Brown wrote:
> On Mon, May 27, 2024 at 08:07:40PM +0100, Mark Brown wrote:

> > This is now in mainline and appears to be causing several tests (at
> > least the ptrace vmaccess global_attach test on arm64, possibly also
> > some of the epoll tests) that previously were timed out by the harness
> > to to hang instead.  A bisect seems to point at this patch in
> > particular, there was a bunch of discussion of the fallout of these
> > patches but I'm afraid I lost track of it, is there something in flight
> > for this?  -next is affected as well from the looks of it.

> FWIW I'm still seeing this on -rc2...

AFAICT this is due to the switch to using clone3() with CLONE_VFORK
to start the test which means we never even call alarm() to set up the
timeout for the test, let alone have the signal for it delivered.  I'm a
confused about how this could ever work, with clone_vfork() the parent
shouldn't run until the child execs (which won't happen here) or exits.
Since we don't call alarm() until after we started the child we never
actually get that far, but even if we reorder things we'll not get the
signal for the alarm if the child messes up since the parent is
suspended.

I'm not clear what the original race being fixed here was but it seems
like we should revert this since the timeout functionality is pretty
important?

--46cg5PHekJwEmoXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZd+9cACgkQJNaLcl1U
h9Dq9Qf/ayW5k2h3cIM8VUJF25GNHiI9zuUbaWYwfO31cGn2pVzpron7bMjMPquc
mSEU7tXShn2QIvp2ihL+DGLgAWH8YPqoE6U47ifgpIU2CNHJhd6kqdqr8gBSqqoh
qJ6UnxIlpcMRaudyTcBD+6Jp5riheZnt7Fhaiysdlrp0ba8ByRGktZQ6aRWCy0tp
pRTY1U/MdKZ7dJ7jfNx2fKsmpgZnesoMnCjDePEc4/UqOatbJ8Yug9F1+CgmKM8J
YPNU9qRl7KqV+1J/FAbSN1Ncla7G24E5xZHk+wlg2+YVfEGSuOqETgviczCbglPs
u3axeb+jU57c8gYgrDhSASu5UN5IMw==
=SmQ4
-----END PGP SIGNATURE-----

--46cg5PHekJwEmoXH--

