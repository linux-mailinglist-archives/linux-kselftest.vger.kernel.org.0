Return-Path: <linux-kselftest+bounces-46048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 594BCC71C79
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 59E8D2BB74
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689B29B777;
	Thu, 20 Nov 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kac52/W6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C987299954;
	Thu, 20 Nov 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604649; cv=none; b=lAEzMrRBwpvRm86X75nbJtMrIlOJ3UoQ80mMqYz6IntRuU/rLOzuIqDZd5wGw7kl4wSr0lsWe36V0EruT1wofIYdBIN/1rxz5tqcsErU8IzohK5DDcwJR4AWAwMlUzxNKjJOU/WT6Yb/o0pkl3H7+merqhqgZtdADvXZbsQFOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604649; c=relaxed/simple;
	bh=GGPnlgX2iQobN3wb/SWRFZZFbrk4oYQx4oWmCoBkq4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sssKhhHeHhpj+fiwXBNiiVy8hejBrXPXhS+4IMjOZflLEvV+oH/Yrt5Kh0jhIMcz67h7LoaRodvyu2FVqjGej48cXlW//ms5DaVUtC/eYarRnkKGKDq3d3Hm5lsoip7Bppg34kNrRZOURKaqF16MbVZ8PXlZRFjThENqTR6NNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kac52/W6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D3FC116D0;
	Thu, 20 Nov 2025 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604649;
	bh=GGPnlgX2iQobN3wb/SWRFZZFbrk4oYQx4oWmCoBkq4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kac52/W6mgBiHc9NFId0xxz5cfGnHiW8meKwe/7PlRmP0vn/n1X5OSpssDAeN3p6K
	 kIem53IIoWqCkq+GwGcbWPivfqujamcae8V1yHw4NO2EhuJ8nioySIjG74jw8w88zX
	 JoQ8Odv0OUWK/dC/8wuRPxyBl5kuntyfXvMwEh3xZhUMedHV6kSbZJnUvLwrXL4UiV
	 2AWuzrYKFCGj8jf71ubI6V9EjB/mX1Ax0id5fN1JWzSfFd0tvYTKlJgJEgWF2wRlQb
	 Ek4+2zXqkGo6sMNTnTkPiomZQOp0j3UV0Dzz5KlZq7DzG+XIoeop/nwsr6ru5zE3qG
	 /nz8q7xBlqNlw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 11/12] netdevsim: add loopback support
Date: Wed, 19 Nov 2025 18:10:23 -0800
Message-ID: <20251120021024.2944527-12-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support device loopback. Apparently this mode has been historically
supported by the toeplitz test and I don't have any HW which lets
me test the conversion..

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 2b713db16cd0..6927c1962277 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -133,15 +133,21 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out_drop_any;
 
-	peer_ns = rcu_dereference(ns->peer);
-	if (!peer_ns)
-		goto out_drop_any;
+	/* Check if loopback mode is enabled */
+	if (dev->features & NETIF_F_LOOPBACK) {
+		peer_ns = ns;
+		peer_dev = dev;
+	} else {
+		peer_ns = rcu_dereference(ns->peer);
+		if (!peer_ns)
+			goto out_drop_any;
+		peer_dev = peer_ns->netdev;
+	}
 
 	dr = nsim_do_psp(skb, ns, peer_ns, &psp_ext);
 	if (dr)
 		goto out_drop_free;
 
-	peer_dev = peer_ns->netdev;
 	rxq = skb_get_queue_mapping(skb);
 	if (rxq >= peer_dev->num_rx_queues)
 		rxq = rxq % peer_dev->num_rx_queues;
@@ -976,7 +982,8 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_FRAGLIST |
 			    NETIF_F_HW_CSUM |
 			    NETIF_F_LRO |
-			    NETIF_F_TSO;
+			    NETIF_F_TSO |
+			    NETIF_F_LOOPBACK;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_HW_OFFLOAD;
-- 
2.51.1


