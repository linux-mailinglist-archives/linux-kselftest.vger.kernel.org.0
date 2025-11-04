Return-Path: <linux-kselftest+bounces-44718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D76EC31407
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 14:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41A374FA634
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5B325496;
	Tue,  4 Nov 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7Hjr3XX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64183322C83;
	Tue,  4 Nov 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262982; cv=none; b=rMhWnEW7SzZzV8jdK/K0zcfglf0pDqrrN/a+v6Tyoj+8jeexfJW6z2K6FirlXrhve9JqfLryeILR3o4x4U2UlBF54X29hP+zyWESFD0Vuj0aFNPHmgnkgmQ2+hYX+7hms5WB2Nupp1lXSBDKN9LnktKAQP2EkmnzWxUp/OtJqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262982; c=relaxed/simple;
	bh=azAivItrY49K4UEWYLYRHt/ABH+lv/uzEUAK+JesQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rodDa7QfMDOcfy/XiknZTrrUsLzEuFyVazhs41vzgqSVG8w/QGuO5SFTBvVTMTP+YlHQuuqB13VDjtWGA+5el2aeSa0xE1OUsCz0cidtkrSakLdiYt4YCYWNdzXBuHUyEJc2bMtqklTLDUVZy+adwwVQ9BFrimbV4VRUjR9k950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Hjr3XX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A062C116C6;
	Tue,  4 Nov 2025 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262981;
	bh=azAivItrY49K4UEWYLYRHt/ABH+lv/uzEUAK+JesQvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7Hjr3XXl0wQ6S3iFdZF1fsWAaniWWYVjMUMFOIJoxwxwG7Pdt5Q0uoBuKT25gqwg
	 lEz+KP3L9DEWhfwLtWQyANZbT349w+tMTDOFwZKz33/HLWZtWtJ6dR2iveJMA4OzRX
	 erIpsHPp7L5Mb1SU6CLwmjZR8Jcdzc4vfBaVHd5T5hzMrsk3QEdctGHJa6D8Mjc0c6
	 5LLMlS9wnVeGjT7cisTQFuxpFn/c3zVixGIreOkBM+QBI8NyzYNm8+6L8x0GlqVCk4
	 h09XYJA7Qt/yd9XY2mSb9HhEa2mV76Vaia8dMabqnpGlCecthwd/NVPosoImOzatBm
	 3ebOICKClbf8w==
Date: Tue, 4 Nov 2025 13:29:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <aQn_wgG6bLhDL0xJ@finisterre.sirena.org.uk>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+bUc+8DkjVNeTm22"
Content-Disposition: inline
In-Reply-To: <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
X-Cookie: If in doubt, mumble.


--+bUc+8DkjVNeTm22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 09:44:38AM +0100, Marek Szyprowski wrote:

> I got almost the same result while bisecting on ARM 32bit Exynos-based=20
> boards, so the issue with this patchset is not fully ARM64 specific. For=
=20
> some reasons it also doesn't affect all systems though. It is even=20
> worse, because it affected only a subset of boards, but different for=20
> each tested commit. The observed failure looks exactly the same:

I'm also seeing other architectures affected looking at -next, I see the
Avenger96 (32 bit Arm) and VisionFive 2 (RISC-V) with bisects coming out
on the merge of the branch or on

# first bad commit: [10d91dac2ea5ddf04e647cf862430d1051adb839] vdso/datasto=
re: Allocate data pages dynamically

It looks like the uniprocessor boards I've got (at91sam9g20ek,
BeagleBone Black) are running fine.

--+bUc+8DkjVNeTm22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkJ/8EACgkQJNaLcl1U
h9CpkAf6A+69+z2QXStQyH9xpQ9GPBEq+tDAXKjipsigRts9dJxv2bGY1a5Dh8au
FBJQ/jhD8D2X6RlQHTv40vs6tG60GIngt24OmI3FasOGwxXhtwBcLaS0aHHlYUUt
qLVORv6xfBq3F6/wDzQ1aIDlPTIy400fD/eCJUwI083H1txPvzlYMm12cIWIiJ8u
bT8xDPGVKJtPEbLohQkWfoI6tPvxoDxzOGziUwQMi4XK8U2/4cEhIPve/Aa9GbpF
+ZCmks9cF4bslJWUjVPor98/kGlIRc722fvvOaukvYQv8rrS79j7XNfo78Bw/d3g
b6y91B0A7gLZU52AavqrMnJTlHXHQQ==
=LyBm
-----END PGP SIGNATURE-----

--+bUc+8DkjVNeTm22--

