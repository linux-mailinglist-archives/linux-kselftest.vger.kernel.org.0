Return-Path: <linux-kselftest+bounces-7690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07728A13A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 13:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6963C286CC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836D14A4C9;
	Thu, 11 Apr 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bP56bhYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29714A094;
	Thu, 11 Apr 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836521; cv=none; b=elUc1XiTYlcaZfD3O3nyGnMus5utac1TQbH3jr8A6FBP/w7NuXnDw/kK0QNOs0RVqEHc9TmEJvhrdrT9asGTwDpk2QmNtQNROgN3Jaxw1lq9BjlJLmdk7b2svOUY9N/ZUUuJ3CdM+iL7i/tkyZpEtJP/n0mWBtLj5tkDs4HEkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836521; c=relaxed/simple;
	bh=qUHLbICK+OzVzpgAugTLlBx/+ikYrtOfR4K8Nx4oYfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr3rCctWzL7tBgODvASomc3yId/sR/r0qOevb+lhYrs04lcZ2vFqAXLmxjEASs19YdSI3sh8LIxJ8exVBpJO6SSir1VdeyVsoOJwgItQ5SVCPNUocZx+HY8eFqa+cvJkANTgbwd+YlfZjOSR6P5qhjGAypIXIdanB+uZAyaIdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bP56bhYa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712836519; x=1744372519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qUHLbICK+OzVzpgAugTLlBx/+ikYrtOfR4K8Nx4oYfw=;
  b=bP56bhYazXE6fy9pzuspJ00L7+mAYf9fViRTI/B1qbtIWpCrX5UoQgUr
   bsim6FASELIQkXU8tHt60EukTZDXe0LjQuo4NSLV+7S/Fj3JtebeURRLi
   cDS+/LaqmRv/U5HpGBa+A5vS1tV67B+o49zbWnUQhS2Zp97F3DZX0S+Pr
   Bz3kT3FrCrjtDT/8reOa+zOyVND2f//FmvRwndqA4tZT4Q010JJw77jTu
   A5YlSZEczLKN3i8aWAsom5h5/zlz22O0DNnmIfW+KJVpFhf0gxZq8I5Ms
   o2jQu7ShpC9vB/21on4GXcydv0LkNlmK2kcWIQ5JyG8s/qJPJBrhbBwbg
   g==;
X-CSE-ConnectionGUID: z5vJuW0ISXO47ggJt+rbgA==
X-CSE-MsgGUID: mQWA4GzKR12LP6aGbYLBwA==
X-IronPort-AV: E=Sophos;i="6.07,193,1708412400"; 
   d="asc'?scan'208";a="251356126"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 04:55:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:54:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Apr 2024 04:54:33 -0700
Date: Thu, 11 Apr 2024 12:53:43 +0100
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
Message-ID: <20240411-backwater-opal-00c9aed2231e@wendy>
References: <20240410091106.749233-1-cleger@rivosinc.com>
 <20240410091106.749233-8-cleger@rivosinc.com>
 <ZhcFeVYUQJmBAKuv@debug.ba.rivosinc.com>
 <20240410-jawless-cavalry-a3eaf9c562a4@spud>
 <20240410-judgingly-appease-5df493852b70@spud>
 <ZhcTiakvfbjb2hon@debug.ba.rivosinc.com>
 <1287e6e9-cb8e-4a78-9195-ce29f1c4bace@rivosinc.com>
 <20240411-superglue-errant-b32e5118695f@wendy>
 <c86f9fa8-e273-4509-83fa-f21d3265d5c9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jM0CNQ7ZIr2lhGV/"
Content-Disposition: inline
In-Reply-To: <c86f9fa8-e273-4509-83fa-f21d3265d5c9@rivosinc.com>

--jM0CNQ7ZIr2lhGV/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:08:21AM +0200, Cl=E9ment L=E9ger wrote:
> >> If we consider to have potentially broken isa string (ie extensions
> >> dependencies not correctly handled), then we'll need some way to
> >> validate this within the kernel.
> >=20
> > No, the DT passed to the kernel should be correct and we by and large we
> > should not have to do validation of it. What I meant above was writing
> > the binding so that something invalid will not pass dtbs_check.
>=20
> Acked, I was mainly answering Deepak question about dependencies wrt to
> using __RISCV_ISA_EXT_SUPERSET() which does not seems to be relevant
> since we expect a correct isa string to be passed.

Ahh, okay.

> But as you stated, DT
> validation clearly make sense. I think a lot of extensions strings would
> benefit such support (All the Zv* depends on V, etc).

I think it is actually as simple something like this, which makes it
invalid to have "d" without "f":

| diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
| index 468c646247aa..594828700cbe 100644
| --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
| +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
| @@ -484,5 +484,20 @@ properties:
|              Registers in the AX45MP datasheet.
|              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
| =20
| +allOf:
| +  - if:
| +      properties:
| +        riscv,isa-extensions:
| +          contains:
| +            const: "d"
| +          not:
| +            contains:
| +              const: "f"
| +    then:
| +      properties:
| +        riscv,isa-extensions:
| +          false
| +
| +
|  additionalProperties: true
|  ...

If you do have d without f, the checker will say:
cpu@2: riscv,isa-extensions: False schema does not allow ['i', 'm', 'a', 'd=
', 'c']

At least that's readable, even though not clear about what to do. I wish
the former could be said about the wall of text you get for /each/
undocumented entry in the string.

--jM0CNQ7ZIr2lhGV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhfPRwAKCRB4tDGHoIJi
0stXAP9uCAN5bZHcv91EPinTAeqedRCedCrkE5YEE9f8JUyrxgD8CAHddpGznZHx
TNOtc9GaDiQRS4tdrlJo9+Hn1Puv4w0=
=k3aJ
-----END PGP SIGNATURE-----

--jM0CNQ7ZIr2lhGV/--

