Return-Path: <linux-kselftest+bounces-7704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF48A14DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A9F1F21FAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76E383B5;
	Thu, 11 Apr 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezO8dL3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE91EF1E;
	Thu, 11 Apr 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839489; cv=none; b=PmUTCE85VmDspho+Xx3GoSc4StO/nxJoWfDdo6tZnCmuPdtb2DXDmOzVVdYQDwt76xttaVPD0/hBlrdUVTuGni3y8qR5mEG5MFJJy+QozcM+yHwQ+RiEpRSMCvrdyopSZ1TgztKcONUKQ3Nic6at4tbw1YUAOaFzIyQEBo48qpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839489; c=relaxed/simple;
	bh=OQQRNWdkr4WaI4b7oKpsegOo4RWqi1dZNaSeFtlWVbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZkkm6yIIkhxAOjl3gw171MFQEvyVAT2w8eWp+2dWybdB4d4L4pOO0g2FcEarUSEv1oIRjQnxSjwODhOwWVM4Ru/jdNdiNCwh/HmYXUb2sLjX2ud9wMkSdZFHSO0IvkGnp2Do3Yk6yT+RJjBxHIMONhLMMQppTV+HgqT7CI83nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezO8dL3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A944DC433C7;
	Thu, 11 Apr 2024 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712839488;
	bh=OQQRNWdkr4WaI4b7oKpsegOo4RWqi1dZNaSeFtlWVbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezO8dL3L5bOW/ml2vbaGtawX/gEsCvPnqy/P65Zu/3kKzzDDV2uAojI3ROPJydran
	 9GLtNAEV56iMg6hYEGo+Kz8nWSm56YLsqfFg5PjuO1naq1POmwCOQPwLAmWS8izuD9
	 hxwgwVUGiHxPGLmdTKfnCt2YFgx7YB9KQhRgNUe8r68amk3jozUBOOMY8mk9mAbxRu
	 kDqpvZdcc2qANX/cONjTE9myBeD3pYF6g6wdXYwyTXQxnCWqo0Ur6ioR97JnMAmxvN
	 IuAqwTSsPqp1tKlQz1Kvem3pGLR/WlcmuoIYPpiH8G12OVYl0tKtFI9/I5z6VFtsaM
	 GyMeZQrQVLiWQ==
Date: Thu, 11 Apr 2024 13:44:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
Message-ID: <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
References: <87sf02bgez.ffs@tglx>
 <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eLEudqFzuEINegTy"
Content-Disposition: inline
In-Reply-To: <20240406150950.GA3060@redhat.com>
X-Cookie: Elliptic paraboloids for sale.


--eLEudqFzuEINegTy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2024 at 05:09:51PM +0200, Oleg Nesterov wrote:
> Thomas says:
>=20
> 	The signal distribution test has a tendency to hang for a long
> 	time as the signal delivery is not really evenly distributed. In
> 	fact it might never be distributed across all threads ever in
> 	the way it is written.
>=20
> To me even the
>=20
> 	This primarily tests that the kernel does not favour any one.

Further to my previous mail it's also broken the arm64 selftest builds,
they use kselftest.h with nolibc in order to test low level
functionality mainly used by libc implementations and nolibc doesn't
implement uname():

In file included from za-fork.c:12:
=2E./../kselftest.h:433:17: error: variable has incomplete type 'struct uts=
name'
        struct utsname info;
                       ^
=2E./../kselftest.h:433:9: note: forward declaration of 'struct utsname'
        struct utsname info;
               ^
=2E./../kselftest.h:435:6: error: call to undeclared function 'uname'; ISO =
C99 and later do not support implicit function declarations [-Wimplicit-fun=
ction-declaration]
        if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) =
!=3D 2)
            ^
=2E./../kselftest.h:435:22: error: call to undeclared function 'sscanf'; IS=
O C99 and later do not support implicit function declarations [-Wimplicit-f=
unction-declaration]
        if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) =
!=3D 2)
                            ^
1 warning and 3 errors generated.

--eLEudqFzuEINegTy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYX2zoACgkQJNaLcl1U
h9BNsAf/SALLRc/9ZAS59tFpxQdRfvXtWqUNgZWj+IKbEwArKB6V0kOSkYeeFF5x
cIP8785Nor1UFY6gBKpNdXwyI1zCLIpX+RwrV2aFJ/DQlcnLfCXvYlPIJ4hVV3DM
LTDs6/MtMx7xXkbyfXRyw+Dy0JuoW7m5l982y1KGI8otoA+Ld/hgbnamNRfrIWd4
GTCAup3fO84OA892aV4hmGgPFHjRuXvCwHg2LLrkFiaGpn9Qz2iJkalIYimZQtuW
sXpV4urnzUybTmMXPRWhj7znL+5BYVPXO83ZtfSq6/jJ60Md5Tg36aazNXpo0H68
OCJR4L+iK4CHAj87DoDQkhVw2BRaUA==
=tp/A
-----END PGP SIGNATURE-----

--eLEudqFzuEINegTy--

