Return-Path: <linux-kselftest+bounces-7793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D498A8A2DA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8E9281C68
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05854646;
	Fri, 12 Apr 2024 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B4ybTsXF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF245674E;
	Fri, 12 Apr 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921909; cv=none; b=oDt+yQddqy8ypjSYxfP8MnkCzruYTYP7oKC1WoPYjrWkUI6UH/4fvvK+xXwXQ03NleLePeG6kLQwAHp8hNIo1ZHBmQetjxDCjq8+Dqkd7K9LnpVVwaTcBVIl2AZ9IrgQAI9810mtQcW+zCHchVOytUAGNT/zqgv3WTELajROwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921909; c=relaxed/simple;
	bh=aWPWXWwePYJ7mcthXXcnh6W3EMOk6ujdepGmdYxSc0c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJsq8TpNdeQlIWq3QaksZlpxXCxO5vuYVnkRj1GUUTVPsAL5NGr6GtAMsk8Q8P4FAtIfXkpiyiOVOAiD/YHWd0bAWIyu+c4yI5CaYS2q6Oh/ePYJRAc53uRdUcgxTxyRMERlWvMsvGWVD7lx5mc2dCDo//8PnjFK7r0egy/guUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B4ybTsXF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712921908; x=1744457908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aWPWXWwePYJ7mcthXXcnh6W3EMOk6ujdepGmdYxSc0c=;
  b=B4ybTsXFVrSB7obR05QAb5IRs7584qdbH4++gFBdVj1o6VZ1GfDS8Irv
   ePwPuu8FILMnb3ZHUU+FAnj/rvxWpr6TGXCL48kFh73NFnNGXWNRErmgw
   DFPE+XUOoVsl9f1hajG8b9N47NMY8JVfslhQcs70iCuqzLIANti+pLrkQ
   BH7d6NeZCu68DKm3qih8nDAx5Y+E0IXTbRr27q5iAF7pKBnxTv91dktKU
   BBbZjnsR4cF6DXhPBFGlSJGM0E4lul8NbajMJIzeCTpi1BNZciYjNZFvv
   mX9zvcFKwFQauGWYd5XPAYDskpGoXSwQnLr2o+zCctuVpKn6Gpzvhrcq9
   Q==;
X-CSE-ConnectionGUID: ++lz7ARxTeyfeBIEUobjog==
X-CSE-MsgGUID: KH8PpH+1RGyAV72cISUUNA==
X-IronPort-AV: E=Sophos;i="6.07,196,1708412400"; 
   d="asc'?scan'208";a="20734020"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 04:38:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:38:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 04:37:59 -0700
Date: Fri, 12 Apr 2024 12:37:08 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Evan Green
	<evan@rivosinc.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<shuah@kernel.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 15/19] riscv: hwcap: Add v to hwcap if xtheadvector
 enabled
Message-ID: <20240412-thrill-amnesty-019897f21466@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-15-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibtP5+Ck2kdPiHYk"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-15-4af9815ec746@rivosinc.com>

--ibtP5+Ck2kdPiHYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:21PM -0700, Charlie Jenkins wrote:
> xtheadvector is not vector 1.0 compatible, but it can leverage all of
> the same save/restore routines as vector plus
> riscv_v_first_use_handler(). vector 1.0 and xtheadvector are mutually
> exclusive so there is no risk of overlap.

I think this not okay to do - if a program checks hwcap to see if vector
is supported they'll get told it is on T-Head system where only the 0.7.1
is.

>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 41a4d2028428..59f628b1341c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -647,9 +647,13 @@ static void __init riscv_fill_hwcap_from_isa_string(=
unsigned long *isa2hwcap)
>  		 * Many vendors with T-Head CPU cores which implement the 0.7.1
>  		 * version of the vector specification put "v" into their DTs.
>  		 * CPU cores with the ratified spec will contain non-zero
> -		 * marchid.
> +		 * marchid. Only allow "v" to be set if xtheadvector is present.
>  		 */
> -		if (acpi_disabled && this_vendorid =3D=3D THEAD_VENDOR_ID &&
> +		if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,
> +							   RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> +			this_hwcap |=3D isa2hwcap[RISCV_ISA_EXT_v];
> +			set_bit(RISCV_ISA_EXT_v, isainfo->isa);
> +		} else if (acpi_disabled && this_vendorid =3D=3D THEAD_VENDOR_ID &&
>  		    this_archid =3D=3D 0x0) {
>  			this_hwcap &=3D ~isa2hwcap[RISCV_ISA_EXT_v];
>  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
> @@ -776,6 +780,15 @@ static int __init riscv_fill_hwcap_from_ext_list(uns=
igned long *isa2hwcap)
> =20
>  		of_node_put(cpu_node);
> =20
> +		/*
> +		 * Enable kernel vector routines if xtheadvector is present
> +		 */
> +		if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,
> +							   RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> +			this_hwcap |=3D isa2hwcap[RISCV_ISA_EXT_v];
> +			set_bit(RISCV_ISA_EXT_v, isainfo->isa);
> +		}
> +
>  		/*
>  		 * All "okay" harts should have same isa. Set HWCAP based on
>  		 * common capabilities of every "okay" hart, in case they don't.
>=20
> --=20
> 2.44.0
>=20

--ibtP5+Ck2kdPiHYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkc5AAKCRB4tDGHoIJi
0gKCAP4v+esN57jD+BTAcXXG/qusYjMQbk1rVAldJniCgV0x0gEAibLnaoOuNXqF
Pa0786aCvAvHYTWbBfJ/ykNix6NyKQI=
=b/XX
-----END PGP SIGNATURE-----

--ibtP5+Ck2kdPiHYk--

