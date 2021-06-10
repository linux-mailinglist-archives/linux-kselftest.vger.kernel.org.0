Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AC53A33A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJTCo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJTCo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 15:02:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7D6C061574;
        Thu, 10 Jun 2021 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xTRjHtkMVfiEz4i7gVCu050JHA1BAAViAhxBjNTqnr0=; b=v0ermCJCsvrKcJozDIgJaQ9mAs
        QK/N1tf1IVJBqXRoU2Zjqfd+0nWnmqmjfB7N0ptRxKQd/2eFgSKzsRLMxX9DTKtCZydrecLkoxpLW
        5T7E7oDDx3F/yKl//Z2wdkyNvkSZXpc8J+xNo/jsDiDMyp49ayMBMqljhsnuO6Qdg+S9faxM3hg1x
        01xaJ91axH5I7Hi6Kylz6tgA2IxY/nZKF67bPkr6jN6Tvx9t718+/WOotzmIkTl9/zxWQf5MeKyXk
        RZCP/M4Xkx4p+UsrO0GCP+fqlm+fQN9Nhe5RlpXZCgaJQeW2k3WEICEjPExfpHYhZ9IFs0fDN7dwk
        uwoPK1uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrPuU-001yKc-6y; Thu, 10 Jun 2021 19:00:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F35C3001E3;
        Thu, 10 Jun 2021 21:00:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FFA3200F8CB3; Thu, 10 Jun 2021 21:00:09 +0200 (CEST)
Date:   Thu, 10 Jun 2021 21:00:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
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
Message-ID: <YMJhObisfWJ1PzgR@hirez.programming.kicks-ass.net>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603212416.25934-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 03, 2021 at 05:24:13PM -0400, Waiman Long wrote:
> Cpuset v1 uses the sched_load_balance control file to determine if load
> balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
> as its use may require disabling load balancing at cgroup root.
> 
> For workloads that require very low latency like DPDK, the latency
> jitters caused by periodic load balancing may exceed the desired
> latency limit.
> 
> When cpuset v2 is in use, the only way to avoid this latency cost is to
> use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
> the kernel boot, however, there is no way to add or remove CPUs from
> this isolated set. For workloads that are more dynamic in nature, that
> means users have to provision enough CPUs for the worst case situation
> resulting in excess idle CPUs.

Also, can we change isolcpus to create a default cgroup hierarchy
instead of being the fugly hack that it is? I really hate isolcpus with
a passion, it needs to die.
