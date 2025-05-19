Return-Path: <linux-kselftest+bounces-33326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24AABC164
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFD17FDB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383CD28368E;
	Mon, 19 May 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azJywjW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF511DE4FB;
	Mon, 19 May 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666545; cv=none; b=aSLjOxdb/JviyG1LUSH7qb1xMVeALRkJstJzDYFV8L0Qp00mczj56oBWQzpQ6FPvAUh1lkZTNcn5qxrbGqCbYZ34Ta0D9AkGnoV+U37bIQCGc0U9ho17sR9rTnBmSH/Hgs9XRyYma9DT2YT8Mbo2UTZuMfm4R4fju93jP/O6LY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666545; c=relaxed/simple;
	bh=+X76iYUuy9DsVDbkt7YyPLXZmVHqkBUvv95NS/ecbuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZmK+YKRr8Y1GKV5c6cQYEBNc6f39rNXLKHkU4e0R7OZRyBkGo7TmHPch7N/IwutCcs7PzE32wkJqKGPxKSzbysIJifYLUWYQTT7YDmyp3J+549yQ9tEiHgqtXgS5C2dQN3CdGsOeETWM9tTaOpz9kUTXxdbQ1izksSpYV4ATw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azJywjW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3471AC4CEE4;
	Mon, 19 May 2025 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747666544;
	bh=+X76iYUuy9DsVDbkt7YyPLXZmVHqkBUvv95NS/ecbuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azJywjW5goGMJCUc2P54PElSOo8JWGM8mqdZQsYrORxyAGU1FV1GyaPuEnsfpeY23
	 jaB2g2WqGjFM+7z89oBUL+YbxXsK8WD5cmfBkRjJN00KhEXAG9tE1PyF0pJ6pOWSOw
	 JLki26GX+/BzJYgCbhp6AHYIZ6ppiM3N2n4uTsDzfYFLCIiogrr3HlOzb0BDHBr6Ue
	 fR1KdCjw6uQBLSMQe/jU+N2ac5or2ZekJiUD6je/GTa8f8b8goJUoq136xktdkOa7X
	 D5qpAa3YkFM3gfHJuIWWdP98xFmSYvfMnqwEw4B5cNqp2JSsYiMPwNCf0LWIOtDKmo
	 NG0Mlly7htn7Q==
Date: Mon, 19 May 2025 15:55:40 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
Message-ID: <d3e3508d-9192-4f32-9db0-835e1cd614ac@sirena.org.uk>
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <f924f789-5269-4046-99a4-2991f9a3ab3c@redhat.com>
 <aCcvxaFc6DE_Mhr1@finisterre.sirena.org.uk>
 <58dbef73-6e37-46de-9092-365456306b27@redhat.com>
 <aCc5E-wB4nBwrKEP@finisterre.sirena.org.uk>
 <46d151d7-c04b-4538-9725-dc4f46ac8ac1@redhat.com>
 <aCd-8kEyDm2f2w0z@finisterre.sirena.org.uk>
 <8131ce62-0cee-455f-9eeb-e2bbed244402@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M2L5/cXLTc0+AzCR"
Content-Disposition: inline
In-Reply-To: <8131ce62-0cee-455f-9eeb-e2bbed244402@redhat.com>
X-Cookie: We have ears, earther...FOUR OF THEM!


--M2L5/cXLTc0+AzCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2025 at 03:28:47PM +0200, David Hildenbrand wrote:
> On 16.05.25 20:07, Mark Brown wrote:
> > On Fri, May 16, 2025 at 04:12:08PM +0200, David Hildenbrand wrote:

> > [Converting to kselftet_harness]
> > > > That'd certainly work, though doing that is more surgery on the test
> > > > than I personally have the time/enthusiasm for right now.

> > > Same over here.

> > > But probably if we touch it, we should just clean it up right away. Well,
> > > if we decide that that is the right cleanup. (you mention something like that
> > > in your patch description :)

> > OTOH there's something to be said for just making incremental
> > improvements in the tests where we can, they tend not to get huge
> > amounts of love in general which means perfect can very much be the
> > enemy of good.  If there's some immediate prospect of someone doing a
> > bigger refactoring then that'd be amazing, but if not then it seems
> > useful to make things play better with the automation for now.

> I would agree if it would be a handful of small changes.

> But here we are already at

>  1 file changed, 107 insertions(+), 56 deletions(-)

Those are pretty mechanical changes due to the amount of chat from the
program rather than a more substantial reconstruction of the logic which
is rather more risky for a drive by.

--M2L5/cXLTc0+AzCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgrRmsACgkQJNaLcl1U
h9DuZAf+P60cnZrBiz7qi76C5eLIVuVj+QIAm2cpmnirdllp9oYWisfl93q5Pgpd
6S4imW+gEU8sWAQXlo10YjV05db/QpkGeK5gnzxjCwa58LPMM5rzX5qyAOfvEKlU
vuvYzGzUOt5rCptsHz+Wbn6d/hMH/ObmNSJ9J1Swisgz+oSLB2jbgatlQKiT+3Ot
6BuRN7ESdCHc0tMvG2/hBy37HDyql+R6hRzQLt1vJiCpMv/tbnNgM4o+apWK/2Hj
JMAHkkxZDOgquo9lWQcTn0BbQjTJxFFqndIzJzCCwapvu09jJ3P7kk0AVvPJYrsg
D8d+sL1akSM6lTPgt4cSNZm9EpxZnA==
=DeB+
-----END PGP SIGNATURE-----

--M2L5/cXLTc0+AzCR--

