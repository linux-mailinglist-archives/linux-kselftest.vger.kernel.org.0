Return-Path: <linux-kselftest+bounces-9775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9BE8C0C71
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 10:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3E31C217F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4CC149DEF;
	Thu,  9 May 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bm0NJ0Ek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E813BC3E;
	Thu,  9 May 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242728; cv=none; b=g/qsb1zgzVcvFE4l/AMbXvhCmgbH82TrYdkKXJgvrdI4MS9WhN9nSh3YIGP8wMhWkds4HIdUF9o5TB6lxspdVGb3ayfjD9RlvNncaBQWIJTAsXDFC5zUujGOdNOkHKE9eqwEWDesrvLN6GL+zBWUmUH73btsPcHd+kukTYMC2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242728; c=relaxed/simple;
	bh=eYgKI50AT2puid8niw056MNT1xXDuMOWDzaLJ3XEMcg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6+VnwyncJkTCguBSccRuy5uNmw0RDMMKkjIYmvI9ANCG4fp6cogtn3BFyc/33IeXKIo/EIqGtqOTud1dcmJ3vPQXhfbmRF7RmC+O6w3AeFgxK86+UD/heKLoOU9WPbGySVuXpukbotEDKHiRnNBBUULbsZIgSC6C8bGFvk18a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bm0NJ0Ek; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715242724; x=1746778724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eYgKI50AT2puid8niw056MNT1xXDuMOWDzaLJ3XEMcg=;
  b=bm0NJ0Ek2mT/D0mnGdkQxIb+iN3c91TXw9cERf6CH0D085Tx3z77ebVB
   T8i460240NQJlIEwxIJQJeb72kDLgIUqY7i+dX5wWI6raSHp1ICDyQcK+
   VdaVYCfvuDQr+hKUnsJjApsWn0UgHydVWR+cSjsbJUmRlIhyiZU5Tnb3m
   6vcEOJGbVGjZ8szHhXKhWDYhlMBcOjXdUCTzAlHZLpggUwXomLolwJ/F2
   NC6WpagfxcgfuQ+xn6U/RukqtWsU77PfFzvgvXSgFsx3UfCe5Q0+un308
   OwKtPDQEQrfQ+DuUNAgl/h5xYjoK6Uvw610df/nMSI7EEHKguTNFTdfN/
   Q==;
X-CSE-ConnectionGUID: G4GzFAIbQe+QUvzKLznIEQ==
X-CSE-MsgGUID: LrAwBxhoTOuEmzUltNBDxA==
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="asc'?scan'208";a="24290819"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2024 01:18:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 01:18:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 01:18:27 -0700
Date: Thu, 9 May 2024 09:18:16 +0100
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
Subject: Re: [PATCH v6 05/17] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240509-creation-sanctuary-3fce99784eb0@wendy>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-5-cb7624e65d82@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8KQsPCKEipxU/bn"
Content-Disposition: inline
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-5-cb7624e65d82@rivosinc.com>

--a8KQsPCKEipxU/bn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 11:18:20AM -0700, Charlie Jenkins wrote:
> Separate vendor extensions out into one struct per vendor
> instead of adding vendor extensions onto riscv_isa_ext.
>=20
> Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> code.
>=20
> The xtheadvector vendor extension is added using these changes.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

I thought that I had reviewed this the other day,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--a8KQsPCKEipxU/bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjyGyAAKCRB4tDGHoIJi
0mhxAP9qdCcZ8ossQnBRj6IxsLBS9ND1SyiR7l8fPbeYE+uedAD/QXKDPBmr4WYf
L33Wau015J9JR8PRw7FtXts7dwrKOg8=
=xTfT
-----END PGP SIGNATURE-----

--a8KQsPCKEipxU/bn--

