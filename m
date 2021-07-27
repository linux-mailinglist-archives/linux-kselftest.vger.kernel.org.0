Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29243D747B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 13:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhG0Lmo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 07:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236087AbhG0Lmn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 07:42:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FF6A61A0C;
        Tue, 27 Jul 2021 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627386164;
        bh=kScULZZCypjcOHNbhOUj9pQys0yWEAROn9wACbjozIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8JyQpsRV2qnrTyHfpCN4LeYJtuQKD2lVoLcORs/LIL6Zlfk+9kyrUWwpYLWVH0zC
         da4SkWCfx1FBjXO9GP9sD5YcX7dwO7+aUAGptdmkKD+iau4FPQXrDqvZf/7/iOvINL
         hPupBomYDitrlzXqSt4tgqqnLYI2Tt1erZZv5dqLFsX+/sdb2DjELZQk74bMom9TdJ
         KcCDDCgKTvR9Q4BGNqRgLcv7FjGJG7qUC0JwTdOpDa+T3RxkWbzRnt7Z2YLV8sSelE
         imLHD8oRPKROL+Ha8NMd192W7plhwgLNv5bQ8qDVMtz8sREeVIktU/vSiCj03Wb9u+
         uv+1mXNkUEojg==
Date:   Tue, 27 Jul 2021 13:42:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v3 6/9] cgroup/cpuset: Add a new isolated cpus.partition
 type
Message-ID: <20210727114241.GA283787@lothringen>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720141834.10624-7-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 20, 2021 at 10:18:31AM -0400, Waiman Long wrote:
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=TBD
> 
> commit 994fb794cb252edd124a46ca0994e37a4726a100
> Author: Waiman Long <longman@redhat.com>
> Date:   Sat, 19 Jun 2021 13:28:19 -0400
> 
>     cgroup/cpuset: Add a new isolated cpus.partition type
> 
>     Cpuset v1 uses the sched_load_balance control file to determine if load
>     balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
>     as its use may require disabling load balancing at cgroup root.
> 
>     For workloads that require very low latency like DPDK, the latency
>     jitters caused by periodic load balancing may exceed the desired
>     latency limit.
> 
>     When cpuset v2 is in use, the only way to avoid this latency cost is to
>     use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
>     the kernel boot, however, there is no way to add or remove CPUs from
>     this isolated set. For workloads that are more dynamic in nature, that
>     means users have to provision enough CPUs for the worst case situation
>     resulting in excess idle CPUs.
> 
>     To address this issue for cpuset v2, a new cpuset.cpus.partition type
>     "isolated" is added which allows the creation of a cpuset partition
>     without load balancing. This will allow system administrators to
>     dynamically adjust the size of isolated partition to the current need
>     of the workload without rebooting the system.
> 
>     Signed-off-by: Waiman Long <longman@redhat.com>
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Nice! And while we are adding a new ABI, can we take advantage of that and
add a specific semantic that if a new isolated partition matches a subset of
"isolcpus=", it automatically maps to it. This means that any further
modification to that isolated partition will also modify the associated
isolcpus= subset.

Or to summarize, when we create a new isolated partition, remove the associated
CPUs from isolcpus= ?

Thanks.
