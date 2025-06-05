Return-Path: <linux-kselftest+bounces-34392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B6ACF586
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CE27A9FB5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04439201270;
	Thu,  5 Jun 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEKDUQMC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF751DE4D8;
	Thu,  5 Jun 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145120; cv=none; b=CHkfgMD1cecZlm9SyFgM/FaIzf5EP6kIjuRVFVPtaJ0SeYLk3HryRvoYzD+seHt7mEtyH1v09+x+xCMYOCLiue3QJhVSs9WeA/L305Uq+cETBK6RRM2nfayM2iWy/2zYUVEvpvtT6lIR9QWykcsIZnRzcV25xjjy8a1DO41G/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145120; c=relaxed/simple;
	bh=0xekhmg8e9Y5UWkgvRX8bN01GpyHTc9EJETaU34EBfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWGE3NZ/BfY9uzSylerqs52ogQKeQiclRVFAFRGa3c0GbIUltjEzvJ+bbAv9lST7jbKtfXfKKsmufQ6oS32OT5NHN3AE48r9P9FfYf2qo1bmoSyzJWtbfidGGbr5XoJORnJ9ggvjD1KJlmloHLoCSO5+CqOLDQIY2vJDYnV+ROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEKDUQMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10ECC4CEE7;
	Thu,  5 Jun 2025 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749145120;
	bh=0xekhmg8e9Y5UWkgvRX8bN01GpyHTc9EJETaU34EBfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEKDUQMCbtUopVwxTfqHz6sZwkws9HEGcsd6p6hHVdTFjIYhg5ovczIEP0XkWxiej
	 GWXS4uwz180E5H/SS1wtAZchah3dZLlvVAqVg6W7NaT8lNyr3jldHVmyoJZ4o629w2
	 eAAYSH2BhWb8+RL+HctotiVgY5/3RpZ2XB7G/UTwxlIKGIy1cXal8gbBy5kJGIa102
	 Pzor+pNfwGJi/BicFGlEfYqh6+89RJ6up3Bk7GUAmDhvFKFAAlrdhGe8ccTDYb5qGh
	 q5fk1hNsUpUWK7gXnmpMGlfHzvCkJxNWqzEu+1LHV6i+OOCenyHR+23GPKnZESYrEF
	 uuaonNicUQQmg==
Date: Thu, 5 Jun 2025 18:38:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <961a62b0-d0d3-40db-8008-61c634172ca6@sirena.org.uk>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
 <976bbe1a-ef16-4006-acac-8b6be46ee5ea@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vB+CiuveTwbKhBGL"
Content-Disposition: inline
In-Reply-To: <976bbe1a-ef16-4006-acac-8b6be46ee5ea@lucifer.local>
X-Cookie: That's no moon...


--vB+CiuveTwbKhBGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2025 at 06:09:09PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jun 05, 2025 at 05:42:55PM +0100, Mark Brown wrote:

> > > Better to do all of these formating fixes and maintain the _same behaviour_ then
> > > separately tackle whether or not we should skip.

> > I'm confused, that's generally the opposite of the standard advice for
> > the kernel - usually it's fixes first, then deal with anything cosmetic
> > or new?

> I mean the crux is that the 'cosmetic' changes also included a 'this might
> break things' change.

No, the cosmetic changes are separate.  I'm just saying I have a small
bunch of stuff based on David's feedback to send out after the merge
window.

> I'm saying do the cosmetic things in _isolation_, or fix the brokenness
> before doing the whole lot.

Some subsystems will complain if you send anything that isn't urgent
during the merge window, this looked more like an "I suppose you could
configure the kernel that way" problem than a "people will routinely run
into this" one, I was expecting it (or something) to go in as a fix but
that it was safer to wait for -rc1 to send.

> > > Obviously the better option would be to somehow determine if hugetlb is
> > > available in advance (of course, theoretically somebody could come in and
> > > reserve pages but that's not veyr likely).

> > The tests do enumerate the set of available hugepage sizes at runtime
> > (see the loop in run_test_case()) but detect_hugetlb_page_sizes() just
> > looks in /sys/kernel/mm/hugepages/ for subdirectories and doesn't look
> > inside those directories to see if there are actually any huge pages
> > available for the huge page sizes advertised.  There's probably utility
> > in at least a version of that function that checks.

> Right yes, I mean obviously this whole thing is a mess already that's not
> your fault, and ideally we'd have some general way of looking this up
> across _all_ tests and just switch things on/off accordingly.

That is at least library code so it'd get the three tests that use it,
though possibly one of them actually wants the current behaviour for
some reason?

> There's a whole Pandora's box about what the tests should assume/not and
> yeah. Anyway. Maybe leave it closed for now :)

It's separate, yeah.  It'd also be good to document what you need to
enable all the tests somewhere as well - there's the config fragment
already which is good, but you also at least need a bunch of command
line options to set up huge pages and enable secretmem.

--vB+CiuveTwbKhBGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhB1hsACgkQJNaLcl1U
h9A2bAf+I82kOkj0hxVILfRgpLG3fbkaq9Xu07fjPZBtFAZBZiAB8MsNjGsCMM/h
BxmflTVj29JxSM2UpBpPy7FSYo7bcKmtRfJ/k3+j00P1GgOLcX535RCZjVHMXDoU
eytwc7OefpqH6LDYfwgBS7pYa4XazsoQd6VgdVxzer/TyCMyPMZwdUgTJNEpFNfF
CvuQrRmNbl0BoA8cxp5w+txg2Zfvt0sYh8N43GHXdIUv7bnKrkXoMtK+FuovgpUB
47MvWE7dwBjxQbEK6wmE1oj8qMYz1vJPOCONKgiY3coGvvIwHpUnv5AuVYyMlWrQ
/xNh3jFErEnzqaysCXPijyLJ2mz/RA==
=DSUt
-----END PGP SIGNATURE-----

--vB+CiuveTwbKhBGL--

