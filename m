Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E912C44C00F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhKJLXm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 06:23:42 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:44290 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbhKJLXi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 06:23:38 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 06:23:36 EST
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AABDwp1011374
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 12:13:58 +0100
Received: from MD1T0KAC-VM.ad001.siemens.net (md1t0kac.ad001.siemens.net [139.25.68.224])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1AABDvXQ030772;
        Wed, 10 Nov 2021 12:13:57 +0100
From:   Felix Moessbauer <felix.moessbauer@siemens.com>
To:     longman@redhat.com
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net,
        frederic@kernel.org, guro@fb.com, hannes@cmpxchg.org,
        juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lizefan.x@bytedance.com, mkoutny@suse.com, mtosatti@redhat.com,
        pauld@redhat.com, peterz@infradead.org, shuah@kernel.org,
        tj@kernel.org, jan.kiszka@siemens.com, henning.schild@siemens.com
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type & empty effecitve cpus
Date:   Wed, 10 Nov 2021 12:13:57 +0100
Message-Id: <20211110111357.17617-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018143619.205065-1-longman@redhat.com>
References: <20211018143619.205065-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Weiman,

> v8:
>  - Reorganize the patch series and rationalize the features and
>    constraints of a partition.
>  - Update patch descriptions and documentation accordingly.
> 
> v7:
>  - Simplify the documentation patch (patch 5) as suggested by Tejun.
>  - Fix a typo in patch 2 and improper commit log in patch 3.
> 
> v6:
>  - Remove duplicated tmpmask from update_prstate() which should fix the
>    frame size too large problem reported by kernel test robot.
> 
> This patchset makes four enhancements to the cpuset v2 code.
> 
>  Patch 1: Enable partition with no task to have empty cpuset.cpus.effective.
> 
>  Patch 2: Refining the features and constraints of a cpuset partition
>  clarifying what changes are allowed.
>
>  Patch 3: Add a new partition state "isolated" to create a partition
>  root without load balancing. This is for handling intermitten workloads
>  that have a strict low latency requirement.


I just tested this patch-series and can confirm that it works on 5.15.0-rc7-rt15 (PREEMT_RT).

However, I was not able to see any latency improvements when using
cpuset.cpus.partition=isolated.
The test was performed with jitterdebugger on CPUs 1-3 and the following cmdline:
rcu_nocbs=1-4 nohz_full=1-4 irqaffinity=0,5-6,11 intel_pstate=disable
On the other cpus, stress-ng was executed to generate load.

Just some more general notes:

Even with this new "isolated" type, it is still very tricky to get a similar
behavior as with isolcpus (as long as I don't miss something here):

Consider an RT application that consists of a non-rt thread that should be floating
and a rt-thread that should be placed in the isolated domain.
This requires cgroup.type=threaded on both cgroups and changes to the application
(threads have to be born in non-rt group and moved to rt-group).

Theoretically, this could be done externally, but in case the application sets the
affinity mask manually, you run into a timing issue (setting affinities to CPUs
outside the current cpuset.cpus results in EINVAL).

Best regards,
Felix Moessbauer
Siemens AG

> Patch 4: Enable the "cpuset.cpus.partition" file to show the reason
>  that causes invalid partition like "root invalid (No cpu available
>  due to hotplug)".
> 
> Patch 5 updates the cgroup-v2.rst file accordingly. Patch 6 adds a new
> cpuset test to test the new cpuset partition code.
