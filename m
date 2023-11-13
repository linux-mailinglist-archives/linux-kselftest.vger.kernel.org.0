Return-Path: <linux-kselftest+bounces-55-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146EF7EA6CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 00:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C324328106E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 23:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5763D97B;
	Mon, 13 Nov 2023 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU1QFw4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016920B28;
	Mon, 13 Nov 2023 23:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B272C433CC;
	Mon, 13 Nov 2023 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699917410;
	bh=2jeX2uvYGdFERiAmTgYhq8ls/6kWqVz41YErONEFjxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EU1QFw4KDclNNHXck3iTW41k2dh+DB5cw5HltIeq4TTToD+f+BrQztDX3ne40h0jf
	 YhfX4EPqNps7vr9CI/Rsigh+rWOPiPpOXP4rZ0S+zx0vEAcL9MIN4z5wF9254S1kDO
	 4vS8VDeuLlEo0KgxUI3YXnMxCcx0xn8dGrtEruFgG9QyBlViDmhCGYWScCxt3EL1o5
	 P5wI/oxRgxeGhnjMjZ8fQ3Dni+RCdF/mvN8MDboAepOohxJvgH4PusjhCZLuh1fzg2
	 i/13MzjaMOxa/Xl7s8tLPPIJe0xSIaoxBo2RWvDwoRcVGgszkOUnRvGnaqiMxSWnfB
	 kW4lEqXbVWGqg==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 14 Nov 2023 00:16:13 +0100
Subject: [PATCH net 1/5] mptcp: deal with large GSO size
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-1-7b9cd6a7b7f4@kernel.org>
References: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
In-Reply-To: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Poorva Sonparote <psonparo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@apple.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3784; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YRXLhzfEC4lljdr2nwDn01AzU3o8e037p4jOnZPvtQ8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5ZN7yapXbpxTVvBFqQLDB2/j7LcjDPRBREL
 4h0/bVwJuqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWQAKCRD2t4JPQmmg
 c3BAEACJ9JFVbmEJnFeRFDQXWb9QDX9FFEmBlM7VYvOTtAULytMT1YNhF7utw3w4K/Quc/fwUvn
 7EPQ8UXAn6+E3gKH02ctd3gLeZBO4VGlPrxtUYHZO8G1eFGyuMX9wg7FEvIskNOyMfURebFRkNN
 zoua91vpIVxa3iulECuRq9+x5mHc8a+2HvgUJl8Q8RSATL6Q7cWTdXelYG5+5rbTfwHKpiyR8fA
 t56v5SpJvuT+b9qdV0RK9w4M4xlyHgM5BrvJD5f3cTFgXPJndSa/apaXkUI8VdK0wTdO2BHL/Ek
 IJhQzkiqLGJAHCc/+a7N+ZbURM7kQTbrdyGSnS/AHc55Fjl0zxMWh8BRkTJkxELztE+uLphfo+6
 Xe2Pp3jyLVWlHgTvF9G6gBmZgiboMSNSGoQqBBV0Y5CTZvWSa3dzXnvhmN6J3jlKNieeNGKJ37I
 U6VGdy0t45iLfcSA5orEIdKrTYeZd3Dej6YpUn77OTHWKSW3s7hnV9MvjCYvZRT4QHhwwPklIKT
 wXngC1q2RUNkFMO0k88Not4rJKyKinzjAjt1T9M/A3decd7VOto3R/uSJk5Zzo6qwaFoOOMQuR0
 eLf5SW3UwFYWqwD4U42vq/qKyMxeOVvHah8AOsOtYgo+DQbC2p1QsCo0zdTMqs7b6R/vtMwEX7N
 1rbogMixW46MM6A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After the blamed commit below, the TCP sockets (and the MPTCP subflows)
can build egress packets larger than 64K. That exceeds the maximum DSS
data size, the length being misrepresent on the wire and the stream being
corrupted, as later observed on the receiver:

  WARNING: CPU: 0 PID: 9696 at net/mptcp/protocol.c:705 __mptcp_move_skbs_from_subflow+0x2604/0x26e0
  CPU: 0 PID: 9696 Comm: syz-executor.7 Not tainted 6.6.0-rc5-gcd8bdf563d46 #45
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
  netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
  RIP: 0010:__mptcp_move_skbs_from_subflow+0x2604/0x26e0 net/mptcp/protocol.c:705
  RSP: 0018:ffffc90000006e80 EFLAGS: 00010246
  RAX: ffffffff83e9f674 RBX: ffff88802f45d870 RCX: ffff888102ad0000
  netlink: 8 bytes leftover after parsing attributes in process `syz-executor.4'.
  RDX: 0000000080000303 RSI: 0000000000013908 RDI: 0000000000003908
  RBP: ffffc90000007110 R08: ffffffff83e9e078 R09: 1ffff1100e548c8a
  R10: dffffc0000000000 R11: ffffed100e548c8b R12: 0000000000013908
  R13: dffffc0000000000 R14: 0000000000003908 R15: 000000000031cf29
  FS:  00007f239c47e700(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f239c45cd78 CR3: 000000006a66c006 CR4: 0000000000770ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
  PKRU: 55555554
  Call Trace:
   <IRQ>
   mptcp_data_ready+0x263/0xac0 net/mptcp/protocol.c:819
   subflow_data_ready+0x268/0x6d0 net/mptcp/subflow.c:1409
   tcp_data_queue+0x21a1/0x7a60 net/ipv4/tcp_input.c:5151
   tcp_rcv_established+0x950/0x1d90 net/ipv4/tcp_input.c:6098
   tcp_v6_do_rcv+0x554/0x12f0 net/ipv6/tcp_ipv6.c:1483
   tcp_v6_rcv+0x2e26/0x3810 net/ipv6/tcp_ipv6.c:1749
   ip6_protocol_deliver_rcu+0xd6b/0x1ae0 net/ipv6/ip6_input.c:438
   ip6_input+0x1c5/0x470 net/ipv6/ip6_input.c:483
   ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:304
   __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5532
   process_backlog+0x353/0x660 net/core/dev.c:5974
   __napi_poll+0xc6/0x5a0 net/core/dev.c:6536
   net_rx_action+0x6a0/0xfd0 net/core/dev.c:6603
   __do_softirq+0x184/0x524 kernel/softirq.c:553
   do_softirq+0xdd/0x130 kernel/softirq.c:454

Address the issue explicitly bounding the maximum GSO size to what MPTCP
actually allows.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/450
Fixes: 7c4e983c4f3c ("net: allow gso_max_size to exceed 65536")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a0b8356cd8c5..66e947054945 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1230,6 +1230,8 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mptcp_do_fallback(ssk);
 }
 
+#define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1256,6 +1258,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		return -EAGAIN;
 
 	/* compute send limit */
+	if (unlikely(ssk->sk_gso_max_size > MPTCP_MAX_GSO_SIZE))
+		ssk->sk_gso_max_size = MPTCP_MAX_GSO_SIZE;
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	copy = info->size_goal;
 

-- 
2.40.1


