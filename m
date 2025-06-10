Return-Path: <linux-kselftest+bounces-34531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA23BAD2AD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 02:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53381891D10
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7F015C0;
	Tue, 10 Jun 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9N28LeP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA18A645;
	Tue, 10 Jun 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514383; cv=none; b=ddRETkGKVgaf5xlg/MDSURj7wam2vWVFBUlFNpFTO48z9KmFi905lL2jbdrC+mgZbo7PRm7PUt3FEtaVw50ce7CNUiYPhgZ0rNbT15FMSGzZDW2KoDiLbFUsHU7Drz4/z9Gp7iIFcMJFPEd0ZLNh5xC422fUS9uF55hpHgpkRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514383; c=relaxed/simple;
	bh=EB5B/sD194nGvooI5Aa9H25sIT/lJMIiyYJPqiS3Kcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLN8X6QUrmqwfdU54UkibhwrrC8Sj4RkbeNKkpCskUYDh/NRP4gGE8JdY1+fY+o2wt+PKibi52tXy6W5CZAo8brK53ADHSBiFPFZQMyDsxt/02TogJpW3Oy8vw2EuAtPvVh3BQIMQUxro95EdxDvMCidnHH//uqpaRDdvlDyY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9N28LeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10D3C4CEEB;
	Tue, 10 Jun 2025 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749514383;
	bh=EB5B/sD194nGvooI5Aa9H25sIT/lJMIiyYJPqiS3Kcs=;
	h=From:To:Cc:Subject:Date:From;
	b=M9N28LePt8TMwfwr4f2GpM5qPRZZI1o8C4x3/5/2So2Yd+IPVI3g7XPN0nksNHRfr
	 3n50MaHMUIxKI8Gd1I+/CuC/I5PNRKH5rgNHU/z4ae0C5Evk85XD4SUKVpv7H6gcL6
	 tYzg6k5rmTR+JwonU7AR7OH1lCbMYWKU7cjxSomMtt5mUSDgPvJsNXGZV/doqdUbsF
	 ReFAT5QDY/g9sRAfA+mnOQyJ5FrnG8FmkNilhlG1UlZ/kkIgXomBnuyItsnSd94a80
	 G8PtkUAo7Fm+Hx3sLsoiV6teZO7F2bi51vFZAwetn80yHdEhWKgbBlAgfRjdx7v0A6
	 jdd8NbGkU4kEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	maze@google.com,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
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
Subject: [PATCH net v3 1/2] net: clear the dst when changing skb protocol
Date: Mon,  9 Jun 2025 17:12:44 -0700
Message-ID: <20250610001245.1981782-1-kuba@kernel.org>
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
Try to preserve metadata dsts, those may carry non-routing
metadata.

Cc: stable@vger.kernel.org
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_adjust_room()")
Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - go back to v1, the encap / decap which don't change proto
   will be added in -next
 - split out the test
v2: https://lore.kernel.org/20250607204734.1588964-1-kuba@kernel.org
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
 net/core/filter.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 327ca73f9cd7..7a72f766aacf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3233,6 +3233,13 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
+{
+	skb->protocol = htons(proto);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+}
+
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
 	/* Caller already did skb_cow() with len as headroom,
@@ -3329,7 +3336,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IPV6);
+	bpf_skb_change_protocol(skb, ETH_P_IPV6);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3359,7 +3366,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IP);
+	bpf_skb_change_protocol(skb, ETH_P_IP);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3550,10 +3557,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Match skb->protocol to new outer l3 protocol */
 		if (skb->protocol == htons(ETH_P_IP) &&
 		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
-			skb->protocol = htons(ETH_P_IPV6);
+			bpf_skb_change_protocol(skb, ETH_P_IPV6);
 		else if (skb->protocol == htons(ETH_P_IPV6) &&
 			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
-			skb->protocol = htons(ETH_P_IP);
+			bpf_skb_change_protocol(skb, ETH_P_IP);
 	}
 
 	if (skb_is_gso(skb)) {
@@ -3606,10 +3613,10 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	/* Match skb->protocol to new outer l3 protocol */
 	if (skb->protocol == htons(ETH_P_IP) &&
 	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		skb->protocol = htons(ETH_P_IPV6);
+		bpf_skb_change_protocol(skb, ETH_P_IPV6);
 	else if (skb->protocol == htons(ETH_P_IPV6) &&
 		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		skb->protocol = htons(ETH_P_IP);
+		bpf_skb_change_protocol(skb, ETH_P_IP);
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
-- 
2.49.0


