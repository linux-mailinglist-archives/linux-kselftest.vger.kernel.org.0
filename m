Return-Path: <linux-kselftest+bounces-7784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377728A2BAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15EA1F2305F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089852F92;
	Fri, 12 Apr 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hxydG2DY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE14E1D5;
	Fri, 12 Apr 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915915; cv=none; b=Vz+u+TJlWL5//WvUwhqPSQWrQ1EiYeEat215wKSM1d7KAT7DU2QpK8MktWKU1kyFnLgtenvWKGkNtLnvZD//eC/il5dM5MoK5w65k1IWuXF+EtEiTbawx+SDVSaTcq3NeKJlyHkoxP1LU+uKBcEe3NCnpiMQTpGN3KIGPNbHPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915915; c=relaxed/simple;
	bh=QndV9TT9pmDT+fXwJI9iOQE9VYOlSdccevWqhWNEacg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0s/DE0NS6lmxiRYPPzTc2iyecUaSpgi41V5rT2k+GagHgVY6M4PVggQ2T9PY6/tyommsvZ9Kv759FN7WdDvbGYDhcBjlGrtKL+bFVx48uoiadji4iAkoTk2zyghQM9J/YwIItdhQXBaLKaLNBAt43sdpauMOsngK/ELNtAYM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hxydG2DY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712915914; x=1744451914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QndV9TT9pmDT+fXwJI9iOQE9VYOlSdccevWqhWNEacg=;
  b=hxydG2DY9EC4gf9jhE6POyrRgP9gVbeFSIfbtTDRlNoYlmjNkHKDWyZg
   lGFUk5KqlVY2Sv0yT/qSMD2y2dzKI9B/4M5LJNQSlbWtj8TLy0msjE0eD
   xwvbJLM5WzQJ3Q6n/PLrPO2YviF8UHYbHEX1p34HgTmhwjCR3t2mmBGHD
   Lw9uuYAFksj4VHQZEvdS5t/nVd72Vz7zhCBytqZv9wxQwfoL5ycyJ/jdA
   FM6pz1ejiW2UNcrQJ8eX9RMCctyOP6V0G8fDxpFLpTPf1FNj8Tk7TOQ9+
   uUI/UdWagxerd3YS0v3Z9jImbhVyi4YuOveGpm2o0KxcosWYQV6QqDL3R
   A==;
X-CSE-ConnectionGUID: OGnVlqFaSN2/PpP1KY9laQ==
X-CSE-MsgGUID: +7SHxj1mSZiXXuIvu13hXg==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="20723575"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 02:58:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:58:16 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 02:58:12 -0700
Date: Fri, 12 Apr 2024 10:57:21 +0100
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
Subject: Re: [PATCH 01/19] dt-bindings: riscv: Add vendorid and archid
Message-ID: <20240412-revocable-dosage-99265debe66b@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-1-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YzIxShuT9j2BnF76"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-1-4af9815ec746@rivosinc.com>

--YzIxShuT9j2BnF76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:07PM -0700, Charlie Jenkins wrote:
> vendorid and marchid are required during devicetree parsing to determine
> known hardware capabilities. This parsing happens before the whole
> system has booted, so only the boot hart is online and able to report
> the value of its vendorid and archid.

I'll comment on the kernel patch, but this is not needed.

> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index d87dd50f1a4b..c21d7374636c 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -94,6 +94,17 @@ properties:
>      description:
>        The blocksize in bytes for the Zicboz cache operations.
> =20
> +  riscv,vendorid:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description:
> +      Same value as the mvendorid CSR.
> +
> +  riscv,archid:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description:
> +      Same value as the marchid CSR.
> +
> +
>    # RISC-V has multiple properties for cache op block sizes as the sizes
>    # differ between individual CBO extensions
>    cache-op-block-size: false
>=20
> --=20
> 2.44.0
>=20

--YzIxShuT9j2BnF76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkFgQAKCRB4tDGHoIJi
0taCAP4tYStLi/B4J7M5neONl/q/8R8/ZSNYoUC3mB5o++Qa+gD7BOaDcH4iTfuG
7JqZQnqsXKTRSQOes4E+V+bAkjzkYQU=
=x06j
-----END PGP SIGNATURE-----

--YzIxShuT9j2BnF76--

