Return-Path: <linux-kselftest+bounces-8185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E18A712D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776191F2219C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2444131BCA;
	Tue, 16 Apr 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n6oZDMS0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4012F387;
	Tue, 16 Apr 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284369; cv=none; b=lh4RxGFEoFRh6UAFdakO15yszLmlXshAntE/2Vff5ttQ/G3rx9sWMzgqllXWwR9JS4ybCAsCBZRiOKVVsT71GzypRcMKSy9/Ouw3RdAlOGzxaoSUEhCRY3BV67ronbkFU97ZL9UrjYwq88leWVg0qQ/wLLVZtPN7tH03VpYmNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284369; c=relaxed/simple;
	bh=3zAPfjvHteJBBddQNYzl55aQUUjHHppgPi7ePDJmnxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trZaFr1yc+gUKGk0qeGLIShlKsPACRgLiQKFeqiyfxMkNXhe0fbdfuD89SCOxYXf6BIq79dA88cDMzkJw6+I4eR9nqZgjYQ4drGru0n/nETPSDhZKTrIZA7rrY8CvLEH+0w+1loIegJhu7QLK9x6eRLGRgiMwtBoB7yFbw0YdbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n6oZDMS0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Xh9QahWZwTjmL2IMPLsv4+7DG/WtPClJRGihDEPKvo=; b=n6oZDMS0oxpy46eVB6FiyrfWLd
	rAK7xR44f9IZl5U2MJX65xNnu1i+rMDlGhugRD9htFwKlOoFSgqk8DRlZD4XhW4zGqtKnRehuwsp/
	EFHzCP4zqGxa8VbgMSR2NEYSMFqK27id8cVxPiNeWy0DxEtRU89UOdnEGzazvZHEOEMDmBDjGMf6L
	U0zhs4xx+pDGGqesbyaR5L4p3aW7XHWQ/p3Wu3o2q5m9Wrp/yBQu+hTRpnLhixgJ7wyprk//+XyqM
	rOIExHsz57qXdMWU4kiASQSsN3H6IyoiE4Ik2i6i2Ar1gUc+6KHaoOOq3qWyzdvTCLAYyph90htdc
	dAtX2orw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlWf-0000000B9dS-2K6S;
	Tue, 16 Apr 2024 16:19:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3544C30047C; Tue, 16 Apr 2024 18:19:17 +0200 (CEST)
Date: Tue, 16 Apr 2024 18:19:17 +0200
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
Message-ID: <20240416161917.GD12673@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
 <20240416155014.GB12673@noisy.programming.kicks-ass.net>
 <20240416155345.GC12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416155345.GC12673@noisy.programming.kicks-ass.net>

On Tue, Apr 16, 2024 at 05:53:45PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 16, 2024 at 05:50:14PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 16, 2024 at 10:14:21AM +0200, Peter Zijlstra wrote:
> > 
> > > > Some aspects of the implementation may deserve particular comment:
> > > > 
> > > > * In the interest of performance, each object is governed only by a single
> > > >   spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of multiple
> > > >   objects be changed as a single atomic operation. In order to achieve this, we
> > > >   first take a device-wide lock ("wait_all_lock") any time we are going to lock
> > > >   more than one object at a time.
> > > > 
> > > >   The maximum number of objects that can be used in a vectored wait, and
> > > >   therefore the maximum that can be locked simultaneously, is 64. This number is
> > > >   NT's own limit.
> > 
> > AFAICT:
> > 
> > 	spin_lock(&dev->wait_all_lock);
> > 	  list_for_each_entry(entry, &obj->all_waiters, node)
> > 	    for (i=0; i<count; i++)
> > 	      spin_lock_nest_lock(q->entries[i].obj->lock, &dev->wait_all_lock);
> > 
> > Where @count <= NTSYNC_MAX_WAIT_COUNT.
> > 
> > So while this nests at most 65 spinlocks, there is no actual bound on
> > the amount of nested lock sections in total. That is, all_waiters list
> > can be grown without limits.
> > 
> > Can we pretty please make wait_all_lock a mutex ?
> 
> Hurmph, it's worse, you do that list walk while holding some obj->lock
> spinlokc too. Still need to figure out how all that works....

So the point of having that other lock around is so that things like:

	try_wake_all_obj(dev, sem)
	try_wake_any_sem(sem)

are done under the same lock?

Where I seem to note that both those functions do that same list
iteration.

Can't you write things like:

static void try_wake_all_obj(struct nysync_device *dev,
			     struct ntsync_obj *obj,
			     void (*wake_obj)(struct ntsync_obj *obj))
{
	list_for_each_entry(entry, &obj->all_waiters, node) {
		spin_lock(&obj->lock);
		try_wake_all(dev, event->q, obj);
		wake_obj(obj);
		spin_unlock(&obj->lock);
	}
}

And then instead of the above, write:

	try_wake_all_obj(dev, sem, wake_sem);

[[ Also, should not something like try_wake_any_sem -- wake_sem in the
   above -- have something like:

	WARN_ON_ONCE(sem->type != NTSYNC_TYPE_SEM);
]]

  

