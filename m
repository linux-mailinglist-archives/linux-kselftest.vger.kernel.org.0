Return-Path: <linux-kselftest+bounces-9231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C588B8F56
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F64283E9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A01474A8;
	Wed,  1 May 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN29Q61T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872C146D60;
	Wed,  1 May 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586633; cv=none; b=mF1nBBAs2dUnuvy/OpTsnWHKvQc9Bwo4mI7pZg8MQyyFcTpHMPNPAnzBzz01/4Em9ROkwGlQEZ6Vix9QUlqh+gTRUbQGWQHEWJtDqH+oAt7k+7af9wYonpUH0HbVEfv2bPLwayUUuzrtmWG+2Or3eBUQncDudB+Ymidma9/20YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586633; c=relaxed/simple;
	bh=drTPFEBrSB98Q77bfO9fNzjeKZr9JPcrroYaZiR1E/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0yij9+qnxtxb5hb5npFAbXKSpHso26mt6VBYhG5npL3Kl39ExSY8/4xcWvlOG1LAo5Nqg/3zvQPNmA18l+UUGS0WznA0mbT4qt/VVXjdhGN5uFD2cNXKf+SCW0ZYx+fxJxR/AnIDsN8ZPcnU9sApdBkCoAaaa3oGW0HZ8efgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN29Q61T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CB5C072AA;
	Wed,  1 May 2024 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714586633;
	bh=drTPFEBrSB98Q77bfO9fNzjeKZr9JPcrroYaZiR1E/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qN29Q61To54o4hphAo7D6ESVL5CLcZ22ZHpI0FyvYvFgLaFOBDvLlrbsKw9PUcy16
	 TdhZ8IltTvssrtMVEElRJH/lued5Rf9aQs3IwxXmxDMeOfCZkMXkPcVhn4/JicsHw5
	 B0UCecIgcjbVQEWadDfGNsMY/WIcfZWgJWkcZdQdn+grMkc4EW6c5HQ/M5qrSvfD7V
	 n+TDSu+G2xvUHeWKLLGMTrnbT2HYGkpmfC2D/dbyODDAShXE0KLAySIvrgReg8bZUj
	 lQLQRnOko30Wy0F+eHnN6YKuMuZWuj5rhHdeiU+ZzDDv+kmMt5ZvIv4AP+w+Bzt/x5
	 7IRI/B/fm+YVg==
Date: Wed, 1 May 2024 19:03:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Evan Green <evan@rivosinc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240501-banner-sniff-4c5958eb15ef@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>
 <ZjKBKg5zzikR5ngl@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DB2yQnBvjkhLdZ/3"
Content-Disposition: inline
In-Reply-To: <ZjKBKg5zzikR5ngl@ghost>


--DB2yQnBvjkhLdZ/3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 10:51:38AM -0700, Charlie Jenkins wrote:
> On Wed, May 01, 2024 at 09:44:15AM -0700, Evan Green wrote:
> > On Fri, Apr 26, 2024 at 2:29=E2=80=AFPM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > > +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > > +               const struct riscv_isa_vendor_ext_data_list *ext_list=
 =3D riscv_isa_vendor_ext_list[i];
> > > +
> > > +               if (bitmap_empty(ext_list->vendor_bitmap, ext_list->b=
itmap_size))
> > > +                       bitmap_copy(ext_list->vendor_bitmap,
> > > +                                   ext_list->per_hart_vendor_bitmap[=
cpu].isa,
> > > +                                   ext_list->bitmap_size);
> >=20
> > Could you get into trouble here if the set of vendor extensions
> > reduces to zero, and then becomes non-zero? To illustrate, consider
> > these masks:
> > cpu 0: 0x0000C000
> > cpu 1: 0x00000003 <<< vendor_bitmap ANDs out to 0
> > cpu 2: 0x00000010 <<< oops, we end up copying this into vendor_bitmap
> >=20
>=20
> Huh that's a good point. The standard extensions have that same bug too?
>=20
> 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> 		bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> 	else
> 		bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);

I suppose it could in theory, but the boot hart needs ima to even get
this far. I think you'd only end up with this happening if there were
enabled harts that supported rvXXe, but I don't think we even add those
to the possible set of CPUs. I'll have to check.

--DB2yQnBvjkhLdZ/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjKEAgAKCRB4tDGHoIJi
0t4AAP48TlGaRjpIOJcoV+H8wuppgNwKKx3OUtSc+5sg9jOMTgD/cl2e9XPolr3n
9O0nDbaTisOGW7yGRdUZvJ0dsEhOqwE=
=mFwP
-----END PGP SIGNATURE-----

--DB2yQnBvjkhLdZ/3--

