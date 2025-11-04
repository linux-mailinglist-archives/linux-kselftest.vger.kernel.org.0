Return-Path: <linux-kselftest+bounces-44724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2539C32054
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 17:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113A018944A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B79332ECF;
	Tue,  4 Nov 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XERX5aBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935133291C;
	Tue,  4 Nov 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273312; cv=none; b=somKRkCCevsbPR8UovKaeIYYO2JNsdzfogiLUlRdNXtCar+2IhtWvw1HCAbv4BykMMmT0od0LKsvxgJHwd0cDktXK62xfkgWZbctoK/VvHEi+2hVUEAFCk1KP5JhtvVwdwu5++3shllwimsYjncwOl5ypcp7+Ll/Uh75FYQ6YCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273312; c=relaxed/simple;
	bh=ZgapEV2f6UOkVKQ4Tm3UO+ujY8mCniaMXHTUMRbX7qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwPF5T5yQfxU0mhmmuKUidpmp9revRIG2RTiwVggAruvbY9hD85MPnnGgkBomqk0W9mpDL3556v7OPv1d/nkdryemQfp/fzjmjaEYpr+93XH452l4cMoX60EBxb8y8gYQOj9QhA1rEN23ciHVMXUjfjmgIAPR7mPD5W5tUZsYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XERX5aBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA99BC4CEF8;
	Tue,  4 Nov 2025 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273312;
	bh=ZgapEV2f6UOkVKQ4Tm3UO+ujY8mCniaMXHTUMRbX7qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XERX5aBHazdMMA+oEnGRxw1zsSiVD03zD1/OvFrITxNP8TY8EKGHO897kQpHZcTC4
	 AjOz22hE45sDXPt8Me6tOdmAhG+A6sT8FL6AjX6iYO6ZcS6KadkQT0rMkbJmui1OF/
	 y4pOsmta37VrO7TikjmFAe6yJr0DOXYwKDoT/9gVY3btW9L5vhKbX9306CCCv2kmMU
	 q0Xm6Z0TQ7+VPuX7Bj+EZ5H6rPQRzeur3ohk90yIJvxkO3YG03g9YEM8mYNDLcUFlG
	 PnlmletPsDgf5n3+Go+pKne9UEK4e4ygPuzYRVo35SlZ1BzC2w6vuQ8zAxKAJKLqqA
	 KeZdQ7RUrsN6Q==
Date: Tue, 4 Nov 2025 16:21:49 +0000
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
	linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
Message-ID: <aQooHZ5p4DNhwbar@finisterre.sirena.org.uk>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
 <aQn8G9r2OWv_yEQp@finisterre.sirena.org.uk>
 <20251104162009-8cffa62d-e95b-466b-9a27-c51b0f5257cd@linutronix.de>
 <aQogAfbrP9rTPLvI@finisterre.sirena.org.uk>
 <20251104170215-3600e71c-1573-43aa-ad1d-8d02af9bbbf4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vgxhQqUhFOf4jqrE"
Content-Disposition: inline
In-Reply-To: <20251104170215-3600e71c-1573-43aa-ad1d-8d02af9bbbf4@linutronix.de>
X-Cookie: If in doubt, mumble.


--vgxhQqUhFOf4jqrE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 05:03:28PM +0100, Thomas Wei=DFschuh wrote:
> On Tue, Nov 04, 2025 at 03:47:13PM +0000, Mark Brown wrote:

> > I can let you submit LAVA jobs to my lab (there's an API, a web
> > interface for (re)submitting jobs and a CLI tool for shoving jobs in) if
> > that works?  That's how my own access to it works unless I go pull
> > boards out.  You should be able to resubmit existing jobs, it downloads
> > test binaries over HTTP.

> Sounds good.

OK, folllowing up off-list for that.

--vgxhQqUhFOf4jqrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkKKBwACgkQJNaLcl1U
h9BB+Qf9EauYOf7gmQuIlmWkRFyAe3nL6GnUvplpFK7JQgCAmEpS6FK/StPLVbZL
WwU/hE4esPcUwdBtU2pbY2fHKOHlAE3CNPiiEYfjkd51GcYtFX5b0Lw1PDB72Kgo
ZFvKRrKRgkb3Mn3f7Dl2XoapM8m7YR/tRtJNCBk+SesiIQ0HfL5V4ExsYO+L5c7s
wegS0czcQsWbwDBTsPWl3QJF+HPkq28QUpznRvaUwKfj7Pe5PJTpEQy9OZQf7u4r
e8p94FrmEto2SEMlh98mHi5iZcmCBPvOtFtCrv8NmzDi7olabfnoQ+ECOnFB2+Cy
tm2fLJofnR2UpxNKmXwxdF0pK8VkPw==
=HhMt
-----END PGP SIGNATURE-----

--vgxhQqUhFOf4jqrE--

