Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F256B2A79
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 17:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCIQL3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 11:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCIQHw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 11:07:52 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A685FA0B8
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Mar 2023 08:04:03 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id v27so2063535vsa.7
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Mar 2023 08:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678377829;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VtzxcV9+d+7ddnD0tdQHfmSE6FYbF8HS0Y5dbZjnBYE=;
        b=XGJ7pYxbIyvSknn+TCVMhtQarUpH5ScMEJFjRxN7fQvKjOTcoxz6zDAEdz07t3w32U
         0JMgmB4Q7JFgSe7aW+tc6inmAWpmoUrxTcmGIZ7EQx8cerUjuHY9cpiKgSLlxKE+Md63
         8G976/IGwpd4ZaOeoFkxkqsw3v+tbOF8EefU1CEpOUyBQqTP9qDhxsOmkOw2uQdZqtog
         RJareruckFQusEqJgkrvxaSIm+i75B74h6tRVW8mt6UkShZGo1vcRINO7AahefiQzO7Z
         ogOP4gu/kbRupq/Ce4GZ7jQxwkc68QBvDTqyQPAfRMAyEUrJGxOjfLU3d2zXm2FVvUjK
         UWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678377829;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtzxcV9+d+7ddnD0tdQHfmSE6FYbF8HS0Y5dbZjnBYE=;
        b=6L2JLbnoEDx7neRBtgN2HvJhQAegKS3MtSlocdqV4UGUFqPiVNW8YNQY9xx0ts492f
         nzyVbrR4FITXB5SISrwWBfTCITj3xTL2j81liXyqqNbvREMI4nz7pAUV/0HD7Cri+GPF
         B+Nl7cm+UmqYGcwuY1KkeOEwVCeINdOmCjzmdcyxc6UNBQfa9K2xv6SWhskyvvfiLAMY
         Bg5nRmGjzduVUpwLjrwCEvhvs9g63UydCwgjJkZQWaZwXbgnQOQX2fMkNJJuttJ/Ur7D
         v94biTvKqqgeuZ06/EozeNiNaAqx/UtHQO4fVAGLWb4ol6A8thW4mXHNllyBaxd6P0dh
         CqtA==
X-Gm-Message-State: AO0yUKU3ca7hlqp3GaMjBO4QB4AVBqgrN3Dj+0LyjrKW95OvyVdxQ4wW
        498GzNvq8HHRsN/Md0IOB/zv9SLqUk4vF0qQgIngfg4phfOV+Epl4cA=
X-Google-Smtp-Source: AK7set/VwtP920P26uvjHKICcmnsK8dWOuxBbSaNfw/SrllKnQW311Ce3K7pCAO2OZVi4xOqQ0OM92XZJB1VOgEQtQ4=
X-Received: by 2002:a67:fb19:0:b0:402:99ce:1d9c with SMTP id
 d25-20020a67fb19000000b0040299ce1d9cmr15194342vsr.1.1678377829229; Thu, 09
 Mar 2023 08:03:49 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 9 Mar 2023 21:33:29 +0530
Message-ID: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
Subject: selftests: gpio: crash on arm64
To:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following kernel warnings and crash notices on arm64 Rpi4 device while
running selftests: gpio on Linux mainline 6.3.0-rc1 kernel and Linux next.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Please refer to test log links for detailed test plan and kernel crash logs.
It is reproducible on arm64 juno-r2, Rpi4 and Qualcomm dragonboard 410c
and qemu-arm64.

Test log:
-----------
kselftest: Running tests in gpio
TAP version 13
1..2
# selftests: gpio: gpio-mockup.sh
# 1.  Module load tests
[   61.176149] =============================================================================
[   61.176802]
[   61.176807] ======================================================
[   61.176809] WARNING: possible circular locking dependency detected
[   61.176811] 6.3.0-rc1-next-20230307 #1 Not tainted
[   61.176814] ------------------------------------------------------
[   61.176816] modprobe/510 is trying to acquire lock:
[   61.176818] ffff80000b2284e8 (console_owner){..-.}-{0:0}, at:
console_flush_all (kernel/printk/printk.c:2879
kernel/printk/printk.c:2942)
[   61.176846]
[   61.176846] but task is already holding lock:
[   61.176848] ffff000040000698 (&n->list_lock){-.-.}-{2:2}, at:
get_partial_node.part.0 (mm/slub.c:2271)
[   61.176861]
[   61.176861] which lock already depends on the new lock.
[   61.176861]
[   61.176863]
[   61.176863] the existing dependency chain (in reverse order) is:
[   61.176864]
[   61.176864] -> #2 (&n->list_lock){-.-.}-{2:2}:
[   61.176871] lock_acquire (kernel/locking/lockdep.c:5673)
[   61.176879] _raw_spin_lock_irqsave
(include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[   61.176885] get_partial_node.part.0 (mm/slub.c:2271)
[   61.176890] ___slab_alloc (mm/slub.c:2268 mm/slub.c:2386 mm/slub.c:3188)
[   61.176894] __slab_alloc.constprop.0 (mm/slub.c:3292)
[   61.176899] __kmem_cache_alloc_node (mm/slub.c:3345 mm/slub.c:3442
mm/slub.c:3491)
[   61.176903] __kmalloc (mm/slab_common.c:968 mm/slab_common.c:980)
[   61.176908] tty_buffer_alloc (drivers/tty/tty_buffer.c:182)
[   61.176914] __tty_buffer_request_room (drivers/tty/tty_buffer.c:279)
[   61.176919] __tty_insert_flip_char (drivers/tty/tty_buffer.c:398)
[   61.176924] uart_insert_char (drivers/tty/serial/serial_core.c:3341)
[   61.176929] pl011_fifo_to_tty.isra.0 (drivers/tty/serial/amba-pl011.c:314)
[   61.176934] pl011_int (include/linux/spinlock.h:390
drivers/tty/serial/amba-pl011.c:1396
drivers/tty/serial/amba-pl011.c:1571)
[   61.176937] __handle_irq_event_percpu (kernel/irq/handle.c:158)
[   61.176941] handle_irq_event (kernel/irq/handle.c:193
kernel/irq/handle.c:210)
[   61.176944] handle_fasteoi_irq (kernel/irq/chip.c:716)
[   61.176950] generic_handle_domain_irq (kernel/irq/irqdesc.c:652
kernel/irq/irqdesc.c:707)
[   61.176953] gic_handle_irq (arch/arm64/include/asm/io.h:75
include/asm-generic/io.h:335 drivers/irqchip/irq-gic.c:344)
[   61.176958] call_on_irq_stack (arch/arm64/kernel/entry.S:905)
[   61.176962] do_interrupt_handler (arch/arm64/kernel/entry-common.c:274)
[   61.176968] el1_interrupt (arch/arm64/kernel/entry-common.c:472
arch/arm64/kernel/entry-common.c:486)
[   61.176971] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:492)
[   61.176975] el1h_64_irq (arch/arm64/kernel/entry.S:587)
[   61.176978] __kmem_cache_alloc_node (mm/slub.c:3490)
[   61.176983] kmalloc_trace (mm/slab_common.c:1064 (discriminator 4))
[   61.176986] inet6_dump_fib (net/ipv6/ip6_fib.c:657)
[   61.176991] rtnl_dump_all (net/core/rtnetlink.c:3964)
[   61.176997] netlink_dump (net/netlink/af_netlink.c:2296)
[   61.177004] netlink_recvmsg (net/netlink/af_netlink.c:2024)
[   61.177009] ____sys_recvmsg (net/socket.c:1015 net/socket.c:1036
net/socket.c:2723)
[   61.177014] ___sys_recvmsg (net/socket.c:2765)
[   61.177019] __sys_recvmsg (include/linux/file.h:31 net/socket.c:2797)
[   61.177025] __arm64_sys_recvmsg (net/socket.c:2802)
[   61.177030] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   61.177037] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   61.177043] do_el0_svc (arch/arm64/kernel/syscall.c:194)
[   61.177049] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   61.177052] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   61.177055] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[   61.177058]
[   61.177058] -> #1 (&port_lock_key){-.-.}-{2:2}:
[   61.177065] lock_acquire (kernel/locking/lockdep.c:5673)
[   61.177071] _raw_spin_lock_irqsave
(include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[   61.177074] serial8250_console_write
(drivers/tty/serial/8250/8250_port.c:3394)
[   61.177082] univ8250_console_write (drivers/tty/serial/8250/8250_core.c:585)
[   61.177087] console_flush_all (kernel/printk/printk.c:2888
kernel/printk/printk.c:2942)
[   61.177093] console_unlock.part.0 (kernel/printk/printk.c:3017)
[   61.177098] vprintk_emit (kernel/printk/printk.c:2317)
[   61.177104] vprintk_default (kernel/printk/printk.c:2328)
[   61.177110] vprintk (kernel/printk/printk_safe.c:50)
[   61.177116] _printk (kernel/printk/printk.c:2341)
[   61.177121] register_console (kernel/printk/printk.c:3468)
[   61.177126] uart_add_one_port
(drivers/tty/serial/serial_core.c:2579
drivers/tty/serial/serial_core.c:3100)
[   61.177130] serial8250_register_8250_port
(drivers/tty/serial/8250/8250_core.c:1093)
[   61.177135] bcm2835aux_serial_probe
(drivers/tty/serial/8250/8250_bcm2835aux.c:184)
[   61.177141] platform_probe (drivers/base/platform.c:1405)
[   61.177148] really_probe (drivers/base/dd.c:552 drivers/base/dd.c:631)
[   61.177152] __driver_probe_device (drivers/base/dd.c:768)
[   61.177157] driver_probe_device (drivers/base/dd.c:798)
[   61.177161] __driver_attach (drivers/base/dd.c:1185)
[   61.177166] bus_for_each_dev (drivers/base/bus.c:368)
[   61.177170] driver_attach (drivers/base/dd.c:1202)
[   61.177173] bus_add_driver (drivers/base/bus.c:673)
[   61.177177] driver_register (drivers/base/driver.c:246)
[   61.177182] __platform_driver_register (drivers/base/platform.c:868)
[   61.177188] bcm2835aux_serial_driver_init
(drivers/tty/serial/8250/8250_bcm2835aux.c:233)
[   61.177195] do_one_initcall (init/main.c:1306)
[   61.177199] kernel_init_freeable (init/main.c:1378 init/main.c:1395
init/main.c:1414 init/main.c:1634)
[   61.177207] kernel_init (init/main.c:1524)
[   61.177212] ret_from_fork (arch/arm64/kernel/entry.S:871)
[   61.177216]
[   61.177216] -> #0 (console_owner){..-.}-{0:0}:
[   61.177222] __lock_acquire (kernel/locking/lockdep.c:3099
kernel/locking/lockdep.c:3217 kernel/locking/lockdep.c:3832
kernel/locking/lockdep.c:5056)
[   61.177228] lock_acquire.part.0 (arch/arm64/include/asm/percpu.h:40
kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5671)
[   61.177233] lock_acquire (kernel/locking/lockdep.c:5673)
[   61.177238] console_flush_all (kernel/printk/printk.c:2883
kernel/printk/printk.c:2942)
[   61.177244] console_unlock.part.0 (kernel/printk/printk.c:3017)
[   61.177250] vprintk_emit (kernel/printk/printk.c:2317)
[   61.177255] vprintk_default (kernel/printk/printk.c:2328)
[   61.177261] vprintk (kernel/printk/printk_safe.c:50)
[   61.177267] _printk (kernel/printk/printk.c:2341)
[   61.177271] slab_bug (mm/slub.c:892)
[   61.177274] check_bytes_and_report (mm/slub.c:1054)
[   61.177279] check_object (mm/slub.c:1196 (discriminator 2))
[   61.177283] alloc_debug_processing (mm/slub.c:1415 mm/slub.c:1425)
[   61.177287] get_partial_node.part.0 (mm/slub.c:2146 mm/slub.c:2279)
[   61.177291] ___slab_alloc (mm/slub.c:2268 mm/slub.c:2386 mm/slub.c:3188)
[   61.177295] __slab_alloc.constprop.0 (mm/slub.c:3292)
[   61.177300] __kmem_cache_alloc_node (mm/slub.c:3345 mm/slub.c:3442
mm/slub.c:3491)
[   61.177304] kmalloc_trace (mm/slab_common.c:1064 (discriminator 4))
[   61.177308] device_add (drivers/base/core.c:3436 drivers/base/core.c:3486)
[   61.177311] platform_device_add (drivers/base/platform.c:717)
[   61.177317] platform_device_register_full (drivers/base/platform.c:844)
[   61.177323] gpio_mockup_register_chip+0x1ec/0x2b8 gpio_mockup
[   61.177342] gpio_mockup_init+0xf0/0xd40 gpio_mockup
[   61.177352] do_one_initcall (init/main.c:1306)
[   61.177356] do_init_module (kernel/module/main.c:2457)
[   61.177363] load_module (kernel/module/main.c:2859)
[   61.177369] __do_sys_finit_module (kernel/module/main.c:2961)
[   61.177375] __arm64_sys_finit_module (kernel/module/main.c:2928)
[   61.177381] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   61.177387] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   61.177393] do_el0_svc (arch/arm64/kernel/syscall.c:194)
[   61.177398] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   61.177402] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   61.177405] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[   61.177408]
[   61.177408] other info that might help us debug this:
[   61.177408]
[   61.177410] Chain exists of:
[   61.177410]   console_owner --> &port_lock_key --> &n->list_lock
[   61.177410]
[   61.177417]  Possible unsafe locking scenario:
[   61.177417]
[   61.177418]        CPU0                    CPU1
[   61.177419]        ----                    ----
[   61.177420]   lock(&n->list_lock);
[   61.177423]                                lock(&port_lock_key);
[   61.177426]                                lock(&n->list_lock);
[   61.177429]   lock(console_owner);
[   61.177432]
[   61.177432]  *** DEADLOCK ***
[   61.177432]
[   61.177434] 3 locks held by modprobe/510:
[   61.177436] #0: ffff000040000698 (&n->list_lock){-.-.}-{2:2}, at:
get_partial_node.part.0 (mm/slub.c:2271)
[   61.177448] #1: ffff80000b227f18 (console_lock){+.+.}-{0:0}, at:
vprintk_emit (kernel/printk/printk.c:1936 kernel/printk/printk.c:2315)
[   61.177460] #2: ffff80000b228388 (console_srcu){....}-{0:0}, at:
console_flush_all (include/linux/srcu.h:200 kernel/printk/printk.c:290
kernel/printk/printk.c:2934)
[   61.177471]
[   61.177471] stack backtrace:
[   61.177474] CPU: 3 PID: 510 Comm: modprobe Not tainted
6.3.0-rc1-next-20230307 #1
[   61.177479] Hardware name: Raspberry Pi 4 Model B (DT)
[   61.177482] Call trace:
[   61.177483] dump_backtrace (arch/arm64/kernel/stacktrace.c:160)
[   61.177487] show_stack (arch/arm64/kernel/stacktrace.c:167)
[   61.177490] dump_stack_lvl (lib/dump_stack.c:107)
[   61.177498] dump_stack (lib/dump_stack.c:114)
[   61.177504] print_circular_bug (kernel/locking/lockdep.c:2057)
[   61.177509] check_noncircular (kernel/locking/lockdep.c:2181)
[   61.177514] __lock_acquire (kernel/locking/lockdep.c:3099
kernel/locking/lockdep.c:3217 kernel/locking/lockdep.c:3832
kernel/locking/lockdep.c:5056)
[   61.177520] lock_acquire.part.0 (arch/arm64/include/asm/percpu.h:40
kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5671)
[   61.177525] lock_acquire (kernel/locking/lockdep.c:5673)
[   61.177530] console_flush_all (kernel/printk/printk.c:2883
kernel/printk/printk.c:2942)
[   61.177536] console_unlock.part.0 (kernel/printk/printk.c:3017)
[   61.177542] vprintk_emit (kernel/printk/printk.c:2317)
[   61.177547] vprintk_default (kernel/printk/printk.c:2328)
[   61.177553] vprintk (kernel/printk/printk_safe.c:50)
[   61.177559] _printk (kernel/printk/printk.c:2341)
[   61.177564] slab_bug (mm/slub.c:892)
[   61.177567] check_bytes_and_report (mm/slub.c:1054)
[   61.177571] check_object (mm/slub.c:1196 (discriminator 2))
[   61.177575] alloc_debug_processing (mm/slub.c:1415 mm/slub.c:1425)
[   61.177579] get_partial_node.part.0 (mm/slub.c:2146 mm/slub.c:2279)
[   61.177583] ___slab_alloc (mm/slub.c:2268 mm/slub.c:2386 mm/slub.c:3188)
[   61.177587] __slab_alloc.constprop.0 (mm/slub.c:3292)
[   61.177592] __kmem_cache_alloc_node (mm/slub.c:3345 mm/slub.c:3442
mm/slub.c:3491)
[   61.177596] kmalloc_trace (mm/slab_common.c:1064 (discriminator 4))
[   61.177600] device_add (drivers/base/core.c:3436 drivers/base/core.c:3486)
[   61.177603] platform_device_add (drivers/base/platform.c:717)
[   61.177609] platform_device_register_full (drivers/base/platform.c:844)
[   61.177615] gpio_mockup_register_chip+0x1ec/0x2b8 gpio_mockup
[   61.177625] gpio_mockup_init+0xf0/0xd40 gpio_mockup
[   61.177634] do_one_initcall (init/main.c:1306)
[   61.177638] do_init_module (kernel/module/main.c:2457)
[   61.177644] load_module (kernel/module/main.c:2859)
[   61.177650] __do_sys_finit_module (kernel/module/main.c:2961)
[   61.177656] __arm64_sys_finit_module (kernel/module/main.c:2928)
[   61.177662] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   61.177668] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   61.177674] do_el0_svc (arch/arm64/kernel/syscall.c:194)
[   61.177680] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   61.177683] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   61.177686] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[   62.011685] BUG kmalloc-512 (Not tainted): Poison overwritten
[   62.017513] -----------------------------------------------------------------------------
[   62.017513]
[   62.027300] 0xffff00004ecb7a38-0xffff00004ecb7a47 @offset=31288.
First byte 0x6a instead of 0x6b
[   62.036210] Allocated in swnode_register+0x40/0x218 age=808 cpu=3 pid=386
[   62.043101] __kmem_cache_alloc_node (mm/slub.c:3345 mm/slub.c:3442
mm/slub.c:3491)
[   62.047784] kmalloc_trace (mm/slab_common.c:1064 (discriminator 4))
[   62.051406] swnode_register (drivers/base/swnode.c:776)
[   62.055293] fwnode_create_software_node (drivers/base/swnode.c:934
(discriminator 4))
[   62.060238] gpio_mockup_register_chip+0x1c4/0x2b8 gpio_mockup
[   62.066337] gpio_mockup_init+0xf0/0xd40 gpio_mockup
[   62.071551] do_one_initcall (init/main.c:1306)
[   62.075437] do_init_module (kernel/module/main.c:2457)
[   62.079238] load_module (kernel/module/main.c:2859)
[   62.083037] __do_sys_finit_module (kernel/module/main.c:2961)
[   62.087455] __arm64_sys_finit_module (kernel/module/main.c:2928)
[   62.092048] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   62.095848] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   62.100793] do_el0_svc (arch/arm64/kernel/syscall.c:194)
[   62.104151] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   62.107244] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   62.111570] Freed in software_node_release+0xdc/0x108 age=632 cpu=0 pid=428
[   62.118633] __kmem_cache_free (mm/slub.c:3732 mm/slub.c:3788 mm/slub.c:3800)
[   62.122784] kfree (mm/slab_common.c:1020)
[   62.125788] software_node_release (drivers/base/swnode.c:761)
[   62.130204] kobject_put (lib/kobject.c:685 lib/kobject.c:712
include/linux/kref.h:65 lib/kobject.c:729)
[   62.133739] software_node_notify_remove (drivers/base/swnode.c:1093)
[   62.138597] device_del (drivers/base/core.c:2265 drivers/base/core.c:3778)
[   62.142134] platform_device_del.part.0 (drivers/base/platform.c:753)
[   62.146903] platform_device_unregister (drivers/base/platform.c:551
drivers/base/platform.c:794)
[   62.151672] gpio_mockup_exit+0x54/0x280 gpio_mockup
[   62.156888] __arm64_sys_delete_module (kernel/module/main.c:756
kernel/module/main.c:698 kernel/module/main.c:698)
[   62.161745] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   62.165545] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   62.170490] do_el0_svc (arch/arm64/kernel/syscall.c:194)
[   62.173850] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   62.176941] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   62.181267] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[   62.184975] Slab 0xfffffc00013b2c00 objects=21 used=7
fp=0xffff00004ecb7400
flags=0x7fffc0000010200(slab|head|node=0|zone=1|lastcpupid=0xffff)
[   62.197943] Object 0xffff00004ecb7a00 @offset=31232 fp=0xffff00004ecb7400
[   62.197943]
[   62.206325] Redzone  ffff00004ecb7800:

...

[   63.089597] CPU: 3 PID: 510 Comm: modprobe Not tainted
6.3.0-rc1-next-20230307 #1
[   63.097186] Hardware name: Raspberry Pi 4 Model B (DT)
[   63.102392] Call trace:
[   63.104865] dump_backtrace (arch/arm64/kernel/stacktrace.c:160)
[   63.108665] show_stack (arch/arm64/kernel/stacktrace.c:167)
[   63.112021] dump_stack_lvl (lib/dump_stack.c:107)
[   63.115734] dump_stack (lib/dump_stack.c:114)
[   63.119093] print_trailer (mm/slub.c:953)
[   63.122892] check_bytes_and_report (mm/slub.c:1058)
[   63.127395] check_object (mm/slub.c:1196 (discriminator 2))
[   63.131104] alloc_debug_processing (mm/slub.c:1415 mm/slub.c:1425)
[   63.135606] get_partial_node.part.0 (mm/slub.c:2146 mm/slub.c:2279)
[   63.140286] ___slab_alloc (mm/slub.c:2268 mm/slub.c:2386 mm/slub.c:3188)
[   63.144084] __slab_alloc.constprop.0 (mm/slub.c:3292)
[   63.148674] __kmem_cache_alloc_node (mm/slub.c:3345 mm/slub.c:3442
mm/slub.c:3491)
[   63.153354] kmalloc_trace (mm/slab_common.c:1064 (discriminator 4))
[   63.156974] device_add (drivers/base/core.c:3436 drivers/base/core.c:3486)
[   63.160508] platform_device_add (drivers/base/platform.c:717)
[   63.164837] platform_device_register_full (drivers/base/platform.c:844)
[   63.169959] gpio_mockup_register_chip+0x1ec/0x2b8 gpio_mockup
[   63.176057] gpio_mockup_init+0xf0/0xd40 gpio_mockup
[   63.181269] do_one_initcall (init/main.c:1306)
[   63.185155] do_init_module (kernel/module/main.c:2457)
[   63.188956] load_module (kernel/module/main.c:2859)
[   63.192755] __do_sys_finit_module (kernel/module/main.c:2961)
[   63.197171] __arm64_sys_finit_module (kernel/module/main.c:2928)
[   63.201765] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   63.205565] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:149)
[   63.210510] do_el0_svc (arch/arm64/kernel/syscall.c:194)
[   63.213869] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   63.216961] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   63.221287] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[   63.224998] FIX kmalloc-512: Restoring Poison
0xffff00004ecb7a38-0xffff00004ecb7a47=0x6b
[   63.233202] FIX kmalloc-512: Marking all objects used
[   63.399213] =============================================================================

links to the crash:
  - https://lkft.validation.linaro.org/scheduler/job/6224830#L1291
  - https://lkft.validation.linaro.org/scheduler/job/6224742#L1202
  - https://lkft.validation.linaro.org/scheduler/job/6224784#L3415
   - https://lkft.validation.linaro.org/scheduler/job/6224810#L2029

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 709c6adf19dc558e44ab5c01659b09a16a2d3c82
  git_describe: next-20230307
  kernel_version: 6.3.0-rc1
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXESbRAbSUj9oic6d8dK2d7Q8/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/798095907
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXESbRAbSUj9oic6d8dK2d7Q8
  toolchain: gcc-11



--
Linaro LKFT
https://lkft.linaro.org
