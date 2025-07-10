Return-Path: <linux-kselftest+bounces-36942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B86AFFCA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8973B04AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326A28FABA;
	Thu, 10 Jul 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8cR+ttK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C028FAAB;
	Thu, 10 Jul 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136953; cv=none; b=O3anZkhH8sXEfvkyFpchWTT69SHdtPItnRVtci4NS+6Kk+BP/eoMTyJTOHe8GAh5uhJxv73NEv21xI8yD0hYdmYyrFE3xFvymUKrUmbQ2N5nvwvF7gGjfKvkzrH+tKaF1ZDKhNNwJoUaPnrqXXlj+7W8KvsfPiacsgqJA6NImIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136953; c=relaxed/simple;
	bh=N7lVbkdHA3+AaTIpvBFWHX0SAnOFAgo8RQjZ5xhsVRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBFl2K7oKph1kHdSMo0tixFX/hzYZ+oFAZ0e2Fu2mTjcXcvfV1AV+mygxHJ3B1lHMX53efAy9eSdZ/6SBik0ZXatT81Su/sCF5YoQGV1YxxygztvGuO5zThFe3ymv9miPEQq1qBYeKLClhlFxirVe6W99GdKaksiSV+plJqBrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8cR+ttK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F4DC4AF09;
	Thu, 10 Jul 2025 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752136953;
	bh=N7lVbkdHA3+AaTIpvBFWHX0SAnOFAgo8RQjZ5xhsVRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8cR+ttKHF9yVAYCEUlvjW+JSd+2z+KUMiWHqhXL87CVS/PTXMKk4lH+VBdypmiux
	 fvuZccdAMLh7zUdT+bYBXYEiES1dwoezghRhIGJ8KukUKzbYQksVbfIuUD7KpRnPfd
	 UGm9Z6/B01CQN3mUC7ZIS5ZbLm4MVeZOB5IEDURyJ9vGewFhigSLpMb2LrZos723nY
	 33OO3+q3IUXDa6jcHrC27IZhyEOacXptEU5JAJhOMNn/82oH/cpuRiBnZHCuHfGrOv
	 a1kKcLAqY4BnEyi4ZwutYKe98n8vrmUpFqgvnth/7aNZ9x2GSSjsaULPBDDBPuSAis
	 YgErcO59ZTfEw==
Date: Thu, 10 Jul 2025 09:42:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: wang lian <lianux.mm@gmail.com>, Liam.Howlett@oracle.com,
	akpm@linux-foundation.org, brauner@kernel.org, david@redhat.com,
	gkwang@linx-info.com, jannh@google.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
	sj@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Message-ID: <aG9889HWQ8K24z5w@finisterre.sirena.org.uk>
References: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
 <20250709123224.6593-1-lianux.mm@gmail.com>
 <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HMq8UWvlx2E25A13"
Content-Disposition: inline
In-Reply-To: <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
X-Cookie: Who is John Galt?


--HMq8UWvlx2E25A13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2025 at 10:46:07AM -0400, Zi Yan wrote:
> On 9 Jul 2025, at 8:32, wang lian wrote:

> > Thanks for testing the patch and reporting this build failure.
> > I don't have an arm64 environment readily available for testing, so I
> > appreciate you catching this. I suspect this is caused by missing or
> > older userspace headers in the cross-compilation toolchain.

> Right. My /usr/include/sys does not have pidfd.h. IMHO selftests
> should not rely on userspace headers, otherwise we cannot test
> latest kernel changes.

That's not realistic, we need to be able to use things like libc and for
many areas you'd just end up copying or reimplmenenting the userspace
libraries.  There's some concerns for sure, for example we used to have
hideous problems with the BPF tests needing extremely recent versions of
LLVM which weren't available from distros, but just saying nothing from
userspace is a big blocker to getting things done.  With some things
they're widely enough available that you can just assume they're there,
with other things they're less standard so we need build time checks.

OTOH in a case like this where we can just refer directly to a kernel
header for some constants or structs then it does make sense to use the
kernel headers, or in other cases where we're testing things that are
intended to be controlled by libc it makes sense to use nolibc avoid
conflicting with libc.

--HMq8UWvlx2E25A13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhvfPMACgkQJNaLcl1U
h9CImQf/Qotd6O/HXpyLcvS62Q/sJq8PY9vqEKgtMwJiL4Kh1ix8b1qyKqZyXQwp
gLgU8WKUsgQccOUaRsyiUP3guh7d4WgmbOdNZDsvUOP0OkJ/GQmyL/X19mZptqKR
hlvVhP8qRiI0BxVlpuEU6QxeSJZuilN2p9NoRwAGHNoOKb4E8lLZFlFS0w8KvO4Z
NekttHHsY6wwSZlgiPzM2bRugoYQ7XamUQDm+mjH+3jY87FWFGeR7qA7Zbhuh2Ec
HV3HMVJk5azHp5HeKUtMy9TyPxq/fnT6rtvC4Chz8nVNUD7hUWCHPZzEu0hZNiJF
G0oep0VX3ZcNRFem90bLQ5OrkR8ZcA==
=xV34
-----END PGP SIGNATURE-----

--HMq8UWvlx2E25A13--

