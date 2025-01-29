Return-Path: <linux-kselftest+bounces-25402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47216A225D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 22:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2DB1672F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931861E9B1F;
	Wed, 29 Jan 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PrL7se9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9591E47B0
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186213; cv=none; b=nZ58KwlgcHLf6KN+GnWyQ9SqKnA48kBOH/afiunqAF8rlIFC50OkNq5LptaeStlctNG3crgEySnD8QraaRARyXp1c6vVTxa16yUrcHjtzmTGZtEajeWWf24abJwnZghy3dYI/jkhtJDYuSwC8i4rRsPPIJvYbm+mMlPjCoFM+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186213; c=relaxed/simple;
	bh=c3zdLUjyfoxA5IXunh28EbOIUhI4Z6JgdKurXMndpS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6lEJ05deLnfSSa7KiQF2BdRx1yaTZBRG3WmbkdYdh7m4e4Uf+ioCXS9zEJdeeVrn7oMr+nuXfN5ys2H/UdJ6u/b/N8h9P2kmeCjPDamg7AbiRTjM4/SPvPV5qIs5TOkHNU1DIwzTJBbYB/Pz3MIouxz8NgaHHEgFaOG7rNolEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PrL7se9q; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Jan 2025 16:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738186209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDKVH8SqEMjnHY+WIVjJ+T1RpSbVZqtPnx8I5fD1WQ0=;
	b=PrL7se9qqjPBXp1XFV2EmWC/YQYIKX/z1pi1eAnJkmwFeOSxV+xJyIx/sTwY/m6tC8c9Gh
	Z7bqrCrzS47tLKzLgizwLAA7SV46krfgyqPQZMbuFVLQf3pxEmxL/lhs5s67fQhSJSovWH
	GA1FbVGtkNkip4zmr0R720dnPO6UanU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
Message-ID: <nxabgljkslxwr27wrzgjxao2nr3jh5leytj7f3pjir3t27uf5w@zcdmd4phur2m>
References: <20250128163859.1883260-1-agruenba@redhat.com>
 <20250128163859.1883260-12-agruenba@redhat.com>
 <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
 <CAHc6FU6Yzk1Si37nRji-5uDZF9uaYo=G5tbtuS_5FiW6BDVTAg@mail.gmail.com>
 <rddasfmbw3ul2iezec7rgit2vxnv4p53uvoydck4b5jxuo44kq@7qlk5cru6w7r>
 <CAHc6FU7oZxP1cy6uihH=m9i=0z8PmCtozwQs2HgnqvbTDhAd_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7oZxP1cy6uihH=m9i=0z8PmCtozwQs2HgnqvbTDhAd_g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 29, 2025 at 10:21:31PM +0100, Andreas Gruenbacher wrote:
> On Wed, Jan 29, 2025 at 9:28 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > On Wed, Jan 29, 2025 at 07:21:49PM +0100, Andreas Gruenbacher wrote:
> > > On Wed, Jan 29, 2025 at 7:04 PM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > > On Tue, Jan 28, 2025 at 05:38:48PM +0100, Andreas Gruenbacher wrote:
> > > > > Rename eytzinger0_find_test_val() to eytzinger0_find_test_le() and add a
> > > > > new eytzinger0_find_test_val() wrapper that calls it.
> > > > >
> > > > > We have already established that the array is sorted in eytzinger order,
> > > > > so we can use the eytzinger iterator functions and check the boundary
> > > > > conditions to verify the result of eytzinger0_find_le().
> > > > >
> > > > > Only scan the entire array if we get an incorrect result.  When we need
> > > > > to scan, use eytzinger0_for_each_prev() so that we'll stop at the
> > > > > highest matching element in the array in case there are duplicates;
> > > > > going through the array linearly wouldn't give us that.
> > > >
> > > > For test code, wouldn't it be simpler to iterate over the test array,
> > > > testing with every element as a search value? There's enough corner
> > > > cases in lookup that I think it'd be worthwhile (and probably add some
> > > > extra test values, e.g. first/last elements +1/-1).
> > >
> > > If you expect to get the same index back, that won't work when there
> > > are duplicates.
> >
> > No, but we wouldn't expect to get the same index back if we're testing
> > every combination of elements (+0, -1, +1) x (le, ge, gt) - and it
> > sounds like perhaps we should, if you've been finding bugs. Thoughts?
> 
> I don't really know what you're after here. Function
> eytzinger0_find_test() already tests every combination of elements
> (+0, -1, +1) x (le, ge, gt).

Ok - it can be hard to tell looking at isolated patches vs. being able
to fetch a git repo. Do you have it in a branch I can fetch from?

> The full scans of the array in eytzinger0_find_test_{le,gt,ge}() are
> not there to verify correctness; they're only there to produce
> slightly nicer debug output. I'm perfectly happy with removing that if
> you prefer.

No, not at all

> > I think the test code would have to do short linear searches from the
> > test element, and then verify the search functions against that.
> 
> What for? We already know from the eytzinger0_for_each loop in
> eytzinger0_find_test() that the array is in eytzinger sort order, and
> we also know from eytzinger{0,1}_test() that the _prev() and _next()
> functions are doing "the right thing". So the one thing left to verify
> in eytzinger0_find_test_{le,gt,ge}() is that all the search functions
> always return the boundary element. That's done by going to the next
> element in search order and by verifying that it no longer fulfils the
> search criterion.
> 
> > Have you spotted any issues with searching over arrays with duplicate
> > elements?
> 
> Only that eytzinger0_find_ge() didn't always find the first matching
> element in the array; see patches 17 and 18.

Gotcha

Ok, it sounds like everything I'm after is there - give me a git branch
so I can read through it that way and I'll be happy to merge when you
say it's ready

