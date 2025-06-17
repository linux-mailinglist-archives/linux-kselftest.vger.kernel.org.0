Return-Path: <linux-kselftest+bounces-35188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C19ADC46B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99A83ADBBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145A28FABA;
	Tue, 17 Jun 2025 08:19:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0B1E3DCF;
	Tue, 17 Jun 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148349; cv=none; b=XazHkIltYP20Yp+pAHDPSUi22/xEqziDvH0/Z+9CtD3KgkvnJv3QlqfDQnvLNUtGy9BfSPvCMhONbH5r8Z6TvHJhjFteLYeH7eoenx2wRKai7qN1cg6q/mjoMVLJGI61uG/Xlxp0U6jsILVK5Vk3LyYKoHFbVfjnwUWyDbcfhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148349; c=relaxed/simple;
	bh=Ya02A6KSQP7IifJw9ze9oqhqSpeNuf34AYwn/7z5joU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRw8/mpZGFEbz5Rp0X6/7wBkkWNa6Q7VeY5vAi4vBwEHjzC+ONsvUKdfrbr7j0UYExJYDKy3q/ilJPNTMshmX/FHsIW9ocV7xculEpdvjAo330IlitOLvgsz3zQCtiNpXuYA8TFRucyEOE12DGG5lshxnTlJ3H+jWW69XdTYFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so1070642866b.0;
        Tue, 17 Jun 2025 01:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750148346; x=1750753146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBnJcIZF2UCEJDwnnA5SfZDnvEUhOFTZwy3JCGcNINI=;
        b=pMLgqbRrE7xIOGb+JaoTUokEHujLWKiZlvWiSoiM+tY2+P3vJWx6SIEDZZQr3PQEs5
         lWzBR+1k2ehPTQ7vaVhjpedyFQVnmCJ/AgIleRTzwXbjea+3QBLRd0AZ5wAY8oBTTsFq
         w9MhT+ajM9dDWVKMgFOFBYhjI6mWHZ3gMp/pnVXX7uGQ1XtbKpaprjsZtZBonxVxGFAC
         KrXAcF8w6mZwfunKznws60rqI9wjx11IlgDdaPLkPZPVyylNt9cuvMz4Ryn3THnOOGx6
         pPiY1H87NEGd889DIxpr0FrDsmsg+U0yf9Z8YMmqXbqLQCUemnj4Mrt6V9UcO6Lea2Yc
         D7cw==
X-Forwarded-Encrypted: i=1; AJvYcCUwKzcGybmHhLUBTw5yKMKqwxXsR2xjcD2CDWStX4IervD3qovt9nYe00ezCMiDjb2nTPR53Q48X2goRw3ObvPH@vger.kernel.org, AJvYcCWzAe9f0KzVvr21bL1f9AEgVWuke9UPf3zBA/8fsP1LHXsyvqKOmHFHEG6nsI/flI10BCRyWnzeeJabHe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VJFsIxHeCU2TMVf4T4pJsqd/YntfNTgvu5G/3E97OdeL+QEi
	hWIJG+t6QvYzJPPzgp003EGWVeNZyTq1NBcoyQwVFQumU8Kys8T725M/
X-Gm-Gg: ASbGncuQfGS/EJB4VU4GgNEAhHLgwDy5jdWFSSp9HKLjMFaSvQiA+ZkdiCDCQkgyhVn
	gfogdZ7pYwRaQ3WgY++CU9Q1fFB+MfBQhQ8gYblOkjH49r0pUwV2O1D15gylyOZb8hoIoX6IZEq
	E4cLUxR9qboT2dKqZFLHTiihhjo+bGXvHgilW+xQQSepEZnw6pCTmZs5auxyftsq7hY29Ig7c5O
	Ge2rGXN/WpoKVeLD/hFjhHMl7gjrNrJgqEf6H1cJoC0beQlEK5WbdmwZ1TNVHQu3kmjOSWPB4ma
	3y0XqnLvN99cHeNhDrBxo67VOv9M9JT+Li54+i2wXZZTkWM9hOzMnw==
X-Google-Smtp-Source: AGHT+IGVxg/b/s61sSSlHJNpQGVeO8ZLLS75RaoNkCLs9NKEjRrxbuyAWU10ZTFr8ZXjpnxLoQyG7A==
X-Received: by 2002:a17:907:d02:b0:ad8:9b5d:2c19 with SMTP id a640c23a62f3a-adfad3eacbbmr1067488166b.9.1750148345803;
        Tue, 17 Jun 2025 01:19:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81be674sm825822166b.53.2025.06.17.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:19:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 17 Jun 2025 01:18:57 -0700
Subject: [PATCH net-next v3 1/4] netdevsim: migrate to dstats stats
 collection
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-netdevsim_stat-v3-1-afe4bdcbf237@debian.org>
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
In-Reply-To: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUST2WkQTO6BE4yvfqsg1+vBmR/Z6+znHdvlmw
 IzgQolGczaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFEk9gAKCRA1o5Of/Hh3
 bWXwD/9qh9a+WtDElz7YP+VjICkofXQ4apyY+rXmHjhWU4927DNllnfSE64cGOMCn/KBAiwBQUQ
 Il9/hR22EgWkDewhQXlWaH6/jJwnsSxRU+s8FKNNSzFyl9/ZqTYY5aAskfl7PkMlkmOsD6sUWSh
 k883bBHdnuxn64rFQiT55LysR7vulDtcDgdjAr5tneInTu+x/bJHDXoNySsXJG9N/7PsJqXPo9t
 gaZBTxKn11LaGVnCnFKB/sZa1NYnf8vM09YhDUCyZ3EA9RHkgQT5VYucutHBE5Xjy2wMnLzKvVD
 rr7/J8ucI3ZvJHaWcxG1TgmY09I5V0n2FuW0L8yOrz5nICAlkiRJACjeOgrgsXDdtbRMWWXOiHG
 A0vqQBrM+Du05DxO+c9BflKb2jx3Ni7cIQ7RxoNbClMaDHHrV5xhwrVsTEWyglBdHQQYzfRCZu2
 5fwRnMs0tkWvsbkrCU+ojAdf+ilj5h7/K1TSnTJFg5WvXuy1kOj41B9LTg5TQCfKbLlXg3vni7U
 uDyoJOEFJd32O3yylVKxtTY8FzUKcMViRmQFF01jrU3LB5lK4QXTBd12VZASW6SfftHKKMQX0W1
 jL6eGsSn4FC0X2k1fzhWtne899Dox8TImjqgsVCe8zX1aR1czPFES5IPns3Wkselj5+ru5/s2GO
 VFdLGtR6dKwmc3g==
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


