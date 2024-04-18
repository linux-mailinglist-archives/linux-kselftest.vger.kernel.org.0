Return-Path: <linux-kselftest+bounces-8306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C58A96CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351911F235DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2115B542;
	Thu, 18 Apr 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n6YUKBVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B015AAAD;
	Thu, 18 Apr 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434114; cv=none; b=jdbIG+gEqDwBV1Nl1TkLb6K8KIav2KKwh6IORb6poLhE9DdLyJbY5Iji2MgivFGCq/lRX34tiL+WkY8WGILT1u7qjG7Lt/bMSjXgInr67GyyPl8nkUyN39BzANI/jdLUdTytyYwxOCjoCqtjpL/2KDKCgBPqjKM1YovQIT9H/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434114; c=relaxed/simple;
	bh=duaR1AnrObmqETtxDghvr7defhHd1q2pgv4fpE/MLDo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VruC80sYECNONcb+ArLC/6ky0kIQuW9mqHH907ndPYf9CH3v/QdaSCmus/NzJYWmnyk9dBDxLsUtVmapfob9ROnGDCCU8mwdi7NwRXqIwpZT46mEPF/SWsucs082dnEQuAi/Y1AhyHV2Y3i1v1zp+bWOgNzDs0aZjrwbK5iJeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n6YUKBVw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713434112; x=1744970112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=duaR1AnrObmqETtxDghvr7defhHd1q2pgv4fpE/MLDo=;
  b=n6YUKBVwvB2ol+qn2y164nnedPopKC3VvGAAVR6OBjd6GAr19/BmMgF6
   lFdadHIlPA4BP13v7XA1IMZPbvaMdfgrcfuYXEl1mKOZ2sVA7s5rNRAvn
   rCLlpYkwUZKLX8C00NT1dNpH/cos6I6zD6r2Dz7R7WDQ2fKv+NwA1J3Z6
   lBDh2a+UBuNPZbwGcomAKsr1XIVSvpgx6Z4B7ehxuoAEokg8aVTI05/Fk
   6osCeQb3ne7x6vhQBxQfsbygRCVTST+rnZX68N8ZApuqkd+ySTf/HN1Oc
   VS3NfjkL2RZPt/5j7CWX/mmEjLhicRMOtPrkDfX3XQiUqhj9DheiT5i0i
   Q==;
X-CSE-ConnectionGUID: ECU7hUHwT6yX4X4vObkvLg==
X-CSE-MsgGUID: G7MHUU6ZS1qzj52fb6t0/g==
X-IronPort-AV: E=Sophos;i="6.07,211,1708412400"; 
   d="asc'?scan'208";a="188872991"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2024 02:55:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 02:54:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 02:54:27 -0700
Date: Thu, 18 Apr 2024 10:54:12 +0100
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
Subject: Re: [PATCH v4 1/9] riscv: vector: add a comment when calling
 riscv_setup_vsize()
Message-ID: <20240418-harsh-childlike-94403aa132b3@wendy>
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-1-e0c45bb6b253@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="stxnFH69aESRe/Ix"
Content-Disposition: inline
In-Reply-To: <20240412-zve-detection-v4-1-e0c45bb6b253@sifive.com>

--stxnFH69aESRe/Ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:48:57PM +0800, Andy Chiu wrote:
> The function would fail when it detects the calling hart's vlen doesn't
> match the first one's. The boot hart is the first hart calling this
> function during riscv_fill_hwcap, so it is impossible to fail here. Add
> a comment about this behavior.
>=20
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
> Changelog v2:
>  - update the comment (Conor)
> ---
>  arch/riscv/kernel/cpufeature.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..d22b12072579 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -683,6 +683,10 @@ void __init riscv_fill_hwcap(void)
>  	}
> =20
>  	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> +		/*
> +		 * This callsite can't fail here. It cannot fail when called on
> +		 * the boot hart.

I am loathe to comment on this again, so=20
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
but you could just write this as "This cannot fail when called on the
boot hart."

Cheers,
Conor.

> +		 */
>  		riscv_v_setup_vsize();
>  		/*
>  		 * ISA string in device tree might have 'v' flag, but
>=20
> --=20
> 2.44.0.rc2
>=20

--stxnFH69aESRe/Ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiDtuAAKCRB4tDGHoIJi
0vBwAP98Il+vXK4C3r4MkJnr98Iu2kDKN2juNFv17/2CzU01XAD8DKAV9cWacroD
OxgMcDQ3nbE0Mhf3iWlSh55SQQYoqQ4=
=At92
-----END PGP SIGNATURE-----

--stxnFH69aESRe/Ix--

