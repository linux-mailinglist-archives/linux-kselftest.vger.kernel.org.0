Return-Path: <linux-kselftest+bounces-44722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51027C31E93
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B84644E5DE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28B264638;
	Tue,  4 Nov 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCdInrer"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AE199385;
	Tue,  4 Nov 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271237; cv=none; b=YDbwe5RqLKE52vslYLlVuTcGof59RNIInzGeALaz+MZjN/HJGTyJwz9eHPsr9euQYas+gB1cE4uFznLWba+at963NtgvrFlTXCMwwGrOkzFh0Vw5m8h6N0MP9KBCGwzSzagmHRFx9miRTbheK1ki311NqRZ6VgnkjSDjigehZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271237; c=relaxed/simple;
	bh=sNvgLU2tT2QtYcE++dQwFqfrLanXeBmZ4oNa9dmXiuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V717GHrEb1zvsSAByNRdpn4oDLFtcOhrTJG8f8UjMchiG04nQKyeayaJ9U2Imes5oRYSTzs7nc9U74gEQzp1ticxW0CuuaB2WnQA+ASGP9/hlcDHsDcCUdCcgoCAVTpAbdhi69+gz5pzVkkNUn2KTf3UDaS4t+TWhoo36odydDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCdInrer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED2C116B1;
	Tue,  4 Nov 2025 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762271237;
	bh=sNvgLU2tT2QtYcE++dQwFqfrLanXeBmZ4oNa9dmXiuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCdInrer7LepIuBSWSpwRE+lkhLMT9QMw++9YEMTJILBagvaoNxLr+E0o5iuw+6qh
	 4/wP2J/i3qQhy5Kft/3TosLdM1EgHmFfsDK6IfYfxoZle5eaUgdBPc4bBPcnGVDqCk
	 KDErSYxmCqyp6oXXW1VrnfahWBgE9m/+PVH+EPJIt9FQkfqsuURo3cJDCqE+O2eLBm
	 H5C/ACbilrOMnKgtI/iXeKepbvLqkq/7r0yYg60InC0JDZv2lD5lmhMJiKxwLDUaGU
	 HnvSWLKkLYbiR9jWLoMXivF840mjsxtbmnf6d5oYx+LvesdpChJDbGY8UJRR9UTUBV
	 x1K59OjL2V1Cw==
Date: Tue, 4 Nov 2025 15:47:13 +0000
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
Message-ID: <aQogAfbrP9rTPLvI@finisterre.sirena.org.uk>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
 <CGME20251104084442eucas1p2af1bd88393f4d6a532df1cd41f32a287@eucas1p2.samsung.com>
 <e7f05748-a11c-47eb-b1fa-cdc9dc6d05e0@samsung.com>
 <aQn8G9r2OWv_yEQp@finisterre.sirena.org.uk>
 <20251104162009-8cffa62d-e95b-466b-9a27-c51b0f5257cd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zVoWTguNpry6X+3h"
Content-Disposition: inline
In-Reply-To: <20251104162009-8cffa62d-e95b-466b-9a27-c51b0f5257cd@linutronix.de>
X-Cookie: If in doubt, mumble.


--zVoWTguNpry6X+3h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 04:43:34PM +0100, Thomas Wei=DFschuh wrote:
> On Tue, Nov 04, 2025 at 01:14:03PM +0000, Mark Brown wrote:

> > I've now got the results for this specific commit, it looks like every
> > single arm64 system is failing.  I didn't test any other architectures.

> Which one do you mean exactly with "this specific commit"?

> 6a011a228293 ("vdso/datastore: Map pages through struct page")
> 10d91dac2ea5 ("vdso/datastore: Allocate data pages dynamically")

The one in the thread being replied to here, the first.

> Any chance I could get remote access to one of your test machines?
> I don't have access to the exact machines and that should reduce the chan=
ce
> of chasing down dead ends.

I can let you submit LAVA jobs to my lab (there's an API, a web
interface for (re)submitting jobs and a CLI tool for shoving jobs in) if
that works?  That's how my own access to it works unless I go pull
boards out.  You should be able to resubmit existing jobs, it downloads
test binaries over HTTP.

--zVoWTguNpry6X+3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkKIAEACgkQJNaLcl1U
h9BXnwf8DrtoASOmIwCcathDthMIkBxak4gjtFCMM9nl89xoYXw0PBVjwG05q9Ug
wRGz5y1/4Lw02ScLoNgGHwrQvg+j2UZaRq5bxFZ/sTsAIk/EGp6BPS0DkaQscGWH
lua2F7kyuqAm4W68+aHxBoFfT/Tmj/IrNYJkAV0t1PSLxWAXckiHTsa8wpUsW857
Dmv99n18VJcp32FYPy8Cdgxcdi86Uta8cpqOkA9IDA/ExbpWmveGN+IkJklF7zBA
YdW9Z9zvjZ6yfNP4/HgLCx5G41XKX2Ra0iNKEvdrKC9mp5x5Ra2ogMPYFFYZDhBx
mWcYg2iUelmLcPPYxVsizqjhauW2MA==
=RR8q
-----END PGP SIGNATURE-----

--zVoWTguNpry6X+3h--

