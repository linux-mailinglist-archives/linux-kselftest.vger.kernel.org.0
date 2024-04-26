Return-Path: <linux-kselftest+bounces-8920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07C8B3A26
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335092844FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE6B3610A;
	Fri, 26 Apr 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkVPE603"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2706EB5C;
	Fri, 26 Apr 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142159; cv=none; b=MdGthb8527tv746ZJQveQabsg00mUD+fgqvsQIy5lJvZx4VQYo9wyFnpwCq9+Jf6FGNO3MU4BU04hHHSvO8Z+nYutg/zsWs/Pjt3W9uRnn6O4I8JRqayXE01x8supMnsKPEzx7bCcLKQNJZW/VHqoDR3+hoq5rn6BKtjYsLz0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142159; c=relaxed/simple;
	bh=fvWCKMof3QYNLsCaCCHiN9bivg7kkxwrQ3p10OT8TKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W962lbnOi8JTdTUsp6/9fieP4vrkcJiUV539mmxo3S78IJAM6DAmB/lv/px+ijmLKyarXkHWCmdq8fBDPl1Vm7BqgIkdbD4yfO2T1vOOLKT+fzz0WswYO0zkvVsHOLBYARa6UMMLlKSQaGWL1m5IVMQHog+3VH2/xFD47rUsFLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkVPE603; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C4C113CD;
	Fri, 26 Apr 2024 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714142159;
	bh=fvWCKMof3QYNLsCaCCHiN9bivg7kkxwrQ3p10OT8TKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkVPE603ro8SVcnyj5gfGayGqBckvi1U15SCiOUS2p//vLtPWOVe4qbxdd/SxRdD3
	 F0lOcZnmAURdDAddOnOSBLUrPTVdi3bXVcThWbLxddt4hIP5wlYIvn7YXZko3iet54
	 QH/EeM++arDAydol9fkd3A6Btb173CrgPYfdI5qg6Ojz3h374XKfdj1Hr6hqfYld0i
	 Hs7amcRkVntlK/wfR/CEUZDafyZUzWL+RO+ffQvOyK10410R/a9k9caOvLFUMBRjGG
	 9J6ydOQMya87VMl8k3SBZvaGwvzu13gPIH+wkXrGioDhsH8RtKCC2F/ZHk3eFZ+Hu9
	 rKOyl5d/HxeQQ==
Date: Fri, 26 Apr 2024 15:35:53 +0100
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
Subject: Re: [PATCH v3 03/11] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
Message-ID: <20240426-pusher-bartender-9a1eddd9a422@spud>
References: <20240423124326.2532796-1-cleger@rivosinc.com>
 <20240423124326.2532796-4-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ROz/llGSkBkozfg7"
Content-Disposition: inline
In-Reply-To: <20240423124326.2532796-4-cleger@rivosinc.com>


--ROz/llGSkBkozfg7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 02:43:17PM +0200, Cl=E9ment L=E9ger wrote:
> The Zc* standard extension for code reduction introduces new extensions.
> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
> are left out of this patch since they are targeting microcontrollers/
> embedded CPUs instead of application processors.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

The potential split aside, I think what's here makes sense.

Thanks,
Conor.

> ---
>  arch/riscv/include/asm/hwcap.h |  4 +++
>  arch/riscv/kernel/cpufeature.c | 47 +++++++++++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 543e3ea2da0e..b7551bad341b 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -82,6 +82,10 @@
>  #define RISCV_ISA_EXT_ZACAS		73
>  #define RISCV_ISA_EXT_XANDESPMU		74
>  #define RISCV_ISA_EXT_ZIMOP		75
> +#define RISCV_ISA_EXT_ZCA		76
> +#define RISCV_ISA_EXT_ZCB		77
> +#define RISCV_ISA_EXT_ZCD		78
> +#define RISCV_ISA_EXT_ZCF		79
> =20
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 6d238c8dbccf..24bf3fbc0578 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -107,6 +107,29 @@ static bool riscv_ext_zicboz_validate(const struct r=
iscv_isa_ext_data *data,
>  	return true;
>  }
> =20
> +static bool riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
> +				   const unsigned long *isa_bitmap)
> +{
> +	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA);
> +}
> +static bool riscv_ext_zcd_validate(const struct riscv_isa_ext_data *data,
> +				   const unsigned long *isa_bitmap)
> +{
> +	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
> +	       __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d);
> +}
> +
> +static bool riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
> +				   const unsigned long *isa_bitmap)
> +{
> +#ifdef CONFIG_64BIT
> +	return false;
> +#else
> +	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
> +	       __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f);
> +#endif
> +}
> +
>  #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size,=
 _validate) {	\
>  	.name =3D #_name,									\
>  	.property =3D #_name,								\
> @@ -118,6 +141,9 @@ static bool riscv_ext_zicboz_validate(const struct ri=
scv_isa_ext_data *data,
> =20
>  #define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0, NULL)
> =20
> +#define __RISCV_ISA_EXT_DATA_VALIDATE(_name, _id, _validate) \
> +			_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, _validate)
> +
>  /* Used to declare pure "lasso" extension (Zk for instance) */
>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
>  	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
> @@ -209,6 +235,21 @@ static const unsigned int riscv_xlinuxenvcfg_exts[] =
=3D {
>  	RISCV_ISA_EXT_XLINUXENVCFG
>  };
> =20
> +/*
> + * Zc* spec states that:
> + * - C always implies Zca
> + * - C+F implies Zcf (RV32 only)
> + * - C+D implies Zcd
> + *
> + * These extensions will be enabled and then validated depending on the
> + * availability of F/D RV32.
> + */
> +static const unsigned int riscv_c_exts[] =3D {
> +	RISCV_ISA_EXT_ZCA,
> +	RISCV_ISA_EXT_ZCF,
> +	RISCV_ISA_EXT_ZCD,
> +};
> +
>  /*
>   * The canonical order of ISA extension names in the ISA string is defin=
ed in
>   * chapter 27 of the unprivileged specification.
> @@ -255,7 +296,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
>  	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
>  	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
> -	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
> +	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
>  	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
>  	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_x=
linuxenvcfg_exts,
> @@ -274,6 +315,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> +	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_dep=
ends),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_val=
idate),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_val=
idate),
>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>  	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> --=20
> 2.43.0
>=20

--ROz/llGSkBkozfg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiu7yQAKCRB4tDGHoIJi
0gh5AP0cbGNts8eoVZeDItSxQA5RKNgG88ExrmtRhfQLSdNEUwD/b5VaqUNBUM6U
7zMWwwWvojpz7oLhHEntm9Ys+IamPwE=
=wMBZ
-----END PGP SIGNATURE-----

--ROz/llGSkBkozfg7--

