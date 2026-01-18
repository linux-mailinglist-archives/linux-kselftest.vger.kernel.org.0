Return-Path: <linux-kselftest+bounces-49305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F0DD39760
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D2D300762E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C81FE45D;
	Sun, 18 Jan 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvzTtIl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0C18DB0D;
	Sun, 18 Jan 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768749410; cv=none; b=Aorawqj0zMG8yro/RqhL7PlELrQgWfHS/ipRNcdhM8GqxXazgaHYGIo/Ly710MT3bNcDCd5NS6Db/kxm64tCUcq0LkSN+uKdXnL3njt8UiRM9q3WVT8ciEJDW1KUemp324oZ9lQ9VlQoP8YLD9YpVrieXglKSIEUDeuw9ib4gDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768749410; c=relaxed/simple;
	bh=zbjFQf142QTPll+HlFBxgXdPxx+czptb9ll+AkDvzCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co3IRAD1lOkYHhf0C1I4M/xY6EmLOYoRPf8BnUF+IMpO9PZpj1ToUgG1ofSA0jX/pK1uN9tuAcVxUg+NPogqKbwNfrZdp+nBtW3XbJbxg2ko6wfbzrK4MoWZ5/uttQkSVwJoDJ+yGvy0N9FbflSsbfZu6OCrLZOfSFGUwVZDefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvzTtIl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD0EC116D0;
	Sun, 18 Jan 2026 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768749410;
	bh=zbjFQf142QTPll+HlFBxgXdPxx+czptb9ll+AkDvzCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvzTtIl5xA9be4QGgqfj+yT7GFOYPBw5BtgESqPxxNbcwzrvWLC/qhdg4u+Y6BLJZ
	 zMF9SnrkRcMyPRuK0sTrX6u0zzxTE2bKrCllzsofmie9OYL0UkYDvF6rNoh811kWbw
	 b53CKhMMj7pxRvg38b63g5Dt/Ft12VE0osis/258rMIUnF7BvZbb/+WnDyhI5UHQ/R
	 anrb0HUDpIpA8da4rlDW7q9KM1Q8+i4FfTQYF9pVblCpFzT9T8kmh3Yacx/ZjDSkl4
	 IQlT9dljin/kV3PAUU7TZ14TFar1o0LvTtFeawufg1a2hMX/BLUsYcSZk/V3FcrsCH
	 ddaN+YFFAd8PA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0C11D1AC56A1; Mon, 19 Jan 2026 00:16:37 +0900 (JST)
Date: Sun, 18 Jan 2026 15:16:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Use syscall() macro over nolibc
 my_syscall()
Message-ID: <aWz5VDoGPiOrfsTN@sirena.co.uk>
References: <20260117-nolibc-mysyscall-arm64-v1-1-f70266a3db15@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0YxDK5bhyWkoEAQo"
Content-Disposition: inline
In-Reply-To: <20260117-nolibc-mysyscall-arm64-v1-1-f70266a3db15@weissschuh.net>
X-Cookie: Think big.  Pollute the Mississippi.


--0YxDK5bhyWkoEAQo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 01:10:51PM +0100, Thomas Wei=DFschuh wrote:
> The my_syscall*() macros are internal implementation details of nolibc.
> Nolibc also provides the regular syscall(2), which is also a macro
> and directly expands to the correct my_syscall().
>=20
> Use syscall() instead.
>=20
> As a side-effect this fixes some return value checks, as my_syscall()
> returns the raw value as set by the kernel and does not set errno.

Acked-by: Mark Brown <broonie@kernel.org>

Looking at the history the nolibc syscall() was added after we started
doing this in the arm64 selftests, it was 2023 while the tpidr2 test
is from 2022.

--0YxDK5bhyWkoEAQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmls+VIACgkQJNaLcl1U
h9CfBAf/SeWySUzi4DWG7/eYfuh0UqSkZ9GVeLEaP6CQVEBfhdQfDA+rdN/1fkGH
zzTWSCk8oMSQv1BTNnkREcYZQOh2M6YB1gk0ZPHcTdIjOKwxhZ73fiLrOnMzAtgQ
SHydTuSJeNJh1hZhl9DNGZmYrvHSaOBDWi5vFKeKIdnOlhZQyCR6gfrsN7JkzJjO
9Lnt9Q+Yy38sgyJJeks0dtCqyXUPaCFCg6q0Ybpm6tHrv0g3LXGByArkFxEGGdgr
i+ODI3vne00/mmkukr1sCjxyfrWTGeD+lLFy5nnsYGzWpTrC4Pa7lCnIzNYUmOll
+mForHW+scEwEHpSM5nKFhdLjo+bog==
=8Im9
-----END PGP SIGNATURE-----

--0YxDK5bhyWkoEAQo--

