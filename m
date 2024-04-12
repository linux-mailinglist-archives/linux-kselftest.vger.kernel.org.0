Return-Path: <linux-kselftest+bounces-7874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE548A37DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7981F23718
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 21:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765C152169;
	Fri, 12 Apr 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFOO2uHj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B855610B;
	Fri, 12 Apr 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957274; cv=none; b=Mj0qbA7a5T4FV6i+i2ax69dGFcFAkgGX+XKdAD3aDwMQ9SAHfPK7gO0HTJiopeqbm/eI5F5z7oP+K9/QN0smMR4ulicOx/AQw7a+HSBwmeqBYI9UwTjrm6kRs4sCyU9Q0uNbgq8RhqZ9AdhXjlEOam5UWO3eSEJeJtClZxZ7TkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957274; c=relaxed/simple;
	bh=SZAhNfEeVcww/X2691cfrbsEdjA/UK3hcGjsVOjFIt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHCGmQKcJddWIdoVx43/RZOOdf3nuTA2xFV8Y9XAzUuJExqYrE6+bsjUR1WCm2xM784xHB2yZzD1tUbQ9ipDoRydQnVZJGFx/b4+AwZvOXfYZwcpXb9hc7AUQz2wZn/MhvZDvdIcdAOa92O+OPm9sIZTPoJxDzi4KqtdASk2kes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFOO2uHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E3BC113CC;
	Fri, 12 Apr 2024 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712957273;
	bh=SZAhNfEeVcww/X2691cfrbsEdjA/UK3hcGjsVOjFIt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFOO2uHjBnbHrZBz78J7P32btxZfs0ikA8AuxaqnJqBW8OSR/DxBtnr8rpuok4JFa
	 zJ/KoGf0HhdDj1ljqUwky8wdpMZHR+lq2MGJdFW2pOmmKOlw4j1r0Nd7yzC/uL8/PF
	 dQhHuIMtgz3CWParOxHuzvSSfNzLaFru1u8twdA4MMN6pbDU/fVNKyz9Lt6INT8SQz
	 ausyPHgsii9hWFsky8F+bF2xhgIAUu5S4f4SxYZzgNA9mk48NapQ9ZdFY9k6E424Cw
	 lXtKecgYu39j/WT9O70i7gS7eSmFGw09nK/GSWSEdt71HkjYgo+dtOllSsOUWRY3tN
	 b12lpFLF86zow==
Date: Fri, 12 Apr 2024 22:27:47 +0100
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
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240412-chemist-haunt-0a30a8f280ca@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <ZhlrdGXfSushUNTp@ghost>
 <20240412-eastcoast-disparity-9c9e7d178df5@spud>
 <ZhmeLoPS+tsfqv1T@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ikEUv4YkPVdtqseT"
Content-Disposition: inline
In-Reply-To: <ZhmeLoPS+tsfqv1T@ghost>


--ikEUv4YkPVdtqseT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 01:48:46PM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 07:47:48PM +0100, Conor Dooley wrote:
> > On Fri, Apr 12, 2024 at 10:12:20AM -0700, Charlie Jenkins wrote:
> > > On Fri, Apr 12, 2024 at 11:25:47AM +0100, Conor Dooley wrote:
> > > > On Thu, Apr 11, 2024 at 09:11:08PM -0700, Charlie Jenkins wrote:
> > > > > The riscv_cpuinfo struct that contains mvendorid and marchid is n=
ot
> > > > > populated until all harts are booted which happens after the DT p=
arsing.
> > > > > Use the vendorid/archid values from the DT if available or assume=
 all
> > > > > harts have the same values as the boot hart as a fallback.
> > > > >=20
> > > > > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT prop=
erty on older T-Head CPUs")
> > > >=20
> > > > If this is our only use case for getting the mvendorid/marchid stuff
> > > > from dt, then I don't think we should add it. None of the devicetre=
es
> > > > that the commit you're fixing here addresses will have these proper=
ties
> > > > and if they did have them, they'd then also be new enough to hopefu=
lly
> > > > not have "v" either - the issue is they're using whatever crap the
> > > > vendor shipped.
> > >=20
> > > Yes, the DT those shipped with will not have the property in the DT so
> > > will fall back on the boot hart. The addition of the DT properties al=
low
> > > future heterogenous systems to be able to function.
> >=20
> > I think you've kinda missed the point about what the original code was
> > actually doing here. Really the kernel should not be doing validation of
> > the devicetree at all, but I was trying to avoid people shooting
> > themselves in the foot by doing something simple that would work for
> > their (incorrect) vendor dtbs.
> > Future heterogenous systems should be using riscv,isa-extensions, which
> > is totally unaffected by this codepath (and setting actual values for
> > mimpid/marchid too ideally!).
> >=20
>=20
> I am on the same page with you about that.=20
>=20
> > > > If we're gonna get the information from DT, we already have somethi=
ng
> > > > that we can look at to perform the disable as the cpu compatibles g=
ive
> > > > us enough information to make the decision.
> > > >=20
> > > > I also think that we could just cache the boot CPU's marchid/mvendo=
rid,
> > > > since we already have to look at it in riscv_fill_cpu_mfr_info(), a=
void
> > > > repeating these ecalls on all systems.
> > >=20
> > > Yeah that is a minor optimization that can I can apply.
> > >=20
> > > >=20
> > > > Perhaps for now we could just look at the boot CPU alone? To my
> > > > knowledge the systems that this targets all have homogeneous
> > > > marchid/mvendorid values of 0x0.
> > >=20
> > > They have an mvendorid of 0x5b7.
> >=20
> > That was a braino, clearly I should have typed "mimpid".
> >=20
> > > This is already falling back on the boot CPU, but that is not a solut=
ion
> > > that scales. Even though all systems currently have homogenous
> > > marchid/mvendorid I am hesitant to assert that all systems are
> > > homogenous without providing an option to override this.
> >=20
> > There are already is an option. Use the non-deprecated property in your
> > new system for describing what extesions you support. We don't need to
> > add any more properties (for now at least).
>=20
> The issue is that it is not possible to know which vendor extensions are
> associated with a vendor. That requires a global namespace where each
> extension can be looked up in a table. I have opted to have a
> vendor-specific namespace so that vendors don't have to worry about
> stepping on other vendor's toes (or the other way around). In order to
> support that, the vendorid of the hart needs to be known prior.

Nah, I think you're mixing up something like hwprobe and having
namespaces there with needing namespacing on the devicetree probing side
too. You don't need any vendor namespacing, it's perfectly fine (IMO)
for a vendor to implement someone else's extension and I think we should
allow probing any vendors extension on any CPU.

> I know a rebuttal here is that this is taking away from the point of
> the original patch. I can split this patch up if so. The goal here is to
> allow vendor extensions to play nicely with the rest of the system.
> There are two uses of the mvendorid DT value, this fix, and the patch
> that adds vendor extension support. I felt that it was applicable to
> wrap the mvendorid DT value into this patch, but if you would prefer
> that to live separate of this fix then that is fine too.
>=20
> - Charlie
>=20
> >=20
> > > The overhead is
> > > looking for a field in the DT which does not seem to be impactful eno=
ugh
> > > to prevent the addition of this option.
> > >=20
> > > >=20
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > >=20
> > > > > @@ -514,12 +521,23 @@ static void __init riscv_fill_hwcap_from_is=
a_string(unsigned long *isa2hwcap)
> > > > >  				pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> > > > >  				continue;
> > > > >  			}
> > > > > +			if (of_property_read_u64(node, "riscv,vendorid", &this_vendor=
id) < 0) {
> > > > > +				pr_warn("Unable to find \"riscv,vendorid\" devicetree entry,=
 using boot hart mvendorid instead\n");
> > > >=20
> > > > This should 100% not be a warning, it's not a required property in =
the
> > > > binding.
> > >=20
> > > Yes definitely, thank you.
> > >=20
> > > - Charlie
> > >=20
> > > >=20
> > > > Cheers,
> > > > Conor.
> > > >=20
> > > > > +				this_vendorid =3D boot_vendorid;
> > > > > +			}
> > > >=20
> > >=20
> > >=20
>=20
>=20

--ikEUv4YkPVdtqseT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhmnUwAKCRB4tDGHoIJi
0jigAQDfKVOtXBGsrZEzFFSHux1+TlSlG6+CUNstZFQgF4UZaAD9HgNuQ1aA632s
vNn9o7HLtTwwww5zo9cL2A5nvA4gWQY=
=tX/M
-----END PGP SIGNATURE-----

--ikEUv4YkPVdtqseT--

