Return-Path: <linux-kselftest+bounces-7867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E358A3718
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817AE1F231F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FDD199B8;
	Fri, 12 Apr 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MttpEfVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104ED21A0A;
	Fri, 12 Apr 2024 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954008; cv=none; b=mvN65wZuPSnWnyP+b/nCRVVm+QA7xN+s9G9vB9D+KzWmf2YEM8nbLWFLMTMhpOUHc4AENHVXYpe0Q4KmvLK+pkzkxtTF0PZZgrD6NhCMq+MmcUD+eGxSZvF/nAbkQR7Zf7iYph47wBe0Cihe1wUAe5IWrZNGXWnd8KQmMelHrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954008; c=relaxed/simple;
	bh=YQ2UKw4sariCXmZ/qJSMve/BQZtVmS5ZWlzN1dqap/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcR3/p9tSMhorQlM8Tia10LRTu3lZXX6ugEsTCev5kzrdiTudDuF03duIeTyE0p+gJExPwHC7JgVFNtUfrF9wjf4BwH/IFPiHa01eSyQuXcvccG3CKUooi+1UtU8iLKiw40bicArHt8CSpimoGv4sqneCpG7gvQN18+ejQrh+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MttpEfVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1358BC113CC;
	Fri, 12 Apr 2024 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712954007;
	bh=YQ2UKw4sariCXmZ/qJSMve/BQZtVmS5ZWlzN1dqap/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MttpEfVGcroBL6oEWqlTkdnkDxzRW5XoGbAKc5TKuHF+6y4aqdV5ucuP+AYZfTp8K
	 4ppufqNtlR5eecjFAluraMWcC+Qecd3oZyp0q1OMzyoicslfw+j42bn+Hb08wvM6D3
	 c1SxAEXs6qciuaK2Dap6U2O9no7Q8n3alWUbLY1kYhvvUkdJxIvfoYqilF9GH4H9dJ
	 AlA2X0ovSlEqhekqJrMx79EqMHop6E7f38aM/aMO1gDCpY4/K2sowDll/jprg7roXl
	 Fq/bZvY+TtrAy/phb4MYb4QstUD5UQeraxz5QuNsIj26skY0pPpO+lWBOaVEKjNrn5
	 EzJvEl8syoyZQ==
Date: Fri, 12 Apr 2024 21:33:20 +0100
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
Subject: Re: [PATCH 07/19] riscv: Optimize
 riscv_cpu_isa_extension_(un)likely()
Message-ID: <20240412-eccentric-prune-a19dfc485748@spud>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-7-4af9815ec746@rivosinc.com>
 <20240412-aerosol-heritage-cec1eca172fb@wendy>
 <ZhlwpKuqVkQCr6u+@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYt3sBPHBU50LMpH"
Content-Disposition: inline
In-Reply-To: <ZhlwpKuqVkQCr6u+@ghost>


--WYt3sBPHBU50LMpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 10:34:28AM -0700, Charlie Jenkins wrote:
> On Fri, Apr 12, 2024 at 11:40:38AM +0100, Conor Dooley wrote:
> > On Thu, Apr 11, 2024 at 09:11:13PM -0700, Charlie Jenkins wrote:
> > > When alternatives are disabled, riscv_cpu_isa_extension_(un)likely()
> > > checks if the current cpu supports the selected extension if not all
> > > cpus support the extension. It is sufficient to only check if the
> > > current cpu supports the extension.
> > >=20
> > > The alternatives code to handle if all cpus support an extension is
> > > factored out into a new function to support this.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> >=20
> > >  static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu=
, const unsigned long ext)
> > >  {
> > > -	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unl=
ikely(ext))
> > > -		return true;
> > > +	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
> > > +			   "ext must be < RISCV_ISA_EXT_MAX");
> > > =20
> > > -	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && __riscv_has_extension_u=
nlikely_alternatives(ext))
> > > +		return true;
> > > +	else
> > > +		return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > >  }
> >=20
> > static __always_inline bool riscv_cpu_has_extension_likely(int cpu, con=
st unsigned long ext)
> > {
> > 	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely=
(ext))
> > 		return true;
> >=20
> > 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
> > }
> >=20
> > This is the code as things stand. If alternatives are disabled, the if
> > statement becomes if (0 && foo) which will lead to the function call
> > getting constant folded away and all you end up with is the call to
> > __riscv_isa_extension_available(). Unless I am missing something, I don=
't
> > think this patch has any affect?
>=20
> Yeah I fumbled this one it appears. I got thrown off by the nested
> IS_ENABLED(CONFIG_RISCV_ALTERNATIVE). This patch eliminates the need for
> this and maybe can avoid avoid confusion in the future.

I think it just creates unneeded functions and can/should be dropped.

--WYt3sBPHBU50LMpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhmakAAKCRB4tDGHoIJi
0pbtAP9jkxR3+Jersf36JhdRHz+EJKoRwl2CgWp+9OK6jzrMcQEA+Nbu0mlIiEoV
Dsowm8jCIeypptYWv/zWVcIHHTzErgc=
=WYNo
-----END PGP SIGNATURE-----

--WYt3sBPHBU50LMpH--

