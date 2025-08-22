Return-Path: <linux-kselftest+bounces-39698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E09B32095
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5CC7AF995
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E87E3043DC;
	Fri, 22 Aug 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSgMwNBy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDA2580CF;
	Fri, 22 Aug 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880446; cv=none; b=UMTv60gGY9hIDATRBoGZ6jxYTtFKVhhzy21p2YRC/8L+cNCnY/j+FBFavkqoOOke9nPKsAIBhFzQTRPWeSVKXGpuqv293kILVSiwevaFcfqR/5XlHrQUbPHTq5DtEODg1HTmnt2KQjR7vdBun9yNMbLTIs1Aih9x6YLW3xilL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880446; c=relaxed/simple;
	bh=iKMaqY2T2MvMaFi0XbUWD0o8saOVzIOavh0WskJFFJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDU6PYt9cMo11b1YWtY461Mz+SDDgDAKVutpd0ofHvk9yp9bl8AC9dVhcB+Ki9yohGAgOXmDZupP/7oiTRHp/ciH5w4bTpavpxgrv4+RtPRfl893ucRkydK5/gW1F8PaAFBse+X4Fla6zullujLm5CEldxahV4g9l0mlIQd+pSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSgMwNBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87CEC4CEED;
	Fri, 22 Aug 2025 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755880445;
	bh=iKMaqY2T2MvMaFi0XbUWD0o8saOVzIOavh0WskJFFJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSgMwNByRYG87aU+xs9MlnWyfggyMpBShAVpHsDhv7+s2Rl50S6MV03gYuI5AIodC
	 gHcJY5vJ8pODlXqfgGFRJt9EsHTYJ9w2zZFxRJzHV80px0qH3IDHBBl2EIDCGFHNVc
	 NdTJacp29PXHOA/QWlJPY6xryO5kHtiYrIf2AmdKyPGVZOmtYOiIeRzrL/a25q30Mp
	 zcBN6hWt8nLuR0iQficgQqnP2PL2DpHAas3KYnbbJjCNjhbrFEoluJgwSHM9RLb14W
	 /tnD6l4HBcfilMhKlkILzTEKi08X16/ucccvai6fqwMVP7CYKttBi9Kng1v051vWcI
	 yXe6kg4RWOPiA==
Date: Fri, 22 Aug 2025 17:33:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anup@brainfault.org, pbonzini@redhat.com,
	shuah@kernel.org, cyan.yang@sifive.com, cleger@rivosinc.com,
	charlie@rivosinc.com, cuiyunhui@bytedance.com,
	samuel.holland@sifive.com, namcao@linutronix.de, jesse@rivosinc.com,
	inochiama@gmail.com, yongxuan.wang@sifive.com,
	ajones@ventanamicro.com, parri.andrea@gmail.com,
	mikisabate@gmail.com, yikming2222@gmail.com,
	thomas.weissschuh@linutronix.de, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and Zclsd
 extension descriptions
Message-ID: <20250822-purge-doubling-f38988284db1@spud>
References: <20250821140131.225756-1-pincheng.plct@isrc.iscas.ac.cn>
 <20250821140131.225756-2-pincheng.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iXs4qi8wL7fiAACn"
Content-Disposition: inline
In-Reply-To: <20250821140131.225756-2-pincheng.plct@isrc.iscas.ac.cn>


--iXs4qi8wL7fiAACn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:01:27PM +0800, Pincheng Wang wrote:
> Add descriptions for the Zilsd (Load/Store pair instructions) and
> Zclsd (Compressed Load/Store pair instructions) ISA extensions
> which were ratified in commit f88abf1 ("Integrating load/store
> pair for RV32 with the main manual") of the riscv-isa-manual.
>=20
> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index ede6a58ccf53..d72ffe8f6fa7 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -366,6 +366,20 @@ properties:
>              guarantee on LR/SC sequences, as ratified in commit b1d80660=
5f87
>              ("Updated to ratified state.") of the riscv profiles specifi=
cation.
> =20
> +        - const: zilsd
> +          description:
> +            The standard Zilsd extension which provides support for alig=
ned
> +            register-pair load and store operations in 32-bit instruction
> +            encodings, as ratified in commit f88abf1 ("Integrating
> +            load/store pair for RV32 with the main manual") of riscv-isa=
-manual.
> +
> +        - const: zclsd
> +          description:
> +            The Zclsd extension implements the compressed (16-bit) versi=
on of the
> +            Load/Store Pair for RV32. As with Zilsd, this extension was =
ratified
> +            in commit f88abf1 ("Integrating load/store pair for RV32 wit=
h the
> +            main manual") of riscv-isa-manual.
> +
>          - const: zk
>            description:
>              The standard Zk Standard Scalar cryptography extension as ra=
tified
> @@ -847,6 +861,16 @@ properties:
>              anyOf:
>                - const: v
>                - const: zve32x
> +      # Zclsd depends on Zilsd and Zca
> +      - if:
> +          contains:
> +            anyOf:
> +              - const: zclsd
> +        then:
> +          contains:
> +            anyOf:
> +              - const: zilsd
> +              - const: zca
> =20
>  allOf:
>    # Zcf extension does not exist on rv64
> @@ -864,6 +888,21 @@ allOf:
>            not:
>              contains:
>                const: zcf
> +  # Zilsd extension does not exist on rv64
> +  - if:
> +      properties:

> +        riscv,isa-extensions:
> +          contains:
> +            const: zilsd

This syntax is odd, it shouldn't be required to have zilsd in here and
in the then. Did you copy this from Zcf or come up with it yourself
because it didn't work otherwise?

> +        riscv,isa-base:
> +          contains:
> +            const: rv64i
> +    then:
> +      properties:
> +        riscv,isa-extensions:
> +          not:
> +            contains:
> +              const: zilsd
> =20
>  additionalProperties: true
>  ...
> --=20
> 2.39.5
>=20

--iXs4qi8wL7fiAACn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKib9QAKCRB4tDGHoIJi
0irLAQCV5/SvoxN05dR+xOZRbx3ngdqvZgXtTOXV1Bvb1u1sbgEAqB+ZSQTXtrTn
OOlkomc7ojGER25FiOTQpdYiyfasmAg=
=zFKH
-----END PGP SIGNATURE-----

--iXs4qi8wL7fiAACn--

