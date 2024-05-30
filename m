Return-Path: <linux-kselftest+bounces-10967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD28D54E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44A528687C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845517E453;
	Thu, 30 May 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZQ4mxtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94B1F947;
	Thu, 30 May 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717106110; cv=none; b=UAQg7JyL5R1sf0y3+1bN8vaHBtZDGGZjcAmY17cGXD5wVHCA3Vku44i6Pf2Ic0dkFg0CRvTGbtnVxcPvzYTnToLeto2vbvhitvncZcfTm/wvLsic/CEZ2FrNxkYLApYZzm/PviteaJPD+h8q2u2FktOFuTMg6HtuXxoeYbuTBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717106110; c=relaxed/simple;
	bh=/VfaV/85ip1/Lj37F3db092taXFOC4P5Olaax8eSKGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK5PSkgJXNyq4oItEe3JlvGil6Gh4lW1w8mJXEH2tZVoWRisRPlA+d9KGy1PlMazf8UF8vGRAu7OrPcQbcqMqwwTztH7R+Skv0Bz99HQledrTM4/FGoByq5glxusuq0EGfX+iWBCrZ0P5ypamj1jKOenUsGvubzADNEFx19dhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZQ4mxtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9753CC2BBFC;
	Thu, 30 May 2024 21:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717106109;
	bh=/VfaV/85ip1/Lj37F3db092taXFOC4P5Olaax8eSKGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZQ4mxtPBvXvCeNYWUR960jdhWfNHrKSc6bPcA7sMKru1eZHTHDJKG3aKjH6LKfRq
	 BZDEpq8uhdWWPRDT1eD7klYULUHB4lKNmmn32sNNNF00rPzBYMPrCo9UO0EZKwqVNR
	 C7YrmeptnX5uuJD1i6wlO7W5l6P08k8ii8xOwC8Q/SfjdnSrxqt2fJjgtmtzmHcjO4
	 gmHytnkZ3BygZJQM+iLZdI3X19qMira65xrhpnNU1o+1bQRaPII/3npFey5IGcZWg5
	 fTcHGst5oHyNEcR897cFnzW+SF8JIF/wCALlcQB3qQMIusaYlEao9vDCA81l6iQzpG
	 8MbaiarDzZidg==
Date: Thu, 30 May 2024 22:55:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: andy.chiu@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
	aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>, guoren@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
	Evan Green <evan@rivosinc.com>, cleger@rivosinc.com,
	shuah@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, vincent.chen@sifive.com,
	greentime.hu@sifive.com, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 6/8] riscv: hwprobe: add zve Vector subextensions into
 hwprobe interface
Message-ID: <20240530-daylong-pelican-74ccadb9811f@spud>
References: <20240510-zve-detection-v5-6-0711bdd26c12@sifive.com>
 <mhng-0679629d-d115-44ae-a33a-bf42980c7686@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54amDOCv5zaovVhC"
Content-Disposition: inline
In-Reply-To: <mhng-0679629d-d115-44ae-a33a-bf42980c7686@palmer-ri-x1c9a>


--54amDOCv5zaovVhC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 02:35:51PM -0700, Palmer Dabbelt wrote:
> On Thu, 09 May 2024 09:26:56 PDT (-0700), andy.chiu@sifive.com wrote:
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index 969ef3d59dbe..35390b4a5a17 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -114,6 +114,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe =
*pair,
> >  		EXT_KEY(ZIHINTPAUSE);
> >=20
> >  		if (has_vector()) {
> > +			EXT_KEY(ZVE32X);
> > +			EXT_KEY(ZVE32F);
> > +			EXT_KEY(ZVE64X);
> > +			EXT_KEY(ZVE64F);
> > +			EXT_KEY(ZVE64D);
> >  			EXT_KEY(ZVBB);
> >  			EXT_KEY(ZVBC);
> >  			EXT_KEY(ZVKB);
>=20
> Conor left a comment over here <https://lore.kernel.org/all/20240510-zve-=
detection-v5-6-0711bdd26c12@sifive.com/>.

This link is to the patch you're replying to, not anything from me.
I commented on a bunch of stuff in v4, but not this patch - generally I
ignore hwprobe to be honest...

> I think the best bet is to just merge this v5 on for-next now, though --
> there's a bunch of patch sets touching ISA string parsing and IIUC that
> sub-extension parsing stuff is a pre-existing issue, and Clement's patch =
set
> still has some outstanding feedback to address.
>=20
> So I think if we just go with this we're not regressing anything, we just
> have a bit more to clean up.  Maybe it's a little uglier now that userspa=
ce
> can see the sub-extensions, but I'd bet wacky ISA strings will be able to
> confuse us for a while.

I wanna do some cleanup stuff w/ Clements series applied, if that's what
you were talking about, but I don't see much point starting that until
the cpufeature stuff has calmed down - Charlie's and Clement's series
really need to be in for-next for it to be worth doing.

> I staged this so I can throw it at the tester, LMK if anyone has issues
> otherwise it'll show up on for-next.

--54amDOCv5zaovVhC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlj1twAKCRB4tDGHoIJi
0m7+AQCuLCvXdrPloK2ge546WprTaktc5AJayKqwle2CbRg+qAEAimwmspM+d7gX
w2SCZjy28pKq6A7bDCxZ9Jlu+kWWdwM=
=N8Bg
-----END PGP SIGNATURE-----

--54amDOCv5zaovVhC--

