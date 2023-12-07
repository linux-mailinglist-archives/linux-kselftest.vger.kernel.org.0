Return-Path: <linux-kselftest+bounces-1380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8980922A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 21:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808B51F211B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E75026A;
	Thu,  7 Dec 2023 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiREk0so"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A45025F;
	Thu,  7 Dec 2023 20:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16879C433C7;
	Thu,  7 Dec 2023 20:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701980334;
	bh=QNpdhsUDUeBMWgIe029az6yJ0bM5+Vcwn1beTYWInjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiREk0soMiRO9TNKHICL6XVvpK+xRhB8awImP5Tu/ALNn3KK0TLQEII5AS6pC8BMV
	 hGBCZsGBE165bv3S3xh0lY+E0TYq1sbIHJ7u/xiU6kZW9c+mKAOQ0FwC3NTNiZSh0/
	 Py2ShItz64LdfEow6Bfrl3/u5m+LvWLyjTJli7sLatQX9Y9NgEhQwaG20dRQNzsrqu
	 xNyXu8FZEv5rXhi4eXpDOHoNHkK2DTrU1bWSN+BSvK/qUNCkhnA70RPevK6AZy18Vx
	 vknatbPHPBBDRpO5JxgZTeFUivH7BQvrdHCTtvbobP0MxaDLu0R2lkuxUaVm+U3kWe
	 0UqAlSihLkq9A==
Date: Thu, 7 Dec 2023 20:18:49 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	Shuah Khan <shuah@kernel.org>, kernelci@lists.linux.dev,
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <310391e8-fdf2-4c2f-a680-7744eb685177@sirena.org.uk>
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <20230828211424.2964562-4-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pkj5fhuMUnWEtPFQ"
Content-Disposition: inline
In-Reply-To: <20230828211424.2964562-4-nfraprado@collabora.com>
X-Cookie: Integrity has no need for rules.


--Pkj5fhuMUnWEtPFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 05:13:12PM -0400, N=EDcolas F. R. A. Prado wrote:
> Introduce a new kselftest to detect devices that were declared in the
> Devicetree, and are expected to be probed by a driver, but weren't.

I've been running this in my personal CI for a little while now and I'm
finding it's pretty marginal for the 45 second default timeout in
kselftest on some platforms, especially BeagleBone Black though it's not
just that.  BBB is both slow and has a comprehensive DT which won't help
matters, there's 253 devices.

I'm running it from nfsroot which is going to be part of the problem but
shouldn't be too bad since we're mainly dealing with proc and sysfs and
hopefully mostly running cached binaries, I'm also using a serial
console to get the output which is going to add overhead especially with
a large number odevices with length names.  I'm not sure what the best
solution is here - a quick glance at the code doesn't ring any alarm
bells for me, this may just be a reasonable runtime for the test.

--Pkj5fhuMUnWEtPFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyKKgACgkQJNaLcl1U
h9Bc2Qf9Ff2kw/O+966mMrAYPT/ndJA6i8hD9VjeLevjVDZ2HGUY9YfIo4B+zkb2
bPVIFdfHfD3J3hu01MWBUyaUVTNU+TWTF3rX5imPd9NNFHnvneTOGtg4KOCRXcSl
KKuM+C4k+euPWJiFNJRJgwLFVOY4GPNrVkTi9XP7r6Wv8MU7Un4sjQ0+dBTmE5gp
FclMgg306GEgWgzGxw2rIhyLZbGJPpPuu0cmqVlitgmTWIzi63vQrH4wrCQ+R/l1
Npe6lzBjnqghV5cJOLs0sQe7NRMPzY/B9Z+cXERW1DYad86s9jeYedqdXDaRuqjM
CgbCssr96PhbPheZxkPPULQacKbrBA==
=uXwM
-----END PGP SIGNATURE-----

--Pkj5fhuMUnWEtPFQ--

