Return-Path: <linux-kselftest+bounces-27829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EAA4911A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 06:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3697216F183
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C671C302E;
	Fri, 28 Feb 2025 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zbrxhdao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361651AF0CB
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721911; cv=none; b=T8RG2VRyHsTB5v0qqm8JrQbhTV8CMu1LyDOGWIf5gtlNrqusEJ7r1btCFQ5UjAJlJAWdDtzT+WMn9Aa2myJGIMsAiCURt5wd5wdP0WXDcYH4/9dI0e8YQ47KBMylVdnYNrp1uYr5Hk30coQ6aRaQ8xmMojKecp8uZ55+beOrnF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721911; c=relaxed/simple;
	bh=isxaFmrKmYHCGlZExmVjSHepJqDAVdMlLja10DSOAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sa2nWaxQnCl3EPjVz3iS/gSKKBg0LdhSL0rdCrubwECF/B/UMAI6vLOaoqHndiFQkG31B2TZHvR7VbNeEIIdMMrWFcw7C+hGU/m7gnFSoGDoE896v7J4SdeuiWXKnzUPAoFy82+y4+LaL8pCk120WnqxC24EW8azb2wum7OwhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zbrxhdao; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740721897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CbQAEZBPDpzuaEAifTRhgBJW4d3VzEfkVjBc5JVCR9I=;
	b=Zbrxhdao6U19J7aiaKMearYycQu6cNwFk7/dtOQXDc8wp258BSz1HXe5ZGbzNRgnS9ykXM
	i2FuJL8Hi9iAEnQH3Lh7xgGC6HOgi9cqq4UsX9hk0iVdPxX9yownFf5IH+y/v0K4qFPhpb
	rhM6VrApxObbSkEVv5jfc8U50J+76SU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	martin.lau@linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	cong.wang@bytedance.com
Subject: [PATCH bpf-next v2 0/3] bpf: Fix use-after-free of sockmap
Date: Fri, 28 Feb 2025 13:51:03 +0800
Message-ID: <20250228055106.58071-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1. Issue
Syzkaller reported this issue [1].

2. Reproduce

We can reproduce this issue by using the test_sockmap_with_close_on_write()
test I provided in selftest, also you need to apply the following patch to
ensure 100% reproducibility (sleep after checking sock):

'''
static void sk_psock_verdict_data_ready(struct sock *sk)
{
        .......
        if (unlikely(!sock))
                return;
+       if (!strcmp("test_progs", current->comm)) {
+               printk("sleep 2s to wait socket freed\n");
+               mdelay(2000);
+               printk("sleep end\n");
+       }
        ops = READ_ONCE(sock->ops);
        if (!ops || !ops->read_skb)
                return;
}
'''

Then running './test_progs -v sockmap_basic', and if the kernel has KASAN
enabled [2], you will see the following warning:

'''
BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0x29b/0x2d0
Read of size 8 at addr ffff88813a777020 by task test_progs/47055

Tainted: [O]=OOT_MODULE
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_address_description.constprop.0+0x30/0x420
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 print_report+0xb7/0x270
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 ? kasan_addr_to_slab+0xd/0xa0
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 kasan_report+0xca/0x100
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 sk_psock_verdict_data_ready+0x29b/0x2d0
 unix_stream_sendmsg+0x4a6/0xa40
 ? __pfx_unix_stream_sendmsg+0x10/0x10
 ? fdget+0x2c1/0x3a0
 __sys_sendto+0x39c/0x410
'''

3. Reason
'''
CPU0                                             CPU1
unix_stream_sendmsg(sk):
  other = unix_peer(sk)
  other->sk_data_ready(other):
    socket *sock = sk->sk_socket
    if (unlikely(!sock))
        return;
                                                 close(other):
                                                   ...
                                                   other->close()
                                                   free(socket)
    READ_ONCE(sock->ops)
    ^
    use 'sock' after free
'''

For TCP, UDP, or other protocols, we have already performed
rcu_read_lock() when the network stack receives packets in ip_input.c:
'''
ip_local_deliver_finish():
    rcu_read_lock()
    ip_protocol_deliver_rcu()
        xxx_rcv
    rcu_read_unlock()
'''

However, for Unix sockets, sk_data_ready is called directly from the
process context without rcu_read_lock() protection.

4. Solution
Based on the fact that the 'struct socket' is released using call_rcu(),
We add rcu_read_{un}lock() at the entrance and exit of our sk_data_ready.
It will not increase performance overhead, at least for TCP and UDP, they
are already in a relatively large critical section.

Of course, we can also add a custom callback for Unix sockets and call
rcu_read_lock() before calling _verdict_data_ready like this:
'''
if (sk_is_unix(sk))
    sk->sk_data_ready = sk_psock_verdict_data_ready_rcu;
else
    sk->sk_data_ready = sk_psock_verdict_data_ready;

sk_psock_verdict_data_ready_rcu():
    rcu_read_lock()
    sk_psock_verdict_data_ready()
    rcu_read_unlock()
'''
However, this will cause too many branches, and it's not suitable to
distinguish network protocols in skmsg.c.

[1] https://syzkaller.appspot.com/bug?extid=dd90a702f518e0eac072
[2] https://syzkaller.appspot.com/text?tag=KernelConfig&x=1362a5aee630ff34

---
v1 -> v2:
1. Add Fixes tag.
2. Extend selftest of edge case for TCP/UDP sockets.
3. Add Reviewed-by and Acked-by tag.
https://lore.kernel.org/bpf/20250226132242.52663-1-jiayuan.chen@linux.dev/T/#t

Jiayuan Chen (3):
  bpf, sockmap: avoid using sk_socket after free
  selftests/bpf: Add socketpair to create_pair to support unix socket
  selftests/bpf: Add edge case tests for sockmap

 net/core/skmsg.c                              | 18 ++++--
 .../selftests/bpf/prog_tests/socket_helpers.h | 13 +++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 59 +++++++++++++++++++
 3 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.47.1


