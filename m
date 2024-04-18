Return-Path: <linux-kselftest+bounces-8309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470E8A9735
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EDE1C21EF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E915CD4E;
	Thu, 18 Apr 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y8EGkjW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4715CD51;
	Thu, 18 Apr 2024 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435721; cv=none; b=F3Q/oAZbsIls9ekGw9lAEBGWdZVDKsrHPdEyrcsXW+YD6wHSnvj4zBVxcum2UgQnkVXYyRvscrmBcDeScJNRck/pK+Ig1F6q7lzdXOIg66rookYnWO7i4DfJ2/+7PzjZY2H6WlLUdnqsVipqn21JP9c5ej7N/Td2Blk5rXHBV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435721; c=relaxed/simple;
	bh=9hq0MbHS2MZ4Vl7dzWJ4AWW2yuB2FdAWiTYckqmPylA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwOvXUiSW1b8NFDpIs4pvHEmCYuoMmBi++dL13X7J0zf21jImitLORmNjJpMYLT063v5q7uZcvHg74jrJxST+C2FoC7VGXovAKbeeA1iqtviu3X7ISfM9MLTaPFjr1tLlzSMJIg40VN9tIGoEG8POPiAdayHA1x8SCE40a8q7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y8EGkjW2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713435721; x=1744971721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9hq0MbHS2MZ4Vl7dzWJ4AWW2yuB2FdAWiTYckqmPylA=;
  b=y8EGkjW2KwA8qorYdwbL6mJ7arNejJnt2kJFPNlQ8YXx44K99g0dqFv9
   dwx98dEQwD0P8poSM2ea5Slh7+It4n+6TsYjdgs/lrYLCRbxUqdknAU76
   1NZenFxt9ZTGc6/bdkCye/PPcNzrLVnY4qYyfZZk7ubxX6NfUhRTxreTj
   +cVtdrROocaJYXApAzSRIhVIFyKsjQyvJ+Yrdmezn7OznCrumeQ4jhGte
   f5l6XlQKG9I4FaZM4YDKB/0XkAoBbquUh51Ru1Elj+vCmuBZcwRkczQ8I
   sYD8RJ9h7XCYsPqbEZTYqMuIW5LdYOpdGN6zBG11YTSo7WSODmZmfoAu8
   g==;
X-CSE-ConnectionGUID: 2BlBkMo/RkCgCTcxqrBIpg==
X-CSE-MsgGUID: fof2w0dDS92WJg8ouQypAw==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="asc'?scan'208";a="21586637"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 03:22:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 03:21:37 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 03:21:33 -0700
Date: Thu, 18 Apr 2024 11:21:18 +0100
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
Subject: Re: [PATCH v4 5/9] dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA
 extension description
Message-ID: <20240418-litigate-zippy-d05379b5ace0@wendy>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-5-e0c45bb6b253@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IKul8mjn3Ad3mqHY"
Content-Disposition: inline
In-Reply-To: <20240412-zve-detection-v4-5-e0c45bb6b253@sifive.com>

--IKul8mjn3Ad3mqHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:49:01PM +0800, Andy Chiu wrote:
> Add description for Zve32x Zve32f Zve64x Zve64f Zve64d ISA extensions.
>=20
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

Technically this should be before the patch using them in the kernel,
but=20
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--IKul8mjn3Ad3mqHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiD0HgAKCRB4tDGHoIJi
0n1wAPd1er7jDl4Eexl9WWN83HD+Ca2d7uVxpq71neDpZ5hxAQDgD/U89OOnw5dd
hmkxzNHP/2AVHlS/1DyRsZjUghB3AA==
=ofyD
-----END PGP SIGNATURE-----

--IKul8mjn3Ad3mqHY--

