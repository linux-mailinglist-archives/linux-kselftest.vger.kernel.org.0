Return-Path: <linux-kselftest+bounces-11579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DA9026B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DE11C229BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E8143746;
	Mon, 10 Jun 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4la2Tf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A25B1F8;
	Mon, 10 Jun 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036970; cv=none; b=glj6gOtE66zhRH2AA47d+rqoyR2FNDHublL+ej3+2qR+IAp8ujHqPovAlcPcVryDMJ2upG2kCgMy8H6VI3L6PxrTKzRqq8tCsWMHfXJiI/m9eK1rTt7k6rla5784sjvFH/3p9LiK7AbQ4hAxgs6wNfj0EBBfaa4w3OD39pGA7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036970; c=relaxed/simple;
	bh=Brmahvm4Yc2awdlg8pCbCM4vutFLaNRGWciE5wW/mBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba/4XU77xGX0L7vAjOISiJ2k3pD5g8/Yiga9DUvuH6rejQScU44RzWFnAk4dHOeRCMttxyAL+Y0o2N62AwN3R3N4Ih6J4v/BuXr8f99tDHFgjE3dZgfUeuZW8zIsgxb2lxNJGCTH+CPMeZFdmhjvEGBx3k9E/EqBP9IUrsa+j+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4la2Tf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D21C2BBFC;
	Mon, 10 Jun 2024 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718036969;
	bh=Brmahvm4Yc2awdlg8pCbCM4vutFLaNRGWciE5wW/mBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4la2Tf2AWfy3SsQXpKsi5iMpBXuatfTSLmKnfqdaFgTMwr9jky2WaHuum2W9v0A7
	 tF4oUXkvy9W5N+bRD+uPzWwm2XooXhl2jWm/7ocz+rm/Rdx8NTDOakGrmlmfLoUtxs
	 3xENG8tF5/Xm46JHQhx8Z2pa95DwnhneFRKZyPYqBWfuOeozmfICy9pN91FYuS53Fj
	 2R9ynJ8u6SSrDC9T1LNH7nJ5/yhV8MVGfEsTYmN9LfAvuA0brCD1U3UzEkWScUoiAV
	 2pSVrP551vX3vnyck6QmVrhnFbbD7z36cdvIXJaE/6o4m+Ltom916vbHTcEfZbFich
	 Qfb9w1ahqwRNA==
Date: Mon, 10 Jun 2024 17:29:23 +0100
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
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/13] dt-bindings: thead: add a vlen register length
 property
Message-ID: <20240610-unaltered-crazily-5b63e224d633@spud>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-2-3fe591d7f109@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7a3nHEEpIFMkcfnt"
Content-Disposition: inline
In-Reply-To: <20240609-xtheadvector-v1-2-3fe591d7f109@rivosinc.com>


--7a3nHEEpIFMkcfnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2024 at 09:45:07PM -0700, Charlie Jenkins wrote:
> Add a property analogous to the vlenb CSR so that software can detect
> the vector length of each CPU prior to it being brought online.
> Currently software has to assume that the vector length read from the
> boot CPU applies to all possible CPUs. On T-Head CPUs implementing
> pre-ratification vector, reading the th.vlenb CSR may produce an illegal
> instruction trap, so this property is required on such systems.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/thead.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml b/Documen=
tation/devicetree/bindings/riscv/thead.yaml
> index 301912dcd290..5e578df36ac5 100644
> --- a/Documentation/devicetree/bindings/riscv/thead.yaml
> +++ b/Documentation/devicetree/bindings/riscv/thead.yaml
> @@ -28,6 +28,13 @@ properties:
>            - const: sipeed,lichee-module-4a
>            - const: thead,th1520
> =20
> +thead,vlenb:

This needs to move back into cpus.yaml, this file documents root node
compatibles (boards and socs etc) and is not for CPUs. If you want to
restrict this to T-Head CPUs only, it must be done in cpus.yaml with
a conditional `if: not: ... then: properties: thead,vlenb: false`.

Please test your bindings.

Thanks,
Conor.

> +  $ref: /schemas/types.yaml#/definitions/uint32
> +  description:
> +    VLEN/8, the vector register length in bytes. This property is requir=
ed in
> +    systems where the vector register length is not identical on all har=
ts, or
> +    the vlenb CSR is not available.
> +
>  additionalProperties: true
> =20
>  ...
>=20
> --=20
> 2.44.0
>=20

--7a3nHEEpIFMkcfnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmcp4wAKCRB4tDGHoIJi
0gVEAQDisUaq6cRgwS43d8aFe/cyWmfTzOM3tCUfWvDJ7AnVuwD9EFVnAEjsPyON
r50kgk8Vr8uPuUh+qeyS+8kydQEtQwI=
=QXX5
-----END PGP SIGNATURE-----

--7a3nHEEpIFMkcfnt--

