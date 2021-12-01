Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8EF464479
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 02:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhLABaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 20:30:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:44379 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhLABaI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 20:30:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223237262"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="223237262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 17:26:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="459066859"
Received: from liweilv-mobl.ccr.corp.intel.com (HELO [10.167.226.45]) ([10.255.30.243])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 17:26:45 -0800
From:   Li Zhijian <zhijianx.li@intel.com>
Subject: ww_mutex.sh hangs since v5.16-rc1
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Message-ID: <895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com>
Date:   Wed, 1 Dec 2021 09:26:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Folks


LKP/0Day found that ww_mutex.sh cannot complete since v5.16-rc1, but
I'm pretty sorry that we failed to bisect the FBC, instead, the bisection pointed
to a/below merge commit(91e1c99e17) finally.

Due to this hang, other tests in the same group are also blocked in 0Day, we
hope we can fix this hang ASAP.

So if you have any idea about this, or need more debug information, feel free to let me know :)

BTW, ww_mutex.sh was failed in v5.15 without hang, and looks it cannot reproduce on a vm.

Our box:
root@lkp-knm01 ~# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       46 bits physical, 48 bits virtual
CPU(s):              288
On-line CPU(s) list: 0-287
Thread(s) per core:  4
Core(s) per socket:  72
Socket(s):           1
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               133
Model name:          Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz
Stepping:            0
CPU MHz:             1385.255
CPU max MHz:         1600.0000
CPU min MHz:         1000.0000
BogoMIPS:            2992.76
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            1024K
NUMA node0 CPU(s):   0-287
NUMA node1 CPU(s):
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ring3mwait cpuid_fault epb pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms avx512f rdseed adx avx512pf avx512er avx512cd xsaveopt dtherm ida arat pln pts avx512_vpopcntdq avx512_4vnniw avx512_4fmaps

Below the call stack in v5.16-rc2

[ 1000.374954][ T2713] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-136057256686de39cc3a07c2e39ef6bc43003ff6/tools/testing/selftests/locking'
[ 1000.375030][ T2713]
[ 1000.428791][ T2713] 2021-11-22 22:21:27 make run_tests -C locking
[ 1000.428864][ T2713]
[ 1000.491043][ T2713] make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-136057256686de39cc3a07c2e39ef6bc43003ff6/tools/testing/selftests/locking'
[ 1000.491121][ T2713]
[ 1000.540807][ T2713] TAP version 13
[ 1000.540882][ T2713]
[ 1000.576050][ T2713] 1..1
[ 1000.576282][ T2713]
[ 1000.612980][ T2713] # selftests: locking: ww_mutex.sh
[ 1000.613288][ T2713]
[ 1495.201324][ T1577] INFO: task kworker/u576:16:1470 blocked for more than 491 seconds.
[ 1495.220059][ T1577]       Tainted: G    B             5.16.0-rc2 #1
[ 1495.240902][ T1577] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1495.265617][ T1577] task:kworker/u576:16 state:D stack:    0 pid: 1470 ppid:     2 flags:0x00004000
[ 1495.289054][ T1577] Workqueue: test-ww_mutex test_cycle_work [test_ww_mutex]
[ 1495.310936][ T1577] Call Trace:
[ 1495.327809][ T1577] <TASK>
[ 1495.344735][ T1577] __schedule+0xdb0/0x25c0
[ 1495.362764][ T1577]  ? io_schedule_timeout+0x180/0x180
[ 1495.382013][ T1577]  ? lock_downgrade+0x680/0x680
[ 1495.400894][ T1577]  ? do_raw_spin_lock+0x125/0x2c0
[ 1495.418866][ T1577] schedule+0xe4/0x280
[ 1495.435597][ T1577] schedule_preempt_disabled+0x18/0x40
[ 1495.454588][ T1577] __ww_mutex_lock+0x1248/0x34c0
[ 1495.476189][ T1577]  ? test_cycle_work+0x1bb/0x500 [test_ww_mutex]
[ 1495.497763][ T1577]  ? mutex_lock_interruptible_nested+0x40/0x40
[ 1495.518959][ T1577]  ? lock_downgrade+0x680/0x680
[ 1495.536861][ T1577]  ? wait_for_completion_interruptible+0x340/0x340
[ 1495.556253][ T1577]  ? ww_mutex_lock+0x3e/0x380
[ 1495.574003][ T1577] ww_mutex_lock+0x3e/0x380
[ 1495.591958][ T1577]  test_cycle_work+0x1bb/0x500 [test_ww_mutex]
[ 1495.612260][ T1577]  ? stress_reorder_work+0xa00/0xa00 [test_ww_mutex]
[ 1495.632857][ T1577]  ? 0xffffffff81000000
[ 1495.649027][ T1577]  ? rcu_read_lock_sched_held+0x5f/0x100
[ 1495.668211][ T1577]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1495.687010][ T1577] process_one_work+0x817/0x13c0
[ 1495.704991][ T1577]  ? rcu_read_unlock+0x40/0x40
[ 1495.723024][ T1577]  ? pwq_dec_nr_in_flight+0x280/0x280
[ 1495.740211][ T1577]  ? rwlock_bug+0xc0/0xc0
[ 1495.758038][ T1577] worker_thread+0x8b/0xd80
[ 1495.775008][ T1577]  ? process_one_work+0x13c0/0x13c0
[ 1495.793017][ T1577] kthread+0x3b9/0x4c0
[ 1495.810782][ T1577]  ? set_kthread_struct+0x100/0x100
[ 1495.829988][ T1577] ret_from_fork+0x22/0x30
[ 1495.845811][ T1577] </TASK>
[ 1495.859087][ T1577] INFO: task kworker/u576:36:1490 blocked for more than 492 seconds.
[ 1495.879048][ T1577]       Tainted: G    B             5.16.0-rc2 #1
[ 1495.897879][ T1577] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1495.919582][ T1577] task:kworker/u576:36 state:D stack:    0 pid: 1490 ppid:     2 flags:0x00004000
[ 1495.941865][ T1577] Workqueue: test-ww_mutex test_cycle_work [test_ww_mutex]
[ 1495.959889][ T1577] Call Trace:
[ 1495.974816][ T1577] <TASK>
[ 1495.988759][ T1577] __schedule+0xdb0/0x25c0
[ 1495.988759][ T1577] __schedule+0xdb0/0x25c0
[ 1496.003849][ T1577]  ? io_schedule_timeout+0x180/0x180
[ 1496.020839][ T1577]  ? lock_downgrade+0x680/0x680
[ 1496.036854][ T1577]  ? do_raw_spin_lock+0x125/0x2c0
[ 1496.051976][ T1577] schedule+0xe4/0x280
[ 1496.067780][ T1577] schedule_preempt_disabled+0x18/0x40
[ 1496.085004][ T1577] __ww_mutex_lock+0x1248/0x34c0
[ 1496.101895][ T1577]  ? test_cycle_work+0x1bb/0x500 [test_ww_mutex]
[ 1496.119889][ T1577]  ? mutex_lock_interruptible_nested+0x40/0x40
[ 1496.137873][ T1577]  ? lock_downgrade+0x680/0x680
[ 1496.152657][ T1577]  ? wait_for_completion_interruptible+0x340/0x340
[ 1496.168773][ T1577]  ? ww_mutex_lock+0x3e/0x380
[ 1496.184862][ T1577] ww_mutex_lock+0x3e/0x380
[ 1496.199979][ T1577]  test_cycle_work+0x1bb/0x500 [test_ww_mutex]
[ 1496.216277][ T1577]  ? stress_reorder_work+0xa00/0xa00 [test_ww_mutex]
[ 1496.234904][ T1577]  ? 0xffffffff81000000
[ 1496.249856][ T1577]  ? rcu_read_lock_sched_held+0x5f/0x100
[ 1496.265951][ T1577]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1496.282815][ T1577] process_one_work+0x817/0x13c0
[ 1496.299791][ T1577]  ? rcu_read_unlock+0x40/0x40
[ 1496.314754][ T1577]  ? pwq_dec_nr_in_flight+0x280/0x280
[ 1496.331779][ T1577]  ? rwlock_bug+0xc0/0xc0
[ 1496.348007][ T1577] worker_thread+0x8b/0xd80
[ 1496.362905][ T1577]  ? process_one_work+0x13c0/0x13c0
[ 1496.378975][ T1577] kthread+0x3b9/0x4c0
[ 1496.393866][ T1577]  ? set_kthread_struct+0x100/0x100
[ 1496.408827][ T1577] ret_from_fork+0x22/0x30
[ 1496.423901][ T1577] </TASK>
[ 1496.437994][ T1577] INFO: task kworker/u576:0:15113 blocked for more than 492 seconds.
[ 1496.455862][ T1577]       Tainted: G    B             5.16.0-rc2 #1
[ 1496.473759][ T1577] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1496.494808][ T1577] task:kworker/u576:0  state:D stack:    0 pid:15113 ppid:     2 flags:0x00004000
[ 1496.517000][ T1577] Workqueue: test-ww_mutex test_cycle_work [test_ww_mutex]
[ 1496.537035][ T1577] Call Trace:
[ 1496.551187][ T1577] <TASK>
[ 1496.566405][ T1577] __schedule+0xdb0/0x25c0
[ 1496.582012][ T1577]  ? io_schedule_timeout+0x180/0x180
[ 1496.598049][ T1577]  ? lock_downgrade+0x680/0x680
[ 1496.615360][ T1577]  ? do_raw_spin_lock+0x125/0x2c0
[ 1496.631835][ T1577] schedule+0xe4/0x280
[ 1496.645972][ T1577] schedule_preempt_disabled+0x18/0x40
[ 1496.663774][ T1577] __ww_mutex_lock+0x1248/0x34c0
[ 1496.681795][ T1577]  ? test_cycle_work+0x1bb/0x500 [test_ww_mutex]
[ 1496.698731][ T1577]  ? mutex_lock_interruptible_nested+0x40/0x40
[ 1496.714996][ T1577]  ? lock_downgrade+0x680/0x680
[ 1496.730888][ T1577]  ? wait_for_completion_interruptible+0x340/0x340
[ 1496.747926][ T1577]  ? ww_mutex_lock+0x3e/0x380
[ 1496.762482][ T1577] ww_mutex_lock+0x3e/0x380
[ 1496.778844][ T1577]  test_cycle_work+0x1bb/0x500 [test_ww_mutex]


And, we found that it  occasionally hangs on v5.16-rc3 (1/3 runs), below is a good dmesg.
[  962.136756][ T2950] make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d58071a8a76d779eedab38033ae4c821c30295a5/tools/testing/selftests/locking'
[  962.136831][ T2950]-
[  962.205036][ T2950] TAP version 13
[  962.206003][ T2950]-
[  962.298458][ T2950] 1..1
[  962.299657][ T2950]-
[  962.345588][ T2950] # selftests: locking: ww_mutex.sh
[  962.345657][ T2950]-
[  973.641869][T25509] All ww mutex selftests passed
[  973.773996][ T2950] # locking/ww_mutex: ok
[  973.774068][ T2950]-
[  973.774236][ T2960] # locking/ww_mutex: ok
[  973.802355][ T2960]-
[  973.829966][ T2950] ok 1 selftests: locking: ww_mutex.sh
[  973.834748][ T2950]-
[  973.838302][ T2960] ok 1 selftests: locking: ww_mutex.sh
[  973.899815][ T2960]-
[  973.921431][ T2950] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d58071a8a76d779eedab38033ae4c821c30295a5/tools/testing/selftests/locking'
[  973.932312][ T2950]-
[  973.957345][ T2960] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d58071a8a76d779eedab38033ae4c821c30295a5/tools/testing/selftests/locking'



Thanks
Zhijian@0Day



