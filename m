Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9544C2AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhKJOFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 09:05:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232099AbhKJOFS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 09:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636552950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TPGlDsYndtj+OjEFiCGDmUdaoybdwvNgP/PovWuwWE=;
        b=EoMS89G2HO7NB47MGT27BmL6l8pg/WYnu9Xag5Z7OhG/zty4ZRUvASe5NxKN4MfJcT69gR
        +Ijqaw9Qj33FNYDMNgP6xj6lBpomC5UcjGClWM0y2XHpAhObLaeXMKGxZHcXHWVVpwithf
        x4FINSiz9nAnmQni1XLLE7MLiT/h63w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-MM8c5JeAMRmm1GLTfZmcJQ-1; Wed, 10 Nov 2021 09:02:24 -0500
X-MC-Unique: MM8c5JeAMRmm1GLTfZmcJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18BFE871807;
        Wed, 10 Nov 2021 14:02:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 437915D6B1;
        Wed, 10 Nov 2021 14:01:58 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A1A32416952E; Wed, 10 Nov 2021 10:21:59 -0300 (-03)
Date:   Wed, 10 Nov 2021 10:21:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Felix Moessbauer <felix.moessbauer@siemens.com>
Cc:     longman@redhat.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, corbet@lwn.net, frederic@kernel.org,
        guro@fb.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com,
        mkoutny@suse.com, pauld@redhat.com, peterz@infradead.org,
        shuah@kernel.org, tj@kernel.org, jan.kiszka@siemens.com,
        henning.schild@siemens.com
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Message-ID: <20211110132159.GA12767@fuller.cnet>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110111357.17617-1-felix.moessbauer@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 10, 2021 at 12:13:57PM +0100, Felix Moessbauer wrote:
> Hi Weiman,
> 
> > v8:
> >  - Reorganize the patch series and rationalize the features and
> >    constraints of a partition.
> >  - Update patch descriptions and documentation accordingly.
> > 
> > v7:
> >  - Simplify the documentation patch (patch 5) as suggested by Tejun.
> >  - Fix a typo in patch 2 and improper commit log in patch 3.
> > 
> > v6:
> >  - Remove duplicated tmpmask from update_prstate() which should fix the
> >    frame size too large problem reported by kernel test robot.
> > 
> > This patchset makes four enhancements to the cpuset v2 code.
> > 
> >  Patch 1: Enable partition with no task to have empty cpuset.cpus.effective.
> > 
> >  Patch 2: Refining the features and constraints of a cpuset partition
> >  clarifying what changes are allowed.
> >
> >  Patch 3: Add a new partition state "isolated" to create a partition
> >  root without load balancing. This is for handling intermitten workloads
> >  that have a strict low latency requirement.
> 
> 
> I just tested this patch-series and can confirm that it works on 5.15.0-rc7-rt15 (PREEMT_RT).
> 
> However, I was not able to see any latency improvements when using
> cpuset.cpus.partition=isolated.
> The test was performed with jitterdebugger on CPUs 1-3 and the following cmdline:
> rcu_nocbs=1-4 nohz_full=1-4 irqaffinity=0,5-6,11 intel_pstate=disable
> On the other cpus, stress-ng was executed to generate load.

enum hk_flags {
        HK_FLAG_TIMER           = 1,
        HK_FLAG_RCU             = (1 << 1),
        HK_FLAG_MISC            = (1 << 2),
        HK_FLAG_SCHED           = (1 << 3),
        HK_FLAG_TICK            = (1 << 4),
        HK_FLAG_DOMAIN          = (1 << 5),
        HK_FLAG_WQ              = (1 << 6),
        HK_FLAG_MANAGED_IRQ     = (1 << 7),
        HK_FLAG_KTHREAD         = (1 << 8),
};

static int __init housekeeping_nohz_full_setup(char *str)
{
        unsigned int flags;

        flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
                HK_FLAG_MISC | HK_FLAG_KTHREAD;

        return housekeeping_setup(str, flags);
}
__setup("nohz_full=", housekeeping_nohz_full_setup);

So HK_FLAG_SCHED and HK_FLAG_MANAGED_IRQ are unset in your configuration.
Perhaps they are affecting your latency numbers?

This tool might be handy to see what is the reason for the latency source:

https://github.com/xzpeter/rt-trace-bpf

./rt-trace-bcc.py -c isolated-cpu

> Just some more general notes:
> 
> Even with this new "isolated" type, it is still very tricky to get a similar
> behavior as with isolcpus (as long as I don't miss something here):
> 
> Consider an RT application that consists of a non-rt thread that should be floating
> and a rt-thread that should be placed in the isolated domain.
> This requires cgroup.type=threaded on both cgroups and changes to the application
> (threads have to be born in non-rt group and moved to rt-group).
> 
> Theoretically, this could be done externally, but in case the application sets the
> affinity mask manually, you run into a timing issue (setting affinities to CPUs
> outside the current cpuset.cpus results in EINVAL).
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
> 
> > Patch 4: Enable the "cpuset.cpus.partition" file to show the reason
> >  that causes invalid partition like "root invalid (No cpu available
> >  due to hotplug)".
> > 
> > Patch 5 updates the cgroup-v2.rst file accordingly. Patch 6 adds a new
> > cpuset test to test the new cpuset partition code.
> 
> 

