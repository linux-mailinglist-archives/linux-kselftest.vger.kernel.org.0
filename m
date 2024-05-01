Return-Path: <linux-kselftest+bounces-9192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EC8B892F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 13:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FB41C212F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994F6518F;
	Wed,  1 May 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV/NkRDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425724F898;
	Wed,  1 May 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563004; cv=none; b=W8pwIlF4XJmxW1GKSgr7UuPSFm2BJs3ZSvexwCnt57bU4Ao1omsNdUXMjz6zATh/IudxleF5gE/UWo2yUt9x930Ifth+WOQkbVcecYNDlT22h6UB7+ZMzOUTfLS2bFd/5rN2k6ib7x3eiI2ML5WzqZOw4SrqghqumQiVvDBRkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563004; c=relaxed/simple;
	bh=wnyP0N2IUEGu5xTUV2erSrz4gmuy2GNmNKOOWDxahyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieeyATj0dycJcTqHrHqor7vCE5l4daB0M90lkW53PIYhRZbw+3UfjKjeB2Fy8Cl0YKvLNO3UHgh0Jl/XFW3/zoE+MO4gY+pGvp5Qi8cPMLSMwhzmVSyCA6AIXBm5FKH50aBgqey1HRHByTuvLqheRyBBDkpThAouxrytv6mGsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV/NkRDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46749C113CC;
	Wed,  1 May 2024 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714563003;
	bh=wnyP0N2IUEGu5xTUV2erSrz4gmuy2GNmNKOOWDxahyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FV/NkRDARin7EyZMp5zpEWMLOj7VUk5uwlOKmK/QraQENAekoYt74g9QAxgVzlN7Q
	 08GMdnBX9j1fCSX+x9eHg/9gkz/RRyQGC6WXGnBZKEQrc/FYO3xS2k2rJOgUeNOvO9
	 v+6TP+11RF1FxRoCP6ym+ANBFfHJod9ArKo9IAbRaqgfJWhwB1P4LfsvKEsURoylZR
	 HA405aAGd6qouJVCU+Tav/nkNNHiA3TFy/qmglhIqIAuB/6EkZ8Ogy42gqJmmRlz6H
	 Xeur1ue0wnBx8dK9Mr/kaiu3qffOQ5XkwtpYP2HF/F5YNEPWhYoshZQbfFN6YyH+RF
	 In72dVGW+yRmQ==
Date: Wed, 1 May 2024 12:29:56 +0100
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
Subject: Re: [PATCH v4 06/16] riscv: Introduce vendor variants of extension
 helpers
Message-ID: <20240501-tripping-acetone-e556e993ba95@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-6-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y5+x5J78UsrLnSS+"
Content-Disposition: inline
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-6-b692f3c516ec@rivosinc.com>


--Y5+x5J78UsrLnSS+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 02:29:20PM -0700, Charlie Jenkins wrote:

> index c073494519eb..dd7e8e0c0af1 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -844,25 +844,41 @@ void __init_or_module riscv_cpufeature_patch_func(s=
truct alt_entry *begin,
>  {
>  	struct alt_entry *alt;
>  	void *oldptr, *altptr;
> -	u16 id, value;
> +	u16 id, value, vendor;
> =20
>  	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>  		return;
> =20
>  	for (alt =3D begin; alt < end; alt++) {
> -		if (alt->vendor_id !=3D 0)
> -			continue;
> -
>  		id =3D PATCH_ID_CPUFEATURE_ID(alt->patch_id);
> +		vendor =3D PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
> =20
> -		if (id >=3D RISCV_ISA_EXT_MAX) {
> +		/*
> +		 * Any alternative with a patch_id that is less than
> +		 * RISCV_ISA_EXT_MAX is interpreted as a standard extension.
> +		 *
> +		 * Any alternative with patch_id that is greater than or equal
> +		 * to RISCV_VENDOR_EXT_ALTERNATIVES_BASE is interpreted as a
> +		 * vendor extension.

I think this stuff is all fine, since we can always re-jig things in the
future if needs be.

> +		 */
> +		if (id < RISCV_ISA_EXT_MAX) {
> +			/*
> +			 * This patch should be treated as errata so skip
> +			 * processing here.
> +			 */
> +			if (alt->vendor_id !=3D 0)
> +				continue;
> +
> +			if (!__riscv_isa_extension_available(NULL, id))
> +				continue;
> +		} else if (id >=3D RISCV_VENDOR_EXT_ALTERNATIVES_BASE) {
> +			if (!__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vend=
or, id))
> +				continue;
> +		} else {
>  			WARN(1, "This extension id:%d is not in ISA extension list", id);
>  			continue;
>  		}
> =20
> -		if (!__riscv_isa_extension_available(NULL, id))
> -			continue;
> -
>  		value =3D PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
>  		if (!riscv_cpufeature_patch_check(id, value))
>  			continue;
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/ve=
ndor_extensions.c
> index f76cb3013c2d..eced93eec5a6 100644
> --- a/arch/riscv/kernel/vendor_extensions.c
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -3,6 +3,7 @@
>   * Copyright 2024 Rivos, Inc
>   */
> =20
> +#include <asm/vendorid_list.h>
>  #include <asm/vendor_extensions.h>
>  #include <asm/vendor_extensions/thead.h>
> =20
> @@ -16,3 +17,42 @@ const struct riscv_isa_vendor_ext_data_list *riscv_isa=
_vendor_ext_list[] =3D {
>  };
> =20
>  const size_t riscv_isa_vendor_ext_list_size =3D ARRAY_SIZE(riscv_isa_ven=
dor_ext_list);
> +
> +/**
> + * __riscv_isa_vendor_extension_available() - Check whether given vendor
> + * extension is available or not.
> + *
> + * @cpu: check if extension is available on this cpu
> + * @vendor: vendor that the extension is a member of
> + * @bit: bit position of the desired extension
> + * Return: true or false
> + *
> + * NOTE: When cpu is -1, will check if extension is available on all cpus
> + */
> +bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendo=
r, unsigned int bit)
> +{
> +	unsigned long *bmap;
> +	struct riscv_isainfo *cpu_bmap;
> +	size_t bmap_size;
> +
> +	switch (vendor) {
> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
> +	case THEAD_VENDOR_ID:
> +		bmap =3D riscv_isa_vendor_ext_list_thead.vendor_bitmap;
> +		cpu_bmap =3D riscv_isa_vendor_ext_list_thead.per_hart_vendor_bitmap;
> +		bmap_size =3D riscv_isa_vendor_ext_list_thead.bitmap_size;
> +		break;
> +#endif
> +	default:
> +		return false;
> +	}
> +
> +	if (cpu !=3D -1)
> +		bmap =3D cpu_bmap[cpu].isa;
> +
> +	if (bit >=3D bmap_size)
> +		return false;
> +
> +	return test_bit(bit, bmap) ? true : false;
> +}
> +EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);

I wonder if we care to implement a non __ prefixed version of this, like
the standard stuff? The only __ version users of the standard one are in
kvm and core arch code, the "external" users all use the non-prefixed
version.

In any case,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Y5+x5J78UsrLnSS+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjIntAAKCRB4tDGHoIJi
0pG1AP9aIuCIPhbYrT1n7AA8UjSnOOwkB+PkZ7aGQQs6HdTO4gEA7aKglY8RnM0i
x4nkold+5MiZkBsWg8bRWX3UFKhfEAA=
=BvUa
-----END PGP SIGNATURE-----

--Y5+x5J78UsrLnSS+--

