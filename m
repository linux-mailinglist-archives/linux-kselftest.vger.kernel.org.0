Return-Path: <linux-kselftest+bounces-39598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB3B307C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9604A605CA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D1352FEC;
	Thu, 21 Aug 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKD35vlM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4D352FE7;
	Thu, 21 Aug 2025 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809376; cv=none; b=lKZYmQ0gT+WwGLluHliBwB1j6CmGBG32pJmyzbLugXEIP49RM4kCcOCQAWgdH8kYLKr46To6dXi4zBrRo5O1Y4XczHrYZv4JY/dt7nxuPL5UuRND3X2OFD9kbZytPvocdXf0rwjjzfdjJudsXyWoI0r9GzZhuKR6n4jjKVxumFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809376; c=relaxed/simple;
	bh=Rbd/4KwEl8hFhj9W4DP/GsOYavHXATjdIGBQxWM6AIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrrEBsBgJ5+c3PpQ2YezGa0JuvS/eUWWgMZuS+x8Ch7iY+QP70J8gBgW/Qgk3TxXMOBcJwYzXKpPzlsE1DRz9dQNSrTf9QMCb1esbctPyfs33N44SrEl/0VKESXrM+97dDSc1mKvWiBfpkUvNznxNOfxQJHEEm50KknWmcDjPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKD35vlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C3CC4CEEB;
	Thu, 21 Aug 2025 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755809374;
	bh=Rbd/4KwEl8hFhj9W4DP/GsOYavHXATjdIGBQxWM6AIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKD35vlMLUuMNmiLl+X/wclsjiC8FOsiKGz6gejy1ADhyxU7/QyRe26AxpfDUXm1l
	 WLTzefSWPGECKFFJpdO8qmUqktqgabiAcLfYXCWBkyod+7msM/TB0d9NE8e4OhzhI+
	 PSRqtZCulGcm30KUmuXhNDoh18+ySu2PByFuDhaG1EYxBFpowmJuhlCyqYUDS3qXUq
	 sc/96ANW63gn1RldkhMvRcGytD1dT5tp2AdGYjHOayUI5aCjWkmmG0g0FVxEzLPqzD
	 jcK0fXwlTMPN0CwKuHl+HU0WELfQUJc2aH4OGmNnoDQ/MlLWL/eGAIkoCNcQrqC4/L
	 x5gd5FTvzl54w==
Date: Thu, 21 Aug 2025 21:49:29 +0100
From: Mark Brown <broonie@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/alsa: remove 0/NULL global variable assignment
Message-ID: <9c310ab7-0f0b-412f-8df7-71730a2d2caa@sirena.org.uk>
References: <20250821200132.1218850-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LIJm8UEXT3cPURDU"
Content-Disposition: inline
In-Reply-To: <20250821200132.1218850-1-zlatistiv@gmail.com>
X-Cookie: Warp 7 -- It's a law we can live with.


--LIJm8UEXT3cPURDU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:01:32PM +0300, Nikola Z. Ivanov wrote:
> Remove 0/NULL global variable assignment in mixer-test.c and pcm-test.c

Why?

> --- a/tools/testing/selftests/alsa/mixer-test.c
> +++ b/tools/testing/selftests/alsa/mixer-test.c
> @@ -53,10 +53,10 @@ struct ctl_data {
>  	struct ctl_data *next;
>  };
> =20
> -int num_cards =3D 0;
> -int num_controls =3D 0;
> -struct card_data *card_list =3D NULL;
> -struct ctl_data *ctl_list =3D NULL;
> +int num_cards;
> +int num_controls;
> +struct card_data *card_list;
> +struct ctl_data *ctl_list;

Nothing now sets initial values for these variables so they all have
undefined values which is buggy.  The code is relying on the default
values.

--LIJm8UEXT3cPURDU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminhlgACgkQJNaLcl1U
h9CPJwf/aY4pSg8MnKf2igmuuzd3CZ724kH69g0zDGajBcie5gE89S13NPjG7KgM
/VqX6quyiBtSYbWQKw8FvgygKrkxmoBsuuIFuv9k2FeTGSfi3pHkiVjYcCIjWgsj
svj8YUiPvueCupUt1/gHGwx0KcAaAd2gwLJhl0smVHejqgcgvk7fTMINwjWmdkLq
nNS/nn1SSEc0vxspvndTPrt/P1FcOhkhrc+62bIqsHCtxZDU+fJ9+Z7LUz6PZxlq
sSC6kl39VKdLcu4WI0ZwUk/D8T6CX4AZPyhrAZdhz9B91KppvdqN3HbgUAjdBlq7
QMgeLAk0USWC4pI7l4umXzxb+xUc6A==
=1rKS
-----END PGP SIGNATURE-----

--LIJm8UEXT3cPURDU--

