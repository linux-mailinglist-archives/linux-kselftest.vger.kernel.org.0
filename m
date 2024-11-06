Return-Path: <linux-kselftest+bounces-21529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D944C9BEB9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 14:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2971F27A70
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4321F8935;
	Wed,  6 Nov 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAWQLAnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FA1F8932;
	Wed,  6 Nov 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897175; cv=none; b=du0MjGuH6duB6nWJO8QysQmi8eudiCu4q2lPH6xGcG0mdHGK+LBC5mQs3HfTDZ0s52Eo/cy+S63sYqZUa93WVGa1tAZKywkIQeMGhWTWiEiueh5VBuvMFvigV8450JkD79xs53/2tcFfR6zxdrzko/d4fqWuQ5obT4l35pxZz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897175; c=relaxed/simple;
	bh=YkcPNWLf76J1061B0KOaBUk4W1esB7s7nOVJlCu0VhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeONdKEpB44dNK7migibJ+hMztDMVmA9S6E5exa42xMSfz59/nvdiAkxUW5qokow7oj7jLHM1TtHzfPAB38XaSpdFZkgYMjunjSL/IS3B8uuG6So4VQkuYPF4r/eJZzjMD/jAfhWBmi3X8CSilawsZj5/BYrLXKZI+sM2qGykOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAWQLAnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849A1C4CED4;
	Wed,  6 Nov 2024 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730897175;
	bh=YkcPNWLf76J1061B0KOaBUk4W1esB7s7nOVJlCu0VhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAWQLAnwhpRxPJrlAAXLjmqJcDG/Dk9rXVFkrH/BjGcMG+7b3RbMTik3ex1ESTQ+U
	 nCYr7goKQPKySJPhKT+9XbEChMNvLfmUrVeHN/RYQejgmXbsmZ6f2CtjUxlppxVwOq
	 FLKmU4lPxB0SxajmEAZ8oW1Qj9S5GmAgbpjztut26HWgbj8IOTz1DHy3meX4piXSTd
	 0S6jht6A+Gcid3hUC9oPeBG8byJN2T6gJmJAUVTPD6uoi0u5aLUOQREAYSh51g8G8U
	 m089QjGr7B7upaHIoZa215paUUouZItebHbXljOIjyTDe9e5UL6QxhgY4eE92drBGN
	 oYXcAVYw96YcA==
Date: Wed, 6 Nov 2024 12:46:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] kselftest/arm64: Corrupt P15 in the irritator when
 testing SSVE
Message-ID: <36fb49f5-55d8-4890-a8d4-d2cba67a9185@sirena.org.uk>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <20241023-arm64-fp-stress-irritator-v1-3-a51af298d449@kernel.org>
 <ZytSnBSk4r81a3z1@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uY0xOiikQHx+c9tS"
Content-Disposition: inline
In-Reply-To: <ZytSnBSk4r81a3z1@J2N7QTR9R3>
X-Cookie: Include me out.


--uY0xOiikQHx+c9tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 11:27:24AM +0000, Mark Rutland wrote:

> > +#ifndef SSVE
> >  	// And FFR
> >  	wrffr	p15.b
> >  #endif

> Both RDFFR and WRFFR are illegal in streaming mode unless FEAT_FA64 is
> implemented and enabled, so we cannot use DRFFR in the SSVE case.

Indeed, I'm surprised that managed to pass my testing...

> Is there a different instruction we can use?

We could just trash p0 with something like a load or add.

--uY0xOiikQHx+c9tS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcrZREACgkQJNaLcl1U
h9AuDAf9EenSozerVruavdm5ZHWW9Ijf/c0eJQy8RgpZDVdg8IAI/BaK7TYaLRT6
J1MR8UHPRJQWDHhouJnMmJSQfPfKnPxEBFTPgXREFZNxHg/BHRzyYSN+r7h4SA/L
xHpxuucuvuryBlGGSkW3Q6BrTxsQBham/jij3IwsMAORVaYRdBafcea7fd+gj0qR
6734ffT+I2UELAFXYYYQqn9yXRB6ZIDCwzfHaZhhuPVnInmqLeo6bTKguMED6K32
/FE1IFFoKZHmZNT3YnqP3lNkrt14WX6GWGejTjO++Y6JDpQQgEYddStDMt7dMl84
2YNuWHfBf1fWDgcjqpP5Ic4AL9vqQA==
=JVe4
-----END PGP SIGNATURE-----

--uY0xOiikQHx+c9tS--

