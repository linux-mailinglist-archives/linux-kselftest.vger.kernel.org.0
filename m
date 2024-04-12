Return-Path: <linux-kselftest+bounces-7798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA48A2E55
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7601C22841
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA156B8B;
	Fri, 12 Apr 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YAHg2XAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001004597F;
	Fri, 12 Apr 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925071; cv=none; b=A0IcYShq3v6awrMTK5UAL38mw3DrgTDg8Sa4fmWxBWr2CPUehIyEYt8o6NGKOxU6qQiFPpMbhXWFPyr02xSq617R930/+4XjEPYIZpN7aEVxUThbeZ+rK7E32qYXCLbTpW/fn+x1puaetqLRpXlYQLGCtaJyWjyPB8foMM4znqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925071; c=relaxed/simple;
	bh=o8YSWsoCfZ7tptBqUVVtBw1fFnKL06BvA0qNMfnioDw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrKgMjZgU6xYp+kONcTUnwd/shQlVeMwqsTBstoVwlEBRGLrGq4+SgzFwFIupwpegcnzhpHIudEcjTcvF/pYHBU+bk1ZqIJQyRY/DU1f3daxeAqtihNksiiaP55Yic0GZtaV7RDYz872oJ0aKVOLWWf39kMGwFvW3kq5CfrHeXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YAHg2XAj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712925068; x=1744461068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o8YSWsoCfZ7tptBqUVVtBw1fFnKL06BvA0qNMfnioDw=;
  b=YAHg2XAjz7reUSlwhHo3OfF5Idv4gtTNL0u6hg6Ez4/4TdvRQE+0Jm3h
   eXn6PURY+LVOAyym2nk8cV6tG4V8Adyy4MCmL4zkXa7z9bcCsuteA58IN
   Ha84RKCsIEWH+PNTJ7opAhaIvRxwwk5ihL7RUGSDd1ABonlbtKSdziEFZ
   pbBirLOAHzDllFbmpm3kiWWs/7hfmWVWyP+QxFLNQ4exZxai+XIgE4Fg0
   i7GMOjQorX47q/94/Ygabzs/O1WULRC3MQhhRU1TpywpP6J5z1tRRocuK
   xpUsvI+ciSXJH94rX7hYQMd5XQldcMZ4evKM91uEAZmKKXnQqsp7dzxoC
   Q==;
X-CSE-ConnectionGUID: 8n3UuTh2QzaDn5A8rQGjFg==
X-CSE-MsgGUID: nqO9YiBGTYCscAdrhaD7/w==
X-IronPort-AV: E=Sophos;i="6.07,196,1708412400"; 
   d="asc'?scan'208";a="188017039"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 05:31:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 05:31:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 05:30:59 -0700
Date: Fri, 12 Apr 2024 13:30:08 +0100
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
Subject: Re: [PATCH 06/19] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240412-sprawl-product-1e1d02e25bca@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/rKIhypokaxpjzdO"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746@rivosinc.com>

--/rKIhypokaxpjzdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:12PM -0700, Charlie Jenkins wrote:
>  static void __init riscv_parse_isa_string(unsigned long *this_hwcap, str=
uct riscv_isainfo *isainfo,

> -					  unsigned long *isa2hwcap, const char *isa)
> +					struct riscv_isainfo *isavendorinfo, unsigned long vendorid,
> +					unsigned long *isa2hwcap, const char *isa)
>  {
>  	/*
>  	 * For all possible cpus, we have already validated in
> @@ -349,8 +384,30 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>  		const char *ext =3D isa++;
>  		const char *ext_end =3D isa;
>  		bool ext_long =3D false, ext_err =3D false;
> +		struct riscv_isainfo *selected_isainfo =3D isainfo;
> +		const struct riscv_isa_ext_data *selected_riscv_isa_ext =3D riscv_isa_=
ext;
> +		size_t selected_riscv_isa_ext_count =3D riscv_isa_ext_count;
> +		unsigned int id_offset =3D 0;
> =20
>  		switch (*ext) {
> +		case 'x':
> +		case 'X':

One quick remark is that we should not go and support this stuff via
riscv,isa in my opinion, only allowing it for the riscv,isa-extensions
parsing. We don't have a way to define meanings for vendor extensions in
this way. ACPI also uses this codepath and at the moment the kernel's
docs say we're gonna follow isa string parsing rules in a specific version
of the ISA manual. While that manual provides a format for the string and
meanings for standard extensions, there's nothing in there that allows us
to get consistent meanings for specific vendor extensions, so I think we
should avoid intentionally supporting this here.

I'd probably go as far as to actively skip vendor extensions in
riscv_parse_isa_string() to avoid any potential issues.

> +			bool found;
> +
> +			found =3D get_isa_vendor_ext(vendorid,
> +						   &selected_riscv_isa_ext,
> +						   &selected_riscv_isa_ext_count);
> +			selected_isainfo =3D isavendorinfo;
> +			id_offset =3D RISCV_ISA_VENDOR_EXT_BASE;
> +			if (!found) {
> +				pr_warn("No associated vendor extensions with vendor id: %lx\n",
> +					vendorid);

This should not be a warning, anything we don't understand should be
silently ignored to avoid spamming just because the kernel has not grown
support for it yet.

Thanks,
Conor.

> +				for (; *isa && *isa !=3D '_'; ++isa)
> +					;
> +				ext_err =3D true;
> +				break;
> +			}
> +			fallthrough;
>  		case 's':
>  			/*
>  			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
> @@ -366,8 +423,6 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
>  			}
>  			fallthrough;
>  		case 'S':
> -		case 'x':
> -		case 'X':
>  		case 'z':
>  		case 'Z':
>  			/*
> @@ -476,8 +531,10 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>  				set_bit(nr, isainfo->isa);
>  			}
>  		} else {
> -			for (int i =3D 0; i < riscv_isa_ext_count; i++)
> -				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
> +			for (int i =3D 0; i < selected_riscv_isa_ext_count; i++)
> +				match_isa_ext(&selected_riscv_isa_ext[i], ext,
> +					      ext_end, selected_isainfo,
> +					      id_offset);
>  		}
>  	}
>  }

--/rKIhypokaxpjzdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkpUAAKCRB4tDGHoIJi
0suMAP9hVav0oRL2jmBJm2ACwJ1+CNYfBT488OIk7AWbRjBIigEAtUP/mmReLFMY
g7/EcQ6a/96RixRPX9yYcg23rYMJOQE=
=w9t9
-----END PGP SIGNATURE-----

--/rKIhypokaxpjzdO--

