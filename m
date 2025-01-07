Return-Path: <linux-kselftest+bounces-23978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E961DA03A5B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 09:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E801B7A233C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5B1DFDBF;
	Tue,  7 Jan 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bU4BdYcn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41677198E78;
	Tue,  7 Jan 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240254; cv=none; b=p65pfIyGT9WgmXpuS7pKdSI533Jb4PdIFfrtMzcC2j+IJilUnOJhDVMsVuiPjzy/2FKu4PiVL81SItaQVh6fjp9UUJLvZRtxPDW0yDj2fkRJ+CllqFYlLoEzxNxCMRYs7H/I9WB8Ez0z0GU9xEveggauSUhzbbBWURbR+nwrljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240254; c=relaxed/simple;
	bh=2j0To2z708Hn2b6bNch2njDc+GPMbDoEWEYZbiTv8rQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0Dl3nDUPm0pq7HyThDhbv9WqKE89dKowRV6Qh0rKRtqAY7ZoCue99GZ8OOReK+Gzrz7cyXpbixSdjLjEAuFJ6fSyNRjWkKb2fhf7T9UJpd3aUVSfBfdajX/BWNdqNCufqakKbxpp+pNlNoaWaiaM6XV4ALIf4utjAkmPeblVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bU4BdYcn; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736240251; x=1767776251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SC1mbAev+9sK6OCOjA6+EkRnZ+bYlCkoq+asNgcdmS4=;
  b=bU4BdYcn0Ax0KfqIt9LTTFgJpdB5xiU49v4k/HZFsOk2ktDZcqN+Rm2B
   4mP3cG7zpiv0HZKg13pQgQOTmNPT/X4aunjU5ErSAURKYX4RqHr+OKV9I
   L+Ryr5HiLY4ZfRb+UdU1E3OPeFFUbryZnSwsaGKLiuX3tA0OcP3XFMugP
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,295,1728950400"; 
   d="scan'208";a="159523600"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 08:57:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:39955]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.119:2525] with esmtp (Farcaster)
 id 9f3ed6e6-aeb4-4841-95ac-539e22d429cf; Tue, 7 Jan 2025 08:57:29 +0000 (UTC)
X-Farcaster-Flow-ID: 9f3ed6e6-aeb4-4841-95ac-539e22d429cf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 7 Jan 2025 08:57:28 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.249.113) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 7 Jan 2025 08:57:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <andrew+netdev@lunn.ch>, <b.a.t.m.a.n@lists.open-mesh.org>,
	<bpf@vger.kernel.org>, <bridge@lists.linux.dev>, <davem@davemloft.net>,
	<donald.hunter@gmail.com>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <idosch@nvidia.com>, <jiri@resnulli.us>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-can@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-ppp@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<liuhangbin@gmail.com>, <netdev@vger.kernel.org>,
	<osmocom-net-gprs@lists.osmocom.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
Date: Tue, 7 Jan 2025 17:56:46 +0900
Message-ID: <20250107085646.42302-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Sat,  4 Jan 2025 20:57:21 +0800
> This patch series includes some netns-related improvements and fixes for
> rtnetlink, to make link creation more intuitive:
> 
>  1) Creating link in another net namespace doesn't conflict with link
>     names in current one.
>  2) Refector rtnetlink link creation. Create link in target namespace
>     directly.
> 
> So that
> 
>   # ip link add netns ns1 link-netns ns2 tun0 type gre ...
> 
> will create tun0 in ns1, rather than create it in ns2 and move to ns1.
> And don't conflict with another interface named "tun0" in current netns.
> 
> Patch 01 serves for 1) to avoids link name conflict in different netns.
> 
> To achieve 2), there're mainly 3 steps:
> 
>  - Patch 02 packs newlink() parameters into a struct, including
>    the original "src_net" along with more netns context. No semantic
>    changes are introduced.
>  - Patch 03 ~ 07 converts device drivers to use the explicit netns
>    extracted from params.
>  - Patch 08 ~ 09 removes the old netns parameter, and converts
>    rtnetlink to create device in target netns directly.
> 
> Patch 10 ~ 11 adds some tests for link name and link netns.
> 
> 
> BTW please note there're some issues found in current code:
> 
> - In amt_newlink() drivers/net/amt.c:
> 
>     amt->net = net;
>     ...
>     amt->stream_dev = dev_get_by_index(net, ...
> 
>   Uses net, but amt_lookup_upper_dev() only searches in dev_net.
>   So the AMT device may not be properly deleted if it's in a different
>   netns from lower dev.

I think you are right, and the upper device will be leaked
and UAF will happen.

amt must manage a list linked to a lower dev.

Given no one has reported the issue, another option would be
drop cross netns support in a short period.

---8<---
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 98c6205ed19f..d39a5fe17a6f 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3168,6 +3168,12 @@ static int amt_newlink(struct net *net, struct net_device *dev,
 	struct amt_dev *amt = netdev_priv(dev);
 	int err = -EINVAL;
 
+	if (!net_eq(net, dev_net(dev))) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_TARGET_NETNSID],
+				    "Can't find stream device in a different netns");
+		return err;
+	}
+
 	amt->net = net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
 
---8<---


> 
> - In gtp_newlink() in drivers/net/gtp.c:
> 
>     gtp->net = src_net;
>     ...
>     gn = net_generic(dev_net(dev), gtp_net_id);
>     list_add_rcu(&gtp->list, &gn->gtp_dev_list);
> 
>   Uses src_net, but priv is linked to list in dev_net. So it may not be
>   properly deleted on removal of link netns.

The device is linked to a list in the same netns, so the
device will not be leaked.  See gtp_net_exit_batch_rtnl().

Rather, the problem is the udp tunnel socket netns could be
freed earlier than the dev netns.

---8<---
# ip netns add test
# ip netns attach root 1
# ip -n test link add netns root name gtp0 type gtp role sgsn
# ip netns del test
[  125.828205] ref_tracker: net notrefcnt@0000000061c9afc0 has 1/2 users at
[  125.828205]      sk_alloc+0x7c8/0x8c0
[  125.828205]      inet_create+0x284/0xd70
[  125.828205]      __sock_create+0x23b/0x6a0
[  125.828205]      udp_sock_create4+0x94/0x3f0
[  125.828205]      gtp_create_sock+0x286/0x340
[  125.828205]      gtp_create_sockets+0x43/0x110
[  125.828205]      gtp_newlink+0x775/0x1070
[  125.828205]      rtnl_newlink+0xa7f/0x19e0
[  125.828205]      rtnetlink_rcv_msg+0x71b/0xc10
[  125.828205]      netlink_rcv_skb+0x12b/0x360
[  125.828205]      netlink_unicast+0x446/0x710
[  125.828205]      netlink_sendmsg+0x73a/0xbf0
[  125.828205]      ____sys_sendmsg+0x89d/0xb00
[  125.828205]      ___sys_sendmsg+0xe9/0x170
[  125.828205]      __sys_sendmsg+0x104/0x190
[  125.828205]      do_syscall_64+0xc1/0x1d0
[  125.828205] 
[  125.833135] ref_tracker: net notrefcnt@0000000061c9afc0 has 1/2 users at
[  125.833135]      sk_alloc+0x7c8/0x8c0
[  125.833135]      inet_create+0x284/0xd70
[  125.833135]      __sock_create+0x23b/0x6a0
[  125.833135]      udp_sock_create4+0x94/0x3f0
[  125.833135]      gtp_create_sock+0x286/0x340
[  125.833135]      gtp_create_sockets+0x21/0x110
[  125.833135]      gtp_newlink+0x775/0x1070
[  125.833135]      rtnl_newlink+0xa7f/0x19e0
[  125.833135]      rtnetlink_rcv_msg+0x71b/0xc10
[  125.833135]      netlink_rcv_skb+0x12b/0x360
[  125.833135]      netlink_unicast+0x446/0x710
[  125.833135]      netlink_sendmsg+0x73a/0xbf0
[  125.833135]      ____sys_sendmsg+0x89d/0xb00
[  125.833135]      ___sys_sendmsg+0xe9/0x170
[  125.833135]      __sys_sendmsg+0x104/0x190
[  125.833135]      do_syscall_64+0xc1/0x1d0
[  125.833135] 
[  125.837998] ------------[ cut here ]------------
[  125.838345] WARNING: CPU: 0 PID: 11 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x26c/0x520
[  125.838906] Modules linked in:
[  125.839130] CPU: 0 UID: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.13.0-rc5-00150-gc707e6e25dde #188
[  125.839734] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  125.840497] Workqueue: netns cleanup_net
[  125.840773] RIP: 0010:ref_tracker_dir_exit+0x26c/0x520
[  125.841128] Code: 00 00 00 fc ff df 4d 8b 26 49 bd 00 01 00 00 00 00 ad de 4c 39 f5 0f 85 df 00 00 00 48 8b 74 24 08 48 89 df e8 a5 cc 12 02 90 <0f> 0b 90 48 8d 6b 44 be 04 00 00 00 48 89 ef e8 80 de 67 ff 48 89
[  125.842364] RSP: 0018:ff11000007f3fb60 EFLAGS: 00010286
[  125.842714] RAX: 0000000000004337 RBX: ff1100000d231aa0 RCX: 1ffffffff0e40d5c
[  125.843195] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8423ee3c
[  125.843664] RBP: ff1100000d231af0 R08: 0000000000000001 R09: fffffbfff0e397ae
[  125.844142] R10: 0000000000000001 R11: 0000000000036001 R12: ff1100000d231af0
[  125.844606] R13: dead000000000100 R14: ff1100000d231af0 R15: dffffc0000000000
[  125.845067] FS:  0000000000000000(0000) GS:ff1100006ce00000(0000) knlGS:0000000000000000
[  125.845596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.845984] CR2: 0000564cbf104000 CR3: 000000000ef44001 CR4: 0000000000771ef0
[  125.846480] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  125.846958] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  125.847450] PKRU: 55555554
[  125.847634] Call Trace:
[  125.847800]  <TASK>
[  125.847946]  ? __warn+0xcc/0x2d0
[  125.848177]  ? ref_tracker_dir_exit+0x26c/0x520
[  125.848485]  ? report_bug+0x28c/0x2d0
[  125.848742]  ? handle_bug+0x54/0xa0
[  125.848982]  ? exc_invalid_op+0x18/0x50
[  125.849252]  ? asm_exc_invalid_op+0x1a/0x20
[  125.849537]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[  125.849865]  ? ref_tracker_dir_exit+0x26c/0x520
[  125.850174]  ? __pfx_ref_tracker_dir_exit+0x10/0x10
[  125.850510]  ? kfree+0x1cf/0x3e0
[  125.850740]  net_free+0x5d/0x90
[  125.850962]  cleanup_net+0x685/0x8e0
[  125.851226]  ? __pfx_cleanup_net+0x10/0x10
[  125.851514]  process_one_work+0x7d4/0x16f0
[  125.851795]  ? __pfx_lock_acquire+0x10/0x10
[  125.852072]  ? __pfx_process_one_work+0x10/0x10
[  125.852396]  ? assign_work+0x167/0x240
[  125.852653]  ? lock_is_held_type+0x9e/0x120
[  125.852931]  worker_thread+0x54c/0xca0
[  125.853193]  ? __pfx_worker_thread+0x10/0x10
[  125.853485]  kthread+0x249/0x300
[  125.853709]  ? __pfx_kthread+0x10/0x10
[  125.853966]  ret_from_fork+0x2c/0x70
[  125.854229]  ? __pfx_kthread+0x10/0x10
[  125.854480]  ret_from_fork_asm+0x1a/0x30
[  125.854746]  </TASK>
[  125.854897] irq event stamp: 17849
[  125.855138] hardirqs last  enabled at (17883): [<ffffffff812dc6ad>] __up_console_sem+0x4d/0x60
[  125.855714] hardirqs last disabled at (17892): [<ffffffff812dc692>] __up_console_sem+0x32/0x60
[  125.856315] softirqs last  enabled at (17878): [<ffffffff8117d603>] handle_softirqs+0x4f3/0x750
[  125.856908] softirqs last disabled at (17857): [<ffffffff8117d9e4>] __irq_exit_rcu+0xc4/0x100
[  125.857492] ---[ end trace 0000000000000000 ]---
---8<---

We can fix this by linking the dev to the socket's netns and
clean them up in __net_exit hook as done in bareudp and geneve.

---8<---
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..77638a815873 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -70,6 +70,7 @@ struct pdp_ctx {
 /* One instance of the GTP device. */
 struct gtp_dev {
 	struct list_head	list;
+	struct list_head	sock_list;
 
 	struct sock		*sk0;
 	struct sock		*sk1u;
@@ -102,6 +103,7 @@ static unsigned int gtp_net_id __read_mostly;
 
 struct gtp_net {
 	struct list_head gtp_dev_list;
+	struct list_head gtp_sock_list;
 };
 
 static u32 gtp_h_initval;
@@ -1526,6 +1528,10 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 
 	gn = net_generic(dev_net(dev), gtp_net_id);
 	list_add_rcu(&gtp->list, &gn->gtp_dev_list);
+
+	gn = net_generic(src_net, gtp_net_id);
+	list_add(&gtp->sock_list, &gn->gtp_sock_list);
+
 	dev->priv_destructor = gtp_destructor;
 
 	netdev_dbg(dev, "registered new GTP interface\n");
@@ -1552,6 +1558,7 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 			pdp_context_delete(pctx);
 
 	list_del_rcu(&gtp->list);
+	list_del(&gtp->sock_list);
 	unregister_netdevice_queue(dev, head);
 }
 
@@ -2465,6 +2472,8 @@ static int __net_init gtp_net_init(struct net *net)
 	struct gtp_net *gn = net_generic(net, gtp_net_id);
 
 	INIT_LIST_HEAD(&gn->gtp_dev_list);
+	INIT_LIST_HEAD(&gn->gtp_sock_list);
+
 	return 0;
 }
 
@@ -2475,9 +2484,12 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
-		struct gtp_dev *gtp;
+		struct gtp_dev *gtp, *next;
+
+		list_for_each_entry_safe(gtp, next, &gn->gtp_dev_list, list)
+			gtp_dellink(gtp->dev, dev_to_kill);
 
-		list_for_each_entry(gtp, &gn->gtp_dev_list, list)
+		list_for_each_entry_safe(gtp, next, &gn->gtp_sock_list, sock_list)
 			gtp_dellink(gtp->dev, dev_to_kill);
 	}
 }
---8<---


> 
> - In pfcp_newlink() in drivers/net/pfcp.c:
> 
>     pfcp->net = net;
>     ...
>     pn = net_generic(dev_net(dev), pfcp_net_id);
>     list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
> 
>   Same as above.

I haven't tested pfcp but it seems to have the same problem.

I'll post patches for gtp and pfcp.


> 
> - In lowpan_newlink() in net/ieee802154/6lowpan/core.c:
> 
>     wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
> 
>   Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
>   in link netns.

I guess you mean the ifindex is defined in src_net instead.
Not sure if it's too late to change the behaviour.

