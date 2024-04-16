Return-Path: <linux-kselftest+bounces-8167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA548A6F4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C17D1C214FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5512FF9B;
	Tue, 16 Apr 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeXYVayM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5012FB02;
	Tue, 16 Apr 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279934; cv=none; b=vDr7FlKa7ShNvmsVYCK/GHfxJb75Eki55WGKQl0t9Rf794CSbhi6l7nstou3kUHBOs0rT8F5g3GLv1x2C7kq8xdw+Wc1FDssUxIAdP5Eg6UlPpTsin+kf3gk4L2Swj7ZOZAsj7SXML+g7Ks8YNNMM9F7jlezUab26zmipyR3r3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279934; c=relaxed/simple;
	bh=O9p4OJelM8j5ChKW6+ZnGM3uSLJaoJ69DKouPYKRqlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrHA7+gDPZqPlZ4nrHktnfpy0bfqERQ6STMPmoUuPnDlgbOZwiBMNKHBinvujCZacZ/No+5lYduuUuR7YvntYCHfXonf+Eg9jOyMqdEuodyEOmoOoa3cFs53xpaJpH0hzEf1RegFzY41cyeWX4kOVsQC9LiAEFOtsTLp5Vb0n9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeXYVayM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4437C32786;
	Tue, 16 Apr 2024 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713279933;
	bh=O9p4OJelM8j5ChKW6+ZnGM3uSLJaoJ69DKouPYKRqlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeXYVayMoFa9mEbIWXY9ZBGlRgib//9BkGwkvOXQc5ScFPvJWcyFuzBpZcXy6lmVV
	 R1UhVDdenW8hJS1bVLytbNm8Me0gheegQtCoE6g2LrJF615lVPFdplSs+V25UXlFe3
	 +fV6CmblloXgOY2hh0sHrjI9RFLZUuXKCknAa02JsFiIUXG4dypxmNKLEDcFzTAbBI
	 djrdXqCeqtQx3OmyUnf/pPiOCqJ3CCd/YhDD7HHzj3wXRMEr6N/ulunG+fAiCF79tR
	 Xu967LvfUwGz4YmxeEbhuKiu3sT4utLWKjldeb1lxX25lwpdlp4zswvSmg7aybUJ9P
	 UOBikzQmbzqRw==
Date: Tue, 16 Apr 2024 16:05:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/17] dt-bindings: riscv: Add vendorid
Message-ID: <20240416-cavity-afar-d25eaac5fb03@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-3-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wMBbbKu9mXXkxQXp"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-3-c7d68c603268@rivosinc.com>


--wMBbbKu9mXXkxQXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:12:00PM -0700, Charlie Jenkins wrote:
> vendorid are required during DT parsing to determine known hardware
> capabilities. This parsing happens before the whole system has booted,
> so only the boot hart is online and able to report the value of its
> vendorid.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

If we are gonna add these, I think we may as well add all 3. I'd also
tie them together, so that either you have none or all 3.

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index d87dd50f1a4b..030c7697d3b7 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -94,6 +94,11 @@ properties:
>      description:
>        The blocksize in bytes for the Zicboz cache operations.
> =20
> +  riscv,vendorid:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description:
> +      Same value as the mvendorid CSR.
> +
>    # RISC-V has multiple properties for cache op block sizes as the sizes
>    # differ between individual CBO extensions
>    cache-op-block-size: false
>=20
> --=20
> 2.44.0
>=20

--wMBbbKu9mXXkxQXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6TtgAKCRB4tDGHoIJi
0sLCAP9GK5EvwG7exqhsRC6YBSqncpF7d0Ozytay1vZqdS4XsQD/RpbWEV4Jsg1B
lsL0MHoKzJIL7pb7I+XCv8Ff59aiCwA=
=6uQe
-----END PGP SIGNATURE-----

--wMBbbKu9mXXkxQXp--

