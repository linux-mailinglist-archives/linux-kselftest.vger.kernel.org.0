Return-Path: <linux-kselftest+bounces-7787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27B48A2C50
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6EA1C21651
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4BF53E0C;
	Fri, 12 Apr 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tM/Hv55u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18DF53373;
	Fri, 12 Apr 2024 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917705; cv=none; b=T6fj8NHTqeBOrTIykF7jF0EUUB5VEiBwLFVyX8/zCYuZsLKnFwzV0l30xe5tigayol4k3qJQ7JVfxnRM5RbU2ZRkGFHG+UrblqtlFlilnbQ5jgi+1uIsJ5Q82BDYRwpZQYwho+ZvwgwE5Bs7LSf+/kjv71vZlysPBzw2GXecnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917705; c=relaxed/simple;
	bh=kTLKhtwsa3h1qGVsoBTw6KqmQbL6Q+SdjxubJOC058A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj7r7/4zMeH4nPFNYXa2MxDpUTEugGmcb84MtXNvhyUehbgUGTxyxJXjsrfjcIbxKec+/eMCDFKMc8TYD9fHq4cQOwTcL5yC6GcJpMRQRtHZt0O+UuUKRJaBYxuzDvK6mfj1Hwo6bO43nizowfSj5NuHtyBGfSqYOreoi7x565Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tM/Hv55u; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712917703; x=1744453703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTLKhtwsa3h1qGVsoBTw6KqmQbL6Q+SdjxubJOC058A=;
  b=tM/Hv55ujaC1/xrzF+d6S8jappRm99BcYH6YQJwFhjjCTqAFR9GyHpSh
   8LBR9yTD6IErQhBE306TDeMc25Ov4gQywgqnDy7GcVW9xy7uoQUqVGSjz
   oC2eaE6fHoMAGj3LuTj7h59TMTwWX8V111DLjOmHIFFlzw84L8PG3RVQn
   7WwzdJ5Ltlkf8mFlSkiAcwCZz+I7GkLaYK7klREp8oGI/0S43tvOFoLUa
   SVd8gEm6XykWYPF9bMxrsZiwrsZIWQAjC6cxQ2dSsD7mo27ykBQfZHj70
   45/5vw+wMFrzmxkkcs74R//ZJ0XW8I4NJRiWg6/bJWIo2lDC4toOCTEIQ
   g==;
X-CSE-ConnectionGUID: pekK4ghjTo2w0Gm+KgOwIA==
X-CSE-MsgGUID: 7y8rWc9PRki4RcpHGC2VyA==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="20673244"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 03:28:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 03:28:18 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 03:28:14 -0700
Date: Fri, 12 Apr 2024 11:27:23 +0100
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
Subject: Re: [PATCH 03/19] dt-bindings: riscv: Add xtheadvector ISA extension
 description
Message-ID: <20240412-ream-dwarf-8cdc3d0f279c@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-3-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qHjL7kIT1sLLfOfO"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-3-4af9815ec746@rivosinc.com>

--qHjL7kIT1sLLfOfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:09PM -0700, Charlie Jenkins wrote:
> The xtheadvector ISA extension is described on the T-Head extension spec
> Github page [1].
>=20
> [1] https://github.com/T-head-Semi/thead-extension-spec/blob/master/xthea=
dvector.adoc

Link: <foo> [1]

>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 468c646247aa..3fd9dcf70662 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -477,6 +477,10 @@ properties:
>              latency, as ratified in commit 56ed795 ("Update
>              riscv-crypto-spec-vector.adoc") of riscv-crypto.
> =20
> +        # vendor extensions, each extension sorted alphanumerically unde=
r the
> +        # vendor they belong to. Vendors are sorted alphanumerically as =
well.
> +
> +        # Andes
>          - const: xandespmu
>            description:
>              The Andes Technology performance monitor extension for count=
er overflow
> @@ -484,5 +488,10 @@ properties:
>              Registers in the AX45MP datasheet.
>              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
> =20
> +        # T-HEAD
> +        - const: xtheadvector
> +          description:
> +            The T-HEAD specific 0.7.1 vector implementation.

This needs the link and a SHA or some other reference to the version
of the document.

Thanks,
Conor.

> +
>  additionalProperties: true
>  ...
>=20
> --=20
> 2.44.0
>=20

--qHjL7kIT1sLLfOfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkMiwAKCRB4tDGHoIJi
0jwIAQDE34qo4fc159LqDVXLnUh1xD3mFK2kVSZZanvcn5G3rAEA7T4mAnRBt/8y
DaAR+UAhIFMAcbXd35hewh6U4mwHMwk=
=Co3F
-----END PGP SIGNATURE-----

--qHjL7kIT1sLLfOfO--

