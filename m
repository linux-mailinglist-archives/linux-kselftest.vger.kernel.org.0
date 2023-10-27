Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655C47D96E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0Lrh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345734AbjJ0Lrg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:47:36 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48FFC4
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 04:47:31 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457cc01b805so889514137.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698407250; x=1699012050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cz8tL+/ZScku0Dlnsowhcp/n/F3CxkTXbBTziMCrUYQ=;
        b=YlSG72/BqUjVbcAJXboQBc7w6twACPVXOuSKtEASAl/wcX4FJlSjgv2sy/oaAyv7r8
         ZyS1dlw03IawgY9I6XtPyFCI9nT0exWjosBL8E6p2Wd4PHtPdHWYuQnGGl1S7x35RIb0
         vKXQenvE+gGbei12Bc1dJBuhTyyUqGfUvScMFL1Pb3seb9DBsAuxTVg6GmQeStWkqcUy
         mPQ1U12lSNEdHUPFHf+ILJDvgL/q8wO6121fmr0MD7SN//O/QfXhO59WjaQHfS8JXP5+
         FX/zsXVHHorfWei28t99jJgCQyuvpLEduUt4S1PoSm9a+prK94EPMeLMr34Ir+5h88Dz
         fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407250; x=1699012050;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cz8tL+/ZScku0Dlnsowhcp/n/F3CxkTXbBTziMCrUYQ=;
        b=WdkefCBCax0rdO9JDFqWK+uqHCqZp0hyhqPRjDLFrbqqOWb09vrljRgDLfFS6nnlUs
         gkp2JScrQEyvb2bnCY6zbjUurKe5gVDkW2DvHgaECpF1pQ+Sudcy8xJf1eqH9NcHuNjU
         fLKLx995KEfHB1BCFWQgoprKqXZ15XV5vzos6ySCJVNsWWGMrBd2CeFyiPrfrkacY0Kh
         cSe4qCmE6vHKEuqTUj9jj2VswlHet9BIejg64wshQUprGybaAJt/KA7/UrgyyLdeP91x
         ZABOayyPTp8wm0UMcSP3KkveHxsvB/CX6jy3ZeYqjcRPlwbNEv9Reh2GGSXBThTemW1s
         tJ6A==
X-Gm-Message-State: AOJu0YyiTDlZW4v79KEYqZE5sW0lfSlr1JDfOF02/t4EX8l76OvzoZXn
        KbE4vAuYDkl+jXVjMAlp6ERKeOgukosDdYAI821JkEiLKyH0XTXfonKFqA==
X-Google-Smtp-Source: AGHT+IHfyecaO9s/+PZZMhHZd0+oaFqNbDRPBLtgFfqI192yBSoKNlHVWO5bjAH8CaykpNyKHz0snj39GEypdWxLS1A=
X-Received: by 2002:a67:c11a:0:b0:457:cd8b:57b6 with SMTP id
 d26-20020a67c11a000000b00457cd8b57b6mr2640162vsj.31.1698407250089; Fri, 27
 Oct 2023 04:47:30 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 27 Oct 2023 17:17:19 +0530
Message-ID: <CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com>
Subject: selftests: ftrace: RIP: 0010:__lock_acquire (kernel/locking/lockdep.c:5005)
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>, Dave Jones <davej@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sasha.levin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Ajay Kaher <akaher@vmware.com>
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

Following kernel crash noticed on x86_64 while running selftests ftracetests
running 6.6.0-rc7-next-20231026.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

log:
-----
# ok 44 ftrace - test for function traceon/off triggers
# ok 45 ftrace - test tracing error log support
# ok 46 Test creation and deletion of trace instances while setting an event
[ 1402.419605] BUG: kernel NULL pointer dereference, address: 0000000000000097
[ 1402.426574] #PF: supervisor read access in kernel mode
[ 1402.431715] #PF: error_code(0x0000) - not-present page
[ 1402.436852] PGD 0 P4D 0
[ 1402.439393] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1402.443578] CPU: 0 PID: 18196 Comm: ls Not tainted 6.6.0-rc7-next-20231026 #1
[ 1402.450711] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[ 1402.458102] RIP: 0010:__lock_acquire (kernel/locking/lockdep.c:5005)
[ 1402.462722] Code: 4d d4 53 45 85 f6 0f 84 a5 06 00 00 44 8b 2d 8d
c2 bf 02 45 89 c2 49 89 fb 89 f3 41 89 d6 45 89 c8 45 85 ed 0f 84 ca
02 00 00 <48> 81 3f c0 2b f1 af 44 0f 44 d0 83 fb 01 0f 86 c2 02 00 00
31 d2
All code
========
   0: 4d d4                rex.WRB (bad)
   2: 53                    push   %rbx
   3: 45 85 f6              test   %r14d,%r14d
   6: 0f 84 a5 06 00 00    je     0x6b1
   c: 44 8b 2d 8d c2 bf 02 mov    0x2bfc28d(%rip),%r13d        # 0x2bfc2a0
  13: 45 89 c2              mov    %r8d,%r10d
  16: 49 89 fb              mov    %rdi,%r11
  19: 89 f3                mov    %esi,%ebx
  1b: 41 89 d6              mov    %edx,%r14d
  1e: 45 89 c8              mov    %r9d,%r8d
  21: 45 85 ed              test   %r13d,%r13d
  24: 0f 84 ca 02 00 00    je     0x2f4
  2a:* 48 81 3f c0 2b f1 af cmpq   $0xffffffffaff12bc0,(%rdi) <--
trapping instruction
  31: 44 0f 44 d0          cmove  %eax,%r10d
  35: 83 fb 01              cmp    $0x1,%ebx
  38: 0f 86 c2 02 00 00    jbe    0x300
  3e: 31 d2                xor    %edx,%edx

Code starting with the faulting instruction
===========================================
   0: 48 81 3f c0 2b f1 af cmpq   $0xffffffffaff12bc0,(%rdi)
   7: 44 0f 44 d0          cmove  %eax,%r10d
   b: 83 fb 01              cmp    $0x1,%ebx
   e: 0f 86 c2 02 00 00    jbe    0x2d6
  14: 31 d2                xor    %edx,%edx
[ 1402.481497] RSP: 0018:ffff9b3041327998 EFLAGS: 00010002
[ 1402.486719] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 1402.493843] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000097
[ 1402.500967] RBP: ffff9b3041327a38 R08: 0000000000000000 R09: 0000000000000000
[ 1402.508092] R10: 0000000000000001 R11: 0000000000000097 R12: ffff8de420f38040
[ 1402.515225] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[ 1402.522348] FS:  00007f52d72a1d00(0000) GS:ffff8de767a00000(0000)
knlGS:0000000000000000
[ 1402.530438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1402.536224] CR2: 0000000000000097 CR3: 000000012201e005 CR4: 00000000003706f0
[ 1402.543354] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1402.550479] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1402.557602] Call Trace:
[ 1402.560049]  <TASK>
[ 1402.562153] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[ 1402.565559] ? __die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434)
[ 1402.568611] ? page_fault_oops (arch/x86/mm/fault.c:707)
[ 1402.572711] ? __lock_acquire (kernel/locking/lockdep.c:186
kernel/locking/lockdep.c:3872 kernel/locking/lockdep.c:5136)
[ 1402.576811] ? do_user_addr_fault (arch/x86/mm/fault.c:1264)
[ 1402.581170] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26
arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127
arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)
[ 1402.585094] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
[ 1402.589283] ? __lock_acquire (kernel/locking/lockdep.c:5005)
[ 1402.593296] ? lock_acquire (kernel/locking/lockdep.c:467
(discriminator 4) kernel/locking/lockdep.c:5755 (discriminator 4)
kernel/locking/lockdep.c:5718 (discriminator 4))
[ 1402.597045] ? create_dir_dentry.part.0
(fs/tracefs/event_inode.c:357 (discriminator 1))
[ 1402.601928] lock_acquire (kernel/locking/lockdep.c:467
(discriminator 4) kernel/locking/lockdep.c:5755 (discriminator 4)
kernel/locking/lockdep.c:5718 (discriminator 4))
[ 1402.605503] ? d_invalidate (fs/dcache.c:1725 (discriminator 1))
[ 1402.609170] ? lock_release (kernel/locking/lockdep.c:5429
kernel/locking/lockdep.c:5773)
[ 1402.612923] ? create_dir_dentry.part.0 (fs/tracefs/event_inode.c:387)
[ 1402.617803] _raw_spin_lock (include/linux/spinlock_api_smp.h:134
kernel/locking/spinlock.c:154)
[ 1402.621467] ? d_invalidate (fs/dcache.c:1725 (discriminator 1))
[ 1402.625126] d_invalidate (fs/dcache.c:1725 (discriminator 1))
[ 1402.628619] create_dir_dentry.part.0 (fs/tracefs/event_inode.c:390)
[ 1402.633324] dcache_dir_open_wrapper (fs/tracefs/event_inode.c:586)
[ 1402.637945] ? __pfx_dcache_dir_open_wrapper (fs/tracefs/event_inode.c:536)
[ 1402.643081] do_dentry_open (fs/open.c:948)
[ 1402.646924] vfs_open (fs/open.c:1083)
[ 1402.650069] path_openat (fs/namei.c:3623 fs/namei.c:3779)
[ 1402.653648] do_filp_open (fs/namei.c:3810 (discriminator 2))
[ 1402.657233] do_sys_openat2 (fs/open.c:1441 (discriminator 1))
[ 1402.660911] __x64_sys_openat (fs/open.c:1466)
[ 1402.664749] do_syscall_64 (arch/x86/entry/common.c:51
arch/x86/entry/common.c:82)
[ 1402.668328] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)
[ 1402.673120] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 1402.676864] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 1402.680607] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 1402.684352] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)
[ 1402.689136] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 1402.692880] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)
[ 1402.697666] ? do_syscall_64 (arch/x86/entry/common.c:101)
[ 1402.701440] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
[ 1402.706512] RIP: 0033:0x7f52d7439df1
[ 1402.710082] Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00
41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff
ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00
00 00
All code
========
   0: 44 24 18              rex.R and $0x18,%al
   3: 31 c0                xor    %eax,%eax
   5: 41 83 e2 40          and    $0x40,%r10d
   9: 75 3e                jne    0x49
   b: 89 f0                mov    %esi,%eax
   d: 25 00 00 41 00        and    $0x410000,%eax
  12: 3d 00 00 41 00        cmp    $0x410000,%eax
  17: 74 30                je     0x49
  19: 89 f2                mov    %esi,%edx
  1b: b8 01 01 00 00        mov    $0x101,%eax
  20: 48 89 fe              mov    %rdi,%rsi
  23: bf 9c ff ff ff        mov    $0xffffff9c,%edi
  28: 0f 05                syscall
  2a:* 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax <--
trapping instruction
  30: 77 3f                ja     0x71
  32: 48 8b 54 24 18        mov    0x18(%rsp),%rdx
  37: 64 48 2b 14 25 28 00 sub    %fs:0x28,%rdx
  3e: 00 00

Code starting with the faulting instruction
===========================================
   0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
   6: 77 3f                ja     0x47
   8: 48 8b 54 24 18        mov    0x18(%rsp),%rdx
   d: 64 48 2b 14 25 28 00 sub    %fs:0x28,%rdx
  14: 00 00
[ 1402.728821] RSP: 002b:00007fff2270ba90 EFLAGS: 00000287 ORIG_RAX:
0000000000000101
[ 1402.736388] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f52d7439df1
[ 1402.743520] RDX: 0000000000090800 RSI: 0000558fb3992090 RDI: 00000000ffffff9c
[ 1402.750651] RBP: 0000000000000000 R08: 0000000000000007 R09: 0000558fb3992250
[ 1402.757775] R10: 0000000000000000 R11: 0000000000000287 R12: 00007f52d72a1b98
[ 1402.764900] R13: 00007fff2270bee0 R14: 0000558fb3992090 R15: 0000558fb28aafc8
[ 1402.772027]  </TASK>
[ 1402.774216] Modules linked in: x86_pkg_temp_thermal fuse configfs
[last unloaded: trace_printk]
[ 1402.782908] CR2: 0000000000000097
[ 1402.786220] ---[ end trace 0000000000000000 ]---
[ 1402.790839] RIP: 0010:__lock_acquire (kernel/locking/lockdep.c:5005)
[ 1402.795468] Code: 4d d4 53 45 85 f6 0f 84 a5 06 00 00 44 8b 2d 8d
c2 bf 02 45 89 c2 49 89 fb 89 f3 41 89 d6 45 89 c8 45 85 ed 0f 84 ca
02 00 00 <48> 81 3f c0 2b f1 af 44 0f 44 d0 83 fb 01 0f 86 c2 02 00 00
31 d2
All code
========
   0: 4d d4                rex.WRB (bad)
   2: 53                    push   %rbx
   3: 45 85 f6              test   %r14d,%r14d
   6: 0f 84 a5 06 00 00    je     0x6b1
   c: 44 8b 2d 8d c2 bf 02 mov    0x2bfc28d(%rip),%r13d        # 0x2bfc2a0
  13: 45 89 c2              mov    %r8d,%r10d
  16: 49 89 fb              mov    %rdi,%r11
  19: 89 f3                mov    %esi,%ebx
  1b: 41 89 d6              mov    %edx,%r14d
  1e: 45 89 c8              mov    %r9d,%r8d
  21: 45 85 ed              test   %r13d,%r13d
  24: 0f 84 ca 02 00 00    je     0x2f4
  2a:* 48 81 3f c0 2b f1 af cmpq   $0xffffffffaff12bc0,(%rdi) <--
trapping instruction
  31: 44 0f 44 d0          cmove  %eax,%r10d
  35: 83 fb 01              cmp    $0x1,%ebx
  38: 0f 86 c2 02 00 00    jbe    0x300
  3e: 31 d2                xor    %edx,%edx

Code starting with the faulting instruction
===========================================
   0: 48 81 3f c0 2b f1 af cmpq   $0xffffffffaff12bc0,(%rdi)
   7: 44 0f 44 d0          cmove  %eax,%r10d
   b: 83 fb 01              cmp    $0x1,%ebx
   e: 0f 86 c2 02 00 00    jbe    0x2d6
  14: 31 d2                xor    %edx,%edx
[ 1402.814213] RSP: 0018:ffff9b3041327998 EFLAGS: 00010002
[ 1402.819439] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 1402.826587] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000097
[ 1402.833711] RBP: ffff9b3041327a38 R08: 0000000000000000 R09: 0000000000000000
[ 1402.840836] R10: 0000000000000001 R11: 0000000000000097 R12: ffff8de420f38040
[ 1402.847959] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[ 1402.855083] FS:  00007f52d72a1d00(0000) GS:ffff8de767a00000(0000)
knlGS:0000000000000000
[ 1402.863161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1402.868897] CR2: 0000000000000097 CR3: 000000012201e005 CR4: 00000000003706f0
[ 1402.876023] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1402.883154] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1402.890280] Kernel panic - not syncing: Fatal exception
[ 1402.895543] Kernel Offset: 0x2b000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1402.906322] ---[ end Kernel panic - not syncing: Fatal exception ]---

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231026/testrun/20823466/suite/log-parser-test/tests/
 - https://lkft.validation.linaro.org/scheduler/job/6974183#L5240

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
  git_describe: next-20231026
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2XHt24sNSdog7DYY3FLKFZpZmjG/config
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2XHt24sNSdog7DYY3FLKFZpZmjG/
  toolchain: gcc-13


--
Linaro LKFT
https://lkft.linaro.org
