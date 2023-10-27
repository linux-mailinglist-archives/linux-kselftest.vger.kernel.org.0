Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57C7DA138
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjJ0TUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0TUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 15:20:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD89812A;
        Fri, 27 Oct 2023 12:20:19 -0700 (PDT)
Received: from DESKTOP-4OLSCEK. (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id CFFA720B74C0;
        Fri, 27 Oct 2023 12:20:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFFA720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698434419;
        bh=51MbCZDx+/uvMJ238k4HMXKwd1iNXyw0KT3PTGJGFZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jb0ES6p7Bx9t04ROhWNumf4ddWPxyF+NGZ2c5bk7MbP8DaNi0DNVWP0+KjKKyW0Hw
         fhI1B9hRn0VWzTmtLtjzRT4SNJFtBZRtgIjQYKNQGhlig/6UKpKigstysZ08QRzljj
         AgzSPXxORSfBbdoCDsL89jiFIQzGo84pCVd/7ciQ=
Date:   Fri, 27 Oct 2023 12:20:11 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Brown <broonie@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: selftests: user_events: ftrace_test - RIP:
 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
Message-ID: <20231027192011.GA436-beaub@linux.microsoft.com>
References: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023 at 05:38:41PM +0530, Naresh Kamboju wrote:
> Following kernel crash noticed on x86_64 while running selftests: user_events:
> ftrace_test running 6.6.0-rc7-next-20231026.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> kselftest: Running tests in user_events
> TAP version 13
> 1..4
> # timeout set to 90
> # selftests: user_events: ftrace_test
> [ 2391.606817] general protection fault, probably for non-canonical
> address 0x6b6b6b6b6b6b8a83: 0000 [#1] PREEMPT SMP PTI
> [ 2391.617519] CPU: 1 PID: 34662 Comm: ftrace_test Not tainted
> 6.6.0-rc7-next-20231026 #1
> [ 2391.625428] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.7 12/07/2021
> [ 2391.632811] RIP: 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
> [ 2391.637952] Code: 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
> 55 31 f6 48 89 e5 41 55 41 54 53 48 89 fb 48 c7 c7 40 8c 61 94 e8 92
> d3 5a 01 <44> 0f b6 a3 18 1f 00 00 41 80 fc 01 0f 87 c8 dc 4e 01 45 31
> ed 41
> All code
> ========
>    0: 90                    nop
>    1: 90                    nop
>    2: 90                    nop
>    3: 90                    nop
>    4: 90                    nop
>    5: 90                    nop
>    6: 90                    nop
>    7: 90                    nop
>    8: 90                    nop
>    9: 90                    nop
>    a: 90                    nop
>    b: 90                    nop
>    c: 66 0f 1f 00          nopw   (%rax)
>   10: 55                    push   %rbp
>   11: 31 f6                xor    %esi,%esi
>   13: 48 89 e5              mov    %rsp,%rbp
>   16: 41 55                push   %r13
>   18: 41 54                push   %r12
>   1a: 53                    push   %rbx
>   1b: 48 89 fb              mov    %rdi,%rbx
>   1e: 48 c7 c7 40 8c 61 94 mov    $0xffffffff94618c40,%rdi
>   25: e8 92 d3 5a 01        callq  0x15ad3bc
>   2a:* 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d <-- trapping instruction
>   31: 00
>   32: 41 80 fc 01          cmp    $0x1,%r12b
>   36: 0f 87 c8 dc 4e 01    ja     0x14edd04
>   3c: 45 31 ed              xor    %r13d,%r13d
>   3f: 41                    rex.B
> 
> Code starting with the faulting instruction
> ===========================================
>    0: 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d
>    7: 00
>    8: 41 80 fc 01          cmp    $0x1,%r12b
>    c: 0f 87 c8 dc 4e 01    ja     0x14edcda
>   12: 45 31 ed              xor    %r13d,%r13d
>   15: 41                    rex.B
> [ 2391.656696] RSP: 0018:ffffb36e0a477d80 EFLAGS: 00010246
> [ 2391.661937] RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000080000000
> [ 2391.669064] RDX: 0000000000000000 RSI: ffffffff9299b722 RDI: ffffffff9299b722
> [ 2391.676195] RBP: ffffb36e0a477d98 R08: 000000000000002f R09: 0000000000000002
> [ 2391.683321] R10: ffffb36e0a477d70 R11: 0000000000000000 R12: 0000000000000002
> [ 2391.690453] R13: ffffb36e0a477e88 R14: ffff99c5803a2230 R15: ffff99c581c39000
> [ 2391.697586] FS:  00007fb4b9681740(0000) GS:ffff99c6efa80000(0000)
> knlGS:0000000000000000
> [ 2391.705670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2391.711410] CR2: 00007fb4b96ab5e0 CR3: 000000010635c002 CR4: 00000000003706f0
> [ 2391.718540] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2391.725665] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2391.732797] Call Trace:
> [ 2391.735240]  <TASK>
> [ 2391.737339] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [ 2391.740744] ? die_addr (arch/x86/kernel/dumpstack.c:421
> arch/x86/kernel/dumpstack.c:460)
> [ 2391.744056] ? exc_general_protection (arch/x86/kernel/traps.c:697
> arch/x86/kernel/traps.c:642)
> [ 2391.748766] ? asm_exc_general_protection
> (arch/x86/include/asm/idtentry.h:564)
> [ 2391.753652] ? __mutex_lock (kernel/locking/mutex.c:613
> (discriminator 3) kernel/locking/mutex.c:747 (discriminator 3))
> [ 2391.757487] ? __mutex_lock (kernel/locking/mutex.c:613
> (discriminator 3) kernel/locking/mutex.c:747 (discriminator 3))
> [ 2391.761318] ? tracing_update_buffers (kernel/trace/trace.c:6470)
> [ 2391.765851] event_enable_write (kernel/trace/trace_events.c:1408)
> [ 2391.769976] vfs_write (fs/read_write.c:582)
> [ 2391.773296] ? close_fd_get_file (fs/file.c:821)
> [ 2391.777396] ? preempt_count_sub (kernel/sched/core.c:5857
> kernel/sched/core.c:5853 kernel/sched/core.c:5875)
> [ 2391.781496] ksys_write (fs/read_write.c:638)
> [ 2391.784918] __x64_sys_write (fs/read_write.c:646)
> [ 2391.788671] do_syscall_64 (arch/x86/entry/common.c:51
> arch/x86/entry/common.c:82)
> [ 2391.792248] ? do_syscall_64 (arch/x86/entry/common.c:101)
> [ 2391.795995] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)
> [ 2391.800785] ? do_syscall_64 (arch/x86/entry/common.c:101)
> [ 2391.804529] ? do_syscall_64 (arch/x86/entry/common.c:101)
> [ 2391.808275] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 2391.813327] RIP: 0033:0x7fb4b977c140
> [ 2391.816920] Code: 40 00 48 8b 15 c1 9c 0d 00 f7 d8 64 89 02 48 c7
> c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 24 0e 00 00 74 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28
> 48 89
> All code
> ========
>    0: 40 00 48 8b          add    %cl,-0x75(%rax)
>    4: 15 c1 9c 0d 00        adc    $0xd9cc1,%eax
>    9: f7 d8                neg    %eax
>    b: 64 89 02              mov    %eax,%fs:(%rdx)
>    e: 48 c7 c0 ff ff ff ff mov    $0xffffffffffffffff,%rax
>   15: eb b7                jmp    0xffffffffffffffce
>   17: 0f 1f 00              nopl   (%rax)
>   1a: 80 3d a1 24 0e 00 00 cmpb   $0x0,0xe24a1(%rip)        # 0xe24c2
>   21: 74 17                je     0x3a
>   23: b8 01 00 00 00        mov    $0x1,%eax
>   28: 0f 05                syscall
>   2a:* 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax <--
> trapping instruction
>   30: 77 58                ja     0x8a
>   32: c3                    retq
>   33: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
>   3a: 48 83 ec 28          sub    $0x28,%rsp
>   3e: 48                    rex.W
>   3f: 89                    .byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
>    6: 77 58                ja     0x60
>    8: c3                    retq
>    9: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
>   10: 48 83 ec 28          sub    $0x28,%rsp
>   14: 48                    rex.W
>   15: 89                    .byte 0x89
> [ 2391.835660] RSP: 002b:00007ffc43b05b38 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [ 2391.843225] RAX: ffffffffffffffda RBX: 00007ffc43b05d88 RCX: 00007fb4b977c140
> [ 2391.850350] RDX: 0000000000000002 RSI: 000056376b59b7d4 RDI: 0000000000000007
> [ 2391.857482] RBP: 00007ffc43b05b60 R08: 0000000000000000 R09: 00007fb4b9681740
> [ 2391.864615] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [ 2391.871747] R13: 00007ffc43b05d98 R14: 000056376b59ddc8 R15: 00007fb4b9981020
> [ 2391.878907]  </TASK>
> [ 2391.881106] Modules linked in: x86_pkg_temp_thermal fuse configfs
> [ 2391.887288] ---[ end trace 0000000000000000 ]---
> [ 2391.891915] RIP: 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
> [ 2391.897231] Code: 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
> 55 31 f6 48 89 e5 41 55 41 54 53 48 89 fb 48 c7 c7 40 8c 61 94 e8 92
> d3 5a 01 <44> 0f b6 a3 18 1f 00 00 41 80 fc 01 0f 87 c8 dc 4e 01 45 31
> ed 41
> All code
> ========
>    0: 90                    nop
>    1: 90                    nop
>    2: 90                    nop
>    3: 90                    nop
>    4: 90                    nop
>    5: 90                    nop
>    6: 90                    nop
>    7: 90                    nop
>    8: 90                    nop
>    9: 90                    nop
>    a: 90                    nop
>    b: 90                    nop
>    c: 66 0f 1f 00          nopw   (%rax)
>   10: 55                    push   %rbp
>   11: 31 f6                xor    %esi,%esi
>   13: 48 89 e5              mov    %rsp,%rbp
>   16: 41 55                push   %r13
>   18: 41 54                push   %r12
>   1a: 53                    push   %rbx
>   1b: 48 89 fb              mov    %rdi,%rbx
>   1e: 48 c7 c7 40 8c 61 94 mov    $0xffffffff94618c40,%rdi
>   25: e8 92 d3 5a 01        callq  0x15ad3bc
>   2a:* 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d <-- trapping instruction
>   31: 00
>   32: 41 80 fc 01          cmp    $0x1,%r12b
>   36: 0f 87 c8 dc 4e 01    ja     0x14edd04
>   3c: 45 31 ed              xor    %r13d,%r13d
>   3f: 41                    rex.B
> 
> Code starting with the faulting instruction
> ===========================================
>    0: 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d
>    7: 00
>    8: 41 80 fc 01          cmp    $0x1,%r12b
>    c: 0f 87 c8 dc 4e 01    ja     0x14edcda
>   12: 45 31 ed              xor    %r13d,%r13d
>   15: 41                    rex.B
> [ 2391.916120] RSP: 0018:ffffb36e0a477d80 EFLAGS: 00010246
> [ 2391.921569] RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000080000000
> [ 2391.928872] RDX: 0000000000000000 RSI: ffffffff9299b722 RDI: ffffffff9299b722
> [ 2391.936237] RBP: ffffb36e0a477d98 R08: 000000000000002f R09: 0000000000000002
> [ 2391.943388] R10: ffffb36e0a477d70 R11: 0000000000000000 R12: 0000000000000002
> [ 2391.950527] R13: ffffb36e0a477e88 R14: ffff99c5803a2230 R15: ffff99c581c39000
> [ 2391.957670] FS:  00007fb4b9681740(0000) GS:ffff99c6efa80000(0000)
> knlGS:0000000000000000
> [ 2391.965822] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2391.971579] CR2: 00007fb4b96ab5e0 CR3: 000000010635c002 CR4: 00000000003706f0
> [ 2391.978721] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2391.985879] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2391.993028] Kernel panic - not syncing: Fatal exception
> [ 2391.998287] Kernel Offset: 0x10000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 2392.009066] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 

It's hard to repro this, it does repro after running several times for
me.

Steven, this is firing when the self test writes 1 to the enable file
for a user_event created event.

Sometimes I get this splat instead of a panic:
[  956.819778] ------------[ cut here ]------------
[  956.820526] WARNING: CPU: 12 PID: 914 at kernel/trace/trace.c:516 tracing_release_file_tr+0x46/0x50
[  956.821389] Modules linked in:
[  956.821708] CPU: 12 PID: 914 Comm: ftrace_test Not tainted 6.6.0-rc7-next-20231026 #1
[  956.822501] RIP: 0010:tracing_release_file_tr+0x46/0x50
[  956.822902] Code: d1 03 01 8b 83 c0 1e 00 00 85 c0 74 1d 83 e8 01 48 c7 c7 80 5b ef 84 89 83 c0 1e 00 00 e8 b2 b5 03 01 31 c0 5b e9 75 ee 27 01 <0f> 0b eb df 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
[  956.824261] RSP: 0018:ffffb59d879e3ee8 EFLAGS: 00010246
[  956.824656] RAX: 0000000000000000 RBX: ffff9e386a82c058 RCX: 0000000000000000
[  956.825239] RDX: 0000000000000000 RSI: ffffffff84b6b383 RDI: 00000000ffffffff
[  956.825835] RBP: ffff9e3844076200 R08: 0000000000000000 R09: 0000000000000000
[  956.826425] R10: ffffb59d879e3ee8 R11: ffffffff8328526f R12: 00000000000f801f
[  956.827359] R13: ffff9e3846134020 R14: ffff9e3843fd03a8 R15: 0000000000000000
[  956.828732] FS:  00007eff4f818740(0000) GS:ffff9e3f26300000(0000) knlGS:0000000000000000
[  956.829436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  956.829968] CR2: 00007eff4f42a250 CR3: 00000007d0744004 CR4: 0000000000370eb0
[  956.830591] Call Trace:
[  956.830804]  <TASK>
[  956.831113]  ? __warn+0x7f/0x160
[  956.831469]  ? tracing_release_file_tr+0x46/0x50
[  956.831891]  ? report_bug+0x1c3/0x1d0
[  956.832224]  ? handle_bug+0x3c/0x70
[  956.832544]  ? exc_invalid_op+0x14/0x70
[  956.832861]  ? asm_exc_invalid_op+0x16/0x20
[  956.833190]  ? tracing_release_file_tr+0x1f/0x50
[  956.833727]  ? tracing_release_file_tr+0x46/0x50
[  956.834159]  ? tracing_release_file_tr+0x1f/0x50
[  956.834579]  __fput+0xab/0x300
[  956.834903]  __x64_sys_close+0x38/0x80
[  956.835235]  do_syscall_64+0x41/0xf0
[  956.835554]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
[  956.835974] RIP: 0033:0x7eff4f515157
[  956.836291] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 83 b8 f7 ff
[  956.837728] RSP: 002b:00007ffc021d8158 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  956.838351] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007eff4f515157
[  956.838975] RDX: 0000000000000002 RSI: 000055637921d7d4 RDI: 0000000000000005
[  956.839586] RBP: 00007ffc021d8180 R08: 0000000000000000 R09: 00007eff4f818740
[  956.840201] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc021d83b8
[  956.840810] R13: 000055637921cae7 R14: 000055637921fc38 R15: 00007eff4f946040
[  956.841562]  </TASK>
[  956.841787] irq event stamp: 881
[  956.842145] hardirqs last  enabled at (889): [<ffffffff831d7f49>] console_unlock+0x109/0x130
[  956.843013] hardirqs last disabled at (896): [<ffffffff831d7f2e>] console_unlock+0xee/0x130
[  956.843648] softirqs last  enabled at (694): [<ffffffff8314ba2a>] irq_exit_rcu+0x8a/0xe0
[  956.844276] softirqs last disabled at (689): [<ffffffff8314ba2a>] irq_exit_rcu+0x8a/0xe0
[  956.844893] ---[ end trace 0000000000000000 ]---

Warning is from this code:
static void __trace_array_put(struct trace_array *this_tr)
{
        WARN_ON(!this_tr->ref);
        this_tr->ref--;
}

It seems like there might be a timing window or an incorrect call to
trace_array_put() somewhere. Do you think this is related to the eventfs
work?

Thanks,
-Beau

> Links:
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231026/testrun/20823454/suite/log-parser-test/tests/
> - https://lkft.validation.linaro.org/scheduler/job/6974179#L5053
> 
> metadata:
> git_ref: master
> git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> git_sha: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
> git_describe: next-20231026
> kernel_version: 6.6.0-rc7
> kernel-config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2XHt24sNSdog7DYY3FLKFZpZmjG/config
> artifact-location:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2XHt24sNSdog7DYY3FLKFZpZmjG/
> toolchain: gcc-13
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
