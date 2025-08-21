Return-Path: <linux-kselftest+bounces-39605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF505B3085A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84787A24FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A42C0275;
	Thu, 21 Aug 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW9mUdlD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F622172C;
	Thu, 21 Aug 2025 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811856; cv=none; b=s0VsfRIjDCOY9SSjlkpK6ff8nVJDr/AU6M4B5Js4BL9F7cNWKnWLRMUas6VI7yBRfzSHIm1c0A6dGKGiF6gpiLrwIul4YrTlF3Yh4N4i+g1lfQDBZR5TFwaF5zg/v6BVNglMxcFG5vsnMjhRbEmXmPPbBcMC6zLK9gtat8yFUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811856; c=relaxed/simple;
	bh=/ty/vVkt74iKPXOsP7kI5bxNFsiih+atHcD6arkGgaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYUCP+Fb1gzul0+/cmLnbsFVd9u7Y6CsF0wN/gaZYge6bBkjQf0rQuXELiqHjmtqt7gA1BYVFMqspyhDEjaItbWUCMHnFzkbt7CRLfWf15Qtib8tfyafloNS6Rp/qUgHdvIPcj22YcNFukgPrlw+/00TH/eJ8ocy+RqqKEks5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW9mUdlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC2AC4CEEB;
	Thu, 21 Aug 2025 21:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755811855;
	bh=/ty/vVkt74iKPXOsP7kI5bxNFsiih+atHcD6arkGgaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LW9mUdlDSGZ+grjKxbSX+AifJztORJQOb1dSeDbgHwiwmQZNgdGl5UHApou6TLyQ/
	 FvpG+3V9fQxQ9Kg6rkc8EssNSNWz2GXdmwiqS7oT7vf/lO+0PZJoM7iiBlFDDYffMC
	 vSLssyLMUr6hA92WxQwpM+P0a/lamHbRXvbiDSbO3+l1BAEQDtl8UhdIMQHhLqHMS8
	 DUH3juTT7zbBRixz0rsprBs/UNsFmXyA6TYQ57HPmYQ/0Uft5Pz10zdO58Dvro8sR/
	 lHSitmXV0Eh7BkhJWEprfSOwqAG6KgGtgbfTT8wGKoNiBquFvVtGUuLZr0plL98/Vf
	 6PEyCVfjLtC8Q==
Date: Thu, 21 Aug 2025 22:30:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Nikola Ivanov <zlatistiv@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/alsa: remove 0/NULL global variable assignment
Message-ID: <f7ff446f-2a9e-49dc-af7a-6e4c76803471@sirena.org.uk>
References: <20250821200132.1218850-1-zlatistiv@gmail.com>
 <9c310ab7-0f0b-412f-8df7-71730a2d2caa@sirena.org.uk>
 <CAHjv_as7m7UbSLAPU6hX_=tAvLZYR_7Q=1n+Xq-nW-6OJ237PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wXnrCk0mND4j2nmE"
Content-Disposition: inline
In-Reply-To: <CAHjv_as7m7UbSLAPU6hX_=tAvLZYR_7Q=1n+Xq-nW-6OJ237PA@mail.gmail.com>
X-Cookie: Warp 7 -- It's a law we can live with.


--wXnrCk0mND4j2nmE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2025 at 12:17:14AM +0300, Nikola Ivanov wrote:
> On Thu, Aug 21, 2025 at 09:49:29PM +0100, Mark Brown wrote:

> > > -int num_cards = 0;
> > > -int num_controls = 0;
> > > -struct card_data *card_list = NULL;
> > > -struct ctl_data *ctl_list = NULL;
> > > +int num_cards;
> > > +int num_controls;
> > > +struct card_data *card_list;
> > > +struct ctl_data *ctl_list;

> > Nothing now sets initial values for these variables so they all have
> > undefined values which is buggy.  The code is relying on the default
> > values.

> Checkpatch reports it as an error, it looks to be part of the C
> standard that all compilers must initialize globals to 0.
> Though I suppose it helps with readability to see
> the num_ counters assigned 0.

Do you have a reference there, note that these are just plain non-static
variables?  I wouldn't trust checkpatch for anything that isn't kernel
code (and even there it's got issues).

--wXnrCk0mND4j2nmE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminkAoACgkQJNaLcl1U
h9Ch0Qf7BQo2dqPlUT7IzMvCZC9WzUrMkweHu+WVhf8d5Zkyb0EIaj1SuQqcxCxN
030Alv6gWo+vWae3AOV+uRCfZ23AC4sATuUdHXTP2rq2pD5rWGhOOw04GcItAgnU
I2Hso7PI/VvVh83VeGfR/rtgJc1+EcVzkOUnCz1Zbmy8rxDJlhxRiWZr9wb+OaZQ
uEbP247E29lUdKuG1enVqcxAy6qedKa+zfjwuFPs9M1Jsr2vMkyLyiOBcQFwpYDo
OhF//Lb5chZrQszhr1RYuF5nEjuJYueKumw7IqxZkUwDToUxSPa0c9gBtCDCrsPl
JnwKwwjDjBV0EC+n94ryHvctoFxXvQ==
=qDLL
-----END PGP SIGNATURE-----

--wXnrCk0mND4j2nmE--

