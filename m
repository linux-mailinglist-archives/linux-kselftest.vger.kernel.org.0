Return-Path: <linux-kselftest+bounces-47242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754BACABAFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 00:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA537300307F
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6DA2EA490;
	Sun,  7 Dec 2025 23:54:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7052AD37
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Dec 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765151654; cv=none; b=I+DVEQzAUCCE49O6hf3Ae9jVx+jPdfXWd4GjwlL6NaSYuivDyPntqdwBlzpMLzkwyYgoMXLL3jJK560UtoWT1cPbThADZ9pXXzn7VqyffhJ94w/R0rvu7MZFLByK+g4KDKrxCJH/QF1vQUwQaSPaurseM3HMhkpzjZlQKJQ9Uqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765151654; c=relaxed/simple;
	bh=nv1gsi2cXg2zquMpGiktATH8eIesuNYvo+pt5FJtTJY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EycecX11/cvn6XegCvq95rF7Oq2KoflVSw56SIKAyrFdNcw/5mBalKgKBjZAq45+TpBYPXM70zuYh+okTl0760L23BhofqFJz3EXKxoXeJi0TQCSALNur3ml18DfSYTOVf572Hot7lO5HN9eofcMi3n4ifoxs1X/B0ZRAloq0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7c754daf77fso8089688a34.1
        for <linux-kselftest@vger.kernel.org>; Sun, 07 Dec 2025 15:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765151651; x=1765756451;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7wdWkNBJWleX7uoFqe/knQBz9xdh8YJqkyMR5oAQ+k=;
        b=hbgPHfxvrkKeqr2fBFCPwQec2TTe+vImOM4GUSLH5QQFkK0j41JIr4ws/ILyWs315C
         sOx+8uQ9aDwYwO10YndU7AXpdG/P5E8S1HXNRSAudAjqoLogW1PzlVWu1/f5epsb2tU2
         jB2QMo+GizWXnQjjRQ8j/cg/81zTPowp/8BR+V22z85titw1hqqW9Rbpqn8QUiHozWne
         NkcUjE/brqZtBKWuDxIcBY1svHJfXd7gSg4xeESHlTqEyq+m3tGRhkOIzn45pUtvRHHB
         tg6ag0s+zYEBcEkorKyoS80PI3X2r3861WI/duYhg7iB74ARo4+upRB48Xgoza0PflKt
         hZSw==
X-Forwarded-Encrypted: i=1; AJvYcCVjbcJvMsuZXCOFzsqLFLDvDRRc89B6BN2mA7zDQPXBUMLgQUDQBS3TogxXzPc+8EllPTSSUku051TnGkwugqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbJMrbqQm7ImEfiTDNKiNUDz4UD/wjibp2YzzV5l1D8G2nCl7
	+xjJ3/huU89s4LCbS6boD1ZHqtIL9YU1p1I7h0GkPM6YEVXSU4nX6EEcCB7fkQJ1yQcyRfTqOuR
	8wisQ0eZhsD14jh9kIG0sOGqkwyDHwQbp6WKW+jgg4ymRhHZdEiwZqEwSNKY=
X-Google-Smtp-Source: AGHT+IEfkFWdVf2eVX44aHK5fDneLUmME7ewRc7OqS0aMUmGkEo3JkMH766Mb/Bqa6CDr1Vm0EgtFD0Om0pMHzt73d/7hGKT3udg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6101:b0:659:9a49:8e31 with SMTP id
 006d021491bc7-6599a499e45mr2033523eaf.35.1765151651670; Sun, 07 Dec 2025
 15:54:11 -0800 (PST)
Date: Sun, 07 Dec 2025 15:54:11 -0800
In-Reply-To: <20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693613a3.a70a0220.38f243.0071.GAE@google.com>
Subject: [syzbot ci] Re: Add IP6IP6 flowtable SW acceleration
From: syzbot ci <syzbot+ci57ebb75c98bab786@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, fw@strlen.de, horms@kernel.org, kadlec@netfilter.org, 
	kuba@kernel.org, linux-kselftest@vger.kernel.org, lorenzo@kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, phil@nwl.cc, shuah@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] Add IP6IP6 flowtable SW acceleration
https://lore.kernel.org/all/20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org
* [PATCH nf-next 1/5] netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
* [PATCH nf-next 2/5] netfilter: Modify nf_flow_skb_encap_protocol() to return int intead of bool
* [PATCH nf-next 3/5] netfilter: flowtable: Add IP6IP6 rx sw acceleration
* [PATCH nf-next 4/5] netfilter: flowtable: Add IP6IP6 tx sw acceleration
* [PATCH nf-next 5/5] selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest

and found the following issues:
* KASAN: slab-use-after-free Read in nf_flow_skb_encap_protocol
* general protection fault in ipv6_frag_rcv
* general protection fault in nf_flow_offload_ipv6_hook

Full report is available here:
https://ci.syzbot.org/series/24632ec9-06ab-4e09-8015-19822d83c6a9

***

KASAN: slab-use-after-free Read in nf_flow_skb_encap_protocol

tree:      nf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netfilter/nf-next.git
base:      ff736a286116d462a4067ba258fa351bc0b4ed80
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/833219cc-e7e2-437d-b31c-1eb3666c1e93/config
C repro:   https://ci.syzbot.org/findings/afcab565-801f-4cde-a1c5-b1d327537871/c_repro
syz repro: https://ci.syzbot.org/findings/afcab565-801f-4cde-a1c5-b1d327537871/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in nf_flow_ip6_tunnel_proto net/netfilter/nf_flow_table_ip.c:388 [inline]
BUG: KASAN: slab-use-after-free in nf_flow_skb_encap_protocol+0x13a2/0x1540 net/netfilter/nf_flow_table_ip.c:438
Read of size 2 at addr ffff888175605eb6 by task syz.1.20/6010

CPU: 1 UID: 0 PID: 6010 Comm: syz.1.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 nf_flow_ip6_tunnel_proto net/netfilter/nf_flow_table_ip.c:388 [inline]
 nf_flow_skb_encap_protocol+0x13a2/0x1540 net/netfilter/nf_flow_table_ip.c:438
 nf_flow_offload_ipv6_lookup net/netfilter/nf_flow_table_ip.c:1074 [inline]
 nf_flow_offload_ipv6_hook+0x13c/0x32a0 net/netfilter/nf_flow_table_ip.c:1102
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
 nf_ingress net/core/dev.c:5900 [inline]
 __netif_receive_skb_core+0x241c/0x2f90 net/core/dev.c:5996
 __netif_receive_skb_one_core net/core/dev.c:6135 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6250
 netif_receive_skb_internal net/core/dev.c:6336 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6395
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53b9d8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f53babe6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f53b9fe6090 RCX: 00007f53b9d8f7c9
RDX: 000000000000fdef RSI: 0000200000000340 RDI: 0000000000000003
RBP: 00007f53b9df297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f53b9fe6128 R14: 00007f53b9fe6090 R15: 00007ffc1b120a08
 </TASK>

Allocated by task 6010:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_node_noprof+0x433/0x710 mm/slub.c:5340
 __alloc_skb+0x255/0x430 net/core/skbuff.c:679
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xca/0x890 net/core/skbuff.c:6712
 sock_alloc_send_pskb+0x84d/0x980 net/core/sock.c:2995
 tun_alloc_skb drivers/net/tun.c:1461 [inline]
 tun_get_user+0xa43/0x3e90 drivers/net/tun.c:1794
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6010:
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
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 kfree_skb include/linux/skbuff.h:1331 [inline]
 dst_discard_out+0x1c/0x30 net/core/dst.c:32
 nf_flow_ip6_tunnel_proto net/netfilter/nf_flow_table_ip.c:383 [inline]
 nf_flow_skb_encap_protocol+0x9c2/0x1540 net/netfilter/nf_flow_table_ip.c:438
 nf_flow_offload_ipv6_lookup net/netfilter/nf_flow_table_ip.c:1074 [inline]
 nf_flow_offload_ipv6_hook+0x13c/0x32a0 net/netfilter/nf_flow_table_ip.c:1102
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
 nf_ingress net/core/dev.c:5900 [inline]
 __netif_receive_skb_core+0x241c/0x2f90 net/core/dev.c:5996
 __netif_receive_skb_one_core net/core/dev.c:6135 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6250
 netif_receive_skb_internal net/core/dev.c:6336 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6395
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888175605e00
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 182 bytes inside of
 freed 240-byte region [ffff888175605e00, ffff888175605ef0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x175604
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff8881036c4a00 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff8881036c4a00 dead000000000122 0000000000000000
head: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 057ff00000000001 ffffea0005d58101 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5922, tgid 5922 (syz-executor), ts 68256102142, free_ts 61484167308
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1845
 prep_new_page mm/page_alloc.c:1853 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3879
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5178
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3232
 new_slab mm/slub.c:3286 [inline]
 ___slab_alloc+0xf56/0x1990 mm/slub.c:4655
 __slab_alloc+0x65/0x100 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 kmem_cache_alloc_node_noprof+0x4c5/0x710 mm/slub.c:5340
 __alloc_skb+0x255/0x430 net/core/skbuff.c:679
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 inet_ifmcaddr_notify+0x7e/0x150 net/ipv4/igmp.c:1481
 ____ip_mc_inc_group+0x9b8/0xde0 net/ipv4/igmp.c:1564
 __ip_mc_inc_group net/ipv4/igmp.c:1573 [inline]
 ip_mc_inc_group net/ipv4/igmp.c:1579 [inline]
 ip_mc_up+0x125/0x300 net/ipv4/igmp.c:1880
 inetdev_event+0xfb3/0x15b0 net/ipv4/devinet.c:1630
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9802
page last free pid 5811 tgid 5811 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2901
 __slab_free+0x2e7/0x390 mm/slub.c:5970
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_noprof+0x367/0x6e0 mm/slub.c:5295
 ptlock_alloc+0x20/0x70 mm/memory.c:7302
 ptlock_init include/linux/mm.h:3059 [inline]
 pagetable_pte_ctor include/linux/mm.h:3113 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:78 [inline]
 pte_alloc_one+0x7a/0x310 arch/x86/mm/pgtable.c:18
 __do_fault+0xd1/0x390 mm/memory.c:5276
 do_shared_fault mm/memory.c:5780 [inline]
 do_fault mm/memory.c:5854 [inline]
 do_pte_missing mm/memory.c:4362 [inline]
 handle_pte_fault mm/memory.c:6195 [inline]
 __handle_mm_fault+0x1847/0x5400 mm/memory.c:6336
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6505
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

Memory state around the buggy address:
 ffff888175605d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888175605e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888175605e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                     ^
 ffff888175605f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888175605f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


***

general protection fault in ipv6_frag_rcv

tree:      nf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netfilter/nf-next.git
base:      ff736a286116d462a4067ba258fa351bc0b4ed80
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/833219cc-e7e2-437d-b31c-1eb3666c1e93/config
C repro:   https://ci.syzbot.org/findings/bac8a298-33d8-4b3a-9f63-a0a2373aaab2/c_repro
syz repro: https://ci.syzbot.org/findings/bac8a298-33d8-4b3a-9f63-a0a2373aaab2/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5982 Comm: syz.1.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:dst_dev include/net/dst.h:571 [inline]
RIP: 0010:skb_dst_dev include/net/dst.h:586 [inline]
RIP: 0010:skb_dst_dev_net include/net/dst.h:596 [inline]
RIP: 0010:ipv6_frag_rcv+0x19c/0x2a20 net/ipv6/reassembly.c:328
Code: 5c 24 08 4c 89 74 24 10 48 8b 44 24 60 42 80 3c 28 00 74 08 48 89 df e8 42 15 21 f8 48 8b 03 49 89 c6 49 83 e6 fe 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 25 15 21 f8 bb 08 01 00 00 49 03
RSP: 0018:ffffc90003776d20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88816d87a1d8 RCX: ffff88816bf65700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003776f08 R08: ffffea0006d29400 R09: 0000000b00007ff5
R10: ffffea0006d29400 R11: ffffffff8a04b090 R12: 0000000000000040
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888173607480
FS:  00007fa70abdd6c0(0000) GS:ffff8882a9f2e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 0000000112fa8000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 nf_flow_ip6_tunnel_proto net/netfilter/nf_flow_table_ip.c:383 [inline]
 nf_flow_skb_encap_protocol+0x9c2/0x1540 net/netfilter/nf_flow_table_ip.c:438
 nf_flow_offload_ipv6_lookup net/netfilter/nf_flow_table_ip.c:1074 [inline]
 nf_flow_offload_ipv6_hook+0x13c/0x32a0 net/netfilter/nf_flow_table_ip.c:1102
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
 nf_ingress net/core/dev.c:5900 [inline]
 __netif_receive_skb_core+0x241c/0x2f90 net/core/dev.c:5996
 __netif_receive_skb_one_core net/core/dev.c:6135 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6250
 netif_receive_skb_internal net/core/dev.c:6336 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6395
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa70b58f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa70abdd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa70b7e6090 RCX: 00007fa70b58f7c9
RDX: 000000000000fdef RSI: 0000200000000340 RDI: 0000000000000003
RBP: 00007fa70b5f297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa70b7e6128 R14: 00007fa70b7e6090 R15: 00007ffcd9538b88
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dst_dev include/net/dst.h:571 [inline]
RIP: 0010:skb_dst_dev include/net/dst.h:586 [inline]
RIP: 0010:skb_dst_dev_net include/net/dst.h:596 [inline]
RIP: 0010:ipv6_frag_rcv+0x19c/0x2a20 net/ipv6/reassembly.c:328
Code: 5c 24 08 4c 89 74 24 10 48 8b 44 24 60 42 80 3c 28 00 74 08 48 89 df e8 42 15 21 f8 48 8b 03 49 89 c6 49 83 e6 fe 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 f7 e8 25 15 21 f8 bb 08 01 00 00 49 03
RSP: 0018:ffffc90003776d20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88816d87a1d8 RCX: ffff88816bf65700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003776f08 R08: ffffea0006d29400 R09: 0000000b00007ff5
R10: ffffea0006d29400 R11: ffffffff8a04b090 R12: 0000000000000040
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888173607480
FS:  00007fa70abdd6c0(0000) GS:ffff8882a9f2e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 0000000112fa8000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	5c                   	pop    %rsp
   1:	24 08                	and    $0x8,%al
   3:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
   8:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 42 15 21 f8       	call   0xf821155e
  1c:	48 8b 03             	mov    (%rbx),%rax
  1f:	49 89 c6             	mov    %rax,%r14
  22:	49 83 e6 fe          	and    $0xfffffffffffffffe,%r14
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 25 15 21 f8       	call   0xf821155e
  39:	bb 08 01 00 00       	mov    $0x108,%ebx
  3e:	49                   	rex.WB
  3f:	03                   	.byte 0x3


***

general protection fault in nf_flow_offload_ipv6_hook

tree:      nf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netfilter/nf-next.git
base:      ff736a286116d462a4067ba258fa351bc0b4ed80
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/833219cc-e7e2-437d-b31c-1eb3666c1e93/config
C repro:   https://ci.syzbot.org/findings/bee4a66a-8f79-4936-9f6e-7f9e229693c9/c_repro
syz repro: https://ci.syzbot.org/findings/bee4a66a-8f79-4936-9f6e-7f9e229693c9/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 1 UID: 0 PID: 5978 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:nf_flow_offload_ipv6_forward net/netfilter/nf_flow_table_ip.c:1027 [inline]
RIP: 0010:nf_flow_offload_ipv6_hook+0x2f3/0x32a0 net/netfilter/nf_flow_table_ip.c:1106
Code: 85 c6 03 00 00 e8 6d f0 31 f8 41 bc 14 00 00 00 e9 af 02 00 00 48 8d 4b 60 48 89 4c 24 18 48 c1 e9 03 48 89 8c 24 90 00 00 00 <42> 0f b6 04 21 84 c0 0f 85 de 23 00 00 44 0f b7 73 60 41 83 e6 03
RSP: 0018:ffffc900031d6fe0 EFLAGS: 00010206
RAX: ffffffff898e1101 RBX: 0000000000000002 RCX: 000000000000000c
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc900031d73e0 R08: ffffffff8f7d1e77 R09: 1ffffffff1efa3ce
R10: dffffc0000000000 R11: fffffbfff1efa3cf R12: dffffc0000000000
R13: 1ffff9200063ae1c R14: ffff88816cfc5680 R15: ffffc900031d72e0
FS:  00007fd7653a06c0(0000) GS:ffff8882a9f2e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 000000011342a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
 nf_ingress net/core/dev.c:5900 [inline]
 __netif_receive_skb_core+0x241c/0x2f90 net/core/dev.c:5996
 __netif_receive_skb_one_core net/core/dev.c:6135 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6250
 netif_receive_skb_internal net/core/dev.c:6336 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6395
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd76458f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd7653a0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd7647e6090 RCX: 00007fd76458f7c9
RDX: 000000000000fdef RSI: 0000200000000380 RDI: 0000000000000003
RBP: 00007fd7645f297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd7647e6128 R14: 00007fd7647e6090 R15: 00007ffde1f0b2b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nf_flow_offload_ipv6_forward net/netfilter/nf_flow_table_ip.c:1027 [inline]
RIP: 0010:nf_flow_offload_ipv6_hook+0x2f3/0x32a0 net/netfilter/nf_flow_table_ip.c:1106
Code: 85 c6 03 00 00 e8 6d f0 31 f8 41 bc 14 00 00 00 e9 af 02 00 00 48 8d 4b 60 48 89 4c 24 18 48 c1 e9 03 48 89 8c 24 90 00 00 00 <42> 0f b6 04 21 84 c0 0f 85 de 23 00 00 44 0f b7 73 60 41 83 e6 03
RSP: 0018:ffffc900031d6fe0 EFLAGS: 00010206
RAX: ffffffff898e1101 RBX: 0000000000000002 RCX: 000000000000000c
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc900031d73e0 R08: ffffffff8f7d1e77 R09: 1ffffffff1efa3ce
R10: dffffc0000000000 R11: fffffbfff1efa3cf R12: dffffc0000000000
R13: 1ffff9200063ae1c R14: ffff88816cfc5680 R15: ffffc900031d72e0
FS:  00007fd7653a06c0(0000) GS:ffff8882a9f2e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 000000011342a000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	85 c6                	test   %eax,%esi
   2:	03 00                	add    (%rax),%eax
   4:	00 e8                	add    %ch,%al
   6:	6d                   	insl   (%dx),%es:(%rdi)
   7:	f0 31 f8             	lock xor %edi,%eax
   a:	41 bc 14 00 00 00    	mov    $0x14,%r12d
  10:	e9 af 02 00 00       	jmp    0x2c4
  15:	48 8d 4b 60          	lea    0x60(%rbx),%rcx
  19:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
  1e:	48 c1 e9 03          	shr    $0x3,%rcx
  22:	48 89 8c 24 90 00 00 	mov    %rcx,0x90(%rsp)
  29:	00
* 2a:	42 0f b6 04 21       	movzbl (%rcx,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 de 23 00 00    	jne    0x2415
  37:	44 0f b7 73 60       	movzwl 0x60(%rbx),%r14d
  3c:	41 83 e6 03          	and    $0x3,%r14d


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

