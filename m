Return-Path: <linux-kselftest+bounces-7869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3078A3726
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 22:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2FD1F22130
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BB82E62F;
	Fri, 12 Apr 2024 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLrZrrOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49984C6E;
	Fri, 12 Apr 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954411; cv=none; b=FzdFYwFmS+ZmytNAXiie5m5+ue6L4298jshGTESZYBTLrssNKMvLJe4wjvKdvgNlSi5fxYcrApQScvKEm5MR0PW8MwkSXSWUnb8URvkeqNN0QWwXl1TRXReGqadWhDeoSzKvBmYt+gdK+m3GpVUd6JuI+K6W1/3xHQ8Insa+tmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954411; c=relaxed/simple;
	bh=Wgrizvi5A+bU/saW/WglETWFAcMfROK+Fq7L/emRDFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcYVG/75OavGpFKPpIZoBuVzm6AwVS76y5jlOkOpMjjeKVC3f1gTkvGkokZ5VHjU5YBm4WrpLxVZcAtR/RENQWiSmjmyhLQ1srEd0au2AFXo/gHfq58bggDwpMC3AGgOnPCMBHbnQdel8QmQCrwk4gUtMtXrqDKC22xhZaot0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLrZrrOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F638C113CC;
	Fri, 12 Apr 2024 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712954410;
	bh=Wgrizvi5A+bU/saW/WglETWFAcMfROK+Fq7L/emRDFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLrZrrOErntm7dx7brDVgtbc8YFE2ZWlhntzOKdzavzwbiPxdU4SxE5N0s99Lv7nF
	 8v8rtZVaBDWLs2oX+WlaoolC6mQtDz3xrrt+8xqMRhypWjiJkT1lwLEYj7FzFUR57Z
	 IBmXiSjqFroWZ8UpPhH0TOiv485z8A6gHEzoxvpwyLb5qHAP6frHZmj3Rm4YznYeQq
	 TU+oWLs44WYtvFqwjIXj6y7khsPUAazL+HE/zPLZo9mqLjCvhjzzhXMpNemVImfRlq
	 /0BApQnILlJ+SoD9dCK7n5cP3xfmyXobojk7lVgDwwuLKCZdOPB4oeheH2wz5vnDqo
	 mOuxra2m04tsg==
Date: Fri, 12 Apr 2024 21:40:03 +0100
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
Subject: Re: [PATCH 08/19] riscv: Introduce vendor variants of extension
 helpers
Message-ID: <20240412-drab-french-55d8ff2c8cfa@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-8-4af9815ec746@rivosinc.com>
 <20240412-dwarf-shower-5a7300fcd283@wendy>
 <ZhlypvTdsFPZBr08@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aP1C8yQRrFgLdfM0"
Content-Disposition: inline
In-Reply-To: <ZhlypvTdsFPZBr08@ghost>


--aP1C8yQRrFgLdfM0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 10:43:02AM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 12:49:57PM +0100, Conor Dooley wrote:
> > On Thu, Apr 11, 2024 at 09:11:14PM -0700, Charlie Jenkins wrote:
> > > Create vendor variants of the existing extension helpers. If the
> > > existing functions were instead modified to support vendor extensions=
, a
> > > branch based on the ext value being greater than
> > > RISCV_ISA_VENDOR_EXT_BASE would have to be introduced. This additional
> > > branch would have an unnecessary performance impact.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >=20
> > I've not looked at the "main" patch in the series that adds all of the
> > probing and structures for representing this info yet beyond a cursory
> > glance, but it feels like we're duplicating a bunch of infrastructure
> > here before it is necessary. The IDs are all internal to Linux, so I'd
> > rather we kept everything in the same structure until we have more than
> > a handful of vendor extensions. With this patch (and the theadpmu stuff)
> > we will have three vendor extensions which feels like a drop in the
> > bucket compared to the standard ones.
>=20
> It is not duplicating infrastructure. If we merge this into the existing
> infrastructure, we would be littering if (ext > RISCV_ISA_VENDOR_EXT_BASE)
> in __riscv_isa_extension_available. This is particularily important
> exactly because we have so few vendor extensions currently so this check
> would be irrelevant in the vast majority of cases.

That's only because of your implementation. The existing vendor extension
works fine without this littering. That's another thing actually, you
forgot to convert over the user we already have :)

> It is also unecessary to push off the refactoring until we have some
> "sufficient" amount of vendor extensions to deem changing the
> infrastructure when I already have the patch available here. This does
> not introduce any extra overhead to existing functions and will be able
> to support vendors into the future.

Yeah, maybe that's true but this was my gut reaction before reading the
other patch in detail (which I've still yet to do).

--aP1C8yQRrFgLdfM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhmcIwAKCRB4tDGHoIJi
0mfZAP4qEWVgp1JuIP38Uolxn+eUBjm/iYTlV1+a2fJsENNWWgD/eG4awqACrOj8
2zrdJWUXuGon9BtRXw8OxMYkhWD0JAU=
=y7fd
-----END PGP SIGNATURE-----

--aP1C8yQRrFgLdfM0--

