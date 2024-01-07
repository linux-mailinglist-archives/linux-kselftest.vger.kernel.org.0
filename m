Return-Path: <linux-kselftest+bounces-2703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C31826588
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 19:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6531C20A43
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDE13FF5;
	Sun,  7 Jan 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPhVtzEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18613FE7;
	Sun,  7 Jan 2024 18:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBC1C433C8;
	Sun,  7 Jan 2024 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704651287;
	bh=D5Nom47ccMZ97QeLtyaOdTVnONRBDihub2rgb4f09og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPhVtzExBoCgx5NuC2ZbvarxZ/zJCcbZK3JJZFOzuEd1EjYISOZrFuppVVq1/amdR
	 n4tuzDLmnGFKLwa18If3m4HcRdVhfR9Gd3UpzYqGGObucyOTz5i3QWP+9u6LHAajRe
	 reuKOvNkfoEXG9QetuLmggbJPADJBYdsWgvNYLUjXow8cAMbR355XbR60++LuoOPXK
	 PC9g58QW8vWNqGCVg3v2UCoxGiILF+UtHatQRUmO/Ax2YqdyyGkFK/rdIM5Cxxzu0Q
	 F09orz7R7wmFRrEu0LEf9erUj5jDcAwI4z+MskYcAMJk5CQsBVxoPYJUKad5T82vUU
	 lGdnmzoMjEIHg==
Date: Sun, 7 Jan 2024 18:14:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 3/4] ksellftest: alsa: Fix the printf format specifier
 to unsigned int
Message-ID: <ZZrqE4iCRMqTX/3v@finisterre.sirena.org.uk>
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
 <20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr>
 <ZZrEXSU3Bx85rSGo@finisterre.sirena.org.uk>
 <34121d01-34dd-4c29-b31e-91f3e8ea15bc@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XCxdPNrpuVCVekfZ"
Content-Disposition: inline
In-Reply-To: <34121d01-34dd-4c29-b31e-91f3e8ea15bc@alu.unizg.hr>
X-Cookie: You might have mail.


--XCxdPNrpuVCVekfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 07, 2024 at 05:21:00PM +0100, Mirsad Todorovac wrote:

> I guess I can keep the Acked-by tags. Will the patchwork find the tag in
> the v1 patch set?

No, you need to include it.

--XCxdPNrpuVCVekfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWa6hMACgkQJNaLcl1U
h9DqiAf9H/lxmjuXFFoExRxTy9SeGZtlRitB+Mjw32/2JiK5kwlTJEiiyaqzTQQV
15hvrrGbDHWGGFy6TwMFAC7xK2C9ahvJeOOQNmt7F605eds03YVe+LqbonqamMCc
Txt48KAJhcv8SocP/OTJvLquz6ALoaeGU/Cb2Q7NkbzUHt/78jH1U7n4Q4UPSssq
1QOeEWsMAin4piwRPthM0/D33jawybLQDsWVaq1G85Y909dT/4nhQySRpgsZn1wS
1+y8y6xhK7x8WnXoLJgIXhV7Dwqraorbk68FYGjvUyG32giCyJLbE5Mu8r8iMvZF
MXQUzFUQNHYtE0OGgYD8/mMHRrxEOA==
=TwJb
-----END PGP SIGNATURE-----

--XCxdPNrpuVCVekfZ--

