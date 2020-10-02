Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54A280E33
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 09:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJBHow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBHow (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 03:44:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15EC0613E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 00:44:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so546274otg.5
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1lNPZMrZdFDQdptJsnb62xeKwTuF9SGn6OSEgwscXXo=;
        b=W1nzzVAlNQ2Ri5NS9MVmLjU6+d/9amZcddY28T1bhrigyxnU9KcYT+2QBK5uPLuq4j
         nBPm6svWSicyC8Lj35ShiqikK+gyQRzkCnwsckQWlWUb5w2qAQjoMX8VxCsxFrQ7XL5V
         qd3YoYu05WzFhT7fPnCpeZfOA+DFj0a8rgfz+EFB138PsFj9Hzteot2pitcFBpfPEdSd
         kvTlVgbGonGpyfFy4WiANLMjKspT3BfxD6XOfvy1mkrydS1RzF0ioJlpaVn/iKAm46kK
         6Fnm3cz5u8q9YgKR5CqCRpZFoGjBDow+t+A226wsp/EM1X5QSpeX1Gdug3gCWiH/tbmA
         NzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1lNPZMrZdFDQdptJsnb62xeKwTuF9SGn6OSEgwscXXo=;
        b=qM5HYRpyF0SWMh9SopDnvjYfraR7uvGrp49szy4gjE+IF02B+/vYCt0I1qiEpKopbY
         s1tAfTE+EBHGFSfTqANhm77FN5Zx3afxwY17XiZXgZh4MH/00D06RaV8ljKcUZ09nU6L
         h6bcHRdTXgEx+Utd/s3X88wzatsLMvFAnT2ObVyIZTIBYg46JzRAGayG7Pzf8XKNI4Z8
         Au3ToctdDJNEedowwC+UR7hRd+jZDYl9CoNZDgcXTP5DbIDDklknVAhFGl5puQylR/kJ
         69/vD0MBs/8bMbfZQ23Avvx9a+aS23hmwcLLuiyQdEqQz+6Ov7TOj6+az2zDGnv06DXY
         QTwQ==
X-Gm-Message-State: AOAM530Ndff+OR8ZY0HVi2+z887uzRXMetJKtCnN5K3kehUfqbs+7pbp
        hFYRKSX23KRKlwAz798O3UYtyoLn2L6XDGkvBhyhgg==
X-Google-Smtp-Source: ABdhPJyftVpGXjxh8lYaOixC5PFU+3S/hOyTGNy//GEROfnDsnZBXHXekOGE8SodwbaPgZ4hdwTD35AnLrNAUu3p9nk=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr846062otf.281.1601624691040;
 Fri, 02 Oct 2020 00:44:51 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 2 Oct 2020 13:14:40 +0530
Message-ID: <CA+G9fYsG_sg_ys8bV5GEkEHj45DLLhLszyA3Kra74Nqt3ENh_w@mail.gmail.com>
Subject: WARNING:at arch/x86/kvm/vmx/vmx.c:4809 handle_exception_nmi+0x5ab/0x5c0
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, lkft-triage@lists.linaro.org,
        X86 ML <x86@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, mgamal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While running kselftest kvm evmcs_test the following kernel warning was noticed
on x86_64 running linux next 20201001 kernel.

WARNING: CPU: 0 PID: 11202 at
/usr/src/kernel/arch/x86/kvm/vmx/vmx.c:4809
handle_exception_nmi+0x5ab/0x5c0

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
# cd  /opt/kselftests/kvm
# ./evmcs_test

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: d39294091fee6b89d9c4a683bb19441b25098330
  git describe: next-20201001
  make_kernelversion: 5.9.0-rc7
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/872/config

# selftests: kvm: evmcs_test
[  492.217268] ------------[ cut here ]------------
[  492.222034] WARNING: CPU: 0 PID: 11202 at
/usr/src/kernel/arch/x86/kvm/vmx/vmx.c:4809
handle_exception_nmi+0x5ab/0x5c0
[  492.232747] Modules linked in: sch_fq sch_ingress veth algif_hash
x86_pkg_temp_thermal fuse [last unloaded: gpio_mockup]
[  492.243664] CPU: 0 PID: 11202 Comm: evmcs_test Tainted: G        W
       5.9.0-rc7-next-20201001 #1
[  492.252899] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  492.260398] RIP: 0010:handle_exception_nmi+0x5ab/0x5c0
[  492.265554] Code: 84 f7 fb ff ff 8b 93 ac 0e 00 00 85 d2 0f 84 e4
fb ff ff c7 83 ac 0e 00 00 00 00 00 00 48 89 df e8 9a f2 fa ff e9 d2
fb ff ff <0f> 0b e9 cc fd ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
00 0f
[  492.284317] RSP: 0018:ffffbf3001323cf8 EFLAGS: 00010246
[  492.289568] RAX: 0000000000000060 RBX: ffff9f5b08048000 RCX: 0000000000000000
[  492.296716] RDX: 00000000f359fd01 RSI: 0000000000000000 RDI: 000000008000030e
[  492.303868] RBP: ffffbf3001323d20 R08: 0000000080000306 R09: 0000000000000000
[  492.311018] R10: ffffbf3001323c30 R11: ffffbf30013e7000 R12: 0000000000000000
[  492.318167] R13: 0000000000000000 R14: ffff9f5b52714000 R15: 0000000000000000
[  492.325492] FS:  00007f22a58cc740(0000) GS:ffff9f5b5fc00000(0000)
knlGS:0000000000000000
[  492.333596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  492.339362] CR2: 0000000000000000 CR3: 00000004013c0006 CR4: 00000000003726f0
[  492.346513] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  492.353662] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  492.360814] Call Trace:
[  492.363293]  vmx_handle_exit+0x102/0x5e0
[  492.367241]  vcpu_enter_guest+0xe27/0x18a0
[  492.371361]  ? lock_acquire+0x9c/0x390
[  492.375132]  ? kvm_arch_vcpu_ioctl_run+0x9c/0x620
[  492.379865]  kvm_arch_vcpu_ioctl_run+0x12b/0x620
[  492.384501]  ? kvm_arch_vcpu_ioctl_run+0x12b/0x620
[  492.389316]  kvm_vcpu_ioctl+0x261/0x670
[  492.393183]  ? security_file_ioctl+0x37/0x50
[  492.397500]  __x64_sys_ioctl+0x96/0xd0
[  492.401283]  do_syscall_64+0x37/0x50
[  492.404878]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  492.409954] RIP: 0033:0x7f22a51ca8f7
[  492.413551] Code: b3 66 90 48 8b 05 a1 35 2c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 35 2c 00 f7 d8 64 89
01 48
[  492.432312] RSP: 002b:00007ffe09251188 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  492.439895] RAX: ffffffffffffffda RBX: 00000000007d23d0 RCX: 00007f22a51ca8f7
[  492.447043] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000009
[  492.454195] RBP: 000000000000000b R08: 000000000040d893 R09: 0000000000000005
[  492.461344] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe09251210
[  492.468495] R13: 00007f22a58c5000 R14: 00007ffe092512a0 R15: 000000000000000b
[  492.475658] CPU: 0 PID: 11202 Comm: evmcs_test Tainted: G        W
       5.9.0-rc7-next-20201001 #1
[  492.484879] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  492.492357] Call Trace:
[  492.494803]  dump_stack+0x7d/0x9f
[  492.498126]  __warn+0x94/0x100
[  492.501183]  ? handle_exception_nmi+0x5ab/0x5c0
[  492.505715]  report_bug+0xc0/0x150
[  492.509123]  handle_bug+0x48/0x80
[  492.512442]  exc_invalid_op+0x18/0x70
[  492.516108]  asm_exc_invalid_op+0x12/0x20
[  492.520119] RIP: 0010:handle_exception_nmi+0x5ab/0x5c0
[  492.525257] Code: 84 f7 fb ff ff 8b 93 ac 0e 00 00 85 d2 0f 84 e4
fb ff ff c7 83 ac 0e 00 00 00 00 00 00 48 89 df e8 9a f2 fa ff e9 d2
fb ff ff <0f> 0b e9 cc fd ff ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
00 0f
[  492.544001] RSP: 0018:ffffbf3001323cf8 EFLAGS: 00010246
[  492.549229] RAX: 0000000000000060 RBX: ffff9f5b08048000 RCX: 0000000000000000
[  492.556361] RDX: 00000000f359fd01 RSI: 0000000000000000 RDI: 000000008000030e
[  492.563492] RBP: ffffbf3001323d20 R08: 0000000080000306 R09: 0000000000000000
[  492.570625] R10: ffffbf3001323c30 R11: ffffbf30013e7000 R12: 0000000000000000
[  492.577757] R13: 0000000000000000 R14: ffff9f5b52714000 R15: 0000000000000000
[  492.584900]  vmx_handle_exit+0x102/0x5e0
[  492.588839]  vcpu_enter_guest+0xe27/0x18a0
[  492.592943]  ? lock_acquire+0x9c/0x390
[  492.596697]  ? kvm_arch_vcpu_ioctl_run+0x9c/0x620
[  492.601411]  kvm_arch_vcpu_ioctl_run+0x12b/0x620
[  492.606037]  ? kvm_arch_vcpu_ioctl_run+0x12b/0x620
[  492.610833]  kvm_vcpu_ioctl+0x261/0x670
[  492.614675]  ? security_file_ioctl+0x37/0x50
[  492.618963]  __x64_sys_ioctl+0x96/0xd0
[  492.622725]  do_syscall_64+0x37/0x50
[  492.626308]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  492.631362] RIP: 0033:0x7f22a51ca8f7
[  492.634938] Code: b3 66 90 48 8b 05 a1 35 2c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 35 2c 00 f7 d8 64 89
01 48
[  492.653676] RSP: 002b:00007ffe09251188 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  492.661243] RAX: ffffffffffffffda RBX: 00000000007d23d0 RCX: 00007f22a51ca8f7
[  492.668373] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000009
[  492.675498] RBP: 000000000000000b R08: 000000000040d893 R09: 0000000000000005
[  492.682632] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe09251210
[  492.689763] R13: 00007f22a58c5000 R14: 00007ffe092512a0 R15: 000000000000000b
[  492.696921] irq event stamp: 33513
[  492.700345] hardirqs last  enabled at (33523): [<ffffffffa4a3f229>]
console_unlock+0x4a9/0x5b0
[  492.708970] hardirqs last disabled at (33532): [<ffffffffa4a3f183>]
console_unlock+0x403/0x5b0
[  492.717596] softirqs last  enabled at (33388): [<ffffffffa5c00308>]
__do_softirq+0x308/0x42a
[  492.726043] softirqs last disabled at (33351): [<ffffffffa5a00f82>]
asm_call_irq_on_stack+0x12/0x20
[  492.735099] ---[ end trace 3a8d97eed7321275 ]---


full test log link,
https://lkft.validation.linaro.org/scheduler/job/1809553#L6581

-- 
Linaro LKFT
https://lkft.linaro.org
