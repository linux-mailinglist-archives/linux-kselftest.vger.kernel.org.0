Return-Path: <linux-kselftest+bounces-37073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D650B01673
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467C85C21CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F4212FB3;
	Fri, 11 Jul 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFZETary"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096520F07C;
	Fri, 11 Jul 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222904; cv=none; b=AmXnZdFLR2/M6Byt7MZmT3oCdUj6eCWzCxG2PtcnRJyfix81HAy732dvc6Z6PCPM8R9zTuAkR40FOouOMD9Rkz2QUWDpI5cvl+/Pe/faxxV4MciHGbNPirLRwo6eFIhzPOvnfjvvAT1JS8z2Eqgb0/VaAFtMHtAopeevrhUylwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222904; c=relaxed/simple;
	bh=TAy1v2ajYNRGrEGIYaOIVT0gQxyBaqDqSGRU+ULeuMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU7SD5x4KV3NX5PNBIPZ8+lMvhMvgcE2mI+SFLnJgqLoBf22hDyGTcFl1QmiaWlC8TagcnpBYhwF0fr8kfP7CmNl+NgjfMVPYCTLo0ZgFupkx0e2WGxdNwfwS2M3AFc3PKMa1CcR3TxN3cJ9KLRm96otZ1wAcWlFPewMYGOqGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFZETary; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F6BC4CEEF;
	Fri, 11 Jul 2025 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222903;
	bh=TAy1v2ajYNRGrEGIYaOIVT0gQxyBaqDqSGRU+ULeuMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFZETary2Wmb/a1YyTnhMYE2rTNLLfWVHnGKdyQK5sEUkqlK24B7htHKckNKFz+Ej
	 tzsjFbkN2tC9otJUNuBT2X3hBzPQiGjUGzu5L2O74fKJblieiceWp8QJc2nCW63p2n
	 Rej2kDL08IPeiPwU3LPwVuwbmdL/e8AhbWC8WkqpCQM8drQ6A4d8a2mlc0E7S+ej06
	 KXIIzT7CVpelZxEXOpv5eOVRX/QZSIWKP57uGwYSiKZSomwx9q6dZ2/1763jvR0MxP
	 tMWXK15cBQAVfaO3HufN0I7NwTjKksXmFZgxun8DxMSrEo/SjJRtKQg/wqNvQc6XoG
	 1APe+34jXP8KQ==
Date: Fri, 11 Jul 2025 09:34:38 +0100
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
Message-ID: <aHDMnogm_EOx4oMU@finisterre.sirena.org.uk>
References: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
 <20250709123224.6593-1-lianux.mm@gmail.com>
 <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
 <aG9889HWQ8K24z5w@finisterre.sirena.org.uk>
 <D536C704-BE27-43CD-AB58-4F55A7C97C9E@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HI5VLhoBXNGsODFu"
Content-Disposition: inline
In-Reply-To: <D536C704-BE27-43CD-AB58-4F55A7C97C9E@nvidia.com>
X-Cookie: Do not cut switchbacks.


--HI5VLhoBXNGsODFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2025 at 12:28:13PM -0400, Zi Yan wrote:
> On 10 Jul 2025, at 4:42, Mark Brown wrote:
> > On Wed, Jul 09, 2025 at 10:46:07AM -0400, Zi Yan wrote:

> >> Right. My /usr/include/sys does not have pidfd.h. IMHO selftests
> >> should not rely on userspace headers, otherwise we cannot test
> >> latest kernel changes.

> > That's not realistic, we need to be able to use things like libc and for
> > many areas you'd just end up copying or reimplmenenting the userspace
> > libraries.  There's some concerns for sure, for example we used to have

> Sure. For libraries like libc, it is unrealistic to not rely on it.
> But for header files, are we expecting to install any kernel headers
> to the running system to get selftests compiled? If we are testing
> RC versions and header files might change before the actual release,
> that would pollute the system header files, right?

Right, for the kernel's headers there's two things - we use a
combination of tools/include and 'make headers_install' which populates
usr/include in the kernel tree (apparently mm rejects the latter but it
is widely used in the selftests, especially for architecture specifics).
These install locally and used before the system headers.

> > OTOH in a case like this where we can just refer directly to a kernel
> > header for some constants or structs then it does make sense to use the
> > kernel headers, or in other cases where we're testing things that are

> That is exactly my point above.

What was said was a bit stronger though, and might lead people down a
wheel reinvention path.

--HI5VLhoBXNGsODFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhwzJ4ACgkQJNaLcl1U
h9C7egf9FmlKl+ceVeTLDerFTWBe1c6B4gT5syI3bD6wP/vgY4VLzggDjc0Artgp
+DOtkHndeNo9/Ie9kttstdqWkkfIyDnhMSDMlNbRZlY+HXlszEHTpjiPryr3/MtM
6UD1jp0dxAFRkiywNwWI3enPqLSukLLUOA6GYYz8oVFR12xZJ+/SHRgzIh6lITZe
BNGvKR2AYqsXpfJi3Cbs/Phr7AhycV1qMhGAb7WKiX9ckPskxfqAP6cnvJFUix0Q
jrNqEMCefKvsZAOSIzgYJCiBQGTtJs7fHPZef8VtZvZRlFImtWHC5spGxAG6UCPL
p4Kcj9xuI4xPBmciCtyIyLDxJNe6nA==
=brBx
-----END PGP SIGNATURE-----

--HI5VLhoBXNGsODFu--

