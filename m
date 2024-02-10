Return-Path: <linux-kselftest+bounces-4487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E6D850284
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 05:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AB1C211AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 04:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA18567A;
	Sat, 10 Feb 2024 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imJ6G0w/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14E53B8
	for <linux-kselftest@vger.kernel.org>; Sat, 10 Feb 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707538809; cv=none; b=IXeux+NY5jRJspd2Sbicg9VLNX1dIEY3Ovdt2IdV0IsTMJovZZh/ycWTI3FyaGQssoRvfibEvpIhckqg3I8n6XEbXRZ5XrZKnN2JcRkckIVs5gy2y6kVLOTyenAFebK+oGx4DZv8gfGFl3gvvafdk3DhAjVgTvH5Zi0Vw83XhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707538809; c=relaxed/simple;
	bh=MI1UER5k/zVC0RgJ6mRH32EW0jN5U9Mp1biZX1Oxpww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNfc/qvMc8qco19d3tBG/ym9Fkk9UOtVrJF4xcz4x1f9kRccyZgGKZPIVdoxl1iV9XzQ7ZnxWlfKbqL7N96eYPMQqBqWxVELZUduQEbcBf7J0ABTzowhmRjLhaQ6S2IPNwj/Bvc5WSEqcRIXm8o+iFi6KmG7YUWjjcAGWhtvhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imJ6G0w/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707538806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj8awdQxCDQMdFFZH7GYC8xsn8ZodHraAX8/7iY9PS8=;
	b=imJ6G0w/QGERiOQ5AUw6bzxPNELeat741mP5tj4ehBSBDTD4aArfki46RujhYk7dYz3QKq
	dZe/4ylpYYVRfaK9w7GITrxAs5X3mcSf/lx8dgIAy7jC9EXJEah71iHbqPg3XA7uqhl9cL
	dD2MS+FRvvNHznkE45WTZBc5fJHtdNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-1Up1vlD4PW-fA4xNBnYDpQ-1; Fri, 09 Feb 2024 23:20:02 -0500
X-MC-Unique: 1Up1vlD4PW-fA4xNBnYDpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2213E185A780;
	Sat, 10 Feb 2024 04:20:01 +0000 (UTC)
Received: from [10.22.17.112] (unknown [10.22.17.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B6762166B31;
	Sat, 10 Feb 2024 04:19:58 +0000 (UTC)
Message-ID: <b6e6454a-d08f-4a71-b546-16cf3e2b88a5@redhat.com>
Date: Fri, 9 Feb 2024 23:19:58 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] cgroup/cpuset: Support RCU_NOCB on isolated
 partitions
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
 Ryan Phillips <rphillips@redhat.com>, Brent Rowsell <browsell@redhat.com>,
 Peter Hunt <pehunt@redhat.com>, Cestmir Kalina <ckalina@redhat.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Alex Gladkov <agladkov@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Phil Auld <pauld@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Costa Shulyupin <cshulyup@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
 <ZagJPoEsLZ6Dg-NG@mtj.duckdns.org>
 <5ee5bf79-6cdc-4d1b-a19f-f0d5165a5f16@redhat.com>
 <ZcIsd6fjgmsb2dxr@localhost.localdomain>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZcIsd6fjgmsb2dxr@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 2/6/24 07:56, Frederic Weisbecker wrote:
> Le Wed, Jan 17, 2024 at 12:15:07PM -0500, Waiman Long a écrit :
>> On 1/17/24 12:07, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
>>>> The first 2 patches are adopted from Federic with minor twists to fix
>>>> merge conflicts and compilation issue. The rests are for implementing
>>>> the new cpuset.cpus.isolation_full interface which is essentially a flag
>>>> to globally enable or disable full CPU isolation on isolated partitions.
>>> I think the interface is a bit premature. The cpuset partition feature is
>>> already pretty restrictive and makes it really clear that it's to isolate
>>> the CPUs. I think it'd be better to just enable all the isolation features
>>> by default. If there are valid use cases which can't be served without
>>> disabling some isolation features, we can worry about adding the interface
>>> at that point.
>> My current thought is to make isolated partitions act like isolcpus=domain,
>> additional CPU isolation capabilities are optional and can be turned on
>> using isolation_full. However, I am fine with making all these turned on by
>> default if it is the consensus.
> Right it was the consensus last time I tried. Along with the fact that mutating
> this isolation_full set has to be done on offline CPUs to simplify the whole
> picture.
>
> So lemme try to summarize what needs to be done:
>
> 1) An all-isolation feature file (that is, all the HK_TYPE_* things) on/off for
>    now. And if it ever proves needed, provide a way later for more finegrained
>    tuning.
That is more or less the current plan. As detailed below, HK_TYPE_DOMAIN 
& HK_TYPE_WQ isolation are included in the isolated partitions by 
default. I am also thinking about including other relatively cheap 
isolation flags by default. The expensive ones will have to be enabled 
via isolation_full.
>
> 2) This file must only apply to offline CPUs because it avoids migrations and
>    stuff.
Well, the process of first moving the CPUs offline first is rather 
expensive. I won't mind doing some partial offlining based on the 
existing set of teardown and bringup callbacks, but I would try to avoid 
fully offlining the CPUs first.
>
> 3) I need to make RCU NOCB tunable only on offline CPUs, which isn't that much
>     changes.
>
> 4) HK_TYPE_TIMER:
>     * Wrt. timers in general, not much needs to be done, the CPUs are
>       offline. But:
>     * arch/x86/kvm/x86.c does something weird
>     * drivers/char/random.c might need some care
>     * watchdog needs to be (de-)activated
>     
> 5) HK_TYPE_DOMAIN:
>     * This one I fear is not mutable, this is isolcpus...

HK_TYPE_DOMAIN is already available via the current cpuset isolated 
partition functionality. What I am currently doing is to extend that to 
other HK_TYPE* flags.


>
> 6) HK_TYPE_MANAGED_IRQ:
>     * I prefer not to think about it :-)
>
> 7) HK_TYPE_TICK:
>     * Maybe some tiny ticks internals to revisit, I'll check that.
>     * There is a remote tick to take into consideration, but again the
>       CPUs are offline so it shouldn't be too complicated.
>
> 8) HK_TYPE_WQ:
>     * Fortunately we already have all the mutable interface in place.
>       But we must make it live nicely with the sysfs workqueue affinity
>       files.

HK_TYPE_WQ is basically done and it is going to work properly with the 
workqueue affinity sysfs files. From the workqueue of view, HK_TYPE_WQ 
is currently treated the same as HK_TYPE_DOMAIN.

>
> 9) HK_FLAG_SCHED:
>     * Oops, this one is ignored by nohz_full/isolcpus, isn't it?
>     Should be removed?
I don't think HK_FLAG_SCHED is being used at all. So I believe we should 
remove it to avoid confusion.
>
> 10) HK_TYPE_RCU:
>      * That's point 3) and also some kthreads to affine, which leads us
>       to the following in HK_TYPE_KTHREAD:
>
> 11) HK_FLAG_KTHREAD:
>      * I'm guessing it's fine as long as isolation_full is also an
>        isolated partition. Then unbound kthreads shouldn't run there.

Yes, isolation_full applies only to isolated partitions. It extends the 
amount of CPU isolation by enabling all the other CPU available 
isolation flags.

Cheers,
Longman


