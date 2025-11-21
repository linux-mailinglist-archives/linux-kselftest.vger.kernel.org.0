Return-Path: <linux-kselftest+bounces-46204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC1EC780DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 10:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5DA652A2BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3991F33CEBC;
	Fri, 21 Nov 2025 09:10:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B1335BB2
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716204; cv=none; b=BXFCUkf5JDbvZVS0Jwd9cqkCEQdcqfuXflyf5aG5osF51wE5ksp1+Nm/TsXh2Cfar6ZXRqBVjoRWtoCECEon2VNR5grgnGwd2hn28XWYdFbizMAJ0Pvfc+LJkPIQX5Ti/fON6tkPCXS6Rc9DCk/Ih3+1wTmIIkSUlHciMtrxhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716204; c=relaxed/simple;
	bh=vg79M219XGGLpOOCD3nggj7szuXZ71qPwLq1kIfIqhQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OqyO/g1Ed1z3WWyFc2rZgnr4PRSMIHvDetntIoDYSq5SbWRX6+eeSiw1FW7UMN1HbV7gvux1CC+jJmN6u975pHJuP1ul3FkiMsKjpUS1IdTQ8gZMlM8I4EUCad6YYrixO57XovLl0T+KgFs0jQY9ATdSIFvpuxE83e1WeSq95MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43322b98837so20830235ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 01:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716200; x=1764321000;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWuLSidvvnSvw4YAymo7D+BvHgPZyOyhKpbKdP3J5D0=;
        b=eI5JeBquuSx0EzoGrG9U660ZnqNOkMMI0NBhfqCC8WQDX/zl8UP/Fnk//1ovvHm8w5
         bFGmOHqaSpL9GzXisdwZf9Z5acrbrFiqagnEYM6/BspQBMUalm9OvyEPzecVfGrbVhVt
         hgAkgP+qPIbDuoC7YTM1qcSJSjE1mbMeg9tm2Xd+kRKem+sNoOy9jojAzrSvn0XHT74m
         qNSEMMq8U+sNznv42LVVBwjdyZybOJgmxDPxUnAJN9JSHT2r5jYVLnEKxY194xqL7PJV
         EGbUsRLmBlSZJN+6leCYAf7t0LOIR7m+esHi6sRNVRi2nUTDvK5otum8fF/FjRCyb0ux
         ebbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu17bCVw3WRDa+uYaO/HRi71fJ/mHuQXlGEz0UA0McWf6YV5zBS2PPkAH37lVl7Pj4SucZ41+aeAPXbv7mukc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOu/R5UIrzEUWGnxpRHPUJg1ZjcgmE+94HU8aitPi5DEujRbGS
	ml84j958wqAJnzLEbFCMr9BPk4TKWyVFpsaCd/ckdSZeQte5yMUdMkH6JewBf+YCQILlw5ogAg9
	g2nV6EZ9OXatZFM8wvDKwV8AUvbvsHgRsO1kVSZ8DXJ4cxmTMJWPAz7z+nh8=
X-Google-Smtp-Source: AGHT+IEUEmrVne+AgiXYsuAf4E5ga36x2J+6fu6B3ByvZ1aB8sG9KDXXOwAIfZzlQN+/SSI4rzt0zX4d8/S9X3LVzEu6GK+fLqsU
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3784:b0:433:73c8:526a with SMTP id
 e9e14a558f8ab-435b986ab6fmr10786735ab.16.1763716200057; Fri, 21 Nov 2025
 01:10:00 -0800 (PST)
Date: Fri, 21 Nov 2025 01:10:00 -0800
In-Reply-To: <20251121030013.60133-1-jiayuan.chen@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69202c68.a70a0220.2ea503.0049.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Fix FIONREAD and copied_seq issues
From: syzbot ci <syzbot+ci899cbcced7549398@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	cong.wang@bytedance.com, daniel@iogearbox.net, davem@davemloft.net, 
	dsahern@kernel.org, eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, 
	horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mhal@rbox.co, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, sgarzare@redhat.com, shuah@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] bpf: Fix FIONREAD and copied_seq issues
https://lore.kernel.org/all/20251121030013.60133-1-jiayuan.chen@linux.dev
* [PATCH bpf-next v2 1/3] bpf, sockmap: Fix incorrect copied_seq calculation
* [PATCH bpf-next v2 2/3] bpf, sockmap: Fix FIONREAD for sockmap
* [PATCH bpf-next v2 3/3] bpf, selftest: Add tests for FIONREAD and copied_seq

and found the following issues:
* KASAN: slab-out-of-bounds Read in tcp_ioctl
* KASAN: slab-use-after-free Read in tcp_ioctl
* SYZFAIL: failed to recv rpc
* WARNING in sk_psock_destroy

Full report is available here:
https://ci.syzbot.org/series/2dc8b7c6-6074-4e9e-a56e-dc5f34e678db

***

KASAN: slab-out-of-bounds Read in tcp_ioctl

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      4722981cca373a338bbcf3a93ecf7144a892b03b
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/ffa9b2b0-ceb4-4d19-bc45-58475d561b3b/config
syz repro: https://ci.syzbot.org/findings/5fbc614a-9eb9-426b-96c5-1f69b6874e56/syz_repro

==================================================================
BUG: KASAN: slab-out-of-bounds in tcp_ioctl+0x673/0x860 net/ipv4/tcp.c:659
Read of size 2 at addr ffff8881114d5df6 by task syz.2.19/6006

CPU: 0 UID: 0 PID: 6006 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 tcp_ioctl+0x673/0x860 net/ipv4/tcp.c:659
 sock_ioctl_out net/core/sock.c:4392 [inline]
 sk_ioctl+0x3c7/0x600 net/core/sock.c:4420
 inet_ioctl+0x416/0x4c0 net/ipv4/af_inet.c:1007
 sock_do_ioctl+0xdc/0x300 net/socket.c:1254
 sock_ioctl+0x576/0x790 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f472558f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f472647a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f47257e5fa0 RCX: 00007f472558f6c9
RDX: 0000000000000000 RSI: 0000000000008905 RDI: 0000000000000004
RBP: 00007f4725611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f47257e6038 R14: 00007f47257e5fa0 R15: 00007ffcbb3f8478
 </TASK>

The buggy address belongs to the object at ffff8881114d5d80
 which belongs to the cache UDP of size 1984
The buggy address is located 118 bytes inside of
 allocated 1984-byte region [ffff8881114d5d80, ffff8881114d6540)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1114d0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88811112a501
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff888105697000 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800f000f 00000000f5000000 ffff88811112a501
head: 017ff00000000040 ffff888105697000 dead000000000122 0000000000000000
head: 0000000000000000 00000000800f000f 00000000f5000000 ffff88811112a501
head: 017ff00000000003 ffffea0004453401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5847, tgid 5847 (syz-executor), ts 60144423433, free_ts 60089454561
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3232
 new_slab mm/slub.c:3286 [inline]
 ___slab_alloc+0xf56/0x1990 mm/slub.c:4655
 __slab_alloc+0x65/0x100 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 kmem_cache_alloc_noprof+0x3f9/0x6e0 mm/slub.c:5295
 sk_prot_alloc+0x57/0x220 net/core/sock.c:2233
 sk_alloc+0x3a/0x370 net/core/sock.c:2295
 inet_create+0x7a0/0x1000 net/ipv4/af_inet.c:328
 __sock_create+0x4b3/0x9f0 net/socket.c:1605
 udp_sock_create4+0xbe/0x4b0 net/ipv4/udp_tunnel_core.c:19
 udp_sock_create include/net/udp_tunnel.h:59 [inline]
 wg_socket_init+0x4e5/0xa60 drivers/net/wireguard/socket.c:387
 wg_open+0x24f/0x420 drivers/net/wireguard/device.c:51
 __dev_open+0x470/0x880 net/core/dev.c:1682
page last free pid 5847 tgid 5847 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 discard_slab mm/slub.c:3330 [inline]
 __put_partials+0x146/0x170 mm/slub.c:3876
 put_cpu_partial+0x1f2/0x2e0 mm/slub.c:3951
 __slab_free+0x2b9/0x390 mm/slub.c:5929
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 __do_kmalloc_node mm/slub.c:5649 [inline]
 __kmalloc_noprof+0x3c3/0x7f0 mm/slub.c:5662
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 fib_create_info+0x172d/0x3210 net/ipv4/fib_semantics.c:1402
 fib_table_insert+0xc6/0x1b50 net/ipv4/fib_trie.c:1212
 fib_magic+0x2c4/0x390 net/ipv4/fib_frontend.c:1134
 fib_add_ifaddr+0x144/0x5f0 net/ipv4/fib_frontend.c:1156
 fib_netdev_event+0x382/0x490 net/ipv4/fib_frontend.c:1516
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9705

Memory state around the buggy address:
 ffff8881114d5c80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff8881114d5d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881114d5d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                             ^
 ffff8881114d5e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881114d5e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


***

KASAN: slab-use-after-free Read in tcp_ioctl

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      4722981cca373a338bbcf3a93ecf7144a892b03b
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/ffa9b2b0-ceb4-4d19-bc45-58475d561b3b/config
C repro:   https://ci.syzbot.org/findings/956fd3c8-f06a-44eb-b0ff-510a6c8b378d/c_repro
syz repro: https://ci.syzbot.org/findings/956fd3c8-f06a-44eb-b0ff-510a6c8b378d/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in tcp_ioctl+0x673/0x860 net/ipv4/tcp.c:659
Read of size 2 at addr ffff888101fe3bf6 by task syz.0.17/5959

CPU: 1 UID: 0 PID: 5959 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 tcp_ioctl+0x673/0x860 net/ipv4/tcp.c:659
 sock_ioctl_out net/core/sock.c:4392 [inline]
 sk_ioctl+0x3c7/0x600 net/core/sock.c:4420
 inet_ioctl+0x416/0x4c0 net/ipv4/af_inet.c:1007
 sock_do_ioctl+0xdc/0x300 net/socket.c:1254
 sock_ioctl+0x576/0x790 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a1458f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a1545b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4a147e5fa0 RCX: 00007f4a1458f6c9
RDX: 0000000000000000 RSI: 0000000000008905 RDI: 0000000000000004
RBP: 00007f4a14611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4a147e6038 R14: 00007f4a147e5fa0 R15: 00007ffef33173a8
 </TASK>

Allocated by task 5926:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_noprof+0x367/0x6e0 mm/slub.c:5295
 sk_prot_alloc+0x57/0x220 net/core/sock.c:2233
 sk_alloc+0x3a/0x370 net/core/sock.c:2295
 inet_create+0x7a0/0x1000 net/ipv4/af_inet.c:328
 __sock_create+0x4b3/0x9f0 net/socket.c:1605
 sock_create net/socket.c:1663 [inline]
 __sys_socket_create net/socket.c:1700 [inline]
 __sys_socket+0xd7/0x1b0 net/socket.c:1747
 __do_sys_socket net/socket.c:1761 [inline]
 __se_sys_socket net/socket.c:1759 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1759
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5926:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2543 [inline]
 slab_free mm/slub.c:6642 [inline]
 kmem_cache_free+0x19b/0x690 mm/slub.c:6752
 sk_prot_free net/core/sock.c:2276 [inline]
 __sk_destruct+0x4d2/0x660 net/core/sock.c:2373
 inet_release+0x144/0x190 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0xc3/0x240 net/socket.c:1455
 __fput+0x44c/0xa70 fs/file_table.c:468
 fput_close_sync+0x119/0x200 fs/file_table.c:573
 __do_sys_close fs/open.c:1589 [inline]
 __se_sys_close fs/open.c:1574 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1574
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888101fe3b80
 which belongs to the cache UDP of size 1984
The buggy address is located 118 bytes inside of
 freed 1984-byte region [ffff888101fe3b80, ffff888101fe4340)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x101fe0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8881086b4301
anon flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff888160ef5b40 0000000000000000 0000000000000001
raw: 0000000000000000 00000000800f000f 00000000f5000000 ffff8881086b4301
head: 017ff00000000040 ffff888160ef5b40 0000000000000000 0000000000000001
head: 0000000000000000 00000000800f000f 00000000f5000000 ffff8881086b4301
head: 017ff00000000003 ffffea000407f801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 3581320107, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3232
 new_slab mm/slub.c:3286 [inline]
 ___slab_alloc+0xf56/0x1990 mm/slub.c:4655
 __slab_alloc+0x65/0x100 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 kmem_cache_alloc_noprof+0x3f9/0x6e0 mm/slub.c:5295
 sk_prot_alloc+0x57/0x220 net/core/sock.c:2233
 sk_alloc+0x3a/0x370 net/core/sock.c:2295
 inet_create+0x7a0/0x1000 net/ipv4/af_inet.c:328
 __sock_create+0x4b3/0x9f0 net/socket.c:1605
 inet_ctl_sock_create+0x9a/0x220 net/ipv4/af_inet.c:1632
 igmp_net_init+0xb9/0x150 net/ipv4/igmp.c:3125
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 __register_pernet_operations net/core/net_namespace.c:1314 [inline]
 register_pernet_operations+0x336/0x800 net/core/net_namespace.c:1391
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888101fe3a80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff888101fe3b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888101fe3b80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff888101fe3c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888101fe3c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

SYZFAIL: failed to recv rpc

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      4722981cca373a338bbcf3a93ecf7144a892b03b
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/ffa9b2b0-ceb4-4d19-bc45-58475d561b3b/config
C repro:   https://ci.syzbot.org/findings/f3ffc26d-6509-4e92-92bd-bfa118ae72e6/c_repro
syz repro: https://ci.syzbot.org/findings/f3ffc26d-6509-4e92-92bd-bfa118ae72e6/syz_repro

SYZFAIL: failed to recv rpc
fd=3 want=4 recv=0 n=0 (errno 9: Bad file descriptor)


***

WARNING in sk_psock_destroy

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      4722981cca373a338bbcf3a93ecf7144a892b03b
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/ffa9b2b0-ceb4-4d19-bc45-58475d561b3b/config
C repro:   https://ci.syzbot.org/findings/a13957c4-d51a-4472-ab31-37d57484d32e/c_repro
syz repro: https://ci.syzbot.org/findings/a13957c4-d51a-4472-ab31-37d57484d32e/syz_repro

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5871 at net/core/skmsg.c:828 __sk_psock_purge_ingress_msg net/core/skmsg.c:828 [inline]
WARNING: CPU: 0 PID: 5871 at net/core/skmsg.c:828 __sk_psock_zap_ingress net/core/skmsg.c:839 [inline]
WARNING: CPU: 0 PID: 5871 at net/core/skmsg.c:828 sk_psock_destroy+0xa24/0xaa0 net/core/skmsg.c:871
Modules linked in:
CPU: 0 UID: 0 PID: 5871 Comm: kworker/0:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events sk_psock_destroy
RIP: 0010:__sk_psock_purge_ingress_msg net/core/skmsg.c:828 [inline]
RIP: 0010:__sk_psock_zap_ingress net/core/skmsg.c:839 [inline]
RIP: 0010:sk_psock_destroy+0xa24/0xaa0 net/core/skmsg.c:871
Code: e8 51 78 7c f8 85 ed 7e 29 e8 08 74 7c f8 48 89 df 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d e9 32 e7 d6 f8 e8 ed 73 7c f8 90 <0f> 0b 90 e9 3f fb ff ff e8 df 73 7c f8 4c 89 f7 be 03 00 00 00 e8
RSP: 0018:ffffc900044679f0 EFLAGS: 00010293
RAX: ffffffff894392d3 RBX: dffffc0000000000 RCX: ffff88810f218000
RDX: 0000000000000000 RSI: 0000000000022fe0 RDI: 0000000000000000
RBP: ffff88810ba8b000 R08: ffffffff8f7cee77 R09: 1ffffffff1ef9dce
R10: dffffc0000000000 R11: fffffbfff1ef9dcf R12: ffff88810ba890c0
R13: dead000000000100 R14: 0000000000022fe0 R15: ffff88810ba890c0
FS:  0000000000000000(0000) GS:ffff88818eb38000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0002a58f8 CR3: 000000000dd38000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

