Return-Path: <linux-kselftest+bounces-37076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9EB017B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 11:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33797BA5EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED14C27A107;
	Fri, 11 Jul 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SScJ1xeK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DE128395;
	Fri, 11 Jul 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226187; cv=none; b=L49hkLhHQwIzq6omsWF3KQ6/IC43js3c2g5nv5MEVgAs3Va6u0jGewLboBV+lZtEYiSf8H7xOIWMT/LHvMOwMPhXg51IR3x/kMRbyFJJRsAGZCg934YYwWG1suRUgVOamT2pORj9yF3HhQfNz+82Lp1jdMkAueyALyJtbulQ+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226187; c=relaxed/simple;
	bh=ZAZ+5Y11qKAvm1dXLvYH4qKO4T6pRKgWPUaiWkGhIqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmYojdk6SVpHVLe61GAGwl67mb+Td88b0QkmYSlCvkAXVJFT5jzNyu8fWKs8J2+Ara94/clDJoQP7rlZ69d2nsy43pjfXglg8GgtfRF7evWcVq31klZqL4+HV57E4e0QGBuhzh7zHeQMBIy7xEfztEVJZWiePFKbYUT4s+6gGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SScJ1xeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E201FC4CEED;
	Fri, 11 Jul 2025 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752226187;
	bh=ZAZ+5Y11qKAvm1dXLvYH4qKO4T6pRKgWPUaiWkGhIqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SScJ1xeKZ8IadNXhyFKNLEscKZfr/U/LfmpCQ/2lJey+z4CfoQnyw23bugK8Tj196
	 UIzmms829d5gsgvUK/98teXYjiX64VHcGexQOILcQOb1uRtq4NYI1a1RSY4gJyWunL
	 YN2cbVXlu/CtMGx37Zdi+K2DK9QcLsDyMDiep8C6ntZXydcmoc4WmQO0VTgiFjO4bz
	 1JeRBxSZ3W01qgZRIoQ3Ibmgvg1S3AwlmVXUiaOJnjh5rATz4Pnr989bQDT4S3d22u
	 Kn1WyBCic1pII+wtZQU+B3bFc8UKUQhjVv6U42VfuWxLt1qTsuAQ2oWiM67YN+PqQk
	 Qowr5XoUMuScw==
Date: Fri, 11 Jul 2025 10:29:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
	ziy@nvidia.com, david@redhat.com, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org,
	Liam.Howlett@oracle.com, brauner@kernel.org, gkwang@linx-info.com,
	jannh@google.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
	vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Message-ID: <aHDZiOVx4g-MQTKm@finisterre.sirena.org.uk>
References: <20250710112249.58722-1-lianux.mm@gmail.com>
 <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
 <aHDHQzzbtgCh6Ox3@finisterre.sirena.org.uk>
 <569270da-8827-4a3c-84db-91f715ef5c22@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SFZKbjgBQq/vRqfg"
Content-Disposition: inline
In-Reply-To: <569270da-8827-4a3c-84db-91f715ef5c22@lucifer.local>
X-Cookie: Do not cut switchbacks.


--SFZKbjgBQq/vRqfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2025 at 09:53:10AM +0100, Lorenzo Stoakes wrote:
> On Fri, Jul 11, 2025 at 09:11:47AM +0100, Mark Brown wrote:

> > One thing to watch out for with peering into the private header files of
> > other selftests is that it's a routine source of build and sometimes
> > runtime failures, people have a tendency to update one selftest without
> > thinking that other selftests might be peering at their code.  The cross
> > tree aspect can make it painful to deal with the resulting issues.

> I take it from the lack of reported issues this hasn't happened in reality.

That's a general comment about this pattern over the selftests as a
whole rather than this specific header - if this one has been working
well then great (I certainly didn't run into it myself).  In general I'd
say this pattern is up there as one of the most common individual
sources of build breaks in the selftests, and often has a relatively
high level of friction getting things fixed compared to the others.

--SFZKbjgBQq/vRqfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhw2YcACgkQJNaLcl1U
h9CLEwf/ZWeg29sShJdmo1DWOnsYSf29FpSHfH2135dGeKf0J7qanbDbzlmhfIkX
UoJgs3j0OFL4hr3g9KTTqdGGevlHT2NBcX1hY3JG3Xqx3tG5i4xbG4tXQaDFxCTf
qH2gllx8AOhggUSdSAVge4/jLsKcwnovp3chXzCZpBsSBqIgQB0LnSG6TkY0meYJ
hK0lAxnX3UOBmd3Lsd7qdpuz0r815Z11hntEUjejGwVUaLKMpDmR7AblyUZ6lwSI
AYdL5Vv447Gjcc6ajl4ORTrNYKh4jsEOQVptictoSwy3iYxuZ24JJ8w0k4HzL2NT
8s8zrXM5H94bGESAcdET8n6gBKSH+g==
=WTBl
-----END PGP SIGNATURE-----

--SFZKbjgBQq/vRqfg--

