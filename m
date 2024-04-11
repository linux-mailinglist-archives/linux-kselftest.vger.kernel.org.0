Return-Path: <linux-kselftest+bounces-7703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C68A14D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF781C22567
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F11EB31;
	Thu, 11 Apr 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRFRu4LM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA11EA7D;
	Thu, 11 Apr 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839326; cv=none; b=g9FYIDgmX6aCD74LFnVX4NEMbQyksBXxS4/50KRcjrz6VG0jM23rAEgzYFB7HTNnvegK+gVRGCmmtKwjISskZTeEWZ4XKIdWp3uessBFG6M50yUjDo8mjKbxZUc305IYKVsyiXU5dysr1ufg69sRd+m0qxh06j9E1v2saWo3Kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839326; c=relaxed/simple;
	bh=PxTp+fmSvnK/+mwcHlID3Kvo0O7S7lNkjkYYM7rv7bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvoKlfTcGYkwPx4J/i5Q5EaD9KLUql24/qHX8Nhfy6MesOQ2YMTjJnJkh8MXZjIAYR3AxlhC6LV35j4tRfsErtuCOjAMsNcBoA9hcBJb72IPg0Bdgo8kgWq7mhn70oMCNLY3DhQWYTQJJOmQ+ja60vGfUym2yg/LhO1MRddZl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRFRu4LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9039C433C7;
	Thu, 11 Apr 2024 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712839326;
	bh=PxTp+fmSvnK/+mwcHlID3Kvo0O7S7lNkjkYYM7rv7bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRFRu4LMSAcDcIV/Zn5qo6j1KR0AjcaZC/E48Yv2LdLv1JLDJgIA6CPMmCC2B9WVK
	 +JxX1LFJOG9lf53HU44Dp+VCqoGW+9nmp50VUY49aTi+IzSRtstEvaoxLSpR0AswgF
	 Bp7+m/bhrpFE9IfpPs8OO2JrRFlKUswlN/Q6cDB+a6mtfQcbuqZgRAiO0H4KAO+MGh
	 h1nvrkubyJ/Dqd0jOCAa8Rk7ZcSC8O6X/lfdLEhDvKUHWI7DfoFs/HJ1Me+erh7uKO
	 8700e1u7b0Eod5ljxJT/+2QN6mpalo9oqWw8fMzIA2ATMD6mdCYlTOx37Cy+Jyt2ry
	 i324Or5q88Jjg==
Date: Thu, 11 Apr 2024 13:41:59 +0100
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
Message-ID: <a9a4a964-6f0c-43a5-9fa8-10926d74fbf1@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="dyKDlGTPSGYPjOVd"
Content-Disposition: inline
In-Reply-To: <20240406150950.GA3060@redhat.com>
X-Cookie: Elliptic paraboloids for sale.


--dyKDlGTPSGYPjOVd
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
>=20
> comment doesn't look right. The kernel does favour a thread which hits
> the timer interrupt when CLOCK_PROCESS_CPUTIME_ID expires.
>=20
> The new version simply checks that the group leader sleeping in join()
> never receives SIGALRM, cpu_timer_fire() should always send the signal
> to the thread which burns cpu.
>=20
> Without the commit bcb7ee79029d ("posix-timers: Prefer delivery of signals
> to the current thread") the test-case fails immediately, the very 1st tick
> wakes the leader up. Otherwise it quickly succeeds after 100 ticks.

This has landed in -next and is causing warning spam throughout
kselftest when built with clang:

/home/broonie/git/bisect/tools/testing/selftests/kselftest.h:435:6: warning=
: variable 'major' is used uninitialized whenever '||' condition is true [-=
Wsometimes-uninitialized]
        if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) =
!=3D 2)
            ^~~~~~~~~~~~
/home/broonie/git/bisect/tools/testing/selftests/kselftest.h:438:9: note: u=
ninitialized use occurs here
        return major > min_major || (major =3D=3D min_major && minor >=3D m=
in_minor);
               ^~~~~
/home/broonie/git/bisect/tools/testing/selftests/kselftest.h:435:6: note: r=
emove the '||' if its condition is always false
        if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) =
!=3D 2)
            ^~~~~~~~~~~~~~~
/home/broonie/git/bisect/tools/testing/selftests/kselftest.h:432:20: note: =
initialize the variable 'major' to silence this warning
        unsigned int major, minor;
                          ^
                           =3D 0

--dyKDlGTPSGYPjOVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYX2pcACgkQJNaLcl1U
h9BWSAf8Ce2hIytHCkF6x1UmNuIwLSR+DyWc98yv65Jm8C0/yq8fOxHApvkBkoJD
TPfPTSw/my83GMGiSkXAyoMcRuK6C5MS6Nnr74SPv8y6sweoXDEr2lQ8MSr3m08e
HSE21HDCyG/zXhs00vukeR55ffNA7VGDB3BFoogyVDtILTpYgjz5xoJeFCyRQ6Kn
P/QpL4Ig57dAWqYfCk3ya6OFpwNN2GFeBV6OL8Lmxa4EXXHqJY0S9Zkn8Rg9oISf
qisPgNrW2RZ9xGHlRKAw4/g2Rqu5NHSUXQ3zhf7nK3m34MU2CccG2400FyF/X9u3
JO2v7g6vTGB3SDPcCJhahFtF76LMgA==
=8Eym
-----END PGP SIGNATURE-----

--dyKDlGTPSGYPjOVd--

