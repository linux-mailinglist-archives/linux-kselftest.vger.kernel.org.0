Return-Path: <linux-kselftest+bounces-2150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E8816FC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F871C23F64
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89525BFB1;
	Mon, 18 Dec 2023 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glTtI9lc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57425BFAE;
	Mon, 18 Dec 2023 12:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC9C433C8;
	Mon, 18 Dec 2023 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702904145;
	bh=oBgos+bxtQX9bJXwmO+GwrODNW9kUny9zAsyRxBzmt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glTtI9lcuFSlnfSNx4uFVln8PiBRTtPkmVC5B813o7U0dpkWpHGnTvW6/izWxdKq/
	 6b/0c5yEr7SYTPEwrMOCFOsurUkNxeeWjGwmnnjymOZKYtbp5XmggrS4udlnMtlfiV
	 6BU3xFuyBRkXhVeCLwEATCG4JGlIaQN4E1VqHRjsR5X3blw0sJbK9m30cJKue3LwR4
	 oKqBYkSHB5b2pWPtfOH/QbP8eIe2dczXG8YID2N0Nm9e7G2oYN1xOoGY+JXleVp2K8
	 /G1tVGF7zY5++O71DuMcQYEUrWBkDh1lgD5515OfaQXur/vJqRomwPcAuFnFxf1ZFA
	 /kV08z5bE7O2A==
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
Subject: [PATCH net-next v10 06/10] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
Date: Mon, 18 Dec 2023 14:55:09 +0200
Message-Id: <20231218125513.52337-7-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218125513.52337-1-rogerq@kernel.org>
References: <20231218125513.52337-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move this code around to avoid forward declaration.
No functional change.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 86 ++++++++++++-------------
 1 file changed, 43 insertions(+), 43 deletions(-)

v10: no change.
v9: no code change. Added Reviewed-by tag.
v8: no change
v7: move am65_cpsw_qos_tx_rate_calc()
v6: no change
v5: no change
v4: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 2c97fa05a852..862a98211caa 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -56,6 +56,16 @@ enum timer_act {
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+static u32
+am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
+{
+	u32 ir;
+
+	bus_freq /= 1000000;
+	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
+	return ir;
+}
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -772,49 +782,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
 					  port, port, true);
 }
 
-int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
-			       void *type_data)
-{
-	switch (type) {
-	case TC_QUERY_CAPS:
-		return am65_cpsw_tc_query_caps(ndev, type_data);
-	case TC_SETUP_QDISC_TAPRIO:
-		return am65_cpsw_setup_taprio(ndev, type_data);
-	case TC_SETUP_BLOCK:
-		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	am65_cpsw_est_link_up(ndev, link_speed);
-	port->qos.link_down_time = 0;
-}
-
-void am65_cpsw_qos_link_down(struct net_device *ndev)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	if (!port->qos.link_down_time)
-		port->qos.link_down_time = ktime_get();
-
-	port->qos.link_speed = SPEED_UNKNOWN;
-}
-
-static u32
-am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
-{
-	u32 ir;
-
-	bus_freq /= 1000000;
-	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
-	return ir;
-}
-
 static void
 am65_cpsw_qos_tx_p0_rate_apply(struct am65_cpsw_common *common,
 			       int tx_ch, u32 rate_mbps)
@@ -916,3 +883,36 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
 		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));
 	}
 }
+
+int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			       void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return am65_cpsw_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_TAPRIO:
+		return am65_cpsw_setup_taprio(ndev, type_data);
+	case TC_SETUP_BLOCK:
+		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	am65_cpsw_est_link_up(ndev, link_speed);
+	port->qos.link_down_time = 0;
+}
+
+void am65_cpsw_qos_link_down(struct net_device *ndev)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	if (!port->qos.link_down_time)
+		port->qos.link_down_time = ktime_get();
+
+	port->qos.link_speed = SPEED_UNKNOWN;
+}
-- 
2.34.1


