Return-Path: <linux-kselftest+bounces-15535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4C954EBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1641C21A19
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7571BCA0A;
	Fri, 16 Aug 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLRW6Qec"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF3817
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825445; cv=none; b=cVhxLy/huQo3VG1zGL6FHcp2nKe7Qk2JUIPF8T0rc5602ViIt/c5oTrpVXS4evmQT8yAnQqJZFpaoaFJyFmsB9ArM7RxcKLDWHyBD7xQApbz7eF4pAlxm8kiM5ttNwqHUrejt4Kr8sM3Em31A2+5Xo1PhhgUL2IDuIfno2Oze1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825445; c=relaxed/simple;
	bh=gwGWleasfzZTjyzjYm+Cp+/F/TEJ7mXlGBA1Zr2ScjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUubNW0HmoPYCHtnpPeCVjN7eJDjE2dYhjHbpIGJpBxj7uiAWpS5A7AUG1Ofc3sc5wOkIeKiuU2U8YPeVjusDZ+T4tHmJVySf0/1tx/NE6t5iaz5KhbHSFxUdu/C43JjbjXOpDcjse13pERtdPjTDmru6yfXUynz3BtDS3iXITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLRW6Qec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69F0C32782;
	Fri, 16 Aug 2024 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723825444;
	bh=gwGWleasfzZTjyzjYm+Cp+/F/TEJ7mXlGBA1Zr2ScjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLRW6Qec1Y/l6pyft3eqIdCaz5QQ2xOFlCwV6wiVm+yGIUzX78L/XISkIVHY7peRz
	 m929eLZG3SdNRgFK12DZy5LE9IKbQXSlxiAVgSlWRWfpDdNh9T/UmYFfYHER/DGv7v
	 QLE5NH0t/7YJmgweLm51rJNTarVud7WQknek/OKYXMqur7wPoJZR1YH/Ju55lBzRjW
	 3208FYmwnj3oE00PU3B9vJEWIbqyrPfItLRq/muHjDLazSWY433fx5IUg4WCOPi7lE
	 jOy/VgmMl7ZffUyDa0eCBtmWD/QXlkh5NXmY7G15pMJTe2BMKAzJP5xuUVGL1Vdg8r
	 zbZyXMDeqMPng==
Date: Fri, 16 Aug 2024 17:24:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/8] kselftest/arm64: signal: drop now redundant
 GNU_SOURCE definition
Message-ID: <c3d152d9-1c6f-44ca-b431-fd4747ed1486@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
 <20240816153251.2833702-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kCIZpd7DfOUMI0DR"
Content-Disposition: inline
In-Reply-To: <20240816153251.2833702-2-andre.przywara@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--kCIZpd7DfOUMI0DR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 04:32:44PM +0100, Andre Przywara wrote:
> The definition of GNU_SOURCE was recently centralised in an upper layer
> kselftest Makefile, so the definition in the arm64 signal tests Makefile
> is no longer needed. To make things worse, since both definitions are
> not strictly identical, the compiler warns about it:
> <command-line>: warning: "_GNU_SOURCE" redefined
> <command-line>: note: this is the location of the previous definition

Reviewed-by: Mark Brown <broonie@kernel.org>

--kCIZpd7DfOUMI0DR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/fR8ACgkQJNaLcl1U
h9CW3Qf/RWVmwwK++KjOM21KJLrRE3mH+XZrderr+c/fAotniHQ++uCoRQKqAJqo
7OXb35Ft0BPd46ZCuMEUoICh/PZj5ZzK8wYBIhqlxOhGfvYy8tuIZtvMYohWRs3w
/HH2f4c/K8/f9JVwJ9HSpJJzGbs8TqbuwMJhi0c3NNB1ttc3OoJ6RYKML2aDCAeU
XNEdqgnozrTE483y24YPKxjG9e/IRCxqZmlqHE4F9soVm9kM/ZboGR24So9SCXeb
nNGJv3gmWx66Jlt3jx9RkEC1tO5SF6GCNmeDFh9PGpuucNyUJJLgaoDGxjNjlvdc
p+Uqeo7KF+oeqTOLcViKugKyfM339A==
=2Nbt
-----END PGP SIGNATURE-----

--kCIZpd7DfOUMI0DR--

