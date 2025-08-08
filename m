Return-Path: <linux-kselftest+bounces-38571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5711B1EB2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27BF5869E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7F280035;
	Fri,  8 Aug 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLyZNXvQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F528033C
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665917; cv=none; b=D7JRQBU3qh5iNrLxnhcEvic077FE5W4P4oRJ82HyE4pKM8lJD3uu3Qr3RqWu3CQwvUAjd0/T6dlakPqoy5LYjoh0JdwPmnbBvSLA+2TjqcQlLhb1IqDhkgk6nlQ26DssLX6zCgH9ftMotoNpoeII0y5mQWs6lZZeMbwd7bfSobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665917; c=relaxed/simple;
	bh=F8nbBLRNaq9ZRHK52cEhX8v06L1MGtyHCKna3p5NPhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ca6KM+L+i/eW16cKiqHlZ/72vNCMA1zI3eefNpCgICl8YPaIM+1Ie3OTHLuyepA+tw3C1g+qwq+VEiIn0O9sRQgo4IYeJGKikGzT6AB5CADYGa3dWLYkxQMsAH+7TLvODFiKiQzKu55yvFul4OBytPV09klxZLXJeapHOLmIn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLyZNXvQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A3OeAL2hH5pGYTkgLU0jvPwLfGPcXeQXo67V4spjwz8=;
	b=jLyZNXvQLir59HfHJ5x//2Gk/brDZT6nOyb6Uxkih9e31ruRNICARV8lTjLLgYkI02hm4U
	mnTC0BrHOop0am7CbKMtQ6BFwBwnwWq/64PVDAHQANd4RoHkO22y+EoTGsX2Ng38JxmQEl
	TnCVYhd0Gtm7paj8O6GSuZmyymzpFHM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-5ZhcPWNMNyCCkbSwF1SfqQ-1; Fri,
 08 Aug 2025 11:11:50 -0400
X-MC-Unique: 5ZhcPWNMNyCCkbSwF1SfqQ-1
X-Mimecast-MFC-AGG-ID: 5ZhcPWNMNyCCkbSwF1SfqQ_1754665907
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58C06195608F;
	Fri,  8 Aug 2025 15:11:46 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 077AB1954196;
	Fri,  8 Aug 2025 15:11:38 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 00/18] cgroup/cpuset: Enable runtime modification of
Date: Fri,  8 Aug 2025 11:10:44 -0400
Message-ID: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The "nohz_full" and "rcu_nocbs" boot command parameters can be used to
remove a lot of kernel overhead on a specific set of isolated CPUs which
can be used to run some latency/bandwidth sensitive workloads with as
little kernel disturbance/noise as possible. The problem with this mode
of operation is the fact that it is a static configuration which cannot
be changed after boot to adjust for changes in application loading.

There is always a desire to enable runtime modification of the number
of isolated CPUs that can be dedicated to this type of demanding
workloads. This patchset is an attempt to do just that with an amount of
CPU isolation close to what can be done with the nohz_full and rcu_nocbs
boot kernel parameters.

This patch series provides the ability to change the set of housekeeping
CPUs at run time via the cpuset isolated partition functionality.
Currently, the cpuset isolated partition is able to disable scheduler
load balancing and the CPU affinity of the unbound workqueue to avoid the
isolated CPUs. This patch series will extend that with other kernel noises
associated with the nohz_full boot command line parameter which has the
following sub-categories:
  - tick
  - timer
  - RCU
  - MISC
  - WQ
  - kthread

The rcu_nocbs is actually a subset of nohz_full focusing just on the
RCU part of the kernel noises. The WQ part has already been handled by
the current cpuset code.

This series focuses on the tick and RCU part of the kernel noises by
actively changing their internal data structures to track changes in
the list of isolated CPUs used by cpuset isolated partitions.

The dynamic update of the lists of housekeeping CPUs at run time will
also have impact on the other part of the kernel noises that reference
the lists of housekeeping CPUs at run time.

The pending patch series on timer migration[1], when properly integrated
will support the timer part too.

The CPU hotplug functionality of the Linux kernel is used to facilitate
the runtime change of the nohz_full isolated CPUs with minimal code
changes. The CPUs that need to be switched from non-isolated to
isolated or vice versa will be brought offline first, making the
necessary changes and then brought back online afterward.

The use of CPU hotplug, however, does have a slight drawback of
freezing all the other CPUs in part of the offlining process using
the stop machine feature of the kernel. That will cause a noticeable
latency spikes in other running applications which may be significant
to sensitive applications running on isolated CPUs in other isolated
partitions at the time. Hopefully we can find a way to solve this
problem in the future.

One possible workaround for this is to reserve a set of nohz_full
isolated CPUs at boot time using the nohz_full boot command parameter.
The bringing of those nohz_full reserved CPUs into and out of isolated
partitions will not invoke CPU hotplug and hence will not cause
unexpected latency spikes. These reserved CPUs will only be needed
if there are other existing isolated partitions running critical
applications at the time when an isolated partition needs to be created.

Patches 1-4 updates the CPU isolation code at kernel/sched/isolation.c
to enable dynamic update of the lists of housekeeping CPUs.

Patch 5 introduces a new cpuhp_offline_cb() API for shutting down the
given set of CPUs, running the given callback method and then bringing
those CPUs back online again. This new API will block any incoming
hotplug events from interfering this operation.

Patches 6-9 updates the cpuset partition code to use the new cpuhp API
to shut down the affect CPUs, making changes to the housekeeping
cpumasks and then bring those CPUs online afterward.

Patch 10 works around an issue in the DL server code that block the
hotplug operation under certain configurations.

Patch 11-14 updates the timer tick and related code to enable proper
updates to the set of CPUs requiring nohz_full dynticks support.

Patch 15 enables runtime modification to the set of isolated CPUs
requiring RCU NO-CB CPU support with minor changes to the RCU code.

Patches 16-18 includes other miscellaneous updates to cpuset code and
documentation.

This patch series is applied on top of some other cpuset patches[1]
posted upstream recently.

[1] https://lore.kernel.org/lkml/20250806093855.86469-1-gmonaco@redhat.com/
[2] https://lore.kernel.org/lkml/20250806172430.1155133-1-longman@redhat.com/

Waiman Long (18):
  sched/isolation: Enable runtime update of housekeeping cpumasks
  sched/isolation: Call sched_tick_offload_init() when
    HK_FLAG_KERNEL_NOISE is first set
  sched/isolation: Use RCU to delay successive housekeeping cpumask
    updates
  sched/isolation: Add a debugfs file to dump housekeeping cpumasks
  cpu/hotplug: Add a new cpuhp_offline_cb() API
  cgroup/cpuset: Introduce a new top level isolcpus_update_mutex
  cgroup/cpuset: Allow overwriting HK_TYPE_DOMAIN housekeeping cpumask
  cgroup/cpuset: Use CPU hotplug to enable runtime nohz_full
    modification
  cgroup/cpuset: Revert "Include isolated cpuset CPUs in
    cpu_is_isolated() check"
  sched/core: Ignore DL BW deactivation error if in
    cpuhp_offline_cb_mode
  tick/nohz: Make nohz_full parameter optional
  tick/nohz: Introduce tick_nohz_full_update_cpus() to update
    tick_nohz_full_mask
  tick/nohz: Allow runtime changes in full dynticks CPUs
  tick: Pass timer tick job to an online HK CPU in tick_cpu_dying()
  cgroup/cpuset: Enable RCU NO-CB CPU offloading of newly isolated CPUs
  cgroup/cpuset: Don't set have_boot_nohz_full without any boot time
    nohz_full CPU
  cgroup/cpuset: Documentation updates & don't use CPU 0 for isolated
    partition
  cgroup/cpuset: Add pr_debug() statements for cpuhp_offline_cb() call

 Documentation/admin-guide/cgroup-v2.rst       |  33 +-
 .../admin-guide/kernel-parameters.txt         |  19 +-
 include/linux/context_tracking.h              |   8 +-
 include/linux/cpuhplock.h                     |   9 +
 include/linux/cpuset.h                        |   6 -
 include/linux/rcupdate.h                      |   2 +
 include/linux/sched/isolation.h               |   9 +-
 include/linux/tick.h                          |   2 +
 kernel/cgroup/cpuset.c                        | 344 ++++++++++++------
 kernel/context_tracking.c                     |  21 +-
 kernel/cpu.c                                  |  47 +++
 kernel/rcu/tree_nocb.h                        |   7 +-
 kernel/sched/core.c                           |   8 +-
 kernel/sched/debug.c                          |  32 ++
 kernel/sched/isolation.c                      | 151 +++++++-
 kernel/sched/sched.h                          |   2 +-
 kernel/time/tick-common.c                     |  15 +-
 kernel/time/tick-sched.c                      |  24 +-
 .../selftests/cgroup/test_cpuset_prs.sh       |  15 +-
 19 files changed, 583 insertions(+), 171 deletions(-)

-- 
2.50.0


