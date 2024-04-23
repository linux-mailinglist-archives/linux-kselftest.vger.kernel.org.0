Return-Path: <linux-kselftest+bounces-8717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4718AF493
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 18:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A64C1F25D0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131BE13D52C;
	Tue, 23 Apr 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0N9z2Dp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB813D510;
	Tue, 23 Apr 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890910; cv=none; b=j7Q+Eb3zQSDitVcUFmYzR/VWc6/pdxCdWDPqj/DuEdLJVGAOYxve1ghcx6d+zD7EQyJqq5P58YnP2B9AZ3iyZZaEo471kY/3HyDHaArPPXlKHWDYS8grTHWs/Ybkm3IUSDYKZTQh4o8wTFAcaqoH1Ds4UgpLPG4SH04+v4ayd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890910; c=relaxed/simple;
	bh=dDcEPFI4Ualc1uLvugD6+grOLhPWeZRyR8kTPMNYs3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ0RyWF7U4pcH4NthuPhKLWiJgBBfS/olC0LqhwXeWekkRhoit+MDbjFS4Wu6YFVP1g6vooL15JVo5cX0kyFhnlJpyPfB1z2xyoC2RgBVQW5vmowOMWRoPtLQ9AIY8GC4CTFiT05F9EQXR7dtM/5Lkm8xqVnPSrtk20lFYdDMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0N9z2Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2099AC116B1;
	Tue, 23 Apr 2024 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713890909;
	bh=dDcEPFI4Ualc1uLvugD6+grOLhPWeZRyR8kTPMNYs3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0N9z2Dpb8WrHvqNLiT000UhV8Y+9krxRJtMDjYhIaBZP1030Bof/Sp/hOK16Vnyt
	 pbVCxC1D1O5/vA65C3BsscHOwlAvYg1UpOpQ3EVxyzDTLUE1ZM+lZ8cmZu3/NkS3Tw
	 xVOk1gKZBGsmyD84IVNwPtg+ESwZW+XFy+bMdvO5bjU1uLsENudLBOWWYEhZMMT8Fa
	 vyNNR8+roNhWc/HCa+cWfetSA9UjIquzJOhYsoF6WnUMrvgZez9qPfpY5616SRkjrl
	 L6wHTtaUP4o+WnWmTSYwHJWDswPA3+5pzcdxtnlLflvYjbQiJdjWqAwg5QkWxRyxD2
	 yBGwCrlwvy10w==
Date: Tue, 23 Apr 2024 17:48:24 +0100
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
Subject: Re: [PATCH 2/5] riscv: add ISA extension parsing for Zimop
Message-ID: <20240423-juiciness-unethical-90ec18e4fabe@spud>
References: <20240404103254.1752834-1-cleger@rivosinc.com>
 <20240404103254.1752834-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zc1JrpErq69EY9Ys"
Content-Disposition: inline
In-Reply-To: <20240404103254.1752834-3-cleger@rivosinc.com>


--Zc1JrpErq69EY9Ys
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 12:32:48PM +0200, Cl=E9ment L=E9ger wrote:
> Add parsing for Zimop ISA extension which was ratified in commit
> 58220614a5f of the riscv-isa-manual.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e17d0078a651..543e3ea2da0e 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,7 @@
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
>  #define RISCV_ISA_EXT_XANDESPMU		74
> +#define RISCV_ISA_EXT_ZIMOP		75
> =20
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..115ba001f1bc 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -256,6 +256,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> +	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
>  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> --=20
> 2.43.0
>=20

--Zc1JrpErq69EY9Ys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZifmVwAKCRB4tDGHoIJi
0rtUAQCfFhskrVJaQGT4zQgAGIaJX6eQRM8RECwtSJ2o0cGu0gD+IKq0dbK1gZnO
+otlDf1x+J0DKBOQ9YLeg8J2xFWRTAk=
=AiuW
-----END PGP SIGNATURE-----

--Zc1JrpErq69EY9Ys--

