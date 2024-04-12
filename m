Return-Path: <linux-kselftest+bounces-7794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48A8A2DB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995DEB21954
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498C54FA0;
	Fri, 12 Apr 2024 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jNdm1F9P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67A535BF;
	Fri, 12 Apr 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922016; cv=none; b=j22lBi7CysNzd/7wV5pCgjh+FEWywISPdUcYdU/saj25Bk3sOOilUgbbP47qv8WvQXceMxj11vp88ajFtcg1lB5vIh3vJO8dCC99WiBNFv5Ox6MWlhpdAUtJZOb6Fm8OGo+8hip8bCTxqV+7ErI8FZi3nS6k2gyLJ1L9WrGgwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922016; c=relaxed/simple;
	bh=vWrwURI6uGqGzEOsz/9U6rKnDuH3RZniZsq0pIueHuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfPWm3uKPlL1JCkBhkOvlz3nlSJ9yJMtbehirQV5WJWf0HFJtFe5NiY7JGG4mVBidLiEab2fRSTe33RMUKQOtL++wNDKmXcJmU3yBfPFMeltAsV1VE28Hm7EvFSaOTkLB5bmoYX8eU96drLnlKZzZLMOMptucETmgkT057FROk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jNdm1F9P; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712922014; x=1744458014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vWrwURI6uGqGzEOsz/9U6rKnDuH3RZniZsq0pIueHuI=;
  b=jNdm1F9PnMm/YluZBMYuP8Lt+bCLyf5Yat8+q4XDohQr97BVOHQVDIT2
   sLIRjvmickPnqs2YiQqu2enxT+P9Estc/HaHnqgyYy9/oNC7Si4AmM5/8
   CU41yOLwVVP4U3YSzzFZELB6hS5Uw6VyUvMgxExtxas60MozbOai4xHbK
   ZG13Mpzw4oA3JKnUJXw7v99egIbfiWN6rt2Or1x66Dz8umjt+ehGujBHm
   eF40kQe4y6XVMB3ACRYgCsvv41xA5oxIJmz6p0Hhph+CVKzVcIAixA+c9
   WDPJb+JEYw6mk71FwICNnEO9Xcdm5I908GJQw4dnbcabenAVp7knP6+9U
   w==;
X-CSE-ConnectionGUID: i+DXDR/OTgiZjECvCk7SnA==
X-CSE-MsgGUID: LNJas4KrQx+JcZi4m5YrkA==
X-IronPort-AV: E=Sophos;i="6.07,196,1708412400"; 
   d="asc'?scan'208";a="21275385"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 04:40:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:40:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 04:40:06 -0700
Date: Fri, 12 Apr 2024 12:39:15 +0100
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
Subject: Re: [PATCH 16/19] riscv: hwprobe: Add vendor extension probing
Message-ID: <20240412-candle-duffel-a612bab6e2a7@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mRHPCw/Vg3OkuwNh"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>

--mRHPCw/Vg3OkuwNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2024 at 09:11:22PM -0700, Charlie Jenkins wrote:

> +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
> +				    const struct cpumask *cpus)
> +{
> +	int cpu;
> +	u64 missing = 0;
> +
> +	pair->value = 0;
> +
> +	struct riscv_hwprobe mvendorid = {
> +		.key = RISCV_HWPROBE_KEY_MVENDORID,
> +		.value = 0
> +	};
> +
> +	hwprobe_arch_id(&mvendorid, cpus);
> +
> +	/* Set value to zero if CPUs in the set do not have the same vendor. */
> +	if (mvendorid.value == -1ULL)
> +		return;
> +
> +	/*
> +	 * Loop through and record vendor extensions that 1) anyone has, and
> +	 * 2) anyone doesn't have.
> +	 */
> +	for_each_cpu(cpu, cpus) {
> +		struct riscv_isainfo *isavendorinfo = &hart_isa_vendor[cpu];
> +
> +#define VENDOR_EXT_KEY(ext)								\
> +	do {										\
> +		if (__riscv_isa_vendor_extension_available(isavendorinfo->isa,		\
> +							 RISCV_ISA_VENDOR_EXT_##ext))	\
> +			pair->value |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
> +		else									\
> +			missing |= RISCV_HWPROBE_VENDOR_EXT_##ext;			\
> +	} while (false)
> +
> +	/*
> +	 * Only use VENDOR_EXT_KEY() for extensions which can be exposed to userspace,
> +	 * regardless of the kernel's configuration, as no other checks, besides
> +	 * presence in the hart_vendor_isa bitmap, are made.
> +	 */
> +	VENDOR_EXT_KEY(XTHEADVECTOR);

Reading the comment here, I don't think you can do this. All vector
support in userspace is continent on kernel configuration options.

> +
> +#undef VENDOR_EXT_KEY
> +	}
> +
> +	/* Now turn off reporting features if any CPU is missing it. */
> +	pair->value &= ~missing;
> +}

--mRHPCw/Vg3OkuwNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkdYwAKCRB4tDGHoIJi
0oeDAP4tnQJ0meOXf8oUmHOUiJb0NFMEHSi8MWLLKw5qh80wlwD/R11jlcsqR/Uh
O70O3h3uu21ywXzH0Akw/ETQIVC34As=
=Jjh4
-----END PGP SIGNATURE-----

--mRHPCw/Vg3OkuwNh--

