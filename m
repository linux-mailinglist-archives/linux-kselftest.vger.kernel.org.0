Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9324C1E6AFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406563AbgE1T35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406224AbgE1T3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 15:29:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEACC08C5C8
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:29:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so34838889ljm.10
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LG5hYZ7Ikts/gne6l6DOJh2FMsCsvjqkt423G7oWWfU=;
        b=AZ96DRJevzNQNryK6Ukufn6pZPy/SuVzHeMqY8Qli6MWMKckmAOf6QsL3+75Gldo0K
         4cg0GjO3J3Cj/q5gvWd6UOaiKW719c6DXSwzm0axLuA3owXVEc2SUKI0llOqe+pWOW9U
         wPy82S36L+341yoAAVM/556hxBA5pnTEIvkeEzULrm9FPsSuAGXSOC2naFacA3Em/2D2
         pO+3o3yOxf7mMr4AjwW/JuVxcBXtmU6vWZuZCa7epXWVVsVuHZ28XvKM8qR3goGwHOJK
         R+KkGj7QqY8ssR71p71LXn+S5hK9X/X0zdUmtEi5Dy7GE29a66DjaP/qKAfH8iXxn04L
         H+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LG5hYZ7Ikts/gne6l6DOJh2FMsCsvjqkt423G7oWWfU=;
        b=n1m5s3gqew3nv7n7AioYX8NvO9qGoDu5y8Zg0dTIF4xEHuwJt/x54qzvpN/vrzmWV9
         h3Xcz2LU3sjPa5LhGdP/xGQhV71c3/HgnMrFW4jYrIC7p5aa/B+OEKU7eAJBM+k7nsit
         Oe5wV4HRHHGtS2PicLZ5V5W/+qIXAkZoRNtVtU5wfYE946ESJvQ1tGY9Jq/RFkuWM1oi
         /ujFK09+8UBZXGRRYrGSYkXkaN4mtdhJdwItnjGOpErBgLv6HxCd0y173uDoGu3Zh7Zl
         lEjE9awTwmHheoU5dw6reb6rXLaNaQn9iucOdHmPUodtL+EM/anQF/nb32LMleLwNsLh
         mJTg==
X-Gm-Message-State: AOAM531lAXcagnljpUVB7dNYRllDBIydO2FZbcZgiPRBYyfM2U7Fw0wc
        Ibf61cxGKMYgzG4t/0aRyYMJ+XAv4uuljGBVU58kDA==
X-Google-Smtp-Source: ABdhPJwwVYwlL+lh5lR4ZF3/y3wdjysd6G+/gpv5a6X0IK0iMwwZn7hyMrn+divxdvxBwcivR3+k4q2uOiTQFVGQhR8=
X-Received: by 2002:a2e:574e:: with SMTP id r14mr2362068ljd.411.1590694192852;
 Thu, 28 May 2020 12:29:52 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 29 May 2020 00:59:40 +0530
Message-ID: <CA+G9fYvnJNre4G=ZsPAon_Zt+kT_QLQB_VZVhdWKYbn29xtsRA@mail.gmail.com>
Subject: BUG: arch/x86/kvm/mmu/mmu.c:3722: kvm_mmu_load+0x407/0x420
To:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     eesposit@redhat.com, lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running selftest kvm set_memory_region_test on x86_64 linux-next kernel
5.7.0-rc6-next-20200518 the kernel BUG noticed.

steps to reproduce: (always reproducible )
-------------------------
cd /opt/kselftests/default-in-kernel/kvm
./set_memory_region_test

BAD: next-20200518 (still reproducible on next-20200526)
GOOD: next-20200515
git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/777/config

kernel crash log,
-----------------------
[   33.074161] ------------[ cut here ]------------
[   33.079845] kernel BUG at /usr/src/kernel/arch/x86/kvm/mmu/mmu.c:3722!
[   33.086422] invalid opcode: 0000 [#1] SMP PTI
[   33.090792] CPU: 3 PID: 512 Comm: set_memory_regi Not tainted
5.7.0-rc7-next-20200526 #1
[   33.100253] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   33.107642] RIP: 0010:kvm_mmu_load+0x407/0x420
[   33.112086] Code: ff e9 42 fc ff ff 48 8b 0d f6 ec 99 01 e9 31 ff
ff ff 48 8b 0d ea ec 99 01 e9 ac fe ff ff 48 8b 0d de ec 99 01 e9 af
fd ff ff <0f> 0b 48 8b 0d d0 ec 99 01 eb 90 0f 1f 40 00 66 2e 0f 1f 84
00 00
[   33.130829] RSP: 0018:ffffb225803d7d20 EFLAGS: 00010293
[   33.136047] RAX: ffff936ee4fd8420 RBX: ffff936ee4fd8000 RCX: 0000000000000000
[   33.143171] RDX: 0000000000000027 RSI: ffffffffacc81b20 RDI: ffff936ee76fb9a8
[   33.150294] RBP: ffffb225803d7d50 R08: ffff936eefbb66c0 R09: ffff936eec668800
[   33.157418] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   33.164567] R13: 00000000002dc6c0 R14: ffff936ee4fd8000 R15: 0000000000000001
[   33.171710] FS:  00007fce5aed3740(0000) GS:ffff936eefb80000(0000)
knlGS:0000000000000000
[   33.179787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.185525] CR2: 0000000000fdd298 CR3: 0000000263c74004 CR4: 00000000003626e0
[   33.192682] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   33.199806] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   33.206930] Call Trace:
[   33.209377]  vcpu_enter_guest+0x10d0/0x17f0
[   33.213580]  ? kvm_load_guest_fpu.isra.131+0x4d/0x140
[   33.218632]  kvm_arch_vcpu_ioctl_run+0x12a/0x650
[   33.223250]  ? kvm_arch_vcpu_ioctl_run+0x12a/0x650
[   33.228036]  kvm_vcpu_ioctl+0x261/0x680
[   33.231872]  ? __audit_syscall_entry+0xdd/0x130
[   33.236400]  ksys_ioctl+0x98/0xb0
[   33.239715]  ? do_syscall_64+0x20/0xa0
[   33.243461]  __x64_sys_ioctl+0x1a/0x20
[   33.247212]  do_syscall_64+0x5a/0xa0
[   33.250785]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   33.255836] RIP: 0033:0x7fce5a7d18f7
[   33.259415] Code: b3 66 90 48 8b 05 a1 35 2c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 35 2c 00 f7 d8 64 89
01 48
[   33.278152] RSP: 002b:00007ffca3313c68 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   33.285708] RAX: ffffffffffffffda RBX: 0000000000fdd3e0 RCX: 00007fce5a7d18f7
[   33.292831] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
[   33.299954] RBP: 0000000000000000 R08: 0000000000409dc3 R09: 0000000000000000
[   33.307078] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000004018a0
[   33.314204] R13: 00007ffca3313e80 R14: 00007fce5aed36c0 R15: 0000000000000000
[   33.321331] Modules linked in: x86_pkg_temp_thermal fuse
[   33.326672] ---[ end trace 76d29d87896dd85b ]---
[   33.331308] RIP: 0010:kvm_mmu_load+0x407/0x420
[   33.335753] Code: ff e9 42 fc ff ff 48 8b 0d f6 ec 99 01 e9 31 ff
ff ff 48 8b 0d ea ec 99 01 e9 ac fe ff ff 48 8b 0d de ec 99 01 e9 af
fd ff ff <0f> 0b 48 8b 0d d0 ec 99 01 eb 90 0f 1f 40 00 66 2e 0f 1f 84
00 00
[   33.354497] RSP: 0018:ffffb225803d7d20 EFLAGS: 00010293
[   33.359749] RAX: ffff936ee4fd8420 RBX: ffff936ee4fd8000 RCX: 0000000000000000
[   33.366882] RDX: 0000000000000027 RSI: ffffffffacc81b20 RDI: ffff936ee76fb9a8
[   33.374015] RBP: ffffb225803d7d50 R08: ffff936eefbb66c0 R09: ffff936eec668800
[   33.381145] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   33.388278] R13: 00000000002dc6c0 R14: ffff936ee4fd8000 R15: 0000000000000001
[   33.395412] FS:  00007fce5aed3740(0000) GS:ffff936eefb80000(0000)
knlGS:0000000000000000
[   33.403496] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.409242] CR2: 0000000000fdd298 CR3: 0000000263c74004 CR4: 00000000003626e0
[   33.416374] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   33.423509] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
t_memory_region_[   33.431191] general protection fault, probably for
non-canonical address 0xdead000000000100: 0000 [#2] SMP PTI
[   33.442078] CPU: 1 PID: 512 Comm: set_memory_regi Tainted: G      D
          5.7.0-rc7-next-20200526 #1
[   33.451541] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   33.458927] RIP: 0010:__schedule+0x48b/0x830
[   33.463197] Code: 84 be fd ff ff 48 01 83 68 0c 00 00 48 83 83 60
0c 00 00 01 e9 aa fd ff ff 4d 8b bc 24 50 03 00 00 4d 85 ff 0f 84 c3
fd ff ff <49> 8b 47 10 4c 89 ff 4c 89 f6 48 8b 40 08 e8 f2 83 21 00 4d
8b 3f
[   33.481933] RSP: 0018:ffffb225803d7bf8 EFLAGS: 00010086
[   33.487151] RAX: 0000000000000000 RBX: ffff936eefaacc00 RCX: 0000000000000002
[   33.494276] RDX: 0000006500000000 RSI: 0000000000000000 RDI: ffff936ee4fd8000
[   33.501398] RBP: ffffb225803d7c50 R08: 0000000000000000 R09: 0000000000000001
[   33.508523] R10: ffffb225803d7b80 R11: 0000000000000197 R12: ffff936ee76fb100
[   33.515646] R13: ffff936eefaacc18 R14: ffff936eee1d1880 R15: dead000000000100
[   33.522771] FS:  00007fce5aed3740(0000) GS:ffff936eefa80000(0000)
knlGS:0000000000000000
[   33.530848] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.536586] CR2: 000055c5745b6280 CR3: 0000000207c10006 CR4: 00000000003626e0
[   33.543710] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   33.550832] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   33.557957] Call Trace:
[   33.560406]  preempt_schedule_common+0x15/0x30
[   33.564849]  _cond_resched+0x22/0x30
[   33.568426]  wait_for_completion+0x42/0x120
[   33.572605]  __synchronize_srcu+0xef/0x180
[   33.576704]  ? __bpf_trace_rcu_invoke_callback+0x10/0x10
[   33.582017]  synchronize_srcu+0x66/0x110
[   33.585941]  ? synchronize_srcu+0x66/0x110
[   33.590031]  kvm_page_track_unregister_notifier+0x4f/0x60
[   33.595423]  kvm_mmu_uninit_vm+0x15/0x20
[   33.599340]  kvm_arch_destroy_vm+0x1ab/0x210
[   33.603604]  kvm_put_kvm+0x1c6/0x3d0
[   33.607176]  kvm_vm_release+0x21/0x30
[   33.610840]  __fput+0x109/0x270
[   33.613979]  ____fput+0xe/0x10
[   33.617037]  task_work_run+0x6f/0xc0
[   33.620609]  do_exit+0x3ec/0xd10
[   33.623842]  rewind_stack_do_exit+0x17/0x17
[   33.628024] RIP: 0033:0x7fce5a7d18f7
[   33.631597] Code: Bad RIP value.
[   33.634821] RSP: 002b:00007ffca3313c68 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   33.642387] RAX: ffffffffffffffda RBX: 0000000000fdd3e0 RCX: 00007fce5a7d18f7
[   33.649511] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
[   33.656634] RBP: 0000000000000000 R08: 0000000000409dc3 R09: 0000000000000000
[   33.663757] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000004018a0
[   33.670882] R13: 00007ffca3313e80 R14: 00007fce5aed36c0 R15: 0000000000000000
[   33.678007] Modules linked in: x86_pkg_temp_thermal fuse
[   33.683320] ---[ end trace 76d29d87896dd85c ]---
[   33.687937] RIP: 0010:kvm_mmu_load+0x407/0x420
[   33.692373] Code: ff e9 42 fc ff ff 48 8b 0d f6 ec 99 01 e9 31 ff
ff ff 48 8b 0d ea ec 99 01 e9 ac fe ff ff 48 8b 0d de ec 99 01 e9 af
fd ff ff <0f> 0b 48 8b 0d d0 ec 99 01 eb 90 0f 1f 40 00 66 2e 0f 1f 84
00 00
[   33.711111] RSP: 0018:ffffb225803d7d20 EFLAGS: 00010293
[   33.716329] RAX: ffff936ee4fd8420 RBX: ffff936ee4fd8000 RCX: 0000000000000000
[   33.723452] RDX: 0000000000000027 RSI: ffffffffacc81b20 RDI: ffff936ee76fb9a8
[   33.730576] RBP: ffffb225803d7d50 R08: ffff936eefbb66c0 R09: ffff936eec668800
[   33.737699] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   33.744823] R13: 00000000002dc6c0 R14: ffff936ee4fd8000 R15: 0000000000000001
[   33.751948] FS:  00007fce5aed3740(0000) GS:ffff936eefa80000(0000)
knlGS:0000000000000000
[   33.760024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.765760] CR2: 00007fce5a7d18cd CR3: 0000000207c10006 CR4: 00000000003626e0
[   33.772885] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   33.780009] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   33.787132] note: set_memory_regi[512] exited with preempt_count 2
[   33.793304] Fixing recursive fault but reboot is needed!

Test job link,
https://lkft.validation.linaro.org/scheduler/job/1455528#L1230


-- 
Linaro LKFT
https://lkft.linaro.org
