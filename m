Return-Path: <linux-kselftest+bounces-13856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB393462A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 04:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D076B2824A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB111FA1;
	Thu, 18 Jul 2024 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u37XGcnN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F815C3
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269052; cv=none; b=rQ/NcZvdx4+Y18N4V3AETxBh41egZQnyh3Eicf8qu35PloS+RKCQWhldk8m8kokiHha4efSTXOgwA4o/WvINSSE1mLpcBTw4Co/DCPV1TUEfPxWtn8IKYBwzab5gpskVd0Hq8jZcjOPJuPm0Fw6xhN2SfFFgMQlkkC/HPRuq628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269052; c=relaxed/simple;
	bh=dCoacnuGxiULqHiSnABfHzecGlEVaqAvTmtFNNALpWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpBQtUiomrZHsIZcfXjrHAFdtP88ejDJFeFp470eA7iPVb6JKKQCeuzB1yHFKaQFkaomlMIMcxQLMVr0tZvtwtPPOcF8CjuuX/f9GwpeSXkq2/kH9dttR+TDRtcAXzHY0OqMsZOCJubmw/ESbY+Md2xjX/mlq7Z/Dg7g/RCZ3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u37XGcnN; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tj@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721269048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68sXNRc9aX1kYOm4EbIZEtLCrD/0gXEQ3WebTzoEtqU=;
	b=u37XGcnNYIkm7CZp0xVQulO63AGKHfEhofgSq9I3JUGi8vomRFMkTFJ9pXAW/r51S9tZNy
	EFOmQYMZivqm6B8ev52sG8BAcy2ISBMXc68Z8ujGDbt21h2hvy11H2bhpHLDDlcivbOBjG
	RcfIfO6APi0RRqkrWsmxvoGvEjTCzJU=
X-Envelope-To: longman@redhat.com
X-Envelope-To: davidf@vimeo.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: core-services@vimeo.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: shuah@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: shakeel.butt@linux.dev
Date: Thu, 18 Jul 2024 02:17:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, David Finkel <davidf@vimeo.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <Zph7LKR94CWkL83i@google.com>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <20240717170408.GC1321673@cmpxchg.org>
 <CAFUnj5OA0KaC54M9vd8W+NZJwz5Jw25u-BStO=Bi2An=98Ruwg@mail.gmail.com>
 <20240717204453.GD1321673@cmpxchg.org>
 <CAFUnj5OGJtR0wqOZVUh8QQ3gaw4gmatsEN1LcBdcwN_wx-LUug@mail.gmail.com>
 <85a67b00-9ae7-42a1-87e0-19b5563b9a0f@redhat.com>
 <Zphu4SDGCJ-IExnf@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zphu4SDGCJ-IExnf@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 17, 2024 at 03:24:49PM -1000, Tejun Heo wrote:
> On Wed, Jul 17, 2024 at 07:48:40PM -0400, Waiman Long wrote:
> ...
> > How about letting .peak shows two numbers? The first one is the peak since
> > the creation of the cgroup and cannot be reset. The second one is a local
> > maximum that can be reset to 0. We just to keep track of one more counter
> > that should be simple enough to implement.
> 
> What Johannes suggested seems to hit all the marks - it's efficient and
> relatively simple, the overhead is only on the users of the facility, and
> flexible in a straightforward manner. I have a hard time buying the argument
> that it's more difficult to use - the benefit to cost ratio seems pretty
> clear. Given that, I'm not sure why we'd want to add something fishy that
> can lead to longterm problems.

+1 to that. I really like Johannes's suggestion.

Thanks

