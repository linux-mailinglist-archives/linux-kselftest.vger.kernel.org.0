Return-Path: <linux-kselftest+bounces-7789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702658A2D57
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6AAB22FD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7554914;
	Fri, 12 Apr 2024 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c4Lh99Ue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A354918;
	Fri, 12 Apr 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921202; cv=none; b=F2wRJRVRsS74oHx7d85BaHr/ImjUhO3hVYB1+0n/rRp/Z9twa9jZetyzNMXxN2xAYcYOphPaj+9rlNPvdQCersLbcqtbR9g0qDvnB9gDD+c8sMnoT/FdDR1EL1STsvOUak7JvFEw5q7HlwkXqcBml7oKreRtbNc80Sfvz02Rvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921202; c=relaxed/simple;
	bh=z+QWmlRkXyiZHeyBdGOBMyt0lCNZkClZvYp8kEJVhsQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyjEpVtZbPdbPpKRW1oPa+lwHAbGPYe7KRkuS7QuRexr6tF9WYZRcbj9skc8U/CruEaZALDy4rVt32eFZ4uQMvBOtL45JEkm9cvieN7xgfs3yIT5XoNSk0RuuQtI3kdYeK6FI6AQk14QmlIgVaJolN091O6p8L8BKUIzZwOvvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c4Lh99Ue; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712921200; x=1744457200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+QWmlRkXyiZHeyBdGOBMyt0lCNZkClZvYp8kEJVhsQ=;
  b=c4Lh99UeYj4OVZPo8ToZKnV67HgdkbhLPdqx1NykFNqIIQTax6+JcWzT
   QCNOXOkr79UwP099CD182TDlD4S4O6up3dmqejjYTuoBAI8FtuzSeFE+g
   frdXqe2UB8RSRGKR9trxXTzpsPGGh+0iCMF9WgDj+DRFrNRJCnr3yX/Ot
   lWUu5LKipiztOrbNZ2scUqPcNdO0JCo6SBzZnecivW5AnO9GE/TvxHOaW
   BEYGgBzLpeL/m6/e9CBhA56U0GtYRh4YABFSRuUrxJqNHElXxx3twNG/1
   MgcXGdCBSreVxjoeC4/jBu52WsO9+3oMl38Dvr8g+L+NjshhtiBUuScSD
   g==;
X-CSE-ConnectionGUID: mMLqTC6MQs2jRulaBFM8hA==
X-CSE-MsgGUID: cKKh0uYiRwyg+O5MVbf/Iw==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="22708176"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 04:26:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:26:37 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 04:26:33 -0700
Date: Fri, 12 Apr 2024 12:25:42 +0100
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
Subject: Re: [PATCH 05/19] riscv: Fix extension subset checking
Message-ID: <20240412-underuse-manliness-56d328666ce9@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-5-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q4bmFTLuVU/tA/Al"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-5-4af9815ec746@rivosinc.com>

--q4bmFTLuVU/tA/Al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:11PM -0700, Charlie Jenkins wrote:
> This loop is supposed to check if ext->subset_ext_ids[j] is valid, rather
> than if ext->subset_ext_ids[i] is valid, before setting the extension
> id ext->subset_ext_ids[j] in isainfo->isa.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index cd156adbeb66..5eb52d270a9a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -617,7 +617,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
> =20
>  			if (ext->subset_ext_size) {
>  				for (int j =3D 0; j < ext->subset_ext_size; j++) {
> -					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
> +					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
>  						set_bit(ext->subset_ext_ids[j], isainfo->isa);
>  				}
>  			}
>=20
> --=20
> 2.44.0
>=20

--q4bmFTLuVU/tA/Al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkaNgAKCRB4tDGHoIJi
0jF+AP0aO4m1oyhnqLkpU2nu54aTKQxfBfGaf5fonL4sFryyhgD/dWIvHo6yBxxP
Nl1Ow+f7aIxbclA0UIvZgnXGzIHIIgQ=
=wY2O
-----END PGP SIGNATURE-----

--q4bmFTLuVU/tA/Al--

