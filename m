Return-Path: <linux-kselftest+bounces-44444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5ADC215D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 18:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986023A546B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD92FE06B;
	Thu, 30 Oct 2025 17:00:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F572D6E71;
	Thu, 30 Oct 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843631; cv=none; b=W8+8HFMiOTvJNRVGoSud6n4T6D0Yjg3fqubqDYzXWu48Ip+NlQpgcEDtYxbWnJ6+UrBM4KU85hD5u6u7z21x1mfRvd8IIHQCbf0Kc0/G5dZSdQj16CGoaddEVtzdf/6noIcwKV8Veb3h1sAtK/GaTU+3Zkn2pUI9dyziPHLsNxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843631; c=relaxed/simple;
	bh=Us7RqJUdMWhpC26w+AHuMmRgNQ+ROlw8AWfw4V26NZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ao5SVHjXVfsr4TelSyIzEz9//89BP7/DUBB0+TMNvRB5ABkJXsaJ0KMm5PfcW2gEpis72s7xmiOnLOgLwY+n1SwwfDe5GAVeWAkxSYKbD2YSwz+nnHqPT/4HbgQnNw4jk73JKNvzTzk/ITYVSoW10lgPd1mczec6BDPRRHSJvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D3882C40;
	Thu, 30 Oct 2025 10:00:21 -0700 (PDT)
Received: from [10.57.36.244] (unknown [10.57.36.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D79E3F673;
	Thu, 30 Oct 2025 10:00:25 -0700 (PDT)
Message-ID: <c978e3ed-054f-4849-a4ff-d0fba07e3c19@arm.com>
Date: Thu, 30 Oct 2025 17:00:24 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v10 sched_ext/for-6.19] Add a deadline server for
 sched_ext tasks
To: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, sched-ext@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 19:08, Andrea Righi wrote:
> sched_ext tasks can be starved by long-running RT tasks, especially since
> RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
> tasks.
> 
> Several users in the community have reported issues with RT stalling
> sched_ext tasks. This is fairly common on distributions or environments
> where applications like video compositors, audio services, etc. run as RT
> tasks by default.
> 
> Example trace (showing a per-CPU kthread stalled due to the sway Wayland
> compositor running as an RT task):
> 
>  runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
>  ...
>  CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
>            curr=sway[994] class=rt_sched_class
>    R kworker/0:0[106377] -5043ms
>        scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
>        sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
>        cpus=01
> 
> This is often perceived as a bug in the BPF schedulers, but in reality
> schedulers can't do much: RT tasks run outside their control and can
> potentially consume 100% of the CPU bandwidth.
> 
> Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
> also boosted and do not suffer starvation.
> 
> Two kselftests are also provided to verify the starvation fixes and
> bandwidth allocation is correct.
> 
> == Highlights in this version ==
> 
>  - wait for inactive_task_timer() to fire before removing the bandwidth
>    reservation (Juri/Peter: please check if this new
>    dl_server_remove_params() implementation makes sense to you)
>  - removed the explicit dl_server_stop() from dequeue_task_scx() and rely
>    on the delayed stop behavior (Juri/Peter: ditto)
> 
> This patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dl-server
> 
> Changes in v10:
>  - reordered patches to better isolate sched_ext changes vs sched/deadline
>    changes (Andrea Righi)
>  - define ext_server only with CONFIG_SCHED_CLASS_EXT=y (Andrea Righi)
>  - add WARN_ON_ONCE(!cpus) check in dl_server_apply_params() (Andrea Righi)
>  - wait for inactive_task_timer to fire before removing the bandwidth
>    reservation (Juri Lelli)
>  - remove explicit dl_server_stop() in dequeue_task_scx() to reduce timer
>    reprogramming overhead (Juri Lelli)
>  - do not restart pick_task() when invoked by the dl_server (Tejun Heo)
>  - rename rq_dl_server to dl_server (Peter Zijlstra)
>  - fixed a missing dl_server start in dl_server_on() (Christian Loehle)
>  - add a comment to the rt_stall selftest to better explain the 4%
>    threshold (Emil Tsalapatis)
> 
> Changes in v9:
>  - Drop the ->balance() logic as its functionality is now integrated into
>    ->pick_task(), allowing dl_server to call pick_task_scx() directly
>  - Link to v8: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/
> 
> Changes in v8:
>  - Add tj's patch to de-couple balance and pick_task and avoid changing
>    sched/core callbacks to propagate @rf
>  - Simplify dl_se->dl_server check (suggested by PeterZ)
>  - Small coding style fixes in the kselftests
>  - Link to v7: https://lore.kernel.org/all/20250809184800.129831-1-joelagnelf@nvidia.com/
> 
> Changes in v7:
>  - Rebased to Linus master
>  - Link to v6: https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/
> 
> Changes in v6:
>  - Added Acks to few patches
>  - Fixes to few nits suggested by Tejun
>  - Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/
> 
> Changes in v5:
>  - Added a kselftest (total_bw) to sched_ext to verify bandwidth values
>    from debugfs
>  - Address comment from Andrea about redundant rq clock invalidation
>  - Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/
> 
> Changes in v4:
>  - Fixed issues with hotplugged CPUs having their DL server bandwidth
>    altered due to loading SCX
>  - Fixed other issues
>  - Rebased on Linus master
>  - All sched_ext kselftests reliably pass now, also verified that the
>    total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with these patches
>  - Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/
> 
> Changes in v3:
>  - Removed code duplication in debugfs. Made ext interface separate
>  - Fixed issue where rq_lock_irqsave was not used in the relinquish patch
>  - Fixed running bw accounting issue in dl_server_remove_params
>  - Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/
> 
> Changes in v2:
>  - Fixed a hang related to using rq_lock instead of rq_lock_irqsave
>  - Added support to remove BW of DL servers when they are switched to/from EXT
>  - Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/
> 
> Andrea Righi (5):
>       sched/deadline: Add support to initialize and remove dl_server bandwidth
>       sched_ext: Add a DL server for sched_ext tasks
>       sched/deadline: Account ext server bandwidth
>       sched_ext: Selectively enable ext and fair DL servers
>       selftests/sched_ext: Add test for sched_ext dl_server
> 
> Joel Fernandes (6):
>       sched/debug: Fix updating of ppos on server write ops
>       sched/debug: Stop and start server based on if it was active
>       sched/deadline: Clear the defer params
>       sched/deadline: Add a server arg to dl_server_update_idle_time()
>       sched/debug: Add support to change sched_ext server params
>       selftests/sched_ext: Add test for DL server total_bw consistency
> 
>  kernel/sched/core.c                              |   3 +
>  kernel/sched/deadline.c                          | 169 +++++++++++---
>  kernel/sched/debug.c                             | 171 +++++++++++---
>  kernel/sched/ext.c                               | 144 +++++++++++-
>  kernel/sched/fair.c                              |   2 +-
>  kernel/sched/idle.c                              |   2 +-
>  kernel/sched/sched.h                             |   8 +-
>  kernel/sched/topology.c                          |   5 +
>  tools/testing/selftests/sched_ext/Makefile       |   2 +
>  tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 ++
>  tools/testing/selftests/sched_ext/rt_stall.c     | 222 ++++++++++++++++++
>  tools/testing/selftests/sched_ext/total_bw.c     | 281 +++++++++++++++++++++++
>  12 files changed, 955 insertions(+), 77 deletions(-)
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
>  create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

Thanks Andrea, I've tested a few things I had in mind with no complaints.
Most importantly it a) it doesn't break the existing fair_server and b)
Ensures BPF schedulers don't stall even with something like:
sudo chrt -r 95 stress-ng --cpu 0 --taskset 0-$(($(nproc)-1)) -t 30m

For patches 0 to 9:
Tested-by: Christian Loehle <christian.loehle@arm.com>

