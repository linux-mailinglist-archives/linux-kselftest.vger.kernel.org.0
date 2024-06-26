Return-Path: <linux-kselftest+bounces-12818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C591870F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29ED81F238E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74318FDBF;
	Wed, 26 Jun 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qumrygjL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B818EFD4;
	Wed, 26 Jun 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418354; cv=none; b=NuDoYZxmqZZr/iBOPi7MJx/G98del1ax2Q0rQjojZjSz3mfjFD1sbF6ZpgEilLouFxtD0z9mQJFFdFQ3UUZx4UhT1pbKbyMa9jkOvaj8fVDofW6eFQF8i3Yrqe+OsCoANngrzi/xu0rHkOo3M1s3omJru6HbrsvYm4xQqlItkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418354; c=relaxed/simple;
	bh=rgo3ROjfkiZphHhfjT5YqttLf9ixriyLdpT71TMMrQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syKvjdx9h7EKAXYK4y0CILir4u4uZikcGMvGmMdBo0ScZxwvpG5Jw756qMEcwWEln4nzHUaSVmIiD1WICKXPIPwwyIZaEZBGewEfLf+Eq5gq6rL07FVlulHefNee6whsXkOanFp8ycjOycvsVGa1YxCvHrWmCr4ArIeQmXnczUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qumrygjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97309C116B1;
	Wed, 26 Jun 2024 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719418354;
	bh=rgo3ROjfkiZphHhfjT5YqttLf9ixriyLdpT71TMMrQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qumrygjLN+Yvc2y3En/c4vYMCxYnwiXa9Y1AZlK7UM3weqsISJ3EkdELIcMRj0uGj
	 11fYFJN4YHdZ734XCMSBmBaFPB/h0d+7ktPKqeTRyX9yZMYtfQyfWxriAoOEeSgPQN
	 BMUi+mw76WQqYXV5mafNmE+ep8gd+mPKU7OC3cDJUEKD0ROSWuKejPxBDiIC6S4GGk
	 z52Hgn/mQ5FdAuqOM3TClNWuxiasX9ygNlwW6pl65bwGD+SylfFNn2bPT62k80CslM
	 4owiuflVSStk79fj426G2qTgZHHtyRBgHkstZVNKZ1HXyZSUUIoVm/gzkADj40jDY4
	 7czqrupJe1/WQ==
Date: Wed, 26 Jun 2024 17:12:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] selftests/alsa:Fix printf format string in pcm-test.c
Message-ID: <5861fcb0-ce55-4a07-abe2-fb5e6f3c2c36@sirena.org.uk>
References: <20240626084859.4350-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2MCufdw4GmxXURX6"
Content-Disposition: inline
In-Reply-To: <20240626084859.4350-1-zhujun2@cmss.chinamobile.com>
X-Cookie: Results vary by individual.


--2MCufdw4GmxXURX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 01:48:59AM -0700, Zhu Jun wrote:
> Inside of test_pcm_time() arguments are printed via printf
> but '%d' is used to print @flags (of type unsigned int).
> Use '%u' instead, just like we do everywhere else.
>=20
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Reviewed-by: Mark Brown <broonie@kernel.org>

--2MCufdw4GmxXURX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ8Pe0ACgkQJNaLcl1U
h9CVAQf8CNTFtHORM0WLopVH0IpdRooLPrpDztY1dObc00Y8bmW0kMhIs4aEveXQ
T0G+nb62/ZXtvBLrVr0CXrXw+LLN7aISsXQ7yjpeBlstggcPswF2x/gBgUh6K2kZ
mBLuiwxtQl77ct6rGNX3ZFMNnEnPcDCkjH4zv1tByw94DdQQ05YmaZFNwtCFwJPb
gd+B+YGqiKtlTHxHYEQAHBmCZxCKdaXHhFBgvhq4fypR0nS0ax3MfWwBNrCocwFi
M6PU1ypBYsOnQqYZBYE+OXQooITJXb6iW9CEvyTzJXWM64CFoqgRsnLq/rcDz8zx
TdxHz6PBVsqzLjseELjOcOMgyvTCGQ==
=/ymd
-----END PGP SIGNATURE-----

--2MCufdw4GmxXURX6--

