Return-Path: <linux-kselftest+bounces-16812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CE9665EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB3A1F21560
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482831B2EF6;
	Fri, 30 Aug 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNwUVg53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE0EEC9;
	Fri, 30 Aug 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032639; cv=none; b=DHuvfUSkjfDAcZHZh22SRrRwjGV6VhE0a0uSwPTPDd+s+ArVj6fEBudlxAjb2GtViwE0IsUBFLND3qVym2KJx7mxZk7TNHUJ13FxmjXJikHzFW8Ov8q0r0u7jKGT57YPRZb35g19SQvbryt5KZHwUOxMBoUThP3+3PELouUOcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032639; c=relaxed/simple;
	bh=WlCQ3d+pkD4dwXRjDSTxJBjttia+/6c3FcwfFK2Pqq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW2y1JTI+JIltsqPmdvXGGinb9eTmJS3RJS9qtMIPli39c6CMmLerIK+f2xYuGOsUheoNTXf+1Cgz9yCvdSfrEoDwfTUeBe+R1GSxd+HZ55owsiCGoUPBR0m9OwzZfd6tgHebG2dk6piQgEqNIZem8GvDpX3CCe1yIS1bCeSrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNwUVg53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D47C4CEC2;
	Fri, 30 Aug 2024 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032638;
	bh=WlCQ3d+pkD4dwXRjDSTxJBjttia+/6c3FcwfFK2Pqq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNwUVg53jpeeMo8Onx0A8fQZxyIi/54T06NsICRHAfKBUJPhxRU/rWwBxbsQXvuDH
	 vWaoaxUn/rcWp2k9ZqKET+XQ7vRmMemfQjSgHpGtvSNIi3ZaMicM3BufOwxutwUXYo
	 Y/EpGbfizO8mnkw8JGsNqIzf2tWR7nMflVVhQrfFzc1QBXq5NQaTOIOCV0/b8O91JN
	 PKd4dODAOTSFdpeqSxu8VAJOdpIzDgCYPfHhha54BSwHxynXP4N6TZ7PxX4KSWdzpZ
	 u5qJ7QtnHxgyAlSlujXdYe0kq5XbvYyy2xXu6v9MSTdG1XubW/OZzKZDStlYOJXt4e
	 yMv9vZVJZwtmQ==
Date: Fri, 30 Aug 2024 16:43:54 +0100
From: Mark Brown <broonie@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/vDSO: Fix cross build for the random tests
Message-ID: <dd1d8f71-28ab-44db-819e-90aff2f9b9be@sirena.org.uk>
References: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>
 <ZtHmdf1XsEJLur84@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XAtaYKVVmQ4tJSmN"
Content-Disposition: inline
In-Reply-To: <ZtHmdf1XsEJLur84@zx2c4.com>
X-Cookie: for ARTIFICIAL FLAVORING!!


--XAtaYKVVmQ4tJSmN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2024 at 05:34:13PM +0200, Jason A. Donenfeld wrote:

> > +ifeq ($(ARCH),$(filter $(ARCH),x86_64))

> Actually... this doesn't work. Because:

> ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)

> The x86_64 gets turned into an x86. It's a little trickier when
> considering subarch. I'll send a followup here and not queue this.

Ah, right - I originally had copied the line above with both x86 and
x86_64 when I tested and did a last minute edit during final review
after I'd switched away.

--XAtaYKVVmQ4tJSmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbR6LoACgkQJNaLcl1U
h9CTWAf/Uv26vpPNHryShQOXRALhsp8AA4/QHwJBB99tVzqr2bBjYWO/Kbqej+MZ
qyu8cMld9+6ykpWr3FNcemjvl6xE+MEbr5C24Wj5inrX48Hoqgf1U123tcUPrulx
Hpfvy971lPtRXIDGChSF9IK2t29DoL2ewLcjIje+XS2q2DxEMfgmWxbhzhqaJ3K6
IA4B45zcmh8+QZIt50tnzemCKpv+u7XS+Z9UzVorPKoXiOhdgjBphhFOQT7PT4fV
tm1ULBkE5fWZeiHDHelEsC4NUzKBL9aVgvga7DO3SHk2NbHTLt1NyqgbNk4WVHyB
UKUyhM+0SSFiSDiJSNIRNNA4EiNjOA==
=zfhn
-----END PGP SIGNATURE-----

--XAtaYKVVmQ4tJSmN--

