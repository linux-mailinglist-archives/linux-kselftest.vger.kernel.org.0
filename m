Return-Path: <linux-kselftest+bounces-13070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1202924295
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 17:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECCC1F235F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C61BD017;
	Tue,  2 Jul 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2rFR4+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7841BD00E;
	Tue,  2 Jul 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934774; cv=none; b=Gp5VufWosYcdvEPo9DRdTL0NwjPk8jjGR4xBiQNMTOu3QwSjUpJxljKAHqTZDKP4lqtu5ZiSrHLgwFah4TzkHPYNsGIyADICWTMGMztoiJCkk0BuPeSoD1c3UdwsYyCiNxJemtFWBttr6J7coSVb4wykBxAiLKMksIUmTUEQpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934774; c=relaxed/simple;
	bh=g+sRA4FxF0h1IXfXKKTkTHt+QuvIbChKxddB8lzK4EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABwyb6unX5BvqAFwMerMVvzSKFyIQVHOufBqhn9aoK4ZmWTNA89jy6pCsmDJdMbojzJ27JjZIzuW9LaqU6us7n/oKZvPuqU0MeGuwDqaQTsfVcTSHw09hN1CgGAY8zsu4oEDpdYhOcj1u3JhubT7Rdpdk9Wr48z+0L0JyoBiByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2rFR4+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64C5C4AF0C;
	Tue,  2 Jul 2024 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719934773;
	bh=g+sRA4FxF0h1IXfXKKTkTHt+QuvIbChKxddB8lzK4EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2rFR4+1H8QAjHvU9Nz3JkKytSJuyGXKQhLFL1bLBu4/dRgrX3qdt0w6Xq/S6XkFZ
	 ZlB8VolHFV5FXsu4clie838j9pElkHVJKrVH2pYsB34+zZPYXftXRi0jLjnmKosCF+
	 XRqvP4pTy97ke6vL8nabJ3odm4GxIbubsDZztRCtBQhRkPTZeOcs6LUWEU8C684usv
	 5ZbydD7hBTg+SJjg+VwMNbV0djJTy9wrTgEA/3DLdINP+ZmnGY9KmI+sMgil7QiQMZ
	 t9VU8adMQ/COk9f2GOfv1+DkuhttuUaaPgJg/2LUPc3gtKxmh4MJHSExYyjk3CSlLz
	 jq57ItKWe1/vg==
Date: Tue, 2 Jul 2024 16:39:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Yu-Chien Peter Lin <peterlin@andestech.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>, tim609@andestech.com,
	dminus@andestech.com, ycliang@andestech.com
Subject: Re: [PATCH v3 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Message-ID: <20240702-protegee-exploring-49c0dbd831e5@spud>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
 <20240619-xtheadvector-v3-3-bff39eb9668e@rivosinc.com>
 <0cc13581-5cc4-4a25-a943-7a896f42da4c@sifive.com>
 <20240701-prancing-outpost-3cbce791c554@spud>
 <7ab7d629-6993-4cad-b5b7-62bddfc74a49@sifive.com>
 <20240701-pyromania-spinster-709a6c8cc460@spud>
 <ZoPMEaq8wKzXhFuA@APC323>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hXUitlnmUnc9XLtm"
Content-Disposition: inline
In-Reply-To: <ZoPMEaq8wKzXhFuA@APC323>


--hXUitlnmUnc9XLtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 05:46:42PM +0800, Yu-Chien Peter Lin wrote:
> On Mon, Jul 01, 2024 at 05:31:01PM +0100, Conor Dooley wrote:
> > On Mon, Jul 01, 2024 at 11:11:55AM -0500, Samuel Holland wrote:
> > > Hi Conor, Charlie,
> > >=20
> > > On 2024-07-01 11:07 AM, Conor Dooley wrote:
> > > > On Mon, Jul 01, 2024 at 10:27:01AM -0500, Samuel Holland wrote:
> > > >> On 2024-06-19 6:57 PM, Charlie Jenkins wrote:
> > > >>> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch=
/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > >>> index 64c3c2e6cbe0..6367112e614a 100644
> > > >>> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > >>> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > >>> @@ -27,7 +27,8 @@ cpu0: cpu@0 {
> > > >>>  			riscv,isa =3D "rv64imafdc";
> > > >>
> > > >> The ISA string should be updated to keep it in sync with riscv,isa=
-extensions.
> > > >=20
> > > > This probably looks like this cos I said that the kernel shouldn't =
parse
> > > > vendor extensions from "riscv,isa". My rationale was that we have
> > > > basically no control of what a vendor extension means in riscv,isa =
so=20
> > > > we shouldn't parse them from it (so marginally worse than standard
> > > > extensions, where it means what the spec says except when it doesn'=
t).
> > > >=20
> > > > Given how we implement the parsing, it also meant we weren't implyi=
ng
> > > > meanings for vendor extensions ACPI-land, where we also can't ensur=
e the
> > > > meanings or that they remain stable. That change is in a different
> > > > series:
> > > > https://patchwork.kernel.org/project/linux-riscv/patch/20240609-sup=
port_vendor_extensions-v2-1-9a43f1fdcbb9@rivosinc.com/
> > > >=20
> > > > Although now that I think about it, this might break xandespmu... I
> > > > dunno if the Andes guys switched over to using the new property out=
side
> > > > of the single dts in the kernel tree using their SoC. We could
> > > > potentially special-case that extension if they haven't - but my
> > > > position on this mostly is that if you want to use vendor extension=
s you
> > > > should not be using riscv,isa (even if the regex doesn't complain i=
f you
> > > > add them). I'd like to leave the code in the other patch as-is if w=
e can
> > > > help it.
> > > >=20
> > > > I added Yu Chien Peter Lin here, maybe they can let us know what th=
ey're
> > > > doing.
> > >=20
> > > OK, that makes sense to me. Then please ignore my original comment.
> >=20
> > Should the xandespmu thing be an issue, I'd suggest we just do something
> > like the following, in place of the new switch arm added by Charlie:
> >=20
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index ec4bff7a827c..bb99b4055ec2 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -628,6 +628,17 @@ static void __init riscv_parse_isa_string(const ch=
ar *isa, unsigned long *bitmap
> >  		if (unlikely(ext_err))
> >  			continue;
> > =20
> > +		if (*ext =3D=3D 'x' && acpi_disabled) {
> > +			/*
> > +			 * xandespmu predates this "rule", so special case it for
> > +			 * hysterical raisins
> > +			 */
> > +			if (strncasecmp(ext, "xandespmu", ext_end - ext)) {
> > +				pr_warn_once("Vendor extensions are ignored in riscv,isa. Use risc=
v,isa-extensions instead.");
> > +				break;
> > +			}
> > +		}
> > +
> >  		match_isa_ext(ext, ext_end, bitmap);
> >  	}
> >  }
> >=20
>=20
> Thanks for the hands-up!
> We don't use the deprecated riscv,isa to specify xandespmu, so no
> need to address this special case.

Great, that's good to know - thanks!

--hXUitlnmUnc9XLtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQfLgAKCRB4tDGHoIJi
0hXfAQCCxZXEBqT4cPTHb0LGQh6uikBkC+CR23ztTmUdfDTFHgD+LGxDU34bLk9W
K+AGaZjFkN9dMlpWdebZ/9qZ/D4iqAY=
=KERh
-----END PGP SIGNATURE-----

--hXUitlnmUnc9XLtm--

