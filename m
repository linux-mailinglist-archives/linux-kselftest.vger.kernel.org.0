Return-Path: <linux-kselftest+bounces-36547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE7AF921D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0511CA0661
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA482F2725;
	Fri,  4 Jul 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am+oe5Xu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333A2F2705;
	Fri,  4 Jul 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630550; cv=none; b=TSVskY+koun++9f1cg4Pg7r98BbvPuyvbtoTn5arxqMJ+I5qVTV5meY2VyXtw/bMBizCYlbHNGND4NbQH/Pj4gzL3Rg7yblZ292jxNyuugQPpAVB4VpvWpUC7aOrYw8/eXYA/lFFjflHgCKIEKdDyWkDr7OYzGJoEZ7blX/8fLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630550; c=relaxed/simple;
	bh=U1w4n/gNczm3CXe+WuY5bn1+RGT4rey/pqulyOcbhbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgoapSiYDyRsKFYtBLnwV/IpjyJj07A2g+47bANdCqb3Pz7x3zhhIVzesEMLzT9ZZycjkTzejraxXhwC8Mmw8VZUaM6YwoOS21xGq3rOE07v6xhd4F3idz2nEotPdnDei04tV4M4LgqhJY6KR+fZa2Jg23PUwPk6+c05K3fYd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am+oe5Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F13C19422;
	Fri,  4 Jul 2025 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751630549;
	bh=U1w4n/gNczm3CXe+WuY5bn1+RGT4rey/pqulyOcbhbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Am+oe5XudarJ8J6rflUIS3GkIcr+vL37yVMCwUuWWTvh88tHdR9EzvvcCKJsmLc8J
	 zAl9yZXWy0XwmWB1NDrguJ21Ub5Yn54JrdnuQFvn58WldVwr9glHwwDjeE+1l9fQMj
	 d8UISBXtGp204qUY0/xAE5qDS1oz/dSvriUeO61WpDZi4UOHNXuklT5SyveEdMG2fe
	 d2uB+svcag+bG9NOYWNVL3K5K25OM+FU1cxtvk7muBSZJgSPKVix8jQXCwV5zew1ST
	 D1O80+PiYAXfj5QBy+9YbBVcjaA2/IoQQuz6j067aaERphVMxzufC4SIK24SlXFBUL
	 l5PRZ3u1ELbCQ==
Date: Fri, 4 Jul 2025 13:02:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Christian Brauner <brauner@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] kselftest/arm64: Add coverage for the interaction
 of vfork() and GCS
Message-ID: <33d51f33-3597-4a5b-b54e-0292f12aac69@sirena.org.uk>
References: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>
 <f438fc60-e602-4301-a7dd-bee43c020720@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oP7U7slU7zFgf7pc"
Content-Disposition: inline
In-Reply-To: <f438fc60-e602-4301-a7dd-bee43c020720@t-8ch.de>
X-Cookie: VMS must die!


--oP7U7slU7zFgf7pc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 01:27:28PM +0200, Thomas Wei=DFschuh wrote:

> FYI nolibc now has a proper prctl() implementation you might want to use.

That's open coded because we absolutely cannot tolerate the prctl() to
enable GCS being anything other than inlined, returning from an actual
function call would crash.  Probably for nolibc that'd mostly work out
but it seems better to be very clear about the inlining.

> Also your vfork() selftest uncovered a bug in the brandnew SuperH support.

Ah, doing good work already!

--oP7U7slU7zFgf7pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhnwtAACgkQJNaLcl1U
h9AJ/Qf9Era5xFOINBfLAUYT6xEchOrgAvL27i4SBKII/qTPPYq/fwUg80tdJhHp
69FDLh6r06bTjM/BBoZJy5vg1+Ay3TY0U3Z6PxPi+aJ1rbvjgnon/Us4ArL93iR/
lUSCNMWsDl6jUUHEEnCaAojywpRsVJlYedQg1pCty+CJ9vU9kod6CfqCNoN2AVM6
kYEan/gefBnhVMs/dxXaz39vTTSlLzJnwPUiYq2Gp6SErq5QuoTX2X18yIfTOrhj
p/vXn5K6VkDP93EeHOkBZ0c8gF6b79p9mVrKoRgPtDO8ZFmpefITt93MCLkq54Pk
KykUBHtIF6WqlFzbkAk03BJRFevcWQ==
=mjkI
-----END PGP SIGNATURE-----

--oP7U7slU7zFgf7pc--

