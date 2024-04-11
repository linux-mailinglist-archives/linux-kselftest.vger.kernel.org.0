Return-Path: <linux-kselftest+bounces-7715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7CC8A1BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 19:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CD3281854
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1B13281D;
	Thu, 11 Apr 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFKAUFGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656A132C16;
	Thu, 11 Apr 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851397; cv=none; b=MKHtqLbXypAaG6tyvBz28pC6fMHEWVP0R8lda/BkGRkR6Esdvc9brkjPHW0/YpYENBAC6Y9k2dwM8FvwcyralGaekleNW5+WYBSUWMxaDWDJO/tVkseMLH0HCwxGQ2f6h2NS/ZrZECyDXZi4EwLPlpPE2dpVVkBlF/mgY6V+qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851397; c=relaxed/simple;
	bh=0N+/I5DLiHYV45vZIHFVMpIxTUwvM1Dvt5hV2unXXl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeCTZMc9d1LB/aICa463ULmW6/GBuO/jH2D0mjcQC8plr18gTeiZrCD4b+Fzbpzp1G0MkXI5rWG5qJOZGfXqn0946LzmJBHFsgqF9NThRFmpNhllpfhCWl0347HUSsfaGhZKA6CGl/FHMioskA8UZZadSrDu7s/yAlkwn1dyNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFKAUFGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AE8C2BBFC;
	Thu, 11 Apr 2024 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851397;
	bh=0N+/I5DLiHYV45vZIHFVMpIxTUwvM1Dvt5hV2unXXl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFKAUFGrw3IsxTZbgxXgHhrqdiPFt4v9Xuys1LwjkbvcQ4nQpzeGlA6MhNoZA9QLH
	 YKOK6MZUUYwk8SG18qXCkQKplxYQhM9de8hub1SUyrl4f/mO5xRPGQ3yM1vC+4/BlA
	 f8MWYJPzSGl+8OwZMsqu56+DYgRU33O3vCqa/A6TMmk9qhZLbsUNNPohMdeFMWxi8U
	 v5xypegj0oEEIoOewPd1xIwWvk6boEM/aK3ieOQ4Pjvl03hhrC9cNR35XBD1dy0pbx
	 2y4PGUa+7Hhaq8LzzL4mp9bfBXRbnGrisuNgJBg8DsF9iTA0GcBhKKFPQBcX3PIJJL
	 5n+vxv8H7nhug==
Date: Thu, 11 Apr 2024 17:03:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
Message-ID: <280faf88-9bcd-4f0d-b02a-eb72cbefbb3e@sirena.org.uk>
References: <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
 <87il0o0yrc.ffs@tglx>
 <20240411155053.GD5494@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6X+i8LxTiBMSWKj7"
Content-Disposition: inline
In-Reply-To: <20240411155053.GD5494@redhat.com>
X-Cookie: How come we never talk anymore?


--6X+i8LxTiBMSWKj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2024 at 05:50:53PM +0200, Oleg Nesterov wrote:
> On 04/11, Thomas Gleixner wrote:

> > Grrr. Let me stare at this.

> Damn ;)

> Can't we just turn ksft_min_kernel_version() into

> 	static inline int ksft_min_kernel_version(unsigned int min_major,
> 						  unsigned int min_minor)
> 	{
> 	#ifdef NOLIBC
> 		return -1;
> 	#else

That'd probably work well enough here.  I think it's reasonable for
someone who wants to build a test that uses ksft_min_kernel_version()
with nolibc to figure out how to implement it, right now it's not
actually getting used with nolibc and just happens to be seen due to
being in the same header.

> Not sure what should check_timer_distribution() do in this case, to me
> ksft_test_result_fail() is fine.

I'd go with skip but yeah.

--6X+i8LxTiBMSWKj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYYCb4ACgkQJNaLcl1U
h9Corgf+If9pRewR2Sf7yuBxPHFwhekXG3uOsPuQGQrq/fl0/zgB+V1ToPn9FsrD
+INicy+H4EAfPy4Zr1aWOSJc9O9fsavsvYg59sfnRmYiwSHjQEbIj0ZUSVzEpCRH
39YNs2AEF8MtR0530GNjsDJqYFGdGj/ZCkcgaAHLrvkTWe97LPNaFDhxRfvR6HJz
Y9Dub0bcfCQUt9bg2zGOMzgdll5TF6h2TApiEeedMpS0qO6/uvDH8Ws1gnVlH2dV
HNW/grfhC5too7+GFpDDnBDaWaWD3vWDwuVDcGIWm1Nm9e8Yi1pwjXiGXSRMsBID
8MBmTlnBXsIEKJEnVpTu9zVw9Fg1Sw==
=G3lU
-----END PGP SIGNATURE-----

--6X+i8LxTiBMSWKj7--

