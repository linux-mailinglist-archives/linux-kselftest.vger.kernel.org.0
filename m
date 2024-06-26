Return-Path: <linux-kselftest+bounces-12816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E09186E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7B31C209C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0C18FC65;
	Wed, 26 Jun 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd0QDBCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856418FC63;
	Wed, 26 Jun 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418030; cv=none; b=rgRL2QPBCA0hj6r7wIH4xDHzkri9+VxcAdea89PIpspdW3KhQm9XRdlHhXHn0jXBxbwIXIFgCJQmejrkePFqFiBzSi7V6yFAzaiqDLzmUC0YUr+E7qdTSeWdEYc/qw9vNZnuwahsHZjsGrT8p6y5q6v39uxNn2bBeyj5kYH7nE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418030; c=relaxed/simple;
	bh=jBYsvNwmgV6evpl2+xehoqnbnw89piDUSEN3vF3JUsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfCkXeLno7kvP8KKdUPIwY9ll0Q0LkeBftnrwDY3QD68oz8+UkgNkA+pCC4ObF7mvgTHOsfkw/T5mxMK8NgebjFP8n+xV7pZA10DQPom5Xr+BIjyw/TTn285XJALTwV8TLU7FWHRYiJa/wyHXGSOigvg16m5Afi/9SF5d2XUx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd0QDBCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277EEC116B1;
	Wed, 26 Jun 2024 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719418029;
	bh=jBYsvNwmgV6evpl2+xehoqnbnw89piDUSEN3vF3JUsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hd0QDBCLhWTYECrLb097tL6rf8DJBIH5MMJvVnWzga1ddvmwY5ddxuBHWwYQZhgLj
	 u63dc5BBHxgXi3v8HFiwWZZ3AeulhEorzMOPpuQvQ2f0XrTKJHpy7o8rz9XhcBAOj4
	 tq4bE8NkUT7+FhcECv+eu44m4p2ZjnHxxqqpk7GXkJTQ9xw+9/7KHAIjL1+HwDDh42
	 WijpexDLfV7h7u4ZlOnmfHwErICoNRANro4H5K85z5TBlAqOwuhNJThWsCMxrKdXKh
	 cPVO6PFWgw5+tXhIzKmAqiQ7Z1atRgLolOda0FoAeSBT9zSevRiUNQpcXe4NRi5yZP
	 ffNcra6PcKm/g==
Date: Wed, 26 Jun 2024 17:07:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, mingo@kernel.org, tglx@linutronix.de,
	mark.rutland@arm.com, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <e5940e99-3247-43f2-b644-b9469252284f@sirena.org.uk>
References: <20240626054847.1463889-1-dev.jain@arm.com>
 <20240626054847.1463889-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dx3xOd6WDMoTxEhi"
Content-Disposition: inline
In-Reply-To: <20240626054847.1463889-3-dev.jain@arm.com>
X-Cookie: Results vary by individual.


--Dx3xOd6WDMoTxEhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2024 at 11:18:47AM +0530, Dev Jain wrote:
> This test asserts the relation between blocked signal, delivered signal,
> and ucontext. The ucontext is mangled with, by adding a signal mask to
> it; on return from the handler, the thread must block the corresponding
> signal.

This looks good on a first pass, I see there's a new version coming so
I'll go through again when that comes but I'd expect it's all good.

--Dx3xOd6WDMoTxEhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ8PKcACgkQJNaLcl1U
h9ADywf/VYdeEGxf4yGrFYB4PTNo/EDm6kQq4Rq9i6roSnh4yxxmCaJ3qvD2pSTO
vRRJhC6St1SfFA7YgTOnqr02uKuG9cAs47sRikRT7ua4zQBkpbLItDCJ+EYihzwR
3+np7JxFngPnkvjErOvnKf7+WSuX7lMNALiVgEUPQcDQnDdHquaOXBUc14OSSc/l
1WSyU9xgdTdn+1/zz8KcIJJ9UfZdgtcEPMA+l7abmhT18IGLoMGs0v/sA042acNr
ffvzRhYje6HY6Dq5mXKzJff3iyPqP0Uh4zd1x22zYZZSOfG1AhfOgESplCu6JOhi
qweqgSaNfPKIoJ2mr8KfxYLpS15X8Q==
=q0Uj
-----END PGP SIGNATURE-----

--Dx3xOd6WDMoTxEhi--

