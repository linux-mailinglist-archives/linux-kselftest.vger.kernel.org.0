Return-Path: <linux-kselftest+bounces-8256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C18A86AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B0E1F212B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8DE1428F7;
	Wed, 17 Apr 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0TE9tNy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966C1411DB;
	Wed, 17 Apr 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365431; cv=none; b=PmZPPlZXynEAKggAjouHzX14Pdyy4w0WC0oOv0skEX3CEuXwRxaoiys2sHGc13uFK4UABAWFFnGtatfozAKoI9q7Kf9DOXJtHtGtZ9+4ljUfCc0tIirCgpyHX3W9rit+NajDFEWA9tt/CuM7Vp5L4qXWCYZGGvIxIpqm1XHPSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365431; c=relaxed/simple;
	bh=FykH/T46P+7wCQWaQbgZ5I3yQADVR9jYDVfl8lpXZM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfnvJLmgJ1D/1SovZLX32Y3CPm69iGic+Z7cBFHhyi4/8tOyAU2DyteJ3FI8Vw+yrVnCiKF7cMx+QFzQ8R4vkWD7fj7120JFDJ4T/E1dA3O7qc8JS5mn7kcUMi+8NNmVGG3T15RTYbkRYi6mJ82UozaqpgHpe5/tlXORW17xut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0TE9tNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0ADC072AA;
	Wed, 17 Apr 2024 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365431;
	bh=FykH/T46P+7wCQWaQbgZ5I3yQADVR9jYDVfl8lpXZM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0TE9tNy0I6n0GmJCfpRHv5LLvD0sH8KvnXmmKZyKXPN+5gEXa1Q4AzpPYORPb1xh
	 6FZSy9x854VCtsJj3uGAdR0tZAl4NgVGuKIpFvzOv7wQ/K1slgqe+H/pZwCHuXNc+I
	 OdqHsqKaB1sZzrNKlgxgQSHT6SVN4ew8Xt1FvR89JkG94e9Y5WUwwr6m3CcTva7TVU
	 axGqATm2OFiDzneSdmBmoG6CAyUFtgtaE6OtFXe+jyNkvltWV5OGGXBYFS1/HqHN+1
	 VATui1UTMFtHkyEBpfjqFA3OoMm0FuBmS5Qtw6Vov597ADDOjsY7mHjcUEne6ZAG6x
	 lLhgT/5aLIfzg==
Date: Wed, 17 Apr 2024 15:50:24 +0100
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
Subject: Re: [PATCH v2 13/17] riscv: vector: Support xtheadvector save/restore
Message-ID: <20240417-semisweet-willed-1ce1098d8c41@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-13-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TWtuz8+j2Sj8ixHN"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-13-c7d68c603268@rivosinc.com>


--TWtuz8+j2Sj8ixHN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:12:10PM -0700, Charlie Jenkins wrote:

> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 6727d1d3b8f2..f42eaa8178e9 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -33,10 +33,24 @@ int riscv_v_setup_vsize(void)
>  {
>  	unsigned long this_vsize;
> =20
> -	/* There are 32 vector registers with vlenb length. */
> -	riscv_v_enable();
> -	this_vsize =3D csr_read(CSR_VLENB) * 32;
> -	riscv_v_disable();
> +	/*
> +	 * This is called before alternatives have been patched so can't use
> +	 * riscv_has_vendor_extension_unlikely

() after that function name please.

> +	 */
> +	if (has_xtheadvector_no_alternatives()) {
> +		/*
> +		 * Although xtheadvector states that th.vlenb exists and
> +		 * overlaps with the vector 1.0 vlenb, an illegal instruction is
> +		 * raised if read. These systems all currently have a fixed
> +		 * vector length of 128, so hardcode that value.

I had this written before the meeting, so pasting it anyway:
-- >8 --
=46rom 5ed25d0f841e755b8dd4f1f6a3ea824601758d8e Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Wed, 17 Apr 2024 14:39:36 +0100
Subject: [PATCH] dt-bindings: riscv: cpus: add a vlen register length prope=
rty

Add a property analogous to the vlenb CSR so that software can detect
the vector length of each CPU prior to it being brought online.
Currently software has to assume that the vector length read from the
boot CPU applies to all possible CPUs. On T-Head CPUs implementing
pre-ratification vector, reading the th.vlenb CSR may produce an illegal
instruction trap, so this property is required on such systems.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
We could actually enforce the latter since we know the compatibles of
the relevant CPUs and can tell if xtheadvector is present.
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentat=
ion/devicetree/bindings/riscv/cpus.yaml
index d067f2a468ee..2a6449a0f1d7 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -95,6 +95,12 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
=20
+  riscv,vlenb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      VLEN/8, the vector register length in bytes. This property is requir=
ed in
+      systems where the vector register length is not identical on all har=
ts.
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false
--=20
2.43.0



> +		 */
> +		this_vsize =3D 128;
> +	} else {
> +		/* There are 32 vector registers with vlenb length. */
> +		riscv_v_enable();
> +		this_vsize =3D csr_read(CSR_VLENB) * 32;
> +		riscv_v_disable();
> +	}

--TWtuz8+j2Sj8ixHN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/hsAAKCRB4tDGHoIJi
0uymAQC52tKEjWhnlrK5EZxs57FTgtZequO5iT1oxcXhr1buWwD/eH4/QhI+A7+a
rSSXaCKwy6W28YxEUDpHe9r7Re8SMgs=
=l2tD
-----END PGP SIGNATURE-----

--TWtuz8+j2Sj8ixHN--

