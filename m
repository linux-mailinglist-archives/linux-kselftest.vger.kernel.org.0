Return-Path: <linux-kselftest+bounces-18113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4785097BCEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 15:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD11C21330
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492918A6B7;
	Wed, 18 Sep 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh/xU5S1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB25189F5B;
	Wed, 18 Sep 2024 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665506; cv=none; b=axCe8GqD6pFSedZGDi6Ta8rVX5bW2/TII2YXubtda1iFmj2yTMV9OjpP/uIOGrrPh0aEj67/c0LKB8Lay+HvGxKzlKlS2iGN6wj2ske927PM/wnK/H8dskPxOZjlst/kTsQMpGRHTBJ5FTqVc4kbqqfYVXxb06so38ebr0cTga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665506; c=relaxed/simple;
	bh=KOHe4DkxWPpMPzEVfB3CEawAqwmw6QSxmlJeI52pIoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8cA/NIcLLSCCc7rglKnzSrgHKVWjHDWY4RXlYbgAO4yaYJ2SViM84F2s6KTl7N9H6fLR0bfrx5h286yk61rXXYmeYIggVGX5Dcu9N52ojxA4g0CSSSuNZIfYdrvF64EkRYUVVyI+8yOhkJNcGDzRoE280GDAU6CFiSAtw0HnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh/xU5S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D423C4CEC3;
	Wed, 18 Sep 2024 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726665505;
	bh=KOHe4DkxWPpMPzEVfB3CEawAqwmw6QSxmlJeI52pIoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dh/xU5S18W8bmrdGiQsgjQDFh4MbnzV/26SPABn5L+f1AudLfNt6FLiTfsMkwixGj
	 j2zyQMnjx5cZFcHyqoZ82ScavkOJmoyuVI7BAbyqsjDBnfmoQyAGO9IfM/2tUVLkSZ
	 w+CtaxZ+UvzYAWq6Jw9AM6Mz4HymaXyBrWwi7b9OQbZk0zkiuFH2RzsXPf52LLXUwz
	 3F7QjcbmMUgq+HB2OXZUevnlcKG/czdIg4IBj5ys8AHNbdL4a6yYJCscSkNit+DHcO
	 zk6bkd87G2iKnBPDcVJ28BvlOlqQJTZN8uIX/txubNN6KWF+k2pFxcjAfwzphYat2t
	 Mg8jKMjEH0Zag==
Date: Wed, 18 Sep 2024 15:18:21 +0200
From: Mark Brown <broonie@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
	willy@infradead.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
	rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <ZurTHc1C27iqofjp@finisterre.sirena.org.uk>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
 <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t9zZ3Q/TxVJgOE8I"
Content-Disposition: inline
In-Reply-To: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
X-Cookie: Editing is a rewording activity.


--t9zZ3Q/TxVJgOE8I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2024 at 03:50:00PM -0700, Jeff Xu wrote:

> Even though the number of lines is large in these patches, its main
> intention is to test Pedro's in-place change (from can_modify_mm to
> can_modify_vma). Before this patch,  the test had a common pattern:
> setup memory layout, seal the memory, perform a few mm-api steps, verify
> return code (not zero).  Because of the nature of out-of-loop,  it is
> sufficient to just verify the error code in a few cases.

> With Pedro's in-loop change, the sealing check happens later in the
> stack, thus there are more things and scenarios to verify. And there were
> feedback to me during in-loop change that selftest should be extensive
> enough to discover all regressions.  Even though this viewpoint is subject
> to debate. Since none would want to do it, I thought I would just do it.

> So the Patch V3 1/5 is dedicated entirely to increasing the verification
> for existing scenarios, this including checking return code code, vma-size,
> etc after mm api return.

> Patch V3 3/5 are for unmap(), during review of V2 of Pedro's in-loop
> change, we discovered a bug in unmap(), and unmap() is not atomic.
> This leads to 4/5(mmap), 5/5(mremap), which calls munmap().
> In addition, I add scenarios to cover cross-multiple-vma cases.

> The  high-level goal of mseal test are two folds:
> 1> make sure sealing is working correctly under different scenarios,
> i.e. sealed mapping are not modified.
> 2> For unsealed memory, added mseal code  doesn't regress on regular mm API.

> The goal 2 is as important as 1, that is why tests usually are done in
> two phases, one with sealing, the other without.

That's vastly more detail than is in the changelogs for the actual
patches (which are just a few lines each) or the cover letter of the
series.  I don't have the MM knowledge to assess the detail of what
you're saying but I can't help but think that it'd help a lot with
review if all this detail were part of the actual submission.

--t9zZ3Q/TxVJgOE8I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbq0xwACgkQJNaLcl1U
h9Bb5gf9HvuDNv8AbcGEzO+8ZQVVGlBGUXahiFFNylLhIRpt0rJ+ZSpxamPviKMX
Z8Ab8ByYPhR6dkRdKHPFdKf1oe2EVQ2vEZjygtPbrrKHmV6oVj3syK69kTvacQUC
Q9+6cm1vsKi5BgaTB3JFrqVbVce5h9hB5++WnLtz/B4Eg+d9Phvbk/YS9nzfN0wS
MbB8DV5Xg2UOnV22hDua2WGQ48IY0pY8RUKgnZxpOwSSXDNJDJ3RJIkXF6s/RqC/
ck4M9EcxicevWhGI6TnO5k5enDRPLMPstK94jpbamYSswPTOZLrzaZPha8H6euES
h7L14up0NhGMSHaZAXsuAVP3yb0lCw==
=n6h7
-----END PGP SIGNATURE-----

--t9zZ3Q/TxVJgOE8I--

