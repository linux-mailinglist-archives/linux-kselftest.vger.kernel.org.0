Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA13A3389
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 20:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhFJSxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFJSxb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 14:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC0C061574;
        Thu, 10 Jun 2021 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q5QvTqrG2xVL3YDck5+IL8BU+tiEEtCfhbIy/ABm4q4=; b=CU4PzQCpc4kXcm5s/Gn6dBy1bI
        V+bvyjbmJQGo1ViZ8M3QSJME2yJXvw18DkMN+PtxeOXj+8+8NryifDEg/1SbgFUDgIIQONtiohFJm
        VczSDtj8wDlrpDsvkX807Py7w3g9QrQJ6Let0xe8y/sGb9k5vj/gtk/+8jRhPjsVvDg9UrJTeHjJo
        k6w3VKJzl57npRQq7X3vWd935MbBTgXVSAqvWxZeF0o6G+QDvkIu0EutYlEZTsUeV3fau/0QiRj25
        zngxTnlIHcTVkM1c25vJcE00sNpDB8t73WJyUxKztTGqU1f/pmgEjjcDqbzb2PadC/+R4VgNC0kkZ
        dSSrqCaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrPlV-001xP4-Iq; Thu, 10 Jun 2021 18:50:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 094783001E4;
        Thu, 10 Jun 2021 20:50:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E09F200F8CB3; Thu, 10 Jun 2021 20:50:52 +0200 (CEST)
Date:   Thu, 10 Jun 2021 20:50:52 +0200
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
Message-ID: <YMJfDHr1+xxm6SBi@hirez.programming.kicks-ass.net>
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
> 
> To address this issue for cpuset v2, a new cpuset.cpus.partition type
> "root-nolb" is added which allows the creation of a cpuset partition with
> no load balancing. This will allow system administrators to dynamically
> adjust the size of the no load balancing partition to the current need
> of the workload without rebooting the system.

I'm confused, why do you need this? Just create a parition for each cpu.
