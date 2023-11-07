Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20E7E4015
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjKGNab (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 08:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjKGNaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 08:30:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FA0E8F;
        Tue,  7 Nov 2023 05:30:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A125B13D5;
        Tue,  7 Nov 2023 05:31:10 -0800 (PST)
Received: from arm.com (RQ4T19M611.cambridge.arm.com [10.1.33.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A05B3F6C4;
        Tue,  7 Nov 2023 05:30:24 -0800 (PST)
Date:   Tue, 7 Nov 2023 13:30:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: arm64: fp-stress: Unable to handle kernel paging
 request at virtual address
Message-ID: <ZUo77jSVA1jWbps1@arm.com>
References: <CA+G9fYsHX3+o+iU-7W-Z5SJCpmch5uuxhBk6CFN86G9YTrgO=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsHX3+o+iU-7W-Z5SJCpmch5uuxhBk6CFN86G9YTrgO=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 07, 2023 at 06:32:13PM +0530, Naresh Kamboju wrote:
> # <1>[   88.160313] Unable to handle kernel paging
> request at virtual address 00550f0344550f02

It would really help if the kernel dump was not wrapped. Just use git
send-email to post to the list if your email client wraps the log. I'll
try to unwrap some of this below:

> <1>[   88.161949] Mem abort info:
> <1>[   88.162574]   ESR = 0x0000000096000004
> <1>[   88.163283]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[   88.164330]   SET = 0, FnV = 0
> <1>[   88.164930]   EA = 0, S1PTW = 0
> <1>[   88.165854]   FSC = 0x04: level 0 translation fault
> <1>[   88.166852] Data abort info:
> <1>[   88.167463]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> <1>[   88.168566]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> <1>[   88.169558]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> <1>[   88.170580] [00550f0344550f02] address between user and kernel address ranges
> <0>[   88.172317] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> <4>[   88.173833] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables
> <4>[   88.177601] CPU: 1 PID: 1 Comm: systemd Not tainted 6.6.1-rc1 #1
> <4>[   88.178992] Hardware name: linux,dummy-virt (DT)
> <4>[   88.180334] pstate: 224000c9 (nzCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> <4>[ 88.181149] pc : percpu_ref_get_many (include/linux/percpu-refcount.h:174 (discriminator 2) include/linux/percpu-refcount.h:204 (discriminator 2))
> <4>[ 88.182885] lr : percpu_ref_get_many (include/linux/percpu-refcount.h:174 (discriminator 2) include/linux/percpu-refcount.h:204 (discriminator 2))
> <4>[   88.183621] sp : ffff80008000bd80
> <4>[   88.184039] x29: ffff80008000bd80 x28: ffff0000c02c8000 x27: 000000000000000a
> <4>[   88.185245] x26: 0000000000000000 x25: 0000000000000002 x24: 0000000000000000
> <4>[   88.187718] x23: ffff0000c2306f40 x22: 0000000000000000 x21: 44550f0344550f02
> <4>[   88.188696] x20: 44550f0344550f02 x19: 0000000000000001 x18: 0000000000000000
> <4>[   88.189556] x17: ffff436cf77c7000 x16: ffff800080008000 x15: 0000000000000000
> <4>[   88.190568] x14: 0000000000000000 x13: ffff0000c2290026 x12: ffff80008002bcb4
> <4>[   88.191589] x11: 0000000000000040 x10: ffff0000c00ea0a8 x9 : ffffbc9405d93864
> <4>[   88.192573] x8 : ffff80008000bcd8 x7 : ffff0000c09fe000 x6 : ffff436cf77c7000
> <4>[   88.193523] x5 : ffff80008000bd40 x4 : fffffffffffffef8 x3 : 0000000000000040
> <4>[   88.194472] x2 : 0000000000000002 x1 : ffff0000c02c8000 x0 : 0000000000000001
> <4>[   88.195706] Call trace:
> <4>[ 88.196098] percpu_ref_get_many (include/linux/percpu-refcount.h:174 (discriminator 2) include/linux/percpu-refcount.h:204 (discriminator 2))
> <4>[ 88.196815] refill_obj_stock (mm/memcontrol.c:3339 (discriminator 2))
> <4>[ 88.197367] obj_cgroup_uncharge (mm/memcontrol.c:3406)
> <4>[ 88.197835] kmem_cache_free (include/linux/mm.h:1630 include/linux/mm.h:1849 include/linux/mm.h:1859 mm/slab.h:208 mm/slab.h:572 mm/slub.c:3804 mm/slub.c:3831)
> <4>[ 88.198407] put_pid.part.0 (kernel/pid.c:118)
> <4>[ 88.198870] delayed_put_pid (kernel/pid.c:127)
> <4>[ 88.200527] rcu_core (arch/arm64/include/asm/preempt.h:13 (discriminator 1) kernel/rcu/tree.c:2146 (discriminator 1) kernel/rcu/tree.c:2403 (discriminator 1))
> <4>[ 88.200978] rcu_core_si (kernel/rcu/tree.c:2421)
> <4>[ 88.201972] __do_softirq (arch/arm64/include/asm/jump_label.h:21 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554)
> <4>[ 88.202587] ____do_softirq (arch/arm64/kernel/irq.c:81)
> <4>[ 88.203049] call_on_irq_stack (arch/arm64/kernel/entry.S:892)
> <4>[ 88.203544] do_softirq_own_stack (arch/arm64/kernel/irq.c:86)
> <4>[ 88.204008] irq_exit_rcu (arch/arm64/include/asm/percpu.h:44 kernel/softirq.c:612 kernel/softirq.c:634 kernel/softirq.c:644)
> <4>[ 88.204401] el1_interrupt (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/entry-common.c:246 arch/arm64/kernel/entry-common.c:505 arch/arm64/kernel/entry-common.c:517)
> <4>[ 88.205751] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:523)
> <4>[ 88.206672] el1h_64_irq (arch/arm64/kernel/entry.S:591)
> <4>[ 88.207329] map_id_range_down (kernel/user_namespace.c:299 kernel/user_namespace.c:319)
> <4>[ 88.208250] make_kuid (kernel/user_namespace.c:412)
> <4>[ 88.208826] inode_init_always (include/linux/fs.h:1343 (discriminator 1) fs/inode.c:174 (discriminator 1))
> <4>[ 88.209678] alloc_inode (fs/inode.c:266 (discriminator 2))
> <4>[ 88.210105] new_inode (fs/inode.c:1004 fs/inode.c:1030)
> <4>[ 88.210542] proc_pid_make_inode (fs/proc/base.c:1898)
> <4>[ 88.210963] proc_pid_instantiate (fs/proc/base.c:1949 fs/proc/base.c:3420)
> <4>[ 88.211361] proc_pid_lookup (fs/proc/base.c:3464)
> <4>[ 88.211762] proc_root_lookup (fs/proc/root.c:325 (discriminator 1))
> <4>[ 88.212299] __lookup_slow (fs/namei.c:1694)
> <4>[ 88.212739] walk_component (fs/namei.c:1711 fs/namei.c:2002)
> <4>[ 88.213244] link_path_walk.part.0.constprop.0 (fs/namei.c:2331 (discriminator 1)) <4>[ 88.213803] path_openat (fs/namei.c:2254 (discriminator 1) fs/namei.c:3793 (discriminator 1))
> <4>[ 88.214264] do_filp_open (fs/namei.c:3824)
> <4>[ 88.214550] do_sys_openat2 (fs/open.c:1422)
> <4>[ 88.215080] __arm64_sys_openat (fs/open.c:1448)
> <4>[ 88.215495] invoke_syscall (arch/arm64/include/asm/current.h:19 arch/arm64/kernel/syscall.c:56)
> <4>[ 88.215986] el0_svc_common.constprop.0 (include/linux/thread_info.h:127 (discriminator 2) arch/arm64/kernel/syscall.c:144 (discriminator 2))
> <4>[ 88.216476] do_el0_svc (arch/arm64/kernel/syscall.c:156)
> <4>[ 88.216910] el0_svc (arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:679)
> <4>[ 88.217246] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
> <4>[ 88.217766] el0t_64_sync (arch/arm64/kernel/entry.S:595)
> <0>[ 88.218477] Code: a90153f3 aa0003f4 aa0103f3 97f6f396 (f9400280)
> All code
> ========
>    0:* f3 53                repz push %rbx <-- trapping instruction
>    2: 01 a9 f4 03 00 aa    add    %ebp,-0x55fffc0c(%rcx)
>    8: f3 03 01              repz add (%rcx),%eax
>    b: aa                    stos   %al,%es:(%rdi)
>    c: 96                    xchg   %eax,%esi
>    d: f3 f6 97 80 02 40 f9 repz notb -0x6bffd80(%rdi)
> 
> Code starting with the faulting instruction
> ===========================================
>    0: 80 02 40              addb   $0x40,(%rdx)
>    3: f9                    stc

That's x86. The arm64 version:

All code
========
   0:	a90153f3 	stp	x19, x20, [sp, #16]
   4:	aa0003f4 	mov	x20, x0
   8:	aa0103f3 	mov	x19, x1
   c:	97f6f396 	bl	0xffffffffffdbce64
  10:*	f9400280 	ldr	x0, [x20]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	f9400280 	ldr	x0, [x20]

> <4>[   88.219947] ---[ end trace 0000000000000000 ]---
> <0>[   88.220779] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> <2>[   88.221715] SMP: stopping secondary CPUs
> <0>[   88.226328] Kernel Offset: 0x3c9385a00000 from 0xffff800080000000
> <0>[   88.226953] PHYS_OFFSET: 0x40000000
> <0>[   88.227382] CPU features: 0x0,00000000,d1e2cf43,99e6773f
> <0>[   88.228141] Memory Limit: none
> <0>[   88.228905] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

I haven't looked into what potentially caused this yet. Does it happen
with mainline as well or just 6.6 stable?

-- 
Catalin
