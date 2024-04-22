Return-Path: <linux-kselftest+bounces-8609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5D8ACC1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F141F22733
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD7B146A67;
	Mon, 22 Apr 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WIN6TNL0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D21465A2;
	Mon, 22 Apr 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785853; cv=none; b=M4KDAZmxt92HXAgeYNacJ6FJW1vr6V9PZV/F9ONGtROkmj+gcqtzTVtjEIwej0LcrE4EUluBwkih5ChUUogKD/GctVYta98hCkcq+edoeXmygTsGh8E0LrpzqBEWfvbyR8hPhnDU/1Z1pFVemEg2I3m4jFFQTcaTUbr++7DpdJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785853; c=relaxed/simple;
	bh=JirxwaUTPZ7gRRTADFPsE4LALCUoW+coAPWl1mh0lv4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCDK9w44yM3rQ4iSeAzUR7SZ41WHz8dcFyEWaqyZZwOY3GFkGehUINZspsRQSbsBOx7+gIlT6X5GlrW7Rc8vypzfCPJQfBNTB9EKu1W+qZWy0oS0qYmmnlp5avs1vDJlu7KUwditiZpkr0ici+lQ7eyvpKW36QaSbajBAw/Y4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WIN6TNL0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713785851; x=1745321851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JirxwaUTPZ7gRRTADFPsE4LALCUoW+coAPWl1mh0lv4=;
  b=WIN6TNL03JCsd7HKa0aw3VOEEuMCrHdC+t4+50oDi+OAczxbg4ptWVMj
   IeT58zkDtOaLps1dtLG7t4B4RxgBjs3HgoSeZF9lLtqPbCmSLz5P8sY7x
   fHoo1qFNrHBttf1r6QZvGABPMfRHQIlEFF1QEpsnW+2Bkd0gMMqqmfjRT
   9vslTZO88+WMbvvrsHMA2X04y4WaHAxhdumql9cEWiNKXTDMb7HRM7KH4
   D84ZS6R5Z8byef3xFrQh0dQ6/gDlk61smcDOSMUUZYOSNGYu+boWZIF5v
   qEqF1S7+gZw9Z8bDiyLhcfs1lLRngr8jR+O6Id2l5UTx4ez14EVJmoOdJ
   w==;
X-CSE-ConnectionGUID: RWC0UfowTpGbeC6DP7jNJg==
X-CSE-MsgGUID: E2DBmtQjS3e/5QeweITlcg==
X-IronPort-AV: E=Sophos;i="6.07,220,1708412400"; 
   d="asc'?scan'208";a="22099120"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2024 04:37:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 04:37:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Apr 2024 04:36:58 -0700
Date: Mon, 22 Apr 2024 12:36:42 +0100
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
Message-ID: <20240422-matchbook-unlikable-59987a8d8b1f@wendy>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-5-cleger@rivosinc.com>
 <20240419-clinic-amusing-d23b1b6d2af2@spud>
 <6ab9e591-f2f2-4267-8bdd-169ef0243e14@rivosinc.com>
 <20240422-daylight-sassy-ff3b0d867fef@wendy>
 <032530b8-a26e-494f-bd9c-3e1661add5d4@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BQeFG0OJOWz1hKp9"
Content-Disposition: inline
In-Reply-To: <032530b8-a26e-494f-bd9c-3e1661add5d4@rivosinc.com>

--BQeFG0OJOWz1hKp9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 01:14:26PM +0200, Cl=E9ment L=E9ger wrote:
> On 22/04/2024 11:35, Conor Dooley wrote:
> > On Mon, Apr 22, 2024 at 10:53:10AM +0200, Cl=E9ment L=E9ger wrote:
> >> On 19/04/2024 17:51, Conor Dooley wrote:
> >>> On Thu, Apr 18, 2024 at 02:42:27PM +0200, Cl=E9ment L=E9ger wrote:
> >>>> The Zc* standard extension for code reduction introduces new extensi=
ons.
> >>>> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
> >>>> are left out of this patch since they are targeting microcontrollers/
> >>>> embedded CPUs instead of application processors.
> >>>>
> >>>> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> >>>> ---
> >>>>  arch/riscv/include/asm/hwcap.h | 4 ++++
> >>>>  arch/riscv/kernel/cpufeature.c | 4 ++++
> >>>>  2 files changed, 8 insertions(+)
> >>>>
> >>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm=
/hwcap.h
> >>>> index 543e3ea2da0e..b7551bad341b 100644
> >>>> --- a/arch/riscv/include/asm/hwcap.h
> >>>> +++ b/arch/riscv/include/asm/hwcap.h
> >>>> @@ -82,6 +82,10 @@
> >>>>  #define RISCV_ISA_EXT_ZACAS		73
> >>>>  #define RISCV_ISA_EXT_XANDESPMU		74
> >>>>  #define RISCV_ISA_EXT_ZIMOP		75
> >>>> +#define RISCV_ISA_EXT_ZCA		76
> >>>> +#define RISCV_ISA_EXT_ZCB		77
> >>>> +#define RISCV_ISA_EXT_ZCD		78
> >>>> +#define RISCV_ISA_EXT_ZCF		79
> >>>> =20
> >>>>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> >>>> =20
> >>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpuf=
eature.c
> >>>> index 115ba001f1bc..09dee071274d 100644
> >>>> --- a/arch/riscv/kernel/cpufeature.c
> >>>> +++ b/arch/riscv/kernel/cpufeature.c
> >>>> @@ -261,6 +261,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[]=
 =3D {
> >>>>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
> >>>>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> >>>>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> >>>> +	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
> >>>> +	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
> >>>> +	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
> >>>> +	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
> >>>>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> >>>>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> >>>>  	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> >>>
> >>> Ye, this looks exactly like what I "feared".
> >>
> >> Ok but for instance, Qemu actually set Zc* based on C/F/D. So the ISA
> >> string containing theses dependencies should actually also be allowed.
> >> So should we simply ignore them in the ISA string and always do our own
> >> "post-processing" based on C/F/D?
> >=20
> > I'm not familiar with the contents of all of these extensions, but I
> > assume the reasoning for splitting them out is that you can implement
> > them but not maybe not implement C (or something similar)? If that's the
> > case, you cannot always imply.
>=20
> Yeah, they can be implemented independently so we need to be able to
> parse them independently.

> However, the kernel currently requires C

No it doesn't!
There's a Kconfig option that controls whether or not we build with
compressed instructions.

> so we
> should always have Zca/Zcf/Zcd. But if that changes in the future, then,
> that won't be true anymore. Better keep it generic probably


--BQeFG0OJOWz1hKp9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiZLygAKCRB4tDGHoIJi
0rZqAPsH+rOY+xwtmy02hvEj5S0LCo5WHbH42moKe/rg2JsecQD9Efgn3/dHRehg
SrE0p8oOablre3zPC16fRvmLyILrMAw=
=iMqf
-----END PGP SIGNATURE-----

--BQeFG0OJOWz1hKp9--

