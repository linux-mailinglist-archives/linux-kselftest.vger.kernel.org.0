Return-Path: <linux-kselftest+bounces-25405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06545A226F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 00:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C08164974
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 23:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B351B424D;
	Wed, 29 Jan 2025 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vS2tBcBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB891DDCD
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193807; cv=none; b=IPglOk6jwDvEcSIGOfDwq6llYe1lY7AIGX8K19EqLOSNBu/rJwhNhc8QHv1oaIvJQ5UR4SfwnM8yYPwJLwQskH8qJGPPblsGAn3oFYBGJT4RwQWj6mxOkpIuu+GWIj4q259wLqOp/DOd1rmnz+EkK3RqJ6Kb+vsiQRfU0qUiFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193807; c=relaxed/simple;
	bh=UaeAALwAtuafje6+N38h7Tic7wOnzgVgeMqqjTyj6kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAErzbmwCG/Y0BeRQzw3bz34gK3mgZXpxoCDUoYvxe0xrCZAaGAKs5ekGr1+IM860YZr8fbCIvAbSapgT5BoBxHzQyBULpgtZ9Rhi8aSbIHF0dhWgY2BCVtyGDmodRPEdGOgrCrTe640fLcv1PwlxRS6UcxmOp/uFVRPnqSH4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vS2tBcBb; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Jan 2025 18:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738193796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5zomXTa+ERKjUowhQf21+AaHnjtqsE4cQH6Ryktt6g=;
	b=vS2tBcBbVcTb74wxWwlQhUYz4URK43M4wJ53qy9gLo3UE0zEWolxtOWXwP4gssSbARdGE2
	AVFpmRK0cY0ndgfDcb6JqqKiT5kSagkVHWvhX8fZHNLbKd7kizCy1SorQ5Beuy4ab4NYAW
	1kNF4qgUqFkZCYYXzNDH5So4B3NaRcg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
Message-ID: <dxumxyg5no5dc7ndslicm6v7dmkjkbrfr2wocsytin7jx6jdic@4utbjfwdcnqi>
References: <20250128163859.1883260-1-agruenba@redhat.com>
 <20250128163859.1883260-12-agruenba@redhat.com>
 <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
 <CAHc6FU6Yzk1Si37nRji-5uDZF9uaYo=G5tbtuS_5FiW6BDVTAg@mail.gmail.com>
 <rddasfmbw3ul2iezec7rgit2vxnv4p53uvoydck4b5jxuo44kq@7qlk5cru6w7r>
 <CAHc6FU7oZxP1cy6uihH=m9i=0z8PmCtozwQs2HgnqvbTDhAd_g@mail.gmail.com>
 <nxabgljkslxwr27wrzgjxao2nr3jh5leytj7f3pjir3t27uf5w@zcdmd4phur2m>
 <CAHc6FU7x8MbRLA9ELYiDM+Srz2FNzOzr28yztBA=CrPsj8X43A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7x8MbRLA9ELYiDM+Srz2FNzOzr28yztBA=CrPsj8X43A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 12:17:51AM +0100, Andreas Gruenbacher wrote:
> On Wed, Jan 29, 2025 at 10:30 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > On Wed, Jan 29, 2025 at 10:21:31PM +0100, Andreas Gruenbacher wrote:
> > > On Wed, Jan 29, 2025 at 9:28 PM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > > On Wed, Jan 29, 2025 at 07:21:49PM +0100, Andreas Gruenbacher wrote:
> > > > > On Wed, Jan 29, 2025 at 7:04 PM Kent Overstreet
> > > > > <kent.overstreet@linux.dev> wrote:
> > > > > > On Tue, Jan 28, 2025 at 05:38:48PM +0100, Andreas Gruenbacher wrote:
> > > > > > > Rename eytzinger0_find_test_val() to eytzinger0_find_test_le() and add a
> > > > > > > new eytzinger0_find_test_val() wrapper that calls it.
> > > > > > >
> > > > > > > We have already established that the array is sorted in eytzinger order,
> > > > > > > so we can use the eytzinger iterator functions and check the boundary
> > > > > > > conditions to verify the result of eytzinger0_find_le().
> > > > > > >
> > > > > > > Only scan the entire array if we get an incorrect result.  When we need
> > > > > > > to scan, use eytzinger0_for_each_prev() so that we'll stop at the
> > > > > > > highest matching element in the array in case there are duplicates;
> > > > > > > going through the array linearly wouldn't give us that.
> > > > > >
> > > > > > For test code, wouldn't it be simpler to iterate over the test array,
> > > > > > testing with every element as a search value? There's enough corner
> > > > > > cases in lookup that I think it'd be worthwhile (and probably add some
> > > > > > extra test values, e.g. first/last elements +1/-1).
> > > > >
> > > > > If you expect to get the same index back, that won't work when there
> > > > > are duplicates.
> > > >
> > > > No, but we wouldn't expect to get the same index back if we're testing
> > > > every combination of elements (+0, -1, +1) x (le, ge, gt) - and it
> > > > sounds like perhaps we should, if you've been finding bugs. Thoughts?
> > >
> > > I don't really know what you're after here. Function
> > > eytzinger0_find_test() already tests every combination of elements
> > > (+0, -1, +1) x (le, ge, gt).
> >
> > Ok - it can be hard to tell looking at isolated patches vs. being able
> > to fetch a git repo. Do you have it in a branch I can fetch from?
> >
> > > The full scans of the array in eytzinger0_find_test_{le,gt,ge}() are
> > > not there to verify correctness; they're only there to produce
> > > slightly nicer debug output. I'm perfectly happy with removing that if
> > > you prefer.
> >
> > No, not at all
> >
> > > > I think the test code would have to do short linear searches from the
> > > > test element, and then verify the search functions against that.
> > >
> > > What for? We already know from the eytzinger0_for_each loop in
> > > eytzinger0_find_test() that the array is in eytzinger sort order, and
> > > we also know from eytzinger{0,1}_test() that the _prev() and _next()
> > > functions are doing "the right thing". So the one thing left to verify
> > > in eytzinger0_find_test_{le,gt,ge}() is that all the search functions
> > > always return the boundary element. That's done by going to the next
> > > element in search order and by verifying that it no longer fulfils the
> > > search criterion.
> > >
> > > > Have you spotted any issues with searching over arrays with duplicate
> > > > elements?
> > >
> > > Only that eytzinger0_find_ge() didn't always find the first matching
> > > element in the array; see patches 17 and 18.
> >
> > Gotcha
> >
> > Ok, it sounds like everything I'm after is there - give me a git branch
> > so I can read through it that way and I'll be happy to merge when you
> > say it's ready
> 
> Sure, I've pushed the patches here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/agruen/linux.git/log/?h=bcachefs
> 
> Note that you don't want to merge the following patch:
> 
>   bcachefs: Run the eytzinger tests on modprobe
> 
> And this minor one should probably be changed to use __maybe_unused or
> dropped; not sure which of the two options you prefer:
> 
>   bcachefs: remove dead code in is_aligned

That code is a cut and paste of sort.c, so we should just drop it - no
reason for those to diverge (and perhaps add a giant comment on where
it's from).

> I've only run the self tests. They seem to provide good coverage and I
> don't expect any trouble, but some real filesystem testing would be
> great.

I've fetched it to my repo and added it to the CI:

https://evilpiepirate.org/~testdashboard/ci?user=kmo&branch=eytzinger

