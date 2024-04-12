Return-Path: <linux-kselftest+bounces-7792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 066788A2D86
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD204B22C8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859454F87;
	Fri, 12 Apr 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Prz6xAi7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FA2208E;
	Fri, 12 Apr 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921721; cv=none; b=LnQU+fxnLcdQZ1zCZ02wyV50grm+sZW03ybld/V4ROERI7AkMe0zyQJC6Iu+kYXhamWGZgSs5USV/+AElyriakZA69tIrtNojCwRQV01jyuC60KNhL51Fac5vXsv8mTFW3Otma3uu4e+WJxBZaV8xttyx6Ao97G0669Abkc65C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921721; c=relaxed/simple;
	bh=rFo3W94iUSuQhBrmABhl4gWFChYqSdvcm2Lgae2EHdY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUvFXXFN2TYhcO/Vw055oV3AL8iBMDHvkISAY+vsJ/c48cIQx4l9H3XV6bppfuOkVfP8rY3NVxbYzukmaa+tHhZyMvIjEXMlvBKAtOy4rihLgDBa9EM9reYmUu/6i3ppNOGGv9IX/zTthn1XcGBC1ogFM+ppdiAdyHhNsuXZkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Prz6xAi7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712921719; x=1744457719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rFo3W94iUSuQhBrmABhl4gWFChYqSdvcm2Lgae2EHdY=;
  b=Prz6xAi7qjyKg/jAhQ6oUohFWpGBVZJWSAiR9tJbz6cVLOnF+mKnOKLx
   9TkWbSINfHXwZutk8pAReO8YtoyDCpD3RH4S85KHSgSzabvPxWhjWd55n
   Fyqa02AMdBYVZLj5FqHUxirVkxgVnx38K7ah08S9hXgPu7iq8rlNSvVBb
   KWKsXHEPWQTyC7Nd1NiIvKdKv43UaMc7aNjG5O35009WIcHpAC/BkW43V
   PU6O+KyQJAaaFUIWw2iWVggkTbMaTxHUGUkATDM7j1GvaC4bxhmhXirDU
   l+MV/l9dHgg0b+31E0hkKI6R+VQo2s7J+rI5D+oDrdp66dn5bG6QN9u9X
   g==;
X-CSE-ConnectionGUID: DNSnegTRQWK/aU/b9HmXRg==
X-CSE-MsgGUID: 3ZwNcCjXROqOSmEhUdI/pw==
X-IronPort-AV: E=Sophos;i="6.07,196,1708412400"; 
   d="asc'?scan'208";a="20733643"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 04:35:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:34:56 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 04:34:52 -0700
Date: Fri, 12 Apr 2024 12:34:01 +0100
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
Subject: Re: [PATCH 14/19] riscv: hwprobe: Disambiguate vector and
 xtheadvector in hwprobe
Message-ID: <20240412-moonshine-acting-0df1a90b86d2@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-14-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CIbAOIHVm3rWkC3a"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-14-4af9815ec746@rivosinc.com>

--CIbAOIHVm3rWkC3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:20PM -0700, Charlie Jenkins wrote:
> Ensure that hwprobe does not flag "v" when xtheadvector is present.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/kernel/sys_hwprobe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 8cae41a502dd..e0a42c851511 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -69,7 +69,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  	if (riscv_isa_extension_available(NULL, c))
>  		pair->value |=3D RISCV_HWPROBE_IMA_C;
> =20
> -	if (has_vector())
> +	if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VEND=
OR_EXT_XTHEADVECTOR))

Hmm, I think this is "dangerous". has_vector() is used across the kernel
now in several places for the in-kernel vector. I don't think that
has_vector() should return true for the T-Head stuff given that &
has_vector() should represent the ratified spec. I'll have to think
about this one and how nasty this makes any of the save/restore code
etc.

>  		pair->value |=3D RISCV_HWPROBE_IMA_V;
> =20
>  	/*
> @@ -112,7 +112,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pa=
ir,
>  		EXT_KEY(ZACAS);
>  		EXT_KEY(ZICOND);
> =20
> -		if (has_vector()) {
> +		if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VEN=
DOR_EXT_XTHEADVECTOR)) {
>  			EXT_KEY(ZVBB);
>  			EXT_KEY(ZVBC);
>  			EXT_KEY(ZVKB);
>=20
> --=20
> 2.44.0
>=20

--CIbAOIHVm3rWkC3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkcKQAKCRB4tDGHoIJi
0gvTAP9GH7U2Z0EXFSBtL7aH2M1WCi7IEFN7jXtiPAqbISwS6wD9H4wKMr87wqkO
InW23KBw0VsImbhAE0sE9pZfp34S4wM=
=jT/T
-----END PGP SIGNATURE-----

--CIbAOIHVm3rWkC3a--

