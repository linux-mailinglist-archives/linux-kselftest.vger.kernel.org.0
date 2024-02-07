Return-Path: <linux-kselftest+bounces-4455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7E84F95A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA015B22F73
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C997B3C3;
	Fri,  9 Feb 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtEYEL8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBC6F06C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494953; cv=none; b=F2+zI/pDdOdd9c67fqdcoepPchCwTUfTx2euwVUWtuoyvirhL1mP2QX8LUSc2lFt503lZmodbueVGwK9Ao7bof7aLkdE2DEyrRKQeZPvoVWfnhI3u1TgR6ez1m9+z2ADILklSJtYqEg5FZgzNbot3jYWz8n/+LwWUTpxzQq/tn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494953; c=relaxed/simple;
	bh=q6wyummIqcmZDUbzboQvNIEztcMivzauItQGnEHzm+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trA66QeMoKR4COGKOApZK1+bnsfQUfuNHa/aM+xHFoKd2AlSOYDqALhJ1hH0Hv4381RR0tvFVlC6+AkLzToG/Z/0KjzMfNfUm+Pk2ZrXIwhRJFTMXqHEnWcpva26PCghqXXS9FMfWIAuP4OOPCBJAnaPea3cn8kmpg3Heohfgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtEYEL8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707494950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KdzfFxuaAxTQegBPNRDPqdrZtFIwl4Nb3u77kWuWvE=;
	b=ZtEYEL8emyLz6eamcrWcU7CiBYyQRlPu60swHXY9pFerKIqt8wuaNzXB1jBuav7BH/MFCf
	iFXPdwbgul+xxGLugDuylWxZX0w/e67XDF2VcGwJ/2B3iuTqsMoFu3pC9Y03j9CVW46Cm+
	CYA1ejaqTuRI73gd3Z4Wvs8fSwbwwUU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-58nEO-BdNnKrOcjPFr-AOQ-1; Fri,
 09 Feb 2024 11:09:06 -0500
X-MC-Unique: 58nEO-BdNnKrOcjPFr-AOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8651D38116E7;
	Fri,  9 Feb 2024 16:09:04 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D61840C9444;
	Fri,  9 Feb 2024 16:09:03 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 81307400E52ED; Wed,  7 Feb 2024 11:59:21 -0300 (-03)
Date: Wed, 7 Feb 2024 11:59:21 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <ZcOaybEOJrpLsU/2@tpad>
References: <20240117163511.88173-1-longman@redhat.com>
 <ZagJPoEsLZ6Dg-NG@mtj.duckdns.org>
 <5ee5bf79-6cdc-4d1b-a19f-f0d5165a5f16@redhat.com>
 <ZcIsd6fjgmsb2dxr@localhost.localdomain>
 <ZcKFRqrUh5tTbsaJ@tpad>
 <ZcOYEkHCoh75R-LA@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcOYEkHCoh75R-LA@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Feb 07, 2024 at 03:47:46PM +0100, Frederic Weisbecker wrote:
> Le Tue, Feb 06, 2024 at 04:15:18PM -0300, Marcelo Tosatti a écrit :
> > On Tue, Feb 06, 2024 at 01:56:23PM +0100, Frederic Weisbecker wrote:
> > > Le Wed, Jan 17, 2024 at 12:15:07PM -0500, Waiman Long a écrit :
> > > > 
> > > > On 1/17/24 12:07, Tejun Heo wrote:
> > > > > Hello,
> > > > > 
> > > > > On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
> > > > > > The first 2 patches are adopted from Federic with minor twists to fix
> > > > > > merge conflicts and compilation issue. The rests are for implementing
> > > > > > the new cpuset.cpus.isolation_full interface which is essentially a flag
> > > > > > to globally enable or disable full CPU isolation on isolated partitions.
> > > > > I think the interface is a bit premature. The cpuset partition feature is
> > > > > already pretty restrictive and makes it really clear that it's to isolate
> > > > > the CPUs. I think it'd be better to just enable all the isolation features
> > > > > by default. If there are valid use cases which can't be served without
> > > > > disabling some isolation features, we can worry about adding the interface
> > > > > at that point.
> > > > 
> > > > My current thought is to make isolated partitions act like isolcpus=domain,
> > > > additional CPU isolation capabilities are optional and can be turned on
> > > > using isolation_full. However, I am fine with making all these turned on by
> > > > default if it is the consensus.
> > > 
> > > Right it was the consensus last time I tried. Along with the fact that mutating
> > > this isolation_full set has to be done on offline CPUs to simplify the whole
> > > picture.
> > > 
> > > So lemme try to summarize what needs to be done:
> > > 
> > > 1) An all-isolation feature file (that is, all the HK_TYPE_* things) on/off for
> > >   now. And if it ever proves needed, provide a way later for more finegrained
> > >   tuning.
> > > 
> > > 2) This file must only apply to offline CPUs because it avoids migrations and
> > >   stuff.
> > > 
> > > 3) I need to make RCU NOCB tunable only on offline CPUs, which isn't that much
> > >    changes.
> > > 
> > > 4) HK_TYPE_TIMER:
> > >    * Wrt. timers in general, not much needs to be done, the CPUs are
> > >      offline. But:
> > >    * arch/x86/kvm/x86.c does something weird
> > >    * drivers/char/random.c might need some care
> > >    * watchdog needs to be (de-)activated
> > >    
> > > 5) HK_TYPE_DOMAIN:
> > >    * This one I fear is not mutable, this is isolcpus...
> > 
> > Except for HK_TYPE_DOMAIN, i have never seen anyone use any of this
> > flags.
> 
> HK_TYPE_DOMAIN is used by isolcpus=domain,....

> HK_TYPE_MANAGED_IRQ is used by isolcpus=managed_irq,...
> 
> All the others (except HK_TYPE_SCHED) are used by nohz_full=

I mean i've never seen any use of the individual flags being set.

You either want full isolation (nohz_full and all the flags together,
except for HK_TYPE_DOMAIN which is sometimes enabled/disabled), or not.

So why not group them all together ?

Do you know of any separate uses of these flags (except for
HK_TYPE_DOMAIN).

> Thanks.
> 
> > 
> > > 
> > > 6) HK_TYPE_MANAGED_IRQ:
> > >    * I prefer not to think about it :-)
> > > 
> > > 7) HK_TYPE_TICK:
> > >    * Maybe some tiny ticks internals to revisit, I'll check that.
> > >    * There is a remote tick to take into consideration, but again the
> > >      CPUs are offline so it shouldn't be too complicated.
> > > 
> > > 8) HK_TYPE_WQ:
> > >    * Fortunately we already have all the mutable interface in place.
> > >      But we must make it live nicely with the sysfs workqueue affinity
> > >      files.
> > > 
> > > 9) HK_FLAG_SCHED:
> > >    * Oops, this one is ignored by nohz_full/isolcpus, isn't it?
> > >    Should be removed?
> > > 
> > > 10) HK_TYPE_RCU:
> > >     * That's point 3) and also some kthreads to affine, which leads us
> > >      to the following in HK_TYPE_KTHREAD:
> > > 
> > > 11) HK_FLAG_KTHREAD:
> > >     * I'm guessing it's fine as long as isolation_full is also an
> > >       isolated partition. Then unbound kthreads shouldn't run there.
> > > 
> > > 12) HK_TYPE_MISC:
> > >     * Should be fine as ILB isn't running on offline CPUs.
> > > 
> > > Thanks.
> > > 
> > > 
> > 
> 
> 


