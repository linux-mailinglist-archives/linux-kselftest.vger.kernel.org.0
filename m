Return-Path: <linux-kselftest+bounces-41672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC47B7C6BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6BF1635E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 11:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3E371E81;
	Wed, 17 Sep 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJTBlI3/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC32F28FF;
	Wed, 17 Sep 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110025; cv=none; b=HU4Vs3pSebztpkqHgfXmzGYtevsXMNo7WfWXOxG4NYenVNfqbwBUZe+vInntLewf7FJuMWJLy0tnHptQv0cUnZ+3kHWgXj9HCazvuIasnU43gU86OgOvjMRsuc97OAj5sfLCIgk8WvawCsR+ZRozjTomDo5HQwIHCedMuaMrIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110025; c=relaxed/simple;
	bh=KgDwTFTcAIYXCbk2aWAR0KmQVMiewKIO3OkY42d+t0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGC1vZbL3pmDy+kt/GPXJWLgZDKkA9W6U6TKF7XNnPI3NuHU+Yf0ldxUE2uIZr6OwV3HS7HrQE6asSEyeVoy+YzpcnFJ+DRBQP+t1Yg8kEnnYz/GZd9jOTeia2u9Vl8eWUES6qZ87MiAHWG7UYPxaM6uegQZMB11TPtSmBQGtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJTBlI3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608FCC4CEF0;
	Wed, 17 Sep 2025 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110025;
	bh=KgDwTFTcAIYXCbk2aWAR0KmQVMiewKIO3OkY42d+t0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJTBlI3/BU5wm3NkHaq8qLP6iyFGjYJSq9l4RO7B61RwFZ9bZ3U2rPGWbr8Esk2gx
	 UPtk6omSt0dmFHftiNR4ahoD9IhVaXI/gZmDbo0kjGyD0I2/lOjGlZ88kLHc8toJZL
	 bu0fJm4P44QXEvA5gWxa/I3hwy1oGSGDA38jmO+Meo/oLZ8DjGi/0itbOYa+ZUDkJi
	 +x9cu03Wt6GwC5OjWOII69V7KCW/qUPn2+zpd2j9veN90OFxk7cWaq3V+yKFpowqHH
	 AWO2ZA0GV22vh20NwTEkl7Bt2drYm03fuaTBbW6iMNRyybTqUYKle73tcMtIpjFLYd
	 UobXjV9LaTnUQ==
Date: Wed, 17 Sep 2025 12:53:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] kselftest/arm64/gcs/basic-gcs: Respect parent directory
 CFLAGS
Message-ID: <28ff3ed7-9380-4baf-aee4-ce1ffbd2a40a@sirena.org.uk>
References: <20250916-arm64-gcs-nolibc-v1-1-ee54aa65fc26@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ISLF/TkZCujUpmvw"
Content-Disposition: inline
In-Reply-To: <20250916-arm64-gcs-nolibc-v1-1-ee54aa65fc26@weissschuh.net>
X-Cookie: Lake Erie died for your sins.


--ISLF/TkZCujUpmvw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 06:51:35PM +0200, Thomas Wei=DFschuh wrote:

> Restructure the rule for basic-gcs to respect the $(CFLAGS).
> Also drop those options which are already provided by $(CFLAGS).

I think I was concerned about CFLAGS having things in it that weren't
appropriate for nolibc since the build setup is kind of fiddly, but I'm
not sure how real a concern that is:

Reviewed-by: Mark Brown <broonie@kernel.org>

--ISLF/TkZCujUpmvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjKoUQACgkQJNaLcl1U
h9CQgwf/bLFOwIs2jkw3RDKB9zUPQtfr4oUjZO9/Uw3NYf+Fj5E3Dax5YHsFGp10
SMs0hl0qxzSdoqxQFxXrBTA5Snou6ROQcrA6I7BF3h8USWOsEwftWPXfDiPwjZN6
RMsSUObazIbzgmAs1WpS2PqL4jG4mbb/1L+x6+XSDnDASJs1e0iYaM/lAs/pYMvv
8+UUyDivkV9H/9cWd/bZiuxScG1YTOzQk9BoKqIU/OyncPlfUyjfumvJs9kDsytg
LqTH+tbD3FIZDUbBbByV2mzqeQGqcA0Xb9l1W+d83LvzccdvBSIMe5/tvghUCp8O
ZQ9qT8t0jyNW9OL4yVyj26xowXK81w==
=y+g6
-----END PGP SIGNATURE-----

--ISLF/TkZCujUpmvw--

