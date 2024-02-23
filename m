Return-Path: <linux-kselftest+bounces-5356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A95D861785
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E54C1C2096F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB413B2A6;
	Fri, 23 Feb 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMP9Zs9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9313A887;
	Fri, 23 Feb 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704913; cv=none; b=oawnn0iozqrwu02CujdlfrCgnirEdX9vglqm6WYi6eyYaSOZ8khV42OhcX1gVWxifE5ki/OiuaN88tXnC0Lyoh61gPfjiNHMydz1sfcRvEDW/uGc/aAqVxfd9J31mNN+edmyD542o4mvD9J8xl6T0lNmSHLcVASy1tFSL+hrzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704913; c=relaxed/simple;
	bh=7TtWjndsxVYffCALwoOeo7w2xmYQpzPb4cckMSedr8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9kJKYf9J58//ZstaPzrQ/f3CIDpNtGpQ0UtFvHQiC8QM0W8/KNRKBtQJTn/fFTASMO0SOVXfIe2Q07qYelaQkODyezqz76uFCGMGR3XT9EBvkGnL0kErzmSSKbARSxUoVkxRehrf7nPL2rnhZT1ZCb03S6XtHXDp8Kzw6MS+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMP9Zs9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43753C433C7;
	Fri, 23 Feb 2024 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704913;
	bh=7TtWjndsxVYffCALwoOeo7w2xmYQpzPb4cckMSedr8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uMP9Zs9FvAfs8yXXna/ZtizY9EHKjdcpQeCD7uKP4MR3vD01xGG8ZQosUT1+hw+xf
	 oA1W70K/jcKg82oh9UekJDpVQAWhGHi+roXddDAeu38K+SimnnLwkWwSOoQmROPqiJ
	 zzMEs/0R8snoUE0zySjABHzZobcTSdkYTkRETuiEVwQiiHFt42UQ2Ggfh13T/+XNZ0
	 utgq/pGCiIWLJlqpNrWC7XvU2kLZS5Rp49EYex1a+w530Bx/2gS7Bki4TIc3lavPzp
	 uhvoM5UrGe4LzGCOlyIih5+4AehIuzcjq25othCKufNLvfTx2LWPTFmdf7Y3QEyIvA
	 pwH6tmithjCOw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:19 +0100
Subject: [PATCH net 09/10] mptcp: fix possible deadlock in subflow diag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-9-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5011; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=r5yS2aqxy/UFqDVBdC2SzLwUgEbcbOAGxz23X5YQglQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqJQlYEbverqjk/Wt3czNkvGndu41GkjAVk
 Ipdmg1TyUyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c+qAD/9eH6iHyK1RwTYjxr/tAoH+SjQQWyyiQhjuZRa5eOHb/Wzp9QHInrYQhEAcrT2McZ/qBia
 ngOUSBp9kzlnuljowjUa2wDCVqhW+RE11BWvUqSHvvtONFt9HBxzyQ2RLSHLkFB/2ZMPqbUca8L
 2Oot9QjYxQQrCUex4NzQkNiQNlleaTChQpPDUmU6AwaVeVvf1C9d7w9rQxA1rV2BSHNa4C2jsgu
 JXZY+424zLdFx3MnM0cW6IhfkrK8D+zquFuViCGyh3Tzkp7s3UlnumO48JCcucLouAyb3o2a2e4
 AWCzqLcxCoeten7eVvogMlPV+wFQwnEC2S2LbKgD91eXBQot4KqoBcvXm2W5bwO6ScSYfT2HJ5q
 bihP/eSvTpdtNN2XlqarlQqC1ccgxKOm7x4LiXwm4BPnNgOBOWtKVFKrXumFB7bcgt8DEfJ4GfZ
 osl8rwV73RgwfLCOJX+Iunv2dYGwXKnbNEB9paFifPw2SsqeXwdwDDl23h5HDb6PlDJ0vLvKSqW
 6tQ+r3siPX5XS7MTyTS0mlYNd3pw6v/BoN5q76wIUJbJtdO7w7iUfGUD/LtCwERJIvZs0edULIu
 hM0WLZ4gVlGgw2YyESGr+HphdIbVLsk/TKEtc4oRBXRajGJf8rapMqw4BaVQRrnM+lFzJIdRSBB
 4lKYfuJ0BLEbuMw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Syzbot and Eric reported a lockdep splat in the subflow diag:

   WARNING: possible circular locking dependency detected
   6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0 Not tainted

   syz-executor.2/24141 is trying to acquire lock:
   ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
   tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
   ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
   tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137

   but task is already holding lock:
   ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
   include/linux/spinlock.h:351 [inline]
   ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
   inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #1 (&h->lhash2[i].lock){+.+.}-{2:2}:
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   __inet_hash+0x335/0xbe0 net/ipv4/inet_hashtables.c:743
   inet_csk_listen_start+0x23a/0x320 net/ipv4/inet_connection_sock.c:1261
   __inet_listen_sk+0x2a2/0x770 net/ipv4/af_inet.c:217
   inet_listen+0xa3/0x110 net/ipv4/af_inet.c:239
   rds_tcp_listen_init+0x3fd/0x5a0 net/rds/tcp_listen.c:316
   rds_tcp_init_net+0x141/0x320 net/rds/tcp.c:577
   ops_init+0x352/0x610 net/core/net_namespace.c:136
   __register_pernet_operations net/core/net_namespace.c:1214 [inline]
   register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1283
   register_pernet_device+0x33/0x80 net/core/net_namespace.c:1370
   rds_tcp_init+0x62/0xd0 net/rds/tcp.c:735
   do_one_initcall+0x238/0x830 init/main.c:1236
   do_initcall_level+0x157/0x210 init/main.c:1298
   do_initcalls+0x3f/0x80 init/main.c:1314
   kernel_init_freeable+0x42f/0x5d0 init/main.c:1551
   kernel_init+0x1d/0x2a0 init/main.c:1441
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

   -> #0 (k-sk_lock-AF_INET6){+.+.}-{0:0}:
   check_prev_add kernel/locking/lockdep.c:3134 [inline]
   check_prevs_add kernel/locking/lockdep.c:3253 [inline]
   validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
   __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   lock_sock_fast include/net/sock.h:1723 [inline]
   subflow_get_info+0x166/0xd20 net/mptcp/diag.c:28
   tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
   tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
   inet_sk_diag_fill+0x10ed/0x1e00 net/ipv4/inet_diag.c:345
   inet_diag_dump_icsk+0x55b/0x1f80 net/ipv4/inet_diag.c:1061
   __inet_diag_dump+0x211/0x3a0 net/ipv4/inet_diag.c:1263
   inet_diag_dump_compat+0x1c1/0x2d0 net/ipv4/inet_diag.c:1371
   netlink_dump+0x59b/0xc80 net/netlink/af_netlink.c:2264
   __netlink_dump_start+0x5df/0x790 net/netlink/af_netlink.c:2370
   netlink_dump_start include/linux/netlink.h:338 [inline]
   inet_diag_rcv_msg_compat+0x209/0x4c0 net/ipv4/inet_diag.c:1405
   sock_diag_rcv_msg+0xe7/0x410
   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
   sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
   netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
   netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
   netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:745
   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
   ___sys_sendmsg net/socket.c:2638 [inline]
   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
   do_syscall_64+0xf9/0x240
   entry_SYSCALL_64_after_hwframe+0x6f/0x77

As noted by Eric we can break the lock dependency chain avoid
dumping any extended info for the mptcp subflow listener:
nothing actually useful is presented there.

Fixes: b8adb69a7d29 ("mptcp: fix lockless access in subflow ULP diag")
Cc: stable@vger.kernel.org
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 6ff6f14674aa..7017dd60659d 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 	bool slow;
 	int err;
 
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		return 0;
+
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;

-- 
2.43.0


