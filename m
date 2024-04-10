Return-Path: <linux-kselftest+bounces-7610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17748A034B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 00:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC21B22B7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 22:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD3190684;
	Wed, 10 Apr 2024 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3/uWsva"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005B19067B;
	Wed, 10 Apr 2024 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788042; cv=none; b=cWd27bifoLBg4ud9PC6AfEnX1hD2kjFOFnE6OkmFo7yLgVPvGed7m5FXKiwAn0F5UxUt7UIptatdDybNpePHPZBt/xbcQ5pn5SPdS6quO/zMCAHyINC3Dvp+tmIYH77CvxBV+zUW7enmS8hx15NTuEmCcFHo7K75lIAJuhVudrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788042; c=relaxed/simple;
	bh=MQwfwXM6s1UZx2FVelAfwabzd67L2NdfTcUOcwAkZa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHebwPvCRjy+POpLoVEgAV8eiE/m1fBN2dT2TbXF73oJCuRmikvdt39YdtgsVR0bt+Ga846GEBW42ePhXxA4rUhEakS7MA0oMMzqj5RIrimx5CI7eT43B3unyrrkspiOIPwBx0lcNe431bKGcRtV7vz/cAznC+0s6TN8REbEThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3/uWsva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E43C43390;
	Wed, 10 Apr 2024 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712788041;
	bh=MQwfwXM6s1UZx2FVelAfwabzd67L2NdfTcUOcwAkZa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3/uWsvaOVdQm4bUzZWXXVJh7Wz75OVPDbNxYG47HDWrUe4NRBf2haOzPZ5BTxLZr
	 ZC6IMZAHcrynGxHiYq3jz52i7ej0rN/aJYw+es916TUJ8W0q1hU18178W6RjIR7Mtr
	 u6w32lwy76uxqJ0KHElDXglXLwG3tqXyePsPawNR6jTQLG8NFyOdt+q8rcv9DkP0NC
	 70nM/T3v/QA686jfQLVrIuderjJhiu+MJatd+IiwAja72W6qHSskPMT3YKq/D1IARS
	 F5yGeIPYvce+43LFuqfCiuf0TdQJWhZrnNYilgUguhAsZx/mKtygsI+P7YAAlxXB7m
	 KCNX0t+Sb+ZIA==
Date: Wed, 10 Apr 2024 23:27:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/10] riscv: add ISA extension parsing for Zcmop
Message-ID: <20240410-judgingly-appease-5df493852b70@spud>
References: <20240410091106.749233-1-cleger@rivosinc.com>
 <20240410091106.749233-8-cleger@rivosinc.com>
 <ZhcFeVYUQJmBAKuv@debug.ba.rivosinc.com>
 <20240410-jawless-cavalry-a3eaf9c562a4@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UqyEiLRcLky9DwaJ"
Content-Disposition: inline
In-Reply-To: <20240410-jawless-cavalry-a3eaf9c562a4@spud>


--UqyEiLRcLky9DwaJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:16:11PM +0100, Conor Dooley wrote:
> On Wed, Apr 10, 2024 at 02:32:41PM -0700, Deepak Gupta wrote:
> > On Wed, Apr 10, 2024 at 11:11:00AM +0200, Cl=E9ment L=E9ger wrote:
> > > Add parsing for Zcmop ISA extension which was ratified in commit
> > > b854a709c00 ("Zcmop is ratified/1.0") of the riscv-isa-manual.
> > >=20
> > > Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> > > ---
> > > arch/riscv/include/asm/hwcap.h | 1 +
> > > arch/riscv/kernel/cpufeature.c | 1 +
> > > 2 files changed, 2 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/=
hwcap.h
> > > index b7551bad341b..cff7660de268 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -86,6 +86,7 @@
> > > #define RISCV_ISA_EXT_ZCB		77
> > > #define RISCV_ISA_EXT_ZCD		78
> > > #define RISCV_ISA_EXT_ZCF		79
> > > +#define RISCV_ISA_EXT_ZCMOP		80
> > >=20
> > > #define RISCV_ISA_EXT_XLINUXENVCFG	127
> > >=20
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 09dee071274d..f1450cd7231e 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -265,6 +265,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> > > 	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
> > > 	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
> > > 	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
> > > +	__RISCV_ISA_EXT_DATA(zcmop, RISCV_ISA_EXT_ZCMOP),
> >=20
> > As per spec zcmop is dependent on zca. So perhaps below ?
> >=20
> > __RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZCMOP, RISCV_ISA_EXT_ZCA)
>=20
> What's zicboz got to do with it, copy-pasto I guess?
> If we're gonna imply stuff like this though I think we need some
> comments explaining why it's okay.

Also, I'm inclined to call that out specifically in the binding, I've
not yet checked if dependencies actually work for elements of a string
array like the do for individual properties. I'll todo list that..

--UqyEiLRcLky9DwaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhcSRAAKCRB4tDGHoIJi
0q6sAP9ipmaLBEqGqnK1J/+foh06vDyH4IjZKsQzB4HnpE/08QD+LHYD03uimI1C
REPzlhiL3W105ct+G/bLuPwbDQsvHAM=
=29Jl
-----END PGP SIGNATURE-----

--UqyEiLRcLky9DwaJ--

