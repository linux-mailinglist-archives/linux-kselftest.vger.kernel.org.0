Return-Path: <linux-kselftest+bounces-8783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712988B0E01
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A620AB2A6F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E815FA93;
	Wed, 24 Apr 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2AJakrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009415FA81;
	Wed, 24 Apr 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972072; cv=none; b=NYNsUA0jlKP7RjOIeQlmgk/kAVLVaHtsuGbO0hkS95PzmWFKPnxIoMKpFy5JYeGSUII/hSxpb+rez1s5sGumN27umtOinhFjOxsf9SiH6Y3XOXKEdFkgVt/YTTqsI2F6BYlcN9KSU28DAwN/8M9JZ3JsiQxQQrFs0MlEqCfEo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972072; c=relaxed/simple;
	bh=/l+aim4eVg3tD558UYuMgrS+4aCm5cbypDJqLdx1Ryo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uka7YQ905MykVcu3uSWyk9BQOvyIb853lraystCGowUb589dWsiuFokGaB6xgbPgtJAyzgL/Efz206/mDcNG8MFw1yUDKY5HuJfVFBBvNWbwc5kAkxryVUdlZOhhn5btQi3w38+2mrrh80f9YXnTz/PjDGb/bfWhnwSXi5nIsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2AJakrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47571C113CD;
	Wed, 24 Apr 2024 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972071;
	bh=/l+aim4eVg3tD558UYuMgrS+4aCm5cbypDJqLdx1Ryo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2AJakrRhQHhabOh9W1Vw+yqbESBngO0TMYtLJnyWOv19ax40paV12wwc6oj5/+BO
	 qlRJZXShH3g+SFh6RW0ypVY3Odj0hOV7KMOAsbC8Xeo2N63RyCfez+DYIpcKI60MxD
	 P2IqNhRaeyZq5E+AShy9ScmlGUfsFSagCh1u8gc28uOs7ftBm90e+R9aWF3QJiCrSh
	 m9cIHGmBp5UXh5d/nR6O2mhRdWn28PdwL3MSVlF3QBImuHxRPxfNUZDb9K1q8TNDPf
	 zuGg6RP0A+91LHr4NDr+Bk1b/QTHOQTfzJUSYb45m94KLqIlgDi1OfLYcYLSUMubFE
	 rMeaZRK3J2Pgw==
Date: Wed, 24 Apr 2024 16:21:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v3 06/17] riscv: Fix extension subset checking
Message-ID: <20240424-gondola-cosmic-b7a02b2a8619@spud>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-6-67cff4271d1d@rivosinc.com>
 <6c624361-a968-498b-a9fb-ea2aaec70ce8@ghiti.fr>
 <20240424-wildly-goofy-c81aac6f8cd7@spud>
 <ZikhpEgEoMX/rObu@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nD+3DKOIzzyPJcNe"
Content-Disposition: inline
In-Reply-To: <ZikhpEgEoMX/rObu@ghost>


--nD+3DKOIzzyPJcNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:13:40AM -0400, Charlie Jenkins wrote:
> On Wed, Apr 24, 2024 at 03:51:54PM +0100, Conor Dooley wrote:
> > On Wed, Apr 24, 2024 at 04:22:02PM +0200, Alexandre Ghiti wrote:
> > > Hi Charlie,
> > >=20
> > > On 21/04/2024 03:04, Charlie Jenkins wrote:
> > > > This loop is supposed to check if ext->subset_ext_ids[j] is valid, =
rather
> > > > than if ext->subset_ext_ids[i] is valid, before setting the extensi=
on
> > > > id ext->subset_ext_ids[j] in isainfo->isa.
> > > >=20
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar c=
rypto")
> > > > ---
> > > >   arch/riscv/kernel/cpufeature.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpu=
feature.c
> > > > index 48874aac4871..b537731cadef 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -609,7 +609,7 @@ static int __init riscv_fill_hwcap_from_ext_lis=
t(unsigned long *isa2hwcap)
> > > >   			if (ext->subset_ext_size) {
> > > >   				for (int j =3D 0; j < ext->subset_ext_size; j++) {
> > > > -					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
> > > > +					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
> > > >   						set_bit(ext->subset_ext_ids[j], isainfo->isa);
> > > >   				}
> > > >   			}
> > > >=20
> > >=20
> > > I think this should go into -fixes, let's check with Palmer if he wan=
ts to
> > > take this patch only or if you should send the patch on its own.
> >=20
> > I think splitting out this and patch 1 into a new series targeting fixes
> > would probably make things clearer?
>=20
> Okay I can do that. I will give it a bit more time before I send this
> series split into two to allow time for the rest of the patches to
> gather comments so I avoid sending too many duplicate patches.

Ye, I do hope to get back to this series later in the week when I have
time to actually read through all of the patches in detail.

However, you wouldn't have to resend both parts of the series - you can
just split out the fixes portion and send that, leaving the rest of the
series sitting on the list to gather comments.

--nD+3DKOIzzyPJcNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZikjYQAKCRB4tDGHoIJi
0vMQAP9maA50ULDUWJSbR/H0kPheLWbahRSLOt4mOCRfE2UuSwD/bKM2SV4XWfF6
LnzrLv6vAQLZ4EwZ5d4MDmnjwTGjMwU=
=ENki
-----END PGP SIGNATURE-----

--nD+3DKOIzzyPJcNe--

