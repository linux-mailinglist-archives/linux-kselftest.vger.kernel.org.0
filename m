Return-Path: <linux-kselftest+bounces-21862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF319C5BDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7032FB28508
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EC13A879;
	Tue, 12 Nov 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WledquTp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893D433CB;
	Tue, 12 Nov 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417926; cv=none; b=ivs9yb3eqqyb9s5LuENS28ay5oS9BEhSONAytGpsdMLN9CyY2g27jib9F+mi5mRxHLuF5GZkESj6hrFT9yi0JWGB+s9LUNfonSyirk5HeNZdS6HNa/A+ty4HMk3VXUkzrXMAICl4eNqFO2gGUOqeq6mknj935hpt6oNw6+YNMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417926; c=relaxed/simple;
	bh=fhzf1jcZSTAtYRSI99xDL2bTyDAMziFUtoPEDRFBo7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEIUCBs6QTrBKCtusxlzFjcfEgJD0p6osOMyAwF7LeR3lgpB0bEGx0PLewaH1d5aUMqJxopsI9Xi4oOdxKpEHTJEeliNrCPkc+8U83z5YffOBiB6E3V8elxmAsqovbRZsiHVbEKkyCdyIcZzajxHNNUWo1edoRcdEq8o6/509ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WledquTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEEEC4CECD;
	Tue, 12 Nov 2024 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417925;
	bh=fhzf1jcZSTAtYRSI99xDL2bTyDAMziFUtoPEDRFBo7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WledquTpOzLCn8K1NSvc85m+6IeY7VJhhVTy/4QavsGdoUpzWXffMrNOyd7G6SUfv
	 9/SXctGeD+w+dGadzhJjYM3Dx4g2DeAiR22gAAKrDHKuMKh/OuXXm8xgxILV32PeSS
	 v/2h0/icCFAULxX0nwa9PhD+WgIed4gjgyfoKuHYiTuYC22ZIH3jMldHVNNtz2PCTb
	 qffJQpbIwEoVu3HstbEdOrKqVAiVs1v3PCB8wfT/CKU76RQMJ15xOVe4E/dxBpQ+J5
	 +nh+XS4A+fD2HdiByuYeQK7efVov589w+Y4CMl8H3YmHw+ezsgyhLPptYQEshJOUpI
	 osulbbKHU6LcQ==
Date: Tue, 12 Nov 2024 13:25:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Check that SVCR is 0 in signal handlers
Message-ID: <ZzNXQtbk1NWN6F7f@finisterre.sirena.org.uk>
References: <20241106-arm64-fpmr-signal-test-v1-1-31fa34ce58fe@kernel.org>
 <ZzM8RrD248eSW5bG@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l9TdSVVGcv9oOszk"
Content-Disposition: inline
In-Reply-To: <ZzM8RrD248eSW5bG@arm.com>
X-Cookie: Editing is a rewording activity.


--l9TdSVVGcv9oOszk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2024 at 11:30:14AM +0000, Catalin Marinas wrote:
> On Wed, Nov 06, 2024 at 05:07:51PM +0000, Mark Brown wrote:

> > +		fprintf(stderr, "Unexpected SVCR %llx\n", get_svcr());
> > +		return 1;
> > +	}

> I think I'll change both printf specifiers to %lx here since in the libc
> I have installed, uin64_t is an unsigned long (the kernel defines it as
> unsigned long long). Both gcc and clang complain but the compiler
> shouldn't matter since the headers come with glibc.

Makes sense.  I do wish the compilers were more consistent with
including these warnings :(

--l9TdSVVGcv9oOszk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmczVzYACgkQJNaLcl1U
h9ARyAf/ccxPjV6NvV0HX+NR8V0IrCkIUFYkF+JnPeCHw79ymsk9scQ+8HkDFvXA
OUzbd+d42XjQN4bMm6FK8NF0Be4syfkOUmP5EUx2x4aWMjghJZIpH53hORjDYH8m
ej9HimaSZlhkVUFEFsYeTgLH/NC0WbGKyW1KlnLpZ3oAZNzXNsRTM+vfKvkijvYn
nH4NcBHjA/p9duc9XDitUZISNE6sKMAZT0h8dOp6an2S4gSHLx2wLH5//Mbvinja
NpOzppfqHNEXN2DpGjvgLzEs6fQjRaRXnfno6QOBg6DTO+Qg40ExFexA2YwW43nY
d0PnQEXkJ4bwC6IVbirTiegjMLaLzA==
=q9Xo
-----END PGP SIGNATURE-----

--l9TdSVVGcv9oOszk--

