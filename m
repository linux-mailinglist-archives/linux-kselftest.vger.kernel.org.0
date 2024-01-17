Return-Path: <linux-kselftest+bounces-3167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9052830BC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9560D28D490
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563E225D9;
	Wed, 17 Jan 2024 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POFlDrid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A184225A1
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511717; cv=none; b=H6CfAWrWF6MTYcBWaMBaLsMZ2M5pZCnToEjsuraF5mDNlw43z/7QHaX1SRSuUa1ChI2GWo13EPxUsNjpQHKUOgW3IQV+4mtDgEuIQQ1l7qHlfmehZ7bqXyRyT6x+xJ1sMP96McSfZBMV79hz318BDqb0oJLQkGBox+4JtjQ5iGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511717; c=relaxed/simple;
	bh=T7IslF0lI3yblMUodVhB9tJHIl2XHIH3degOHlEEIZ4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By; b=LFukDD/KsU25dg+f8k7eo4i2ihmUBYwr+JRC1WqNbhEGkStP0Porfm4G5qK8Drk4JJP4lyEOKst77yc7wEGEtlt2eT9Fj786s9aYX2VTD0NNdMBV8C3dHFaWvjvz//aDndDDzYLU5haPW+TSCiJEp6Fn+3dnWP1q+8zkrl613n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POFlDrid; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705511715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGm/eLi1COg3Vpc3apSqmPNHHb4PLdH7xLSc6T9224c=;
	b=POFlDridqg/rsFuOtpj1oakrxzx5nOGKlm4VcJBEye7/Qh07bAxTWJsmaMjKggvs86tRdY
	/9xdLu2uu/cUHjTCk+IW8CdxGJestkMmEQABb1RQTcBs2gfzqZn+PtkglcwX4FXFx6Gqv8
	BsRJlk+om9005AZp9PoR5RW8Dv4Rat8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-7Yv0cQF3P-OKvQw7cQLm-g-1; Wed, 17 Jan 2024 12:15:11 -0500
X-MC-Unique: 7Yv0cQF3P-OKvQw7cQLm-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0782885CBA5;
	Wed, 17 Jan 2024 17:15:10 +0000 (UTC)
Received: from [10.22.16.147] (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7E4F2026D6F;
	Wed, 17 Jan 2024 17:15:07 +0000 (UTC)
Message-ID: <5ee5bf79-6cdc-4d1b-a19f-f0d5165a5f16@redhat.com>
Date: Wed, 17 Jan 2024 12:15:07 -0500
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
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Frederic Weisbecker <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZagJPoEsLZ6Dg-NG@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 1/17/24 12:07, Tejun Heo wrote:
> Hello,
>
> On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
>> The first 2 patches are adopted from Federic with minor twists to fix
>> merge conflicts and compilation issue. The rests are for implementing
>> the new cpuset.cpus.isolation_full interface which is essentially a flag
>> to globally enable or disable full CPU isolation on isolated partitions.
> I think the interface is a bit premature. The cpuset partition feature is
> already pretty restrictive and makes it really clear that it's to isolate
> the CPUs. I think it'd be better to just enable all the isolation features
> by default. If there are valid use cases which can't be served without
> disabling some isolation features, we can worry about adding the interface
> at that point.

My current thought is to make isolated partitions act like 
isolcpus=domain, additional CPU isolation capabilities are optional and 
can be turned on using isolation_full. However, I am fine with making 
all these turned on by default if it is the consensus.

Cheers,
Longman


