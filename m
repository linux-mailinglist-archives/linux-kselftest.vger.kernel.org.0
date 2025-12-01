Return-Path: <linux-kselftest+bounces-46835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2259C989E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B18E344843
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE69338910;
	Mon,  1 Dec 2025 17:54:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CBB33890D
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611649; cv=none; b=e2K6T0Ayspc7b/WXQjsQ+gOJU/2MyTX0myh8VWL9QEjTA8qP4a9Ld8flOTJskI69jmuEI0i+4OfLTQLj73Lcw5j6zRI3l+qMUPh6+tw0QDWYSyEAqbCpFTBE0/ObFGWcj+hnpBTONnpCkg759tpmyxp1xqJZblQ9KwHvsJFPTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611649; c=relaxed/simple;
	bh=nyM5B04WuEeoHFU+XeboANqmb9rEd5fYWiqE8ERWhpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dr27vV/8yXBujho/LnVmulZj65Zpy+PjI9IFkzja5kj3F2kguGgi6rXWfB3kuqF5FGXn6LpyPEQSrmWFn0y5ZbRE5T+IWg+e+kW/S1vDpbu2TxTie08zZN719ZCp7dB5nPq6aVPL6Of8tiqG+M6DaS4JET/6t8G4mb5VUBDOVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c70546acd9so9527095a34.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 09:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611647; x=1765216447;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyc6WjZ8Em7woNiV98DJoyRaZxKfm+HKgB4Z/K976KI=;
        b=YmfP3J+jJt4bt0xWOeIgegpLLzxqORGpQcbl2qvZcuwMh6bWukl0IIAhzfE11Hu4Al
         XNe8GR8CdVkMn+qksDu97UI4xKR9zUWxEFS5rvFVxh4NctJLHZmaVZhu4BIJ9DpCLCve
         g/nmPPDVoggUm2wEq4QJH9jl++KMIWlMyf4XybrA3/RyKj9shl7fIZq8Aegm/xKoEVk9
         Th0OaZrUsoSbAGD7eBLI4BRo0qAVXai5xIvjPOYt6g/pofoZcMl4LjlE7aUFlumKQ7oD
         uCx3cXo2wJ0f0C/CMyNBw4p+YsmHswk5/76w9tjYxE1htuWUrlBw1XWfVFh/vV+FF5yS
         XgBA==
X-Forwarded-Encrypted: i=1; AJvYcCWK4J2UOfjShA1C9L55iN3BgnQA8wqKWTfoILgeLcQNi7raBfwY4jKa9spXDcrKWDpx6Gls9SG6QyiCsqUg+aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5VGYXbjA7nBZiXZjTgKr2tHupe8uf4LHCHYcKcMQFbIJet5jj
	T8WKMAX4dtMHY4WQfSPZjpe7JNsQ06jlKlizrCi4S4wrpop4CYws8HTcmJ4fgLgkpRATKDX7+Z/
	RU8idvRDRmqnV/fjHEjaWWVwjBv1KTvVtUjtgxCn+OKDKAN7g7fgM8wKcVHA=
X-Google-Smtp-Source: AGHT+IHMd8XzOHphqg33Hf8c3lCpH6nTpq0tWYN6ecFTHLilPens0485mvdEtkuPcdfEFKdo6fl/wZBHEdqpTQ+GAUxlbz1vkJXp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1794:b0:450:cc6d:d4ce with SMTP id
 5614622812f47-4514e84c99emr12733411b6e.63.1764611646967; Mon, 01 Dec 2025
 09:54:06 -0800 (PST)
Date: Mon, 01 Dec 2025 09:54:06 -0800
In-Reply-To: <20251201-flowtable-offload-ip6ip6-v1-0-1dabf534c074@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692dd63e.a70a0220.d98e3.018c.GAE@google.com>
Subject: [syzbot ci] Re: Add IP6IP6 flowtable SW acceleration
From: syzbot ci <syzbot+ci42934faa3c3455b7@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, fw@strlen.de, horms@kernel.org, kadlec@netfilter.org, 
	kuba@kernel.org, linux-kselftest@vger.kernel.org, lorenzo@kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, phil@nwl.cc, shuah@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] Add IP6IP6 flowtable SW acceleration
https://lore.kernel.org/all/20251201-flowtable-offload-ip6ip6-v1-0-1dabf534c074@kernel.org
* [PATCH RFC nf-next 1/4] netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
* [PATCH RFC nf-next 2/4] netfilter: flowtable: Add IP6IP6 rx sw acceleration
* [PATCH RFC nf-next 3/4] netfilter: flowtable: Add IP6IP6 tx sw acceleration
* [PATCH RFC nf-next 4/4] selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest

and found the following issue:
KASAN: slab-use-after-free Read in nf_flow_skb_encap_protocol

Full report is available here:
https://ci.syzbot.org/series/df395c22-6768-4a9f-9a96-56b5307acbc6

***

KASAN: slab-use-after-free Read in nf_flow_skb_encap_protocol

tree:      nf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netfilter/nf-next.git
base:      ff736a286116d462a4067ba258fa351bc0b4ed80
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/018f7259-7abc-4b77-b40c-e8e520e1e793/config
C repro:   https://ci.syzbot.org/findings/5cb5bc43-721b-4a9e-a093-4d52aab5ba9f/c_repro
syz repro: https://ci.syzbot.org/findings/5cb5bc43-721b-4a9e-a093-4d52aab5ba9f/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in nf_flow_ip6_tunnel_proto net/netfilter/nf_flow_table_ip.c:383 [inline]
BUG: KASAN: slab-use-after-free in nf_flow_skb_encap_protocol+0x1336/0x14e0 net/netfilter/nf_flow_table_ip.c:433
Read of size 2 at addr ffff888115de92b6 by task syz.0.20/5970

CPU: 0 UID: 0 PID: 5970 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 nf_flow_ip6_tunnel_proto net/netfilter/nf_flow_table_ip.c:383 [inline]
 nf_flow_skb_encap_protocol+0x1336/0x14e0 net/netfilter/nf_flow_table_ip.c:433
 nf_flow_offload_ipv6_lookup net/netfilter/nf_flow_table_ip.c:1065 [inline]
 nf_flow_offload_ipv6_hook+0x131/0x3380 net/netfilter/nf_flow_table_ip.c:1092
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
RIP: 0033:0x7f8b24f8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b25e26038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8b251e6090 RCX: 00007f8b24f8f7c9
RDX: 000000000000fdef RSI: 0000200000000440 RDI: 0000000000000003
RBP: 00007f8b24ff297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8b251e6128 R14: 00007f8b251e6090 R15: 00007ffe014b8a38
 </TASK>

Allocated by task 5970:
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

Freed by task 5970:
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
 icmpv6_param_prob include/linux/icmpv6.h:95 [inline]
 ipv6_rthdr_rcv+0x150e/0x2020 net/ipv6/exthdrs.c:828
 nf_flow_ip6_tunnel_proto net/netfilter/nf_flow_table_ip.c:381 [inline]
 nf_flow_skb_encap_protocol+0x9b5/0x14e0 net/netfilter/nf_flow_table_ip.c:433
 nf_flow_offload_ipv6_lookup net/netfilter/nf_flow_table_ip.c:1065 [inline]
 nf_flow_offload_ipv6_hook+0x131/0x3380 net/netfilter/nf_flow_table_ip.c:1092
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

The buggy address belongs to the object at ffff888115de9200
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 182 bytes inside of
 freed 240-byte region [ffff888115de9200, ffff888115de92f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x115de8
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff8881036ba8c0 ffffea0004280a80 dead000000000002
raw: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 017ff00000000040 ffff8881036ba8c0 ffffea0004280a80 dead000000000002
head: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 017ff00000000001 ffffea0004577a01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5555, tgid 5555 (dhcpcd), ts 36767395595, free_ts 35122573404
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
 alloc_skb_with_frags+0xca/0x890 net/core/skbuff.c:6712
 sock_alloc_send_pskb+0x84d/0x980 net/core/sock.c:2995
 unix_dgram_sendmsg+0x454/0x1840 net/unix/af_unix.c:2139
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 sock_write_iter+0x279/0x360 net/socket.c:1195
 do_iter_readv_writev+0x623/0x8c0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
page last free pid 5262 tgid 5262 stack trace:
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
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2924 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1431
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888115de9180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888115de9200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888115de9280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                     ^
 ffff888115de9300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888115de9380: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

