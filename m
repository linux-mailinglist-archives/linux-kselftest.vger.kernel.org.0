Return-Path: <linux-kselftest+bounces-34397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665DACF681
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EE53AD6A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93F27A103;
	Thu,  5 Jun 2025 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/B05Pdc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CA276051;
	Thu,  5 Jun 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147882; cv=none; b=Y4gAvZ83WMBnBXLjtHtOHIxCxsg0Z1yuGf9zTveJDU45kljj6dEVjdDLKZwcahpIHrR+lCPt884StrRxotzpO0W6qOqpRJeVrB+aau/1L+W7LC8SVOVoP4v55EpGqw4S1u4BqpG3z7/t8wQX6RtjNCg2IkCl/PbnZooSWKTjkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147882; c=relaxed/simple;
	bh=h59WDfgXYE9Pb86KnZDa6AJUEpLoHUxQH/9dgjM8T7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqU76mCg7xlweHETTZhSIEd1feeOUni9TYFNfiXEIIFSqPKqRbo0F09qGtgNfDYh9T14wkqE/a6t1rz2f5jOh4RXp0Q/8QI9R4UCs7/Eo5aM/pPPU52UymaCYr6wi/oT6ZdQkFLfCJ48zxj/vFy6N7p6snq5X4gxfqJJiVa9t4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/B05Pdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50580C4CEE7;
	Thu,  5 Jun 2025 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749147880;
	bh=h59WDfgXYE9Pb86KnZDa6AJUEpLoHUxQH/9dgjM8T7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/B05PdcgIwIxY4Y40GFQWYpLlOJUSyIHxJ+BKK5DvdeVhb7+gJFx9o9TGk8T8iiW
	 8XPN7Dc9sw/P2/QpN1l2YOQylJ5gn87gBubAPCsoczi0GFAnTJCWxAj4gEXRfch/M5
	 KnhbGuih02Gs29Kfwd954vDs3EGkG7dbf3w/iMOLm1+tgoQszwjGcnIlHgbb9g/XBV
	 tbqP1Edik1NcCKLL9P4voVzUq7NIJCO7qwH+aBiKub6j3cQ5oTMFmx8Ts86JqSkIaX
	 4PLKPAP9an6Yhb+Dzl1O61Elo/qreKGt7iJIb9GAHgYg41850yQwCH3LiODiy6N42K
	 XlFpni7xY0Pgw==
Date: Thu, 5 Jun 2025 19:24:36 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <1fec0548-6507-466d-ace8-702fadbc68f1@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
 <077b6af0-bef3-4f1f-b785-9e351d01a89f@redhat.com>
 <d039ca05-da2f-4317-be04-34edb7ad3496@sirena.org.uk>
 <beee85ae-8b36-4705-af96-1d65c40df215@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HpBeBDudQufsoeBi"
Content-Disposition: inline
In-Reply-To: <beee85ae-8b36-4705-af96-1d65c40df215@redhat.com>
X-Cookie: That's no moon...


--HpBeBDudQufsoeBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2025 at 07:34:28PM +0200, David Hildenbrand wrote:
> On 05.06.25 19:19, Mark Brown wrote:

> > TBH this has been a lot better than the more common failure mode with
> > working on selftests where people just completely ignore or are openly
> > dismissive about them :/ .  Probably room for a middle ground though.

> Can we *please* limit such reworks to mechanical changes in the future?

Yes, that's better in general.

--HpBeBDudQufsoeBi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhB4OMACgkQJNaLcl1U
h9Al1Af/a6G87pi3kA/SrMQRDKlWTzVxwv3blS6pt6Ks3luo0YCwAnyuv31qYJO/
F2Y29QAhRS/q3/szS1Oc6dgLEDjBqOQY5lohv0FgMM4cKvFnrEusqh06KVlnrGCa
wVir6kF7qRc+/WAyrbh1ilobORYMpLHLi8F+cidREacOP+KYOU4MqrMjp5GBVK0M
Dr8HvKTSQst5p3R+u6Hv123JKDRQl65Pc+xGGjB0xV+V3TBVutENafKAWvRwwbtI
PqXYhWkre2dndR+qw8tMxGs2B5woNRh8ZdQDkjlN2iYUy/rjI+v2RYB3uLnEIUvK
Y3GT8Jbmuwyy90alEh6E+lMxX73YQg==
=cOEy
-----END PGP SIGNATURE-----

--HpBeBDudQufsoeBi--

