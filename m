Return-Path: <linux-kselftest+bounces-20536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE249AE298
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A25B282392
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B01CACDD;
	Thu, 24 Oct 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I8u0GvhH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892451C8FB5;
	Thu, 24 Oct 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765896; cv=none; b=Z+VCHvLuuxNnUKl7HrVmSmRIP4fdsI6/zByjYld5JFppJHVfk6UE87O+Vhyj+cxcBZ5FVE2vEQwQiXn1/ym+Aa44vRX5Ot+Y0s9e3tIMO+EILG7ZKRWtikTIfkZAtE7WE1N5EWbrcrK8/lqEHClfdszyH/p7QR9cz2e3q3hQUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765896; c=relaxed/simple;
	bh=Gmz9Xqx0ZtU8zOpInCLRKD7Z2S5uEH9cxuDripCqFqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c17WJKLiLAYyMhlBfFJvQkPyd8iTZX3zuGdmJXztZIqO5Fz8XUF4R7u4Iap9MOFYFDbpubWJBWrZWMcVN0D2bQW/FmJm3vVqvcfUOrSwt9pO4Jnj9hzTuBt9cCKEgZOwpeAraOUAWccVb/8XqYKnObpyBXSVny+nHkNjaiMK7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I8u0GvhH; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49OAV4Rn053993;
	Thu, 24 Oct 2024 05:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729765864;
	bh=n964dTNex7tpk0he9DOLYs/250I2jZHfL5mWxJ2ZSgM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=I8u0GvhH6hH46g0figOoGcDm9W0dv/yg0KhLFHzlmXVTlyP/gI07AE+mF8N7xe5+l
	 KiU1yTUjwZ01XXY1l5Xe2sP3DrINvImcKeNVpg7EBhJ5ZRXFI2Qc+sfdi1di6T0Qw3
	 UxQiaK6A5tOYS/VLR6Evx2JottONV+lLZwatA3iU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49OAV4Qc023029
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Oct 2024 05:31:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 05:31:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 05:31:03 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49OAV3PM081880;
	Thu, 24 Oct 2024 05:31:03 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49OAV2lp024601;
	Thu, 24 Oct 2024 05:31:03 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <dan.carpenter@linaro.org>,
        <jiri@resnulli.us>, <n.zhandarovich@fintech.ru>,
        <aleksander.lobakin@intel.com>, <lukma@denx.de>, <horms@kernel.org>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>
Subject: [PATCH net-next v2 3/4] net: ti: icssg-prueth: Add VLAN support for HSR mode
Date: Thu, 24 Oct 2024 16:00:55 +0530
Message-ID: <20241024103056.3201071-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024103056.3201071-1-danishanwar@ti.com>
References: <20241024103056.3201071-1-danishanwar@ti.com>
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


