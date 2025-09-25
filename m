Return-Path: <linux-kselftest+bounces-42365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45129BA0BA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C914A0E2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6022D4F9;
	Thu, 25 Sep 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT6pw6+g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1384C81;
	Thu, 25 Sep 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819675; cv=none; b=KORu62zi9JCgEGdCk3EIB9FEWr8KcHuLNK1ijnpDnzaJt4rVMPOuYmcC9Qs0stuLozyHB03K4SgeophWYAyqraxkX7+6sVM/X1nEbu+E6gwu0PWk2hd5/DLuSIjcWmGjLvLuth38gtGMvCbVihjZGt2fZARrpFTKqIH6zSbCZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819675; c=relaxed/simple;
	bh=O1Q9AD/Y0daQmPvqlI9fuDLvv2ewhUT+6wpWRDKQqr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVTpFaQMnWKyr5cvhM51XIdHGV1mqlnFgAAfBoNAbXSkt7gXOq+Ekgok5YBvtvuf/20QX2DVyZ7ppIYwhn2220NV1hf5Kb08r2z6ZUcHsZVKe43VwOGyim2CxSj4i1z0vVehUa4sPftImG49tMrTKQR6+Zk7zq+75C7HkeLGvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT6pw6+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C938C4CEF0;
	Thu, 25 Sep 2025 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758819674;
	bh=O1Q9AD/Y0daQmPvqlI9fuDLvv2ewhUT+6wpWRDKQqr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iT6pw6+gWV8s3l5E4cZeQbmxqmeklnwdSowwMU7NvSCLlTBEkwlQk8668NkNmecpe
	 IaGAgAmwoVM95JQJ9Bi7gFJppo8Q3BuGbgJAPvQMtUA8Ts5v06LLcOirvc1rUrXhyi
	 4qQvdUqI8kGdmB04ByWVSjSUVOtNzo8A3OaHkC5RXVCbNHZ6cPW67LuXFQtzUag0Vk
	 1dVzQQ7lVv8SDPMiZf8kEH++jMl4uIQrxdQvyEfXEmhNhecIaLO2TjS5ra7+dK/Yzb
	 X6ewLT22p6QlXt2nm1OGYZdfwGCfQKGTKje+pt4HjJldlRgVWrqMxlRD/cDKfuD2GY
	 sZ/52E292BsEQ==
Date: Thu, 25 Sep 2025 18:01:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	Carlos O'Donell <codonell@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Szabolcs Nagy <nsz@port70.net>,
	Rich Felker <dalias@libc.org>, libc-alpha@sourceware.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] arm64/gcs: Support reuse of GCS for exited
 threads
Message-ID: <38d629f2-99bb-4b13-a6ed-a4126d130b1f@sirena.org.uk>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <20250921-arm64-gcs-exit-token-v1-1-45cf64e648d5@kernel.org>
 <aNVx9vlgi8t81V6Y@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3c3n0rvpVVOjrHBw"
Content-Disposition: inline
In-Reply-To: <aNVx9vlgi8t81V6Y@arm.com>
X-Cookie: Shipping not included.


--3c3n0rvpVVOjrHBw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 05:46:46PM +0100, Catalin Marinas wrote:
> On Sun, Sep 21, 2025 at 02:21:35PM +0100, Mark Brown wrote:

> > +	} else if (task == current &&
> > +		   task->thread.gcs_el0_mode & PR_SHADOW_STACK_EXIT_TOKEN) {

> I checked the code paths leading here and task is always current. But
> better to keep the test in case the core code ever changes.

We can't have scheduled?  That's actually a pleasant surprise, that was
the main hole I was thinking of in the cover letter.

> > +		/*
> > +		 * We can't do anything constructive if this fails,
> > +		 * and the thread might be exiting due to being in a
> > +		 * bad state anyway.
> > +		 */
> > +		put_user_gcs(cap_val, cap_ptr, &ret);
> > +
> > +		/*
> > +		 * Ensure the new cap is ordered before standard
> > +		 * memory accesses to the same location.
> > +		 */
> > +		gcsb_dsync();
> > +	}

> The only downside is that, if the thread did not unwind properly, we
> don't write the token where it was initially. We could save the token
> address from clone3() and restore it there instead.

If we do that and the thread pivots away to another GCS and exits from
there then we'll write the token onto a different stack.  Writing onto
the location that userspace provided when creating the thread should be
fine for glibc's needs but it feels like the wrong assumption to bake
in, to me it feels less bad to have to map a new GCS in the case where
we didn't unwind properly.  There will be overhead in doing that but the
thread is already exiting uncleanly so imposing a cost doesn't seem
disproportionate.

--3c3n0rvpVVOjrHBw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVdVIACgkQJNaLcl1U
h9DKLwf/ZZs+qbNGg0ahxmWOTIgk8umedSfGIuB6yoLJVkgIjRv+fhkm19+a7ih7
cBVeUNXJQc6SnE8sBnTU3ETo7CAK6lcnKJI/auXKN2LbKuc2Aw95tYmF6g1JRs8j
Mby5a2btMhAc2gSz5Bz+mmGY34D7cfYOn6rtF5n0dhNnWIbuh0zNvuRXooR8barG
d74uA5v3XTsGbKnSXLYJJjFqbsysAXlFz5XVq0P/ZWNm6zWzeGF6oj+F+AGSXI+8
4A9eMJl0mZ8VVVNcGcYP+qw0l2L8jLOWUrPc8KFCW7aKlSZwjtbWVY7so5ikHHNd
0iI/PRPttN4lzP5lojrLGvLOCoQ4Kw==
=YY2v
-----END PGP SIGNATURE-----

--3c3n0rvpVVOjrHBw--

