Return-Path: <linux-kselftest+bounces-8182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4C8A702C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA3E281A83
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393D1311AF;
	Tue, 16 Apr 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hiIgWI9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD41311B5;
	Tue, 16 Apr 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282626; cv=none; b=EgeH8Ephu6vQHfSVuknxjSnu10FSSuZvMO0cBsRbqD5irNbMbM/RMI05hXAE/OOz+ysoViVSJIDMWayRLXC+5HjoowX9f2lYNdLRBpr7m/VogTXS7P/QNkchsgzbzpH6lsMujKSBbOueMEE3zzL/QziWNCenX6pNmPTeC8Cz4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282626; c=relaxed/simple;
	bh=3Y9O0MlxyrAJ2pHeJl4SB/ssSLif36xZUfaHCTP0w1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAQstXZ12wgZ6kktvHBjSUKEr9nj2EuBOczxYM8nmp5B8ctNEze7/ulQMl8Otwp/ygrwvWi69pRj5T+Be1EW/M+vZWiMHbsbuLf5QipsVA8CITZfWsMfPAV+zgEPBI1i3socTNncO1LcoU4oEjt514btB1yjCodKPk1yLmNkM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hiIgWI9h; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wVWhOXvGG+yObUBTl7o/q7ZThNzkFqz22v3LgF9rG04=; b=hiIgWI9hsxFGLq9jXQ9mjcpQd2
	UF1ybZKNzoUandzUz0yQWqJF0SjY+Wfs5LZ0z7dHeTt6ymH2hhcHROmAanmEC2gC3PxMvh75VWdtl
	yo63GebQ3mzj3xr35c8S+qzrbaSj0pVQ3ifm6BGkwriazxon0AJWY4bldKRhkRDpgsCE3BWweL016
	JTsHWwEwEV83R8ulEYAdETg5EMr6ZQXg4HaAKqlGElSpCw7mO2mG9HlzqX2uMuad4l2d0P85H+jpG
	peIeh102/pwL/zAZRjIefAw25/4hZd+QhYOrVGN2F4gHWbtiF5m6xoLC6yXTYHlAxLMJy98N1ijo8
	3tOXdM4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwl4Y-0000000B8Vt-416A;
	Tue, 16 Apr 2024 15:50:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 812F530040C; Tue, 16 Apr 2024 17:50:14 +0200 (CEST)
Date: Tue, 16 Apr 2024 17:50:14 +0200
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
Message-ID: <20240416155014.GB12673@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416081421.GB31647@noisy.programming.kicks-ass.net>

On Tue, Apr 16, 2024 at 10:14:21AM +0200, Peter Zijlstra wrote:

> > Some aspects of the implementation may deserve particular comment:
> > 
> > * In the interest of performance, each object is governed only by a single
> >   spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of multiple
> >   objects be changed as a single atomic operation. In order to achieve this, we
> >   first take a device-wide lock ("wait_all_lock") any time we are going to lock
> >   more than one object at a time.
> > 
> >   The maximum number of objects that can be used in a vectored wait, and
> >   therefore the maximum that can be locked simultaneously, is 64. This number is
> >   NT's own limit.

AFAICT:

	spin_lock(&dev->wait_all_lock);
	  list_for_each_entry(entry, &obj->all_waiters, node)
	    for (i=0; i<count; i++)
	      spin_lock_nest_lock(q->entries[i].obj->lock, &dev->wait_all_lock);

Where @count <= NTSYNC_MAX_WAIT_COUNT.

So while this nests at most 65 spinlocks, there is no actual bound on
the amount of nested lock sections in total. That is, all_waiters list
can be grown without limits.

Can we pretty please make wait_all_lock a mutex ?

> >   The acquisition of multiple spinlocks will degrade performance. This is a
> >   conscious choice, however. Wait-for-all is known to be a very rare operation
> >   in practice, especially with counts that approach the maximum, and it is the
> >   intent of the ntsync driver to optimize wait-for-any at the expense of
> >   wait-for-all as much as possible.

Typical sane usage is a good guide for performance, but you must not
forget about malicious userspace and what they can do on purpose to mess
you up.


Anyway, let me stare more at all this....

