Return-Path: <linux-kselftest+bounces-33462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB073ABF5FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 15:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580631BC487E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAE277035;
	Wed, 21 May 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXIQqED9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAD267B74;
	Wed, 21 May 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833754; cv=none; b=RMGeC+x2D2FMsGqS64zNtTETOTTMKskpUMn7tzY25zQorgd1547hqnCvqbXS4txbsNLZ7MtYJ+ejumbUHCJGTq0IIZhKqXeXnUXzMCBBTDB8hLq5oeANGQGwcCDQfUeEfM59wSw8yvn5LhQIaMAP6V9jm8MAp15QFzgFP7Ktp00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833754; c=relaxed/simple;
	bh=bCBWcxiWDU6PjGpBZmA3DyIcHmcuPZXNGNPh9vZSu/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbyKgzUIXRymPVV8qCSd7IkCzYmO4kY/zaZ/qR+EtwqOSoBhZG/x5B8+3h1rw66ivVIVupcjnde8jExd0gvP8JIr7YqtQPlbbV6XpbRtvkoFMo8onA+Hp+aTOU2zJ3TItU5Lz1pKR9ab2xRawD9xRy+pLWTbN1rHR8LMMdVoAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXIQqED9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB6EC4CEE4;
	Wed, 21 May 2025 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747833754;
	bh=bCBWcxiWDU6PjGpBZmA3DyIcHmcuPZXNGNPh9vZSu/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXIQqED9pD1RgmdUZHIf2/fJ6B88SP7EUVt25qVXFeGkG8vgq/UrHd8xSVe8aBrrS
	 KthV+ywE3AX475vSRu+DVdrruf0LqGMtmHWfmSLK16JlKf4FUrLDN2sElmhOQUTxK+
	 afe7ConIu8pWZ4VL5r+pL3HCDLlfbCuoLsYEW5fgaiUU/Y7GP/BGiZEVlA+ka6YPl/
	 l3CeAkZDFNMNeoCYKkvA9+S3dRyBwz8cn0sjqDCc9SdJ7PBEAaRUWsk7EP0VOUpEWA
	 R0XibwhJQUZQzopUeH8dDkpYr9Ohh6fT7oCQZCFKO1zv2GD1aFITmZrZjb9YPTlWYx
	 0W8w++GsyjM1g==
Date: Wed, 21 May 2025 14:22:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <744a1aa8-1efc-4c20-b45e-070fc038f6e8@sirena.org.uk>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
 <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
 <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="istvV2yEVqeEXT2+"
Content-Disposition: inline
In-Reply-To: <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
X-Cookie: 42


--istvV2yEVqeEXT2+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 03:08:05PM +0200, Thomas Wei=DFschuh wrote:
> On 2025-05-21 14:03:37+0100, Mark Brown wrote:

> > > +/* make sure to include all global symbols */
> > > +#include "nolibc.h"

> > assumes that the nolibc include directory is in the include path, or
> > otherwise set up with a -I path, previously you just had to include
> > nolibc.h with the includes that are there working due to being relative
> > to nolibc.h.  I'll send a patch for the arm64 tests.

> Thanks for the report.
> Inside sys/ this should actually be #include "../nolibc.h".
> I'll doublecheck all of sys/ and see why our new header checks didn't
> catch this.

Ah, you expect what's currently there to work - good.  I noticed that
the vDSO tests had a -I for the nolibc directory which made me think it
was expected that it be there, it's the only user on most arches.

> > It looks like the RISC-V selftests are also impacted, I didn't spot any
> > other users that didn't already have an -I.

> No changes to the selftests should be necessary.

OK, that's easier for me!

--istvV2yEVqeEXT2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgt05UACgkQJNaLcl1U
h9BEUgf+NXAxTLZGGcacSNBCjGp2GbVKIF+yWoENjpe/FVNqj6IQ2Y3hag4unV7g
8IkRlBQbZx2tr4eDIL4kW5ABrpCs1YeC9er0b7B+V65SA3P1HcEaRdjpBhl7Po1t
TTDKMYXC4BOXccUTnIVPGPW4GQJK3wA2mfjWjHpFgilTuSzV4ww1aH+J8XlJvVKS
liHSeBBkQflZeC5bEzC6hJTXlRai1rAod4gATSB6AZ1XVRHeYd8eDegap2YSZogW
+LdY75L23dodgfNKnIamjykcJf20gVYP+XfZcjLahIp3fTXVyM80HYg5VUtrj2gK
eL5TrxTv5VNHLDrBuAaZm8EMGhPL+Q==
=kJ28
-----END PGP SIGNATURE-----

--istvV2yEVqeEXT2+--

