Return-Path: <linux-kselftest+bounces-4491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB08850793
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Feb 2024 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA79F28233C
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Feb 2024 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E615BE;
	Sun, 11 Feb 2024 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJD2HE53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8C1106
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Feb 2024 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707616007; cv=none; b=rvXARsaEC8RV3w67JR6q11lzEIEHHbBdjoldqQ6FNZ3dlIOjTyf1hE3lEfFfINC4XWwl+ItMRdyL9kkn5Ep92M6+syWOOlIbOz9l1+B2gR7dFFoRZKWHiEYxri6dti4qoe66HOmiMoyiQ3y9IbxuImLCTTvc8cFNFZcLWI3P/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707616007; c=relaxed/simple;
	bh=BQmjpW0I5tJ8/1nqzqWJxFSuGQt107l1mhgaSnsMkJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVzsE9ruIIjT86vKgO5/kqO5IFf6qiSwHZPnvI/EvgsnC00VESFhmou8PFVW3Epmiy+tudshkDgATkp9fjAhuaYXWlUg6+oMYsEgSbUtyzkhdgbhsn3lko9ZQTsQURyCeLu+7JirAf7NOGa4+XCFnuQDkd85U7hzhVeSDQKyA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJD2HE53; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707616004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGLK4dJX5e1tF4UUiUtCFTTT+Sp7JjuwMt77i6yrPM0=;
	b=SJD2HE53PcdL7kkZ1bIk/R+oz3qr203m6EL2duyoM0o4Jc3zCmNNyOo1O90UX5uKSpwSBW
	iMnxnHUuPprmNjbR/RlBR7ZebO5pNSK//l3eoYj+VP7rMnnSNlQI14WF6Xui+mx6aaVKOc
	xcPjl7uuRvqUPaHN9KzeRS+A7xZJ0/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-yiTLxjd_N9GMU2JQXIMtGQ-1; Sat,
 10 Feb 2024 20:46:41 -0500
X-MC-Unique: yiTLxjd_N9GMU2JQXIMtGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7C7E38212CD;
	Sun, 11 Feb 2024 01:46:40 +0000 (UTC)
Received: from [10.22.16.18] (unknown [10.22.16.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99E84111CD4C;
	Sun, 11 Feb 2024 01:46:34 +0000 (UTC)
Message-ID: <099a0310-6805-4ad5-aa99-2589e768acd6@redhat.com>
Date: Sat, 10 Feb 2024 20:46:34 -0500
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
To: paulmck@kernel.org
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Frederic Weisbecker <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
 <ad806d7c-91ec-4659-9348-1b0bb42dd417@paulmck-laptop>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ad806d7c-91ec-4659-9348-1b0bb42dd417@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 1/19/24 05:24, Paul E. McKenney wrote:
> On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
>> This patch series is based on the RFC patch from Frederic [1]. Instead
>> of offering RCU_NOCB as a separate option, it is now lumped into a
>> root-only cpuset.cpus.isolation_full flag that will enable all the
>> additional CPU isolation capabilities available for isolated partitions
>> if set. RCU_NOCB is just the first one to this party. Additional dynamic
>> CPU isolation capabilities will be added in the future.
>>
>> The first 2 patches are adopted from Federic with minor twists to fix
>> merge conflicts and compilation issue. The rests are for implementing
>> the new cpuset.cpus.isolation_full interface which is essentially a flag
>> to globally enable or disable full CPU isolation on isolated partitions.
>> On read, it also shows the CPU isolation capabilities that are currently
>> enabled. RCU_NOCB requires that the rcu_nocbs option be present in
>> the kernel boot command line. Without that, the rcu_nocb functionality
>> cannot be enabled even if the isolation_full flag is set. So we allow
>> users to check the isolation_full file to verify that if the desired
>> CPU isolation capability is enabled or not.
>>
>> Only sanity checking has been done so far. More testing, especially on
>> the RCU side, will be needed.
> There has been some discussion of simplifying the (de-)offloading code
> to handle only offline CPUs.  Along with some discussion of eliminating
> the (de-)offloading capability altogehter.
>
> We clearly should converge on the capability to be provided before
> exposing this to userspace.  ;-)

Would you mind giving me a pointer to the discussion of simplifying the 
de-offloading code to  handle only offline CPUs?

Thanks,
Longman


