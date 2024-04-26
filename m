Return-Path: <linux-kselftest+bounces-8943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E278B40E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 22:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9668D1F22D8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FE29413;
	Fri, 26 Apr 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdP/+3Ja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAD11181;
	Fri, 26 Apr 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163860; cv=none; b=Yudp/IRRWewUMzUeWkB+6U3EL78+kpYZ6QPC/21ZBm0P8AK4X/y3+tIpzUbBzsbPbJNrHIl14TzHUSYWYtEuUGNVYFew11MLBSTyHkul20xz+a/d7nGHgm5oYfCD/hUTQkhQXLgXYK9uTJ0He1Bbj6MT63DEK7XBSEfKtyaLfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163860; c=relaxed/simple;
	bh=uPLxJVI4MBITKFrKzxGui7Nb96vhOwcYwnCPWnkGezo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPh1HlcILifU88NHbUSbrMCzw7+enVLbiyYqDylMTwvLHSurR/ffevo1EbLm5vHt6ZJyIiaBa+D7As1QggVPOuVf1/UtkjeDuL6wgpRkSdQ+789nitWQf/gXYv4mLb58dlmPxRgLQdZXux7GiHm8jfEWZhri9RkMgckNmLJUu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdP/+3Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE17C113CD;
	Fri, 26 Apr 2024 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714163860;
	bh=uPLxJVI4MBITKFrKzxGui7Nb96vhOwcYwnCPWnkGezo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdP/+3JaWnyFfeXTcEwDCT/0UVK9xvUpyYRChjz/YP2ukIknpPm5gg8HZI0MciSAb
	 R3IlpxmFEjp7qVPox5VmAfGLxhU/PgnyWa+j9gpaQ8nhQ/75nh8tiSO6wsIJiwWZfT
	 OkOAYc5q0dDbk4lpagTHNbYhhkobHUcUPfJhKbJ6Vs8mmIXvvuRWpWDhDRCc18EoZK
	 WaPaRL/ccOPpewVsXYy2x7uXzPQIY3616TLEOxf3ApHEhH0ZSktfHLBVKADtreRcuJ
	 MJpw5R8RlpqNhmgxFJOW3kYyo+ATPJ5+TGQSAaAWvTZRbShOWRLntvaCIfnGobUjzt
	 YY64xdgrPDC0A==
Date: Fri, 26 Apr 2024 21:37:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 08/17] riscv: Introduce vendor variants of extension
 helpers
Message-ID: <20240426-suitable-unsheathe-0c5f5851c891@spud>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-8-67cff4271d1d@rivosinc.com>
 <20240426-myself-crowbar-99dc0a080cd9@spud>
 <ZiwIBmlaDbYdmv8f@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X64VCS2z8liAY+RZ"
Content-Disposition: inline
In-Reply-To: <ZiwIBmlaDbYdmv8f@ghost>


--X64VCS2z8liAY+RZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 01:01:10PM -0700, Charlie Jenkins wrote:
> On Fri, Apr 26, 2024 at 05:19:59PM +0100, Conor Dooley wrote:
> > On Sat, Apr 20, 2024 at 06:04:40PM -0700, Charlie Jenkins wrote:
> > > @@ -163,6 +164,8 @@ void thead_errata_patch_func(struct alt_entry *be=
gin, struct alt_entry *end,
> > >  	for (alt =3D begin; alt < end; alt++) {
> > >  		if (alt->vendor_id !=3D THEAD_VENDOR_ID)
> > >  			continue;
> > > +		if (alt->patch_id >=3D RISCV_VENDOR_EXT_ALTERNATIVES_BASE)
> > > +			continue;
> >=20
> > >  		if (alt->patch_id >=3D ERRATA_THEAD_NUMBER)
> >=20
> > This number is 2, how does the patching actually work for vendor stuff
> > when the base is always greater than 2?
> >=20
>=20
> Patching is handled through the patcher at the end of cpufeature.c. The
> vendor_id field is set in the alternatives for errata and now also for
> vendor extensions. The vendor extension patching is all handled
> generically.
>=20
> This is distinguished by the patch_id being greater than
> RISCV_VENDOR_EXT_ALTERNATIVES_BASE, which should leave way more than
> enough room for errata ids. Since the code already checks if the
> patch_id is greater than the errata number, I can drop the
> "if (alt->patch_id >=3D RISCV_VENDOR_EXT_ALTERNATIVES_BASE)" check.

Ah, ye, I was being dumb - I was somehow thinking that you were using
the errata patch function to patch this, which obviously wouldn't be a
good design. If that had been the case, you'd never patch anything, but
you patch the extensions using the cpufeature patch function so it all
works out.

If anything, I guess there could be an assert here somewhere that
enforces ERRATA_VENDOR_NUMBER < VENDOR_EXT_BASE.

--X64VCS2z8liAY+RZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiwQjQAKCRB4tDGHoIJi
0tMXAQC2Jy5XWBM1FWNAjh7ocF5y/z1Sjb/6AbsEoZ39m4Y8AAEA+Z85d2KbMCvL
2c+qY4x+XGFCBD5ZSMejeXfez3/DvAs=
=XikS
-----END PGP SIGNATURE-----

--X64VCS2z8liAY+RZ--

