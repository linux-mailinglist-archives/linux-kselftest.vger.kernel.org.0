Return-Path: <linux-kselftest+bounces-7862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3E8A3619
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C577C1F238FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9EA14F13B;
	Fri, 12 Apr 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv70IH6H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9E14EC60;
	Fri, 12 Apr 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948453; cv=none; b=E8W2l+6h/MSG94Y4nySB3B+1JDchWVsn9Lkut7JrCyVqF4m2P+Y3Dz0kYOlitIg1zjb/j3UNmQ/Up5qKYMf1W0Pixe9d6ZqW8LTznQRuSdxCybkuinIPpQiVc3z7PR76FyYlvyBdvgDU3MtK7HgD8gkenamNXaOMnS0lmufenZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948453; c=relaxed/simple;
	bh=zjERDaZxnJcQkN5CsXJlf2FvNFLdjHZ+EAHGDAdZ/ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTzVQ2vFtI00wZbREoZKm9t80zgxBpUdGuoWjsPrPi4lb6JM6MB6T/9CxV+pt2BoPHo/gyTefNzrvhIGrp6vCiGL3tSJid1GKbjjGyrsKOSSSAATF4gl682FREJtld+aSPm4zJ9/36lNPg1z6Lc3mYVVrdLO/R2g0xfr0OuBYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv70IH6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E802C113CC;
	Fri, 12 Apr 2024 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712948453;
	bh=zjERDaZxnJcQkN5CsXJlf2FvNFLdjHZ+EAHGDAdZ/ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fv70IH6HmhET0vREPnCPAMw7Zte6KDR18caLJzQeXRwxqTL3cawpT4GwCrOrEc4Iz
	 aDIwNQLY4iuGz2uT6ddt6Drg20rKv8pLAQY+S9iJ5MJfTkj1Slz72G5IjBok911JBa
	 OGW9Ly/6Sgpxi7thDG2JTywWye/BPbTzIr75uHA/UvcFvbE5mZNDHTZOYVjNG/hYKa
	 F2VPZREepVD5IIuM2tBNpHszwqYu1VY50G5VS/JY8jKs0687DtugQAf1/SsVJ6WGqK
	 Ti16VSTjb8XNu5k4X46LeIYUzY8u/OIUDWq0hSDH5lav6BZtioOlRauXV7ViOfCO+e
	 k26f2bOKdS9Zw==
Date: Fri, 12 Apr 2024 20:00:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 12/19] riscv: Create xtheadvector file
Message-ID: <20240412-displease-sensually-33d91fc3fe63@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-12-4af9815ec746@rivosinc.com>
 <20240412-thirty-sacrament-db052c7fe6fe@wendy>
 <Zhl8Y+GzTB/ip7rT@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yiuYflu9z+To5kfn"
Content-Disposition: inline
In-Reply-To: <Zhl8Y+GzTB/ip7rT@ghost>


--yiuYflu9z+To5kfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:24:35AM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 12:30:32PM +0100, Conor Dooley wrote:
> > On Thu, Apr 11, 2024 at 09:11:18PM -0700, Charlie Jenkins wrote:
> > > These definitions didn't fit anywhere nicely, so create a new file to
> > > house various xtheadvector instruction encodings.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/xtheadvector.h | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/include/asm/xtheadvector.h b/arch/riscv/inclu=
de/asm/xtheadvector.h
> > > new file mode 100644
> > > index 000000000000..348263ea164c
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/xtheadvector.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +/*
> > > + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an=
 older
> > > + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction f=
or
> > > + * vsetvli	t4, x0, e8, m8, d1
> > > + */
> > > +#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
> > > +#define THEAD_VSETVLI_X0X0E8M8D1	".long	0x00307057\n\t"
> > > +
> > > +/*
> > > + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the s=
ame
> > > + * encoding as the standard vse8.v and vle8.v, compilers seem to opt=
imize
> > > + * the call resulting in a different encoding and then using a value=
 for
> > > + * the "mop" field that is not part of vector-0.7.1
> > > + * So encode specific variants for vstate_save and _restore.
> >=20
> > This wording seems oddly familiar to me, did Heiko not write this?
>=20
> Yeah, I wasn't sure how to attribute him. He wrote almost all of the
> lines in this file, but I put it together into this file. What is the
> standard way of doing that?

The original patches have his sob and authorship, so I would at least
expect co-developed-by.

--yiuYflu9z+To5kfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhmE3gAKCRB4tDGHoIJi
0pxvAP9yVWDaNANZULFGFjAROk1PKk4c4Q7mCmsZPOAQYvlN8wEA59scy5YtWI5N
LccwmxaDOXa8yoM0s7fRijgi3x//xwI=
=OBaT
-----END PGP SIGNATURE-----

--yiuYflu9z+To5kfn--

