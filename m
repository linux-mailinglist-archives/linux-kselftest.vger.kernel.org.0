Return-Path: <linux-kselftest+bounces-9225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5408B8ED8
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE43A1F21E0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8851BC3F;
	Wed,  1 May 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkwq10iK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9041B949;
	Wed,  1 May 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583583; cv=none; b=fuv3aAC0EX+Nv/0ZfCpb+bcd/Q0rawO9RxYG9GuMeyDWjEMil3SDfCbXDHC/7K488IlYXqtsVv43GXyyt7AihGLmFhKF2fcsf/lSiKDuBOlzplb7pnX0dcJaRyEyzyT1OzUEtICQsxHQDzn2xZgtFZRxiGhSP3NRkltK1RDdAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583583; c=relaxed/simple;
	bh=IPz3/aYgNNtTogx2QM/gCrHuFcu+FzM5abaZXdd4Yz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSnakXLYVOe+79yyWnfJdKRy224ineR/r4PNLUDCOjeZmd19DT8u9lTlS+8n6XATcDwEUDJR1ARTr9hwqn/HbptpkDO9QvM3YwvobeHC3blnhBAyqY7ZvEHoySakjXiT5Ckwp9EyxnxYsLvGbXsmHFy1jks2wEPl8llVaisX0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkwq10iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A3CC072AA;
	Wed,  1 May 2024 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714583582;
	bh=IPz3/aYgNNtTogx2QM/gCrHuFcu+FzM5abaZXdd4Yz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkwq10iKy65p80Ifjsox/DLLayxuj+nXv/KiaiaLvUT7iXX3Lsb/vXUKbej837y6+
	 oFP+d24cLqsoV3YN+nD9qskRfyG4+hXDqDaoRaVlUza1aio4ef9rNxlOCWxtQvKao2
	 hxfQpL3nt0+VPUHXaFRYC2KVeXXPG2VGBnPj9M8Dn/WCAnceBWQsYMEfrwDuI6vi3Y
	 NpGSZW3z8srrJh0iKwVNS8cYydXi8ii4cJO0cVWwY/cLtZofBPJomJQ1VLOopgiSeg
	 OPpOAETa2Cin4x7krMLph7NXP8rnqXSLtuWMKv7cuoGwfEu8Ke8+qdVuhFtU0Cb06O
	 YIvRyEzwbv9XA==
Date: Wed, 1 May 2024 18:12:56 +0100
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
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240501-drained-gradation-28fbca0cb566@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <20240501-drivable-deviation-0a493511770c@spud>
 <ZjJ3oaFWhbLc39sz@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/qzKnHYGdUVhk0nf"
Content-Disposition: inline
In-Reply-To: <ZjJ3oaFWhbLc39sz@ghost>


--/qzKnHYGdUVhk0nf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 10:10:57AM -0700, Charlie Jenkins wrote:
> On Wed, May 01, 2024 at 12:40:38PM +0100, Conor Dooley wrote:
> > On Fri, Apr 26, 2024 at 02:29:19PM -0700, Charlie Jenkins wrote:
> > > Separate vendor extensions out into one struct per vendor
> > > instead of adding vendor extensions onto riscv_isa_ext.
> > >=20
> > > Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> > > code.
> > >=20
> > > The xtheadvector vendor extension is added using these changes.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/Kconfig                               |  2 +
> > >  arch/riscv/Kconfig.vendor                        | 19 ++++++
> > >  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
> > >  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
> > >  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
> > >  arch/riscv/kernel/Makefile                       |  2 +
> > >  arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++=
++++------
> > >  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
> > >  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
> > >  arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++
> >=20
> > I see no modifications to cpu.c here, is it intentional that vendor
> > stuff isn't gonna show up in /proc/cpuinfo?
>=20
> I wasn't sure if that's something we were wanting to support since
> hwprobe is the prefered api, but I can add that if it is desired.

Desired API for programmatic consumption, sure, but for human users
I think it's good to have the info there.

--/qzKnHYGdUVhk0nf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJ4GAAKCRB4tDGHoIJi
0j3QAQDeC/2mrXk6dao/g67mzgn2Smh9xCv61aljEa2yPZ5CnAEAgL6ApCxtDfzO
MGOVAm2ywft3ZaZrWjs6YI+O9CVW4gw=
=YR4z
-----END PGP SIGNATURE-----

--/qzKnHYGdUVhk0nf--

