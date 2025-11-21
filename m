Return-Path: <linux-kselftest+bounces-46287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7284C7B72C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 20:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781E03A35D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CAB2F5480;
	Fri, 21 Nov 2025 19:12:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6D283FD4
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752331; cv=none; b=qfwa4Jhf5DYEWG9jOmpDL5yrQ0mQskyg2bMaFsfJLSWUwMuZPpp5XgG/EM9j2fG2cbAKvghubsCWUlp45+DUy2lDHztyGbjy1gP3tQFixibrS1fQVOq6pQt9CfqqtYvySDZG7I8BG0jjJsRJgXvqYi43CAUZev5vBwdx2y2GtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752331; c=relaxed/simple;
	bh=KcExuHFbvGVL877GH2Yt2khrOVDDGLD57w4E7G0pbJ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KLTqkzVOASymx9a9h/8d39JqWr29+J6z3EpcQTpGSGgXz48l3bN7EerIy7BP1oPonibi4/39YCD6FKojgpusp3joxlhWqgSUn6/vqETMu1iQ99LPi8jYn1tk6eRFOIZ/z/new0D8bJN2uNKfYSDz8sbVl/T05cNzEDn7kukyT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so23275035ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763752328; x=1764357128;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp1Y/kQiEwJmjqt4ksMcE/EjQXg7HazwT/IxQ4hBf8I=;
        b=T2n3R+RIaR/4NNqjYdv91QnsIW3l2+iKx2SenGHdGYJeLIJntvlQpjup41F92z+ON2
         ioLmPzDP4zGQu9Xnb+87kFC7bp8g3Z/LTKIx8k/kFSd0pvb3OKDPythYsmFnR7lnqRoU
         vK6fSg3yRez509dsp3TW4bVPpKmvCgHMeyWQj+yAUh/6gDppf+8adsvhIKoA2NknkQJB
         joZ/gHhy93L235wXvXVrd33k+4jjxKrMFfujQFiDQx6DVjzhMQmXFtLip2wMzhmce6VA
         IMMVmXsmRptyW498RdpfMQZcpjrhOVw3MTeuUqIiPjdkk0DyKXRMeewdOx83VQ/zGg29
         Wqtg==
X-Forwarded-Encrypted: i=1; AJvYcCUs2Jch671qa57IhEJnCGN+gbp8mNP4SoAR+X0qhFSloMKQwC3nzTSHVq0rUT6Un5RwTG6ySU5u6jVejT3uw0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69zWcmlkKcpSaMlLbwxycCNBSCFPDaeOc1WAclkDJmWvSd8OQ
	h1ZzEW6aJf8tH6WfLBey9kBIyNfZBTtH8y3zAIGwgQFVVGIie8HEf4KMJu0Z3y5I0bVuE5QZxiN
	6A8kJWWpZOGQE14A028/B24p9o/bL++MsC3glQf9X+0SdRiZdTuIzBKxbgtA=
X-Google-Smtp-Source: AGHT+IFriywcA32sdVNGdO/ZtxY4kHcwu0gSYgId74xjiMJPj0Rrq69gYFh/G04n4/3q24gtrfUpvjY0lbuMfLsE+n0R2ka5/Qbs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3:b0:430:d061:d9f7 with SMTP id
 e9e14a558f8ab-435b8e79eb1mr29467535ab.23.1763752328399; Fri, 21 Nov 2025
 11:12:08 -0800 (PST)
Date: Fri, 21 Nov 2025 11:12:08 -0800
In-Reply-To: <20251117110736.293040-1-jiayuan.chen@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6920b988.a70a0220.2ea503.005e.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Fix FIONREAD and copied_seq issues
From: syzbot ci <syzbot+cib6e828d16434909d@syzkaller.appspotmail.com>
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

[v1] bpf: Fix FIONREAD and copied_seq issues
https://lore.kernel.org/all/20251117110736.293040-1-jiayuan.chen@linux.dev
* [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq calculation
* [PATCH bpf-next v1 2/3] bpf, sockmap: Fix FIONREAD for sockmap
* [PATCH bpf-next v1 3/3] bpf, selftest: Add tests for FIONREAD and copied_seq

and found the following issues:
* KASAN: slab-out-of-bounds Read in tcp_ioctl
* KASAN: slab-use-after-free Read in tcp_ioctl

Full report is available here:
https://ci.syzbot.org/series/d61ee16d-47d7-4d43-ae17-0fb7c57066d9

***

KASAN: slab-out-of-bounds Read in tcp_ioctl

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      4722981cca373a338bbcf3a93ecf7144a892b03b
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/41c96565-ad0a-411a-985e-bed590104688/config
C repro:   https://ci.syzbot.org/findings/29a438ed-4757-4e3b-a8ba-f66ae067f793/c_repro
syz repro: https://ci.syzbot.org/findings/29a438ed-4757-4e3b-a8ba-f66ae067f793/syz_repro

==================================================================
BUG: KASAN: slab-out-of-bounds in tcp_ioctl+0x673/0x860 net/ipv4/tcp.c:659
Read of size 2 at addr ffff8881097608f6 by task syz.0.17/5965

CPU: 0 UID: 0 PID: 5965 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
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
 inet6_ioctl+0x204/0x280 net/ipv6/af_inet6.c:590
 sock_do_ioctl+0xdc/0x300 net/socket.c:1254
 sock_ioctl+0x576/0x790 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe4b998f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd756e87d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe4b9be5fa0 RCX: 00007fe4b998f749
RDX: 0000000000000000 RSI: 0000000000008905 RDI: 0000000000000003
RBP: 00007fe4b9a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe4b9be5fa0 R14: 00007fe4b9be5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 5965:
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
 inet6_create+0x7f0/0x1260 net/ipv6/af_inet6.c:193
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

The buggy address belongs to the object at ffff888109760000
 which belongs to the cache UDPv6 of size 2176
The buggy address is located 118 bytes to the right of
 allocated 2176-byte region [ffff888109760000, ffff888109760880)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x109760
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888112b82901
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff88817159e000 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800e000e 00000000f5000000 ffff888112b82901
head: 017ff00000000040 ffff88817159e000 dead000000000122 0000000000000000
head: 0000000000000000 00000000800e000e 00000000f5000000 ffff888112b82901
head: 017ff00000000003 ffffea000425d801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5556, tgid 5556 (dhcpcd), ts 39360973378, free_ts 39270063669
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
 inet6_create+0x7f0/0x1260 net/ipv6/af_inet6.c:193
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
page last free pid 5554 tgid 5554 stack trace:
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
 kmem_cache_alloc_noprof+0x367/0x6e0 mm/slub.c:5295
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2922 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1431
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888109760780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888109760800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888109760880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                             ^
 ffff888109760900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888109760980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


***

KASAN: slab-use-after-free Read in tcp_ioctl

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      4722981cca373a338bbcf3a93ecf7144a892b03b
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/41c96565-ad0a-411a-985e-bed590104688/config
syz repro: https://ci.syzbot.org/findings/c04327b1-fdf2-4b1c-9c19-973a310a26d4/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in tcp_ioctl+0x76d/0x860 net/ipv4/tcp.c:678
Read of size 4 at addr ffff8881023c66e4 by task syz.0.21/6017

CPU: 0 UID: 0 PID: 6017 Comm: syz.0.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 tcp_ioctl+0x76d/0x860 net/ipv4/tcp.c:678
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
RIP: 0033:0x7fd75e18f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd75f094038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd75e3e5fa0 RCX: 00007fd75e18f749
RDX: 0000200000000080 RSI: 000000000000894b RDI: 0000000000000003
RBP: 00007fd75e213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd75e3e6038 R14: 00007fd75e3e5fa0 R15: 00007ffc97663258
 </TASK>

Allocated by task 5843:
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
 inet_ctl_sock_create+0x9a/0x220 net/ipv4/af_inet.c:1632
 igmp_net_init+0xb9/0x150 net/ipv4/igmp.c:3125
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 setup_net+0xfe/0x320 net/core/net_namespace.c:445
 copy_net_ns+0x34e/0x4e0 net/core/net_namespace.c:580
 create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3129
 __do_sys_unshare kernel/fork.c:3200 [inline]
 __se_sys_unshare kernel/fork.c:3198 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3198
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5682:
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
 sock_release+0x85/0x150 net/socket.c:690
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:252
 cleanup_net+0x4d8/0x820 net/core/net_namespace.c:695
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8881023c6600
 which belongs to the cache UDP of size 1984
The buggy address is located 228 bytes inside of
 freed 1984-byte region [ffff8881023c6600, ffff8881023c6dc0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1023c0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888114298b01
anon flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff888104ab6640 0000000000000000 0000000000000001
raw: 0000000000000000 00000000800f000f 00000000f5000000 ffff888114298b01
head: 017ff00000000040 ffff888104ab6640 0000000000000000 0000000000000001
head: 0000000000000000 00000000800f000f 00000000f5000000 ffff888114298b01
head: 017ff00000000003 ffffea000408f001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 4132853290, free_ts 0
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
 ffff8881023c6580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881023c6600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881023c6680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8881023c6700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881023c6780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

