Return-Path: <linux-kselftest+bounces-8098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C28A65DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837431C223A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37980131BC0;
	Tue, 16 Apr 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TFB4qvBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD684FDB;
	Tue, 16 Apr 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255286; cv=none; b=r3vfAFbodIRQb6z29DlAoE2o3Ixvxcuoj9/+X8A4NyQb7cFxH0WWW+pUm9R03TUYShpUxpHNJnXqvg5wcRUc6sgR/bASVJvg22lLWeheD1x13Gy7mBkgakkxx8f3mc3dY8StTPVU7hTcx40+ux3yjJqfTmg6oNzD7+T2czX10HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255286; c=relaxed/simple;
	bh=qbqYO/qkmcHJ9rIi8OxHB+nST1Kb4QPq6SCXNW/Yz98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EucLonWVJfhD7In/+uGfb0iHNQlAbUFqc/LI9GcY1AnbWEwryD6Ld8fQo8GAKwCL79F2hfwF2nzujj8Bf5QK90I6CkkZ4bfadjxfCBAQnc9m8k5/lhAQY/Vs1c38ZEhnv36fy01vn7uoypYcQaT9f/QmcJYwFH+HV1mGWLt4Ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TFB4qvBG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8FtFd8fkjuL3rHBatnhIVfckCIelgtSGQnf7ZO6rrWI=; b=TFB4qvBG6bHk4WsYQdl8qin0tQ
	HpXlbZERVDlP3U9r7temzbhsZeX+vtLXOI/zmKuayl9YgdmTkDhMYGb0fRKokVX73r83d+FQxTAzr
	TJPl7aataHSRVle8SXCuoCHPukmiX/JMGuxitbIXIaxYC9TSLxd8tptfOJpQ+yZSh/TtAR3gKqWM5
	6bTf3BlbNXZFy9t9am4rgTi0cQ5WJWUns67JbYR7jXTNndgZHEOQHZD/tfki8qEHNSD0OCwe2pUEv
	bPKsjvj8ivCOG07er+TR4eKL9Mf1qGc4S0Y0EZhr18xwSgMEbpmRej5cal7laYjPvEWjRX8kqB5JT
	ivgVslqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwdxN-0000000AylZ-2bba;
	Tue, 16 Apr 2024 08:14:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46C6C300473; Tue, 16 Apr 2024 10:14:21 +0200 (CEST)
Date: Tue, 16 Apr 2024 10:14:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Message-ID: <20240416081421.GB31647@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416010837.333694-1-zfigura@codeweavers.com>

On Mon, Apr 15, 2024 at 08:08:10PM -0500, Elizabeth Figura wrote:
> This patch series implements a new char misc driver, /dev/ntsync, which is used
> to implement Windows NT synchronization primitives.

This patch series does not apply to anything I have at hand. Nor does it
state anything explicit to put it on top of.


> Hence I would like to request review from someone familiar with locking to make
> sure that the usage of low-level kernel primitives is correct and that the wait
> queues work as intended, and to that end I've CC'd the locking maintainers.

I am sadly very limited atm, but I'll try and read through it. If only I
could apply...



> == Patches ==
> 
> The intended semantics of the patches are broadly intended to match those of the
> corresponding Windows functions. For those not already familiar with the Windows
> functions (or their undocumented behaviour), patch 27/27 provides a detailed
> specification, and individual patches also include a brief description of the
> API they are implementing.
> 
> The patches making use of this driver in Wine can be retrieved or browsed here:
> 
>     https://repo.or.cz/wine/zf.git/shortlog/refs/heads/ntsync5

I don't support GE has it in his builds? Last time I tried, building
Wine was a bit of a pain.


> Some aspects of the implementation may deserve particular comment:
> 
> * In the interest of performance, each object is governed only by a single
>   spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of multiple
>   objects be changed as a single atomic operation. In order to achieve this, we
>   first take a device-wide lock ("wait_all_lock") any time we are going to lock
>   more than one object at a time.
> 
>   The maximum number of objects that can be used in a vectored wait, and
>   therefore the maximum that can be locked simultaneously, is 64. This number is
>   NT's own limit.
> 
>   The acquisition of multiple spinlocks will degrade performance. This is a
>   conscious choice, however. Wait-for-all is known to be a very rare operation
>   in practice, especially with counts that approach the maximum, and it is the
>   intent of the ntsync driver to optimize wait-for-any at the expense of
>   wait-for-all as much as possible.

Per the example of percpu-rwsem, it would be possible to create a
mutex-spinlock hybrid scheme, where single locks are spinlocks while
held, but can block when the global thing is pending. And the global
lock is always mutex like.

If all that is worth it, I don't know. Nesting 64 spinlocks doesn't give
me warm and fuzzy feelings though.

