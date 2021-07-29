Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E093DA1B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhG2LDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 07:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236430AbhG2LDh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 07:03:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8081A60BD3;
        Thu, 29 Jul 2021 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627556614;
        bh=uCbW9J3YqEIQSJj9wEXdcOHPabjCeLFizZzIoZQFBfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKygjhxSpGxVYxPyQT8pgYAj5pGx1nIbzlIHdu7B9Trjb3QHSwOaL+8n6erSy1qE8
         QwzIK8PqMKm8mB3l4dYF/xwSkYjM2S2gyiPRuFV1H4LTpxRfZ/dm4UtX7Sd0SmtuiW
         0axwvVBceoswzdjQm9BCZ51E4X6sN9W5mWYFKTVbfZ8TXvUOLuESoyOLQSGqavi7j6
         219KxzvEYwR+NGJLwraQsdv1Rs+E9hjAYXGAEldiDRBIxdWtGfqINqe0ibgR6BFCX4
         7WeToS/NGh84MK9S0t8xV8QixU+1N2j/FYfVo2tUDsvBx3AalVLDlMxFbSB4uYslAz
         rLFvVKYv7AYpw==
Date:   Thu, 29 Jul 2021 13:03:31 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Waiman Long <llong@redhat.com>
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
Message-ID: <20210729110331.GC301667@lothringen>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-7-longman@redhat.com>
 <20210727114241.GA283787@lothringen>
 <fe3d9fcb-c3af-9214-c69f-00ef36521c5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3d9fcb-c3af-9214-c69f-00ef36521c5c@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 27, 2021 at 11:56:25AM -0400, Waiman Long wrote:
> On 7/27/21 7:42 AM, Frederic Weisbecker wrote:
> > On Tue, Jul 20, 2021 at 10:18:31AM -0400, Waiman Long wrote:
> > > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=TBD
> > > 
> > > commit 994fb794cb252edd124a46ca0994e37a4726a100
> > > Author: Waiman Long <longman@redhat.com>
> > > Date:   Sat, 19 Jun 2021 13:28:19 -0400
> > > 
> > >      cgroup/cpuset: Add a new isolated cpus.partition type
> > > 
> > >      Cpuset v1 uses the sched_load_balance control file to determine if load
> > >      balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
> > >      as its use may require disabling load balancing at cgroup root.
> > > 
> > >      For workloads that require very low latency like DPDK, the latency
> > >      jitters caused by periodic load balancing may exceed the desired
> > >      latency limit.
> > > 
> > >      When cpuset v2 is in use, the only way to avoid this latency cost is to
> > >      use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
> > >      the kernel boot, however, there is no way to add or remove CPUs from
> > >      this isolated set. For workloads that are more dynamic in nature, that
> > >      means users have to provision enough CPUs for the worst case situation
> > >      resulting in excess idle CPUs.
> > > 
> > >      To address this issue for cpuset v2, a new cpuset.cpus.partition type
> > >      "isolated" is added which allows the creation of a cpuset partition
> > >      without load balancing. This will allow system administrators to
> > >      dynamically adjust the size of isolated partition to the current need
> > >      of the workload without rebooting the system.
> > > 
> > >      Signed-off-by: Waiman Long <longman@redhat.com>
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > Nice! And while we are adding a new ABI, can we take advantage of that and
> > add a specific semantic that if a new isolated partition matches a subset of
> > "isolcpus=", it automatically maps to it. This means that any further
> > modification to that isolated partition will also modify the associated
> > isolcpus= subset.
> > 
> > Or to summarize, when we create a new isolated partition, remove the associated
> > CPUs from isolcpus= ?
> 
> We can certainly do that as a follow-on.

I'm just concerned that this feature gets merged before we add that new
isolcpus= implicit mapping, which technically is a new ABI. Well I guess I
should hurry up and try to propose a patchset quickly once I'm back from
vacation :-)



> Another idea that I have been
> thinking about is to automatically generating a isolated partition under
> root to match the given isolcpus parameter when the v2 filesystem is
> mounted. That needs more experimentation and testing to verify that it can
> work.

I thought about that too, mounting an "isolcpus" subdirectory withing the top
cpuset but I was worried it could break userspace that wouldn't expect that new
thing to show up.

Thanks.
