Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EADE7D9748
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbjJ0MJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:08:59 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B211F
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 05:08:54 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b625ed7208so901253241.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698408533; x=1699013333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x3yeO1tRhwG+r6xNonTVZt/x+dlrlOfdfkvnTKForig=;
        b=bMG4mwAzoeh99xZ8yMy9f11xVI4glf9SbXLY8YIHdT6jpHmLLj0uMQ6v4EW4T6f/Zv
         /Dlk5qyVS0CI5xAN3JKjp/cHXTnvd6l/cFa0nMA3vwUe59jS+reWtFrfIXyAjaBio/vj
         cXzg/f83fDaMNjsPQPAT06KBnHwFXBdpMekTLNy4BhWzZQt3RVeLJX0HsYjxF+yk/oEz
         ljI2bEdKfgaTJjl8DIvRA+89h0GFeOEtxCGWWqe5Uof1wnTFOE9ml5ijw3xXENepXZeG
         YDYmDwGUg8M8PzOzSJF3YLTNWRY4fYL59Uvb0l8muEy3SaATXXH4UGA1ub0zoPjmWxWk
         q0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408533; x=1699013333;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3yeO1tRhwG+r6xNonTVZt/x+dlrlOfdfkvnTKForig=;
        b=wuDsmF2bL7qzYpHutIVJxjJV4M94P429BMZfymglywZWN55FqkR+IG03BnzgfUBlhn
         7mwJKELP9WBMOrITtFLhI9wTG6vc04HgB0wcrMERByxWJK9AXFtZsZXF5uGGDmTYcR9O
         zL1dZhKUnwnfcCrlISqL/W5fX5/3WvHkdo21y6YuAl9Iu+2TzjKZ0CMHHiqCvUQTDaCG
         kCz7xHqnuBE3fkp98U9f3xUuBUhMTH2meLTOq34BAx6GQ/GcVUmfZ8vBqmdogo2DxLxw
         g8wCpc/xnmn+mQfmYxlxgLz2f8o5++k9rTk+nonDlAjPuejtKuvkMBEl9h7tysYKbu4I
         AyiQ==
X-Gm-Message-State: AOJu0Yzwv7eLFPfzJTYTAdxYUDdxAgUtqBYRv+Qgj+TS/vx48J382POc
        fZJdFISTWlLTAzluepWPG+Cxd+bEl0UEJ4mFUqN+Pj17uDgUaqEK2O2uLw==
X-Google-Smtp-Source: AGHT+IE+AZ9gjmCJMWYHvZ4pSSPr6V6asjp7i6aEh1bTpCYRX4g7CHGvwb9sAOe+1vkbJdfXD6oi2sj1AH4J4/UfDWU=
X-Received: by 2002:a1f:a74f:0:b0:48d:1fcd:9760 with SMTP id
 q76-20020a1fa74f000000b0048d1fcd9760mr2718374vke.10.1698408533359; Fri, 27
 Oct 2023 05:08:53 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 27 Oct 2023 17:38:41 +0530
Message-ID: <CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com>
Subject: selftests: user_events: ftrace_test - RIP: 0010:tracing_update_buffers
 (kernel/trace/trace.c:6470)
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following kernel crash noticed on x86_64 while running selftests: user_events:
ftrace_test running 6.6.0-rc7-next-20231026.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

kselftest: Running tests in user_events
TAP version 13
1..4
# timeout set to 90
# selftests: user_events: ftrace_test
[ 2391.606817] general protection fault, probably for non-canonical
address 0x6b6b6b6b6b6b8a83: 0000 [#1] PREEMPT SMP PTI
[ 2391.617519] CPU: 1 PID: 34662 Comm: ftrace_test Not tainted
6.6.0-rc7-next-20231026 #1
[ 2391.625428] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[ 2391.632811] RIP: 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
[ 2391.637952] Code: 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
55 31 f6 48 89 e5 41 55 41 54 53 48 89 fb 48 c7 c7 40 8c 61 94 e8 92
d3 5a 01 <44> 0f b6 a3 18 1f 00 00 41 80 fc 01 0f 87 c8 dc 4e 01 45 31
ed 41
All code
========
   0: 90                    nop
   1: 90                    nop
   2: 90                    nop
   3: 90                    nop
   4: 90                    nop
   5: 90                    nop
   6: 90                    nop
   7: 90                    nop
   8: 90                    nop
   9: 90                    nop
   a: 90                    nop
   b: 90                    nop
   c: 66 0f 1f 00          nopw   (%rax)
  10: 55                    push   %rbp
  11: 31 f6                xor    %esi,%esi
  13: 48 89 e5              mov    %rsp,%rbp
  16: 41 55                push   %r13
  18: 41 54                push   %r12
  1a: 53                    push   %rbx
  1b: 48 89 fb              mov    %rdi,%rbx
  1e: 48 c7 c7 40 8c 61 94 mov    $0xffffffff94618c40,%rdi
  25: e8 92 d3 5a 01        callq  0x15ad3bc
  2a:* 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d <-- trapping instruction
  31: 00
  32: 41 80 fc 01          cmp    $0x1,%r12b
  36: 0f 87 c8 dc 4e 01    ja     0x14edd04
  3c: 45 31 ed              xor    %r13d,%r13d
  3f: 41                    rex.B

Code starting with the faulting instruction
===========================================
   0: 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d
   7: 00
   8: 41 80 fc 01          cmp    $0x1,%r12b
   c: 0f 87 c8 dc 4e 01    ja     0x14edcda
  12: 45 31 ed              xor    %r13d,%r13d
  15: 41                    rex.B
[ 2391.656696] RSP: 0018:ffffb36e0a477d80 EFLAGS: 00010246
[ 2391.661937] RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000080000000
[ 2391.669064] RDX: 0000000000000000 RSI: ffffffff9299b722 RDI: ffffffff9299b722
[ 2391.676195] RBP: ffffb36e0a477d98 R08: 000000000000002f R09: 0000000000000002
[ 2391.683321] R10: ffffb36e0a477d70 R11: 0000000000000000 R12: 0000000000000002
[ 2391.690453] R13: ffffb36e0a477e88 R14: ffff99c5803a2230 R15: ffff99c581c39000
[ 2391.697586] FS:  00007fb4b9681740(0000) GS:ffff99c6efa80000(0000)
knlGS:0000000000000000
[ 2391.705670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2391.711410] CR2: 00007fb4b96ab5e0 CR3: 000000010635c002 CR4: 00000000003706f0
[ 2391.718540] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2391.725665] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2391.732797] Call Trace:
[ 2391.735240]  <TASK>
[ 2391.737339] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[ 2391.740744] ? die_addr (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:460)
[ 2391.744056] ? exc_general_protection (arch/x86/kernel/traps.c:697
arch/x86/kernel/traps.c:642)
[ 2391.748766] ? asm_exc_general_protection
(arch/x86/include/asm/idtentry.h:564)
[ 2391.753652] ? __mutex_lock (kernel/locking/mutex.c:613
(discriminator 3) kernel/locking/mutex.c:747 (discriminator 3))
[ 2391.757487] ? __mutex_lock (kernel/locking/mutex.c:613
(discriminator 3) kernel/locking/mutex.c:747 (discriminator 3))
[ 2391.761318] ? tracing_update_buffers (kernel/trace/trace.c:6470)
[ 2391.765851] event_enable_write (kernel/trace/trace_events.c:1408)
[ 2391.769976] vfs_write (fs/read_write.c:582)
[ 2391.773296] ? close_fd_get_file (fs/file.c:821)
[ 2391.777396] ? preempt_count_sub (kernel/sched/core.c:5857
kernel/sched/core.c:5853 kernel/sched/core.c:5875)
[ 2391.781496] ksys_write (fs/read_write.c:638)
[ 2391.784918] __x64_sys_write (fs/read_write.c:646)
[ 2391.788671] do_syscall_64 (arch/x86/entry/common.c:51
arch/x86/entry/common.c:82)
[ 2391.792248] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 2391.795995] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)
[ 2391.800785] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 2391.804529] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 2391.808275] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
[ 2391.813327] RIP: 0033:0x7fb4b977c140
[ 2391.816920] Code: 40 00 48 8b 15 c1 9c 0d 00 f7 d8 64 89 02 48 c7
c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 24 0e 00 00 74 17 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28
48 89
All code
========
   0: 40 00 48 8b          add    %cl,-0x75(%rax)
   4: 15 c1 9c 0d 00        adc    $0xd9cc1,%eax
   9: f7 d8                neg    %eax
   b: 64 89 02              mov    %eax,%fs:(%rdx)
   e: 48 c7 c0 ff ff ff ff mov    $0xffffffffffffffff,%rax
  15: eb b7                jmp    0xffffffffffffffce
  17: 0f 1f 00              nopl   (%rax)
  1a: 80 3d a1 24 0e 00 00 cmpb   $0x0,0xe24a1(%rip)        # 0xe24c2
  21: 74 17                je     0x3a
  23: b8 01 00 00 00        mov    $0x1,%eax
  28: 0f 05                syscall
  2a:* 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax <--
trapping instruction
  30: 77 58                ja     0x8a
  32: c3                    retq
  33: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
  3a: 48 83 ec 28          sub    $0x28,%rsp
  3e: 48                    rex.W
  3f: 89                    .byte 0x89

Code starting with the faulting instruction
===========================================
   0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
   6: 77 58                ja     0x60
   8: c3                    retq
   9: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
  10: 48 83 ec 28          sub    $0x28,%rsp
  14: 48                    rex.W
  15: 89                    .byte 0x89
[ 2391.835660] RSP: 002b:00007ffc43b05b38 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 2391.843225] RAX: ffffffffffffffda RBX: 00007ffc43b05d88 RCX: 00007fb4b977c140
[ 2391.850350] RDX: 0000000000000002 RSI: 000056376b59b7d4 RDI: 0000000000000007
[ 2391.857482] RBP: 00007ffc43b05b60 R08: 0000000000000000 R09: 00007fb4b9681740
[ 2391.864615] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[ 2391.871747] R13: 00007ffc43b05d98 R14: 000056376b59ddc8 R15: 00007fb4b9981020
[ 2391.878907]  </TASK>
[ 2391.881106] Modules linked in: x86_pkg_temp_thermal fuse configfs
[ 2391.887288] ---[ end trace 0000000000000000 ]---
[ 2391.891915] RIP: 0010:tracing_update_buffers (kernel/trace/trace.c:6470)
[ 2391.897231] Code: 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
55 31 f6 48 89 e5 41 55 41 54 53 48 89 fb 48 c7 c7 40 8c 61 94 e8 92
d3 5a 01 <44> 0f b6 a3 18 1f 00 00 41 80 fc 01 0f 87 c8 dc 4e 01 45 31
ed 41
All code
========
   0: 90                    nop
   1: 90                    nop
   2: 90                    nop
   3: 90                    nop
   4: 90                    nop
   5: 90                    nop
   6: 90                    nop
   7: 90                    nop
   8: 90                    nop
   9: 90                    nop
   a: 90                    nop
   b: 90                    nop
   c: 66 0f 1f 00          nopw   (%rax)
  10: 55                    push   %rbp
  11: 31 f6                xor    %esi,%esi
  13: 48 89 e5              mov    %rsp,%rbp
  16: 41 55                push   %r13
  18: 41 54                push   %r12
  1a: 53                    push   %rbx
  1b: 48 89 fb              mov    %rdi,%rbx
  1e: 48 c7 c7 40 8c 61 94 mov    $0xffffffff94618c40,%rdi
  25: e8 92 d3 5a 01        callq  0x15ad3bc
  2a:* 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d <-- trapping instruction
  31: 00
  32: 41 80 fc 01          cmp    $0x1,%r12b
  36: 0f 87 c8 dc 4e 01    ja     0x14edd04
  3c: 45 31 ed              xor    %r13d,%r13d
  3f: 41                    rex.B

Code starting with the faulting instruction
===========================================
   0: 44 0f b6 a3 18 1f 00 movzbl 0x1f18(%rbx),%r12d
   7: 00
   8: 41 80 fc 01          cmp    $0x1,%r12b
   c: 0f 87 c8 dc 4e 01    ja     0x14edcda
  12: 45 31 ed              xor    %r13d,%r13d
  15: 41                    rex.B
[ 2391.916120] RSP: 0018:ffffb36e0a477d80 EFLAGS: 00010246
[ 2391.921569] RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000080000000
[ 2391.928872] RDX: 0000000000000000 RSI: ffffffff9299b722 RDI: ffffffff9299b722
[ 2391.936237] RBP: ffffb36e0a477d98 R08: 000000000000002f R09: 0000000000000002
[ 2391.943388] R10: ffffb36e0a477d70 R11: 0000000000000000 R12: 0000000000000002
[ 2391.950527] R13: ffffb36e0a477e88 R14: ffff99c5803a2230 R15: ffff99c581c39000
[ 2391.957670] FS:  00007fb4b9681740(0000) GS:ffff99c6efa80000(0000)
knlGS:0000000000000000
[ 2391.965822] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2391.971579] CR2: 00007fb4b96ab5e0 CR3: 000000010635c002 CR4: 00000000003706f0
[ 2391.978721] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2391.985879] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2391.993028] Kernel panic - not syncing: Fatal exception
[ 2391.998287] Kernel Offset: 0x10000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 2392.009066] ---[ end Kernel panic - not syncing: Fatal exception ]---

Links:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231026/testrun/20823454/suite/log-parser-test/tests/
- https://lkft.validation.linaro.org/scheduler/job/6974179#L5053

metadata:
git_ref: master
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
git_describe: next-20231026
kernel_version: 6.6.0-rc7
kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2XHt24sNSdog7DYY3FLKFZpZmjG/config
artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2XHt24sNSdog7DYY3FLKFZpZmjG/
toolchain: gcc-13


--
Linaro LKFT
https://lkft.linaro.org
