Return-Path: <linux-kselftest+bounces-34415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DDACFDE5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 10:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A1918922E9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026427A915;
	Fri,  6 Jun 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyHv5TV0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D524EF6B;
	Fri,  6 Jun 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749197137; cv=none; b=qVSYjdwZeqQ4sZ/0pVUrXxd4zhh0tMR8IzHLaoqFHQHZ6mS+I8XUA/Q1R+nN8Pj9v0sFX4ySXAPnVcm5WwYE8jr+oYdbQnEjeY4rZ4d3LHJLqP60PeZOuHmblYJvgMFYO5bDiGMfQ3u+HgLRn2vRfvIjOrZw6Pl91eZQnlo7/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749197137; c=relaxed/simple;
	bh=2+ukVt7ZT/sBmEW2z10tGXejfw+yjMbmy9hjYlP/qvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAvEmJR/1Sb8nBi4ws27JwdniQ3xntJOMLWdPeQvBDmEWD3uDx4HdyofeEmvG0/w3BVORCnL0EsepLLhauk0yMSLy8+6uxFOVVfS05bpsOT/j9xZqSorNn9uwo5PNPVKmhD/+pF6pfUy5Ihc/4h+6DPqWbNCC9lpfzI0mHS44g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyHv5TV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811DDC4CEEF;
	Fri,  6 Jun 2025 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749197136;
	bh=2+ukVt7ZT/sBmEW2z10tGXejfw+yjMbmy9hjYlP/qvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyHv5TV0fw7A2TwPXdNR3B6gHFyovUH291qD/ftkl1u3S0HRqsDN7A5evqljYQfDR
	 ddDzLAbEn1SjcHr66kgmq5nHIiY0P1E2Y50dyHR5BHSfIP8OJB3NU++tPtyQHKO9hH
	 Fwn1gtMPIukScrIn3BPTuzRgaNac1/e4ajeTMLUXfbokpF1uGe7N2s/9TviafBMqkd
	 7sb6+0IQFIxtx2eZ3yiXaaoB0+ZrPFrZUW+WeKbkeDshbEjRIhPx6Nik0l5G67c0qH
	 TgOCXcgh3oxiPoTFE+mG4Uyv6bHyMFczt2w9vhr4UqXKZaGokv9+eFs1sVYrfbkG1Y
	 GH03g4Hd4vxFQ==
Date: Fri, 6 Jun 2025 10:05:34 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, 
	Alessandro Carminati <acarmina@redhat.com>, linux-kselftest@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Daniel Diaz <daniel.diaz@linaro.org>, 
	David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ville Syrjala <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Linux Kernel Functional Testing <lkft@linaro.org>, 
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250606-fat-optimal-jackrabbit-cdbb9f@houat>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
 <202505301037.D816A49@keescook>
 <20250531102304.GF21197@noisy.programming.kicks-ass.net>
 <20250602-phenomenal-turkey-of-hurricane-aadcde@houat>
 <20250603122603.GK21197@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="qoe724hz7swoodx2"
Content-Disposition: inline
In-Reply-To: <20250603122603.GK21197@noisy.programming.kicks-ass.net>


--qoe724hz7swoodx2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
MIME-Version: 1.0

On Tue, Jun 03, 2025 at 02:26:03PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 02, 2025 at 01:13:29PM +0200, Maxime Ripard wrote:
>=20
> > > I can't operate kunit
> >=20
> > Why not?
>=20
> Too complicated. People have even wrecked tools/testing/selftests/ to
> the point that it is now nearly impossible to run the simple selftests
> :-(
>=20
> And while I don't mind tests -- they're quite useful. Kunit just looks
> to make it all more complicated that it needs to be. Not to mention
> there seems to be snakes involved -- and I never can remember how that
> works.
>=20
> Basically, if the stuff takes more effort to make run, than the time it
> runs for, its a loss. And in that respect much of the kernel testing
> stuff is a fail. Just too damn hard to make work.
>=20
> I want to: make; ./run.sh or something similarly trivial. But clearly
> that is too much to task these days :-(

Are you sure you're not confusing kunit with kselftests?

You can run all tests in the kernel using:
=2E/tools/testing/kunit/kunit.py run

Restrict it to a single subsystem with (for DRM for example):
=2E/tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm/tests

Both would compile a UML kernel and run the tests on your workstation,
but you can also run them in qemu with:
=2E/tools/testing/kunit/kunit.py run --arch x86_64

So it looks close to what you expect?

Maxime

--qoe724hz7swoodx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaEKhTQAKCRAnX84Zoj2+
dkuhAX9LyJvmNiSNTxiTi6JgV/sxlSk5sRo97QTw1YnBFIjUT/sl00MRuvKDZFaq
sKRGjvEBf17xAmxt5cStdYQumenD9U2D4emcx7/aZKS7vfTR34g6tAmFa1ggk8Wc
ZpbpxDrD5g==
=TJNi
-----END PGP SIGNATURE-----

--qoe724hz7swoodx2--

