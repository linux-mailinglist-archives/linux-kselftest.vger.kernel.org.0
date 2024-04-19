Return-Path: <linux-kselftest+bounces-8450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631B8AB26D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3329C28606E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FC3130AEF;
	Fri, 19 Apr 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jflr+Mer"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615E130497;
	Fri, 19 Apr 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541881; cv=none; b=IGWzmmrILE77SqXqEEwXMLbBcirUoePmO4TTkLZ3f+MCku0L7QBVAqxiaVCIxpxHjLfjcPFe7AT0x1VRC5FINz3RqoXDcTK4jMq7GLWUXVoub5VR/39mo8m7hH33asW3W573S4F9KEb8o23cUolJJY/bxhhFGgmalLVlahCUG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541881; c=relaxed/simple;
	bh=zWv/xUUueVGUPY7NUN+yMB++Labd0w15D1CcT2ZEb+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y66+Z3OrVQMRQnnTvsRlYP2SiEymYVpuC5f3Zgfd2x8FXZsdQ8ANq9TRZK4PQPmowpj+cU8MKostxuZCeaXboqrw6/PkSzxGP+Win33c/RIrPp8d0Ik5SYEiF665fV0q5NxkO4ZJbfNt9R50E1uXEVzbTYZjwdNCLdqUZclMWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jflr+Mer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCAFC2BD10;
	Fri, 19 Apr 2024 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541880;
	bh=zWv/xUUueVGUPY7NUN+yMB++Labd0w15D1CcT2ZEb+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jflr+Mery9Icxy3YAAa4Gdj1oYC1mkU/VBqOa5PU8S9zq1KHtzXsbjjighF29TwsJ
	 IEGyN7LbfLHMhudzxyLDGuBrxur2rD2/bITcoXu9aCd2TgbCbvg3HfWH4PKAV5xtgR
	 PVBM6v7TnN/bL4vZHAFIXwb7W3Eirxvr/YYmU+cXDmBCnSc52XsswVcM3GvavAVprm
	 j0hZ8UIKiDE8jB5I4EbIobbHFn+kCkpBe1s+WdO+MGy68eJJsLGnyYbjJPrLjc2UGZ
	 kKcV+moXe7AQVMTxZt43CKoqxWVDscrmU1W0b2RJa1R6w8JJaFX0Pp7uuDBjbJd9fs
	 tCoVpy/FjJG/Q==
Date: Fri, 19 Apr 2024 16:51:10 +0100
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
Subject: Re: [PATCH v2 04/12] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
Message-ID: <20240419-clinic-amusing-d23b1b6d2af2@spud>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-5-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QS4RfLs7pvJlTuus"
Content-Disposition: inline
In-Reply-To: <20240418124300.1387978-5-cleger@rivosinc.com>


--QS4RfLs7pvJlTuus
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 02:42:27PM +0200, Cl=E9ment L=E9ger wrote:
> The Zc* standard extension for code reduction introduces new extensions.
> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
> are left out of this patch since they are targeting microcontrollers/
> embedded CPUs instead of application processors.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 4 ++++
>  arch/riscv/kernel/cpufeature.c | 4 ++++
>  2 files changed, 8 insertions(+)
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
> index 115ba001f1bc..09dee071274d 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -261,6 +261,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> +	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
> +	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
> +	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
> +	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>  	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),

Ye, this looks exactly like what I "feared".

--QS4RfLs7pvJlTuus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKS7gAKCRB4tDGHoIJi
0j53AP91a0/pzMnYOB5Q1NSAdfxkcqTq0TgGDLsop/SUUlrxKAD+Oqehg3RXMuA6
lxMl1823mjF1OflpyCXnIjSA8qwLFAA=
=4Weq
-----END PGP SIGNATURE-----

--QS4RfLs7pvJlTuus--

