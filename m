Return-Path: <linux-kselftest+bounces-12782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC572917E7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B6B283A6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F2180A95;
	Wed, 26 Jun 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhOnnaeI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF51802B2;
	Wed, 26 Jun 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398481; cv=none; b=umYznTLaWoQQfs+VJoMh8M/HBTSiyNT5VZyS3jNDP4hwzQi/JnSHDGp//UauXDOQNNESqeKXxKUoJqTa9f5yAN2CsnvXnTX0LpAJOEgYgyY/jUPq9KP3l+CP/QSX2KzyYN5aaOIcj/Rm7Dv9yvsSJz83yJCiFYqHzMoVmizg6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398481; c=relaxed/simple;
	bh=8JRrbvdAtdMCg9rjhTDzqTVZ64Nzi3Z/WEFd3S5PQqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWz+no9CriuYpjxAGThvZGzA6YbFoSj03Wf48BS9jVz1BLrg2OvzZ/m96YMdRF+9wBNbmAZ5T3fOGvNHKTFsncYump4+v5gImI8BJrXhL5N03kk4azCBygdo065LImwIYlPET7gwm6ds2wZ7VMshzdqcUcq3bN29PdEMNShBG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhOnnaeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D99C32786;
	Wed, 26 Jun 2024 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719398480;
	bh=8JRrbvdAtdMCg9rjhTDzqTVZ64Nzi3Z/WEFd3S5PQqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhOnnaeIJPx3r5BGpY96hElJRPB2pxJ9lzJcDXfyu098QzAKK+VHNKIKH8QnVH6g5
	 7HSga5yRHl+fxUA19L+k6ObM79x1cvfzdQLOLVL4Go7s1dm0Ad3vKa1DvkRlrRgXo/
	 ycoU0ImDKdFauY8uhhrh6X/565Jw7PXlCTY+4BtGpUMdA/3zJEBBzrxSzyggL4TmZX
	 viSGYlv69h0FS5qfcaX7JhqflhQHt7JRYkg+pfvF2pTqTJWoX5WYcUN6WBxSMuOJEZ
	 sGX2PjKbj6sXmKWkKgh/8gSS3Z+lsBcaEuDA/8ecJn7fDLvBr8ZTY5eWy7pWVPi0E4
	 Eqpqodvdr9v8w==
Date: Wed, 26 Jun 2024 11:41:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: ivan.orlov0322@gmail.com, perex@perex.cz, tiwai@suse.com,
	shuah@kernel.org, linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/alsa:Replace malloc with calloc
Message-ID: <f6a18c7c-8a7a-43c9-80af-b3ecc7f5d6bc@sirena.org.uk>
References: <20240626095409.4908-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pq6Hk9X7r8UpRpuz"
Content-Disposition: inline
In-Reply-To: <20240626095409.4908-1-zhujun2@cmss.chinamobile.com>
X-Cookie: Results vary by individual.


--Pq6Hk9X7r8UpRpuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 02:54:09AM -0700, Zhu Jun wrote:
> Using calloc to handling memory allocation, calloc
> can initialize the allocated memory

>  		SKIP(return, "Can't read patterns. Probably, module isn't loaded");
> =20
>  	card_name =3D malloc(127);
> +	memset(card_name, 0, 127);
>  	ASSERT_NE(card_name, NULL);
>  	self->params.buffer_size =3D 16384;
>  	self->params.period_size =3D 4096;

The change does not match the changelog.

--Pq6Hk9X7r8UpRpuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ78EsACgkQJNaLcl1U
h9ChTgf+JhG8Jj5uuS2NnzYVhJl9Fwjel+gvakwP0yLxm9A4FCfQkhSlmu7T1j1k
xd3bgj2JYB9qJOFG/MG8P/CpSdbEj7oeNQWs9V4LQ9Kc469IXbLAvWa7IYip28lF
YhJg62+x/VXqTAHahmlxeDHOq8FZjX60SMIPADtNaia6tXHAa9vWKzXHwgw1BbiB
he2BR5x2a0oSSwqmWY3qrr3CYHjWrHoMBYX0XWeEWKUQ/tZF6+OaTrmnPJdPxl3z
DHC0HHm3WjnL9/nhMLxSr7JJy6GxuuFDLEf0RaZdsLbdJCAERoruYDdkgU8BOvaz
Yrx5ERtOOlR4vK7PZkUxeC1JmoJK+Q==
=lroO
-----END PGP SIGNATURE-----

--Pq6Hk9X7r8UpRpuz--

