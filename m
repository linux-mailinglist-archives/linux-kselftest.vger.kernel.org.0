Return-Path: <linux-kselftest+bounces-1442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDD380AAC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C08281867
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6039AC0;
	Fri,  8 Dec 2023 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR2wPhGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900D3984B;
	Fri,  8 Dec 2023 17:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D0DC433C7;
	Fri,  8 Dec 2023 17:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702056575;
	bh=3PxOBEXFDvmx4FoVcbn8IisqPaIUct50HbstATld534=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AR2wPhGk2fAvPLFyB3Mvv7cnFnjN2eshwUXqpo7nbjINXPmGWTywFfU5qIWajadZ3
	 3I49M/i8UhpWPOOLeLgfsm9R4lSCXxlzm2YsXNNkEKTmaNQ9nRHEyrSKp060VNRxxJ
	 NeqCYz8gto+GOKdtfXsrohiRfGBd0P4cjwkRP5Q4TaAskOMqplz5B/3+votUzVyAPt
	 ye65cjWTu3hlKebC7Y6C9Ychpg9SYLKnIN68rPBbglwxnPavfzIhnlSaHint/DeJO4
	 SVqsDOnnEIXimi/nSjE52ejy6yQcu1B6vp8g8z4l2oe/3McQY2unfMvKWrlKBZhPhX
	 txyi9K2P9tHDA==
Date: Fri, 8 Dec 2023 17:29:31 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, Frank Rowand <frowand.list@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: dt: Stop relying on dirname to improve
 performance
Message-ID: <ZXNSe2zSCS8fExDz@finisterre.sirena.org.uk>
References: <20231208133955.483851-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vS4BeAJHYDVIouR"
Content-Disposition: inline
In-Reply-To: <20231208133955.483851-1-nfraprado@collabora.com>
X-Cookie: Slow day.  Practice crawling.


--3vS4BeAJHYDVIouR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 10:39:27AM -0300, N=EDcolas F. R. A. Prado wrote:
> When walking directory trees, instead of looking for specific files and
> running dirname to get the parent folder, traverse all folders and
> ignore the ones not containing the desired files. This avoids the need
> to call dirname inside the loop, which gives a big performance boost,
> approximately halving run time: Running locally on a
> mt8192-asurada-spherion, which reports 160 test cases, has gone from
> 5.5s to 2.9s, while running remotely with an nfsroot has gone from
> 13.5s to 5.5s.

It's hard to be sure exactly since the runtime is a bit variable but it
does look like this is running substantially faster on the test systems
I have that were most affected by the slowdown, looks like approximately
a quarter of the time, and all the tests that were present before seem
to still be present.

Tested-by: Mark Brown <broonie@kernel.org>

--3vS4BeAJHYDVIouR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVzUnQACgkQJNaLcl1U
h9DmsQf+JFYIALfEl10juMrMljapsA3mjPr5arODy4QUeKno9st6AKVgLAlqb9eY
APsPKDNooyd4qjQkkoprR7G1uWJhr3pRxa2QFy6lgc05JZFUpEQ3f1nW2ybn2IAT
fRxXERccAExNnKbzaGyxGr/aHSwJpOh5odiFmhnrVLLtsFHTKkjYX80Ck+qKPbh0
z7c1obwHDZsKi0CDlkb2zRENRZ23JNYvHFGBWNVS1KU8UqeO2tNCEQmpwIlalVpv
y1i5X8VuhFYXeBRerPoY9p9/o0kZcHzLEoYvj3al5UebydN8YsJ/MvrliBgmOp1N
jkDSq7DOAA+BOajRlL44GAUOsVr0zQ==
=oWgR
-----END PGP SIGNATURE-----

--3vS4BeAJHYDVIouR--

