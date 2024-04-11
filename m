Return-Path: <linux-kselftest+bounces-7685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70D8A0BC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 11:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B1DB264B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3CE143C77;
	Thu, 11 Apr 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tlvu/boS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEC143C62;
	Thu, 11 Apr 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826250; cv=none; b=L3VKh8HszYV7A3xk+cdAd5FkhyRJBtD8VFyrKb2Vx7UESlwlU9naE7g6myLzMvi1MtONtZjpjcp4aVVQbLE6zF9Cbpg2z4r7JiCIsK4BfDskYdS0KBkiDPy/xJsoFg9UUYzycYmpozYfU69hoqW5hCB5X1Z3fJ9/5UebxUXb+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826250; c=relaxed/simple;
	bh=6TmusjUX3vnMkNQepVsH4u+5hT3VrOI3o3ZMH1yhilU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF5Xhdb9KVgTHAzlMuxo3J3irhZvR79PAPIzvuP/En6CqNFTL3IO744Hrm8M1v+S4IltWiOnQyiiof30+p1QJkiDVG0rIp37cdcI95HsA2mRVYGY+k9qQey4WVH3RUiEh5nTpHfbuzEuLjCp05TK6uy0Zly3StSkYr/e32+M1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tlvu/boS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712826248; x=1744362248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6TmusjUX3vnMkNQepVsH4u+5hT3VrOI3o3ZMH1yhilU=;
  b=tlvu/boSLS6EuRsVNYCNe07oBP3KIstqVJKSGcysn2LCoaYO0Icn5Elk
   e9QROPNo2INRavrnWtB4HLOfPgJPgkRj9PKjHMUdAjak9/GQD3H0wBWT6
   g3mt4tg+CjQMm3er3iM5j+oG9hTMDQcWATJA/y6bKLZWrwW0g77q+lyq9
   zmkqEEzbRFYRtTt8i3UvDmIjdas2VqpRx/GEEFX/fDshv6VZSI340j122
   dQhtuSunlMynZPBtyQLzqaDoG53ELrigBDKtRsvFfwtYaeRd7kF7frGuN
   yyam8huptlC9hp+wUph1cFR6zoh/PiQR8I03xczdZnUn6ox8PL8u8wCBD
   g==;
X-CSE-ConnectionGUID: sBUxEcpYQIqblsPw1hMyfQ==
X-CSE-MsgGUID: 6LquUSg4QDGyfAHGclQ3bA==
X-IronPort-AV: E=Sophos;i="6.07,193,1708412400"; 
   d="asc'?scan'208";a="21080514"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 02:04:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 02:03:57 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Apr 2024 02:03:53 -0700
Date: Thu, 11 Apr 2024 10:03:03 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
CC: Deepak Gupta <debug@rivosinc.com>, Conor Dooley <conor@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Anup Patel <anup@brainfault.org>, Shuah
 Khan <shuah@kernel.org>, Atish Patra <atishp@atishpatra.org>,
	<linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 07/10] riscv: add ISA extension parsing for Zcmop
Message-ID: <20240411-superglue-errant-b32e5118695f@wendy>
References: <20240410091106.749233-1-cleger@rivosinc.com>
 <20240410091106.749233-8-cleger@rivosinc.com>
 <ZhcFeVYUQJmBAKuv@debug.ba.rivosinc.com>
 <20240410-jawless-cavalry-a3eaf9c562a4@spud>
 <20240410-judgingly-appease-5df493852b70@spud>
 <ZhcTiakvfbjb2hon@debug.ba.rivosinc.com>
 <1287e6e9-cb8e-4a78-9195-ce29f1c4bace@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4EMZ8FslzLz1hx5z"
Content-Disposition: inline
In-Reply-To: <1287e6e9-cb8e-4a78-9195-ce29f1c4bace@rivosinc.com>

--4EMZ8FslzLz1hx5z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:25:06AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 11/04/2024 00:32, Deepak Gupta wrote:
> > On Wed, Apr 10, 2024 at 11:27:16PM +0100, Conor Dooley wrote:
> >> On Wed, Apr 10, 2024 at 11:16:11PM +0100, Conor Dooley wrote:
> >>> On Wed, Apr 10, 2024 at 02:32:41PM -0700, Deepak Gupta wrote:
> >>> > On Wed, Apr 10, 2024 at 11:11:00AM +0200, Cl=E9ment L=E9ger wrote:
> >>> > > Add parsing for Zcmop ISA extension which was ratified in commit
> >>> > > b854a709c00 ("Zcmop is ratified/1.0") of the riscv-isa-manual.
> >>> > >
> >>> > > Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> >>> > > ---
> >>> > > arch/riscv/include/asm/hwcap.h | 1 +
> >>> > > arch/riscv/kernel/cpufeature.c | 1 +
> >>> > > 2 files changed, 2 insertions(+)
> >>> > >
> >>> > > diff --git a/arch/riscv/include/asm/hwcap.h
> >>> b/arch/riscv/include/asm/hwcap.h
> >>> > > index b7551bad341b..cff7660de268 100644
> >>> > > --- a/arch/riscv/include/asm/hwcap.h
> >>> > > +++ b/arch/riscv/include/asm/hwcap.h
> >>> > > @@ -86,6 +86,7 @@
> >>> > > #define RISCV_ISA_EXT_ZCB=A0=A0=A0=A0=A0=A0=A0 77
> >>> > > #define RISCV_ISA_EXT_ZCD=A0=A0=A0=A0=A0=A0=A0 78
> >>> > > #define RISCV_ISA_EXT_ZCF=A0=A0=A0=A0=A0=A0=A0 79
> >>> > > +#define RISCV_ISA_EXT_ZCMOP=A0=A0=A0=A0=A0=A0=A0 80
> >>> > >
> >>> > > #define RISCV_ISA_EXT_XLINUXENVCFG=A0=A0=A0 127
> >>> > >
> >>> > > diff --git a/arch/riscv/kernel/cpufeature.c
> >>> b/arch/riscv/kernel/cpufeature.c
> >>> > > index 09dee071274d..f1450cd7231e 100644
> >>> > > --- a/arch/riscv/kernel/cpufeature.c
> >>> > > +++ b/arch/riscv/kernel/cpufeature.c
> >>> > > @@ -265,6 +265,7 @@ const struct riscv_isa_ext_data
> >>> riscv_isa_ext[] =3D {
> >>> > >=A0=A0=A0=A0 __RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
> >>> > >=A0=A0=A0=A0 __RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
> >>> > >=A0=A0=A0=A0 __RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
> >>> > > +=A0=A0=A0 __RISCV_ISA_EXT_DATA(zcmop, RISCV_ISA_EXT_ZCMOP),
> >>> >
> >>> > As per spec zcmop is dependent on zca. So perhaps below ?
> >>> >
> >>> > __RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZCMOP,
> >>> RISCV_ISA_EXT_ZCA)
> >>>
> >>> What's zicboz got to do with it, copy-pasto I guess?
> >=20
> > Yes, copy-pasta :-)
> >=20
> >>> If we're gonna imply stuff like this though I think we need some
> >>> comments explaining why it's okay.
> >>
> >> Also, I'm inclined to call that out specifically in the binding, I've
> >> not yet checked if dependencies actually work for elements of a string
> >> array like the do for individual properties. I'll todo list that..
> >=20
> > Earlier examples of specifying dependency on envcfg actually had functi=
onal
> > use case.
> > So you are right, I am not sure if its actually needed in this
> > particular case.
>=20
> I actually saw that and think about addressing it but AFAICT, this
> should be handled by the machine firmware passing the isa string to the
> kernel (ie, it should be valid). In the case of QEMU, it takes care of
> setting the extension that are required by this extension itself.
>=20
> If we consider to have potentially broken isa string (ie extensions
> dependencies not correctly handled), then we'll need some way to
> validate this within the kernel.

No, the DT passed to the kernel should be correct and we by and large we
should not have to do validation of it. What I meant above was writing
the binding so that something invalid will not pass dtbs_check.

--4EMZ8FslzLz1hx5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhenRgAKCRB4tDGHoIJi
0ntrAP0Tj4WJ1c21e2spkfDS6PwV7wHiJYoWI9/4CiHZwAQORAEApMmTK1BWuikT
fiLbYMmFEHJbe4+ND/jrK1UaiylnyQ8=
=p9pA
-----END PGP SIGNATURE-----

--4EMZ8FslzLz1hx5z--

