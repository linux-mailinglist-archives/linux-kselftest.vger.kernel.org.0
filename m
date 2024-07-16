Return-Path: <linux-kselftest+bounces-13788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC128932ED1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 19:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3927FB22F19
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2919FA9B;
	Tue, 16 Jul 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R462tVje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29619FA72
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149285; cv=none; b=WSxUHFySkauLJr0+cVfambxjBvYvz88zG2NMjYDIwMbG6KEl6RUDuZcPbsD3xb+JRGtiANloavo7j/9JkAOpeWVPxxXklsZFCwniPO1RKBU+CQWqlioauP0OCtT9zkGpXq3eBTvENqMrSohocYfsZB3Nk+iBXntJVyr18JDoMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149285; c=relaxed/simple;
	bh=Y8Pz78H+tOW6Qf4pdXFzK/B47iOTlAXAxYFkbxoikv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjSi9CUyO2lVD1lPTROrUnZE4Mw1h6h5pe/y47NpP6j9ppYNOy8yDWQPIECG4ikD3HI/KH+3sQDbOn6FbpNo0LrFEq0I2CpG+kPZa7slyHu5VfXl/LuAZo7fbdlivjyuBi+BE448c26AIoauj2zt4gx7aCprh7sSFh1AsU/VqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R462tVje; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tj@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721149281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+iafsuuzbArPekZqOmrPqo2BPh9YPyJZoOs5qGZ3sE=;
	b=R462tVjetdP9ddVUy8veVB1JfcQxuEvR1SZrFmrNDDojNeR9L+JqyBSVtSZjyCHcwAfpX0
	e8UHz0sGXsYFh7wlvFIRd+3YCJbMsgKYCk8282VKnpfHLoHEUyYhImUCVwaFCjO1z3eiEG
	cHBGnDVmc9Z/ELPYWvzDttRssutFvFk=
X-Envelope-To: mhocko@suse.com
X-Envelope-To: davidf@vimeo.com
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: core-services@vimeo.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: shakeelb@google.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Date: Tue, 16 Jul 2024 17:01:15 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, David Finkel <davidf@vimeo.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpanW41dQ8DimbA3@google.com>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpajW9BKCFcCCTr-@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 16, 2024 at 06:44:11AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
> ...
> 
> The removal of resets was intentional. The problem was that it wasn't clear
> who owned those counters and there's no way of telling who reset what when.
> It was easy to accidentally end up with multiple entities that think they
> can get timed measurement by resetting.
> 
> So, in general, I don't think this is a great idea. There are shortcomings
> to how memory.peak behaves in that its meaningfulness quickly declines over
> time. This is expected and the rationale behind adding memory.peak, IIRC,
> was that it was difficult to tell the memory usage of a short-lived cgroup.
> 
> If we want to allow peak measurement of time periods, I wonder whether we
> could do something similar to pressure triggers - ie. let users register
> watchers so that each user can define their own watch periods. This is more
> involved but more useful and less error-inducing than adding reset to a
> single counter.

It's definitely a better user interface and I totally agree with you regarding
the shortcomings of the proposed interface with a global reset. But if you let
users to register a (potentially large) number of watchers, it might be quite
bad for the overall performance, isn't it? To mitigate it, we'll need to reduce
the accuracy of peak values. And then the question is why not just poll it
periodically from userspace?

