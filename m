Return-Path: <linux-kselftest+bounces-4242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725A84CD2C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CBC1C223E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3297F477;
	Wed,  7 Feb 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icYajaCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C127D3E6;
	Wed,  7 Feb 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317269; cv=none; b=t/AfrvzZKvEJfMvQ0/MXJLmniPCW0FUVaTQbLtFq1SPiwdPoV6FGdMX+FKiKKTJKWryV8X8VIvXqYKv5OCpufvwziFz4o5FwpPlohjp2uH9HKcqUvnpvZ8M9q2whbqJiZy09a0N+VdbkQrzaGGVYsP50ed7zDVTvOsxIDPM2kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317269; c=relaxed/simple;
	bh=dqeS7RKaqg5NSBHC9tqAZ0jlOtvjCCV80N050qidhz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzRYVwZOikh7PXvTpnuv/06Xu2fFITQA/EscgbNhWI5kfxylcErZiV/1PxlIryufU3rJnoZvIAr4aIQmDhl6b/8pnBpQ2Z2cFm4wPcMxSxIvyU36uZIu6wu/4mG4wKQDKvVQMT+A4rIm0lvfKnBhZYek5fsNYsl7TkK7K6SNJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icYajaCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B241DC433C7;
	Wed,  7 Feb 2024 14:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707317269;
	bh=dqeS7RKaqg5NSBHC9tqAZ0jlOtvjCCV80N050qidhz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icYajaCA2tFuTuC9D1SNlZkAipRaQApzHfHrIPO4rCmYFsJxTQhhfFshiqBzaCWju
	 y12CJHYXvQttTjw5qpXSAtyLcfMStuhpTAyRQEhLzToFX0NrTqDP81kOhE2wMFrQpM
	 HQB9k4CEAY9lkMSxxC4tQYBwQ1ilFaMSUNmfR1zqzAlallx3LLJP2zBl/kNfc8/tvz
	 7y6rbmy/s3mgvrPkcOT9x/RJ0buI/rNL47I4cQaFBkfRU1n/g7tiArc81Jx7KqxO5w
	 ySeNZCGRyg6jIOTOdyZoouhyyFlMC3z9ynle0GLAdzOCw7gKdklno1RqDO4QEusQcT
	 XVhPLhZv65j0w==
Date: Wed, 7 Feb 2024 15:47:46 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>, Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [RFC PATCH 0/8] cgroup/cpuset: Support RCU_NOCB on isolated
 partitions
Message-ID: <ZcOYEkHCoh75R-LA@localhost.localdomain>
References: <20240117163511.88173-1-longman@redhat.com>
 <ZagJPoEsLZ6Dg-NG@mtj.duckdns.org>
 <5ee5bf79-6cdc-4d1b-a19f-f0d5165a5f16@redhat.com>
 <ZcIsd6fjgmsb2dxr@localhost.localdomain>
 <ZcKFRqrUh5tTbsaJ@tpad>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcKFRqrUh5tTbsaJ@tpad>

Le Tue, Feb 06, 2024 at 04:15:18PM -0300, Marcelo Tosatti a écrit :
> On Tue, Feb 06, 2024 at 01:56:23PM +0100, Frederic Weisbecker wrote:
> > Le Wed, Jan 17, 2024 at 12:15:07PM -0500, Waiman Long a écrit :
> > > 
> > > On 1/17/24 12:07, Tejun Heo wrote:
> > > > Hello,
> > > > 
> > > > On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
> > > > > The first 2 patches are adopted from Federic with minor twists to fix
> > > > > merge conflicts and compilation issue. The rests are for implementing
> > > > > the new cpuset.cpus.isolation_full interface which is essentially a flag
> > > > > to globally enable or disable full CPU isolation on isolated partitions.
> > > > I think the interface is a bit premature. The cpuset partition feature is
> > > > already pretty restrictive and makes it really clear that it's to isolate
> > > > the CPUs. I think it'd be better to just enable all the isolation features
> > > > by default. If there are valid use cases which can't be served without
> > > > disabling some isolation features, we can worry about adding the interface
> > > > at that point.
> > > 
> > > My current thought is to make isolated partitions act like isolcpus=domain,
> > > additional CPU isolation capabilities are optional and can be turned on
> > > using isolation_full. However, I am fine with making all these turned on by
> > > default if it is the consensus.
> > 
> > Right it was the consensus last time I tried. Along with the fact that mutating
> > this isolation_full set has to be done on offline CPUs to simplify the whole
> > picture.
> > 
> > So lemme try to summarize what needs to be done:
> > 
> > 1) An all-isolation feature file (that is, all the HK_TYPE_* things) on/off for
> >   now. And if it ever proves needed, provide a way later for more finegrained
> >   tuning.
> > 
> > 2) This file must only apply to offline CPUs because it avoids migrations and
> >   stuff.
> > 
> > 3) I need to make RCU NOCB tunable only on offline CPUs, which isn't that much
> >    changes.
> > 
> > 4) HK_TYPE_TIMER:
> >    * Wrt. timers in general, not much needs to be done, the CPUs are
> >      offline. But:
> >    * arch/x86/kvm/x86.c does something weird
> >    * drivers/char/random.c might need some care
> >    * watchdog needs to be (de-)activated
> >    
> > 5) HK_TYPE_DOMAIN:
> >    * This one I fear is not mutable, this is isolcpus...
> 
> Except for HK_TYPE_DOMAIN, i have never seen anyone use any of this
> flags.

HK_TYPE_DOMAIN is used by isolcpus=domain,....
HK_TYPE_MANAGED_IRQ is used by isolcpus=managed_irq,...

All the others (except HK_TYPE_SCHED) are used by nohz_full=

Thanks.

> 
> > 
> > 6) HK_TYPE_MANAGED_IRQ:
> >    * I prefer not to think about it :-)
> > 
> > 7) HK_TYPE_TICK:
> >    * Maybe some tiny ticks internals to revisit, I'll check that.
> >    * There is a remote tick to take into consideration, but again the
> >      CPUs are offline so it shouldn't be too complicated.
> > 
> > 8) HK_TYPE_WQ:
> >    * Fortunately we already have all the mutable interface in place.
> >      But we must make it live nicely with the sysfs workqueue affinity
> >      files.
> > 
> > 9) HK_FLAG_SCHED:
> >    * Oops, this one is ignored by nohz_full/isolcpus, isn't it?
> >    Should be removed?
> > 
> > 10) HK_TYPE_RCU:
> >     * That's point 3) and also some kthreads to affine, which leads us
> >      to the following in HK_TYPE_KTHREAD:
> > 
> > 11) HK_FLAG_KTHREAD:
> >     * I'm guessing it's fine as long as isolation_full is also an
> >       isolated partition. Then unbound kthreads shouldn't run there.
> > 
> > 12) HK_TYPE_MISC:
> >     * Should be fine as ILB isn't running on offline CPUs.
> > 
> > Thanks.
> > 
> > 
> 

