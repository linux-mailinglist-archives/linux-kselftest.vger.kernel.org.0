Return-Path: <linux-kselftest+bounces-8307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CC8A971B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26303B20E9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7B15B57F;
	Thu, 18 Apr 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xJ36ND9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0B15AD8E;
	Thu, 18 Apr 2024 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435474; cv=none; b=GK1FSvVM3tZab71NPGY9+fEo5PsJFoZBvZDSIgG6d34MAXfOCmEAWZi4Ib+WPlxCNlB8Vwm5VWnk1wFTdKeKTSJ/OYKsD7vt8RhX48pbuetVfbMa73z9Ejy/T6DWftZZ9EZsIwmOkU5EVWpqDjWIMmS9HHGZ1IU0s0vXd/iB0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435474; c=relaxed/simple;
	bh=HvDKZ+glA5qTkrIzDXNuxfHtmsXhvI7/488cGHa/cTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOHN0Eu9T/Od7GKxcRME1TR56Hv5Ak/OPhR09KPFdk4DRoY1xTm8p7lnTssoUGxDXNhEvqSG9zEFNxt50acuBIDvkBXgDNi+6oOt8KtGm3PmNy7sCWDbss7QGbqPoMUtcqFjDnIZvavrcmMDfpX3vD6zBP9/84fFTzynlJFT62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xJ36ND9Z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713435473; x=1744971473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvDKZ+glA5qTkrIzDXNuxfHtmsXhvI7/488cGHa/cTo=;
  b=xJ36ND9ZJ8+n6zlPNqFNrDvbSeDvaHDwezthBCG7t/XEYGyHxWPq8Ou5
   +1jius5hEebikL5wiQcd3ps9yBXoq58UbKg04drgTiSO6mmb8J4iGXc32
   PAw1lDCOWkxyuINsn6XpAlROu6Z+NFluOIQTTk1cxzkP/r4NI5L2e+vB4
   HmnraUcwUlZldMeitotV6rP5iFCZSgAhPxALjPRbBgf5bzKRPCY/t03FW
   dHeqdqB9NiVl1bVKCivVMMwok6WTFCYV6h75VYcykEBfsr+bwfrz5XHEV
   9fyC79LWHxCpKbfmU2QlgWYrdccQaP+E2GnZMumNSaiWbo37hZzxVPMgp
   g==;
X-CSE-ConnectionGUID: jdfy0oE/RiGdWMurzhUwYg==
X-CSE-MsgGUID: rBqpnbjgSpK9ZoW0LzlZyg==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="asc'?scan'208";a="252389070"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 03:17:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 03:17:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 03:17:31 -0700
Date: Thu, 18 Apr 2024 11:17:16 +0100
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
Subject: Re: [PATCH v4 2/9] riscv: smp: fail booting up smp if inconsistent
 vlen is detected
Message-ID: <20240418-busload-footnote-0087b489b3cf@wendy>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-2-e0c45bb6b253@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mIw8CeNjpzZr3Y+"
Content-Disposition: inline
In-Reply-To: <20240412-zve-detection-v4-2-e0c45bb6b253@sifive.com>

--5mIw8CeNjpzZr3Y+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:48:58PM +0800, Andy Chiu wrote:
> Currently we only support Vector for SMP platforms, that is, all SMP
> cores have the same vlenb. If we happen to detect a mismatching vlen, it
> is better to just fail bootting it up to prevent further race/scheduling
> issues.
>=20
> Also, move .Lsecondary_park forward and chage `tail smp_callin` into a
> regular call in the early assembly. So a core would be parked right
> after a return from smp_callin. Note that a successful smp_callin
> does not return.
>=20
> Fixes: 7017858eb2d7 ("riscv: Introduce riscv_v_vsize to record size of Ve=
ctor context")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240228-vicinity-cornstalk-4=
b8eb5fe5730@spud/
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--5mIw8CeNjpzZr3Y+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiDzLAAKCRB4tDGHoIJi
0iukAP9gMz9Evm9RpNziRdVt/TZimCbIoydkw28vTA+Bcs/I9wD+N6M2XUvE06s/
90wzbAtNs6iXwmA4DplsxcRv65SMOwo=
=BKna
-----END PGP SIGNATURE-----

--5mIw8CeNjpzZr3Y+--

