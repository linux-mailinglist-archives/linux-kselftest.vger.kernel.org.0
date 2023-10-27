Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61BC7DA231
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 23:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346489AbjJ0VLi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0VLh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 17:11:37 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36001AA
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 14:11:33 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1e9a324c12fso3363292fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 14:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441093; x=1699045893;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNoZbYOlIv4dyVECabePIdfIGgk1r4UtAtMGjjVpRNw=;
        b=vWH6YE0vGsGT5CeoARnkJLJbIiYRkywGER1R1ZeTjX8aza4ogGHo/Aak6kjsINqcMB
         UxD0r8dVpgxZHgrSrxs+AT4sgQBbdEJ04icGUDe6o3ypPCawGjPHz4dtFVvCNf+V2Dke
         krdfBM6UC38Z2Y0q1SNHsUWFan8Tj3+YfJOUnKYij9pitnC6naJZ/VkieKRnNIKgImad
         4HsXx/C6R9FRUE6Mgfk414UBbT0w1DWHz88qb7EgMWwUegH6dbfEhBO/VoUeEskZOkGh
         6QqCH0IpjbAhpsG+Nawerzv48oOouE+9BFp7+s4mPTfUghieR5VPc++kGnjfRVnfn2JF
         QUwQ==
X-Gm-Message-State: AOJu0YzYC7zi5aOs8wgR842ET+uLJaDqKD/MHViiJH7EafEbuEqXG+0o
        rpdx78gacjmtnx4W/OVFF9WudD0kiZqQw1yik87MiUqlxa77
X-Google-Smtp-Source: AGHT+IH06TV5SQyMqhA2mNC4y+hknxuwnXBpa/QpZXKpAS9AmewD3C85Wv4DRshK3H2WdohHy6Vkol6zFWtyvveMauf8dbuIzWlC
MIME-Version: 1.0
X-Received: by 2002:a05:6870:304d:b0:1c0:e7d3:3b2d with SMTP id
 u13-20020a056870304d00b001c0e7d33b2dmr1720601oau.7.1698441093050; Fri, 27 Oct
 2023 14:11:33 -0700 (PDT)
Date:   Fri, 27 Oct 2023 14:11:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005f6aa0608b9220f@google.com>
Subject: [syzbot] [iommu?] divide error in iommufd_test
From:   syzbot <syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com>
To:     iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
        joao.m.martins@oracle.com, joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e8361b005d7c Add linux-next specific files for 20231023
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e4cb83680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e8fc3570ec9a74
dashboard link: https://syzkaller.appspot.com/bug?extid=25dc7383c30ecdc83c38
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bad5d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1062e393680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e28a7944599e/disk-e8361b00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7dd355dbe055/vmlinux-e8361b00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7b2a9050635d/bzImage-e8361b00.xz

The issue was bisected to:

commit 5e054083ce6929b567c6aadbf8bf627b0f028353
Author: Joao Martins <joao.m.martins@oracle.com>
Date:   Fri Oct 20 22:28:02 2023 +0000

    iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a49a35680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a49a35680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a49a35680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25dc7383c30ecdc83c38@syzkaller.appspotmail.com
Fixes: 5e054083ce69 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5053 Comm: syz-executor178 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:iommufd_test_dirty drivers/iommu/iommufd/selftest.c:1098 [inline]
RIP: 0010:iommufd_test+0x1fd/0x35c0 drivers/iommu/iommufd/selftest.c:1203
Code: 04 02 48 89 4c 24 28 84 c0 74 09 3c 03 7f 05 e8 69 ac 2f fd 48 8b 04 24 31 d2 31 ff 48 8b 5c 24 20 44 8b 68 08 48 8b 44 24 28 <48> f7 f3 48 89 d5 48 89 d6 e8 85 cf d8 fc 48 85 ed 0f 85 ce 22 00
RSP: 0018:ffffc90003937cb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff84affaf2 RDI: 0000000000000000
RBP: 000000000000000d R08: 0000000000000005 R09: 000000000000000d
R10: 000000000000000d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90003937e40 R15: ffffc90003937e00
FS:  00005555560d7380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020006000 CR3: 0000000075a85000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_fops_ioctl+0x35a/0x4e0 drivers/iommu/iommufd/main.c:404
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f5fb02172e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd74d26068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd74d26238 RCX: 00007f5fb02172e9
RDX: 0000000020000140 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 00007f5fb028a610 R08: 0000000000000000 R09: 00007ffd74d26238
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd74d26228 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iommufd_test_dirty drivers/iommu/iommufd/selftest.c:1098 [inline]
RIP: 0010:iommufd_test+0x1fd/0x35c0 drivers/iommu/iommufd/selftest.c:1203
Code: 04 02 48 89 4c 24 28 84 c0 74 09 3c 03 7f 05 e8 69 ac 2f fd 48 8b 04 24 31 d2 31 ff 48 8b 5c 24 20 44 8b 68 08 48 8b 44 24 28 <48> f7 f3 48 89 d5 48 89 d6 e8 85 cf d8 fc 48 85 ed 0f 85 ce 22 00
RSP: 0018:ffffc90003937cb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff84affaf2 RDI: 0000000000000000
RBP: 000000000000000d R08: 0000000000000005 R09: 000000000000000d
R10: 000000000000000d R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90003937e40 R15: ffffc90003937e00
FS:  00005555560d7380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020006000 CR3: 0000000075a85000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	04 02                	add    $0x2,%al
   2:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   7:	84 c0                	test   %al,%al
   9:	74 09                	je     0x14
   b:	3c 03                	cmp    $0x3,%al
   d:	7f 05                	jg     0x14
   f:	e8 69 ac 2f fd       	call   0xfd2fac7d
  14:	48 8b 04 24          	mov    (%rsp),%rax
  18:	31 d2                	xor    %edx,%edx
  1a:	31 ff                	xor    %edi,%edi
  1c:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  21:	44 8b 68 08          	mov    0x8(%rax),%r13d
  25:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
* 2a:	48 f7 f3             	div    %rbx <-- trapping instruction
  2d:	48 89 d5             	mov    %rdx,%rbp
  30:	48 89 d6             	mov    %rdx,%rsi
  33:	e8 85 cf d8 fc       	call   0xfcd8cfbd
  38:	48 85 ed             	test   %rbp,%rbp
  3b:	0f                   	.byte 0xf
  3c:	85 ce                	test   %ecx,%esi
  3e:	22 00                	and    (%rax),%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
