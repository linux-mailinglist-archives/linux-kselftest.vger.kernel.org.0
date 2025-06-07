Return-Path: <linux-kselftest+bounces-34435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD912AD0FCE
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 22:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E231600A4
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BA1F1505;
	Sat,  7 Jun 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKKGIE2A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3ED4315C;
	Sat,  7 Jun 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749329259; cv=none; b=hKIa9nx2AWXXGxw9i0EEk2wU+fcL5ypFcRg/tRtnHtjTqlhFBURO6B5Hf029s6XxjsVRDsLtoKBC6dLiTRBiyPT73QVrB2pEAngSyoxzImPcsVilRfiM9U/m/wIH42c9p1SGbrTGztQbN3x1e8ZNybvTEARnW0OwSdMd2Z5AQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749329259; c=relaxed/simple;
	bh=z1xyZoJq06mfqJaVqxYBZnNiW30P5vCqYojPQzfSySg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nd3CZgg23m5Do95uEo8PbJOC8fQYQyH5HFdf00ssAeKy3gCQK73uTWSHQQNLX5TPrvlXy2Mrw7sinlWn1dWcQ6sqlbLr/1/XriTZi93khSE0X0EgBkIFh3m6K/byqCQ2AmnXR6g/dbdjXcQmfRGORfqO7InCmSOAfhJMQ/Bbk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKKGIE2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36023C4CEE4;
	Sat,  7 Jun 2025 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749329259;
	bh=z1xyZoJq06mfqJaVqxYBZnNiW30P5vCqYojPQzfSySg=;
	h=From:To:Cc:Subject:Date:From;
	b=FKKGIE2AJ4C2b0lPFDJPPaBxOUK/Z7E3RnqtkP6+n6cPUjHJKwiV2lNzQYAbShTN5
	 SsEdqkz1IFiOup33+nUCFFKBKZx/pI1ey6PSg9ZL4XrzyNnRHis8mUP6Dd7v3O9Jzf
	 QEhQjXeOqUK2gysAWnR1JlJas/NGGacrNajNdg0uGG3JFDaOg+hlzWTO7dVqLsvoWu
	 RDaDeLERiHEKRTGRQ2ynhj7BGH0jZZKofzLJD58UgttpiYguyYTq+6ZQsTrceYPhNF
	 glibqDjqpkBU8DXDgqb1lv0AyALD/pVLjcQgVHhunWxCA05Wzpr99wEEfC9Y1SGqGS
	 YoPlwmxKtxLNg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	eddyz87@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	willemb@google.com,
	william.xuanziyang@huawei.com,
	alan.maguire@oracle.com,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH net v2] net: clear the dst when changing skb protocol
Date: Sat,  7 Jun 2025 13:47:34 -0700
Message-ID: <20250607204734.1588964-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A not-so-careful NAT46 BPF program can crash the kernel
if it indiscriminately flips ingress packets from v4 to v6:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
    ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
    ipv6_rcv (net/ipv6/ip6_input.c:306:8)
    process_backlog (net/core/dev.c:6186:4)
    napi_poll (net/core/dev.c:6906:9)
    net_rx_action (net/core/dev.c:7028:13)
    do_softirq (kernel/softirq.c:462:3)
    netif_rx (net/core/dev.c:5326:3)
    dev_loopback_xmit (net/core/dev.c:4015:2)
    ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
    NF_HOOK (./include/linux/netfilter.h:314:9)
    ip_mc_output (net/ipv4/ip_output.c:400:5)
    dst_output (./include/net/dst.h:459:9)
    ip_local_out (net/ipv4/ip_output.c:130:9)
    ip_send_skb (net/ipv4/ip_output.c:1496:8)
    udp_send_skb (net/ipv4/udp.c:1040:8)
    udp_sendmsg (net/ipv4/udp.c:1328:10)

The output interface has a 4->6 program attached at ingress.
We try to loop the multicast skb back to the sending socket.
Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
and changes skb->protocol to v6. We enter ip6_rcv_core which
tries to use skb_dst(). But the dst is still an IPv4 one left
after IPv4 mcast output.

Clear the dst in all BPF helpers which change the protocol.
Also clear the dst if we did an encap or decap as those
will most likely make the dst stale.
Try to preserve metadata dsts, those may carry non-routing
metadata.

Reviewed-by: Maciej Żenczykowski <maze@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_adjust_room()")
Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - drop on encap/decap
 - fix typo (protcol)
 - add the test to the Makefile
v1: https://lore.kernel.org/20250604210604.257036-1-kuba@kernel.org

I wonder if we should not skip ingress (tc_skip_classify?)
for looped back packets in the first place. But that doesn't
seem robust enough vs multiple redirections to solve the crash.

Ignoring LOOPBACK packets (like the NAT46 prog should) doesn't
work either, since BPF can change pkt_type arbitrarily.

CC: martin.lau@linux.dev
CC: daniel@iogearbox.net
CC: john.fastabend@gmail.com
CC: eddyz87@gmail.com
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: willemb@google.com
CC: william.xuanziyang@huawei.com
CC: alan.maguire@oracle.com
CC: bpf@vger.kernel.org
CC: edumazet@google.com
CC: maze@google.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: yonghong.song@linux.dev
---
 tools/testing/selftests/net/Makefile   |  1 +
 net/core/filter.c                      | 31 +++++++++++++++++++-------
 tools/testing/selftests/net/nat6to4.sh | 15 +++++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/nat6to4.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index ea84b88bcb30..ab996bd22a5f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -27,6 +27,7 @@ TEST_PROGS += amt.sh
 TEST_PROGS += unicast_extensions.sh
 TEST_PROGS += udpgro_fwd.sh
 TEST_PROGS += udpgro_frglist.sh
+TEST_PROGS += nat6to4.sh
 TEST_PROGS += veth.sh
 TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
diff --git a/net/core/filter.c b/net/core/filter.c
index 327ca73f9cd7..d5917d6446f2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3406,8 +3406,14 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 	 * need to be verified first.
 	 */
 	ret = bpf_skb_proto_xlat(skb, proto);
+	if (ret)
+		return ret;
+
 	bpf_compute_data_pointers(skb);
-	return ret;
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	return 0;
 }
 
 static const struct bpf_func_proto bpf_skb_change_proto_proto = {
@@ -3554,6 +3560,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		else if (skb->protocol == htons(ETH_P_IPV6) &&
 			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
 			skb->protocol = htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
 	}
 
 	if (skb_is_gso(skb)) {
@@ -3581,6 +3590,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			      u64 flags)
 {
+	bool decap = flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
 	int ret;
 
 	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
@@ -3603,13 +3613,18 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (unlikely(ret < 0))
 		return ret;
 
-	/* Match skb->protocol to new outer l3 protocol */
-	if (skb->protocol == htons(ETH_P_IP) &&
-	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		skb->protocol = htons(ETH_P_IPV6);
-	else if (skb->protocol == htons(ETH_P_IPV6) &&
-		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		skb->protocol = htons(ETH_P_IP);
+	if (decap) {
+		/* Match skb->protocol to new outer l3 protocol */
+		if (skb->protocol == htons(ETH_P_IP) &&
+		    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
+			skb->protocol = htons(ETH_P_IPV6);
+		else if (skb->protocol == htons(ETH_P_IPV6) &&
+			 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
+			skb->protocol = htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
+	}
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
diff --git a/tools/testing/selftests/net/nat6to4.sh b/tools/testing/selftests/net/nat6to4.sh
new file mode 100755
index 000000000000..0ee859b622a4
--- /dev/null
+++ b/tools/testing/selftests/net/nat6to4.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+NS="ns-peer-$(mktemp -u XXXXXX)"
+
+ip netns add "${NS}"
+ip -netns "${NS}" link set lo up
+ip -netns "${NS}" route add default via 127.0.0.2 dev lo
+
+tc -n "${NS}" qdisc add dev lo ingress
+tc -n "${NS}" filter add dev lo ingress prio 4 protocol ip \
+   bpf object-file nat6to4.bpf.o section schedcls/egress4/snat4 direct-action
+
+ip netns exec "${NS}" \
+   bash -c 'echo 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789abc | socat - UDP4-DATAGRAM:224.1.0.1:6666,ip-multicast-loop=1'
-- 
2.49.0


