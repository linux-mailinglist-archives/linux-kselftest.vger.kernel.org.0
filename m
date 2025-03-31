Return-Path: <linux-kselftest+bounces-29951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D364EA7653E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844DE168D5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1401E260D;
	Mon, 31 Mar 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKpUSAvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5871E104E;
	Mon, 31 Mar 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743422186; cv=none; b=sXecmRNKt0OlusZPbj2l3Rmx6TkHnKGxtSLbcea4DTO6ViWhV9KZ+RrlAQrvA8+w7YiFAnvNbg8akXzdM0eWHPNre6L9cV3AZrVVzC2C9u/IVT4Ps8GBLR4sE6Y31fReHJcZYuLhBkHptgmQz0rO4SA4YVc4Y0af7Qbvm8k4l5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743422186; c=relaxed/simple;
	bh=+2tIP000T17A8Oc7t3JMilpXBYVfCrNZDt+OW//gigc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKeLwxvrC0cxzWJy6YnTZpVv9WNqRLcOnj5f80V3wMogMFsMT2MtRceUz0mMdOVkxdoI9GL0282jLPnaSqkTgYS3pGQD07Tqy8DVd6Za4KRu2F0u9gsd6yMVj0YVcOx7LQw6uNReCsewTG3URZevs6v2orjBavzn+obxL5NtwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKpUSAvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB87C4CEE3;
	Mon, 31 Mar 2025 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743422186;
	bh=+2tIP000T17A8Oc7t3JMilpXBYVfCrNZDt+OW//gigc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKpUSAvL1CD7IFs2UvGzkDo6iHdIfzQXRDwjWfHvPmUJXwX5VGnSEK1Dc8jjBYk/Y
	 d/fwhHzvd1jUrQg/Pr6jlSYhv3ZOImcnFKf8CXC/qPn449d14yAFi8NkZkC8WNDVbE
	 o8vKw8u26lGFPt26pgXotQ0+SOEgLIeQJTun+kMtKE37T6cJ12XoRp6DyfW7g1J/4s
	 Oq9G75tUw4lGyZVDZ06iFHAhfXkEWNX8NeLhmb9q1WM47lsb/87ahYEq0qBRP1o59F
	 J6fh9Ha6fLZQOhtzpk69py7w7LeXSzchJlb/ermD0d7mBLIu2ZHhwgqXbsEeShvoJF
	 Rs05onYuLQpvg==
Date: Mon, 31 Mar 2025 12:56:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 12/16] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
Message-ID: <708e303e-4de6-4322-8065-1dacf0cc0d53@sirena.org.uk>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
 <af553c62-ca2f-4956-932c-dd6e3a126f58@sirena.org.uk>
 <c7bea938-ee3b-477e-9ed0-db29ca02a538@sirena.org.uk>
 <75ea2dcf-0ba3-4076-9a54-6b39e4e72a3d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KalBa86xIdoMygpC"
Content-Disposition: inline
In-Reply-To: <75ea2dcf-0ba3-4076-9a54-6b39e4e72a3d@linuxfoundation.org>
X-Cookie: The Ranger isn't gonna like it, Yogi.


--KalBa86xIdoMygpC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2025 at 05:08:26PM -0600, Shuah Khan wrote:
> On 3/26/25 07:02, Mark Brown wrote:

> > This bug is now in mainline.  A fix was posted by Thomas the day after
> > the original report:

> >     https://lore.kernel.org/r/20250321-uapi-consistency-v1-1-439070118dc0@linutronix.de

> > but it has apparently slipped through the cracks.

> If this is going through tip

> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

> Otherwise, I can send this up

Given that this hasn't had a response from tip for several weeks it's
probably as well for you to pick it up - I was considering sending it
directly to Linus myself.

--KalBa86xIdoMygpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfqguIACgkQJNaLcl1U
h9AmYwgAhU5OAjRIyrT55ORFUEnAgksOlpfOa+SMX3JjNaLJjSNnBKc9lpq1L0Zv
3Gzudpo//l44I7kiHFHhujQhH1A5FwGBd8pghgzbu6lICqABVXqdBaQ/6x6qE/VW
v2N8s9oVgeEtybhAtZb2MGo1Z43LrIzHVV6p1aJI8EHklaNqTzQHXCabK+hEVZKx
QC8tTWgy2uNqxzGGmJTXrW949sTqpO2nhk0EqnejnjCEjI9C8iR01GCj0XOum4sT
mk3BX8OdBX1pdZO8PhSgfnsccB11czt+FR+gGO3QcqiuJ4bnkm4ypOKJqrYdMDfc
rR7IUBjoKGYr/QFro/1Uae0npyqFtg==
=u7w3
-----END PGP SIGNATURE-----

--KalBa86xIdoMygpC--

