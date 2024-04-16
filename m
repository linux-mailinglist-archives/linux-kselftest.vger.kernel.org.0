Return-Path: <linux-kselftest+bounces-8171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1888A6F7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09941C2198B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E6130A76;
	Tue, 16 Apr 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmi+PdFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59753130491;
	Tue, 16 Apr 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280597; cv=none; b=Q1c07aKANlOAbojy1Tf5nTwJMPFvrNNhcfYKOt9UFQ+bUnschgoRTlL4xUWxLJbdLIQ0Fq+C1DvXPWhtBPBWLStIi63WVoP7CyW1klz3jppvrggTFRC8YRIkh5ahMHEdmCwmwaWC4esMXbKguG61SDqgbp16HXvtRa7J3N+Bsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280597; c=relaxed/simple;
	bh=InnM2wKHZDVJcxsb32eryq9FZ+eyYPiDT6PDeAxmkcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBrMr6s2dtX2aNKy5TkmkdgDJrxF0rM/tYeie/eXCr874JHLEHC9zaceO1J2vG/Yb7EzsuRxWZPdyeZa8cqDBaKgrwMOKz7PTf1jYKSqvE+TRsU1L3wRlVVeWCgz2cgj7FOOeJHXtP6KWqn2foxRAParW3JAIO8I5eEJn7IcyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmi+PdFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D578C113CE;
	Tue, 16 Apr 2024 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280596;
	bh=InnM2wKHZDVJcxsb32eryq9FZ+eyYPiDT6PDeAxmkcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmi+PdFUk+pqNCmA5Tv0nMe1Rms4QVLfeQiS3gEo2aznB+h0Md9qBqkDmhELSwa1R
	 t9+iuyni43iZdovlFAk11+AliTSkSgGoT7H+mgYODHPu8nasGgUL/zmkpkE7+oMI7c
	 tbBKUook+UHjhFPKv5g/OCrVnSoawHnjFg49vkvTn2jz+m8UcHyt5Nw26siTYzx7eJ
	 eZ2Cwrvr5w4QWb7V5ibYtiglDiMzL7ydyDO+/rEuFwcxbkYvGyNFgKvAQrlLSigLVW
	 pnhgn1uhMYYILoGbd6MAWFg4yBXocjTlf6qJEdzTRMQ4G9kzfE82E9lw08ZzbXwk2v
	 GYvtZW1LJtf1g==
Date: Tue, 16 Apr 2024 16:16:30 +0100
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
Subject: Re: [PATCH v2 02/17] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Message-ID: <20240416-underwire-bright-b2ab0fa991ec@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-2-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FdN+IanOF5jba0gw"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-2-c7d68c603268@rivosinc.com>


--FdN+IanOF5jba0gw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:11:59PM -0700, Charlie Jenkins wrote:
> The xtheadvector ISA extension is described on the T-Head extension spec
> Github page [1] at commit 95358cb2cca9.
>=20
> Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cc=
a9489361c61d3
> 35e03d3134b14133f/xtheadvector.adoc [1]

This should not be wrapped btw.
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 468c646247aa..99d2a9e8c52d 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -477,6 +477,10 @@ properties:
>              latency, as ratified in commit 56ed795 ("Update
>              riscv-crypto-spec-vector.adoc") of riscv-crypto.
> =20
> +        # vendor extensions, each extension sorted alphanumerically unde=
r the
> +        # vendor they belong to. Vendors are sorted alphanumerically as =
well.
> +
> +        # Andes
>          - const: xandespmu
>            description:
>              The Andes Technology performance monitor extension for count=
er overflow
> @@ -484,5 +488,11 @@ properties:
>              Registers in the AX45MP datasheet.
>              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
> =20
> +        # T-HEAD
> +        - const: xtheadvector
> +          description:
> +            The T-HEAD specific 0.7.1 vector implementation as written in
> +            https://github.com/T-head-Semi/thead-extension-spec/blob/953=
58cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
> +
>  additionalProperties: true
>  ...
>=20
> --=20
> 2.44.0
>=20

--FdN+IanOF5jba0gw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6WTgAKCRB4tDGHoIJi
0sMWAP4+aeJt178cyWMEA9Mn4d+S37RsUbed8NjDYrowtrQETAEAti61pmdoJgct
1P4NAn7MiJAgxQW6b5m82/RPqoVkTwo=
=Ucx5
-----END PGP SIGNATURE-----

--FdN+IanOF5jba0gw--

