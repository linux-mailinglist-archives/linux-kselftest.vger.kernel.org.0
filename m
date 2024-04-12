Return-Path: <linux-kselftest+bounces-7877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30598A37ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A06D281B72
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840C15217C;
	Fri, 12 Apr 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQSf3PB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015B610B;
	Fri, 12 Apr 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957657; cv=none; b=sIWLtttjWIDHUHRq8nJYeEnKbGBBeIm77JQpmIIWz1w+15lfEdDRdnRP6Q+cBGe9TNospqALhA9WdhZVhcpaZgLNnemH4I5ADKO6Sb7C4zTHpclDSeCaXxrpReqk3i+7I2Z9mKFXF/5mpefNcwVJ+NRJhb3ukXJ7FP3wNJcVKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957657; c=relaxed/simple;
	bh=RPMZISUCpRH7rGFvp7EbdpEtkFygpiRP/bPV6ApwRUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLbNN+odO50am/JnkWc1n3ZWmfk65jXBs4VX1kbbjTLLT9wO0FlACCPKQnmBjcVqGX5g4jm5FJMTERlcpzJpSyqHO+No1M3DKyKdTJmbIUItGVqmqEEB3dbs6ZcsO8bWnbh6yxs0N3e7YmPsYUj2BsTqyX/2aTKDH3Qi5wYQxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQSf3PB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A7AC113CC;
	Fri, 12 Apr 2024 21:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712957656;
	bh=RPMZISUCpRH7rGFvp7EbdpEtkFygpiRP/bPV6ApwRUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQSf3PB42KVUAVL/1+OQDtLauoAha7gpWFLEfP7EkJZ7N4u8sjm1TXZET0lcr99if
	 p323/cwpgZUxDFoAN0LtJD/WtUmkAowRMfrHXs2ADEs+POp65FYXDmivZLLbSGNrbU
	 cK7psxBkc2pNWhws+T+BLn4rvwbGtErI3pKePtDRrrXtxg4SlAkty9qCRKwyAvaK4o
	 4J1TYby7DtMN0iDHmvtIaHgU/2W7PPaw1EGmkk8oxy7YqdZ0CGvX2zAsbQmuPAc1vv
	 Sybl6gdQ0nD7yXd8jpir5Kgy9dj6jXo2NV/g5uxXJoISW/2Z2e9/7qwwU4KNgSB4f8
	 bogQT43yfNq2A==
Date: Fri, 12 Apr 2024 22:34:10 +0100
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
Message-ID: <20240412-geranium-monotone-b47f414715d1@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-8-4af9815ec746@rivosinc.com>
 <20240412-dwarf-shower-5a7300fcd283@wendy>
 <ZhlypvTdsFPZBr08@ghost>
 <20240412-drab-french-55d8ff2c8cfa@spud>
 <ZhmhtLS5NuRrPOfu@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SiZFDomrOPZV4p3t"
Content-Disposition: inline
In-Reply-To: <ZhmhtLS5NuRrPOfu@ghost>


--SiZFDomrOPZV4p3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:03:48PM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 09:40:03PM +0100, Conor Dooley wrote:
> > On Fri, Apr 12, 2024 at 10:43:02AM -0700, Charlie Jenkins wrote:
> > > On Fri, Apr 12, 2024 at 12:49:57PM +0100, Conor Dooley wrote:
> > > > On Thu, Apr 11, 2024 at 09:11:14PM -0700, Charlie Jenkins wrote:
> > > > > Create vendor variants of the existing extension helpers. If the
> > > > > existing functions were instead modified to support vendor extens=
ions, a
> > > > > branch based on the ext value being greater than
> > > > > RISCV_ISA_VENDOR_EXT_BASE would have to be introduced. This addit=
ional
> > > > > branch would have an unnecessary performance impact.
> > > > >=20
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > >=20
> > > > I've not looked at the "main" patch in the series that adds all of =
the
> > > > probing and structures for representing this info yet beyond a curs=
ory
> > > > glance, but it feels like we're duplicating a bunch of infrastructu=
re
> > > > here before it is necessary. The IDs are all internal to Linux, so =
I'd
> > > > rather we kept everything in the same structure until we have more =
than
> > > > a handful of vendor extensions. With this patch (and the theadpmu s=
tuff)
> > > > we will have three vendor extensions which feels like a drop in the
> > > > bucket compared to the standard ones.
> > >=20
> > > It is not duplicating infrastructure. If we merge this into the exist=
ing
> > > infrastructure, we would be littering if (ext > RISCV_ISA_VENDOR_EXT_=
BASE)
> > > in __riscv_isa_extension_available. This is particularily important
> > > exactly because we have so few vendor extensions currently so this ch=
eck
> > > would be irrelevant in the vast majority of cases.
> >=20
> > That's only because of your implementation. The existing vendor extensi=
on
> > works fine without this littering. That's another thing actually, you
> > forgot to convert over the user we already have :)
>=20
> Oh right, I will convert them over. The fundemental goal of this patch
> is to allow a way for vendors to support their own extensions without
> needing to populate riscv_isa_ext. This is to create separation between
> vendors so they do not impact each other.

The one that needs converting is xandespmu. As I said on the other patch
a minute I don't think isolating vendors for the internal representation
is needed and can be left in hwprobe. I also don't think we can rely on
a behaviour of "SiFive CPUs will always have SiFive's mvendorid" or that
kinda thing, I've heard talk of the SoC vendor getting their mvendorid
for custom CPU cores instead of the CPU vendor and it's possible for
the SBI implementation to "adjust" the values also.

> xlinuxenvcfg does not fit into this scheme however. This scheme assumes
> that a hart cannot have multiple vendors which that extension breaks.
> xlinuxenvcfg is really filling a hole in the standard isa that is
> applicible to all vendors and does not appear in the device tree so it
> is okay for that to live outside this scheme.

Ye, xlinuxenvcfg is an internal psuedo-extension that should be treated
more like a standard one than something vendor.

> > > It is also unecessary to push off the refactoring until we have some
> > > "sufficient" amount of vendor extensions to deem changing the
> > > infrastructure when I already have the patch available here. This does
> > > not introduce any extra overhead to existing functions and will be ab=
le
> > > to support vendors into the future.
> >=20
> > Yeah, maybe that's true but this was my gut reaction before reading the
> > other patch in detail (which I've still yet to do).
>=20
> - Charlie
>=20

--SiZFDomrOPZV4p3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhmo0QAKCRB4tDGHoIJi
0sB2AP9FeUoact1liM4pnP8xEk+uEek2FyqTjYcZiaib0RlcGwD/RBzXv10rgGru
eAFY4Rmq36PhVYfHdF4UI+zCC4yTAgw=
=xSsQ
-----END PGP SIGNATURE-----

--SiZFDomrOPZV4p3t--

