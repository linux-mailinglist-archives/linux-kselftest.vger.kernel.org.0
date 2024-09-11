Return-Path: <linux-kselftest+bounces-17736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B91974D95
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48897282B8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DC1714C0;
	Wed, 11 Sep 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GnJrQka7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j4S315vw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768ED15EFB9;
	Wed, 11 Sep 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044885; cv=none; b=t3/5cETZi0cpTsLR+UJrmRwyCnIu/Lee6IJU/+d5S9bNdkzsizPx6yx5rqalCeuO739sr7cxdFKwAJX4miD5m5K2J2npHqh6CZNysZt3rNL/KoHaTArYIbRANhzK5aF4DfPZjlPFlJK3liZgVe0ktnv6qjl/ebmSaJFNP6siLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044885; c=relaxed/simple;
	bh=Ia5lmZBVLJrbaO6z3AnbdyZ8EauRGs2je4iFnOPryh4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cv/id2FyEAu4Eqj29Qs/ybukB2NyOoVDEww4JdBzVf3L4E28nF/vrOv/qMglWBCYe3Sii6RSjRCXqgb/yZHqcDvn0XV7fhlR+6UNadc86w5DdExxy0HoiVtXsaLa3Cu84W/j+vPJEWyAmAkd8XOm7TvE2gOg2TLbra6TYGzvNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GnJrQka7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j4S315vw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726044882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIWotiYC5Y4E+rxhEG44q+nipjMbhXVcKsGP/nRiJ24=;
	b=GnJrQka7HOInLWqWmsZ6qkHZ0W9Rj5dZZExzd3hvgYSTK0fpI6HL+0e8KjAHudy4kDjpxy
	MxIz+brSXXuagOpfEkXDNNkCPqTiYMqQyMdXfccDcKB9KUouBqPqqXeBfWK2oP4fISlU1D
	n7AtQv7jfK6LRL3xox/WnFCE+IqlAe5Nr7QiRLB8dInilr6U+fR3EEC0kioII5QUxv/OrA
	bfM4Y+wwYlukjtl0dI4jtS6L4NSDu8+9hgWnwvEtB8lvYDpdJ/wNRYat1t5TGQGxPyyKTr
	nfL+jZkLYyW8//Xd3ldFa7ks7tDPyswjuMy4A0qsev4HdZy8NG4iD90mbry+tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726044882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIWotiYC5Y4E+rxhEG44q+nipjMbhXVcKsGP/nRiJ24=;
	b=j4S315vwGFT9faWUP5mefHu/YN3jS/hgY1kW7RTFqW5uO+/pVR6eg/jbfC3j3aPFnwNw84
	ZxIn8qa5KOliF0Cg==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize
 performance and improve readability
In-Reply-To: <85a8aa26-f135-fdde-fadf-c2b38a563805@huawei.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
 <20240904134152.2141-4-thunder.leizhen@huawei.com> <87jzfkbrgf.ffs@tglx>
 <5333927d-3f21-b7cc-8c57-6e21f1b4a3e5@huawei.com> <87bk0vbumx.ffs@tglx>
 <85a8aa26-f135-fdde-fadf-c2b38a563805@huawei.com>
Date: Wed, 11 Sep 2024 10:54:41 +0200
Message-ID: <878qvya7u6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 11 2024 at 15:44, Leizhen wrote:
> On 2024/9/10 19:44, Thomas Gleixner wrote:
>> That minimizes the pool lock contention and the cache foot print. The
>> global to free pool must have an extra twist to accomodate non-batch
>> sized drops and to handle the all slots are full case, but that's just a
>> trivial detail.
>
> That's great. I really admire you for completing the refactor in such a
> short of time.

The trick is to look at it from the data model and not from the
code. You need to sit down and think about which data model is required
to achieve what you want. So the goal was batching, right?

That made it clear that the global pools need to be stacks of batches
and never handle single objects because that makes it complex. As a
consequence the per cpu pool is the one which does single object
alloc/free and then either gets a full batch from the global pool or
drops one into it. The rest is just mechanical.

> But I have a few minor comments.
> 1. When kmem_cache_zalloc() is called to allocate objs for filling,
>    if less than one batch of objs are allocated, all of them can be
>    pushed to the local CPU. That's, call pcpu_free() one by one.

If that's the case then we should actually immediately give them back
because thats a sign of memory pressure.

> 2. Member tot_cnt of struct global_pool can be deleted. We can get it
>    simply and quickly through (slot_idx * ODEBUG_BATCH_SIZE). Avoid
>    redundant maintenance.

Agreed.

> 3. debug_objects_pool_min_level also needs to be adjusted accordingly,
>    the number of batches of the min level.

Sure. There are certainly more problems with that code. As I said, it's
untested and way to big to be reviewed. I'll split it up into more
manageable bits and pieces.

Thanks,

        tglx

