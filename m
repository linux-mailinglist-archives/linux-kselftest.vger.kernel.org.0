Return-Path: <linux-kselftest+bounces-35257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA5ADE593
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFD9189D3E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0753B27FB2D;
	Wed, 18 Jun 2025 08:33:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014571EEA40;
	Wed, 18 Jun 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235580; cv=none; b=FHUdS+YxpbQ7G91l1M6jiRiVlxNd0K5+z0BCli4ybI8tPpoEs//DbXWEbCPFEfR+FbvunA88Xaba3UFm4UMrvbd2AEgjZaG/HCo066tT4cuRU+vlXuKJwlZR8eBNJjJWzBQ26GKZ7O9GWEfTgERxok1mwo3ZeZB0F/aDlbkTHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235580; c=relaxed/simple;
	bh=Ya02A6KSQP7IifJw9ze9oqhqSpeNuf34AYwn/7z5joU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEIAArZfGCLdU2ECSqMGtLWFTiH/AYyByByenDU+r83Igq1Pf/TB/EhFWnrmGH0h/tr7/reTyhEHLDGvNL0kr6PSJbAl2moU5E6l3jwLbD9C8EyQ3uxM9Vr1ASJKkJKqLChFAC/Ox5i1HhjKQ1lYfLoHkLKgHc97TFXTE1kCWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad883afdf0cso1301329766b.0;
        Wed, 18 Jun 2025 01:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750235577; x=1750840377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBnJcIZF2UCEJDwnnA5SfZDnvEUhOFTZwy3JCGcNINI=;
        b=oezVzWkmLjFn+I/Q9gjyBzSSjxJsytgD2bUQu75LG4Y3C1VXS/7g0IIiv2MKG7WNf5
         cv+fOBBARAXNW5F9ik3bRxf4JZMeoL0VkAVYKLTs8Nt7noMW2Tn2zwjV6ShVX9rTx2fb
         w3boStA9E5BLKQwTVf1/QOQ/q7fH69yqBK3npdQH6yBr9VSs+NB5EzHjpav07+dmNu9t
         6zbNGhMhzs6QGQI43evzs4qViW//9QgDFSLxdXvObBpjp13ChrV77WxUDBuF4P7czuM+
         0rIAocJaNEJ72dE3X5rLefsEFulE6wU7dnISNMHmsn8wxVKzaUUIijD6+4CHb0Pjiy0H
         q1ew==
X-Forwarded-Encrypted: i=1; AJvYcCWcVmP4coTKMbIV7ugjehAAZK910dpgSTgcj+/zzSYMLi6/KWRXJ5er51uzvHhs2FgpTvsu7aKcHiUBOzM=@vger.kernel.org, AJvYcCX5brsDeDZA5N9b3y1FtbqRuwdJt8xP5+EXUPtN5G64wfgUSn8feTPY+kO5lKMfVlKdRbKQ0J72vGNGXCh5qEYo@vger.kernel.org
X-Gm-Message-State: AOJu0YwUkVhhMnkAaB/mRcGxUKIVch7xf76nn9ENACWEI3DGrhzQhqKb
	Pjqhs/JGD4JC/B2W+H7683x8DRz7Kj37jlwN5Btb7e3vHjpBWpP5rtMn
X-Gm-Gg: ASbGncsxSU8SlpQPgJUeOu+KkMIMCsQNLWhOcV1kQiGgfkr5qlKPZ23SW/l2qR8QtQI
	ioZYGjyPol/8fX/0/Trwc5aPzwpSCMVvG3YE7pBbREwjtx2si4s1CMnM/tUwZMtU2VwKfXc2d6O
	r+K6s2cyohK5RFUUXT7K8TAlq09MDYc+6q1+mjpKmfHBJXzz67v8rD/FBOFjN1emEX+TuTRX4tP
	MA95/YYqMkbl83LES62A/2fYc2rylwsPsMRrisOTk5pjwr78XidDRlzRLbVwWwJ0jeAgGvbv1i2
	z3QknxupEg+pi/hrjj/6LWi/55DEjlgU2yFArx6hGcVjprCGDX0wgg==
X-Google-Smtp-Source: AGHT+IH9+K3XVhXg1nTZyGPs4R0Oq2xdoVDSJwYCAIwGXBVGtboeQwWRzQuh0LpeJom2RA72Ua7PPw==
X-Received: by 2002:a17:907:920a:b0:ae0:1b44:43c9 with SMTP id a640c23a62f3a-ae01b44480emr119285166b.60.1750235576819;
        Wed, 18 Jun 2025 01:32:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec892ab29sm1000223866b.114.2025.06.18.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 01:32:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Jun 2025 01:32:42 -0700
Subject: [PATCH net-next v4 1/4] netdevsim: migrate to dstats stats
 collection
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-netdevsim_stat-v4-1-19fe0d35e28e@debian.org>
References: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
In-Reply-To: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com, Joe Damato <joe@dama.to>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4957; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ya02A6KSQP7IifJw9ze9oqhqSpeNuf34AYwn/7z5joU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUnm1GhmHtd/d4WZp8ub6yCIp901Fk7R4m/2Nt
 3hqhrwkSAyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFJ5tQAKCRA1o5Of/Hh3
 bUStEACldGbIVFpgyJ1IDyFif97TLe2MFkPCf2d0h+JsSs3+Pn+gNT5N0S0dfNXMRsyf2NimVzq
 d/e+neWBtPlNjbBP/w6Zx/5IHQJwFSSClltVfqkoxarEWBbq3jbVlitxshaIEQ5GoaVYgchG0s5
 8PDyr65urBbnGdqXewKUFwLPCFxcGEC+jJvR1DtRH2YafFOYAPB2TKNFkY5/jXD7WyStAaLtph1
 /P31yQzdizUKKy5tBa/Pd+MoUIF90ZklOx+FqZVSGiGcvz8WuXX/DWz8naKj1GmXP8l+bx70J3l
 3ptalNXfd0/de/1N9crPSs1+yplZe8CJb5oeIHjNNnSZTfi7XPmK8qqhCgLmpmB77eATZQAPfUU
 03NgI9SrmeHjS4j9NUJSblxiLSpPtVGPRjv8S89tyqAjtQrIVc8wFFz7qAtXX4vfIi2EAb+eY9h
 JUXZeWfAj5XQHB4cj/BvBerKLlKA+cdZEEOuaDP5HVaSj66imhUplXna2sH3SvMYvpK2VK1SY1J
 pyWb04FHWKKN9+nKoyUdaUK8fQsWkdPV4Y8Sl/Tnf0GUX1J4kmbyI6ihvrl8N/NOIe34Wd/ZmY8
 6LBxXYxwzESlVFtbz6ZqHVvIJm5ORrN8fbzNIwId/cuj26AvSoGI54Gvc9OItwv7Z4tE9OtoFpj
 li+TXlggYCCFhDg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace custom statistics tracking with the kernel's dstats infrastructure
to simplify code and improve consistency with other network drivers.

This change:
- Sets dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS for automatic
  automatic allocation and deallocation.
- Removes manual stats fields and their update
- Replaces custom nsim_get_stats64() with dev_get_stats()
- Uses dev_dstats_tx_add() and dev_dstats_tx_dropped() helpers
- Eliminates the need for manual synchronization primitives

The dstats framework provides the same functionality with less code.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c    | 33 ++++++---------------------------
 drivers/net/netdevsim/netdevsim.h |  5 -----
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index fa5fbd97ad69e..5010d8eefc854 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -93,19 +93,14 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
 	rcu_read_unlock();
-	u64_stats_update_begin(&ns->syncp);
-	ns->tx_packets++;
-	ns->tx_bytes += len;
-	u64_stats_update_end(&ns->syncp);
+	dev_dstats_tx_add(dev, skb->len);
 	return NETDEV_TX_OK;
 
 out_drop_free:
 	dev_kfree_skb(skb);
 out_drop_cnt:
 	rcu_read_unlock();
-	u64_stats_update_begin(&ns->syncp);
-	ns->tx_dropped++;
-	u64_stats_update_end(&ns->syncp);
+	dev_dstats_tx_dropped(dev);
 	return NETDEV_TX_OK;
 }
 
@@ -126,20 +121,6 @@ static int nsim_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void
-nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
-{
-	struct netdevsim *ns = netdev_priv(dev);
-	unsigned int start;
-
-	do {
-		start = u64_stats_fetch_begin(&ns->syncp);
-		stats->tx_bytes = ns->tx_bytes;
-		stats->tx_packets = ns->tx_packets;
-		stats->tx_dropped = ns->tx_dropped;
-	} while (u64_stats_fetch_retry(&ns->syncp, start));
-}
-
 static int
 nsim_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
 {
@@ -556,7 +537,6 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-	.ndo_get_stats64	= nsim_get_stats64,
 	.ndo_set_vf_mac		= nsim_set_vf_mac,
 	.ndo_set_vf_vlan	= nsim_set_vf_vlan,
 	.ndo_set_vf_rate	= nsim_set_vf_rate,
@@ -580,7 +560,6 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-	.ndo_get_stats64	= nsim_get_stats64,
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
 };
@@ -594,7 +573,7 @@ static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		nsim_get_stats64(dev, &rtstats);
+		dev_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;
 	stats->bytes = rtstats.rx_bytes;
@@ -606,7 +585,7 @@ static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct rtnl_link_stats64 rtstats = {};
 
 	if (!idx)
-		nsim_get_stats64(dev, &rtstats);
+		dev_get_stats(dev, &rtstats);
 
 	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
 	stats->bytes = rtstats.tx_bytes;
@@ -618,7 +597,7 @@ static void nsim_get_base_stats(struct net_device *dev,
 {
 	struct rtnl_link_stats64 rtstats = {};
 
-	nsim_get_stats64(dev, &rtstats);
+	dev_get_stats(dev, &rtstats);
 
 	rx->packets = !!rtstats.rx_packets;
 	rx->bytes = 0;
@@ -890,6 +869,7 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_HW_CSUM |
 			    NETIF_F_LRO |
 			    NETIF_F_TSO;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
 }
@@ -1022,7 +1002,6 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	dev_net_set(dev, nsim_dev_net(nsim_dev));
 	ns = netdev_priv(dev);
 	ns->netdev = dev;
-	u64_stats_init(&ns->syncp);
 	ns->nsim_dev = nsim_dev;
 	ns->nsim_dev_port = nsim_dev_port;
 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d04401f0bdf79..343b8f19dbed6 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -108,11 +108,6 @@ struct netdevsim {
 
 	int rq_reset_mode;
 
-	u64 tx_packets;
-	u64 tx_bytes;
-	u64 tx_dropped;
-	struct u64_stats_sync syncp;
-
 	struct nsim_bus_dev *nsim_bus_dev;
 
 	struct bpf_prog	*bpf_offloaded;

-- 
2.47.1


