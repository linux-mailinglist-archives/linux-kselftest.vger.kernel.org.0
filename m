Return-Path: <linux-kselftest+bounces-9774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A278C0C64
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 10:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA032B209DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D014A0AA;
	Thu,  9 May 2024 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AZUB6qGS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5514A097;
	Thu,  9 May 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242659; cv=none; b=e9cLLxRzLiE1AwENWxIJo7INezKePmCadNHzRuW9BR/FsKKpM9WiDfgDgLSZbwfbOK+bgJjww0OVZrOYiegdZGRooXCETBDg5kXRgYEDfeMlg8C81XvQjtLUHqPRA2wI9F87Ec3OopWcZiPd96n0I6gkECS7UpqPL7moA2RxqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242659; c=relaxed/simple;
	bh=lMaYXea0/pL6iEr0T3fEYaeD0BO/p+aXtvy3hTqRvxI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbh7LLR62n4O7ae+2OSSAxD0UTCi1RoH4fdagB9p2W0WZHHzUkhFyFH/7bpGB2yYBcY7V9dG3Qw1tYrnPN0TXyzupN7brwOvIQnBbywbLugsroAwNPIH+4FlgkmmH9LZ3OcpZSZAxmRg9ItWOZExgohxfSPo4PfphHZpZR39RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AZUB6qGS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715242656; x=1746778656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lMaYXea0/pL6iEr0T3fEYaeD0BO/p+aXtvy3hTqRvxI=;
  b=AZUB6qGSZYcgcW/c8X1Bb+pHRm2EZk+XUjUcPSje9xqkhq0AUDCDRRQB
   5NrO6KtDRBFcLFqRmDQY+lbzZtQP+VPulxmFsTycoIoJevMxORq0TSKIu
   Ae6GjwwurjyXFXM0cEDSK0om0GDY1bHO8XbgVmeeJMItj8VP8/OUPxjTx
   MAdxX0okqu9Bfg2fduW6cDj9hhUzQXL+ikEXE/9VQBjc1rIlpj8a3GDUr
   FjngvC44BTfDPDyH4CK/72CBf7dFPBmUfpbR2GnNpuRwCMyiwP6qC4pMm
   pFKyZwt8yozeor6mOehDCAXJXpOhaSB1/BX8EkMMS13fHRMDWaVlZMfJs
   g==;
X-CSE-ConnectionGUID: 0mKwrjsVTF+mfP6kb6VBzw==
X-CSE-MsgGUID: w51U2VCEQquHoJanXOK8gQ==
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="asc'?scan'208";a="26482894"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2024 01:17:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 01:17:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 01:17:20 -0700
Date: Thu, 9 May 2024 09:17:09 +0100
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
Subject: Re: [PATCH v6 03/17] riscv: vector: Use vlenb from DT
Message-ID: <20240509-quickly-nibble-01cdb4e541ee@wendy>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftL9clxrsKa3hb4u"
Content-Disposition: inline
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>

--ftL9clxrsKa3hb4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Charlie,

Just me being a pain again...

On Fri, May 03, 2024 at 11:18:18AM -0700, Charlie Jenkins wrote:
> @@ -671,6 +713,11 @@ void __init riscv_fill_hwcap(void)
>  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
>  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
>  		}
> +
> +		if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogeneous_vlenb() < 0) {
> +			pr_warn("Unsupported heterogeneous vlen detected, vector extension disabled.\n");
> +			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
> +		}
>  	}

After replying to Andy this morning about doing some dependency checking
for vector-reliant extensions I realised that we're actually doing this
check too late to be useful for that case.
Say for Zvkb we want to check if vector has been enabled before marking
the extension available, and without Clement's series that re-works the
riscv_isa_extension_check(), we need to ensure that vector support isn't
gonna get turned after we've already marked Zvkb as usable. If we could
move the riscv_has_homogeneous_vlenb() call before probing extensions we
could then examine the result in riscv_isa_extension_check() for V and
make sure it doesn't get enabled in the first place, rather than
clearing it after the fact.

There's a whole load of moving pieces between different series here at
the moment though, I wish some of it would land so that I could send
some cleanup patches for what I think is inconsistency on top :) I
wouldn't mind if this landed as-is, it's still an improvement and the
user I mention above doesn't actually exist yet.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ftL9clxrsKa3hb4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjyGhQAKCRB4tDGHoIJi
0u56AP95eBVgYwPh58UnZa0lZuyLzeDG6PlD0hXLsOA0eWnxUwEAqvt6X42WuHh8
3JcdzsXkKeCVaTmE3NYKMOyV9FDU3Q4=
=JxGW
-----END PGP SIGNATURE-----

--ftL9clxrsKa3hb4u--

