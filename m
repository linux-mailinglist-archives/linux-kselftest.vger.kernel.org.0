Return-Path: <linux-kselftest+bounces-44670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C1C2D524
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 18:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035351886299
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F7319605;
	Mon,  3 Nov 2025 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPmPZfN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143E329369;
	Mon,  3 Nov 2025 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188955; cv=none; b=NLO7XvtQpsi/u2KVTTfTpEqvPAtk/TE02glxYbOwBMeNpLzA3irRl8iaS/TzGmodH52kpdbE7a2x/RifRM+r5qJnatANKEodX88QixOBuqIVZsjzVnGtmeUkL/NqO5jK3pRI+jTGUi6uM1QKcERytFcSUUEE0W/U6Qm3w8f53i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188955; c=relaxed/simple;
	bh=norwYxHA6VI/ySU0ex5Ew7OW1FQwMlwu39WjPcjgOKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBGLTfYMPUcQhGuyFfT3niG/NVkpQEX1q64F6AqrdJHqSxg6LLWaHUBqgD/jEOd/IxBmo67B2aH2bKaSYX5bvYYzgb6vH10NQ682e/6koi9GO/3MiQEoO0g1u0x0GW4CIZEDacPR+PWnRVZS048HD9WXmijllYrUjEkLCkhXSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPmPZfN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28A1C116C6;
	Mon,  3 Nov 2025 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188955;
	bh=norwYxHA6VI/ySU0ex5Ew7OW1FQwMlwu39WjPcjgOKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPmPZfN0yXQ5Ndyhd1mm6d5YyvVQn+2NS84I1P7cyPdxS80PfY2ZucI9nnhbgf4WY
	 s7T0hQkmYh3BvC31fK7wOMt5xVzp7z74BHWa8QiGuneY+AjDKqKSdLT2+rUSqfiIRO
	 dq+CUk9yAJPAVVOoWmGfXhaovQn/CvtO/zMXNg05HM/YIbPUs0MlUvc8htSP7z6LHt
	 MfQNRhhp20WhSWzc6Igwle5mi2X3jI4fgZVoTroQvMzbrqdD1j07JdGxQgKVOnVbrm
	 vd3TNzlzeFyZKWqiC0BIaRsKVR8HfiPDkfKQworpdeGvoSegLcGOaqT5hTJ1SqTz0O
	 PrtNV6DhYV2Ww==
Date: Mon, 3 Nov 2025 16:55:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <aQjemPIbHMplGD4N@finisterre.sirena.org.uk>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <87bjljw1ra.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyY1KyZQ9jhQldRu"
Content-Disposition: inline
In-Reply-To: <87bjljw1ra.ffs@tglx>
X-Cookie: If in doubt, mumble.


--xyY1KyZQ9jhQldRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2025 at 04:54:01PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 03 2025 at 15:24, Mark Brown wrote:

> > which isn't super instructive.  Not all platforms seem to be affected,
> > I've seen this on at least the Arm FVP, Orion O6 and Libretech Renegade
> > Elite.  The diagnostics aren't very clear here but given that I'm seeing
> > the same issue and bisect result on multiple platforms it seemed worth
> > mentioning.  Some platforms do seem fine.

> Can you try

>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso

> which is rc1 based and only contains the VDSO changes. That might give
> us a better hint.

Yeah, hopefully - my infrastructure is pretty swamped ATM and I'm in an
internal conference.  I did kick something off earlier on this specific
commit which should be equivalent information but it'll be tomorrow
before I can get a full picture.

--xyY1KyZQ9jhQldRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkI3pcACgkQJNaLcl1U
h9BpwAf9G2OE1wGg3D/F2WCmsKiRzqX8EJTZWpdThdfvEP9vbPytmPqRt4LoPk9E
cKlt3SaJFVZbyfx2YTDOqcC/FaQr5gdVRVsLuiKavYpVHanTEb/HCx2BvROuDvE2
Ssx3Em7R+eHCyonl/unY/EOt7PP4hUtDizXKblf1rb5I/tM9ADlHYpQSTKF2Poxr
/gIn6gPy89C+hD2rrkQJZWraOVcbciUGJVMWtMKRm96l0pPwdHchsimXnrYq6AId
exk8ECk4hjsPpcarTzTqvJr+UCDMFpF99qq7GWDrkeifMqQqrvR5RY2kcsdyNGMw
3ssV8/Eg6XLVg7GU0FL9k76qaqD7kA==
=et8+
-----END PGP SIGNATURE-----

--xyY1KyZQ9jhQldRu--

