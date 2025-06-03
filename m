Return-Path: <linux-kselftest+bounces-34223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCC2ACCA0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940A2188605B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709BD23A990;
	Tue,  3 Jun 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFsrjOn5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46954231A55;
	Tue,  3 Jun 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964146; cv=none; b=cWqBIBNE8dKNYWQ4DQJfTC5+rzCXNUIDo+whVC2cyvA0+y4KNh4UQjPpyGoJ5RD/KiUvChDpOal9P6er8sQ85OE84wBhUFRk+f4F53v/msDSguZiabOZ9U6iVfGlEWbAdmUPScjGQftHHYSyKSUBHKcHSsGy5ho1YIsHeVfLxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964146; c=relaxed/simple;
	bh=0hTLQi0oAwCP5NrLU1AZ6DJvGLwP+iyJza4JG77lOJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl9qUaAK6n01gcGSZubTCdZsL5dzcISfAbRncmPjmSigpPewnmNXrnGuV4ut7Mvce+sS7U37PItJuA+Md0m3CEYcBt3fPr3ywjGZH1zsKgk0drZyd/GYgOYpz94ezebylWOK8IN+1oFzwfUkufWRHwT3dT8ge33/QLj3aZSwRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFsrjOn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE31C4CEED;
	Tue,  3 Jun 2025 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748964145;
	bh=0hTLQi0oAwCP5NrLU1AZ6DJvGLwP+iyJza4JG77lOJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFsrjOn5vr9Qx6cv8CU2jpKkc9VU0PPSyinAwF+o5qu8Xq5NtS8oRk0goJY0ZNVYD
	 JVMgwbUq4EYAtqOf4sa1+QDPK8JMLU4/1lIwpL/MTNWtW6y+LLcDZSFB2lBf2HOfye
	 ifpAS8qF1RIX2CVPUEbInQK/GMp72nwToZxhfG4VESJ3VrL1vZQEjCXD/WxGEp4ra3
	 uWA4wLFceuKfXmZodfLTfWAcI1g56Zw0ScbrxosOL00SzJnQCIPlNASgq7yrCxqLNJ
	 eOGfx4f19K6S2PofASc0rGGXA0hfIBNtOdseoF3I3VOWGqoP6Ukr3r38BH20DNRKzZ
	 1fN+FI5xeCauw==
Date: Tue, 3 Jun 2025 16:22:21 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
Message-ID: <e1d20dbf-734f-4a2c-915a-86c9fbac998a@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
 <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
 <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
 <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
 <df85fba8-826f-41fb-8850-077a4e4dd240@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vzYPTz+0185M4LPA"
Content-Disposition: inline
In-Reply-To: <df85fba8-826f-41fb-8850-077a4e4dd240@redhat.com>
X-Cookie: Avec!


--vzYPTz+0185M4LPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 05:06:17PM +0200, David Hildenbrand wrote:
> On 03.06.25 16:58, Mark Brown wrote:

> > Like I said I suspect the test name is just unclear here...

> I would hope we find some mechanical replacement.

> E.g.,

> ksft_test_result_pass("No leak from parent into child\n");

> becomes

> ksft_print_msg("No leak from parent into child\n");
> log_test_result(KSFT_PASS);

Like I've been saying this is just the final test result, in this case I
would expect that for the actual thing we're trying to test any
confusion would be addressed in the name of the test so that it's clear
what it was trying to test.  So adding "Leak from parent to child" to
the name of all the tests?

--vzYPTz+0185M4LPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg/EywACgkQJNaLcl1U
h9C7RQf+NaJb8aic+VrkqhBtJNm1XQMiWUrS35SXFbO6qEGxn5oQanJY13y3xyky
/wQsVQhd2hLb1Zin1X6CINnGYyYMdyTIxpxXzTw72Q5DB0DSK46/7oRZTqPgiuIh
aHjF9pBHNRQVZvsuhzGJOu3yHbilan4LEjp1ZawjyudxZOyDyW477RJYk+WrE8iu
f5ptoGT1Eukrm2ZmdEI51GIvRxtx1K0tVYQN2nTqzb2gzQS4u4vuPNpZhn5uPMBU
8Gf0VDRL3hVckY6XbYIhZwIjzSee6UJe0UudgmwilChz+K3C8kQQ5k+Ia1PYIgNZ
q4LsgYvunzKlJK1b9QA4BJmrJ1506g==
=QnWD
-----END PGP SIGNATURE-----

--vzYPTz+0185M4LPA--

