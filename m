Return-Path: <linux-kselftest+bounces-12523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7FE913C7F
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 17:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ADA1F227CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9971822D4;
	Sun, 23 Jun 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig2qEl3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977F1822C1;
	Sun, 23 Jun 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157385; cv=none; b=sDeiA8yEtr1ERb8jh+30IfWNXXcKhuWy4HxXiAo1o5DTK7a+0fg4pjrNWgfDoC7J3qk6V0E0tCb2Zh4Y3FD9PqDdxbP/BxyeBOvIcP5V/HPk3uGzpxcFWZfw60UxCW5MwHBiEVaVBdvKUjiRvFbNFa1npove0MInvVkEuzsEFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157385; c=relaxed/simple;
	bh=lOo+ByMOxJv+uOcBMeubi7V3Rm4GnZ1uYp8z+JG4D7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltnAK0ng+EdQ4iMmyxYl1RJvjsFBujwEyP3yfympcE7yfi1YuXIOrK6o4K7YIVx1QNWo0NbfR7lUq3wFzbseYWholSP3fr6WX3NNl4sT9rb4EMwLg5rPm3dFxwZPj9hVk8WVPegt4Q2cu3U7ebQhl1Wie5EhJhPJdWkZXvZPMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig2qEl3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C6C2BD10;
	Sun, 23 Jun 2024 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719157385;
	bh=lOo+ByMOxJv+uOcBMeubi7V3Rm4GnZ1uYp8z+JG4D7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ig2qEl3L4TVco7WlBwgMQUjId3RGZgfm6ZSQSHOUzIJt7J2AV7Kl9d399jRG/+/kk
	 yMdLpjNVa+o4mc419wbWElR7rwCDvJ7Odk5KwyJgy+AYatwVFBCtVjSamnAmi4LMFN
	 484fIdjkW+ZcWzV9AYNokqANEnZZjNRA2A/MfG37zTPPZunAVYCGVKw6ZVAe/mJDHG
	 n0Dar0++YGiGAgaRGvenduDqIdQozpvXoQnbL/N/TLBDiG9WV79LnkqZ2Il8O+UqV9
	 5Oeqnog/H75h1RByve23ecbkHVll3UcSUVnIP6kdJcX6RvSKWM+ts5ntO7bc+qra3d
	 oUKygciaWfakQ==
Date: Sun, 23 Jun 2024 16:42:59 +0100
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
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 08/16] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
Message-ID: <20240623-cornbread-preteen-4ec287aa165c@spud>
References: <20240619113529.676940-1-cleger@rivosinc.com>
 <20240619113529.676940-9-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XCIoMUFlsNIN40u9"
Content-Disposition: inline
In-Reply-To: <20240619113529.676940-9-cleger@rivosinc.com>


--XCIoMUFlsNIN40u9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 01:35:18PM +0200, Cl=E9ment L=E9ger wrote:
> The Zc* standard extension for code reduction introduces new extensions.
> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
> are left out of this patch since they are targeting microcontrollers/
> embedded CPUs instead of application processors.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/hwcap.h |  4 +++
>  arch/riscv/kernel/cpufeature.c | 55 +++++++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 18859277843a..b12ae3f2141c 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -87,6 +87,10 @@
>  #define RISCV_ISA_EXT_ZVE64F		78
>  #define RISCV_ISA_EXT_ZVE64D		79
>  #define RISCV_ISA_EXT_ZIMOP		80
> +#define RISCV_ISA_EXT_ZCA		81
> +#define RISCV_ISA_EXT_ZCB		82
> +#define RISCV_ISA_EXT_ZCD		83
> +#define RISCV_ISA_EXT_ZCF		84
> =20
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index a3af976f36c9..aa631fe49b7c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -111,6 +111,9 @@ static int riscv_ext_zicboz_validate(const struct ris=
cv_isa_ext_data *data,
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
> @@ -122,6 +125,37 @@ static int riscv_ext_zicboz_validate(const struct ri=
scv_isa_ext_data *data,
>  #define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _valida=
te) \
>  	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _vali=
date)
> =20
> +static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,

It's super minor, but my OCD doesn't like this being called "depends"
when the others are all called "validate".

> +				 const unsigned long *isa_bitmap)
> +{
> +	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA))
> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}
> +static int riscv_ext_zcd_validate(const struct riscv_isa_ext_data *data,
> +				  const unsigned long *isa_bitmap)
> +{
> +	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d))
> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}
> +
> +static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
> +				  const unsigned long *isa_bitmap)
> +{
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		return -EINVAL;
> +
> +	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}

--XCIoMUFlsNIN40u9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnhCgwAKCRB4tDGHoIJi
0ojNAP4zqID4s2fTIoOLI3MwCtAFLJWCKaU3UhLxLueoiVavOgD+I+moOCuXJqHu
LFPQJbfCtkhdREIdkaCj+l4fuZIM5AI=
=tBDW
-----END PGP SIGNATURE-----

--XCIoMUFlsNIN40u9--

