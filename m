Return-Path: <linux-kselftest+bounces-15542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A0954EEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB7AB23D75
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F891BDA94;
	Fri, 16 Aug 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp1UsmFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23261B8EA0
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825998; cv=none; b=ZDV0nKI9XmGGYo8xMF5hyfoRRysbYKBEDG/g2b80Wpc7ZxXx25wA/amKEvsoOkjWwJ0YoCBe10vHLsav4G5Gi6H1606ezRhuB2O3g56Ca90YXzNY7AIy1EztqIJ4Od/V/BitQgealP2kUwphcxTik9gozMtyIAqg0+ouACTXIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825998; c=relaxed/simple;
	bh=2EyY/5pYR1R8Q5iUBESN2N20cTSeSNehSVnHxg7RnlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKOjmGCmK5FjD/o8sr2VSu4IKytZek6rdK6iGFLSbys07ho1qEwbkMoOJfhcmkGIO5vNFXMTBE3V6cYdOQnq+0D7vGQGXHHN4m+fWGNT3aZeqgfm1kgtyOMjOyRY9vhH72YDpVr5xNZkbsZbCTHyqasN2h0qgcHuIB6Y50tBKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp1UsmFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76825C32782;
	Fri, 16 Aug 2024 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825998;
	bh=2EyY/5pYR1R8Q5iUBESN2N20cTSeSNehSVnHxg7RnlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yp1UsmFzWjnAUII3wkv7MkUbq2XUyVwyWs2tv699KmMYwvkwALLn5zWm2d5F0i1ut
	 aaeu3KsSX8D9b+FpBRWkNatBT+xBwMlg6EFPI9iKm+ML8rFnKcuH8+Ug9OoSmfQ30u
	 8ibb0uyJYpN/XqjEYvotl8b37FZVvz1QuNh1GMQ0j6N2IWwwrHCT9YDY22F/5IwbVF
	 Hz0iv9iXTIuJslJoEJwehn4gW5m6E8ugi4Zj2PAekVCbjZKHo/1qCdF9E80n4XWRXw
	 ddJYoRPJptAYkDrk/AxgqPTCVe0gVIhl1g3kW7gpkfx04qgfMxwb3JAt+AGNKEaAO8
	 lcL2eaMq0F2Mw==
Date: Fri, 16 Aug 2024 17:33:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 8/8] kselftest/arm64: mte: fix printf type warnings about
 longs
Message-ID: <96b9769d-814b-4e98-8b23-065ada489553@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-9-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhjDTLja/kLeDz1W"
Content-Disposition: inline
In-Reply-To: <20240816153251.2833702-9-andre.przywara@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--uhjDTLja/kLeDz1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 04:32:51PM +0100, Andre Przywara wrote:
> When checking MTE tags, we print some diagnostic messages when the tests
> fail. Some variables uses there are "longs", however we only use "%x"
> for the format specifier.

Reviewed-by: Mark Brown <broonie@kernel.org>

--uhjDTLja/kLeDz1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/f0gACgkQJNaLcl1U
h9BEsgf/ayZziAguU2uBJ2yLXofSkZp12FhQPNHRo802wCJIhaoibUJiFsiY4eXM
+ZVOHtA4e4+pNWH6KCzZNCy9fbmDxW1Jfeh/rHK0zJ0aEga/0gp+ly41HAyeFzQe
TsmjGJFuM/5BrHV3CxgsKYxjS6tS0A0OKIk7BxhQz1k/zmyaImLsUDsTxkTyAtLS
K+I6IxvYU3yO4s7kaQh2nGSzVuY1uf5lhNupC7jcz9OfYY3aBDzLtnJI7MJ3lhYa
lpvWUXnmI1DNk55ucmyANJo4Y0tzZBucAl0FzorvsAVjtwZVKsBx4lsnWmMuKu/M
h4dYiqs8HDHtnYTBwADL1sEdhfSnPQ==
=w1Y5
-----END PGP SIGNATURE-----

--uhjDTLja/kLeDz1W--

