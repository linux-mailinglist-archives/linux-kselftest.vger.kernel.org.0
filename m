Return-Path: <linux-kselftest+bounces-4203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698E784BE16
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 20:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5141C227CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 19:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFB14014;
	Tue,  6 Feb 2024 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elWmJSmz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933114274
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247782; cv=none; b=CFZ/mQvTOVEZ9vRGzjGiotq8s/J2w5ZmzU1za19fBGS4WHylnvKGheI3PtJkwI3IWOo8btEJAIU/tKj1NCg5QpcFFlkLuVK06mCBRGTbgYLL157Fn/OqHWn3W7R0k0KvvGEbt+geezCGo/Nrs452POrc0yhwB9FlzvOAUsja5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247782; c=relaxed/simple;
	bh=XZkQUMsfnvjrmuHhGG32XgueQTUnlS3+DOH+pSVZ9V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0FX4UKbbDWGUPaSZBmkiM/MYaScLipWsCf+4Up9iY8yqaO69gBVQBDWf0J11SNOnlCrdcegGYmkbKLu81LOHmWgwSQYbZqhjpSM3kOACDeKCA0xZZTy0w3cC0UMEhPlCnOon01+yAGaa56p8IF/HgY3SL0cSgudZsl1s7nPj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elWmJSmz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707247780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cVRs7KeAPV1Z6Jd/uVlTNTCTsZbLZD+HLSKeeEyC2I=;
	b=elWmJSmzT5SO2YQC1A/yzPoCtSVSnOalZxSjS9AJjbLTZFtc8pR2M81e8RxEempblKgGFT
	Hw5vNr9e2pn26UzbgqYZCavd5a7JaLWtdT2s1CdU3xbkxJV7flQI6VdZuL9bmyxQsaTEEO
	Z7+nCP8oIUsp7M9Q08CWzTpYWs0drfg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35--OZ5BSJwN7SNOU60aDZ1nA-1; Tue,
 06 Feb 2024 14:29:37 -0500
X-MC-Unique: -OZ5BSJwN7SNOU60aDZ1nA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9F401C060CE;
	Tue,  6 Feb 2024 19:29:35 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 634C02026D08;
	Tue,  6 Feb 2024 19:29:33 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 8DA37401E0C72; Tue,  6 Feb 2024 16:15:18 -0300 (-03)
Date: Tue, 6 Feb 2024 16:15:18 -0300
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
Message-ID: <ZcKFRqrUh5tTbsaJ@tpad>
References: <20240117163511.88173-1-longman@redhat.com>
 <ZagJPoEsLZ6Dg-NG@mtj.duckdns.org>
 <5ee5bf79-6cdc-4d1b-a19f-f0d5165a5f16@redhat.com>
 <ZcIsd6fjgmsb2dxr@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcIsd6fjgmsb2dxr@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, Feb 06, 2024 at 01:56:23PM +0100, Frederic Weisbecker wrote:
> Le Wed, Jan 17, 2024 at 12:15:07PM -0500, Waiman Long a écrit :
> > 
> > On 1/17/24 12:07, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
> > > > The first 2 patches are adopted from Federic with minor twists to fix
> > > > merge conflicts and compilation issue. The rests are for implementing
> > > > the new cpuset.cpus.isolation_full interface which is essentially a flag
> > > > to globally enable or disable full CPU isolation on isolated partitions.
> > > I think the interface is a bit premature. The cpuset partition feature is
> > > already pretty restrictive and makes it really clear that it's to isolate
> > > the CPUs. I think it'd be better to just enable all the isolation features
> > > by default. If there are valid use cases which can't be served without
> > > disabling some isolation features, we can worry about adding the interface
> > > at that point.
> > 
> > My current thought is to make isolated partitions act like isolcpus=domain,
> > additional CPU isolation capabilities are optional and can be turned on
> > using isolation_full. However, I am fine with making all these turned on by
> > default if it is the consensus.
> 
> Right it was the consensus last time I tried. Along with the fact that mutating
> this isolation_full set has to be done on offline CPUs to simplify the whole
> picture.
> 
> So lemme try to summarize what needs to be done:
> 
> 1) An all-isolation feature file (that is, all the HK_TYPE_* things) on/off for
>   now. And if it ever proves needed, provide a way later for more finegrained
>   tuning.
> 
> 2) This file must only apply to offline CPUs because it avoids migrations and
>   stuff.
> 
> 3) I need to make RCU NOCB tunable only on offline CPUs, which isn't that much
>    changes.
> 
> 4) HK_TYPE_TIMER:
>    * Wrt. timers in general, not much needs to be done, the CPUs are
>      offline. But:
>    * arch/x86/kvm/x86.c does something weird
>    * drivers/char/random.c might need some care
>    * watchdog needs to be (de-)activated
>    
> 5) HK_TYPE_DOMAIN:
>    * This one I fear is not mutable, this is isolcpus...

Except for HK_TYPE_DOMAIN, i have never seen anyone use any of this
flags.

> 
> 6) HK_TYPE_MANAGED_IRQ:
>    * I prefer not to think about it :-)
> 
> 7) HK_TYPE_TICK:
>    * Maybe some tiny ticks internals to revisit, I'll check that.
>    * There is a remote tick to take into consideration, but again the
>      CPUs are offline so it shouldn't be too complicated.
> 
> 8) HK_TYPE_WQ:
>    * Fortunately we already have all the mutable interface in place.
>      But we must make it live nicely with the sysfs workqueue affinity
>      files.
> 
> 9) HK_FLAG_SCHED:
>    * Oops, this one is ignored by nohz_full/isolcpus, isn't it?
>    Should be removed?
> 
> 10) HK_TYPE_RCU:
>     * That's point 3) and also some kthreads to affine, which leads us
>      to the following in HK_TYPE_KTHREAD:
> 
> 11) HK_FLAG_KTHREAD:
>     * I'm guessing it's fine as long as isolation_full is also an
>       isolated partition. Then unbound kthreads shouldn't run there.
> 
> 12) HK_TYPE_MISC:
>     * Should be fine as ILB isn't running on offline CPUs.
> 
> Thanks.
> 
> 


