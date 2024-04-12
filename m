Return-Path: <linux-kselftest+bounces-7788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6FE8A2CAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 12:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DD6B218A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5C3F9D5;
	Fri, 12 Apr 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GJNxqNCO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704C20310;
	Fri, 12 Apr 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918526; cv=none; b=MJsbeDvxaVokNh5XDiiZyAX8Gdzbvbjuo0fZy9JU188lc+DDNT6rtmjA8vaFDw0FKlWpEcKDjdGBGyWelybFU/xVgBVsi+HSn16HnRmkrw67KcI6t+lhqUr1aeZiSewcQxq5E+ZhRAhSHSCpR9Yi41gwy7aYUz+Yhv0O3reEc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918526; c=relaxed/simple;
	bh=X/p/ft+IL0tus7dW1yBsZJutmsAr0uojLmY1LWYjZes=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjSykpl8DynrJekHBiF5mbdmqpEl5mQuy3E3XppnrYIJcl4A2svqfZVBlpLc+RRLOJOylx5eh02d20Sc8461yfTrQSpHMLrxUboP8F35MmOZRE/ppXiVE0ivFtfyHW3fSEGKQLt8pmC4gLgVfdEGg4+081KwK6WWfHPF9CDcVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GJNxqNCO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712918524; x=1744454524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X/p/ft+IL0tus7dW1yBsZJutmsAr0uojLmY1LWYjZes=;
  b=GJNxqNCOgW14345HFh2W//scsLVA5YXzVszRvY5ns/CCFepjKdJ2fyK4
   jRN00EWC47Y3OQcvTDu++GS0E8OQ+q9Z3uMa789dHSCLAGi7YQsZ06ndy
   kbljM56PtNzPcdVWhf9d4xxkXsJf4IiyCexleQhs59Ava6+UG8KhfDTnN
   gKR8+7m9oG09u/RZx1gfEbYy/d2VrYOzvg81llx8IOwLaz6pgesBLKxKW
   hupzj1RqqWVDusfd2C9vJFZ6eg1D+ZkHBO+D1mKFiAHZW0QDNfortM35R
   jbbkEhrwBcNanlSikW/7BvC+yrSjynU2t/eSvFy2NXHALA3nlec62dlhk
   g==;
X-CSE-ConnectionGUID: tAWyHYMtQVGntX8nk/B7jA==
X-CSE-MsgGUID: 13SAqUUaRYm44u3/FKnbdQ==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="20728192"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 03:42:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 03:41:33 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 03:41:29 -0700
Date: Fri, 12 Apr 2024 11:40:38 +0100
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
Subject: Re: [PATCH 07/19] riscv: Optimize
 riscv_cpu_isa_extension_(un)likely()
Message-ID: <20240412-aerosol-heritage-cec1eca172fb@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-7-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YUt35LWoARaS+0kq"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-7-4af9815ec746@rivosinc.com>

--YUt35LWoARaS+0kq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:13PM -0700, Charlie Jenkins wrote:
> When alternatives are disabled, riscv_cpu_isa_extension_(un)likely()
> checks if the current cpu supports the selected extension if not all
> cpus support the extension. It is sufficient to only check if the
> current cpu supports the extension.
>=20
> The alternatives code to handle if all cpus support an extension is
> factored out into a new function to support this.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---

>  static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, co=
nst unsigned long ext)
>  {
> -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikel=
y(ext))
> -		return true;
> +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> +			   "ext must be < RISCV_ISA_EXT_MAX");
> =20
> -	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && __riscv_has_extension_unlik=
ely_alternatives(ext))
> +		return true;
> +	else
> +		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }

static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const u=
nsigned long ext)
{
	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext=
))
		return true;

	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
}

This is the code as things stand. If alternatives are disabled, the if
statement becomes if (0 && foo) which will lead to the function call
getting constant folded away and all you end up with is the call to
__riscv_isa_extension_available(). Unless I am missing something, I don't
think this patch has any affect?

Thanks,
Conor.


--YUt35LWoARaS+0kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkPpgAKCRB4tDGHoIJi
0gSNAQC+oMqT7zoEL9RxUhkl7uImpatcHajgjd6QJ8PnV2xTcgD/YMRe1XytJnd7
9pJBNiy2EcDN51fcQvf7s4vI9GM9Awc=
=Tq3D
-----END PGP SIGNATURE-----

--YUt35LWoARaS+0kq--

