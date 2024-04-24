Return-Path: <linux-kselftest+bounces-8779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE58B0D35
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01711F270D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFE515F409;
	Wed, 24 Apr 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otlWOyP+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760BE15EFB5;
	Wed, 24 Apr 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970321; cv=none; b=RXMBI8p4Ezzz2oxEgXPTDbMDwPPSekb6j/maHc5ecnwgtclLd/TWYFvRXv89x4LXAywkRBzXsBF1oNo31xnY2t4zWEDuF7k30uTkxE83U9R5t7UEnqkowlOrMBB1dSwLttAfzxjqSgiNTz3XCeoS86FJo6sChRlEICQkfLPidLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970321; c=relaxed/simple;
	bh=xPav91uI1ZNG9OJ6vetVcvDnMQMHSyXYAwBYPIfWJAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws3b4USsO36b7fAOEaymwozxMn7f9kfcjltrqCpuemefG7hXud47ecwLj256cgi72boCkUNwaiL298xeKZsYodwCATG9/Z+bWhS/IHA2BBTz2iFK5oIcEncM2/HKJDjnGr47CPzU332WfnSxptNoQ7YVZbhWNORSthABHUmbzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otlWOyP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF5C2BD10;
	Wed, 24 Apr 2024 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970321;
	bh=xPav91uI1ZNG9OJ6vetVcvDnMQMHSyXYAwBYPIfWJAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otlWOyP+tAKLOQY2jJz85UVBDjxfaJSShJb8fCwhde1QoWBVcXV9L8kOXZ7YiktDq
	 CRFb4dulN7XW95JUfM340CSKNKybZ2dJ/b22SsZmQHhpqofEEHEXAqU2wibXzCVcS4
	 HMfrS42NqBU81/dRPTkCtrvTtS8gTilQE5Db4nHV+I76fiYJBhDWN3DjU9kCwIeHh6
	 4jJBSNhlOmgAMqensikb4v8l+gbU3+tw7ozUQMwFHWkUnxOIf1FA6OpSCkGWp9J4rL
	 qB5hmqfwunYdSCmCdXGDOuwRopsL05J5I6EI7VnQPgdbplKA3I0ae1TvQI8BIOQKJG
	 eF4loR+GluPmg==
Date: Wed, 24 Apr 2024 15:51:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20240424-wildly-goofy-c81aac6f8cd7@spud>
References: <20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com>
 <20240420-dev-charlie-support_thead_vector_6_9-v3-6-67cff4271d1d@rivosinc.com>
 <6c624361-a968-498b-a9fb-ea2aaec70ce8@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ISCd5ZrJR7K6TsSY"
Content-Disposition: inline
In-Reply-To: <6c624361-a968-498b-a9fb-ea2aaec70ce8@ghiti.fr>


--ISCd5ZrJR7K6TsSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 04:22:02PM +0200, Alexandre Ghiti wrote:
> Hi Charlie,
>=20
> On 21/04/2024 03:04, Charlie Jenkins wrote:
> > This loop is supposed to check if ext->subset_ext_ids[j] is valid, rath=
er
> > than if ext->subset_ext_ids[i] is valid, before setting the extension
> > id ext->subset_ext_ids[j] in isainfo->isa.
> >=20
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypt=
o")
> > ---
> >   arch/riscv/kernel/cpufeature.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 48874aac4871..b537731cadef 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -609,7 +609,7 @@ static int __init riscv_fill_hwcap_from_ext_list(un=
signed long *isa2hwcap)
> >   			if (ext->subset_ext_size) {
> >   				for (int j =3D 0; j < ext->subset_ext_size; j++) {
> > -					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
> > +					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
> >   						set_bit(ext->subset_ext_ids[j], isainfo->isa);
> >   				}
> >   			}
> >=20
>=20
> I think this should go into -fixes, let's check with Palmer if he wants to
> take this patch only or if you should send the patch on its own.

I think splitting out this and patch 1 into a new series targeting fixes
would probably make things clearer?

--ISCd5ZrJR7K6TsSY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZikcigAKCRB4tDGHoIJi
0lY6AP9fxMZ4oOWAWRpbaYHs+Q77SeZ+QaOXEZh098c2I789WAEAmdgrmjjeEcJ4
b2LKa6uCXOLW9VEFR/QJlfNVN9MYwgU=
=Z23p
-----END PGP SIGNATURE-----

--ISCd5ZrJR7K6TsSY--

