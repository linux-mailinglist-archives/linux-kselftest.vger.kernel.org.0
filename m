Return-Path: <linux-kselftest+bounces-11860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203F907542
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100DE1C21B40
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD8145FF8;
	Thu, 13 Jun 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpWSvufS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50CF1422B4;
	Thu, 13 Jun 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289305; cv=none; b=R+220KDakv2cNuECy4MeDCIhZMbhTSETOeESWsZiIY6F8yvVXZ4twB0Hk9u408ScXNqGntRY/bKbNxecpq2yLpQfChqDaWQcJOxcRp0K610Pc8vE52SOUHaP5FqbPF675ks0ylbn0vm1IV/6r8KVZjZDeZBcwKFmXsaZrjDeshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289305; c=relaxed/simple;
	bh=JaP7qDY1oFoFZ4n3ApB2MhPSSgkthi/B+6BCfNqzZXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOtzsmOMZdJOP01hJudAMyC998RWfLftOx5pvptLJFOhdGsxhV4CROr42Hxyj6o+sfeRTuuYlT8y24gXw+kZzhusy+ffPTDnEic2wMZEP6HilaiEZhXqNvgELgmDzVtq6m9/vwCMctV1eaOYyY/VbeAg0ORod4+SABtc/KYwtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpWSvufS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9CEC32786;
	Thu, 13 Jun 2024 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289305;
	bh=JaP7qDY1oFoFZ4n3ApB2MhPSSgkthi/B+6BCfNqzZXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpWSvufSz4/6eYuosODegqx8fYaQJdmhbXOMc9p3b5WQ/gfIGYomNolbhKVu0XyEs
	 W2H0e+wQFo2NkfWXDAQ3LbTEDDBa2Alep0Fo++oTkFflawV4GEvJ9Wi9kiKocoOyXu
	 fIs689QlI2/OOyKKFS+JJohZLTVF2vzDfltpGmegtsEUMHY9J9XtRXAhn/OQjlS7AN
	 Mmo2SE5noT0cWKfvCzt91qNktweA/t/FLRttcxzlyVNGPmu4WlwLvnCi0XAQ/tlJrt
	 5M7dL1TY4lZA2RowibqCH1a4V1xRmTX8OuDJjQXYcjGojVOUCAUfkVjOtM3IOv6kmW
	 rvvZiMkjp8hjg==
Date: Thu, 13 Jun 2024 15:34:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dt-bindings: cpus: add a thead vlen register
 length property
Message-ID: <20240613-gauntlet-starlet-2aedade31a06@spud>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
 <20240610-xtheadvector-v2-2-97a48613ad64@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AQap8GU9ejAJchW7"
Content-Disposition: inline
In-Reply-To: <20240610-xtheadvector-v2-2-97a48613ad64@rivosinc.com>


--AQap8GU9ejAJchW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 03:56:39PM -0700, Charlie Jenkins wrote:
> Add a property analogous to the vlenb CSR so that software can detect
> the vector length of each CPU prior to it being brought online.
> Currently software has to assume that the vector length read from the
> boot CPU applies to all possible CPUs. On T-Head CPUs implementing
> pre-ratification vector, reading the th.vlenb CSR may produce an illegal
> instruction trap, so this property is required on such systems.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--AQap8GU9ejAJchW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmsDkgAKCRB4tDGHoIJi
0u7xAP9LpPul5GSNB17Xr63YXTnJb87tSBlm5oBD3QK4jgiBbAD/WyZuDo4SvIBG
T0dxQyzZxI2/QiuOT6A0fzXSpA+tgwY=
=i6hR
-----END PGP SIGNATURE-----

--AQap8GU9ejAJchW7--

