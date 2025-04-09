Return-Path: <linux-kselftest+bounces-30421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FB2A82824
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DDB170943
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97325F7AE;
	Wed,  9 Apr 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm/UjriE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252EA25D52D;
	Wed,  9 Apr 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209470; cv=none; b=q23fAgqtVNfxIye5hosh2b5OcGQxF3ODgTQIbUpx+56jtAr3c3TyACSMtiW8Q45/O/I+HOm1s7gLDDdPTmGi/BfYcmsKbalLteS6jz00h645bNFKF27Au4ye0vOGGZ8FJW9N3tSM9+6bQMi2gLzfUnOLK/YgSPnO0ttQlFTDFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209470; c=relaxed/simple;
	bh=1Nnt71nyAGfZU1DSl3LMzHdL2W8BDPs3/42qienzcBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZN/I4rN1S6R1Zt6UhgXOeazpfEfXG5vbLanq4MBpJFttlrZ/622/75rRioCeX7YtoXVXYwn3DqgZ/jBplxkqdv5BfQ0IZ2oAUE9M+vwOlstKmlNcQwANnHlRPxWqpVM9cNmtJ4PBfCBiZLcKF5LDAeaCzlvw8KgAAzfULMnOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm/UjriE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EB8C4CEE7;
	Wed,  9 Apr 2025 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209469;
	bh=1Nnt71nyAGfZU1DSl3LMzHdL2W8BDPs3/42qienzcBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nm/UjriEQ41a9dIZ6xHY+y3hyC6MnTaOXqlSMDSDLCaDUOCfh3mg+lx25ZaJt8O90
	 2VE7ysFbTceVolCa+/Ns/l/Nix/9waBQQja4+Ew6/muE98rmtgX+4/H0nQEhNbV4DL
	 RvQBGm2b+A1tVW9Gd/tAhJdV2GgwzKgwcXSgvcoDNU1mJUnx1SlRxEeYZnM5eO12uT
	 sMvQnwhR4BV12ZzokXSDzQ2kJI+x1Hf7V1PMQD6FJIk03D3PGuwz+Jls9Rhl4XscXz
	 Qy3ULf47PTzuVn7j5h8EDtJLd2depQ+KRR5v+8UfNm62LwVPn5DdkZGF82RopOOHrN
	 HrjKr7CoS5diA==
Date: Wed, 9 Apr 2025 15:37:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs-amp-lib-test: Don't select SND_SOC_CS_AMP_LIB
Message-ID: <6e94dd2e-e242-4bff-be85-d3029fb08693@sirena.org.uk>
References: <20250409104544.878475-1-rf@opensource.cirrus.com>
 <a47c2074-2e28-43e6-a7a1-c3ac662723cf@sirena.org.uk>
 <5feaca10-f3bc-49bb-8e5b-9d9efa918e16@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0uIvSnhXV3OF6Eij"
Content-Disposition: inline
In-Reply-To: <5feaca10-f3bc-49bb-8e5b-9d9efa918e16@opensource.cirrus.com>
X-Cookie: Words must be weighed, not counted.


--0uIvSnhXV3OF6Eij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 03:34:27PM +0100, Richard Fitzgerald wrote:
> On 09/04/2025 3:24 pm, Mark Brown wrote:

> > This by itself results in the Cirrus tests being removed from a kunit
> > --alltests run which is a regression in coverage.  I'd expect to see
> > some corresponding updates in the KUnit all_tests.config to keep them
> > enabled.

> That's the defined behaviour of KUNIT_ALL_TESTS. It shouldn't have been
> running as part of an alltests if nothing had selected it. That seems to
> make people angry. Probably the same people who would complain if there
> was a bug in the code that they didn't want to test.

Hence the updates to all_tests.config...

--0uIvSnhXV3OF6Eij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2hjgACgkQJNaLcl1U
h9BVjQf/fdLWBj7HT/DQHtQwaIbKOwxGF4Q0TvYZATrbpHLVXW0PHfb4T9roq4ko
zHE4Yj4QuZdksWN7K9loTUlMWwmEEpFWwJZcOCa2h2oNdTnc4DIUQwsPsYYwDnLK
/sGfJw+QE1JNuvUD8AhFQj6ktrhnB1zlA2O0m0TYYpPzCq8PWkIqBc3oPUHx5oXu
xmTCjDYboD9qbg+V/NCxzdm8kxbL9Xxn5r5818sbhUV5weR9FRBXUIM7jBJI7tjW
L2ubgWyQQgPOxITux/RRimFFxM/ERgQnVxxgEtJ+BulhHs9GQ585opY+Jmyh4So1
sSrxHRY3Qx3B53VOu0+DwzIbpCS0pA==
=RazQ
-----END PGP SIGNATURE-----

--0uIvSnhXV3OF6Eij--

