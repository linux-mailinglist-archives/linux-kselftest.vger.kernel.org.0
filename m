Return-Path: <linux-kselftest+bounces-11596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E352902943
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1A6282800
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2214F132;
	Mon, 10 Jun 2024 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzjQlIS/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9C14F10E;
	Mon, 10 Jun 2024 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047708; cv=none; b=S0rlFD+LJrqBGLH9WE1dB6iWor6+RjfC/WEZg90s/NqZsFMuEFg2ffrf2/bRL3xwjstYQPo5uGkCb6Qe/AAc+SXtdJ0bjjopq0zhaYSiZXRPu+T4UCH4STTm2NT9tUCfX/bucYOOJdnVGaDX0qfOlMIrmcoKfzg/F2sILJe1EQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047708; c=relaxed/simple;
	bh=9PZjDT0V6Lj4GRK41zPSetvsgEiAtuFunhoEXkc3IY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFvHkgMLTUO8m9y+g99r6QUDcO4GX4oK/0Vl4wjICoN1FzQd/ORgqWmHUwyGNA4soHMaIA6FwETvvyqDpMg+G3q0QPYSDkUyyxg3+vfMmxCaU7D8VXUlNvPP2/VQNUHIm84FJMw3C2SH8lslBOpLrmKZ0hIsnXC8MZmqDiUDYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzjQlIS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468B4C4AF1A;
	Mon, 10 Jun 2024 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718047708;
	bh=9PZjDT0V6Lj4GRK41zPSetvsgEiAtuFunhoEXkc3IY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TzjQlIS/V6CcADcn39qu2MVD/FOA+Yr1qULzWAMawj4+ebOtJTsjTS8PWQReYHTUG
	 t+b10QtTD4rZWBvXYcPEAXJyraxXaxdRcUcmIa/r/WJBUz8+ASC1ep3qdO5S8FAOBU
	 OBfzwXkUZW57K73lsfZdzbkmqc3oyftFUt8BMrHSkwiTqIovF/ssJpOtVa9PkT7fJb
	 W4+IRELYJ3POTYVbrVtiGU6Vl1PfN4RwR978eiSDoU7Dr/53/hcmvcGsZWM9uyEIsa
	 P+HafwBaOUMhDp8SPgHnxzpgbr8YJHO+llEdJbpVEgLymDlFY+Q3jKcbI47wglfe73
	 ALVBkh4DUZJdg==
Date: Mon, 10 Jun 2024 20:28:22 +0100
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
Message-ID: <20240610-envision-impart-7211e512f987@spud>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-2-3fe591d7f109@rivosinc.com>
 <20240610-unaltered-crazily-5b63e224d633@spud>
 <Zmcr7pP+XEWHYTsy@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zZEd5eFtiVuoCvyW"
Content-Disposition: inline
In-Reply-To: <Zmcr7pP+XEWHYTsy@ghost>


--zZEd5eFtiVuoCvyW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 09:38:06AM -0700, Charlie Jenkins wrote:
> On Mon, Jun 10, 2024 at 05:29:23PM +0100, Conor Dooley wrote:
> > On Sun, Jun 09, 2024 at 09:45:07PM -0700, Charlie Jenkins wrote:
> > > Add a property analogous to the vlenb CSR so that software can detect
> > > the vector length of each CPU prior to it being brought online.
> > > Currently software has to assume that the vector length read from the
> > > boot CPU applies to all possible CPUs. On T-Head CPUs implementing
> > > pre-ratification vector, reading the th.vlenb CSR may produce an ille=
gal
> > > instruction trap, so this property is required on such systems.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/thead.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml b/Doc=
umentation/devicetree/bindings/riscv/thead.yaml
> > > index 301912dcd290..5e578df36ac5 100644
> > > --- a/Documentation/devicetree/bindings/riscv/thead.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/thead.yaml
> > > @@ -28,6 +28,13 @@ properties:
> > >            - const: sipeed,lichee-module-4a
> > >            - const: thead,th1520
> > > =20
> > > +thead,vlenb:
> >=20
> > This needs to move back into cpus.yaml, this file documents root node
> > compatibles (boards and socs etc) and is not for CPUs. If you want to
> > restrict this to T-Head CPUs only, it must be done in cpus.yaml with
> > a conditional `if: not: ... then: properties: thead,vlenb: false`.
> >=20
> > Please test your bindings.
>=20
> Now that I know `make dt_binding_check` exists I will use that in the
> future!

And in this case dtbs_check would also complain about riscv,vlenb being
undocumented - and complain about thead,vlenb not being a permitted cpu
property either.

Thanks,
Conor.

--zZEd5eFtiVuoCvyW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmdT1gAKCRB4tDGHoIJi
0gELAP9N4Tu6RdQuKtMCvloFTO6BrRXNU2iSwXxMepsikmv0PQEAsVNMYTrc/cIX
AooXc0b3saxiQGxb2MiZo/UtbA/dcAo=
=DctY
-----END PGP SIGNATURE-----

--zZEd5eFtiVuoCvyW--

