Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD33A3431
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJTmJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJTmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 15:42:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F589C061574;
        Thu, 10 Jun 2021 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dFVbMgHSVXeqKN6P1dJ+5aGTI7wSx+DxBg16yiPD+NU=; b=jLWPqrtTHgNShn8IpLGkd6FVZ3
        izj6LMj2aFyZzsEkle6f5RA+iQCJVb9B2PjXWPNQtwI7lOQfDhA07umz1wQEi89AcaF/T3JA5MdQP
        U3PE/a9COCNVIXjSrn6TYJgtyiBpWeJVmsgb0/O83RY1Lwybg5rDDktCwQI0h4MwYYS2N18/wc3Lf
        i7qeN9Mfj4Ux1UzKetZKr2BUtH1JMEiJqcWxv0/E1OhXjMVlpZXEphZ/8r9LGCLa6xboy6Jq0ABya
        eG/+sh4cdiXw55XeyETHRsXU/l6jlFvf2G6lBGetSMirYQJI1sTMe1W6EWeguc9qbkJNm8jNA0+iN
        OOYGIErQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrQWe-00228z-HP; Thu, 10 Jun 2021 19:39:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5EDD3001E4;
        Thu, 10 Jun 2021 21:39:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6379721AB0AC0; Thu, 10 Jun 2021 21:39:35 +0200 (CEST)
Date:   Thu, 10 Jun 2021 21:39:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/5] cgroup/cpuset: Add new cpus.partition type with no
 load balancing
Message-ID: <YMJqd1JJcFTThH8j@hirez.programming.kicks-ass.net>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-3-longman@redhat.com>
 <YMJfDHr1+xxm6SBi@hirez.programming.kicks-ass.net>
 <820aff72-fce2-ac2f-88e6-787249e04308@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820aff72-fce2-ac2f-88e6-787249e04308@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 10, 2021 at 03:16:29PM -0400, Waiman Long wrote:
> On 6/10/21 2:50 PM, Peter Zijlstra wrote:
> > On Thu, Jun 03, 2021 at 05:24:13PM -0400, Waiman Long wrote:
> > > Cpuset v1 uses the sched_load_balance control file to determine if load
> > > balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
> > > as its use may require disabling load balancing at cgroup root.
> > > 
> > > For workloads that require very low latency like DPDK, the latency
> > > jitters caused by periodic load balancing may exceed the desired
> > > latency limit.
> > > 
> > > When cpuset v2 is in use, the only way to avoid this latency cost is to
> > > use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
> > > the kernel boot, however, there is no way to add or remove CPUs from
> > > this isolated set. For workloads that are more dynamic in nature, that
> > > means users have to provision enough CPUs for the worst case situation
> > > resulting in excess idle CPUs.
> > > 
> > > To address this issue for cpuset v2, a new cpuset.cpus.partition type
> > > "root-nolb" is added which allows the creation of a cpuset partition with
> > > no load balancing. This will allow system administrators to dynamically
> > > adjust the size of the no load balancing partition to the current need
> > > of the workload without rebooting the system.
> > I'm confused, why do you need this? Just create a parition for each cpu.
> > 
> From a management point of view, it is more cumbersome to do one cpu per
> partition. I have suggested this idea of 1 cpu per partition to the
> container developers, but they don't seem to like it.

Oh, because it then creates a cgroup tree per CPU and you get to move
tasks between cgroups?

OK I suppose.
