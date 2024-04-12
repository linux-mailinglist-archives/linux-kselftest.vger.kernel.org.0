Return-Path: <linux-kselftest+bounces-7856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898348A35DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEE81C235D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FC714F119;
	Fri, 12 Apr 2024 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqNKaNJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16BB14F10A;
	Fri, 12 Apr 2024 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947091; cv=none; b=GsE1x6v9u8m9SrxJSuxh4d557vYjmUq5+uGXhZEC/cm8cFOdaJfYd1/hyq72G6ACik8uLyb7dycu/1n3xr0gbJtRuS/S8CcSA+5ReknbU4LoQIudgrok+UwIn7E4o2Sc/LOsxOY7zMIr2nGxALEG2peYOTCfLOzXPrQ+2KqvhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947091; c=relaxed/simple;
	bh=F6zQv5ic7tyHfVnV+5BzE9fGTieop/gUlPWBQ1/NTQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfSxleR3b6sBM88Ik3b0iRLQyKdeSxlewjeFW01hKcqdmFeQGYghUox6A2oKEaHmT3OxS4qL3lylWLupm7OWJmfW3UyMn3NLzTq5LZ4Pt4//30FhsK6kwDHvgrXlCDzPeFU4C7+5YZAzqHWqB62Wpvl07+6B8zvhg0TMt5RYnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqNKaNJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E42C113CC;
	Fri, 12 Apr 2024 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712947091;
	bh=F6zQv5ic7tyHfVnV+5BzE9fGTieop/gUlPWBQ1/NTQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqNKaNJyrcbRforb/MYgMOxrEDl0SnFDz+UiLgKXR0VegcimDJL8+gNaAxjh9arLZ
	 j62nWhmhH0h7D1Bmhba/CnW9u/YGgTofj+BAjD10gL0TDJCs0f3Z1UujiCzKi6GAFk
	 YEK3dm5xQ8+PL2KeHe3w+isaK+CMqV7wVeCklahS/AVcxH4s+CpCV3GOFnMAoH1Gk8
	 IdV5QM/34y7EioeIdQiUM8Z/ntcFPAm3ef00weUono8+NlvVOID5lvimmTOKcm0lbr
	 FeG93C8vNVD9g4HsuYhpsnenlo3aCiD7XrPo4S8dV5SLWn3U3VoSz1oBTBARD9gD+j
	 IjG9UHOou+uXw==
Date: Fri, 12 Apr 2024 19:38:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Evan Green <evan@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
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
Message-ID: <20240412-employer-crier-c201704d22e3@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <CALs-HsuMZOMpDh8kwQx6FE2mawzt+qTD-WZ6Mvhrt+hUhkZimg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gRwXSR6OMoeFGriG"
Content-Disposition: inline
In-Reply-To: <CALs-HsuMZOMpDh8kwQx6FE2mawzt+qTD-WZ6Mvhrt+hUhkZimg@mail.gmail.com>


--gRwXSR6OMoeFGriG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 10:04:17AM -0700, Evan Green wrote:
> On Fri, Apr 12, 2024 at 3:26=E2=80=AFAM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 09:11:08PM -0700, Charlie Jenkins wrote:
> > > The riscv_cpuinfo struct that contains mvendorid and marchid is not
> > > populated until all harts are booted which happens after the DT parsi=
ng.
> > > Use the vendorid/archid values from the DT if available or assume all
> > > harts have the same values as the boot hart as a fallback.
> > >
> > > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property=
 on older T-Head CPUs")
> >
> > If this is our only use case for getting the mvendorid/marchid stuff
> > from dt, then I don't think we should add it. None of the devicetrees
> > that the commit you're fixing here addresses will have these properties
> > and if they did have them, they'd then also be new enough to hopefully
> > not have "v" either - the issue is they're using whatever crap the
> > vendor shipped.
> > If we're gonna get the information from DT, we already have something
> > that we can look at to perform the disable as the cpu compatibles give
> > us enough information to make the decision.
> >
> > I also think that we could just cache the boot CPU's marchid/mvendorid,
> > since we already have to look at it in riscv_fill_cpu_mfr_info(), avoid
> > repeating these ecalls on all systems.
> >
> > Perhaps for now we could just look at the boot CPU alone? To my
> > knowledge the systems that this targets all have homogeneous
> > marchid/mvendorid values of 0x0.
>=20
> It's possible I'm misinterpreting, but is the suggestion to apply the
> marchid/mvendorid we find on the boot CPU and assume it's the same on
> all other CPUs? Since we're reporting the marchid/mvendorid/mimpid to
> usermode in a per-hart way, it would be better IMO if we really do
> query marchid/mvendorid/mimpid on each hart. The problem with applying
> the boot CPU's value everywhere is if we're ever wrong in the future
> (ie that assumption doesn't hold on some machine), we'll only find out
> about it after the fact. Since we reported the wrong information to
> usermode via hwprobe, it'll be an ugly userspace ABI issue to clean
> up.

You're misinterpreting, we do get the values on all individually as
they're brought online. This is only used by the code that throws a bone
to people with crappy vendor dtbs that put "v" in riscv,isa when they
support the unratified version.

--gRwXSR6OMoeFGriG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhl/jAAKCRB4tDGHoIJi
0ptyAP0ZNjBpBCn7hL8p0/KqkB5iLRYcgUFzEfFnnLIR4Xu6bQEAnNsKHlMQNDHe
Gwr2lxxHHiZdULO9EWHcunPE1hXT4w4=
=sTMn
-----END PGP SIGNATURE-----

--gRwXSR6OMoeFGriG--

