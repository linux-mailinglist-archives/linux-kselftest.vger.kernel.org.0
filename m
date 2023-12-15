Return-Path: <linux-kselftest+bounces-2024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5482A814918
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBB81C220F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FE2DF91;
	Fri, 15 Dec 2023 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbCq2Xcw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740E34CF4;
	Fri, 15 Dec 2023 13:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9842C433CC;
	Fri, 15 Dec 2023 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646495;
	bh=tguRDweVmXAx8BWsv5HDtmI+3kavF67X9xeMvzMRra4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbCq2XcwdnWshFWttQxOXXHpaYgTkOVt/uoV+FaZGKd0pwCSv037zko5grPpz6E+r
	 d4k9ASxnCroXNcreVHmU8GIQ9C2nc449K6FlmPwJtwIqvPVA/tRN/w7C6/+L0et5V9
	 TBECiYEgF699Wh0lYjkjOIg6mHzLturMi18mcLmOEoMdi3H+756h1KGgeV9qkr8UJL
	 EQ8P5yLrdpUqSn5V0F48/45qkiF6GPuJZqDI9cV1uHptEDUwAxxLsWpEhWuz/oNUE6
	 Rfde+gpzQ4/DWz89xTskbDxFB4odEAyR8P88Xd1wPdRXxU/dEon/6Q1PzG+vLQu/V3
	 8vQCerD4q1pWA==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH net-next v9 10/10] net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on hrtimers
Date: Fri, 15 Dec 2023 15:20:48 +0200
Message-Id: <20231215132048.43727-11-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215132048.43727-1-rogerq@kernel.org>
References: <20231215132048.43727-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grygorii Strashko <grygorii.strashko@ti.com>

Add SW IRQ coalescing based on hrtimers for TX and RX data path which
can be enabled by ethtool commands:

- RX coalescing
  ethtool -C eth1 rx-usecs 50

- TX coalescing can be enabled per TX queue

  - by default enables coalesing for TX0
  ethtool -C eth1 tx-usecs 50
  - configure TX0
  ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
  - configure TX1
  ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
  - configure TX0 and TX1
  ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce tx-usecs 100

  show configuration for TX0 and TX1:
  ethtool -Q eth0 queue_mask 3 --show-coalesce

Comparing to gro_flush_timeout and napi_defer_hard_irqs, this patch
allows to enable IRQ coalesing for RX path separately.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 79 +++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 59 ++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  4 ++
 3 files changed, 134 insertions(+), 8 deletions(-)

Changelog:

v9: no change
v8: no change
v7: no change
v6: no change
v5: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index 0a6134cdf39f..35fceba01ea4 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -904,6 +904,80 @@ static void am65_cpsw_get_mm_stats(struct net_device *ndev,
 	s->MACMergeHoldCount = readl(base + AM65_CPSW_STATN_IET_TX_HOLD);
 }
 
+static int am65_cpsw_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+				  struct kernel_ethtool_coalesce *kernel_coal,
+				  struct netlink_ext_ack *extack)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	tx_chn = &common->tx_chns[0];
+
+	coal->rx_coalesce_usecs = common->rx_pace_timeout / 1000;
+	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout / 1000;
+
+	return 0;
+}
+
+static int am65_cpsw_get_per_queue_coalesce(struct net_device *ndev, u32 queue,
+					    struct ethtool_coalesce *coal)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	if (queue >= AM65_CPSW_MAX_TX_QUEUES)
+		return -EINVAL;
+
+	tx_chn = &common->tx_chns[queue];
+
+	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout / 1000;
+
+	return 0;
+}
+
+static int am65_cpsw_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+				  struct kernel_ethtool_coalesce *kernel_coal,
+				  struct netlink_ext_ack *extack)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	tx_chn = &common->tx_chns[0];
+
+	if (coal->rx_coalesce_usecs && coal->rx_coalesce_usecs < 20)
+		return -EINVAL;
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20)
+		return -EINVAL;
+
+	common->rx_pace_timeout = coal->rx_coalesce_usecs * 1000;
+	tx_chn->tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
+static int am65_cpsw_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
+					    struct ethtool_coalesce *coal)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_tx_chn *tx_chn;
+
+	if (queue >= AM65_CPSW_MAX_TX_QUEUES)
+		return -EINVAL;
+
+	tx_chn = &common->tx_chns[queue];
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20) {
+		dev_info(common->dev, "defaulting to min value of 20us for tx-usecs for tx-%u\n",
+			 queue);
+		coal->tx_coalesce_usecs = 20;
+	}
+
+	tx_chn->tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
 const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.begin			= am65_cpsw_ethtool_op_begin,
 	.complete		= am65_cpsw_ethtool_op_complete,
@@ -922,6 +996,11 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.get_ts_info		= am65_cpsw_get_ethtool_ts_info,
 	.get_priv_flags		= am65_cpsw_get_ethtool_priv_flags,
 	.set_priv_flags		= am65_cpsw_set_ethtool_priv_flags,
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
+	.get_coalesce           = am65_cpsw_get_coalesce,
+	.set_coalesce           = am65_cpsw_set_coalesce,
+	.get_per_queue_coalesce = am65_cpsw_get_per_queue_coalesce,
+	.set_per_queue_coalesce = am65_cpsw_set_per_queue_coalesce,
 
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= am65_cpsw_get_link_ksettings,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 41e0046a52d5..faa0561e988e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -596,8 +596,10 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 					msecs_to_jiffies(1000));
 	if (!i)
 		dev_err(common->dev, "tx timeout\n");
-	for (i = 0; i < common->tx_ch_num; i++)
+	for (i = 0; i < common->tx_ch_num; i++) {
 		napi_disable(&common->tx_chns[i].napi_tx);
+		hrtimer_cancel(&common->tx_chns[i].tx_hrtimer);
+	}
 
 	for (i = 0; i < common->tx_ch_num; i++) {
 		k3_udma_glue_reset_tx_chn(common->tx_chns[i].tx_chn,
@@ -616,6 +618,7 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 	}
 
 	napi_disable(&common->napi_rx);
+	hrtimer_cancel(&common->rx_hrtimer);
 
 	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
 		k3_udma_glue_reset_rx_chn(common->rx_chns.rx_chn, i,
@@ -885,6 +888,15 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	return ret;
 }
 
+static enum hrtimer_restart am65_cpsw_nuss_rx_timer_callback(struct hrtimer *timer)
+{
+	struct am65_cpsw_common *common =
+			container_of(timer, struct am65_cpsw_common, rx_hrtimer);
+
+	enable_irq(common->rx_chns.irq);
+	return HRTIMER_NORESTART;
+}
+
 static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 {
 	struct am65_cpsw_common *common = am65_cpsw_napi_to_common(napi_rx);
@@ -912,7 +924,13 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
 		if (common->rx_irq_disabled) {
 			common->rx_irq_disabled = false;
-			enable_irq(common->rx_chns.irq);
+			if (unlikely(common->rx_pace_timeout)) {
+				hrtimer_start(&common->rx_hrtimer,
+					      ns_to_ktime(common->rx_pace_timeout),
+					      HRTIMER_MODE_REL_PINNED);
+			} else {
+				enable_irq(common->rx_chns.irq);
+			}
 		}
 	}
 
@@ -968,7 +986,7 @@ static void am65_cpsw_nuss_tx_wake(struct am65_cpsw_tx_chn *tx_chn, struct net_d
 }
 
 static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
-					   int chn, unsigned int budget)
+					   int chn, unsigned int budget, bool *tdown)
 {
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
@@ -991,6 +1009,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 		if (cppi5_desc_is_tdcm(desc_dma)) {
 			if (atomic_dec_and_test(&common->tdown_cnt))
 				complete(&common->tdown_complete);
+			*tdown = true;
 			break;
 		}
 
@@ -1013,7 +1032,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 }
 
 static int am65_cpsw_nuss_tx_compl_packets_2g(struct am65_cpsw_common *common,
-					      int chn, unsigned int budget)
+					      int chn, unsigned int budget, bool *tdown)
 {
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
@@ -1034,6 +1053,7 @@ static int am65_cpsw_nuss_tx_compl_packets_2g(struct am65_cpsw_common *common,
 		if (cppi5_desc_is_tdcm(desc_dma)) {
 			if (atomic_dec_and_test(&common->tdown_cnt))
 				complete(&common->tdown_complete);
+			*tdown = true;
 			break;
 		}
 
@@ -1059,21 +1079,40 @@ static int am65_cpsw_nuss_tx_compl_packets_2g(struct am65_cpsw_common *common,
 	return num_tx;
 }
 
+static enum hrtimer_restart am65_cpsw_nuss_tx_timer_callback(struct hrtimer *timer)
+{
+	struct am65_cpsw_tx_chn *tx_chns =
+			container_of(timer, struct am65_cpsw_tx_chn, tx_hrtimer);
+
+	enable_irq(tx_chns->irq);
+	return HRTIMER_NORESTART;
+}
+
 static int am65_cpsw_nuss_tx_poll(struct napi_struct *napi_tx, int budget)
 {
 	struct am65_cpsw_tx_chn *tx_chn = am65_cpsw_napi_to_tx_chn(napi_tx);
+	bool tdown = false;
 	int num_tx;
 
 	if (AM65_CPSW_IS_CPSW2G(tx_chn->common))
-		num_tx = am65_cpsw_nuss_tx_compl_packets_2g(tx_chn->common, tx_chn->id, budget);
+		num_tx = am65_cpsw_nuss_tx_compl_packets_2g(tx_chn->common, tx_chn->id,
+							    budget, &tdown);
 	else
-		num_tx = am65_cpsw_nuss_tx_compl_packets(tx_chn->common, tx_chn->id, budget);
+		num_tx = am65_cpsw_nuss_tx_compl_packets(tx_chn->common,
+							 tx_chn->id, budget, &tdown);
 
 	if (num_tx >= budget)
 		return budget;
 
-	if (napi_complete_done(napi_tx, num_tx))
-		enable_irq(tx_chn->irq);
+	if (napi_complete_done(napi_tx, num_tx)) {
+		if (unlikely(tx_chn->tx_pace_timeout && !tdown)) {
+			hrtimer_start(&tx_chn->tx_hrtimer,
+				      ns_to_ktime(tx_chn->tx_pace_timeout),
+				      HRTIMER_MODE_REL_PINNED);
+		} else {
+			enable_irq(tx_chn->irq);
+		}
+	}
 
 	return 0;
 }
@@ -1705,6 +1744,8 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 
 		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
 				  am65_cpsw_nuss_tx_poll);
+		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
 
 		ret = devm_request_irq(dev, tx_chn->irq,
 				       am65_cpsw_nuss_tx_irq,
@@ -1930,6 +1971,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 	netif_napi_add(common->dma_ndev, &common->napi_rx,
 		       am65_cpsw_nuss_rx_poll);
+	hrtimer_init(&common->rx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+	common->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
 
 	ret = devm_request_irq(dev, rx_chn->irq,
 			       am65_cpsw_nuss_rx_irq,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index 1e4a045057fc..7da0492dc091 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -75,6 +75,8 @@ struct am65_cpsw_tx_chn {
 	struct k3_cppi_desc_pool *desc_pool;
 	struct k3_udma_glue_tx_channel *tx_chn;
 	spinlock_t lock; /* protect TX rings in multi-port mode */
+	struct hrtimer tx_hrtimer;
+	unsigned long tx_pace_timeout;
 	int irq;
 	u32 id;
 	u32 descs_num;
@@ -138,6 +140,8 @@ struct am65_cpsw_common {
 	struct napi_struct	napi_rx;
 
 	bool			rx_irq_disabled;
+	struct hrtimer		rx_hrtimer;
+	unsigned long		rx_pace_timeout;
 
 	u32			nuss_ver;
 	u32			cpsw_ver;
-- 
2.34.1


