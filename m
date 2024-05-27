Return-Path: <linux-kselftest+bounces-10737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285238D0B42
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD631F222D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB052160784;
	Mon, 27 May 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR8/eFXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402215ECFF;
	Mon, 27 May 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836860; cv=none; b=IMDcq/mhGcFVz8qfbZ30txvMfhc2dmxV97w/+I6QylvHn2k9/2pdW9GbUOgnUR+Zyb69L6+FL+pQiqs58N0cbPppsYie5xDNsDY5Ocb8VUkSfPKCwv1OKwlMDrrwj4t6z64pKqH3xquML6dho0ay4Lj9kNss9PiWM0sHZAK6ZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836860; c=relaxed/simple;
	bh=UAEnHiSC1PDA0L1KaZk1ZNrZGkvGLhQGf5jxKFjBwLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQaDWe5U96cCE7w4v59chp4RHtgN7j/+97E+hWfXzvaXJJAUG5VmWRZkrgvxPs67SacGqQYqZh669DULYIthXQFpUmGuiGWGtR4hveqP7J7SB1EVnp/Q9gxrFmMffru7i0JB7PeJISkCuxtg2xadjOwBF9t1gNU8Ms7Qn7FmZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR8/eFXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88945C2BBFC;
	Mon, 27 May 2024 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716836860;
	bh=UAEnHiSC1PDA0L1KaZk1ZNrZGkvGLhQGf5jxKFjBwLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YR8/eFXJyUokyJhCKsd2N8o4+6s0N8UvrEamhTdSXomXPST5JbQJuI0vjaWwKbfMG
	 TQFDvUwj6aosaxDpYWID/W9VLyicSyy/AR7mDNOqBUwDn7A9n+VJcapdPBqvgKiUCt
	 SwHQgI/o4GM8wKMtY60ZTHA7nL67CNGIlT775YIObUHL8SuJmNKJ7tcxh6mXISzfqT
	 P+RCSYpRbP9SUVQdDMS1LPIDkgLePczld6jtCHhwgAaEIF0Ns9QYs91yNs4JpbLqZZ
	 zbnYpa7RLwzWN4VMVp+FOR7j9M7cIsAFMHEmQEHGMZ+rLmRc7pPt96Us6Li8njks94
	 o8dPHplm0FyPQ==
Date: Mon, 27 May 2024 20:07:31 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 04/10] selftests/harness: Fix interleaved scheduling
 leading to race conditions
Message-ID: <9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk>
References: <20240511171445.904356-1-mic@digikod.net>
 <20240511171445.904356-5-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwkg7Agk0Gg3e4Mx"
Content-Disposition: inline
In-Reply-To: <20240511171445.904356-5-mic@digikod.net>
X-Cookie: Teutonic:


--pwkg7Agk0Gg3e4Mx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 07:14:39PM +0200, Micka=EBl Sala=FCn wrote:

> Fix a race condition when running several FIXTURE_TEARDOWN() managing
> the same resource.  This fixes a race condition in the Landlock file
> system tests when creating or unmounting the same directory.

> Using clone3() with CLONE_VFORK guarantees that the child and grandchild
> test processes are sequentially scheduled.  This is implemented with a
> new clone3_vfork() helper replacing the fork() call.

This is now in mainline and appears to be causing several tests (at
least the ptrace vmaccess global_attach test on arm64, possibly also
some of the epoll tests) that previously were timed out by the harness
to to hang instead.  A bisect seems to point at this patch in
particular, there was a bunch of discussion of the fallout of these
patches but I'm afraid I lost track of it, is there something in flight
for this?  -next is affected as well from the looks of it.

Log of the ptrace issue (not that it's useful, the job just gets killed
by the test runner):

   https://lava.sirena.org.uk/scheduler/job/307984

Bisect log:

git bisect start
# status: waiting for both good and bad commits
# good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
git bisect good e8f897f4afef0031fe618a8e94127a0934896aba
# status: waiting for bad commit, 1 good commit known
# bad: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
git bisect bad a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
# good: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-2024=
-03-13' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 480e035fc4c714fb5536e64ab9db04fedc89e910
# good: [2ac2b1665d3fbec6ca709dd6ef3ea05f4a51ee4c] Merge tag 'hwlock-v6.9' =
of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
git bisect good 2ac2b1665d3fbec6ca709dd6ef3ea05f4a51ee4c
# good: [e858beeddfa3a400844c0e22d2118b3b52f1ea5e] bcachefs: If we run merg=
es at a lower watermark, they must be nonblocking
git bisect good e858beeddfa3a400844c0e22d2118b3b52f1ea5e
# good: [e43afae4a335ac0bf54c7a8f23ed65dd55449649] Merge tag 'powerpc-6.9-3=
' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good e43afae4a335ac0bf54c7a8f23ed65dd55449649
# good: [09e10499ee6a5a89fc352f25881276398a49596a] Merge tag 'drm-misc-fixe=
s-2024-05-02' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fi=
xes
git bisect good 09e10499ee6a5a89fc352f25881276398a49596a
# good: [3c15237018eb8a9a56bb49a5dbf4d8eeb154b5cc] Merge tag 'usb-6.9-rc7' =
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good 3c15237018eb8a9a56bb49a5dbf4d8eeb154b5cc
# good: [62788b0f225da1837ad38101112e2c49123470ee] Merge tag 'for-linus' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/rmk/linux
git bisect good 62788b0f225da1837ad38101112e2c49123470ee
# good: [ed44935c330a2633440e8d2660db3c7538eeaf10] Merge tag 'spi-fix-v6.9-=
rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect good ed44935c330a2633440e8d2660db3c7538eeaf10
# good: [c22c3e0753807feee1391a22228b0d5e6ba39b74] Merge tag 'mm-hotfixes-s=
table-2024-05-10-13-14' of git://git.kernel.org/pub/scm/linux/kernel/git/ak=
pm/mm
git bisect good c22c3e0753807feee1391a22228b0d5e6ba39b74
# good: [b61821bb32c5577272408e1b05e6a0879a64257f] Merge tag 'drm-misc-fixe=
s-2024-05-10' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fi=
xes
git bisect good b61821bb32c5577272408e1b05e6a0879a64257f
# bad: [323feb3bdb67649bfa5614eb24ec9cb92a60cf33] selftests/harness: Handle=
 TEST_F()'s explicit exit codes
git bisect bad 323feb3bdb67649bfa5614eb24ec9cb92a60cf33
# bad: [323feb3bdb67649bfa5614eb24ec9cb92a60cf33] selftests/harness: Handle=
 TEST_F()'s explicit exit codes
git bisect bad 323feb3bdb67649bfa5614eb24ec9cb92a60cf33
# bad: [3656bc23429a4d539c81b5cb8f17ceeeeca8901a] selftests/landlock: Do no=
t allocate memory in fixture data
git bisect bad 3656bc23429a4d539c81b5cb8f17ceeeeca8901a
# good: [7e4042abe2ee7c0977fd8bb049a6991b174a5e6f] selftests/landlock: Fix =
FS tests when run on a private mount point
git bisect good 7e4042abe2ee7c0977fd8bb049a6991b174a5e6f
# bad: [a86f18903db9211e265cc130b61adb175b7a4c42] selftests/harness: Fix in=
terleaved scheduling leading to race conditions
git bisect bad a86f18903db9211e265cc130b61adb175b7a4c42
# good: [fff37bd32c7605d93bf900c4c318d56d12000048] selftests/harness: Fix f=
ixture teardown
git bisect good fff37bd32c7605d93bf900c4c318d56d12000048
# first bad commit: [a86f18903db9211e265cc130b61adb175b7a4c42] selftests/ha=
rness: Fix interleaved scheduling leading to race conditions

--pwkg7Agk0Gg3e4Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZU2fIACgkQJNaLcl1U
h9Dbvwf9GBe6CMev8rV7g0l9ySTK2TS6MgAsua7pQ3x/WySaCk0rujv9vrJ+sIR8
tEIjLhwHiAsapapJ9sWukiC9O5pud9XH2NtvinE1i51LIQhdpiuwarqPa3Jcdyf/
wkKrVrAIlS4AWb0N5heFCTSkL5Oq1DHWiqw/ojlDoWs0f3F/pN3pbCsCJFIzhNhS
dvlgnGo9WYNUa0PTay1FYdjA24Q/eJO9FDBTqnC5VU6bp3MoZPzVuS/aj5FRK/0R
O3dbNQ2zCcZtQSDCNXBUGIu93ySlLbXyK7e+wZ/FWh4KZJsjwGIGXShxFKKQH65+
GKs/BgwkzGoDBlvdbqfqlGkjrZGcJw==
=iE8h
-----END PGP SIGNATURE-----

--pwkg7Agk0Gg3e4Mx--

