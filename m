Return-Path: <linux-kselftest+bounces-7396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68D89BEE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC361F23E45
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F966A8AD;
	Mon,  8 Apr 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YColKxwq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2136A342;
	Mon,  8 Apr 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579046; cv=none; b=MLLI33tohdQOWgx6W/oLjpl1ALy4PBUqhp6CipGcokcZ4dq4RZbYNnm2ONKBGvxMV1kDOrEnR3U8E6eKSBcUFITXG7LJ6VNCtpFfzlvAyECE0oI6968br5sgogrncu5nKe+DmTw1fugUM9hWNtv2/RA/vuBAJZYKrXnJla5EAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579046; c=relaxed/simple;
	bh=OmlkXyMP/p6kjhvrzdxuzPLTgizMNaWW9HDJiUC8jCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZokOM/cem2jU1x1ft8ejyUFD/Q2ON2HTwooBHkfopvQn1A9sfhwA/XT/4MhgflJuMASMVr7+5PEg4MUdLWKpqDOtwk4a9OTCmANxmkwAFASSuOEzYTuZ+pilsVBNwmGVlkV84josZSXPYTQxn38o6Y3WDDmt1cwLtFD7qehAdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YColKxwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C4DC433F1;
	Mon,  8 Apr 2024 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712579046;
	bh=OmlkXyMP/p6kjhvrzdxuzPLTgizMNaWW9HDJiUC8jCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YColKxwq4R7Xy50Mx+/2IlfxKdz/Vax3+a9MdGD5Il0tPXVBfo9BHGTGONlJfG780
	 /TJt/t291bOzOlbnsGcNeX7V925JFqUDMaB9cYwGReZ0V7jLMjVDuE4h7Bkm+Y78w5
	 heIC+ZY+hDjEe1OdN8StB15+MmoASAScvKB8yE897YV2xMo9sbnMenmb4+EGA2pjUc
	 QOpu95sQ4goHC6pZqEFlrs4odTMjO8SAXHVxFztE+Hv83nWunA1gi0umempa3kB/nl
	 YCb16AiWY47TwIeRmWCF8kwKjfzoehttY9VgkySYjv63CMOIQlDyShGs6H4wbEXkYB
	 V9UHLDsIou/xA==
Date: Mon, 8 Apr 2024 13:24:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com, suzuki.poulose@arm.com,
	ryan.roberts@arm.com, rob.herring@arm.com, Catalin.Marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 4/4] selftests: Add build infrastructure along with README
Message-ID: <7ec3aaa8-9df1-44f0-8c5d-c1e28f973386@sirena.org.uk>
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-5-dev.jain@arm.com>
 <ab271c32-dca8-413f-b97e-c8ceb6d7924c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oNxGWWpiwQ7x0mrB"
Content-Disposition: inline
In-Reply-To: <ab271c32-dca8-413f-b97e-c8ceb6d7924c@collabora.com>
X-Cookie: Drive defensively.  Buy a tank.


--oNxGWWpiwQ7x0mrB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 07, 2024 at 02:15:15AM +0500, Muhammad Usama Anjum wrote:
> On 4/5/24 1:44 PM, Dev Jain wrote:

> > @@ -0,0 +1,31 @@
> > +KSelfTest ARM
> > +===============
> > +
> > +- This is a series of compatibility tests, wherein the source files are
> > +  built statically into a 32 bit ELF; they should pass on both 32 and 64
> > +  bit kernels. They are not built or run but just skipped completely when
> > +  env-variable ARCH is found to be different than 'arm64' or 'arm' and
> > +  `uname -m` reports other than 'aarch64', 'armv7l' or 'armv8l'.
> > +
> > +- Please ensure that the test kernel is built with CONFIG_COMPAT enabled.

> Please create a config file and put all the per-requisite configurations in
> that. For example, look at tools/testing/selftests/mm/config

Note that arm and arm64 are different architectures, and the kernel
config stuff only applies when building for arm64...

--oNxGWWpiwQ7x0mrB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT4d8ACgkQJNaLcl1U
h9CAhwf9HJ73B6b+YfDEJfAnAbwpPhRdPTmIUF4Ds0xgmdVwRHOgBBs91I4MXEOh
kaU+olkJlf+INpOCa5PpFygDclsGlAUodDUn6oMs6u8og8eHWl0r3ejPFwv6WIwR
+K/4+kA7Pc1gP0lRYH2ONEJG4jLUgajA5QW6NrmmWClKQg8aMqshHZZF+uszLOnQ
lmo+Zr+xj1cwYjOr+lKGl+bF/L/S1aOboHwBMAkmNpV+ZxZ3j6sir+L0qVov2K4s
2J95bfFw/nganBft8X0Sr6wnzRdn1jR9YxpexBKis8XfQA4V+BZBDeI2Yv54e2DQ
qjNOpHgitPoMjadKOnByQ+A+csICaw==
=qmTk
-----END PGP SIGNATURE-----

--oNxGWWpiwQ7x0mrB--

