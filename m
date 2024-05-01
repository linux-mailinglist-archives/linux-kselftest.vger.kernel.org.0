Return-Path: <linux-kselftest+bounces-9243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700D8B9074
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C14281D69
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A21635A8;
	Wed,  1 May 2024 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwu2J1/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326835B69E;
	Wed,  1 May 2024 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594551; cv=none; b=bCmgdqEmsL5P18shOzwQde8vp4BaWCdJrJdjIfm5nacxkT6yVk8ccWPRpo7mVN3M0Q7NNaLfT/6vKLCLYywwInv7lOwos3Dwx+Rz725+gw1N9z8toiiwnSwiWNY5HEcGR1S/+UcKTez2E2nC1Za/OwLLDg2QdyIl/9R3XG928UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594551; c=relaxed/simple;
	bh=B1Uh4i07qA042YiuAtEnhpGxy0d/YEecRVrlZr0WYw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phUO/6mT/45zDJZKOJQ8dVdWbju2fsePsJOIe3eLMj/3JVpxJyNQlbyCLTjAR/GAk+mHU70Lau3q7+dD4c5cihapT+NkiNuR4KRpSDp53Tx1t1E+KmvOvXbbmd65TqA2fsfJaGGGywKeU6Duoxk2KZO3V73BkaXPPDELt18P5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwu2J1/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32582C4AF19;
	Wed,  1 May 2024 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714594550;
	bh=B1Uh4i07qA042YiuAtEnhpGxy0d/YEecRVrlZr0WYw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwu2J1/hBd8nUQDpUcCUvBJ/iE2Tt854m42ww+YyLzdRcPUswOq5X0ben9BhtzqeC
	 KOKuGrC9hV5ugEltMpZ9LOWNXx7IyJ5ph2DcYQNxdfLLfODQruyozQYBAm8PdX5uCd
	 yTaCg1bca1vKUTibNb9AFHiToLHamAtXOTlRaeXrgWVlm/yDrZONGe8lu5d69xM6Wp
	 Z62GETam1wKiei04yhW3bFHttlICDuVo6oap1jc0+w9TIxqKGdDD52njjkMnNW8rA5
	 8pUAQwLGgMJvnnOX1fzvEk4w6i/tgDG4PVqALPi6mG841Jf3Hoep8sSx9ZeeXav/4V
	 3eUPthzU83tnA==
Date: Wed, 1 May 2024 21:15:44 +0100
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
Subject: Re: [PATCH v4 07/16] riscv: cpufeature: Extract common elements from
 extension checking
Message-ID: <20240501-hazy-reformist-8ff36ba53450@spud>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-7-b692f3c516ec@rivosinc.com>
 <20240501-probable-unfunded-746ef6ae1853@spud>
 <ZjKcfZsWgR1AY3AZ@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GXUDSiAct5jPEsjU"
Content-Disposition: inline
In-Reply-To: <ZjKcfZsWgR1AY3AZ@ghost>


--GXUDSiAct5jPEsjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 12:48:13PM -0700, Charlie Jenkins wrote:
> On Wed, May 01, 2024 at 12:37:14PM +0100, Conor Dooley wrote:
> > On Fri, Apr 26, 2024 at 02:29:21PM -0700, Charlie Jenkins wrote:
> > > The __riscv_has_extension_likely() and __riscv_has_extension_unlikely=
()
> > > functions from the vendor_extensions.h can be used to simplify the
> > > standard extension checking code as well. Migrate those functions to
> > > cpufeature.h and reorganize the code in the file to use the functions.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/cpufeature.h        | 78 +++++++++++++++++---=
----------
> > >  arch/riscv/include/asm/vendor_extensions.h | 28 -----------
> > >  2 files changed, 44 insertions(+), 62 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index fedd479ccfd1..17896ec9ec11 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -98,59 +98,66 @@ extern bool riscv_isa_fallback;
> > > =20
> > >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitm=
ap);
> > > =20
> > > +#define EXT_ALL_VENDORS		0
> >=20
> > It's not really "all vendors", it's standard. Otherwise, this seems all
>=20
> This hooks up into the alternatives:
>=20
> ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)

Yeah, I know what you're using it for, I just find the naming odd.
>=20
> Where the "vendor" argument is supposed to be 0 if the alternative is
> applicable to all vendors. Is there a better way to convey this?

s/EXT_ALL_VENDORS/STANDARD_EXT/?

--GXUDSiAct5jPEsjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjKi7wAKCRB4tDGHoIJi
0pu+AP9hEmGvtiSYMRVj8J8qm6vSD21SfEYfsPIhrXHI3zAnRwEAtYpy2rqHQbrU
hC4o62eJA24pmjxdVcu266GkK87+ywA=
=wAFW
-----END PGP SIGNATURE-----

--GXUDSiAct5jPEsjU--

