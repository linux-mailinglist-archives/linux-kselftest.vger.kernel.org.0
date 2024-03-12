Return-Path: <linux-kselftest+bounces-6258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D428796A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DFEB2470C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229C7AE72;
	Tue, 12 Mar 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aukJ/eNk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CECD1DFD8;
	Tue, 12 Mar 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254666; cv=none; b=Zqg7t7CxhbdV6Z3QkrgZ7qaR+eKaS49T3A/gBuDvumvR8PpbGE91DgaWqzKN0RadjS46a/oK4jFyejs+jmGPeGhcwuII/2k5Xn98ScTvWobrAcN+VxoGzl3yZcgmiiPtsJNlBWWhinkoisIKOQ5E3j8I59KYIcVI850tU0SmlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254666; c=relaxed/simple;
	bh=Dy35dwPt2qxF2qUUrlFwaycsRiwdy9dn4pHsT5ZLSGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIaUPFdeapmKPx6WA4JrRXEXNB++Ndsga5Cu2CqmLHFoG1mx693F15FhyHgp6zyra3ENCM9dJdshIqFpxuAJnKVi6HBBZNFBX8g2EEZ6BegcEqbnoGv98RwmMtk3UpfnYzcea0AB16kLsRSvz/ptav9Hdj5z3woPE+vVN57u710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aukJ/eNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E7C433C7;
	Tue, 12 Mar 2024 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254666;
	bh=Dy35dwPt2qxF2qUUrlFwaycsRiwdy9dn4pHsT5ZLSGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aukJ/eNkN+YxIpLAdDkVRaOAwmdrbNrNZgs82sjROJOwJ1cRhWzZAp3hKMU0o6by+
	 ClTlHTyUvbdjvyY4/G74hRToq/cZ9BrgDhaB+HPsKPBThz5V0mnvS4Q4WgBQvcptpR
	 04z6b6XP7us+6me/XmilaA8rQnRctidem5GuYEJRvHPnybkiiNXO4JEYbRUM4OiaPY
	 UFJRlCI98zvgAzsZLe3qUDx3DzX1Q/Ugn7gqlwF7kxh6x+dvQaqjTZDbJmQj3umXD3
	 1PXAX/9vH+gF3+GRdcEgLVCtkdJFbDDShjF9MVbGV0IHrKEFATopahqSygkBb4KvY3
	 s3KPe9CIlkidg==
Date: Tue, 12 Mar 2024 14:44:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	"Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
Message-ID: <e83b606a-e34e-423f-b26b-df745052d06b@sirena.org.uk>
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
 <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A8PYQDEZ5U6Pm1op"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
X-Cookie: Oh, so there you are!


--A8PYQDEZ5U6Pm1op
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 03:41:32PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 21, 2024 at 3:06=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:

>     static int __init regulator_init_complete(void)
>     {
>             /*
>              * Since DT doesn't provide an idiomatic mechanism for
>              * enabling full constraints and since it's much more natural
>              * with DT to provide them just assume that a DT enabled
>              * system has full constraints.
>              */
>             if (of_have_populated_dt())
>                     has_full_constraints =3D true;
>=20
>             ...
>     }
>     late_initcall_sync(regulator_init_complete);

> (The latter looks a bit futile, as have_full_constraints() already
>  contains a check for of_have_populated_dt()?)

Yes, it's duplicated and we should remove it.

--A8PYQDEZ5U6Pm1op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwakIACgkQJNaLcl1U
h9A8ewf+MxFaGvrtn8DK977EqCU2BEx8094DvO7eMo0nyAJUm2gxwqKrhgdxDEFY
I0g6tj4LKJmyrLH4jH1T84U85aVm9il1PX4OUNyIHtHqrTvZuxonx1hbMfHWnq4d
varya5+YeCMfo3B8heD4RSSmX4ewG6Jgb+IeDl/Jn8On2Pys75Sh1Bk8mbbunG+H
pOK8gTFj5jOaR6JoX/gsoYsifocZ0s96AqUqmk+i7zxdX6qJhGDaD7azW/qhJAUv
+E/x/KzOuerVx8mX2drUIR9jk/s1+t3mgTJZKAYoGUDW2PwG9wPb8tqtofX2ghXU
ZgSshLDLKjTalXEyonUkGEadKnNxmA==
=/ZcU
-----END PGP SIGNATURE-----

--A8PYQDEZ5U6Pm1op--

