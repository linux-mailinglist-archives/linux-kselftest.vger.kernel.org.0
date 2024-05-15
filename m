Return-Path: <linux-kselftest+bounces-10260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205888C69F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF761C2123A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632E15622F;
	Wed, 15 May 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF8iYYpJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167E156222;
	Wed, 15 May 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788028; cv=none; b=peRpPSnWO/PEIa5OGu2U+yT41d2tDltJBx9huesb7ttGt0kUTQ3FYpYQdpMmbEF9FIV+zSPxgxIYp3a+eY5ZkvXiiekQcnSco3brmCllvwKrKXOoMC/tdBTWqWo3/bxp6lBOYYxgP/DPjPrtmUHn8Y9XTZDZdsXgrdDHMSdDKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788028; c=relaxed/simple;
	bh=3i/POYwuo5W+l1r5f3w06dIkd/xGPKue75hnlbOliL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JznQeXpWJwLpsd07x6WjwtIjO6S8AmGskqJn9d6dA407Q0T7OtwrbCNASWXeZvs52sRdk5jgf+FbqRlP0BH2O2amR3mdT3LpHujSIlJI9NNN3McyIx9uvEqv2Q3vK/0wVcSSFtBP8Qa5fUw+f2dgWVCtMnQc3Weylu6rRnzkGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF8iYYpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E30C116B1;
	Wed, 15 May 2024 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715788027;
	bh=3i/POYwuo5W+l1r5f3w06dIkd/xGPKue75hnlbOliL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DF8iYYpJshvHDiL0aN1ynB1Xamqclpnm5VsF7Gb/scp5CbHlyYhY5T6KjtGiHzTWB
	 sWCeWecwaskt/I+Se+I3+9jzLZjdY5WApFbu3g1OU5/C6SaH5PdArGhjOmQRjdOnga
	 oP59kEoDooOB60AOf8sX0eXbvIVaWJXrLq5c73G96g77s/fPb3AdEbaGIB9tW30mZy
	 cuqbdplphnJa87SWxpquy/ytCaiuCmEJ4wGgHYnHeLM1rq9VjxZzEFYhy2Yfl5qbj3
	 +bkm2C9PCQexxHPocoNrwfFVB3ivvjrBCzeuYrYS9/WwLBVfG515YR8ixV2OW91ZdT
	 UvrWLVPJ+JMqQ==
Date: Wed, 15 May 2024 16:47:02 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
Message-ID: <20240515-bucktooth-squiggly-4facfc989f28@spud>
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240514-headcount-shrill-390ac0b9233c@spud>
 <7a26604f-2653-4140-9294-637b340282d1@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B+OPq6rJ8plGHjIi"
Content-Disposition: inline
In-Reply-To: <7a26604f-2653-4140-9294-637b340282d1@rivosinc.com>


--B+OPq6rJ8plGHjIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 03:26:23PM +0200, Cl=E9ment L=E9ger wrote:
> > This function is badly in need of some new variable names for the first
> > two parameters. It's hard to follow what each of them is meant to be
> > once you're inside this function and removed from their definitions.
> > The first parameter is the source bitmap that we've already filled from
> > the dt/acpi scan of that hart and the second is the per-hart data
> > structure that we're gonna assign it to and keep "forever", I think the
> > naming should reflect that.
>=20
> Yeah, wasn't sure of the naming at all. Would you be ok with the followin=
g:
>=20
> - source_isa: Input ISA bitmap parsed from ISA string (DT/ACPI)
> - resolved_isa: Output ISA bitmap resolved from the first one
> (configuration and extension dependencies matching).
>=20
> Since I'm a non-native english speaker, I'm not sure at all if it
> correctly means what they do, feel free to tell me if you have some
> better options.

I think those are fine, thanks.

--B+OPq6rJ8plGHjIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTY9gAKCRB4tDGHoIJi
0gfyAQD3gQ7fCpehp/K+Pj9OiStbPvZMpDXqnSuJw6Duajbu8AD+NUc2u8OiReCl
xfifv7AgIuj7zJ7HphX1WRFq4KJc6wQ=
=cKSf
-----END PGP SIGNATURE-----

--B+OPq6rJ8plGHjIi--

