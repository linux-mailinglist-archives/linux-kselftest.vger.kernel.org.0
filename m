Return-Path: <linux-kselftest+bounces-34700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F3AD5529
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9E17F60F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452927C844;
	Wed, 11 Jun 2025 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jypLM2ze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A5236430;
	Wed, 11 Jun 2025 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644054; cv=none; b=gtWJEL3sP3TWMQlzwStge/KgO5K2BdvCZT/0RWEudu5W398m/7Ew7wrj2D1nY056W8+zlTcCujtYC66Er3dPO2yNzQgFzdWn9trhsX2KBLMEEQCemkrU1eeo8IPT4jPmkQqfJVY0ROb4UtMr31VFJEfg7YKvRnVlVmb4lp2L7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644054; c=relaxed/simple;
	bh=8W7y2ug/7YME7PexfXOiPUIhgjLNDFmxSgAqpvaKdEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLbRSYsA3SsU6vx7BQ0PGDsKYDVZ9WlUUaP1RvgS4Is105/9it/GPvdpdE1WDgiiOgCQGg04H+kOU54+/WxI0oJiDYDgyvdxI8lR8+F7hfKc6vGbRirByBoYKHWfzlq5h383MLbeOpJ1A9jZsDXJwo+IF0T87KcwpLvQRc/gj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jypLM2ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A064C4CEF1;
	Wed, 11 Jun 2025 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749644054;
	bh=8W7y2ug/7YME7PexfXOiPUIhgjLNDFmxSgAqpvaKdEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jypLM2ze7j8YPZmlgol3splyOSTyUY06tVScc/UnutpEaakTmXWCMEsK9FI2XoHCC
	 Ty3qaMoBueEyk0eWQIFLRGt5lPlJsfO5E0/xboOoP/Hqk59eOtgo11Vq3Ps4USYcDY
	 wgoZCqsdHec51pavWnBUPc0pIodd29stmHHxfHOD1iO1QylZOTP82mFBgqnQGcxlr8
	 h2tPPFOnzZbVGVs/Y7bcHEKw3InScxojSOC999YdXwQKZgmqPNC3egeLVgvjXd2xCs
	 2bDipvYUMXWABjKyxYLSunuxYldLjNrPDRsov3ecvHZ1KFvDoI7AAyARiJIemli4Ko
	 KTwYZO1XHCk1g==
Date: Wed, 11 Jun 2025 13:14:10 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests/mm: Convert some cow error reports to
 ksft_perror()
Message-ID: <4ae56ed1-c25d-4ace-aeff-f97884246c41@sirena.org.uk>
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
 <20250610-selftest-mm-cow-tweaks-v1-2-43cd7457500f@kernel.org>
 <e88999e6-8c79-4273-9f6f-df28d016cc6e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2u5g+dpnZc+yRuyy"
Content-Disposition: inline
In-Reply-To: <e88999e6-8c79-4273-9f6f-df28d016cc6e@redhat.com>
X-Cookie: No skis take rocks like rental skis!


--2u5g+dpnZc+yRuyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 02:10:20PM +0200, David Hildenbrand wrote:
> On 10.06.25 16:13, Mark Brown wrote:
> > This prints the errno and a string decode of it.
> >=20
> > Reported-by: David Hildenbrand <david@redhat.com>
>=20
> Probably not "Reported-by". Did you mean "Suggested-by" like for the othe=
rs?

Probably. I'm sure I was thinking something there but not sure what.

--2u5g+dpnZc+yRuyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhJcxEACgkQJNaLcl1U
h9DfwQf/SzWod9RbWKqPK86WfL2gkBooCAQCzXdR56dwvobuGo/74De4ozPz/NNT
5FRwmDEewKWDV6NVZ9v+J93OC4d1/owoecZ5hBPCAi39pYQ/3U0k2tYio8LklcUh
o6zzMPaPtsXmVyZLqwCgdl69yFkAQNvdED1bjATnRDcI3rGzOXjXe6SGWS2LIQuS
nxJecqJ/pqUaZRWdGawzl3b5GYfZtG+ujOKF7RNj5rd7geSqSrJaNa55p/cS3GpN
nrPaIzZAdW01FenWBZ61RCSW2es+UZaXIfBO2G1b8nQgNz1ttUHCQ9Z2+3W/MEM/
qRS9UCBJesVOoRXQJxynyDvGBrP/XA==
=Xt5+
-----END PGP SIGNATURE-----

--2u5g+dpnZc+yRuyy--

