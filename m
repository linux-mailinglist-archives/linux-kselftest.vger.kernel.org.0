Return-Path: <linux-kselftest+bounces-11849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD2906866
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2921F22A12
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C8C13D286;
	Thu, 13 Jun 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9FwA2BH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845F29AB;
	Thu, 13 Jun 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270395; cv=none; b=rX9cy6dxGhh8+mjRUd20LcKUDrzoI13hXk0m/fo+lYiGJOuIJMI4o/fU9cQHJ3QYC/hGXYa3kfm+F2C2LZrXtqAxz9fLdyIAwh01l9eroXkcFv+NXgKU4ON7/9Z/Hy3SWwjzKo9cAwibk0CZQUj0Tmz55y05g1xUicO+ZXdMmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270395; c=relaxed/simple;
	bh=8Xjm/uj9cAgItooDzOKc5oI7NbTaImBSC4XKzPzMWAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKraMzGHwnnoQhDIivBl8aLlE3v6d1A1UBKmXfw7pHTDlT+y30EaUYeKYdThFK7aZm1bAD3Q22OIIGsEHqs4uC4Ck0EntlkVgzEgrc7RvGWZPrWEi79hdUNlKHpv+I96xJoDDGquRk3Pc4YeF+F84/SPxdiSzK00uSDsBHKGBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9FwA2BH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD1BC2BBFC;
	Thu, 13 Jun 2024 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718270395;
	bh=8Xjm/uj9cAgItooDzOKc5oI7NbTaImBSC4XKzPzMWAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9FwA2BHwLLmZ/7ti+Yq9/n6AalsdGJWg2ax2sYZQGUCb/xn+XoMMbgd/9muEROwH
	 TBOm3a3DZy98nUC8dHQryUBpQuXRWlkfbh85h49ZrvkJhyVzES0rAWS7jWpI9fLXzu
	 r8uMvqN/BcwNslxHy9o5vDdojL9yZQXUcVqGhdBJCa7qWSmu/UTi6wE06Vy9VtriaK
	 dRvGi+cYDdN4nqmFi98hiLWhX3LQ0JOVubmpvQg4859Er3Av9PHqpruZGrVPiQFfwd
	 SDTL3ax4y1ycLXw9u3MYl1FXXqHeVpcODHpTR9wbSFMGoFsqFlY1HW/UvyVPKu1P0h
	 kmmPJ3NJ9P45Q==
Date: Thu, 13 Jun 2024 10:19:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
	tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <Zmq5uK0RfvgVKFdO@finisterre.sirena.org.uk>
References: <20240611075650.814397-1-dev.jain@arm.com>
 <20240611075650.814397-3-dev.jain@arm.com>
 <Zmg0GoGnJFbPysfK@finisterre.sirena.org.uk>
 <ec1973ee-909d-41a2-8b32-256302d190b4@arm.com>
 <ZmmfkbuCl61rEPs-@finisterre.sirena.org.uk>
 <920f2e27-39ee-4c53-9c90-63d67e7d7586@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YUY1zS9czf83kEFd"
Content-Disposition: inline
In-Reply-To: <920f2e27-39ee-4c53-9c90-63d67e7d7586@arm.com>
X-Cookie: Your love life will be... interesting.


--YUY1zS9czf83kEFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2024 at 10:21:39AM +0530, Dev Jain wrote:

> I guess we agree on the same thing; so, how about I rephrase the delivery
> and blocking code comments this way:
> "A process can request blocking of a signal by masking it into its set of
> blocked signals; such a signal, when sent to the process by the kernel, will
> get blocked by the process and it may later unblock it and take an action.
> At that point, the signal will be "delivered".

Yes.

> A signal sent by the kernel to the process, is said to be delivered to the
> process when the process takes an action upon receipt of the signal: such
> action may include termination, or jumping to a signal handler."

I'd just drop this last paragraph.

> > TBH I'm not sure what you mean there by real time signals, I can't see
> > a reference to real time in the copies of signal(2), signal(7) or
> > sigaction(2) on my system.  I suspect SA_NODEFER is the actual thing
> > here.

> Real-time signals get a mention on signal(7), under the heading
> "Real-time signals":

Ah, it's got a - in there so it doesn't show up in searches.

> > I still don't follow what the above means.  When you say "invariant" you
> > don't specify with respect to what, and it's not clear to me why the
> > saved context in ucontext would have changed without the handler writing
> > to it.  For clarity I think this needs to say what the ucontext is
> > expected to be the same as/different to.

> The ucontext at this stage is supposed to be empty, I guess I'll replace
> the word "invariant" then.
> "it's not clear to me why the saved context in ucontext would have changed
> without the handler writing to it" - by invariant I meant, the set of blocked
> signals before invocation of handler is exactly the set of signals blocked in
> ucontext, which, in this case, is the empty set. I'll just write that ucontext
> is empty.

Yes, or like I say in general it's the the interrupted context (there's
other parts of the signal frame which are changed).

--YUY1zS9czf83kEFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZqubMACgkQJNaLcl1U
h9AXLQf/aNzj6GO0tVDsn4lAZgwmn9+i5bZOPoYs2VUX+xjqGAgxXGaBHZYGTtQv
x6p5xqPIKZMH0IqOL2t6GjyQsvuxFLZqXSiTgTKUpGQBYzt5yG9HtHIWkQdDBelM
3hXcZHCqYaqIh0eDTcJZcrMfHb4QUJIVXqsa1i2/Oz8oJNDVYTs+NeXtO8V5Z9dp
rpJjtQF61pCwH3H6KaBlAUWcy8qnkA+WrwfgIgBU1lG1UFgmUp4FOTadg45JlBne
zKHGSw9N74vmrNfrCxZp6961JbMxDWFRaHOVNlHlwpjkQwJiDHvWcYjED1L+32YO
7Kp1Dq+eoxoW8dmF1uLF3VVYnyXXzg==
=/g6T
-----END PGP SIGNATURE-----

--YUY1zS9czf83kEFd--

