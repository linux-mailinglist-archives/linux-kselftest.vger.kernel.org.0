Return-Path: <linux-kselftest+bounces-44967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEBC3B81A
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 14:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51316227E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093433711C;
	Thu,  6 Nov 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj9jE7yo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FC1E2614;
	Thu,  6 Nov 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436387; cv=none; b=FF+iPK92bPZT+6bQHzQAk2KEwYiVnhmSuWNyhTzDyEt9CWlwZ3bRvs4qeIeZi1r8u3nFiU9LBRD+WYeCsZ0dWIq8d1K5d35GxX3vguYW27kCL1WT0bdly226HBCcOFAt98QRuov7dYewJ2SyBhzFv+YxU8WlN/rTfZbSlHsA59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436387; c=relaxed/simple;
	bh=lvN082Tgo45NxAv9qOCzujCY0L4Wp+Q7wkeySWpj1K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxRnyVh1+NhNVYAFWtOaUwrtpoTPLXr96dVLxQaF2Dnv/qOeOfSnkqPkTNBWejR3x8uscK9aMpKFH1lIS+HfjbkwGqqgRdgvSu1hhnMW1Hw29eWruSx3R7skRt2Z9zEN5d4f4cRBpgSGBeH1HJzFkj7UAnelzMBYU0FR13o8djY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj9jE7yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FADC4CEF7;
	Thu,  6 Nov 2025 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762436387;
	bh=lvN082Tgo45NxAv9qOCzujCY0L4Wp+Q7wkeySWpj1K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj9jE7yoInr9BCWfLJ0Y8+K6jrgVmgkwml63N4WoByHVsIr4RWQ7jaDOc81VdNYJ8
	 iTSCutwFS0KKGPYd8MgmLbSZozfDICTrA/EwOxswYw32R5r2FcMvYuyqLSnKlg09GK
	 ZGqwqyOq5eWuvrCT8KWgRiq/B2qmCmSO815iikAweI9cxudRZAg/pcDZnnUrPzQRrs
	 cN2lwF4mGeI/cbxWZtf3kduZfEEOnF+HlI1wbjFN0rVAlsEKu9W/Nk6ryO+lT+57Vi
	 zzU+PGx4Sd+6r49nkGvK51PgNHObALx0PSlYhCn8Qq3ZiZYk2NFEy6IKxYmHxQusBf
	 Wc8wnQM0TuucA==
Date: Thu, 6 Nov 2025 13:39:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
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
	linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com,
	Ryan.Roberts@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <aQylIPCo1sEnJF4F@finisterre.sirena.org.uk>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
 <aQyig5TNkw2YJm19@finisterre.sirena.org.uk>
 <20251106142956-d6251eba-c696-4a2f-a3e3-af461530d932@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EYbPhjGrYVw8SR92"
Content-Disposition: inline
In-Reply-To: <20251106142956-d6251eba-c696-4a2f-a3e3-af461530d932@linutronix.de>
X-Cookie: If in doubt, mumble.


--EYbPhjGrYVw8SR92
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 02:32:56PM +0100, Thomas Wei=DFschuh wrote:
> On Thu, Nov 06, 2025 at 01:28:35PM +0000, Mark Brown wrote:

> > Given that this issue is very disruptive to userspace it's causing us to
> > miss huge amounts of test coverage for -next, would it be possible to
> > drop these patches until we resolve the issue?

> This issue and the observed panics should be fixed in v5 of the series:
> https://lore.kernel.org/lkml/20251106-vdso-sparc64-generic-2-v5-0-97ff2b6=
542f7@linutronix.de/

> I'll ping tglx directly.

Ah, fantastic - I wasn't aware of the new version.

--EYbPhjGrYVw8SR92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkMpSAACgkQJNaLcl1U
h9ApqAf8DFWNLEwpnWuEpnrOTVfL+iVYzK6YSgBge+QboC8tTBNFnMnnQ5Ht92aC
QaU0hO+PO0XJiyMXzjXfT5JgDO8ovlQIUShX3kjD7MF/MuSGdEAbRUEzoFj4d170
GN1BVZ8iAysXN0NytDNcZImpsxwVva2BtBFzYouhWlcDg2eRPWhzd6tvmJY3b0ZI
qn9eJOHvYiqh6I4jaF/7mI11G/JYp3x3738trx8FMvZxgxL6y0O0MQ8lETGJTaao
EwYoM4wyzL8dDJ0r4bYy7pGAiIKFQXpASY1pInXJQ/NVO4fcAC7E47S0u5odZz1h
lhDgGOw14KG8UFp0J4rBQQRfSWDhCA==
=oxel
-----END PGP SIGNATURE-----

--EYbPhjGrYVw8SR92--

