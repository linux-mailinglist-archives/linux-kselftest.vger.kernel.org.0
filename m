Return-Path: <linux-kselftest+bounces-44970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81DC3BA01
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 15:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0670625C84
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674833BBA8;
	Thu,  6 Nov 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud+s8WUS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0133A015;
	Thu,  6 Nov 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437747; cv=none; b=IXy7PFLB2MpmjEuA0I2BHbJAEmxvclpsXKkOzvcfFTKPp9EMyn/InFqeNiv3yADgJiC994npwFkPUE+tkYEqGV4BCju+CRqi/QHjs+0x1IZG68k3xFQWOd4FEm8Fign9P2Ycgj7ptiAFx1+jcBudIW2InSoOb8e5a9wPweezK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437747; c=relaxed/simple;
	bh=rks74Ok2xVDZRYVekwVF/tod1CxxsRBTTzdE/GlxP70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLABcp0Fn8Vr10idJJU94lSuXmV+DANbiJ1Fp4dYvmW+HwDczdp51lNRyayvHjfdK8+bTdG5Zfvfp9P0VYjoEf+SoGoQHNFlm+O1caQ7t8MLcXO9ooPdqpR1g7rxQvfJGLWk5Ouhk/0wu54lhddRmrvz06xA49WhPNH4CGae0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud+s8WUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A90C4CEFB;
	Thu,  6 Nov 2025 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762437747;
	bh=rks74Ok2xVDZRYVekwVF/tod1CxxsRBTTzdE/GlxP70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ud+s8WUSocuprubvzUOn8VaTTNgP5pI8KL1QrPvB41zFUOTeVRqsg6VXanq7RjXrt
	 Xn+A/6fKrbkrAoSRxtE7sgs19ET/So8zm9IajCVZ4mSdbwTSULmFfhU5BAo+iF7nTD
	 ZMUcjlN+rjIbRkhA07YgsdHFpyV+ozJZ/xB4qYFYWSN+AChzURE/gwQXR5xm4ExRgC
	 f5IG/MS4uEHvmQ/Vp4534qX52O/yMhhPHpmXheOg/bpZX16ILqr8bdwixpllo89E9L
	 dh0F2VOHbeO7NnGAN2xsSfXTCxZCZ93t4sk6Si+GzjOjs2MhU+GK+MX4wmRD6Ijdjv
	 z3wqWVhwtQQaQ==
Date: Thu, 6 Nov 2025 14:02:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v5 00/34] sparc64: vdso: Switch to the generic vDSO
 library
Message-ID: <aQyqcH39IPLRWMt_@finisterre.sirena.org.uk>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4rnwqeK5vRaFw2+U"
Content-Disposition: inline
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
X-Cookie: Dyslexics have more fnu.


--4rnwqeK5vRaFw2+U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 11:01:53AM +0100, Thomas Wei=DFschuh wrote:
> The generic vDSO provides a lot common functionality shared between
> different architectures. SPARC is the last architecture not using it,
> preventing some necessary code cleanup.
>=20
> Make use of the generic infrastructure.

> ---
> Changes in v5:
> - Merge the patches for 'struct page' mapping and dynamic allocation
> - Zero out newly-allocated data pages
> - Pick up review tags
> - Link to v4: https://lore.kernel.org/r/20251014-vdso-sparc64-generic-2-v=
4-0-e0607bf49dea@linutronix.de

I've validated that the zeroing fixes the issues we were seeing with
boot failures on a reasonable chunk of the arm64 platforms:

Tested-by: Mark Brown <broonie@kernel.org>

I didn't get to all of them but I'd expect the rest are also fine.

--4rnwqeK5vRaFw2+U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkMqnAACgkQJNaLcl1U
h9DdXQf/cqvSjdtV28SWYNX+UHnXmboyHxzenwcfa4zxbnrzgQ8feYntV6Ikfx7L
ovSme6EY9cGYwoDmmhIHSSVZ0iuMwgiSj/NLxYlzbayc8uJITnfMorXtyOkqn7eQ
9PngOIxdOAGels3s3oLIZfRg7pXKnfX176OvkFQi6I2gHaBHCpQbBq4o5qVqFo85
Yra3emkWyARoll2AJ3u/dPVaDlXP2H3z4fm9QzX/1aWFaGN5Ml43iLbTfuC6YPlA
/XTavzO9jIbi7l2J36K152BdwsgyOEHqQezDy5a/7bSQwA9cH7ok32svP1b5hpl1
DOGKdUeeQCo9BAzV2TfMQR9jwzkZSQ==
=zN3L
-----END PGP SIGNATURE-----

--4rnwqeK5vRaFw2+U--

