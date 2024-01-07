Return-Path: <linux-kselftest+bounces-2693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329708264BD
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFA81C20B8F
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A72134C6;
	Sun,  7 Jan 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8uWbhNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606C13FED;
	Sun,  7 Jan 2024 15:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF43C433C7;
	Sun,  7 Jan 2024 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704641436;
	bh=HkgKor4eVzCLnt7wJJ+kbZqp3bzXmOy8cKp6UmMngIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8uWbhNfFGRnFTX5/wxxE05wOu2DYDAzUyZOjt7JPD6yv9fJV1+1KGh8AS3Zupsh1
	 8cuTolU1C/RQBztnL6HyRFl7T7aMAF5sKqkxLY50w1S0gK1JvGIr2/s5knOnN1yBy/
	 jqUoLFsyodX1M9RXQn1aHjcE3ESsV3/LKIJH40mgB7kdIIuXe7Ne2E7Z3ngltq+Sm+
	 GiiCqLU5KPze7qxNU2ukbH1sw9tn6DT1iyl6QZ1ncMfJZ/pAAvjSeZoROu1ZC8t3+6
	 kwYz8/drTKT1SAzKGkTL0IhtbieNhTcx0cDR78m58bHW3R2V4WVBzqk5E9udPDeaTa
	 QKtfkoK02SWVw==
Date: Sun, 7 Jan 2024 15:30:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 2/4] kselftest: alsa: Fix the printf format specifier
 in call to ksft_print_msg()
Message-ID: <ZZrDmUsMvGy+Mld1@finisterre.sirena.org.uk>
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
 <20240107151218.933806-3-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+dy7+qB+kEXbWci0"
Content-Disposition: inline
In-Reply-To: <20240107151218.933806-3-mirsad.todorovac@alu.unizg.hr>
X-Cookie: You might have mail.


--+dy7+qB+kEXbWci0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 04:12:18PM +0100, Mirsad Todorovac wrote:
> The GCC 13.2.0 compiler issued the following warning:
>=20
> mixer-test.c: In function =E2=80=98ctl_value_index_valid=E2=80=99:
> mixer-test.c:322:79: warning: format =E2=80=98%lld=E2=80=99 expects argum=
ent of type =E2=80=98long long int=E2=80=99, \

Acked-by: Mark Brown <broonie@kernel.org>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--+dy7+qB+kEXbWci0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWaw5gACgkQJNaLcl1U
h9B9bAf+M9h6ZPAfDhv/yX5n/ZoeGnIEnfAab0IJx+CXNQiu+WD5zvnpPeYxGyig
EZzIFbV1XYLTvFN8dyRuO8tTpncU/iic74MEorbsLNoRU+Uxx2srhAqrp5DX0Wsl
k7J3ohpye+OczzRjupUm4GwOD1timRgdYL6gt56YpmtQezJP2UU+FSEIzhAFH2vw
eEtByOeTugi32DT7mKakIaB7u7UEQd3zAoLudS1l7rVPn1lbB4FU39p+St/d6bPQ
zIRQ6yj41n0xXx/RcHCZAVIQOS54TuwhjRYXZbvA7hSBCayZZJq6DsI1KChe35rc
RH6cITdbCvk7djrDegPo5fRXbFnMkQ==
=yPV5
-----END PGP SIGNATURE-----

--+dy7+qB+kEXbWci0--

