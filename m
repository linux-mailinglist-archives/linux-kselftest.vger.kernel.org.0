Return-Path: <linux-kselftest+bounces-19653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42599CC4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F4B1C2282B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047A1ADFF9;
	Mon, 14 Oct 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLFM+t4W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEDC1AC45F;
	Mon, 14 Oct 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914812; cv=none; b=fj7xHS3mgSmDjPQ0yCc7YEwd+Si9kB43Tdo5GBGcsaVIgCs8R5NWC13CIPHg8I1+NWHTHKPI40yNfBkeBlI1dIpaRJsqpfoj+pQVXCHgQ8TMEKz9dutR+YMvRgDVPz13FmvEyOFD1NA9RI8s9sNk7uYSoL1jRuZRglcaWMlXBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914812; c=relaxed/simple;
	bh=4rFBOgxbRxsGSItMVxpTTzO12dDwFek2/2aDpf+2Uh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iVWVUF5uJQFZS8diZPTRuTZ/DvLcZ4TWQ8la8X7b8yw9tAPhEdP2MmjPRezy+24RqRkXKtcLm0rSfi6yGDwQKVFjH4MfUnwFfWAmAweyZCaB+aOOc0RgPexJeKVs/vpQA6kfBz7IS+VeW/6GQlTQlJWRscRqiFhNQQBAP+Ifkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLFM+t4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFB4C4CEC6;
	Mon, 14 Oct 2024 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914811;
	bh=4rFBOgxbRxsGSItMVxpTTzO12dDwFek2/2aDpf+2Uh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kLFM+t4WsT3A+MtZiQRnQM8GPLsOtEDyKzXG21x5DuiDLp8Ms8PThb0swhh6mc3vn
	 pa25GoGJFfAcrGz7k3EIUe7bzPRuSohORG1+Hs99pnwvFlh0WY5VixE7CM8VCj+83p
	 1dCYrUPLperbsKbFe90JcgsQIac5DNi24EaMyz+LLx+JdiSyuzjtUyq3iXZ8KtNWpO
	 XkgKJ5I1mv6uLo8LBmhsfWo3DrZpC0qxX6I7QdKLK40bGstSxAV1uCQxMWd6GGu4OQ
	 0h321UAvwpYeA83V4xF+dRjI4UM62bEgSFD5vVAXHP7y2NJ5cvdiKnf5qThIK6Aj0q
	 l/c63/CZA66Eg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Oct 2024 16:06:00 +0200
Subject: [PATCH net v2 1/2] mptcp: prevent MPC handshake on port-based
 signal endpoints
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-net-mptcp-mpc-port-endp-v2-1-7faea8e6b6ae@kernel.org>
References: <20241014-net-mptcp-mpc-port-endp-v2-0-7faea8e6b6ae@kernel.org>
In-Reply-To: <20241014-net-mptcp-mpc-port-endp-v2-0-7faea8e6b6ae@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12029; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=n0ptyci1csBA/gH5/LyBQXyU/aNH+nz6jWKLh20Ti7U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnDSV0YpPvplI2XYwyN9P52fx1YJPxMgNRJRmak
 BcukA7cK3WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZw0ldAAKCRD2t4JPQmmg
 c/k6EACDQzdJ1B4LjkPrKTM0IlO4HnWMGFfY+wQiS2/tRCz7HeVWzaR9q95aDz0dI5ik2r34DEA
 kNKH657hX1mFQIngEH5KHUh4bLDQm7ewSSrs9dEztSuk+hov6XRCWsLKHcvqJ4tH8oQB8jrXAQE
 ZuNQuB0A1wRpbwsqi/x1ygHle83jV6dwmf/THrk4eUg9e3+jcI7B63/xX20svWzLOIc3VDfCTCP
 uOjOpeTQRJ4Pb+zbkLnFcLarzFGN5+lqp89vlh7ngwQbO5+u3U94yHCbOOl99ejgrsJ2tx0IHAb
 7Syb4HYkJznathMmNnGyksJgR2lS/z4+LoAUl/mtTI9/bVMvgPlD3KAtIwVnoGT3kHdAeOA6KH1
 nK3tPvAJbHO8h+xP2jQKZbXcsVyKoGe+jXPyozAN2SZGIB16Gdeer6XWPeIwRP1fqYnq2YTQRI1
 ddKNcTbluEvlZVdTJx2FLJmrkGmrpV2zovR/U9bVZDkx5OEt8CJ5+auEDP8YXvMJc94dw4y21t+
 +kmgqK8yl1Ak1wlzlhil+v1b/eMh0ifDq0IfYN+eNmIYLvsPE/OCftMuJu3Ugg5IHRKqgvvCUvw
 mF/WEeVnavI8yhChxo3R3tlyfGl+GfPl2bOYLSte80S6XYGK4ueDWXXysq6k1xSm2CKzeg0lGB1
 0ZhzJdl9/2YfkvQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Syzkaller reported a lockdep splat:

  ============================================
  WARNING: possible recursive locking detected
  6.11.0-rc6-syzkaller-00019-g67784a74e258 #0 Not tainted
  --------------------------------------------
  syz-executor364/5113 is trying to acquire lock:
  ffff8880449f1958 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  ffff8880449f1958 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

  but task is already holding lock:
  ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(k-slock-AF_INET);
    lock(k-slock-AF_INET);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  7 locks held by syz-executor364/5113:
   #0: ffff8880449f0e18 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
   #0: ffff8880449f0e18 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x153/0x1b10 net/mptcp/protocol.c:1806
   #1: ffff88803fe39ad8 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
   #1: ffff88803fe39ad8 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg_fastopen+0x11f/0x530 net/mptcp/protocol.c:1727
   #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
   #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
   #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: __ip_queue_xmit+0x5f/0x1b80 net/ipv4/ip_output.c:470
   #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
   #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
   #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x45f/0x1390 net/ipv4/ip_output.c:228
   #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
   #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: process_backlog+0x33b/0x15b0 net/core/dev.c:6104
   #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
   #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
   #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x230/0x5f0 net/ipv4/ip_input.c:232
   #6: ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
   #6: ffff88803fe3cb58 (k-slock-AF_INET){+.-.}-{2:2}, at: sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328

  stack backtrace:
  CPU: 0 UID: 0 PID: 5113 Comm: syz-executor364 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  Call Trace:
   <IRQ>
   __dump_stack lib/dump_stack.c:93 [inline]
   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
   check_deadlock kernel/locking/lockdep.c:3061 [inline]
   validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
   __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   sk_clone_lock+0x2cd/0xf40 net/core/sock.c:2328
   mptcp_sk_clone_init+0x32/0x13c0 net/mptcp/protocol.c:3279
   subflow_syn_recv_sock+0x931/0x1920 net/mptcp/subflow.c:874
   tcp_check_req+0xfe4/0x1a20 net/ipv4/tcp_minisocks.c:853
   tcp_v4_rcv+0x1c3e/0x37f0 net/ipv4/tcp_ipv4.c:2267
   ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
   __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
   __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
   process_backlog+0x662/0x15b0 net/core/dev.c:6108
   __napi_poll+0xcb/0x490 net/core/dev.c:6772
   napi_poll net/core/dev.c:6841 [inline]
   net_rx_action+0x89b/0x1240 net/core/dev.c:6963
   handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
   do_softirq+0x11b/0x1e0 kernel/softirq.c:455
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
   local_bh_enable include/linux/bottom_half.h:33 [inline]
   rcu_read_unlock_bh include/linux/rcupdate.h:908 [inline]
   __dev_queue_xmit+0x1763/0x3e90 net/core/dev.c:4450
   dev_queue_xmit include/linux/netdevice.h:3105 [inline]
   neigh_hh_output include/net/neighbour.h:526 [inline]
   neigh_output include/net/neighbour.h:540 [inline]
   ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
   ip_local_out net/ipv4/ip_output.c:129 [inline]
   __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
   __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
   tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6542 [inline]
   tcp_rcv_state_process+0x2c32/0x4570 net/ipv4/tcp_input.c:6729
   tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1934
   sk_backlog_rcv include/net/sock.h:1111 [inline]
   __release_sock+0x214/0x350 net/core/sock.c:3004
   release_sock+0x61/0x1f0 net/core/sock.c:3558
   mptcp_sendmsg_fastopen+0x1ad/0x530 net/mptcp/protocol.c:1733
   mptcp_sendmsg+0x1884/0x1b10 net/mptcp/protocol.c:1812
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0x1a6/0x270 net/socket.c:745
   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
   ___sys_sendmsg net/socket.c:2651 [inline]
   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2737
   __do_sys_sendmmsg net/socket.c:2766 [inline]
   __se_sys_sendmmsg net/socket.c:2763 [inline]
   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2763
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f04fb13a6b9
  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007ffd651f42d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04fb13a6b9
  RDX: 0000000000000001 RSI: 0000000020000d00 RDI: 0000000000000004
  RBP: 00007ffd651f4310 R08: 0000000000000001 R09: 0000000000000001
  R10: 0000000020000080 R11: 0000000000000246 R12: 00000000000f4240
  R13: 00007f04fb187449 R14: 00007ffd651f42f4 R15: 00007ffd651f4300
   </TASK>

As noted by Cong Wang, the splat is false positive, but the code
path leading to the report is an unexpected one: a client is
attempting an MPC handshake towards the in-kernel listener created
by the in-kernel PM for a port based signal endpoint.

Such connection will be never accepted; many of them can make the
listener queue full and preventing the creation of MPJ subflow via
such listener - its intended role.

Explicitly detect this scenario at initial-syn time and drop the
incoming MPC request.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f4aacdfef2c6a6529c3e
Cc: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c        |  1 +
 net/mptcp/mib.h        |  1 +
 net/mptcp/pm_netlink.c |  1 +
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 11 +++++++++++
 5 files changed, 15 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ad88bd3c58dffed8335eedb43ca6290418e3c4f4..19eb9292bd6093a760b41f98c1774fd2490c48e3 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -17,6 +17,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableSYNTXDrop", MPTCP_MIB_MPCAPABLEACTIVEDROP),
 	SNMP_MIB_ITEM("MPCapableSYNTXDisabled", MPTCP_MIB_MPCAPABLEACTIVEDISABLED),
+	SNMP_MIB_ITEM("MPCapableEndpAttempt", MPTCP_MIB_MPCAPABLEENDPATTEMPT),
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 3206cdda8bb1067f9a8354fd45deed86b67ac7da..128282982843a07614a46f9b2c2f7c708306c769 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -12,6 +12,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEDROP,	/* Client-side fallback due to a MPC drop */
 	MPTCP_MIB_MPCAPABLEACTIVEDISABLED, /* Client-side disabled due to past issues */
+	MPTCP_MIB_MPCAPABLEENDPATTEMPT,	/* Prohibited MPC to port-based endp */
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f6f0a38a0750f82bc909f02a75beec980d951f1f..1a78998fe1f49510ef1f487c8cd5b369a37fb20d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1121,6 +1121,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
+	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
 	err = __inet_listen_sk(ssk, backlog);
 	if (!err)
 		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 74417aae08d0f488bc358ce6cd931540650bb7be..568a72702b080d7610425ce5c3a409c7b88da13a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -535,6 +535,7 @@ struct mptcp_subflow_context {
 		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
+	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 25dde81bcb7575958635aaf14a5b8e9a5005e05f..6170f2fff71e4f9d64837f2ebf4d81bba224fafb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -132,6 +132,13 @@ static void subflow_add_reset_reason(struct sk_buff *skb, u8 reason)
 	}
 }
 
+static int subflow_reset_req_endp(struct request_sock *req, struct sk_buff *skb)
+{
+	SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEENDPATTEMPT);
+	subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+	return -EPERM;
+}
+
 /* Init mptcp request socket.
  *
  * Returns an error code if a JOIN has failed and a TCP reset
@@ -165,6 +172,8 @@ static int subflow_check_req(struct request_sock *req,
 	if (opt_mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 
+		if (unlikely(listener->pm_listener))
+			return subflow_reset_req_endp(req, skb);
 		if (opt_mp_join)
 			return 0;
 	} else if (opt_mp_join) {
@@ -172,6 +181,8 @@ static int subflow_check_req(struct request_sock *req,
 
 		if (mp_opt.backup)
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
+	} else if (unlikely(listener->pm_listener)) {
+		return subflow_reset_req_endp(req, skb);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {

-- 
2.45.2


