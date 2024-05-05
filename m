Return-Path: <linux-kselftest+bounces-9480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103508BC184
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F361C209FD
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54B2E83F;
	Sun,  5 May 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rONx/UNK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E142D044;
	Sun,  5 May 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920819; cv=none; b=KLlcPpyxsGO2FrI6JAOOd4yabzK4c54Wh1DZdpAYCpo3mtCCTsnGLC7OtiSR9vdYaGKvb/KW589Cc5JrxdbpaoWSrff6U+9ZxgdYXcO2gw89qp7qkrunrHzg30mrWa37BAY+Vw9z62ff4SiOgN4eMy3QqdIFspR2gXXO2Pb33TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920819; c=relaxed/simple;
	bh=gfr6J8JaI0FQSBkoFj/QKJrcZ1kMMUOIbnAK47RI06o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmIsiGw1g9BUHSGWroiNhKYv53WyOcoxvDu4hqXwfCB6Y+jcLqvVzJvQzV03NMk5nIOUKxOlmxLxztU1I1Nw/yreR7jPf5hoMLevMVZ0xPYkDY3SEXjwgGek1wVYC8szULaHDN7qVW+85o76WGyuQBH89D4hMdij5y2wacHEEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rONx/UNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860EDC113CC;
	Sun,  5 May 2024 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920818;
	bh=gfr6J8JaI0FQSBkoFj/QKJrcZ1kMMUOIbnAK47RI06o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rONx/UNK4fw/FNu8BIef7/Qx2Wlw4fTdIijYCTe41usY7p1zpLbtpQPrGWntvqCt4
	 JZrpK422ntuev4jf2Re8uD5+2CSv9rQRsOabscJkzGOD9lav7Gc60718Doxjh6Mfh5
	 Dq7tAh95kxelOg6WlG+VZ8uaRw4J4AZ8isuh2byflT/yHOoZ0vGmPxgoBIqfA8r9DI
	 TdrG0ZzlUYLNDRcLO++qP5gHvRJ4iMtUXZF+MeS9/d+PbLM0ok6TtKDKkOXQ6D7/bW
	 oqz48Ll/XY8wPSvQ0+lZdVAcAXGVHvqHHFiBu5FOl9ArRbhlVQuMk4u3THA/vkPuOq
	 HBDXDG15zQRRQ==
Date: Sun, 5 May 2024 23:53:36 +0900
From: Mark Brown <broonie@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/alsa: fix a build warning: return a value in
 all cases
Message-ID: <ZjedcAW6ITmo9pXp@finisterre.sirena.org.uk>
References: <20240504021330.33429-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FQLEYbDtCxwwEBJN"
Content-Disposition: inline
In-Reply-To: <20240504021330.33429-1-jhubbard@nvidia.com>
X-Cookie: lisp, v.:


--FQLEYbDtCxwwEBJN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 07:13:30PM -0700, John Hubbard wrote:
> dump_config_tree() is declared to return an int, but the compiler cannot
> prove that it always returns any value at all. This leads to a clang
> warning, when building via:

Though given that the function isn't referenced we could also just
delete it.

--FQLEYbDtCxwwEBJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY3nXAACgkQJNaLcl1U
h9DBvAf/Tmp6oAlXkJLinQYYWlHXd/+lMb0PVv5TalZyil2L+ifp0pZbyknBloWc
k8NEvKofzBymkugbsGsvrTBN9E4dLl2Nr6XHPBoADVT5IQx0mrXZYd6pdyZXYil0
WaMGDMEDwMDFAkfTdVvvEntz2CRTUFNPVMzCZVmQYM3m0vCjPRY3ibI04z00SASb
iHwq6VaX9lkIs4knd1XGb8amrWpABwSiZD6iE6MDmD/7xP309WkOpx9jBhy6607h
PJsgk3k0mkhSTvKXoIN8HYtfIJlpHKzN9mOV2vhh9IlGG6zKa95rIWnq4iAbkTHF
sxx38aBbSc9GBcSA4yHJJqFg0n6/9g==
=lp+W
-----END PGP SIGNATURE-----

--FQLEYbDtCxwwEBJN--

