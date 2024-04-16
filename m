Return-Path: <linux-kselftest+bounces-8179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D518F8A6FC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE3B1F2211C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161A130E2B;
	Tue, 16 Apr 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8bfNMUL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69480125B2;
	Tue, 16 Apr 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281307; cv=none; b=Z+KGLj/BwTbhmReR95Cv/aDjISNr/vlXJax9dl9DbsHOUwDtv1mRoWscc/PHP2Dy4yB4BxY5xzodudO1uRWnS+vilMJtIEwngVxilzOdk7L0D1wAZhnNQGXvq0ktBizPhjMGx4CmwFFjDAs0b9EugRMU+OvYEkNPZF4ZbS2/YA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281307; c=relaxed/simple;
	bh=e7THuib2jYpaypD6WlnQShylaP5wyEwmwYV9EkglRW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/qKj/My7l44jZ4QLPmQCLX64uiaDEcpM67YRu8a/SRVCXbXg3yYqqefjdejGIRDurhJK5/ByciaDsSpm1R2K2U/ndauY4QXyQl2j9k4i2yXLxT3abrbPyVybga+lrPYBWtVQ+h99mElurtLVRwVK9ozMcR6WAkt0Vs0vqJCSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8bfNMUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83258C113CE;
	Tue, 16 Apr 2024 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281307;
	bh=e7THuib2jYpaypD6WlnQShylaP5wyEwmwYV9EkglRW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8bfNMUL+taETD8GpRDIgp7waHn4KT2C0/Kfgtm9sGK/Gqw7B6CcjydgFup6Fj5v2
	 eR0pZDwrzFCddOdkfli8TQaaKFa70tVQDghGZ4vXXNYa4yAAip2/LA2mqsO4AV68lH
	 wQr0DxWi+8/LSo+0D0iJIgWsjf19bJy6CZoj7q3txJCiUM3pABkx+2DhJaGTINzzns
	 +zuAC8sgnx00CD2p1HwDD1f/Unxyk9WgkMGDt2J1ay45kyw+CAQO+FOIQTuB0EdwhF
	 wB4FFtR0UFva4a5nZGa2NsSpQPBJBRwjgCYlT4GLG3LO36C1lvwaYZBiHOFq1qC01M
	 w+cDoQYVy7gLw==
Date: Tue, 16 Apr 2024 16:28:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/17] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Message-ID: <20240416-scorer-easeful-4dae3c18465d@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-4-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6+SPECBpGFwY+8mB"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-4-c7d68c603268@rivosinc.com>


--6+SPECBpGFwY+8mB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:12:01PM -0700, Charlie Jenkins wrote:
> The D1/D1s SoCs support xtheadvector which should be included in the
> devicetree. Also include vendorid for the cpu.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/b=
oot/dts/allwinner/sun20i-d1s.dtsi
> index 64c3c2e6cbe0..4788bb50afa2 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -27,7 +27,8 @@ cpu0: cpu@0 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +					       "zifencei", "zihpm", "xtheadvector";


> +			riscv,vendorid =3D <0x00000000 0x0000005b7>;

Isn't this effectively useless given there's only one CPU here?
We also already know the vendor of the hart, because the compatible says
it is a "thead,c906" so this doesn't provide any new information.

>  			#cooling-cells =3D <2>;
> =20
>  			cpu0_intc: interrupt-controller {
>=20
> --=20
> 2.44.0
>=20

--6+SPECBpGFwY+8mB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6ZEwAKCRB4tDGHoIJi
0v4RAQDrqlZrOVNmVT2qJWHlaUy5oV83I9CLCGUxlH9aAGur6QEAoFXtsX7XrWNf
i2shqmRRdXJ1R1aeL6/dha7DMntUqAg=
=6P7j
-----END PGP SIGNATURE-----

--6+SPECBpGFwY+8mB--

