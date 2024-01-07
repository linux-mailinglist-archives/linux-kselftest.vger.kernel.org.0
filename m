Return-Path: <linux-kselftest+bounces-2694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6298264C1
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EAC1C20D8F
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEFD134C6;
	Sun,  7 Jan 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj6aVDKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BA13AC3;
	Sun,  7 Jan 2024 15:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99930C433C8;
	Sun,  7 Jan 2024 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704641633;
	bh=uXq3aMV2PGcT8PQ61nObhq47B6rlF6lYCCII84WlvsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dj6aVDKsL+AvLdpcHsZ85qUGYRwoZmtPnd0KxMw37E3vZCLTlXIh9KA4skCN297R4
	 OjcHoxj4HpKRy0umxAv3CXPnier8kN5gpm7rbJ5zTrLA5tZcOGSdDVMr3K62NEUhUb
	 PV81wS+G7YEwe60JmcyIDli3nJlxFuu4mfpuG5Y2AcfdamGIHKdUP/Oz6LKXYU9Ynh
	 Lree3OZJxb39etSq+3jL03E1AAJkfpmdmROaQm28eyGjdm+VJqxsNULPE+8yN1zReT
	 tzTiajNlDRGwSvff/yRlQEPYNqB60cyTDhiilfG7BzX8oIDCoPi5ktNtCVPi581JYc
	 EOUqkCbkRy+6Q==
Date: Sun, 7 Jan 2024 15:33:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 3/4] ksellftest: alsa: Fix the printf format specifier
 to unsigned int
Message-ID: <ZZrEXSU3Bx85rSGo@finisterre.sirena.org.uk>
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
 <20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p9mm3phoO9jkv5GJ"
Content-Disposition: inline
In-Reply-To: <20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr>
X-Cookie: You might have mail.


--p9mm3phoO9jkv5GJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 04:12:20PM +0100, Mirsad Todorovac wrote:

> mixer-test.c:350:80: warning: format =E2=80=98%ld=E2=80=99 expects argume=
nt of type =E2=80=98long int=E2=80=99, \
> 			      but argument 5 has type =E2=80=98unsigned int=E2=80=99 [-Wformat=
=3D]

If this is the issue then...

> -			ksft_print_msg("%s.%d value %ld more than item count %ld\n",
> +			ksft_print_msg("%s.%d value %ld more than item count %d\n",
>  				       ctl->name, index, int_val,
>  				       snd_ctl_elem_info_get_items(ctl->info));

=2E..why are we not using an unsigned format specifier here?  I am very
suprised this doesn't continue to warn.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--p9mm3phoO9jkv5GJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWaxF0ACgkQJNaLcl1U
h9CdNQf/eSp1ZBFqDqiG3/RzhWZq0q6Cxi19N7gfrqosUu9wmJszlaYOwjkl7NIS
bM5J3aQTUHrl14v/kctmvg9YokFIRRIY95EJq/4nVrx8CWHeylXMhw8LVuBjaJu1
Dm0WBl//R/lKeiqICnld9WI8xiLJ9bqNDZAGQzJSKbtsHXaB+iIE0nDL4KVniz4t
C7tLJDBRnFS+i9cCGQPGq278lt0Ne4YBg+bU9lCQhCunaS8YvF4qas1w/0wYapTq
Kezrn28qcEYZo2cEv/hW3dUpJCSnkTRCYrVNP18M4bWv7zbjEU4K5zuS/PRtZhU9
/mvxxSeGKCXHJvWlZRoObfbh5uK91g==
=SaVm
-----END PGP SIGNATURE-----

--p9mm3phoO9jkv5GJ--

