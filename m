Return-Path: <linux-kselftest+bounces-2031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE98149B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBEAB2109F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132B62DB8F;
	Fri, 15 Dec 2023 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDd1hVLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35C2E623
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 13:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9854AC433C8;
	Fri, 15 Dec 2023 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702648451;
	bh=PfST1jdzhxOAteHkX/4wywKOjFP7hPGJ499h5PgtccM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDd1hVLTE5QHaHhTZRN4PvozaEVV1AmCPxz6AuNirY1GRfojrTzHgFcOdlSEyMq5t
	 Nd1V6jYntCPlDRpwjr+4WkfQqTABI4xRxuG+7hn2x8DtwYBHgKYo3p3A7TvgM45egd
	 z1PBCf/M68ZkBK6gJvnY6OU/NTOadJSD2YEpMrbIzc33pKDZd2ymafzN1X7u1uG4kL
	 A3IKZEzeiabD4lLDOSdW4B680Vx7Ca4MAewqttMd3rGdYcKCImxxIuGYPbUDP3NSKk
	 1OQuZ4iz+bri2B1gSSvsAt94SrvAVxKsM/aXoSmaHqYC02JW2ggikVZuSJkmvvtme0
	 JBLt+RV1kgvPg==
Date: Fri, 15 Dec 2023 13:54:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Message-ID: <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
References: <20231214162434.3580009-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rv2JuR2krLZfp0G5"
Content-Disposition: inline
In-Reply-To: <20231214162434.3580009-1-ryan.roberts@arm.com>
X-Cookie: PARDON me, am I speaking ENGLISH?


--rv2JuR2krLZfp0G5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2023 at 04:24:34PM +0000, Ryan Roberts wrote:
> When running tests on a CI system (e.g. LAVA) it is useful to output
> test results in TAP format so that the CI can parse the fine-grained
> results to show regressions. Many of the mm selftest binaries already
> output using the TAP format. And the kselftests runner
> (run_kselftest.sh) also uses the format. CI systems such as LAVA can
> already handle nested TAP reports. However, with the mm selftests we
> have 3 levels of nesting (run_kselftest.sh -> run_vmtests.sh ->
> individual test binaries) and the middle level did not previously
> support TAP, which breaks the parser.

Reviewed-by: Mark Brown <broonie@kernel.org>

> Let's fix that by teaching run_vmtests.sh to output using the TAP
> format. Ideally this would be opt-in via a command line argument to
> avoid the possibility of breaking anyone's existing scripts that might
> scrape the output. However, it is not possible to pass arguments to
> tests invoked via run_kselftest.sh. So I've implemented an opt-out
> option (-n), which will revert to the existing output format.

What I did for ftrace which had a similar situation was make a wrapper
script which invokes the test runner, make the test runner a
TEST_PROGS_EXTENDED so it's not run by the kselftest infrastructure
automatically and make the wrapper a normal TEST_PROGS.  Neither option
is especially lovely.

--rv2JuR2krLZfp0G5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8Wn0ACgkQJNaLcl1U
h9CjPwf/cdFp1eTRgPPag0UWpm/AWBET2FW0ZyA+FmQzYiPHI/P8Y8PqBQ1Kv3Ba
fNl0WRn1C4TNd5RhpjYWXqcLnd+aLZ0hsF22GuXo/lu6sTLz6AbZ+YyAa27vXZqO
hiH8TriNzHwGrWolo+rIxEHoPlIBiX6TWORSTIZwW6tMHHq4z01XduvTnYrknX8l
cJMM7lSmML+0jzUce0tSw7iaKtIhhcK9jthZaHnwkf5jZIpxH6TTtSU4I1hHgfBb
ZDmKai3mOcpHxUlLj0+lp0uju/TNgr3CDNvLPfh7UxIQy+hEkaZgH4XHsU7WdOh9
tJnXBcqtIASP5QRyVeKvyJ5rLPxsLg==
=cTyH
-----END PGP SIGNATURE-----

--rv2JuR2krLZfp0G5--

