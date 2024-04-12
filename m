Return-Path: <linux-kselftest+bounces-7795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB55A8A2DC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CD41C21819
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C655C3B;
	Fri, 12 Apr 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ceZLQ1C4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECACF5490C;
	Fri, 12 Apr 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922658; cv=none; b=DJCSMRom9rmjzpdQYKiaYc9mbRfTm1ZrOg0rw26HUVfasfrZAmiPo1DMlqq2l7bN1llzchTPi9qC1jhlepLdSGQF8t1KbMabFa+4+YpcW2LtW3UA4dtjHzwFR696I7ecDUBag8kIJMHNrwSJWd8kxqfzAwTQQtudkA+JkR9PHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922658; c=relaxed/simple;
	bh=/MsWLEJD+g2lmJVxWXE9ihQ+XOiKAY5YDqrlImseWCM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkTOMCJ6nT0VWRGTTqrzdAubkjdpPqIgYxyy9ck1tHT0WPD2pN7B8VhkaDUQ7RSnmOjzLja4XawGDVOVvgWBHIPo0tLPLIKfJW7wmypAttHSl70OXqP4+3TJQeqXJYZSkvIMjtoi7Ml2RGTSSYaNDf0GVt0pjB58rlgvNp3DpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ceZLQ1C4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712922657; x=1744458657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MsWLEJD+g2lmJVxWXE9ihQ+XOiKAY5YDqrlImseWCM=;
  b=ceZLQ1C4Zx2xp8ul0pxyDVnNHXuLPYZXqxO0nQ7I6XuPbC6nIRuA69kI
   eRdD6eR8USM7wblnUfazwkwHa9e4JNspHaofp3h+0Ss3OL2sSky0ZfO0O
   DCXtC+07GOaBn3mLOuibI4nEHAdCWjDxMZDD2l1/kM5yuLW336YEc8nte
   qBLfarCIN9lgWPZWGI/4Wx0kALQeIkh6bo4Td73sVdN2/6j/iGHac/fyH
   FsZTJqBqXQWE2ulUcYqbtnLTThq6Vb8wzbEDGvlfodEUd10K1CzD9/QUI
   8uCnW0LyXswsfat1pUAKXZSRw4uEzoBIbuce0zXMuTDyRFnzCbCmVjmNp
   g==;
X-CSE-ConnectionGUID: DbXRGJMARISTcHYzzFqcJQ==
X-CSE-MsgGUID: r4WPBt/kRzewCEGLyzl6yw==
X-IronPort-AV: E=Sophos;i="6.07,196,1708412400"; 
   d="asc'?scan'208";a="20735309"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 04:50:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:50:52 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 04:50:48 -0700
Date: Fri, 12 Apr 2024 12:49:57 +0100
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
Subject: Re: [PATCH 08/19] riscv: Introduce vendor variants of extension
 helpers
Message-ID: <20240412-dwarf-shower-5a7300fcd283@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-8-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OxSigVsCwYUnQIoR"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-8-4af9815ec746@rivosinc.com>

--OxSigVsCwYUnQIoR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:14PM -0700, Charlie Jenkins wrote:
> Create vendor variants of the existing extension helpers. If the
> existing functions were instead modified to support vendor extensions, a
> branch based on the ext value being greater than
> RISCV_ISA_VENDOR_EXT_BASE would have to be introduced. This additional
> branch would have an unnecessary performance impact.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

I've not looked at the "main" patch in the series that adds all of the
probing and structures for representing this info yet beyond a cursory
glance, but it feels like we're duplicating a bunch of infrastructure
here before it is necessary. The IDs are all internal to Linux, so I'd
rather we kept everything in the same structure until we have more than
a handful of vendor extensions. With this patch (and the theadpmu stuff)
we will have three vendor extensions which feels like a drop in the
bucket compared to the standard ones.


> ---
>  arch/riscv/include/asm/cpufeature.h | 54 +++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/cpufeature.c      | 34 ++++++++++++++++++++---
>  2 files changed, 84 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index db2ab037843a..8f19e3681b4f 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -89,6 +89,10 @@ bool __riscv_isa_extension_available(const unsigned lo=
ng *isa_bitmap, unsigned i
>  #define riscv_isa_extension_available(isa_bitmap, ext)	\
>  	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
> =20
> +bool __riscv_isa_vendor_extension_available(const unsigned long *vendor_=
isa_bitmap, unsigned int bit);
> +#define riscv_isa_vendor_extension_available(isa_bitmap, ext)	\
> +	__riscv_isa_vendor_extension_available(isa_bitmap, RISCV_ISA_VENDOR_EXT=
_##ext)
> +
>  static __always_inline bool
>  __riscv_has_extension_likely_alternatives(const unsigned long ext)
>  {
> @@ -117,6 +121,8 @@ __riscv_has_extension_unlikely_alternatives(const uns=
igned long ext)
>  	return true;
>  }
> =20
> +/* Standard extension helpers */
> +
>  static __always_inline bool
>  riscv_has_extension_likely(const unsigned long ext)
>  {
> @@ -163,4 +169,52 @@ static __always_inline bool riscv_cpu_has_extension_=
unlikely(int cpu, const unsi
>  		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>  }
> =20
> +/* Vendor extension helpers */
> +
> +static __always_inline bool
> +riscv_has_vendor_extension_likely(const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_likely_alternatives(ext);
> +	else
> +		return __riscv_isa_vendor_extension_available(NULL, ext);
> +}
> +
> +static __always_inline bool
> +riscv_has_vendor_extension_unlikely(const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_unlikely_alternatives(ext);
> +	else
> +		return __riscv_isa_vendor_extension_available(NULL, ext);
> +}
> +
> +static __always_inline bool riscv_cpu_has_vendor_extension_likely(int cp=
u, const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_likely_alternatives(ext);
> +	else
> +		return __riscv_isa_vendor_extension_available(hart_isa_vendor[cpu].isa=
, ext);
> +}
> +
> +static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(int =
cpu, const unsigned long ext)
> +{
> +	compiletime_assert(ext < RISCV_ISA_VENDOR_EXT_MAX,
> +			   "ext must be < RISCV_ISA_VENDOR_EXT_MAX");
> +
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
> +		return __riscv_has_extension_unlikely_alternatives(ext);
> +	else
> +		return __riscv_isa_vendor_extension_available(hart_isa_vendor[cpu].isa=
, ext);
> +}

Same stuff about constant folding applies to these, I think these should
just mirror the existing functions (if needed at all).

Cheers,
Conor.

--OxSigVsCwYUnQIoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkf5QAKCRB4tDGHoIJi
0t21AQDpXCNkKreoJcGsD1c3KhhnWrrt3e8Dua+btfF4IRjd5AD+OTlLyxva26D5
OHyd+dKNVKNYXjtuHGTu8h6vqaR8mw0=
=H6/V
-----END PGP SIGNATURE-----

--OxSigVsCwYUnQIoR--

