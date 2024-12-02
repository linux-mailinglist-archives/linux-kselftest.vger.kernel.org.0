Return-Path: <linux-kselftest+bounces-22673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E743B9E01CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 13:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F65285174
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E11FECC7;
	Mon,  2 Dec 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Jed/pMdz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE041FECA6
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141137; cv=none; b=ZxnaJmTOGZixGGwmG4ITUbpNjuCId8eX0kIMGkiAacfvFziosMpV2BLbuanOPH56wP2yUAkVzYEFu9x0HSNPo58aNmnj0Jy+Iw/TjDbCEyTjYWFPNeEafPwRDAj92kEUcJUJNzxXj5e/5VHwgbfhqTKeeT99BwdWcx6NnAXso8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141137; c=relaxed/simple;
	bh=R3raTy+TsyNhkfIZ0aBPxt6o5618wybYnhAizrUINhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIQkuIGcEm20ec5f14aiokOdBOiLCHbLtJmXd99yejANRy1wXrOknmiJ+68JSl7je9nGisROprALvRvvrQtwd0TOAJAvyKud3ySe2MeTnu2RWAK8KVTojLvXmme3ZsbsdoRmDdizLFVL0zsqgy/v6zDVDKFViU8wFQplnGKEnNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Jed/pMdz; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dM-008Gew-SA; Mon, 02 Dec 2024 12:30:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=uNFEdS5uGm6Njo4yZYOGUhFLFGeSEmwBt49zd9lx61Q=; b=Jed/pMdzlOGtkIN4p5WMj0koWh
	Jr4Dz7IjcTqcFFGqvHBDjfWaWgEHpnA8778fzJetjpItXtKThzhErt2R4SD0mINszmbnRV4JLRZCp
	deEnWeotcGQ+pcFU9WF9vcVusI72hwjIhRBAXN/s//tDKw9OvUt9Ly0lrnwsBZykHDA0jyP4m3Jd4
	lLm5mdRwLLUD9ZqSmctfhL4UyWpvSxWLYIXIlLyyJJP9AtTSJzsMNwPuoqu4UJ9v0SQYiqQnz1z++
	uq0TuHMsQKvvMvRQ+nV7IJMLt97uG7InrYLBbfj0wytbQaqeyhjeKzdLtjMKecuL5GH17MNQ6NelK
	wnO8NXdQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dK-0005e5-Ul; Mon, 02 Dec 2024 12:30:32 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tI4d5-007H5a-3p; Mon, 02 Dec 2024 12:30:15 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 02 Dec 2024 12:29:25 +0100
Subject: [PATCH bpf 3/3] bpf, sockmap: Fix race between element replace and
 close()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co>
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
In-Reply-To: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Element replace (with a socket different from the one stored) may race with
socket's close() link popping & unlinking. __sock_map_delete()
unconditionally unrefs the (wrong) element:

// set map[0] = s0
map_update_elem(map, 0, s0)

// drop fd of s0
close(s0)
  sock_map_close()
    lock_sock(sk)               (s0!)
    sock_map_remove_links(sk)
      link = sk_psock_link_pop()
      sock_map_unlink(sk, link)
        sock_map_delete_from_link
                                        // replace map[0] with s1
                                        map_update_elem(map, 0, s1)
                                          sock_map_update_elem
                                (s1!)       lock_sock(sk)
                                            sock_map_update_common
                                              psock = sk_psock(sk)
                                              spin_lock(&stab->lock)
                                              osk = stab->sks[idx]
                                              sock_map_add_link(..., &stab->sks[idx])
                                              sock_map_unref(osk, &stab->sks[idx])
                                                psock = sk_psock(osk)
                                                sk_psock_put(sk, psock)
                                                  if (refcount_dec_and_test(&psock))
                                                    sk_psock_drop(sk, psock)
                                              spin_unlock(&stab->lock)
                                            unlock_sock(sk)
          __sock_map_delete
            spin_lock(&stab->lock)
            sk = *psk                        // s1 replaced s0; sk == s1
            if (!sk_test || sk_test == sk)   // sk_test (s0) != sk (s1); no branch
              sk = xchg(psk, NULL)
            if (sk)
              sock_map_unref(sk, psk)        // unref s1; sks[idx] will dangle
                psock = sk_psock(sk)
                sk_psock_put(sk, psock)
                  if (refcount_dec_and_test())
                    sk_psock_drop(sk, psock)
            spin_unlock(&stab->lock)
    release_sock(sk)

Then close(map) enqueues bpf_map_free_deferred, which finally calls
sock_map_free(). This results in some refcount_t warnings along with a
KASAN splat[1].

Fix __sock_map_delete(), do not allow sock_map_unref() on elements that may
have been replaced.

[1]:
BUG: KASAN: slab-use-after-free in sock_map_free+0x10e/0x330
Write of size 4 at addr ffff88811f5b9100 by task kworker/u64:12/1063

CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Not tainted 6.12.0+ #125
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0x90
 print_report+0x174/0x4f6
 kasan_report+0xb9/0x190
 kasan_check_range+0x10f/0x1e0
 sock_map_free+0x10e/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 1202:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 __kasan_slab_alloc+0x85/0x90
 kmem_cache_alloc_noprof+0x131/0x450
 sk_prot_alloc+0x5b/0x220
 sk_alloc+0x2c/0x870
 unix_create1+0x88/0x8a0
 unix_create+0xc5/0x180
 __sock_create+0x241/0x650
 __sys_socketpair+0x1ce/0x420
 __x64_sys_socketpair+0x92/0x100
 do_syscall_64+0x93/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 46:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x37/0x60
 __kasan_slab_free+0x4b/0x70
 kmem_cache_free+0x1a1/0x590
 __sk_destruct+0x388/0x5a0
 sk_psock_destroy+0x73e/0xa50
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff88811f5b9080
 which belongs to the cache UNIX-STREAM of size 1984
The buggy address is located 128 bytes inside of
 freed 1984-byte region [ffff88811f5b9080, ffff88811f5b9840)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11f5b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888127d49401
flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: f5(slab)
raw: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
head: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000003 ffffea00047d6e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811f5b9000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811f5b9080: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811f5b9100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88811f5b9180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811f5b9200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Disabling lock debugging due to kernel taint

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:25 refcount_warn_saturate+0xce/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B              6.12.0+ #125
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xce/0x150
Code: 34 73 eb 03 01 e8 82 53 ad fe 0f 0b eb b1 80 3d 27 73 eb 03 00 75 a8 48 c7 c7 80 bd 95 84 c6 05 17 73 eb 03 01 e8 62 53 ad fe <0f> 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xce/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xce/0x150
 sock_map_free+0x2e5/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

refcount_t: underflow; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:28 refcount_warn_saturate+0xee/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B   W          6.12.0+ #125
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xee/0x150
Code: 17 73 eb 03 01 e8 62 53 ad fe 0f 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05 f6 72 eb 03 01 e8 42 53 ad fe <0f> 0b e9 6e ff ff ff 80 3d e6 72 eb 03 00 0f 85 61 ff ff ff 48 c7
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xee/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xee/0x150
 sock_map_free+0x2d3/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 20b348b1964a10a1b0bfbe1a90a4a4cd99715b81..f1b9b3958792cd599efcb591742874e9b3f4a76b 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -412,12 +412,11 @@ static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	int err = 0;
 
 	spin_lock_bh(&stab->lock);
-	sk = *psk;
-	if (!sk_test || sk_test == sk)
+	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
 
 	if (likely(sk))

-- 
2.46.2


