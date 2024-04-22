Return-Path: <linux-kselftest+bounces-8605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A9E8AC8FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 11:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E92B20841
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE645FBB7;
	Mon, 22 Apr 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DFrm4TpI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FD50280;
	Mon, 22 Apr 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778557; cv=none; b=fmyLY24L4tbxyFkyAaoVa9MMWOuNu3tVSYxgeHWA3vZMHhiLMFrkk2q+Ww6l/rMNx27BsSi6/EEW+ZoY9VUac1b9HG/YyOnYdqHVyIhLTnkLd2+gHr2uNVgFJV9dy0tdnkChoOot0RhH0N9+t6s7HzRScROTMhmoL4PhCJjDSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778557; c=relaxed/simple;
	bh=677JTIwL5UswqAMre8oBa/Ouum0+FEfuPU/W+YYnR/8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMPEXpYKD0wH8TvYFKvrzVZL8zCJ00PyUW40VQdzdDOiuZ4jz8znqTQv7YrArNB/vSek7SLsJh9FrRZDNpDedUGsYCDM6LFVA1YE17VYOc4mSKRwf4pSKcG9HwpUoPN7kDP3LP5Wziyp8H9Dn5CJtJSpucU5qi8vtHNCxm2t/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DFrm4TpI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713778555; x=1745314555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=677JTIwL5UswqAMre8oBa/Ouum0+FEfuPU/W+YYnR/8=;
  b=DFrm4TpIsukX3mCQpWYKeR4jyMEZhmFuFTeJ+S3XNgn6eGhl5CKn4NA9
   NHkWuL2ymmyvREIkm+Y9HCmjeoEyAzN7MHN9aPch4V37wa6mFvE8LR+YZ
   cgYeFx5GqZPs7CULtKPxUKpKCFvdnDRqmsr9PGwj7tZf4Q1MYGVKsA9EN
   cvXGrNWzBRXRIbZ7Gn0pr+aPBLDeh8DSxx8iWYsPtfF4XqF2OZ5fARiDY
   TfBTk7wHowH+jVaxrO0rjgvU4pgGJg4GWxGzaV7EgB5Dk0gilfWg2z46v
   9gDDHjXT19XlhdBKVizuioZguS+U8YuEAHGIw/0FxEA+jpKlyJitz1rYV
   A==;
X-CSE-ConnectionGUID: pUtzPF9AQeyO8Y9fcaMWRA==
X-CSE-MsgGUID: RbrRuDOgRGGKP/iBnvhOVQ==
X-IronPort-AV: E=Sophos;i="6.07,220,1708412400"; 
   d="asc'?scan'208";a="22042204"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2024 02:35:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 02:35:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Apr 2024 02:35:37 -0700
Date: Mon, 22 Apr 2024 10:35:21 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel
	<anup@brainfault.org>, Shuah Khan <shuah@kernel.org>, Atish Patra
	<atishp@atishpatra.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <kvm@vger.kernel.org>,
	<kvm-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 04/12] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
Message-ID: <20240422-daylight-sassy-ff3b0d867fef@wendy>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-5-cleger@rivosinc.com>
 <20240419-clinic-amusing-d23b1b6d2af2@spud>
 <6ab9e591-f2f2-4267-8bdd-169ef0243e14@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qeeS7kj0r9HsIAfv"
Content-Disposition: inline
In-Reply-To: <6ab9e591-f2f2-4267-8bdd-169ef0243e14@rivosinc.com>

--qeeS7kj0r9HsIAfv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 10:53:10AM +0200, Cl=E9ment L=E9ger wrote:
> On 19/04/2024 17:51, Conor Dooley wrote:
> > On Thu, Apr 18, 2024 at 02:42:27PM +0200, Cl=E9ment L=E9ger wrote:
> >> The Zc* standard extension for code reduction introduces new extension=
s.
> >> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
> >> are left out of this patch since they are targeting microcontrollers/
> >> embedded CPUs instead of application processors.
> >>
> >> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> >> ---
> >>  arch/riscv/include/asm/hwcap.h | 4 ++++
> >>  arch/riscv/kernel/cpufeature.c | 4 ++++
> >>  2 files changed, 8 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/h=
wcap.h
> >> index 543e3ea2da0e..b7551bad341b 100644
> >> --- a/arch/riscv/include/asm/hwcap.h
> >> +++ b/arch/riscv/include/asm/hwcap.h
> >> @@ -82,6 +82,10 @@
> >>  #define RISCV_ISA_EXT_ZACAS		73
> >>  #define RISCV_ISA_EXT_XANDESPMU		74
> >>  #define RISCV_ISA_EXT_ZIMOP		75
> >> +#define RISCV_ISA_EXT_ZCA		76
> >> +#define RISCV_ISA_EXT_ZCB		77
> >> +#define RISCV_ISA_EXT_ZCD		78
> >> +#define RISCV_ISA_EXT_ZCF		79
> >> =20
> >>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> >> =20
> >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufea=
ture.c
> >> index 115ba001f1bc..09dee071274d 100644
> >> --- a/arch/riscv/kernel/cpufeature.c
> >> +++ b/arch/riscv/kernel/cpufeature.c
> >> @@ -261,6 +261,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> >>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> >>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> >>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> >> +	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
> >> +	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
> >> +	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
> >> +	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
> >>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> >>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> >>  	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> >=20
> > Ye, this looks exactly like what I "feared".
>=20
> Ok but for instance, Qemu actually set Zc* based on C/F/D. So the ISA
> string containing theses dependencies should actually also be allowed.
> So should we simply ignore them in the ISA string and always do our own
> "post-processing" based on C/F/D?

I'm not familiar with the contents of all of these extensions, but I
assume the reasoning for splitting them out is that you can implement
them but not maybe not implement C (or something similar)? If that's the
case, you cannot always imply.

--qeeS7kj0r9HsIAfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiYvWQAKCRB4tDGHoIJi
0tQCAP9mC34KZI4RlzykLZZJcqOkhj2mcUcNSSr/RaK9eFBoxQEA2vpvtlw6ZDsy
MIBjOz/mpW/guSx4/dUBlp9zwuIycAA=
=vD9i
-----END PGP SIGNATURE-----

--qeeS7kj0r9HsIAfv--

