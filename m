Return-Path: <linux-kselftest+bounces-48334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF54CF9C08
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53EC3313605C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EDE3559E9;
	Tue,  6 Jan 2026 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4/ASQjj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6943559DC;
	Tue,  6 Jan 2026 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720597; cv=none; b=rjdKVeONH9eVyiNbSdG7mEhYPpdIOzsL6rcH+vaTPCnEH/xNktdDfQzpveDoqBBdhU+LSh+aIbNEUZ4vTVpWluaCDZDcYp+6JKQfezmeGG9jaRtcAazazR30mvKyfRy/8OvhWySjITttymt7eiEuSMy0cy6urS3kS7NJyQNyRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720597; c=relaxed/simple;
	bh=S59AIhszH1mltc6DfCoGlRJ+0/sPO1hMLyo8OSVvGME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca+HH8Dw2GRmPGxi7VtGd/ERqhL8kz/rWrEH8SzWzGk3meOhsWAKOgH4Jz9yp2917gqflCT45jOxsiPwR4FurC88YseQiFL5TsSS4EfTP8gQnVGJLen8/aTwy0djkRg6yyxTNHL3XGgRbnJMnVsPHoEcp5Bz+WsRy8B16LSbqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4/ASQjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4802BC116C6;
	Tue,  6 Jan 2026 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767720597;
	bh=S59AIhszH1mltc6DfCoGlRJ+0/sPO1hMLyo8OSVvGME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4/ASQjj9n5SEFj3Y3lei8PxO5TbigT6vEzGbkddPw5ppErLKA4dVT6q7harmTpUL
	 SnDZvChCe4x+vEqiPm7N0qxANu2dxvIkT9otgrgBQKbOevxt7t+KWEr0UUUArr3vYx
	 N30dZ6i3I3VEuIX1DaZ1xWvsbBDOxU9qCp/blaPJfLr6Ld5+9kPjM6CaDz14LRqLa9
	 CWtIzL4h0gWCmdN9q3OV51jaVYxojvxYEnUQs2w8a7FyLRVi5q9EaYTFP6iSUinniD
	 9gLrx/BKcecZwSHVQTa34oBOGj7h5TRy+NN1op7XH2HQRvYaPVwcdnciObu8xufofg
	 /OWnL1pjedxFA==
Date: Tue, 6 Jan 2026 17:29:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/testing/selftests: fix gup_longterm for unknown fs
Message-ID: <56b7d3e2-fcfa-42c2-988f-907086f031d1@sirena.org.uk>
References: <20260106154547.214907-1-lorenzo.stoakes@oracle.com>
 <20260106092836.d6a4fa77b755bd989d1521b9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1m3/mpdwsBsKXyRx"
Content-Disposition: inline
In-Reply-To: <20260106092836.d6a4fa77b755bd989d1521b9@linux-foundation.org>
X-Cookie: People respond to people who respond.


--1m3/mpdwsBsKXyRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 09:28:36AM -0800, Andrew Morton wrote:
> On Tue,  6 Jan 2026 15:45:47 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > Commit 66bce7afbaca ("selftests/mm: fix test result reporting in
> > gup_longterm") introduced a small bug causing unknown filesystems to always
> > result in a test failure.

> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Fixes: 66bce7afbaca ("selftests/mm: fix test result reporting in gup_longterm")

> -stable users might want this?

I think so.

--1m3/mpdwsBsKXyRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmldRo4ACgkQJNaLcl1U
h9CM0Qf/S33dckv3loTsZRKZjDP/+2/a4BY6PGpohLKe0w51tgiuLCxd1X/2jk6N
ky7lf8dsYp0n3gH8X5qNqZkV6ORRUPjNFbnwjb4+uz/qboNv/tb71GeHU+hGKDDJ
8gFFUMBBhgwP5sXymPeIx0x3zY6c9/exaja3RQJxAgu9aLw8MYID1LXhT4zfsh8z
S0X+ifWgfr4qcUzuVwE0uOoBWP6OqM5cINm2oLf1Gj6QawsGJVn+J8bJU/masvJL
uEfk+6nZyT9qFiquPddDzZokuSYPYOxyOPXYwuUTaedmgJ74xSNUhb2t5t0suwgb
q3sLVMMrHap0GNb3DCnb794Bycr5gA==
=gYNf
-----END PGP SIGNATURE-----

--1m3/mpdwsBsKXyRx--

