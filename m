Return-Path: <linux-kselftest+bounces-31299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49DA9689E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 14:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AE7178789
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE327CCE1;
	Tue, 22 Apr 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw6uWJOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD427B51D;
	Tue, 22 Apr 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323852; cv=none; b=dkxw+i2IoObxTj7PLQZWUsQzNcBIsN5B3wvyqsUjhewq6jDOztObiyq7E+eoYD854nU6K4PBMQnyTSpHLtP9db2RrRGiKAO7uY9lzdnar0ZjZrwWGz31Pyrq54iHNpquF3v7LeAgP+fxUaZEM+R25jZusoE71QJLZypFjA61k0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323852; c=relaxed/simple;
	bh=94jXciuuUSY9QuhItKiQptIuzEJLDtkPg4FjL9VSNNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvQEbuyquHYjUfD6JFbf7E8kZzV696B/sAHQU9Etembd1eVulEY4HyBt0Cy1Z0xevs9S+ThNWHoSxY/muYWJfKpj+NIoTr3WtBjfzoPCpH6+tLlAjzHVhE/EgwXEp+oXOLhmi1+vXa9b2vu2JkhYM3yKE1o6aizj/uTzfkWcf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw6uWJOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA72DC4CEE9;
	Tue, 22 Apr 2025 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745323852;
	bh=94jXciuuUSY9QuhItKiQptIuzEJLDtkPg4FjL9VSNNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kw6uWJOm6W2vov0Xou0Q1nwXyRFOzbfmCDBgCrbyv43JYIKsL2tC2RGg5ytkQoiYp
	 C90/VwxumVENrW54coSVlbVYF5xqbRDoIEAu8iyu7wGtjjGVTIbs7Py+6TsariZDrj
	 AUuSi4sfKUpd/skZy6Ff+TCtL1OyBptDHN9DBpcevaDwznmwF6g8FNEHZH6bnSs0Dk
	 Nl8ReR6ldekCvrsMN02J3OrH2YDFoJJ5oq7uCXhfaqjVgaa8Pr/piThWUdSBiIZGR/
	 jScCVakKXMn9dLsUmUaXhwIm5RuHFmXKypDrXP5f/PMvlzMe8cfeszlLEK7VWW9drR
	 7xiKBTQvHgRBg==
Date: Tue, 22 Apr 2025 13:10:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: PRIME_NUMBERS_KUNIT_TEST should not select
 PRIME_NUMBERS
Message-ID: <f2a55a3f-6c56-43fa-bfda-25cc11fe5212@sirena.org.uk>
References: <40f8a40eef4930d3ac9febd205bc171eb04e171c.1744641237.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="peTE4oWe+GxHaYSy"
Content-Disposition: inline
In-Reply-To: <40f8a40eef4930d3ac9febd205bc171eb04e171c.1744641237.git.geert@linux-m68k.org>
X-Cookie: Laugh when you can


--peTE4oWe+GxHaYSy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 04:35:00PM +0200, Geert Uytterhoeven wrote:
> Enabling a (modular) test should not silently enable additional kernel
> functionality, as that may increase the attack vector of a product.
>=20
> Fix this by making PRIME_NUMBERS_KUNIT_TEST depend on PRIME_NUMBERS
> instead of selecting it.
>=20
> After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=3Dm to build
> modules for all appropriate tests for ones system, without pulling in
> extra unwanted functionality, while still allowing a tester to manually
> enable PRIME_NUMBERS and this test suite on a system where PRIME_NUMBERS
> is not enabled by default.  Resurrect CONFIG_PRIME_NUMBERS=3Dm in
> tools/testing/selftests/lib/config for the latter use case.

This commit, which is now in mainline, causes the prime numbers test to
vanish from my CI which is a regression - the selftests config fragment
is obviously not picked up by the kunit runner when it builds the
kernel.  You should add any KUnit tests to one of the configs in
tools/testing/kunit/configs/ - generally all_tests.config.

--peTE4oWe+GxHaYSy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgHh0YACgkQJNaLcl1U
h9BAbQf+MLaR8l9s2WvjLTYBFiZOVsUlKyZEcRQ7+JooNMQJU3Cu73gcjSLNPZta
E71k2bqMfdc90BWdrR++BLYWTX6z7Sat/tzmbTUrBdDBi0jCOQo1AWbpgJjitMbT
lCYZ3/yeDoCc2Mj9e68jsKLsFZkViuTJeBaY9666wMviHd/7DNh2DUZ59B3bNNyr
+Dln8YH3J46agFmF5vooL9rZXmYoYWkIq5aC4fXUsl4vCIlCCI0S1LXiFsM2Op3t
JZa9KRlgMz0PtjVfhPwTMIQl7w0EhDpwiBULg5nkzpnAyhlob9QZRpZlR1juLWPX
UnDoRyQrZOQ6qnqIGjDr2uEnGcafoA==
=FhrA
-----END PGP SIGNATURE-----

--peTE4oWe+GxHaYSy--

