Return-Path: <linux-kselftest+bounces-20168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 566309A46E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 21:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CB41F23434
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615B20513F;
	Fri, 18 Oct 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxq02s7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA5204F68;
	Fri, 18 Oct 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279054; cv=none; b=C2tKUKwXBpqR4grZ8gOEyvQe55M9FEll9dzvcrG18YH2A7/in8AbI+ryLukbPIYsEJ5CEDtmc6helHhIkanhvlkoU1NBkw1rBHgh3EV9lLSZCbOihD0nICGVbWYdre7c3l+jfmCI+f/CUI+j3wpq6Poja0jKkjYG+zvW+d/HgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279054; c=relaxed/simple;
	bh=FhMJHeMxfCHZJv7HzYbAE22jWcvqI+5NkAu445PHzZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEm99Qb11EexYCMqQU8dUZvQDD8MJ7dQlCfUu2Xzbm8qSUYjcyktymOUOb4kHG/rWOZyOCkQDxY3pi/l6oZ7+jG9xTcQb98xFFJKQcrSzb144DPoNJmiFW1ul4IQGXwFVAlwb/pV2V83cMkCxiDJxR0fqBUUMK57P5zv2BpKDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxq02s7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF24C4CEC3;
	Fri, 18 Oct 2024 19:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729279053;
	bh=FhMJHeMxfCHZJv7HzYbAE22jWcvqI+5NkAu445PHzZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxq02s7CqA1347PJeMXmW6mhZ2a4Y7ijHqI9exGxn9cEp8iIo9Ur0uyJVVVmhBtz0
	 YGLFkSX3K/xA1Jt09l/B6qeKyjMdSz5262JVP3+MbCf069rwc0iWvapV4/x8LLAZti
	 g2M6FGboAajoTqdHeYjjb15f0lXfFHL3GiV51RIHUz9aITNuzg60+RMyCAJ/h054lr
	 2fc3CE4qEjPRK5vMPa+hczGF8KtAf6b2M9nhJwD3M2WKohmlwqMkxTsGgYY2nV0fHa
	 HMYyxZ/yoTmfb5Tbkp8gATSM8LQ9OTEy52XjNvyHfNFyW6k2teWQHooly4ZAiXnZJJ
	 rbatHg+/EdLCw==
Date: Fri, 18 Oct 2024 20:17:28 +0100
From: Mark Brown <broonie@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Donald Zickus <dzickus@redhat.com>, workflows@vger.kernel.org,
	automated-testing@lists.yoctoproject.org,
	linux-kselftest@vger.kernel.org,
	kernelci <kernelci@lists.linux.dev>,
	Nikolai Kondrashov <nkondras@redhat.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	kernelci-members <kernelci-members@groups.io>,
	laura.nao@collabora.com
Subject: Re: [RFC] Test catalog template
Message-ID: <a3752d83-7ca2-4ab7-9228-e762d9211a3b@sirena.org.uk>
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VyPTSV0RNA4X4lYJ"
Content-Disposition: inline
In-Reply-To: <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
X-Cookie: What is the sound of one hand clapping?


--VyPTSV0RNA4X4lYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2024 at 03:21:58PM +0800, David Gow wrote:

> It's also probably going to be necessary to have separate sets of
> tests for different use-cases. For example, there might be a smaller,
> quicker set of tests to run on every patch, and a much longer, more
> expensive set which only runs every other day. So I don't think
> there'll even be a 1:1 mapping between 'test collections' (files) and
> subsystems. But an automated way of running "this collection of tests"
> would be very useful, particularly if it's more user-friendly than
> just writing a shell script (e.g., having nicely formatted output,
> being able to run things in parallel or remotely, etc).

This is definitely the case for me, I have an escallating set of tests
that I run per patch, per branch and for things like sending pull
requests.

> >   maintainer:
> >     - name: name1
> >       email: email1
> >     - name: name2
> >       email: email2
> >   list:

> How important is it to have these in the case where they're already in
> the MAINTAINERS file? I can see it being important for tests which
> live elsewhere, though eventually, I'd still prefer the subsystem
> maintainer to take some responsibility for the tests run for their
> subsystems.

It does seem useful to list the maintainers for tests in addition to the
maintaienrs for the code, and like you say some of the tests are out of
tree.

--VyPTSV0RNA4X4lYJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcStEcACgkQJNaLcl1U
h9Av3Af7BWZP998q7HAR9n0kAkjsi6kf2c+3+NX1Yr+i3gyJFihBUdBOclT+A5jz
3VrnKnLVwmepJ5KhUbDJkHK6v5ATmz8DO8EQEl6lOXnrumi4JPeZB53rsQmHHP5L
c2gjl7u4IhARS1SzibLfV0edgMrQ/epFvp0nej/3Q1FhviJUEuTykLIwW3NuOmd5
Fyeh8TkMc+CqTNBmQ29anZ8V+rCgwU3/eLfOP4rdCPeR3HZajhK0myNa2JPSGUsr
L8qq00nWNh0p9CFCc0Mj+ESjvQwd7SFuGiQCmDia+jCVadEhiWkAeAsJQPVvCNIY
5KYdJTIRO9CwO9ZtfMVvFrEAs0XM3w==
=Ef3N
-----END PGP SIGNATURE-----

--VyPTSV0RNA4X4lYJ--

