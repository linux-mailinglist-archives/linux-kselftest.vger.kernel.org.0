Return-Path: <linux-kselftest+bounces-12783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B6917E8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154A51C20EDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C218306C;
	Wed, 26 Jun 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6/KVl26"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07711822F9;
	Wed, 26 Jun 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398503; cv=none; b=h8s5UDVxfkzuzhINaSe/S8jJV5DYw/IPV8gTnLd1TPxxi8IQ2BgRcxYAf5hNLkrxHyq9A/4Aqge8p3fGc/g8CfdtgDKY7VuPWyXVppD+c0AG/ujT2Kn+qsws0G1ng/wXv658SEwW//upE6NrZjpGP45A08hq9w+B2L3XfNv1h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398503; c=relaxed/simple;
	bh=5liAa5eq+JjIRvMH4LLV+J2ftrJA8xP0V0652DuHtkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEmbitIYYN0PNBGqz6zD6TSThwGlox9iqBdvWDrQUVQE/UhaiRFetmfe9F5XrTgGlHD2uSyQJZEs5SxymDoTJAZgkOHPN/mC3y4AQtvW7M9PnSj52Vu170zbTtIMcwzvjCWOkIV3NBBtLUNVS9lS0H/9mTshj5zpLSnk0ZPJNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6/KVl26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A620DC32786;
	Wed, 26 Jun 2024 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719398503;
	bh=5liAa5eq+JjIRvMH4LLV+J2ftrJA8xP0V0652DuHtkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6/KVl26xDBLftI1+kDRvccEqK2MWbddiTESoO0Esin9P86fdZ7jGHqry8xatNikm
	 iGGX8Aws55BlWxKicoIsQDu5vOUFMSe9dB2elSQlDKOzahCVEvl5ReiVDpyW6R1Mg0
	 N63h+53UB634bkgUhbHsKTV8L0MjgOP1YSGRf+WNmUMsLJZ2rP87g3AqDpXPJdPRRm
	 Gl9LjvCvHi8qNIV0/7c+9atP/HzS/55sQbny3kl9anMD/mE1924kKfpeteQQ7Ct2pB
	 F4F9y1qpdcnpav2mazBGZaxPE64hEklMGk/byd1lyWNNazEafJjxWgOheX5bmRg+96
	 RFtHDhv/W3Oag==
Date: Wed, 26 Jun 2024 11:41:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: ivan.orlov0322@gmail.com, perex@perex.cz, tiwai@suse.com,
	shuah@kernel.org, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/alsa:Add memset to initialize memory
Message-ID: <755d4876-9ce5-436e-aeeb-200f02ad7819@sirena.org.uk>
References: <20240626095817.5037-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="942wIzHHpXhuyjzx"
Content-Disposition: inline
In-Reply-To: <20240626095817.5037-1-zhujun2@cmss.chinamobile.com>
X-Cookie: Results vary by individual.


--942wIzHHpXhuyjzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2024 at 02:58:17AM -0700, Zhu Jun wrote:
> Add memset to initialize the requested memory

Why?

--942wIzHHpXhuyjzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ78GIACgkQJNaLcl1U
h9B6lwgAgO34y5xxu4pQjPXhvISych0YvoDsDFvW7n12BQ6Xmo80RCY4lQrxMs32
BRKKoaUe3vux5+8mOjs7/skY3V43ToRyoN5gFIwXOf21Gg/EogUYxAKXYrd1MXai
mlXG7ukuEbXf5g9UdxPeyj2bV71Ft/HOHnlflckQCJh+6xkpeMy+Gmq+fQF9+a1/
mZkunXXibYE71ZeWGsyT7KaSRH7PJ9e8kCxeagDTiIorv3bah24w2+Mu1e/cD/xQ
UPHCH+nvt8RMC+KQgC6t9yDZoytHKw5ulpN1nOcD/SKLt2a2FJmMkSlHTHJcIYRV
JHfHD8h4U33BFJl6YFhbqWTDw7F6ng==
=Zfgl
-----END PGP SIGNATURE-----

--942wIzHHpXhuyjzx--

