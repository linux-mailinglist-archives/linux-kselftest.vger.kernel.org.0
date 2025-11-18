Return-Path: <linux-kselftest+bounces-45929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68BC6BC5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 16E552AD10
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CBF31D757;
	Tue, 18 Nov 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsUiw09d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8530F53A;
	Tue, 18 Nov 2025 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502733; cv=none; b=dP4EZzlArfYyIRu3ssXF1NujROE+KsKxpE8QHRSd+bWdcpqeghwqxXV8ifGTPDEns7JjeJjdq5ZkSb0HXQu3Y4Zd3ZX6lfuaBsQ+Fgk6la8FHuXWBFJ2LkixJVhEFsD9atxBrGCf0iXXh602xl6XbiapWgew703eDS//l05Y7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502733; c=relaxed/simple;
	bh=IudkGQ6Ftj+GR26bJr5wJC2xiIKCXDdipzViIKvPrpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptC1xD3bh71oQ8qd5mTCDes8piTl3JTKPgfkkJaeDc4qoWVQAMpebwCYe89YzUk4Fetg2gx0ocp8bNHTbqUVkakcAne/0rEc0R8syMvImve3Ry5miqjtVHk7OSLBIWaeztS1xPJLvivBFkMSuG6NZkmXlnUMDO94+ipe0q0hD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsUiw09d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC91C19422;
	Tue, 18 Nov 2025 21:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502732;
	bh=IudkGQ6Ftj+GR26bJr5wJC2xiIKCXDdipzViIKvPrpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsUiw09dzZa5mNanIUxFLkm7OGNXEx900wyeiSRa9h/JZw1DOpij0Pgx6mhm57rpz
	 AmwvYzg3LjYYLnajFCz/WnpC6NOMODRkTaqio3EnVkAzJJLYJhTSM95oanYSr2eFfF
	 VUf8QSdtHUvbAEHOq6j2+FfYJ8G4cTUzb72hrDIn7y5mdycK+ZSh80wqYIVOTNC0Bv
	 YHCGaJUpNIDw4VHO8WE6vL5+Gtn0XVCxBIb+j9CxchrBmQz9lJIRNd8SGxWT9wHYVJ
	 s2LqSOjhvk7b0yJuJGTPCyJ/MGauITMZT6kiEIGFp7GJayFqLLlqt1K+TwJU3fi++K
	 /q4Xryj1OfALw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/12] netdevsim: add loopback support
Date: Tue, 18 Nov 2025 13:51:25 -0800
Message-ID: <20251118215126.2225826-12-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
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


