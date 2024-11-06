Return-Path: <linux-kselftest+bounces-21517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E6E9BE236
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A421C2321C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A31DC19D;
	Wed,  6 Nov 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="frJ+21GN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678D183CD6;
	Wed,  6 Nov 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884673; cv=none; b=U+tSiZ1GUl92BQcC/TsmeTatMRBLJ3ZcDG4xNIMHSecLe1YxgvL5eL0ZN2k/b3Yq5lFDDSbp158b4pJyUI6ZaZTzb85YWp5L707bec3pv0aTTxHO0hItHke2Hw223lWmd0PSUB295PWGjpzf6MKIyc2LHEqFkndoR9r9QrraeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884673; c=relaxed/simple;
	bh=Gmz9Xqx0ZtU8zOpInCLRKD7Z2S5uEH9cxuDripCqFqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqyWfs1JMD+fTNqLNMC8Wml25oStIEEndwrB2S2ByunOJSpgLOhgA33gK3BoLIlxWPH0wbMhGiTrNkRvU+CvDlaTH05jwUUrJbH3LtdtM+hbwYv1NwLlX1z5j2olp2DYk1JrWyxMKfhbFwlciy/SKnC3pPwLdUB7IhOTcA1lRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=frJ+21GN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HJrv035698;
	Wed, 6 Nov 2024 03:17:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730884639;
	bh=n964dTNex7tpk0he9DOLYs/250I2jZHfL5mWxJ2ZSgM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=frJ+21GN4k9d2q19iuYPBNNffn09Ba96IWHnT8nysNNserrsjJA/UY8StYaWncFL1
	 0Hdryk1IW+j2A2RIGZzDbrIslByhg7wybbBOgx6JOEO3p8VDIMQOGvIX//B2CiMfN9
	 Jz09wtpmXWYr2TPh30TYmQfjDsGO6EKjSW63BkXk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A69HJEk116871
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 03:17:19 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 03:17:18 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 03:17:18 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HInB081268;
	Wed, 6 Nov 2024 03:17:18 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A69HI80020792;
	Wed, 6 Nov 2024 03:17:18 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <jiri@resnulli.us>,
        <w-kwok2@ti.com>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 3/4] net: ti: icssg-prueth: Add VLAN support for HSR mode
Date: Wed, 6 Nov 2024 14:47:09 +0530
Message-ID: <20241106091710.3308519-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106091710.3308519-1-danishanwar@ti.com>
References: <20241106091710.3308519-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

Add support for VLAN addition/deletion in HSR mode.
In HSR mode, even if the host port is not a member of
the VLAN domain, the slave ports should simply forward the
frames. So allow forwarding of all VLAN frames in HSR mode.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 +++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 0556910938fa..b4d70c6e0cff 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -808,6 +808,47 @@ static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
 	return features;
 }
 
+static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int untag_mask = 0;
+	int port_mask;
+
+	if (prueth->is_hsr_offload_mode) {
+		port_mask = BIT(PRUETH_PORT_HOST) | BIT(emac->port_id);
+		untag_mask = 0;
+
+		netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
+			   vid, port_mask, untag_mask);
+
+		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
+		icssg_set_pvid(emac->prueth, vid, emac->port_id);
+	}
+	return 0;
+}
+
+static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int untag_mask = 0;
+	int port_mask;
+
+	if (prueth->is_hsr_offload_mode) {
+		port_mask = BIT(PRUETH_PORT_HOST);
+		untag_mask = 0;
+
+		netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
+			   vid, port_mask, untag_mask);
+
+		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
+	}
+	return 0;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -820,6 +861,8 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_get_stats64 = icssg_ndo_get_stats64,
 	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
 	.ndo_fix_features = emac_ndo_fix_features,
+	.ndo_vlan_rx_add_vid = emac_ndo_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -947,7 +990,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->netdev_ops = &emac_netdev_ops;
 	ndev->ethtool_ops = &icssg_ethtool_ops;
 	ndev->hw_features = NETIF_F_SG;
-	ndev->features = ndev->hw_features;
+	ndev->features = ndev->hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
 	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
-- 
2.34.1


