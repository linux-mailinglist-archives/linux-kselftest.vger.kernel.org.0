Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA246B1D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 05:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhLGEbN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 23:31:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:18578 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233659AbhLGEbM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 23:31:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298288408"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="298288408"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:27:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="461106554"
Received: from hanyu1-mobl.ccr.corp.intel.com (HELO [10.167.226.45]) ([10.255.29.181])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:27:39 -0800
Subject: Re: ww_mutex.sh hangs since v5.16-rc1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, open list <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
References: <895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com>
 <20211202225712.GG16608@worktop.programming.kicks-ass.net>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <5249edf6-5b28-a8da-ca68-f1ea68c3637e@intel.com>
Date:   Tue, 7 Dec 2021 12:27:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202225712.GG16608@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 03/12/2021 06:57, Peter Zijlstra wrote:
> On Wed, Dec 01, 2021 at 09:26:18AM +0800, Li Zhijian wrote:
>> Hi Folks
>>
>>
>> LKP/0Day found that ww_mutex.sh cannot complete since v5.16-rc1, but
>> I'm pretty sorry that we failed to bisect the FBC, instead, the bisection pointed
>> to a/below merge commit(91e1c99e17) finally.
>>
>> Due to this hang, other tests in the same group are also blocked in 0Day, we
>> hope we can fix this hang ASAP.
>>
>> So if you have any idea about this, or need more debug information, feel free to let me know :)
>>
>> BTW, ww_mutex.sh was failed in v5.15 without hang, and looks it cannot reproduce on a vm.
> On real hardware:
>
> root@ivb-ep:/usr/src/linux-2.6/tools/testing/selftests/locking# uname -a
> Linux ivb-ep 5.16.0-rc3-00284-g68601c558556 #1 SMP PREEMPT Thu Dec 2 23:03:29 CET 2021 x86_64 GNU/Linux
> root@ivb-ep:/usr/src/linux-2.6/tools/testing/selftests/locking# ./ww_mutex.sh
> locking/ww_mutex: ok
>
> [ 1907.907801] Beginning ww mutex selftests
> [ 1915.700077] All ww mutex selftests passed
>
>
> What else do I try?
I have no idea that, not sure below message is helpful

root@lkp-knm01 /opt/rootfs# pgrep test-ww_mutex | wc -l
256
root@lkp-knm01 /opt/rootfs# pgrep test-ww_mutex -l | head -n 3
1492 kworker/u576:38+test-ww_mutex
1497 kworker/u576:43+test-ww_mutex
1513 kworker/u576:59+test-ww_mutex

root@lkp-knm01 /opt/rootfs# lscpu
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
CPU MHz:             1600.000
CPU max MHz:         1600.0000
CPU min MHz:         1000.0000
BogoMIPS:            2992.92
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            1024K
NUMA node0 CPU(s):   0-287
NUMA node1 CPU(s):
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma cx16 xtpr pdcm sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ring3mwait cpuid_fault epb pti tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms avx512f rdseed adx avx512pf avx512er avx512cd xsaveopt dtherm ida arat pln pts avx512_vpopcntdq avx512_4vnniw avx512_4fmaps
root@lkp-knm01 /opt/rootfs#


[ 1500.848024] INFO: task kworker/u576:5:12395 blocked for more than 496 seconds.
[ 1500.866920]       Not tainted 5.16.0-rc4 #1
[ 1500.882898] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1500.903997] task:kworker/u576:5  state:D stack:    0 pid:12395 ppid:     2 flags:0x00004000
[ 1500.926047] Workqueue: test-ww_mutex test_cycle_work [test_ww_mutex]
[ 1500.945916] Call Trace:
[ 1500.959042] <TASK>
[ 1500.972977] __schedule+0xdb0/0x25c0
[ 1500.987868]  ? io_schedule_timeout+0x180/0x180
[ 1501.004971]  ? lock_downgrade+0x680/0x680
[ 1501.021975] schedule+0xe4/0x280
[ 1501.036896] schedule_preempt_disabled+0x18/0x40
[ 1501.053967] __ww_mutex_lock.constprop.0+0x1248/0x34c0
[ 1501.072020]  ? test_cycle_work+0x1bb/0x500 [test_ww_mutex]
[ 1501.088903]  ? mutex_lock_interruptible_nested+0x40/0x40
[ 1501.106256]  ? lock_is_held_type+0xd7/0x140
[ 1501.123083]  ? ww_mutex_lock+0x3e/0x380
[ 1501.138803] ww_mutex_lock+0x3e/0x380
[ 1501.154637]  test_cycle_work+0x1bb/0x500 [test_ww_mutex]
[ 1501.172498]  ? stress_reorder_work+0xa00/0xa00 [test_ww_mutex]
[ 1501.189955]  ? rcu_read_lock_sched_held+0xa1/0x100
[ 1501.205827]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 1501.221996] process_one_work+0x817/0x13c0
[ 1501.236500]  ? rcu_read_unlock+0x40/0x40
[ 1501.252896]  ? pwq_dec_nr_in_flight+0x280/0x280
[ 1501.269914]  ? rwlock_bug.part.0+0xc0/0xc0
[ 1501.285008] worker_thread+0x8b/0xd80
[ 1501.301083]  ? process_one_work+0x13c0/0x13c0
[ 1501.318071] kthread+0x3b9/0x4c0
[ 1501.331953]  ? set_kthread_struct+0x100/0x100
[ 1501.348374] ret_from_fork+0x22/0x30
[ 1501.363834] </TASK>
[ 1501.377565]
[ 1501.377565]
                Showing all locks held in the system:
[ 1501.407817] 4 locks held by kworker/u576:38/1492:
[ 1501.424053]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1501.447970]  #1: ffffc9000db6fdd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1501.472031]  #2: ffffc9000db6fc98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1501.495016]  #3: ffff8882688935c0 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1501.519059] 4 locks held by kworker/u576:43/1497:
[ 1501.535821]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1501.558931]  #1: ffffc9000dbbfdd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1501.582978]  #2: ffffc9000dbbfc98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1501.604950]  #3: ffff88826888e520 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1501.628905] 4 locks held by kworker/u576:59/1513:
[ 1501.646947]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1501.672947]  #1: ffffc9000dcbfdd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1501.698754]  #2: ffffc9000dcbfc98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1501.723030]  #3: ffff888268880208 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1501.748891] 1 lock held by khungtaskd/1650:
[ 1501.767506]  #0: ffffffff855d5060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.0+0x0/0x40
[ 1501.794899] 4 locks held by kworker/192:2/2053:
[ 1501.814535] 1 lock held by in:imklog/3102:
[ 1501.831982]  #0: ffff88828ca12170 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xa1/0xc0
[ 1501.855919] 1 lock held by dmesg/3826:
[ 1501.873472]  #0: ffff88821e5c80d0 (&user->lock){+.+.}-{3:3}, at: new_sync_write+0x4cc/0x640
[ 1501.897875] 4 locks held by kworker/u576:0/7921:
[ 1501.918442]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1501.946235]  #1: ffffc9000abcfdd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1501.972770]  #2: ffffc9000abcfc98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1501.998071]  #3: ffff888268884130 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1502.025008] 4 locks held by kworker/u576:1/12391:
[ 1502.045611]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1502.072864]  #1: ffffc900078dfdd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1502.100181]  #2: ffffc900078dfc98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1502.126541]  #3: ffff888268888460 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1502.154874] 4 locks held by kworker/u576:2/12392:
[ 1502.175873]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1502.203986]  #1: ffffc90007937dd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1502.232522]  #2: ffffc90007937c98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1502.260005]  #3: ffff88826888b4c0 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1502.289015] 4 locks held by kworker/u576:3/12393:
[ 1502.311079]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1502.340862]  #1: ffffc9000798fdd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1502.369950]  #2: ffffc9000798fc98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1502.398992]  #3: ffff8882688931b8 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1502.429018] 4 locks held by kworker/u576:4/12394:
[ 1502.452516]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1502.482907]  #1: ffffc900079e7dd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1502.513932]  #2: ffffc900079e7c98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1502.544097]  #3: ffff88826888a1f0 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1502.575802] 4 locks held by kworker/u576:5/12395:
[ 1502.600046]  #0: ffff888262e50138 ((wq_completion)test-ww_mutex){+.+.}-{0:0}, at: process_one_work+0x740/0x13c0
[ 1502.630939]  #1: ffffc90007a3fdd0 ((work_completion)(&cycle->work)){+.+.}-{0:0}, at: process_one_work+0x76d/0x13c0
[ 1502.662034]  #2: ffffc90007a3fc98 (ww_class_acquire){+.+.}-{0:0}, at: process_one_work+0x817/0x13c0
[ 1502.691957]  #3: ffff88826888d908 (ww_class_mutex){+.+.}-{3:3}, at: test_cycle_work+0x14c/0x500 [test_ww_mutex]
[ 1502.723051] 4 locks held by kworker/u576:6/12396:


