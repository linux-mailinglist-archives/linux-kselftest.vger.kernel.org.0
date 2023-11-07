Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE67E3FB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 14:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjKGNJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 08:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjKGNJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 08:09:07 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13783F5
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 05:02:26 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-45d94e7759eso1719111137.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699362145; x=1699966945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0dmc2pSgoCryQuSJMykbixmz0fOnoQcfDuhNRyz/50=;
        b=Mu+fi+t/uyrXrU96snbA17q17Ona4+trejHfUbHn/sEUdnsXpGk2jrBOkXzqMPSrwt
         MMTN/LOrvws/aU+y5bYQO3IbGn0Jwf4V+hdePWunHh5Q3JL3j/sZAv6FwlvViIuL/gNn
         XnHY5K2G+ZQOfqtOqTUvJT22F6zFsbE+kAMyNtcjCDBa9MfrilUdA/TFKqyYP3+zbIL6
         UE9k191kO20TVj86JR+Sjjj/VPJ3jihMIZwfBm4EhtjQ9cRfdvXj0H7k0CY/hLHQpLRt
         wImQ4FsPX7X1YsD/TG9mxkcqIdLIri4iYouTQEwnb5PPd5NRu/fTQ+TOXUsh1MoE65Mu
         tyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362145; x=1699966945;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0dmc2pSgoCryQuSJMykbixmz0fOnoQcfDuhNRyz/50=;
        b=donald5pHghhN3cJkPL7DOOqOkVktHi47CwtsL5P6yeA4kgdPQan/CnGsUIHeINrPN
         bkIeXTjCqNXB0CK0wrbWBXVBc2p3wUNazpWgrBu4lm3nVi2lcG3uNFLjC3edoYLpOB64
         YwsDo8ZXr1HymhL9/rcd3NTcTeDz4bfernAFzfHIOquUf15tKNJ5zFTHUmYhHu72s2vM
         ctfsdpwmrED3+gcmvFrgw5kF3icmnxWCfk2vvgB8q8O553KUB6HxgmODq9diqdTL6gKj
         1x+cPLHBo2wcCelJ8RIgCdDHgcQZauTmFV+K6tls7ZFqTSC0fOZ5T4MpUBV5o0WkTwIH
         ft5g==
X-Gm-Message-State: AOJu0YyPAaB4S2nmdCc4LsEZ2XNFvRp4F3LMGaeUpsWAeqwrCzE7h9Ys
        ft8tUJkvafkl6meHa43ZqWdlWVK/09/UKQrfpTVgkA==
X-Google-Smtp-Source: AGHT+IHcQym7NUsN9eywaTV73IYbGoIKJSmtCCU0ZZ6HTXJMA9tX25be3Bq38SyLEaZuZgvXXoO7eoxbmR6F08aS1Uw=
X-Received: by 2002:a05:6102:23e2:b0:45f:8a2c:5f65 with SMTP id
 p2-20020a05610223e200b0045f8a2c5f65mr668402vsc.16.1699362145230; Tue, 07 Nov
 2023 05:02:25 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 18:32:13 +0530
Message-ID: <CA+G9fYsHX3+o+iU-7W-Z5SJCpmch5uuxhBk6CFN86G9YTrgO=Q@mail.gmail.com>
Subject: selftests: arm64: fp-stress: Unable to handle kernel paging request
 at virtual address
To:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following kernel oops noticed while running kselftests arm64 on qemu-arm64
on stable-rc linux-6.6.y branch.

I have re-built vmlinux with the same config and ran decode stackdump.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Logs:
====
# selftests: arm64: fp-stress
# TAP version 13
# 1..32
# # 2 CPUs, 5 SVE VLs, 5 SME VLs, SME2 absent
# # Will run for 10s
# # Started FPSIMD-0-0
<>
# # SVE-VL-64-0: Expected
[3904000039044000390480003904c0003904000139044001390480013904c0013904000239044002390480023904c0023904000339044003390480033904c003]
<>
# # Finishing up...
# # SSVE-VL-16-0: Terminated by signal 15, no error, iterations=50467, signals=9
# # SVE-VL-16-0: Terminated by signal 15, no error, iterations=56669, signals=9
# # FPSIMD-1-0: Terminated by signal 15, no error, iterations=20632, signals=10
# # FPSIMD-0-0: Terminated by signal 15, no error, iterations=21549, signals=9
# # SSVE-VL-16-1: Terminated by signal 15, no error, iterations=49077,
signals=10
# # ZA-VL-16-0: Terminated by signal 15, no error, iterations=24878, signals=9
# # ZA-VL-16-1: Terminated by signal 15, no error, iterations=22452, signals=10
# # SVE-VL-16-1: Terminated by signal 15, no error, iterations=49039, signals=10
# ok 1 FPSIMD-0-0
# # SVE-VL-256-<1>[   88.160313] Unable to handle kernel paging
request at virtual address 00550f0344550f02
<1>[   88.161949] Mem abort info:
<1>[   88.162574]   ESR = 0x0000000096000004
<1>[   88.163283]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   88.164330]   SET = 0, FnV = 0
<1>[   88.164930]   EA = 0, S1PTW = 0
<1>[   88.165854]   FSC = 0x04: level 0 translation fault
<1>[   88.166852] Data abort info:
<1>[   88.167463]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
<1>[   88.168566]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   88.169558]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   88.170580] [00550f0344550f02] address between user and kernel
address ranges
<0>[   88.172317] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
<4>[   88.173833] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables
<4>[   88.177601] CPU: 1 PID: 1 Comm: systemd Not tainted 6.6.1-rc1 #1
0<4>[   88.178992] Hardware name: linux,dummy-virt (DT)
<4>[   88.180334] pstate: 224000c9 (nzCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[ 88.181149] pc : percpu_ref_get_many
(include/linux/percpu-refcount.h:174 (discriminator 2)
include/linux/percpu-refcount.h:204 (discriminator 2))
<4>[ 88.182885] lr : percpu_ref_get_many
(include/linux/percpu-refcount.h:174 (discriminator 2)
include/linux/percpu-refcount.h:204 (discriminator 2))
<4>[   88.183621] sp : ffff80008000bd80
<4>[   88.184039] x29: ffff80008000bd80 x28: ffff0000c02c8000 x27:
000000000000000a
<4>[   88.185245] x26: 0000000000000000 x25: 0000000000000002 x24:
0000000000000000
<4>[   88.187718] x23: ffff0000c2306f40 x22: 0000000000000000 x21:
44550f0344550f02
<4>[   88.188696] x20: 44550f0344550f02 x19: 0000000000000001 x18:
0000000000000000
<4>[   88.189556] x17: ffff436cf77c7000 x16: ffff800080008000 x15:
0000000000000000
<4>[   88.190568] x14: 0000000000000000 x13: ffff0000c2290026 x12:
ffff80008002bcb4
<4>[   88.191589] x11: 0000000000000040 x10: ffff0000c00ea0a8 x9 :
ffffbc9405d93864
<4>[   88.192573] x8 : ffff80008000bcd8 x7 : ffff0000c09fe000 x6 :
ffff436cf77c7000
<4>[   88.193523] x5 : ffff80008000bd40 x4 : fffffffffffffef8 x3 :
0000000000000040
<4>[   88.194472] x2 : 0000000000000002 x1 : ffff0000c02c8000 x0 :
0000000000000001
<4>[   88.195706] Call trace:
<4>[ 88.196098] percpu_ref_get_many
(include/linux/percpu-refcount.h:174 (discriminator 2)
include/linux/percpu-refcount.h:204 (discriminator 2))
<4>[ 88.196815] refill_obj_stock (mm/memcontrol.c:3339 (discriminator 2))
<4>[ 88.197367] obj_cgroup_uncharge (mm/memcontrol.c:3406)
<4>[ 88.197835] kmem_cache_free (include/linux/mm.h:1630
include/linux/mm.h:1849 include/linux/mm.h:1859 mm/slab.h:208
mm/slab.h:572 mm/slub.c:3804 mm/slub.c:3831)
<4>[ 88.198407] put_pid.part.0 (kernel/pid.c:118)
<4>[ 88.198870] delayed_put_pid (kernel/pid.c:127)
<4>[ 88.200527] rcu_core (arch/arm64/include/asm/preempt.h:13
(discriminator 1) kernel/rcu/tree.c:2146 (discriminator 1)
kernel/rcu/tree.c:2403 (discriminator 1))
<4>[ 88.200978] rcu_core_si (kernel/rcu/tree.c:2421)
<4>[ 88.201972] __do_softirq (arch/arm64/include/asm/jump_label.h:21
include/linux/jump_label.h:207 include/trace/events/irq.h:142
kernel/softirq.c:554)
<4>[ 88.202587] ____do_softirq (arch/arm64/kernel/irq.c:81)
<4>[ 88.203049] call_on_irq_stack (arch/arm64/kernel/entry.S:892)
<4>[ 88.203544] do_softirq_own_stack (arch/arm64/kernel/irq.c:86)
<4>[ 88.204008] irq_exit_rcu (arch/arm64/include/asm/percpu.h:44
kernel/softirq.c:612 kernel/softirq.c:634 kernel/softirq.c:644)
<4>[ 88.204401] el1_interrupt (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/entry-common.c:246
arch/arm64/kernel/entry-common.c:505
arch/arm64/kernel/entry-common.c:517)
<4>[ 88.205751] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:523)
<4>[ 88.206672] el1h_64_irq (arch/arm64/kernel/entry.S:591)
<4>[ 88.207329] map_id_range_down (kernel/user_namespace.c:299
kernel/user_namespace.c:319)
<4>[ 88.208250] make_kuid (kernel/user_namespace.c:412)
<4>[ 88.208826] inode_init_always (include/linux/fs.h:1343
(discriminator 1) fs/inode.c:174 (discriminator 1))
<4>[ 88.209678] alloc_inode (fs/inode.c:266 (discriminator 2))
<4>[ 88.210105] new_inode (fs/inode.c:1004 fs/inode.c:1030)
<4>[ 88.210542] proc_pid_make_inode (fs/proc/base.c:1898)
<4>[ 88.210963] proc_pid_instantiate (fs/proc/base.c:1949 fs/proc/base.c:3420)
<4>[ 88.211361] proc_pid_lookup (fs/proc/base.c:3464)
<4>[ 88.211762] proc_root_lookup (fs/proc/root.c:325 (discriminator 1))
<4>[ 88.212299] __lookup_slow (fs/namei.c:1694)
<4>[ 88.212739] walk_component (fs/namei.c:1711 fs/namei.c:2002)
<4>[ 88.213244] link_path_walk.part.0.constprop.0 (fs/namei.c:2331
(discriminator 1))
<4>[ 88.213803] path_openat (fs/namei.c:2254 (discriminator 1)
fs/namei.c:3793 (discriminator 1))
<4>[ 88.214264] do_filp_open (fs/namei.c:3824)
<4>[ 88.214550] do_sys_openat2 (fs/open.c:1422)
<4>[ 88.215080] __arm64_sys_openat (fs/open.c:1448)
<4>[ 88.215495] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:56)
<4>[ 88.215986] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:144 (discriminator 2))
<4>[ 88.216476] do_el0_svc (arch/arm64/kernel/syscall.c:156)
<4>[ 88.216910] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
<4>[ 88.217246] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
<4>[ 88.217766] el0t_64_sync (arch/arm64/kernel/entry.S:595)
<0>[ 88.218477] Code: a90153f3 aa0003f4 aa0103f3 97f6f396 (f9400280)
All code
========
   0:* f3 53                repz push %rbx <-- trapping instruction
   2: 01 a9 f4 03 00 aa    add    %ebp,-0x55fffc0c(%rcx)
   8: f3 03 01              repz add (%rcx),%eax
   b: aa                    stos   %al,%es:(%rdi)
   c: 96                    xchg   %eax,%esi
   d: f3 f6 97 80 02 40 f9 repz notb -0x6bffd80(%rdi)

Code starting with the faulting instruction
===========================================
   0: 80 02 40              addb   $0x40,(%rdx)
   3: f9                    stc
<4>[   88.219947] ---[ end trace 0000000000000000 ]---
<0>[   88.220779] Kernel panic - not syncing: Oops: Fatal exception in interrupt
<2>[   88.221715] SMP: stopping secondary CPUs
<0>[   88.226328] Kernel Offset: 0x3c9385a00000 from 0xffff800080000000
<0>[   88.226953] PHYS_OFFSET: 0x40000000
<0>[   88.227382] CPU features: 0x0,00000000,d1e2cf43,99e6773f
<0>[   88.228141] Memory Limit: none
<0>[   88.228905] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---

Links:
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6-31-gac6cb619d608/testrun/20963487/suite/log-parser-test/tests/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6-31-gac6cb619d608/testrun/20963487/suite/log-parser-test/test/check-kernel-oops/log
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2XntnCQFUyH9ZTp4CynoCSijCrR

Re-built image:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/builds/2XqQotMV6TQIaH5zimuvMiXxA64

--
Linaro LKFT
https://lkft.linaro.org
