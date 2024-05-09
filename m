Return-Path: <linux-kselftest+bounces-9773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18318C0C22
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 09:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E24D2824E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62233149DEC;
	Thu,  9 May 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sibTL0dW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C513C9C0;
	Thu,  9 May 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240953; cv=none; b=GD2fjvZDuvIzq7pJoemrMGRte+hTs8PNoJnf39nqDGAZOGO3gcdczQBeNrJPggv77PQ+8Kiu2FkvgMQcbEY5lwYiSc1uH+WqiKK3IJ/UZP49EhQGVZmIv3mB2C90mmVa1eB78FgDy2+nUE6GhPcLVXfLnqs4wZBIuldMm3nUATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240953; c=relaxed/simple;
	bh=sDwPafMpIIsl7Mu2sC8mUTOsijZlaGt+V4EsD8yPch4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp1GKOd+InBotM3fe/O0nvBulhag2NM3S+Jou3RvBd0sqm2BooRUv9Jgu24zE4tPMGZlGFmvHEY8tuvbGwegoXulLWc6wCtY5+arcI+mJFzwsfvMg7lW7odFquxE+npCt55E1VnubiIQtvtBIo44lTjKoPQ2Qyj7WEp3XFFngbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sibTL0dW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715240950; x=1746776950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sDwPafMpIIsl7Mu2sC8mUTOsijZlaGt+V4EsD8yPch4=;
  b=sibTL0dWHltkqoG9/79SI/g3961GGl49C0NOZk1xzzGFx5uxjPTDYSqM
   m97+EU60v2YFxWuZ7Qvl8EjJCi6ItYpj6X3bUlV88oHgGxLEtbWyk5RMo
   qR4FnTK/EhHaVkfA7f1YJ5DJGsUstvOzTuJP/Yf3xBNkjYO7YVXpPnvkg
   kIN093h3owUFPCNhDpY5qegz4aPYGmnOUeGXtozQG5JGBY95AscCw5Ems
   SFDhcdVGIQck758msQv3unoMbsRGKoN+gVzOMYM6fjIceqhdGuK6cEhKm
   o7L9J1+t+Dwl5Tr2N3gHpaguzoeN0xUoD/FioUwJ/lW4jQsv8p66kq/f+
   g==;
X-CSE-ConnectionGUID: b4TAGUWbRRaXvl7Tlp/mVw==
X-CSE-MsgGUID: 0hMmNNlFTQa1/hvoYYDwrg==
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="asc'?scan'208";a="191609229"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2024 00:49:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 00:48:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 00:48:19 -0700
Date: Thu, 9 May 2024 08:48:09 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Andy Chiu <andy.chiu@sifive.com>
CC: Conor Dooley <conor@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner <heiko@sntech.de>, Guo Ren
	<guoren@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Evan
 Green <evan@rivosinc.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Shuah Khan <shuah@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Vincent Chen <vincent.chen@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Joel Granados
	<j.granados@samsung.com>, Jerry Shih <jerry.shih@sifive.com>
Subject: Re: [PATCH v4 7/9] riscv: vector: adjust minimum Vector requirement
 to ZVE32X
Message-ID: <20240509-mandatory-monsieur-dfa4d7881fa9@wendy>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-7-e0c45bb6b253@sifive.com>
 <20240418-brook-chili-4d3e61d1a55c@wendy>
 <20240418155256.GA2410@sol.localdomain>
 <20240418-ultimatum-yam-11de4b063b83@spud>
 <20240418173203.GA1081@sol.localdomain>
 <20240418173946.GB1081@sol.localdomain>
 <20240418-sterling-sanding-d59c3b0a2aaa@spud>
 <CABgGipU74TA3KgCH4pPuRefbnYt3q6RKcQwfyspenisEtY6eqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ILfmNxMoEmQr18uK"
Content-Disposition: inline
In-Reply-To: <CABgGipU74TA3KgCH4pPuRefbnYt3q6RKcQwfyspenisEtY6eqw@mail.gmail.com>

--ILfmNxMoEmQr18uK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 02:56:30PM +0800, Andy Chiu wrote:
> Hi Conor,
>=20
> Should we check if "v" presents for vector crypto extensions in
> riscv_isa_extension_check()? We are not checking this for now. So a
> kernel compiled with RISCV_ISA_V still has a problem if its isa-string
> includes any of vector crypto ("zvbb, zvkg, etc") but not "v".


Yeah, one of the things I took away from this discussion is that we need
to improve the implementation of both the methods we have at the moment
for drivers etc to check if extensions are present and usable.
In general, I don't think checks like that are "safe" to do in
riscv_isa_extension_check(), because the dependencies may not all have
been resolved when we probe an extension (Clement's current Zca etc
series improves the situation though by only calling the checks after
we probe all extensions).

The simple V cases are all fine though - the DT binding and ACPI rules
for compatible strings all mandate that single-letter extensions must
come before multi-letter ones. For riscv,isa-extensions we control the
probe ordering and probe V before any multi-letter stuff. Additionally,
we should make it a requirement for V to be present if things that
depend on it are.

That said, is it permitted by the specs to have any of the extensions
you mention without the full V extension, but with one of the cut-down
variants you mention here? If not, I'd be more interested in figuring
out the non-extension dependencies: whether or not the kernel itself
supports vector and if the kernel has opted to disable vector due to
detecting that harts have mismatching vector lengths.

TL;DR: I think we should add some checks in riscv_isa_extension_check().

Thanks,
Conor.


--ILfmNxMoEmQr18uK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjx/qQAKCRB4tDGHoIJi
0nmVAP9L+cHjupn5RAFkHpZYc5Cnnq2E5GdciRokz+M5dfaZiwEA9ymnxi2cQa7X
f5iK/7u9QwmQNblOabpPI5z1wq28rAo=
=dW2A
-----END PGP SIGNATURE-----

--ILfmNxMoEmQr18uK--

