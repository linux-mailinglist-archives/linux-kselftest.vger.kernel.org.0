Return-Path: <linux-kselftest+bounces-4187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CD84B247
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761B61F23B4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64F12E1CE;
	Tue,  6 Feb 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzFXWqzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A112E1CC;
	Tue,  6 Feb 2024 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214584; cv=none; b=CLrOhbXCGrdeyBgAXl8jGfl1FXRC8P1hdLqyhy9omLE0zGMzWqq3hQXbBGqESyicP9PVZmABiMG7oVVrx2/jcF5YZIs2MMf8A6CTvtb+M3CvTy4diua9Y8FJeuzTpfXypCSGZt15k/UrAfo+tNjr1MdmImJmydEhbUkR9+VLxyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214584; c=relaxed/simple;
	bh=wMD5eAY0iQmIfhYhlvS2fvz7hSPiZv7Z1ENCFiASYCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+Hx5oI70Cql5PmekMresUOPXqRsY/tVpkiSZue4PmWhSwNo+aDG5cuUBYIExPglmYXkkHs/nCcXcAKJd8uLUqxA68Lunnr1RROWMMFv6an8mlbMDRR17o+MPfzD0QBMGib3lnwnFRtZzPUyZkDbZge0TQLIBsuKWHmWBAHFbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzFXWqzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA5FC433F1;
	Tue,  6 Feb 2024 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214583;
	bh=wMD5eAY0iQmIfhYhlvS2fvz7hSPiZv7Z1ENCFiASYCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzFXWqzg8e3PBT9jW4dFw6fxwUbmu8CZCY9KGnO0NNUlxCKMEzTTSgQ/U895TntGr
	 9g93t5pFD4h7rY+JyD1ZeFjtv/oPTWipNHXF7yfZKiZiqeblaq31t2zxByP52dnEN2
	 WooPN0v5kPm5+8TM6l2YKD7UAqTpciIKGX9yQSC6iu4SEkZEmDbGSTVE4maXautYZ6
	 6xrezg+vAW4eMMi2JRxVczB1rl0DPAQ8ACateSbghWmvrOHUjEN/DacnOn+YwXXLMi
	 vCIPOdr3foPGFXBR+I+KPce9p62H2sQXWq2xkCm1oiqcW/zdPGb7JwDEloQL2X66A7
	 n/BuPoQuLjEYg==
Date: Tue, 6 Feb 2024 10:16:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Pin benchmark to single CPU
Message-ID: <ZcIG8y0U1VyMsCAD@finisterre.sirena.org.uk>
References: <20240206095642.work.502-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I7uCmILCv4P/yIfw"
Content-Disposition: inline
In-Reply-To: <20240206095642.work.502-kees@kernel.org>
X-Cookie: You might have mail.


--I7uCmILCv4P/yIfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 01:56:47AM -0800, Kees Cook wrote:

> +	/* Set from highest CPU down. */
> +	for (cpu = ncores - 1; cpu >= 0; cpu--) {
> +		CPU_ZERO_S(setsz, setp);
> +		CPU_SET_S(cpu, setsz, setp);

Is there some particular reason to go from the highest CPU number down?
Not that it super matters but the default would be to iterate from 0 and
there's a comment but it just says the what not the why.

--I7uCmILCv4P/yIfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCBvIACgkQJNaLcl1U
h9DubAf+J3cp6PF/Zn8lKA03k0dw+PzlRe86nz0UwqF++h7gW5aebKtTNG2+8fsA
MC0f3yJ8xCELVDN1HlDOKAbZgzUiHHAiBl/Np+b4qd9MIybOuwHf6A3quYZQi/f/
1zZTiA6zTv5Ai4N+2Zj5cSK5gc7e8BTzzej2clem7GAHYjMEo6kNOcGKF21Puk2g
ojpdD4VzIcmfk9CQimCTtZcMsCFEbcgKG9Rpbte64TQEdXyBDFMJp/AXhxqZvFS1
4B4rDcsHw2+4riVnUrtQsufpEpi83eQUfOh/4pkjuC05wiDjqYa+7szguMO0+s80
cXv9MJgxIYIv9ba/UjkKaSr5Yqs5GQ==
=FFzA
-----END PGP SIGNATURE-----

--I7uCmILCv4P/yIfw--

