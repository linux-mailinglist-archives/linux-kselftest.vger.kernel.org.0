Return-Path: <linux-kselftest+bounces-2019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDF814908
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511291F2103D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7230D17;
	Fri, 15 Dec 2023 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfR/8ks1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CB2DB7A;
	Fri, 15 Dec 2023 13:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6FCC433C7;
	Fri, 15 Dec 2023 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646475;
	bh=SORD+aX0jZeq6LLHFMIqKkoroLX2+AhIob6MdUk+lGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfR/8ks1eu5Ka89YnQLfeBvX/LUUNCVQyyQ1ijl5TmpipDwrERapSsiOp6VoGV212
	 nO7CGrdSNQg1Y5aZ4LOXIUHofZGyyyZteZ+yxEfDtwjDoNUHeZotqbc9VddUZuKi1R
	 3TFh7FL1MwbeKv2pX5Y5clUMhKrd3Wv0vTMQFQ8EAVhCO58loP7xrY0sG8573+rJBY
	 OPWkz72K4nUkIfpNST3hDWfDy9nOE/C20rqBEvLqKA/znwN8B4EOaUgbqraks/o7Cg
	 gvMcyBk837Zx0Aj8+aYiXwQLyDvUr5aEy9vPQE/UG8ybY/a7w27UFVEPjR2BhBsEKD
	 W50fUI+E3/uSQ==
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
Subject: [PATCH net-next v9 05/10] net: ethernet: am65-cpsw: cleanup TAPRIO handling
Date: Fri, 15 Dec 2023 15:20:43 +0200
Message-Id: <20231215132048.43727-6-rogerq@kernel.org>
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

Handle offloading commands using switch-case in
am65_cpsw_setup_taprio().

Move checks to am65_cpsw_taprio_replace().

Use NL_SET_ERR_MSG_MOD for error messages.
Change error message from "Failed to set cycle time extension"
to "cycle time extension not supported"

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 151 +++++++++++-------------
 1 file changed, 71 insertions(+), 80 deletions(-)

Changelog:

v9: no change
v8: don't initialize ret = 0, tact = TACT_PROG
v7: don't use "\n" in NL_SET_ERR_MSG_MOD()
v6: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 4bc611cc4aad..2c97fa05a852 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -428,7 +428,7 @@ static void am65_cpsw_stop_est(struct net_device *ndev)
 	am65_cpsw_timer_stop(ndev);
 }
 
-static void am65_cpsw_purge_est(struct net_device *ndev)
+static void am65_cpsw_taprio_destroy(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
@@ -441,29 +441,66 @@ static void am65_cpsw_purge_est(struct net_device *ndev)
 	port->qos.est_admin = NULL;
 }
 
-static int am65_cpsw_configure_taprio(struct net_device *ndev,
-				      struct am65_cpsw_est *est_new)
+static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
+				struct tc_taprio_qopt_offload *to)
+{
+	int i;
+
+	*to = *from;
+	for (i = 0; i < from->num_entries; i++)
+		to->entries[i] = from->entries[i];
+}
+
+static int am65_cpsw_taprio_replace(struct net_device *ndev,
+				    struct tc_taprio_qopt_offload *taprio)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct netlink_ext_ack *extack = taprio->mqprio.extack;
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	struct am65_cpts *cpts = common->cpts;
-	int ret = 0, tact = TACT_PROG;
+	struct am65_cpsw_est *est_new;
+	int ret, tact;
 
-	am65_cpsw_est_update_state(ndev);
+	if (!netif_running(ndev)) {
+		NL_SET_ERR_MSG_MOD(extack, "interface is down, link speed unknown");
+		return -ENETDOWN;
+	}
 
-	if (est_new->taprio.cmd == TAPRIO_CMD_DESTROY) {
-		am65_cpsw_stop_est(ndev);
-		return ret;
+	if (common->pf_p0_rx_ptype_rrobin) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "p0-rx-ptype-rrobin flag conflicts with taprio qdisc");
+		return -EINVAL;
+	}
+
+	if (port->qos.link_speed == SPEED_UNKNOWN)
+		return -ENOLINK;
+
+	if (taprio->cycle_time_extension) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "cycle time extension not supported");
+		return -EOPNOTSUPP;
 	}
 
+	est_new = devm_kzalloc(&ndev->dev,
+			       struct_size(est_new, taprio.entries, taprio->num_entries),
+			       GFP_KERNEL);
+	if (!est_new)
+		return -ENOMEM;
+
+	am65_cpsw_cp_taprio(taprio, &est_new->taprio);
+
+	am65_cpsw_est_update_state(ndev);
+
 	ret = am65_cpsw_est_check_scheds(ndev, est_new);
 	if (ret < 0)
-		return ret;
+		goto fail;
 
 	tact = am65_cpsw_timer_act(ndev, est_new);
 	if (tact == TACT_NEED_STOP) {
-		dev_err(&ndev->dev,
-			"Can't toggle estf timer, stop taprio first");
-		return -EINVAL;
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't toggle estf timer, stop taprio first");
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	if (tact == TACT_PROG)
@@ -476,62 +513,24 @@ static int am65_cpsw_configure_taprio(struct net_device *ndev,
 	am65_cpsw_est_set_sched_list(ndev, est_new);
 	am65_cpsw_port_est_assign_buf_num(ndev, est_new->buf);
 
-	am65_cpsw_est_set(ndev, est_new->taprio.cmd == TAPRIO_CMD_REPLACE);
+	am65_cpsw_est_set(ndev, 1);
 
 	if (tact == TACT_PROG) {
 		ret = am65_cpsw_timer_set(ndev, est_new);
 		if (ret) {
-			dev_err(&ndev->dev, "Failed to set cycle time");
-			return ret;
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to set cycle time");
+			goto fail;
 		}
 	}
 
-	return ret;
-}
-
-static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
-				struct tc_taprio_qopt_offload *to)
-{
-	int i;
-
-	*to = *from;
-	for (i = 0; i < from->num_entries; i++)
-		to->entries[i] = from->entries[i];
-}
-
-static int am65_cpsw_set_taprio(struct net_device *ndev, void *type_data)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-	struct tc_taprio_qopt_offload *taprio = type_data;
-	struct am65_cpsw_est *est_new;
-	int ret = 0;
-
-	if (taprio->cycle_time_extension) {
-		dev_err(&ndev->dev, "Failed to set cycle time extension");
-		return -EOPNOTSUPP;
-	}
-
-	est_new = devm_kzalloc(&ndev->dev,
-			       struct_size(est_new, taprio.entries, taprio->num_entries),
-			       GFP_KERNEL);
-	if (!est_new)
-		return -ENOMEM;
-
-	am65_cpsw_cp_taprio(taprio, &est_new->taprio);
-	ret = am65_cpsw_configure_taprio(ndev, est_new);
-	if (!ret) {
-		if (taprio->cmd == TAPRIO_CMD_REPLACE) {
-			devm_kfree(&ndev->dev, port->qos.est_admin);
+	devm_kfree(&ndev->dev, port->qos.est_admin);
+	port->qos.est_admin = est_new;
 
-			port->qos.est_admin = est_new;
-		} else {
-			devm_kfree(&ndev->dev, est_new);
-			am65_cpsw_purge_est(ndev);
-		}
-	} else {
-		devm_kfree(&ndev->dev, est_new);
-	}
+	return 0;
 
+fail:
+	devm_kfree(&ndev->dev, est_new);
 	return ret;
 }
 
@@ -558,34 +557,26 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	return;
 
 purge_est:
-	am65_cpsw_purge_est(ndev);
+	am65_cpsw_taprio_destroy(ndev);
 }
 
 static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
 {
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	struct tc_taprio_qopt_offload *taprio = type_data;
-	struct am65_cpsw_common *common = port->common;
-
-	if (taprio->cmd != TAPRIO_CMD_REPLACE &&
-	    taprio->cmd != TAPRIO_CMD_DESTROY)
-		return -EOPNOTSUPP;
-
-	if (!netif_running(ndev)) {
-		dev_err(&ndev->dev, "interface is down, link speed unknown\n");
-		return -ENETDOWN;
-	}
-
-	if (common->pf_p0_rx_ptype_rrobin) {
-		dev_err(&ndev->dev,
-			"p0-rx-ptype-rrobin flag conflicts with taprio qdisc\n");
-		return -EINVAL;
+	int err = 0;
+
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		err = am65_cpsw_taprio_replace(ndev, taprio);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		am65_cpsw_taprio_destroy(ndev);
+		break;
+	default:
+		err = -EOPNOTSUPP;
 	}
 
-	if (port->qos.link_speed == SPEED_UNKNOWN)
-		return -ENOLINK;
-
-	return am65_cpsw_set_taprio(ndev, type_data);
+	return err;
 }
 
 static int am65_cpsw_tc_query_caps(struct net_device *ndev, void *type_data)
-- 
2.34.1


