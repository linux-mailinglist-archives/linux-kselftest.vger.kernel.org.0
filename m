Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073E0325DCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 08:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBZG67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 01:58:59 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46132 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBZG6y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 01:58:54 -0500
Received: by mail-io1-f72.google.com with SMTP id w8so5719096iox.13
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Feb 2021 22:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HvtxSlnkKCjNyZT0wEb2/bz1bqloYHt5btZDhiiQNMw=;
        b=h6+JR2HE2MVRiG8W7vf3hOiU9o9rGNDKrmbipaWUl6DEWbv+r2EfwhrSAHCxlaRRzT
         VFvBUFxYl52x2OYwO+knuiWucznF9sQWBN6XsuUdmlVVrPV+v7WJAgz6RpCCu1LhFaZQ
         B/tDEIrPj3mJAW+TnB69h/QfsoBB3O2OPv7NFRqqoWP19sZYAxW1cA6XzWk7zj75NNAO
         XAVr308UOkid+hkca9DcbavBlEn+3ynwF8Aij6k8OAhuDzCQOqzUrt/d86ZsG0z36yQl
         lIu/9UKIzhLxxJIDATjo9wvZe2iGtPzQNU8p8goCBFTdfTs2w0zCheDp7g3JVLOWLwao
         UyZQ==
X-Gm-Message-State: AOAM5333iBn8SB0gcob/ucax+akFQxBLLVOLJDwhoQIDYyrPd9a/aAvU
        7oaSUN/6h7c7Oz9FCxNRZvOzk/gwwEuvnjfDGjBSnBed4c8Z
X-Google-Smtp-Source: ABdhPJxI+mzmBz1ZfCN/cLim2VzndeY1gOTYkUwCuSZQxW+bnQAaX6rYquy9IfcqPUVm5FDdKSv/xgFFPP6FOCZzWXi7kf3Xvd3b
MIME-Version: 1.0
X-Received: by 2002:a92:6403:: with SMTP id y3mr1283700ilb.90.1614322692653;
 Thu, 25 Feb 2021 22:58:12 -0800 (PST)
Date:   Thu, 25 Feb 2021 22:58:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6093b05bc37caae@google.com>
Subject: general protection fault in kvm_hv_irq_routing_update
From:   syzbot <syzbot+6987f3b2dbd9eda95f12@syzkaller.appspotmail.com>
To:     aaronlewis@google.com, bp@alien8.de, drjones@redhat.com,
        graf@amazon.com, hpa@zytor.com, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, makarandsonare@google.com,
        mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a99163e9 Merge tag 'devicetree-for-5.12' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d72682d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a875029a795d230
dashboard link: https://syzkaller.appspot.com/bug?extid=6987f3b2dbd9eda95f12
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12faef12d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163342ccd00000

The issue was bisected to:

commit 8f014550dfb114cc7f42a517d20d2cf887a0b771
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Tue Jan 26 13:48:14 2021 +0000

    KVM: x86: hyper-v: Make Hyper-V emulation enablement conditional

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10df16a8d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12df16a8d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14df16a8d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6987f3b2dbd9eda95f12@syzkaller.appspotmail.com
Fixes: 8f014550dfb1 ("KVM: x86: hyper-v: Make Hyper-V emulation enablement conditional")

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
general protection fault, probably for non-canonical address 0xdffffc0000000028: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000140-0x0000000000000147]
CPU: 1 PID: 8370 Comm: syz-executor859 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:synic_get arch/x86/kvm/hyperv.c:165 [inline]
RIP: 0010:kvm_hv_set_sint_gsi arch/x86/kvm/hyperv.c:475 [inline]
RIP: 0010:kvm_hv_irq_routing_update+0x230/0x460 arch/x86/kvm/hyperv.c:498
Code: 80 19 00 00 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 ff 01 00 00 4d 8b ad 80 19 00 00 49 8d bd 40 01 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 28 84 c0 74 06 0f 8e d2 01 00 00 45 0f b6 bd 40 01 00 00
RSP: 0018:ffffc90001b3fac0 EFLAGS: 00010206
RAX: 0000000000000028 RBX: ffff888012df5900 RCX: 0000000000000000
RDX: ffff888022193780 RSI: ffffffff81174d43 RDI: 0000000000000140
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffc900018819eb
R10: ffffffff81170f3e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000a73300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557e8c876888 CR3: 0000000013c0b000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kvm_set_irq_routing+0x69b/0x940 arch/x86/kvm/../../../virt/kvm/irqchip.c:223
 kvm_vm_ioctl+0x12d0/0x2800 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3959
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43ef29
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe391eb808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ef29
RDX: 0000000020000140 RSI: 000000004008ae6a RDI: 0000000000000004
RBP: 0000000000402f10 R08: 0000000000400488 R09: 0000000000400488
R10: 0000000000400488 R11: 0000000000000246 R12: 0000000000402fa0
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
Modules linked in:
---[ end trace 2aa75ec1dd148710 ]---
RIP: 0010:synic_get arch/x86/kvm/hyperv.c:165 [inline]
RIP: 0010:kvm_hv_set_sint_gsi arch/x86/kvm/hyperv.c:475 [inline]
RIP: 0010:kvm_hv_irq_routing_update+0x230/0x460 arch/x86/kvm/hyperv.c:498
Code: 80 19 00 00 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 ff 01 00 00 4d 8b ad 80 19 00 00 49 8d bd 40 01 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 28 84 c0 74 06 0f 8e d2 01 00 00 45 0f b6 bd 40 01 00 00
RSP: 0018:ffffc90001b3fac0 EFLAGS: 00010206
RAX: 0000000000000028 RBX: ffff888012df5900 RCX: 0000000000000000
RDX: ffff888022193780 RSI: ffffffff81174d43 RDI: 0000000000000140
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffc900018819eb
R10: ffffffff81170f3e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000a73300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557e8c876888 CR3: 0000000013c0b000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
