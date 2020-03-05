Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4117AED8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 20:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCETSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 14:18:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46455 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgCETSi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 14:18:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id y30so3188033pga.13;
        Thu, 05 Mar 2020 11:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuDWzMxqB/bf/yuBzy9nEakWcvTUMsx1qZ8c6TKyRek=;
        b=sMwKGlpcTsJb5gJKksCX+C1R8l0/BzO3WCZVhtsCBpGz7ujfPWSIJC/NXhob0+9/kh
         jr1HELX7Cev0KHSaU6XTeqvsLotV4NrqsQtBrSC6iZk8TTL0LipmrDELW1ELqC6Qf8X6
         lrgiqcpZ/5UGpmxoMcDbH6kD0FIHd3Tz0ZBF/b87/k661yIzj2LfERUJ04kyN9yHaogE
         /whnCWPAOFLErtJYJPo8SsFkhhklEPaWQCAQeItYB0QPF51F0qxxdIxwWVle2bPkx0ll
         reo5/QpB+dg7+uUllJf/HT2XRQjybywrN4ygIcpj3njNaFYQvcu0EyS44LFMduoCESkA
         csmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuDWzMxqB/bf/yuBzy9nEakWcvTUMsx1qZ8c6TKyRek=;
        b=UYtaT+UOc+jZ0WsdYc+ztFLy/PHG/4RpIzPX9GpYsMZllJLMS+nUMO8uVtema/gVLs
         J+bbMaRHF0oRPX6BNJuoMURFa0sD00KTrN0tJbL/AptQh6x4+gxRRiOm2hogbeSWeumO
         7WqTNnBN6r+cTxPSHb2rtwgsO0m9hetMHoORx5M5fKNdBht92cdA+SUr2d4fc+BltGnS
         rZQ/838b/64/YH/Bi+xzT12KeqdwJJAriYw2ygWl2hwHkgP1J3HOCrD6J5q8OHGcJshm
         YZ8W8eYAQfwlRQKNyKo5NpN/LQ0xxdc2X23kTaqqBfHpkKlwqzIUEsf3O2tfyYXkn6A5
         6xZg==
X-Gm-Message-State: ANhLgQ128WoDPlBjapVPzlmcPqSPwiC5nkP7BXmjlfzmSTPn2xaQ19t5
        zrS+/YgDyW9Qy8B1MvqWvsl1b3N8fbM7ucIpIEo=
X-Google-Smtp-Source: ADFU+vsAy6TjyoKGyVrtJMDe8PnU/6D2yqSZuMpRfLQ+tsk5lf/OE79mNROf9oCt8N32L0jC2PgbPmzLH49BB2kqi4E=
X-Received: by 2002:a63:5859:: with SMTP id i25mr8775122pgm.74.1583435916106;
 Thu, 05 Mar 2020 11:18:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvRZ9eCE29FjXkv1dQfrdGO3uWp4Tvkip5Z_jsgjVJeAQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvRZ9eCE29FjXkv1dQfrdGO3uWp4Tvkip5Z_jsgjVJeAQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Mar 2020 21:18:25 +0200
Message-ID: <CAHp75VfhKoLtWkLHUyzg6m=rx833qiCVimWJVKU13qrX+aJz-Q@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00 - ida_free+0x76/0x140
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Cc: Sakari

On Thu, Mar 5, 2020 at 6:00 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Regression reported on Linux next 5.6.0-rc4-next-20200305 on x86_64,
> i386, arm and arm64. The steps to reproduce is running kselftests lib
> printf.sh test case.
> Which is doing modprobe operations.
>
> BTW, there are few RCU warnings from the boot log.
> Please refer below link for more details.
>
> Steps reproduce by using kselftests,
>
>           - lsmod || true
>           - cd /opt/kselftests/default-in-kernel/lib/
>           - export PATH=/opt/kselftests/default-in-kernel/kselftest:$PATH
>           - ./printf.sh || true
>           - ./bitmap.sh || true
>           - ./prime_numbers.sh || true
>           - ./strscpy.sh || true
>
> x86_64 kernel BUG dump.
> + ./printf.sh
> [   32.594369] test_printf: loaded.
> [   32.599859] BUG: kernel NULL pointer dereference, address: 00000000
> [   32.606143] #PF: supervisor read access in kernel mode
> [   32.611280] #PF: error_code(0x0000) - not-present page
> [   32.616419] *pde = 00000000
> [   32.619306] Oops: 0000 [#1] SMP
> [   32.622452] CPU: 0 PID: 387 Comm: modprobe Not tainted
> 5.6.0-rc4-next-20200305 #1
> [   32.629928] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [   32.637314] EIP: ida_free+0x61/0x130
> [   32.640891] Code: 00 c7 45 e8 00 00 00 00 c7 45 ec 00 00 00 00 0f
> 88 c4 00 00 00 89 d3 e8 9d ee 01 00 89 c7 8d 45 d8 e8 e3 18 01 00 a8
> 01 75 3f <0f> a3 30 72 72 8b 45 d8 89 fa e8 70 f0 01 00 53 68 d8 61 01
> d3 e8
> [   32.659628] EAX: 00000000 EBX: 00000000 ECX: ffffffff EDX: 00000000
> [   32.665887] ESI: 00000000 EDI: 00000246 EBP: f21a7cc8 ESP: f21a7c9c
> [   32.672153] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010046
> [   32.678928] CR0: 80050033 CR2: 00000000 CR3: 32ff3000 CR4: 003406d0
> [   32.685186] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   32.691442] DR6: fffe0ff0 DR7: 00000400
> [   32.695273] Call Trace:
> [   32.697721]  software_node_release+0x21/0x80
> [   32.701990]  kobject_put+0xa8/0x1c0
> [   32.705476]  kobject_del+0x40/0x60
> [   32.708881]  kobject_put+0x92/0x1c0
> [   32.712380]  fwnode_remove_software_node+0x30/0x50
> [   32.717201]  software_node_unregister_nodes+0x2b/0x50
> [   32.722246]  test_printf_init+0xe00/0x1d29 [test_printf]
> [   32.727563]  ? find_held_lock+0x27/0xa0
> [   32.731423]  ? test_hashed+0x54/0x54 [test_printf]
> [   32.736207]  ? test_hashed+0x54/0x54 [test_printf]
> [   32.741001]  do_one_initcall+0x54/0x2e0
> [   32.744841]  ? rcu_read_lock_sched_held+0x47/0x70
> [   32.749547]  ? kmem_cache_alloc_trace+0x285/0x2b0
> [   32.754249]  ? do_init_module+0x21/0x1ef
> [   32.758166]  ? do_init_module+0x21/0x1ef
> [   32.762087]  do_init_module+0x50/0x1ef
> [   32.765837]  load_module+0x1e32/0x2540
> [   32.769586]  ? kernel_read_file+0x295/0x2d0
> [   32.773771]  sys_finit_module+0x8a/0xe0
> [   32.777611]  do_fast_syscall_32+0x8e/0x340
> [   32.781709]  entry_SYSENTER_32+0xaa/0x102
> [   32.785719] EIP: 0xb7f75ce1
> [   32.788508] Code: 5e 5d c3 8d b6 00 00 00 00 b8 40 42 0f 00 eb c1
> 8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 8b 3c 24 c3 90 51 52 55 89 e5 0f
> 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
> 8d 76
> [   32.807246] EAX: ffffffda EBX: 00000003 ECX: 0806233a EDX: 00000000
> [   32.813502] ESI: 085fb600 EDI: 085fb550 EBP: 085fb6e0 ESP: bffe839c
> [   32.819760] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
> [   32.826542] Modules linked in: test_printf(+) x86_pkg_temp_thermal fuse
> [   32.833150] CR2: 0000000000000000
> [   32.836461] ---[ end trace 69388c972b4562b8 ]---
> [   32.841072] EIP: ida_free+0x61/0x130
> [   32.844642] Code: 00 c7 45 e8 00 00 00 00 c7 45 ec 00 00 00 00 0f
> 88 c4 00 00 00 89 d3 e8 9d ee 01 00 89 c7 8d 45 d8 e8 e3 18 01 00 a8
> 01 75 3f <0f> a3 30 72 72 8b 45 d8 89 fa e8 70 f0 01 00 53 68 d8 61 01
> d3 e8
> [   32.863420] EAX: 00000000 EBX: 00000000 ECX: ffffffff EDX: 00000000
> [   32.869679] ESI: 00000000 EDI: 00000246 EBP: f21a7cc8 ESP: f21a7c9c
> [   32.875936] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010046
> [   32.882713] CR0: 80050033 CR2: 00000000 CR3: 32ff3000 CR4: 003406d0
> [   32.888970] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   32.895227] DR6: fffe0ff0 DR7: 00000400
> [   32.899060] BUG: sleeping function called from invalid context at
> /usr/src/kernel/include/linux/percpu-rwsem.h:49
> [   32.909303] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
> 387, name: modprobe
> [   32.917207] INFO: lockdep is turned off.
> [   32.921124] irq event stamp: 5120
> [   32.924434] hardirqs last  enabled at (5119): [<d20dea05>] kfree+0x135/0x270
> [   32.931472] hardirqs last disabled at (5120): [<d2b9ab04>]
> _raw_spin_lock_irqsave+0x14/0x40
> [   32.939809] softirqs last  enabled at (4978): [<d2b9f165>]
> __do_softirq+0x2c5/0x3c3
> [   32.947454] softirqs last disabled at (4969): [<d1ea67d5>]
> call_on_stack+0x45/0x50
> [   32.955009] CPU: 0 PID: 387 Comm: modprobe Tainted: G      D
>    5.6.0-rc4-next-20200305 #1
> [   32.963867] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [   32.971250] Call Trace:
> [   32.973695]  dump_stack+0x6e/0x96
> [   32.977009]  ___might_sleep+0x14d/0x240
> [   32.980846]  __might_sleep+0x33/0x80
> [   32.984419]  exit_signals+0x2a/0x2d0
> [   32.987997]  do_exit+0x8e/0xb00
> [   32.991143]  ? do_fast_syscall_32+0x8e/0x340
> [   32.995421]  rewind_stack_do_exit+0x11/0x13
> [   32.999600] EIP: 0xb7f75ce1
> [   33.002416] Code: 5e 5d c3 8d b6 00 00 00 00 b8 40 42 0f 00 eb c1
> 8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 8b 3c 24 c3 90 51 52 55 89 e5 0f
> 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
> 8d 76
> [   33.021153] EAX: ffffffda EBX: 00000003 ECX: 0806233a EDX: 00000000
> [   33.027425] ESI: 085fb600 EDI: 085fb550 EBP: 085fb6e0 ESP: bffe839c
> [   33.033685] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
> [   33.040465] note: modprobe[387] exited with preempt_count 1
> ./../kselftest/module.sh: line 56:   387 Killed
> $modprobe -q $module $args
> printf:  [FAIL]
>
>
> metadata:
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git branch: master
>   git describe: next-20200305
>   kernel-config:
> http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/719/config
>
> ref:
> https://lkft.validation.linaro.org/scheduler/job/1267112#L1254
> https://lkft.validation.linaro.org/scheduler/job/1267041#L9795
>
> --
> Linaro LKFT
> https://lkft.linaro.org



-- 
With Best Regards,
Andy Shevchenko
