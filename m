Return-Path: <linux-kselftest+bounces-39855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418FB34605
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6616016A40E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721102FD7AD;
	Mon, 25 Aug 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyNIFgz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CC2FD1B1;
	Mon, 25 Aug 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136339; cv=none; b=AmQIDlXTCtM4wFUym7KCP+YTP//YZvbDXh8dEuccFhGJG8X1ffy81y/p9dLSj1eZ0+57iT97eFAeYbREkUiGY2wnCBL4pjkfMpdA8xSP7JDkvblGCmbtz1Rgg/rsq2SdAszfrE2F/yCn/j+EIl8WOE0LPeMzjYRYMA6im5pfh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136339; c=relaxed/simple;
	bh=VdXv3IR0RyWcnqK9z0T8Vm61jcDrRrzxkUdL7zyiyk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjOM30nMTQG1s/UaoPDfYCpwiHe70zmF2TPnkzT/dPfx8/FLOWlMkJroJ2wJis4Kksut+ba40XyQk2JwkQSJ5u2bloPEwDTmawVEeWzu7EiIBxaKAIOUh92wjEiVCuyvq76/q9qMaP0iv1jlA6nAmF9mV7A5c3WzysLnwjLNdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyNIFgz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784AAC4CEED;
	Mon, 25 Aug 2025 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756136338;
	bh=VdXv3IR0RyWcnqK9z0T8Vm61jcDrRrzxkUdL7zyiyk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyNIFgz5d7kF5QOI8fGg1u2r4gVyyya04fhU2Wgii9toCRMvTmLPh7SsQ2MCnwtgz
	 D2lhNb2TH7NM5JgRtZDYZEWXQHxcUR7fMFB5/5xF4Xijjf//4tyu8O/cnbL1L8IGLP
	 +9OsW/dMIAM2L5Sm4L6eZHoPrjy09IHoLZJtyMNKXUeLCTztOfeH+H5EiLjfwrNCHF
	 +Mak8iXXiJx+FXwoQ4JxLVMze0bcLgotRldIvPoG4S/v3qU5N+M3GSdfQTPdiU4E1k
	 sXz527Db+jurmOHVkVgefaDe/fq7vHacIwjEQx5+v1/EWggqVDGxuvxRmhvLccQMGW
	 mVV5gDkwiCEaA==
Date: Mon, 25 Aug 2025 16:38:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: shuah@kernel.org, dev.jain@arm.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: fix typo in ss_flags check message for sas.c
Message-ID: <aKyDj8DNOWxBVNkr@finisterre.sirena.org.uk>
References: <20250824191721.631980-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WVCgYumej1Gh08AI"
Content-Disposition: inline
In-Reply-To: <20250824191721.631980-1-alok.a.tiwari@oracle.com>
X-Cookie: Filmed before a live audience.


--WVCgYumej1Gh08AI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 12:17:16PM -0700, Alok Tiwari wrote:
> Fix a typo in the signal alternate stack test where the error
> message incorrectly used tss_flags instead of the correct field
> name ss_flags.
>=20
> This change ensures the test output accurately reflects the
> structure member being checked.

Reviewed-by: Mark Brown <broonie@kernel.org>

--WVCgYumej1Gh08AI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmisg44ACgkQJNaLcl1U
h9ByCAf+KiGMPqNLxXZyjSYP2N7gAZwtjvHWxMJ3nxmYNfPiEpZt07uiGmrSXFcU
wKPWILT0SyMuBWy+DZLwpO1J2yFWpQ+zKlUVpt10s2uEiSz9faxtp/aU4Dr2NcFi
QkxYvElN4ikgFCuo3A81XdiMEJ/6NaZtnXjBU3a7pnLzCxZ9zhNq9ZwQqBwtrFs6
C6bV22BC2QnwgsJqvBth5Oy9SB4/lZpOjvVKmULZ9jmbgH4rM8rsImQ/uk+tRjHP
Jj3NqPqoeJOMElVt3meI8v0YIXtRO7fns+AbhCD7M2ZjLJt0ZXqKX4xeink4haZ+
Ae5RKApxy7FTbcK5qP4ipSr/Y2lo3w==
=Y6uD
-----END PGP SIGNATURE-----

--WVCgYumej1Gh08AI--

