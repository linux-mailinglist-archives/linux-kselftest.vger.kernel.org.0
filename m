Return-Path: <linux-kselftest+bounces-12652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B0916B03
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B9F1F28E8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A412D16EBE1;
	Tue, 25 Jun 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4PxwaZp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F616D33B;
	Tue, 25 Jun 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327065; cv=none; b=bshVKgYm+gcpbBDjMHOpzgxN4r4yDGUaRL6GJ4sT6tCIn6Zy5AuxKFWGpmCfvZeGzNFYM7O/khx5WR5iJZYQvME8v97GFKK2Y66X1bc1F+1KtdDyvm8MiU5SMRjU56LG6Q3lMyGLrRJGVigwJ6TvVRZSj3mvoJhpRlhWtDuKACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327065; c=relaxed/simple;
	bh=h7/s1erSrTInKP/WfJXKAlirzQaaLfNgEqTkzmlNeWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmDV18FeomUYhiNpg9fqyM+OIVAi/7kIX7Dz+/X8TgxYypDPiIfn/pjnW3wwRiJDcx/1+ACMmajnThkeW2mdqIxWPuA2qx/EEYdCHQYc8bfIdJFDTR8o1djwPD212PJLKw2hXgPzolWgl+/U9ykImgwo4TsKP0rVj3i7N5lPmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4PxwaZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C64C32781;
	Tue, 25 Jun 2024 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327064;
	bh=h7/s1erSrTInKP/WfJXKAlirzQaaLfNgEqTkzmlNeWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4PxwaZptC/mrLUYem2vzCWclAWJx9yUlEjjlguMsEA9cwvaZ4yPel74R2ZxiLnvR
	 A2oNPJYNkBWtKFXwwhHJiaCYvXTF85t20gmIgjaqjwc1odeAUqS9bIF2/4hZKUwz3+
	 6qqo97tDKElp69yt/8DzNYaYXcvGfR9a4QHsztGl/X50GjCD/s+0y+miYPoM0eB+Xi
	 ev3nMUoY2hiJLqfosv4jiwJwBtFfZRh0wDz2YnKgLyxzrB7w0EEVm8/HHCOh+0QRa7
	 Uvdv5NSIsVY142FaeawS/1wDcH5JjVEmljs2c60LL5lHTt3YwP/RWL8WfIenQjuzS/
	 j64abmeLhVVmQ==
Date: Tue, 25 Jun 2024 15:50:59 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v7 01/16] dt-bindings: riscv: add Zimop ISA extension
 description
Message-ID: <20240625-blimp-richly-f5828cbfe6a6@spud>
References: <20240619113529.676940-1-cleger@rivosinc.com>
 <20240619113529.676940-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9PA0Wx6xMQTCxIcL"
Content-Disposition: inline
In-Reply-To: <20240619113529.676940-2-cleger@rivosinc.com>


--9PA0Wx6xMQTCxIcL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 01:35:11PM +0200, Cl=E9ment L=E9ger wrote:
> Add description for the Zimop (May-Be-Operations) ISA extension which
> was ratified in commit 58220614a5f of the riscv-isa-manual.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cfed80ad5540..e214679ab6da 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -363,6 +363,11 @@ properties:
>              ratified in the 20191213 version of the unprivileged ISA
>              specification.
> =20
> +        - const: zimop
> +          description:
> +            The standard Zimop extension version 1.0, as ratified in com=
mit
> +            58220614a5f ("Zimop is ratified/1.0") of the riscv-isa-manua=
l.
> +
>          - const: ztso
>            description:
>              The standard Ztso extension for total store ordering, as rat=
ified
> --=20
> 2.45.2
>=20

--9PA0Wx6xMQTCxIcL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrZUwAKCRB4tDGHoIJi
0h+2AQD3yl1OivAnczjSlHzmMNfjOS/06MsBmq0xtbv8bTLpNAD/RzbgHtntHnej
NyEPsFHW7yXdXAU1j8rFsiMmhti6igo=
=/o9k
-----END PGP SIGNATURE-----

--9PA0Wx6xMQTCxIcL--

