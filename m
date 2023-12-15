Return-Path: <linux-kselftest+bounces-2022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC7E814912
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD22D284184
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B502DB9C;
	Fri, 15 Dec 2023 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYNO5AA+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9634550;
	Fri, 15 Dec 2023 13:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E737C433C9;
	Fri, 15 Dec 2023 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646487;
	bh=xh8nj4aicULef/nQjhyQKTPRtR0PgwACV1/l6uVWZGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYNO5AA+2Ah5q+OHBiNkLNx6e44vagiwGQbIMomAZZQpxk/iMkzW6BeIHlcGdwEqa
	 /oQegsEGwzYtpYO8FtLPzeOZC5c+zikcYtXnuT+p7ijatlrlJkCBNQNxfA0gFWYv5q
	 hmQDrAtQ3XK59R5w8QCfjRJk2MTr8LmiW/D0GU5K+3AJhphIPOjnaKIiMR4ijUvDfR
	 qry3aojfqaQBfE8wQAaEOmehFGLFjmfUyUJb/5mXRXjLF+PjKODx+qjtThTZvgLf//
	 UOwk1vq9EmmhSL06b87yCCuH+1nbTD1+MqQ5vtznHWWCjh6mXqSLS5+qtdv9Sshm1O
	 yUtlyecvKqUCw==
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
Subject: [PATCH net-next v9 08/10] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
Date: Fri, 15 Dec 2023 15:20:46 +0200
Message-Id: <20231215132048.43727-9-rogerq@kernel.org>
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

This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
not only setting up pri:tc mapping, but also configuring TX shapers
(rate-limiting) on external port FIFOs.

The MQPRIO Qdisc offload is expected to work with or without VLAN/priority
tagged packets.

The CPSW external Port FIFO has 8 Priority queues. The rate-limit can be
set for each of these priority queues. Which Priority queue a packet is
assigned to depends on PN_REG_TX_PRI_MAP register which maps header
priority to switch priority.

The header priority of a packet is assigned via the RX_PRI_MAP_REG which
maps packet priority to header priority.

The packet priority is either the VLAN priority (for VLAN tagged packets)
or the thread/channel offset.

For simplicity, we assign the same priority queue to all queues of a
Traffic Class so it can be rate-limited correctly.

Configuration example:
 ethtool -L eth1 tx 5
 ethtool --set-priv-flags eth1 p0-rx-ptype-rrobin off

 tc qdisc add dev eth1 parent root handle 100: mqprio num_tc 3 \
 map 0 0 1 2 0 0 0 0 0 0 0 0 0 0 0 0 \
 queues 1@0 1@1 1@2 hw 1 mode channel \
 shaper bw_rlimit min_rate 0 100mbit 200mbit max_rate 0 101mbit 202mbit

 tc qdisc replace dev eth2 handle 100: parent root mqprio num_tc 1 \
 map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 hw 1

 ip link add link eth1 name eth1.100 type vlan id 100
 ip link set eth1.100 type vlan egress 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7

In the above example two ports share the same TX CPPI queue 0 for low
priority traffic. 3 traffic classes are defined for eth1 and mapped to:
TC0 - low priority, TX CPPI queue 0 -> ext Port 1 fifo0, no rate limit
TC1 - prio 2, TX CPPI queue 1 -> ext Port 1 fifo1, CIR=100Mbit/s, EIR=1Mbit/s
TC2 - prio 3, TX CPPI queue 2 -> ext Port 1 fifo2, CIR=200Mbit/s, EIR=2Mbit/s

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/Kconfig          |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c |   3 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c  | 255 ++++++++++++++++++++++-
 drivers/net/ethernet/ti/am65-cpsw-qos.h  |  20 ++
 4 files changed, 277 insertions(+), 4 deletions(-)

Changelog

v9:
- drop "\n" from message string passed to NL_SET_ERR_MSG_FMT_MOD()

v8:
- optimize TO_MBPS()
- mention MQPRIO support in TI_AM65_CPSW_QOS Kconfig help text

v7:
- don't return -EINVAL if num_tc is 0 in setup

v6:
- fixed typo in comment "packet_priorit"->"packet_priority"
- don't call netif_set_real_num_tx_queues() from am65_cpsw_reset_tc_mqprio()
- reset TX queue priorities to zero at init. AM65_CPSW_PN_REG_TX_PRI_MAP = 0
- don't ignore return value in am65_cpsw_setup_mqprio()

v5:
- fix warning at NL_SET_ERR_MSG_FMT_MOD()

v4:
- use macro TO_MBPS()
- use bool for 'shaper_en'
- split code movement into separate patch
- drop rate vs link speed check as mqprio can be set at link down
- call am65_cpsw_reset_tc_mqprio() after pm_runtime_get_sync()

v2:
- clean up commit message
- avoid forward declarations
- use tc_mqprio_qopt_offload :: extack for error message reporting
- avoid unnecessary mqprio->qopt.hw == 0 checks
- set struct tc_mqprio_caps :: validate_queue_counts = true and get rid of
  am65_cpsw_mqprio_verify()
- do not modify AM65_CPSW_P0_REG_RX_PRI_MAP register.

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 49cd96c4f532..f76532443298 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -139,7 +139,8 @@ config TI_AM65_CPSW_QOS
 	depends on TI_K3_AM65_CPSW_NUSS && NET_SCH_TAPRIO && TI_K3_AM65_CPTS
 	help
 	  This option enables QoS offload features in AM65 CPSW like
-	  Time Aware Shaper (TAS) / Enhanced Scheduled Traffic (EST).
+	  Time Aware Shaper (TAS) / Enhanced Scheduled Traffic (EST)
+	  and MQPRIO qdisc offload.
 	  The EST scheduler runs on CPTS and the TAS/EST schedule is
 	  updated in the Fetch RAM memory of the CPSW.
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7651f90f51f2..2e374745f239 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2127,6 +2127,9 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 				dev_err(dev, "Use random MAC address\n");
 			}
 		}
+
+		/* Reset all Queue priorities to 0 */
+		writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
 	}
 	of_node_put(node);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 9f0a05e763d1..7ad7af3b3c60 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/pm_runtime.h>
+#include <linux/math.h>
 #include <linux/time.h>
 #include <net/pkt_cls.h>
 
@@ -15,6 +16,8 @@
 #include "am65-cpts.h"
 #include "cpsw_ale.h"
 
+#define TO_MBPS(x)	DIV_ROUND_UP((x), BYTES_PER_MBIT)
+
 enum timer_act {
 	TACT_PROG,		/* need program timer */
 	TACT_NEED_STOP,		/* need stop first */
@@ -31,6 +34,232 @@ am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
 	return ir;
 }
 
+static void am65_cpsw_tx_pn_shaper_reset(struct am65_cpsw_port *port)
+{
+	int prio;
+
+	for (prio = 0; prio < AM65_CPSW_PN_FIFO_PRIO_NUM; prio++) {
+		writel(0, port->port_base + AM65_CPSW_PN_REG_PRI_CIR(prio));
+		writel(0, port->port_base + AM65_CPSW_PN_REG_PRI_EIR(prio));
+	}
+}
+
+static void am65_cpsw_tx_pn_shaper_apply(struct am65_cpsw_port *port)
+{
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct am65_cpsw_common *common = port->common;
+	struct tc_mqprio_qopt_offload *mqprio;
+	bool enable, shaper_susp = false;
+	u32 rate_mbps;
+	int tc, prio;
+
+	mqprio = &p_mqprio->mqprio_hw;
+	/* takes care of no link case as well */
+	if (p_mqprio->max_rate_total > port->qos.link_speed)
+		shaper_susp = true;
+
+	am65_cpsw_tx_pn_shaper_reset(port);
+
+	enable = p_mqprio->shaper_en && !shaper_susp;
+	if (!enable)
+		return;
+
+	/* Rate limit is specified per Traffic Class but
+	 * for CPSW, rate limit can be applied per priority
+	 * at port FIFO.
+	 *
+	 * We have assigned the same priority (TCn) to all queues
+	 * of a Traffic Class so they share the same shaper
+	 * bandwidth.
+	 */
+	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
+		prio = tc;
+
+		rate_mbps = TO_MBPS(mqprio->min_rate[tc]);
+		rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
+						       common->bus_freq);
+		writel(rate_mbps,
+		       port->port_base + AM65_CPSW_PN_REG_PRI_CIR(prio));
+
+		rate_mbps = 0;
+
+		if (mqprio->max_rate[tc]) {
+			rate_mbps = mqprio->max_rate[tc] - mqprio->min_rate[tc];
+			rate_mbps = TO_MBPS(rate_mbps);
+			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
+							       common->bus_freq);
+		}
+
+		writel(rate_mbps,
+		       port->port_base + AM65_CPSW_PN_REG_PRI_EIR(prio));
+	}
+}
+
+static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
+					  struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	u64 min_rate_total = 0, max_rate_total = 0;
+	u32 min_rate_msk = 0, max_rate_msk = 0;
+	bool has_min_rate, has_max_rate;
+	int num_tc, i;
+
+	if (!(mqprio->flags & TC_MQPRIO_F_SHAPER))
+		return 0;
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE)
+		return 0;
+
+	has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
+	has_max_rate = !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
+
+	if (!has_min_rate && has_max_rate) {
+		NL_SET_ERR_MSG_MOD(extack, "min_rate is required with max_rate");
+		return -EOPNOTSUPP;
+	}
+
+	if (!has_min_rate)
+		return 0;
+
+	num_tc = mqprio->qopt.num_tc;
+
+	for (i = num_tc - 1; i >= 0; i--) {
+		u32 ch_msk;
+
+		if (mqprio->min_rate[i])
+			min_rate_msk |= BIT(i);
+		min_rate_total +=  mqprio->min_rate[i];
+
+		if (has_max_rate) {
+			if (mqprio->max_rate[i])
+				max_rate_msk |= BIT(i);
+			max_rate_total +=  mqprio->max_rate[i];
+
+			if (!mqprio->min_rate[i] && mqprio->max_rate[i]) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "TX tc%d rate max>0 but min=0",
+						       i);
+				return -EINVAL;
+			}
+
+			if (mqprio->max_rate[i] &&
+			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "TX tc%d rate min(%llu)>max(%llu)",
+						       i, mqprio->min_rate[i],
+						       mqprio->max_rate[i]);
+				return -EINVAL;
+			}
+		}
+
+		ch_msk = GENMASK(num_tc - 1, i);
+		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Min rate must be set sequentially hi->lo tx_rate_msk%x",
+					       min_rate_msk);
+			return -EINVAL;
+		}
+
+		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Max rate must be set sequentially hi->lo tx_rate_msk%x",
+					       max_rate_msk);
+			return -EINVAL;
+		}
+	}
+
+	min_rate_total = TO_MBPS(min_rate_total);
+	max_rate_total = TO_MBPS(max_rate_total);
+
+	p_mqprio->shaper_en = true;
+	p_mqprio->max_rate_total = max_t(u64, min_rate_total, max_rate_total);
+
+	return 0;
+}
+
+static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+
+	p_mqprio->shaper_en = false;
+	p_mqprio->max_rate_total = 0;
+
+	am65_cpsw_tx_pn_shaper_reset(port);
+	netdev_reset_tc(ndev);
+
+	/* Reset all Queue priorities to 0 */
+	writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+}
+
+static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct am65_cpsw_common *common = port->common;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	int i, tc, offset, count, prio, ret;
+	u8 num_tc = qopt->num_tc;
+	u32 tx_prio_map = 0;
+
+	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
+
+	ret = pm_runtime_get_sync(common->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(common->dev);
+		return ret;
+	}
+
+	if (!num_tc) {
+		am65_cpsw_reset_tc_mqprio(ndev);
+		ret = 0;
+		goto exit_put;
+	}
+
+	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
+	if (ret)
+		goto exit_put;
+
+	netdev_set_num_tc(ndev, num_tc);
+
+	/* Multiple Linux priorities can map to a Traffic Class
+	 * A Traffic Class can have multiple contiguous Queues,
+	 * Queues get mapped to Channels (thread_id),
+	 *	if not VLAN tagged, thread_id is used as packet_priority
+	 *	if VLAN tagged. VLAN priority is used as packet_priority
+	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
+	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
+	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
+	 * assume that Queue_n gets mapped to header_priority_n. We can then
+	 * set the switch priority in pn_tx_pri_map.
+	 */
+
+	for (tc = 0; tc < num_tc; tc++) {
+		prio = tc;
+
+		/* For simplicity we assign the same priority (TCn) to
+		 * all queues of a Traffic Class.
+		 */
+		for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
+			tx_prio_map |= prio << (4 * i);
+
+		count = qopt->count[tc];
+		offset = qopt->offset[tc];
+		netdev_set_tc_queue(ndev, tc, count, offset);
+	}
+
+	writel(tx_prio_map, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+
+	am65_cpsw_tx_pn_shaper_apply(port);
+
+exit_put:
+	pm_runtime_put(common->dev);
+
+	return ret;
+}
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -414,6 +643,8 @@ static void am65_cpsw_taprio_destroy(struct net_device *ndev)
 
 	port->qos.est_oper = NULL;
 	port->qos.est_admin = NULL;
+
+	am65_cpsw_reset_tc_mqprio(ndev);
 }
 
 static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
@@ -462,6 +693,10 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 	if (!est_new)
 		return -ENOMEM;
 
+	ret = am65_cpsw_setup_mqprio(ndev, &taprio->mqprio);
+	if (ret)
+		return ret;
+
 	am65_cpsw_cp_taprio(taprio, &est_new->taprio);
 
 	am65_cpsw_est_update_state(ndev);
@@ -505,6 +740,7 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 	return 0;
 
 fail:
+	am65_cpsw_reset_tc_mqprio(ndev);
 	devm_kfree(&ndev->dev, est_new);
 	return ret;
 }
@@ -515,7 +751,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	ktime_t cur_time;
 	s64 delta;
 
-	port->qos.link_speed = link_speed;
 	if (!am65_cpsw_port_est_enabled(port))
 		return;
 
@@ -559,6 +794,14 @@ static int am65_cpsw_tc_query_caps(struct net_device *ndev, void *type_data)
 	struct tc_query_caps_base *base = type_data;
 
 	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+
+		return 0;
+	}
+
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
@@ -857,6 +1100,8 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 		return am65_cpsw_tc_query_caps(ndev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return am65_cpsw_setup_taprio(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return am65_cpsw_setup_mqprio(ndev, type_data);
 	case TC_SETUP_BLOCK:
 		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
 	default:
@@ -868,6 +1113,9 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = link_speed;
+	am65_cpsw_tx_pn_shaper_apply(port);
+
 	am65_cpsw_est_link_up(ndev, link_speed);
 	port->qos.link_down_time = 0;
 }
@@ -876,8 +1124,9 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = SPEED_UNKNOWN;
+	am65_cpsw_tx_pn_shaper_apply(port);
+
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
-
-	port->qos.link_speed = SPEED_UNKNOWN;
 }
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index e3259f27baad..b54c34c0aa7f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -9,6 +9,7 @@
 #include <net/pkt_sched.h>
 
 struct am65_cpsw_common;
+struct am65_cpsw_port;
 
 struct am65_cpsw_est {
 	int buf;
@@ -16,6 +17,12 @@ struct am65_cpsw_est {
 	struct tc_taprio_qopt_offload taprio;
 };
 
+struct am65_cpsw_mqprio {
+	struct tc_mqprio_qopt_offload mqprio_hw;
+	u64 max_rate_total;
+	bool shaper_en;
+};
+
 struct am65_cpsw_ale_ratelimit {
 	unsigned long cookie;
 	u64 rate_packet_ps;
@@ -26,6 +33,7 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_est *est_oper;
 	ktime_t link_down_time;
 	int link_speed;
+	struct am65_cpsw_mqprio mqprio;
 
 	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
@@ -36,6 +44,15 @@ struct am65_cpsw_qos {
 #define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
 #define AM65_CPSW_PN_REG_EST_CTL		0x060
 #define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_P0_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
+
+#define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
+#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
+#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_PN_REG_EST_CTL		0x060
+#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
 
 /* AM65_CPSW_REG_CTL register fields */
 #define AM65_CPSW_CTL_EST_EN			BIT(18)
@@ -66,6 +83,9 @@ struct am65_cpsw_qos {
 #define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
 #define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
 
+/* number of priority queues per port FIFO */
+#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
+
 #if IS_ENABLED(CONFIG_TI_AM65_CPSW_QOS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
-- 
2.34.1


