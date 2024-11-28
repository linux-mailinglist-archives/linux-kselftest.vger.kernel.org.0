Return-Path: <linux-kselftest+bounces-22599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B549DB7DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 13:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72263B20A96
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309A519F11B;
	Thu, 28 Nov 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX6cRumk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926B19DF75;
	Thu, 28 Nov 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797884; cv=none; b=NPDr/asoklJLGDuug8vwsC0rFF2UUh2Y6Sxe1RMSTAmurobTCicj4zoU9oRnb66aoJlwEmAxqfdPhPVNq6F/QLThzqpZKgps609IkPBtugipO+u5saVxQFQc2h3/n6N8vZWH27HdXEL1Zxw5fxfXdrLvm6stxBCE9e5QmwOwGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797884; c=relaxed/simple;
	bh=j/RUrsTokEv/goAQcc7EU9RZkjPgdJBbW2tnd6jjncY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btnTrL4SFaTilJ4ai0ipUSHBP1MIapTyO7YJBGPnukq56GUytnT0Batm85lr6B8vPN8+FgM3SwN+e9TF/M4PuvAPuCU7BuuIJFwWeP4L/QMKmz1orb+8LO1aLrCwa2ujbBFSUQ3elR/LTomZnOBHpwJ6fgqJ5RIezwInGUCq1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX6cRumk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC08C4CECE;
	Thu, 28 Nov 2024 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797883;
	bh=j/RUrsTokEv/goAQcc7EU9RZkjPgdJBbW2tnd6jjncY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WX6cRumkYoKwiF5XINtX56jxKqES0NXeJlxRQVFQktDVZ2U+Gbv3UzDTzkvJ6jhG5
	 7lP93ZzbFrGBDYpwY94IL5V3X/JlmAMFyHs/I1W+4y4hWk5TT0vavVJbvsfjw8YFln
	 kC0huIQuuBgYOtWnpYU/lVCrGu1xRMcpaqpQmBBzlCPvkGsEgHCkmCxj2zAwLw+cSz
	 Yi/LcbGYGICj8bbTnz30rIQMSCZcd3RiFwB5Aafljiuakm8K5Ow28lrxh0737sL4H9
	 LhcZ5OVaeyPsAE7q/R9fAcME2q/y622Sm1ax0kb+RbIZg2ubxNf9PYMtMMwbLnB5pW
	 ICX5NHE3DyuLw==
Date: Thu, 28 Nov 2024 12:44:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: hugetlb_dio: Fix test naming
Message-ID: <ed5c2cd6-9090-444e-9da1-9d8c7376a6e2@sirena.org.uk>
References: <20241127-kselftest-mm-hugetlb-dio-names-v1-1-22aab01bf550@kernel.org>
 <8174031c-b9b1-4e32-806e-28f1b2c1dee0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z/cBFCxrNXEw7+kf"
Content-Disposition: inline
In-Reply-To: <8174031c-b9b1-4e32-806e-28f1b2c1dee0@linux.ibm.com>
X-Cookie: Close cover before striking.


--z/cBFCxrNXEw7+kf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2024 at 10:46:56AM +0530, Donet Tom wrote:
> On 11/27/24 21:44, Mark Brown wrote:

> > +	ksft_test_result(free_hpage_a == free_hpage_b,
> > +			 "free huge pages from %u-%u\n", start_off, end_off);

> This test allocates a hugetlb buffer and adjusts the start and end offsets of the buffer based
> on|start_off|  and|end_off|. The adjusted buffer is then used for Direct I/O (DIO). If I understand
> correctly,|start_off|  and|end_off|  are not free huge pages but rather DIO buffer offsets. Should we
> change this message to "Hugetlb DIO buffer offset"?

Sure, so long as the message is consistent it doesn't really matter what
it is from the point of view of the tooling.  I also noticed while doing
this that the test doesn't verify that a huge page is actually used at
any point, I was thinking about doing an incremental change for that
too.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--z/cBFCxrNXEw7+kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdIZbYACgkQJNaLcl1U
h9C08Qf/QR6MqwPfTrV/mEHoacgG9N00oq7AcUOZ6Xsnu7fnyMDrIWHYCFotfqoi
LrxdsOgSfgTNNbvnurxKAN3/mg93DIyg2Nc+J2jzU13U2uAHwhtlWXmUm8Jd7enS
eN/AKMHNcewMjqjYY/O2arjwNaaJ08w7f78b6EuuaLezvUV6wsSBkqOTt0RWRBeV
0OMo8kDYGBfvKpYPTRWv1qzkQ4YxDfZ8gsGAyfsFUWWrczatbew07JezuOIcdtlX
hb1a5hOd2PnvKDTkpo6U8rCrJvOwSlGPG0uj80lk2m6cmp3XGgMH/BIllXkynuAV
pRwWm544pzgNMD+bvbqHr0+yMWTXDQ==
=BFDj
-----END PGP SIGNATURE-----

--z/cBFCxrNXEw7+kf--

