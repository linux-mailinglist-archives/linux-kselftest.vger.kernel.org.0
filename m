Return-Path: <linux-kselftest+bounces-9132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A88B757F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5601C21DDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFDF13D881;
	Tue, 30 Apr 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iq39YaZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0546168A9;
	Tue, 30 Apr 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479197; cv=none; b=jNsU8dVHEV0Y9bSiAp23yDLg1/eOKMu3y/0XtCaCz9XKH5qmxIiByldHitLR1IUabXWnN4woGgLlqCDWuXNZYBSXMDHTZLeLX7FcMUMIuioO6nuMaQS4ixMmhzDwJPjj6V7HSfjhMbqibSH/+15HLBkMsyRZCuwYbCW/gnOqUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479197; c=relaxed/simple;
	bh=doLKeQy4TExi5QdhktMBd2IZ1vpBh5RzTkVFTj89drA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP3I620ouV54SFdN7/+8Y7R9sH0BV1ASt0+0Fp9S54oXxijdqc5pV9438SR12HLYr3Liy/4onXF4+g8yRGLLkIdC/ciQNPZEtf3RMX7sBSPBZ+0Mjggptmxjg48ayogAs2mpQaDbPaIhAU7Uey7sTlUkJwFWLoQKWYItHP5thro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iq39YaZc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714479194; x=1746015194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=doLKeQy4TExi5QdhktMBd2IZ1vpBh5RzTkVFTj89drA=;
  b=iq39YaZcFwUzIWCSDeHlLmn0X/Ix/zIRb8/fuiAAs9RwOCZj9+wGQuz4
   J2ym+Gwg7KqBEV8+G5zuJJveIUr119qt42UFJ+MiMAoCzsbKkF2UP4Yfm
   RtY1sLuqrGesrtF12EUYnpujltujJdIRIkd5093hGgHVkRv1coXdfyeMQ
   4t8X4ng7DX6MOGecYtQVFD5UyXI2IV5gDUKIit2UAFsPQxenBcAYdUMmG
   gXzWW20CEbVLWmSSD285KL60NmY1tTP5vhe+Ium46pYTcr8y4Ncaz5wqO
   KyUKIKaC0pacn5d61uAELzTHUu7hjSD+ZJixOwSsrSthtIAUVeJBkA5YT
   Q==;
X-CSE-ConnectionGUID: uObasyPdQ16WgqrK/xhteQ==
X-CSE-MsgGUID: onc3MT8LRSmj1H2yRHI51w==
X-IronPort-AV: E=Sophos;i="6.07,242,1708412400"; 
   d="asc'?scan'208";a="190594512"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2024 05:13:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 05:12:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Apr 2024 05:12:50 -0700
Date: Tue, 30 Apr 2024 13:12:32 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel
	<anup@brainfault.org>, Shuah Khan <shuah@kernel.org>, Atish Patra
	<atishp@atishpatra.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <kvm@vger.kernel.org>,
	<kvm-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
Message-ID: <20240430-gratuity-refinish-29abb136c958@wendy>
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240429-subtext-tabby-3a1532f058a5@spud>
 <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>
 <20240430-payable-famished-6711765d5ca4@wendy>
 <dbcf0be9-eae6-4776-bc5b-c6fad58df9c3@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8ucTtHBCJgf8Riu/"
Content-Disposition: inline
In-Reply-To: <dbcf0be9-eae6-4776-bc5b-c6fad58df9c3@rivosinc.com>

--8ucTtHBCJgf8Riu/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 01:58:11PM +0200, Cl=E9ment L=E9ger wrote:
> Yeah, see what you mean. I think we also need to define if we want to
> expose all the ISA extensions in /proc/cpuinfo (ie no matter the config
> of the kernel) or not. If so, additional validate() callback would make
> sense. If we want to keep the full ISA string in /proc/info, then we
> will need another way of doing so.

If extensions aren't usable, they shouldn't be in /proc/cpuinfo either
as there's programs that parse that to figure out what they can use,
possibly even only checking a single cpu and using that as gospel.
That's why there's that per-hart-isa thing that was added by one of your
colleagues last year.

--8ucTtHBCJgf8Riu/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjDgMAAKCRB4tDGHoIJi
0neYAQC5KDKxLwVlxUktx/6ZGxEKZ7t0/TmIWfR2P7wsLDIFPQD/YOo01ylZOQ90
q2ipRVfjcUwY9iXnlr4411pWO+cJBAA=
=u/5V
-----END PGP SIGNATURE-----

--8ucTtHBCJgf8Riu/--

