Return-Path: <linux-kselftest+bounces-7864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727AC8A3651
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 21:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD48FB216D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A114F9F2;
	Fri, 12 Apr 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE1ZhfCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9714F9ED;
	Fri, 12 Apr 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949979; cv=none; b=KBSkRd1/EeNqTRfbHa434VaEO4nEJcU+GXrS9L5d4PYVt4o79IleJSUO1ho/USB0AriTwZQmR7kGUjAKQNFsCT73e18ZtNf2B7axXTVfRw2WRcS9a6kR3ccf7Qov+gNrQPLNSP8j6Ufcd2ZNRaGqb6AZ8F02faG+LycqsuFOZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949979; c=relaxed/simple;
	bh=ArpGHG9cuv9OtQt7jL/xNgqJB9MdPk3k7JUvanjZuic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4j1llD5C+4462x+yaOTMjojkyUvHHcnKuDeTDjb84KFs7OnjCfwvicTpbS/tAGBZt5H4OSi0ogMk1XvzIlnjm7ejTEek6gnoMVNs8Pn9T0VUWKI+5m/Q8ESuubpWfxRpbW0Tcu2UcQATL/K0Ch0dg61TzYQ+ttPGd44/bSoYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE1ZhfCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5419DC113CC;
	Fri, 12 Apr 2024 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712949978;
	bh=ArpGHG9cuv9OtQt7jL/xNgqJB9MdPk3k7JUvanjZuic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BE1ZhfCIepy+Sz+T2/94eePFkoOBa4Wa95SbkS2QeDMiyp12yVm5dxbXQ8DBAVn7e
	 zaEoB5oI8W25RYxz9nj1KmtQifkJbq6TcZaZvzr2BZLansHu9+OSr3iV9XFoQ9mehr
	 WDWWtMq8E1dfTt7HdTaOi9lb15ndfSLbPuCdFZmSZKfRDjjictfHUo2RWyRlm9K4E8
	 9JirdX8YiXS/iJ1fnkO5Y3Wi29otvkyu+i2+2rQtPRBfmq1njgVEabcy+rtzdw7f1H
	 vOZ2jbfP0fNsPzw0gK+ZL/PdQRjsoz8WjLOPnKbLLA9WO+GJBKQMbXROTtaPlEzejH
	 FKtr8IV7z/8qw==
Date: Fri, 12 Apr 2024 20:26:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Evan Green <evan@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240412-earmark-sanction-810b7222cae5@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <CALs-HsuMZOMpDh8kwQx6FE2mawzt+qTD-WZ6Mvhrt+hUhkZimg@mail.gmail.com>
 <20240412-employer-crier-c201704d22e3@spud>
 <ZhmBfaKXMMtolwSr@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tJyAzTWQiwGEEGv9"
Content-Disposition: inline
In-Reply-To: <ZhmBfaKXMMtolwSr@ghost>


--tJyAzTWQiwGEEGv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:46:21AM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 07:38:04PM +0100, Conor Dooley wrote:
> > On Fri, Apr 12, 2024 at 10:04:17AM -0700, Evan Green wrote:
> > > On Fri, Apr 12, 2024 at 3:26=E2=80=AFAM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > >
> > > > On Thu, Apr 11, 2024 at 09:11:08PM -0700, Charlie Jenkins wrote:
> > > > > The riscv_cpuinfo struct that contains mvendorid and marchid is n=
ot
> > > > > populated until all harts are booted which happens after the DT p=
arsing.
> > > > > Use the vendorid/archid values from the DT if available or assume=
 all
> > > > > harts have the same values as the boot hart as a fallback.
> > > > >
> > > > > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT prop=
erty on older T-Head CPUs")
> > > >
> > > > If this is our only use case for getting the mvendorid/marchid stuff
> > > > from dt, then I don't think we should add it. None of the devicetre=
es
> > > > that the commit you're fixing here addresses will have these proper=
ties
> > > > and if they did have them, they'd then also be new enough to hopefu=
lly
> > > > not have "v" either - the issue is they're using whatever crap the
> > > > vendor shipped.
> > > > If we're gonna get the information from DT, we already have somethi=
ng
> > > > that we can look at to perform the disable as the cpu compatibles g=
ive
> > > > us enough information to make the decision.
> > > >
> > > > I also think that we could just cache the boot CPU's marchid/mvendo=
rid,
> > > > since we already have to look at it in riscv_fill_cpu_mfr_info(), a=
void
> > > > repeating these ecalls on all systems.
> > > >
> > > > Perhaps for now we could just look at the boot CPU alone? To my
> > > > knowledge the systems that this targets all have homogeneous
> > > > marchid/mvendorid values of 0x0.
> > >=20
> > > It's possible I'm misinterpreting, but is the suggestion to apply the
> > > marchid/mvendorid we find on the boot CPU and assume it's the same on
> > > all other CPUs? Since we're reporting the marchid/mvendorid/mimpid to
> > > usermode in a per-hart way, it would be better IMO if we really do
> > > query marchid/mvendorid/mimpid on each hart. The problem with applying
> > > the boot CPU's value everywhere is if we're ever wrong in the future
> > > (ie that assumption doesn't hold on some machine), we'll only find out
> > > about it after the fact. Since we reported the wrong information to
> > > usermode via hwprobe, it'll be an ugly userspace ABI issue to clean
> > > up.
> >=20
> > You're misinterpreting, we do get the values on all individually as
> > they're brought online. This is only used by the code that throws a bone
> > to people with crappy vendor dtbs that put "v" in riscv,isa when they
> > support the unratified version.
>=20
> Not quite,

Remember that this patch stands in isolation and the justification given
in your commit message does not mention anything other than fixing my
broken patch.

> the alternatives are patched before the other cpus are
> booted, so the alternatives will have false positives resulting in
> broken kernels.

Over-eagerly disabling vector isn't going to break any kernels and
really should not break a behaving userspace either.
Under-eagerly disabling it (in a way that this approach could solve) is
only going to happen on a system where the boot hart has non-zero values
and claims support for v but a non-boot hart has zero values and
claims support for v but actually doesn't implement the ratified version.
If the boot hart doesn't support v, then we currently disable the
extension as only homogeneous stuff is supported by Linux. If the boot
hart claims support for "v" but doesn't actually implement the ratified
version neither the intent of my original patch nor this fix for it are
going to help avoid a broken kernel.

I think we do have a problem if the boot cpu having some erratum leads
to the kernel being patched in a way that does not work for the other
CPUs on the system, but I don't think this series addresses that sort of
issue at all as you'd be adding code to the pi section if you were fixing
it. I also don't think we should be making pre-emptive changes to the
errata patching code either to solve that sort of problem, until an SoC
shows up where things don't work.

Cheers,
Conor.

--tJyAzTWQiwGEEGv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhmK1AAKCRB4tDGHoIJi
0hziAP4j1liS/8H3/sGH37oV1Ie6vt982Lewk2FPT35h55TKRQEA/iypRsMhmnBH
35WadNZuyEtJ844XSGK0IM1bH0q7eAk=
=Lvox
-----END PGP SIGNATURE-----

--tJyAzTWQiwGEEGv9--

