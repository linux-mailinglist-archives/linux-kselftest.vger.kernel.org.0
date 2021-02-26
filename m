Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C0325E66
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBZHn0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 02:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZHn0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 02:43:26 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9088C061574;
        Thu, 25 Feb 2021 23:42:45 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id f33so8271348otf.11;
        Thu, 25 Feb 2021 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMr4ZfOdknvNK6qxXkZDsfjyOXK7e1+8va3gHtKGjwA=;
        b=uUuOr7J72pmh4I1i5YDidK6nLmFE9UYmhR7DOjEGxVj67/71vDovgvRIl7z55hbS3W
         uopiLYc05Wy9ES/FYFnvnFFU2ubhjiAtsiS+MjWNVX05sEnWokgM761QCZeWFRlw8Jb1
         Q8HCG5k68WR5w0oKA5WP+xP89V8JkD91eTJenIwtCgNVv9LDX67DZ+5YT3tbzzuOAMzA
         gfI8CWApcqk9WijXdD4saDWIywv1jkDSqL79Pk+Gw9LdpLBdOWMlQtH/Epq5S4XEJkDT
         ceIpWplenAyDLhI9DBKv488PxXfDvxpbpVf7GR9BoSkZy9pDtSTppzfFM83uP2vQwiNH
         OVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMr4ZfOdknvNK6qxXkZDsfjyOXK7e1+8va3gHtKGjwA=;
        b=cAA9srlnYS14AHRv/m2uBFeCK6y6bFzu+WErzfX+gMwkchm9Dka9kY4qolR6D9tf4T
         d4r3iK3t4M2zCeI1GSZcc0Z65GUcIM+BwS1kZuuAUfZtWIw5O3pqixW3BDCaOBhvwW5+
         s4rBatd2zGsb2MoREVboouSzHyPVvaJS2EffOGqINWDbPZjsSbBc9v4TzBML3lCMCqKA
         Lua/xwaDMlSqOfEKw46myEjHocUfroXxMMHZ9X0cg4KsYlL31EHA2z4GUAYycDre9EGB
         xiVvy9spdE3hRVKdaOdqoe1qbwobYcIP3l5X1VmHZZEFWQ34yXtzzYYbgsuMoGJAB3fC
         vObw==
X-Gm-Message-State: AOAM532sjz6bvpI17jrLErrVerKDTDKvmsBR5PsiYeuq+F4Q8INyhu22
        EI8ud7saS0dN4T528mIjX7KZyrUV4VtsOqbS9s8=
X-Google-Smtp-Source: ABdhPJwQvNf5R9EscuFJCfCDDXhRAz48MxUvFWrzTb6sHgRcmZQ3jV1EfpuJ3M1ZLlznmJUUr/pfFg+mKvLhUVDe/yU=
X-Received: by 2002:a05:6830:10c1:: with SMTP id z1mr1284708oto.254.1614325365271;
 Thu, 25 Feb 2021 23:42:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a6093b05bc37caae@google.com>
In-Reply-To: <000000000000a6093b05bc37caae@google.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 26 Feb 2021 15:42:34 +0800
Message-ID: <CANRm+CwZ2q6z9=6tkdXy1gin1yBh+WxDWtyuORg-8_LLp9o25A@mail.gmail.com>
Subject: Re: general protection fault in kvm_hv_irq_routing_update
To:     syzbot <syzbot+6987f3b2dbd9eda95f12@syzkaller.appspotmail.com>
Cc:     aaronlewis@google.com, Borislav Petkov <bp@alien8.de>,
        Andrew Jones <drjones@redhat.com>,
        Alexander Graf <graf@amazon.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, makarandsonare@google.com,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 26 Feb 2021 at 15:01, syzbot
<syzbot+6987f3b2dbd9eda95f12@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a99163e9 Merge tag 'devicetree-for-5.12' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d72682d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7a875029a795d230
> dashboard link: https://syzkaller.appspot.com/bug?extid=6987f3b2dbd9eda95f12
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12faef12d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163342ccd00000
>
> The issue was bisected to:
>
> commit 8f014550dfb114cc7f42a517d20d2cf887a0b771
> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> Date:   Tue Jan 26 13:48:14 2021 +0000
>
>     KVM: x86: hyper-v: Make Hyper-V emulation enablement conditional
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10df16a8d00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12df16a8d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14df16a8d00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6987f3b2dbd9eda95f12@syzkaller.appspotmail.com
> Fixes: 8f014550dfb1 ("KVM: x86: hyper-v: Make Hyper-V emulation enablement conditional")
>
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
> general protection fault, probably for non-canonical address 0xdffffc0000000028: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000140-0x0000000000000147]
> CPU: 1 PID: 8370 Comm: syz-executor859 Not tainted 5.11.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:synic_get arch/x86/kvm/hyperv.c:165 [inline]
> RIP: 0010:kvm_hv_set_sint_gsi arch/x86/kvm/hyperv.c:475 [inline]
> RIP: 0010:kvm_hv_irq_routing_update+0x230/0x460 arch/x86/kvm/hyperv.c:498
> Code: 80 19 00 00 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 ff 01 00 00 4d 8b ad 80 19 00 00 49 8d bd 40 01 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 28 84 c0 74 06 0f 8e d2 01 00 00 45 0f b6 bd 40 01 00 00
> RSP: 0018:ffffc90001b3fac0 EFLAGS: 00010206
> RAX: 0000000000000028 RBX: ffff888012df5900 RCX: 0000000000000000
> RDX: ffff888022193780 RSI: ffffffff81174d43 RDI: 0000000000000140
> RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffc900018819eb
> R10: ffffffff81170f3e R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000a73300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557e8c876888 CR3: 0000000013c0b000 CR4: 00000000001526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  kvm_set_irq_routing+0x69b/0x940 arch/x86/kvm/../../../virt/kvm/irqchip.c:223
>  kvm_vm_ioctl+0x12d0/0x2800 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3959
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x43ef29
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe391eb808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ef29
> RDX: 0000000020000140 RSI: 000000004008ae6a RDI: 0000000000000004
> RBP: 0000000000402f10 R08: 0000000000400488 R09: 0000000000400488
> R10: 0000000000400488 R11: 0000000000000246 R12: 0000000000402fa0
> R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
> Modules linked in:
> ---[ end trace 2aa75ec1dd148710 ]---
> RIP: 0010:synic_get arch/x86/kvm/hyperv.c:165 [inline]

Missing check to_hv_vcpu(vcpu) in synic_get(), I will fix it.

> RIP: 0010:kvm_hv_set_sint_gsi arch/x86/kvm/hyperv.c:475 [inline]
> RIP: 0010:kvm_hv_irq_routing_update+0x230/0x460 arch/x86/kvm/hyperv.c:498
> Code: 80 19 00 00 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 ff 01 00 00 4d 8b ad 80 19 00 00 49 8d bd 40 01 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 28 84 c0 74 06 0f 8e d2 01 00 00 45 0f b6 bd 40 01 00 00
> RSP: 0018:ffffc90001b3fac0 EFLAGS: 00010206
> RAX: 0000000000000028 RBX: ffff888012df5900 RCX: 0000000000000000
> RDX: ffff888022193780 RSI: ffffffff81174d43 RDI: 0000000000000140
> RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffc900018819eb
> R10: ffffffff81170f3e R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000a73300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557e8c876888 CR3: 0000000013c0b000 CR4: 00000000001526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
