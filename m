Return-Path: <linux-kselftest+bounces-8308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834698A9728
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236BE1F23611
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D815B96D;
	Thu, 18 Apr 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lBfJr998"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35915AAD9;
	Thu, 18 Apr 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435638; cv=none; b=e1JIpZEXQSpfmvALV9/BTv56KyD//0ql/PO6doGqIfVnVwQOgsqoU4ds49JNevoaewlcZn2yn6WnA5ZWFKpC211ScJpsdGUAy8dgq3tAExDWyAmmRGBVVYk3zRdyaNN7UHwxZ8BJvfDM3zOX6CyLLsc66WwQv61Mtd39fDTmkrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435638; c=relaxed/simple;
	bh=WeZBsDuQNwuqcLLzHGYml04J8M2UBghlloEStXX5BnI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIuGirsDHCMKvi1Hb09PcDUjDeOXEmjfJtklZXA1lP+TaZRe+cGgy/n5vV5YMYd4ug/SGLpxZzdYyt0u0AoIszXoFsNSVowT7UuevHdWB8rlrjg1+djoLR7DvBXTyB77VJ5xRgPrJfQkwpSL8aJiYHN4dTSA3xJooRLx/rscO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lBfJr998; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713435638; x=1744971638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WeZBsDuQNwuqcLLzHGYml04J8M2UBghlloEStXX5BnI=;
  b=lBfJr998QU6G49TtDoYms07MqTLjXbStrvi+L8TZZT/S+S/HYrJ0QiY+
   Xi7UIxD7CeLWzTztRAoAnktT20RcTlERkBj92oTZATI8EhYr5QP5mDTS4
   6SsdbgXFlKIdZCFbL+/55Qf5gQZWEtx4HQ5ByFbhq0X2IbZI/Hq9yyo0M
   AZvAQaBrAiqkIc0WRfBPwNY1EPaNRRYdojtd1SslvsA8vq8EjmyiOigRS
   bUb/tNWBn2fAqdqb1OhAD1+WUHN4sbWaix2jP180/mt6tPy4Z/tKkcQ2k
   zdLmtObft514/T4fuV6lq+j0xEnK48cGrqjJPAQf8r/XUsZb55BGEJOsn
   g==;
X-CSE-ConnectionGUID: Uj/C6BjUSJ27K3aZQSHGBQ==
X-CSE-MsgGUID: XKQFOuaVQ5mdX7qWs3qYiA==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="asc'?scan'208";a="21586426"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 03:20:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 03:20:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 03:20:10 -0700
Date: Thu, 18 Apr 2024 11:19:55 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Andy Chiu <andy.chiu@sifive.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner
	<heiko@sntech.de>, Guo Ren <guoren@kernel.org>, Conor Dooley
	<conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Evan
 Green <evan@rivosinc.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Shuah Khan <shuah@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Vincent Chen <vincent.chen@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] riscv: cpufeature: add zve32[xf] and zve64[xfd]
 isa detection
Message-ID: <20240418-legged-catfish-8358cbe836de@wendy>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-4-e0c45bb6b253@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/qVfv2QvWwihzlW8"
Content-Disposition: inline
In-Reply-To: <20240412-zve-detection-v4-4-e0c45bb6b253@sifive.com>

--/qVfv2QvWwihzlW8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:49:00PM +0800, Andy Chiu wrote:
> Multiple Vector subextensions are added. Also, the patch takes care of
> the dependencies of Vector subextensions by macro expansions. So, if
> some "embedded" platform only reports "zve64f" on the ISA string, the
> parser is able to expand it to zve32x zve32f zve64x and zve64f.
>=20
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
> Changelog v3:
>  - renumber RISCV_ISA_EXT_ZVE* to rebase on top of 6.9
>  - alphabetically sort added extensions (Cl=E9ment)
> Changelog v2:
>  - remove the extension itself from its isa_exts[] list (Cl=E9ment)
>  - use riscv_zve64d_exts for v's extension list (Samuel)
> ---
>  arch/riscv/include/asm/hwcap.h |  5 +++++
>  arch/riscv/kernel/cpufeature.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e17d0078a651..f64d4e98e67c 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,11 @@
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
>  #define RISCV_ISA_EXT_XANDESPMU		74
> +#define RISCV_ISA_EXT_ZVE32X		75
> +#define RISCV_ISA_EXT_ZVE32F		76
> +#define RISCV_ISA_EXT_ZVE64X		77
> +#define RISCV_ISA_EXT_ZVE64F		78
> +#define RISCV_ISA_EXT_ZVE64D		79
> =20
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index f6f3ece60d69..38d09de518b1 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -188,6 +188,35 @@ static const unsigned int riscv_zvbb_exts[] =3D {
>  	RISCV_ISA_EXT_ZVKB
>  };
> =20
> +#define RISCV_ISA_EXT_ZVE32F_IMPLY_LIST	\
> +	RISCV_ISA_EXT_ZVE32X,

Not really a reason to have a list here, there's only one thing implied.
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--/qVfv2QvWwihzlW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiDzywAKCRB4tDGHoIJi
0snJAP9A1H3tdsAfC7x0n4uxmjKhN/QLFEqxtSbHh0TO3ExpQAD/eEqf5L56+de7
S/eSP6FR8y3aqB7ZO3o55fQW/xkj4A8=
=38Nm
-----END PGP SIGNATURE-----

--/qVfv2QvWwihzlW8--

