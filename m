Return-Path: <linux-kselftest+bounces-30105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F71A7BD26
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C7D3B7292
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D971C32EA;
	Fri,  4 Apr 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQMQrsUS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0587131E49;
	Fri,  4 Apr 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771793; cv=none; b=u+tzmcrxomlw3gVib4aTAv2T9aJCHr9ANibYKvRM2qSrtoZbv+LXjFop0gP2t9iBm0wO288CTwd8+xKeVL53sYQaBLaH9KBrY8aVy0qDhDBlkVfIK1xYMyUQwdnVEFKEyg/0MqD03t0JqU5dMY2CBNvmt1PzITBXrSAhXmGYxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771793; c=relaxed/simple;
	bh=AKLtJKgf6xvY8q/ufoUEoQNZ+XIHdCtuKdSi0hzYYBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al3PRRt8TA2puqbCtH87Pz9Hlm5qcL8wjTqRQ8jYxCvYOd/TzwChgHtNJ6wpEPilT6+ErJCuqCZKCOJQJ+dsZA7rvMjPHwijEO9M6/LsQHhayXj8FTOELsz1CZQpOGumyROj6fIUfK9EftLcY0OWqMdH+EQZ5zR3x6HWfJsNF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQMQrsUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57730C4CEDD;
	Fri,  4 Apr 2025 13:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743771793;
	bh=AKLtJKgf6xvY8q/ufoUEoQNZ+XIHdCtuKdSi0hzYYBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQMQrsUS7cQSM+dAXLB5YhPBn9aqUgzyfhobLQQi4NPn1qB0UFCzQhywGy5iJrto1
	 /1auJFTdYaS4tkopc/uLiKWZKqC8+Iz4QaLsSCjLPskmYkwTxfnG+j6uxFYaAsOaGx
	 RSRx2bYnEv9wmphEhboMVl6w94MWUVUA4yRQ4PXEfAYAE7nHjbSneWMDWV7c2JRm2b
	 GI8gU83Gu54k6DE4mamV1XVodAJKXpaZK6OMb3DxpLxzWm1uegT0bRG0AKIRxz4GTn
	 ur/kyQd5bxCSVDgchdcJEiO4Gk/yTrC8RxOm6t5Pg1z5F9iKMz4Xodeciupg3fngdY
	 w0346XLuXmSTQ==
Date: Fri, 4 Apr 2025 14:03:03 +0100
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
Message-ID: <0850bce9-f6d1-4742-a132-25b02bf6fac8@sirena.org.uk>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
 <af553c62-ca2f-4956-932c-dd6e3a126f58@sirena.org.uk>
 <c7bea938-ee3b-477e-9ed0-db29ca02a538@sirena.org.uk>
 <75ea2dcf-0ba3-4076-9a54-6b39e4e72a3d@linuxfoundation.org>
 <708e303e-4de6-4322-8065-1dacf0cc0d53@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cV+QB6VwGauMc72v"
Content-Disposition: inline
In-Reply-To: <708e303e-4de6-4322-8065-1dacf0cc0d53@sirena.org.uk>
X-Cookie: You will soon forget this.


--cV+QB6VwGauMc72v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2025 at 12:56:26PM +0100, Mark Brown wrote:
> On Fri, Mar 28, 2025 at 05:08:26PM -0600, Shuah Khan wrote:

> > If this is going through tip

> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>

> > Otherwise, I can send this up

> Given that this hasn't had a response from tip for several weeks it's
> probably as well for you to pick it up - I was considering sending it
> directly to Linus myself.

I tried sending a copy to Linus but he didn't respond yet, could you
send it as part of a kselftest pull request?  It'd be unfortunate to
have a broken -rc1.

--cV+QB6VwGauMc72v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfv2IYACgkQJNaLcl1U
h9BrcAf/c+Isfk+QXS/lo7Vaf3QMDGrL0qiuFylQH2WcURylDQesXlCyE36yinxP
SVs/gto1aZZvWXs6tZiMHfRbdJmA0Bol/WEgGouC3YbKV09E94321Q5vO67Qo4p4
kUtyUWDBdJ2ltUn+tdMvwPnXEzEzT4Qd36llO22p99jaY8BQww8wj+UkBtaNcJxv
dgThiAoRt23TKxPJ1HXRbszAXrKSc6HI/eYbjOZaZjQowZ5GVZPs5JVkG3jSii8h
CqSp23rxxw5icqh4c7RQS1c1v+UygJTubXZNTNAKXbWf2x33CCvpHUTyRFeNqMfI
ZxxNgSIZEXsJKc3dJhB3WFWIBm0ubw==
=9cZZ
-----END PGP SIGNATURE-----

--cV+QB6VwGauMc72v--

