Return-Path: <linux-kselftest+bounces-8310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2088A9764
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAEB1C21E6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF355769;
	Thu, 18 Apr 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z00elmWE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94F8821;
	Thu, 18 Apr 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436249; cv=none; b=u2ilw5EoqyrUsSD8cOmgjcUyS6/hmh84OtXq/LCz3hUMsaHjZlO8wtFKiRPkhBMX1pgeDfYD6Ftt4M7c4e0EZmzFgaMgTKMpeInma9gWj8FcLKlh9qZOsMn9Sh2Arng+12JvOmUC3PhZzEq/iRfOx9WdI7SclTFryuLzpi1zQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436249; c=relaxed/simple;
	bh=Kx/O3NbYmmye71xw/73E2GXjtvhWZUZ9V2RPXla/lMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIC6xWzJeor+eSlvEijC+hXqYsJYoIEM3ZHxgewX3chTnwge1s6c6nPo3d/1X2FWozKusGMsTgdBWhQ+VzYBtoHjA5Lt9xnPxixMkiNlzJidtuHDi+Gr5QHVOSt0wVt5vHw+Upt0IPpYCp9LUzUgWizfQ14tziyMAETnr/k9EaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z00elmWE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713436246; x=1744972246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kx/O3NbYmmye71xw/73E2GXjtvhWZUZ9V2RPXla/lMw=;
  b=z00elmWELtbcPeTB4DKGS+v09AG49WHfYDhBaHLFLTU5mYA+7bb22pDv
   r89yMsjVfiUsjGO+maTI1mi4SHPFs7HvoCyJiv2twFV6kWCouLI7CqsDY
   R1qrWulswX0qmbmUbgJR4FAxOE08O6uDxBue8wWvmWyfIuGtaNvopPD3E
   BQ5Vh/88zb9g3fEsYdi4PegRCKlTiFGiWDJUSlcVOHs5GAnL8YE7MAcev
   CAikYsWt61SDoXyn/JvOw6x094pcSpVNRGrbgLACNnhwOVzDU2YPd61mC
   ln2voPf2W0feQ7hrQEn0E7w8nRDX9AQ9jk00nAfFjsOa5/lz1cNkDcSrU
   g==;
X-CSE-ConnectionGUID: IwiwC4InSEmNg7Dv2twxMA==
X-CSE-MsgGUID: noxMaoaySkiucyrpesccLQ==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="asc'?scan'208";a="21540872"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 03:30:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 03:30:18 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 03:30:14 -0700
Date: Thu, 18 Apr 2024 11:29:59 +0100
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
Subject: Re: [PATCH v4 3/9] riscv: cpufeature: call match_isa_ext() for
 single-letter extensions
Message-ID: <20240418-twirl-aground-a581d6e45854@wendy>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-3-e0c45bb6b253@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+kb/Lbwm7h/0iKfQ"
Content-Disposition: inline
In-Reply-To: <20240412-zve-detection-v4-3-e0c45bb6b253@sifive.com>

--+kb/Lbwm7h/0iKfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:48:59PM +0800, Andy Chiu wrote:
> Single-letter extensions may also imply multiple subextensions. For
> example, Vector extension implies zve64d, and zve64d implies zve64f.
>=20
> Extension parsing for "riscv,isa-extensions" has the ability to resolve
> the dependency by calling match_isa_ext(). This patch makes deprecated
> parser call the same function for single letter extensions.

Sure, why not..

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--+kb/Lbwm7h/0iKfQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiD2JwAKCRB4tDGHoIJi
0lSLAP9etZ2WCMHmao3TIOEA8ZgOo2OTJ3ipe9slmFEM10nxuwD/Zi2J1xel+G8Q
uSuqYeiY5lSCD4TaQEPHlc1Aa2nRgwQ=
=7adE
-----END PGP SIGNATURE-----

--+kb/Lbwm7h/0iKfQ--

