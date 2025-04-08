Return-Path: <linux-kselftest+bounces-30381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D69A8186E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E085188F84A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9CC255222;
	Tue,  8 Apr 2025 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TcoBLalr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F5242914
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150982; cv=none; b=iTVKBTf1NupYimpyH0NycZoX00dvBPEgyIR45LEDrp9Pz/mUjUYbrtZ18rZogs/Sg7ffKPMvyuKGbABFtP2QHQ4hFYncXf3WhojFM49XCd83wl+1zb9CSQ4ULmyKBH37FQDDjVq53LDbkAultcXZ8MPlfF00+pLXVP8ZFgBalFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150982; c=relaxed/simple;
	bh=wvvzta72QEmE5Gx/4J/NhwpLTLMel558Hz++rS/+MT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3tCF4SC6nSWCjkAkjawT6Yuv0uOBvlKpWNa0BHrQPZ166D22PVT+VbgLOS57ZkAbdn5c5xSBSSK2JILJLckn+7QSztYlb52r/U7J4tmi3TbFhYJYXNhe/LkoFEaFM+5k/Q6SuZlNtRtnOQIu4WCDzYU3r2B0rN92b3hNGYHlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TcoBLalr; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Apr 2025 22:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744150978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vzxu9RqZfgCag2kaUjY8CYVmo1wIXtQPZ42lCWTw8iY=;
	b=TcoBLalr58CwOZhSnic9nJcluUplJlVYgdbXYy86g3MFATiR2nLoyxOIfXJzq6VYNDHRNN
	Nh7H7/+JYKH03Mw4gmcNyLOTeYpIIUGATAk4J2BXOGw1+NzorwG7tkExOmInn5G61Sc99w
	QBt34DnligOA4US0OCv1a5JNq63JjSM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: memcg: Increase error tolerance of
 child memory.current check in test_memcg_protection()
Message-ID: <Z_Wht7kyWyk62IBU@google.com>
References: <20250406024010.1177927-1-longman@redhat.com>
 <20250406024010.1177927-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406024010.1177927-3-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 05, 2025 at 10:40:10PM -0400, Waiman Long wrote:
> The test_memcg_protection() function is used for the test_memcg_min and
> test_memcg_low sub-tests. This function generates a set of parent/child
> cgroups like:
> 
>   parent:  memory.min/low = 50M
>   child 0: memory.min/low = 75M,  memory.current = 50M
>   child 1: memory.min/low = 25M,  memory.current = 50M
>   child 2: memory.min/low = 0,    memory.current = 50M
> 
> After applying memory pressure, the function expects the following
> actual memory usages.
> 
>   parent:  memory.current ~= 50M
>   child 0: memory.current ~= 29M
>   child 1: memory.current ~= 21M
>   child 2: memory.current ~= 0
> 
> In reality, the actual memory usages can differ quite a bit from the
> expected values. It uses an error tolerance of 10% with the values_close()
> helper.
> 
> Both the test_memcg_min and test_memcg_low sub-tests can fail
> sporadically because the actual memory usage exceeds the 10% error
> tolerance. Below are a sample of the usage data of the tests runs
> that fail.
> 
>   Child   Actual usage    Expected usage    %err
>   -----   ------------    --------------    ----
>     1       16990208         22020096      -12.9%
>     1       17252352         22020096      -12.1%
>     0       37699584         30408704      +10.7%
>     1       14368768         22020096      -21.0%
>     1       16871424         22020096      -13.2%
> 
> The current 10% error tolerenace might be right at the time
> test_memcontrol.c was first introduced in v4.18 kernel, but memory
> reclaim have certainly evolved quite a bit since then which may result
> in a bit more run-to-run variation than previously expected.
> 
> Increase the error tolerance to 15% for child 0 and 20% for child 1 to
> minimize the chance of this type of failure. The tolerance is bigger
> for child 1 because an upswing in child 0 corresponds to a smaller
> %err than a similar downswing in child 1 due to the way %err is used
> in values_close().
> 
> Before this patch, a 100 test runs of test_memcontrol produced the
> following results:
> 
>      17 not ok 1 test_memcg_min
>      22 not ok 2 test_memcg_low
> 
> After applying this patch, there were no test failure for test_memcg_min
> and test_memcg_low in 100 test runs.

Ideally we want to calculate these values dynamically based on the machine
size (number of cpus and total memory size).

We can calculate the memcg error margin and scale memcg sizes if necessarily.
It's the only way to make it pass both on a 2-CPU's vm and 512-CPU's physical
server.

Not a blocker for this patch, just an idea for the future.

Thanks!

