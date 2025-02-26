Return-Path: <linux-kselftest+bounces-27610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11BA460B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 14:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2BA7A4DEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C62222B8;
	Wed, 26 Feb 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MF1PRG5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3B221559
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576202; cv=none; b=X4683IL28ZlI5/tOxc8K1H9334LCpe4w9oNkeBxMDao7Z3NKe9ahI1yzSN2dSpNhzVBBpfm4T/X6oUA12vvaBpX0slguM6/Khdvc5I6YOKbmgXq/mSvsG3SFmTDtNdfA/OYPGm/XRMfjqnI1/oGYJCXXYbXn6NuseKNRFBo8m/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576202; c=relaxed/simple;
	bh=BNBjN9eojJuckvSPmE2E6Krsv7VXfHHr3UGTTgvNq2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Okp4RqbsgMIq+v1Il9XjgLy8mO8Y6ni+kB7gFSMFjje/v8K9j5Vf3CHZT54o6kmEsIKsnc0u7/n9s7IgbS1pS4YHiALVXAaz+02i7eIr1HFhNUTXslcIf0NZKRSbF4dzrxIaXZrA8rS3bKmY1F0DaIts6UP33jQMISMQQWbe3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MF1PRG5Q; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740576186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LIrVE00T1J3Jz4vdwi9do6q1hDo8nGa1bNYBlY2fo8E=;
	b=MF1PRG5QQ1Lqq7wFZG6q8r8CMol2naHU/jSKSQcnkINwj7weVztyp1WqNvpg3VINv/Eagu
	UQJz/MQx3uCsrKpXXyVmU+KtzlQ4AXW1YfmXE0s9Tuz3zDBtPXfEZ4vaH44dG5/ZLgL+t0
	FzDdjq2JIzguGZDV3fxP8WfDZtVwvis=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: cong.wang@bytedance.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
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
	martin.lau@linux.dev,
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
	mrpre@163.com
Subject: [PATCH bpf-next v1 0/3] bpf: Fix use-after-free of sockmap
Date: Wed, 26 Feb 2025 21:22:39 +0800
Message-ID: <20250226132242.52663-1-jiayuan.chen@linux.dev>
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

Jiayuan Chen (3):
  bpf, sockmap: avoid using sk_socket after free
  selftests/bpf: Add socketpair to create_pair to support unix socket
  selftests/bpf: Add edge case tests for sockmap

 net/core/skmsg.c                              | 18 ++++--
 .../selftests/bpf/prog_tests/socket_helpers.h | 13 ++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 57 +++++++++++++++++++
 3 files changed, 82 insertions(+), 6 deletions(-)

-- 
2.47.1


