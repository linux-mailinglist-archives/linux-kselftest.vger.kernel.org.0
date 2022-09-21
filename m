Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B195BFE75
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIUMyx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 08:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUMyx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 08:54:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B96B2B24A;
        Wed, 21 Sep 2022 05:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D606CB82F78;
        Wed, 21 Sep 2022 12:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842B6C433C1;
        Wed, 21 Sep 2022 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663764887;
        bh=YOREVqdIi8zBRUcMYq8fnOQ4gi+Z20giD+aCVE2GlBA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cw0cKrkSyUrkO7AfNSAlImFbnDueErPqkUxWF3PBUZMhgiwOi582vJKoO8dQU7G+K
         hVh8DRVj8UOM8YVC7dHPn5JzK7jqUlznlIFrKGzkg7u/1i9f2meHsa6BAegmPOge2a
         vxjdmXjH7YCEBJ7qehrGdf9DQqLcY/FtZRiOjLZ9C4W5Z7QQZIU1lFTr8nhnVid0dC
         VJW+OJ4DbdA4jORt2iHtMBwvpJ+6wzXPFqWi+myxVTCJsFkHDekIxWmtKgbk3TINuI
         vaJ7n8yrsVFusyc6wLw7vipgLXS1VGCQcoPcpwDuvRw2jcHuhanbHAAPB1vMRU5NA8
         PyIkRkI5IknCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0D9A35C0849; Wed, 21 Sep 2022 05:54:47 -0700 (PDT)
Date:   Wed, 21 Sep 2022 05:54:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, rcu <rcu@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 arch/arm64/mm/fault.c:593
Message-ID: <20220921125447.GY4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+G9fYs3xh6qAdaCL1WyBqvt+JgBxioCjHhph0V-8w215pKh_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs3xh6qAdaCL1WyBqvt+JgBxioCjHhph0V-8w215pKh_Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 15, 2022 at 03:47:51PM +0530, Naresh Kamboju wrote:
> [Please ignore this email if it is already reported]
> Following kernel warning and BUG have been found while running kselftests gpio
> test case on arm64 Raspberry Pi 4 Model B device running 6.0.0-rc5.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> crash log:
> 
> [   53.796405] kselftest: Running tests in gpio
> TAP version 13
> 1..2
> # selftests: gpio: gpio-mockup.sh
> # 1.  Module load tests
> # 1.1.  dynamic allocation of gpio
> [   55.416786]
> [   55.418311] =============================
> [   55.422371] WARNING: suspicious RCU usage
> [   55.426431] 6.0.0-rc5 #1 Not tainted
> [   55.430052] -----------------------------
> [   55.434112] kernel/sched/core.c:9854 Illegal context switch in
> RCU-bh read-side critical section!

This is exactly what it says on the label:  Something failed to get out
of an RCU read-side critical section before scheduling.

In this case, it was an RCU-bh read-side critical section, that is, an
unmatched call to rcu_read_lock_bh(), local_bh_disable(), spin_lock_bh(),
and so on.  In the case of spin_lock_bh(), the lock might have been
released using spin_unlock().

However...

> [   55.443108] other info that might help us debug this:
> [   55.443108]
> [   55.451222]
> [   55.451222] rcu_scheduler_active = 2, debug_locks = 1
> [   55.457839] 1 lock held by modprobe/563:
> [   55.461812]  #0: ffff00004cf450f8 (&dev->mutex){....}-{3:3}, at:
> device_release_driver_internal+0x50/0x290
> [   55.471632]
> [   55.471632] stack backtrace:
> [   55.476046] CPU: 2 PID: 563 Comm: modprobe Not tainted 6.0.0-rc5 #1
> [   55.482401] Hardware name: Raspberry Pi 4 Model B (DT)
> [   55.487607] Call trace:
> [   55.490079]  dump_backtrace+0xe4/0x130
> [   55.493879]  show_stack+0x30/0x70
> [   55.497235]  dump_stack_lvl+0x8c/0xb8
> [   55.500947]  dump_stack+0x18/0x34
> [   55.504303]  lockdep_rcu_suspicious+0xf8/0x10c
> [   55.508806]  __might_resched+0xd0/0x240
> [   55.512694]  __might_sleep+0x58/0xb0
> [   55.516316]  do_page_fault+0x244/0x4d0
> [   55.520116]  do_translation_fault+0xd8/0x100

...did this really take a page fault while attempting to acquire
a semaphore?  That does sound like a symptom of something pretty
ugly happening.

Maybe a use-after-free bug?  Maybe try reproducing with KASAN?

And of course there is always bisection.

						Thanx, Paul

> [   55.524443]  do_mem_abort+0x58/0xb0
> [   55.527979]  el1_abort+0x44/0x70
> [   55.531248]  el1h_64_sync_handler+0xa4/0xd0
> [   55.535487]  el1h_64_sync+0x64/0x68
> [   55.539020]  __lock_acquire+0x53c/0x2040
> [   55.542995]  lock_acquire.part.0+0xe8/0x24c
> [   55.547233]  lock_acquire+0x84/0xa0
> [   55.550766]  down_write+0x60/0xc4
> [   55.554123]  simple_recursive_removal+0x58/0x290
> [   55.558803]  debugfs_remove+0x5c/0x80
> [   55.562516]  gpio_mockup_debugfs_cleanup+0x24/0x34 [gpio_mockup]
> [   55.568614]  devm_action_release+0x24/0x3c
> [   55.572764]  release_nodes+0x64/0x9c
> [   55.576384]  devres_release_all+0x94/0xec
> [   55.580447]  device_unbind_cleanup+0x24/0x74
> [   55.584773]  device_release_driver_internal+0x240/0x290
> [   55.590070]  driver_detach+0x5c/0xf0
> [   55.593691]  bus_remove_driver+0x6c/0x10c
> [   55.597753]  driver_unregister+0x38/0x6c
> [   55.601728]  platform_driver_unregister+0x24/0x34
> [   55.606497]  gpio_mockup_exit+0x24/0x20c [gpio_mockup]
> [   55.611707]  __arm64_sys_delete_module+0x184/0x2f0
> [   55.616562]  invoke_syscall+0x8c/0x120
> [   55.620362]  el0_svc_common.constprop.0+0x104/0x124
> [   55.625307]  do_el0_svc+0x44/0xc0
> [   55.628664]  el0_svc+0x48/0xc0
> [   55.631757]  el0t_64_sync_handler+0xbc/0x140
> [   55.636084]  el0t_64_sync+0x18c/0x190
> [   55.639793]
> [   55.641298] =============================
> [   55.645356] WARNING: suspicious RCU usage
> [   55.649417] 6.0.0-rc5 #1 Not tainted
> [   55.653037] -----------------------------
> [   55.657096] kernel/sched/core.c:9854 Illegal context switch in
> RCU-sched read-side critical section!
> [   55.666356]
> [   55.666356] other info that might help us debug this:
> [   55.666356]
> [   55.674469]
> [   55.674469] rcu_scheduler_active = 2, debug_locks = 1
> [   55.681084] 1 lock held by modprobe/563:
> [   55.685057]  #0: ffff00004cf450f8 (&dev->mutex){....}-{3:3}, at:
> device_release_driver_internal+0x50/0x290
> [   55.694863]
> [   55.694863] stack backtrace:
> [   55.699275] CPU: 2 PID: 563 Comm: modprobe Not tainted 6.0.0-rc5 #1
> [   55.705628] Hardware name: Raspberry Pi 4 Model B (DT)
> [   55.710834] Call trace:
> [   55.713306]  dump_backtrace+0xe4/0x130
> [   55.717103]  show_stack+0x30/0x70
> [   55.720459]  dump_stack_lvl+0x8c/0xb8
> [   55.724170]  dump_stack+0x18/0x34
> [   55.727526]  lockdep_rcu_suspicious+0xf8/0x10c
> [   55.732029]  __might_resched+0x214/0x240
> [   55.736003]  __might_sleep+0x58/0xb0
> [   55.739625]  do_page_fault+0x244/0x4d0
> [   55.743424]  do_translation_fault+0xd8/0x100
> [   55.747751]  do_mem_abort+0x58/0xb0
> [   55.751286]  el1_abort+0x44/0x70
> [   55.754556]  el1h_64_sync_handler+0xa4/0xd0
> [   55.758794]  el1h_64_sync+0x64/0x68
> [   55.762326]  __lock_acquire+0x53c/0x2040
> [   55.766301]  lock_acquire.part.0+0xe8/0x24c
> [   55.770538]  lock_acquire+0x84/0xa0
> [   55.774072]  down_write+0x60/0xc4
> [   55.777428]  simple_recursive_removal+0x58/0x290
> [   55.782107]  debugfs_remove+0x5c/0x80
> [   55.785818]  gpio_mockup_debugfs_cleanup+0x24/0x34 [gpio_mockup]
> [   55.791911]  devm_action_release+0x24/0x3c
> [   55.796061]  release_nodes+0x64/0x9c
> [   55.799682]  devres_release_all+0x94/0xec
> [   55.803743]  device_unbind_cleanup+0x24/0x74
> [   55.808070]  device_release_driver_internal+0x240/0x290
> [   55.813367]  driver_detach+0x5c/0xf0
> [   55.816988]  bus_remove_driver+0x6c/0x10c
> [   55.821050]  driver_unregister+0x38/0x6c
> [   55.825025]  platform_driver_unregister+0x24/0x34
> [   55.829793]  gpio_mockup_exit+0x24/0x20c [gpio_mockup]
> [   55.835002]  __arm64_sys_delete_module+0x184/0x2f0
> [   55.839858]  invoke_syscall+0x8c/0x120
> [   55.843657]  el0_svc_common.constprop.0+0x104/0x124
> [   55.848602]  do_el0_svc+0x44/0xc0
> [   55.851958]  el0_svc+0x48/0xc0
> [   55.855051]  el0t_64_sync_handler+0xbc/0x140
> [   55.859378]  el0t_64_sync+0x18c/0x190
> [   55.863087] BUG: sleeping function called from invalid context at
> arch/arm64/mm/fault.c:593
> [   55.871554] in_atomic(): 0, irqs_disabled(): 128, non_block: 0,
> pid: 563, name: modprobe
> [   55.879757] preempt_count: 0, expected: 0
> [   55.883816] RCU nest depth: 0, expected: 0
> [   55.887965] 1 lock held by modprobe/563:
> [   55.891936]  #0: ffff00004cf450f8 (&dev->mutex){....}-{3:3}, at:
> device_release_driver_internal+0x50/0x290
> [   55.901743] irq event stamp: 10213
> [   55.905185] hardirqs last  enabled at (10213): [<ffff8000096e2e74>]
> _raw_spin_unlock_irqrestore+0x84/0xa0
> [   55.914888] hardirqs last disabled at (10212): [<ffff8000096e3314>]
> _raw_spin_lock_irqsave+0xa4/0xb0
> [   55.924151] softirqs last  enabled at (9742): [<ffff800008010be4>]
> __do_softirq+0x514/0x62c
> [   55.932618] softirqs last disabled at (9737): [<ffff8000080b4768>]
> __irq_exit_rcu+0x164/0x19c
> [   55.941265] CPU: 2 PID: 563 Comm: modprobe Not tainted 6.0.0-rc5 #1
> [   55.947618] Hardware name: Raspberry Pi 4 Model B (DT)
> [   55.952823] Call trace:
> [   55.955296]  dump_backtrace+0xe4/0x130
> [   55.959093]  show_stack+0x30/0x70
> [   55.962448]  dump_stack_lvl+0x8c/0xb8
> [   55.966159]  dump_stack+0x18/0x34
> [   55.969515]  __might_resched+0x1c4/0x240
> [   55.973490]  __might_sleep+0x58/0xb0
> [   55.977111]  do_page_fault+0x244/0x4d0
> [   55.980910]  do_translation_fault+0xd8/0x100
> [   55.985238]  do_mem_abort+0x58/0xb0
> [   55.988774]  el1_abort+0x44/0x70
> [   55.992043]  el1h_64_sync_handler+0xa4/0xd0
> [   55.996281]  el1h_64_sync+0x64/0x68
> [   55.999814]  __lock_acquire+0x53c/0x2040
> [   56.003789]  lock_acquire.part.0+0xe8/0x24c
> [   56.008028]  lock_acquire+0x84/0xa0
> [   56.011560]  down_write+0x60/0xc4
> [   56.014916]  simple_recursive_removal+0x58/0x290
> [   56.019594]  debugfs_remove+0x5c/0x80
> [   56.023306]  gpio_mockup_debugfs_cleanup+0x24/0x34 [gpio_mockup]
> [   56.029400]  devm_action_release+0x24/0x3c
> [   56.033549]  release_nodes+0x64/0x9c
> [   56.037170]  devres_release_all+0x94/0xec
> [   56.041232]  device_unbind_cleanup+0x24/0x74
> [   56.045559]  device_release_driver_internal+0x240/0x290
> [   56.050855]  driver_detach+0x5c/0xf0
> [   56.054477]  bus_remove_driver+0x6c/0x10c
> [   56.058539]  driver_unregister+0x38/0x6c
> [   56.062513]  platform_driver_unregister+0x24/0x34
> [   56.067281]  gpio_mockup_exit+0x24/0x20c [gpio_mockup]
> [   56.072490]  __arm64_sys_delete_module+0x184/0x2f0
> [   56.077346]  invoke_syscall+0x8c/0x120
> [   56.081145]  el0_svc_common.constprop.0+0x104/0x124
> [   56.086089]  do_el0_svc+0x44/0xc0
> [   56.089446]  el0_svc+0x48/0xc0
> [   56.092539]  el0t_64_sync_handler+0xbc/0x140
> [   56.096866]  el0t_64_sync+0x18c/0x190
> [   56.100584] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000150
> [   56.109495] Mem abort info:
> [   56.112320]   ESR = 0x0000000096000006
> [   56.116116]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   56.121499]   SET = 0, FnV = 0
> [   56.124589]   EA = 0, S1PTW = 0
> [   56.127767]   FSC = 0x06: level 2 translation fault
> [   56.132708] Data abort info:
> [   56.135622]   ISV = 0, ISS = 0x00000006
> [   56.139505]   CM = 0, WnR = 0
> [   56.142506] user pgtable: 4k pages, 48-bit VAs, pgdp=000000004adb5000
> [   56.149035] [0000000000000150] pgd=08000000469d2003,
> p4d=08000000469d2003, pud=0800000046b70003, pmd=0000000000000000
> [   56.159807] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [   56.165455] Modules linked in: gpio_mockup(-) algif_hash
> aes_neon_bs aes_neon_blk xhci_pci raspberrypi_cpufreq
> snd_soc_hdmi_codec xhci_pci_renesas brcmfmac brcmutil hci_uart btqca
> btbcm cfg80211 bluetooth reset_raspberrypi crct10dif_ce
> clk_raspberrypi raspberrypi_hwmon rfkill iproc_rng200 pwm_bcm2835 v3d
> rng_core i2c_bcm2835 drm_shmem_helper vc4 bcm2711_thermal cec
> drm_display_helper drm_cma_helper gpu_sched pcie_brcmstb
> drm_kms_helper fuse drm
> [   56.205467] CPU: 2 PID: 563 Comm: modprobe Tainted: G        W
>     6.0.0-rc5 #1
> [   56.213318] Hardware name: Raspberry Pi 4 Model B (DT)
> [   56.218523] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   56.225582] pc : __lock_acquire+0x53c/0x2040
> [   56.229910] lr : lock_acquire.part.0+0xe8/0x24c
> [   56.234499] sp : ffff80000d03b8a0
> [   56.237852] x29: ffff80000d03b8a0 x28: ffff800008456678 x27: 0000000000000000
> [   56.245091] x26: ffff800008456678 x25: 0000000000000150 x24: 0000000000000000
> [   56.252329] x23: ffff00004c200040 x22: 0000000000000000 x21: 0000000000000001
> [   56.259567] x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
> [   56.266804] x17: ffff800008b93ed0 x16: 0000000000000000 x15: 0000000000000028
> [   56.274041] x14: 000000000004ffff x13: ffff80000b40dd00 x12: ffff80000802cff8
> [   56.281279] x11: ffff80000b40d840 x10: ffff80000802cdfc x9 : 0000000100000000
> [   56.288517] x8 : ffff00004c200040 x7 : ffff800008456678 x6 : 0000000000000000
> [   56.295755] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
> [   56.302992] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff80000aeb6000
> [   56.310230] Call trace:
> [   56.312701]  __lock_acquire+0x53c/0x2040
> [   56.316674]  lock_acquire.part.0+0xe8/0x24c
> [   56.320911]  lock_acquire+0x84/0xa0
> [   56.324444]  down_write+0x60/0xc4
> [   56.327799]  simple_recursive_removal+0x58/0x290
> [   56.332477]  debugfs_remove+0x5c/0x80
> [   56.336186]  gpio_mockup_debugfs_cleanup+0x24/0x34 [gpio_mockup]
> [   56.342276]  devm_action_release+0x24/0x3c
> [   56.346425]  release_nodes+0x64/0x9c
> [   56.350043]  devres_release_all+0x94/0xec
> [   56.354104]  device_unbind_cleanup+0x24/0x74
> [   56.358430]  device_release_driver_internal+0x240/0x290
> [   56.363725]  driver_detach+0x5c/0xf0
> [   56.367346]  bus_remove_driver+0x6c/0x10c
> [   56.371407]  driver_unregister+0x38/0x6c
> [   56.375380]  platform_driver_unregister+0x24/0x34
> [   56.380147]  gpio_mockup_exit+0x24/0x20c [gpio_mockup]
> [   56.385356]  __arm64_sys_delete_module+0x184/0x2f0
> [   56.390211]  invoke_syscall+0x8c/0x120
> [   56.394009]  el0_svc_common.constprop.0+0x104/0x124
> [   56.398952]  do_el0_svc+0x44/0xc0
> [   56.402308]  el0_svc+0x48/0xc0
> [   56.405400]  el0t_64_sync_handler+0xbc/0x140
> [   56.409725]  el0t_64_sync+0x18c/0x190
> [   56.413435] Code: 6b01001f 54002668 a94573fb 1400003d (f9400321)
> [   56.419613] ---[ end trace 0000000000000000 ]---
> 
> 
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/5528616#L1360
> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>   git_sha: 3245cb65fd91cd514801bf91f5a3066d562f0ac4
>   git_describe: v6.0-rc5-25-g3245cb65fd91
>   kernel_version: 6.0.0-rc5
>   kernel-config: https://builds.tuxbuild.com/2EkryDJF2MJ3zNyYOYb016CJbRv/config
>   vmlinux.xz: https://builds.tuxbuild.com/2EkryDJF2MJ3zNyYOYb016CJbRv/vmlinux.xz
>   System.map: https://builds.tuxbuild.com/2EkryDJF2MJ3zNyYOYb016CJbRv/System.map
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/639865874
>   artifact-location: https://builds.tuxbuild.com/2EkryDJF2MJ3zNyYOYb016CJbRv
>   toolchain: gcc-11
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
