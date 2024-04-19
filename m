Return-Path: <linux-kselftest+bounces-8446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8FD8AB250
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31691C2346B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6966B12FF9A;
	Fri, 19 Apr 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXF3MH9U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452712F361;
	Fri, 19 Apr 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541768; cv=none; b=t6KZLjCf4lACE1BE7kznBNG8qf6yacZKAkzybTGxT4+dW3PmKbTOT+uwyzAKGGIF4PP4h7C/klVlqMRHYKz7Ma1zB+Z+kDtjUh4v0pjypVaDp1x8JwkdFHFiTRYN/vCGpkKY4ybQeyJYzlU4Wg00aCrPzGh6wl468ceHlBifvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541768; c=relaxed/simple;
	bh=MMNCu9qXo/Sui8C3tMfJ7lzuoTJCSLI1PUO4ACRkh8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ6i3sVogZDql9IK1FPHjM//a/a0+aWriVDV1PSuWxinBgR/rIb/vt0ZzSJN9lScLjnky2zAh0vVxWZtwM2lNMygkt2MxcvqENFA3P4LGgxlrNoe/n2JiAOs6OqAl89C99F1d/joDO+mHSX0Aw2IkReTp8XWKloY1hggs//LHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXF3MH9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F25C2BD10;
	Fri, 19 Apr 2024 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541768;
	bh=MMNCu9qXo/Sui8C3tMfJ7lzuoTJCSLI1PUO4ACRkh8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXF3MH9UhHZaW5c+fQbICV8+tqL8zZd3GbsK+MMtlVnuI+U9MykD5EdYMbnqzGiQA
	 clolbwi+WJpRnCi8Bgt+tEF57vK45kHXEgAivOzflaV60ugfWPJize6jQXFRFHwjyr
	 VRS95okpFhaUArffiB/+u6m+wylmbq/z7sLeQsbFvkITQqoo7UuMHWOkDxb5E4UPYj
	 yAg41C5DHBDH+t2YzcwksmCMBm7ZYDOWSL2q4WPfoHN6O8DqUXWH6xY+zsUNil7480
	 D0X+YTTKNs+W1AwuRvHl2QI8DgHMxQgN51X8xpUibgE1yudXL+nOsnAy3LXdkfDXNg
	 tmjlh9MV2WO1A==
Date: Fri, 19 Apr 2024 16:49:16 +0100
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
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/12] dt-bindings: riscv: add Zc* extension rules
 implied by C extension
Message-ID: <20240419-blinked-timid-da722ec6ddc4@spud>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-4-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DpdcO0rlxZdj1hXZ"
Content-Disposition: inline
In-Reply-To: <20240418124300.1387978-4-cleger@rivosinc.com>


--DpdcO0rlxZdj1hXZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 02:42:26PM +0200, Cl=E9ment L=E9ger wrote:
> As stated by Zc* spec:
>=20
> "As C defines the same instructions as Zca, Zcf and Zcd, the rule is that:
>  - C always implies Zca
>  - C+F implies Zcf (RV32 only)
>  - C+D implies Zcd"
>=20
> Add additionnal validation rules to enforce this in dts.

I'll get it out of the way: NAK, and the dts patch is the perfect
example of why. I don't want us to have to continually update
devicetrees. If these are implied due to being subsets of other
extensions, then software should be able to enable them when that
other extension is present.

My fear is that, and a quick look at the "add probing" commit seemed to
confirm it, new subsets would require updates to the dts, even though
the existing extension is perfectly sufficient to determine presence.

I definitely want to avoid continual updates to the devicetree for churn
reasons whenever subsets are added, but not turning on the likes of Zca
when C is present because "the bindings were updated to enforce this"
is a complete blocker. I do concede that having two parents makes that
more difficult and will likely require some changes to how we probe - do
we need to have a "second round" type thing?
Taking Zcf as an example, maybe something like making both of C and F into
"standard" supersets and adding a case to riscv_isa_extension_check()
that would mandate that Zca and F are enabled before enabling it, and we
would ensure that C implies Zca before it implies Zcf?

Given we'd be relying on ordering, we have to perform the same implication
for both F and C and make sure that the "implies" struct has Zca before Zcf.
I don't really like that suggestion, hopefully there's a nicer way of doing
that, but I don't like the dt stuff here.

Thanks,
Conor.

>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       |  8 +++--
>  .../devicetree/bindings/riscv/extensions.yaml | 34 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index d87dd50f1a4b..c4e2c65437b1 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -168,7 +168,7 @@ examples:
>                  i-cache-size =3D <16384>;
>                  reg =3D <0>;
>                  riscv,isa-base =3D "rv64i";
> -                riscv,isa-extensions =3D "i", "m", "a", "c";
> +                riscv,isa-extensions =3D "i", "m", "a", "c", "zca";
> =20
>                  cpu_intc0: interrupt-controller {
>                          #interrupt-cells =3D <1>;
> @@ -194,7 +194,8 @@ examples:
>                  reg =3D <1>;
>                  tlb-split;
>                  riscv,isa-base =3D "rv64i";
> -                riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c";
> +                riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "=
zca",
> +                                       "zcd";
> =20
>                  cpu_intc1: interrupt-controller {
>                          #interrupt-cells =3D <1>;
> @@ -215,7 +216,8 @@ examples:
>                  compatible =3D "riscv";
>                  mmu-type =3D "riscv,sv48";
>                  riscv,isa-base =3D "rv64i";
> -                riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c";
> +                riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "=
zca",
> +                                       "zcd";
> =20
>                  interrupt-controller {
>                          #interrupt-cells =3D <1>;
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index db7daf22b863..0172cbaa13ca 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -549,6 +549,23 @@ properties:
>                  const: zca
>              - contains:
>                  const: f
> +      # C extension implies Zca
> +      - if:
> +          contains:
> +            const: c
> +        then:
> +          contains:
> +            const: zca
> +      # C extension implies Zcd if d
> +      - if:
> +          allOf:
> +            - contains:
> +                const: c
> +            - contains:
> +                const: d
> +        then:
> +          contains:
> +            const: zcd
> =20
>  allOf:
>    # Zcf extension does not exists on rv64
> @@ -566,6 +583,23 @@ allOf:
>            not:
>              contains:
>                const: zcf
> +  # C extension implies Zcf if f on rv32 only
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          allOf:
> +            - contains:
> +                const: c
> +            - contains:
> +                const: f
> +        riscv,isa-base:
> +          contains:
> +            const: rv32i
> +    then:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zcf
> =20
>  additionalProperties: true
>  ...
> --=20
> 2.43.0
>=20

--DpdcO0rlxZdj1hXZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiKSfAAKCRB4tDGHoIJi
0p0bAQCI0ZdOO2q+xaWhcL7Krk9HCdLpniOsKdATTU8zMWqUWgEA7ccpybuwBzK1
KglS0OiA5rjSvLYmJv2WgOCxlKn58AQ=
=l0RY
-----END PGP SIGNATURE-----

--DpdcO0rlxZdj1hXZ--

