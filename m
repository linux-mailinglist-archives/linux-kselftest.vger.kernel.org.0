Return-Path: <linux-kselftest+bounces-7791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DF8A2D7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58258282B80
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64A54BEA;
	Fri, 12 Apr 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hToX5BP4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C953FE4B;
	Fri, 12 Apr 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921523; cv=none; b=W4KOcLeeOIRrW+/Feo2nqygGyrBNNTjPaHtp2fCn9eE7bWXK6EYYnNh+GdoIaIHL54f7j6jrSKQhOjQPzciLzFAI6IP7W6hKlh2wy+r67tfYKUgGI7Upyv5kA+/8GXtyLSliNedR+JjQzxkvNI3U/oghxLnDZc5IthIq64rg2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921523; c=relaxed/simple;
	bh=BzJrqDFA6AyqBMFADduzWLtGiHXrJzqR3kUA+iQC510=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lktQJQZjktcn2/1tTMZyEfFo7wMHqLyNI7JtK76TnFDXueP2Z/A71BdTe2sTHRaoH28eoNwj9meGEG4X8tamMTkqs8VFmvOVsWlpel8NtV2guOE9cHk6HChut3VCjtwDuyfPHxmXOwFKJmvi70ATnHy4K+4w3z3YLuefwZaSvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hToX5BP4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712921521; x=1744457521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BzJrqDFA6AyqBMFADduzWLtGiHXrJzqR3kUA+iQC510=;
  b=hToX5BP4SXoVMNvZRVi/Ay/pxg591xwePZJ7/MAzhm2s4jqZ920kP/f+
   3Iu28KTiGaFX94vqs1C1gMK/DvHdOAVDOKRLI/hR/8LBUOYHuT2MN4JpY
   0+9nC81MiU8+FidMEi2F2VzZCey2++hjmbEebHTaMRemtUGY36D27g7Sn
   FZ/YlM6bzPm3PMNaDowVXJA/XGdwhztRhrrNKY8M/G2BMUxj1chh0zGEd
   6cOS7LkolPn4uQ3KvdD0z3tH8plkHNSD+5auPAgs4FgwoT53xNUmqz5yf
   fLC5MVSh1AaHkme6IDXAxiB5EPHMBq5bOH44w/90qW7mwX9GJM/A8iGl5
   w==;
X-CSE-ConnectionGUID: VphaOc2hTpGpkTSDHvpbiw==
X-CSE-MsgGUID: V1pgwBcRSfihNzKAqHlD4Q==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="20733274"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 04:32:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:31:27 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 04:31:23 -0700
Date: Fri, 12 Apr 2024 12:30:32 +0100
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
Subject: Re: [PATCH 12/19] riscv: Create xtheadvector file
Message-ID: <20240412-thirty-sacrament-db052c7fe6fe@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-12-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zwcSHVZLwjxefjz8"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-12-4af9815ec746@rivosinc.com>

--zwcSHVZLwjxefjz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:18PM -0700, Charlie Jenkins wrote:
> These definitions didn't fit anywhere nicely, so create a new file to
> house various xtheadvector instruction encodings.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/xtheadvector.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/xtheadvector.h b/arch/riscv/include/a=
sm/xtheadvector.h
> new file mode 100644
> index 000000000000..348263ea164c
> --- /dev/null
> +++ b/arch/riscv/include/asm/xtheadvector.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/*
> + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an old=
er
> + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
> + * vsetvli	t4, x0, e8, m8, d1
> + */
> +#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
> +#define THEAD_VSETVLI_X0X0E8M8D1	".long	0x00307057\n\t"
> +
> +/*
> + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
> + * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
> + * the call resulting in a different encoding and then using a value for
> + * the "mop" field that is not part of vector-0.7.1
> + * So encode specific variants for vstate_save and _restore.

This wording seems oddly familiar to me, did Heiko not write this?

> + */
> +#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
> +#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
> +#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
> +#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
> +#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
> +#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
> +#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
> +#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
>=20
> --=20
> 2.44.0
>=20

--zwcSHVZLwjxefjz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkbWAAKCRB4tDGHoIJi
0nL6AQCJkh59MUri2maEyaJ1kO+VFKtPc14IkIZHwM9bajqXywD+Jf+vDHMGA2cu
5IE2w9WyYjd8dq+NtRxdy9fp8qwtqQE=
=mofk
-----END PGP SIGNATURE-----

--zwcSHVZLwjxefjz8--

