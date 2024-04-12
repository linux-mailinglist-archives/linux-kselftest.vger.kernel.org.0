Return-Path: <linux-kselftest+bounces-7861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2CE8A3615
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FC72855FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB814F9D7;
	Fri, 12 Apr 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw30pxNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86523778;
	Fri, 12 Apr 2024 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948388; cv=none; b=ndJDRGObN2wFfzVe8RAsUfk1QR6ZyA+pAo1jv5pW0JUJpHDkh45qOCryLriE+RFYHpe6g0Bz2oWMkbH26LeEWfa3TI67r9U6NBjcW+Q+BjDF7QLsmaOSIyhV2K0fuxiChMaVr3PYq3X+XVff1MEz878d7Bl6rR/vnBIfQ36JC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948388; c=relaxed/simple;
	bh=LuLEqLX3JLgh1GzFv1vsjyQM7SgJUCT9K8xbIt5Uo5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVBg/f3dvk6ryI1pkO7wnpFh2qYFdBMRvT/szNM1jRA718i5AHM/VG7ageOQPdKABQCDvuXI+8WWz8muaL176yzJ4Q2JDCaG+s+z2o1r+R61l/Lk2XFqtgyJ/p0vrAaemt13ibWk2e6n10Pz3SOynbpfh56ifWsohF7RiTcfo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw30pxNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9DBC2BBFC;
	Fri, 12 Apr 2024 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712948387;
	bh=LuLEqLX3JLgh1GzFv1vsjyQM7SgJUCT9K8xbIt5Uo5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mw30pxNB+RuhG0Eg6RLHx0nvRwAHBHW+UMA78SHhSenayouFGw636u5+aZEMbs48u
	 Z4OdOpjIHXdliZT0DbX3uwJ021wUPeRQ5VYMQiGoX+GmVJlQo//SARrCfV0uajBvt+
	 pesRNDzSUTKDdgRfgX1eDrFzi72ikiW4TW7bvtbMf8Q3ZYz2WUZmXSBJlRALj7D+wf
	 JPiii9gXxroeixv8+8Mp+JI+bRqaFLipDLSi9+4rUFgGPfqzc5WHMXfTInHUKEYKtF
	 ztbHkT9vIdkVVsWnTFcPYgyvkVy9sjrF1NafQ6QIQONuZChPON/S1loIowHoead7r1
	 3hHVQMi2LTdtQ==
Date: Fri, 12 Apr 2024 19:59:40 +0100
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
Subject: Re: [PATCH 06/19] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240412-factsheet-attain-1a2d1c5306a2@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746@rivosinc.com>
 <20240412-sprawl-product-1e1d02e25bca@wendy>
 <ZhloHGxa5jRRR9xg@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CsanCPP69sx4whwN"
Content-Disposition: inline
In-Reply-To: <ZhloHGxa5jRRR9xg@ghost>


--CsanCPP69sx4whwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 09:58:04AM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 01:30:08PM +0100, Conor Dooley wrote:
> > On Thu, Apr 11, 2024 at 09:11:12PM -0700, Charlie Jenkins wrote:
> > >  static void __init riscv_parse_isa_string(unsigned long *this_hwcap,=
 struct riscv_isainfo *isainfo,
> >=20
> > > -					  unsigned long *isa2hwcap, const char *isa)
> > > +					struct riscv_isainfo *isavendorinfo, unsigned long vendorid,
> > > +					unsigned long *isa2hwcap, const char *isa)
> > >  {
> > >  	/*
> > >  	 * For all possible cpus, we have already validated in
> > > @@ -349,8 +384,30 @@ static void __init riscv_parse_isa_string(unsign=
ed long *this_hwcap, struct risc
> > >  		const char *ext =3D isa++;
> > >  		const char *ext_end =3D isa;
> > >  		bool ext_long =3D false, ext_err =3D false;
> > > +		struct riscv_isainfo *selected_isainfo =3D isainfo;
> > > +		const struct riscv_isa_ext_data *selected_riscv_isa_ext =3D riscv_=
isa_ext;
> > > +		size_t selected_riscv_isa_ext_count =3D riscv_isa_ext_count;
> > > +		unsigned int id_offset =3D 0;
> > > =20
> > >  		switch (*ext) {
> > > +		case 'x':
> > > +		case 'X':
> >=20
> > One quick remark is that we should not go and support this stuff via
> > riscv,isa in my opinion, only allowing it for the riscv,isa-extensions
> > parsing. We don't have a way to define meanings for vendor extensions in
> > this way. ACPI also uses this codepath and at the moment the kernel's
> > docs say we're gonna follow isa string parsing rules in a specific vers=
ion
> > of the ISA manual. While that manual provides a format for the string a=
nd
> > meanings for standard extensions, there's nothing in there that allows =
us
> > to get consistent meanings for specific vendor extensions, so I think we
> > should avoid intentionally supporting this here.
>=20
> Getting a "consistent meaning" is managed by a vendor.

IOW, there's absolutely no guarantee of a consistent meaning.

> If a vendor
> supports a vendor extension and puts it in their DT/ACPI table it's up
> to them to ensure that it works. How does riscv,isa-extensions allow for
> a consistent meaning?

The definitions for each string contain links to exact versions of
specifications that they correspond to.

> >=20
> > I'd probably go as far as to actively skip vendor extensions in
> > riscv_parse_isa_string() to avoid any potential issues.
> >=20
> > > +			bool found;
> > > +
> > > +			found =3D get_isa_vendor_ext(vendorid,
> > > +						   &selected_riscv_isa_ext,
> > > +						   &selected_riscv_isa_ext_count);
> > > +			selected_isainfo =3D isavendorinfo;
> > > +			id_offset =3D RISCV_ISA_VENDOR_EXT_BASE;
> > > +			if (!found) {
> > > +				pr_warn("No associated vendor extensions with vendor id: %lx\n",
> > > +					vendorid);
> >=20
> > This should not be a warning, anything we don't understand should be
> > silently ignored to avoid spamming just because the kernel has not grown
> > support for it yet.
>=20
> Sounds good.
>=20
> - Charlie
>=20
> >=20
> > Thanks,
> > Conor.
> >=20
> > > +				for (; *isa && *isa !=3D '_'; ++isa)
> > > +					;
> > > +				ext_err =3D true;
> > > +				break;
> > > +			}
> > > +			fallthrough;
> > >  		case 's':
> > >  			/*
> > >  			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
> > > @@ -366,8 +423,6 @@ static void __init riscv_parse_isa_string(unsigne=
d long *this_hwcap, struct risc
> > >  			}
> > >  			fallthrough;
> > >  		case 'S':
> > > -		case 'x':
> > > -		case 'X':
> > >  		case 'z':
> > >  		case 'Z':
> > >  			/*
> > > @@ -476,8 +531,10 @@ static void __init riscv_parse_isa_string(unsign=
ed long *this_hwcap, struct risc
> > >  				set_bit(nr, isainfo->isa);
> > >  			}
> > >  		} else {
> > > -			for (int i =3D 0; i < riscv_isa_ext_count; i++)
> > > -				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
> > > +			for (int i =3D 0; i < selected_riscv_isa_ext_count; i++)
> > > +				match_isa_ext(&selected_riscv_isa_ext[i], ext,
> > > +					      ext_end, selected_isainfo,
> > > +					      id_offset);
> > >  		}
> > >  	}
> > >  }
>=20
>=20

--CsanCPP69sx4whwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhmEnAAKCRB4tDGHoIJi
0pNvAP0cufmJeVfjqNNvS2amdK3cPxp6+XoZZuLVZYI1W7JTkAD9Etz7Xt95pEBt
HBVc3vyRX/GytuvTJoIkVsfPSrRlpA0=
=aGbN
-----END PGP SIGNATURE-----

--CsanCPP69sx4whwN--

