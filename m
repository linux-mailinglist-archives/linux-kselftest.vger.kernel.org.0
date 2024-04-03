Return-Path: <linux-kselftest+bounces-7100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64088973A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79B81C27EEB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A33014A4FF;
	Wed,  3 Apr 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDPLt6si"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525514A4E4
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157048; cv=none; b=cpDkfxjp5OrhNERA0klG+0FJMDh2uUgBrXlI2yx91azvJJnpJZajSAZTvxCvyZdww64gBzUJX24q0vV0CgrWzV1P4nfTIFw8s2WkwAur/QKKSDXFuKlh3a364z7YnST8Gg5EzU8H5squ4ikmBGBjKT8s5RhWYlZm39tRVXE2vPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157048; c=relaxed/simple;
	bh=anwzlEybqYMGwaD+F9GCbHmbnWkGkyE/W+MYH3vfNAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQpW2U7HzGUUpVHxSNj+dR+iShOvcCSt7Y+TjuWOYfRJxvh3PjZTgHzLVTGqTfPolYYfC9onuIIbNaCQehuj9o4uQSX+31xxc/0LiF0GuJTC3ApgVXElYDJRYLVJCur9SpEZGBOGSkq8NePN5S42CjgJaQ454axTfzR0ATMll74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDPLt6si; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712157045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcTH6u0Rlg+BVw+a7Jg/5/hidJ0AE0bMPe3NIsD6EkA=;
	b=bDPLt6sibniL94jXKHcQabn5v15dNcmY8O0sa5Yq9VKF17RLzt/xHmVHNZDP1EQzBLBdus
	TipUGdVveH8Jx2/5Ga2G3XRs9ZLsjsTMUrCigRWye8ceT70dQlwsHGOrRjOVicwMGWUHu6
	xrZBfTw67qlD2Rbk7U3GZ7gV5yrqjRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-5XXZIlPLMNmZ6TxIZUFe7A-1; Wed, 03 Apr 2024 11:10:40 -0400
X-MC-Unique: 5XXZIlPLMNmZ6TxIZUFe7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E328A80B1E3;
	Wed,  3 Apr 2024 15:10:38 +0000 (UTC)
Received: from [10.22.33.218] (unknown [10.22.33.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80B2B2166B31;
	Wed,  3 Apr 2024 15:10:37 +0000 (UTC)
Message-ID: <ae27aa5a-4c34-46dd-b139-3017729e2c1f@redhat.com>
Date: Wed, 3 Apr 2024 11:10:37 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Barry Song <song.bao.hua@hisilicon.com>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
 <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
 <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <620d1b70-cfbc-4b76-ad04-b3be559afd56@redhat.com>
 <tm5kvzgn2g5yv63zoyqvd2bdrgl7l3ytffu4cq4ybxyq5irp76@hpmq3zfbtmlp>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <tm5kvzgn2g5yv63zoyqvd2bdrgl7l3ytffu4cq4ybxyq5irp76@hpmq3zfbtmlp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 4/3/24 10:56, Michal Koutný wrote:
> On Wed, Apr 03, 2024 at 10:47:33AM -0400, Waiman Long <longman@redhat.com> wrote:
>> should be rare these days as it will only apply in the case of cgroup
>> v1 under certain condtion,
> Could the migration be simply omitted it those special cases?
>
> (Tasks remain in cpusets with empty cpusets -- that already happens in
> with the current patch before workqueue is dispatched.)

The tasks should not be runnable if there is no CPUs left in their v1 
cpuset. Migrating them to a parent with runnable CPUs is the current way 
which I don't want to break. Alternatively, we could force it to fall 
back to cgroup v2 behavior using the CPUs in their parent cpuset.

Cheers,
Longman

>
> Michal


