Return-Path: <linux-kselftest+bounces-47714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F8CCC497
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310C330F03BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB882877D6;
	Thu, 18 Dec 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMtqRmyw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A412BDC01;
	Thu, 18 Dec 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067928; cv=none; b=LwrLqIMQ1HWA19UrtageQilKhH6r2Hiq0/LlWad5Gl5tV+WFyUD4Rv054LXg3wmS0kXUlKL8LWjtb3/l122N/jvrG6vZvWTfi9hBuNUh9yUxSSNTA0LBjvB0fRV/ieODhVHPLsPdAuYNWXXctskxOSZOJkoFobFltkeeI+y/igY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067928; c=relaxed/simple;
	bh=r0E2VNvXCIpCx/++TKgBDonkZ7YJUx+FvKeMkOV/3Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6oNW63LMCYwta69dM3+xiKIklHnJctj1er/cCs/NDSua9XxRnAEG/IXuiXolEv4W486c8FzyrqVUSyCMOQsi9pM5A4s0Vdm+SVWJkS57PFfecu01g54C+uLFYDqYZMgawUVKibkAvOWa+EtNK0w7HE9ze5YudR7YdU+qKoeZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMtqRmyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C393C116B1;
	Thu, 18 Dec 2025 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766067927;
	bh=r0E2VNvXCIpCx/++TKgBDonkZ7YJUx+FvKeMkOV/3Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMtqRmywxWmOknyn1jm2k0YQDZSr1Oh+XyzEpnUWWcwyXCVf8gfOI4FcMWWEsluy/
	 EEI5Od9UiaWP7cyRj5F2T3Jx3lZ6QVOKOrAn9BIwAIYOwN3EIvW9JPPLEc9SCOz0KD
	 /cAWpiIlfTiI7aWlYBBb7L//03IZ8bxboBepSEpOc8zOzQuhtiwySjTAgAYQmOtg3m
	 j1C+tkDhrZildjmqO2bExvAD1fWqfeiKSf7EE4C6cw9MJ2+yxn3vKC7BKOov3rcKnA
	 KZ6OGu/PILpJuy5K6WakdBeSCEGhbNpMbfDvnz4l5i7xiA4qez/8+IoEGqgTzkAGIN
	 qBqzNm+4l1dyA==
Date: Thu, 18 Dec 2025 14:25:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH 1/4] selftests/mm: remove flaky header check
Message-ID: <682f64d0-353c-47bb-808b-eacc2d4d6c00@sirena.org.uk>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-2-kevin.brodsky@arm.com>
 <5f866c1a-c8cd-4dc6-b312-9017cef89920@sirena.org.uk>
 <e971e44e-5539-4fc4-8128-0ce9c3d10a38@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b1+frtrHPzRKmdHc"
Content-Disposition: inline
In-Reply-To: <e971e44e-5539-4fc4-8128-0ce9c3d10a38@arm.com>
X-Cookie: Close cover before striking.


--b1+frtrHPzRKmdHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2025 at 02:24:10PM +0100, Kevin Brodsky wrote:
> On 17/12/2025 11:04, Mark Brown wrote:

> > More generally building selftests with random older kernel versions
> > isn't really something that's expected to be robust:

> I suppose that Documentation/dev-tools/kselftest.rst talks about
> *running* against older kernels, not *building* against them. That said,

Yeah, running is fairly normal but huge swathes of the selftests won't
build without current kernel headers and it's not an especially useful
use of time to support that.

> we are dealing with an out-of-tree kernel module here, so the two are
> essentially the same... Yunsheng suggested an updated check that I think
> is reasonable, maybe it is a reasonable compromise?

Well, there's also the selection of KDIR which for some reason defaults
to the installed kernel so we get:

  $ make -C tools/testing/selftests LLVM=1 ARCH=arm64 TARGETS=mm

  Warning: missing page_frag_cache.h, please use a newer kernel. page_frag test will be skipped.

Your changelog says it'll work for an in tree build but I can't figure
out how to do that (using the top level Makefile to recurse doesn't seem
to DTRT either).  Having looked at this more I think the problem here is
that the selection of KDIR is wrong, not the check.

--b1+frtrHPzRKmdHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlEDtEACgkQJNaLcl1U
h9DTXwf+NKcXoL0qH47tIhKzxB1aWsfOAem/OloigbCC3HAdbAnebqErn4V3PyLU
3PUVn9u9QB5XEIPobLqzig0dqOAgPsDtxbz5WhKUo69GKcxGl8h114OjCgQryQ1h
mMFUAhB610D+X83WWgy71GdWQNcZL+UC6jpe4wMZojsjUYL0R3Z6YCyFrU8xL7g6
o8r7e9dYhrNWbsUG60Y7L+293dN56TtyWRcG1iBYHGDgc3MKOFOaNO5GTQCuE6HC
5x2excDax3yLwV9meWrl7h6yH9RJvIeSoBCTHNITSPkbbhKSKIZECwgwzZHYsFGO
KMtV45ue9RSG0bp3BprtIV6bCsb32A==
=dMYV
-----END PGP SIGNATURE-----

--b1+frtrHPzRKmdHc--

