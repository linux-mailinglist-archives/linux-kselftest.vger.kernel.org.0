Return-Path: <linux-kselftest+bounces-8226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCE8A7632
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9CE1C22B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923CF5D905;
	Tue, 16 Apr 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="UcoBE2bl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0A5A7AA;
	Tue, 16 Apr 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302306; cv=none; b=GtIVvLuFp6qj1Og+7dGg7avWkicY8i028QrXXAEAcf4RUaABmjwATH0DoFv0DxygfgNu5Qoo4Pi57QQo5HDDPqtD+UXHI/QsMYoKYroHjfc9JJrh67VdImhGzvwnYyNYW2NDpVTEzvc26vf5yncs3UZM31jByCr1pxeunINShOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302306; c=relaxed/simple;
	bh=EvbyO7bvRMSDVVZLdFcnu53/hqhD2C/fYZh1qMNWwQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5fkIU/NzoA7x2lYsaau5K+m1zZwG83a1amXpj3NQNvXoPxht5eWW9sMKp+VN3T9zgjxnX2L2GF5+g5Ka5s7NMGIOtjVBPF9ikrcJGutFqz8NxLdTOdYy/xNyeuNhXtlXfUj18tvbGLA3lMcXlTrOAgzw8HY5uttAQqnG+m9LbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=UcoBE2bl; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=39jrlTIKZR26vKSUZInqjb2tqQ7GhCKjcflbulzLrL0=; b=UcoBE2blPfk3dLKdpY2OXEveoB
	89b/qtGoeh044tool43dYwHilWB0RTRjibZyHFWwUuNaloioplc6WAmLhf3rDjCAiJ1oRo72mi5Mq
	UTgk7ZX7C+7g2godKsjZw6pt8CBcElWNquWCvWp+pfRlzaDqTE6fYDvFIBMhs2qGFQwEbi8VqZpRi
	EzFDpo0b+fzDAd8LuyhIabLZZTj+eQzSoeTV4zW66rTEJuHacFchvLZDKDNeexuXAg0SooTLtQ3aY
	avJSQHNuQ2qZzxXbKS2Gf5bwbn4V8SU1EseP018JfcO4X48Qvgs6x+dLvKdDzJnxGnNGcjVKzHQm/
	/PIY4Esw==;
Received: from [10.69.139.14] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwqC2-00GSyt-23;
	Tue, 16 Apr 2024 16:18:18 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Tue, 16 Apr 2024 16:18:17 -0500
Message-ID: <23472492.6Emhk5qWAg@terabithia>
In-Reply-To: <20240416161917.GD12673@noisy.programming.kicks-ass.net>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416155345.GC12673@noisy.programming.kicks-ass.net>
 <20240416161917.GD12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 16 April 2024 11:19:17 CDT Peter Zijlstra wrote:
> On Tue, Apr 16, 2024 at 05:53:45PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 16, 2024 at 05:50:14PM +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 16, 2024 at 10:14:21AM +0200, Peter Zijlstra wrote:
> > > > > Some aspects of the implementation may deserve particular comment:
> > > > > 
> > > > > * In the interest of performance, each object is governed only by a
> > > > > single
> > > > > 
> > > > >   spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of
> > > > >   multiple
> > > > >   objects be changed as a single atomic operation. In order to
> > > > >   achieve this, we first take a device-wide lock ("wait_all_lock")
> > > > >   any time we are going to lock more than one object at a time.
> > > > >   
> > > > >   The maximum number of objects that can be used in a vectored wait,
> > > > >   and
> > > > >   therefore the maximum that can be locked simultaneously, is 64.
> > > > >   This number is NT's own limit.
> > > 
> > > AFAICT:
> > > 	spin_lock(&dev->wait_all_lock);
> > > 	
> > > 	  list_for_each_entry(entry, &obj->all_waiters, node)
> > > 	  
> > > 	    for (i=0; i<count; i++)
> > > 	    
> > > 	      spin_lock_nest_lock(q->entries[i].obj->lock,
> > > 	      &dev->wait_all_lock);
> > > 
> > > Where @count <= NTSYNC_MAX_WAIT_COUNT.
> > > 
> > > So while this nests at most 65 spinlocks, there is no actual bound on
> > > the amount of nested lock sections in total. That is, all_waiters list
> > > can be grown without limits.
> > > 
> > > Can we pretty please make wait_all_lock a mutex ?

That should be fine, at least.

> > Hurmph, it's worse, you do that list walk while holding some obj->lock
> > spinlokc too. Still need to figure out how all that works....
> 
> So the point of having that other lock around is so that things like:
> 
> 	try_wake_all_obj(dev, sem)
> 	try_wake_any_sem(sem)
> 
> are done under the same lock?

The point of having the other lock around is that try_wake_all() needs to lock 
multiple objects at the same time. It's a way of avoiding lock inversion.

Consider task A does a wait-for-all on objects X, Y, Z. Then task B signals Y, 
so we do try_wake_all_obj() on Y, which does try_wake_all() on A's queue 
entry; that needs to check X and Z and consume the state of all three objects 
atomically. Another task could be trying to signal Z at the same time and 
could hit a task waiting on Z, Y, X, and that causes inversion.

The simple and easy way to implement everything is just to have a global lock 
on the whole device, but this is kind of known to be a performance bottleneck 
(this was NT's BKL, and they ditched it starting with Vista or 7 or 
something).

Instead we use a lock per object, and normally in the wait-for-any case we 
only ever need to grab one lock at a time, but when we need to do a wait-for-
all we need to lock multiple objects at once, and we grab the outer lock to 
avoid potential lock inversion.

> Where I seem to note that both those functions do that same list
> iteration.

Over different lists. I don't know if there's a better way to name things to 
make that clearer.

There's the "any" wait queue, which tasks which do a wait-for-any add 
themselves to, and the "all" wait queue, which tasks that do a wait-for-all 
add themselves to. Signaling an object could potentially wake up either one, 
but checking whether a task is eligible is a different process.



