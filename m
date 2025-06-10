Return-Path: <linux-kselftest+bounces-34619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C43AD4058
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 19:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B94516992D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD44C238143;
	Tue, 10 Jun 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5W8FrX8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68CE1EA84
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576091; cv=none; b=QgtPFvJcHJi65rSGQBDHQaSwMTqW9ivK5O1s35OKljE8FCnIR1XSSqUWuGh5YOa2xLcQHEJ54f5anveDL6VM+OguNSY6yJ3PLrUfVzA9y+J6nnQMtWog55L78o6P8kihhmvhWnuk+2lw5I+1YPWLcY2iK+cert0RhyYxtYYeauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576091; c=relaxed/simple;
	bh=uMUbDDWbv5sCEg0wSyQ8mfK14YGIgnjUU7mUXHnNmkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0exarabdKL3Hg2bR7vEMOHt1kHKUE/APlyi+nVyTat9afLff0sTDgD1aXZC+XtrztqmKJa9SmF3h50Gxd9P9oXVGCQulec140g7m191q+h46V/2AQtv2rGJIm+kobJFnFPpCeuC79vMo8HoApfAJTgUjZjL9pgmqR0cQ2csy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5W8FrX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FD6C4CEED;
	Tue, 10 Jun 2025 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749576091;
	bh=uMUbDDWbv5sCEg0wSyQ8mfK14YGIgnjUU7mUXHnNmkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5W8FrX8vJzCA9tlBAky6AfFI8j03Hulw1Lff6BoOSmC7FyxImBimfdHUmaewntYS
	 8uHbHqR6fkMbdizPOpQczYyLBifLAlzCXT85FXe/QWCIc4WIupRxSOEN2/ZnwjDzUM
	 rXtLRzg1bCQFxyB3864jTAqOHCEMW81BW1oTPfB+1noyEjceRCeTP1OsVdpjIs2XiN
	 jJehePkl6QPz3EYV4MAwtGCPVioAFfGBB23Vv55Qeko4zPsg0JP27Hj9WtpDuo7o1A
	 na0PoVVNRQ9WU36UuC1ZMMZcUHFf84MRg9TIqi+gZyuN/ixsepCQhe+Da5E/YOqe5z
	 Hh9qIA4r9oWFw==
Date: Tue, 10 Jun 2025 18:21:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: nolibc test target overwites kernel config without asking
Message-ID: <3f874365-c113-442c-a32f-f0b9611f999e@sirena.org.uk>
References: <3d5128b9-b4b6-4a8e-94ce-ea5ff4ea655b@sirena.org.uk>
 <5df3037e-2486-43f2-9fc8-e0aeb716c848@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wFropd4Gc2BtY91J"
Content-Disposition: inline
In-Reply-To: <5df3037e-2486-43f2-9fc8-e0aeb716c848@t-8ch.de>
X-Cookie: When in doubt, follow your heart.


--wFropd4Gc2BtY91J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 07:05:59PM +0200, Thomas Wei=DFschuh wrote:
> On 2025-06-09 17:42:47+0100, Mark Brown wrote:

> > KUnit deals with this by doing it's kernel build in a .kunit directory,
> > it'd probably be good to do something similar for nolibc.

> I assume you are using "make" directly. For a more complete
> kunit.py-like solution we have run-tests.sh, which does indeed use a
> dedicated build directory.

Given that the tests were in tools/testing/selftests I initially tried
to run them via the selftests build infra which didn't work since
they're not glued into that at all and I ran into this as part of
debugging.  It didn't actually occur to me to look anywhere other than
the Makefile, that's how you normally invoke selftests.

Given that AFAICT the tests don't use any kselftest infrastructure or
otherwise overlap with it I think it'd be better to move them to
tools/testing/nolibc, that'd make it clearer that they're their own
thing and avoid surprises.

--wFropd4Gc2BtY91J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhIaZYACgkQJNaLcl1U
h9DgRAf6AxP0bXmbsfc7J1mcxRBArqguj9lcn2JHH1EbbEKPmc4pA+akL1mpSLqg
t29OT/v8Uf81e6Co/SGgtHkWLpxeYaUeKy1Lu/K31h8OYoRyog59TTSX/nQ4I+Kj
1oGENyZQI+Crnwv0Wyf49wls2BCvHBzjc1/dXQ9kJyguHaOtVzw+Bh7H3ch4Pabm
v++R/au04yhWKr8QF8UWgEzfm9zrTSOlxuhitvKlw+IQrKFcl4lAGULagbxN1UkK
fZGZeQd1aIPP2x7HIlAf0eL9LZuFAODDa6gHE4svx0pDam/YXtCWddaEGMONBelE
2AJDuKNTqhQO75YRx4psVBjg7UUpDA==
=wNfW
-----END PGP SIGNATURE-----

--wFropd4Gc2BtY91J--

