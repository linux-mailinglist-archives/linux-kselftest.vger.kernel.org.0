Return-Path: <linux-kselftest+bounces-7915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A238A4101
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 09:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8A7B20CDE
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E091208A8;
	Sun, 14 Apr 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsmLywl4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6A1B95A;
	Sun, 14 Apr 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713080564; cv=none; b=BOle6LmIyCN1pG3Z0rOlp/Qt2Fzt15tZ44bcjzbUpv2C4i4KJ99kMsygcBUl/06oLs5B02//r7DHOqACMZs1jlCH5H5F+xVL5v12IXLPOC4uYz+bfZZ3akFXOEgZ0qKaI1rF0eQEByeDxTLKot7K/YGcQfzVJp/ih4Y3SoDR/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713080564; c=relaxed/simple;
	bh=6ykjIOAiBTxAiHLB66C2NCpr8txrh6E+cO0uOmmMD4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQASohzEwMhp069T7T2fo3BHoTHRJbkJWtVFiVo94R6EfzEW9SUzJt35uOWpDb4YAUXIgCr3seUlJ5JJKIl0D1nKKkL/pcfgs65YT5rOB8C0J5N4cVnU6eIOSAiGM+AzXFwZYTmlloBArNahbdm5U4Ahn3+LmfiuuqnPYHHUX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsmLywl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB96CC072AA;
	Sun, 14 Apr 2024 07:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713080564;
	bh=6ykjIOAiBTxAiHLB66C2NCpr8txrh6E+cO0uOmmMD4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsmLywl4iNGNTHtupw2OuDIiGfTyBkJ5uvaHX4sOTTqDSdplEUtw0indT1FmDqTOX
	 Uu8QwmdLfL75QuRUzpyyLwQed/6l6XHGBxZCFbYURYZkuIHNwL5f4ibQaC3kmV889m
	 vCwfNMFWLBzzHfMGVyEUKt0g6t3azcILi72V5OcPcfTJswR7YHULYKsaQQf0nV3Nin
	 Jd3KODzja7A4SLRwaJPdcZDetlenDlbiPC1Ay+wEOz77W2ZlZF2iWiTJ2Kucs67Z6a
	 /8/Yq9grG3+kR83s4LaAeJWdDOvwhT0IngSJVkpcLWwJvEksY8Qo8OhMQRgdMEUH7P
	 IZH6NtISNZ9mA==
Date: Sun, 14 Apr 2024 16:42:37 +0900
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
Subject: Re: [PATCH] selftests: fix build failure with NOLIBC
Message-ID: <ZhuI7TRZ111I3mBU@finisterre.sirena.org.uk>
References: <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
 <20240412123536.GA32444@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RDirHntfewS0PWXo"
Content-Disposition: inline
In-Reply-To: <20240412123536.GA32444@redhat.com>
X-Cookie: You might have mail.


--RDirHntfewS0PWXo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:35:36PM +0200, Oleg Nesterov wrote:
> As Mark explains ksft_min_kernel_version() can't be compiled with nolibc,
> it doesn't implement uname().
>=20
> Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_ti=
mer_distribution()")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/f0523b3a-ea08-4615-b0fb-5b504a2d39df@=
sirena.org.uk/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Makes sense to me given that there's not likely to be any immediate
users.

Reviewed-by: Mark Brown <broonie@kernel.org>

--RDirHntfewS0PWXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYbiOoACgkQJNaLcl1U
h9DjfAf+NeKWvpY1kfNztkGXC5XgmSPRN72mmjwoz5S5ADSj6eACj6FVUx8dMLmx
MboAtU5eBumh83kzmDd64LH3zoNrC47WBOgPc8DNJ+Rojo+M1+9wA1EnC0qbPQyT
0H4LAFT2+/erlxSCrXcI/ValOLvD7+OOlEpObFMbFzyCT3cLQhQe/7o1gkjvArBC
Y39UmP6cvV69IhQ0VRg2F+xvOZTBrD4h2THuRwD6FXnMt/kYfcKpFO0BeB+XvbvV
r+7KTIQ8fkxw19JNuwSpzOM7M1Y9gJcsyN+bIZf1ctwOullXzAv2hh1IruVehXfA
Ey2qL/O9t3pwtZT3MddpQbx8KoJpAg==
=MeqW
-----END PGP SIGNATURE-----

--RDirHntfewS0PWXo--

