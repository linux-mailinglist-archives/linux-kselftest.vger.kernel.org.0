Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDBB63D37C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiK3KfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 05:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiK3KfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 05:35:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9744645A33;
        Wed, 30 Nov 2022 02:35:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMbF95Gf9z4wgn;
        Wed, 30 Nov 2022 21:35:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1669804512;
        bh=2MrGuwIIFFf8mJjgY+3KK6RoTtnWaC4YdC9C/t0dJp8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=MZz6Vyz4jl/7be4CLSCqS1NokHNG94MkNHF4tEP8RWNQrNXtBfIMQBqudMSGwo8mg
         3oZqIZ8CQubtYrcKyhl7S+v8fgJNf+NrF6aRMcBl3DcSPDjltNLEUXP7UaB1+jsI5e
         bdTkVOO6uRsI+gpCJvN7HXYDsaXKrKE631J7LpxPvOTEyPvfWKuP0cEoI+t5eOlPCz
         clndMy9QGm0t/VEirfX0Ru7fVj3ZxNkeUgnRQIRB8DAE8p2PXlcJM5A9xKJvAnmiQN
         b4dIKQvOE8GAlenAjw76sz6bkv615PzP58HtJ7hJz9AWL3BIVuI75EX3alww0GjANO
         UMkmfYx8b1rzg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     syzbot <syzbot+adec8406ad17413d4c06@syzkaller.appspotmail.com>,
        christophe.leroy@csgroup.eu, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, ye.xingchen@zte.com.cn
Subject: Re: [syzbot] WARNING in btrfs_free_reserved_data_space_noquota
In-Reply-To: <000000000000fac82605ee97fb72@google.com>
References: <000000000000fac82605ee97fb72@google.com>
Date:   Wed, 30 Nov 2022 21:35:09 +1100
Message-ID: <87bkoobuhu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

syzbot <syzbot+adec8406ad17413d4c06@syzkaller.appspotmail.com> writes:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b7b275e60bcd Linux 6.1-rc7
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=158a7b73880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=adec8406ad17413d4c06
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169ccb75880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bf7153880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/5423c2d2ad62/mount_0.gz
>
> The issue was bisected to:
>
> commit c814bf958926ff45a9c1e899bd001006ab6cfbae
> Author: ye xingchen <ye.xingchen@zte.com.cn>
> Date:   Tue Aug 16 10:51:06 2022 +0000
>
>     powerpc/selftests: Use timersub() for gettimeofday()

That can't be right, that patch only touches
tools/testing/selftests/powerpc/benchmarks/gettimeofday.c which isn't
built into vmlinux - and definitely not for an x86 build.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118c3d03880000

This says:
  Reproducer flagged being flaky

AFAICS there isn't a syzbot command to ask for a new bisection, so
someone will have to do it manually.

cheers

> final oops:     https://syzkaller.appspot.com/x/report.txt?x=138c3d03880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=158c3d03880000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+adec8406ad17413d4c06@syzkaller.appspotmail.com
> Fixes: c814bf958926 ("powerpc/selftests: Use timersub() for gettimeofday()")
>
> RDX: 0000000000000001 RSI: 0000000020000280 RDI: 0000000000000005
> RBP: 00007ffd32e91c70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000006
> R13: 00007ffd32e91cb0 R14: 00007ffd32e91c90 R15: 0000000000000006
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3764 at fs/btrfs/space-info.h:122 btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> WARNING: CPU: 1 PID: 3764 at fs/btrfs/space-info.h:122 btrfs_free_reserved_data_space_noquota+0x219/0x2b0 fs/btrfs/delalloc-space.c:179
> Modules linked in:
> CPU: 1 PID: 3764 Comm: syz-executor759 Not tainted 6.1.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:122 [inline]
> RIP: 0010:btrfs_space_info_free_bytes_may_use fs/btrfs/space-info.h:154 [inline]
> RIP: 0010:btrfs_free_reserved_data_space_noquota+0x219/0x2b0 fs/btrfs/delalloc-space.c:179
> Code: 2f 00 74 08 4c 89 ef e8 b5 98 32 fe 49 8b 5d 00 48 89 df 4c 8b 74 24 08 4c 89 f6 e8 21 81 de fd 4c 39 f3 73 16 e8 d7 7e de fd <0f> 0b 31 db 4c 8b 34 24 41 80 3c 2f 00 75 8c eb 92 e8 c1 7e de fd
> RSP: 0018:ffffc9000443f410 EFLAGS: 00010293
> RAX: ffffffff83ac1919 RBX: 00000000005cb000 RCX: ffff888027989d40
> RDX: 0000000000000000 RSI: 0000000000800000 RDI: 00000000005cb000
> RBP: dffffc0000000000 R08: ffffffff83ac190f R09: fffffbfff1cebe0e
> R10: fffffbfff1cebe0e R11: 1ffffffff1cebe0d R12: ffff8880774f3800
> R13: ffff8880774f3860 R14: 0000000000800000 R15: 1ffff1100ee9e70c
> FS:  0000555555aaa300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0d98f20140 CR3: 0000000025ccf000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  btrfs_free_reserved_data_space+0x9d/0xd0 fs/btrfs/delalloc-space.c:199
>  btrfs_dio_iomap_begin+0x8f7/0x1070 fs/btrfs/inode.c:7762
>  iomap_iter+0x606/0x8a0 fs/iomap/iter.c:74
>  __iomap_dio_rw+0xd91/0x20d0 fs/iomap/direct-io.c:601
>  btrfs_dio_write+0x9c/0xe0 fs/btrfs/inode.c:8094
>  btrfs_direct_write fs/btrfs/file.c:1835 [inline]
>  btrfs_do_write_iter+0x871/0x1260 fs/btrfs/file.c:1980
>  do_iter_write+0x6c2/0xc20 fs/read_write.c:861
>  vfs_writev fs/read_write.c:934 [inline]
>  do_pwritev+0x200/0x350 fs/read_write.c:1031
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0d98ea8ea9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd32e91c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0d98ea8ea9
> RDX: 0000000000000001 RSI: 0000000020000280 RDI: 0000000000000005
> RBP: 00007ffd32e91c70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008000000 R11: 0000000000000246 R12: 0000000000000006
> R13: 00007ffd32e91cb0 R14: 00007ffd32e91c90 R15: 0000000000000006
>  </TASK>
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
