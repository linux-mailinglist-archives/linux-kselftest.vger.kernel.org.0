Return-Path: <linux-kselftest+bounces-2151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F45816FC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27AE1F26EE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B443D5D73B;
	Mon, 18 Dec 2023 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ3ILWb1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC05BFB6;
	Mon, 18 Dec 2023 12:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C9C433C9;
	Mon, 18 Dec 2023 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702904149;
	bh=vf/NkWYnyw6YGMGXuWY+AzWwA9HCrA4yf4wAHZdTxbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ3ILWb1ZfvrBlYQaNbA5hSZNYKVlHkM4+wj2SHVT9+MZP/bQvqUrorCwPZyJWZ4n
	 8x54g7HaRrvSlrsqycn8Ct+Y/VXVsIAoxNEDAnmqvCe6MjqtTHDVKYmOIOE5RGOhKZ
	 shbaNH/KdZNoPYlI4rEbjJyEFvWc6FJGPHx3004p0CFbJUGXYwa6jdynj1I6Ze0qM9
	 GkRMUFK3JUsPnxHDm7c7MJ3nTTxQpGIBE1Dj5moWW8Co9XMnslZkBx9W2ibl03stGu
	 72KHsEv2SMyGDTZXz0hAk1TQpplhGGQKfUpc6I/saIMNsIqZtP+HRCYuE29djp0Ak1
	 QnTxmB8JH4HGA==
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
Subject: [PATCH net-next v10 07/10] net: ethernet: am65-cpsw: Move register definitions to header file
Date: Mon, 18 Dec 2023 14:55:10 +0200
Message-Id: <20231218125513.52337-8-rogerq@kernel.org>
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

Move register definitions to header file. No functional change.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 35 -------------------------
 drivers/net/ethernet/ti/am65-cpsw-qos.h | 35 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 35 deletions(-)

Changelog:

v10: no change.
v9: no code change. added Reviewed-by tag.
v8: no change
v7: no change
v6: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 862a98211caa..9f0a05e763d1 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -15,41 +15,6 @@
 #include "am65-cpts.h"
 #include "cpsw_ale.h"
 
-#define AM65_CPSW_REG_CTL			0x004
-#define AM65_CPSW_PN_REG_CTL			0x004
-#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
-#define AM65_CPSW_PN_REG_EST_CTL		0x060
-#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
-
-/* AM65_CPSW_REG_CTL register fields */
-#define AM65_CPSW_CTL_EST_EN			BIT(18)
-
-/* AM65_CPSW_PN_REG_CTL register fields */
-#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
-
-/* AM65_CPSW_PN_REG_EST_CTL register fields */
-#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
-#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
-#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
-#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
-#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
-#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
-
-/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
-#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
-#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
-#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
-#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
-#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
-
-/* EST FETCH COMMAND RAM */
-#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
-#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
-#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
-#define AM65_CPSW_FETCH_CNT_OFFSET		8
-#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
-#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
-
 enum timer_act {
 	TACT_PROG,		/* need program timer */
 	TACT_NEED_STOP,		/* need stop first */
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index be4987eb8c51..e3259f27baad 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -31,6 +31,41 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
 };
 
+#define AM65_CPSW_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_PN_REG_EST_CTL		0x060
+#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+
+/* AM65_CPSW_REG_CTL register fields */
+#define AM65_CPSW_CTL_EST_EN			BIT(18)
+
+/* AM65_CPSW_PN_REG_CTL register fields */
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
 #if IS_ENABLED(CONFIG_TI_AM65_CPSW_QOS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
-- 
2.34.1


