Return-Path: <linux-kselftest+bounces-11861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95345907546
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41110284BBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C205145A02;
	Thu, 13 Jun 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltyFxSs0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012D1DFFC;
	Thu, 13 Jun 2024 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289367; cv=none; b=ZWB8b9tYpN3U27SsD1K0L1DqNII+inhfgXkxV5dOU1JGXnKq9mcJ63ibORM07s4W7WBkiYNMsowbFxEOQL83rVIS1yI4QOVzkjyLS33jcN6Rhx1QLkxo3XZF31C3f9PahI0D7W47tcO0eoy4BPDWD0lfqTLSRRqQpgAAK7E4zDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289367; c=relaxed/simple;
	bh=7wnmI7TeP0WeiVAAxGMFZ1X0/xHdMvNM5Is10JfsQQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3F9J8kGAQs3nPKSTiyXY/uzB8bXhC506NqOHLnML/kr5UeBUtw+NwtxpafUU+XOhr1/iyYq3YnkMRFCxnB8hFQEcNMJ86PsuR11kmmLLDcmBN0qFGdCEzXPq6aFXZQWuDyVRKBZUS4S+iEUdt2BWFLtFAd1mDDliEOS6wRF1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltyFxSs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4141FC32786;
	Thu, 13 Jun 2024 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289367;
	bh=7wnmI7TeP0WeiVAAxGMFZ1X0/xHdMvNM5Is10JfsQQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltyFxSs01wKpY81IY1J3YZdqf+5LLaFA/jSLklfqk4FtGIgkp1xEd95Fg5ULZhSt/
	 VyrfeCXcKW2m/KsS8kUcgsniM3BH5EjUYh8eWdNjBgL9vhV/+98aREYEmXdc33CXvb
	 wUmPmg0w3dZFZw4bERwHHbmafeZx9eonN6Ksj0X0T0zAp6fYa1ikpokzQjtCFg9uLM
	 bpAMm2RJK3UAc4aZRL2HuZsFi/BdBepXZVdC1FH69KNy8Wl5XEKPKDudrdhda5zhy1
	 3H1cCYksPlDDT4RSNpY/25yepKhyyY3hv8ed/Iv610517KkqLA8KFGKhbpnS06hARH
	 Xt2xTho9jQwDA==
Date: Thu, 13 Jun 2024 15:36:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Message-ID: <20240613-luxury-marigold-d1c7099ab944@spud>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
 <20240610-xtheadvector-v2-3-97a48613ad64@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P927rlnZ+YfGx1Bx"
Content-Disposition: inline
In-Reply-To: <20240610-xtheadvector-v2-3-97a48613ad64@rivosinc.com>


--P927rlnZ+YfGx1Bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 03:56:40PM -0700, Charlie Jenkins wrote:
> The D1/D1s SoCs support xtheadvector so it can be included in the
> devicetree. Also include vlenb for the cpu.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/b=
oot/dts/allwinner/sun20i-d1s.dtsi
> index 64c3c2e6cbe0..6367112e614a 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -27,7 +27,8 @@ cpu0: cpu@0 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +					       "zifencei", "zihpm", "xtheadvector";
> +			thead,vlenb =3D <128>;
>  			#cooling-cells =3D <2>;
> =20
>  			cpu0_intc: interrupt-controller {
>=20
> --=20
> 2.44.0
>=20

--P927rlnZ+YfGx1Bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmsD0QAKCRB4tDGHoIJi
0savAP4lXMAN/lrY71frvXJaVaDKC7qZVjR7y/fNATh/HEaRnQEAr04KLzlaDWhh
9w9mRAzQd3WkOuRXmnk+DeCQb9Ll2Qo=
=Q6OS
-----END PGP SIGNATURE-----

--P927rlnZ+YfGx1Bx--

