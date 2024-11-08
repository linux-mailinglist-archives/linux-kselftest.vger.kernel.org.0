Return-Path: <linux-kselftest+bounces-21682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1489C1FD3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DB71C21159
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8391F4FC0;
	Fri,  8 Nov 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho6yILlH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F61E7C38
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077919; cv=none; b=m8EDcys0fikT2KlV4bYZaeQ3r4yDb5Kh963bGDO5AUf+JT1IzmZOiIT7pHwwZgjDZCaNu5/jOTtvSwF86y03oajz6zrK6j/fulV5AIcyXth+EQdBi+8Xr+aI0W1TevrzIIFq9pVEYiXpMkRgIrIbVUFd3akxkkAS8crQSgDP1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077919; c=relaxed/simple;
	bh=jujS6TcdXPOdfGkk9xmtfjYfLPjdbGSKT0owvz7WSsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQmZQtLiRlnHuywawxs0t8GItFnbmXzpWiSnYaszW1xubzcFBFS3VGyMXdVjHQL2QlORTUDqEyjnz9nMzVFIJk8zS02uT8c/FO6vCVoK8/hmk34bXTqGluJx8dpBdz4fcTo8mKquSo5CIcYQdyjuwwcchpKSAm4juekPHZqIB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho6yILlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94E6C4CECF;
	Fri,  8 Nov 2024 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731077919;
	bh=jujS6TcdXPOdfGkk9xmtfjYfLPjdbGSKT0owvz7WSsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ho6yILlHLvJ7XoyQfmnZ2LqtK8/5jEj4+mQ4uqi7un9CKLX+8sg2s1scE4mSwmcDJ
	 PxZxdYc/aye7SNp/VpCcJEFImw7URFfuWqfMitehn7QPXlpnZyAg9xN6uD8ITfc75o
	 BTX7RNrZwOyzN7qxilNeN8kROohTAHf4h0prSUow1VxQgwZ/szBO4wkgl1jQO2KPEJ
	 L//GptjEHXYw0NUFQPctnOVVk7h1BigJQ+gIBa6A0TIyZt15+G3u++/twyUNeH3ETD
	 ik5Zbf0KeTyD1g3uu4cKsHlkFrQGXP98gZzgMWjpy798Z/g2+zRDhOmTr3YJpg7Whb
	 d2ysooApkOLBw==
Date: Fri, 8 Nov 2024 14:58:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/4] kselftest/arm64: Fix compilation warnings/errors in
 the arm64 tests
Message-ID: <3f0b7891-7f67-441b-8ba9-ab302ac57792@sirena.org.uk>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0+KMOfvkan29Cw6V"
Content-Disposition: inline
In-Reply-To: <20241108134920.1233992-1-catalin.marinas@arm.com>
X-Cookie: Do not overtax your powers.


--0+KMOfvkan29Cw6V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2024 at 01:49:16PM +0000, Catalin Marinas wrote:
> It looks like people started ignoring the compiler warnings (or even
> errors) when building the arm64-specific kselftests. The first three
> patches are printf() arguments adjustment. The last one adds
> ".arch_extension sme", otherwise they fail to build (with my toolchain

Unfortunately there's a lot of toolchain variance with these warnings so
a lot of people simply won't see them, you need a fairly fresh toolchain
to see them, and IIRC GCC and clang warn about different sets of things
too which doesn't help.  If you look at the set of tests you're updating
they're all fairly old so will predate the warnings having been added, I
doubt anyone touched them recently enough to see the warnings.

--0+KMOfvkan29Cw6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuJxoACgkQJNaLcl1U
h9AU4Qf/T0cpTyGvK9q5oQGeP1KN/h24qt3oFB/Gg4vEveomB39oGOuWLh0+sEC2
TQgDJTFbu1Pf7qYXBjvyiLXQaC8wKbaDroO/bbHHzxOKelDOLsw+2hHm2W34jfhD
FcVDAP8Tp0MvrWA0RB/yU58O9+UEGsnzbnwig/HT+lAeLpAC8p/7/0xeMGZJWsuF
LDirrv70ZRsNHI7LyHcTiZurfiwg5gFmTnQvOHzwmT9HM6bSh1WXdxQtqH6TRgvF
ujVCdNbmVYb4lmF/z8W8jC/bueyaqzDpAc0uhoHWHFvi/S/8VVBycRs20m0GTpwV
Z7/qhqakltR6iDsZOprngtDiEKD/lw==
=XZcB
-----END PGP SIGNATURE-----

--0+KMOfvkan29Cw6V--

