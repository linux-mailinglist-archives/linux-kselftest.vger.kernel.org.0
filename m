Return-Path: <linux-kselftest+bounces-2199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C78185EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE651F241FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EFA156F5;
	Tue, 19 Dec 2023 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+OVVphT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19B1BDE2;
	Tue, 19 Dec 2023 10:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC66C433C7;
	Tue, 19 Dec 2023 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983529;
	bh=pdB4vb9mFRLzm5d9CfC16xts5eLTvorc6Zvr/JMGL+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+OVVphTbqc5HrUXgp814DIHrdvvCKKZ0HDkMZ1qpHq/oiAIilzX4KboT1pEzXOY8
	 5oQhnJkl5WMVl0p6Wk3bI4Ng5VfnNegpDZpLunYC/pMHv+sjAYrZy54InEuavCDPzL
	 Cr/uO4mrOrTSbJA61pyK1l7jASDPoRGatdUu7U0pQSV+bi5WAB93evgSjap7wxmQ28
	 S0rbcmLIENCy1ATvG3YjGtA1c2ZRA+UPOL1KBmIWR/Lj5s6QrVKEunaEmtTp25uKtD
	 75tRHacnuPvglbPaHnB5EJZi0EJU8H9LQN8vJRXyyneRzPLaUSzDDAIn+lLE4T9hJe
	 cKZ8Goz9BgA+A==
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
Subject: [PATCH net-next v11 09/10] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
Date: Tue, 19 Dec 2023 12:58:04 +0200
Message-Id: <20231219105805.80617-10-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219105805.80617-1-rogerq@kernel.org>
References: <20231219105805.80617-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add driver support for viewing / changing the MAC Merge sublayer
parameters and seeing the verification state machine's current state
via ethtool.

As hardware does not support interrupt notification for verification
events we resort to polling on link up. On link up we try a couple of
times for verification success and if unsuccessful then give up.

The Frame Preemption feature is described in the Technical Reference
Manual [1] in section:
	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)

Due to Silicon Errata i2208 [2] we set limit min IET fragment size to
124 (excluding 4 bytes mCRC).

[1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
[2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/ti/Kconfig             |   5 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 167 +++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 174 ++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 105 ++++++++++++
 6 files changed, 456 insertions(+), 2 deletions(-)

Changelog:

v11:
- no change

v10:
- no change

v9:
- fix up am65_cpsw_get_eth_mac_stats() by merging patch
  "net: ethernet: ti: am65-cpsw: Fix get_eth_mac_stats"
- remove unnecessary 'if (cfg->verify_time > 0)' check in am65_cpsw_set_mm()

v8:
- fix build if CONFIG_TI_AM65_CPSW_TAS not enabled
- change CONFIG_TI_AM65_CPSW_TAS to CONFIG_TI_AM65_CPSW_QOS
- mention about Frame Preemption support in TI_AM65_CPSW_QOS Kconfig help
- mentioned IET fragment size excludes 4 bytes mCRC in commit log

v7:
- use else if
- drop FIXME comment
- fix lldp kselftest failure by limiting max_verify_time to spec limit of 128ms.
- now passes all ethtool_mm.sh kselftests (patch 8 required)

v6:
- get mutex around am65_cpsw_iet_commit_preemptible_tcs() in
  am65_cpsw_iet_change_preemptible_tcs()
- use "preemption" instead of "pre-emption"
- call am65_cpsw_setup_mqprio() from within am65_cpsw_setup_taprio()
- Now works with kselftest except the last test which fails

v5:
- No change

v4:
- Rebase and include in the same series as mqprio support.

v3:
- Rebase on top of v6.6-rc1 and mqprio support [1]
- Support ethtool_ops :: get_mm_stats()
- drop unused variables cmn_ctrl and verify_cnt
- make am65_cpsw_iet_link_state_update() and
  am65_cpsw_iet_change_preemptible_tcs() static

[1] https://lore.kernel.org/all/20230918075358.5878-1-rogerq@kernel.org/

v2:
- Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
  and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
- Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
  AM65_CPSW_PN_CTL_IET_PORT_EN set.
- Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
- Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
  1G link if link is inactive.
- resize the RX FIFO based on pmac_enabled, not tx_enabled.

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index f76532443298..be01450c20dc 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -139,8 +139,9 @@ config TI_AM65_CPSW_QOS
 	depends on TI_K3_AM65_CPSW_NUSS && NET_SCH_TAPRIO && TI_K3_AM65_CPTS
 	help
 	  This option enables QoS offload features in AM65 CPSW like
-	  Time Aware Shaper (TAS) / Enhanced Scheduled Traffic (EST)
-	  and MQPRIO qdisc offload.
+	  Time Aware Shaper (TAS) / Enhanced Scheduled Traffic (EST),
+	  MQPRIO qdisc offload and Frame-Preemption MAC Merge / Interspersing
+	  Express Traffic (IET).
 	  The EST scheduler runs on CPTS and the TAS/EST schedule is
 	  updated in the Fetch RAM memory of the CPSW.
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index b9e1d568604b..0a6134cdf39f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -11,6 +11,7 @@
 #include <linux/pm_runtime.h>
 
 #include "am65-cpsw-nuss.h"
+#include "am65-cpsw-qos.h"
 #include "cpsw_ale.h"
 #include "am65-cpts.h"
 
@@ -670,6 +671,9 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
 
 	stats = port->stat_base;
 
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
 	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
 	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
 	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
@@ -740,6 +744,166 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
 	return 0;
 }
 
+static void am65_cpsw_port_iet_rx_enable(struct am65_cpsw_port *port, bool enable)
+{
+	u32 val;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+	if (enable)
+		val |= AM65_CPSW_PN_CTL_IET_PORT_EN;
+	else
+		val &= ~AM65_CPSW_PN_CTL_IET_PORT_EN;
+
+	writel(val, port->port_base + AM65_CPSW_PN_REG_CTL);
+	am65_cpsw_iet_common_enable(port->common);
+}
+
+static void am65_cpsw_port_iet_tx_enable(struct am65_cpsw_port *port, bool enable)
+{
+	u32 val;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	if (enable)
+		val |= AM65_CPSW_PN_IET_MAC_PENABLE;
+	else
+		val &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
+
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+}
+
+static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
+	u32 port_ctrl, iet_ctrl, iet_status;
+	u32 add_frag_size;
+
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_QOS))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&priv->mm_lock);
+
+	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+
+	state->tx_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
+	state->pmac_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
+
+	iet_status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
+
+	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+	else
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+
+	add_frag_size = AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
+	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
+
+	/* Errata i2208: RX min fragment size cannot be less than 124 */
+	state->rx_min_frag_size = 124;
+
+	/* FPE active if common tx_enabled and verification success or disabled (forced) */
+	state->tx_active = state->tx_enabled &&
+			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
+	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
+
+	state->verify_time = port->qos.iet.verify_time_ms;
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = 128;
+
+	mutex_unlock(&priv->mm_lock);
+
+	return 0;
+}
+
+static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+			    struct netlink_ext_ack *extack)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
+	struct am65_cpsw_iet *iet = &port->qos.iet;
+	u32 val, add_frag_size;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_QOS))
+		return -EOPNOTSUPP;
+
+	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
+	if (err)
+		return err;
+
+	mutex_lock(&priv->mm_lock);
+
+	if (cfg->pmac_enabled) {
+		/* change TX & RX FIFO MAX_BLKS as per TRM recommendation */
+		if (!iet->original_max_blks)
+			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+
+		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
+		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+	} else if (iet->original_max_blks) {
+		/* restore RX & TX FIFO MAX_BLKS */
+		writel(iet->original_max_blks,
+		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+	}
+
+	am65_cpsw_port_iet_rx_enable(port, cfg->pmac_enabled);
+	am65_cpsw_port_iet_tx_enable(port, cfg->tx_enabled);
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	if (cfg->verify_enabled) {
+		val &= ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
+		/* Reset Verify state machine. Verification won't start here.
+		 * Verification will be done once link-up.
+		 */
+		val |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
+	} else {
+		val |= AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
+		/* Clear LINKFAIL to allow verify/response packets */
+		val &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
+	}
+
+	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
+	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+	/* verify_timeout_count can only be set at valid link */
+	port->qos.iet.verify_time_ms = cfg->verify_time;
+
+	/* enable/disable preemption based on link status */
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+
+	mutex_unlock(&priv->mm_lock);
+
+	return 0;
+}
+
+static void am65_cpsw_get_mm_stats(struct net_device *ndev,
+				   struct ethtool_mm_stats *s)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	void __iomem *base = port->stat_base;
+
+	s->MACMergeFrameAssOkCount = readl(base + AM65_CPSW_STATN_IET_RX_ASSEMBLY_OK);
+	s->MACMergeFrameAssErrorCount = readl(base + AM65_CPSW_STATN_IET_RX_ASSEMBLY_ERROR);
+	s->MACMergeFrameSmdErrorCount = readl(base + AM65_CPSW_STATN_IET_RX_SMD_ERROR);
+	/* CPSW Functional Spec states:
+	 * "The IET stat aMACMergeFragCountRx is derived by adding the
+	 *  Receive Assembly Error count to this value. i.e. AM65_CPSW_STATN_IET_RX_FRAG"
+	 */
+	s->MACMergeFragCountRx = readl(base + AM65_CPSW_STATN_IET_RX_FRAG) + s->MACMergeFrameAssErrorCount;
+	s->MACMergeFragCountTx = readl(base + AM65_CPSW_STATN_IET_TX_FRAG);
+	s->MACMergeHoldCount = readl(base + AM65_CPSW_STATN_IET_TX_HOLD);
+}
+
 const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.begin			= am65_cpsw_ethtool_op_begin,
 	.complete		= am65_cpsw_ethtool_op_complete,
@@ -769,4 +933,7 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.get_eee		= am65_cpsw_get_eee,
 	.set_eee		= am65_cpsw_set_eee,
 	.nway_reset		= am65_cpsw_nway_reset,
+	.get_mm			= am65_cpsw_get_mm,
+	.set_mm			= am65_cpsw_set_mm,
+	.get_mm_stats		= am65_cpsw_get_mm_stats,
 };
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2e374745f239..41e0046a52d5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2194,6 +2194,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	ndev_priv = netdev_priv(port->ndev);
 	ndev_priv->port = port;
 	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
+	mutex_init(&ndev_priv->mm_lock);
+	port->qos.link_speed = SPEED_UNKNOWN;
 	SET_NETDEV_DEV(port->ndev, dev);
 
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index f3dad2ab9828..1e4a045057fc 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -145,6 +145,7 @@ struct am65_cpsw_common {
 	bool			pf_p0_rx_ptype_rrobin;
 	struct am65_cpts	*cpts;
 	int			est_enabled;
+	bool			iet_enabled;
 
 	bool		is_emac_mode;
 	u16			br_members;
@@ -170,6 +171,10 @@ struct am65_cpsw_ndev_priv {
 	struct am65_cpsw_port	*port;
 	struct am65_cpsw_ndev_stats __percpu *stats;
 	bool offload_fwd_mark;
+	/* Serialize access to MAC Merge state between ethtool requests
+	 * and link state updates
+	 */
+	struct mutex		mm_lock;
 };
 
 #define am65_ndev_to_priv(ndev) \
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 7790d739e74e..816e73a3d6e4 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -4,6 +4,7 @@
  *
  * quality of service module includes:
  * Enhanced Scheduler Traffic (EST - P802.1Qbv/D2.2)
+ * Interspersed Express Traffic (IET - P802.3br/D2.0)
  */
 
 #include <linux/pm_runtime.h>
@@ -25,6 +26,8 @@ enum timer_act {
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+static void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs);
+
 static u32
 am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
 {
@@ -192,6 +195,8 @@ static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
 
 	/* Reset all Queue priorities to 0 */
 	writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+
+	am65_cpsw_iet_change_preemptible_tcs(port, 0);
 }
 
 static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
@@ -254,6 +259,7 @@ static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
 	writel(tx_prio_map, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
 
 	am65_cpsw_tx_pn_shaper_apply(port);
+	am65_cpsw_iet_change_preemptible_tcs(port, mqprio->preemptible_tcs);
 
 exit_put:
 	pm_runtime_put(common->dev);
@@ -261,6 +267,171 @@ static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
 	return ret;
 }
 
+static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
+{
+	int verify_time_ms = port->qos.iet.verify_time_ms;
+	u32 val;
+
+	/* The number of wireside clocks contained in the verify
+	 * timeout counter. The default is 0x1312d0
+	 * (10ms at 125Mhz in 1G mode).
+	 */
+	val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
+
+	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
+	val *= verify_time_ms;		/* count for timeout ms */
+
+	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
+		return -EINVAL;
+
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
+
+	return 0;
+}
+
+static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
+{
+	u32 ctrl, status;
+	int try;
+
+	try = 20;
+	do {
+		/* Reset the verify state machine by writing 1
+		 * to LINKFAIL
+		 */
+		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+		ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
+		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+		/* Clear MAC_LINKFAIL bit to start Verify. */
+		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+		ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
+		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+		msleep(port->qos.iet.verify_time_ms);
+
+		status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
+		if (status & AM65_CPSW_PN_MAC_VERIFIED)
+			return 0;
+
+		if (status & AM65_CPSW_PN_MAC_VERIFY_FAIL) {
+			netdev_dbg(port->ndev,
+				   "MAC Merge verify failed, trying again\n");
+			continue;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
+			netdev_dbg(port->ndev, "MAC Merge respond error\n");
+			return -ENODEV;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
+			netdev_dbg(port->ndev, "MAC Merge verify error\n");
+			return -ENODEV;
+		}
+	} while (try-- > 0);
+
+	netdev_dbg(port->ndev, "MAC Merge verify timeout\n");
+	return -ETIMEDOUT;
+}
+
+static void am65_cpsw_iet_set_preempt_mask(struct am65_cpsw_port *port, u8 preemptible_tcs)
+{
+	u32 val;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	val &= ~AM65_CPSW_PN_IET_MAC_PREMPT_MASK;
+	val |= AM65_CPSW_PN_IET_MAC_SET_PREEMPT(preemptible_tcs);
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+}
+
+/* enable common IET_ENABLE only if at least 1 port has rx IET enabled.
+ * UAPI doesn't allow tx enable without rx enable.
+ */
+void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_port *port;
+	bool rx_enable = false;
+	u32 val;
+	int i;
+
+	for (i = 0; i < common->port_num; i++) {
+		port = &common->ports[i];
+		val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+		rx_enable = !!(val & AM65_CPSW_PN_CTL_IET_PORT_EN);
+		if (rx_enable)
+			break;
+	}
+
+	val = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
+
+	if (rx_enable)
+		val |= AM65_CPSW_CTL_IET_EN;
+	else
+		val &= ~AM65_CPSW_CTL_IET_EN;
+
+	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
+	common->iet_enabled = rx_enable;
+}
+
+/* CPSW does not have an IRQ to notify changes to the MAC Merge TX status
+ * (active/inactive), but the preemptible traffic classes should only be
+ * committed to hardware once TX is active. Resort to polling.
+ */
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
+{
+	u8 preemptible_tcs;
+	int err;
+	u32 val;
+
+	if (port->qos.link_speed == SPEED_UNKNOWN)
+		return;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
+		return;
+
+	/* update common IET enable */
+	am65_cpsw_iet_common_enable(port->common);
+
+	/* update verify count */
+	err = am65_cpsw_iet_set_verify_timeout_count(port);
+	if (err) {
+		netdev_err(port->ndev, "couldn't set verify count: %d\n", err);
+		return;
+	}
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	if (!(val & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)) {
+		err = am65_cpsw_iet_verify_wait(port);
+		if (err)
+			return;
+	}
+
+	preemptible_tcs = port->qos.iet.preemptible_tcs;
+	am65_cpsw_iet_set_preempt_mask(port, preemptible_tcs);
+}
+
+static void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
+{
+	struct am65_cpsw_ndev_priv *priv = am65_ndev_to_priv(port->ndev);
+
+	port->qos.iet.preemptible_tcs = preemptible_tcs;
+	mutex_lock(&priv->mm_lock);
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+	mutex_unlock(&priv->mm_lock);
+}
+
+static void am65_cpsw_iet_link_state_update(struct net_device *ndev)
+{
+	struct am65_cpsw_ndev_priv *priv = am65_ndev_to_priv(ndev);
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	mutex_lock(&priv->mm_lock);
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+	mutex_unlock(&priv->mm_lock);
+}
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -737,6 +908,7 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 
 	devm_kfree(&ndev->dev, port->qos.est_admin);
 	port->qos.est_admin = est_new;
+	am65_cpsw_iet_change_preemptible_tcs(port, taprio->mqprio.preemptible_tcs);
 
 	return 0;
 
@@ -1116,6 +1288,7 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 
 	port->qos.link_speed = link_speed;
 	am65_cpsw_tx_pn_shaper_apply(port);
+	am65_cpsw_iet_link_state_update(ndev);
 
 	am65_cpsw_est_link_up(ndev, link_speed);
 	port->qos.link_down_time = 0;
@@ -1127,6 +1300,7 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 
 	port->qos.link_speed = SPEED_UNKNOWN;
 	am65_cpsw_tx_pn_shaper_apply(port);
+	am65_cpsw_iet_link_state_update(ndev);
 
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index b54c34c0aa7f..b328e56c5b2b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -23,6 +23,12 @@ struct am65_cpsw_mqprio {
 	bool shaper_en;
 };
 
+struct am65_cpsw_iet {
+	u8 preemptible_tcs;
+	u32 original_max_blks;
+	int verify_time_ms;
+};
+
 struct am65_cpsw_ale_ratelimit {
 	unsigned long cookie;
 	u64 rate_packet_ps;
@@ -34,6 +40,7 @@ struct am65_cpsw_qos {
 	ktime_t link_down_time;
 	int link_speed;
 	struct am65_cpsw_mqprio mqprio;
+	struct am65_cpsw_iet iet;
 
 	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
@@ -93,6 +100,8 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
 void am65_cpsw_qos_link_down(struct net_device *ndev);
 int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
 void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
+void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
 #else
 static inline int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev,
 					     enum tc_setup_type type,
@@ -117,6 +126,102 @@ static inline int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev,
 
 static inline void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
 { }
+static inline void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
+{ }
+static inline void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
+{ }
 #endif
 
+#define AM65_CPSW_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_MAX_BLKS		0x008
+#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
+#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
+#define AM65_CPSW_PN_REG_IET_CTRL		0x040
+#define AM65_CPSW_PN_REG_IET_STATUS		0x044
+#define AM65_CPSW_PN_REG_IET_VERIFY		0x048
+#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_PN_REG_EST_CTL		0x060
+#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
+
+/* AM65_CPSW_REG_CTL register fields */
+#define AM65_CPSW_CTL_IET_EN			BIT(17)
+#define AM65_CPSW_CTL_EST_EN			BIT(18)
+
+/* AM65_CPSW_PN_REG_CTL register fields */
+#define AM65_CPSW_PN_CTL_IET_PORT_EN		BIT(16)
+#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
+
+/* AM65_CPSW_PN_REG_EST_CTL register fields */
+#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
+#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
+#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
+#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
+#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
+#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
+
+/* AM65_CPSW_PN_REG_IET_CTRL register fields */
+#define AM65_CPSW_PN_IET_MAC_PENABLE		BIT(0)
+#define AM65_CPSW_PN_IET_MAC_DISABLEVERIFY	BIT(2)
+#define AM65_CPSW_PN_IET_MAC_LINKFAIL		BIT(3)
+#define AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK	GENMASK(10, 8)
+#define AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_OFFSET	8
+#define AM65_CPSW_PN_IET_MAC_PREMPT_MASK		GENMASK(23, 16)
+#define AM65_CPSW_PN_IET_MAC_PREMPT_OFFSET		16
+
+#define AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(n)	(((n) << AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_OFFSET) & \
+						  AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK)
+#define AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(n)	(((n) & AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK) >> \
+						  AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_OFFSET)
+#define AM65_CPSW_PN_IET_MAC_SET_PREEMPT(n)	(((n) << AM65_CPSW_PN_IET_MAC_PREMPT_OFFSET) & \
+						 AM65_CPSW_PN_IET_MAC_PREMPT_MASK)
+#define AM65_CPSW_PN_IET_MAC_GET_PREEMPT(n)	(((n) & AM65_CPSW_PN_IET_MAC_PREMPT_MASK) >> \
+						 AM65_CPSW_PN_IET_MAC_PREMPT_OFFSET)
+
+/* AM65_CPSW_PN_REG_IET_STATUS register fields */
+#define AM65_CPSW_PN_MAC_STATUS			GENMASK(3, 0)
+#define AM65_CPSW_PN_MAC_VERIFIED		BIT(0)
+#define AM65_CPSW_PN_MAC_VERIFY_FAIL		BIT(1)
+#define AM65_CPSW_PN_MAC_RESPOND_ERR		BIT(2)
+#define AM65_CPSW_PN_MAC_VERIFY_ERR		BIT(3)
+
+/* AM65_CPSW_PN_REG_IET_VERIFY register fields */
+#define AM65_CPSW_PN_MAC_VERIFY_CNT_MASK	GENMASK(23, 0)
+#define AM65_CPSW_PN_MAC_GET_VERIFY_CNT(n)	((n) & AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
+/* 10 msec converted to NSEC */
+#define AM65_CPSW_IET_VERIFY_CNT_MS		(10)
+#define AM65_CPSW_IET_VERIFY_CNT_NS		(AM65_CPSW_IET_VERIFY_CNT_MS * \
+						 NSEC_PER_MSEC)
+
+/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
+#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
+#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
+#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
+#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
+#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
+
+/* EST FETCH COMMAND RAM */
+#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
+#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
+#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
+#define AM65_CPSW_FETCH_CNT_OFFSET		8
+#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
+#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
+
+/* AM65_CPSW_PN_REG_MAX_BLKS fields for IET and No IET cases */
+/* 7 blocks for pn_rx_max_blks, 13 for pn_tx_max_blks*/
+#define AM65_CPSW_PN_TX_RX_MAX_BLKS_IET		0xD07
+
+/* Slave IET Stats. register offsets */
+#define AM65_CPSW_STATN_IET_RX_ASSEMBLY_ERROR	0x140
+#define AM65_CPSW_STATN_IET_RX_ASSEMBLY_OK	0x144
+#define AM65_CPSW_STATN_IET_RX_SMD_ERROR	0x148
+#define AM65_CPSW_STATN_IET_RX_FRAG		0x14c
+#define AM65_CPSW_STATN_IET_TX_HOLD		0x150
+#define AM65_CPSW_STATN_IET_TX_FRAG		0x154
+
+/* number of priority queues per port FIFO */
+#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
+
 #endif /* AM65_CPSW_QOS_H_ */
-- 
2.34.1


