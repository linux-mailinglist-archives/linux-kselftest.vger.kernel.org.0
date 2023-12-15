Return-Path: <linux-kselftest+bounces-2037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882D8814A90
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A11F23516
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9821117;
	Fri, 15 Dec 2023 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhPrOeQo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A70EC4
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 14:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3542C433C8;
	Fri, 15 Dec 2023 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702650845;
	bh=ZiRZ4YjATu4TGrrKZlDXFW1sERrTfcilbkwjLebC+1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhPrOeQoRqHRz0kUU4cke1C6faEtavQOIgpEiouI3hPsl7oYpAJwa55CkME0XsFt8
	 DolOMwqGztxD0xCtrz4Ac3I8DRf692BVPO+1SFGdqV3o+y/J7zhBpz/cRnDlCX12BF
	 Hr+keIdGMLqf8K6ePveZL5yHVVw9+XAW354H2iZgP1zbc0AMAF4Q/9TtoFPMg3BWHl
	 YmGluZBc3pqhkQh6Rf11B8GhAnG9RQDfiYQulMcPJ1oS5Zn6bXJQfKts3K0VTCBO63
	 W9QdKfAx5LLnNPeT128ci+te1i/aMKON7B76HIMj3QGqXpWxUBrOpGxPhbkOjpq+Mj
	 OgJ2Q51jintrQ==
Date: Fri, 15 Dec 2023 14:34:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Message-ID: <c52cf127-2a2d-4541-851d-ba9da666c895@sirena.org.uk>
References: <20231214162434.3580009-1-ryan.roberts@arm.com>
 <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
 <71228821-cbd3-4a3c-9ed5-18f6d5ebcfc0@arm.com>
 <07193932-941d-46f6-b152-d6c5fe09b26b@sirena.org.uk>
 <76abe3b9-3f66-4336-b09d-d5c137ff6582@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3JgyYHagcl08Y53"
Content-Disposition: inline
In-Reply-To: <76abe3b9-3f66-4336-b09d-d5c137ff6582@arm.com>
X-Cookie: PARDON me, am I speaking ENGLISH?


--x3JgyYHagcl08Y53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 02:28:32PM +0000, Ryan Roberts wrote:
> On 15/12/2023 14:08, Mark Brown wrote:

> # -----------------------
> # running ./hugepage-mmap
> # -----------------------
> # Returned address is 0xffff89e00000
> # First hex is 0
> # First hex is 3020100
> # [PASS]
> ok 1 hugepage-mmap
> # SUMMARY: PASS=1 SKIP=0 FAIL=0
> 1..1

> If you think the latter is ofensive, then I can do the wrapping as you suggest.

I think it's fine here - it was more of an issue for ftrace.

--x3JgyYHagcl08Y53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8Y9gACgkQJNaLcl1U
h9BYZQf/VfwL2QFJmNtLII1VwPsS9E48jEQlqys2bwW0a/kHlNuQ/dpRbTR1EeX8
U01C1FpTQN4PyhC8EikPxc6cs7yDGbcJ8kSxVhFkL22gT2fpIp5M9DsNrzWk1Or/
9+RoyMJrH/mV0uloAt/34Ermwk4ZoxLwnlxSaZydEKiCGXnw5X0AMhA9Q31YBtg4
P1dGJVHxxrqdq18Eznke2wScLchQ3LxGqI04Rboz1JKAONxla9MFy+rJV3EpIKa2
4AopkbsltBLl3xS86VC+/5MHS+69+/8PK8ZnJUH6+wMysXleaiZevURiK4NiU+ji
lp+GYcBv6cHcORZNN0gfDCK3v0Ah5Q==
=AzXJ
-----END PGP SIGNATURE-----

--x3JgyYHagcl08Y53--

