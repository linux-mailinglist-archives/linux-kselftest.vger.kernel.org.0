Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0EC7DA43D
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 02:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJ1AJc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 20:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1AJb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 20:09:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1C1B9;
        Fri, 27 Oct 2023 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698451766; x=1729987766;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=QmgZrVJ6ygh99PiI4Qt0Q1m1fSOReg2/JxXAqgJGWuA=;
  b=GcPqhANJFB8D2uD0afMVhSgZ6lZDQ77KyDeKpYEnYVefBTbdqvxOQjxL
   tiymGWxMnaSvrz2dDQCMwX6jT13DGWK93mdMG5Oox8I3VTOqBldyN/99O
   YoxZdkBjv4NLk0p6IEwAwkK6XJtBC+sEP306ZJiTJ7e2QW1LVzuSsHKOv
   g6PqsQUIJP+lqzfbz5L0BIrglwlLoSGqyJph2wecVyVzzHbG0bz8RLvMB
   F7GsczFh7zMCACmJi5OtRy/dywDhPDRS11yc/VxrO9z7i8/7IC+VOU2Zg
   z7DtCpe1sL4ZN/0MGZ7SmOCtgBQtJutmnzYoee8c2bCn1G29lZ3zEFUBR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="474106824"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="474106824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="995759"
Received: from mkasukur-mobl8.amr.corp.intel.com (HELO vcostago-mobl3) ([10.255.228.186])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:09:14 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     kernel test robot <oliver.sang@intel.com>,
        Xabier Marquiegui <reibax@gmail.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com, oliver.sang@intel.com
Subject: Re: [linux-next:master] [ptp]  403376ddb4:
  stress-ng.clock.ops_per_sec -12.7% regression
In-Reply-To: <202310271441.b9fb0896-oliver.sang@intel.com>
References: <202310271441.b9fb0896-oliver.sang@intel.com>
Date:   Fri, 27 Oct 2023 17:09:25 -0700
Message-ID: <878r7nr4ju.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

kernel test robot <oliver.sang@intel.com> writes:

> Hello,
>
> kernel test robot noticed a -12.7% regression of stress-ng.clock.ops_per_=
sec on:
>
>
> commit: 403376ddb4221be9db5326ae334773807df71ffe ("ptp: add debugfs inter=
face to see applied channel masks")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>

I guess this is somewhat expected, taking a look at the stress-ng clock
stressor, it calls open() on a PTP device (/dev/ptp0), which creates a
new event queue and since 403376ddb4221b, it also creates a new debugfs
entry. And that is where the regression seems to be coming from.

But just to get an idea if there was any impact on things that are
expected to be called more frequently, I ran a quick-and-dirty program
that calls clock_gettime() a bunch of times:

~/src/benches $ sudo time ./gettime -d /dev/ptp2 -c 1000000
0.45user 2.44system 0:02.89elapsed 99%CPU (0avgtext+0avgdata 1408maxresiden=
t)k

And after reverting that commit (and 75a384ceda93df):

~/src/benches $ sudo time ./gettime -d /dev/ptp2 -c 1000000
0.44user 2.45system 0:02.90elapsed 99%CPU (0avgtext+0avgdata 1408maxresiden=
t)k

So, yeah, the paths that I expect to be more used do not seem to have
regressed. So I am not too worried about this.

Anyway, thanks for the report.

> testcase: stress-ng
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.0=
0GHz (Cascade Lake) with 128G memory
> parameters:
>
> 	nr_threads: 1
> 	disk: 1HDD
> 	testtime: 60s
> 	class: interrupt
> 	test: clock
> 	cpufreq_governor: performance
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310271441.b9fb0896-oliver.san=
g@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231027/202310271441.b9fb0896-ol=
iver.sang@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group=
/test/testcase/testtime:
>   interrupt/gcc-12/performance/1HDD/x86_64-rhel-8.3/1/debian-11.1-x86_64-=
20220510.cgz/lkp-csl-d02/clock/stress-ng/60s
>
> commit:=20
>   c5a445b1e9 ("ptp: support event queue reader channel masks")
>   403376ddb4 ("ptp: add debugfs interface to see applied channel masks")
>
> c5a445b1e9347b14 403376ddb4221be9db5326ae334=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \=20=20
>       2.50            +8.3%       2.71        iostat.cpu.system
>       0.05 =C2=B1  3%      +0.0        0.06        mpstat.cpu.all.soft%
>       1.84            +0.2        2.04        mpstat.cpu.all.sys%
>     200469           -10.7%     178950        vmstat.system.cs
>     135153            -7.8%     124597        vmstat.system.in
>    2804514           -12.7%    2448917        stress-ng.clock.ops
>      46741           -12.7%      40815        stress-ng.clock.ops_per_sec
>      78.00            +2.6%      80.00        stress-ng.time.percent_of_c=
pu_this_job_got
>    5606454           -12.7%    4896355        stress-ng.time.voluntary_co=
ntext_switches
>      18583 =C2=B1  5%     +31.1%      24360 =C2=B1  9%  turbostat.C1
>       2.90 =C2=B1  2%      +0.1        3.03        turbostat.C1E%
>    5353747           -13.0%    4655189        turbostat.POLL
>       0.28            -0.0        0.24        turbostat.POLL%
>      10.11            +1.4%      10.25        turbostat.RAMWatt
>      88825            -6.6%      82944        proc-vmstat.nr_active_anon
>      11367            +4.6%      11892        proc-vmstat.nr_mapped
>      96532            -6.6%      90119        proc-vmstat.nr_shmem
>      19819            +4.1%      20633        proc-vmstat.nr_slab_reclaim=
able
>      88825            -6.6%      82944        proc-vmstat.nr_zone_active_=
anon
>     420661           +27.6%     536903 =C2=B1 35%  proc-vmstat.numa_hit
>     420556           +27.4%     535725 =C2=B1 36%  proc-vmstat.numa_local
>     133275            -6.9%     124053        proc-vmstat.pgactivate
>     488366 =C2=B1  2%     +60.4%     783374        proc-vmstat.pgalloc_no=
rmal
>     227687            +3.2%     234860        proc-vmstat.pgfault
>     323139 =C2=B1  3%     +94.6%     628694        proc-vmstat.pgfree
>       0.00 =C2=B1141%    +325.0%       0.01 =C2=B1 26%  perf-sched.sch_de=
lay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
>       0.01 =C2=B1217%    +455.3%       0.04 =C2=B1 68%  perf-sched.sch_de=
lay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.alloc_cpum=
ask_var_node.clock_was_set
>       0.10 =C2=B1 14%     +66.8%       0.16 =C2=B1 15%  perf-sched.sch_de=
lay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_cl=
ock_nanosleep
>       0.00 =C2=B1141%    +325.0%       0.01 =C2=B1 26%  perf-sched.sch_de=
lay.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
>       0.91 =C2=B1 21%     -53.8%       0.42 =C2=B1 55%  perf-sched.sch_de=
lay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       1.27           +18.7%       1.51        perf-sched.total_wait_and_d=
elay.average.ms
>       1.27           +18.7%       1.51        perf-sched.total_wait_time.=
average.ms
>      18.82 =C2=B1 20%     +59.4%      29.99 =C2=B1 27%  perf-sched.wait_a=
nd_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.=
vfs_write.ksys_write
>       1278 =C2=B1  2%     +16.3%       1487 =C2=B1  3%  perf-sched.wait_a=
nd_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>     220.33 =C2=B1  5%     +14.1%     251.33 =C2=B1  2%  perf-sched.wait_a=
nd_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.20 =C2=B1 13%     +63.7%       0.33 =C2=B1 14%  perf-sched.wait_a=
nd_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_s=
ys_clock_nanosleep
>      18.82 =C2=B1 20%     +59.4%      29.99 =C2=B1 27%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_w=
rite.ksys_write
>       0.01 =C2=B1208%    +433.3%       0.05 =C2=B1 64%  perf-sched.wait_t=
ime.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.alloc_cpum=
ask_var_node.clock_was_set
>       0.10 =C2=B1 12%     +60.7%       0.16 =C2=B1 13%  perf-sched.wait_t=
ime.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_cl=
ock_nanosleep
>       0.13           +35.1%       0.17 =C2=B1  2%  perf-stat.i.MPKI
>  9.417e+08            +4.1%    9.8e+08        perf-stat.i.branch-instruct=
ions
>       4.24 =C2=B1  2%      +0.6        4.81 =C2=B1  2%  perf-stat.i.cache=
-miss-rate%
>    1107890           +23.8%    1371103 =C2=B1  2%  perf-stat.i.cache-miss=
es
>   18969540           +28.6%   24388966        perf-stat.i.cache-references
>     210406           -11.1%     187069        perf-stat.i.context-switches
>       1.15            -3.5%       1.11        perf-stat.i.cpi
>     185.83 =C2=B1  2%      +7.7%     200.19 =C2=B1  4%  perf-stat.i.cpu-m=
igrations
>      56299 =C2=B1  6%     -64.8%      19830 =C2=B1  6%  perf-stat.i.cycle=
s-between-cache-misses
>  1.249e+09            +2.7%  1.283e+09        perf-stat.i.dTLB-loads
>       0.00 =C2=B1  6%      +0.0        0.00 =C2=B1  4%  perf-stat.i.dTLB-=
store-miss-rate%
>       7425 =C2=B1  5%     +12.8%       8373 =C2=B1  4%  perf-stat.i.dTLB-=
store-misses
>  7.573e+08            +2.3%  7.746e+08        perf-stat.i.dTLB-stores
>    6674913 =C2=B1  2%      -5.5%    6305796        perf-stat.i.iTLB-load-=
misses
>   5.03e+09            +3.1%  5.184e+09        perf-stat.i.instructions
>       1159            +5.5%       1222 =C2=B1  2%  perf-stat.i.instructio=
ns-per-iTLB-miss
>       0.89            +3.0%       0.92        perf-stat.i.ipc
>     536.86           +28.0%     687.18        perf-stat.i.metric.K/sec
>      81.89            +3.0%      84.38        perf-stat.i.metric.M/sec
>       2127            +5.2%       2239 =C2=B1  2%  perf-stat.i.minor-faul=
ts
>     106399 =C2=B1  2%     +36.0%     144713 =C2=B1  3%  perf-stat.i.node-=
loads
>     106511 =C2=B1  5%     +71.6%     182771 =C2=B1  3%  perf-stat.i.node-=
stores
>       2127            +5.2%       2239 =C2=B1  2%  perf-stat.i.page-faults
>       0.22           +20.1%       0.26 =C2=B1  2%  perf-stat.overall.MPKI
>       1.09            -2.6%       1.06        perf-stat.overall.cpi
>       4955           -18.8%       4021 =C2=B1  2%  perf-stat.overall.cycl=
es-between-cache-misses
>       0.00 =C2=B1  5%      +0.0        0.00 =C2=B1  4%  perf-stat.overall=
.dTLB-store-miss-rate%
>     753.96            +9.1%     822.64 =C2=B1  2%  perf-stat.overall.inst=
ructions-per-iTLB-miss
>       0.92            +2.7%       0.94        perf-stat.overall.ipc
>   9.27e+08            +4.1%  9.648e+08        perf-stat.ps.branch-instruc=
tions
>    1090868           +23.8%    1350235 =C2=B1  2%  perf-stat.ps.cache-mis=
ses
>   18670301           +28.6%   24005580        perf-stat.ps.cache-referenc=
es
>     207054           -11.1%     184104        perf-stat.ps.context-switch=
es
>     182.86 =C2=B1  2%      +7.7%     197.01 =C2=B1  4%  perf-stat.ps.cpu-=
migrations
>  1.229e+09            +2.7%  1.263e+09        perf-stat.ps.dTLB-loads
>       7309 =C2=B1  5%     +12.8%       8244 =C2=B1  4%  perf-stat.ps.dTLB=
-store-misses
>  7.454e+08            +2.3%  7.624e+08        perf-stat.ps.dTLB-stores
>    6568626 =C2=B1  2%      -5.5%    6205894        perf-stat.ps.iTLB-load=
-misses
>  4.951e+09            +3.1%  5.103e+09        perf-stat.ps.instructions
>       2094            +5.2%       2204 =C2=B1  2%  perf-stat.ps.minor-fau=
lts
>     104758 =C2=B1  2%     +36.0%     142499 =C2=B1  3%  perf-stat.ps.node=
-loads
>     104880 =C2=B1  5%     +71.6%     179969 =C2=B1  3%  perf-stat.ps.node=
-stores
>       2094            +5.2%       2204 =C2=B1  2%  perf-stat.ps.page-faul=
ts
>  3.124e+11            +3.9%  3.245e+11        perf-stat.total.instructions
>       9.42 =C2=B1  5%      -2.2        7.20 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.clock_gettime
>       9.26 =C2=B1  5%      -2.2        7.08 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_gettime
>       9.24 =C2=B1  5%      -2.2        7.07 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_gettime
>       8.84 =C2=B1  5%      -2.2        6.67 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.e1000e_read_systim.e1000e_phc_gettimex.pc_clock_gettime.__x=
64_sys_clock_gettime.do_syscall_64
>       9.20 =C2=B1  5%      -2.2        7.04 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.clock_gettime
>       8.96 =C2=B1  5%      -2.2        6.81 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.e1000e_phc_gettimex.pc_clock_gettime.__x64_sys_clock_gettim=
e.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       9.12 =C2=B1  5%      -2.1        6.98 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64.entr=
y_SYSCALL_64_after_hwframe.clock_gettime
>      10.96 =C2=B1  2%      -2.0        8.98 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.syscall
>      10.98 =C2=B1  3%      -1.7        9.28 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.clock_adjtime
>      10.09 =C2=B1  3%      -1.5        8.55 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_adjtime
>       9.94 =C2=B1  3%      -1.5        8.42 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_adjtime
>       9.68 =C2=B1  3%      -1.5        8.20 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.__do_sys_clock_adjtime.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.clock_adjtime
>       8.53 =C2=B1  4%      -1.3        7.22 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.do_adjtimex.__do_sys_clock_adjtime.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe.clock_adjtime
>       6.44 =C2=B1  5%      -1.2        5.20 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_ca=
ll.do_idle
>       6.22 =C2=B1  4%      -1.1        5.12 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>       5.59 =C2=B1  3%      -1.0        4.59 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       6.42 =C2=B1  3%      -0.9        5.51 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.timekeeping_inject_offset.do_adjtimex.__do_sys_clock_adjtim=
e.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.86 =C2=B1  3%      -0.9        5.00 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.clock_was_set.timekeeping_inject_offset.do_adjtimex.__do_sy=
s_clock_adjtime.do_syscall_64
>       3.34 =C2=B1  5%      -0.7        2.68 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.syscall
>       2.99 =C2=B1  9%      -0.6        2.34 =C2=B1 14%  perf-profile.call=
trace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt=
.poll_idle.cpuidle_enter_state.cpuidle_enter
>       2.47 =C2=B1 13%      -0.5        1.94 =C2=B1 15%  perf-profile.call=
trace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.a=
sm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state
>       3.31 =C2=B1  3%      -0.5        2.83 =C2=B1  8%  perf-profile.call=
trace.cycles-pp._raw_spin_lock_irqsave.clock_was_set.timekeeping_inject_off=
set.do_adjtimex.__do_sys_clock_adjtime
>       2.78 =C2=B1  3%      -0.4        2.42 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.timer_create
>       2.37 =C2=B1  3%      -0.3        2.07 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_create
>       2.33 =C2=B1  3%      -0.3        2.03 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
>       1.64 =C2=B1  3%      -0.3        1.36 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.add_device_randomness.do_adjtimex.__do_sys_clock_adjtime.do=
_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.43 =C2=B1  3%      -0.3        1.16 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.blake2s_compress.blake2s_update.add_device_randomness.do_ad=
jtimex.__do_sys_clock_adjtime
>       1.52 =C2=B1  3%      -0.3        1.26 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.blake2s_update.add_device_randomness.do_adjtimex.__do_sys_c=
lock_adjtime.do_syscall_64
>       1.23 =C2=B1  8%      -0.2        0.99 =C2=B1 12%  perf-profile.call=
trace.cycles-pp.posix_cpu_clock_get.__x64_sys_clock_gettime.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe.syscall
>       1.02 =C2=B1  5%      -0.1        0.88 =C2=B1 12%  perf-profile.call=
trace.cycles-pp.read_tsc.ktime_get_update_offsets_now.clock_was_set.timekee=
ping_inject_offset.do_adjtimex
>       0.74 =C2=B1  4%      -0.1        0.61 =C2=B1 13%  perf-profile.call=
trace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_ru=
n_queues.hrtimer_interrupt
>       0.47 =C2=B1 45%      +0.4        0.90 =C2=B1 17%  perf-profile.call=
trace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.00            +0.7        0.69 =C2=B1 10%  perf-profile.calltrace=
.cycles-pp.lookup_one_len.start_creating.__debugfs_create_file.ptp_open.pos=
ix_clock_open
>       0.00            +0.7        0.72 =C2=B1 12%  perf-profile.calltrace=
.cycles-pp.dput.simple_recursive_removal.debugfs_remove.ptp_release.posix_c=
lock_release
>       0.00            +0.7        0.75 =C2=B1 14%  perf-profile.calltrace=
.cycles-pp.lookup_one_len.start_creating.debugfs_create_dir.ptp_open.posix_=
clock_open
>       0.00            +0.8        0.75 =C2=B1 12%  perf-profile.calltrace=
.cycles-pp.start_creating.__debugfs_create_file.ptp_open.posix_clock_open.c=
hrdev_open
>       0.00            +0.9        0.86 =C2=B1 15%  perf-profile.calltrace=
.cycles-pp.start_creating.debugfs_create_dir.ptp_open.posix_clock_open.chrd=
ev_open
>       0.00            +0.9        0.91 =C2=B1 14%  perf-profile.calltrace=
.cycles-pp.mnt_get_count.mntput_no_expire.simple_recursive_removal.debugfs_=
remove.ptp_release
>       0.00            +1.0        1.05 =C2=B1 13%  perf-profile.calltrace=
.cycles-pp.mntput_no_expire.simple_recursive_removal.debugfs_remove.ptp_rel=
ease.posix_clock_release
>       0.00            +1.3        1.26 =C2=B1 12%  perf-profile.calltrace=
.cycles-pp.__debugfs_create_file.ptp_open.posix_clock_open.chrdev_open.do_d=
entry_open
>       0.00            +1.5        1.47 =C2=B1 13%  perf-profile.calltrace=
.cycles-pp.debugfs_create_dir.ptp_open.posix_clock_open.chrdev_open.do_dent=
ry_open
>       0.00            +2.4        2.42 =C2=B1 11%  perf-profile.calltrace=
.cycles-pp.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_=
release.__fput
>       0.00            +3.0        2.95 =C2=B1 11%  perf-profile.calltrace=
.cycles-pp.debugfs_remove.ptp_release.posix_clock_release.__fput.__x64_sys_=
close
>       1.74 =C2=B1  5%      +3.0        4.71 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_open=
at2
>       2.90 =C2=B1  6%      +3.0        5.87 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do=
_syscall_64
>       1.35 =C2=B1  6%      +3.0        4.33 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.posix_clock_open.chrdev_open.do_dentry_open.do_open.path_op=
enat
>       1.42 =C2=B1  6%      +3.0        4.41 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.chrdev_open.do_dentry_open.do_open.path_openat.do_filp_open
>       2.02 =C2=B1  5%      +3.0        5.01 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_o=
penat
>       2.95 =C2=B1  6%      +3.0        5.95 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
>       3.51 =C2=B1  6%      +3.0        6.51 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL=
_64_after_hwframe.open64
>       3.54 =C2=B1  6%      +3.0        6.55 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.open64
>       1.18 =C2=B1  6%      +3.0        4.21 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.ptp_open.posix_clock_open.chrdev_open.do_dentry_open.do_open
>       3.57 =C2=B1  6%      +3.0        6.61 =C2=B1  9%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       3.75 =C2=B1  6%      +3.1        6.82 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.open64
>       3.58 =C2=B1  6%      +3.1        6.66 =C2=B1 10%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       0.93 =C2=B1 11%      +3.2        4.16 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
>       0.90 =C2=B1 11%      +3.2        4.13 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       0.87 =C2=B1 11%      +3.2        4.10 =C2=B1 12%  perf-profile.call=
trace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.__close
>       1.06 =C2=B1  8%      +3.2        4.30 =C2=B1 11%  perf-profile.call=
trace.cycles-pp.__close
>       0.51 =C2=B1 45%      +3.4        3.91 =C2=B1 12%  perf-profile.call=
trace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.__close
>       0.00            +3.6        3.59 =C2=B1 11%  perf-profile.calltrace=
.cycles-pp.ptp_release.posix_clock_release.__fput.__x64_sys_close.do_syscal=
l_64
>       0.00            +3.7        3.68 =C2=B1 11%  perf-profile.calltrace=
.cycles-pp.posix_clock_release.__fput.__x64_sys_close.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>      12.58 =C2=B1  4%      -2.8        9.74 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.__x64_sys_clock_gettime
>       9.42 =C2=B1  5%      -2.2        7.20 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.clock_gettime
>       8.84 =C2=B1  5%      -2.2        6.67 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.e1000e_read_systim
>       8.97 =C2=B1  5%      -2.2        6.81 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.e1000e_phc_gettimex
>       9.12 =C2=B1  5%      -2.1        6.98 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.pc_clock_gettime
>      10.92 =C2=B1  3%      -1.8        9.07 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.syscall
>      11.24 =C2=B1  3%      -1.7        9.51 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.clock_adjtime
>       9.69 =C2=B1  3%      -1.5        8.21 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.__do_sys_clock_adjtime
>       7.19 =C2=B1  4%      -1.4        5.80 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.poll_idle
>       8.53 =C2=B1  4%      -1.3        7.22 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.do_adjtimex
>       6.42 =C2=B1  3%      -0.9        5.51 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.timekeeping_inject_offset
>       5.93 =C2=B1  3%      -0.9        5.06 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.clock_was_set
>       4.47 =C2=B1  3%      -0.5        3.98 =C2=B1  7%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irqsave
>       2.37 =C2=B1  3%      -0.4        1.95 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.entry_SYSRETQ_unsafe_stack
>       2.88 =C2=B1  2%      -0.4        2.50 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.timer_create
>       2.08 =C2=B1  3%      -0.3        1.74 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.read_tsc
>       1.65 =C2=B1  3%      -0.3        1.37 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.add_device_randomness
>       1.43 =C2=B1  3%      -0.3        1.16 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.blake2s_compress
>       1.53 =C2=B1  3%      -0.3        1.26 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.blake2s_update
>       1.74 =C2=B1  5%      -0.3        1.48 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.hrtimer_wakeup
>       1.24 =C2=B1  8%      -0.2        1.00 =C2=B1 12%  perf-profile.chil=
dren.cycles-pp.posix_cpu_clock_get
>       1.70 =C2=B1  5%      -0.2        1.46 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.try_to_wake_up
>       1.81 =C2=B1  6%      -0.2        1.59 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.ktime_get_update_offsets_now
>       1.14 =C2=B1  3%      -0.2        0.96 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.ttwu_do_activate
>       0.91 =C2=B1  3%      -0.2        0.73 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.rep_movs_alternative
>       1.20 =C2=B1  6%      -0.2        1.02 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.lapic_next_deadline
>       1.04 =C2=B1  4%      -0.2        0.87 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.hrtimer_start_range_ns
>       1.00 =C2=B1  4%      -0.1        0.86 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.activate_task
>       0.96 =C2=B1  5%      -0.1        0.83 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode
>       0.46 =C2=B1  7%      -0.1        0.33 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp._raw_spin_unlock_irqrestore
>       0.54 =C2=B1  8%      -0.1        0.42 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.clockevents_program_min_delta
>       1.04 =C2=B1  4%      -0.1        0.94 =C2=B1  6%  perf-profile.chil=
dren.cycles-pp.memset_orig
>       0.52 =C2=B1  8%      -0.1        0.42 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.22 =C2=B1 17%      -0.1        0.14 =C2=B1 34%  perf-profile.chil=
dren.cycles-pp.posix_get_monotonic_timespec
>       0.22 =C2=B1 20%      -0.1        0.14 =C2=B1 20%  perf-profile.chil=
dren.cycles-pp.ktime_get_real_ts64
>       0.11 =C2=B1 20%      -0.1        0.05 =C2=B1 51%  perf-profile.chil=
dren.cycles-pp.__cgroup_account_cputime
>       0.22 =C2=B1  9%      -0.1        0.16 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.posix_get_boottime_timespec
>       0.12 =C2=B1  7%      -0.0        0.08 =C2=B1 27%  perf-profile.chil=
dren.cycles-pp.update_curr_fair
>       0.06 =C2=B1 46%      +0.0        0.10 =C2=B1 25%  perf-profile.chil=
dren.cycles-pp.memcpy_orig
>       0.01 =C2=B1223%      +0.1        0.07 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.rcu_nocb_try_bypass
>       0.00            +0.1        0.06 =C2=B1 14%  perf-profile.children.=
cycles-pp.default_pointer
>       0.00            +0.1        0.07 =C2=B1 15%  perf-profile.children.=
cycles-pp.__srcu_read_unlock
>       0.00            +0.1        0.08 =C2=B1 32%  perf-profile.children.=
cycles-pp.iput
>       0.00            +0.1        0.08 =C2=B1 23%  perf-profile.children.=
cycles-pp.lookup_one_common
>       0.00            +0.1        0.09 =C2=B1 18%  perf-profile.children.=
cycles-pp.inode_init_once
>       0.00            +0.1        0.09 =C2=B1 22%  perf-profile.children.=
cycles-pp.__srcu_read_lock
>       0.00            +0.1        0.09 =C2=B1 26%  perf-profile.children.=
cycles-pp.up_write
>       0.00            +0.1        0.09 =C2=B1 20%  perf-profile.children.=
cycles-pp.__d_lookup
>       0.00            +0.1        0.10 =C2=B1 19%  perf-profile.children.=
cycles-pp.setup_object
>       0.14 =C2=B1 20%      +0.1        0.24 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.get_obj_cgroup_from_current
>       0.00            +0.1        0.10 =C2=B1 27%  perf-profile.children.=
cycles-pp.shrink_dcache_parent
>       0.02 =C2=B1142%      +0.1        0.12 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.lockref_put_or_lock
>       0.00            +0.1        0.10 =C2=B1 20%  perf-profile.children.=
cycles-pp.d_lookup
>       0.00            +0.1        0.10 =C2=B1 18%  perf-profile.children.=
cycles-pp.__wake_up_common_lock
>       0.00            +0.1        0.11 =C2=B1 17%  perf-profile.children.=
cycles-pp.lookup_dcache
>       0.00            +0.1        0.11 =C2=B1 22%  perf-profile.children.=
cycles-pp.shuffle_freelist
>       0.00            +0.1        0.12 =C2=B1 17%  perf-profile.children.=
cycles-pp.d_instantiate
>       0.00            +0.1        0.12 =C2=B1 24%  perf-profile.children.=
cycles-pp.down_write
>       0.10 =C2=B1 36%      +0.1        0.23 =C2=B1 29%  perf-profile.chil=
dren.cycles-pp.obj_cgroup_charge
>       0.00            +0.1        0.14 =C2=B1 24%  perf-profile.children.=
cycles-pp.allocate_slab
>       0.00            +0.1        0.14 =C2=B1 36%  perf-profile.children.=
cycles-pp.memcg_list_lru_alloc
>       0.00            +0.1        0.14 =C2=B1 34%  perf-profile.children.=
cycles-pp.d_walk
>       0.00            +0.1        0.14 =C2=B1  5%  perf-profile.children.=
cycles-pp.number
>       0.00            +0.2        0.16 =C2=B1 16%  perf-profile.children.=
cycles-pp.__destroy_inode
>       0.00            +0.2        0.16 =C2=B1 16%  perf-profile.children.=
cycles-pp.dentry_unlink_inode
>       0.10 =C2=B1 26%      +0.2        0.26 =C2=B1 18%  perf-profile.chil=
dren.cycles-pp.___slab_alloc
>       0.00            +0.2        0.17 =C2=B1 17%  perf-profile.children.=
cycles-pp.destroy_inode
>       0.00            +0.2        0.18 =C2=B1 13%  perf-profile.children.=
cycles-pp.fsnotify_grab_connector
>       0.27 =C2=B1 20%      +0.2        0.44 =C2=B1 12%  perf-profile.chil=
dren.cycles-pp.__call_rcu_common
>       0.34 =C2=B1 14%      +0.2        0.52 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.mod_objcg_state
>       0.00            +0.2        0.19 =C2=B1  8%  perf-profile.children.=
cycles-pp.inode_init_always
>       0.00            +0.2        0.22 =C2=B1 15%  perf-profile.children.=
cycles-pp.fsnotify_destroy_marks
>       0.40 =C2=B1 12%      +0.3        0.66 =C2=B1 18%  perf-profile.chil=
dren.cycles-pp.memcg_slab_post_alloc_hook
>       0.00            +0.3        0.26 =C2=B1 22%  perf-profile.children.=
cycles-pp.d_invalidate
>       0.00            +0.3        0.28 =C2=B1 10%  perf-profile.children.=
cycles-pp.__d_add
>       0.00            +0.3        0.30 =C2=B1 11%  perf-profile.children.=
cycles-pp.simple_lookup
>       0.00            +0.3        0.32 =C2=B1 15%  perf-profile.children.=
cycles-pp.evict
>       0.55 =C2=B1  9%      +0.4        0.90 =C2=B1 17%  perf-profile.chil=
dren.cycles-pp.smpboot_thread_fn
>       0.14 =C2=B1 24%      +0.4        0.50 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp._find_next_bit
>       0.00            +0.4        0.37 =C2=B1 11%  perf-profile.children.=
cycles-pp.sprintf
>       0.00            +0.4        0.37 =C2=B1 11%  perf-profile.children.=
cycles-pp.vsnprintf
>       0.00            +0.4        0.43 =C2=B1 15%  perf-profile.children.=
cycles-pp.slab_pre_alloc_hook
>       0.00            +0.6        0.58 =C2=B1 12%  perf-profile.children.=
cycles-pp.__d_alloc
>       1.69 =C2=B1  7%      +0.6        2.30 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.__do_softirq
>       1.15 =C2=B1  4%      +0.6        1.80 =C2=B1 17%  perf-profile.chil=
dren.cycles-pp.rcu_do_batch
>       1.26 =C2=B1  4%      +0.6        1.91 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.rcu_core
>       0.00            +0.7        0.70 =C2=B1 14%  perf-profile.children.=
cycles-pp.alloc_inode
>       0.00            +0.8        0.76 =C2=B1 10%  perf-profile.children.=
cycles-pp.d_alloc
>       0.00            +0.8        0.84 =C2=B1 11%  perf-profile.children.=
cycles-pp.d_alloc_parallel
>       0.59 =C2=B1  6%      +0.9        1.46 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock
>       0.00            +0.9        0.91 =C2=B1 11%  perf-profile.children.=
cycles-pp.new_inode
>       0.00            +1.0        1.01 =C2=B1 15%  perf-profile.children.=
cycles-pp.kmem_cache_alloc_lru
>       0.00            +1.0        1.05 =C2=B1 11%  perf-profile.children.=
cycles-pp.__dentry_kill
>       0.00            +1.1        1.10 =C2=B1 11%  perf-profile.children.=
cycles-pp.dentry_kill
>       0.00            +1.2        1.16 =C2=B1 11%  perf-profile.children.=
cycles-pp.__lookup_slow
>       0.10 =C2=B1 30%      +1.2        1.31 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.dput
>       0.00            +1.3        1.26 =C2=B1 12%  perf-profile.children.=
cycles-pp.__debugfs_create_file
>       0.00            +1.4        1.44 =C2=B1 13%  perf-profile.children.=
cycles-pp.mnt_get_count
>       0.00            +1.4        1.44 =C2=B1 11%  perf-profile.children.=
cycles-pp.lookup_one_len
>       0.00            +1.5        1.47 =C2=B1 13%  perf-profile.children.=
cycles-pp.debugfs_create_dir
>       0.01 =C2=B1223%      +1.6        1.60 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.mntput_no_expire
>       0.00            +1.6        1.61 =C2=B1 11%  perf-profile.children.=
cycles-pp.start_creating
>       0.00            +2.4        2.43 =C2=B1 12%  perf-profile.children.=
cycles-pp.simple_recursive_removal
>       0.00            +3.0        2.96 =C2=B1 11%  perf-profile.children.=
cycles-pp.debugfs_remove
>       1.75 =C2=B1  5%      +3.0        4.71 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.do_dentry_open
>       1.35 =C2=B1  6%      +3.0        4.33 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.posix_clock_open
>       2.93 =C2=B1  5%      +3.0        5.91 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.path_openat
>       1.42 =C2=B1  6%      +3.0        4.41 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.chrdev_open
>       2.03 =C2=B1  5%      +3.0        5.02 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.do_open
>       2.97 =C2=B1  6%      +3.0        5.98 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.do_filp_open
>       3.54 =C2=B1  6%      +3.0        6.56 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.do_sys_openat2
>       3.57 =C2=B1  6%      +3.0        6.59 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.__x64_sys_openat
>       1.18 =C2=B1  6%      +3.0        4.22 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.ptp_open
>       3.79 =C2=B1  6%      +3.1        6.84 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.open64
>       0.87 =C2=B1 11%      +3.2        4.10 =C2=B1 12%  perf-profile.chil=
dren.cycles-pp.__x64_sys_close
>       1.09 =C2=B1  9%      +3.2        4.34 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.__close
>       0.59 =C2=B1 11%      +3.3        3.92 =C2=B1 12%  perf-profile.chil=
dren.cycles-pp.__fput
>       0.31 =C2=B1 19%      +3.4        3.68 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.posix_clock_release
>       0.18 =C2=B1 15%      +3.4        3.59 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.ptp_release
>       8.84 =C2=B1  5%      -2.2        6.67 =C2=B1  9%  perf-profile.self=
.cycles-pp.e1000e_read_systim
>       3.55 =C2=B1  7%      -0.8        2.72 =C2=B1 14%  perf-profile.self=
.cycles-pp.poll_idle
>       4.42 =C2=B1  3%      -0.5        3.92 =C2=B1  7%  perf-profile.self=
.cycles-pp._raw_spin_lock_irqsave
>       2.32 =C2=B1  4%      -0.4        1.90 =C2=B1  9%  perf-profile.self=
.cycles-pp.entry_SYSRETQ_unsafe_stack
>       2.01 =C2=B1  3%      -0.3        1.70 =C2=B1  8%  perf-profile.self=
.cycles-pp.read_tsc
>       1.78 =C2=B1  5%      -0.3        1.50 =C2=B1  9%  perf-profile.self=
.cycles-pp.syscall
>       1.43 =C2=B1  3%      -0.3        1.16 =C2=B1 11%  perf-profile.self=
.cycles-pp.blake2s_compress
>       1.08 =C2=B1  5%      -0.2        0.88 =C2=B1 15%  perf-profile.self=
.cycles-pp._copy_to_user
>       1.20 =C2=B1  6%      -0.2        1.02 =C2=B1  9%  perf-profile.self=
.cycles-pp.lapic_next_deadline
>       0.56 =C2=B1  4%      -0.1        0.44 =C2=B1 17%  perf-profile.self=
.cycles-pp.rep_movs_alternative
>       0.42 =C2=B1  8%      -0.1        0.30 =C2=B1 16%  perf-profile.self=
.cycles-pp._raw_spin_unlock_irqrestore
>       0.52 =C2=B1  8%      -0.1        0.42 =C2=B1 10%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.38 =C2=B1 10%      -0.1        0.30 =C2=B1 19%  perf-profile.self=
.cycles-pp.syscall_enter_from_user_mode
>       0.44 =C2=B1  9%      -0.1        0.36 =C2=B1  9%  perf-profile.self=
.cycles-pp.__schedule
>       0.28 =C2=B1 14%      -0.1        0.20 =C2=B1 10%  perf-profile.self=
.cycles-pp.exit_to_user_mode_prepare
>       0.09 =C2=B1 29%      -0.1        0.04 =C2=B1 72%  perf-profile.self=
.cycles-pp.do_adjtimex
>       0.21 =C2=B1 13%      -0.0        0.16 =C2=B1 10%  perf-profile.self=
.cycles-pp.__update_load_avg_se
>       0.12 =C2=B1  8%      -0.0        0.08 =C2=B1 22%  perf-profile.self=
.cycles-pp.update_curr_fair
>       0.13 =C2=B1 20%      -0.0        0.10 =C2=B1 10%  perf-profile.self=
.cycles-pp.apparmor_capable
>       0.06 =C2=B1 50%      +0.0        0.10 =C2=B1 16%  perf-profile.self=
.cycles-pp.get_obj_cgroup_from_current
>       0.02 =C2=B1144%      +0.1        0.07 =C2=B1 17%  perf-profile.self=
.cycles-pp.do_filp_open
>       0.17 =C2=B1 16%      +0.1        0.23 =C2=B1 12%  perf-profile.self=
.cycles-pp.put_timespec64
>       0.02 =C2=B1141%      +0.1        0.08 =C2=B1 27%  perf-profile.self=
.cycles-pp.___slab_alloc
>       0.00            +0.1        0.07 =C2=B1 15%  perf-profile.self.cycl=
es-pp.__srcu_read_unlock
>       0.02 =C2=B1141%      +0.1        0.09 =C2=B1 24%  perf-profile.self=
.cycles-pp.lockref_put_or_lock
>       0.44 =C2=B1  9%      +0.1        0.52 =C2=B1  9%  perf-profile.self=
.cycles-pp.kmem_cache_free
>       0.00            +0.1        0.09 =C2=B1 21%  perf-profile.self.cycl=
es-pp.inode_init_once
>       0.00            +0.1        0.09 =C2=B1 21%  perf-profile.self.cycl=
es-pp.__srcu_read_lock
>       0.00            +0.1        0.09 =C2=B1 25%  perf-profile.self.cycl=
es-pp.up_write
>       0.00            +0.1        0.09 =C2=B1 21%  perf-profile.self.cycl=
es-pp.__d_lookup
>       0.00            +0.1        0.09 =C2=B1 26%  perf-profile.self.cycl=
es-pp.down_write
>       0.00            +0.1        0.09 =C2=B1 27%  perf-profile.self.cycl=
es-pp.slab_pre_alloc_hook
>       0.01 =C2=B1223%      +0.1        0.11 =C2=B1 51%  perf-profile.self=
.cycles-pp.mntput_no_expire
>       0.00            +0.1        0.11 =C2=B1  9%  perf-profile.self.cycl=
es-pp.kmem_cache_alloc_lru
>       0.00            +0.1        0.12 =C2=B1 12%  perf-profile.self.cycl=
es-pp.inode_init_always
>       0.00            +0.1        0.14 =C2=B1  5%  perf-profile.self.cycl=
es-pp.number
>       0.26 =C2=B1 19%      +0.2        0.44 =C2=B1 18%  perf-profile.self=
.cycles-pp.memcg_slab_post_alloc_hook
>       0.11 =C2=B1 29%      +0.3        0.39 =C2=B1 18%  perf-profile.self=
.cycles-pp._find_next_bit
>       0.58 =C2=B1  7%      +0.8        1.42 =C2=B1  5%  perf-profile.self=
.cycles-pp._raw_spin_lock
>       0.00            +1.1        1.14 =C2=B1 14%  perf-profile.self.cycl=
es-pp.mnt_get_count
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

--=20
Vinicius
