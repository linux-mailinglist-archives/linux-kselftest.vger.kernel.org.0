Return-Path: <linux-kselftest+bounces-7786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238748A2C4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 12:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD60285A8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281753373;
	Fri, 12 Apr 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lRQnW+lm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7653E16;
	Fri, 12 Apr 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917613; cv=none; b=od2mWTXwCglC2tIj5Nc33X7dBomn3p3/MNspcQba+HHppECPU7jxfu0BOSh7F8V6eO6QU6aCByPS6vzqsxt8AKvQ+iZLUSBEGZZr/6A3n/OYh7SZZLj5N4mRVLHBxpIZTPPctyYCwj/PJUFG+kTVk8DxcQHTGUhaPa2uDK7lF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917613; c=relaxed/simple;
	bh=40Wqfd4r8w7pmze5vM3OJGtDYx+IFl6psH0Cqec/ypk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8UIfWcnT9ci7FsbgXXRFXOf+hmXngAexlSeYCWJRGGosPIBepSzOpQVrCjtp+Fa07gh3/uG2gV63qKxQYSrJcwDU0cywgifCAEg5ibbtN8yE4uSIBxOSs/jfZBS3CwxA5xc1n4vFJha5vZ6WQ8XqLxMqquK0cXa4Ly9XyTALFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lRQnW+lm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712917610; x=1744453610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40Wqfd4r8w7pmze5vM3OJGtDYx+IFl6psH0Cqec/ypk=;
  b=lRQnW+lmw/ugcL+EeAwVlQ9h+O2E4vuk98PZxGapJqzeBWlPOyA5/BId
   YTzEh2G0HyCggmnxQpZ/K2BtKdEnnS//61XNZjLklIM+vShe/SyOQS116
   F7t9dMkYRRQVx6hbVWMrYr/RTOeZ8gHCUpXiREzSNig1z+2O1NESuaAg3
   csFV7HE9ZSqr2iEUibEnzEDJtvHrg9TaCArBJ1MHFV4vTdR/oAlBLwWIG
   yohc25n4oWEl0A3phVdxRSgiTEsUlBZcuSOWAO6omZ/BPiPkgjgdPa34n
   g4X8tZTosne0NBJ1eLjlF/9lQqG13dDSAiC3dJIIBpyE/DvkLNJOPxHJw
   A==;
X-CSE-ConnectionGUID: ZU7OXHjzTCmT3jYqw1Xv5g==
X-CSE-MsgGUID: x9xw3+4GQs2S7ff9t2+dXw==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="188003463"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 03:26:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 03:26:42 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 03:26:38 -0700
Date: Fri, 12 Apr 2024 11:25:47 +0100
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
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240412-tuesday-resident-d9d07e75463c@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9J4y1ZtcO1sNylrs"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>

--9J4y1ZtcO1sNylrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:08PM -0700, Charlie Jenkins wrote:
> The riscv_cpuinfo struct that contains mvendorid and marchid is not
> populated until all harts are booted which happens after the DT parsing.
> Use the vendorid/archid values from the DT if available or assume all
> harts have the same values as the boot hart as a fallback.
>=20
> Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on =
older T-Head CPUs")

If this is our only use case for getting the mvendorid/marchid stuff
=66rom dt, then I don't think we should add it. None of the devicetrees
that the commit you're fixing here addresses will have these properties
and if they did have them, they'd then also be new enough to hopefully
not have "v" either - the issue is they're using whatever crap the
vendor shipped.
If we're gonna get the information from DT, we already have something
that we can look at to perform the disable as the cpu compatibles give
us enough information to make the decision.

I also think that we could just cache the boot CPU's marchid/mvendorid,
since we already have to look at it in riscv_fill_cpu_mfr_info(), avoid
repeating these ecalls on all systems.

Perhaps for now we could just look at the boot CPU alone? To my
knowledge the systems that this targets all have homogeneous
marchid/mvendorid values of 0x0.

> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

> @@ -514,12 +521,23 @@ static void __init riscv_fill_hwcap_from_isa_string=
(unsigned long *isa2hwcap)
>  				pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>  				continue;
>  			}
> +			if (of_property_read_u64(node, "riscv,vendorid", &this_vendorid) < 0)=
 {
> +				pr_warn("Unable to find \"riscv,vendorid\" devicetree entry, using b=
oot hart mvendorid instead\n");

This should 100% not be a warning, it's not a required property in the
binding.

Cheers,
Conor.

> +				this_vendorid =3D boot_vendorid;
> +			}


--9J4y1ZtcO1sNylrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkMKwAKCRB4tDGHoIJi
0v68AQD669QXYYGZU4Sw+Wu1jBsENutdxevRVfy9dIk6oB75uwEAp3mGiS9zEGbC
gOmDF/36Lm2Mc4K4SgfZISRAD+65oAI=
=tAZ7
-----END PGP SIGNATURE-----

--9J4y1ZtcO1sNylrs--

